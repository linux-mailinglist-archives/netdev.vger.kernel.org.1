Return-Path: <netdev+bounces-101511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05FA8FF239
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AC41C223FC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4261990A2;
	Thu,  6 Jun 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYUfds0Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E6197A97
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690442; cv=none; b=Irnsykni9WGO0vVN0pWKTts20vSdJ5U1XBSn9B2uFPnFCQtkF2YXFx2SF6xTtjIwP8p3ntPddp6EFcRivNuDtmF/vLfQGFpxtCOQP2e9qYlbE41A8bhF4UFlh8tD0TvsmmJhJCCW8wlBQqipXW3BDeiEWF4mSZzNQ1+3Lpq/U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690442; c=relaxed/simple;
	bh=W1OuWNB0bkOEU9w5LqbddJ4kBF2lvHqPeAPrjRKvtgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cCK7C1/xRntI1/IIhusb0jgyRtcgt9w/5tXXrItwuuQz06E5V+vluwLadhFHiiqf0vkTrktdVsMl5kuii/3cG8EwTvR4z2CrFGdKwGRQzu3xNbwKr9nEt6UjcXq12NzZ/wP9U4K+Bb062ObzexNgnDbO4uyJr95dwC2hjWcxAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYUfds0Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717690439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IzSDGw8od85snm57zbxuvv/NzS8nkao35fmoIwqLLgs=;
	b=gYUfds0ZfpnyR6gmfDveAihvkY9PftXITceqcFvOQz9i1fXluwRscCUOoT9wAKB2a93ORW
	8FEDKjvQ6ceqK46G70fXp5ZIC4nRh4G2KkOVOqW5RRzzYqhcERTdddBU1+B/k9Nv5Ki5PD
	t0qGAAjX58WlpSRF07zZU6YLyfEIoUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Xcy8I2HdPPGEKvzbb5ug9A-1; Thu, 06 Jun 2024 12:13:58 -0400
X-MC-Unique: Xcy8I2HdPPGEKvzbb5ug9A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42135f60020so10023015e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 09:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717690437; x=1718295237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzSDGw8od85snm57zbxuvv/NzS8nkao35fmoIwqLLgs=;
        b=g2dcf1UCfPI3c7IjUO3cbJTgTm/CFossrg/G1xNlFDzpCIpGlTWlVmhqIWWT7tMhPI
         4pEi9A2zQ7wzAB2bXmdKKFs0mEHAQYvzL4sj46pzyEqFh/TzQZx+Oj4ezv0OfV4XAzmW
         ynq2QtLvqt0QPLQ+qO3JeZRmSC2figejlVA5coixOrQv9rHa7Sdt2kQg31/jw5qOJ5ST
         toN+uQTvOzKZw7CXuTQk3TU9iR3c020ZxpdY9M8jTRkAUf1Dw2MOiazef7NgnBmK9Z8p
         UDwK/D4ICph+nrp8XI/coxSCpxTJ4+P9OSH8AHw3AvxOpRfckhbQnJRBtkWhlE4JBfcK
         ctzg==
X-Gm-Message-State: AOJu0YxVCpWZQ1Kgms/70D6ZpGjNngJFjlpq0miCDwpC9upsYTIw97Fj
	6XXrZODJsjqnEFuYvd6n+GXNIi+equfEyqOJLwcMyC0gt2XmFy/i5N/L0uB/sVmmhFb9+wypapq
	DPWdkQxQmLbl4vO7H2puYJo2YN55cOSlLMmWVQ3TYGZNRwKHZpxluDw==
X-Received: by 2002:a05:600c:474d:b0:420:29dd:84d0 with SMTP id 5b1f17b1804b1-42164a21e80mr1260335e9.29.1717690437408;
        Thu, 06 Jun 2024 09:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdTOWlSJ5IW0s71K4asP1Ona2Ida4RcKK6Be1s2hQ7mI1w/ee7ExIChEN6s3bWztZCW13yhw==
X-Received: by 2002:a05:600c:474d:b0:420:29dd:84d0 with SMTP id 5b1f17b1804b1-42164a21e80mr1260195e9.29.1717690437013;
        Thu, 06 Jun 2024 09:13:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6007c28330abdfa7052.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7c28:330a:bdfa:7052])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29508sm1946504f8f.4.2024.06.06.09.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:13:56 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:13:54 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stephen hemminger <shemminger@vyatta.com>
Subject: [PATCH net v2] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault@redhat.com>
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

VXLAN-GPE can carry IP packets directly. Use pskb_inet_may_pull() in
that case. Otherwise use skb_vlan_inet_prepare() to handle Ethernet
header and potential VLANs.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2:
  * Handle the case of VXLAN-GPE carrying Ethernet frames (Paolo)
  * s/fragmented skb/non-linear skb/ (Eric)

 drivers/net/vxlan/vxlan_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 567cb3faab70..b510855c2b2a 100644
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
@@ -2355,6 +2355,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
 	__be32 vni = 0;
 
+	if (!(flags & VXLAN_F_GPE) || skb->protocol == ETH_P_TEB) {
+		if (!skb_vlan_inet_prepare(skb))
+			goto drop;
+	} else {
+		if (!pskb_inet_may_pull(skb))
+			goto drop;
+	}
+
+	old_iph = ip_hdr(skb);
+
 	info = skb_tunnel_info(skb);
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 
-- 
2.39.2


