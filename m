Return-Path: <netdev+bounces-75756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A786B10A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE852841B0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4F14CAB3;
	Wed, 28 Feb 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmfmeTKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85E14EFC1
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128762; cv=none; b=Z4bBOw0GGkrmuZJiQR45xj4wJGrX9OHGiOIeIovlDx0QwjhrYlAExgWnfjdn8+phfMgsimBJlSjqvJCaghNpj8V4HWvIlg3KakWOIUUYbwznkQ2aCB+PlQbXdXO9/wp7YLC7bBM4yoR85L1fPDsv4nsCGqRUG98FkoBOA0j9wFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128762; c=relaxed/simple;
	bh=4HgKVA1dS9r7ClZ7dFaEguke6UCIXLxQ8RYY5rEYbRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LiOnhD3LF6p3PKrL/Oeyev9NfyiyRsyWJmnO2aXZGJhnrhbPsgtR7MvkIx/6YE8Os5OoJrndOYhfG4Q8adRTGu8Ld8wRuaX/UuUeN3CDIRL0+FQK6C06oLbXHOV2Dc5DL1hLSS4W8+dw8WJ61inuYjiyEvCDanPSk+GDpTR+RSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmfmeTKF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2c8c1b76cso2586471fa.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128759; x=1709733559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dNyu200RrJ1ULpYWG+XRBiEez1CyMQJAb/8qBEc3U4=;
        b=HmfmeTKFm1zE0PwBa8BD0TVx41l5gV5Ea89nN69Oa9rETD1f/e6YozO19qd5FfUBJo
         mRJCv1I+ygrrHiCQuDz3cgPWxanYrXv2oS/FE8SitXTtCVYR8wxhBDanKPyWq/L0Y1CZ
         a9iqIEhihczYvCSE6IA2/jERkmHAVtM9tBGi5DgE0MsEuPMIJK3/kSYN/yfk5gn9vnjy
         vQaq85iFjJQIZODLXe6WMMIq6mrUtdbRgy5IlejmVnL3wvi4NfPiQSi78vJioCercuKk
         7WE3J5EdT0FlQmZUrvhil//bnuEscBFfLXSd5IHpPMnvCBTyLxWZX6d7GxJCrgwCtPfp
         RpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128759; x=1709733559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dNyu200RrJ1ULpYWG+XRBiEez1CyMQJAb/8qBEc3U4=;
        b=d3TOe9qqk8Qzy3vcUQ9XyUKyGBg21ZFPX8gpvCnFmZRv+4dDTw6MwyRaiSAmaFPrIs
         PhSLdoBXBFTLLF376W4V7AXeoJlmSXSr8QZ+n+4W1ffVhVizQfuK4boh64GoXeUvbAQZ
         jgdlMWaR+3cSerbPIE6W++br2rm+mzeUBRj7dS7IPpvRIqqEzx4lVdAjJ4DJ0+SYN7Ac
         sp2+kdQ2bqwKA3FmSCpUEqc9HuMrFctXdq+i6l+zQUPLmqDeWnV6mIbOwqnffOzoyqFT
         gOwjbWOd/XRu2/Ztyc3s+uc36Oo49fp7/c+QolIqaitGue54dRdyW+jl+NcCps6L8XNL
         B6aQ==
X-Gm-Message-State: AOJu0Yxv5nTZI/LwRW5HgsLqdXiZSa8vTPrxuJjlcmOWoPRq05jlSuoQ
	z2629vmrkfqmdIZUJmz4eGTK/Te4MkVGASqUW82E36j+VQ0oGG+E
X-Google-Smtp-Source: AGHT+IF8Mq3YwJysMrczLTXbuLexWx7rR74jeIUNHleOHFFAg4vda+1E3OulAD8wVZM+iy58e7HuHQ==
X-Received: by 2002:a05:6512:3f20:b0:512:bd32:ed55 with SMTP id y32-20020a0565123f2000b00512bd32ed55mr9016252lfa.4.1709128758597;
        Wed, 28 Feb 2024 05:59:18 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id b19-20020a0565120b9300b005131e8b7103sm95204lfv.1.2024.02.28.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:59:17 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 1/3] nstat: constify name argument in generic_proc_open
Date: Wed, 28 Feb 2024 08:58:56 -0500
Message-Id: <20240228135858.3258-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the argument passed to the function
is always a constant value

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/nstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/nstat.c b/misc/nstat.c
index 2c10feaa..3a58885d 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -43,7 +43,7 @@ int npatterns;
 char info_source[128];
 int source_mismatch;
 
-static int generic_proc_open(const char *env, char *name)
+static int generic_proc_open(const char *env, const char *name)
 {
 	char store[128];
 	char *p = getenv(env);
-- 
2.30.2


