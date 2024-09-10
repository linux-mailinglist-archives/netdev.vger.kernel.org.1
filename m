Return-Path: <netdev+bounces-127107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A3B974239
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1461F2648C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E602176226;
	Tue, 10 Sep 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIPIlzv5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DE1990CD
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993072; cv=none; b=u/FVlFTMX+kaGTYm4pCk+Z6EKE+iQ0WIrHJ4Hft4uyUJ1LP87dtRWD2Gb5AnPp205JQLw+PrK3DmrrQVzvIUr/RMpkHcGsCS7YdxwpSdFQxsOiRwwT31Wb5VqyZ1z1P03AUXOoK5t2gQOTJ8O6hyalQuhow5ScS0KBbJLJKR7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993072; c=relaxed/simple;
	bh=t0p+DKtsP2UqAeyDDmHG5inYJvpiLgVJBaMN8BatI30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNtWrOonHVfwdLyt84AQhoqBucEEFg6xrDvoGsJbDKLZhBc5w1ccQQzMUyFtZJ+XnLoadkfV5GHwIxhbedF6YaHh3MxRlohxSi4R/Qs1qs1CgXEEzMc/yZxiO95dyoZCQ5wdbmqnNxaN+bv2hyAuvE6uaWtdBYkY/Zo8aqpormY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIPIlzv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725993069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uD9i7eMFdncgQ4UnM4MS+bib7xCqKxNBrR1OE5cg8M8=;
	b=EIPIlzv5enrJZACHDWVLWnOAJ5ObctxdSNOYrBho0PK890HqLjHrSaUPwiabFRrF/1q9QS
	wyEe3t5ce5bBtdnc4D4BbROS4B7eB42VSTD08RbXCrW4fDSsItSN+ZHK/9wcfycbNsklHI
	3LuuxkwENJQm5c9cd3KYONWKvIj1H3g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-wlXiSiAROumy5oKgpWsiDA-1; Tue, 10 Sep 2024 14:31:08 -0400
X-MC-Unique: wlXiSiAROumy5oKgpWsiDA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so13915685e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993067; x=1726597867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD9i7eMFdncgQ4UnM4MS+bib7xCqKxNBrR1OE5cg8M8=;
        b=E2mGL1UgAY4sWw//JmZums4+gGKOm/6Z1yfNZXeWZnPVvmJX07MMM+hix0Bv809Dif
         rgB2IzKC0/4kNsTk5DPzSbU37eiyWBldBWyY5BiCfG15jAej73Bvq7wnp0ikBNi9Bp9i
         EUVHSHvF7Neh56cQwG22TYjvg6Gv56l2tnjXFuJVUSvWvtSeg+t/cLaz8+uje7A87RSo
         6A6Wfg4Fcvcq4kRAXyQETNGW9bRRr3OuCCX1dciD4rrrztM9e5PsIyeEpwJzNhbC+cta
         AVQVELYsb5Rv8Akt4Aloheve44utr0hybA0cD3G6Rm1fwf9WD/37I7xtiV8ARqlILkpy
         J2SA==
X-Gm-Message-State: AOJu0YwJ3syzS+fkbIKJbLTSoKNCBnqrpMxg12J9hg9kWGtmAMQ1Y6WO
	UJKzgNMLPKIBg8lg3ECIRmpxEZzQZBeGRECL4k5lrb6IfWk8WyjnllrG/aVmLngqb4cQYW1qqeI
	5EVyMxJlHrXCsQbM6pHqSDRhhDYbKEQzZ0WIkUq7DB0c++Gp2f5ib0w==
X-Received: by 2002:a05:600c:4446:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42cac9fb8fbmr88372985e9.31.1725993066607;
        Tue, 10 Sep 2024 11:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHku243acfzMtws68n1RLwSptOYNJC9CsQcN9WapNhDVlwfKgyMeaqNd184GHmySA9mIzjMg==
X-Received: by 2002:a05:600c:4446:b0:42c:ac9f:b505 with SMTP id 5b1f17b1804b1-42cac9fb8fbmr88372705e9.31.1725993065823;
        Tue, 10 Sep 2024 11:31:05 -0700 (PDT)
Received: from debian (2a01cb058d23d6001ef525940bfc7e6a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1ef5:2594:bfc:7e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb218d7sm121436675e9.9.2024.09.10.11.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:31:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 20:31:03 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net 1/2] bareudp: Pull inner IP header in
 bareudp_udp_encap_recv().
Message-ID: <b4556a576ad02373509b390dcc9278d4f38e1290.1725992513.git.gnault@redhat.com>
References: <cover.1725992513.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725992513.git.gnault@redhat.com>

Bareudp reads the inner IP header to get the ECN value. Therefore, it
needs to ensure that it's part of the skb's linear data.

This is similar to the vxlan and geneve fixes for that same problem:
  * commit f7789419137b ("vxlan: Pull inner IP header in vxlan_rcv().")
  * commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
    geneve_rx()")

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
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


