Return-Path: <netdev+bounces-76107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8B86C591
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F43D1F27006
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE0060DD8;
	Thu, 29 Feb 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOgCiu3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0860912
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199558; cv=none; b=fWm5nDjRjea57dFHrCJz3HsXL8tedHpwRsBv33uv/5oKAWE9uIotvrTgX25n3NKjwWEaQyDAsdN49BAT7271vwyGt1bfQZ9/wWQGvZ3AKp8hryGYIVzqyCDgW4rYlL9F4fYYzBozZ35sZacP8+wf8ZIYYjJoOzzVmMauMzeiKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199558; c=relaxed/simple;
	bh=PXXHCj0qSheK+PXqIEo2zK1s2R1TbuQAozRVSoKVS2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUHTFHkVK4oI0GIDcJ4kNF4YcN0E5uNGYkwSCkeeN0sUnNhYLVrPXuKhL52EeBywp2vZR1gODQfIEo37EIV48GhIF/BxngZ2c+IJxZIsH3gpyZofUP1P0rh8mfMxNHSl/IrvBPgU+hlumYwuYvazsAuS65QHZUyLFqR2l3Rs8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOgCiu3H; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-42e8e2f71f5so7291111cf.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709199556; x=1709804356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GMHHqI9Xusb41p6XUGKZRY6CZmT5vNODarz+70kM5U=;
        b=nOgCiu3H8xERhXfz/093TTLXhJHnLOSoWvh2+uhXrGHuDK8PUh2Zq7QLDzjz2LQ2J3
         XnDLMNplhFmix89itvP0CvMZ4HKYjd8i3mETuRhzVfRrpk3XdlB7cvcVsALOjJ71kTRz
         /4YmzO7CD/rfMzUyOI3nuGtJptCgN3NNENffh9R4FVpEk/5gwcbYuQjWG/PaEqu1P+1l
         NCv2ocgkvXXBTqxdd6bL1uZcoytMULrMXR9bRZGrDJ1UiBbSVhh9+eRRwhRKfv/abRfx
         fzcTjnRU8ZNYbGjdQF+usKm3C/swohvqhFy++Gv+BNWQ3KeJdIpb9PvhffXiUmuKuEpJ
         X75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199556; x=1709804356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GMHHqI9Xusb41p6XUGKZRY6CZmT5vNODarz+70kM5U=;
        b=jBfatUWvCPeSl8BgkIJBF4GXECInqT31xyuH/Y4w6cxYT6Zms6ob9EoN+wNWI8WnmM
         l7xH1AvCHref9xCi7Kt3uR8Z0O18AYKOFFgTHl/FNbWMRrXT2KmGUq6TWDrMgrQGEFC2
         uretXQe1n1j3uMoKh7SyB/6olKp3inlUgOAyPrSsnWGvc348/QxvHPXC3F4HHmSaZgBJ
         PPrKZdVv0g+HTB8BAK1QVk223xugowY/e1d9Vwm+PDyu9qWTLRvbdwQeEjK1o0ybwL0m
         sgXcBCnM2axvmbzzVhjIt6Q0JomIxOiS4feTqvpYKoLU2HDr3kyg+G5L6HPz4ZHiXQ8I
         z3gw==
X-Gm-Message-State: AOJu0YzrVG9jbCqi541nVrzYCOY296Qfz4Hwhy6X+iZy7Q/OfGiUcFzM
	kqhauVwWW5hlvPijvKd3bSWQWfX5G8ftwAiTZwSC03Lfokk7vfUVD2VST5HW2LpdGAZNcD6vUQo
	bKTosx6uPIg==
X-Google-Smtp-Source: AGHT+IEDxq6uI2572UVRvpGXxrGAnibtoh7v6g++s2BmPdwspjHLGDQfkiZg8/QFVcjjITkFLaGBNGUQ/aS89g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:57d6:0:b0:42e:7d41:47fe with SMTP id
 w22-20020ac857d6000000b0042e7d4147femr4092qta.11.1709199555981; Thu, 29 Feb
 2024 01:39:15 -0800 (PST)
Date: Thu, 29 Feb 2024 09:39:08 +0000
In-Reply-To: <20240229093908.2534595-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229093908.2534595-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229093908.2534595-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net: adopt skb_network_header_len() more broadly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(skb_transport_header(skb) - skb_network_header(skb))
can be replaced by skb_network_header_len(skb)

