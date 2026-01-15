Return-Path: <netdev+bounces-250249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA6D25C0E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3EF13028DAB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB23BB9F8;
	Thu, 15 Jan 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PPZfacP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44653BB9E6
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494533; cv=none; b=P02SEiZ6yhR2E3ZRgBsn31UHKGkFAr400anf4GbhwOhn77N65fiyOPPQf3G9QpPZhwudTzZ3BnRtPpPI5/aXsNBrcDCQmgP3KXUy4m/ns39wjC4PWzCHIaB5xxH2IVca0+jQapmGXa3YjmMvekFAEhDp/Bt9VFpqZT0/BTl1xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494533; c=relaxed/simple;
	bh=JFb4SbeyltssbTkVrC2fePq+++qLD9rMapcGslFduHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyufGm0mePPDIU0AvRkXV1BCX3hM5/OJr8nmGLsJyllY3K5djNBu5y9LUnGnSZ8y9MlmNlRh+WY1Bd7KzWVsPmVK6KVf4EdRa2Kao1opQu0BEFKq0x/t+3PyxH8pJtUSqeVgkg/OEgUqF6K3R61JuWc5Swbb/CkLDw6F+I+djao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PPZfacP/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430fbb6012bso835811f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768494529; x=1769099329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URJX5xTHolO9FC46ryjpGruJ5TGEDEyfrbwATuqwgLQ=;
        b=PPZfacP/bGzplc0450JH455dYiEUnNfUxQqSjlpjqIKonKjZZywOVZdLqzEqshSlls
         Ng7iaUezeoXcgC+iB7m0WMJ6ykwFWxA8At1owBUUOwZAxNVxjbgWzjhlXwNMYvqZi2OE
         1qLM/T5yL/TBaIDqILptRNIvkdq6D6rKbWpYKWU4BDWKEnYE4+NZWzUF6Y9lq57tHzDw
         Axkb44kDQ4rki3qmMn5r1sROBVEhjCLZfJOCj4iqJnE0/pl5vp5aJ9SiE7GDxUnHkjis
         zWUX/6b8cJF2C2PSJU45/ekSzDP88TQ0YgX721XUAeD0HKGBg8j+H+zy+GVab8afwPsu
         0QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494529; x=1769099329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URJX5xTHolO9FC46ryjpGruJ5TGEDEyfrbwATuqwgLQ=;
        b=C6P5u8demqRiYiUzllCkpmukictHcu669CV01otnHCKxRIPH+mD6UvtEdYM2oWudPY
         K2k4x1SPRa8Lg4X9UMejmLpPkttNrdb06P+qMLPfzG0RPC5gwqkE+Hbt56U6nsip0na5
         Phb+igcGcaEseiNFo64jLtsBi26lHL7HIP+DiLCho+e2yfYApeh9/3KuhkL82VuECrLa
         uKEa01THML/xoGmX9v1e6/yTaM5kK3JRh1EEJaAvGRnJGdd36g1H1zj7wjL2oijwXkd3
         el2n5JQ/CUMVvV5eM3Au9UX84Sc841VkDJFhjP8j4XgidEQZk+zq5vOlrn0megkiprOr
         w3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFnQeEQ1UaDx8G2Pl7ypR8RgF11OEp2ZOB2WM82KSY94QquDNjwJL78edZokFpY4JbWu4nl1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UGsaYn2IARKQ/fpRRntKzmA0rvkgS8uN0Ugr1BLvb/kMhOZa
	PR92HLymSOFB7AQivscpROr0vnLNv8zOoNJcLM3dWZJ1nrOgY6A6++15bdJFYnGMQxc=
