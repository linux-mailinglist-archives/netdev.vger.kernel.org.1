Return-Path: <netdev+bounces-222709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20640B5577F
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4595679F0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD130AD13;
	Fri, 12 Sep 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSERWCSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EAE2FE58F
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708081; cv=none; b=n4qqlk31qKtiNx7BcpznjpnTtbCwdefF37kspmaeWTAyGODvyHCbASE1h3Vt56HI2R8/KMWBlBeQgALwJXyhKluu8w8R0ZDc5626pTxDNvOLtNycBNh8sHgAFu6qKQxqIKKesvIVVPziV1JrMB8d7EILQb0dA9xOe8rAL3uDlyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708081; c=relaxed/simple;
	bh=opK9aPGAXVHhckSh6izsT60dPkYbx2MWfkJAbOvr+/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSccby/l/q7XNzX+XF5jms69eVRt7kZ9vMH+ocyTsNFuGnOsyWOthxipcIB4cFMbPFVaAbUqsKmAfn9BfWBnGc23gSpiw64S0rhPAuqLGr58kNAc3pjOtc8MPTFqUgcUwYDNiVfZ2ffMs4P3Q+6cyeCTzcBecFytprwGqYy0o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSERWCSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D01C4CEF1;
	Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708081;
	bh=opK9aPGAXVHhckSh6izsT60dPkYbx2MWfkJAbOvr+/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSERWCSI+KpVZA8jZ8t04wCWgzpRCY8iWBOVYRWFc0dwLcMxfkA1WIhsiNPpEckX2
	 RPZypne5LHxmf/uEuR/Kgs+xtKNYfa9X6HhZe+yCstaU+LPK5ROVlXP4RxCJEz/aWL
	 pJXfI0/oBTapNi5BjkyU7RXK7SdPo+sVShK6NVCk26Pq97rn74Kzv4S1aRK0tDvNPG
	 PBobRKGiWhLckpywRP62/yKLnNGmB7FrhazEG6tniKcYpIDQ/ulwuoDSihZhfuo3Pl
	 XW0NlvbtG3luHhR1PgBoyAndpXPDeZbcAykAOG8ttC4BpwQatVcXkrpM9jJyPKbK4z
	 qXT68w0LwwX0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/9] eth: fbnic: support allocating FW completions with extra space
Date: Fri, 12 Sep 2025 13:14:24 -0700
Message-ID: <20250912201428.566190-6-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912201428.566190-1-kuba@kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support allocating extra space after the FW completion.
This makes it easy to pass extra variable size buffer space
to FW response handlers without worrying about synchronization
(completion itself is already refcounted).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index c1de2793fa3d..6a413e7296da 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -100,6 +100,8 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
 			    bool send_log_history);
 int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd);
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size);
 struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type);
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *cmpl_data);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 72f750eea055..1a92e4be010e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -1542,11 +1542,12 @@ void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
 				 fw_version, str_sz);
 }
 
-struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+struct fbnic_fw_completion *__fbnic_fw_alloc_cmpl(u32 msg_type,
+						  size_t priv_size)
 {
 	struct fbnic_fw_completion *cmpl;
 
-	cmpl = kzalloc(sizeof(*cmpl), GFP_KERNEL);
+	cmpl = kzalloc(sizeof(*cmpl) + priv_size, GFP_KERNEL);
 	if (!cmpl)
 		return NULL;
 
@@ -1557,6 +1558,11 @@ struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
 	return cmpl;
 }
 
+struct fbnic_fw_completion *fbnic_fw_alloc_cmpl(u32 msg_type)
+{
+	return __fbnic_fw_alloc_cmpl(msg_type, 0);
+}
+
 void fbnic_fw_put_cmpl(struct fbnic_fw_completion *fw_cmpl)
 {
 	kref_put(&fw_cmpl->ref_count, fbnic_fw_release_cmpl_data);
-- 
2.51.0


