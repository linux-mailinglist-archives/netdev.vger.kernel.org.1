Return-Path: <netdev+bounces-163808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB75A2B9EC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57521617A6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7714B959;
	Fri,  7 Feb 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LusWOKc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458122417C9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738900212; cv=none; b=CPmDzkVCGyPxaM/7TLHmIAadC13+eKBY3/1hw4/w2ioNEzEzdC3XM3EVJ8ejk0v8ylvRYuh4vsGdBlHqSeI0UCXoRZv/ugbmAy44tU9aKutt0vMsm4RS9FoqV2rq2PrcFSgL2nugK9lks+GdYpVaX5OeHOjJMukrY6CbVYLJftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738900212; c=relaxed/simple;
	bh=00STvQOrTVpW46eR0C7TF+dutc2HTMudAo2M4N2hvJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOv58hoY8/GHLSsKVcgr9+vpbY0ksqqrOrsaX7FAbLY9VZ8PcymXJP09wO4Mb2BBbCka/KTaGRcIVPTj9asMYft4S6nGMRZT3UpCgd4pCmXkZ+4ZsWjSCLYIZBUAlJtN3E6f4jWWrWA52kx5uEs2SqsWytA2gHst5/gnkoFJGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LusWOKc0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f3e2b4eceso23825375ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738900209; x=1739505009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99Y3RHw9IoGyu/OHmGZfzS93VmrKyz4eApsN452oSVg=;
        b=LusWOKc0BSI3EwrMParrI4r1okFcbVEPnPFIIiog8JuR+eoCKPCcuQQUeGpv1PUrsA
         waMt+2sbD7kiEHNq4YHXgmcf37MTHLrTNiB/t2sM2t1d3p10Mq9X1vQartKTlM+eqcNs
         Xzj5xSZzDoDaL/yZipsqIlBBYXqPUdVV1q+zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738900209; x=1739505009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99Y3RHw9IoGyu/OHmGZfzS93VmrKyz4eApsN452oSVg=;
        b=icn/bEEJXxYdXEQIbBQWfpC9S9+5nQEXd3ObcGpkqmpp1gAXwXdoPeAwnLogl08aRH
         kDZYV+H/YkJH0NdfMaBI3vKJXL+lmQW1952eddcmyyk3akJCAfv21rwwBaIhEYXbOxj7
         ifEv0uSqsZXKv4DFVvpsIIWbWXgMCFSwedYQTgGBDU+EjA8afJlVO2rj/ugKP/6HdJG1
         OlzlJ9rVNEDQx8F/PmG+OcJPpFsWJY1blTz3yHKlETcF5LZXx3r+DGNsZ7wmWQOQqxoi
         7k1Ft77gdau5076lAjtOzG0uk4J1/ksdnQppwxaIM1NMeniYJ87QIRBUAA2sxb7j9FsN
         YRNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPcGTnAod8sSCk3P6PBb62L/dk4+dY6HURBo333OdLofKVEj8g84VpbmllesejRYfm+QEXcHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlX/gEXkLo8H2QVcmg2v+WGKfBWV8mpfP5HF5a9JSEip2nNRP
	/0mbw9YJp4rHv7BUeYYoe9yKMdTKZcfLRLlS3DK0R2tB/EW5GudHIW8L5mgj2Y0=
X-Gm-Gg: ASbGncvmVl8v2KKC5YPAyEG6whLRZsVVYlyRqlnbJH5j0mEFswtnIz+LRjFnz0FMp6a
	HiAdqL556ory5p26FPOO8Cp8R1FMXGE791qefR4joOH2G1JS+olLKkxVsyC0Evo2gsUwxy/mr+E
	K4/Du6DYZrTfSV5SMlCai9BH2/P0qkYgxSpw/k0a+9V06z5SjthcOeft2jG70VuGdRWNarnfxVT
	N0eJielOFD9lvhXFUG3KH+hgotenYHuN+vUr0l0fklZUwOna2J2xzpOlG87dR6ZH+GwUt/8AlHu
	0WddSDgfPpZlk6GWpTd6PMaUkiC3jJf/uHtB5hz9mUMI86F+THJOgpvPEQ==
