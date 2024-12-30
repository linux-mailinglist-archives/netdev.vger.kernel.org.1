Return-Path: <netdev+bounces-154567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7119FEA76
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CA16140F
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685DD198A37;
	Mon, 30 Dec 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAv4wNJW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13A197A8F
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735588085; cv=none; b=H9Fv76R+JmDGnTnhxLHrgsFRv7zvjg4hT9yBcAY2FcaNbqzjw7FT6djt/NF3B18PlzR0u4XsoZIcqzIpkK7zL6NJuCwwAp4xAb3lzyGj8+QdHQZ7Iq6FYn8g1x/oZqzpqAfBlZwAkZpDn+oXDOHbNxP2Dg6dPbpgS2S/X/I+Ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735588085; c=relaxed/simple;
	bh=B3EJZ/S/esoATUjqEdl8TDYWwEgcBPsSzHzXW4OYIC8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WF4hR6Rz1D2OZnik4BbBUI7kCDJSQ4sRQZLb2XP46DSLNzQ1zUNgWBFEZLfuU7uEI7snpV7beMlw9ulOAYe9+zLyjfCWxikIJvPd4Z9ZBMjnhPu1mc6OXkwbACCE7vCrG3onTV1Mkz70+/EwCPFxWlOrM4R+2ShAI5l91wg8ftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAv4wNJW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6eeef7cb8so531538185a.2
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735588082; x=1736192882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Ry3mIuEm7lREFg97VQTiVZrVyCsSvlQWDWsMAl3ycU=;
        b=nAv4wNJWgHz5Ha7Yl3Ivu5DOlaNu0Z1c964gyC1n/Gz1/KN6hizxFZwO9IrTHntlDT
         9y74cY+V79B2mrBynsYXQKu5mnMKb/GLPG3W5Ph/tZOkaHUaAYXNtpi5QvBWB1yAtKJy
         mnttxQYGqp8vFbSydHNXv49FbveF8j0cW1cEwusufJzKM/+MJu7QXudjTahULRMd0uU5
         I/BdoN6WsEqhKrnwXbDlxwT+vQPVpgauOmnb+1LiU1orL+hPAsWjN7QREc9Ni0XvIccv
         PDV1LWE8rYjVGIVimEWiM7eOvE3VvBPdUeHqztGEZrY+9SSfh9ShN/qOnH78UjPwn1rH
         DLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735588082; x=1736192882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ry3mIuEm7lREFg97VQTiVZrVyCsSvlQWDWsMAl3ycU=;
        b=phEC3If88/V4igLrUOwo3eP3dutPaCnGBT0uWtfpK97JyjjfFT7eXSQ8HV6YxVdg8/
         mkCHbdV83PwwAq33YMw3hbTBRchQc/2zQlwPArrBwHrOsoOkHTvKHhRAUfTP9yniIhLS
         VRdLPAxKVHcDoGuMRp7X42f0eiQEtpLQclYc6yz4gzR1WS/m/1gwTRQ3zuwTwtUADwFW
         hfn1grPNKSh+ORWuqLdHr074rgYBwIuGerM6Kfxnk2DCuxQRatpQdHrUSjG0cYUmpqN+
         95+41zJ4qUtsHn9CYzXHEChcyrvDDd4VGZIYMVV/POEXRZng204AQjUhxomj0hcDRS1n
         k8yw==
X-Forwarded-Encrypted: i=1; AJvYcCWtZg+ypasquNi6grj/frWwsI0+zOKeR8S9spYygo9rs0eta4vT4c87Fhcg6wGoTkK2iVqLCu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6Mw4t3DDEnQSjjr/MsepXGf2abo0e6DfDJ31NL6sF5jF1d7j
	3LUKgLxVJDtD69PJGE6BvVl56ZvDuoF7X4zTDp6HaNjrOLJ9WDhCyfcSaWEtB/rMUFJO7Y1XNzO
	HXjYz77rtiw==
