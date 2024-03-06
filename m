Return-Path: <netdev+bounces-77986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B1873B2E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E991284389
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B6135A4B;
	Wed,  6 Mar 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQmKltRF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5A13541D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740314; cv=none; b=XAiyEL/5W/G6zhFrZRGmU9DOlXxp8IeSm55YPBjtW6tQCWMM4g15vylLU4CRrHTCYMbVnz+Em2LAyQaLt3j8mi+F/BWN8fpaITpDXiF9Jez3yXB+wJMGJrDqC+AFGk6mERUwLkHSX4uTel++VU82PyfQe4Hb3wYtp7t6DRjjwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740314; c=relaxed/simple;
	bh=kycNMe6DHXFljknm328aMoj2S+mDUf8/A9vURyt59Ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZo3Eum6fWsb2RH6wCNI45yayIdccv3qaXRkp0V/KYbFtUjuW1UN6ynX44nEqvHjiH8pARmtSd9bup87jJGwE41B0eLmQDoiCj3Hkq0GcT1UCFeTZchr8ps6Lf7xb8ChgcRbb10XVAjd/3NsGGcPxzysFAs/MSA7ChbrQvZkijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQmKltRF; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-78319f64126so1089698185a.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740312; x=1710345112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMuCxi2AjOBoZJJyj4jdPqG4tTm6Xd7RX/AlbU4n310=;
        b=fQmKltRFXqUz1AvFishp1XqeLZGuCqx80sAVhUR+rVffsmRuUOjB3X/xrZyuxnsq8V
         N4qqqDTterz1N3ooqCSgOXdkoZ3ULX+eNDlPLua7ttZL9c7WWIeXl+/yJVHqTKiHWNoO
         AZSgsw0OYZoaJv4VEXehNL/F9mXPH89qpQFmZljydbB1mnm/PZ0U9SOmsh6VXUZWO5FP
         0nbTwOJyHXHrHiGPYqzH7YrOmmggW8ElExces/FHkgSkZoLS8Pi+3rK7zz3lYxsVU8uH
         XLbZPOATQ5etlSxoU091ws6axut76ZrVw7/k52MxiUFte55Qia6spspkC9RPrQgPMsvF
         shCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740312; x=1710345112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMuCxi2AjOBoZJJyj4jdPqG4tTm6Xd7RX/AlbU4n310=;
        b=G+YNT7UoyXkFji2Ra9Fu3JRawvWxhpY0EwdjNMtEeFfP7i4lvzP1gyT/7Y3AZA911W
         a6DVpLdCftEHzYap57Wp6EhoZkRke1AnklToTwGcCT0SfbDK7s+wiBDtZwCS4pAtIJy3
         0X8VtvPoYc/4LoMCotORBRnMBuM8AOyMUrZ5TnLzB0HckRjoD/klyIbI6khGqhS2lYD9
         VVScVRWKHxFJqojS7LdZLFdMkNBg1l+7rYL6RJ2lDOg1ynQIbD61TJ+XAt3TAy81Rojt
         FFT3uhF5XJD9Zg8K03ISuXMAUJI1BMPLKUw9t4jbccdppySjNrSGRXzH2ysUNnjt6ueu
         naaA==
X-Forwarded-Encrypted: i=1; AJvYcCXS1VywcpQdl1561yTstjXEb9h0638CTMcbYkWp2wFKMhBx2RassAvdJ9zmvyu7/9F7cviegnHVTXoSdB2BvHATZHS77NIs
X-Gm-Message-State: AOJu0YyLN83K6NGRVPyrdVsvrHGg1USShIYTZrELaeVmlMfyQKjKY3lE
	wKuE8uvH1wYpercDm3qM/liuRmzFcK+zb5OAARaVYDWn1P8KyARS9J2DwJnzcq/X/2FUXHWpFS9
	AVuQxgnBgkA==
X-Google-Smtp-Source: AGHT+IHHG505VJ+V/xBdbImUMtoGWtEdNIqIBcE5HGqtwkAu3jHud/ZJOeKrGBx/8GJE5+W3b+KQMW5u7oEtTg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4055:b0:787:d1aa:58b9 with SMTP
 id i21-20020a05620a405500b00787d1aa58b9mr67577qko.5.1709740311948; Wed, 06
 Mar 2024 07:51:51 -0800 (PST)
Date: Wed,  6 Mar 2024 15:51:42 +0000
In-Reply-To: <20240306155144.870421-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306155144.870421-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306155144.870421-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] ipv6: make in6_dump_addrs() lockless
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

in6_dump_addrs() is called with RCU protection.

There is no need holding idev->lock to iterate through unicast addresses.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 480a1f9492b590bb13008cede5ea7dc9c422af67..f063a718893d989bc3362416a6b49ed14bb4c4ea 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5273,23 +5273,22 @@ static int inet6_fill_ifacaddr(struct sk_buff *skb,
 }
 
 /* called with rcu_read_lock() */
-static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
+static int in6_dump_addrs(const struct inet6_dev *idev, struct sk_buff *skb,
 			  struct netlink_callback *cb, int s_ip_idx,
 			  struct inet6_fill_args *fillargs)
 {
-	struct ifmcaddr6 *ifmca;
-	struct ifacaddr6 *ifaca;
+	const struct ifmcaddr6 *ifmca;
+	const struct ifacaddr6 *ifaca;
 	int ip_idx = 0;
 	int err = 1;
 
-	read_lock_bh(&idev->lock);
 	switch (fillargs->type) {
 	case UNICAST_ADDR: {
-		struct inet6_ifaddr *ifa;
+		const struct inet6_ifaddr *ifa;
 		fillargs->event = RTM_NEWADDR;
 
 		/* unicast address incl. temp addr */
-		list_for_each_entry(ifa, &idev->addr_list, if_list) {
+		list_for_each_entry_rcu(ifa, &idev->addr_list, if_list) {
 			if (ip_idx < s_ip_idx)
 				goto next;
 			err = inet6_fill_ifaddr(skb, ifa, fillargs);
@@ -5302,7 +5301,6 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 		break;
 	}
 	case MULTICAST_ADDR:
-		read_unlock_bh(&idev->lock);
 		fillargs->event = RTM_GETMULTICAST;
 
 		/* multicast address */
@@ -5315,7 +5313,6 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 			if (err < 0)
 				break;
 		}
-		read_lock_bh(&idev->lock);
 		break;
 	case ANYCAST_ADDR:
 		fillargs->event = RTM_GETANYCAST;
@@ -5332,7 +5329,6 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 	default:
 		break;
 	}
-	read_unlock_bh(&idev->lock);
 	cb->args[2] = ip_idx;
 	return err;
 }
-- 
2.44.0.278.ge034bb2e1d-goog


