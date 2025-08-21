Return-Path: <netdev+bounces-215492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C04B2EDAF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA661BA22D7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE8F18FDBE;
	Thu, 21 Aug 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLP4x41i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827B34CF9
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755164; cv=none; b=NIqiZQ1M489Wm1W5PYxgPATs8NQhMW6mKi/kvU+LY5Rqly09p+O/9wA/xxbormEXZnlOSi2QW/iQMY/KYeMgbPef6dLwVjWo6EICOArEUEPVDBGSJAF1e4skf2s+FRlSadXOjtUEmsNbSZGrEvXC3Wjk8QnI5vQ0ujt90y32rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755164; c=relaxed/simple;
	bh=Srj3rFOsfCzj+PD/WkeAiA0hCOKPcMFGfMKVYVlhsPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmxyKe5VBv7FRztxWE2AkyCMm0OH6MNrrgXjeHsiqrqqm358LGx+NEL/lCeU2/SGMMKTpFmgyRqlurkT2VXRuJnnD2iCcKYzSNYv2D+6VgwJYMXfqLW0kZ+9/U6Ov+EVSP2Rro/MzAwqSGDI/ss37a+G6ua2vHk/CwtxXNyjWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLP4x41i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755755160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRXrain0W+j8l/cPnlQgvaKbPaIS0ezOBC4pdHHjnIs=;
	b=SLP4x41ixI1i8ewo7iaLMlDO0EijzVWUg5DYSAmwSIDexHGCId7V7eOB7CDe/MlITP6Jw3
	D2A50LuZ5vIbJjqmi4N0Gq3eirdZKrNmGPwJPMg2lTXsgSAnB14U+/QihpVClwv/h93mp4
	omnt4whjSGV76xumwFc3hbmd6LvGl8o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Zg6vtnkePcq0zSl9WXoQag-1; Thu, 21 Aug 2025 01:45:58 -0400
X-MC-Unique: Zg6vtnkePcq0zSl9WXoQag-1
X-Mimecast-MFC-AGG-ID: Zg6vtnkePcq0zSl9WXoQag_1755755158
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47610d3879so510487a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 22:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755755158; x=1756359958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRXrain0W+j8l/cPnlQgvaKbPaIS0ezOBC4pdHHjnIs=;
        b=rZiwYge7NhEhaj2da85I0PfPUNyU/y3Gb+MxdAME0KE4xTpAXxTDQLRic4URWZnnn2
         GJFEFunL6t/5W7HTJgvZLlfYdIadzLZ5EpJ2p44dlqXgJP7KKAosvajhEtBpgIWXeCDz
         v1oDNcBZjzOh26O428s/fKlVe2838O92QgO7021nRi90VR068v7K5rUtQFxSWKeVF4no
         7DYmVUk5TuOqRBDq7RoTySsXFpA47B1joiH8QaMyVFc0GbPkWcQmGgyJYsrZJbBqo75b
         +Qo2KxDMGiYPecW2o4ffLeOdLjweTfzStUFe+vKF0nD+CzNtZ+doBkM8hUxr8O4/GLC8
         5f+g==
X-Forwarded-Encrypted: i=1; AJvYcCUD/uhEdRu7mgNrQOYskrDZoPZlYt305PUcitNjKiZ2b3VldIvEoY1xtJKbPEbuSJvR/6Q1afI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxf+lNJvLlEzYBQT2/ZsNumoEsPE0m1L70AUhiF5YX2iolhWVJ
	1zGeMB886QaqNfhKEnt+xj6eV0dOBwO3ArsqvFI6H2GDaU0GPKVvuP4/tFlQXskQnLYsQR+HYET
	op4aifbjVF04iE8RlMhBnWeKFskiju5isDV4d/TnNsxrDPqQB7tvKE1YWwg==
X-Gm-Gg: ASbGnctCPunE2xiySpBLzPQf9NIMyTrYkkr4s/O1DWkmWCunyzMgRRGfQpkzrOYPcaz
	R/OtbDdOAwL7R+lhyIdW4F6XQ6vuPp8q1bM+5rieznjS0FAtezYX3ZZJfHBHlMsotRmijXXZNCT
	RbPEaYgpx2XADWjxXg+dCRqw2mC/btAtqTNA/LALtUntfLtHy4bOGe5u09Dv/E7ZkqpDUJpmZAa
	KjccWLDiqf53nnnp9oacmMy49qSIBdMcPuIo18N900tQPR322hnGHNE8DDqHoxPAbhcG/QVzxol
	FYq5z888Ej//YGEMOCcEE2Yw8HsImWRzJ5wRYBwM+GM0u2buFm5S9fpFW2DFXr/Dc2KlU+jkZwo
	scCVWwC8wiy7aiK4Fact0cnlMRuhi+5TJaIZa5PLl
X-Received: by 2002:a05:6a20:12ca:b0:240:2473:57c5 with SMTP id adf61e73a8af0-2433084a8e0mr1687614637.26.1755755157814;
        Wed, 20 Aug 2025 22:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD0Hg2lxd5XzkUpZQlEPCRPncdoUq4P5yYUHng5qxLglHuz+QWVZoaaM1mzbfcGv24Nt7iew==
X-Received: by 2002:a05:6a20:12ca:b0:240:2473:57c5 with SMTP id adf61e73a8af0-2433084a8e0mr1687583637.26.1755755157199;
        Wed, 20 Aug 2025 22:45:57 -0700 (PDT)
Received: from pwayper-thinkpadt590.cbr.redhat.com (203-174-143-46.can.static-ipl.aapt.com.au. [203.174.143.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm3805360a12.25.2025.08.20.22.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 22:45:56 -0700 (PDT)
From: Paul Wayper <pwayper@redhat.com>
X-Google-Original-From: Paul Wayper <paulway@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	netdev@vger.kernel.org
Cc: paulway@redhat.com,
	jbainbri@redhat.com
Subject: [PATCH iproute2] ss: Don't pad the last (enabled) column
Date: Thu, 21 Aug 2025 15:45:47 +1000
Message-ID: <20250821054547.473917-1-paulway@redhat.com>
X-Mailer: git-send-email 2.50.1
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

Also remove the 'EXT' column which does not seem to be used.

Fixes: 59f46b7b5be86 ("ss: Introduce columns lightweight abstraction")
Signed-off-by: Paul Wayper <paulway@redhat.com>
---
 misc/ss.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 989e168ae35026249ccec0e2d4a3df07b0438c7b..27cf7434c616e0030efc8876f00715d4b37dd567 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -123,10 +123,11 @@ enum col_id {
 	COL_RADDR,
 	COL_RSERV,
 	COL_PROC,
-	COL_EXT,
 	COL_MAX
 };
 
+int LAST_COL = COL_MAX;
+
 enum col_align {
 	ALIGN_LEFT,
 	ALIGN_CENTER,
@@ -152,7 +153,6 @@ static struct column columns[] = {
 	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
 	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
-	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
 };
 
 static struct column *current_field = columns;
@@ -1079,6 +1079,24 @@ static void out(const char *fmt, ...)
 	va_end(args);
 }
 
+static void check_last_column(void)
+{
+	/* Find the last non-disabled column and set LAST_COL. */
+	for (int i = COL_MAX - 1; i > 0; i--) {
+		struct column c = columns[i];
+
+		if (!c.disabled) {
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
-- 
2.50.1


