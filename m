Return-Path: <netdev+bounces-69964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3C84D23D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04045B264D7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D485C6B;
	Wed,  7 Feb 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMANQWpS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA685C42
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334186; cv=none; b=NifTtZbJ8cW35MvoIdeBoB9aVUQ8foThy30GUxlhCdjE5v7mNLIFaD8CQjZ53FNmZ3cyUM6gI3Xue5MseGEcJSftjh1VV97F472NSj9L1st8G/ewnTIzBMxrUNZxzjF+TL5pH6K/6klgOdvhpaB2LaSjj/GW5No2a57pIl6nBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334186; c=relaxed/simple;
	bh=Zb0KvqSVUFD6trhqRy7c97PHe4hgPnMtl+lYemNh+DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQXxfTNVuhsFSas19qgy+/KlV4w+gKico1/sJQy+0VcsMZDwq2aFSG0ktctU3YC7RYu+sHUsCfVlNxokcRVxSvnzWF2jDErrYyNi3nkcrBBq2Pi/ioNhxoEn8DHsKhcgGGHU7xb0ct07aq7+onzrL11QLJ1zlDIMfR9qzWDxSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMANQWpS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604a05a36d2so4210957b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334183; x=1707938983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=YMANQWpSeX3QLm8O6MtZp9VqcmTrjsQpEWzKsiwgcKuV8QTh+cowV8TYbbAQen8dYM
         E2Nuv19z2sJ0vevZWuPetVFtCcwriLDmJZrg9e7x0p69erzFdQN8vyV2A0xIyfAwxOhN
         en6kUcN5kYo43p6aDWDZfk71XVronweX7sKV1fElMDQ0BNmX9reHrWnRZDd7bonMgGfj
         IRiGlycebR2e19JnalGd2srsz5pxDJiWXAfkBM7tyslDByEThAm3zbvoktzCUzsukch2
         2Ndtyigm7KTS8dfwAmG76enJlO81pC0vMhZopr6N1t/0V+zMvws48dS7ktaWfD69NLEB
         b3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334183; x=1707938983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=ZhSxdrI4a9fTv1j+sKRXfjSMjwgaBkVvqS3yl5PY80z2GFosilpbb58W+DxFMuEuHA
         VPeeQgHB940RdPEOUAz7GOZgdLcSKISoSoVrCECwHtD+6uggGi4lBHp7Bmgd90NhGp1B
         7NMK7NOilI9O4TfUEl0+iqw2Y3Ramin2rEJJgjPPApfwpdXIbMngdKEAq3vboPfIJbX/
         c5ko2vxTaXnCgMBV74g0kkKKm5RL3qgbKydMjtrQLknRfIpMJpDS5z2bAZ/pCR2KKSzm
         pkcl+ZRNh9UU0PhTcNvRzNvD3/R1TIInEgKEhurZI8DKPfoCR1aptBFVYbmgRrVZs2TW
         vDOA==
X-Gm-Message-State: AOJu0YwUuk+whqwe5ELvTKSqp4X67WFDQzp/vbc8v+2TC51n/Uc+sTKS
	ftExDTOAEDEel6RKG/yLCKhl5sixlRWoxXkR2CJ7aywaSkqd9x49fUMTCZpv
X-Google-Smtp-Source: AGHT+IEg/r5XIgTBe5APRpYJI1nD/tOW7AjzXULl6h1ItepdteOWJUDuPcMSmDSgD/uWSDQmM2/E3g==
X-Received: by 2002:a81:4043:0:b0:602:ab33:5f5 with SMTP id m3-20020a814043000000b00602ab3305f5mr6071610ywn.11.1707334183355;
        Wed, 07 Feb 2024 11:29:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzxIou0X3VkyEBWHSshJQ+lJMQIatb275H90GSpxLtTRYkoRx04PYiqRe96oVpVpKcwNOn5Mys7pn7QowPIAyxbAmhKndonPO9x/2g/WLBi/ZIbca0tYHgX5TjoiJuJ/f7wQXzJ9Ukuktm3PydocU4M1sbta2rOoyijholXFC8Nzw0uRUntu0eIukxpG17gJNsrLIAy6O3ALzvaXL6yDS3N/TanBBqi/iy3bz+m1IvofquYiPyIpJ/OLJwEfrQ4RGAzSJFC3FJkv3agQHxu0sWTZDy9csz4nuKKnfXEvwGYjvGBaGbIJ09JvgtIo0JSWPTh0RnX5QybRzOSd3gMgUITGj0kHr+HRDEoA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id cn33-20020a05690c0d2100b006040cbbe952sm380088ywb.89.2024.02.07.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:29:43 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v5 2/5] net/ipv6: Remove unnecessary clean.
Date: Wed,  7 Feb 2024 11:29:30 -0800
Message-Id: <20240207192933.441744-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207192933.441744-1-thinker.li@gmail.com>
References: <20240207192933.441744-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The route here is newly created. It is unnecessary to call
fib6_clean_expires() on it.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 98abba8f15cd..dd6ff5b20918 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
 				clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