X-Google-Smtp-Source: AGHT+IFXhGzujin8U2lkl/+6f0Xg7mbxdgeKJhC5Pl3A5Mw/zCHhPvIvtRyQq/bgDmb+DOpU8dOV8A==
X-Received: by 2002:a05:6a21:8dc8:b0:1e1:9bea:659e with SMTP id adf61e73a8af0-1ee03b76d38mr3507993637.35.1738900209311;
        Thu, 06 Feb 2025 19:50:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d4a0sm2093394b3a.15.2025.02.06.19.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 19:50:08 -0800 (PST)
Date: Thu, 6 Feb 2025 19:50:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6WC7rysltAFwhJI@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <Z6LYjHJxx0pI45WU@LQ3V64L9R2>
 <Z6UnSe1CGdeNSv2q@LQ3V64L9R2>
 <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>
 <Z6U8Smr1rwMDHvEm@LQ3V64L9R2>
 <CAAywjhQ+KBTaqQ=jtOtpx9+82ToOid5n06+NdqLX_iDhH7SQcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhQ+KBTaqQ=jtOtpx9+82ToOid5n06+NdqLX_iDhH7SQcA@mail.gmail.com>

On Thu, Feb 06, 2025 at 07:13:00PM -0800, Samiullah Khawaja wrote:
> On Thu, Feb 6, 2025 at 2:48 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 02:06:14PM -0800, Samiullah Khawaja wrote:
> > > On Thu, Feb 6, 2025 at 1:19 PM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
> > > > > On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> > > > > > Extend the already existing support of threaded napi poll to do continuous
> > > > > > busy polling.
> > > > >
> > > > > [...]
> > > > >
> > > > > Overall, +1 to everything Martin said in his response. I think I'd
> > > > > like to try to reproduce this myself to better understand the stated
> > > > > numbers below.
> > > > >
> > > > > IMHO: the cover letter needs more details.
> > > > >
> > > > > >
> > > > > > Setup:
> > > > > >
> > > > > > - Running on Google C3 VMs with idpf driver with following configurations.
> > > > > > - IRQ affinity and coalascing is common for both experiments.
> > > > >
> > > > > As Martin suggested, a lot more detail here would be helpful.
> > > >
> > > > Just to give you a sense of the questions I ran into while trying to
> > > > reproduce this just now:
> > > >
> > > > - What is the base SHA? You should use --base when using git
> > > >   format-patch. I assumed the latest net-next SHA and applied the
> > > >   patches to that.
> > > Yes that is true. I will use --base when I do it next. Thanks for the
> > > suggestion.
> > > >
> > > > - Which C3 instance type? I chose c3-highcpu-192-metal, but I could
> > > >   have chosen c3-standard-192-metal, apparently. No idea what
> > > >   difference this makes on the results, if any.
> > > The tricky part is that the c3 instance variant that I am using for
> > > dev is probably not available publicly.
> >
> > Can you use a publicly available c3 instance type instead? Maybe you
> > can't, and if so you should probably mention that it's an internal
> > c3 image and can't be reproduced on the public c3's because of XYZ
> > in the cover letter.
> >
> > > It is a variant of c3-standard-192-metal but we had to enable
> > > AF_XDP on it to make it stable to be able to run onload. You will
> > > have to reproduce this on a platform available to you with AF_XDP
> > > as suggested in the onload github I shared. This is the problem
> > > with providing an installer/runner script and also system
> > > configuration. My configuration would not be best for your
> > > platform, but you should certainly be able to reproduce the
> > > relative improvements in latency using the different busypolling
> > > schemes (busy_read/busy_poll vs threaded napi busy poll) I
> > > mentioned in the cover letter.
> >
> > Sorry, I still don't agree. Just because your configuration won't
> > work for me out of the box is, IMHO, totally unrelated to what
> > Martin and I are asking for.
> >
> > I won't speak for Martin, but I am saying that the configuration you
> > are using should be thoroughly documented so that I can at least
> > understand it and how I might reproduce it.
> I provided all the relevant configuration I used that you can apply on
> your platform. 

Sorry, but that is not true -- both due to your below statement on
IRQ routing and thread affinity being provided later and your
agreement that you didn't include version numbers or git SHAs below.

> Later also provided the IRQ routing and thread affinity
> as Martin asked, but as you can see it is pretty opaque and irrelevant
> to the experiment I am doing and it also depends on the platform you
> use.

[...]

