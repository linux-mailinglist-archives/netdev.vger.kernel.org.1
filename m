Return-Path: <netdev+bounces-77590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177768723A0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77F5287CA6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD312B16B;
	Tue,  5 Mar 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLrvxvWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD04128801
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654691; cv=none; b=XdHACwmDlrPLZaQmKrWS9sEwMpV1MOLNY0GmiqVplBaAxCW7wQcBzlWkbpHI4Fi1Lfi+3/xhdwOdpMDGn5LQOF+cyi0YsXUowtKJBmhqHrLd+KG9ETPLaBk+B7QbRzvRFHmwf+lRqlyXyIk6DTYP7SOKkYRzvMlOKKB/bLieueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654691; c=relaxed/simple;
	bh=gvy+5YrH62b/erUFJ2UXKwPrjN6eRVv04Yn7bkAJCdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pd2S1ezb+b5UVZHjUMEUlKWTy2I4bOLXvaon37p2yo0QDhpVFszRBhsO0Qulo9Z+3x4WH9O4dVojq9r2hcsK9uAqEyE2HiJazZVeb1XSET9aqc2037qHhS3RNZ2Puga1BjuWWyDzgLX6mtDpNzSPQWsqs24j/It/PgTHZ6LDcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLrvxvWI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso9809142276.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654675; x=1710259475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPkfSDEDaD+ot1oycTy547baCEwC3QtbZqcPHtahwi0=;
        b=SLrvxvWIi1doFSzEpeZWC7Z9BAZ6q7E8SQRdFoqKsfRWD//L8u14lrq7llC4uTAzFg
         oh9c+Oy2eI/grlfyU0MR2E3aydXtalDZDQL37q2rYHroTTJa6UQLvUCuw7g2wz7i2b2h
         XdrKE7gbxEWMS7Ij8FSLuZSxwbLMULPDRGoSTXUhQZOYaB1x5KHRVg2+ln3cQSIa6O8d
         +UJZkHisqTLzaKXdSX2GQ+g/BvTV7BwkbQEmYr5VfSrmkI3FHKOlvFV0f5NTHxIPiEdP
         8XnyZmTKzMQj9YsFLywhXg0mt9m0g73eKfgkfO2prQbmL6BAWmxDtdcIjbgdujLoujd+
         6osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654675; x=1710259475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPkfSDEDaD+ot1oycTy547baCEwC3QtbZqcPHtahwi0=;
        b=XV5lF1aU4g5dOuEpO126MxOU8T/Zpiy/rytEd4wQQfcA3arA0/qGAVEPVonjQ388Pm
         Jrme3b4ForaPUf29xnOqxI9/on9xRWVorrQM2aKMQIe7/ZPBlFFdGUBc7LZ/QS5jYmCp
         ix9BjhQfFbPw/E396CGsj5wIWxBAPgra9PUbviJgF5mItSghn5YDvkt/mjjF0XCNC8hZ
         XpJe+7uEROYjFyLlcXuW+51xnUbojmcvqXyzdQeoougAn4t+z8buHfdy/bJwo8WBwqEZ
         GEnMEl7utiqi9rHVejahnWIoXf32SZxfrWLGfTdsu2bmRMOoo2hIgVnGqljuQoBqMJZc
         zwaQ==
X-Gm-Message-State: AOJu0Yze3kBhF+SEK3/qglLxFrrIkU7JxyUYPMfROLGxw3Q4h6b4cf0J
	1oHG0QHokcveoBj9sC0rp+7yeJn2m44hVDP/n8gD+faw1IEbn7ZUN01bPGtbSlHNrMMts6Oukeg
	qdTMYLmUOlw==
X-Google-Smtp-Source: AGHT+IEDdaYTVAMn+9+o9ytS/uLNGtu5wGyDYhiNG1kONQkuPsByYt6TD8z4jfHVOwAm9UGpCcoQvb26418UAA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dcc:41ad:fb3b with SMTP
 id v1-20020a056902108100b00dcc41adfb3bmr475163ybu.10.1709654675207; Tue, 05
 Mar 2024 08:04:35 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:08 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-14-edumazet@google.com>
Subject: [PATCH net-next 13/18] inet: move tcp_protocol and udp_protocol to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are read in rx path, move them to net_hotdata
for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h |  2 ++
 net/ipv4/af_inet.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 97617acb75e1f2141fe7170d93c06f9813c725a3..4d1cb3c29d4edfbc18cf56c370a1e04e5fcb1cbd 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -11,7 +11,9 @@ struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
 	struct net_offload	tcpv4_offload;
+	struct net_protocol	tcp_protocol;
 	struct net_offload 	udpv4_offload;
+	struct net_protocol	udp_protocol;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct packet_offload	ipv6_packet_offload;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 08dda6955562ea6b89e02b8299b03ab52b342f27..6f1cfd176e7b84f23d8a5e505bf8e13b2b755f06 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1751,19 +1751,6 @@ static const struct net_protocol igmp_protocol = {
 };
 #endif
 
-static const struct net_protocol tcp_protocol = {
-	.handler	=	tcp_v4_rcv,
-	.err_handler	=	tcp_v4_err,
-	.no_policy	=	1,
-	.icmp_strict_tag_validation = 1,
-};
-
-static const struct net_protocol udp_protocol = {
-	.handler =	udp_rcv,
-	.err_handler =	udp_err,
-	.no_policy =	1,
-};
-
 static const struct net_protocol icmp_protocol = {
 	.handler =	icmp_rcv,
 	.err_handler =	icmp_err,
@@ -1992,9 +1979,22 @@ static int __init inet_init(void)
 
 	if (inet_add_protocol(&icmp_protocol, IPPROTO_ICMP) < 0)
 		pr_crit("%s: Cannot add ICMP protocol\n", __func__);
-	if (inet_add_protocol(&udp_protocol, IPPROTO_UDP) < 0)
+
+	net_hotdata.udp_protocol = (struct net_protocol) {
+		.handler =	udp_rcv,
+		.err_handler =	udp_err,
+		.no_policy =	1,
+	};
+	if (inet_add_protocol(&net_hotdata.udp_protocol, IPPROTO_UDP) < 0)
 		pr_crit("%s: Cannot add UDP protocol\n", __func__);
-	if (inet_add_protocol(&tcp_protocol, IPPROTO_TCP) < 0)
+
+	net_hotdata.tcp_protocol = (struct net_protocol) {
+		.handler	=	tcp_v4_rcv,
+		.err_handler	=	tcp_v4_err,
+		.no_policy	=	1,
+		.icmp_strict_tag_validation = 1,
+	};
+	if (inet_add_protocol(&net_hotdata.tcp_protocol, IPPROTO_TCP) < 0)
 		pr_crit("%s: Cannot add TCP protocol\n", __func__);
 #ifdef CONFIG_IP_MULTICAST
 	if (inet_add_protocol(&igmp_protocol, IPPROTO_IGMP) < 0)
-- 
2.44.0.278.ge034bb2e1d-goog


