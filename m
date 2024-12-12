Return-Path: <netdev+bounces-151541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B99EFF44
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 23:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F85165B1F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7250A1DE884;
	Thu, 12 Dec 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NDQf0UN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695091DE2AE
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042363; cv=none; b=ZPm9IVuA8OVYCI9flAREe8A+PTdEICwKh/mjJ1W+i5Dq+vG73ZjLydiYg47Gs1BgDeAud6Rmo/msmVIHxMRltGc6cAon2zs9KkBBx0S1To6bB4pwhh8h/ydTM0hVG0wNRzO2Fwhw9Ds73CxjA4PaTksubyQ5YbQTbEtHQbh5Biw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042363; c=relaxed/simple;
	bh=5b93Ejx+o6U3XU578z7tW2V/b291HiAG81hdx+bX7Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDQAMDNJoIQ/mfF5xqv++1pMPapKkFpWmQ0DQ/zzV7FtkESYsF4OFsNVwTNzjnmerYDvCp225udD9YEhbvagKIvK/DKaT+f4cOt1XCrlg6XuZMwvG+EvmkBSmVMzeJray1juHJgp3vi0NbG637Ci6WoMVePLQgF0yCzwA+uopZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NDQf0UN5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso742974a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734042361; x=1734647161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byKdYs4gb/ziw/qyAcgJL2F++uqzHROCdtv1pePEBx0=;
        b=NDQf0UN5mw+CMUbTuFHCmxw6907PA8GVF5VfpWOVcbvWosH9qmy5syGCajcbEipYb5
         4dsdcnaUzwdx6/3QEKfDi/jYp2ErQOXJhKZAW1xQI0CbXywnTm1nC305a/ylA8atdTg8
         wJ4rLE+mCDqr9QxLMeW8x3nzpCcX0w6g9DR5ikdljWiNb3xywT5Z/Lfz2A6lcjNLY7J1
         eyzY+l0oexsrC7bIAw4Vax73/zYL34Ricma0117D006ndc64xIQvCsCCE17hsDhcDIkd
         jwc8VJYS5AGk1Wb3HKFooqmcSC/vmIITTzhitsDQ2Q78y1KgKg3Pc7uI+I3/IHuH3SXK
         NB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042361; x=1734647161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byKdYs4gb/ziw/qyAcgJL2F++uqzHROCdtv1pePEBx0=;
        b=TnYMnR9J1L1NrB28IxS1QneEwlc4U7OJWlX3GzfD8z0i6qU8MZgn+JP5OnU9jeOLce
         6VVZhcqyi/LTUyDQm6Pt7Djfyyn48320WaL4eFqp/MknsUNEQYJsaGjPURsJOeoytE8U
         nFTWudK2vAvNGuPO7iujm8YDBStTC6WG/HGzNR+P6olw5z7ZpjwOHkmiOXklgpcBZg8P
         nX+BwgQOM1+oWUa7tHmBWWyLnMdKEnWpmuPl0w34e1h1JGVo72Fq8z+jnWH1rJqddzB3
         lZV5n9f9KrgzipumlfQN58qkvP7cF7Z6p87OZHlae2GfIADRaoGecepneH6/zVrpQsqx
         VLRw==
X-Gm-Message-State: AOJu0Yx8gU/yoMqDAtzQyiu3I5tusAHA4DGShtaR0tEz/kaus2h5QQAZ
	u8JeN1rzgaxfJIuMHqaVLZV075jsjzMd/pM1oEWB0upkUjHAo34cg4Y82sFgTmXaZ6FgSvnJXRk
	o
X-Gm-Gg: ASbGnctgUfQOmwExke3K8i825Ge/ozDC/K1fqPK1M3mJF+Vuq0gznS0eV4ZuZ7trHB2
	nTbwmh5P3O3J7yqtWaKK+jzzJZfz0Cftp984y60AwJKNBnLmqh3Nb8q5T5qKG4fhyZ39LQ7U9Ao
	Lp4rTCI7Ds9Ph/x6gZJi1pXyNp68W/NaUsXclVKSc0BKOH5YYEUWDCr8UaLfhLJuLvdDXpmVXFR
	sdIs7iV6kZfOGtqhw9QyhfyHoP/6Kuk4HXtb78So3TD9hv1gA1JuOTBj6qdqmIfu6tSwMm1sG2Q
	h418/UCBBb6Mqj+S4EdPQYT5CQjYK/U5uA==
X-Google-Smtp-Source: AGHT+IEF4ZXqDtSw88IcrBT0SKsHsJo7Q+bGWa38MvtiSwW4VdigGd5qLDWhdEruaYwESMzcD7fN1w==
X-Received: by 2002:a17:90b:3a86:b0:2ee:cd83:8fd3 with SMTP id 98e67ed59e1d1-2f2901b0d46mr614577a91.33.1734042360733;
        Thu, 12 Dec 2024 14:26:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm1830071a91.12.2024.12.12.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:26:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/6] rdma: add missing header for basename
Date: Thu, 12 Dec 2024 14:24:27 -0800
Message-ID: <20241212222549.43749-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212222549.43749-1-stephen@networkplumber.org>
References: <20241212222549.43749-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function basename prototype is in libgen.h
Fixes build on musl

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/rdma.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rdma/rdma.h b/rdma/rdma.h
index fb037bcf..fda0a45c 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -10,11 +10,12 @@
 #include <string.h>
 #include <errno.h>
 #include <getopt.h>
+#include <time.h>
+#include <libgen.h>
 #include <netinet/in.h>
 #include <libmnl/libmnl.h>
 #include <rdma/rdma_netlink.h>
 #include <rdma/rdma_user_cm.h>
-#include <time.h>
 #include <net/if_arp.h>
 
 #include "list.h"
-- 
2.45.2


