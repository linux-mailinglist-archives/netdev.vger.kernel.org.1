Return-Path: <netdev+bounces-293274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDfjNN4IGmo70wgAu9opvQ
	(envelope-from <netdev+bounces-293274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35143608FE7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B572B305EF21
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25342B751;
	Fri, 29 May 2026 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwgVQbH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B45409605
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091088; cv=none; b=guzP0oquo1c+H8is3hfuU87HqAILp7rsTfqAIUmcwIc2tEGQLnFcW3Plqhy3slsMWJNGs3f95KdN6ziqZTXwS2qlcecjJ/duQqeSVuaRP08DpU4K6ZpMX6b4I2GmtbHHhDd+22vXW+jdabLsP4DBqLp47oWBYLFLsccTzdGDJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091088; c=relaxed/simple;
	bh=9ztBHi69dTvfIbkPqcEl1msz3Fn7k9rrFW2VNPhV/B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIm7IB75ViKgjFd/LEVwbjCxYblGSWnO90kysAiumPVyoG6nNJwfheElv9sxVtnQTPBFVPNHk16SiTfUC3Lz4g/jXk7KTwVQPfPuzk8J1oCBzuWDGVd06cblyBsD5sQshG1zIYrlKQzxQg9xHu5/yUQTeWTvmQS0xJysx52FKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwgVQbH4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso75002615e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780091085; x=1780695885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wclCqKMzu4g1WLNsGWFcKOde7ruW79bP7ckJPFHNnw4=;
        b=fwgVQbH4FyVJHYo/TgVDXeJt0HtCakNScQWx1FvLXcAuXBPKNaI7U1Jd54/hTYq1rf
         YPmV9lZWUIOyeHMJ9O9pCWqFP3gFvPm9xWe9IGCR5kuh9NRfRYnK2UvLmYrVTxsz0hUB
         c6HsLsvICUZrWsdwUdtb0A8fdQJJwUbxJFYkmNujbuXbckOONywIBh2lyrbbBIZpF6Lk
         ADj6uGERGP2rMz61vCK5RUoB3atrsEdLtMAmTH4x9SHOdBNn/fvwDFE3GKOgD44Idv5k
         vEnGmTSzQ9vnD+ZcSLhd5178NDVbINYMSxMHOxIVbcXuNQPMdXewubeIF2W6vY2CiYMD
         XI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780091085; x=1780695885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wclCqKMzu4g1WLNsGWFcKOde7ruW79bP7ckJPFHNnw4=;
        b=LECLKQS+Y2GGq/3VUy+ntF6EHbwmugBWEQh+kmZ1VuIAAaT5o5KYSCD/cgoIDHP1+Q
         c8KFPLqOQDb+v1d5ozRskuOWGT/UjsoVitCki+OVQn1Eq1uncgpjNWMnlTdHRE8kt1vv
         ldFTwEoYCt2vh5BYQvuh9xJR00xUmIv7gT3rqxUWmGg3OPrCHuibp8K/uyKdbwTjECz/
         D+H0/Vtsj3/gpLbzArRVeaI690AsVYfGRGrTudcmqpMjLizEPBnNaDPV4M+jynmh+MWp
         3pddRqTeIPF3ostzoyDk6oqr0TSYsM4NVEpom1Nf1/Q6RPu8OsxzPBnF+t9o4bEHtJh5
         wMXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jo0weCvcOhTqN/1xZw7tnc4/lPg6W34VK0ZYny36Z487/mO/pua1FHbKEzmU4ulTORSl5cKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Cbvi+KBZ2zyuDHilx8vnKflIJR9WsgXzhdSiuisIR2Zvhz6J
	uB79SoqLTCgP01N2mEn4fsSunyOr0YCekD9vRH31/0IjfqFolHRhBVvP
X-Gm-Gg: Acq92OHIhY3rJujkOukB1UC9pfSVfi/SUEXWvyV4OBGoQlfE96OlnsI0XQTNlRjQPEN
	o4IW+nd9kc1KPEprEwPr57fwd9oNvZDeHt9x2WJzNUwUD/rlHhvVw2fkNgioOlm5VbOE8iCJZxE
	Z0lttFJB5EVVoIArYaZ23zAOhbsT3PnkUG20EIzbUIimMifG4sRaSUs5dXJjMn1KEAkVirAIo7A
	hgzj13GG9joae/w1Vi9YOYO4WFb07Y0Hpu419jp81Ec1RftX6PnwFX0rFeOcyzKVra3MIgKGWXw
	92XWhgCGwi9gpVlwnkc/Zq81WcQPbbzYzH0AhTgMDqhtcPQ9Kses8OiMRdb1JcSAM5Lm7ayAtZL
	gkmiGssZxkj7CZ+NBHmwXGrnDsobe2GfwRU6PzEwRp71TezYk3X5ysNn2hnaH6HgahrniVRldDk
	ltP0qC2epRz2AUWVVvqQ5Bvy9mBFvspwSrXiI1H3yBMWbivaFgF2ab7AfF77UKBm3bZMiPRlk7G
	GV1MkHfMg==
X-Received: by 2002:a05:600c:41c7:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-490a293e0c2mr13857975e9.21.1780091084768;
        Fri, 29 May 2026 14:44:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0aecdfsm22172265e9.13.2026.05.29.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:44:44 -0700 (PDT)
Date: Fri, 29 May 2026 22:44:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 06/11] selftests: Fix arm64 IO barriers to match
 kernel
