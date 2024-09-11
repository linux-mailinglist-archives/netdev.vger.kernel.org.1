Return-Path: <netdev+bounces-127299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD4974E6D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34780286ECE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8126F17D378;
	Wed, 11 Sep 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgztLbYq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4617838C
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046467; cv=none; b=Qk4OjU32MnfAoqdVn72Y+smzz18/P7aHpftvuerMZZpEze3AJd38PN7fxILJTbavS7Ko4/8b5/BQ6cEHJzOm0DahOSnTKLUkSIzGim4bBNilqYy57N7AIATRAnjkG6lC+whNJTnDji2A+8FhGg/kd1hJYrmE0SCH9QYLxq0S+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046467; c=relaxed/simple;
	bh=DHp/mUpzvA4K7Qm2i1Gwac+pAiTlY5oYTEqcySLJkCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxRqOKXGqRLnKAsfGijfbLrLqhRL7WZRhUq501T6siwUnoTCuI9GGMpMW42/CxjAb3RUk6vtLIBeGl6Zfmt73kuUj5SSyG+IK4dPdthFIj7t7QMvB85f/qmozd2q4qvn/veCL9cBhmGOkkWzvk8+G7fBthoUwFPEUw33q1GKBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgztLbYq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnWnhwZhst5zS4FXbkaFs24pilkqbZwz1XRksntuoBE=;
	b=BgztLbYqf4KUazUkiCPlIJd0+oDCJDAtLP3xXZUWqxjAZn/FlRrh+LVcvzKtQH7vpfboT4
	n1YE/frZjS6WLyAaxBFhaZOb8qnhLu/hJzt3vQBoieSXH0CRHYKsxkQg6UADMY8wI8gILZ
	eAxWXhKWBnjyD7Qjk6yri31d5KZNNPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-r7HVeneWPFCcCUqL0bCVjw-1; Wed, 11 Sep 2024 05:21:03 -0400
X-MC-Unique: r7HVeneWPFCcCUqL0bCVjw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so35573825e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046461; x=1726651261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnWnhwZhst5zS4FXbkaFs24pilkqbZwz1XRksntuoBE=;
        b=vqnEi2kKYI8A1WPIa36cZ8KRP8BqgOCG7DOrmNJZDcZJIyDya1Vqk7gkdPSYF1yz/3
         FpK1xbz5bgiomJoL+kGJzXemNSms2ySSTab6z/7BtySlHqnjMoafw5sJNEUKexrkBLHm
         InxB/3rMEfWdlJTa0pw1nQBblWKyR80J1bMT+YWj6iz2IDmJP+nTJXGpRfdS28RjLabJ
         WGMXDRNKq2mnaN14x83qggirBg0lWjSfmBNzSM5ze1Ixd91PQkFlUGGMtSxWUx+TA6tv
         mPjmsWMcEQIH3dTzLH3lW0Twt4wXbqsV3tSA4gNWPFdNnXHYSivxM809EQTOhzIVNejb
         OIJw==
X-Gm-Message-State: AOJu0Ywmv/o2c4qf3XVC4IhC4LqsRdIubyMbZ5B+wd9GVsJDNj+txCYs
	xo+HzaqcenEg27E6YY9NyMbaTB3TKPEsa/FFrjUqmbwT+EtDPd9RJRo8jHk85D3I4q2zIhqdE2W
	0uCAmP/aqWvenVuJDpT/rkpH+TJGFnMZKyNVcphBiMijup4xh82WxJQ==
X-Received: by 2002:a05:600c:a48:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42c9f9e0f8bmr148991005e9.23.1726046461588;
        Wed, 11 Sep 2024 02:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdvHyp8KRfF6J2d7ewwCTvkUlrThRLG/B2aPDoWZwk8IGnj39gKzKYcfxTbP0Y6yJtg21ePA==
X-Received: by 2002:a05:600c:a48:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42c9f9e0f8bmr148990705e9.23.1726046461009;
        Wed, 11 Sep 2024 02:21:01 -0700 (PDT)
Received: from debian (2a01cb058d23d600901e7567fb9bd901.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:901e:7567:fb9b:d901])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0600651sm170979625e9.32.2024.09.11.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:21:00 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:20:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Martin Varghese <martin.varghese@nokia.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2 1/2] bareudp: Pull inner IP header in
 bareudp_udp_encap_recv().
Message-ID: <5205940067c40218a70fbb888080466b2fc288db.1726046181.git.gnault@redhat.com>
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

Bareudp reads the inner IP header to get the ECN value. Therefore, it
needs to ensure that it's part of the skb's linear data.

This is similar to the vxlan and geneve fixes for that same problem:
  * commit f7789419137b ("vxlan: Pull inner IP header in vxlan_rcv().")
  * commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
    geneve_rx()")

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: Add Fixes: tag.

 drivers/net/bareudp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 7aca0544fb29..b4e820a123ca 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -68,6 +68,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	__be16 proto;
 	void *oiph;
 	int err;
+	int nh;
 
 	bareudp = rcu_dereference_sk_user_data(sk);
 	if (!bareudp)
@@ -148,10 +149,25 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	}
 	skb_dst_set(skb, &tun_dst->dst);
 	skb->dev = bareudp->dev;
-	oiph = skb_network_header(skb);
-	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
+	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(bareudp->dev, rx_length_errors);
+		DEV_STATS_INC(bareudp->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (!ipv6_mod_enabled() || family == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 	else
-- 
2.39.2


