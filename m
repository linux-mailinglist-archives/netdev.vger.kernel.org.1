Return-Path: <netdev+bounces-156298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0858A05F89
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3771A1888FAC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685142AA6;
	Wed,  8 Jan 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JhHrEems"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E6B644
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348567; cv=none; b=S75Y8wElanZBA5pDuZQEqlByWXeiWdH0M8rm3hw79LECvNXigowIPG6i2wzKdqpUllKhGsDdtCQk+vPmej1FYtsxIoFHW8rxMYxn2YV+/uLLJtYDZCuzKvtVZM2W9jmT+Z9y4XvoGBNmtbSISC9uiZkoQtb9ep6am3bvr07kAMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348567; c=relaxed/simple;
	bh=Frrx/E3SuJfhwms2dm75wVberjLbOAytg3q3nyw1Iug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMj6qhOM+LbLl/m7PvUsu+Y1fpNx1Crq301U0bHsu+iH5QcHpb98zU/jhEAuPN8kXuouFseQ76DWf3oWIOOvKz4eQkg7ppVr8gJE34cLcNvB8787zEThYbYS9el1DAxNl7/CaCWO9L5f/UL2oFGGq7ZUxWwcnnjhl23p6DmQM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JhHrEems; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so24906900a91.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1736348565; x=1736953365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbHsC10Utv8sWKbVPg0ICTtaSGgRiXVLHD7HJg6VqLc=;
        b=JhHrEemsKgolVarHetKfQcTzBIuw3JKsaAgsA0FmaTHT7WYNhsBSnK5PyVfoAEYpAO
         M9j9Xi3/48BrHM8863Seo8Y0/AaSxidP97Hbssoj2InSycqKDtnFzkTRaLktTK6T646P
         J1hc7gdkp77gM0XHh+ZYQxO7djJwTKqBwNH6PA/XIX302s0/SLy9bh5YONVIx+qPV5tW
         FmiXLFlbLlp95MxMDT+VWQ6HI9y/752t8THCcQW4lGL4ubmM6EsMwxVEDGls1bLVpfwK
         Ll+2+ISB7YZwDMsI6ZXkWuP55uQLTH1UPsdOBPQuvUagM/ONXzYKM7KRoSWZmwcJr/1g
         y1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348565; x=1736953365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbHsC10Utv8sWKbVPg0ICTtaSGgRiXVLHD7HJg6VqLc=;
        b=rK535J9mYEWIXuck9aqkXtR4je2TRwU7Th5uMFrRGGhpNp3cPlfuI4JF38qvBTVS3B
         ecP4oHt6UzvTTLIowSXHmDHm50HCpllYr0TL/md3cCjtpBa2pzlz/eIjdR8XLd77a4Qw
         aiuTdUPUlAtJPvvy8xf8LGhyBtz097KCHaqIcFDUuAQN2ju/PXTlhOVcthyJrNDeE4xt
         2eHnSUqdlm4yQnNTYSDYR/Qj8cWhFXpPLiVKBEjB3kmZ1dt0DOVntdBAIcLq9TESfWIZ
         9/7YHcydmXJoFNtHXkuuvk/TXU6nvENSsFU3jMiRHPUXpqhTOqnOI89FO6SVqJLi2L2/
         JRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdBtP8F5q20JCen6InM40DIsGrJ7T+pxx304Sh2Ez3sp4EH36lIsPENi7wrprBk4i6Z/nbhiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEurKQ7rL2fXhVwRLNt/e4loItXQ2o8hKfJiz3bjuWVKLrTvO
	u2Xu7eG28VEBev7/tDd7pSNeyRDA9Y+kIMGCGejgG4+fzObS1lYR+bY0hI5DE/n02RmTu5Pa+Cf
	mtXAxYN/A/Y+NrbGIQd4v2eJJgpOYG1g1rs24nVeQTonzFWrH
X-Gm-Gg: ASbGnctfvtO+JWdSKXtX49VjNQwlk99F0r6M2f5a3HNb1Zqq07ecEl57WN81XVLDdPs
	uNsZPgxJbaeSI7Bhh6zfau+CKlAVtmNub/LOiEFA+UM6jCZaYs0+NH3Eq6mDiBMqp/z3XGbnbnb
	WnV+63gKuh1MQh2vDnez2Od2e24Rq0N5X1RukK2xeVwnwAd5cLcUicFeK89keV9OPa7KecjyHyC
	DY4QspVf2hS3Lid5FWta3cEIff+xzGSRJ438atnTE+sT2w9xKxWiyxjXBYOxmi/HzAPMP+DpLEj
