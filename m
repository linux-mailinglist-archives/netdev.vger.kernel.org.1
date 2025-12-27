Return-Path: <netdev+bounces-246122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D683CDFA05
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A583019B89
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A2314D04;
	Sat, 27 Dec 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0hkAh+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B9314D1E
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837857; cv=none; b=CFE/BvgBcPC9mhO8UZsHmklfFs6+luDSSWmOQqCIBQBqqnw17BcmgrM/CGLE9ikG8TW6uSl14XqmFTOVfdZ44sp6BpNI1NEW5Ef/RZthqhtprFSigKdt4qcEVAu5b1WndIO26fPkviETabDbuFfJpfcxKHb/dr8vCh5XLvQxBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837857; c=relaxed/simple;
	bh=ZR0iR9pvZGcVZSHwNZDrCThadrViJMyV5/bfGtiN4gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaBo/wlpKRI8SfYccRWqmtt2mCdRaVavpBf2pxCdte9fODKMz8HKnJRVkb2S2Qg1M+lCac8Nv84krlQldOCQBo8qRFZXgm1hCsa4el+6vsWoVtgipYxGNGmZ422YrLpIGw35w9DbKoIXa+fjUD0y5dIa8XbDsn56AUzrc5wWXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0hkAh+A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so21705735e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837853; x=1767442653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvSE1c/4a8QCKCTV5gdf1mCLxf9YZVQyxdWd8z10SmE=;
        b=d0hkAh+APo89SF/oO/BATGo4UBjKStTkO6nvr+Kw3SITajoXYaVQ15NLvunGq+CgKm
         /f1RU381IpYScuBObwBAeOa14t5nYX+bmB3LMkOmJEnOz9lpx7R8KZLwrDSSwWCYUYdF
         5mRdpAypRmMTYXRAyQX5ZUAHYt96mgzso6yyFK9MX9+RzVeWtATQZGCi467A787ljwOo
         Rx6n68rbC7osZgiy2NJS2qABPEz+4BHDdQbaQsd6vbAE2gsJ117+6BSmAC5KkKBy70Kw
         e1a0tdAfHZNz9MAhwrpUMvRik9PS2l9RIU3aNlyFE4Nl4pCKIYgilb2C7b/ZBPc+Ym/+
         hx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837853; x=1767442653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvSE1c/4a8QCKCTV5gdf1mCLxf9YZVQyxdWd8z10SmE=;
        b=nlbL60ubdndh/SI0k+gp23s8rTFtTy76/uuufR9PQtUASsEjp0cbk6KyoL7iIDKTcZ
         oDTmBSfI25Fbb5ZuopZMueUj+Zzug5LTkv75gzUQYHjBf1Plmkk+LzQvH2Yp6utjH20V
         60mfV7yPCYsEOuXo7O8UNNwZdwA6gvs8D5BsDLjfKRYFwP/CAziJdfumvXu1jufjZMym
         ronXvCylXoNMm70la0bkndwOct2lz6Ne+EDVv8Qhgpg0XKJ0muQvrA3J3b65Y4aUX3kQ
         WHD6sYMGH4lNKVXRwqns3EIq8YYuBMHEiI9a7uFho71HBczgpaL9L16EaYjVn9OOa7Dl
         GRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs+kZmchEdHvP+iZu+tfwhTbsKaDhBDaFGbteFUaEUsBEmMjWf6jnLA38XHrg1Q6xEACgaokA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwyCb/C6eF4XUV1knNPkO4r4bW8GqvCNckVh+L9RAbNkEcXMo
	fJLXaGGYRLOnIhKWwOVQAlkMKX3ETNTQzC8CUgQZjMxyVypqyn7z33sONv8L9VhNQDU=
X-Gm-Gg: AY/fxX4omjgKsLk2blQyhZTJ0SF0vCCcJXPQiCyEYBGP0JwYtrBgDpVVttMHxMz6sNp
	vcVyj5HRFuhJgIxLz5iRP4N76sQpMhKshT/ISDZUptWPY/2qfoT8u2NreBZvHmQA3FgV8YvC67Q
	ltVkhmda/M9jVpo0RZUX+FIpWwW4aVxC6gvuoJwt0XwvMwHg3BAc6J6HK+z/A/PBJBudUTGwJfL
	d5JSMjBVeoU+NSUNNIAyxfVmjPHWiehXNxAEHDD6TAh5C2ExbquSMUk2s5YuyTdLsJnpkG1OF+Z
	9TVz9oQXOrLjXbZbCQueco/rjIOq/9bt29eh2++R39FJ3RqdRhIBokVsK9ALiFK6VYYLD0IaS5M
	Wk7FGJ1d+9wjL4jaQus0VIThI7wFLGrnsnbL2lgt/biGCUiiMfvX+6L7miPvWl2xixtLgCtznDA
	wM4yWDY7+kIV354DnQhss=
X-Google-Smtp-Source: AGHT+IFc0PxKRmRSwma+5BK2z0BfbuhbWCK5ZAQiNCh/fQVQ/f+EcwX2yper4KDcLK2LLWDZAwXkgQ==
X-Received: by 2002:a05:600c:620c:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47d3639489cmr187665015e9.17.1766837853435;
        Sat, 27 Dec 2025 04:17:33 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:32 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:12 -0300
Subject: [PATCH 05/19] printk: Add more context to suspend/resume functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1815;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ZR0iR9pvZGcVZSHwNZDrCThadrViJMyV5/bfGtiN4gw=;
 b=tA7/rFTFgz8i0hdAJ53eXVaQiZ32fF9Si88T8AKGgxMwsJDyXHg4gS+HXEQzjoX95zhxiaqSG
 v/P+ZTpJjf2DQdqlDkpPXA8mgBEajKQf1Xila0zWamPBwICGf70zjAA
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The new comments clarifies from where the functions are supposed to be
called.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 173c14e08afe..85a8b6521d9e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2734,7 +2734,8 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
 /**
  * console_suspend_all - suspend the console subsystem
  *
- * This disables printk() while we go into suspend states
+ * This disables printk() while we go into suspend states. Called by the power
+ * management subsystem.
  */
 void console_suspend_all(void)
 {
@@ -2766,6 +2767,12 @@ void console_suspend_all(void)
 	synchronize_srcu(&console_srcu);
 }
 
+/**
+ * console_resume_all - resume the console subsystem
+ *
+ * This resumes printk() when the system is being restored. Called by the power
+ * management subsystem.
+ */
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
@@ -3553,7 +3560,7 @@ struct tty_driver *console_device(int *index)
 /*
  * Prevent further output on the passed console device so that (for example)
  * serial drivers can suspend console output before suspending a port, and can
- * re-enable output afterwards.
+ * re-enable output afterwards. Called by console drivers.
  */
 void console_suspend(struct console *console)
 {
@@ -3572,6 +3579,7 @@ void console_suspend(struct console *console)
 }
 EXPORT_SYMBOL(console_suspend);
 
+/* Resumes printing on the passed console device. Called by console drivers. */
 void console_resume(struct console *console)
 {
 	struct console_flush_type ft;

-- 
2.52.0


