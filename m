Return-Path: <netdev+bounces-184452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0334A9595C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A94163940
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B9224AFB;
	Mon, 21 Apr 2025 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXQOxYpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9B2248B8
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274516; cv=none; b=Alb5vWHaJ+o81BdaModx4MftFuwJkdt4zkcM8xSbGJLULIIyPptatdF65g6ACSwFMeYOVJpej1EKmnW9TxuyuSphsRJPz+I8iKoNI8FB4+y+haelYNjM8R3/TIlNiK8d3keEPI66OvW3chSCcTokxQzNz1AR/si8t1wP7j7ZwTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274516; c=relaxed/simple;
	bh=V4UrmJ2JosPk/8dtqsfWv9rCmJv5YmfOyfdKP2QvMVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFyhIwlIZYdWSl+8JfC/dhc1kZW6NruBYKpHHeQNcuqxh7xBv8DRB4vBvAik2v5pody/82d6pB1Gl3A7c2G+auKW4ejEjmPlUctNPbsgDuE3TXCDPdd0pXRHrPGpElXNQQua4DzYiV6QrIRvoNATmhi1vv5KOqcKOxaNtcA/ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXQOxYpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B07C4CEEC;
	Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274516;
	bh=V4UrmJ2JosPk/8dtqsfWv9rCmJv5YmfOyfdKP2QvMVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXQOxYpUBA4IMZTs1gyz1D4h8xKE8m2/zie0N1bENqlnbKYphBSd0hR9eGFQdJDJj
	 3gk/7s2vDV1sn5TyFNzgRnc1Jp5/IcWwmAbO9begat4WVKSMrAtRB630YQJeW4GwgO
	 a5Y2IAuUd8aRNiuaoD2bOeGdYYysGti9aYDoo3dnYoI2k7YExRh5eM1Mzm4hKUiW0I
	 CGDIikFWB8wpblSnIU1Txp/JxAhNZirYcLmrYn+iKZueutfKslXNRUR0CKrUJ2Nz9K
	 Xsg1EkQKz447f/uEEj1OASyRqyI7kbGt5HEJHAHsug4lfqk+KhErbXXIDFADrjzySF
	 wcMsy539/QkxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 03/22] net: use zero value to restore rx_buf_len to default
Date: Mon, 21 Apr 2025 15:28:08 -0700
Message-ID: <20250421222827.283737-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Distinguish between rx_buf_len being driver default vs user config.
Use 0 as a special value meaning "unset" or "restore driver default".
This will be necessary later on to configure it per-queue, but
the ability to restore defaults may be useful in itself.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/ethtool-netlink.rst              | 2 +-
 include/linux/ethtool.h                                   | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 +++
 net/ethtool/rings.c                                       | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b7a99dfdffa9..723f8e1a33a7 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -974,7 +974,7 @@ threshold value, header and data will be split.
 ``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks driver
 uses to receive packets. If the device uses different memory polls for headers
 and payload this setting may control the size of the header buffers but must
-control the size of the payload buffers.
+control the size of the payload buffers. Setting to 0 restores driver default.
 
 CHANNELS_GET
 ============
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1f61f03f354e..84cfa7f4fce0 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -72,6 +72,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ *		Setting to 0 means reset to driver default.
  * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 2466fe04b642..c294ddb2055f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -396,6 +396,9 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
 		return -EINVAL;
 
+	if (!rx_buf_len)
+		rx_buf_len = OTX2_DEFAULT_RBUF_LEN;
+
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 5e872ceab5dd..628546a1827b 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -139,7 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_MINI]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_RX_JUMBO]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TX]			= { .type = NLA_U32 },
-	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT]	=
 		NLA_POLICY_MAX(NLA_U8, ETHTOOL_TCP_DATA_SPLIT_ENABLED),
 	[ETHTOOL_A_RINGS_CQE_SIZE]		= NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.49.0


