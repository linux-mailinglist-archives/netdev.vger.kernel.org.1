Return-Path: <netdev+bounces-162539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AEA27331
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74407168615
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028A21ADD6;
	Tue,  4 Feb 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zfgP/dPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435F21ADBA
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675461; cv=none; b=mCvuPR23TyT/3g0nbsfq85wk7JjqmKLG+umjbvcy6Yef7fl1waxX/t8bf4zT0zCR3sQHtblruLaD+RpcMI9MEr4lBNp/v/4sT7QFgkFoIawioJHfR9pwey//RLTjNACZqc72bKFq/eVNfaolf8szgpzaV4C5YJ/pWJJT9QCHSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675461; c=relaxed/simple;
	bh=aVvJrJ1SNcCktf1pQeSHpv9lzkWbBlZMrIEN1xAcgKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wp2smIqx4GSccef9GrHald0P4nKIeQ/GlwHycnaLuaorDhYIgoDVyxCHVe9EtDbNina8QLpN4mT534u1DlpLBbNsJ7RYG3WC1Z5wURB5UoVKQR2aqC9HrNY/MkRcQZ1CNN37EdFcBEIXeOh+E02ZsvFOpQoQ9BOJPxlUY9Qlzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zfgP/dPb; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e4244f9de8so14730476d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675459; x=1739280259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOhcfL8xgGzqzFZgJPYOqzYxywHOMdwlzghIyI1cDsc=;
        b=zfgP/dPbXq0jSSNb5TfNoWI6lPeiyrq3wXC6acfTMZSo/aRei1dPsc/PgNHQI6jToq
         F3EvUqND2pJ+m0rw7Hwp4AZn7kmdIeK+mvd4yRUgMmaqnQQTZHXBQ1NdOJSEtyegMkWI
         NLdGQI/HD/pXL1leCRp/EDYLrkFX5dkOiXV3494gs4L/8OQrCjQ50H8BCM2WU9CDSF2o
         fAv4Md7rjqMOg19eP6iAyZYk5wMyo2ygCF/jYF73AoPagGyplo/mcVsOiWXH6eYnkpep
         0rPRd6KfbyoibvfCvGHgRfJ+C/OYbietPSdJ98/yQGx51el2ZQ1nZ0pgzvOV785rnA7K
         gpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675459; x=1739280259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOhcfL8xgGzqzFZgJPYOqzYxywHOMdwlzghIyI1cDsc=;
        b=UJ2MicahnG1acecnvZ6/NDrEgaKEjrTt1gXHKO2MktAxSNjxIO1Ft3/SGg0RUwnBVw
         ODaTXrH2/UrCIST9VyNsYywWW4KQAEfv1XwVqUHZxq3f+U89ISdBW32JYmc6KT+G1E6y
         9yZtxvak5Q1piNFbNm9s0caWiQl5+jtgBFmOmYLJbLakytKRGdjJcjNvbTDILmlpr0UN
         lErpQy2iXexxMf409T2ArflA9E8KOzLlj1tA71ArGh4SVnQ26du/cIsDENBwlkInkovA
         XSaPmxkDxgV91MlpzkWHiUv6Va+s09nRdCNrfeILVG/yat2bNKHinPELTkAnKfcH3h0o
         Bqeg==
X-Gm-Message-State: AOJu0Yx6y7PV3eBRX0QN5MHe8L8KEYNm3dtvOu2lC1IVAbhHoT1XG+DK
	JqZ50tAdT3WzZCGGWTKuO/6rXxWth65Vfcozgu8C1CAjYCxrcx8wviXdoCUi0aZyKCIm6D4SIg4
	k+BoNxIxhCw==
X-Google-Smtp-Source: AGHT+IHy/97T+JlND31mp3xg61p05zqSTumVjErDktYYIBA8BoR+mHOBmklTTcV4AupKCltx4ms9QKytbfR5rQ==
X-Received: from qvbqp16.prod.google.com ([2002:a05:6214:5990:b0:6e2:4bc3:eba4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3115:b0:6e1:afcf:8748 with SMTP id 6a1803df08f44-6e243c35440mr450597916d6.19.1738675459137;
 Tue, 04 Feb 2025 05:24:19 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:52 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-12-edumazet@google.com>
Subject: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net() calls from net/ipv6/ip6_input.c seem to
happen under RCU protection.

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_input.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae6837d1c64d0036829c8b61799578b..4030527ebe098e86764f37c9068d2f2f9af2d183 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -301,7 +301,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 int ipv6_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	skb = ip6_rcv_core(skb, dev, net);
 	if (skb == NULL)
@@ -330,7 +330,7 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
 
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct net_device *dev = skb->dev;
-		struct net *net = dev_net(dev);
+		struct net *net = dev_net_rcu(dev);
 
 		skb_list_del_init(skb);
 		skb = ip6_rcv_core(skb, dev, net);
@@ -488,7 +488,7 @@ static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *sk
 int ip6_input(struct sk_buff *skb)
 {
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-		       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		       dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
 		       ip6_input_finish);
 }
 EXPORT_SYMBOL_GPL(ip6_input);
@@ -500,14 +500,14 @@ int ip6_mc_input(struct sk_buff *skb)
 	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
+	__IP6_UPD_PO_STATS(dev_net_rcu(skb_dst(skb)->dev),
 			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
 			 skb->len);
 
 	/* skb->dev passed may be master dev for vrfs. */
 	if (sdif) {
 		rcu_read_lock();
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), sdif);
+		dev = dev_get_by_index_rcu(dev_net_rcu(skb->dev), sdif);
 		if (!dev) {
 			rcu_read_unlock();
 			kfree_skb(skb);
@@ -526,7 +526,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
+	if (atomic_read(&dev_net_rcu(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
-- 
2.48.1.362.g079036d154-goog