> > > >
> > > > - I have no idea where to put CPU affinity for the 1 TX/RX queue, I
> > > >   assume CPU 2 based on your other message.
> > > Yes I replied to Martin with this information, but like I said it
> > > certainly depends on your platform and hence didn't include it in the
> > > cover letter. Since I don't know what/where core 2 looks like on your
> > > platform.
> >
> > You keep referring to "your platform" and I'm still confused.
> >
> > Don't you think it's important to properly document _your setup_,
> > including mentioning that core 2 is used for the IRQ and the
> > onload+neper runs on other cores? Maybe I missed it in the cover
> > letter, but that details seems pretty important for analysis,
> > wouldn't you agree?
> Respectfully I think here you are again confusing things, napi
> threaded polling is running in a separate core (2). And the cover
> letter clearly states the following about the experiment.
> ```
> Here with NAPI threaded busy poll in a separate core, we are able to
> consistently poll the NAPI to keep latency to absolute minimum.
> ```

Is core 2 mentioned anywhere in the cover letter? Is there a
description of the core layout? Is core 2 NUMA local to the NIC? Are
the cores where neper+onload run NUMA local?

I'm probably "again confusing things" and this is all clearly
explained in the cover letter, I bet.

> >
> > Even if my computer is different, there should be enough detail for
> > me to form a mental model of what you are doing so that I can think
> > through it, understand the data, and, if I want to, try to reproduce
> > it.
> I agree to this 100% and I will fill in the interrupt routing and
> other affinity info so it gives you a mental model, that is I am doing
> a comparison between sharing a core between application processing and
> napi processing vs doing napi processing in dedicated cores. I want to
> focus on the premise of the problem/use case I am trying to solve. I
> mentioned this in the cover letter, but it seems you are looking for
> specifics however irrelevant they might be to your platform. I will
> put those in the next iteration.

The specifics are necessary for two reasons:
  1. So I can understand what you claim to be measuring
  2. So I can attempt to reproduce it

How odd to call this "irrelevant"; it's probably one of the most
relevant things required to understand and analyze the impact of the
proposed change.

> >
> > > >
> > > > - The neper commands provided seem to be the server side since there
> > > >   is no -c mentioned. What is the neper client side command?
> > > Same command with -c
> > > >
> > > > - What do the environment variables set for onload+neper mean?
> > > >
> > > > ...
> > > >
> > > > Do you follow what I'm getting at here? The cover lacks a tremendous
> > > > amount of detail that makes reproducing the setup you are using
> > > > unnecessarily difficult.
> > > >
> > > > Do you agree that I should be able to read the cover letter and, if
> > > > so desired, go off and reproduce the setup and get similar results?
> > > Yes you should be able to that, but there are micro details of your
> > > platform and configuration that I have no way of knowing and suggest
> > > configurations. I have certainly pointed out the relevant environment
> > > and special configurations (netdev queues sizes, sysctls, irq defer,
> > > neper command and onload environment variables) that I did for each
> > > test case in my experiment. Beyond that I have no way of providing you
> > > an internal C3 platform or providing system configuration for your
> > > platform.
> >
> > I'm going to let the thread rest at this point; I just think we are
> > talking past each other here and it just doesn't feel productive.
> >
> > You are saying that your platform and configuration are not publicly
> > available, there are too many "micro details", and that you can't
> > suggest a configuration for my computer, which is sure to be wildly
> > different.
> >
> > I keep repeating this, but I'll repeat it more explicitly: I'm not
> > asking you to suggest a configuration to me for my computer.
> >
> > I'm asking you to thoroughly, rigorously, and verbosely document
> > what _exactly_ *your setup* is, precisely how it is configured, and
> > all the versions and SHAs of everything so that if I want to try to
> > reproduce it I have enough information in order to do so.
> >
> > With your cover letter as it stands presently: this is not possible.
> >
> > Surely, if I can run neper and get a latency measurement, I can run
> > a script that you wrote which measures CPU cycles using a publicly
> > available tool, right? Then at least we are both measuring CPU
> > consumption the same way and can compare latency vs CPU tradeoff
> > results based on the same measurement.
> I am not considering the CPU/Latency tradeoff since my use case
> requires consistent latency. This is very apparent when the core is
> shared between application processing and napi processing and it is
> pretty intuitive. I think affinity info and the mental model you are
> looking for would probably make this more apparent.

FYI: I will strongly object to any future submission of this work
that do not include a rigorous, thorough, verbose, reproducible, and
clear analysis of the test system setup, test cases, and trade-offs
introduced by this change.

I'm not a maintainer though, so maybe my strong objections won't
impact this being merged.

