Return-Path: <netdev+bounces-279411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCEmOIqN4mkc7QAAu9opvQ
	(envelope-from <netdev+bounces-279411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916B41E569
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F5F13010738
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F11934D93C;
	Fri, 17 Apr 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htHi75iS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AE364032
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455041; cv=none; b=LKigzK28G9f8P/OV96fgZltivi6SGRdl4Um3oUO9GRJkTqynkOmhYZNEtYjtS325mtou9dt49mhAMMX++p/45nFKOM0oDj/b+PlNEwFcXweGIs4Y3IFL6IqucsQGCaOWnY4jcdpOjYJzMERhH2Gxqvw34daeFaEdkXSPQRagNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455041; c=relaxed/simple;
	bh=KaFMDCFH9CdumsHQVkzpXcZ16qLlfuRi8NWo/FeNfgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSnedaTLqribmsgMlEuAfpSBEVcXKPJRmr6PGl+jMxXGHK187adqyw0QWLSMAFbpSVm6buK4STmmeujN4WxrhC9uab9JsI1Z9SsfpmMg9rM2RvOhK24fnJi33JhWu+GZHVcAlLoq6mWb9k8LzY79du6YSYg7oHqxgxfcAmVLlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htHi75iS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso12120845e9.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455037; x=1777059837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=htHi75iSbURVMZ6Xk9C/IrGjBnOFBWNfL2XmrCASRM+7fW23utl/LnXbfsSHB5bDuY
         p+JrBm3aDjplc/i+J+r+5z3cqZYRptIqbxLk4d2Fs+yDPu6pdSVhKrJvJ+PsyNXkDq8Y
         g1KMYTwZhGj3NXZxDotQEs15pNW1EocuyHt11lGYxOUqKuT1I0nP1Z3vqRpAp+1nxcdn
         u5qYKEtx9eWSjtv+po3EklPDjX5B4dyPS8B3N301kbz6KWAK7z2PDbb39K3lJoEnTUyX
         97wf6Z+bFsq0LOcC+MBtKcORuqrcPUAoc9J2Btom1LDSSbQv8je6lVjNxJkMmHQyu4UJ
         Av+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455037; x=1777059837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSJKJdhPF/oSEv0Q3RwysZnU9Ji4VqpvQLZ2wVMqphA=;
        b=Tc1tmLUL1hWWXEuWYdrL+8f8OvmYp6tV8d7nS/2doSsaPwSowJhi9CNKuHGojLqIi5
         zGFCURQEhX43FF2iePWgcphudlHDSCldXUtddZ2tnHvAE1Pp0kQCv5KMP8bE90y5EhSw
         2uvw0AGpNzVJ2yo4VPKkdXKdAmjBnCpR3igbgXnx2FMo7vpvKl3MOy43YxjFQZRv3qjS
         vMg+Ighrhj5vcMJzjlwN2lSIZcmMSA+4nIc6y9ROgn1NJe6yZibSBtdgOUf7fMfWT9IZ
         Ag2K69cSGnn9QrAqIHbipAq1yy50xtgbcF0yIPCuflCHrAhfbS7ody756xl7CSwQMhrb
         mQhg==
X-Forwarded-Encrypted: i=1; AFNElJ9/ZoKdmdKA27HXwIDgIH3ZBAjENvA3BVQZ5SrYfONM9qWnDkLR3UG3TtWYzkXewgVdzNVeAnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyJoYqqxiuN2CHW0jUwnwfhZ966rYWcSmMbaqe5SvVoQduNCu
	QjsKje8sXqr6Oq8FtGVvPpRzGNb3fxnlqJna4uJZ0/5orTUhK9ZZ6cdS
X-Gm-Gg: AeBDiesX3ToKfDJs1rOEMgflD6bBzHrtMkvWs3gwKHVd9udemyvwN8Xk/3f+oOPZzJ0
	2ND6JfFsMF7CNFDLLf85QcQRPIePuEl//TPQHJjt0IFOO0aduAgdXZYayRzEKyc00luSZ2+efF2
	fNnVtEf+2SG844r67yTPOwnPoWDmN+w1gm6cCZkwsiVM0CrJaqq6hZxPwL3sVaObbPRvD/1J5ao
	A2OdIkukTD62sJsngs3gRWzKoG6A5NFJj9EfRjRp0lUC7iZ7x+VUPK6Q+S7R0aOpdztOw5XDnhv
	mJ93Th+f6p3pFAQ9ZaE1dT9PglUIOzAhRW+N082SAlyB1I0udJ3dH1KoebtDvbu03GZQ0ZiBL7A
	+QeE1yVsOvXTT/aC+A4HcEMKFJk1zh7SQZQgDBAD3C45es1inzdWYD/MFa0nBqcDfhkOApCjVCD
	Vc38vWH10gi6vchKQB2wlaxTpXwtIs112222I3O9jT7AGvs/GUz1grk42jX8+/B1Wb61uHjBC9v
	rs=
X-Received: by 2002:a05:600c:1c11:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488fb782a93mr63697245e9.21.1776455037158;
        Fri, 17 Apr 2026 12:43:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc11ced7sm58174535e9.0.2026.04.17.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:43:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:43:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede
 <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@Stromeko.DE>, Ben Collins <bcollins@watter.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260417204355.37fd960d@pumpkin>
In-Reply-To: <20260417173621.368914-2-ynorov@nvidia.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 0916B41E569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 13:36:12 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> The bitfields are designed in assumption that fields contain unsigned
> integer values, thus extracting the values from the field implies
> zero-extending.
> 
> Some drivers need to sign-extend their fields, and currently do it like:
> 
> 	dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> 	dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> 
> It's error-prone because it relies on user to provide the correct
> index of the most significant bit and proper 32 vs 64 function flavor.
> 
> Thus, introduce a FIELD_GET_SIGNED() macro, which is the more
> convenient and compiles (on x86_64) to just a couple instructions:
> shl and sar.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/bitfield.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 54aeeef1f0ec..35ef63972810 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -178,6 +178,22 @@
>  		__FIELD_GET(_mask, _reg, "FIELD_GET: ");		\
>  	})
>  
> +/**
> + * FIELD_GET_SIGNED() - extract a signed bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:  value of entire bitfield
> + *
> + * Returns the sign-extended field specified by @_mask from the
> + * bitfield passed in as @_reg by masking and shifting it down.
> + */
> +#define FIELD_GET_SIGNED(mask, reg)					\
> +	({								\
> +		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET_SIGNED: ");	\
> +		 ((__signed_scalar_typeof(mask))((long long)(reg) <<	\
> +		 __builtin_clzll(mask) >> (__builtin_clzll(mask) +	\
> +						__builtin_ctzll(mask))));\

Have you looked at what that generates on a typical 32bit architecture?

It really a bad idea to use __signed_scalar_typeof() on anything that isn't
a simple variable.
The bloat from all this when 'mask' is an expansion of GENMASK() is horrid.
Indeed both signed_scalar_typeof() and unsigned_scalar_typeof() should
really not be used - there are generally much better ways.

In this case you can just write:
	({
		auto _mask = mask;
		unsigned int __sl = __builtin_clzll(_mask);
		unsigned int __sr = __sl + __builtin_ctzll(_mask);
		__builtin_chose_expr(sizeof(_mask) <= 4,
			(int)(reg) << __sl - 32 >> __sr - 32,
			((long long)(reg) << __sl >> __sr)
	})
and let the compiler do any more integer promotions (etc).

I'm also not convinced that the checks __BF_FIELD_CHECK() does
on 'reg' are in any sense worth the effort.

I have tried some simpler alternatives, eg:
	!__builtin_constant_p(reg) && statically_true((reg & mask) == 0)
however that throws up some false positives due to some of weird ways
people have used FIELD_GET() where it is nothing like the simplest
(or most obvious) way to do things.
That might have been the code that split a 32bit value into bytes
in a printf with:
	FIELD_GET(GENMASK(7, 0), val), FIELD_GET(GENMASK(15, 8), val),
	FIELD_GET(GENMASK(23, 16), val), FIELD_GET(GENMASK(31, 24), val),

	David

> +	})
> +
>  /**
>   * FIELD_MODIFY() - modify a bitfield element
>   * @_mask: shifted mask defining the field's length and position


