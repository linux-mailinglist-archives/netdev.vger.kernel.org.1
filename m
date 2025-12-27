Return-Path: <netdev+bounces-246130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A730CDFBD9
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3F0F30422BA
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60D31691C;
	Sat, 27 Dec 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mj0ATCYp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FD314D13
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837935; cv=none; b=VXFirksgkUv33B5hRxzRmzNAQsiUkxr+ch6luF9GRnNOozKMhHQuUEUEzsTubCC5MIJDud9lyzWNJ21M1mi3vxHJt9EJ2RwYm5sAh+GwOZEiMY0iGsqjT8n0qqa49pwM6akijY1IUaRtksPSF9rkwC2vXM9wA+IOi/dIqSK+zqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837935; c=relaxed/simple;
	bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPNnCqIFCy1Ws7S+EKddUnQ3tl+Qf7HZcmyaf7KR2PCM3qfEp1JyDem6pDKlStiN8VsI6V9cgM2HLj4CQTNXi57SmGnMH5g1R6CSNovO4+4GHBSzQ9WdvCiRBL36yPDzSRGeTcNq7L+0LYXBDxrkvVhvla3na1FmvJTaASOReSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mj0ATCYp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59149195e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837932; x=1767442732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=Mj0ATCYpdp0NPTtFmaDQUwnoeVYIDluZAR1sa25d+IZ8DqjT+HxNotKSBW2z0WbOXN
         uZbuqs4O5phdfozw6/4alUV/MRvF30lJqW+JlBSBNL6jiSoVb/ZhPk99SXjkOJj8NlOH
         DFkrknsNsKrrO7xrLRzJRDspj01QOTiTe90XuPX/8rxiz7GUlu+OK7eWmuuB0M9kxzZD
         4kP4eYSZ2iAh8x+ddwPsrj1Z9R1rkfZwcWVegyMYPb3hUHeBa4f65Hf2ueiCOsgtc5kL
         wr6WOafPeaIKKQ/Sjvk4uqbOK7Yymh0jmkxskbFGSvxKcJ5LWOtnJ90vdIoDOfGvnijF
         SMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837932; x=1767442732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=dXYn7QwmuSVkPgLY32lY4zi88L0aTK1uTTUBVrMPKE9jlfK5xOnWNIoK+7JXN5mwTF
         9lUTiEqLrCTZGVvKBYUZdkOpWYCsfLvydvnOwg4XR+Tw3Ii3AwfC5qyCk4JWlrP9YxP6
         y5y1boLDysO7tyjtUos2ElaMY1pw8ERKq96VHK5QpZDAstoF3Q4J2ihdhRjuCBoKCyOB
         INLhmx2KmZ0s8xFng/o1UVjN5tIFYuZRrGUk3uIp4PMg5QPOa8CDYE8LajxcVXjemtHA
         S8iTU/Lo1uGJtoL2K/gavEi0aNtsuyb4hJkMut8GkB6igd9YlXTktSJWV7Jtq6Z1UP7V
         iBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr56F2KTsDML28O/mz+tY/xI3YwI+52P/slMnZ6IPNpbQNZMawYsUNFKZDYmwvtFigFN0e8So=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvgmxSbI6l1E6pLVKWlFJIaaUVYLsrrz9PKi3lDdx3ORA3CgX
	apzc79z7pap+4s4AsYhtxiXXeDEbGzeIjOjCLR0ErWHIkTVKBaeU6EHZqJ/cg+hhIvs=
X-Gm-Gg: AY/fxX5XKk/nm3J27yjNi/l3XjNjvTZa6Ywfb8ypwG95KAQHBhq7TDQQ8oSKA+d88LU
	R/3yJcHgEr6SD399UJ6D2qx/DEQkzLL/642lAN0A0gMNZEmPSzi26bCxXi5VkjyRb5tpoEKpq3q
	v1IenTJvePTG/MRMe3bksQ+BwfwlRgVDvX282+zjvs1T83wQWvIR1998o98qqOlSRMmpVDQKK9T
	ejIL604rIXLcnY+vCueyCXcsVVlMfs7c21imLhYwIdw995BKPiDxN8Qlpy+aWj+I1InhYSgPmcK
	0zeyKwlzOc7KBuYe7FAfGDwsp3ggQDpOBqQmLRu9+Yx4SN+yZ33O3wtXNToO0btVYdqrwdZijgw
	d2Vim7HW8ENFHUbARHu1e1nrjOLTomoy9ZWvU4n50EmTHXMNTQ4njPnvuzx5TlLKr/61SCW0KNM
	ljrJmXa5BB
X-Google-Smtp-Source: AGHT+IFbCGvkCxGExFQLBl5yaU008gmiVvRdmeb7k0sjyaCh7Z1nYJocCXv7ZLYKC/Juko66305eyA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr270395745e9.34.1766837927833;
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:20 -0300
Subject: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=961;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
 b=gNLF1CEZIFvupLFUy4kgNSgx2QLue8Fjf3sjVi+zSBhpSIWUfb0laNahgF6qahlq6x3pophwD
 dRykPPu3R/nALZM8P2pCpkq//4oDFgsmNLGc4Tixc+Z0JIXH+9rAGGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff4bda95b9c7..ce4f4ceb7f27 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -582,12 +582,11 @@ static void console_write(struct console *console, const char *string,
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	register_console_force(&mc_console);
 	return 0;
 }
 

-- 
2.52.0


