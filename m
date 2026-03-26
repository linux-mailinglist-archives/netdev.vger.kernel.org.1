Return-Path: <netdev+bounces-272231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEZZFKeUxWmq/gQAu9opvQ
	(envelope-from <netdev+bounces-272231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:18:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D0633B5CA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6347300BE8D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312513A3826;
	Thu, 26 Mar 2026 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7LdI/I9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA533976B3
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556321; cv=none; b=IXcajF826OSrdJBimKrnYWefXY2vAjl2TtJfbP9Q3IjpIddyiFDK6pIbYXOKE4uZuWaMOCas/ag7nnIwJiJVw5cw4UbuxyTmEnn3aweSATbnkEBqBgsTadItw0k8bLClkiuMEyDe0vt/IgSi14We5r/0E0K8A3SfKnuxFmk/W9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556321; c=relaxed/simple;
	bh=K5v5TTWH4F+mh+Qb1H4gG6uq2C0QCi+Bgcw9bKObD+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJ/X1A21mXcT/Nhkv/5W6nXt3QB/13oOTnwRGQCKRlfCwOkG7YROXGLsflCFPbAPwV6q6NVmwm0PuK0PhajcADukhLaRa3Y6+strWzgSqOIohGEPklKwQu3z1HgZ1zU1ntDnQKEAiDg3oyKEAsE2uaOSie67rIyBFcdyP2hvqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7LdI/I9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso14049075e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774556318; x=1775161118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xycnlm/h8VsaAluVGkMfR2izvoHRISt/YiMCwALMUO4=;
        b=X7LdI/I9ozAE4Yw7QpZTVLe0TVjjbwjkLo4fu+3hGtce21mmaUdC4OIPhErpiiyGuP
         bz0kNorxBGWvMMmzvyd3s/Xo5cWy5CBjYJoPSXvL29mJPE+/BZaiXMYaQd5DdeXOquqK
         Iw8wSgfOZZbTQy6KXGyZl7p0UkmMJMRoe1xlLiW70VwJ1GerVbquxPOV35asHCvaL1Cz
         LDRLoNfNgqhksj1zCBNXQyc7OAhRIF9dTzI3b7/rnzyZSUYli6u+eTRUri3eQ/D//Esd
         rhykzrYRgLFZzF0mfaYReGEZ/mbl7E1ldobRHiCXUD8inSXqd6dEwCiZu6B+LqOVvKOv
         SmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556318; x=1775161118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xycnlm/h8VsaAluVGkMfR2izvoHRISt/YiMCwALMUO4=;
        b=goGiyCIZC5k48H2fKC3ozZJFW266SBno0uDARQxdQbgJGCHofe1LDBCB5MzLyzfWM2
         yPbEIjkBuk60cu/ZemDjiVmMJwW25xkgBMpVdAhqJV5bJz3KeEpzxHdpGZT4S0kMUSY0
         1fykSNU9zl8of06K9A2Aq92yB4rMN1K/4H5riJJCUFOaItW55RtfpxkpZEDs5LNCjhLR
         f7aFz/ElFfqfXqTxY+RQeHb0fmG50MgruDl/FEkV6iNxBPmm6RO87sLtn2GwVCrJVylU
         dgMHrfGhlWdiDszqtX4itW6NHXJpW0DV3SU6k3fRg3JTifxSv0Qoq/Vsb7STm/dxXkEh
         F1lg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1+pqBNYwMtHiQQd2q3JSsGhfgGsYkaemkvrELGUaweduKlLp2KgQLyF04hMdthMiBQlSZVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTc9fcce4LQXtMrc2hLTXrPnh7it7n0pEI5oHdX4OSQoeF71/I
	CNzU4bjVc/cn/jzHGj2IH6E6VO14UEdDItEjjH32W5kumLrzoECC8o61
X-Gm-Gg: ATEYQzxbU2EuOprO7QfmamYh0EyL3BV0hfGrQbfAdgM6dpmeycnTaHYABtIyc9X85+j
	+pDkgESmZe+VL8eAmWsZpYl9farGPGWiFoP+FMexqmt776Jbx4EjFrczscy+FLlzrouyf9d6+6V
	vsUKVKChTci6EJSQjQa4EytzAtvJfRPyElIJlN8VwtP6rNyVSutk7bYgaog7E8EYt6DwAEQtuMQ
	TOCJhtZcrYpmbo2jZwwawZGN2lEv6reOfkAaIBeIeRrQ24g840WM5vPxNFhPKTc/34NsY11j3V/
	+jSYmKdnlTr9uWHvzhymMnNfdoObxu09/N3u57PU3yXAuYcdEl6mV9sv4cEFV8YE7wpvGQ6ChN6
	DIp+IA/gKAzDiIy9rP97ZeYVwRxeYZyXQQ8fDV7lr+CK2BE6xUvegB4Jebr14p2zVXxKnqwO+AY
	QgvYOf4gmEdv/28MsEtrXnSrc4wyEuru5a5k+UTLRREhhWEh5Sghq4WFH3pDZyp8ngOzTsFD0um
	q/KYpYHpBJ4
X-Received: by 2002:a05:600c:8708:b0:483:b505:9db7 with SMTP id 5b1f17b1804b1-48727f1b5f1mr442955e9.32.1774556317978;
        Thu, 26 Mar 2026 13:18:37 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d9acb9sm3330475e9.1.2026.03.26.13.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:18:37 -0700 (PDT)
From: david.laight.linux@gmail.com
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH next] wireguard: selftests: Remove spurious precision from banner printf
Date: Thu, 26 Mar 2026 20:18:36 +0000
Message-Id: <20260326201836.3957-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.com,rasmusvillemoes.dk,linux.intel.com,goodmis.org,chromium.org,linux-foundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-272231-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53D0633B5CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>

Change ("%*.s", len, "") to ("%*s", len, "").
The former is equivalent to "%*.0s" but is really a typing mistake.
No actual change to the output.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 tools/testing/selftests/wireguard/qemu/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e..c87570494d30 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -53,7 +53,7 @@ static void print_banner(void)
 		panic("uname");
 
 	len = strlen("    WireGuard Test Suite on       ") + strlen(utsname.sysname) + strlen(utsname.release) + strlen(utsname.machine);
-	printf("\x1b[45m\x1b[33m\x1b[1m%*.s\x1b[0m\n\x1b[45m\x1b[33m\x1b[1m    WireGuard Test Suite on %s %s %s    \x1b[0m\n\x1b[45m\x1b[33m\x1b[1m%*.s\x1b[0m\n\n", len, "", utsname.sysname, utsname.release, utsname.machine, len, "");
+	printf("\x1b[45m\x1b[33m\x1b[1m%*s\x1b[0m\n\x1b[45m\x1b[33m\x1b[1m    WireGuard Test Suite on %s %s %s    \x1b[0m\n\x1b[45m\x1b[33m\x1b[1m%*s\x1b[0m\n\n", len, "", utsname.sysname, utsname.release, utsname.machine, len, "");
 }
 
 static void seed_rng(void)
-- 
2.39.5


