Return-Path: <netdev+bounces-227466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8ABB014D
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F29B1941DE5
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B72C2343;
	Wed,  1 Oct 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8L9CGvB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486B284681
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316602; cv=none; b=J75vfng3r8EsQY+0JTyMuO/M4fUVBkUsn90A93Bx/dEMAf23HgSPrlqGSHO60tBFkR2OyiuJJ0SH+c/RB5EUXEG9At8S7G/yKwP8hYph5qtAe7EytbT5327ykpnjANjpts01uliUyP6owPhRhJHIlneq8J2XMFBVJlKdbAo0a1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316602; c=relaxed/simple;
	bh=ayH6eU74HGK2Uw8pBU8RG4fsbY2PSfyyn49rkqPJ7Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plA6v2131nXJSDK5bS5B7EYLrrkFelgty+Lu6BaGowxyu5yKDkUBhwHGHgnBWAyxi+pBn3cU89sAuf+MZxgJkm6fw5Tg0vhMW9TSCpAxORL1yM562lovWZuz9qZ1nTdToj/L+3EZ12RSlQXtDcfkTRQ5BwHR24Bof/No7XM8HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8L9CGvB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so7228801a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759316601; x=1759921401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9V28geYs6+fybVTeARjUscAK9N0tpW7+cMdGRd5q3Us=;
        b=e8L9CGvB0rCx0sshlkGmL7R9LEouH1QywFa9lzsQmJ1JhgE0OEiKeAbkEETjya5z+p
         MTWA9bH/Ole6l3gKOk137zJnrOK+p/Wwk7HnC+EDM7GGpv+HJyl5NEAEflofoQVrdNFY
         nG2jNc990tXilfTQXZmk6crLKTVa/d8R1oW+lXe2qR6ST9CDflY87v7qTvoYsv1hIAKn
         CHTRHtgQyrdLLnyhag8lO+8GP1MyBYoVAsn3udd3T/FNXKEceUXLxF7faKjbaQMo+43c
         oLHBFtpAo6IRrtZpQiCAPoQ8KCo47y0xKUr/EZAdf2CzmONrp6L13hu+6DzYsYNL8wFW
         sF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759316601; x=1759921401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V28geYs6+fybVTeARjUscAK9N0tpW7+cMdGRd5q3Us=;
        b=WsRhf7KypKz9UOLSfwGKUWeMveCv8Hi1zi6qJg5sIf73lyS3ELI/aYl06Yq9wxylqA
         5+EMHuCDjNGXJy8SYym49G6qwRV59UHze7f14RbpTsmm0ggFO38pB+wCu9ltsVIZE7+R
         XUhohN94wBIfywuqFs/JohLswMvtvBgfLNY7B6wbPPwiOp945Qktyi5kpuiUmDhcDGFv
         yyoCCxLTx1SQGfKPgAvs2G3LkOXx+IS8OjccCAhgoOT03lih5GxltZtmh3APcCEinNwm
         wC0Ze6C2PaM582PsCSvZIi97KIPhS8FHFUTj7ezEDKnExxNTgfB0H3wtbnJ/6EaiXiyR
         D0CQ==
X-Gm-Message-State: AOJu0YzYFp0srWMMthVUaiRYmTpXDaFFCkGqRA8A7GTDce27oSKarirC
	3aHlpJh0UBX58fAhW4WpB0tTXvexkyIdkSZRGbScv3D6NWXKqaDOBG9e
X-Gm-Gg: ASbGncuaGoC3aTJOMTkUREb0iozRVXCjzdgEqWOwkkBsVRwD3UgLHdpA/1zzPVepyDL
	R17EvImxSzkMBRgbWtMvPcnktA+5KkjDN4VsNHz8njDbWq0F7D/mTcsO9OtPV+Me95LAQp07+30
	M9dTGfxs1fx9ApYNceLlFTgx5LszxiYa5f5MhRJxjKIGyq1UQMckWMqCAuz7HxrovFuDD8yhC9I
	gpY8lfXHyrI5XNeRYMoqOcOWTvNPjYmaJRKWe+qOOfIP56AUKPBxJ4wqWx9aiICRRSqM0toLCXs
	Cp0FuoZXrD0haEoKWLhpByp0+G+WpdiMhV+BaWSnNbszozc5VrBwy+RLDoH5bQIRs3zKOmPfPWP
	MwF3NjxIBF+M1cj12kjjJsE10bn5WI2DZF9JDinQTErYsS/KUzevE8OFyiRCKUiNOBcjEZo31FA
	==
