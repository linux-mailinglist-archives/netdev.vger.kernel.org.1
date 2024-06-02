Return-Path: <netdev+bounces-99982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DD8D75D7
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC77C1C2106D
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37D2D60C;
	Sun,  2 Jun 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flBG84Cw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E71E864;
	Sun,  2 Jun 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336886; cv=none; b=Ony29ynLCaa58tijXZ0hyaARr7E1AX6b6i9uBBh9pt+DWA0A8V9fjMO1Yxob9K9w4jaRa7pXbadCLSYgczJjikUeB80v3KJgY/VuOV05+RC4eKzZKgCMrvg02icHpePspC2G9Q1RAR2lgjgYBfnEsKTGijTeafJt6752nL+v2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336886; c=relaxed/simple;
	bh=rXhlaE1KPwN/tg+9WhLGhiVLVCMP6hQf3kuAhUJm670=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUJWwhgRr4h91AqfDpPmhnOrjWrz+p6DoDfj6Xh7uCFX4Yp/ugB2WRq8KHsJ8oTKvPzCxro3gILZbG4JpUFE+vkokW1dEjwn/s0GCxtmvTDtPHq4QaTywnxhdzGubs64Zmfa2PrgHWC/vIKDRUJzzr3HE2ZXCrTziPbC/Zi++s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flBG84Cw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso53079511fa.2;
        Sun, 02 Jun 2024 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717336882; x=1717941682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ehNC6eBzEIAWcfNyyiWP7XK1vhhYZoc9B4wyfzemKPA=;
        b=flBG84CwLUeodsRTPfrDNhHrelNz2pG5gd74aAbZPZNjSLG9Ki65VTXkxT4cLhC1Kl
         GcHsTzc+eLpRQpGbnCSgI2Hy6EdgKdfnmacqyd4D3x6Fn1gb5U26O5jCDJsZ8iLS0HyN
         +ilI5OcZuvPScPKL599WP1OmwCp7hCmiekh81hrzgFemkpe9FJc1codj5aB5c0dgrEsv
         q1RCYoK+IL82RHLaMmC3LaeKaTQWpcVqPeGpD9lbD2cYFO+mzSoNaUzy2UJH9JZDM7Ew
         WBcVUHJdhSHko+sE2bQCNUEaQ1UMpg6O14r8HzzBoyyDO5QFIZt6VStn9xp7wkBFwc/b
         9Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717336882; x=1717941682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehNC6eBzEIAWcfNyyiWP7XK1vhhYZoc9B4wyfzemKPA=;
        b=oTq6wed8fRpsC+ujoVAJ0jxrJk2SK7ZEEwHxSqjS1/Kpd8sGmyNapfuwnxT6TW2TEX
         4BkzARAA+M1FRY+k7ABJdjjEWII6MdHyrH5qILXE0KEah9aL61bXMo6B1+NQQfswfsaQ
         10Pj4vMQgG4vyrNLq0hcadpYnxWH8oc+XdG5GujArW8ZSDg6AnoRKgkgB1Xd4YSaYL/y
         vP9GOfwbJ6MEYLMTYxU4F9mqh2gR3qO5eVQzOu/paZK4Sy/9NLBOINT6J+x4AVk8nSNR
         NEouegkAx9QkwfQnQmPJw2i958j97t6igQxErVA5WrWN55SM44yOlcyo2h9R54VXBxZb
         gpsA==
X-Forwarded-Encrypted: i=1; AJvYcCXBODxshYMmRW9/S3r1xzN9jPYq8XPUe3Y2CltO00Tjykw3vHUGjfXinvlbz9RjacX1XJyBt2J1BqJqLBKbiFUkfECsD0ohXM653VKB3mfuSIY8G/8A0b72L5WkNCV9ViIrj0Os
X-Gm-Message-State: AOJu0Yx4xlKAFEAiSrzCSgHshfr42GgvPhZF5rrSq8zusfVNVTB4bdju
	/bwe4+ox0J2CJwBKARv2aEgUCOpWY6Drl4hp5cEr0xd2NRxus2zV
