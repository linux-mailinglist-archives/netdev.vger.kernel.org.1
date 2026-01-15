Return-Path: <netdev+bounces-250105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FCD2413C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B2E830E99EF
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E336E485;
	Thu, 15 Jan 2026 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjVUrmSC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674637418D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475160; cv=none; b=fg5O6kG5hymREovLuPlqp4PRdZxTicDwOl+TXhaLZWNssjmbc63pXMzlpxYj1tZ+yvTtBEHbu1UP2zPMkMYBUs4Ojn5KTfAP82InFY0s3/hs2Wsr8a9TavLGq2L4LbAg4/WvaBq70KCJqBZWq58VWpfG0eEko+PEg19QuhVcenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475160; c=relaxed/simple;
	bh=5pJaxN7hZxh6H+l9RH7y9R9O3ys4FH/dz9mNWCjHNb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ1k2Zwrs3o8S9EfHTSYkYszfgTQVLz2iYsxcLi71ZrfIspvhWBUt8sdlExAuSZpglBcN3NBxYpazga5GmizhxLUBWUWq/6/Zr0Jv+oUK/EdU9ynlwVouaphYUwz2sLPUWEXrmkhQnOqWiZS6wCdF/r/md+qc/HUqleMPj3QiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjVUrmSC; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-432d2c96215so635030f8f.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768475155; x=1769079955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=fjVUrmSC9MSMqvxswqINqxfP7kInAvh2yUZz80Lx3Oz+J0nN4bpCMKnlR2Zs8PT2QI
         bru01CF9kzRl9QNE0aKptzLlWYeW6ezbhmt50gw0LnNCmoUv69ek4KUzsAEcc35qfbPM
         lWwa/dQor4rpZjr+5VsOA/fiA1EK0/Jy8iu+Vs60ZCcGmBsET27cADZ4cxK5Bc5+M4wF
         8Rfsv+bacl3Jjoo4oi5xtuZsFEhOPKiQKnDx/rO2nHosgTuggeMHXRbt+HfiFHfLlG5s
         yQFtE0iNZlDQATflRbguDlFwutYJ15Xb41/PsBGo5/A8ZgOOOV3bF0JXKgayZCUHaGMb
         NP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475155; x=1769079955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=CDNouZPsWPaj8iSUAiQwCljwh1OYziKfQzfmeFTWoPhv46CC6y4xEUPpu8hrfvjU1N
         jpM1cyXbv3t7lqW8X7+XA3tb59WrRTKt4kHRT8FlbadBMuwWwg3lrjWWS6/qzKmvnNeX
         Aa/tMFo+46I2zh3qUrqut3CZQTM7u7oJajYl6FU6drC+UsZBsRVPaUfqx4LjAc8n6Vih
         i80HkPYcDstP0drHOjSpbckR8wRrRsTj3JYUTNzjamkHqkB/0fUrbSjWA/dfRJITjwak
         7pT7dSVJeGBytxjJGY2bIwGWz7L2/vfjuu9mdMjFooYA4WVjnXil1L8pMhlSNlh6lThZ
         w0AA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ79cdIWwediGCd0fBq/kfvwSeW1y9RR8QmC5BTuW87TiLg+fRv4BXXbwWz55GcFO3ecb/+ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv0UEylZ7W6X9hMdvM6Lf1oz7nMvxrE0AJg8CeBA+ARmVMmLZF
	oIyulujvMfFZ0aQT1mYcgkfDomyuByVvxVDG0Kdvo3J3GgDy7nAnxKIV5m9Nl1zJZww=
X-Gm-Gg: AY/fxX7MIhXVU6Ee1vxMBAFn5uc01rzsjEgjkCBuVsLmp467zy6xaO8IDgYlVcogrb0
	wZ1gGnc98vUkzjeL6dIJL7t8thrFYs3TONan13mdAaCSF645RGuKRzidTvyykTO6wDNFeZsS3ZR
	DAN1Cd+fPiKNT/fs/HYkBiqbt1x5yYJ5gUdWxKwpuvq2baL92Qa2mtcBnowCZr6DBBLEOX99kmm
	zb55JoVOV4krYBFNEJlQo7QWJOxr0QWQ5UWAGmfjU5Y2qLdKTN0PnteeyZCOKUmnmiidjfJda9+
	2ZzVbqG7iV3b8qkmE3PfK+IkuWqqcz0qu+9ghNgWsfH0CVSl6JLsCD4Nx9S0vc2as3eoNpG6n6J
	6REsTvcTh1NYk6cXY4U9KYkHC8WvhddrxKKir5KMFJ7vgU1HGcsmYzSZsaBAjGhEs94ls/KxNUr
	OsqGAVxRqYdXoIzg==
X-Received: by 2002:a05:6000:2f84:b0:430:fa9a:74d with SMTP id ffacd0b85a97d-4342d3912bcmr7103110f8f.24.1768475154515;
        Thu, 15 Jan 2026 03:05:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d909fsm5297949f8f.31.2026.01.15.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:05:53 -0800 (PST)
Date: Thu, 15 Jan 2026 12:05:51 +0100
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
Subject: Re: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
Message-ID: <aWjKD4jv8CySV0Rj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:17, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.

> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -418,10 +418,10 @@ static void pstore_register_console(void)
>  		sizeof(pstore_console.name));
>  	/*
>  	 * Always initialize flags here since prior unregister_console()
> -	 * calls may have changed settings (specifically CON_ENABLED).
> +	 * calls may have changed settings.
>  	 */
> -	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
> -	register_console(&pstore_console);
> +	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;

As the original comment suggests, this was done primary because
of CON_ENABLED flag. Otherwise, the console was not registered again.

register_console() might remove CON_PRINTBUFFER when there was
a boot console and the newly registered console will get associated
with /dev/console. But I consider this a corner case. Other console
drivers ignore this scenario.

I suggest to define the two flags statically in
struct console pstore_console definition as it is done by
other console drivers. Remove this explicit dynamic assigment.
And add the following into the commit message:

<proposal>
Define the remaining console flags statically in the structure definition
as it is done by other console drivers.

The flags were re-defined primary because of the CON_ENABLED flag.
Otherwise, the re-registration failed.

The CON_PRINTBUFFER might get cleared when a boot console was registered
and the pstrore console got associated with /dev/console. In this
case, the pstore console would not re-play the entire ring buffer
on re-registration. But it is a corner case. And it actually might
be a desired behavior.
</proposal>

Otherwise, the next generations of kernel developers might think that
the re-assigment was there because of CON_PRINTBUFFER flag.
And it might cause non-necessary headaches ;-)


> +	register_console_force(&pstore_console);
>  }
>  
>  static void pstore_unregister_console(void)

Best Regards,
Petr

