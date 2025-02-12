Return-Path: <netdev+bounces-165557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BFA32815
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86A13A47AC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B020E71A;
	Wed, 12 Feb 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkZEdlpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C120AF62
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369426; cv=none; b=V+m9BZZ/tj8bZIi/AAd6EiMKUfkaif9AyB4iUJBAyKOe1+wKWHKF9JETi0oKuzM9yqoIea0vgMG2mECWOYfTJzfIDWo/N1Vu+Z1jku2A8EzDrJyPRSsLUaF38onhG2mhTPwFsWe4iY0RF+1Remlm4kJ7NyMFY8j6t4X9BVvndu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369426; c=relaxed/simple;
	bh=HL7LpkbKDvIkcum9ljbFJjK2xYzy+z8aD/iy6Z7FnOI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xui38BvhIKZ5CbyLryghHZ/WHdRR8C3iXrgzdKIO7QMa1ua5EJwfFXBiAUEglCkpTUR9UjOKn08kaUemKDq/sOasMJJd2x7TFZGDvuDPc7dy4mxRMuH9ueZfVeSXlYFmH17aAfFxy15WLJmeomgf4Bki7HIbzK1nQSV4ATjg4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkZEdlpd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2bc451902so94766907b3.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739369423; x=1739974223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gpr4Nf7zswjRBvH8oGdMxFzM+ts0X0UPWMpiHEIDZAM=;
        b=XkZEdlpdHi0DOrjyjfCuJoQfqsd4wNXJ2xP/HeGODIlYfGYnRFX0hyZ+zUmxLHRlvd
         WT3Qce8cOOusmSd6GZaB+sqZ4oj/iat+4tyTr8AbM6sKUEfqX3mc0VbqEjIKlPKI6tTp
         NT83XWBQEaYlO8XP2XICilMk1H+wnjSkbQv0kR1TcORQvgeI7xhyVcTCrlCB4HL4VNcl
         tlJdmcSMmIWIDY7psrN0ebAkN1fi9iqVX+M9LyDc7RK7q3cxjVofaaycYN5ID/Ba7XEk
         AW1ikg9mCmgxs0YT8XNV2d15N+WUxT+v//WOQmCVk6mRxU9ssNzXkkzxlUrnGxzH0KQc
         BqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369423; x=1739974223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gpr4Nf7zswjRBvH8oGdMxFzM+ts0X0UPWMpiHEIDZAM=;
        b=ckqj+j5E46SiiY9gBgEivrMLMTh2bwwf7KX0XRH4qnPkWo53sydQAoKbP9yC8N+bPH
         aAz9lXjhTVhWDmt3P7nYaXUbqjz7TaFRhuxizbcfQaHYXtNHL7ukwPb3ppQb/Gyp7pHy
         LuoPAMv3owN3zkby0DFd2kdlwXVPJIF5HusornoB+VRT1HOV0MMVV050g9zppdqOZfGI
         umnya77ua7AO5qsAXEBQrJn+I/UEJm6G15xm/cBHKr6Izj0+HjpH/HeZ95JHneMacHS7
         sEvkFYJYnM4OnqWgOuJg6dMbah0Rtucw/HzSO7SdwwlTZNIrDpVtcl5UnZOFoyObypV5
         jJow==
X-Gm-Message-State: AOJu0Yww9onUymXy5oKmXTQ9kOXSAP6LoSdBHLQLbgnMxo/UCXae6SR7
	46LAyihxU41YKwGwcQRhru1R/yJou1PDcPXRDXrd+kMgEWnxD4oXc04hurgdIcwhMe3PA6/qriI
	X9NMVmpGoAQ==
X-Google-Smtp-Source: AGHT+IFgltHUnIWQRFNnAdczYPMh7GyRAPiaW/umEKoTquavUYmy0LpvV4jpJ/GORFn42kE9qDA7l1aR4A838A==
X-Received: from ywbfl16.prod.google.com ([2002:a05:690c:3390:b0:6f9:52c8:b79e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6386:b0:6f4:4280:2433 with SMTP id 00721157ae682-6fb1f5a5f34mr30507037b3.9.1739369423686;
 Wed, 12 Feb 2025 06:10:23 -0800 (PST)
Date: Wed, 12 Feb 2025 14:10:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212141021.1663666-1-edumazet@google.com>
Subject: [PATCH net] ipv6: mcast: add RCU protection to mld_newpack()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

mld_newpack() can be called without RTNL or RCU being held.

Note that we no longer can use sock_alloc_send_skb() because
ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.

Instead use alloc_skb() and charge the net->ipv6.igmp_sk
socket under RCU protection.

Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 81a739ebf7094694a6f5de5020cd4c4d1c9642d1..65831b4fee1fda1be110cf3f7d5abebaf076694d 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1773,21 +1773,19 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	struct net_device *dev = idev->dev;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	struct net *net = dev_net(dev);
 	const struct in6_addr *saddr;
 	struct in6_addr addr_buf;
 	struct mld2_report *pmr;
 	struct sk_buff *skb;
 	unsigned int size;
 	struct sock *sk;
-	int err;
+	struct net *net;
 
-	sk = net->ipv6.igmp_sk;
 	/* we assume size > sizeof(ra) here
 	 * Also try to not allocate high-order pages for big MTU
 	 */
 	size = min_t(int, mtu, PAGE_SIZE / 2) + hlen + tlen;
-	skb = sock_alloc_send_skb(sk, size, 1, &err);
+	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb)
 		return NULL;
 
@@ -1795,6 +1793,12 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 	skb_reserve(skb, hlen);
 	skb_tailroom_reserve(skb, mtu, tlen);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	if (ipv6_get_lladdr(dev, &addr_buf, IFA_F_TENTATIVE)) {
 		/* <draft-ietf-magma-mld-source-05.txt>:
 		 * use unspecified address as the source address
@@ -1806,6 +1810,8 @@ static struct sk_buff *mld_newpack(struct inet6_dev *idev, unsigned int mtu)
 
 	ip6_mc_hdr(sk, skb, dev, saddr, &mld2_all_mcr, NEXTHDR_HOP, 0);
 
+	rcu_read_unlock();
+
 	skb_put_data(skb, ra, sizeof(ra));
 
 	skb_set_transport_header(skb, skb_tail_pointer(skb) - skb->data);
-- 
2.48.1.502.g6dc24dfdaf-goog


