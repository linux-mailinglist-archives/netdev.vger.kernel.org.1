Return-Path: <netdev+bounces-205553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A66AFF3AC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EFD17B06D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAD23A9B4;
	Wed,  9 Jul 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="lQnyAvfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DC21A92F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752095095; cv=none; b=cx59jGfnIcJgIXFYfCUGWqDBSKMXju/3qvvK11tcoraJ37CTG9Qd/gm6epimv0brxWr7xpjutZd0L/DioAmF/yR+ERdvekti+R9yF2xflgRvPRWEG9RWv1dGXuo0O+FYQ6iTuzvVe/Bm8RiaYYvwEKghec6d9HAm0uex74qE81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752095095; c=relaxed/simple;
	bh=BNsm2fnHBMugEfz4D2462oBDQDgjrVdyedveO5ODNHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyMKyxZ3aN0aOSPJElFwaHju4c6rvA8WNjhph0pKVG8uaq+WKg84TEenaLZteQW2Y29P7WDjVm++tPD6A2+loMiptsvtDMIWTdzkVgXatkuUhYcoJygSLq9xuCtNsBibBdw1I6H4PDaowddHuHKeq0cXJ+9Ce7WkJsjSCQ11yP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=lQnyAvfB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3a604b43bso45667966b.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1752095092; x=1752699892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNsm2fnHBMugEfz4D2462oBDQDgjrVdyedveO5ODNHw=;
        b=lQnyAvfB2mk8J4KEJtbK59cFxyS7fuJrzpmw3o4DfPHq6syhugLrlbfW1BhKjfiJps
         lMI6/UKZNM1/mSNif8mKavok9bQcq9ukpezY/Ipzfh4GTcSshvRY7CeHRGPNsyzVjaxR
         pAQAO79lDVQZegZvkCRC5jFSj6gc/TyjAgHMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752095092; x=1752699892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNsm2fnHBMugEfz4D2462oBDQDgjrVdyedveO5ODNHw=;
        b=oJynD+3LrJtiDWSy7Z65bgp3qim4suXFYQy2Ip11Dv350D1yyoz3b+NCBDCWmjlOnz
         o74lPIEojdWYgmFqHx56GvXLXuNn1pCdGkbvMjLf8uYKNgMf4ZOsS/XPaql76TOr6mov
         Gf/F5cMoQcxGH88fJJt3CFurW8FzbSc+J8jZNrAqQ8XnjrUhTcOfNXN4DYCwAIe2savB
         Tn4JxR1OwZTNmAXAe1YnhdJhXzgguhoRL9H7iwqvKbtckizMTaDDBAmCsZyr5YSvLWKv
         lasOxudaUK5OpvNmKom0wL4gaMQAFGwQ7Ktp5gHY6y/m865UQHRdT4dGZrrrHjRcdc9i
         haVw==
X-Forwarded-Encrypted: i=1; AJvYcCXnBjZk5qDGRDOeXuSEXKe2lGllLvnC8BSYp1PVCvEp2RN7LayiEQ24Lmuz76vB6/tq37NNF+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZhZpPuORmYmEWQnX1g78OX9DMvbO8vr6OBqE6Gio+b507t2m
	TYQhMvqZ1xoDNrk7N4IqmR7XxrwB08BJO36B+D76I9KUfiKQKveBMN0HKjv+lBbOI3hRdwAWOOe
	B678nt39a5gdZW0frTRXbFGmvI0GBeXkkvyUmdWq/
X-Gm-Gg: ASbGncskbb03MhqY10/hx2rEcdNWeyb7V9FP3uumNjGMvHtYmJguKKX1mw/Ruqq28oQ
	mxDUTnG9hyJNU+JI6fVPO0JX0QUF5f+VrWwX7oN8TM3oTCzcV0KUTIwzAT3ugafuWjOtxNtmYcw
	j+uSA8L7+VLHywv3kEGokEk/xX7ob/UeQWZb/ZpEC0Rw3U
