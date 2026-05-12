Return-Path: <netdev+bounces-287067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI6uInYBA2rdzQEAu9opvQ
	(envelope-from <netdev+bounces-287067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:31:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0051E96A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D046308A5BB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA7349CEA;
	Tue, 12 May 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcRliuqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E710349CC4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581534; cv=none; b=IYZyAciLpVKs9h4lkI0GadpYBJRmslzppUoyT/804XnfyTWZN68bVqz1ibHNIf74LjxJ74ivQzCnCZ3PlrRDB0yOcvMiJDVD0qyyy5J70YRP8gjbuE8qpVwxKLIKvb0zaoiPW1WvaIIb2XGmq9xMxk/SXiVz7ix/8VJ/hpusxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581534; c=relaxed/simple;
	bh=l1Uthq/vfgdP5vHKOjjfQmtBOx+cd8qn/5iG5Ms4y2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR5pNvJV2rEp0g6+yAuETApqa3cdSvD7EqAdgu4wXL9NjZlPILycG5GemEdUnb5CpIqN8D1+OCjcmwDr65n05e6bY4s/MvWXHJTwQM0PhJ+yMHIUMlOTg5J5jY/ZT77W+zgSGwruUhA3uJgghEN2DeUwDs5osGzmhM8ZGtKioE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcRliuqS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488d2079582so56800425e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581532; x=1779186332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTHH+DyX35BmTbzRWkLeoC5HB2tKe6Kngykm47H2oVI=;
        b=mcRliuqSpuQZtpFUjwt48ybIq40gGcgBSaQhzcayd56iv9bi2BWnOB8BJUud2i1BzC
         s9RymANeLjBrhA1tGv9aSJ71bDRhCSsGn/0K/lnXrHmgjr7lvhEujSP44WhT6KBxyNKo
         0oBF6yKDH837rmoHmF+ZOB8bBeyNm4otlTdssfr+7gFUG4lZWnBLnMBZ7ULNsaMfZvHc
         aPNkPSSq53yY0kP5ZfYiACvukZXb6KU6tucdynEKH16AOmDpswWajZWPLa3o4TKhkr8k
         YeBMduY5c3wBNmwX7633cYOfGCX3V9KO9TjvZsPyhJRuJtxy/23MSyU/lPC5K5D6fNTI
         R/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581532; x=1779186332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rTHH+DyX35BmTbzRWkLeoC5HB2tKe6Kngykm47H2oVI=;
        b=IbwkFmjsS3TeAWa77WXXraI+V4z62BHQR5OZ0s5ZdS0N3zntKK7/gjRd6bPawH+Z6W
         SR3hNSLzX/hAJ/tQnr7YBgl5lyGrPc6HufdIuE/zIcZeSqjSBCGBD0r0SqSVEOqZd4wk
         J0yx8GRHsOJciUuJQQNB/Eei9X7Moqfmpb1Ek01AboMcxRmKB9hXhkV27mSVeqnChAEO
         Bf/xXnVXX6COi90i8qXbws5ttf+wFYAOpdcXUceGtso14bahCXHk+CdjeAq124hT7XMT
         wsk3xQIny2u80rukewVT13K+xf7U3tLxf1MQkRiin3X1/PxTmmxMCrCZKRb1qCSYzBB6
         uPAg==
X-Forwarded-Encrypted: i=1; AFNElJ/CW/w+LMd7Ft4KPfNFVu9A3+3/MFjTfGC6d5Cb8yBXhkTkIX4nt4FAA91AJI74Hl/qRsD7fZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3H2Rp2Bk++67+L9aq+1I/2LtAbBP28VNR20ZSRMJTIJr5JYPU
	6vz8C61RIb7OEOxd1WtqR5nbOMSWqShhTLVPTC3rg/ofPcD5+9Jtt2RDXx7rhg==
X-Gm-Gg: Acq92OG07seD5RIVvNan/vCAdUPyluyrPiQz8GhiBdyEuqT+e34/+O/BHW1ZlqOpNtw
	YV/kt2NynWmIcf9bupHKU83AxWG4WVe2jIjFyP73MViYHyOMRkSaQ2Cyw35g1gPG+VCuN6iMTQe
	g+QPiWOY2gy4IvdCZDe6o3lNu1f68ERcNoZcOlfRDItHMb7pCPeJbGCPTC0MoSToRVcTj+/658O
	6W9QmOPqbHQbd9rjYmXiTX6gRp30xWkTAa05zoC6IY/fTJNt9HqAZ/wxbYaCLCX6KFEHTB0bPsM
	0pU3Gq1nwS+VYOo6Z/PrADH95f+pEVteYKSbP7VHf7y8hoCG+5V41EiJhDD5pdK0+fLlCyUlheM
	5r34WQWixe80OjSZXjnW5+RYQR54coV4Yi0rZdczt6oT101CNR0GKXXyunscw2rgKH6NTS+vkDc
	Qlr8HNd8fsNXx0SNZrLavOZC7sGRHhQEpgHOSoM4Nq87Jmc6QHhLQabd/Xl8Cj+CejyzDsESpWM
	4BzAuoCzw==
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48e51f3c4f4mr366926825e9.25.1778581531175;
        Tue, 12 May 2026 03:25:31 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm74352255e9.1.2026.05.12.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:25:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [RFC 5/6] io_uring/zcrx: split append from area creation
Date: Tue, 12 May 2026 11:25:05 +0100
Message-ID: <1778e7ae4bccaaca9a42a6fc668bc04fc283a101.1778581283.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778581283.git.asml.silence@gmail.com>
References: <cover.1778581283.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CE0051E96A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-287067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A preparation patch, move appending an area from __zcrx_create_area()
to the caller.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0551b05d53ee..5fb81bb6f819 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -468,6 +468,7 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 
 static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_zcrx_area **res_area,
 			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
@@ -541,10 +542,8 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	/* we're only supporting one area per ifq for now */
 	area->area_id = 0;
 	area_reg->rq_area_token = (u64)area->area_id << IORING_ZCRX_AREA_SHIFT;
-
-	ret = io_zcrx_append_area(ifq, area);
-	if (!ret)
-		return 0;
+	*res_area = area;
+	return 0;
 err:
 	if (area)
 		io_zcrx_free_area(ifq, area);
@@ -555,7 +554,19 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
 			       struct io_uring_zcrx_ifq_reg *reg)
 {
-	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+	struct io_zcrx_area *area;
+	int ret;
+
+	ret = __zcrx_create_area(ifq, area_reg, &area, reg->rx_buf_len);
+	if (ret)
+		return ret;
+
+	ret = io_zcrx_append_area(ifq, area);
+	if (ret) {
+		io_zcrx_free_area(ifq, area);
+		return ret;
+	}
+	return 0;
 }
 
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
-- 
2.53.0


