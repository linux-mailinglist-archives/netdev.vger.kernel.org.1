Return-Path: <netdev+bounces-198967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DDADE728
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57F405052
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84061286402;
	Wed, 18 Jun 2025 09:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F9285404;
	Wed, 18 Jun 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239175; cv=none; b=bWviikZGb7tcSiYDHRmaFzNmXhn7MHkny1ySPXUONUtNuhtTubDdLiOtnL10Aw1/kHvsskb1I1gPYc8FzSHXeC3Y9rj3h/NaGWcwWCnP7JIX2kvP5c5kAXJ451SclSmQ+fWdzhV64h8zGdKIV1wqL0bQ/KmSl2ecxksTzfpdpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239175; c=relaxed/simple;
	bh=awJPoOTDHtQmol3taNl+GEtMGRMz/y4bUY7QGAY52zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpJeChvwDU2woqZRB2emKaFSjdB7HzQMDp5My9GgdLf8OEdMKf2uzg/hhVazU7pehM3Iwnk00qN0Ql1LJ3ZkOT8c3viEU3VAUR+91RjO7rvon01119DZ+pvw+SutYjAbibejIPqNMN+2qtZws0ca+0ClcYmb/4LgvpPgxWHFSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad574992fcaso1049609366b.1;
        Wed, 18 Jun 2025 02:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239172; x=1750843972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCn1kZoAQdatt2uBEbXC24iQSyiWTUg7uX197Kq7yn8=;
        b=r/R8wj+GYqyKyVFAMDYFOPKJrPOEBxSlGyb3DIVybOP40n2Qj2l4QxF9UXKwrbYtZY
         4Wysu0YYQqzgUI4XNyCWS8C7jNsqtBHbezGoGj9lMgqm85baDSG2PGhUiBdJ8q0X4JEc
         tLP/Cm1BrewmQ4YfIwMzPjKzsNlhSOrHFTll3g7Yyrp1vL1iA5diCS9ftsO/jmFfwB3G
         rlK/zl+GSytpMnuqiANKyY6jV6yTJeK/mWtf6yxCs8D1bcDX3VDmjfi8WWKtgETyEb6U
         71WcNO75FXqQJQMb0XyIp+N1hHaTrA1C/LwSJpJk0LilIUoHyN139VV+oWRLUMt6qBFf
         vUAg==
X-Forwarded-Encrypted: i=1; AJvYcCWgSqd7uD7yBovnvvHn2syO1S8CgqI5Al1asVNqdMXuuHI5rQ8M+t7UP9FSpu/InLJP5kP6Y9040i1SX7s=@vger.kernel.org, AJvYcCX3SZGYYMy8kgVJNjGQv824Nyx96U5ZMeJPjwf/MCHEs49aNyvAWIJ3nnVBwUw++ehTKI321LM9@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUwFb1cJhlsLNKOnTtBPyu3kCKr4IBpfmbQ9NTJwpQfMyFWL6
	V9S135ShFJfd/aEVnEN/H0muTRUPUAgwoLo1ecc79ihxY3L0fWiQZOmO
X-Gm-Gg: ASbGncum3GQ2RvJVJ28Xd5aLzpOGDPBBCAUU2A7NGdxunH0JWH2ecFOz1vlLpaZ4miC
	c6ivDZezq5bO0oeUQsY8DYbi+b+z8oHoGsKpO4a90ZngdoPJ63hpBT4AOFt7+q6FzmhgsMLcdnR
	/Zmyzb0uyaE4jV7hjWPcgm4WY9DXHoFcm1NPLb5N1TGvSfCrUbAWRWF5VlwaWcgOox0mMgFRyCc
	ti+WjrCBF18lXEh7VNAxx0fQlaGSgWjZU6pnncc8S3x5m5IlmADsCqwfINIBrGTERUUSWTlQyoq
	HnfVEuTIaB1viHZqnFOdRCl2yw77CPratWYMa2tEhfKG7HDbCXgT
X-Google-Smtp-Source: AGHT+IEwVSlpLWAngk97Rkk6f9tqqw8KHitjG/wYvnPczz7ua90PLOZduZQNjozIp2zMBElRWHPDkQ==
X-Received: by 2002:a17:907:3c83:b0:ade:348f:88ce with SMTP id a640c23a62f3a-adfad29a1a0mr1688028866b.12.1750239171805;
        Wed, 18 Jun 2025 02:32:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fda18sm1029449066b.92.2025.06.18.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:32:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 02:32:46 -0700
