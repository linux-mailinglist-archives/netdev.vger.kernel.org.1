Return-Path: <netdev+bounces-249536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E71D1AAE1
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1F5309FD34
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D392352C31;
	Tue, 13 Jan 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ru2sEbeo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD43806AC
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325845; cv=none; b=Bs1P/iNDJTCL+RpP8tckK8vxXe/kT9n49mtVhHaKSbPJM+scV0PWWwxCRHWK+Iw15wvMPECoEjun5Vq605KlChPLqCubFKvQhCgRx5ofL9qqHehb0JEqqUpkAHQgbyHXTw5y87sqDbt5Dalm41OOMjBYHS9kBUz6+ydP/7gfqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325845; c=relaxed/simple;
	bh=ICK4ui9NDNRZmZPvqUFhVVRYDzu3U7vjvh8uoefFqv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE3uPhH7CqUO+0/DTau+AuUSaBAWQvEv8nbZ7fV3YFXuhKoDyRv6COq6+myygocr80iRZbm7vo0MSBRa9M4zUd4pun4AqcWAnRS32xRiUW0abtFpjo3n3yJQmYKnmU0ul2XdafQK7wgPbJbtzX4xs9r1Dt1pgPeTCM3GfdQZEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ru2sEbeo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so3710211f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768325840; x=1768930640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=Ru2sEbeo3aF1V5dVdmZ8y7qebfvXyJmIOu3zKjZ0L9VDAaRDnX70AwM7BG2MTCNZwb
         Wt2M0HgSorW10TpGQfsg9caRtjEHGygzZnBCUoVZVtJ9cb0vr93mesbIAhkVPGacjxdE
         7HU2OwKQxMCRd8/BsuI9FzZju+1UH8Go43H+kiq9CHCnMXgCIpF7/w0CTdPzN1DW1Rpm
         vJFnt7QVkUwAiqmRpO4P0wQ4QtHunX4dgFkC5Y5pl2pjWjZOPmVYlIv+L2228OrXc7FR
         T3QgLrVe14c5TYcEkEJYXN3hig3ZqFkIKuc/jaTuv7lqME1z4P3n4adyHDJ+f9c9YNAe
         Bvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325840; x=1768930640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=j6r1HF/IKaQTdGjMmhHzFtHvYvqi+q7AH8ZARKvIfwYj7V/LVQq82V0X1VL1FYKGHS
         25Wis7QtA08t8ktB/m8YtNzBttAXMR8sIqrUvdbDyqOmf2+hXdFiXX77SWQHyS0SNpgB
         vc0AaRxeiQ4k1ZcCIx11bOvawsK4dy5Xs46FtiqWNp20BM6irhoqSQvNI4HqF8v8ieFL
         osZOe1uJa+wbtiavRuu7S9u1J/McHxOp+Fti+5YTeBDjvPb4Rofi+Ustdk50FYuNWHQm
         srtC56zRry1+nk2HL/Ixg0ZWyzQcec6EehLlbsznKVLcDxihgaGsmqGzEjSplBHtdly3
         JrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz5/7VZ0tyevHwoleqGLitalwqPD8PZDulZIkAtam6K0x422isNGr68W30N/ZZD2RkZlMqBDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH74kQe+SDu97pEj4mUctsPEbftq2DP4jph4d/ptAI3p/eIAzq
	Ah7pMj9UCpd82XDTEsGqD0TQKVM+/m7oiS1hAaXn8KitWT2A9p23HBHmULGHnjkGF4M=
X-Gm-Gg: AY/fxX71ObILUJ5MXbxJn4K6/srWxKqn2hFh88NMaPbzRSUxGUTrwX587nL15yi3/an
	udYll4Hhl0giBDlQqPT2Bwv8Gb0s5hbTzcyv7KS7nlUFuLoEBuK1FDeXqcSmT4jfGDiPNcWgMzK
	fJPh2dG9ugkL+E/9BDzAkJrShTitALITm2tTcnG+Xl4tJkwmEFzzqW32mvsvx9Spp/14fKDaIZR
	cWHsw/Wo89w0fvdceVXU+R3D/lz2rmR4jIcvHd51uUzeDdtXk6GV12R6mTxqaqEKPb+m29dfyff
	E4mJahJmi8Nw6qNKqehy3QsEpos40zNt9gie1Pd5jYNe7t6apZxj9FEARWjETYt31WYLWQE9oZ0
	frb7mTiLtA+HrLwx5SLjSOh6I6Vah3AJjpcuRB0xIT5qiCbsdcnn3XJ9xoav3TT3IBa8rTphHA+
	BW8bodTquWRo13aw==
X-Google-Smtp-Source: AGHT+IHUReQqvVgC0db5F0/UgqAPwHgCcpq2ZD0lhm0g7XnDeEa3Phlj1/GEitKl8zvqkUFbSZC6XA==
X-Received: by 2002:a05:6000:2dc9:b0:430:fced:902 with SMTP id ffacd0b85a97d-432c36436fbmr29258778f8f.26.1768325840268;
        Tue, 13 Jan 2026 09:37:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm28342147f8f.34.2026.01.13.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:37:19 -0800 (PST)
Date: Tue, 13 Jan 2026 18:37:17 +0100
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
Subject: Re: [PATCH 02/19] printk: Introduce console_is_nbcon
Message-ID: <aWaCzZ8_UuyAa6xp@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:09, Marcos Paulo de Souza wrote:
> Besides checking if the current console is NBCON or not, console->flags
> is also being read in order to serve as argument of the console_is_usable
> function.
> 
> But CON_NBCON flag is unique: it's set just once in the console
> registration and never cleared. In this case it can be possible to read
> the flag when console_srcu_lock is held (which is the case when using
> for_each_console).
> 
> This change makes possible to remove the flags argument from
> console_is_usable in the next patches.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h   | 27 +++++++++++++++++++++++++++
>  kernel/debug/kdb/kdb_io.c |  2 +-
>  kernel/printk/nbcon.c     |  2 +-
>  kernel/printk/printk.c    | 15 ++++++---------
>  4 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 35c03fc4ed51..dd4ec7a5bff9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
>  	WRITE_ONCE(con->flags, flags);
>  }
>  
> +/**
> + * console_srcu_is_nbcon - Locklessly check whether the console is nbcon

There is _srcu in the function name, see below.

> + * @con:	struct console pointer of console to check
> + *
> + * Requires console_srcu_read_lock to be held, which implies that @con might
> + * be a registered console. The purpose of holding console_srcu_read_lock is
> + * to guarantee that no exit/cleanup routines will run if the console
> + * is currently undergoing unregistration.
> + *
> + * If the caller is holding the console_list_lock or it is _certain_ that
> + * @con is not and will not become registered, the caller may read
> + * @con->flags directly instead.
> + *
> + * Context: Any context.
> + * Return: True when CON_NBCON flag is set.
> + */
> +static inline bool console_is_nbcon(const struct console *con)

And here it is without _srcu.

I would prefer the variant with _srcu to make it clear that it
can be called only under _srcu. Similar to console_srcu_read_flags(con).

> +{
> +	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
> +
> +	/*
> +	 * The CON_NBCON flag is statically initialized and is never
> +	 * set or cleared at runtime.
> +	 */
> +	return data_race(con->flags & CON_NBCON);
> +}
> +
>  /* Variant of console_is_registered() when the console_list_lock is held. */
>  static inline bool console_is_registered_locked(const struct console *con)
>  {

Otherwise, it looks good to me.

With a consistent name, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

