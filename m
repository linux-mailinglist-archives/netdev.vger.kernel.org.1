Return-Path: <netdev+bounces-205551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CFCAFF367
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE334189D2E7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010823AE62;
	Wed,  9 Jul 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv7tv3T4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2041A3179
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094753; cv=none; b=CLScevxI7vKN31Ha7LfzcPrun0Eoegi84oYDrFbkH1kfL8VjTot/yR6xT1by4JCjnRkjf6pL7RYZ19t23SjL1sabBHws05QExF7yxpovte7/0HQNeBemQ2gXg6QxN2Fuy3ynj9egxY4iGry/pc5SCUUGJF/ELqZJ11LiJ32utls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094753; c=relaxed/simple;
	bh=+16ufpkURu7uYjrIPcNtlF7ruHVM1/lL099Xu1ti9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0S71/GHGef3fFal6scAt5QVvRMM5TOlB0C2swf0DE7e242Qqf2tYC1MgRR7PvTkyppZl55/UQcLAwS6Dz/+RBWjNES2ujEZqcTLcuwDSwy25r8i3Kp+Q52UtrgfTqvbXM/aajIgXAgzJa2RIBnl9jfbqBdvcMlEBgkILGVTZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv7tv3T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BEBC4CEEF;
	Wed,  9 Jul 2025 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094753;
	bh=+16ufpkURu7uYjrIPcNtlF7ruHVM1/lL099Xu1ti9SI=;
	h=From:To:Cc:Subject:Date:From;
	b=sv7tv3T4r2ohCfutnqZ/wPvLxHN3a6ZS+zjc57VO8f2qYJmKuB5Kf1wfaSyebzrFN
	 nnEteGa9eSvjkJWziLhsgAvw0izOg4T5K2RkicbST7s8e25BOG5wVhpHNirO+rAZxL
	 16N3KuJQjlAXoUyUsp5sP/T8xIw1nFJkMyJJ1H33hwRUILXHlVuOwkYUh88j36ggY8
	 8iDnJLg6eX4mcU3qNqCiBVu2jqDktReKhHl7O81Z3VCWegFxC05QLQ7+dgQvDj8Rd5
	 PPEWebx9yYeARFf/iD5eHa/NahwUnRNtUyUN3Vmr0ZP++0S7ObAZi0TGSCp9DTyTkL
	 JfKB0zR16pXyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	jacob.e.keller@intel.com,
	lee@trager.us
Subject: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB accesses
Date: Wed,  9 Jul 2025 13:59:10 -0700
Message-ID: <20250709205910.3107691-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBSAN complains that we reach beyond the end of the log entry:

   UBSAN: array-index-out-of-bounds in drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c:94:50
   index 71 is out of range for type 'char [*]'
   Call Trace:
    <TASK>
    ubsan_epilogue+0x5/0x2b
    fbnic_fw_log_write+0x120/0x960
    fbnic_fw_parse_logs+0x161/0x210

We're just taking the address of the character after the array,
so this really seems like something that should be legal.
But whatever, easy enough to silence by doing direct pointer math.

Fixes: c2b93d6beca8 ("eth: fbnic: Create ring buffer for firmware logs")
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: jacob.e.keller@intel.com
CC: lee@trager.us
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index 38749d47cee6..c1663f042245 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -91,16 +91,16 @@ int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
 		entry = log->data_start;
 	} else {
 		head = list_first_entry(&log->entries, typeof(*head), list);
-		entry = (struct fbnic_fw_log_entry *)&head->msg[head->len + 1];
-		entry = PTR_ALIGN(entry, 8);
+		entry_end = head->msg + head->len + 1;
+		entry = PTR_ALIGN(entry_end, 8);
 	}
 
-	entry_end = &entry->msg[msg_len + 1];
+	entry_end = entry->msg + msg_len + 1;
 
 	/* We've reached the end of the buffer, wrap around */
 	if (entry_end > log->data_end) {
 		entry = log->data_start;
-		entry_end = &entry->msg[msg_len + 1];
+		entry_end = entry->msg + msg_len + 1;
 	}
 
 	/* Make room for entry by removing from tail. */
-- 
2.50.0


