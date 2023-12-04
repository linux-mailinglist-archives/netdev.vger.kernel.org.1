Return-Path: <netdev+bounces-53416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D698B802E68
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF361F210BB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6436182CE;
	Mon,  4 Dec 2023 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3tSx+fT1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A4103
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:19:22 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so55530787b3.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701681562; x=1702286362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFg20Zy13bAgrk38a7PgG5Nr6pvQ5q4+zvqB6YL75Fc=;
        b=3tSx+fT15PRvaPcPcBEd8t5hmimt9kpMFIat+MYHncjnb+DR5n1jMiYZ/wPO+NpxW4
         fkPTb9hfh4WVcKINdMIT7/0iM8tK5GRXlum8O67ZaL53nl8tUyojMwhbbwhwu+OTBg4M
         5W7JsRA6Iy6ol3lNDd35lAJiCctDGC9mLRCUxynPRopKj81qTVFV2XFt3NQRops4MEdf
         42fs3IqbbUTQ6pL/Npm/fQJ/EUmNT/lTD8gwUzFFxoCXTFw9pQaEDxzDTVdeVsxtjTKM
         OMhlKXR3yqRLs0nsg/Dtw7jh4/Zfzc8KjN6OwQGhM0a4KycyH1ccgLaW+4G4dTBsTHp2
         Hz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681562; x=1702286362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFg20Zy13bAgrk38a7PgG5Nr6pvQ5q4+zvqB6YL75Fc=;
        b=rqVLvWLBynPWOHf4uMQgKDG1dUui4Q7AcExlVGRpAQwCq4aHGeoSSE89E0tBn0AQDQ
         2Xg6R92yLx8wcPSjBIPiCKophE2o52A6yAg9lXoeag4rpTGdkqOvcMI9srEajVcIUWJm
         FXOkNyaKjZpQ/34+Y91ov/Qp4bc339BKD0cWLYLLbNO2OmWqrOoF3VAK5w/qGtgcnNDP
         5lkUN5PSWEoeEl4VcGPyzBImQCIt+QTVXdQTT24vJHzT6LLdphDLY6sR1PlxauqUgW4z
         G4D1DDys697BMU7SNzshX3+xJrber1uhSwMpCvQWWqob9aI7cBWZyPidnYzTQIANhTli
         QTdw==
X-Gm-Message-State: AOJu0YxyHSl+kZBIMuQdk2qJfM4BjofMNlC/zNFLrKKUD+q0eD1MVC6I
	qIcDaU6gNOuZIeoo+ExvFO+A+zgXvUKArA==
X-Google-Smtp-Source: AGHT+IETYcv4LOI9JTJcqt2tMl2k7AyOIsQAKRz/uysBVqAwY4TawBmAzIcu8v6zJlMcbvdT0QEDn4sqZP2kxA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:74c4:0:b0:db5:4692:3aaf with SMTP id
 p187-20020a2574c4000000b00db546923aafmr279732ybc.6.1701681561857; Mon, 04 Dec
 2023 01:19:21 -0800 (PST)
Date: Mon,  4 Dec 2023 09:19:11 +0000
In-Reply-To: <20231204091911.1326130-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204091911.1326130-6-edumazet@google.com>
Subject: [PATCH iproute2 5/5] tc: fq: reports stats added in linux-6.7
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Report new fields added in linux-6.7:

- fastpath        : Number of packets that have used the fast path.
- band[012]_pkts  : Number of packets currently queued per band.
- band[012]_drops : Counters of dropped packets, per band
                    (only printed if not zero)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tc/q_fq.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tc/q_fq.c b/tc/q_fq.c
index 08bfbf4ef6db1838bca87d1d87d6923255a1a4f6..7f8a2b80d441857ecadc19ea77545092b7f4f02f 100644
--- a/tc/q_fq.c
+++ b/tc/q_fq.c
@@ -510,6 +510,10 @@ static int fq_print_xstats(struct qdisc_util *qu, FILE *f,
 	print_uint(PRINT_ANY, "throttled", " throttled %u)",
 		   st->throttled_flows);
 
+	print_uint(PRINT_ANY, "band0_pkts", " band0_pkts %u", st->band_pkt_count[0]);
+	print_uint(PRINT_ANY, "band1_pkts", " band1_pkts %u", st->band_pkt_count[1]);
+	print_uint(PRINT_ANY, "band2_pkts", " band2_pkts %u", st->band_pkt_count[2]);
+
 	if (st->time_next_delayed_flow > 0) {
 		print_lluint(PRINT_JSON, "next_packet_delay", NULL,
 			     st->time_next_delayed_flow);
@@ -522,6 +526,10 @@ static int fq_print_xstats(struct qdisc_util *qu, FILE *f,
 	print_lluint(PRINT_ANY, "highprio", " highprio %llu",
 		     st->highprio_packets);
 
+	if (st->fastpath_packets)
+		print_lluint(PRINT_ANY, "fastpath", " fastpath %llu",
+			     st->fastpath_packets);
+
 	if (st->tcp_retrans)
 		print_lluint(PRINT_ANY, "retrans", " retrans %llu",
 			     st->tcp_retrans);
@@ -544,7 +552,10 @@ static int fq_print_xstats(struct qdisc_util *qu, FILE *f,
 			     st->flows_plimit);
 
 	if (st->pkts_too_long || st->allocation_errors ||
-	    st->horizon_drops || st->horizon_caps) {
+	    st->horizon_drops || st->horizon_caps ||
+	    st->band_drops[0] ||
+	    st->band_drops[1] ||
+	    st->band_drops[2]) {
 		print_nl();
 		if (st->pkts_too_long)
 			print_lluint(PRINT_ANY, "pkts_too_long",
@@ -562,6 +573,18 @@ static int fq_print_xstats(struct qdisc_util *qu, FILE *f,
 			print_lluint(PRINT_ANY, "horizon_caps",
 				     "  horizon_caps %llu",
 				     st->horizon_caps);
+		if (st->band_drops[0])
+			print_lluint(PRINT_ANY, "band0_drops",
+				     " band0_drops %llu",
+				     st->band_drops[0]);
+		if (st->band_drops[1])
+			print_lluint(PRINT_ANY, "band1_drops",
+				     " band1_drops %llu",
+				     st->band_drops[1]);
+		if (st->band_drops[2])
+			print_lluint(PRINT_ANY, "band2_drops",
+				     " band2_drops %llu",
+				     st->band_drops[2]);
 	}
 
 	return 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog


