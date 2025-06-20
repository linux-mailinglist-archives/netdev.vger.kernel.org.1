Return-Path: <netdev+bounces-199911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9640CAE227F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3941816BF62
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E02E6128;
	Fri, 20 Jun 2025 18:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF351FBEA6;
	Fri, 20 Jun 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445347; cv=none; b=PWFC9LZaa83x2AoKQL9UOS3gMADqUweSxI6em5K8zgIi1ojORCvC3aQEqyI2tVdepJeNI3Hs4Ijzl09yeYJeUK5emMXxlB/1UALIq7WbbhWLbvn/UDngVMzKsGq8I+KHxOlCrqKOm3GcNirw3mgEOPXaiuQqT5xblVEX1rS03eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445347; c=relaxed/simple;
	bh=2pKdhzo1HMxwVwHjaTbCM/9MIT5gPisq5Z/5W/ypTeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tebpRQgcoUnwfhpvI6nLI+tYhlsRibVJ27eWyKLweagtaeEtJy001HaFEoz2cnrF8HQzLQz3GXSo8ebfY73H/IIqv0E6Yg3ciobngfCnbaIjsA7U54E3hnNG+ZDgdA+hPlIrCeguPJvqmAZ4idF3cicbzWI1+Jsjfrrg9VOpVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad891bb0957so392850566b.3;
        Fri, 20 Jun 2025 11:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445344; x=1751050144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MdUYRtToZ9U4e1Pjq6noTjhPUQvGWSQvHQg6vYWd4Q=;
        b=P016kuM6vcBKZlDFBrqbUlU175j6A6nTmev8vZQ94JeS398HckbpoVWdJVG9utHhis
         pSTiKcgdAPNRYmSKs0fDlltmynhdcmjmvcnPM4XxXgjHhM+8+aOuQaMZZwpHVtxrCMmn
         qZBwHuHCJ3X10EGda+cVZHJJVByXKH57s8ftBAUInmaFC9QAuLE/ShfG2ge9OOphM5tA
         QzP74T7WCGDmY9qWiQ1MGDhypFsQVmo0KTGxg1hbkezD7nTG6hjIsoD4elyp0lICe55L
         t8Y9Q03dWOAduMGwv3fY1BzJT6EVVHtJy+VoEigQVCSDRoU189fqYjAkPeGozrzxh3yV
         aGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUehqTkO4mG1Fv9lTkrYjYeApVDpCQE4HkZMPH1RlMydZOWY4BJztGGIHZjSXffL5In7flrELOrENItQ6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5D9pqJ0PR19f3FbgvGowfOxBkj399uxBBepsLZR7YOBRCjSo
	nabix8AwUJ4FktB/MKFiFWSafHSQ6K+DSVwo25vDMXF6uqgnmPk2vV03
X-Gm-Gg: ASbGncvgBXvhM1P4t1DHaxale8oUIBjRP09zt6nrB1/WZKm2QqTTm97ImAC8M17b8NT
	0+NaEL0ZH6NAvs05kz+Pn+zK87TgN5I1F86THCQugcX/O3cC0yE6ZT0ljCYLKTkKWnjKXURzu/K
	4WqNlaoH+qtHyHNJRnOBvl1geFaVpE3IyC8rUAwrZPU5U92zkP4AG5gGJ0Ebf3PCClZyT3KQ6Vq
	WLuFrAPbeR4ivdHoBPJvvF+foPD75l3hRZwnRmqnzocQwltNiiaw5r7Qr8TZhYtnSzQQY/aVK7+
	45ziVXicfsG6/G0r7+ICqrXQpztNI752Ll/WKcc8HCODhbn8AMhM
X-Google-Smtp-Source: AGHT+IHLlxF80gRgnE171HGf8KUHqIIkDaUzm0/WHD6+jhSVE1sQJbVAfM8euNQ84LQUMdOHJPIw+Q==
X-Received: by 2002:a17:907:1c0f:b0:ae0:4820:2474 with SMTP id a640c23a62f3a-ae057c07320mr411690866b.43.1750445343736;
        Fri, 20 Jun 2025 11:49:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b7535sm202587366b.141.2025.06.20.11.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:49:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 20 Jun 2025 11:48:55 -0700
