Return-Path: <netdev+bounces-216734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75020B35029
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655B61B24B07
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADC216E32;
	Tue, 26 Aug 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isXfLM5B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367BC393DE4
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167790; cv=none; b=IEvPv2Drl0g6HgsnHvBFcWj7gQzoABwGNcSNW9wjkbL0vpOWiM/WYpERhR5Qidmr/9tdmyfcOeNaACW8dW5z0J85gjC922E4jCz0iwG9Arjw7ruGzmOc/JFldAUDTF4fdzIxpW+TuOcAKPgBrTU3mAuuUJ0oTXf+IeQdCmdLn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167790; c=relaxed/simple;
	bh=cXlDWkUQqr5/5WleU7eYcC1gn5PdtHp8PFhC6jtyHvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjyocvoV653sFARoh8IoBbiNSMPXUcA5zNbnyblKfpOge+AZZBmDpDnQS5kTNxkzr6gokyBmeh04bUBtHapM538XNT2heyV8yX1X4ejI24VDWTwwcWzRGsWdJTfu1CkpY3rkpv+vWQfs/VyoJucliaHRDzWv5qtuiQGBxa+kdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isXfLM5B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756167776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X3nSpXqHZsSrSQxYq3T9T9dY7bdI1HIGf94AWjQWCeU=;
	b=isXfLM5BUgCS4STNd31BNUeuwPVB/02/z7wsqjz88yGEin5LtHDMvuD+48ekbI1CqCbGxz
	iQrELwXCzIexSCwctj+tlqeqnKbBd8qSA3a72MdjlKQ0322zvTHNaIzVDwzRRgxLgFPTaL
	WyL/FZ3tC/1eNx0QVusokDqF+3WKmdo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-6CsqasqXPPCjQ7eaMP6-Bg-1; Mon, 25 Aug 2025 20:22:55 -0400
X-MC-Unique: 6CsqasqXPPCjQ7eaMP6-Bg-1
X-Mimecast-MFC-AGG-ID: 6CsqasqXPPCjQ7eaMP6-Bg_1756167774
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2461c537540so50527535ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756167774; x=1756772574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3nSpXqHZsSrSQxYq3T9T9dY7bdI1HIGf94AWjQWCeU=;
        b=Nfsb2oES+AMcXRdhhxrk4T7OnvAeQeHZVTJkWEk1x/38B4l2FaaF/VkV/HmPDGRdHs
         QC0i64LglaytcYVhc9rNFt/WdJ6e+VBAphyhHz5OCS/w2sKRP2mbV0P9Vk2WNL5E/9in
         oD57hdrfdYsHzSOPHb+qISRAlhezS6tnF9aYoV6tI9jHS/OgOkFqKYBRdWkAYsz2O8mv
         UFigJDFMzHm4AW9mV9mGBL/GURs+xvRjtUbTLXS8nr8bKWSM1nOKRIjT4r2j0iYhn3KD
         37/uDSMGt2m1gykoB1BuvUjNyAXUjAPzODfiPsQASPygtCDD3HAXNInWTc19inGl0NX/
         LwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+akuv3Vht5Hv1thJ9GSiJVWpDt9pWu2ppsUEgyFeRAWts3OacIOPF5UTOtFGsbO87N/JhpKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAaskA7tAEVa7QbWUHRw4PU6TbnQCFvKrKebKoC06pBeaox3C
	FcHRiJ1EaxwKljOEiQ170+YZkj0eThBpyogOzR1VUiFHTFjEW+vBweXw43Gg0pRQO6Y4bEKsGoO
	uwc2wMVk+UGYs3FlrR1LGGMd6siXoCfl33L7JoXA1TBSyQ4oi1dgFktBLNhXvnwjpoAUx
X-Gm-Gg: ASbGnctyyB1l72ZNWHgtQiXty62dn2hW1Z7A4JYT1UDf0od4nN1KmJIHqdMXMWsTo2j
	lBbGBJms6sHbCh7r0JK38qZivshOqUHCTE5Ii3TKyi32iPBlluZufDvoEvuC9bXUmMZwAreTHEb
	bkvkwe5PTKN/U1JF3YWo6ZA1XNbu639g/mVQ5XltGgRTs81EQVr0+UZiBwrnlt+wPOAHYSFLPkm
	94MHcxQPe35LxRL90+sZ6nObP6QuLEZ1vZX9SMm7lgJhFJdlZ/hBq7QyTrLfLHQQqM9cjCtAInY
	rEW4/rqUxzPYfDKgk5MO4pkdLCG9Sn41o05NQxRxp18aTemnQSJCMW2cRgJExogr0yCXQrkabYl
	S7idH2mmAqQjck5OvgOg5QWnXQXJ5hNly7AZ/kF6Z
X-Received: by 2002:a17:903:b8f:b0:246:9a00:1c82 with SMTP id d9443c01a7336-2469a001efcmr100124775ad.47.1756167773990;
        Mon, 25 Aug 2025 17:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsN8GTWulcsHEvKj160UNXjHs7WU/6V4y+dilaLzKgjWiRl1ZnE5i8HspBn1YLj00goop22g==
