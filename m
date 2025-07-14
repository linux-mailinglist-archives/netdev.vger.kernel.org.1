Return-Path: <netdev+bounces-206527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC63B035D1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF143AFC22
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015F20297B;
	Mon, 14 Jul 2025 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="TmEk9CTF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176720C00B
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471325; cv=none; b=rGT3osWrjcxLzI+hAevcR6cZjcgqKMIJQ1wAwoYCRc5m4MIaq6B3cDi/SO1ay4d66q2dtrIVIXPHxMD3mej7hcJk42auCFbjZFdKL3FfI7bb7KZeKoEa0475aSadi7KssCeTU/nWA5SVQUEK4oOfl06Jl1AnJUqduefz8QVwVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471325; c=relaxed/simple;
	bh=vB5UiUgsozB+0sggKFznBqtC333A7wXb/PoBSWHUbvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eE5TxXpmqSGTKpm0/rFRVKt9JqDYHHGsE8Awd2pBHXUi+MRDyGpCvCIaR98AbZtTqVVoC97KW8T+XJmEy/Pgp/tj/9FzjqZrE0RIzjNCa0kmHr8VWqM6MfIFb6m4xa6ZKGvIFvjipaeuzkDIyaD47UCESyBGEcG9zNbM07YKO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=TmEk9CTF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so678093166b.2
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1752471322; x=1753076122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB5UiUgsozB+0sggKFznBqtC333A7wXb/PoBSWHUbvE=;
        b=TmEk9CTFFpT2sK8boYZBEdcdTzsDrnSXAlytlGPdTwjLko16Hg1ja1WtvHF3OBxX7h
         3gtvnLuAnFKgBtlPqHZu3ZV44MrVofov2ZLuzGt7cXlIJFCjcoElNrQ6+g5YC1ze5fFy
         QFrzrHLh73ov+P+OXO7PXWcg0lapwno2IeYtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752471322; x=1753076122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB5UiUgsozB+0sggKFznBqtC333A7wXb/PoBSWHUbvE=;
        b=WUOTbTAr0gxHq+FDVjzPUwK8OFKt+b4gUUoCEhtlwvznQ4WO3uhBf0yPCUNJcO1Nvo
         7XOzL34v1SdhrrIEeDno+quJbCQ0J2jjgj1ZXz0j0xLRWDTk5cfjfuC3C/0RUS/jgh6X
         dE3zrr5HhruoBmyNqThqsZYkcppnEnCoEOy4nvUilAreNxtNROnai2uORNe9o0pfZC9k
         0IvJszEzMwX6ZEOGFOcjZNepw/+AoHEcDm+WbBxhwltf5jTQ9ihsgD29wFFPmjQL20Nw
         iqtt42Hp4iTPrY3WFpBJttZ6TojFG7LobH5CI9T6KlDjp8FdIDLO9m3wnJZ5LKXYdHeV
         aMhw==
X-Forwarded-Encrypted: i=1; AJvYcCVLYhYU+MscWsVrPhqNi0m2YFszyP1By+/u48tOENg5M9fbB3ijWUcEynQedsHdvoaqCEQN95E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl1396pDOmuoIaSFhmcxhsMYmtSQDd2sxFxSmQEzlezN+FPwR
	pxjmcWCPwkDnvaHap5/p4bqoNBLJCXh/4TnLliBJNNi77iCaxwNS+lBk4OWOlEO5D/PpCoZlTi4
	25VLAa2OGyL/U8DNylDmkVBQ1lIAnzDB9zHQuT8+CDvTGzRO3k4+Jxw==
X-Gm-Gg: ASbGncvepaDwGzg5/c9aBajbNCCKc5KNEWq7ha3nAtSCzi6y8MBz+jFlltCcHnfwiWb
	P/E3t7x+N8D8NOfIGEM/t6w2LlDqjUD9D8OxfSV5E53w8DnhbMYkwV/hlMU57+I/0CeAgLweweJ
	DAhrUlOqfma0FBkaj3ruhIFaWWF/qPGPlQTxf/uKEeFPsTywGV75t5W1mMl86nB1BsbRTtDKz6Z
	2r0wjkv
X-Google-Smtp-Source: AGHT+IH/NKmhyQrk9sk4uvw8CG8NXMmxXC091yizH0omQ4CgkCjY+lXaWd1irvQARhPQa6P7HFb+yefQM/VoEjb/JkE=
X-Received: by 2002:a17:907:e98a:b0:ade:4121:8d3d with SMTP id
 a640c23a62f3a-ae6fc6b1142mr1167961566b.12.1752471322244; Sun, 13 Jul 2025
 22:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <CAK8fFZ6FU1+1__FndEoFQgHqSXN+330qvNTWMvMfiXc2DpN8NQ@mail.gmail.com>
 <08fae312-2e3e-4622-94ab-7960accc8008@intel.com> <366dbe9f-af4d-48ec-879e-1ac54cd5f3b6@intel.com>
 <CAK8fFZ6PPw1nshtSp+QZ_2VVWVrsCKZDdsxdPF9Tjc0=_gi=Wg@mail.gmail.com>
 <bdab5970-0701-4ba7-abd2-2009a92c130a@intel.com> <CAK8fFZ5XPQ-mW5z9qJNJhqFukdtYGJawYTYuhHYDTCvcD37oFw@mail.gmail.com>
 <d3c4f2f0-4c22-449b-9f8d-677c4671ee17@intel.com> <CAK8fFZ4L=bJtkDcj3Vi2G0Y4jpki3qtEf8F0bxgG3x9ZHWrOUA@mail.gmail.com>
 <aff93c23-4f46-4d52-bdaa-9ed365e87782@intel.com> <252667f3-47b2-4d1f-86d6-c34ba43a6d47@intel.com>
 <ee05284e-3ab1-482f-a727-981b9fd4e9ee@intel.com> <a4b27e11-a3fd-4df0-8dd4-60d1a4aec5a8@intel.com>
 <04f3dc70-fd31-4b26-9647-c2f4ed012d8e@intel.com> <CAK8fFZ5MOiT0inGVwO0RjsiSiFNvsrTgikeCokOOhZNXHiaK4Q@mail.gmail.com>
 <7518e246-40ff-4399-9aae-57a5158061c3@intel.com> <CAK8fFZ47qh=ezYwQ5hRPxmwidOkTj_ueQsKz9G7erp0RPtaQ3Q@mail.gmail.com>
 <217bfb43-0c16-499d-b3da-aad22209fea1@intel.com>
