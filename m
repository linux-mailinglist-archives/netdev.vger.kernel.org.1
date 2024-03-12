Return-Path: <netdev+bounces-79579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4B879F22
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25FF31C21D2F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B84205A;
	Tue, 12 Mar 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="gLZL5uqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFD2EAF7
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284110; cv=none; b=K300+nP5LDkwdBNjipnAdOHSPpUhLsi3PnD6MFzJQrOAMTMsrASAyW6qRXPt0vnPOXkKTukVcRqDMubLMWhbdHXOoBVF5PbkTYavgIsXfbJCh9f77lreCt0gGkOMfxOv3rtjlstACkO7YA3mONv4Wss1gy8VVbnm94Syz7+Y31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284110; c=relaxed/simple;
	bh=svRJEBM+C3QE064pQ/pEML8YbGL/qqMDURCpWAG8Mz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDD8gt2z+d4NLTqg7HrFaLOlK0FA7m17ZTh0aER77LDYDK8O6TDZcUa5TwvuNJ4qSR1QACx9HdEIYaUAYUJN4ZYS8ELoU4TBC5B7ErmGEXQpGVbTZxqoLQDEER4r5jyfCrY7ljER7vcektGp1m0AxhfgZLxJRgL6sbabWi7ybS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=gLZL5uqb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29c09ee1bceso2036875a91.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284108; x=1710888908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ib/pb+kLOd5ocoVhOz3+USGBF+/XkIcYOjmle2ItM4=;
        b=gLZL5uqbxtOYm+eQxnqUzQG7w7gvwiPIw9xYmQww2PSMKGvyoOrMuF9eZQhHh1Jp/K
         jREAEf+Kro5gRL9nW2IgP6LA/6u15WmepjYnkjeK3fVW+60xk6ROEtR1QH46PISaDyww
         mi3DaZjymviouq7+E601aJqeNYebPORhcnzIxHiYPK3Q9nvVzndGU74hbl9FTuwxGoVs
         4XX1FdNJpc31wG5ONg/Jdh5kSPkXvkbeu6ucioqj/YQ7wJNPOK6tLGU2LtWt2nLFCvvr
         ORps+q5dGCbFwkEYU1U92OJFf5fC2JHuvuljuTDlEfyMbrBajBfGO0al9DjmPA09SlO7
         L3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284108; x=1710888908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ib/pb+kLOd5ocoVhOz3+USGBF+/XkIcYOjmle2ItM4=;
        b=aelo9Zb6KRMopSEg9+2LzOYXt/cMi4FqAKWKePXtmDM1KaR7D4K9GcZYMGkqlfoMEM
         v2E/KlR/OCrUF1XsHS7CqaASJBUbqKIRtNKgNhxc6crwrdaRHrJlFOAVHX+pgfYGBKuu
         UQd2k9P/4+z4yJLs1ZOnUcoaRLqD898KBMZepW5eKp3vYjWdyPzRfX9mNy7vMAm+0g1q
         6dt1vvALYIy0trvwWZsInmSIGZc6voiKOOTbbR9LbiKapFFPs7BHiGFQR8R2GSYQ8fpq
         UAEVD+Si2HSqjx71paEIod3XzBPWTml5pN8yp00zEim/3atL7jBtgmHeGv6oVYkKnEVg
         B8NA==
X-Gm-Message-State: AOJu0YyDfETlsxeixgfBHcK65ZWb83h+3j0VIBqa5MI+NWj/yllNeKVj
	0onJqdMEOmyB1ypGWPHRlUVNEDOgMy1fdEfyh//QG10OMna4iFMx7o39JTg+ThXB6uoYZbMGSp/
	v
X-Google-Smtp-Source: AGHT+IGeOTf6zq8oES+yQxInSoGIoS7cLEMqBTBkHF+luuaklFfFm3Oe4AZblVJUknzT5toGmlmsTQ==
X-Received: by 2002:a17:90b:4d90:b0:29c:3af5:e274 with SMTP id oj16-20020a17090b4d9000b0029c3af5e274mr2710931pjb.28.1710284108490;
        Tue, 12 Mar 2024 15:55:08 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/5] skbmod: support json in print
