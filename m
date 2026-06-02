Return-Path: <netdev+bounces-294295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AQN7GLoIH2qldwAAu9opvQ
	(envelope-from <netdev+bounces-294295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:45:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90C630567
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z5AcGBye;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294295-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4410F3041BAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C936DA04;
	Tue,  2 Jun 2026 16:38:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0936DA10
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:38:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418289; cv=none; b=hfoudZ/3LIcIf0IjV002UjZ2UdNz+BpYM4ZDliybwyPQ1g7TLXdlm/wwCnUjIMZGpr6V28B/lG/zCbag+F9Lnb05J2vRAQqjhbT+MpUOcdoQpO6YD2uAHpK50qgAqIVFCMiSeDfa8Psewg51z342/nKndcN81LcvcwkLtUnmhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418289; c=relaxed/simple;
	bh=6lwMj5puIzYxtJhOnreQCwSsjBleqxKH7WnH3suKEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYJupsin0UfRgCQ4schNptXtadmlk1aR60fzwu007YqyBZPlizjxwLZO/MG+fdB2Yp+Y+nMM/GL+1u+LoedlF5+Qf+1b1T6B2G65kquJ5pMm/150Yh9fxuselezm+64SGdeyiYvkxQSeFHNgCkOmQhzPRAFkgW3qs1R4QxVndXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5AcGBye; arc=none smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bf046d4da1fso24528766b.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418286; x=1781023086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqWMz0UgTcuvnndiKiX3FpXg1waBM1w5fhEuay6x95A=;
        b=Z5AcGByerqnphvY4FxcjfYt/hR3nVWvMk0t5n3Q+vrktVybVUUeLri3cwq/lDs1ZMQ
         Eo6u2XA3kD6mk/3NsmNqusiSnCm/ZRjuTwBrsE0dkndLNGEVbRa+wmbc32o304klKalZ
         g7morrA4PtVjmeskuyCvdZuBTgBRfC89Jooho+5SMwQNh4sObMRHWgh+P3MDUNu0GDyj
         ff53OPQaAKTOp2gSZxjQTB114qlHwEbPkIIaYvVIn0jOWAyVAEWssY08SJnYzq+ACwrf
         m9z/UIJo68m4qGQKKEzSoJfCsUl/dJ4UdQEmKVio9iOR6Rs7N3DU5znPi9lqN83tLQAs
         wHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418286; x=1781023086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqWMz0UgTcuvnndiKiX3FpXg1waBM1w5fhEuay6x95A=;
        b=VSueY9mEfNz5eG1/0oRoljTAU+j7rxhoxKEG3JWDw6TbDA7hlGp+BQxapG0DCp3tG8
         C8mMWsjqL7XwRGo9xgYNqwhLooMgHPyKJWPLbuewRuQGySgES5W8C3d7x8NL7g2ZGukO
         lB1O8AYVZA08t3G3QN7kILk/BjrwDaeGF9mUr0iq9aDe6dIg/t9bfSXchN2a92FLpcj2
         Z1SKHg6jdNwOVs+v/CTL3/Hh1QRDAqqN6a5tMxtQu+bOJUZ+EXj4R8gwyq2hBRbLr13Q
         y1cm5saGofwrqkEJSl7REoMNNvItOxneLtrwMkejtFRZVyptoAvJp3wv34TspcMEqU2K
         X93A==
X-Forwarded-Encrypted: i=1; AFNElJ/4rpLHDXeQ71MjIkivAo1zNZu6H6C1TKGdY6P4dIYFb0sMWw0CFVD9JF5ZJRCHrydIruIp6Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjQIf/rvGiKRhDKuJh+Nh+zZ30Z/CTbNWidS0YeUVdwNfxEix
	gLXA9uNapXEdOkUgfo7Okn5xKQaHodVIXN5biRGi0fEJU9vbR1qq4rpmT8u7v+DG
X-Gm-Gg: Acq92OFV2QzcCDXOZVaDSmPKoz8sDgHfNjTxTsFZHLrqielQy7PZZPz+yMLtJG3nvjf
	Mf9/Lnkagz5LjiM0j7Vur4+ItZYNG+V9wvrkZe8AxA2ZeGvpR8a+qKo/wZsXoXdBGnGl4mcLDDs
	smwDrIcNOhyb3jQecKRMgMgyY4nWFk8V6KFahZPPTc87nLJQAAnvUVf4EqJrpNte6dq/+MT56NF
	/jzMYrVTrUW8QEf889O5xMj5r/iKyZcW+uLLqbpzjW53zSpgLxzHzE1wNezx+L1rp07UNAD3YF+
	7CBnhJcN+QvvUoY7s/yXMxvP7Atfga2NJYIElAxok+NqKDvvYR0v86aVeu5hmHJjhc/p7EesfY7
	NLM5lDocEUG6E5v1YkZyuoNjk++G7Z+fIlNwFmvCOp3Gg9t9gpPE1Ls4LsEAsvxqdGpgbx1fyV/
	V7i1GfJf1vH3Dd4LeIVpV5X2FqTBodannFY9cCJoYs/J4A6A==
X-Received: by 2002:a17:906:ee81:b0:bec:157:a63a with SMTP id a640c23a62f3a-bf05e3c4d6emr19401366b.1.1780418285576;
        Tue, 02 Jun 2026 09:38:05 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9c499sm15361466b.22.2026.06.02.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:38:04 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:37:56 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260602163756-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
 <20260528142851-oscmaes92@gmail.com>
 <20260528080748.3e74355f@kernel.org>
 <20260528170510-oscmaes92@gmail.com>
 <20260528121210.40b0e493@kernel.org>
 <20260531165140-oscmaes92@gmail.com>
 <4b5bc4b7-9921-42ac-bf87-a5009f561443@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5bc4b7-9921-42ac-bf87-a5009f561443@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294295-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A90C630567

On Sun, May 31, 2026 at 10:09:44PM +0200, Andrew Lunn wrote:
> On Sun, May 31, 2026 at 06:51:40PM +0200, Oscar Maes wrote:
> > On Thu, May 28, 2026 at 12:12:10PM -0700, Jakub Kicinski wrote:
> > > On Thu, 28 May 2026 19:05:10 +0200 Oscar Maes wrote:
> > > > On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> > > > > On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:  
> > > > > > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:  
> > > > > > Intel x86  
> > > > > 
> > > > > LOL. Please. Which _hardware_ platform.
> > > > > Or to ask more directly - is it QEMU.  
> > > > 
> > > > It was indeed tested on QEMU.
> > > > Either way, the performance measurements were just a sanity check.
> > > > Changing the code to use the modern API is just better.
> > > 
> > > Please don't waste our time with optimizations to unused code.
> > 
> > It's not unused code. VMware emulates this device by default in some cases.
> > I've encountered it when installing QubesOS in vmware which is based on
> > relatively modern Linux.
> 
> There is a saying: If it is not broken, don't fix it.
> 
> "Changing the code to use the modern API is just better" if not a good
> enough reason on its own. Using older APIs does not mean it is
> broken. It does not need fixing. Some percentage of changes like this
> break stuff.  We Reviewers/Maintainers need to look closely at such
> changes and decide if it does actually break stuff. And we want to
> know what the return on investment is? I would much rather spend my
> time reviewing new drivers for hardware which currently does not have
> a driver.
> 
> So, if you say something like: I'm using this driver daily for X. I've
> spent some time optimising it, and with this change, my use case gets
> a 10% increase in performance. Here are my numbers....
> 
> That gives us a better feeling that you have extensively tested this,
> so it is less likely you have broken something. You can also show
> there is a real improvement. So the change is actually worth while.
> 
> 	Andrew
> 
> 
> 
> 
> 

Fair enough, I appreciate the input.
This change isn't a big deal to me, so I guess we can drop it.
I'll make sure to keep your advice in mind for future patches.

