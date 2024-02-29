Return-Path: <netdev+bounces-76106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E886C590
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06191C23C7A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9860DCC;
	Thu, 29 Feb 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyr+hmj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71706089B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199557; cv=none; b=PPS3j4rq0vxM+wPsSOh1ZipvtHcQxmKFs4Jp9wKYE8TGePE2UkUeF81o9sSfUCV4gDPYsR9zN4ByRcFRW8DZib64XIeobp+Sx98ouVaChNZUPL7BZgEiursLCI9pAflKZkQ2A4O46DvqiCba3TQPiuyi6wmB0ZhwpZ7ANMOf1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199557; c=relaxed/simple;
	bh=XoLfAXR/XTwklD20U+BF4OtrQwcVKLr44uKuld4g5EA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUMNC3tNyWtVY23brSJZI7AtqM038RcY9uIBJTQhj/h/uooEJ6YT7rJLkDzqAeXnEMbYCAKRFOLmB5buCdFlLtQEKGCvak+Uaqcjl93vpeSMVQS12hk9t2aknsRDkLvAb8G3ZLTll8Hg/qUHTaZZSIsW1Z22jjvJ+Ew9cb0KWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyr+hmj/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6097409275bso3525397b3.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709199554; x=1709804354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxWGVjZRFei4HN2R5UXJm7W3hCtQ1QGEyVBBCdMghTg=;
        b=gyr+hmj/3wliT36MeEw8pQEr51CyLJcKp1tZ273L7yh5Rur/sciwwPLlvnAdlLpqPV
         /kGsbnNzvuPqJ06Llh2CsPwlu31tNGfU8xQ3FNJqso/8n7aUQCE9Ph3mJIGJBzpQDTui
         +odh6r8prEUhkNaJAzYFugJNNjpzkIHfW+eHjxi4mEC05hyXuykELaBlWJ1LIiRf2fzq
         sZyDHeOdfwCEyyeL+gvbj6X23/wFMBX2ei/+0VC+spujKjg8Ls9BuxfEGXcgWkClTx/E
         BW8pzASsJMls9Y9byxGM6nd21GbcLZwwNS5dFiUPrfU7TUc3Fod5eYkmfQfEqMOQnKOp
         RgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199554; x=1709804354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxWGVjZRFei4HN2R5UXJm7W3hCtQ1QGEyVBBCdMghTg=;
        b=G3KDDuFDoy8kyzNCErG9HSymSm8Mjpgqde+v77Mc3w6MbNdkKKc84uiJ6ZUhmGs9bB
         Gkg98DZMWV9gHJ31Qc/OCC5HJynqSEoPMrNLxY3KmYvKj3JBoNCE6JjlwC+aUF9y0HGw
         8OT6EFbvWiL8qhsjwO7yHYzMUoL7+t9nB/P7msw/Qn+TSTO+Bkw5Kq5z1p7EoAoDsT8Q
         QqfWiDgJ4hb2b6HajDlldyf4N5UF+wNg5X+8wauyX0fgwjv2XJt9I15Xa+77l5bw6FMA
         k5qAnXw2Bt97YHhrHcUCdD1vL/uSUEG5U1dz3fK06/lmRRtRxh3Q70TMscDWwR8KE5ri
         NkIQ==
X-Gm-Message-State: AOJu0Yw8j8gN3JwhkwI8oy/bGN6GNI1S5dpay+PCei1qr/TALaGHEWN5
	h/NhCFoKgdr6LkGFpw8PEZejpSUekAxnp+vT0Jps46DIStuKKB2Qi85+TQbjxOU2vE/yUj+M85m
	4IO6NyywrWQ==
X-Google-Smtp-Source: AGHT+IE+qN0K1mNJaJu/S3r3llLgR8PbYzQNfbeQCLo7RqH+OofuXEjc44wAG3UTIbWib47u1DYdim0qGlU8Lg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b220:0:b0:dc7:6f13:61d9 with SMTP id
 i32-20020a25b220000000b00dc76f1361d9mr62394ybj.4.1709199553867; Thu, 29 Feb
 2024 01:39:13 -0800 (PST)
Date: Thu, 29 Feb 2024 09:39:07 +0000
In-Reply-To: <20240229093908.2534595-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229093908.2534595-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229093908.2534595-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: adopt skb_network_offset() and similar helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a cleanup patch, making code a bit more concise.

1) Use skb_network_offset(skb) in place of
       (skb_network_header(skb) - skb->data)