Subject: [PATCH 2/3] netpoll: extract IPv4 address retrieval into helper
 function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netpoll_ip_ref-v1-2-c2ac00fe558f@debian.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
In-Reply-To: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.ne, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2457; i=leitao@debian.org;
 h=from:subject:message-id; bh=awJPoOTDHtQmol3taNl+GEtMGRMz/y4bUY7QGAY52zc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUoe/ajQhscLM4n3n6xbkH9C3/IyKDPmrAMYuP
 QOsKZEW0oiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFKHvwAKCRA1o5Of/Hh3
 bW0dD/wLLtcW5Jl83TnIv+2C/HzUAX3hjINzT1KmcrPRgNp4ljOMAfIgg+nrbVbNFkDOPTprGne
 022EzlE9nmG0H5rxBkZuMJj13vcJ0s3CxgAN1VGt8slmx2uO/EqQRVjLzto2QxMy4wBRbOWwVDl
 ZIVW2oZnsCGYkjH/U89YjnoVqY9R0dLVrdleaTmn4dSHJgjzo3e8vV2tZbZWHknYN3fPTRlH3rV
 qSHmQ2FJuZPz2sWWqSggUfWvJyCh7o+Oup1hZiGcKp3Hdh0K8U9b8u9xgRhIyz6IKfaBBjf54aF
 RaU7kBv9IlJIrNGP/WZjKQ7CCM7jMo+85AXPyXxUoyN0CafPvpGaSAy8ul5FZOTCyZbJUTZLDA3
 8k1LTdqgF5wRQMIvlVBuEUg28SQrTkJe4YTPWrGttWoznvMjmB5jzsUyNqBw5R9DMieC+UpXDeg
 4AQ9TbeyYmkkoEqb/qCwid30UIvNTfJlo5HC58eJ1d2G3dPjHNP6eDsbFbavDbmz7QbsrQhRDT8
 9oKDm4rEstUAeVB89F+mAcAROgu0Ig84sXN0V1GqqDFapPYGGvTATfxPaVnF1sKLE+g9sAubRz1
 /9T4p6u2Fxw4jpN5X28sSMdUuyhH161cUsaY6/iXnDQAIQyqtQ+SfYhreyEfL45yd0rBqYVtlvr
 n/wIVG/baWoxHIA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move the IPv4 address retrieval logic from netpoll_setup() into a
separate netpoll_take_ipv4() function to improve code organization
and readability. This change consolidates the IPv4-specific logic
and error handling into a dedicated function while maintaining
the same functionality.

No functional changes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 473d0006cca1f..6ab494559b5c6 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -598,13 +598,41 @@ static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
 	}
 }
 
+/*
+ * Take the IPv4 from ndev and populate local_ip structure in netpoll
+ */
+static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
+{
+	char buf[MAC_ADDR_STR_LEN + 1];
+	const struct in_ifaddr *ifa;
+	struct in_device *in_dev;
+
+	in_dev = __in_dev_get_rtnl(ndev);
+	if (!in_dev) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf));
+		return -EDESTADDRREQ;
+	}
+
+	ifa = rtnl_dereference(in_dev->ifa_list);
+	if (!ifa) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf));
+		return -EDESTADDRREQ;
+	}
+
+	np->local_ip.ip = ifa->ifa_local;
+	np_info(np, "local IP %pI4\n", &np->local_ip.ip);
+
+	return 0;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
 	char buf[MAC_ADDR_STR_LEN + 1];
 	struct net_device *ndev = NULL;
 	bool ip_overwritten = false;
-	struct in_device *in_dev;
 	int err;
 
 	rtnl_lock();
@@ -644,24 +672,10 @@ int netpoll_setup(struct netpoll *np)
 
 	if (!np->local_ip.ip) {
 		if (!np->ipv6) {
-			const struct in_ifaddr *ifa;
-
-			in_dev = __in_dev_get_rtnl(ndev);
-			if (!in_dev)
-				goto put_noaddr;
-
-			ifa = rtnl_dereference(in_dev->ifa_list);
-			if (!ifa) {
-put_noaddr:
-				np_err(np, "no IP address for %s, aborting\n",
-				       egress_dev(np, buf));
-				err = -EDESTADDRREQ;
+			err = netpoll_take_ipv4(np, ndev);
+			if (err)
 				goto put;
-			}
-
-			np->local_ip.ip = ifa->ifa_local;
 			ip_overwritten = true;
-			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
 			struct inet6_dev *idev;

-- 
2.47.1


