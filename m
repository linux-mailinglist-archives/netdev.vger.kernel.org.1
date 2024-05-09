Return-Path: <netdev+bounces-95100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00868C16AC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15BA1C2131D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955A13DDA6;
	Thu,  9 May 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W507AtNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49B13D89F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284968; cv=none; b=ERrs3sVLb/6kSr/0fawM4usfkxXklYNLzrQvK7eVYa/jAN4el6Vm/PSRoUDVLGJRw0U/eKAp5uQkG0vT65RXV8RUk9JAjJwSudxAicccfzXohO90vrbyc5neBTLXYqNmqwsbkA5Q7RlcIY2cxtAOvvqLmG5o4GGu9xBADaz80fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284968; c=relaxed/simple;
	bh=+slCGtFXvcRjQNf9pPixrF7VucIjnTrEcVdfQN1I3Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GgjsYc4bYZuAtLgkZ5tECE53awyshAOIFuwY7g/cjecSoPGWObdcY540QibeRNSCKdx+VMfMLwtD+Hp7/AgPxtiQCIy3pScH8IcD7knvP0uqUAisC8PCLHrwiQfSGef6WfDXp5BLGkiMtRNoGbdDWyku0IRgIjjwhv2raHZ56p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W507AtNA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61e5d65daceso1183229a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284965; x=1715889765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ROtSes3ZQb3WG9zfhdXtPEPHl3PoGiMttA81TOGVo=;
        b=W507AtNA+pZUQqou2EZd9Sie6CNxjyTU7sCi3FFBXhwGK/XQBVVwRTjWN0yIrUelVf
         mNZSX4WiAuNSe8d1eGWFM7RpsmDydQs5qr1q/vzOV3LSTjqcFLYZ2BH0GbAKQS6h7OrO
         UoMhYUi+jvhWBjVkOMmW4oS49z7oOEoRgwJtExi6Nrp5tIJKw9PA9BwvzV+b4k94EqjB
         CMClzuIWKr8EHMWj9U6GhQh5KJtM/tPMQU9QmL+WiT2HOPvNXHESMVokymSDrS+bp7ap
         y+2j+9KT9driNYKph9w//69YzEOAPk/ziuf1o4NNGyy2xT2AlYmKXBoFUm/okKETXLHo
         bsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284965; x=1715889765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/ROtSes3ZQb3WG9zfhdXtPEPHl3PoGiMttA81TOGVo=;
        b=VBFIDi6nwYlN2jKyIw6cudmi5PZqsE5wQaZq4vtanAX4x6ycH/pjxThy3oLP4aKtEY
         12p2B4ye/9LsM/DaqjlhrXR8B1ZLl7QWd19EJg4S84rdywF+DPFfcZKNHx8YU++IiIXG
         y3Oep5lFj+V4n+AlhR0K5Q8pD/YFPGRpG9UUVPThu/1xrSDt2znlK3M1KP1hmtKVXxpp
         w3LdSK67TDFK8Hn0NlAt0s5v3s++rE9x77UNvtqSEF3l9jre2z3EGwADNsc50HQpndlX
         jJbthAKDYCVrGxrHUPcMzI5wS1kSIuLFinZ9qXfwpMct54YXda7JRvnqZrss4BwyZIGw
         NY3w==
X-Forwarded-Encrypted: i=1; AJvYcCW2EZbzRkjlYPOVUrrrRMGtjy8kLTfvuuMkgseH0NQF9ymEzd3sw8rJ+18n1momfxNjb48nSb85eE6RLSilPVSku6unHRKV
X-Gm-Message-State: AOJu0YzFl31evqsQ3bN2wrtnNaegebFxTRoUYVRQUEK6tGwxNi0t6o0r
	2gqtGdYd2BrRS4o9EWbJ+l1ElnliZYF0TdT8k1kNLmeMa8+lSgumEJL4PGRIzcI3Na+FytWOn53
	4iA==
X-Google-Smtp-Source: AGHT+IGvJuQrQiMk9Le6lHJjBtL89ErJtLYzOJrcQMdwjm9MuNs1OLxjtGfyc0HVY5s6lkIGlnPJdYKFNqo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f54b:b0:1e4:a76f:6da1 with SMTP id
 d9443c01a7336-1ef43f522edmr136425ad.12.1715284964895; Thu, 09 May 2024
 13:02:44 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:32 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-41-edliaw@google.com>
Subject: [PATCH v3 40/68] selftests/nsfs: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nsfs/owner.c | 1 -
 tools/testing/selftests/nsfs/pidns.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nsfs/owner.c b/tools/testing/selftests/nsfs/owner.c
index 96a976c74550..975834ef42aa 100644
--- a/tools/testing/selftests/nsfs/owner.c
+++ b/tools/testing/selftests/nsfs/owner.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e3c772c6a7c7..9136fcaf3f40 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


