Return-Path: <netdev+bounces-53415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D2802E67
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A83280F12
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B01803D;
	Mon,  4 Dec 2023 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/fOZX8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E9F2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:21 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so59403997b3.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681560; x=1702286360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dH7fxg7s8g2U4VGI4/VngLAD7JuHHoX+b6vwZarf2yU=;
        b=H/fOZX8zjZWZXKD6l73T8JpwgcRejPDiBfk7h5nUWn0+cbD/vH7roNLKhcXqpZSOvk
         ZAtL/IFHvCJ3yx2lkn5FRMXqdlOnPwM0Jd2aNMtOBpQdjRAFc66N+8/7HKBLPdc7/Wm8
         2M7m5gLIpt5atcP8UqeO+/Yt7srEKhHYWhpcHsK1NrOTYqOrv2HbdMI5pteKTDM6iLZm
         8uxCsMJqbqeltveu5q09lL/c9OteZq4CUf7P93lBcjzcUPqwPCptnRhKhCy51wym0j6q
         K3Y0l55VU3O1CMA00sc+/VB8hxMTc4AsdTbZx15hEg0IpqfxJMn2DUhPzvbynSuL8xG+
         GZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681560; x=1702286360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH7fxg7s8g2U4VGI4/VngLAD7JuHHoX+b6vwZarf2yU=;
        b=MAlU8x6K0iMW9+IvS2tDRsgnac+Vyv4qoskw8OYhmWfVIKeD1beGzfrNZGsRxlNqEe
         O4DsDOF8xd/Bbp9i8I3KwtlKMok9UYtMYAp0Yd19eJBHsFDW4Nx9mxqg6Rn5OFh92AVG
         ENvWByv7n6diaNpM8S+TfNfH87ZJ0wVtWCI/FKeW5lc5cCI9f75B75oEKfnrFrbxoIv4
         cZYUr8MVVz/Vct+RA5GE5E3olDfSYbQu6U85cQ1v5UbNg8w7Y8vdkZKK+xQeHAvP8wVJ
         qsyBQuDVKVSrORiOGYXJ11hcUyuAH5ZvBAbXUqvSK4GLPzhbtvXc21nMWaezAFvXVXt6
         Rnrg==
X-Gm-Message-State: AOJu0YxEKktXlficNHXcG4eTJc5oGV0YR4sfIUGJC77hqKP7dHvq3bWg
	C2ZHceZj1hRRxCD8cILIYTjJQt7/LhhkUw==
X-Google-Smtp-Source: AGHT+IE0p4snC4sZNnR6cmilH2yI0R8HuTWHBWeJ+Oav45VHpypAhVLOjOxPJ3hVVWIe2gh5e5MTOJsUpimlCg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:989:b0:5d3:e8b8:e1fe with SMTP
 id ce9-20020a05690c098900b005d3e8b8e1femr312707ywb.0.1701681560244; Mon, 04
 Dec 2023 01:19:20 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:10 +0000
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-5-edumazet@google.com>
Subject: [PATCH iproute2 4/5] tc: fq: add TCA_FQ_WEIGHTS handling
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Linux-6.7 FQ got WRR scheduling.

TCA_FQ_WEIGHTS attribute can report/change per-band weights.

tc qdisc show dev eth1
...
qdisc fq ... weights 589824 196608 65536 quantum 8364b ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tc/q_fq.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tc/q_fq.c b/tc/q_fq.c
index d6f724569932906515cd012d4d7f815966523934..08bfbf4ef6db1838bca87d1d87d6923255a1a4f6 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -26,6 +26,7 @@ static void explain(void)
 		"		[ maxrate RATE ] [ buckets NUMBER ]\n"
 		"		[ [no]pacing ] [ refill_delay TIME ]\n"
 		"		[ bands 3 priomap P0 P1 ... P14 P15 ]\n"
+		"		[ weights W1 W2 W3 ]\n"
 		"		[ low_rate_threshold RATE ]\n"
 		"		[ orphan_mask MASK]\n"
 		"		[ timer_slack TIME]\n"
@@ -77,6 +78,8 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	bool set_timer_slack = false;
 	bool set_horizon = false;
 	bool set_priomap = false;
+	bool set_weights = false;
+	int weights[FQ_BANDS];
 	int pacing = -1;
 	struct rtattr *tail;
 
@@ -238,6 +241,33 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				prio2band.priomap[idx] = band;
 			}
 			set_priomap = true;
+		} else if (strcmp(*argv, "weights") == 0) {
+			int idx;
+
+			if (set_weights) {
+				fprintf(stderr, "Duplicate \"weights\"\n");
+				return -1;
+			}
+			NEXT_ARG();
+			for (idx = 0; idx < FQ_BANDS; ++idx) {
+				int val;
+
+				if (!NEXT_ARG_OK()) {
+					fprintf(stderr, "Not enough elements in weights\n");
+					return -1;
+				}
+				NEXT_ARG();
+				if (get_integer(&val, *argv, 10)) {
+					fprintf(stderr, "Illegal \"weights\" element, positive number expected\n");
+					return -1;
+				}
+				if (val < FQ_MIN_WEIGHT) {
+					fprintf(stderr, "\"weight\" element %d too small\n", val);
+					return -1;
+				}
+				weights[idx] = val;
+			}
+			set_weights = true;
 		} else if (strcmp(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -300,6 +330,9 @@ static int fq_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 	if (set_priomap)
 		addattr_l(n, 1024, TCA_FQ_PRIOMAP,
 			  &prio2band, sizeof(prio2band));
+	if (set_weights)
+		addattr_l(n, 1024, TCA_FQ_WEIGHTS,
+			  weights, sizeof(weights));
 	addattr_nest_end(n, tail);
 	return 0;
 }
@@ -365,6 +398,16 @@ static int fq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
 			print_uint(PRINT_ANY, NULL, "%d ", prio2band->priomap[i]);
 		close_json_array(PRINT_ANY, "");
 	}
+	if (tb[TCA_FQ_WEIGHTS] &&
+	    RTA_PAYLOAD(tb[TCA_FQ_WEIGHTS]) >= FQ_BANDS * sizeof(int)) {
+		const int *weights = RTA_DATA(tb[TCA_FQ_WEIGHTS]);
+		int i;
+
+		open_json_array(PRINT_ANY, "weights ");
+		for (i = 0; i < FQ_BANDS; ++i)
+			print_uint(PRINT_ANY, NULL, "%d ", weights[i]);
+		close_json_array(PRINT_ANY, "");
+	}
 	if (tb[TCA_FQ_QUANTUM] &&
 	    RTA_PAYLOAD(tb[TCA_FQ_QUANTUM]) >= sizeof(__u32)) {
 		quantum = rta_getattr_u32(tb[TCA_FQ_QUANTUM]);
-- 
2.43.0.rc2.451.g8631bc7472-goog