X-Received: by 2002:a17:903:b8f:b0:246:9a00:1c82 with SMTP id d9443c01a7336-2469a001efcmr100124545ad.47.1756167773578;
        Mon, 25 Aug 2025 17:22:53 -0700 (PDT)
Received: from pwayper-thinkpadt590.cbr.redhat.com (203-174-143-46.can.static-ipl.aapt.com.au. [203.174.143.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246a4e7f517sm55988625ad.117.2025.08.25.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:22:53 -0700 (PDT)
From: Paul Wayper <pwayper@redhat.com>
X-Google-Original-From: Paul Wayper <paulway@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	netdev@vger.kernel.org
Cc: paulway@redhat.com,
	jbainbri@redhat.com
Subject: [PATCH iproute2] ss: Don't pad the last (enabled) column
Date: Tue, 26 Aug 2025 10:22:37 +1000
Message-ID: <20250826002237.19995-1-paulway@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ss will emit spaces on the right hand side of a left-justified, enabled
column even if it's the last column.  In situations where one or more
lines are very long - e.g. because of a large PROCESS field value - this
causes a lot of excess output.

Firstly, calculate the last enabled column.  Then use this in the check
for whether to emit trailing spaces on the last column.

Also name the 'EXT' column as 'Details' and mark it as disabled by
default, enabled when the -e or --extended options are supplied.

Fixes: 59f46b7b5be86 ("ss: Introduce columns lightweight abstraction")
Signed-off-by: Paul Wayper <paulway@redhat.com>
---
 misc/ss.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 989e168ae35026249ccec0e2d4a3df07b0438c7b..1c576c1e5997ccbca448b6ed5af3d41d7867ba76 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -127,6 +127,8 @@ enum col_id {
 	COL_MAX
 };
 
+int LAST_COL = COL_MAX;
+
 enum col_align {
 	ALIGN_LEFT,
 	ALIGN_CENTER,
@@ -151,8 +153,8 @@ static struct column columns[] = {
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
+	{ ALIGN_LEFT,	"Process",		" ",	0, 0, 0 },
+	{ ALIGN_LEFT,	"Details",		" ",	1, 0, 0 },
 };
 
 static struct column *current_field = columns;
@@ -1079,6 +1081,22 @@ static void out(const char *fmt, ...)
 	va_end(args);
 }
 
+static void check_last_column(void)
+{
+	/* Find the last non-disabled column and set LAST_COL. */
+	for (int i = COL_MAX - 1; i > 0; i--) {
+		if (!columns[i].disabled) {
+			LAST_COL = i;
+			return;
+		}
+	}
+}
+
+static int field_is_last(struct column *f)
+{
+	return f - columns == LAST_COL;
+}
+
 static int print_left_spacing(struct column *f, int stored, int printed)
 {
 	int s;
@@ -1104,6 +1122,10 @@ static void print_right_spacing(struct column *f, int printed)
 	if (!f->width || f->align == ALIGN_RIGHT)
 		return;
 
+	/* Don't print trailing space if this is the last column. */
+	if (field_is_last(f))
+		return;
+
 	s = f->width - printed;
 	if (f->align == ALIGN_CENTER)
 		s /= 2;
@@ -1143,11 +1165,6 @@ static void field_flush(struct column *f)
 	buffer.tail->end = buffer.cur->data;
 }
 
-static int field_is_last(struct column *f)
-{
-	return f - columns == COL_MAX - 1;
-}
-
 /* Get the next available token in the buffer starting from the current token */
 static struct buf_token *buf_token_next(struct buf_token *cur)
 {
@@ -1316,6 +1333,9 @@ static void render(void)
 	if (!buffer.head)
 		return;
 
+	/* Find last non-disabled column */
+	check_last_column();
+
 	token = (struct buf_token *)buffer.head->data;
 
 	/* Ensure end alignment of last token, it wasn't necessarily flushed */
@@ -2452,12 +2472,12 @@ static void proc_ctx_print(struct sockstat *s)
 		if (find_entry(s->ino, &buf,
 				(show_proc_ctx & show_sock_ctx) ?
 				PROC_SOCK_CTX : PROC_CTX) > 0) {
-			out(" users:(%s)", buf);
+			out("users:(%s)", buf);
 			free(buf);
 		}
 	} else if (show_processes || show_threads) {
 		if (find_entry(s->ino, &buf, USERS) > 0) {
-			out(" users:(%s)", buf);
+			out("users:(%s)", buf);
 			free(buf);
 		}
 	}
@@ -6241,6 +6261,10 @@ int main(int argc, char *argv[])
 	if (ssfilter_parse(&current_filter.f, argc, argv, filter_fp))
 		usage();
 
+	/* Details column normally disabled, enable if asked */
+	if (show_details)
+		columns[COL_EXT].disabled = 0;
+
 	if (!show_processes)
 		columns[COL_PROC].disabled = 1;
 
-- 
2.51.0