Date: Tue, 12 Mar 2024 15:53:30 -0700
Message-ID: <20240312225456.87937-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
References: <20240312225456.87937-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tc action never got jsonized.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_skbmod.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tc/m_skbmod.c b/tc/m_skbmod.c
index b1c8d00dfe47..87de59cf60bb 100644
--- a/tc/m_skbmod.c
+++ b/tc/m_skbmod.c
@@ -177,43 +177,48 @@ static int print_skbmod(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	p = RTA_DATA(tb[TCA_SKBMOD_PARMS]);
 
-	fprintf(f, "skbmod ");
+	print_string(PRINT_FP, NULL, "skbmod ", NULL);
 	print_action_control(f, "", p->action, " ");
 
 	if (tb[TCA_SKBMOD_ETYPE]) {
 		skbmod_etype = rta_getattr_u16(tb[TCA_SKBMOD_ETYPE]);
 		has_optional = 1;
-		fprintf(f, "set etype 0x%X ", skbmod_etype);
+		print_0xhex(PRINT_ANY, "etype", "set etype 0x%X ", skbmod_etype);
 	}
 
 	if (has_optional)
-		fprintf(f, "\n\t ");
+		print_string(PRINT_FP, NULL, "%s\t ", _SL_);
 
 	if (tb[TCA_SKBMOD_DMAC]) {
 		has_optional = 1;
-		fprintf(f, "set dmac %s ",
-			ll_addr_n2a(RTA_DATA(tb[TCA_SKBMOD_DMAC]),
-				    RTA_PAYLOAD(tb[TCA_SKBMOD_DMAC]), 0, b1,
-				    sizeof(b1)));
+		print_color_string(PRINT_ANY, COLOR_MAC, "dmac",
+				   "set dmac %s ",
+				   ll_addr_n2a(RTA_DATA(tb[TCA_SKBMOD_DMAC]),
+					       RTA_PAYLOAD(tb[TCA_SKBMOD_DMAC]), 0, b1,
+					       sizeof(b1)));
 
 	}
 
 	if (tb[TCA_SKBMOD_SMAC]) {
 		has_optional = 1;
-		fprintf(f, "set smac %s ",
-			ll_addr_n2a(RTA_DATA(tb[TCA_SKBMOD_SMAC]),
-				    RTA_PAYLOAD(tb[TCA_SKBMOD_SMAC]), 0, b2,
-				    sizeof(b2)));
+		print_color_string(PRINT_ANY, COLOR_MAC, "smac",
+				   "set smac %s ",
+				   ll_addr_n2a(RTA_DATA(tb[TCA_SKBMOD_SMAC]),
+					       RTA_PAYLOAD(tb[TCA_SKBMOD_SMAC]), 0, b2,
+					       sizeof(b2)));
 	}
 
 	if (p->flags & SKBMOD_F_SWAPMAC)
-		fprintf(f, "swap mac ");
+		print_null(PRINT_ANY, "swapmac", "swap mac ", NULL);
 
 	if (p->flags & SKBMOD_F_ECN)
-		fprintf(f, "ecn ");
+		print_null(PRINT_ANY, "ecn", "ecn ", NULL);
+
+	print_nl();
+	print_uint(PRINT_ANY, "index", "\t index %u ", p->index);
+	print_int(PRINT_ANY, "ref", "ref %d ", p->refcnt);
+	print_int(PRINT_ANY, "bind", "bind %d", p->bindcnt);
 
-	fprintf(f, "\n\t index %u ref %d bind %d", p->index, p->refcnt,
-		p->bindcnt);
 	if (show_stats) {
 		if (tb[TCA_SKBMOD_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_SKBMOD_TM]);
@@ -222,7 +227,7 @@ static int print_skbmod(struct action_util *au, FILE *f, struct rtattr *arg)
 		}
 	}
 
-	fprintf(f, "\n");
+	print_string(PRINT_FP, NULL, "\n", NULL);
 
 	return 0;
 }
-- 
2.43.0


