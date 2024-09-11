Return-Path: <netdev+bounces-127300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C08974E6F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1FC1F27615
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5B154C07;
	Wed, 11 Sep 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haqC4BNb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2331547EC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046473; cv=none; b=Pra0vnkdMJRdvLGOhNDwfpkPoe9zs7PEWqbIuO+rpcRz8tIFJW6iTWvJslxRjlKmBP2zUwd9cHK5Tx1XxT0nuYPP54N6qkw3mpYOWQ/o5dbFBIggu1WkSnC+DEYXtqMknzxzFMRxq7a8GY8h+wAe5SOs21xn1OzKuHpFkaHTGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046473; c=relaxed/simple;
	bh=q+6yfiIfGpgR9NEhfqIl3fYRWAD3CBaO4r952W2rClI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPnd0E4DNQ+84Pq69ME7gYZn+v03iJp8VKwl9yMGupYRaD0N9dKrid+Oi0M8ZkjwmD7WL3VcchgK8r2Dgtd2Rv0NHJdMBdxYKK42Wye+8+uY2XBd1QcMB6YsO58nzYzoIU5akqHrjHBw6I2SSIZ7lk8UyvLNxhoDQgZ3xat7jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haqC4BNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgB4FTZluJfDbKftcFiVB902wvOMJX18onGYFEslXfU=;
	b=haqC4BNbe1Vlt7IRBm+OelYaR7tfcZERnsQsIt10kUZacXL5QZh8+mAY1qeXT4jv+CqBqN
	DiNySq06N+TjSSm74VL4WGlYDfLZAOBNkP4HYCSZ3JwoBRQG0/8y2vPvRQAVI54akQNCwa
	yvCjh9AAxiJBKLyCNg49E0kNfifb3yE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-2dFsTWPfOduxsZV4ugLejw-1; Wed, 11 Sep 2024 05:21:09 -0400
X-MC-Unique: 2dFsTWPfOduxsZV4ugLejw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso3872339f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046468; x=1726651268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgB4FTZluJfDbKftcFiVB902wvOMJX18onGYFEslXfU=;
        b=EEwtDiJP2uVJ16pI74JHj2vKOKvPTLkkuQaW/BxyNX4eK1LOSM0XurD/M3rp+RNUsF
         APAscB/eafMwB7fAWNMHl3bZSy89k1V2j7VGdNmG+bdtD2tsYJm1noDjra07O8TLSWmo
         OH0a8TskmNYSSlvvMyKCkR8TiJ1ZT557VfHyDrNdIs22oSRESYXCrQAXyO1d+t1qhLwt
         +HqvynHCzqGbnUC5Os33zl49RsdDuyd0sTVBJdc3lJZDNmY3t20EkPwhNXtbm83NAG8i
         n38j9/zRS8yZ2hxoDtEHlg0de7lOQT5HEh08qCx5xxGFKLb0meaWUF6KR5UrOcV3itYo
         fprA==
X-Gm-Message-State: AOJu0YzAUNxCK5nLlwNHfXdvo8fnZ6ZvSyYkxSS514q6NtR4clnLpCvd
	3QJ3l4iN4p/yXKPDU+6Ze+Pq4OxZMNZ8cpyqMnME0ZUJuJTSNZ08h0KIilFr9P9g1N9xZ5y/KiG
	ZSLFtMDxOYHwVHLd0N0a4j1718GpVJGVOMTltaEM8lNnxgwPQZ7lnzg==
X-Received: by 2002:a5d:4d42:0:b0:371:9121:5642 with SMTP id ffacd0b85a97d-37889609f2cmr11443066f8f.30.1726046468443;
        Wed, 11 Sep 2024 02:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA0d7XGEM8gQqbOB1ABR5hYEuvSDjYp7mCwApcJKYIkVApnuHJmOrYJpBKGxnLPhGMSa89VA==
X-Received: by 2002:a5d:4d42:0:b0:371:9121:5642 with SMTP id ffacd0b85a97d-37889609f2cmr11443051f8f.30.1726046467983;
        Wed, 11 Sep 2024 02:21:07 -0700 (PDT)
Received: from debian (2a01cb058d23d600901e7567fb9bd901.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:901e:7567:fb9b:d901])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564aef9sm11046707f8f.5.2024.09.11.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:21:07 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:21:05 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2 2/2] bareudp: Pull inner IP header on xmit.
Message-ID: <267328222f0a11519c6de04c640a4f87a38ea9ed.1726046181.git.gnault@redhat.com>
References: <cover.1726046181.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726046181.git.gnault@redhat.com>

Both bareudp_xmit_skb() and bareudp6_xmit_skb() read their skb's inner
IP header to get its ECN value (with ip_tunnel_ecn_encap()). Therefore
we need to ensure that the inner IP header is part of the skb's linear
data.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Add Fixes: tag.

 drivers/net/bareudp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index b4e820a123ca..e80992b4f9de 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,6 +317,9 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
@@ -384,6 +387,9 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
-- 
2.39.2


