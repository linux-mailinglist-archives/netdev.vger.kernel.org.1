Return-Path: <netdev+bounces-104878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DDA90EF0E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF2D1C211A9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0F1422CA;
	Wed, 19 Jun 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWV4rL4e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6313DDC0
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804106; cv=none; b=s6y+KqcY2zDnLS0G4atkMIuX2Tgu4ymDtq3bD03X8S1EUlqmHEnQ3DFskXa3/WUH6Jkg/sDqVvtQxYwnhDw+BQHkX2yYwCLOZHWIIGXQIVawaaxstz9PD/+3yQp2EYQvDIPV+Aa5hyJ2Nbs/oRGg8dPp9uT96MKDjJf9Seh4wH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804106; c=relaxed/simple;
	bh=pvcBEkDBogreG6/mMgeoraTc96hhciAcz5hZlcWK12E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tlYtgNA79iREN5tyn8zsE59eW8CA6kRMNSX+/HqIH/k8McW/W15mg4YNuOHflwV6HHacAc89c9W+rwoXQ/Hgx5wpmK6duvw5uLUR6hH3J3hxY4trtoOQ79fkC6dyqapTcnruBud797NJqovyXSaOshFZmfT03lL9nsL3L4rpNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWV4rL4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718804104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/2yEYXTuPjNNDVH1VbYgi9ER4Dh6CLTRWr0nyEl8CR4=;
	b=PWV4rL4eszdCIjR4hnDNGjiCpG/6HRn170Izkoh//Oli2mrZk8QzPq3SDPFdn78Y6X5y2w
	fwpRCEHM6+Dll5abIIUcoDEpQeSP5gJtWNuFx0Urnvk5TzkqTcjc5jyseIbMHglVfeaRuA
	yOkvC3sj4F59WXhNfRiQw0NuHtj84nE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-vZcJ2-c0P6-_0uhTwW7DAA-1; Wed, 19 Jun 2024 09:35:02 -0400
X-MC-Unique: vZcJ2-c0P6-_0uhTwW7DAA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6f97f7481e4so7250839a34.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804102; x=1719408902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2yEYXTuPjNNDVH1VbYgi9ER4Dh6CLTRWr0nyEl8CR4=;
        b=DYW1iVIKCjoqSY5Nfyle1YqLfi1iQdYl/2fjttut4hcCG3G0EvZ2Mr/vqgCInF226B
         0UqZX2B9smepgttynuxV1NKgLfm4WS5/QYGWW4yIxuGKyHgV01YMOSjQQni8szaGf2TQ
         nP/dXMKuSzyZU5+iK8mJKkTomKZZW+J9umsnT2Ig+YO6jc15ZfajM/WAzoop1nAUk3ah
         LrBRpmt/NmGNOA3h6SFfU2gDiKcGfp/NGP/WiekZxPeX54fFbJUwcw2tLdJvJ04Ie9O1
         nW+HmdydQAjwZkSaGsY4PN1SZkqfhIPsJklOll3t5mg+/nGps6CuKoHiY8UFM3251WSA
         Qqlg==
X-Gm-Message-State: AOJu0YxulHZl9SvxLiMUjSYJxsGBcVwshOQRnX2tyvrSRUSKPasxI2KI
	KZKizQZIZaYF4LuFNZUIa+zPlZ4r16Gnzfb5vMRm/z2kHO8Q2Zl3/QtaoWCvtyRxnwPs5EWNuEL
	6pTNF1Wm0keMK76Zzh/knHZGjpSdOsaZN9DmNZD7EQtm0LJvMpDIXvw==
X-Received: by 2002:a05:6830:22fa:b0:6f9:5c2b:9e06 with SMTP id 46e09a7af769-7007430418amr2875223a34.21.1718804102026;
        Wed, 19 Jun 2024 06:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkVkhehVsrrMUXWp12UY2aWFtRjWOBpBvWNZpYfYpf4a0LjFQpcRHc5KT22e38Dt+MTn0vtA==
X-Received: by 2002:a05:6830:22fa:b0:6f9:5c2b:9e06 with SMTP id 46e09a7af769-7007430418amr2875200a34.21.1718804101537;
        Wed, 19 Jun 2024 06:35:01 -0700 (PDT)
Received: from debian (2a01cb058d23d60044f8cd8b961ccbe5.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:44f8:cd8b:961c:cbe5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf24easm77080626d6.29.2024.06.19.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:35:01 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:34:57 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
Subject: [PATCH net v3] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <2aa75f6fa62ac9dbe4f16ad5ba75dd04a51d4b99.1718804000.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure the inner IP header is part of the skb's linear data before
setting old_iph. Otherwise, on a non-linear skb, old_iph could point
outside of the packet data.

Unlike classical VXLAN, which always encapsulates Ethernet packets,
VXLAN-GPE can transport IP packets directly. In that case, we need to
look at skb->protocol to figure out if an Ethernet header is present.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2:
  * Handle the case of VXLAN-GPE carrying Ethernet frames (Paolo)
  * s/fragmented skb/non-linear skb/ (Eric)

v3:
  * Fix the skb->protocol test.
  * Rebase on top of latest net tree: use the new
    skb_vlan_inet_prepare() boolean parameter to avoid pulling the size
    of an Ethernet header when there is none.

 drivers/net/vxlan/vxlan_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 567cb3faab70..ba59e92ab941 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2339,7 +2339,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	struct ip_tunnel_key *pkey;
 	struct ip_tunnel_key key;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct iphdr *old_iph = ip_hdr(skb);
+	const struct iphdr *old_iph;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	unsigned int pkt_len = skb->len;
@@ -2353,8 +2353,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	bool use_cache;
 	bool udp_sum = false;
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+	bool no_eth_encap;
 	__be32 vni = 0;
 
+	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
+	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
+		goto drop;
+
+	old_iph = ip_hdr(skb);
+
 	info = skb_tunnel_info(skb);
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 
-- 
2.39.2


