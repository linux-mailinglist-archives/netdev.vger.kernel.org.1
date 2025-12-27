Return-Path: <netdev+bounces-246127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5DACDFCC7
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC8830046EC
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D031A062;
	Sat, 27 Dec 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H4RzMJ1s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921C31E11F
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837904; cv=none; b=K+u3Wx09OTeSvMPvDUP4JdmgLytgHZ2oEstalMXmFOcc9+MB9QuZMoLhcBDOOjAOCFpSrXwWW/QnjqIy126LZh1N6ekDWhvHTNIz3MYVG3eyDk06hJyJHIkR0qSvdw4jM3Y0chhohV+bXGMRopyU7WCtLxfN2WUD4EA2kLSAY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837904; c=relaxed/simple;
	bh=3dvgtN1V/Te+qiB9DfrS6Ouyxfyny3L7qK8ewpooDVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MM0J03OCkl8Ft8RxNSm4zpm3lMIG50d8JSppnyTC+E5F2xCG4NMM+yQfnM/TUXpirNb4rSUeFveL9Q1Yu84n2lzu7eEUwJLPYp54qRtS5w1L3GI5es1co6mENKsIURcZ8P6v++IHd2xxHXkolJewDpVwA3Y00vpNTOB1KyK0ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H4RzMJ1s; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477563e28a3so48214265e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837900; x=1767442700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=H4RzMJ1s9ZwnjJwrCnWnd3j67LaiHjYoBgfV2z1wnIf37T26+DNg5xDvlBjEVE8otJ
         kZ2dI5l/t4QZvlxSC0mWNKPvut1LsMFF223IPd5HHbNU+MI0qNCyZpKdRWRBFkkgH2JN
         D4ALpdc6KHDsnkmnIPvWgWlbSPpi4qQh7OTavOKNMR9DmGdyqwzp0HJDRAvDoEUJ2zR0
         GYmHIBqq9o4goE5t+JVhQmH1QNH2gj2cIpx9Wv2aAkq8rGei/TSRf3gitnBTzBEM7vf7
         lFxjpO/zZWifNxpKD9YEe2cdMjk7ljAuds+wwBUmEg00mYAJLSAPHVb09/YbRaR1i+/Y
         ePuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837900; x=1767442700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oUj1yTYG2OsJA5NR0t10qcegAjlFezEaj2Q6zpglNnU=;
        b=ZVAbIPmsvZXQZLIDCkUfWVKahmdAlYmH0R2Jp4qI8Vl2N1iXqPDRPYNc2bREYS7XVl
         VqV3S4R1pBhqe3U7044mUf7q+oRdNcJIwrtL/QTnTD+JmCf6/5ComNbrxD4HDc4ExP1c
         WbLN23TR1AzoD2yywSNWAhcxY2P+KLYtQKgMtpUZwa5RHBT3+7HBxZmTWeS+sKFHIcSM
         5ZDHaryvD4pNbaAZEOVGka1HtdxTmO52u5JRCsBdkQ03OmLH7C7lTl287RUvm9V9bNUx
         lf46/E6OcwMXew7mgXyM7Yw0+ExDsZWgXHfklZYwBuchlWbkPPALMUO0xqcJcdI7O90y
         +baA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSW2ikvc7GnOxdTEAYJnUDj+fKdjIRVqKrMJ8jcQsMaT4ln4TLT1ZP9RYVnmpZI1UdTnNLSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu14r0yNeIOzJULX4q95G4TWapiUWcSA7qMYqXwGwTaHMS5WS
	TC6Y3H9KhdX3FkPSFA4Zv6Wxp/kVigEOPwLHlnk6bsNOaYQkwoptVY49Pt8BK29CtTw=
X-Gm-Gg: AY/fxX4N2VAk4cxvcXkm8hVP1VempEGyMv5QLH630I1ygcYQauIVf91Y5FxlMX1PSkk
	fklI+LTo0VLSxatPQ1rQZshYw6jexCHWhizWV3Qv/G5TJP2MwEaYpHSlIJA1+NSxSfiDjA2WRED
	tEtSX/ttlSdUcRiP/H/MWd8s8Tx8AsrVS+mLSwrLFxKiOuh66Ws9zMmFuJ45p+TPYI0pvzkJRIa
	hZTaFVtLsAYrXVeRPLkA1fNEWHXHjRQuz7hSP/Lk4EcF4QFvBMjNq13xKPztreQ8bG1hWxfR91M
	GfiC8oAGTu1jCiG3R7OB0Ll2hcs3lCaSCQA+P1+QqPmmL0O+weEW3QIIT4OM1cC15PxRqncUBaf
	6fjBZ57BKZTnqUa3D9t4wqBYeerPLBp+rWo5U4P44b5gYs1VIoSNDNQX4BGQWZx1eLuPzuB/J2i
	dyfwTjn4lB
X-Google-Smtp-Source: AGHT+IFXI+q7UVcETj2xrgWEDOplaD2DQfL+z5FfnKK5mI2lAjBc9EF1caRTkYKVAlNOUIoqedA3Qg==
X-Received: by 2002:a05:600c:4d98:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-47be29f362amr221645875e9.16.1766837900191;
        Sat, 27 Dec 2025 04:18:20 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:19 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:17 -0300
Subject: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1079;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=3dvgtN1V/Te+qiB9DfrS6Ouyxfyny3L7qK8ewpooDVE=;
 b=vEVEr1V/PLyTXU5DKxPct4kmpsEX80YaTpb8m+k5Ll/RykRPcPf3SC/5piYXBTRWgZnh2jkWP
 FQP0jQiJpLBB9Qo/wJGJV1aoieFgYcnUso9xzkOCnscVwaYm3IY9A0b
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/pstore/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index f8b9c9c73997..9d42c0f2de9e 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -418,10 +418,10 @@ static void pstore_register_console(void)
 		sizeof(pstore_console.name));
 	/*
 	 * Always initialize flags here since prior unregister_console()
-	 * calls may have changed settings (specifically CON_ENABLED).
+	 * calls may have changed settings.
 	 */
-	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
-	register_console(&pstore_console);
+	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;
+	register_console_force(&pstore_console);
 }
 
 static void pstore_unregister_console(void)

-- 
2.52.0