X-Google-Smtp-Source: AGHT+IHnmqWtyNlrV1Cr0Caj9omA/ZYj7wZFKf+cE9I6zDyTyJ+ATsDSfn9l3O6m3zuBhLIYGyucrzKcycH2Zw==
X-Received: from qtxz7.prod.google.com ([2002:a05:622a:1247:b0:467:64d0:3f08])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:650a:b0:7b6:d6dd:8826 with SMTP id af79cd13be357-7b9ba834079mr6738202885a.55.1735588082752;
 Mon, 30 Dec 2024 11:48:02 -0800 (PST)
Date: Mon, 30 Dec 2024 19:47:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230194757.3153840-1-edumazet@google.com>
Subject: [PATCH iproute2] tc: fq: add support for TCA_FQ_OFFLOAD_HORIZON attribute
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In linux-6.13, we added the ability to offload pacing on
capable devices.

tc qdisc add ... fq ... offload_horizon 100ms

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tc/q_fq.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tc/q_fq.c b/tc/q_fq.c
index f549be20f19f474acbc6c609bd99dbe543df48de..51a43122bd5705f9cdf59c5974e995d8bc38f245 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -32,7 +32,8 @@ static void explain(void)
 		"		[ timer_slack TIME]\n"
 		"		[ ce_threshold TIME ]\n"
 		"		[ horizon TIME ]\n"
-		"		[ horizon_{cap|drop} ]\n");
+		"		[ horizon_{cap|drop} ]\n"
+		"		[ offload_horizon TIME ]\n");
 }
 
 static unsigned int ilog2(unsigned int val)
@@ -64,6 +65,7 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	unsigned int ce_threshold;
 	unsigned int timer_slack;
 	unsigned int horizon;
+	unsigned int offload_horizon;
 	__u8 horizon_drop = 255;
 	bool set_plimit = false;
 	bool set_flow_plimit = false;
@@ -79,6 +81,7 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	bool set_horizon = false;
 	bool set_priomap = false;
 	bool set_weights = false;
+	bool set_offload_horizon = false;
 	int weights[FQ_BANDS];
 	int pacing = -1;
 	struct rtattr *tail;
@@ -155,6 +158,13 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 				return -1;
 			}
 			set_horizon = true;
+		} else if (strcmp(*argv, "offload_horizon") == 0) {
+			NEXT_ARG();
+			if (get_time(&offload_horizon, *argv)) {
+				fprintf(stderr, "Illegal \"offload_horizon\"\n");
+				return -1;
+			}
+			set_offload_horizon = true;
 		} else if (strcmp(*argv, "defrate") == 0) {
 			NEXT_ARG();
 			if (strchr(*argv, '%')) {
@@ -333,6 +343,9 @@ static int fq_parse_opt(const struct qdisc_util *qu, int argc, char **argv,
 	if (set_weights)
 		addattr_l(n, 1024, TCA_FQ_WEIGHTS,
 			  weights, sizeof(weights));
+	if (set_offload_horizon)
+		addattr_l(n, 1024, TCA_FQ_OFFLOAD_HORIZON,
+			  &offload_horizon, sizeof(offload_horizon));
 	addattr_nest_end(n, tail);
 	return 0;
 }
@@ -348,6 +361,7 @@ static int fq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt
 	unsigned int orphan_mask;
 	unsigned int ce_threshold;
 	unsigned int timer_slack;
+	__u32 offload_horizon;
 	unsigned int horizon;
 	__u8 horizon_drop;
 
@@ -487,6 +501,14 @@ static int fq_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *opt
 			print_null(PRINT_ANY, "horizon_drop", "horizon_drop ", NULL);
 	}
 
+	if (tb[TCA_FQ_OFFLOAD_HORIZON] &&
+	    RTA_PAYLOAD(tb[TCA_FQ_OFFLOAD_HORIZON]) >= sizeof(__u32)) {
+		offload_horizon = rta_getattr_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
+		print_uint(PRINT_JSON, "offload_horizon", NULL, offload_horizon);
+		print_string(PRINT_FP, NULL, "offload_horizon %s ",
+			     sprint_time(offload_horizon, b1));
+	}
+
 	return 0;
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