X-Google-Smtp-Source: AGHT+IHSDkur6mt7sMuBl3ivcZcSn4ndEARSSMyN0wiFBCWYKf62/5pzal1TKfzFU+ne/f0YvEnq//YFMiNrwqmZHYw=
X-Received: by 2002:a17:906:f413:b0:ad8:9257:5737 with SMTP id
 a640c23a62f3a-ae6e112c1damr125266966b.25.1752095091937; Wed, 09 Jul 2025
 14:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <CAK8fFZ5rS8Xg11LvyQHzFh3aVHbKdRHpuhrpV_Wc7oYRcMZFRA@mail.gmail.com>
 <c764ad97-9c6a-46f5-a03b-cfa812cdb8e1@intel.com> <CAK8fFZ4bRJz2WnhoYdG8PVYi6=EKYTXBE5tu8pR4=CQoifqUuA@mail.gmail.com>
 <f2e43212-dc49-4f87-9bbc-53a77f3523e5@intel.com> <CAK8fFZ6FU1+1__FndEoFQgHqSXN+330qvNTWMvMfiXc2DpN8NQ@mail.gmail.com>
 <08fae312-2e3e-4622-94ab-7960accc8008@intel.com> <366dbe9f-af4d-48ec-879e-1ac54cd5f3b6@intel.com>
 <CAK8fFZ6PPw1nshtSp+QZ_2VVWVrsCKZDdsxdPF9Tjc0=_gi=Wg@mail.gmail.com>
 <bdab5970-0701-4ba7-abd2-2009a92c130a@intel.com> <CAK8fFZ5XPQ-mW5z9qJNJhqFukdtYGJawYTYuhHYDTCvcD37oFw@mail.gmail.com>
 <d3c4f2f0-4c22-449b-9f8d-677c4671ee17@intel.com> <CAK8fFZ4L=bJtkDcj3Vi2G0Y4jpki3qtEf8F0bxgG3x9ZHWrOUA@mail.gmail.com>
 <aff93c23-4f46-4d52-bdaa-9ed365e87782@intel.com> <252667f3-47b2-4d1f-86d6-c34ba43a6d47@intel.com>
 <ee05284e-3ab1-482f-a727-981b9fd4e9ee@intel.com> <a4b27e11-a3fd-4df0-8dd4-60d1a4aec5a8@intel.com>
 <04f3dc70-fd31-4b26-9647-c2f4ed012d8e@intel.com>
In-Reply-To: <04f3dc70-fd31-4b26-9647-c2f4ed012d8e@intel.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 9 Jul 2025 23:04:25 +0200
X-Gm-Features: Ac12FXyaO_OSvkR5pEP7eBnklqIwCyXvyYYGPHM22D5cmw4J-nnhMxF1RgW377k
Message-ID: <CAK8fFZ5MOiT0inGVwO0RjsiSiFNvsrTgikeCokOOhZNXHiaK4Q@mail.gmail.com>
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
>
> On 7/8/2025 5:50 PM, Jacob Keller wrote:
> >
> >
> > On 7/7/2025 3:03 PM, Jacob Keller wrote:
> >> Bad news: my hypothesis was incorrect.
> >>
> >> Good news: I can immediately see the problem if I set MTU to 9K and
> >> start an iperf3 session and just watch the count of allocations from
> >> ice_alloc_mapped_pages(). It goes up consistently, so I can quickly te=
ll
> >> if a change is helping.
> >>
> >> I ported the stats from i40e for tracking the page allocations, and I
> >> can see that we're allocating new pages despite not actually performin=
g
> >> releases.
> >>
> >> I don't yet have a good understanding of what causes this, and the log=
ic
> >> in ice is pretty hard to track...
> >>
> >> I'm going to try the page pool patches myself to see if this test bed
> >> triggers the same problems. Unfortunately I think I need someone else
> >> with more experience with the hotpath code to help figure out whats
> >> going wrong here...
> >
> > I believe I have isolated this and figured out the issue: With 9K MTU,
> > sometimes the hardware posts a multi-buffer frame with an extra
> > descriptor that has a size of 0 bytes with no data in it. When this
> > happens, our logic for tracking buffers fails to free this buffer. We
> > then later overwrite the page because we failed to either free or re-us=
e
> > the page, and our overwriting logic doesn't verify this.
> >
> > I will have a fix with a more detailed description posted tomorrow.
>
> @Jaroslav, I've posted a fix which I believe should resolve your issue:
>
> https://lore.kernel.org/intel-wired-lan/20250709-jk-ice-fix-rx-mem-leak-v=
1-1-cfdd7eeea905@intel.com/T/#u
>
> I am reasonably confident it should resolve the issue you reported. If
> possible, it would be appreciated if you could test it and report back
> to confirm.

@Jacob that=E2=80=99s excellent news!

I=E2=80=99ve built and installed 6.15.5 with your patch on one of our serve=
rs
(strange that I had to disable CONFIG_MEM_ALLOC_PROFILING with this
patch or the kernel wouldn=E2=80=99t boot) and started a VM running our
production traffic. I=E2=80=99ll let it run for a day-two, observe the memo=
ry
utilization per NUMA node and report back.