Add a DEBUG_NET_WARN_ON_ONCE() in skb_network_header_len()
to catch cases were the transport_header was not set.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 3 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c     | 3 +--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c    | 2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c   | 2 +-
 include/linux/skbuff.h                          | 1 +
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index adcee8d9d6d9ad23397cf939abab1577c8929df1..c9b6acd8c892d8f39fafffdf908c510b19aaa51c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3621,8 +3621,7 @@ static u8 bnx2x_set_pbd_csum(struct bnx2x *bp, struct sk_buff *skb,
 			    ((skb->protocol == cpu_to_be16(ETH_P_8021Q)) <<
 			     ETH_TX_PARSE_BD_E1X_LLC_SNAP_EN_SHIFT));
 
-	pbd->ip_hlen_w = (skb_transport_header(skb) -
-			skb_network_header(skb)) >> 1;
+	pbd->ip_hlen_w = skb_network_header_len(skb) >> 1;
 
 	hlen += pbd->ip_hlen_w;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a67b13869016b8cb2eeac8a3e8e1d958497d8c89..3fada49b8ae21251a9f1dbdefb8e6f49cdc42e42 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13213,7 +13213,7 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 		goto out_err;
 
 	/* IPLEN and EIPLEN can support at most 127 dwords */
-	len = skb_transport_header(skb) - skb_network_header(skb);
+	len = skb_network_header_len(skb);
 	if (len & ~(127 * 4))
 		goto out_err;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 245c458e38aee3530badf3689547196043ae4ff7..aefec6bd3b67f97460964606fad8498064bf67b4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4428,7 +4428,7 @@ static netdev_features_t iavf_features_check(struct sk_buff *skb,
 		goto out_err;
 
 	/* IPLEN and EIPLEN can support at most 127 dwords */
-	len = skb_transport_header(skb) - skb_network_header(skb);
+	len = skb_network_header_len(skb);
 	if (len & ~(127 * 4))
 		goto out_err;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e502f4ee9e1f75d5b53552d6229fdb253c5e78ec..782ddc8c296bbba6049c13b9c5574756d73ca276 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1015,8 +1015,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	netdev_features_t netdev_flags = NETIF_F_CSUM_MASK | NETIF_F_SG;
 	u8 tid;
 
-	snap_ip_tcp = 8 + skb_transport_header(skb) - skb_network_header(skb) +
-		tcp_hdrlen(skb);
+	snap_ip_tcp = 8 + skb_network_header_len(skb) + tcp_hdrlen(skb);
 
 	if (!mvmsta->max_amsdu_len ||
 	    !ieee80211_is_data_qos(hdr->frame_control) ||
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 6c2b37e56c7861f62b577d1571c5983b24c5ead5..fa8eba47dc4c77d5bd109d649caa31590e8d1165 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1331,7 +1331,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 			     trans->txqs.tfd.size,
 			     &dev_cmd->hdr, IWL_FIRST_TB_SIZE + tb1_len, 0);
 
-	ip_hdrlen = skb_transport_header(skb) - skb_network_header(skb);
+	ip_hdrlen = skb_network_header_len(skb);
 	snap_ip_tcp_hdrlen = 8 + ip_hdrlen + tcp_hdrlen(skb);
 	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len - iv_len;
 	amsdu_pad = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index d3bde2d010b70a11253e021bd5d8ac9b078ad33d..33973a60d0bf4165e71573807d8791cede555a3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -353,7 +353,7 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 	trace_iwlwifi_dev_tx(trans->dev, skb, tfd, sizeof(*tfd),
 			     &dev_cmd->hdr, start_len, 0);
 
-	ip_hdrlen = skb_transport_header(skb) - skb_network_header(skb);
+	ip_hdrlen = skb_network_header_len(skb);
 	snap_ip_tcp_hdrlen = 8 + ip_hdrlen + tcp_hdrlen(skb);
 	total_len = skb->len - snap_ip_tcp_hdrlen - hdr_len;
 	amsdu_pad = 0;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1470b74fb6d29457685a9e64ea790f7f9d9ffac3..d577e0bee18d21e6d568939326be5e92ad263335 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3036,6 +3036,7 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
 
 static inline u32 skb_network_header_len(const struct sk_buff *skb)
 {
+	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
 	return skb->transport_header - skb->network_header;
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