X-Google-Smtp-Source: AGHT+IEONAEpayWsKNGxI6xBA29AOkjRas6J3hQDBlMqLoHmfcDXyh+j1w1XgSSThwLzi04jTVNHEQ==
X-Received: by 2002:ac2:5de5:0:b0:52b:9955:43b3 with SMTP id 2adb3069b0e04-52b99554482mr958370e87.60.1717336881989;
        Sun, 02 Jun 2024 07:01:21 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e611e334sm127669066b.0.2024.06.02.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:01:20 -0700 (PDT)
Date: Sun, 2 Jun 2024 17:01:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com, Simon Horman <horms@kernel.org>
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, vivien.didelot@gmail.com,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
Message-ID: <20240602140118.nnlvydm4dp6wr4c3@skbuf>
References: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
 <20240531190234.GT491852@kernel.org>
 <BYAPR11MB35583B3BA16BFB2F78615DBBECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20240601120545.GG491852@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601120545.GG491852@kernel.org>

On Sat, Jun 01, 2024 at 01:05:45PM +0100, Simon Horman wrote:
> On Fri, May 31, 2024 at 07:19:54PM +0000, Tristram.Ha@microchip.com wrote:
> > > Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
> > > 
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content
> > > is safe
> > > 
> > > On Tue, May 28, 2024 at 02:35:45PM -0700, Tristram.Ha@microchip.com wrote:
> > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > >
> > > > The very first flush in any port will flush all learned addresses in all
> > > > ports.  This can be observed by unplugging a cable from one port while
> > > > additional ports are connected and dumping the fdb entries.
> > > >
> > > > This problem is caused by the initially wrong value programmed to the
> > > > register.  After the first flush the value is reset back to the normal so
> > > > the next port flush will not cause such problem again.
> > > 
> > > Hi Tristram,
> > > 
> > > I think it would be worth spelling out why it is correct to:
> > > 1. Not set SW_FLUSH_STP_TABLE or SW_FLUSH_MSTP_TABLE; and
> > > 2. Preserve the value of the other bits of REG_SW_LUE_CTRL_1
> > 
> > Setting SW_FLUSH_STP_TABLE and SW_FLUSH_MSTP_TABLE bits are wrong as they
> > are action bits.  The bit should be set only when doing an action like
> > flushing.
> 
> Understood, thanks. And I guess that only bits that are being configured
> should be changed, thus the values other bits are preserved with this
> change.
> 
> FWIIW, I do think it would be worth adding something about this to the
> patch description.

I agree the description is confusing and I had to look it up in the
datasheet to understand.

I would suggest something along the lines of:

Setting the SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE bits of
REG_SW_LUE_CTRL_1 does not do anything right away. They are
just one-shot modifiers of the upcoming flush action executed by
ksz9477_flush_dyn_mac_table().

It is wrong to set these bits at ksz9477_reset_switch() time, because
it makes ksz9477_flush_dyn_mac_table() have an unexpected and incorrect
behavior during its first run. When DSA calls ksz_port_fast_age() on a
single port for the first time, due to this modifier being set, the
entire FDB will be flushed of dynamically learned entries, across all
ports.

Additionally, there is another mistake in the original code, which is
that the value read from the REG_SW_LUE_CTRL_1 is immediately discarded,
rather than preserved. The relevant bit which is set by default in this
register (but we are mistakenly clearing) is:

Bit 3: Multicast Source Address Filtering
1 = Forward packets with a multicast source address
0 = Drop packets with a multicast source address

Tristram, now a question to you: why would we want to forward packets
with a multicast source address? It looks like clearing that field is
one of those things which were accidentally correct.

The cleanest way to not make a functional change where none is intended
is to simply delete the read.