X-Google-Smtp-Source: AGHT+IEiLNxDONmWzGFOs1dt2CAjINsFR3g11b9DiPPat+lRBXux5m70NKoW2Ku2g5fdonnTUmCQHB9APh/l
X-Received: by 2002:a17:90a:fc4f:b0:2ee:6d04:9dac with SMTP id 98e67ed59e1d1-2f548f7ed36mr4091446a91.32.1736348565434;
        Wed, 08 Jan 2025 07:02:45 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-219dca32b8csm19045825ad.133.2025.01.08.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 07:02:45 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ADA543404C9;
	Wed,  8 Jan 2025 08:02:44 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 61604E40152; Wed,  8 Jan 2025 08:02:44 -0700 (MST)
Date: Wed, 8 Jan 2025 08:02:44 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20250103-loutish-heavy-caracal-1dfb5d@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103-loutish-heavy-caracal-1dfb5d@leitao>

On Fri, Jan 03, 2025 at 03:41:17AM -0800, Breno Leitao wrote:
> > For these reasons, allow selection of the egress interface via MAC
> > address. To maintain parity between interfaces, the local_mac entry in
> > configfs is also made read-write and can be used to select the local
> > interface, though this use case is less interesting than the one
> > highlighted above.
> 
> This will change slightly local_mac meaning. At the same time, I am not
> sure local_mac is a very useful field as-is. The configuration might be
> a bit confusing using `local_mac` to define the target interface. I am
> wondering if creating a new field might be more appropriate. Maybe
> `dev_mac`? (I am not super confident this approach is better TBH, but, it
> seems easier to reason about).

Do you mean creating a new field called dev_mac which replaces
local_mac? I do agree that naming is a bit better but I'd be worried
about breaking programs which expect local_mac to exist. Having the
field go read-only --> read-write via this change feels a lot less
disruptive to preexisting programs than renaming the field.

Or do you mean creating a new field dev_mac which will live alongside
local_mac, and letting local_mac keep its existing semantics? It feels
like that would lead to messier code, since dev_mac's semantics are kind
of a superset of local_mac's semantics (e.g. after selecting and
enabling a netconsole via dev_name, local_mac is populated with the mac
address of the interface and we'd probably want the same for dev_mac as
well).

A third option would be dropping the configfs changes altogether, which
I'd be okay with - as I highlighted in the commit message, I suspect
this interface is far less likely to see real use than the command-line
parameter. A downside of this option though is that automated testing
becomes difficult, as we can't write a variant of netcons_basic.sh
without configfs support. We'd have to have a test which uses the
parameter directly, and I'm not sure if we have a testing framework for
the kernel which would support that.

Let me know which option you think is best, and I'll move forward with
it in v2.

> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 4ea44a2f48f7..865c43a97f70 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> 
> > @@ -211,6 +211,8 @@ static struct netconsole_target *alloc_and_init(void)
> > +	/* the "don't use" or N/A value for this field */
> 
> This comment is not very clear. What do you mean exactly?

I wanted to maintain the invariant that when setting up a netconsole, at
most one of dev_name and local_mac is set to a meaningful value, as
otherwise we'd need to implement and document some sort of priority
system when it comes to selecting the local interface. This invariant
requires having a designated "invalid" value for each field - it's the
empty string for dev_name and the broadcast mac for local_mac (for
backwards compatibility purposes, see below).

> 
> > +	eth_broadcast_addr(nt->np.local_mac);
> 
> Why not just memzeroing the memory?

That could work, but we kind of had an unwritten rule that the broadcast
address was the invalid value for local_mac in the code before. For
example, when creating a brand new netconsole via configfs:

# cd /sys/kernel/config/netconsole/
# mkdir test
# cat test/local_mac
ff:ff:ff:ff:ff:ff

So I stuck with the broadcast mac address for the local_mac "invalid"
value.

ACK on the rest of the comments, I will address them in v2 once we have
clarity on the above issue.


