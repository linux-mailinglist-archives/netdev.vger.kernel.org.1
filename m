Return-Path: <netdev+bounces-162531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332FBA2732A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C623A813C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED5215764;
	Tue,  4 Feb 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaPpKTsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3D2153F7
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675451; cv=none; b=HgitqRTGIe0vkoXq1ewum/jYExbdsyH0SqdzT9Ph0tQ5MaZC5YAC5Bsh31/Lk48ohbAz5rvv3xSXu6IyGcKX9El7lCLvu/fshDrGBqKmRkDT9hfA1WugWjbOMh5RFZj7NyLvKS2Uy3niDp7kaSqWdcXO1BSscP21Kynvb1/HZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675451; c=relaxed/simple;
	bh=Tv9lP/iKol3DOwtqFgPyYFOYlq/ggjrKRjQnoathmaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MMrz/tqyM0m+vSrFVVC8EvGXdrBcH0f7wW3APavPdLZ3UTqPImknTC6PRYBLP2FQIru3hIPNbS408jeRQtBu8dURcNnRBg7BexuHsKs1dQWYdu9HQSmer1JvlFPgsZ125R3JBOhx3+CdaJ8pVtL0L0Eyx2v2U9VUWnHyHfw+jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaPpKTsw; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7bcdb02f43cso603384185a.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675448; x=1739280248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=qaPpKTsw+xgFD4LmJcjZQFeL60M0ohdwDtJbA5sdVzF47vBJp/b4uwqt1tFkJ2YeU+
         E9cGyccv6ToIMsmeWjZSWaFJcEHQL0A3L6/bRWTG8uDn+h9pTmi5aqJEbRyrDWZ5ca3t
         Vcj8EYyAmue1s9lQBqsNOfmoWhMqlhWSUdiMZ0/iRZcjUqwgIwNWlzDNo0tZHnH+q+DU
         mYdKBIAy7l6pCP4Bzqm/5l83+C+WLVbidz6iptCsKKGZHECfdmxuELMWHBNMMMAWG3Ez
         PPpRsfYdj1JQrccqqTfETXUf9R2NvmBolYAJI3aC/uy9Qli6r5Q1VX4+ms4bnmehL5sV
         yG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675448; x=1739280248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gzgfgZQZl+mi1a/sA+Jd+RkxpB2VmO3rTOvLw+ezUA=;
        b=kzZGi/oN8dnVUB56MT5OKROIVGKlGoBnizJFCU//x6mJ5WhKl/0dWS1ToWi2itblsf
         Mf2bQGZOTFX/OtZH0FjLtOgVzTrGKrB6fCaK64lbbff3FjuXMBhdnx0NUxQSMM5lselq
         XBEPUv3xAQpaPlf35o4YqSa/ltMYXhCtQx1yUcChAymFTRjVzZXpSy9wyHWyko6ZoarR
         H6w2mPs8wPU5zCaLR0ryw+Kc8cOX32ABRdhipZU5W4cJft5JypG5Ar9AruMBONLBExvy
         v6SYX0Q8Xbmr426nDbJhX6MSj4uxrucaEqBZlSsiAnnWy9ADnhnrL5Sd/voVRBhN0UI4
         AG5Q==
X-Gm-Message-State: AOJu0YyjhtjQOf8fCM2gNE8qkI9Tpa7l36uEuJ0blwkPY+Q4LSOqXri+
	czt7LoSdAqPVJul4gV4RuggdbookQyxbcNSgjJ4uRJ1HMZbmd6V7X74LBgCIShoU099mIq6qCwO
	YnKpKSCl4Qw==
X-Google-Smtp-Source: AGHT+IEkT9t6vpX6GZEi0d28oYCl6RO8GINPMTR3BZrIPlzMSBq6bhARnF1wwsIq/0IRtyG5gy8GivBU93UXUQ==
X-Received: from qknqb10.prod.google.com ([2002:a05:620a:650a:b0:7b6:c513:cf45])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2686:b0:7b8:61df:f5de with SMTP id af79cd13be357-7bffcd90727mr4007528685a.45.1738675448607;
 Tue, 04 Feb 2025 05:24:08 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:44 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-4-edumazet@google.com>
Subject: [PATCH v3 net 03/16] ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip_dst_mtu_maybe_forward() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: f87c10a8aa1e8 ("ipv4: introduce ip_dst_mtu_maybe_forward and protect forwarding path against pmtu spoofing")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ip.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fcdd8ea88c54584b8d4b6c50e7d0c9..ba7b43447775e51b3b9a8cbf5c3345d6308bb525 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -471,9 +471,12 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = dst_rtable(dst);
-	struct net *net = dev_net(dst->dev);
-	unsigned int mtu;
+	unsigned int mtu, res;
+	struct net *net;
+
+	rcu_read_lock();
 
+	net = dev_net_rcu(dst->dev);
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -497,7 +500,11 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 out:
 	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
 
-	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+
+	rcu_read_unlock();
+
+	return res;
 }
 
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
-- 
2.48.1.362.g079036d154-goog


