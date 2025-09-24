Return-Path: <netdev+bounces-226078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E738EB9BC2F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBFF7ACC75
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CE2701B8;
	Wed, 24 Sep 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh1G/C+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EB1C9DE5
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743405; cv=none; b=QP1pSImPjIy00kHbb0GZ+40qcltaQxl0eZ48kttHhdAe9YBPyNeGmcIMuT/ekAJVS2IRwT7Jb+Rv0K9XVTttNdudi24AqGH06iF3Bh23R6QIq0sdyvJd9QBbpp3qjEOWSdbJEDez8Ktm1HVfBm5tbuLTksdMeu7qJiOutd8wx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743405; c=relaxed/simple;
	bh=x0PirskDUQoCp3qGXR4n5Nk5yGFnMZsps6xIIHER+Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1GhMhwiGMjSeAB+eIC3xRGWe3uS2Xwmcu/Jxr8q0EeOpE53m9SORxAiyAeN40EYmJOKDDmXQToCRxgOF7bu81J/+FOnpv0Dp/pHlHPuLNf24ZyNzQN1z3LmkKI8XtuJUijzMP8OHbZEtLvzQrc+sp/2gOuQ5qwgTCK0PtTjqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh1G/C+3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ea856357c38so170155276.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743403; x=1759348203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5QjXZvXBamiaE9w0LxtivX7e6ep1Ii33x+9jRwDeKk=;
        b=Zh1G/C+37FX8CQ5/Kd4+66dngkkDHeisIeM8iqm2j0QjdMy62GeSmRZ6a73HXkbfaB
         6xpZxYdAMLh1l6vBy6OU3JcbxAaj2nGPBvE4HwKTDI6DXpBC1VUlPH/zdwVHFwSX19vv
         hzIjubVlazOlOoI9TPwpYMn8LHlNAlCGcFpA4BJphLQk5W+5svH4Ghh/KaHJ3eW2XfPl
         oaTNUdJQWxjvJV6HlqaEuX2l/8FFInBQ4dOA8iiIkwKIosq1JCUAPL5m7z5dDK4Hh5ST
         n0HH3FveDiswXGd43Hn1BQUwa6BDNOsbJ+K0EZFEoOZvaPoCHrstBLAgjGCCbsfI43B9
         8uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743403; x=1759348203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5QjXZvXBamiaE9w0LxtivX7e6ep1Ii33x+9jRwDeKk=;
        b=SdI6/1WWknAdzEqaQI0KmN3yUIyrQ9VepTJVrJNAVBG7X1YtYiOea+OlI0HkPwbL5B
         io9rqvgcgEuh8vmvbx4VdTrEJcpRlEmWnA3LVZ1HB7R0DPRZmv8ab5GEJFcoNu2l6GIt
         oEFM1Rj3N+HKiANHUtNOHtuCj5Jjf33JQd1iuRsD77wGcAL1oo3uQOszg+EEPWV4Neiy
         YUrRWZQgdrqHxvAfxjdCsUjHBRmhLhjRDkyS/jpZcpJWuPI1OkjvNJlRMEUtfjClRaOz
         ibekZFAE96xfQ7wkUXD9nslt/Hewowpoyb7K5L8LnGvxDUmETbAL6wERU13ALvYJmU8w
         cyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU81c+zYRJvCkEn52tNP1l54u7HqtisKeDSa2RigyxyyS4b1lQ3XrAfe7UpH2lUnXlmvPZ+go4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVazC641rDdTPdM0ByJPT4WVCeLHGErkAiCuIj/9NJDPlXMejS
	zFowHMoJXGk2oHZnpCKZtUCBvDimcRqyus82ZMLVshc7HFZ3Vm29AdyZ
X-Gm-Gg: ASbGncujWMab09uKeFbeGrVz1fNRaYX3/mHq1TndbhAYs9ixziZuuUIS7xoVmRu61rv
	GQw4tyfRYdrsS/ah8uFOolejBfvUS+zzrcA9jztAI5r2wkBHtkjr4HC12xy2ooijHmjW9b0lpWS
	pNqqEaCX5KWggTQVyQyqCY08TA6Ob3y/V4a8yhPHzXz2i0/fKSggsTA6DgeZ3CGDEsuWZqMyIAo
	C6Tgm14d5op00C2zmMWWKbn0WKKJScDrgdW5q5pFagR1NzJtDs+K1MQPG3rtTxzPID1rLrGxwVI
	AaG/0RcWaHBWuwKN816xOoV2k8E3y1gSJAA2Kxd1hRNsZ6SMmkRLyEjLxJ6JyxzncnytF/SWCu0
	hOWGecN01eu0U3Ls0P3Q+
X-Google-Smtp-Source: AGHT+IGOAh0GG/r7TGIliPaLaiB2VYS9iJElKt8gnk1BNImR3Nwz459njCoi+FKY0Wmy5bnZ/s9KDw==
X-Received: by 2002:a05:6902:228c:b0:ead:1e1c:2754 with SMTP id 3f1490d57ef6-eb37fcac490mr1134312276.42.1758743402751;
        Wed, 24 Sep 2025 12:50:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb37f64a46csm290755276.4.2025.09.24.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:02 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/9] selftests: net: add skip all feature to ksft_run()
Date: Wed, 24 Sep 2025 12:49:48 -0700
Message-ID: <20250924194959.2845473-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924194959.2845473-1-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is an entire test suite where each test case depends upon
some feature, e.g., psp, it is easier to state the least common
denominator of dpendencies up front, rather than doing:

cfg.require_psp()

at the start of each test.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/net/lib/py/ksft.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 8e35ed12ed9e..375020d3edf2 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -210,7 +210,7 @@ def _ksft_intr(signum, frame):
         ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
 
 
-def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+def ksft_run(cases=None, globs=None, case_pfx=None, args=(), skip_all=None):
     cases = cases or []
 
     if globs and case_pfx:
@@ -241,6 +241,8 @@ def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
         cnt_key = ""
 
         try:
+            if skip_all:
+                raise KsftSkipEx()
             case(*args)
         except KsftSkipEx as e:
             comment = "SKIP " + str(e)
-- 
2.47.3


