Return-Path: <netdev+bounces-246132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA652CDFC1B
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44540304C8AC
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107E32573B;
	Sat, 27 Dec 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YFrThh6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4732571D
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837953; cv=none; b=OZnCpGrjI+1cMdPDV1oSOuwEkYwAqPlSRxTdj/evYTJMnaFoZjrfvFfhAbjuRfejAFSVQRPtPjkRTcyDCHD0hmhLev4vk3ZCVTkWxpbkfkWabBxsfebkmQcTT7H0P2qIXlns/GsZH3tBmqUWlCDU7eMMJKf7HNfZZmQtkZlne3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837953; c=relaxed/simple;
	bh=8apb8xIF3Rmf3METSNa3/bIFoDSqesuSeq+cEdBJRMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIhAqT3SCChtWPGkBVmp9PJ10ayiDRp8wAryoMm3BWC7PwFlqF+bDtDxkf97bzDczjOn2tPi6Ruh0rrBh6IYKIl6Db4TU5zxiERqNE0eWYNiKopjD5vKqE5OjKzQKzTVtuFq55F2ojaVUi6h6nha+qWUabvK7ecLTrYeQ0wew7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YFrThh6P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae77516so75661845e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837950; x=1767442750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=YFrThh6PBxvoJTmapkdcXTGdiMJKY4cGdQPZqKKLBOvTpaoohsqLRaEcBjqw9FRFZx
         uANWuhf7A/IXQq0PSHi/Kkz/UKztGysEiuDxdHf83MpNjGpjiojArEtWdlyaNvpafXax
         Du35IPOw4vr568Z+e/dXjIQAEXXDS4cmPZWI5/KzcEenD5YWuGg7lOObP/dca93T+sZB
         Urusvvtj9Fcl4ZmMCbdRgzlvwliv5DRi/ff2ztt7UpWrgiaznyaSUjJ9TrlvCSe0eyB0
         EYO4+ZinZQP/pOulsHpxbIrojzTYLT7oF0BIYlSKCTJwA0ilCiTzAYZuVF79unT+shJJ
         YCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837950; x=1767442750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=AI0tPQF2IqZ9NSac3k3qefImAK2yuOXAvyDa98jR6FLOktP191scThuMKBy4PeVsOw
         lWzEV00pkHMWAY3TAISeRZI9Z5muUgMyY2Dkeh0MYJVtiz+6/Rnnl3tH4y5XGtBeaLgj
         w1REGSdr0YKIETQ9kqRrN0M8dbJtPPC/IqWNMr0N2M2GoPpiR4cmEqC5qXaE7xC2Oj3r
         joGvJsGJSxmedhNyYJruKgkPAN/vFLpEXj/58AcxV8YnnhZFnNX3se2N/D3zm8wK2ydy
         kIkqmSg0FhowuEWvSNXATvkoYljjaG5CZlYwVrWeoRUFLHtREZNAoy2nuAv1rdxEE9uC
         bPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfyAYx0CEUor/aP16m2/BROqF9ZrCwYzGwVb8jVL/NGpBO9VUhH9lzVELQCKShK/SYn9TynSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJp+/bewN3XhPfGzEaTcSj5LJ+ZOx9yXzIl+hQZttCmQRdzJaz
	FKu1KaFHHqsuG2TB1ANTC9gp2VEHdH7EP26C9vDEbUEx10tLP5w1du9jQSw5iDoe2U4=
X-Gm-Gg: AY/fxX4uTwh+pXLb1k47wkeRvKw9Kg9aDhkXSb5nj3v6dTKLFojAsR5UHg1uXeNu5aN
	5fWVi+x1aY+Yr0RC0YnlaVTf6LR26vdkvS6VfguVADXb5PA7RMMJF5dw41LWFxMcUwA+asqN/WR
	Go/q/Y74KpwjFOU7IVzLCCcjFbitCqou+4y8o0iFPJPfrUQhQ1Z18lHvTAbYxHZDOhDF2rdSxdl
	0+K9L6HTl47wv1r/n8MUVcQTvrwEM2w5u3KmLWMFpQvfYtE2m0wnNuRKZZitPmSl+GFf66qO9in
	CO2xX8DRN9B2VaIBEyXBvzo7yVRWWssWn7Jf4J8J+7aAhpHsnfV2cAVUbVIfq8USgHxaZULLp6o
	+XY9Yrnco4h4M+x01zmSjfMxZQoleYmT3nNCqPk7vzg7jZd5tuuHc27/zuacVEqJeir0pO4Z8uS
	4XTwCIB9Zq
X-Google-Smtp-Source: AGHT+IFQPHp9+ZXnfJ9gaFXvmbmtROboeRiL3XR0blYfmQMI8wXzbSWqjXdBS1sjkb/JteTKHl2ZOA==
X-Received: by 2002:a05:600c:5303:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47d195c2d7fmr223567305e9.36.1766837946357;
        Sat, 27 Dec 2025 04:19:06 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:05 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:22 -0300
Subject: [PATCH 15/19] drivers: tty: serial: mux.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-15-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1068;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=8apb8xIF3Rmf3METSNa3/bIFoDSqesuSeq+cEdBJRMg=;
 b=SOQn5veC0enOSDBgUA8xgjFU36YeIU5ltm01mWbteI/FsjC7wSIvDCGkCl9Jt9bptuqtwUiUT
 XJt5OJVOiy0DmhgN+BFidqaWmVu/I5CuRGxAmhAzWOivaZFVrPO2ZNN
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index b417faead20f..5a2d706b9cbc 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -390,7 +390,7 @@ static struct console mux_console = {
 	.write =	mux_console_write,
 	.device =	uart_console_device,
 	.setup =	mux_console_setup,
-	.flags =	CON_ENABLED | CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER,
 	.index =	0,
 	.data =		&mux_driver,
 };
@@ -547,7 +547,7 @@ static int __init mux_init(void)
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
 
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
-	        register_console(&mux_console);
+		register_console_force(&mux_console);
 #endif
 	}
 

-- 
2.52.0


