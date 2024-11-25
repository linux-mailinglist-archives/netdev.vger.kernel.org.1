Return-Path: <netdev+bounces-147279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22269D8E67
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 23:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A257F286A17
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298441CB534;
	Mon, 25 Nov 2024 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEfXe1ba"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12E156F3A
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573193; cv=none; b=tN6lAEBeEgIHySZfOw5+0/DxF3xMY/Ip953TVXDfvZgCGtwfMZ+1DRzDWJSAiUQvY352Y1WQXMknEKRnGtY0Yo5kkIswBpzgm6fiT6pXKmKpBAGUC3n7cZBfUR8UQGrbbtNvY/nZG3juuh54F1B5g4tD7y2kyyYvXTPq7hwQ/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573193; c=relaxed/simple;
	bh=FbgVT8CtZaJUYW4PUlH8WrEiVPj7jSW5V+nyidW4wyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niOWag6xJ12yx9YUUkIH1PhNnr7k3AEXjPRJnl4LaPYNEyIJvnEqYQmyTwSA5OBqWcxi06L/FrfIgAjmeo+yT+Xk9trEMMHJ41mD4sKgUFK1UncXktD62lic36cCleEFRkb8biNKUPlInvx8DQ/e1OIIdMVfYe6Swuy361vBZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEfXe1ba; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732573189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aQUXO4Z20IXKMD6bN/TfftHEgC4oaBaDs3134FSiqJE=;
	b=OEfXe1baOUpdLfp39+SajEL1gtYVxtIHqdwFNPjB4Aq9aCILhEhyFE298oBQdcbUeA4rlW
	nJBfKg82TP84dNteLUAE24L8LlAZBHF3JWDl90C92Lw0UTRPGIwcuGj8agYdqQHX5jr8Qy
	9VtGgFLkST6OAu1kbfOeBrRYZ7wCMps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-lheXTFprP1a0TpVJDXqsQA-1; Mon, 25 Nov 2024 17:19:46 -0500
X-MC-Unique: lheXTFprP1a0TpVJDXqsQA-1
X-Mimecast-MFC-AGG-ID: lheXTFprP1a0TpVJDXqsQA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38245ddf59fso4100246f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 14:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732573185; x=1733177985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQUXO4Z20IXKMD6bN/TfftHEgC4oaBaDs3134FSiqJE=;
        b=xFG1qPTLIC8uB2+u6g/oF/i3d/gK/8CS6nlyC6ogvwr+KInVSRzwoUEeTjRxedN4vG
         fqc4FnbJWTgTE6Ndw9wjgjJ0YuOGht/UiJOGzCQut+R4jtGCVL1cp706lUPqfwe+WnjI
         Q1yG38zpGhhhPSrbhVTtMgAIsOwlVw4aji2CqGZ50Va3S2I1tr7H6lWSHfKyTPkYKEDq
         OLfAkcst+Ep8VTjVLOmwk1X31vKZ7lSynGZKjGBQErHeXKUYAERlLBlG+hPMqL3gOe1b
         l5ytcwgW3en+kNGRPTPceivYkyFus7UV7dfRVrzs2xpcluSjEO82jlDnoKglrU65fwJv
         lyJw==
X-Forwarded-Encrypted: i=1; AJvYcCV13qkJNF24hsfCYyTue8Kv2yhSCjFzJqFxPofiO8ZvZvgou7zed2B9BfxMwwyfkeCfmS9YhXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WEbKMjyUBzndItIiwc3DOd4cBP5C5waydWoL2DvzH6CybbQ7
	vBdbY4AIctHaxpglIeJZIHINWx9B3z81IF2qBcW0ye0k2RhtwIZBwybjows3oVoCyAsjsQnxzae
	yblKc6iOiR0zl9xikroBDqEvWDgSNdbQZvCSRgHd7VprBCYmX6s1G5NcO44ljmQ==
X-Gm-Gg: ASbGncuVjnsNhDq90bhcGzna9O+XFyy7RLv1kT6pqo3suDuZF7vJixQFoH1V6nkNYpr
	PnP3P8XDwetrnO/ZnYHdATfGcJVOTq9xwdFCq47E2i5anmQPG73pBycE8QRGR6K5VOszAufvEJV
	w9lluoBtCopaycjF7B8kHTtH1MLRMgKE+OblQN65e64tN771KXGER+B2zEAMo1Tox5DQthQLQAv
	CRGgwMNIh6qnBeW5tQlIhOBNa2xUpslaL55pnHH/WBnlMvwTayAxOFkRN5PZ7qu2g+FWUlUJIJp
	+k79eRx++BbyZ5tsE2kZCg==
X-Received: by 2002:a05:6000:78c:b0:385:bee7:5c63 with SMTP id ffacd0b85a97d-385bee75c97mr2671448f8f.14.1732573184938;
        Mon, 25 Nov 2024 14:19:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7/Qyz9bgV82qGNWSH5Tl3jHd0ty6lmhQ4ezBZR0e4vaXQ3DF97mcrZGxNdqjdY6lGH9mkww==
