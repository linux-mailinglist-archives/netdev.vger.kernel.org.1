Return-Path: <netdev+bounces-109327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB83927F70
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828AC284F97
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1C647;
	Fri,  5 Jul 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZqxcC2os"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67957367
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720140293; cv=none; b=GyWlgwZbF98B2WQdJoMnBYSkgmRVws2UbQFjYG+zuQuH/pw06thk0W4xOBtPr/MvUGMDhgJRDS++Q/i51On0DLqAAroqFLLslVrHkTpG7BLRGZJZlKEiSKyDTUjRwY6B56fI6Ys9oKB1hLXqqumoWJFxkztVnk/Wp1b5jiZqOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720140293; c=relaxed/simple;
	bh=bwqn45eQp/JKkEZzRXiMYTeNkqrs+lwZm7J6+o6qIXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsStfAEjitUiQesMOY02PJ/IoRyVCalROBrToPAHyL7FRccsrS/mr3bxgGxfeAqEf+GuCvc0q39P91z5bHD+Y5UMCdGoQiC6dZnERi+8CJpzPZm3+B1eMqn1slLUPaeG/CdYHDSYSo4YcelL9XSR8KYpkZNGXNjuj/m0duYJqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZqxcC2os; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso6771485ad.3
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720140291; x=1720745091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SDxHgB2akBM9zqPaOczwdeGE1mqZy5oEjHRuYHglh8=;
        b=ZqxcC2osgtRf1G3UZmOfNU9s9Q45wR4wkF4O+uQZZf0LlMsbNo9BoAyaIhM7BTeWl+
         7lahGmQOry+omvpvm7Gy95LvBcs5xC2cNS2/ZGAbhGKssmX7gevggFOmotQiP/KLHJYI
         uyJhvnniHyuyHGAuFuqZSl/J8jMEhlDs67k+XVgM8nARoL5R+Rd853+Wms58tC9gYrKS
         ih5bJznJ5gA2Nzpj69MVqb9RgVxB89zc6Tq37shZ17+6k8U7t8BMEQKm8v7/kEKl3qxN
         uoMKmlSQ5/7xAEm+gcyWjtdtblfnjd66pnwtiDPbsiv1z1D+xXEe1MM9iH7Ox12ckFPU
         +A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720140291; x=1720745091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SDxHgB2akBM9zqPaOczwdeGE1mqZy5oEjHRuYHglh8=;
        b=TBRBoZJeCvgIpigH+WQHakHj14QdhpxTik8Qiw7V3W50SPY/luLALmFrxD2MWkWdJ+
         P56FJbaLgGNQ2zw58oJ4216T6vHGtPPGz2p7u9aOJZEl/IH+N0bTNGY+BwBJIcqngYMM
         7gsn+5XuET6eR7OpTlokmifaOiPIX+PAPd0qfzyakt4Ul9J8CCG+XPdA0Z2oa3AcjPCJ
         ZSth4QTKKqNledByEE+/cwmQGV9BNrcrXWZRlQSgj9yVV8VgeThbU5rwksekXSfgioSc
         6bdsLdXyvN4LiCaqXRtey3C6oHzPSKM+wWoSUPAIX9x3zz1DQ2PrPG2TaaWq1srdl8w/
         SsmQ==
X-Gm-Message-State: AOJu0Yz3b9BTTmU0GjHWF/oWvmhZWWiupGI3i/uuVreU8dUf7mKz07IX
	M5KaCbYUzhVxEfl6nTPC44KipWI0D9CA9aK+v3zHluKHFQd2/RFaXiqCXeXfZZuRK72BmdCqXvX
	6INk=
X-Google-Smtp-Source: AGHT+IHQAnbVAKw0rJ28CiVAQTCjB3B89yNAnSeNJKCjDTlQzeSJyiKVM5cuwbYOPjPubvjzg+0NWQ==
X-Received: by 2002:a17:902:e5d1:b0:1fa:ff88:8942 with SMTP id d9443c01a7336-1fb33df58e6mr22204395ad.1.1720140290646;
        Thu, 04 Jul 2024 17:44:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8c52sm128645245ad.112.2024.07.04.17.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:44:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Subject: [PATCH iproute] route: filter by interface on multipath routes
Date: Thu,  4 Jul 2024 17:44:19 -0700
Message-ID: <20240705004440.186345-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ip route command would silently hide multipath routes when filter
by interface. The problem was it was not looking for interface when
filter multipath routes.

Example:
	ip link add name dummy1 up type dummy
	ip link add name dummy2 up type dummy
	ip address add 192.0.2.1/28 dev dummy1
	ip address add 192.0.2.17/28 dev dummy2
	ip route add 198.51.100.0/24 \
		nexthop via 192.0.2.2 dev dummy1 \
		nexthop via 192.0.2.18 dev dummy2

Before:
ip route show dev dummy1
192.0.2.0/28 proto kernel scope link src 192.0.2.1

After:
ip route show dev dummy1
192.0.2.0/28 proto kernel scope link src 192.0.2.1
198.51.100.0/24
	nexthop via 192.0.2.2 dev dummy1 weight 1
	nexthop via 192.0.2.18 dev dummy2 weight 1

Reported-by: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iproute.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index b5304611..44666240 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -154,6 +154,24 @@ static int flush_update(void)
 	return 0;
 }
 
+static bool filter_multipath(const struct rtattr *rta)
+{
+	const struct rtnexthop *nh = RTA_DATA(rta);
+	int len = RTA_PAYLOAD(rta);
+
+	while (len >= sizeof(*nh)) {
+		if (nh->rtnh_len > len)
+			break;
+
+		if (!((nh->rtnh_ifindex ^ filter.oif) & filter.oifmask))
+			return true;
+
+		len -= NLMSG_ALIGN(nh->rtnh_len);
+		nh = RTNH_NEXT(nh);
+	}
+	return false;
+}
+
 static int filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 {
 	struct rtmsg *r = NLMSG_DATA(n);
@@ -310,12 +328,15 @@ static int filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 			return 0;
 	}
 	if (filter.oifmask) {
-		int oif = 0;
+		if (tb[RTA_OIF]) {
+			int oif = rta_getattr_u32(tb[RTA_OIF]);
 
-		if (tb[RTA_OIF])
-			oif = rta_getattr_u32(tb[RTA_OIF]);
-		if ((oif^filter.oif)&filter.oifmask)
-			return 0;
+			if ((oif ^ filter.oif) & filter.oifmask)
+				return 0;
+		} else if (tb[RTA_MULTIPATH]) {
+			if (!filter_multipath(tb[RTA_MULTIPATH]))
+				return 0;
+		}
 	}
 	if (filter.markmask) {
 		int mark = 0;
-- 
2.43.0


