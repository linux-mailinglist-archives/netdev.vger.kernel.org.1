Return-Path: <netdev+bounces-170590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95578A492B2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31117A9691
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F341DE4FE;
	Fri, 28 Feb 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="upbCXgDT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A41DE4F8
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729555; cv=none; b=Kl3ikTcpDV0hPvdpO63bbfjM43nnAy4e5O+r1XAxtU8LCS5j0ke9V2OUEKL32uAgxcNQgRYuno9E5CI/GJFdaco9p1IbNdekNpQF9rtgGECMHrPM3altgeD3wh6fF9keIpupG9gOKZbF5qlo7FVrzRppLhkPXPl45eVpP259yCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729555; c=relaxed/simple;
	bh=6JPnLhL8s35dB03n039XAvB3PJPp3xjiscDs8gfFdqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bkPCMowPC/Y4JL/3WNI6ftY1a4hzpUwW4zhKEHntzUSWzidCzJ/QlbtC8PKIfxpGak2AcfBPEqdTI13ulK8tRxc5wl5HmlK5YIE+cnOxxLjT0f7xdlZNTL8LyMAbO4cWPWheaXlMsoOzD0PcbNW2hsd2Rm5p+0ya/5GpPHPmAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=upbCXgDT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2210d92292eso47441495ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729554; x=1741334354; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=upbCXgDTP3jqAxSxFR5FQGqaOOBHbmAbOZCYoWeCdICddCJGAHPWV1HIB7v0kTkNSr
         83qScXZZY+31RojPTeGtTwtVLURPvfvvFJ2zKftrbQE/0LqjMo9U7LPASggjQtxwxuT0
         8YsOwxn/E1rfQpdwltIVbXO7X77EaEq8M2tQUsEquljGOfP5PzVhcutZjgBEepFjaYWS
         BjkXbpMWkyDcAUe1hPQLvqxGCk6EVO6VduygeFqvIlS1kS3Jieq8nphWftrlwGKIfgbX
         6ajth9YiJ0F7fT+i8KaomPfSaKV2MPDnwQnjh2TLjWOZs1GYYJ8EkSfj6hZY6+Z7NxXG
         tUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729554; x=1741334354;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY0V7oey/1irsg/oxeJVyzd/IX234qFLR74EBUPiqoM=;
        b=NcEGBWII2SP/o5r67Uy48xmVB+zF85anYchpnHfnhY0WxGRSXhzV11+SHmw8AaFeIZ
         S9cXoBIsR/dUd3uCXkppuwKCMsj9Z+NZZm1JeASNG4vs+2HdmWNBh6zsYCB9O47y84Kr
         6KgT6ukb4xO0rYQeJXV2ofuKwWM/Yn/4XUXIsmRN4Y0yNbYlmYUbhdX7jXYn46i1nPD0
         5KChSG+GdnqBlSgSrmNk8hCeqd31Ej0UTLSrxuBH2MwROjk6krktU0xoNPCJTrNJ46Fx
         F+PdsGWCXPtwigmKJpWkLC/iqO8HcmIqP/y9C/wr1+c19Ug4FFT1pUeXCr+etgSEShBj
         YUrA==
X-Forwarded-Encrypted: i=1; AJvYcCVFMwy5Qk3EUjzck8dGAVn8EIZhMutwFGrvkYAmVO++9Z1z0hFviawfHX6E8Fn1Yj0Hw0WyFgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+fXJSe8EOX8CA+fNwoOPORuZ8+0o9jO4JKofmFZ/BiyrFQbA
	9CFdGUOyyTGam5vfHMO2xuJvZ1fF1IXP7LfecmmXc1cKc3SDi4WLIp/GITjBsA8=
X-Gm-Gg: ASbGnct9kxwKGJMoWEbpfnbAW8HhyDZLrLVgg6XWh3UD+DOU6Brga9msONcnWlkxMdX
	NqvBe58s75qBy8F9ny4e6CZZSI0L1QqJooVg+norVNX6/jShlnz/jYrlbx1ZGq1INE/GGHkKV7x
	ofrVz+XbLDDpEElnjkloYk5kr8c64ZV57xcKTJKeK1g1N9Xymik7rkomhp7Ugq5VMrEObHsQ4mO
	FR7RLqjfNLlHpOOnngrWaMZYYBxtl9q924m/MA3RrjgxFGumvkG6jj6S2QntvAPcy+V0s34mwbs
	Une5NUheII1TtxXHc4cz4Mpke0Wz6A==
X-Google-Smtp-Source: AGHT+IFWTUEIr1u8c10m45czztBToHuvUxMVabSMAgvvIo/y/63jq+3tXupc/0FfOTFltv8uY5F7yQ==
X-Received: by 2002:a17:902:ecd0:b0:220:f030:376b with SMTP id d9443c01a7336-22368f91ed0mr42335305ad.21.1740729553732;
        Thu, 27 Feb 2025 23:59:13 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5bfesm27643365ad.131.2025.02.27.23.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:48 +0900
Subject: [PATCH net-next v7 2/6] net: flow_dissector: Export
 flow_keys_dissector_symmetric
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-2-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

flow_keys_dissector_symmetric is useful to derive a symmetric hash
and to know its source such as IPv4, IPv6, TCP, and UDP.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/flow_dissector.h | 1 +
 net/core/flow_dissector.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index ced79dc8e8560e25a4dd567a04f5710b53452b45..d01c1ec77b7d21b17c14b05c47e3cdda39651bec 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -423,6 +423,7 @@ __be32 flow_get_u32_src(const struct flow_keys *flow);
 __be32 flow_get_u32_dst(const struct flow_keys *flow);
 
 extern struct flow_dissector flow_keys_dissector;
+extern struct flow_dissector flow_keys_dissector_symmetric;
 extern struct flow_dissector flow_keys_basic_dissector;
 
 /* struct flow_keys_digest:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 9cd8de6bebb543c3d672f576e03b29aa86b9d34a..32c7ee31330cf52df05d7a23b3e50d1a1bed9908 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1862,7 +1862,8 @@ void make_flow_keys_digest(struct flow_keys_digest *digest,
 }
 EXPORT_SYMBOL(make_flow_keys_digest);
 
-static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
+EXPORT_SYMBOL(flow_keys_dissector_symmetric);
 
 u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
 {

-- 
2.48.1