Subject: [PATCH net] net: netpoll: Initialize UDP checksum field before
 checksumming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-netpoll_fix-v1-1-f9f0b82bc059@debian.org>
X-B4-Tracking: v=1; b=H4sIABatVWgC/x3MUQqAIBAFwKss7zvBhMq8SkSErrUQFhoRRHcPm
 gPMg8JZuMDRg8yXFNkTHNUVwa9zWlhJgCMYbRrdGq0Sn8e+bVOUW1nfdjbOPtjQoyIcmaPc/zY
 g8YnxfT9dHhpLYgAAAA==
X-Change-ID: 20250620-netpoll_fix-8c678facd8d9
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=leitao@debian.org;
 h=from:subject:message-id; bh=2pKdhzo1HMxwVwHjaTbCM/9MIT5gPisq5Z/5W/ypTeI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoVa0emlkuev5y+6QX5LuXW2KMpoaGPzlbpLWKe
 lSV40lG2lOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFWtHgAKCRA1o5Of/Hh3
 bcjxEACk1HprFMc3NfaPilfP6gpFg5F6CbQhT/NgXTsPf2qs62D1FuxrQlaIyJ9dyYjd/xpql8+
 awDmhOAX6x3d4ariMYm2Al620r12pkM4KI9XLGqFJdSLel01d2VJxVL5Oe50Cin6b4gWXyr9d+l
 /3SgmBYCszTYkmKQJ57YzSl5tqpF7g8Az7dEaMPZrht1cSEOdNwjSHvJ5I43CQCPgESpD5H+8Wa
 fbYyEnXr/90eOf9EWBQ46XbDid92OT+UJ6wGqPHR3GV0KWpR5blqvXgWXtY8R9itqFQVU2XwGTB
 pFzD06LAQWHchTBSbqMaursY2kfzjnVYxkzV1D0stHr8CJDZbxOTN8YpXDdsGGi6QC5KLwTMqgN
 OSUlPbkUzJUGvUxrr/g8U3YGAd9gpAtme66LeNR94FkKsQf4+DgkBUAP3vfrCRsROm4doCdX5NP
 RMGpcnGsb2/YhlX9pRAqQ6/oQHjcODNvA/u7qaXe+SKO2VCghj+rWy+BxODAgdeNL6bCDbRJ94l
 mTCBckMFgp/TS5t/mQGeolQkAB7vwK7Q4nrRZNCyfrQIe499nNZrXG7dYFi4TIJd+rAXhvghQYm
 22A3DsFShkcYxq9utQMLzi2UXT2UFyvPySXcxTAfxINAMUb1gDONUhaKYjkdI8KL7WAUMd7FsWw
 +RMl6QYx2tlALhw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit f1fce08e63fe ("netpoll: Eliminate redundant assignment") removed
the initialization of the UDP checksum, which was wrong and broke
netpoll IPv6 transmission due to bad checksumming.

udph->check needs to be set before calling csum_ipv6_magic().

Fixes: f1fce08e63fe ("netpoll: Eliminate redundant assignment")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4ddb7490df4b8..6ad84d4a2b464 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -432,6 +432,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	udph->dest = htons(np->remote_port);
 	udph->len = htons(udp_len);
 
+	udph->check = 0;
 	if (np->ipv6) {
 		udph->check = csum_ipv6_magic(&np->local_ip.in6,
 					      &np->remote_ip.in6,
@@ -460,7 +461,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		skb_reset_mac_header(skb);
 		skb->protocol = eth->h_proto = htons(ETH_P_IPV6);
 	} else {
-		udph->check = 0;
 		udph->check = csum_tcpudp_magic(np->local_ip.ip,
 						np->remote_ip.ip,
 						udp_len, IPPROTO_UDP,

---
base-commit: 720d4a1714e78cfdc05d44352868601be9c3de94
change-id: 20250620-netpoll_fix-8c678facd8d9

Best regards,
--  
Breno Leitao <leitao@debian.org>


