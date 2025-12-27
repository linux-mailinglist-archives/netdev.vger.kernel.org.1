Return-Path: <netdev+bounces-246125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CB9CDFBAF
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED4D302F69D
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376931B137;
	Sat, 27 Dec 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBo2H9F7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4660F3191C2
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837891; cv=none; b=fQsVV95C9ctIwh45oHHKip9ZLJtH1EamB/dWW8gCiLXN0Y8yk4TH6+ApMrO3m1kssqFJd4OpVzILknXgAI1G22rn7BoLqxfrOKf+MHJ03ZyrLN1uO+WZTjfM/G3R7zcuM3uttBduJqGI9WMMkYjZwfXKGrhxwQPlY1EcHcnM4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837891; c=relaxed/simple;
	bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nv6VqSl0n35BI+yiz9VyzDI5hfWxd5di35FNLi4t69Kb7qsScd53zcIT9RANlBx+wzzpv19sWPlBOEEF853V+Df7llSBQiHD2ciagCxb353ZGZzcWJB9GUtzsS4Ud1iiuV3UkkahgU39k9JPOVXWC1lfcXJAhPwf2GkhyHdZLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBo2H9F7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so13337335e9.3
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837882; x=1767442682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=eBo2H9F7jsvmaK92/XVdbdEGM9Tdcx4wgE+kCCLtUhDw4tiFGEFwrffvmJg3Cjflr4
         lLVjUhZChvFwikE0XJxcYjf0zBktHsHCPeQ1eRdVm52B1/xes6ShF/BI6rU3QvrL5sSM
         7jUR3QpNP5VGu1rAaHCctimiqxfroEiKYvmlv99XtG3FfaXc2C8SLHlvl87kAxKq3Jva
         ETdrsaBZZY0yjMUvbD+hJFiwLigqRz/RW3FlZQ8BcDTHnJ+LTxi77x5xGrYYwApC3/HC
         qy10hdktZ51gFdtI6Ure5hOa6dcgq/XZ2kbj+ggfexvJq8+uWpi7mf1SOoyl/T+MexXY
         2uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837882; x=1767442682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=RqDlAX8Tt4xcmgaV/iiJvKqbFkJTkvqQg2SXheueYBtHoCIOUZwuObYjoK5+uFcx+4
         dNAMpaIHHf3fRR2TPnaILXLFaiL1zLdkZ25AhrsI132QhS70N73pks/sgqxTpCP3dLyn
         nHXlEfEbwix7P2lrcU/4nmzFDfc8lDmRxR1fXgmO8ct8i39eCFAnNFxVdszoD/TmN23W
         M6BeYM7V3d75JLeWO/VBIohTLV/HSl7nCx5ZrMEMPa0S9tMWM9a/bxBv/7MhAfxASjLm
         RnDcZT3BZF/riRnMJz4nGLAv9h4t98Vh6YBrfOofuDozQmNP8GqF89QPCX0akL+FHeH+
         Tc7g==
X-Forwarded-Encrypted: i=1; AJvYcCW7scecahAGtuQCb39uPRdaGLZbEAEdCASIaUw5QikPTIET578IloDdrlrNWKzCBak9dh6WA5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcIpHOPu8xlLdAgwDB2vhlLRBpl6TDV2RL0/IvUj7wmybVNk+
	qy2Q8BUiGwlknf960i+7/D/C5xPOQ0ex0s3Hks9uyEY2r0wXtdt3CPR+AtcTAn0Pdm0=
X-Gm-Gg: AY/fxX4JvVgOcPo1AkqXp+WzyxmtDmyuHo2OpKOugirk5YcSuvgk5+Yx/ZjQlTNYZAG
	NADIyFxx2NJ9XkVzQ+4y3WfEDC8exIOEcCuh0u8ery1RJXszBhoeFtwpuN34nAO2+BA3UE+j2Mi
	cKIgUAwfbTyD7uZfxOsOaKqLq/GZ3rH2gr03peu9rwkaOpkKhaJvGCQcFty/BA+C83pd9HAiwBE
	xIteqqQMes06gHkee1j4PwCIub4aoEjxfqHfkX7rmtImWix8cncm+tKNPV1fGTzgEmgCA0sdjke
	niJ/DWqi5+29FgbA6+c9AKrbu5kAUqDBbKXqkOVQqNL97sBEnP5SrNFhScye28RDEfnOUNAxOQq
	ZmsUxXeey75e5ipc8AAYSJCYPxn9Nt642+4zhPPcfXPXt7ZSbuI0+hWXsolwPtV8And2aWRbJh+
	gpKL1fr8ND
X-Google-Smtp-Source: AGHT+IG0mR7FQaw+l23lNeDI3HZ2oGPwNQnJRaTrq28MQwyhH5VRn+b1LrDgTvBXBb163N6NepB/tA==
X-Received: by 2002:a05:600c:198b:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-47d1df12f84mr272520785e9.0.1766837881680;
        Sat, 27 Dec 2025 04:18:01 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:00 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:15 -0300
Subject: [PATCH 08/19] debug: debug_core: Migrate to register_console_force
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1369;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
 b=frjUdDlkDnmz9ghHbQI85g3SWQC6r698VmLv/vY5BaR0ZhD0fZI/A4RKNedga5QpYNhkZRCmF
 1wOfSuqi/z5ASQwxAphrFcarhmThsZ8zA4jjeiyha2OJh22t8WzJ4PJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/debug_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0b9495187fba..4bf736e5a059 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -941,7 +941,7 @@ static void kgdb_console_write(struct console *co, const char *s,
 static struct console kgdbcons = {
 	.name		= "kgdb",
 	.write		= kgdb_console_write,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 };
 
@@ -950,7 +950,7 @@ static int __init opt_kgdb_con(char *str)
 	kgdb_use_con = 1;
 
 	if (kgdb_io_module_registered && !kgdb_con_registered) {
-		register_console(&kgdbcons);
+		register_console_force(&kgdbcons);
 		kgdb_con_registered = 1;
 	}
 
@@ -1071,7 +1071,7 @@ static void kgdb_register_callbacks(void)
 		register_sysrq_key('g', &sysrq_dbg_op);
 #endif
 		if (kgdb_use_con && !kgdb_con_registered) {
-			register_console(&kgdbcons);
+			register_console_force(&kgdbcons);
 			kgdb_con_registered = 1;
 		}
 	}

-- 
2.52.0


