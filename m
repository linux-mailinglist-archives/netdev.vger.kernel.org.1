Return-Path: <netdev+bounces-301198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MIk5OLumOWoJwAcAu9opvQ
	(envelope-from <netdev+bounces-301198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E521D6B2745
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:18:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=eRhm43cl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301198-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557D8300D855
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724C35DA68;
	Mon, 22 Jun 2026 21:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341A1A680A;
	Mon, 22 Jun 2026 21:18:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163119; cv=none; b=msPxMR7PxshHQQU63wcZ+IfX2qecHjPG0AZkhjUnfcqOc7QEQ0UEa1mOA+2s4s6i/OMFAHmQVnrHFZdSXpzODPf1ryfhVOZZiF6Vrj4W8g3+rtNb98jECAOAAUxciQINNNvW2D0mzz5Mlal7+GZH1I6Qc/Sb3vfHsXiIR/AV7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163119; c=relaxed/simple;
	bh=2YHuOm3D3nZpwzk5qkMI5I0CYLW2QkXe3tO15X3b22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj1aDr5/wPoFOKDPKXIRXcu37en6pm0ktatssMfsQzg3cwwHb+sdvHvsYDXqxJMU/XiXbjcC7nexai62XTUMfObVuG5q7cXDQGnVacjxxUPPF3Af3DaBX3V+GeXKdcsZzia2rG3dkMPsA6rqNclFsYUH8a2odXrPhQpGW7NUW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eRhm43cl; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RgNBQWtN3vUtaCAj9PZrfM3f29o0Zexpy8xT+zB0a90=; b=eRhm43cltEuE83Phurdds0Uy+C
	A+Y7gHCk1pocI1l3BmvmT/nGeFG0htxdWk5sTZfNv80yEJmUD98q2lx3kEC40asvCVaBBTcPTvHXH
	Foa+LanFoazvgysiyyvn4sZZ0gQJHBVTsHpqAktNHG+wC3UREY5NuJfJZweNd1Nq9GAndTNIZ97Rs
	OmNZTp6TeaqkC0upwm7I5MIs2B3EQckhkZ/KzZ7L0c3c4KSsWJNiYjYIVBTE8UI5+AO3q8LHTZFfg
	rf8Cxk4etPddkPKqJC/8NkMQemjqB4U+rQpRjIsR/zEGYohWtRyVHqILKa1bTIPI1m1d0im44AHrY
	OBn/8eow==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbm2C-00000004x8J-4A9T;
	Mon, 22 Jun 2026 21:18:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbm2D-00000004R5B-0spj;
	Mon, 22 Jun 2026 22:18:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v3 3/4] pps: Always use ktime_get_snapshot_id() for pps_get_ts()
Date: Mon, 22 Jun 2026 21:36:20 +0100
Message-ID: <20260622211822.1056437-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622211822.1056437-1-dwmw2@infradead.org>
References: <20260622211822.1056437-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301198-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[enneenne.com,infradead.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:giometti@enneenne.com,m:dwmw2@infradead.org,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jstultz@google.com,m:tglx@kernel.org,m:sboyd@kernel.org,m:mlichvar@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:agordeev@linux.ibm.com,m:dwmw@amazon.co.uk,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amazon.co.uk:email,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E521D6B2745

From: David Woodhouse <dwmw@amazon.co.uk>

A recent commit changed ktime_get_snapshot_id() to return a corrected
::systime value which takes into account the divergence of the normal
per-tick timekeeping from the ideal NTP-disciplined clock.

Rather than using that more accurate timestamp *only* in the case where
CONFIG_NTP_PPS is enabled, do so unconditionally.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/pps_kernel.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 9f088c9023b1..5eeed6695882 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -99,14 +99,12 @@ static inline void timespec_to_pps_ktime(struct pps_ktime *kt,
 
 static inline void pps_get_ts(struct pps_event_time *ts)
 {
-#ifdef CONFIG_NTP_PPS
 	struct system_time_snapshot snap;
 
 	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
 	ts->ts_real = ktime_to_timespec64(snap.systime);
+#ifdef CONFIG_NTP_PPS
 	ts->ts_raw = ktime_to_timespec64(snap.monoraw);
-#else
-	ktime_get_real_ts64(&ts->ts_real);
 #endif
 }
 
-- 
2.54.0