X-Gm-Gg: AY/fxX45nz5/YfDsd5+SWVgqpwIYv7l5YAlK+Z40GcWFDmoqS4smYOjR3RovriI1hjp
	vq51LLX+CJ+A01d9Px+Jp+47ZgTM4b2r7uzsV0ysy6Hu5MJl7kustjs9sjcnnlCwEgWVwYIVJDH
	pwiZOQYSFRnjHMHICU/JZh4u69BAcv/bxYxduczhzuJPbtCaIpg77DCdp4P8XxpPYIUsWNwEAtY
	gdX6NrKTA8Eb4nDGp/n1vR5reIJ9nMj3UcIFeVBdXcDCzJILKChruj7mXlHpWnW5o475mk409lx
	FJ805UMN7NRnJKghkB+kGY3HpgXiQ8jqFo9bd+pmOZHmFOgRwWgwwlIJYeBY0XOPPHEJfq0h1jb
	HochJ304u6vZh0pSgimcc+RzTnAMj2BJZ0sVPNnopCZFdSY/GWATeW9SlOAUrlHcIHZ+DJv/2Nd
	u1SqoExF1JNF3PcA==
X-Received: by 2002:a5d:64c5:0:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-4342c501a57mr9777353f8f.26.1768494528600;
        Thu, 15 Jan 2026 08:28:48 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6e148bsm6604069f8f.33.2026.01.15.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 08:28:47 -0800 (PST)
Date: Thu, 15 Jan 2026 17:28:44 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/19] drivers: tty: serial: ma35d1_serial: Migrate to
 register_console_force helper
Message-ID: <aWkVvCu74HhV7W9s@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-16-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:23, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 285b0fe41a86..d1e03dee5579 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -633,7 +633,7 @@ static struct console ma35d1serial_console = {
>  	.write   = ma35d1serial_console_write,
>  	.device  = uart_console_device,
>  	.setup   = ma35d1serial_console_setup,
> -	.flags   = CON_PRINTBUFFER | CON_ENABLED,
> +	.flags   = CON_PRINTBUFFER,
>  	.index   = -1,
>  	.data    = &ma35d1serial_reg,
>  };
> @@ -657,7 +657,7 @@ static void ma35d1serial_console_init_port(void)
>  static int __init ma35d1serial_console_init(void)
>  {
>  	ma35d1serial_console_init_port();
> -	register_console(&ma35d1serial_console);
> +	register_console_force(&ma35d1serial_console);

Sigh, I am afraid that this is not enough.

I double checked how "ma35d1serial_console" was used. I guess
that it could get registered also via the generic uart device
driver code. I see the following:

#ifdef CONFIG_SERIAL_NUVOTON_MA35D1_CONSOLE
[...]
#define MA35D1SERIAL_CONSOLE    (&ma35d1serial_console)
#else
#define MA35D1SERIAL_CONSOLE    NULL
#endif

static struct uart_driver ma35d1serial_reg = {
[...]
	.cons         = MA35D1SERIAL_CONSOLE,
[...]
};

static int __init ma35d1serial_init(void)
{
[...]
	ret = uart_register_driver(&ma35d1serial_reg);
[...]
	ret = platform_driver_register(&ma35d1serial_driver);
[...]
}

And the gneric code:

uart_configure_port(struct uart_driver *drv, struct uart_state *state,
		    struct uart_port *port)
{
[...]
		/*
		 * If this driver supports console, and it hasn't been
		 * successfully registered yet, try to re-register it.
		 * It may be that the port was not available.
		 */
		if (port->cons && !console_is_registered(port->cons))
			register_console(port->cons);

[...]
}

, which can called via from:

  + mux_probe()
    + uart_add_one_port()
      + serial_ctrl_register_port()
	+serial_core_register_port()
	  + serial_core_add_one_port()
	    + uart_configure_port()
	      + register_console()


Honestly, I am not 100% sure. The struct console is assigned to
.cons in struct uart_driver. And uart_configure_port() function
passes port->cons from struct uart_port *port. But I believe
that they can get assigned somewhere in the maze of
the init/probe code.

I would feel more comfortable if we kept the information as
as flag in struct console so that even the generic callbacks
could use it.

Anyway, it makes sense to create a sepate flag for this
purpose, e.g. CON_FORCE or CON_FORCE_ENABLE.

>  	return 0;
>  }
>  console_initcall(ma35d1serial_console_init);

Best Regards,
Petr

