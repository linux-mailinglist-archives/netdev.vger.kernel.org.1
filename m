Return-Path: <netdev+bounces-250622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76994D38619
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABAC31A8F11
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44913A1CFC;
	Fri, 16 Jan 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K2R1lkKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C734A76D
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592307; cv=none; b=fVFTppbUCjvTRkmL2s/ymgdjzF2S0znDbTqkabE0DXqM0C1LCZn+Xqbasx27GRb6BF/6mZz9uGtPijvu0Z/R3jJa8y+j/coKk9WML1Qez4J34V0t9ZLkIGazZj0cQbbAqxUCVyHP46kwoJNKDo6qPqfl4mReSascNfS2HJl9vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592307; c=relaxed/simple;
	bh=Lds7sMXzJrLrd0gBwEEuZ07H+OYaihFRhMfpOkt8Sd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKTbOnNkudrRFgGsqeEzzUEqhX0ZpGuISPTCtD44Fo8AXyRalwU3YnaT02cL20aARJMuG/4bcCn6h2bRe/v1mz19ohR9CkQ7DE5gU3RNSqeCDDLns22N7qbdVB3k8eZyfGWeF2k1svoU9AORnpuOvytv2FjLrIucZrnZrgUNj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K2R1lkKJ; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6446fcddf2fso2227974d50.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768592303; x=1769197103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dWnjTr3AjoXWLMl2brB8ngehg3o0HcGu3374LRPyGE=;
        b=qCv2eJQ/svS7ZxNYwrTcKCTVMi2adk/woFnfKz6/AdNYlsElD6xbQOwzuA+D5b8C+A
         TvRfnVmIT9XqzkphhIqvUUuXB4K/gdPEGk+hJm6ozjPiO5peZ/Vz7pjLpr/9OUB9URVO
         JK3Mesnm7O1hsedIbuoJFnGqPqbXl2NFYZBblS6qptKOIhGplhk6eIXmkGVKfYKgw6EL
         il+d5hczCQzgGMSz7hkTm4Dm/jAymUGChnnPJTIl9T0GxL78jL/k5bgIk1aizWk6Rraa
         cTmSykf62Phmik0zC64ZcZKT1bK2vmnVGrEj4pkR5fJtLd3RkkC+TMieK4Y2ESdqk7O4
         llqw==
X-Gm-Message-State: AOJu0YxS9yE/LXMI17ImO0ftNvFok3FqsChTbTLFtllTDCjTsgNUQxcA
	l/3/V1EvmOap5QRkxVOZhBDVVzteCHpc4fh0xwouNU4pXG3fuFHJ+fjCNzX0PPXZBqjO0IQ8qpv
	qMWBJfq8ivNoBJ6dVIBDBI4OHZqdJjtajgL0jgoeIP2HIr/8oz2VSbGVQ7wYc0q/fOlkI98Fqdt
	WHVmk56Hfs/emshaAoImZ3xYR1B7DFb7f5dhaktw2pKDxQvTHHzrqWD4/n/U64cVS+/q+Z/rTQy
	PWxGkmlthTFWrbFsA==
X-Gm-Gg: AY/fxX6LJOC+wRNaOjYLpQR5kL+vgO4irG9V3scgYpD3wqyF4J/ejEkm5umu2+phevM
	NNamqU4+0RTYWCOE0Jn53CRPZNU7Qg8KdKdOBLwtngZpnOJSQD8A0rPIofEp+3KjLvrQPM3LRzU
	vUavBD6SZYnJcz9PM3fEAjIynKrLi/UxPiG1A/5CjOx/4ffXjrc0VPQxU5MOLWJ6rAL+Gt3Jkez
	2p0cBHD9hfJQeUGw/GdQJyPWNQnYq+Zvng5MYFIn2WFYwnPLmLwlrCvOPWO+0t3pAZI3fZgs+Sy
	tXPG46Baoz9cmoVWCt54T7SPO3BovUqgfCYmEVZz3SPq4NuBW92p6yA79wAtYHDAMjSIZ4rNrLS
	bvrkQ4GJNJdHtwffW27KUpOWpzb3vQYQPCcx5OdEPB5dKwEctHsIEnQ0u2wp4AX5ymEntq57812
	ZTamG+EX2YQJwWyNI5ufaryyDlS29RL99DREW7TlkClXQxmINb
X-Received: by 2002:a05:690e:4086:b0:63f:9d1e:eb83 with SMTP id 956f58d0204a3-6491649ee1emr3214817d50.30.1768592302983;
        Fri, 16 Jan 2026 11:38:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-793c6882eedsm2104847b3.28.2026.01.16.11.38.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:38:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c5d203988so3841155a91.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768592302; x=1769197102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dWnjTr3AjoXWLMl2brB8ngehg3o0HcGu3374LRPyGE=;
        b=K2R1lkKJa0McK6CL+LhmhlnysA+O8YjMyUDRJKjhtHmRUb4qlN6vGuE9biNvB7eQ/c
         4GXkui3CnZOtPMRMXCmAAkZYNw7erggX5ikobgVQwIL+nZPWbhj9B/xvKH2yHL9+gSDD
         WwhBwkjd1g1x1DDj1IOB2w4PcHseRLJRjz01c=
X-Received: by 2002:a17:90b:5485:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-35272faec68mr3198760a91.25.1768592301735;
        Fri, 16 Jan 2026 11:38:21 -0800 (PST)
X-Received: by 2002:a17:90b:5485:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-35272faec68mr3198753a91.25.1768592301391;
        Fri, 16 Jan 2026 11:38:21 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm2764909a91.15.2026.01.16.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:38:20 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>
Subject: [v5, net-next 5/8] bng_en: Add ndo_features_check support
Date: Sat, 17 Jan 2026 01:07:29 +0530
Message-ID: <20260116193732.157898-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Implement ndo_features_check to validate hardware constraints per-packet:
- Disable SG if nr_frags exceeds hardware limit.
- Disable GSO if packet/fragment length exceeds supported maximum.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 23 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 2c1df5d48b5e..2c8f8949d500 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2420,6 +2420,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_features_check	= bnge_features_check,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 9e069faf2a58..dffb8c17babe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -960,3 +960,26 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
+
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features)
+{
+	u32 len;
+
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
+		features &= ~NETIF_F_SG;
+#endif
+
+	if (skb_is_gso(skb))
+		len = bnge_get_gso_hdr_len(skb) + skb_shinfo(skb)->gso_size;
+	else
+		len = skb->len;
+
+	len >>= 9;
+	if (unlikely(len >= ARRAY_SIZE(bnge_lhint_arr)))
+		features &= ~NETIF_F_GSO_MASK;
+
+	return vlan_features_check(skb, features);
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index 81a24d8f9689..32be5eb46870 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -119,4 +119,7 @@ irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
+netdev_features_t bnge_features_check(struct sk_buff *skb,
+				      struct net_device *dev,
+				      netdev_features_t features);
 #endif /* _BNGE_TXRX_H_ */
-- 
2.47.3


