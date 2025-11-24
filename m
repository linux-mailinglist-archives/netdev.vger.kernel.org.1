Return-Path: <netdev+bounces-241162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD55C80DCE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230454E1834
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609830B53C;
	Mon, 24 Nov 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QjSaNPlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334030B514
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992510; cv=none; b=gLpTS+Yu8gGn4hV7EKZH2Wu3mQQoB0YafpjZJ9GwS1YWBg41pZIzR7u+8hW1/q3zO4ENu/C7J6JftAreJwXIDWSO4c3/7M0+AwikQwj+kF0Mmx29rhGug54BbdQoVPB/gynKY3domuF7m5CMO1kZ25ySd54e0HWve0UVHXvH73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992510; c=relaxed/simple;
	bh=/CKSvAOlVY8BjN8XbCmfdPH2F1Z/MzSriDHooJwKonA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEj5QWmRu3UW9BUlJ+Pj6EMAYpOWsjf+3j5cFtwUPj2cBEt0oJblfCQx0bsIq918H5DxaN3cuvXxvM4TWLmPE4GZXYy1AEom68nvxES5ijFWyr+7GP++rwe0CE/5lqVTsI355qiD5e06XtWKNfLYVMHiTPqj0BEtJTdP6XxlGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QjSaNPlJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a637712so26190045e9.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 05:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763992506; x=1764597306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPuHiWYXlxCT3REvX5xilRSzoHSOopPnik0KnitVPIc=;
        b=QjSaNPlJFOSKJAyKnonLAh8vyfbteye7+90MDqGKQBWFwCM8zYJSrd5ZWIHmnsOWxv
         Y6X0lwfjn86zUPBJZYIdnAPzwboxNslbZUuBFqdBhbuc4OEROzrCQGnLjAUUUMnsOm0C
         tmRms3HjweOWsvLDTFcyGaTPvpUHSn+9GejzsuejgNG1YH5S+G4gC6Dthqxq6wYJeD1p
         Nz9Dcmdi4bPCAKvQlDDRjzm1L32aAOIH+UkRR1Gy4NYMDg8z/T5p8dV8v71yAqj1yZuv
         AG8I7xh8uJqdzxPYekUoEKNGT89RRu0MT/g5d+L0Bm9gD7Yp1zJU/UN5a97EYY8u+Tvv
         lMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763992506; x=1764597306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPuHiWYXlxCT3REvX5xilRSzoHSOopPnik0KnitVPIc=;
        b=r884s+CtcxWDD5RtNYo4os220jU3eWoYmFT/diHCrHwPgHSJ2pzOE0DSH7o7c4vtIQ
         Q83ypoh0wMAEPDmD0HTT7dFizinVKHtTshP4aK+02WO6sa84nX3cNfjkwPNCvH4sQGVO
         j2Nh5d0SZGv9i5MLjc/y9EeLfU6gleHAqeviZdfw5C9KlS4zBUZbOwpQbl4rUvRpdyIq
         JYFH+qx6Ofp/f89/TNUIehQiXaBEsoWztyLdf23qb2V1ksiqoKGr6FRHvNnPhLxTTXY/
         C5RSoUESXxE7/M/hhtrC5Axp6YY2IDOnk37m/OxiKhNfM4uVNSVd+frWuNY7Sts5FLNb
         PHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEd272oMYX003GBE/DK0AGqnv5Vu9nAu96s0l4bINqRrrnca8B/3hODUXiLsF8J1JH9nkMgRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NpztJ6auCdlXfFlGk7IDMHIRRwPgt3tq5SpqrEDp4uyr8Qry
	k621c+yv+dXo8yVfWPhLJoTCMSr4CRRKCs7trW9BAZBhaqLnPdTF5vk2C7UeGC/0JYw=
X-Gm-Gg: ASbGncvt0bjOPV+RRZSOwuY/uPEG3qT2k6h5Dm//vNJSR6crikdOGYUvSJo73DyeEb2
	Zd1Dv2vA6bnTTNopztDQFq4rRURfg56iXSpT4bRIgvP5Jtu7dnlF+ahWZPaFNkPORATtVJcWhJq
	QSxdMDdgZCC7HETGY8GtIarDFWg+Q6l0CZzEYE8I941E6Giwe5qFqsNCUFHAB8eLPCpEaFhg0ef
	7dnCF5N4oFpShNUVXDIJyj6mFppqMreDRBSDEOxrqsJZUmRhhn+3+SvOBLDz0doUr0x0gXyk5sn
	Yv2x3eofgey4eod5r2JgsNNOrpk6aTwk8rR6qU7m3J7hAuIiDPHysaA0ewcfL7ZiKxao2jFBkyH
	p/rZNnDenonAOdJlqpWjNel+z9H4Uv6dxm6p5b0hxjnM7/rwlQuYtaolzbQBpbAauncz++1UEv0
	6I4BBQU+x7ccf71A==
