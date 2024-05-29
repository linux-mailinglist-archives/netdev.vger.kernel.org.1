Return-Path: <netdev+bounces-99172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C858D3EBA
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38831C225E6
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC96BFBA;
	Wed, 29 May 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALk437Bn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7CDDA1
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009281; cv=none; b=nsBRDnfyzFlJT8P9e1IkDIEaKyirvwJBHebNVoQO2eoHgfaSOQ+P5wer7DHSjXZDZ8N47t5qmoJXxc8LNZqGLuZ7OhLYy4IYwRgwu59dTwdUOqjOi1IVIx4u3xEaeSLnwuAEk0U6IZxpNN+7Ldzj30rrmP19qRNX9uoEPv6irYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009281; c=relaxed/simple;
	bh=AmGM5d3KuAGi6btRDQoaihnE/ftjlfQ8aXBMhhV+qvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OyvmBjc9pTOjJwNNolYer6f5BCuUhRzZXOxCDHVQq97x+MHlmKSHL2K/uN6eR3y4jTLs7emsde3t7SWmmNrgYHCyMcPUGasLjqIfCstUt0JRy4+loCyYiqyQdTvBtBvLOz8LvnwlvPNTX9fF4xpXNXSHHhQvseILN76f7ct9Vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALk437Bn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717009278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wC9ouJBDi8Z8E28L7Ue+HZ5zr+CL9purxuDwy31xLAo=;
	b=ALk437BnN7yXpKNhGyueqSWX+Mh3DPtnTVfpMJhtYjUB7G5mvQj58BOcfoGE2B7W66DShT
	RDYe6hIfaZVqQKwnXiWmWBKF1GszQo/qZbuRGS5Y4l4AE2MRLnWllSdPNJqk+qVR+r2meM
	p9UKJf2T4OtfVu7LL3kqNnCTnCJNIms=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-NV3yoTuhMl2t0LiF1dF37w-1; Wed, 29 May 2024 15:01:17 -0400
X-MC-Unique: NV3yoTuhMl2t0LiF1dF37w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e734caac3bso355801fa.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009275; x=1717614075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC9ouJBDi8Z8E28L7Ue+HZ5zr+CL9purxuDwy31xLAo=;
        b=k6XF59cWJP831HK/y/7+2anlQZeZvxSp9ia0tHlilUjFMl4GtXqCb9KiHohaNp4me5
         kfoF3V9Dxni9YVug0OQu8TPbyBkcaumWCkYNaloBDL9lnuC5b/budHdSgY/Mpw6zwmu1
         nZdERV5KUyKrlUUI1z4/YCsIAO66XY2HWwTfrY3sbUx6bg9mZF1wcCDtFkBAv3PLLzrG
         /beCSIRZtX3nmiAf0aq7XGiqG72QhNyhMvdSY0gdhG6zhRaIXyl1ogFqID++smB9icka
         PF37UfXN89qBUt6eIVOUUGnM01WeLgzVwFBErtxO6LjfhO5pm3zhW8xOSydQky7aCXzo
         PSbQ==
X-Gm-Message-State: AOJu0YxIAbCnYZC9l/RPgCenJj8hOS59h5xtHHayEKNLaopJvkJ8scGM
	pSb4CslG9yf+uAumaK+OPYVGrTlfmy4GPUpKpMLDU4/OhPxaK1PjxNG7b1nmjF4l0Z/8YwNbHfu
	Td9CEehznXN6G7JdiqLDhTXSoraK3rVPdxEVQoqtXb2jZM2OJo+LrqQ==
X-Received: by 2002:a05:651c:1992:b0:2e2:7e28:602e with SMTP id 38308e7fff4ca-2e95b03f451mr117940701fa.9.1717009275617;
        Wed, 29 May 2024 12:01:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKxG88dS7gNNScU24sxsjV5qhHq+dgXv0DQetOB6wIOoMcwX5JG/84mfPe5Sm5otnneEYeCA==
X-Received: by 2002:a05:651c:1992:b0:2e2:7e28:602e with SMTP id 38308e7fff4ca-2e95b03f451mr117940491fa.9.1717009275132;
        Wed, 29 May 2024 12:01:15 -0700 (PDT)
Received: from debian (2a01cb058d23d600b6becf410648fe77.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b6be:cf41:648:fe77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dbf0b2a93sm263600f8f.22.2024.05.29.12.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:01:14 -0700 (PDT)
Date: Wed, 29 May 2024 21:01:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <ea071b44960b1bb16413d6b53b355cab6ccfd215.1717009251.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure the inner IP header is part of the skb's linear data before
setting old_iph. Otherwise, on a fragmented skb, old_iph could point
outside of the packet data.

Use skb_vlan_inet_prepare() on classical VXLAN devices to accommodate
for potential VLANs. Use pskb_inet_may_pull() for VXLAN-GPE as there's
no Ethernet header in that case.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index f78dd0438843..323308734192 100644
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
 
+	if (flags & VXLAN_F_GPE) {
+		if (!pskb_inet_may_pull(skb))
+			goto drop;
+	} else {
+		if (!skb_vlan_inet_prepare(skb))
+			goto drop;
+	}
+
+	old_iph = ip_hdr(skb);
+
 	info = skb_tunnel_info(skb);
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 
-- 
2.39.2