Message-ID: <20260529224442.11d7320d@pumpkin>
In-Reply-To: <20260529192933.GD3195266@nvidia.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<6-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
	<ahiFxtmspbETiqWw@google.com>
	<20260529134947.GA128816@nvidia.com>
	<20260529175516.06d5788f@pumpkin>
	<20260529192933.GD3195266@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293274-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35143608FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 16:29:34 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, May 29, 2026 at 05:55:16PM +0100, David Laight wrote:
> > On Fri, 29 May 2026 10:49:47 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Thu, May 28, 2026 at 06:13:26PM +0000, David Matlack wrote:
> > >   
> > > > Let's put these in tools/arch/arm64/include/asm/io.h so that the tools
> > > > headers are more aligned with the kernel headers, and so that the arm64
> > > > io.h overrides are done in the same way as the x86 overrides in
> > > > tools/arch/x86/include/asm/io.h.
> > > > 
> > > > Something like this (untested):    
> > > 
> > > Okay, the disassembly says it works:
> > > 
> > >     1db8:       ca080108        eor     x8, x8, x8
> > >     1dbc:       b5000008        cbnz    x8, 1dbc <readl+0x58>
> > >     1dc0:       f9000fe8        str     x8, [sp, #24]  
> > 
> > That looks strange, I suspect the C didn't match any usual pattern.
> > Normally 'tmp' would get thrown away and 'v' would get kept.
> > But you seem to have discarded 'v' and written 'tmp' to stack.  
> 
> Oh interesting the optimizer isn't turned on for selftest builds. So
> the str is dutifully writing tmp to the stack. Another register has
> the actual value.

I've never seen any point testing with compilation options that are
different from those used in a final/release build.
Otherwise you aren't testing what you are going to release.
This is particularly true for badly written code that might be
relying on uninitialised stack (etc).

> 
> > I'm probably being stupid again, but how does that work?
> > The cpu can speculate straight through the control dependency into
> > the following instructions.
> > An 'eor x1, x8, x8' may not even have a data-dependency on x8.
> > (Most x86 cpus just generate a zero for the equivalent instruction.)  
> 
> I can't say, this is copied from the kernel and Will made it:
> 
>     arm64: io: Ensure calls to delay routines are ordered against prior readX()
>     
>     A relatively standard idiom for ensuring that a pair of MMIO writes to a
>     device arrive at that device with a specified minimum delay between them
>     is as follows:
>     
>             writel_relaxed(42, dev_base + CTL1);
>             readl(dev_base + CTL1);
>             udelay(10);
>             writel_relaxed(42, dev_base + CTL2);
>     
>     the intention being that the read-back from the device will push the
>     prior write to CTL1, and the udelay will hold up the write to CTL1 until
>     at least 10us have elapsed.
>     
>     Unfortunately, on arm64 where the underlying delay loop is implemented
>     as a read of the architected counter, the CPU does not guarantee
>     ordering from the readl() to the delay loop and therefore the delay loop
>     could in theory be speculated and not provide the desired interval
>     between the two writes.
>     
>     Fix this in a similar manner to PowerPC by introducing a dummy control
>     dependency on the output of readX() which, combined with the ISB in the
>     read of the architected counter, guarantees that a subsequent delay loop
>     can not be executed until the readX() has returned its result.

Hmmm...

Ok so there is some subtlety with the read of the counter that might
make it all work.

It is better to make the delay loop have a data dependency on the result
of the readl().
Something like:
	u32 z = 0;
	OPTIMIZER_HIDE_VAR(z);
	writel_relaxed(42, dev_base + CTL1);
	udelay(10 + (z & readl(dev_base + CTL1)));
	writel_relaxed(42, dev_base + CTL2);
That avoids the potentially mispredicted branch and only adds instructions
when a delay follows.
That sequence is safe for all cpu and doesn't cost much for cpu (like x86)
where it (probably) isn't needed (maybe unless you patch the scale for udelay
into the code so there are no memory reads, just code).

Probably best refactored as udelay_depends(10, readl(dev_base + CTL1)).
Or maybe udelay_after().

-- David

>     
>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Jason