X-Google-Smtp-Source: AGHT+IG1aXy33KmNHg9WN5SPhjEuMzD0hduDeGynMkb23F8zv3/FcRZI9YIQut5OtqH8of2UvaqP+w==
X-Received: by 2002:a05:600c:1ca0:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-477c0165b4emr139649225e9.4.1763992506054;
        Mon, 24 Nov 2025 05:55:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm28133751f8f.19.2025.11.24.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 05:55:05 -0800 (PST)
Date: Mon, 24 Nov 2025 14:55:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, efault@gmx.de,
	john.ogness@linutronix.de, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	calvin@wbinvd.org, asml.silence@gmail.com, kernel-team@meta.com,
	gustavold@gmail.com, asantostc@gmail.com
Subject: Re: [PATCH RFC net-next 2/2] netconsole: add CONFIG_NETCONSOLE_NBCON
 for nbcon support
Message-ID: <aSRjtgmr9xKOX1Ek@pathway.suse.cz>
References: <20251121-nbcon-v1-0-503d17b2b4af@debian.org>
 <20251121-nbcon-v1-2-503d17b2b4af@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-nbcon-v1-2-503d17b2b4af@debian.org>

On Fri 2025-11-21 03:26:08, Breno Leitao wrote:
> Add optional support for the nbcon infrastructure to netconsole via a new
> CONFIG_NETCONSOLE_NBCON compile-time option.
> 
> The nbcon infrastructure provides a lock-free, priority-based console
> system that supports atomic printing from any context including NMI,
> with safe handover mechanisms between different priority levels. This
> makes it particularly suitable for crash-safe kernel logging.
> 
> When disabled (default), netconsole uses the legacy console callbacks,
> maintaining full backward compatibility.
> 
> PS: .write_atomic and .write_thread uses the same callback, given that
> there is no safe .write_atomic, so .write_atomic is called as the last
> resource. This is what CON_NBCON_ATOMIC_UNSAFE is telling nbcon.

Makes sense. CON_NBCON_ATOMIC_UNSAFE also explains why target_list_lock
need not be synchronized with nbcon context locking [*]. The _unsafe_
.write_atomic() callback might be called only by the final
nbcon_atomic_flush_unsafe() when even the nbcon context
synchronization can be ignored.

[*] For example, see how port->lock is synchronized with the nbcon
    context by uart_port_lock() wrapper.

> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -369,6 +369,20 @@ config NETCONSOLE_PREPEND_RELEASE
>  	  message.  See <file:Documentation/networking/netconsole.rst> for
>  	  details.
>  
> +config NETCONSOLE_NBCON
> +	bool "Use nbcon infrastructure (EXPERIMENTAL)"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  Enable nbcon support for netconsole. This uses the new lock-free

Strictly speaking, it is not lock-free. The main feature is that it is
threaded so that it does not block the printk() caller.

Nbcon consoles also support synchronous flushing in emergecy situations.
But it does not work with netconsoles because they do not support
atomic operations. They are flushed only by the final desperate flush
in panic() when all locks are ignored.

> +	  console infrastructure which supports threaded and atomic printing.
> +	  Given that netconsole does not support atomic operations, the current
> +	  implementation focuses on threaded callbacks, unless the host is
> +	  crashing, then it uses an unsafe atomic callbacks. This feature is
> +	  available for both extended and non-extended consoles.
> +
> +	  If unsure, say N to use the legacy console infrastructure.
> +
>  config NETPOLL
>  	def_bool NETCONSOLE
>  
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index f4b1706fb081..2943f00b83f6 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1724,6 +1724,57 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  				   extradata_len);
>  }
>  
> +#ifdef CONFIG_NETCONSOLE_NBCON
> +static void netcon_write_nbcon(struct console *con,
> +			       struct nbcon_write_context *wctxt,
> +			       bool extended)
> +{
> +	struct netconsole_target *nt;
> +
> +	lockdep_assert_held(&target_list_lock);
> +
> +	list_for_each_entry(nt, &target_list, list) {
> +		if (nt->extended != extended || !nt->enabled ||
> +		    !netif_running(nt->np.dev))
> +			continue;
> +
> +		if (!nbcon_enter_unsafe(wctxt))
> +			continue;
> +
> +		if (extended)
> +			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
> +		else
> +			write_msg_target(nt, wctxt->outbuf, wctxt->len);

If you accepted the rename in the 1st patch then this would be ;-)

		if (extended)
			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
		else
			send_msg_udp(nt, wctxt->outbuf, wctxt->len);

> +
> +		nbcon_exit_unsafe(wctxt);
> +	}
> +}

Otherwise, it looks good from my POV.

Best Regards,
Petr