In-Reply-To: <217bfb43-0c16-499d-b3da-aad22209fea1@intel.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 14 Jul 2025 07:34:56 +0200
X-Gm-Features: Ac12FXzVsexgxZRqbPmoGoPEbdAR-rFeCAYWDi6OhmXzD7VsZ8yNOcFYnx1r3r0
Message-ID: <CAK8fFZ6qW-Jq6c+JmN3Q78wMFhb=ECV218shSTV8cicv8q9hnw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Damato, Joe" <jdamato@fastly.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Dumazet, Eric" <edumazet@google.com>, 
	"Zaki, Ahmed" <ahmed.zaki@intel.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On 7/11/2025 11:16 AM, Jaroslav Pulchart wrote:
> >>
> >>
> >>
> >> On 7/9/2025 2:04 PM, Jaroslav Pulchart wrote:
> >>>>
> >>>>
> >>>> On 7/8/2025 5:50 PM, Jacob Keller wrote:
> >>>>>
> >>>>>
> >>>>> On 7/7/2025 3:03 PM, Jacob Keller wrote:
> >>>>>> Bad news: my hypothesis was incorrect.
> >>>>>>
> >>>>>> Good news: I can immediately see the problem if I set MTU to 9K an=
d
> >>>>>> start an iperf3 session and just watch the count of allocations fr=
om
> >>>>>> ice_alloc_mapped_pages(). It goes up consistently, so I can quickl=
y tell
> >>>>>> if a change is helping.
> >>>>>>
> >>>>>> I ported the stats from i40e for tracking the page allocations, an=
d I
> >>>>>> can see that we're allocating new pages despite not actually perfo=
rming
> >>>>>> releases.
> >>>>>>
> >>>>>> I don't yet have a good understanding of what causes this, and the=
 logic
> >>>>>> in ice is pretty hard to track...
> >>>>>>
> >>>>>> I'm going to try the page pool patches myself to see if this test =
bed
> >>>>>> triggers the same problems. Unfortunately I think I need someone e=
lse
> >>>>>> with more experience with the hotpath code to help figure out what=
s
> >>>>>> going wrong here...
> >>>>>
> >>>>> I believe I have isolated this and figured out the issue: With 9K M=
TU,
> >>>>> sometimes the hardware posts a multi-buffer frame with an extra
> >>>>> descriptor that has a size of 0 bytes with no data in it. When this
> >>>>> happens, our logic for tracking buffers fails to free this buffer. =
We
> >>>>> then later overwrite the page because we failed to either free or r=
e-use
> >>>>> the page, and our overwriting logic doesn't verify this.
> >>>>>
> >>>>> I will have a fix with a more detailed description posted tomorrow.
> >>>>
> >>>> @Jaroslav, I've posted a fix which I believe should resolve your iss=
ue:
> >>>>
> >>>> https://lore.kernel.org/intel-wired-lan/20250709-jk-ice-fix-rx-mem-l=
eak-v1-1-cfdd7eeea905@intel.com/T/#u
> >>>>
> >>>> I am reasonably confident it should resolve the issue you reported. =
If
> >>>> possible, it would be appreciated if you could test it and report ba=
ck
> >>>> to confirm.
> >>>
> >>> @Jacob that=E2=80=99s excellent news!
> >>>
> >>> I=E2=80=99ve built and installed 6.15.5 with your patch on one of our=
 servers
> >>> (strange that I had to disable CONFIG_MEM_ALLOC_PROFILING with this
> >>> patch or the kernel wouldn=E2=80=99t boot) and started a VM running o=
ur
> >>> production traffic. I=E2=80=99ll let it run for a day-two, observe th=
e memory
> >>> utilization per NUMA node and report back.
> >>
> >> Great! A bit odd you had to disable CONFIG_MEM_ALLOC_PROFILING. I didn=
't
> >> have trouble on my kernel with it enabled.
> >
> > Status update after ~45h of uptime. So far so good, I do not see
> > continuous memory consumption increase on home numa nodes like before.
> > See attached "status_before_after_45h_uptime.png" comparison.
>
> Great news! Would you like your "Tested-by" being added to the commit
> message when we submit the fix to netdev?

Jacob, absolutely.