X-Received: by 2002:a05:6000:78c:b0:385:bee7:5c63 with SMTP id ffacd0b85a97d-385bee75c97mr2671412f8f.14.1732573184445;
        Mon, 25 Nov 2024 14:19:44 -0800 (PST)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb30bfdsm11625478f8f.56.2024.11.25.14.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:19:43 -0800 (PST)
Date: Mon, 25 Nov 2024 23:19:43 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
	mfleming@cloudflare.com
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
Message-ID: <Z0T3__Bzzg31x-Ku@lore-desk>
References: <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk>
 <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <fcaae4c8-4083-4eef-8cfe-3d1f7e340079@kernel.org>
 <25ujrqfgfkyek2mxh2c2kuuvyt5dyx2e6uysujgv3q43ezab4s@aedwgrlhnvft>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gE0rb2NCZ79+/A22"
Content-Disposition: inline
In-Reply-To: <25ujrqfgfkyek2mxh2c2kuuvyt5dyx2e6uysujgv3q43ezab4s@aedwgrlhnvft>


--gE0rb2NCZ79+/A22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Jesper,
>=20
> On Mon, Nov 25, 2024 at 07:50:41PM GMT, Jesper Dangaard Brouer wrote:
> >=20
> >=20
> > On 25/11/2024 16.12, Alexander Lobakin wrote:
> > > From: Daniel Xu <dxu@dxuuu.xyz>
> > > Date: Fri, 22 Nov 2024 17:10:06 -0700
> > >=20
> > > > Hi Olek,
> > > >=20
> > > > Here are the results.
> > > >=20
> > > > On Wed, Nov 13, 2024 at 03:39:13PM GMT, Daniel Xu wrote:
> > > > >=20
> > > > >=20
> > > > > On Tue, Nov 12, 2024, at 9:43 AM, Alexander Lobakin wrote:
> > >=20
> > > [...]
> > >=20
> > > > Baseline (again)
> > > >=20
> > > > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Thr=
oughput (Mbit/s)
> > > > Run 1	3169917	        0.00007295	0.00007871	0.00009343		Run 1	21749=
=2E43
> > > > Run 2	3228290	        0.00007103	0.00007679	0.00009215		Run 2	21897=
=2E17
> > > > Run 3	3226746	        0.00007231	0.00007871	0.00009087		Run 3	21906=
=2E82
> > > > Run 4	3191258	        0.00007231	0.00007743	0.00009087		Run 4	21155=
=2E15
> > > > Run 5	3235653	        0.00007231	0.00007743	0.00008703		Run 5	21397=
=2E06
> > > > Average	3210372.8	0.000072182	0.000077814	0.00009087		Average	21621=
=2E126
> > > >=20
> >=20
> > We need to talk about what we are measuring, and how to control the
> > experiment setup to get reproducible results.
> > Especially controlling on what CPU cores our code paths are executing.
> >=20
> > In above "baseline" case, we have two processes/tasks executing:
> >  (1) RX-napi softirq/thread (until napi_gro_receive deliver to socket)
> >  (2) Userspace netserver process TCP receiving data from socket.
>=20
> "baseline" in this case is still cpumap, just without these GRO patches.
>=20
> >=20
> > My experience is that you will see two noticeable different
> > throughput performance results depending on whether (1) and (2) is
> > executing on the *same* CPU (multi-tasking context-switching),
> > or executing in parallel (e.g. pinned) on two different CPU cores.
> >=20
> > The netperf command have an option
> >=20
> >  -T lcpu,remcpu
> >       Request that netperf be bound to local CPU lcpu and/or netserver =
be
> > bound to remote CPU rcpu.
> >=20
> > Verify setting by listing pinning like this:
> >   for PID in $(pidof netserver); do taskset -pc $PID ; done
> >=20
> > You can also set pinning runtime like this:
> >  export CPU=3D2; for PID in $(pidof netserver); do sudo taskset -pc $CP=
U $PID;
> > done
> >=20
> > For troubleshooting, I like to use the periodic 1 sec (netperf -D1)
> > output and adjust pinning runtime to observe the effect quickly.
> >=20
> > My experience is unfortunately that TCP results have a lot of variation
> > (thanks for incliding 5 runs in your benchmarks), as it depends on tasks
> > timing, that can get affected by CPU sleep states. The systems CPU
> > latency setting can be seen in /dev/cpu_dma_latency, which can be read
> > like this:
> >=20
> >  sudo hexdump --format '"%d\n"' /dev/cpu_dma_latency
> >=20
> > For playing with changing /dev/cpu_dma_latency I choose to use tuned-adm
> > as it requires holding the file open. E.g I play with these profiles:
> >=20
> >  sudo tuned-adm profile throughput-performance
> >  sudo tuned-adm profile latency-performance
> >  sudo tuned-adm profile network-latency
>=20
> Appreciate the tips - I should keep this saved somewhere.
>=20
> >=20
> >=20
> > > > cpumap v2 Olek
> > > >=20
> > > > 	Transactions	Latency P50 (s)	Latency P90 (s)	Latency P99 (s)			Thr=
oughput (Mbit/s)
> > > > Run 1	3253651	        0.00007167	0.00007807	0.00009343		Run 1	13497=
=2E57
> > > > Run 2	3221492	        0.00007231	0.00007743	0.00009087		Run 2	12115=
=2E53
> > > > Run 3	3296453	        0.00007039	0.00007807	0.00009087		Run 3	12323=
=2E38
> > > > Run 4	3254460	        0.00007167	0.00007807	0.00009087		Run 4	12901=
=2E88
> > > > Run 5	3173327	        0.00007295	0.00007871	0.00009215		Run 5	12593=
=2E22
> > > > Average	3239876.6	0.000071798	0.00007807	0.000091638		Average	12686=
=2E316
> > > > Delta	0.92%	        -0.53%	        0.33%	        0.85%			        -4=
1.32%
> > > >=20
> > > >=20
> >=20
> >=20
> > We now three processes/tasks executing:
> >  (1) RX-napi softirq/thread (doing XDP_REDIRECT into cpumap)
> >  (2) CPUmap kthread (until gro_receive_skb/gro_flush deliver to socket)
> >  (3) Userspace netserver process TCP receiving data from socket.
> >=20
> > Again, now the performance is going to depend on depending on which CPU
> > cores the processes/tasks are running and whether some are sharing the
> > same CPU. (There are both wakeup timing and cache-line effects).
> >=20
> > There are now more combinations to test...
> >=20
> > CPUmap is a CPU scaling facility, and you will likely also see different
> > CPU utilization on the difference cores one you start to pin these to
> > control the scenarios.
> >=20
> > > > It's very interesting that we see -40% tput w/ the patches. I went =
back
> > >=20
> >=20
> > Sad that we see -40% throughput...  but do we know what CPU cores the
> > now three different tasks/processes run on(?)
> >=20
>=20
> Roughly, yes. For context, my primary use case for cpumap is to provide
> some degree of isolation between colocated containers on a single host.
> In particular, colocation occurs on AMD Bergamo. And containers are
> CPU pinned to their own CCX (roughly). My RX steering program ensures
> RX packets destined to a specific container are cpumap redirected to any
> of the container's pinned CPUs. It not only provides a good measure of
> isolation but ensures resources are properly accounted.
>=20
> So to answer your question of which CPUs the 3 things run on: cpumap
> kthread and application run on the same set of cores. More than that,
> they share the same L3 cache by design. irq/softirq is effectively
> random given default RSS config and IRQ affinities.
>=20
>=20
> >=20
> > > Oh no, I messed up something =3D\
> > >  > Could you please also test not the whole series, but patches 1-3 (=
up to
> > > "bpf:cpumap: switch to GRO...") and 1-4 (up to "bpf: cpumap: reuse skb
> > > array...")? Would be great to see whether this implementation works
> > > worse right from the start or I just broke something later on.
> > >=20
> > > > and double checked and it seems the numbers are right. Here's the
> > > > some output from some profiles I took with:
> > > >=20
> > > >      perf record -e cycles:k -a -- sleep 10
> > > >      perf --no-pager diff perf.data.baseline perf.data.withpatches =
> ...
> > > >=20
> > > >      # Event 'cycles:k'
> > > >      # Baseline  Delta Abs  Shared Object                          =
                          Symbol
> > > >           6.13%     -3.60%  [kernel.kallsyms]                      =
                          [k] _copy_to_iter
> > >=20
> >=20
> > I really appreciate that you provide perf data and perf diff, but as
> > described above, we need data and information on what CPU cores are
> > running which workload.
> >=20
> > Fortunately perf diff (and perf report) support doing like this:
> >  perf diff --sort=3Dcpu,symbol
> >=20
> > But then you also need to control the CPUs used in experiment for the
> > diff to work.
> >=20
> > I hope I made sense as these kind of CPU scaling benchmarks are tricky,
>=20
> Indeed, sounds quite tricky.
>=20
> My understanding with GRO is that it's a powerful general purpose
> optimization. Enough that it should rise above the usual noise on a
> reasonably configured system (which mine is).
>=20
> Maybe we can consider decoupling the cpumap GRO enablement with the
> later optimizations?

I agree. First, we need to identify the best approach to enable GRO on cpum=
ap
(between Olek's approach and what I have suggested) and then we can evaluate
subsequent optimizations.
@Olek: do you agree?

Regards,
Lorenzo

>=20
> So in Olek's above series, patches 1-3 seem like they would still
> benefit from an simpler testbed. But the more targetted optimizations in
> patch 4+ would probably justify a de-noised setup.  Possibly single host
> with xdp-trafficgen or something.
>=20
> Procedurally speaking, maybe it would save some wasted effort if
> everyone agreed on the general approach before investing more time into
> finer optimizations built on top of the basic GRO support?
>=20
> Thanks,
> Daniel
>=20

--gE0rb2NCZ79+/A22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0T3/wAKCRA6cBh0uS2t
rIwVAP4o+gnNTbb/ewx0Xp01ji0XIGOVlAQduKUyi85Y5/Vr5gEA7ORstLAqRQVv
PLN/WFIuCxPy9Wv+dMNacu/DiJltIAI=
=SCGB
-----END PGP SIGNATURE-----

--gE0rb2NCZ79+/A22--


