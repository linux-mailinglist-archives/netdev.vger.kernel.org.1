Return-Path: <netdev+bounces-249839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A346D1F03B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0607A3011ECC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974DC39A7F1;
	Wed, 14 Jan 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWolcuWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FC39A800
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396346; cv=none; b=TFF+MgecTZgbA9NsYNNxRGwzks+v0WgWiB9u5PIlYmLCEhJpr6lIvG/OczldIX33k7XSZjO3aci2d7oLC7X3WlxVRo1YanP1RgQvs3cHKb9hODaDcZKCIrxwnbuPriE9W/VzbusrkYCDhbHXTBtUW2/eQ5aPYUq7yG4p50IUOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396346; c=relaxed/simple;
	bh=qVQVDrDK8GQt0EFjDkN2BeDB9NxS3hqaAC/BXhJUBXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDvtgNbCk1aqgyy6TtRqx0/ZqM+9lRAS6dANC/PK1+t9eFvvOQWdT1BoSZWb8n/BfiGp0CysOi8xcFzpLKq/Dwf7zrvHO9jO9wCgRtqIMAZho2NV1xIuI5/01Lze0TST1ohBEGeA+n6ENFXI8uOVPORfXQFyAYT6K6gdqr+9iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aWolcuWY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so64648005e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396342; x=1769001142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=aWolcuWYJf6Ct/NWQt6rExuRtGu3LFOudFYsGbsTnoG1JSvl2EkPbO/rwX483SQP4C
         pq+N1613z+QGsd3+cQmuZQY2dTA1+dNH+/pK6fKFvPht2v/0CSotYuEcy6K+Gleu2Lza
         tTMASq4xczVUrzU+yCJiYMdvOF5NjqYrekE+yjnbMK8aJTx5aa1Qr9V7uHjINZRmQ2Bk
         O0B3IT0MWJoBonuK7cH3MAH9v89poQixipOhPiMGt9As9H+5tMMdFoV5oUi2G0anJjR3
         W4piGmZHO7uQ2l5p20BhJjuRHZkRlg/Oa7Wu0iPffIImEF+o2TBhf2OwkcCv07QdI3xY
         jDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396342; x=1769001142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpTGToIn8N6Wm60fm7MZ05SRRlKYptl+ek5X25PfwQ=;
        b=RpiLB8TNY9rHNT/dmGbtv1fZvASqad8lPhOf4GFle+vO6WRpIKXHWftkdjXtp/XmiE
         Q0i1BHKJF4+k+XG2daRtyxZZi4FRGykgQOfWISvj3RrdXpGr11q1Rticoel7p5L5vdb9
         zeaJ1VtE756nQoT1Dsemak7QE+50mXmQUrgZISXBWeGKElmgeJzfaC5+g4gkMWROhTtE
         Zq82UsYH3vyfgwdxXkm/iTDNDSawoieARlCfyr9Y8uwWGSPL3EGVGvGbaBRbZY8/8Rbr
         eGMDcA+ZQnwmMU/8JuSkwpAy++0I2jNT8SHO5sU9mSwUhN5MEYGd1zvrR75KCHwMnTwg
         VYxA==
X-Forwarded-Encrypted: i=1; AJvYcCXsMmaYYM9Cko9Lo/Be4u+NOmNBaFVVka5KHE7OTdVf3QHb6aA1Vms+WlugNWNaYLmxunDFqgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLxDdYF220k9Q6Qjo+KNbtzA/RBklSrfPClEVdRNWF3CUJet7
	AbLfNsCiCgtyacVzEXtlfDE2eD9keSoEVZdCBVkxDbCWw9ja5SHTEvchMg8dI2ePQqk=
X-Gm-Gg: AY/fxX6ZywX03X+aAdLE1lKdAahFZ9EgfVdSoVZpLjQZ4kVlH4qm80ehgcRMonK7Kyu
	m6DnO1L6Ak8Vm/5BCehGnKV7dYiKEiqXCs79dT7EX6YlDIklGeyRWZVv/uGGqgBwIwuExoOekS7
	n3J0hxDFRq45Dw7/R5I7TQAnQIVU3+gOmiEIkLdHNKaLy0gD5+zFL2Ib3b4dQk/xjMSiyiEVop0
	eanDGM2f6uv6vy+CmnkbSvfRQX0vqors6l7Ykvwtp7eVSImgGpBD2g7kL36vz60I+8ASBLI5e1o
	cFbJlpkUwzOcxzK5xDQx8PsroDbFg8lXxSYco7NxVdxV2VgMC9WyhNo+ZQAaow/Tz99+t9ACHle
	jywrd7iAFITAEsiK7K3n926g8i0dRupF0Aixi/olt4nLFXM+8RPzXzvABk9q2/xnoswvLpDAAXa
	aMX0r3fFQIyfAdbJ1xpDkdiYyL
X-Received: by 2002:a05:600c:5490:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47ee3356d5dmr36820375e9.16.1768396341643;
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b8c9bsm27274065e9.3.2026.01.14.05.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:12:21 -0800 (PST)
Date: Wed, 14 Jan 2026 14:12:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/19] printk: Reintroduce consoles_suspended global state
Message-ID: <aWeWMga1VaT0sYwj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-4-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:11, Marcos Paulo de Souza wrote:
> This change partially reverts commit 9e70a5e109a4
> ("printk: Add per-console suspended state"). The intent of the original
> commit was to move the management of the console suspended state to the
> consoles themselves to be able to use SRCU instead of console lock.
> 
> But having a global state is still useful when checking if the global
> suspend was triggered by power management. This way, instead of setting
> the state of each individual console, the code would only set/read from the
> global state.
> 
> Along with this change, two more fixes are necessary: change
> console_{suspend,resume} to set/clear CON_SUSPEND instead of setting
> CON_ENABLED and change show_cons_active to call __console_is_usable to
> check console usefulness.

I would invert the logic a bit. I think that the main motivation
is to replace CON_ENABLE -> CON_SUSPEND.

<proposal>
The flag CON_ENABLE is cleared when serial drivers get suspended. This
"hack" has been added by the commit 33c0d1b0c3ebb6 ("[PATCH] Serial
driver stuff") back in v2.5.28.

Stop hijacking CON_ENABLE flag and use the CON_SUSPEND flag instead.

Still allow to distinguish when:

  - the backing device is being suspended, see console_suspend().

  - the power management wants to calm down all consoles using
    a big-hammer, see console_suspend_all().

And restore the global "consoles_suspended" flag which was removed
by the commit 9e70a5e109a4 ("printk: Add per-console suspended state").

The difference is that accesses to the new global flag are
synchronized the same way as to the CON_SUSPEND flag. It allows
to read it under console_srcu_read_lock().

Finally, use __console_is_usable() in show_cons_active(). It is the
last location where the CON_ENABLED flag was checked directly.

The patch should not change the existing behavior because all users check
the state of the console using console_is_usable().
</proposal>

> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70eb7..7d2bded75b75 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3552,9 +3552,9 @@ static ssize_t show_cons_active(struct device *dev,
>  	for_each_console(c) {
>  		if (!c->device)
>  			continue;
> -		if (!(c->flags & CON_NBCON) && !c->write)
> -			continue;
> -		if ((c->flags & CON_ENABLED) == 0)
> +		if (!__console_is_usable(c, c->flags,
> +					 consoles_suspended,
> +					 NBCON_USE_ANY))

It would be better to move this into a separate patch.

>  			continue;
>  		cs[i++] = c;
>  		if (i >= ARRAY_SIZE(cs))

Otherwise, it looks good.

Best Regards,
Petr

