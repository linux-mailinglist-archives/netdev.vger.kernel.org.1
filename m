Return-Path: <netdev+bounces-302397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JV6uC5omQWpnlgkAu9opvQ
	(envelope-from <netdev+bounces-302397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721306D3EE4
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 15:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=VTJjVKmm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302397-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39BBA300D44E
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23523A9D80;
	Sun, 28 Jun 2026 13:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6A3A9852
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 13:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654614; cv=none; b=Cmpf9oK3n8jfi8vV1Cpmvd5JlgA2A2/y53eYbfyn0mDkqvkkttHepn0QLaIxAkUvgFO79cJ4JsJEgo6zQjPimKNiFooBO8F5fjP3xygZp6ssLq7ube3Wc4d9CPDwPb+uLQsOyx9lGI9VpM51GYjCo0aGq6AsSRW0snMCYA+y7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654614; c=relaxed/simple;
	bh=V5je7SYtnk6tpa19PhDxtt7bEBHEd5JtpSi3Ezx4M5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qK3OzdqCJp6lS9kn7Sr0qjdn773IFMMApLXW2TUeLJrBgLQduz8YYNWTIrUA9fzQ9wLWKx0RxUVvFy4zEmqZ15lUPp4Vdv3PiZaGW4MFGrt0NSqu4QY42UF7qlBTfhH0/rKqncCENmlXot4MRL3AvbXkUTYdSJzfqYjG8c+m8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VTJjVKmm; arc=none smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51a84669e39so14878601cf.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782654610; x=1783259410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC7YWFgG8s0ZS0kr/L0v2U1662wVxJse38QyJ39OVeY=;
        b=VTJjVKmmNlSb4IpbK8pZDG65FUep09xcRvW7LkDWKm8lf6+f0bC03dijRTFnaWtLNg
         hetnOiUG2h3GVt57Gcibb/SMVa7padYkLZbZyQcWgsZVAKvErQ/epUv9K245TIv9QII6
         zAkZX6GQc4L4pH+UIVNSUf9pOfjYPzKxO7o3AZnSqlLXETe426RrG9Syq9SjXjPV4y1l
         QGdXKYGk9K618aGZ9oFK0ebhxgp0BXFRZsLWTwZKyKjJ8TWKePvlbeudmdlD6X80O33a
         a1TKM+R6vE6y/6ilg70wvylXi+YNoAogExZmKAc72UTbeL0OnbwXChBrzQviR90nx0DX
         ulwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782654610; x=1783259410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC7YWFgG8s0ZS0kr/L0v2U1662wVxJse38QyJ39OVeY=;
        b=QHD3A7Z10PoTAosgcauro6gWvf5izq4rZHu8QMmQvtbLtTe5v8/u9coAGJN1OqlYMF
         IfmPcCyAkGsEn8BIYwZRJcdPf1ZgjKo0C8iqdfpkeGCGISBDrRI4xdcP3tqD/+DJZLoQ
         DNNVC/pc2S85pyCsEGR3ssQrw58wqXqYYdgsxUUGmGRt/e7vDY7uevOwkiJ247SeQzLm
         MbR6PCDMu5o1PErPRua0jg1f8FFtEJtU93LGCxFW2JGT1MV1+m/2k8JYYsr5MeWCMW5K
         TtY0pGEfWv4k79zb9cQIUeA0bcCNyB/SNn0NPNXhMM4SsyDNI/aV8azWsBizqf1QYPXR
         fVDw==
X-Forwarded-Encrypted: i=1; AFNElJ/NAR6ajklwMUQI2VXAIXABdy5UENEW3jhnawms4OcmCrSl8ajiChxU04cnrhUI16wHjPuMLKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWeG7PU1e6mfK57q0Q237BehAWIgO+9CeswWRYEUdYz2EgaUs
	T7t66NaXwHlzIIePnQBzk/X+e9Bjz8wKmgYpAmbs5N8DFNNcIUjBsfazV/X7hSFFqFA=
X-Gm-Gg: AfdE7ck7KSFqOGsVNtOlnGqYLggw2IdzwchvPVtWexTYck3+2bH/BggiCsHD4Nlx4pu
	/hUrG6pEEVWQrRh4w45A9B16BMMOUZEZD6IycDONi1dYAXZ6kEe//80uTlITjEslT8pRzJKNIu+
	qY/0/5wa/ZGFCD17Cq29YsaxqEWfL6T8b7RoJ2Y/l5JdPcIiIsGjJT3E1yGZPDIPrWdZGw+Fs1v
	yiFtioiC5lWZkNgimoXGnVrWwQzoe+2H+/6+p/omuaDbxbeFwAGdcotHVP34K3j7X/XYcHhsbr3
	nHTqOmf4MqtkJDz51stTgKwPX8y7RSszPEo7VwA+GWsJP0qKcir5MyQozCL/h8j+ciflKioUTga
	hN/w/WOJDRiqQbHBowXZ9EGNsDjaYDKe+H9esrCOEHIHvWe+Fg2KIdOomHRK+uyI9Qd7jnd+rAj
	Dev+7kUG1E4PGOQSRQ
X-Received: by 2002:ac8:5947:0:b0:51b:faa3:f3d with SMTP id d75a77b69052e-51bfaa316ecmr6157601cf.60.1782654610447;
        Sun, 28 Jun 2026 06:50:10 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51a51a9bca9sm146341991cf.19.2026.06.28.06.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 06:50:08 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Olga Albisser <olga@albisser.org>,
	Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>,
	Henrik Steen <henrist@henrist.net>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] net/sched: dualpi2: clear stale classification on filter miss
Date: Sun, 28 Jun 2026 13:48:47 +0000
Message-ID: <20260628134846.2211556.3eb480ed8de5.dualpi2-filter-no-match@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302397-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:olga@albisser.org,m:koen.de_schepper@nokia-bell-labs.com,m:henrist@henrist.net,m:olivier.tilmans@nokia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 721306D3EE4

DualPI2 leaves previous classification state attached to an skb when
filter classification returns no match.  The enqueue path can then act
on stale state from an earlier classification attempt.

A filter miss should fall back to the default class without reusing old
per-packet classification data.

Initialize the classification result to CLASSIC before running the
classifier.  Explicit L4S, priority, and successful filter
classification can still override that default.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v3:
  - Improve readability
Changes in v2:
  - Add fixes tag

 net/sched/sch_dualpi2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 5434df6ca8ef..27088760eff4 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -346,6 +346,8 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 	struct tcf_proto *fl;
 	int result;
 
+	cb->classified = DUALPI2_C_CLASSIC;
+
 	dualpi2_read_ect(skb);
 	if (cb->ect & q->ecn_mask) {
 		cb->classified = DUALPI2_C_L4S;
@@ -359,10 +361,8 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 	}
 
 	fl = rcu_dereference_bh(q->tcf_filters);
-	if (!fl) {
-		cb->classified = DUALPI2_C_CLASSIC;
+	if (!fl)
 		return NET_XMIT_SUCCESS;
-	}
 
 	result = tcf_classify(skb, NULL, fl, &res, false);
 	if (result >= 0) {
-- 
2.43.0


