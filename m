Return-Path: <netdev+bounces-126386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E125C970F9C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098EC1C2224D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B81B29D2;
	Mon,  9 Sep 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqMcnI7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44D1B012B;
	Mon,  9 Sep 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866619; cv=none; b=Hp9N//57Tx1J9vbGGZ6gP3GziDk/9Q5x0PO/0x9O9fS059OtJl8jN0/RSgrpNSV7OBRZ9MPxyOlTt8KmUcNYA/5Kx/r4JXtn+mP6MD2Dfo3gpnhN0ymcIJzWt5JZfXeXtR4gCVgn9i+bSjZGPArIYCeaEBLuujbh1GAmyUQ9Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866619; c=relaxed/simple;
	bh=YZfrPDhrnbuJUOmglcDwoOF5Zik8vvADBGA8aS7PD+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iO9WuHe+8R/x4TcbmRMNjCxSp/Iqv3Hi+09NRuSM0r6bBDYoDSZ2LIkVTxpsxS1/1A3AcsNIrDWsjrP4+xX1vVevK8UpUAcZPTfTKT3MGwyd06wob8VA8AcnYLo5qBY/nzjUeRQb1TYDGybYxVbouMI6vyyRkKTiB5AuJNxMqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqMcnI7f; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-277f815e6dcso2175483fac.2;
        Mon, 09 Sep 2024 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866617; x=1726471417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz/ZZDJD7Pucm/Uf4aBWG6gS+O9yya4MSrYCj/xV9DM=;
        b=nqMcnI7f4YLpZfcL4lTD1oGqceXzaSUh8bC9Nplj0JIEiHBRFmC3fxW6pxZcptPgf1
         CcBCZGFt9dL26fyuuPptrh+vJ5F3YHLGxgTPQPrWJ0yMKty0sUUIEbzFTXsafBh5hrEM
         0DJZKDFi7ibT5ho/phKM1Uk+hhF9ASihr7a00/FYRhJOahS3X+7z2W7w3HW2S2lf+aKF
         H403wgnZ0vrgu8KGLO+d3ecvUcuAyiZZmop7y8+obYLpj8NFHDTEtdZ1MuE6yq8Yqbp1
         by1Z2qn4R0UJqrQuMWM2JURGT1aSq3bIP6KrdvIDWSFVr8JJMiX5xCUdY82US+IZyVnN
         xs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866617; x=1726471417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz/ZZDJD7Pucm/Uf4aBWG6gS+O9yya4MSrYCj/xV9DM=;
        b=HFZsnpWag26KkpCnk3P74wOdjTH8DgGmALaUhU/KW8RHgph6Fl7gudXOntLcsLf8Uu
         cZE9yjZwY2jcvRrek01XdmXE39e46/AIVPC7Lckkn91mBkcfTGWiwTSK6xdPlHtMK1ej
         LeHXeBibinNRMvaVzfVv/6Ikv3mxRVa5UGm/as18xTuZhwfWkeeDVApixe4OTgqp0Mbh
         NhF4SpQTX+SE7cv97DNXRg2KMZl+L+xZmx/hontcIJMIjkbrfjQRVAxOMLzIVUsJ8D9y
         +qMXE4nkDwretvG3xQX88AAwovWNvtJVSc9wRDy1UX0Fjko+ULsdtj61OADLBu2fRgLa
         ImYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVth7dPITVX2lEiAyv9F8YGXZ9fW2tOYFKDTYukmMpxl6v3I5pmaEo6FTp2IV4tq7UwWvEhAmJm@vger.kernel.org, AJvYcCXY61eFpyuBE4bIb2JqLOKDaq0BOqlaulhLIRy0dTrvYiTxc1GXB6FXySRvvNW4R79DASf03cuQl90RuEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwccHCFnc1ZaY0S5+SxZifHSH8H/MtQvRtsmKy5kLNsOeanQcxW
	0Dlsf575rRhMz42u/A3X6V+edpXpnhcOdxLiT+8JlaKwYdM6MsA8ky+w/UGa
X-Google-Smtp-Source: AGHT+IEuJnbNnQzojo+qINc4rSaCY6bZbPGRAjZR5SiiwEXY4cvcPuFulqoF2sKz7vrHkD6sJZ030Q==
X-Received: by 2002:a05:6870:e387:b0:27b:583b:bfa8 with SMTP id 586e51a60fabf-27b9d8082ddmr2939414fac.17.1725866617049;
        Mon, 09 Sep 2024 00:23:37 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:36 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 07/12] net: vxlan: make vxlan_set_mac() return drop reasons
Date: Mon,  9 Sep 2024 15:16:47 +0800
Message-Id: <20240909071652.3349294-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_set_mac() from bool to enum
skb_drop_reason. In this commit, the drop reason
"SKB_DROP_REASON_LOCAL_MAC" is introduced for the case that the source
mac of the packet is a local mac.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- adjust the call of vxlan_set_mac()
- add SKB_DROP_REASON_LOCAL_MAC
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++---------
 include/net/dropreason-core.h  |  6 ++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2ba25be78ac9..6fe5b75220df 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1609,9 +1609,9 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_set_mac(struct vxlan_dev *vxlan,
-			  struct vxlan_sock *vs,
-			  struct sk_buff *skb, __be32 vni)
+static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  struct vxlan_sock *vs,
+					  struct sk_buff *skb, __be32 vni)
 {
 	union vxlan_addr saddr;
 	u32 ifindex = skb->dev->ifindex;
@@ -1622,7 +1622,7 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 
 	/* Ignore packet loops (and multicast echo) */
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
-		return false;
+		return SKB_DROP_REASON_LOCAL_MAC;
 
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
@@ -1635,11 +1635,11 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if ((vxlan->cfg.flags & VXLAN_F_LEARN) &&
-	    vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source, ifindex, vni))
-		return false;
+	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+		return SKB_NOT_DROPPED_YET;
 
-	return true;
+	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+			   ifindex, vni);
 }
 
 static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
@@ -1774,7 +1774,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (!raw_proto) {
-		if (!vxlan_set_mac(vxlan, vs, skb, vni))
+		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		if (reason)
 			goto drop;
 	} else {
 		skb_reset_mac_header(skb);
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 1b9ec4a49c38..38f9d567f501 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -97,6 +97,7 @@
 	FN(VXLAN_INVALID_SMAC)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
+	FN(LOCAL_MAC)			\
 	FNe(MAX)
 
 /**
@@ -443,6 +444,11 @@ enum skb_drop_reason {
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
 	 */
 	SKB_DROP_REASON_IP_TUNNEL_ECN,
+	/**
+	 * @SKB_DROP_REASON_LOCAL_MAC: the source mac address is equal to
+	 * the mac of the local netdev.
+	 */
+	SKB_DROP_REASON_LOCAL_MAC,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
-- 
2.39.2