X-Google-Smtp-Source: AGHT+IF6egVDTn5Ywg4HO8cRrcaXb7fIR+VPczMNX7N1WKOEThRzIZRtsgAxQPHJcsd40gZ+gXw7rQ==
X-Received: by 2002:a17:90b:314e:b0:335:228c:6f1f with SMTP id 98e67ed59e1d1-339a6e95d23mr3939304a91.12.1759316600367;
        Wed, 01 Oct 2025 04:03:20 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6f15fbfsm2073476a91.21.2025.10.01.04.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:03:19 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	bhanuseshukumar@gmail.com
Subject: [PATCH v2] net: doc: Fix typos in docs
Date: Wed,  1 Oct 2025 16:27:15 +0530
Message-Id: <20251001105715.50462-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in doc comments.

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No functionality change intended.

 Change log:
 v1->v2 changes:
  fixed pertaing to pertaining.
  Link to v1: https://lore.kernel.org/all/20251001064102.42296-1-bhanuseshukumar@gmail.com/
 
 include/linux/phy.h | 4 ++--
 net/tipc/crypto.c   | 2 +-
 net/tipc/topsrv.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index bb45787d8684..de786fc2169b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -292,7 +292,7 @@ static inline const char *phy_modes(phy_interface_t interface)
  *
  * Description: maps RGMII supported link speeds into the clock rates.
  * This can also be used for MII, GMII, and RMII interface modes as the
- * clock rates are indentical, but the caller must be aware that errors
+ * clock rates are identical, but the caller must be aware that errors
  * for unsupported clock rates will not be signalled.
  *
  * Returns: clock rate or negative errno
@@ -514,7 +514,7 @@ enum phy_state {
  * struct phy_c45_device_ids - 802.3-c45 Device Identifiers
  * @devices_in_package: IEEE 802.3 devices in package register value.
  * @mmds_present: bit vector of MMDs present.
- * @device_ids: The device identifer for each present device.
+ * @device_ids: The device identifier for each present device.
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index ea5bb131ebd0..751904f10aab 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1797,7 +1797,7 @@ int tipc_crypto_xmit(struct net *net, struct sk_buff **skb,
  * @b: bearer where the message has been received
  *
  * If the decryption is successful, the decrypted skb is returned directly or
- * as the callback, the encryption header and auth tag will be trimed out
+ * as the callback, the encryption header and auth tag will be trimmed out
  * before forwarding to tipc_rcv() via the tipc_crypto_rcv_complete().
  * Otherwise, the skb will be freed!
  * Note: RX key(s) can be re-aligned, or in case of no key suitable, TX
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index ffe577bf6b51..aad7f96b6009 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -57,7 +57,7 @@
  * @conn_idr: identifier set of connection
  * @idr_lock: protect the connection identifier set
  * @idr_in_use: amount of allocated identifier entry
- * @net: network namspace instance
+ * @net: network namespace instance
  * @awork: accept work item
  * @rcv_wq: receive workqueue
  * @send_wq: send workqueue
@@ -83,7 +83,7 @@ struct tipc_topsrv {
  * @sock: socket handler associated with connection
  * @flags: indicates connection state
  * @server: pointer to connected server
- * @sub_list: lsit to all pertaing subscriptions
+ * @sub_list: list to all pertaining subscriptions
  * @sub_lock: lock protecting the subscription list
  * @rwork: receive work item
  * @outqueue: pointer to first outbound message in queue
-- 
2.34.1


