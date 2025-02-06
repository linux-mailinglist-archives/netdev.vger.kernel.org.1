Return-Path: <netdev+bounces-163690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F98A2B5CF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D891889841
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAF2417FE;
	Thu,  6 Feb 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tAlSLdx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF562417FF
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882128; cv=none; b=cJHANeN9bHxXiAjr0IkDOS53od7Xepd5Zsbwsz6EbQ8lFRZSqMdn7PcgifboquvcnPcwAx6hD50PLRWqsecI88Tkp/XnfLeD/jD1mYJgRAOVLzHW6S7LfPaPyAwcH0FiSVeV1xoD/+Kh10RSasWJSw/Qg0Ul3hQo5Gbt8AA7pMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882128; c=relaxed/simple;
	bh=H8ulpK8eiDZK7VymiNKkMEtdsSQYxyGRFg8I1qGr7oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuBpT1ud2o7mkBro/xcZ1m6uBYRbiEJmFGC71S+dD5FQCZpelOOFroyjL2jlcUkbTVzhWaJN6+4VFfHgYkLwUVdMat3My6UaguhBJ3crwLviglacZeE+7NNUefKe0hn+mU8QnQBSuqXxX7tts9U3MHpc3kvpjMfRhrI1cjDC5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tAlSLdx0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f11b0e580so29325615ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738882125; x=1739486925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWgOSt4p/ZnDXXfO3xp8ZVar5t2U/FbWxOpNVTrj+3o=;
        b=tAlSLdx09oqohZAq+7iHfEjQNwm87vVxWrCegd1+d9wLDcOfx/UtyOfcvGi09NUYmu
         Th0rEhCJ3K4aDxGvOFQk44q6qyJh6L7aL9h6RipfJzw/2Uemb69nZojKxpbaeYTOgEdT
         bKp1kDhuOJAhYDIdP7F+xn4heBiJgKHqSmRqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882125; x=1739486925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWgOSt4p/ZnDXXfO3xp8ZVar5t2U/FbWxOpNVTrj+3o=;
        b=epiRVvktiyHwME46HIyf9CE2Awmsnh+iEi79QV+XI+2SRWUeYRbRB3xoEC7MwerEEJ
         nXSikVX+323ZgSDstUb2w4yD1ik5wDVFtfhPQKZQPQC0JBQq781zzZNpemQy5cAqsdpj
         MPDRN0HOvtzklwW3GXEkrc7BZ//2ZOf24Nfdy9zV0YM1IZjUe5RoMinVRubKEYLdYDvK
         6AUdwuvJMxuLjKeQaTTaw8qxYJtr3BfSOUmCuwCxQzrJ2F+9b2Glj7SfTcYQz01uQLLb
         f3wZymRdb+pa0yCtgBRrL2eKw45IsdQdiJjA4SpuqX3xVSqHo4OAtTtDOb9tNHGYOFG6
         NrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYGjl2KCUbf6WmU1ElVfU+8Cwa6edGFtl2G2MPdp+9J150BtS/G0mBReNltipvoi5Z+0kafuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0h23ALyDaxb7gNOoMVQv3ZkyVGMjy1vkR/XrkAjEA5PII5GrW
	NbXAaaTriC0Ptlz67PDw0IHQ9IEQwehuyLoqpf9jwTXEtM088qB5nVi/cUMP0YM=
X-Gm-Gg: ASbGncuikB6IcxZzN8+8HgclDAUU9HOm5IlBOIAy0XIPiYm/8tcFHLHKYEE8DROqFOi
	X4ikwmLkAL/FYy2Nj8yC8M41gjlEK29KipTbtJFWMmWaZaKfIg3XX69tdMObaFpqj6Sx6W4UhP7
	3GRhcgZOUdLoa6avSD+AYuNGFleyjMMvEoP9osY6o112kD/2LV9OY3vYT3HGUFRq23/poStJIgA
	7lfvC7S5hcaWj/8fu/nrkik/Zyyzbw3KzZ3Iph80abdIsSCEUAzeUQKOHU0CFfcBW/ZxYWkGVvj
	Doe+H5G+N2EAL1V4D2WLtr+Bba/RUsnVJUK2nM5j1bvWqls4AFT7O/h2Mg==
X-Google-Smtp-Source: AGHT+IGZ7Ivga4PcTAXux2AzlAU9Or8FJsTbBFN7AAVsW26k0cvpD2OKJ7KMMAVYlsvhDL/Sznk2PA==
X-Received: by 2002:a17:902:e802:b0:216:2474:3c9f with SMTP id d9443c01a7336-21f4e78104dmr14864505ad.52.1738882125385;
        Thu, 06 Feb 2025 14:48:45 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce16sm18197835ad.9.2025.02.06.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:48:44 -0800 (PST)
