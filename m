Return-Path: <netdev+bounces-223159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE88B58147
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796DD1894770
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C1223DFB;
	Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npteR7kv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E61514F7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951596; cv=none; b=iGjLHW7oeZEsvlErLXg1X+M6Zk70GkGTr6HhVW9mJjzyNbNk1i2qxXjpyGJOaxjvEXlveki3ov3/8taDEy/l3IvZqsobSad6vMOg9AQVC6M4Yhf7c7AGz0oRjUZIEhYP41ryiDbTgQbVv+4Xhl1iedLC5BdccOhnp7GfntZ+1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951596; c=relaxed/simple;
	bh=YMBxYZgHQyV7fMLr6O3z+nEi94eIBXTPTT+WDjmynOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pce5o4f0myLH9Je34ZMsDs+O32JvnHve8wMYPrd61jQqC9DMgYvjCbwFk80YIdNBKTO4is4AJZjsxIA7rgVTCzJITXRxpRn8QdUw3bVmEwb0dABOgIJJheYkhgpvQim2zU7fL/d/TLodZGhHgyzZMgicjAjV6Du/57qX0YuIV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npteR7kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51934C4CEFB;
	Mon, 15 Sep 2025 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951595;
	bh=YMBxYZgHQyV7fMLr6O3z+nEi94eIBXTPTT+WDjmynOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npteR7kvbvqV+9swF2L5tWJtCH5i4D5sPcLeqzPDszYgvaH+l/lfrXSQYZ46JfCpa
	 f68QvkUVmHG6JWCgkvaaC0qrt6zlPDPPgGQjen4caaRlm4OO6nb4Ln+jDg0jjE0die
	 ahUE/ofx7kFRZP00FMWd7JVBkreHSbJGrclOUmWTKTjDJVgzJchKzqWiA5n2LFLv7U
	 wyUybTn/ZB3z5Buv7sx3jxk6xrr64CiibZkmqMJr9O4NkugMcbLSE/T5QNzAVyPJp7
	 rE3tV+vR4TBHsvasoAAcvWmPxDbRKreVgD61qhmmMHXalkMMrfg2wqHwdvH0ATCNX/
	 dTAmLVMtYNP/w==
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
Subject: [PATCH net-next v2 1/9] eth: fbnic: make fbnic_fw_log_write() parameter const
Date: Mon, 15 Sep 2025 08:53:04 -0700
Message-ID: <20250915155312.1083292-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the log message parameter const, it's not modified
and this lets us pass in strings which are const for the caller.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
index cb6555f40a24..50ec79003108 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.h
@@ -41,5 +41,5 @@ void fbnic_fw_log_disable(struct fbnic_dev *fbd);
 int fbnic_fw_log_init(struct fbnic_dev *fbd);
 void fbnic_fw_log_free(struct fbnic_dev *fbd);
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
-		       char *msg);
+		       const char *msg);
 #endif /* _FBNIC_FW_LOG_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
index c1663f042245..85a883dba385 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c
@@ -72,7 +72,7 @@ void fbnic_fw_log_free(struct fbnic_dev *fbd)
 }
 
 int fbnic_fw_log_write(struct fbnic_dev *fbd, u64 index, u32 timestamp,
-		       char *msg)
+		       const char *msg)
 {
 	struct fbnic_fw_log_entry *entry, *head, *tail, *next;
 	struct fbnic_fw_log *log = &fbd->fw_log;
-- 
2.51.0


