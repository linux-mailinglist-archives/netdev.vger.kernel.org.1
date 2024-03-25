Return-Path: <netdev+bounces-81802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33C88B207
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009F31C3AA9D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B35A4D4;
	Mon, 25 Mar 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctWQF93J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8F5A7A8
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399727; cv=none; b=PDS8+n4MkAAf25maaLU3Dl9pE+vl7crJPgK+SliVG9GZ9XvExXVyEu4UV3tkCTmNpJkS1eJOaJBO7AX6EF7T7vasDb4Q+RhZy8tDF1Kg5galLCjX1Dpq4gYXRGnstK8LDFhzGTkZdP2bHhJwVktwTFVZ1S4f53WduMuleRW/RFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399727; c=relaxed/simple;
	bh=IxsBgIi8bOIa7NuGF8CvdPaPRA26MXaFaFJE3EBb9cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNOwyJJUixu1/yUKrYln717+D3a753YsSc510mUnB4J1X5wDZup4D0hR8+kQnA5CNjNDAEmGcQkQ3x0IWRpSx0ftZYQ3jDT3QU26gPVY5snEA08s3cZqNcC37Ag726hYnTIIjogQ62n65N5dZRLGy1x8m2e0lVlnvf9Wtma2Lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctWQF93J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2970383f8f.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399724; x=1712004524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c45tiodY9E4mSJ1693+kxoxg9aws0ZJlkkhHNQFJhO8=;
        b=ctWQF93JcCW/mv+Vd9cAPtoj8KoM+JAnEcbFoBZEwLGPzjHH2RLuRYp8tcFWc3XE3d
         6pSNWsj0NVyKdVgpmZFbTVtUBXm1vJdz+NG5tYxWDCeR7vVKcgK/ORAvSJto+px1aIjn
         DeFsdSUSgWysDvvybovFmS3KnN4cDKPPuQNwD+imedVebkQVHDJODfwSezIRC4CvLaUm
         nLYxJSMG5KUQJcMcmcR6jUj9dofUxM+B129dh2YPcA51prwQg3pRZoyObjm7/YMxF62/
         StgNpjS3BZ82WDh8t0AhmPkvg9kucRLtIReYQgMupWoZ+XKxTwoBzFCgWoCNe3IfwBPq
         6USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399724; x=1712004524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c45tiodY9E4mSJ1693+kxoxg9aws0ZJlkkhHNQFJhO8=;
        b=PO/t8ci/tWhcnSconkh+IiEbg3WcadfziE0il+99B0ublAPFmZanfQSh40u0FQ/ZFe
         ltb35xcpIHm0p+iXWcEZzURZc9hV9gsFx0iMbnp+CeA/zFki4CycxTvR88zb2s6BAt+Q
         A2wFNJOTC8q5DZwNCEJTnwesDZgU/QI05ArXECsqIyQDidNpnsk2A7L4ZzO8p4zu0z7e
         E+exUqZkSMtWvUY9qSOC2LMGIgmcYkVIHzxeofbT2EWAqzg3xe6cRHlGHDQaxpcGB8q6
         LmlZ1Ub/fc6nlt7xRCLrDgI/PGDvi3Df97bUa2GPuAFNgUm1farO4KgDcCXOlE+MYfbZ
         oVcA==
X-Gm-Message-State: AOJu0YxhJZKJmEXl1jNIzA/XKWgtkgm2fj8fEytpcJkDGWFz6RRlKccH
	680rvOc9k79cY8CGcTbrcD8Au5gWPHQt1kMIKJ4mVQwUGjOF50LM4oKnCtUth+M=
X-Google-Smtp-Source: AGHT+IFA5PdlbpfclNFliZ3AvPV/2l0sUaRQURofEZLWKGl/Frw/LrxlBNjZdJQBfY9NzaosntJZkA==
X-Received: by 2002:a5d:6387:0:b0:341:ab6c:71e4 with SMTP id p7-20020a5d6387000000b00341ab6c71e4mr6369617wru.19.1711399723844;
        Mon, 25 Mar 2024 13:48:43 -0700 (PDT)
Received: from lenovo-lap.localdomain (89-138-235-214.bb.netvision.net.il. [89.138.235.214])
        by smtp.googlemail.com with ESMTPSA id bk3-20020a0560001d8300b00341c9956dc9sm5282982wrb.68.2024.03.25.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:48:43 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Make errors direct to "list" instead of "show"
Date: Mon, 25 Mar 2024 22:48:37 +0200
Message-Id: <20240325204837.3010-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage text and man pages only have "list" in them, but the errors
when using "ip ila list" and "ip addrlabel list" incorrectly direct to
running the "show" subcommand. Make them consistent by mentioning "list"
instead.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ipaddrlabel.c | 2 +-
 ip/ipila.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
index b045827a03ea..d343993b64a9 100644
--- a/ip/ipaddrlabel.c
+++ b/ip/ipaddrlabel.c
@@ -101,7 +101,7 @@ static int ipaddrlabel_list(int argc, char **argv)
 		af = AF_INET6;
 
 	if (argc > 0) {
-		fprintf(stderr, "\"ip addrlabel show\" does not take any arguments.\n");
+		fprintf(stderr, "\"ip addrlabel list\" does not take any arguments.\n");
 		return -1;
 	}
 
diff --git a/ip/ipila.c b/ip/ipila.c
index f4387e039f97..50d834f4625c 100644
--- a/ip/ipila.c
+++ b/ip/ipila.c
@@ -142,7 +142,7 @@ static int do_list(int argc, char **argv)
 	ILA_REQUEST(req, 1024, ILA_CMD_GET, NLM_F_REQUEST | NLM_F_DUMP);
 
 	if (argc > 0) {
-		fprintf(stderr, "\"ip ila show\" does not take "
+		fprintf(stderr, "\"ip ila list\" does not take "
 			"any arguments.\n");
 		return -1;
 	}
-- 
2.34.1


