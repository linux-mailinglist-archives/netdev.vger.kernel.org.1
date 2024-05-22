Return-Path: <netdev+bounces-97421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CE8CB731
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC079B24D41
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D481AAA;
	Wed, 22 May 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+VaS4fP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B07E777
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339610; cv=none; b=lkXfc7NVPs1l0yIN0HzwK0ffvyHp141erenlJVSSBEakrg1SGV19zk1PZyo/G2pKqVSWhL6oz5nFZJUJd1nRSPi1TClKfEflBwELXHgJynZJtTPnGTRJxfsGGtB0dX+1DNTyUCbd4/6vglMn7JOSq6Kh9g+SkIT/g9InuI5TGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339610; c=relaxed/simple;
	bh=62O3V38af8AfBVqt/HK7S1eFdYifF40ZLMchODVkB8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HyvHcxmXFKJNpJfFpJrKCThkEX+968mA3al/OcT8vQ0f7ddLRlwFE6LMJBnX9fT6I00OZxHf98/OAE9AoLUZwr+IcyYhp9Lf7J9bKg34gIdJ0r2cLESri7z/C3Mrz7JzZBycmcFW+RDYU+gEPeAVJWKlwBYGdx0ixoblkcOBUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+VaS4fP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b5cb8686c9so12643563a91.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339608; x=1716944408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=y+VaS4fP0TbbS7MXSz46crvSFsk5xjL+U4Olpf0NxQKuXj5aVFHnvvH9RJcMuBNEoX
         h/dGql9owd/eupptDWu2/4Xzds3ZGBK6CZZuUetUvY/BeZxR4pb/2hk93dNWO2oEjmNH
         XC8JY7rEf7U+GbOFgJ7ngfJ6RH80K/U3XW2TJcZCNSCJV34ZExR9Ns+JsF96EROv15FE
         hVzwFNQbPuOvvljjVM6NzNwB2C4szqrDRKt1E6UcVlODoRw40BM9dZKJqYw3Xx5YsjEO
         SmTdgfKYrBXwF2yvPuPgz15VYfUBcQiWGEzVT6ETh1ksDeJq3tzvB11lRwoxZfwXbkYQ
         O5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339608; x=1716944408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=tiltljzrjpwyoODFxf5kKfDf2O/6o9osYDnwxWBfyDAgEpkhf1wVztF7X2N7oH/aG6
         CjOEW5fLDinJH/mx5AaPOg+6j1QqthhlYeWSQaO8h10LjIg/O2/QYJHEGCO1KAy41d3r
         q4nSlpSJY44Kvla9LaTQlGCbbuunIQddbY9zp6eIwvROuma4GlryLModZR8Zjoait1Bk
         HmjtTCd9AzmcBe7goXIIUa1TiPoH1fqeDlU+39oNLQK9BtBh86e5LvvMTpKbSc31W5KN
         dXwanxi/UXVtO33UFp+3tuWU1pPLFm6Gfw0b5WzvTK60Rj8wsiAvtjm57pv06iJqhjyM
         7msQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzsiRA6XW/4xqNT89UesvUGN8/d3oN9dR6feC/yz4xsLNe4YBDn1n6KlE33PMFld2pi0F8S6w+PyJ70tzLr9gcbfc5z0de
X-Gm-Message-State: AOJu0YzR9t+2DM1KjgiVE0M5LjQlfyepZpZ55mSroN5H84nVqxSXQW4m
	h9Rh7zH7dhbiTp68Vko1ZgRVEOTdB1cSMM3UZl4DV/oQz1MG8mW9QDzfpF+oz2MVaI2nm06rTob
	6IQ==
X-Google-Smtp-Source: AGHT+IHt7Kr5feX1gdf4rvQKP41zb9M+M6WWZuA6mfud336Es8VWWBsR3GXtiDGmwzCkNXAVdnqYPJZFEdE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:9f8f:b0:2bd:9285:c147 with SMTP id
 98e67ed59e1d1-2bd9f4a593cmr5758a91.5.1716339607777; Tue, 21 May 2024 18:00:07
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:58 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-13-edliaw@google.com>
Subject: [PATCH v5 12/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c     | 2 --
 .../damon/debugfs_target_ids_read_before_terminate_race.c       | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..3f0dd30f61ef 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -3,8 +3,6 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..611396076420 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,7 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
 
 #include <fcntl.h>
 #include <stdbool.h>
-- 
2.45.1.288.g0e0cd299f1-goog


