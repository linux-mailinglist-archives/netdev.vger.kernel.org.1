Return-Path: <netdev+bounces-280425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AQyLpbN6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:31:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F10446C10
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDF463070E4F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C9381AF5;
	Wed, 22 Apr 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSMG9wHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94C3ECBD7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864190; cv=none; b=pzfBm6690id4m7zxqvc1uGI2GOcAIbTk7VxCn4odVvZR2+AN7AeRMtgq3LZisL9VnXpIYgdgPd2pzyiOYdNtdggnc6h+r591Es4d4vcdlp9TKAc7VQN790tgvxaQWe2qvUdqJLV23IWe8abRxrcfAX/vtYUojuLDDd0Jqc5Hfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864190; c=relaxed/simple;
	bh=TLOu7d6PEufyhJW1gftp1KKhfOJsLSxahWuKn4GauW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLlgHyGnuuoxPvjX4nVt1jvfbLmOz1m1vbdtHS4vH/y6Bb4tGRBZC4Je75Q16eYZGZy6oEUaettwMAGaZUbVSdquJrqK66WKfG6cu3qiSDSZrPBB3eENGYzDCc3vAZiZpIpl3QW+EXmz3J2V0WQu6VK6yhRb0NRCPwp9mYsuCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSMG9wHq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e538decso53654217b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864185; x=1777468985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3NmYgdWW12B1Wn2igviOU+gqNcSGYOouIwQpeCD82o=;
        b=gSMG9wHqpaajv86pcXf8hHiwqy4X+Aq2CmAh1pbJgV1j0qsn2pdPgMcGMiHSturq+X
         d+dZP8YZ++Pg3I4KIsYybc/X0XwN2mVDXW6bgkAk2tj0GcfQPng4pQOImIXeCdF+bKck
         j9QAUGh3Gvx5Y1Jzl2bhogszMpXD9JfyV5dXOuQzYNjYVNyJF0daXf6As3jJazyCI9nf
         eUGk0+7033XARzzpmX5bBgyw4qCQTam2a6NVT0ECjrB3rh61zeDZos5vX8EV3TolRoVN
         eCzd4s7xs+2NQ5Ih9uM9i+ULRPpROOyIRyTuYbbSxdvWmILaNIc4QS1YRrGZi7CJR+a3
         vGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864185; x=1777468985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3NmYgdWW12B1Wn2igviOU+gqNcSGYOouIwQpeCD82o=;
        b=PcZu04LKnccLKHU7MFBzZi/8J5QeP+rilwuCqpFuYV/ghW9x/g7E4UK+ScjashhQ1l
         vo5u75Jjn7ItjVkKO21Fx3jTPJlDWSjxoOS4Z2YWj15yR2Yhf8LHRYDDIxatT9ybcoSF
         OaMI0r0iZjeAZ3DNM/aadYl1HeBfyPKxzMrRmh4JzBmJToy6DvUyGuW37yrlUPNsqwcm
         z0D5H65ZwA9Ox0qyHvCnbqPXfZEeKLtLL2jcqK51ma5u/U8uTukxR9v69kfxZ1vTlboL
         ECJ9mJJRPMF3XCP8RTpYlbMGRzsk23S6re14Jy0m4AVT1Vl20JNpI+1OoGfJmwTeuWcJ
         yM1Q==
X-Gm-Message-State: AOJu0Yyo7oKUoP8EX0368PMxTIp+KlbFoT3ibY4BIxDmzRO34H/uDn0d
	YZTkeZCnRbGzPaRstj27ePhtgi668NvrgWovt+H+VHwWVOqEWW2FxX/5
X-Gm-Gg: AeBDieuv/UnB8NeF9AP619vtKXG4xdUvvF2nxiLAYND++6XCePZEk50Vy0MPoMHlRFg
	USHHF/MueOB3UlSOc+OI00TrwHVUbVO4ZtMpyISOVHmQNxIy0IzCWaICdYVi+7/75UPjLboOmgL
	pMYJaqw6BEKdpeUnXwPQd2qSBXJW6DAJ4X0T8Awx/BXJ5b/OP2kII7CoKFTohUAnwUKjpZByJ2O
	2jADAASKPJDjmXQjG4D4Zz/ynDUE/QZmawGGP4NqsaG8mrjoTRLfA6Hlr8FUeGKdc/mjbBgqH5k
	EmXCe2mrSzl0nYLw+i0fL2hniEdWGx56ZEeMhrAYs5sJ7szrCsnObrjWTKO+7OfnjsKccm0lxMw
	MlvOlOShEPBzftBWM+2z7Jhsf9krKky5FwcaNlVoETf69EEqqGR0Rb4Gn6I9+8BQZFn7Un4WaEj
	+L18sDK+udyiY1t6OtGvQhXOKLwCAUD0WaQgzO1bE=
X-Received: by 2002:a05:690c:6212:b0:79a:b46c:e60a with SMTP id 00721157ae682-7b9ecffd233mr228838177b3.44.1776864184950;
        Wed, 22 Apr 2026 06:23:04 -0700 (PDT)
Received: from localhost ([172.216.252.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89abd7sm67523687b3.1.2026.04.22.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:23:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 16:22:58 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Message-ID: <aejLsqoXKBHwWTbL@stanley.mountain>
References: <CGME20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124@eucas1p1.samsung.com>
 <20260421114029.2689961-1-j.raczynski@samsung.com>
 <aeeFh1zQqhVysvxI@stanley.mountain>
 <aeiHkejLjhRKyj/u@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeiHkejLjhRKyj/u@AMDC4622.eu.corp.samsungelectronics.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43F10446C10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:32:17AM +0200, Jakub Raczynski wrote:
> On Tue, Apr 21, 2026 at 05:11:19PM +0300, Dan Carpenter wrote:
> > On Tue, Apr 21, 2026 at 01:40:29PM +0200, Jakub Raczynski wrote:
> > >  
> > > -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> > > +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
> > 
> > This still isn't beautiful.  There are so many parens.  The !(foo < size)
> > formulation is weird.  The cast is unnnecessary.  Better to write it as:
> > 
> > 	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
> > 		return -ERANGE;
> > 
> > >  		return -ERANGE;
> > >  
> > >  	return aq_to_posix[aq_rc];
> > 
> > regards,
> > dan carpenter
> >
> 
> Alright, will beautify it and resend soon.
> 
> I can see potential original intention of not comparing unsigned from sizeof
> with int, maybe that was original compiler configuration to include that
> warning.

Yeah.  I know.  I wrote a blog about this...

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

Check this out:

$ git grep '(int)' | grep ARRAY_SIZE | wc -l
53

It's as if we want array underflows.

> But at this variable range it is irrelevant and it is probably most disabled
> warning ever.

With the unnecessary cast I had to review to ensure that aq_rc is not
unsigned long type.  There is a real downside to this kind of rule.

regards,
dan carpenter


