Return-Path: <netdev+bounces-246126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FACDFC00
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AEBC305963C
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35DB31D387;
	Sat, 27 Dec 2025 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG47dukP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E831BC95
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837895; cv=none; b=j2Gk6rcntPPzOzzwX/8kMb5do7lajzCTK3z0ke9eCoResLnGbTmupY0AnDotfrmoaJKeE1QS/WHza5J+y+emD2ZPi/xlyW+ci/otMKz5b2DB96QXe8sangmwk+sBVg1hzm+B8BOLjaW+fyolrUYLCiKul9CxQ87JFGEezLLFO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837895; c=relaxed/simple;
	bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRbC4vZPmwGnzHXZqqvMHKYFh7EAGF/ZSECLAAi06zTysIRNZEH4HRadFt7RiIYiCxMw+gv/ivxswD5gF0XONDSZ5MtTx6pW6BMusTRulccuRbnB4JGLvmxQIXd8wOKRdSMaQI+feoj19zvXhy9QoUbDyqDRARI9QxdrlDRWpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG47dukP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso61935535e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837891; x=1767442691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=TG47dukP7w13KTUTZ2mrQEyHmZIw1b67Qnqn/1mmqNRDGCiAKHY++6IMzQte7KyLAr
         BP9kpfYHtqsTTOwTNS8gGBSRy3+UJwj3DoBlWZ/ctuAbw0wRSyH7nuXoD/sCE1QZBnLS
         5hq6zbtHXR5n00KdiMrm2Mv7tMj5gkUX3+E8UDHBrZfBONKAtCmjatG6MROGzUpun7a2
         hm2h/uhigfCGKby0EirnGsqgP9aqtpTzCPmIMy2aOwThblrC7dgAvEXTnu8wn/rjR9YV
         7hZB07PU27uGvQGMJEv3WO6Ln/VstRVEEoWlWKTfdbrnuxKmgAHNe7Esfqboi9c2sEgP
         ehTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837891; x=1767442691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=NbXXatgXBeEF/SXfZAd7Af8lmgIwnDPjiHj0fJ8/lxsHGGzTrJOLw4w1MQhL4DkKPq
         UZ1ZOQNFaGv8FIf5cYnoPk15BOmEuqelTbGGOLFcnJV75ZpU2qfE8/CC2aq9GFaZY9/7
         Z9AV+XV6Bv02iUVbVEEq+SDOzHcOPtoVNZUNlTJp3yyQ3kBFBm6hXALqJmFpLwyAZ8Zk
         DNbhU9KE09S8Y3bBMttJ9NVK7acWzxYZfFsVHIoAwJYh/xyWKYuvxHg/AM2x7e0DHPzU
         3o908ORlnfH9uU66DbZcGjq5sEZzqGT8N2MnQyxW3ha8laDJCu2XoQDwKa4WJPMU20/b
         jMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgnistkE3np9jA2m2SrBRzsWS5VMEmYcES/tmfyJcTNo/uQU1BmHk0iMeSq3TyTC7ggvTUKJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8drRvBlG7A2v3A1fsxXRqx9lQcH260ZqqykeLCAH82Ad6kgAO
	kK5tg0A6HYeaBhD52l5YJ3Hso/+plEcHYn+syQYuAEKP6rV8KvQV8fZuydXdzWcBLpo=
X-Gm-Gg: AY/fxX68x8NqdKgM+HcPZTDdkXDcFajcJr7wFAlFVCk+tqrb6YGkB2Uu0vgPLra/pcH
	7PfuQR3eU9QRnRURFEbM1MoZNQTffwyjGpLFCuK0cmZU7mXqOXZvpWzpEr6qhQwXLtcapnfh/zj
	IooOnzduH0UAnSAhL1o+pQ1h1kfpd4o3ClA5eIs9M0/t51EJRwQR4MAlWAf5xztyuVWQnepzhxB
	lbo3UTnwzU+N6SvCOj9FigsKFI4hU828QhrN2NmWwUtKKp4sAS5UCVQDGrPJGUFAoCSV3F08nu/
	Lq6hOP7XwqoJ7gPaaWvl2KZU32I66EEkjDrKrg0cOYz3Pv0VjH88HPWA28NUYw+tqlyO1yxo3Ac
	4oWrhsLJNplRtWw96+MSBeTJ0p3WH/Kjl9Ksp0H52uX63u5QQ2s0zXiybaRIsSWInyBZdf2mMCq
	bflHRZUUeX
X-Google-Smtp-Source: AGHT+IFJeR5Bq3e314KIMXwkrZhqd3SM0Gtgef2ZKhyuTvMEsyAQgTg0idlkENoTE/A1RwLAaI6A4g==
X-Received: by 2002:a05:600c:a30f:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-47d52efc7bdmr6320155e9.1.1766837890917;
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:16 -0300
Subject: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=997;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
 b=bFiYD37gtcultSa+DtuWsZDZsqldtTEWNQGlnO3f8qpUTnHo9LyYg6/jnVTrFnBYz5Wno6rCP
 MIg9mT6KNXdApenqW2Pg83sbMRC0cE454dAXf3m0peqNYruoithEiNk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/m68k/emu/nfcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index d41260672e24..3504bbb4aedc 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -110,10 +110,9 @@ static int __init nf_debug_setup(char *arg)
 		/*
 		 * The console will be enabled when debug=nfcon is specified
 		 * as a kernel parameter. Since this is a non-standard way
-		 * of enabling consoles, it must be explicitly enabled.
+		 * of enabling consoles, it must be explicitly forced.
 		 */
-		nf_console.flags |= CON_ENABLED;
-		register_console(&nf_console);
+		register_console_force(&nf_console);
 	}
 
 	return 0;

-- 
2.52.0


