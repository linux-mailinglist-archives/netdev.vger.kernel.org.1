Return-Path: <netdev+bounces-246134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC813CDFBD3
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962F83021FA7
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287FE32861B;
	Sat, 27 Dec 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SRYK7cNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46815327BE2
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837972; cv=none; b=FKPXE2LvitZoPM53FyZNSAZxHE+1y63+03P4wr9u+ejAyUdXbjSt9KbTQAwi2/XMFZMd4I16Unwa/cvs2dp6BdZglEkQYJuWEr5+JpUf/TOPW5dNk19DYHnstAKpyyCZG0ic51k2Wvkh+aWLOEBzdyzRJJNHcGyYod+WmY3PKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837972; c=relaxed/simple;
	bh=ipo1oJr6oF51GaJ/ypmHdNm6pxSai2H+L3ksWdFz4YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8M2gAjxbKCbL99NSDdE9g2tt2smmU7B1KwNtRhfk7oRZoxNgPyqs24d2vf9TPB+jsHnkCPr2a4JD7l7jv12uJYPiEv3lGTfCMVyisrrAfSWccILRtg4gZu2F3TUQSF15VHJyytuWa9ZwhJJMODs/VscV3Cjcr5B7goELuSgEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SRYK7cNh; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so21712195e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837968; x=1767442768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=SRYK7cNhanuPRh/iukNskmcmJoRgpsdrXsbinwReRGK5OO1i1+aPaoVgC3PnWAxou+
         oSH6KZov6ZqYaz3bMXY9nhq82AV3/Kf8KtDqgWYR7POyIlFLFe4YQgtmHJ40W3kFRtBD
         2BNiUcBmwScpcfXvZPahF8dG8K9R3/QixOZYnoTM6nf2yaQbZiuv8Qyq/c1WhGXXU0k3
         /yRHzjq1ALnBkRdHcNL1MWzU4nynVc903VUDnRoMv4b9uuXIlhI9WL3UnKJCk/fVGn31
         nrZzSNiTfbDytJEVnxGEFC2FsFogWXkO3ELPwIHiIhbmpDGt5XreQhJu9SjWs0A+B3xN
         q+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837968; x=1767442768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=NHczt5sIxH2q96qg+TBJtO6fQXtWp5mwuhDB+IG0zV6CAag4ht+QeOkDtYCOdls1wW
         TYwWie4XBsxhbxs8Qg+d3VQ6O7Y538N1Jny82mR1H3mi7dioeo+1zUMHtVaYlyEhqrat
         zYef6BQlwKogbhe1dHBjVdT3ooSqR6wfFGoLgEiAFTdy4Q0jHa3EtbvNg+4XkzseR+Ge
         G2sXg8KDevt2gCieJiKN9AzFlBRSpaU6xnL79xTih8T6RIeOinx6RuDkiy7Gp1wcFQHV
         XTHaOb8x8Xp6RpZewge8/5s4qj/I2Cc82a5DbafjV2c5Xy1i42COIFLGEjtO/e4Ghzs1
         MXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWxLl+BaalBepzPlTHyqRQsNMhfCkzkbyZv4imGuiE6lGNkvYwdI5qhSCdYm7lU4qeZJZUuzmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfhlAz47FbTSKc1Jx/ZZ5tOEHhsETk92zB7uDjF0S2TsxAPCl
	4QoZXfjE6G7eNa1qMzG/qBA6utIwhvVnMbunAJuk8/Kl+c97OcIhat/dACllV3jXhok=
X-Gm-Gg: AY/fxX6DLgb9tv3ikOEo5UxTx3mHdbDQlJCZAOXEvmd5KqXyxvwwL7zho2XDdZWtjO9
	n6T718q0gWElt+DFkK8Lh7KTKtUJEmQ2lUV+W7VxngVb/AAWLZzzJpCu+UEXlWoMb3oYvJc3y7/
	jfiLgUkXzwIX2Nm58z65ubNj2GawTBGjBXPtjuimch7so2NKKYSIMvYv49gEeQXGwfagoqUEItL
	AyHnIcpEZTFZb/lvI7+QcdqDt0lvz1weyD4yVK3WFAspzcvQJIjeMw1PJu8MDtf8eWUpQDEvvfz
	opdDWrt+u5Brq6vawESNLQ3Bs6BZWe9OmXDn4dakKppLQL8v0U9RhTSkgF0L7YSbBoPDWdllYvh
	nc0RysSPycb+VTGc2pvhRyv9foFwFDYyhF8EgBMuOqoGk1klcsXbQARIvjgNK2TkqZiuVsaRRdt
	TdeDdS5IJA
X-Google-Smtp-Source: AGHT+IEqqHc/Rd2kLfHagj9YhzIrZRGfzwvOOoeUxY4FRXLnI0VACA/N9sgft7uDx22VCc1m3UDX7g==
X-Received: by 2002:a05:600c:190f:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47d195a72fbmr289900545e9.22.1766837964788;
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:24 -0300
Subject: [PATCH 17/19] drivers: tty: ehv_bytechan: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-17-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1183;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ipo1oJr6oF51GaJ/ypmHdNm6pxSai2H+L3ksWdFz4YE=;
 b=BCXQlMZHiSgf9aACQxFpdYHusJFHrRGAPtAecEP+JmKnj9nHT6kdi2m955mQdUkj992asxAcQ
 YxGwDMjxOJdD2wCUfBrHw1pcuZeGNuCZOOekwLuy8OjtGsDgBHGc3PP
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/ehv_bytechan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 69508d7a4135..a2aab48d11ae 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -299,7 +299,7 @@ static struct console ehv_bc_console = {
 	.name		= "ttyEHV",
 	.write		= ehv_bc_console_write,
 	.device		= ehv_bc_console_device,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 };
 
 /*
@@ -331,7 +331,7 @@ static int __init ehv_bc_console_init(void)
 	   byte channels here, either, since we only care about one. */
 
 	add_preferred_console(ehv_bc_console.name, ehv_bc_console.index, NULL);
-	register_console(&ehv_bc_console);
+	register_console_force(&ehv_bc_console);
 
 	pr_info("ehv-bc: registered console driver for byte channel %u\n",
 		stdout_bc);

-- 
2.52.0