Date: Thu, 6 Feb 2025 14:48:42 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6U8Smr1rwMDHvEm@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhQAb+ExOuPo33ahT68592M4FDNuWx0ieVqevBfNR-Q5TQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 02:06:14PM -0800, Samiullah Khawaja wrote:
> On Thu, Feb 6, 2025 at 1:19 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
> > > On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> > > > Extend the already existing support of threaded napi poll to do continuous
> > > > busy polling.
> > >
> > > [...]
> > >
> > > Overall, +1 to everything Martin said in his response. I think I'd
> > > like to try to reproduce this myself to better understand the stated
> > > numbers below.
> > >
> > > IMHO: the cover letter needs more details.
> > >
> > > >
> > > > Setup:
> > > >
> > > > - Running on Google C3 VMs with idpf driver with following configurations.
> > > > - IRQ affinity and coalascing is common for both experiments.
> > >
> > > As Martin suggested, a lot more detail here would be helpful.
> >
> > Just to give you a sense of the questions I ran into while trying to
> > reproduce this just now:
> >
> > - What is the base SHA? You should use --base when using git
> >   format-patch. I assumed the latest net-next SHA and applied the
> >   patches to that.
> Yes that is true. I will use --base when I do it next. Thanks for the
> suggestion.
> >
> > - Which C3 instance type? I chose c3-highcpu-192-metal, but I could
> >   have chosen c3-standard-192-metal, apparently. No idea what
> >   difference this makes on the results, if any.
> The tricky part is that the c3 instance variant that I am using for
> dev is probably not available publicly.

Can you use a publicly available c3 instance type instead? Maybe you
can't, and if so you should probably mention that it's an internal
c3 image and can't be reproduced on the public c3's because of XYZ
in the cover letter.

> It is a variant of c3-standard-192-metal but we had to enable
> AF_XDP on it to make it stable to be able to run onload. You will
> have to reproduce this on a platform available to you with AF_XDP
> as suggested in the onload github I shared. This is the problem
> with providing an installer/runner script and also system
> configuration. My configuration would not be best for your
> platform, but you should certainly be able to reproduce the
> relative improvements in latency using the different busypolling
> schemes (busy_read/busy_poll vs threaded napi busy poll) I
> mentioned in the cover letter.

Sorry, I still don't agree. Just because your configuration won't
work for me out of the box is, IMHO, totally unrelated to what
Martin and I are asking for.

I won't speak for Martin, but I am saying that the configuration you
are using should be thoroughly documented so that I can at least
understand it and how I might reproduce it.

> >
> > - Was "tier 1 networking" enabled? I enabled it. No idea if it
> >   matters or not. I assume not, since it would be internal
> >   networking within the GCP VPC of my instances and not real egress?
> >
> > - What version of onload was used? Which SHA or release tag?
> v9.0, I agree this should be added to the cover letter.

To the list of things to add to the cover letter:
  - What OS and version are you using?
  - How many runs of neper? It seems like it was just 1 run. Is that
    sufficient? I'd argue you need to re-run the experiment many
    times, with different message sizes, queue counts, etc and
    compute some statistical analysis of the results.

> >
> > - I have no idea where to put CPU affinity for the 1 TX/RX queue, I
> >   assume CPU 2 based on your other message.
> Yes I replied to Martin with this information, but like I said it
> certainly depends on your platform and hence didn't include it in the
> cover letter. Since I don't know what/where core 2 looks like on your
> platform.

You keep referring to "your platform" and I'm still confused.

Don't you think it's important to properly document _your setup_,
including mentioning that core 2 is used for the IRQ and the
onload+neper runs on other cores? Maybe I missed it in the cover
letter, but that details seems pretty important for analysis,
wouldn't you agree?

Even if my computer is different, there should be enough detail for
me to form a mental model of what you are doing so that I can think
through it, understand the data, and, if I want to, try to reproduce
it.

> >
> > - The neper commands provided seem to be the server side since there
> >   is no -c mentioned. What is the neper client side command?
> Same command with -c
> >
> > - What do the environment variables set for onload+neper mean?
> >
> > ...
> >
> > Do you follow what I'm getting at here? The cover lacks a tremendous
> > amount of detail that makes reproducing the setup you are using
> > unnecessarily difficult.
> >
> > Do you agree that I should be able to read the cover letter and, if
> > so desired, go off and reproduce the setup and get similar results?
> Yes you should be able to that, but there are micro details of your
> platform and configuration that I have no way of knowing and suggest
> configurations. I have certainly pointed out the relevant environment
> and special configurations (netdev queues sizes, sysctls, irq defer,
> neper command and onload environment variables) that I did for each
> test case in my experiment. Beyond that I have no way of providing you
> an internal C3 platform or providing system configuration for your
> platform.

I'm going to let the thread rest at this point; I just think we are
talking past each other here and it just doesn't feel productive.

You are saying that your platform and configuration are not publicly
available, there are too many "micro details", and that you can't
suggest a configuration for my computer, which is sure to be wildly
different.

I keep repeating this, but I'll repeat it more explicitly: I'm not
asking you to suggest a configuration to me for my computer.

I'm asking you to thoroughly, rigorously, and verbosely document
what _exactly_ *your setup* is, precisely how it is configured, and
all the versions and SHAs of everything so that if I want to try to
reproduce it I have enough information in order to do so.

With your cover letter as it stands presently: this is not possible.

Surely, if I can run neper and get a latency measurement, I can run
a script that you wrote which measures CPU cycles using a publicly
available tool, right? Then at least we are both measuring CPU
consumption the same way and can compare latency vs CPU tradeoff
results based on the same measurement.

By providing better documentation, you make it more likely that
other people will try to reproduce your results. The more people who
reproduce your results, the stronger the argument to get this merged
becomes.

