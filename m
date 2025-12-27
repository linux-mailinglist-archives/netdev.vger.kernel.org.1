Return-Path: <netdev+bounces-246131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA544CDFB82
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEEE130022F1
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D993242DD;
	Sat, 27 Dec 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WkPdkqCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57B322C65
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837941; cv=none; b=iA67WLFgFPU6FsLkvlu1QYERhoCWbKVtXbbFuVFc//8yLXBd1shRZAZXunJrHFEWKeab1Tq1V9DO5amu3ZSHUZxIdFzXK3Zv62N8VAyqkp8yHZyXBB7Lv017W5vpv4EnUW9QsdUz/U74Aq3VXRfuefgvbWTBUyNstyc6UsbRXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837941; c=relaxed/simple;
	bh=go1Xoe57mzaY/mIQIq5f3pHcbzGWVFe1Pe8aCGM93yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLLkQkM/CMqTkHP/Q15zIQdQ/eQwaT5+2/BxcV5H0ribr7tSxj2UbjTrWpJRPScHa6/3k8sZ2lIP1yoSRK8oRkcDD3SS2tB2ch+Cqb2y63ROoktU1mYZRDsmlzVrXEXeS5y+XDvxaJknBc5lV3fsS6aZB+5zr/IumQ9awUYhZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WkPdkqCj; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so46610855e9.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837937; x=1767442737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=WkPdkqCjvnF1WWewivsx9QKBvWv4Xkq6+Fh344PfMkM7aUVkscfEHyxnA9p64TN2H6
         jrQomrJRmmLRcyIHDzB9nMlDty3nb6h93b8ZmPlw9sOvtbZeeDcmT66uLUIA0Di07OvP
         bPe1SiO2UGhRR1eytL2fnbICWfMM5MFAY7iQw+sqAbuBql9wDEdV3AE3+sWMnUHDBSBn
         iW7EHx8A78yboH3lzk179FGsD0tX9TZtVG/1DsI3onhwFM8G4AY0Ahye4bUK9Pa0XmD/
         gcqgqd0tl7RamgGQRJoqDgwdq8cS7rhb2BfkdaFWU53nrWBUSLvGNgRBK1ChsnqneJei
         o36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837937; x=1767442737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jl/uMa7F0AxGo9UgKbw3ayYmv5/eAGkPJCpV4UBsG/A=;
        b=kklOKRKCy7RZtWMnExW5HWxubNiMKrnTvY/GyRQ+Gec161Wvvaj8eEdSvMsKjxHLYl
         U2+u96jD+ePESt6vVPLai8Oe0npjc4K6++zBD3mp5AiwHXNVsvUlkjtNTVWUrFBK4i//
         VksAAQd0Z3KqOXQGfSykwdo7kiBqUjM4XQ5kkhZpELXzOrFYEUdwOGHF1LF0aJwCafAf
         7HVTJVARnW2jAWrDSoqiG7be1jcD02h5gNJ55zW1pY7Y0F6NCp/l9MQ1J/JJke7Ad7DK
         Uy2HTBJJLaYdKfX3Tz02QB/3PqFgT8H+v629rEmf5y0hrM6+aQyOv0Y9WbXZ23aDkHeE
         5VqA==
X-Forwarded-Encrypted: i=1; AJvYcCU4SpCPkXCCespWvGMRrrvFJZ1SpNVeAbVId7hPkK9zFlAJH7czHrOw3B5wh7TqBzzJ2FRiJkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKN2k63qN2nX7W8/aI2idYtFcbQYTtO77oYhHVr/jVZ0Sg74z
	4/j6aesJ1mk1LpEKBzpiX80gWLxo52LaHQmcUijYDU6iBtlu0TITMpSnlzwMmVfv8fs=
X-Gm-Gg: AY/fxX7Mw2BS5I37xOKs5t8qNctVi6zouPo9BJma4n6PpOrJoWCO+fnS3/SgjUO5zTw
	roxEK/E5672PUQb3tSDRYDnu26/D9VhbqI8a6nWPQWyf2mwn0fFonRQMrV63XsTIfmaEg/PwFTG
	wVl1RikYvJUIEjhqzO6bAK8pJ3QR03TZpkxtvjS7xucD5GC+LJtr5aFLZJ0nVNwvUUFC/8dgGSQ
	Q9NINI3GLWcIZmE4kuSH4mKbfJ1D9vKb309Ukd0H68nZuyr/hUrGHQs3VLcDVsFWvHCZ4Hcozaa
	IoxPR2cjLTJ/gaUg3p/4NvvmpXk7GGknsgnHMNAuTQHeVTerdsldohy2+fIRkMLPqcB/YZQxb8J
	7CvdFE6aZFjOVsnjGZjtTI2S6cZjo2wjNBurFzVnUPBB4P+B5QED/aWGmKXQSoQOTZI0uUBTks5
	vMcJ4+a5TN
X-Google-Smtp-Source: AGHT+IEilNPw9ykBXsWasfDesGg5n0pMdngWI0y9wCDnaTUFF7DpZ4wL0dzMcGNMkGv8jBn79QEjlQ==
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47d1954a128mr290319795e9.13.1766837937081;
        Sat, 27 Dec 2025 04:18:57 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:56 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:21 -0300
Subject: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=940;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=go1Xoe57mzaY/mIQIq5f3pHcbzGWVFe1Pe8aCGM93yA=;
 b=2O7MS+wSbmBy5GHviNZc0eUrBGjBqbDvdZl/gWh/gmVWu32K1VqnWzIxEikovOvxtxQ1Ut5k4
 SCkXkL827NRAROp5vOzN3LiFx30TLjgXwQqt3ej5ptdr+YtakhrR7Rs
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/hwtracing/stm/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index 097a00ac43a7..d3ae633e3bf1 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -42,8 +42,8 @@ static int stm_console_link(struct stm_source_data *data)
 
 	strcpy(sc->console.name, "stm_console");
 	sc->console.write = stm_console_write;
-	sc->console.flags = CON_ENABLED | CON_PRINTBUFFER;
-	register_console(&sc->console);
+	sc->console.flags = CON_PRINTBUFFER;
+	register_console_force(&sc->console);
 
 	return 0;
 }

-- 
2.52.0


