Return-Path: <netdev+bounces-158506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63160A123F0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A37188B7E7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814852139C6;
	Wed, 15 Jan 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ4EBjzU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D912475C8
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945102; cv=none; b=aV50grgU4emNezIkWV4J2orrM0kobtGHKrHQnL6HOuTIuKGRYagEYS+RYewihZYyoJAwCGSRGu9AzzUTWK2Pxwk11AvNftquj/uCfKwrfBeNMNVMs1lYY+nyz3+VFQ3WKgSU7jKvwnzX0Gfl3r7SliTNR7pj8kfceRFqDKnBnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945102; c=relaxed/simple;
	bh=+0Pp6MfZvYi31RiamzwKQPw5KC6VEPCDjQ1AOgXLRHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AEiwPDwgjjA/8skg8EkCR6c6wRhZoRXKsmfM8KyJ/0/aJIzK1ZccWPHuiKuDUst5O4BuY0OqxIlftrHMqSdXXBK6YlAyMqw40XIwUPxJXDmsEe6LMD9OIBLYtMpefFYggKg0zMRvOgu91LcCtYCaX2G0cU7oip7Gb75vHTcDknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZ4EBjzU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736945099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=68ei5DOvAa/E5bc2+JnDKedc78DBOvWfZQBNFL4tRhM=;
	b=QZ4EBjzU3OWDp8+iVrOEoTPfrfP8RlDyK6p+j3VtwqSeFk52J6ixrjEfpalnvNFXXb20r4
	RLjEuM5kqCzzv2dnn7FvJcBNrIiftE8jL4xUOmc9ioTRF6LMD/0XkcF7sR3Sfq52mrKSUN
	rVj9jOa+dwIYfXnDjm+1Jkwd4pfD52k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-UeG64twPPeC9HVpzBkbWHg-1; Wed, 15 Jan 2025 07:44:56 -0500
X-MC-Unique: UeG64twPPeC9HVpzBkbWHg-1
X-Mimecast-MFC-AGG-ID: UeG64twPPeC9HVpzBkbWHg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so31598455e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 04:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736945095; x=1737549895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68ei5DOvAa/E5bc2+JnDKedc78DBOvWfZQBNFL4tRhM=;
        b=qyg/vY0bu4TMJOlEfued+oo5REkiufn5bLj+zNt0vMeb3PeyPQtFmYNhRbQatZjGa7
         Qx3cLlCUVK/wMU4cPg3DzXtuNgTIivvoxTyKqE8cFLx3+J8BEyEoEj7RnZT32tx5ALx7
         ESRJkXDv9v565Mkc2zfsTYfigu/G7phlAb3uJLLofFNUbLCGeULNrMQuFNfFS3zWds/l
         P/ua9cZeWV8kSmRKBelUAXHHyu89uXyerNhk9voczua+JAykW64JlE9eOFtAYWBroqcK
         PzUhXWJtw3KRuD5+p2KAbDsoQua1GmW+R7yGG15Jhp8LexN50XGVcUjCmHUimr2Q8nKM
         xmfw==
X-Gm-Message-State: AOJu0Yy+ztyHmYulZCElKyFUbIpqsc/oDwlq/VoZq48/Fm964doTZ+wj
	S6xRE/glPzKP5JQxolnIj525VTznBuVvoRlKrI55HMfeIb4WpQtNX7dZ/vj/QI88HexPMud3pNX
	FTOW8aJ/4p/0+f7QgGdyT2g5TNt0g7jIm3O+uHNCY9UiVEySC4K3z7A==
X-Gm-Gg: ASbGncvOHvXNdsiw11CCgtXEmpcutyuZzbY23pnB9zl7bJXRX3bWp3XiIida5uvcMMr
	KAt7s/LeqzCbSyUF8dfGOk7tkRs5m6k6OSXPaEkIFgD2wGpHcxfPYYfex785hAFEulk4WT5EfK6
	PU5wjM+ctO/XE4c+NgZSbY8rj8dTh9IPEQDfdXUSoyBlFLJbBZyg68I2x92ZCUE/3LkpZbGrJC6
	STEc2KtjatAFwysko6iQOps/yf3kg0NhghhJGrGgGLpDl8jZKGR1fIXJrNh8Vnx0cYmSS69/oWE
	TJXAXJIY10CtEJxfRljRsCvOpCAhFgykONvX
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id 5b1f17b1804b1-436e26a7578mr278574635e9.15.1736945095096;
        Wed, 15 Jan 2025 04:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWMt27yG2kMWi1F5AG48AAxfZOpqYQ28lr80ZUv7RadtO0edXKJh06nLDhYNQLkMgaeFpJow==
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id 5b1f17b1804b1-436e26a7578mr278574395e9.15.1736945094701;
        Wed, 15 Jan 2025 04:44:54 -0800 (PST)
Received: from debian (2a01cb058d23d6009e7a50f94171b2f9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9e7a:50f9:4171:b2f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499502sm22098855e9.4.2025.01.15.04.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 04:44:54 -0800 (PST)
Date: Wed, 15 Jan 2025 13:44:52 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipv4: Prepare inet_rtm_getroute() to .flowi4_tos
 conversion.
Message-ID: <7bc1c7dc47ad1393569095d334521fae59af5bc7.1736944951.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Store rtm->rtm_tos in a dscp_t variable, which can then be used for
setting fl4.flowi4_tos and also be passed as parameter of
ip_route_input_rcu().

The .flowi4_tos field is going to be converted to dscp_t to ensure ECN
bits aren't erroneously taken into account during route lookups. Having
a dscp_t variable available will simplify that conversion, as we'll
just have to drop the inet_dscp_to_dsfield() call.

Note that we can't just convert rtm->rtm_tos to dscp_t because this
structure is exported to user space.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/route.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9f9d4e6ea1b9..1f7e2a02dd25 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3269,6 +3269,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct flowi4 fl4 = {};
 	__be32 dst = 0;
 	__be32 src = 0;
+	dscp_t dscp;
 	kuid_t uid;
 	u32 iif;
 	int err;
@@ -3283,6 +3284,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	dst = nla_get_in_addr_default(tb[RTA_DST], 0);
 	iif = nla_get_u32_default(tb[RTA_IIF], 0);
 	mark = nla_get_u32_default(tb[RTA_MARK], 0);
+	dscp = inet_dsfield_to_dscp(rtm->rtm_tos);
 	if (tb[RTA_UID])
 		uid = make_kuid(current_user_ns(), nla_get_u32(tb[RTA_UID]));
 	else
@@ -3307,7 +3309,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	fl4.daddr = dst;
 	fl4.saddr = src;
-	fl4.flowi4_tos = rtm->rtm_tos & INET_DSCP_MASK;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
 	fl4.flowi4_oif = nla_get_u32_default(tb[RTA_OIF], 0);
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = uid;
@@ -3331,9 +3333,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		fl4.flowi4_iif = iif; /* for rt_fill_info */
 		skb->dev	= dev;
 		skb->mark	= mark;
-		err = ip_route_input_rcu(skb, dst, src,
-					 inet_dsfield_to_dscp(rtm->rtm_tos),
-					 dev, &res) ? -EINVAL : 0;
+		err = ip_route_input_rcu(skb, dst, src, dscp, dev,
+					 &res) ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.2