2) Use -skb_network_offset(skb) in place of
       (skb->data - skb_network_header(skb))

3) Use skb_transport_offset(skb) in place of
       (skb_transport_header(skb) - skb->data)

4) Use skb_inner_transport_offset(skb) in place of
       (skb_inner_transport_header(skb) - skb->data)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 11 +++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c       |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c         |  2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c         |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c         |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c        |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c    |  3 +--
 drivers/net/ethernet/sfc/siena/tx_common.c        |  5 ++---
 drivers/net/ethernet/sfc/tx_common.c              |  5 ++---
 drivers/net/ethernet/sfc/tx_tso.c                 |  4 ++--
 drivers/net/ethernet/sun/sunvnet_common.c         |  4 ++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.c       |  2 +-
 drivers/net/wireguard/receive.c                   |  2 +-
 kernel/bpf/cgroup.c                               |  2 +-
 net/ipv4/raw.c                                    |  2 +-
 net/ipv4/xfrm4_input.c                            |  2 +-
 net/ipv6/exthdrs.c                                |  4 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c           |  4 ++--
 net/ipv6/reassembly.c                             |  4 ++--
 net/ipv6/xfrm6_input.c                            |  2 +-
 24 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 528441b28c4efe73eae5aa366c66b5ef8cc35ef2..adcee8d9d6d9ad23397cf939abab1577c8929df1 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3538,7 +3538,7 @@ static u8 bnx2x_set_pbd_csum_enc(struct bnx2x *bp, struct sk_buff *skb,
 				 u32 *parsing_data, u32 xmit_type)
 {
 	*parsing_data |=
-		((((u8 *)skb_inner_transport_header(skb) - skb->data) >> 1) <<
+		((skb_inner_transport_offset(skb) >> 1) <<
 		ETH_TX_PARSE_BD_E2_L4_HDR_START_OFFSET_W_SHIFT) &
 		ETH_TX_PARSE_BD_E2_L4_HDR_START_OFFSET_W;
 
@@ -3570,7 +3570,7 @@ static u8 bnx2x_set_pbd_csum_e2(struct bnx2x *bp, struct sk_buff *skb,
 				u32 *parsing_data, u32 xmit_type)
 {
 	*parsing_data |=
-		((((u8 *)skb_transport_header(skb) - skb->data) >> 1) <<
+		((skb_transport_offset(skb) >> 1) <<
 		ETH_TX_PARSE_BD_E2_L4_HDR_START_OFFSET_W_SHIFT) &
 		ETH_TX_PARSE_BD_E2_L4_HDR_START_OFFSET_W;
 
@@ -3613,7 +3613,7 @@ static u8 bnx2x_set_pbd_csum(struct bnx2x *bp, struct sk_buff *skb,
 			     struct eth_tx_parse_bd_e1x *pbd,
 			     u32 xmit_type)
 {
-	u8 hlen = (skb_network_header(skb) - skb->data) >> 1;
+	u8 hlen = skb_network_offset(skb) >> 1;
 
 	/* for now NS flag is not used in Linux */
 	pbd->global_data =
@@ -3667,8 +3667,7 @@ static void bnx2x_update_pbds_gso_enc(struct sk_buff *skb,
 	u8 outerip_off, outerip_len = 0;
 
 	/* from outer IP to transport */
-	hlen_w = (skb_inner_transport_header(skb) -
-		  skb_network_header(skb)) >> 1;
+	hlen_w = skb_inner_transport_offset(skb) >> 1;
 
 	/* transport len */
 	hlen_w += inner_tcp_hdrlen(skb) >> 1;
@@ -3714,7 +3713,7 @@ static void bnx2x_update_pbds_gso_enc(struct sk_buff *skb,
 					0, IPPROTO_TCP, 0));
 	}
 
-	outerip_off = (skb_network_header(skb) - skb->data) >> 1;
+	outerip_off = (skb_network_offset(skb)) >> 1;
 
 	*global_data |=
 		outerip_off |
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f1695c889d3a07feaa8d2de9e782aa1ba847d0be..19668a8d22f76ac06259b18c27177bc2f1c7405e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2473,9 +2473,9 @@ static netdev_features_t hns3_features_check(struct sk_buff *skb,
 		return features;
 
 	if (skb->encapsulation)
-		len = skb_inner_transport_header(skb) - skb->data;
+		len = skb_inner_transport_offset(skb);
 	else
-		len = skb_transport_header(skb) - skb->data;
+		len = skb_transport_offset(skb);
 
 	/* Assume L4 is 60 byte as TCP is the only protocol with a
 	 * a flexible value, and it's max len is 60 bytes.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f12092cdb1f0a5b22895b1aad2e79ed6b4833a0a..a67b13869016b8cb2eeac8a3e8e1d958497d8c89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13208,7 +13208,7 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 		features &= ~NETIF_F_GSO_MASK;
 
 	/* MACLEN can support at most 63 words */
-	len = skb_network_header(skb) - skb->data;
+	len = skb_network_offset(skb);
 	if (len & ~(63 * 2))
 		goto out_err;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 335fd13e86f717136763a2ad8334d247d0e3edb4..245c458e38aee3530badf3689547196043ae4ff7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4423,7 +4423,7 @@ static netdev_features_t iavf_features_check(struct sk_buff *skb,
 		features &= ~NETIF_F_GSO_MASK;
 
 	/* MACLEN can support at most 63 words */
-	len = skb_network_header(skb) - skb->data;
+	len = skb_network_offset(skb);
 	if (len & ~(63 * 2))
 		goto out_err;
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cebb44f51d5f5bbd1177b0caeb1e08f7a2fc30db..b3555655050341a069b6e0cca77e2275f90f87f4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2538,7 +2538,7 @@ igb_features_check(struct sk_buff *skb, struct net_device *dev,
 	unsigned int network_hdr_len, mac_hdr_len;
 
 	/* Make certain the headers can be described by a context descriptor */
-	mac_hdr_len = skb_network_header(skb) - skb->data;
+	mac_hdr_len = skb_network_offset(skb);
 	if (unlikely(mac_hdr_len > IGB_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index a4d4f00e6a8761673857feb019de7ebaf34900ef..b0cf310e6f7bd5c6b6c2ba1ae40072fd183d546d 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2655,7 +2655,7 @@ igbvf_features_check(struct sk_buff *skb, struct net_device *dev,
 	unsigned int network_hdr_len, mac_hdr_len;
 
 	/* Make certain the headers can be described by a context descriptor */
-	mac_hdr_len = skb_network_header(skb) - skb->data;
+	mac_hdr_len = skb_network_offset(skb);
 	if (unlikely(mac_hdr_len > IGBVF_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3af52d238f3bf497f79d1f96f190a1afb6a3c654..34820f6a78b92f011f0ec5c220ca1622bdbd5c81 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5277,7 +5277,7 @@ igc_features_check(struct sk_buff *skb, struct net_device *dev,
 	unsigned int network_hdr_len, mac_hdr_len;
 
 	/* Make certain the headers can be described by a context descriptor */
-	mac_hdr_len = skb_network_header(skb) - skb->data;
+	mac_hdr_len = skb_network_offset(skb);
 	if (unlikely(mac_hdr_len > IGC_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e23c3614fb104f021b85adf73903bde1af6f69c8..1e93edc967ed85612fe6053f3c4cf3172de009ee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10205,7 +10205,7 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
 	unsigned int network_hdr_len, mac_hdr_len;
 
 	/* Make certain the headers can be described by a context descriptor */
-	mac_hdr_len = skb_network_header(skb) - skb->data;
+	mac_hdr_len = skb_network_offset(skb);
 	if (unlikely(mac_hdr_len > IXGBE_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index a44e4bd561421a5ee398f29464ec591af32c8857..9c960017a6de508a1c6db292ff153fcd3472f422 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4413,7 +4413,7 @@ ixgbevf_features_check(struct sk_buff *skb, struct net_device *dev,
 	unsigned int network_hdr_len, mac_hdr_len;
 
 	/* Make certain the headers can be described by a context descriptor */
-	mac_hdr_len = skb_network_header(skb) - skb->data;
+	mac_hdr_len = skb_network_offset(skb);
 	if (unlikely(mac_hdr_len > IXGBEVF_MAX_MAC_HDR_LEN))
 		return features & ~(NETIF_F_HW_CSUM |
 				    NETIF_F_SCTP_CRC |
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index cb1746bc0e0c5d65f8fb546cf1236b9b4d16e0e4..847fa62c80df822addd58374a66b794bf8314aae 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -215,7 +215,7 @@ static void qede_set_params_for_ipv6_ext(struct sk_buff *skb,
 
 	bd2_bits1 |= (1 << ETH_TX_DATA_2ND_BD_IPV6_EXT_SHIFT);
 
-	bd2_bits2 |= ((((u8 *)skb_transport_header(skb) - skb->data) >> 1) &
+	bd2_bits2 |= ((skb_transport_offset(skb) >> 1) &
 		     ETH_TX_DATA_2ND_BD_L4_HDR_START_OFFSET_W_MASK)
 		    << ETH_TX_DATA_2ND_BD_L4_HDR_START_OFFSET_W_SHIFT;
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 41894d154013bfd02ced02d465838efa26a5b3aa..b9dc0071c5de46deaad545e00abe336497d334c3 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -446,8 +446,7 @@ static int qlcnic_tx_encap_pkt(struct qlcnic_adapter *adapter,
 	encap_descr |= skb_network_offset(skb) << 10;
 	first_desc->encap_descr = cpu_to_le16(encap_descr);
 
-	first_desc->tcp_hdr_offset = skb_inner_transport_header(skb) -
-				     skb->data;
+	first_desc->tcp_hdr_offset = skb_inner_transport_offset(skb);
 	first_desc->ip_hdr_offset = skb_inner_network_offset(skb);
 
 	qlcnic_set_tx_flags_opcode(first_desc, flags, opcode);
diff --git a/drivers/net/ethernet/sfc/siena/tx_common.c b/drivers/net/ethernet/sfc/siena/tx_common.c
index a7a9ab304e13686dbddbb8718d1af4df664c44e5..71f9b5ec5ae4657d38c7457ac397421ec5cccced 100644
--- a/drivers/net/ethernet/sfc/siena/tx_common.c
+++ b/drivers/net/ethernet/sfc/siena/tx_common.c
@@ -317,11 +317,10 @@ static int efx_tx_tso_header_length(struct sk_buff *skb)
 	size_t header_len;
 
 	if (skb->encapsulation)
-		header_len = skb_inner_transport_header(skb) -
-				skb->data +
+		header_len = skb_inner_transport_offset(skb) +
 				(inner_tcp_hdr(skb)->doff << 2u);
 	else
-		header_len = skb_transport_header(skb) - skb->data +
+		header_len = skb_transport_offset(skb) +
 				(tcp_hdr(skb)->doff << 2u);
 	return header_len;
 }
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 9f2393d343715d96fc2fbb3a19e3a5c2fde601ff..2adb132b2f7e46951dbe65c4394741a072e63baf 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -336,11 +336,10 @@ int efx_tx_tso_header_length(struct sk_buff *skb)
 	size_t header_len;
 
 	if (skb->encapsulation)
-		header_len = skb_inner_transport_header(skb) -
-				skb->data +
+		header_len = skb_inner_transport_offset(skb) +
 				(inner_tcp_hdr(skb)->doff << 2u);
 	else
-		header_len = skb_transport_header(skb) - skb->data +
+		header_len = skb_transport_offset(skb) +
 				(tcp_hdr(skb)->doff << 2u);
 	return header_len;
 }
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index 64a6768f75ea17fb1c8a8bd83764679f13afc9f8..ddf149db81801d520f7f0e3da07f197686c39813 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -174,8 +174,8 @@ static int tso_start(struct tso_state *st, struct efx_nic *efx,
 	unsigned int header_len, in_len;
 	dma_addr_t dma_addr;
 
-	st->ip_off = skb_network_header(skb) - skb->data;
-	st->tcp_off = skb_transport_header(skb) - skb->data;
+	st->ip_off = skb_network_offset(skb);
+	st->tcp_off = skb_transport_offset(skb);
 	header_len = st->tcp_off + (tcp_hdr(skb)->doff << 2u);
 	in_len = skb_headlen(skb) - header_len;
 	st->header_len = header_len;
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 3525d5c0d694ca30fea4ddc12b1286a40bda359a..351609f4f011d71b5bd07923e78cadab9b2015c4 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1144,9 +1144,9 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
 		nskb->protocol = skb->protocol;
 		offset = skb_mac_header(skb) - skb->data;
 		skb_set_mac_header(nskb, offset);
-		offset = skb_network_header(skb) - skb->data;
+		offset = skb_network_offset(skb);
 		skb_set_network_header(nskb, offset);
-		offset = skb_transport_header(skb) - skb->data;
+		offset = skb_transport_offset(skb);
 		skb_set_transport_header(nskb, offset);
 
 		offset = 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 7cf02ab6de68bd87e4b2602936c8e198a4d5a0cb..6dff2c85682d8bcdd97ca614447e205919d5decd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1257,7 +1257,7 @@ static int wx_tso(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 
 	/* compute header lengths */
 	l4len = enc ? inner_tcp_hdrlen(skb) : tcp_hdrlen(skb);
-	*hdr_len = enc ? (skb_inner_transport_header(skb) - skb->data) :
+	*hdr_len = enc ? skb_inner_transport_offset(skb) :
 			 skb_transport_offset(skb);
 	*hdr_len += l4len;
 
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index a176653c88616b1bc871fe52fcea778b5e189f69..df275b4fccb6d01a3bc22bc5bcc418b569a728e5 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -263,7 +263,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 	 * call skb_cow_data, so that there's no chance that data is removed
 	 * from the skb, so that later we can extract the original endpoint.
 	 */
-	offset = skb->data - skb_network_header(skb);
+	offset = -skb_network_offset(skb);
 	skb_push(skb, offset);
 	num_frags = skb_cow_data(skb, 0, &trailer);
 	offset += sizeof(struct message_data);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 98e0e3835b28b615d447d4b5ff08b10831d858e9..6887417acf16551c2338e62ece3a847203040279 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1358,7 +1358,7 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 				struct sk_buff *skb,
 				enum cgroup_bpf_attach_type atype)
 {
-	unsigned int offset = skb->data - skb_network_header(skb);
+	unsigned int offset = -skb_network_offset(skb);
 	struct sock *save_sk;
 	void *saved_data_end;
 	struct cgroup *cgrp;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c69793f94bb8489cdf0c93b7524ba3fc..25d2b7cc12a51fc8de2fd4de4b676ac5526a23a4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -310,7 +310,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 	nf_reset_ct(skb);
 
-	skb_push(skb, skb->data - skb_network_header(skb));
+	skb_push(skb, -skb_network_offset(skb));
 
 	raw_rcv_skb(sk, skb);
 	return 0;
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index c54676998eb60b7a47ee9defe8d97aec643dd1e1..dae35101d18959b73e60904f2225e59d1423455a 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -58,7 +58,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 		return -iph->protocol;
 #endif
 
-	__skb_push(skb, skb->data - skb_network_header(skb));
+	__skb_push(skb, -skb_network_offset(skb));
 	iph->tot_len = htons(skb->len);
 	ip_send_check(iph);
 
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 727792907d6cb2132d965da4c7cb8447f07b2a68..5a5ac8f036509c0f0bd8d1f3bffbd9d44b2444fd 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -802,7 +802,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 
 	ip6_route_input(skb);
 	if (skb_dst(skb)->error) {
-		skb_push(skb, skb->data - skb_network_header(skb));
+		skb_push(skb, -skb_network_offset(skb));
 		dst_input(skb);
 		return -1;
 	}
@@ -819,7 +819,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 		goto looped_back;
 	}
 
-	skb_push(skb, skb->data - skb_network_header(skb));
+	skb_push(skb, -skb_network_offset(skb));
 	dst_input(skb);
 	return -1;
 
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index b2dd48911c8d62e65cdbb645cc341e12ebc1c3d7..1a51a44571c372184fb4dabc967dedb44cde976b 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -327,9 +327,9 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	if (!reasm_data)
 		goto err;
 
-	payload_len = ((skb->data - skb_network_header(skb)) -
+	payload_len = -skb_network_offset(skb) -
 		       sizeof(struct ipv6hdr) + fq->q.len -
-		       sizeof(struct frag_hdr));
+		       sizeof(struct frag_hdr);
 	if (payload_len > IPV6_MAXPLEN) {
 		net_dbg_ratelimited("nf_ct_frag6_reasm: payload len = %d\n",
 				    payload_len);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5ebc47da1000c2e5fe3a6cfbfda74fe1c6f6db6d..acb4f119e11f0a5a5c0fcd0208436c34b9e4b9e8 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -272,9 +272,9 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	if (!reasm_data)
 		goto out_oom;
 
-	payload_len = ((skb->data - skb_network_header(skb)) -
+	payload_len = -skb_network_offset(skb) -
 		       sizeof(struct ipv6hdr) + fq->q.len -
-		       sizeof(struct frag_hdr));
+		       sizeof(struct frag_hdr);
 	if (payload_len > IPV6_MAXPLEN)
 		goto out_oversize;
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 6e36e5047fbab6bd2a4236006bab5efa546d6850..a17d783dc7c0d7de6695e1ccec3a7b3a87f31e88 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -43,7 +43,7 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
-	int nhlen = skb->data - skb_network_header(skb);
+	int nhlen = -skb_network_offset(skb);
 
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =
 		XFRM_MODE_SKB_CB(skb)->protocol;
-- 
2.44.0.278.ge034bb2e1d-goog


