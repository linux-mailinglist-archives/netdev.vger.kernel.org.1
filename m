Return-Path: <netdev+bounces-69989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3584D2F7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A1F1C26F78
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4885C55;
	Wed,  7 Feb 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoooRZrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0D71272BA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337605; cv=none; b=XeEsG6l27ca9NL8R9w7TaPJTFxbhpSkNBVk9hoc/1VKQGekO+tVD9Pst26wzOEh5/DPRPjEdD7VIECNRH/CcxNJexx+ZO/wjzJJuU2l5FoEZyhIiVNWw60FTa75G3+ZwhlH/WnHVTMVQSJPfSHzlSyNdQC/9uCN82MJIMtQO4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337605; c=relaxed/simple;
	bh=ahhBiOSgYufJF64+bbNRSiHjojv+oDCFJmzL8Cb6Gd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CZjgGJFTBEbnThQ964Y61F+QGVilQMj4+vzU9p1H3Z+BIsJaSpm/oPT3KWZBAGNL5RdzCPI8vT3K5y20BhyZqSNtfVUPiNeLraB9yUF/35ZpsCUdQ937jR4qmovsFkniyzlY3p8tAuzIkDQP/2ofwRXCfxwSf1EG4nPilTJpOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoooRZrb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so14747431fa.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707337601; x=1707942401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=celvFWbXY5XaPD+zXDmsr0LcGBRVkzrPsOKGhCuW7I4=;
        b=VoooRZrbnHo/uOY8WgwzIiQL6mcYLS092ogIkjWSC20fRhx434ge1iyol/Ie4YpWnc
         yvvY0sClk2vFjiD1I1PZ5XW31YRs3enXgkE0/RN5IQYEmplP5r9RwqhFniAuQBCCOP63
         XIa55mV6xgK4TPuk0REkjtv+G9RVMWwCyhYXBv4JNrH6ta9FtOKODD2qDXKC8DS2zZ6k
         Q3n4e4oS0H0sR8KV/jX7aNbWzcyIVo7JIJcrkBLBpnKQYK2Gvty44Ro9fybbr4Z9lY4r
         6S4lCd1g0bOg8FRGCwvybt5SyZhd5tEhrPJTagi/sGPn5rM/s3qKcmzNSVMi0qP9mYIU
         AHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337601; x=1707942401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=celvFWbXY5XaPD+zXDmsr0LcGBRVkzrPsOKGhCuW7I4=;
        b=bl3b88mjTQaOHNkfQscPV8Ms5M2V5PXQs+noU//UqUCDiM1yHIBqvxhZ9qaV8ZzkvB
         iQSdGuXtjWIgkqfhtKZEyo1sxIivVqK25Nbv1WchcT3NA/xQEz/g5OAToPkBnjert57+
         R+M10TRVKx133gS0AzjyIUifKbMetq7Hv6776XxZKyxs1OrA6wtlYaG4Xr18DVKEIaoM
         39lkahq6hOVk1fYh4KCgcNL6QxqNKMz3sSqvQmwFzeNsmyHJgiADyIUE95JuH5w7wGfG
         /F8WrJDPSOwsvvyfSZwyeKIWfy8EF8irfRB7In2RJk0EZeAHEN3wAaHQ1ndbnbAb0a+3
         6Csw==
X-Gm-Message-State: AOJu0Yzxo4kWrAD73gzKiwfGHI8Fr3Ol8j78i4TsYD/f+6bb24XvEMAU
	SFpOCw4oZGQv1tZ6e/kZnDBHRGPukvLYUYX0BBvIRYvsZWvjf72WK/lzGXsP
X-Google-Smtp-Source: AGHT+IErryVFBlSm9o5Ong3fW2x5Ca0sMCfmb02NLiqd9Q/v+ZxcN2pc6pJibwKoFRIPAPSpoC5MQA==
X-Received: by 2002:a05:651c:2118:b0:2d0:c37b:edc1 with SMTP id a24-20020a05651c211800b002d0c37bedc1mr3094888ljq.36.1707337601164;
        Wed, 07 Feb 2024 12:26:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWahtHGcUUqmOnhJcekulp+KjGxe+U2y56ssjuQOa3f28QrorSwYgza8tNTdkcRufhMs/w3sJOlyXN9FdPG++DNJROYLGQH
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id q187-20020a2e5cc4000000b002d0c34de739sm299936ljb.105.2024.02.07.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:26:40 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] ipaddrlabel: Fix descriptor leak in flush_addrlabel()
Date: Wed,  7 Feb 2024 23:25:42 +0300
Message-Id: <20240207202542.9872-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added closure of descriptor `rth2.fd` created by rtnl_open() when
returning from function.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 ip/ipaddrlabel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ip/ipaddrlabel.c b/ip/ipaddrlabel.c
index b045827a..3857fcf5 100644
--- a/ip/ipaddrlabel.c
+++ b/ip/ipaddrlabel.c
@@ -201,8 +201,10 @@ static int flush_addrlabel(struct nlmsghdr *n, void *arg)
 		n->nlmsg_type = RTM_DELADDRLABEL;
 		n->nlmsg_flags = NLM_F_REQUEST;
 
-		if (rtnl_open(&rth2, 0) < 0)
+		if (rtnl_open(&rth2, 0) < 0) {
+			rtnl_close(&rth2);
 			return -1;
+		}
 
 		if (rtnl_talk(&rth2, n, NULL) < 0)
 			return -2;
-- 
2.30.2


