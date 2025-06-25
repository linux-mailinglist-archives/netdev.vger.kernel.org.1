Return-Path: <netdev+bounces-201218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B374CAE880B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833D24A7E9A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D727E059;
	Wed, 25 Jun 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0NWswJX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4622652AF;
	Wed, 25 Jun 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865099; cv=none; b=QOs8W+WnlRvGmkxwdmjfYOLSQegGuGa21PHjnwG+rasXFUpxjwvEEWerZi1dcC8anJYibEcC6FWF6szlW1jHdcdg+k6AqJXozPL+DERnIEencxR37pwxH5THbbteNIyONKfVzScoS1X8NnW85KpEHv2VHzcwxLXymWEwMSAUBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865099; c=relaxed/simple;
	bh=DVaxS9mTINZk0rvzzEi0zAW5HSrGIGK0lZqID2qLB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJl/J0oqp02ku7kSaciI0ircc3+vq5TsrQdF09naNgFOb7ew8h0oe5qvRM9SuAMsY3lm6o7+YvJub5SYHTLPNhNupWY5+mdCv8gqBtUF9khu1Y4XZhkA9zTlLa1wwugQ0K4ux2MsWAkVClOjxZQc4sguR7p1bmUozF2UtEROczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0NWswJX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a589b7dd5fso1083111cf.0;
        Wed, 25 Jun 2025 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865097; x=1751469897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ST35E8pfOiK/1Yn/IFpq1998QsVUH66BaD6x0ib8XaU=;
        b=I0NWswJXUZB8xE7M4Pd7Y4YF5zjuxGPDcRoK0h14U8urG+y7pb5nqN7MPIgwIySsdL
         2mdsQMMuY0y9Dr2H//CHAnf1VgrbqiY2+A5H7mix2lGu1w+XtybqiXvo0zeJGMUO38g0
         2FDJpVVxe8ZU2sfMuHWuBcA3WXDzsA35SxSJOWPc9xbsAchFvNk0R4gv5eCI2RrkVRqI
         GMwDIcyKAUAXxq8e2UZNR7FvmNkdXbhERev4+ZFCCad/LmoWabe+P6SNkXGDFKy+IZ45
         sNTyRZq5txJ8FR6xfTACzoP/sJCa8T1+E74usU+6x9KRi7fdNcg5I+G0+SuVTHfMzgzc
         efQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865097; x=1751469897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ST35E8pfOiK/1Yn/IFpq1998QsVUH66BaD6x0ib8XaU=;
        b=hiuT8UQ6YtNxSyVBHekge0M/2FOLPmeH6ct6RsTLMp2wqMMuAhTW1VcDQGncr9mYDR
         NJN3zdZoS5neSNhoCl4ZhF0YTwDYB67KIV9leiI/yaFNtSE+jSluAdhArsktPthuCBcq
         wj6WXzwNU3N52OIRhhZFXSGw4wfMnDeDZvoTbAs4/YusEPiTCZGLGYl1Q2y+9vxE2DAz
         uAAlxQlgJAVvGuVxKSp8mAADLtVOEIDGFlnQeMSpDQR3VasKvn2z7wS+kPm615t/omsu
         NM26PPYX9UZYGztO293j1fQntSeh1S0qwtis+05CbE5nJhkpC54PLczD2vSFR6L8mhxa
         4sIA==
X-Forwarded-Encrypted: i=1; AJvYcCVmSuRaojIG3cHZ1bTEXpsBWag3W0CCbEtwXQ0MlWTp7EbyNHqwrQWZkjq40jSDWfHhVlDR@vger.kernel.org, AJvYcCVrcmXsN22ABUUVgsZVu8P+7SLrPaJEh0S6bJ4GP/u+cmQlPEmaGe/B203xaMLwbysm2mhCvdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zUgDSSll3BeUROzq26rG89aHCXnV+hQFi00lFJsLH2Ai772X
	dKSK0YBKSMebSJyEzuM5c1VRMJ5tP0tZPVo2XunhP9dlIB00i2cygtDa
X-Gm-Gg: ASbGncvKZDObVn5lZ4Kcn4MsHldC/MjO8kEAabMHC7lY6BCvQHzDmfk+JqZH6Vre/Zo
	PY61LRhyjGTR3cSsufx59urWG9+DW3db97N6mzvI7L4gIo4YxVCkmksd0Xz22V2pK6FWBcGuUct
	1eN35cTE/D3xTxOfPcvoZbm/W9rF4b6mwkXCFRlGXpoqjMcryWBOQp5JpeI9HGhkjcGCt5CGvAH
	TtyvM9XZPnSWypGz6eEpPQbvLfPpR0hwuf5QSAuBL90hp++teD65SYI6nPrK95M5r53ARJJheSE
	paQd1a++TpBB5A3Ofkl8bnA2ooSVsQKI1CTel7NT0AVI0UquVMlwvRu2y7yjOAH1WOyKqDoqFPH
	jHt9xMeZ//bX3q6vYj7kU2NYar32P/fHXPHjOKFA++zcCF1Ru4Mmi
X-Google-Smtp-Source: AGHT+IHSHF4por84O5ihD13mbCVJ7lpg+HRk5vsTlb5fCqjI7ut2qlgYqwNXArOEw1tTdM6stSMZ5A==
X-Received: by 2002:ac8:5894:0:b0:4a4:4103:f301 with SMTP id d75a77b69052e-4a7c0238ac5mr57115501cf.0.1750865096376;
        Wed, 25 Jun 2025 08:24:56 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fbe06sm617917785a.94.2025.06.25.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:24:55 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5313EF40066;
	Wed, 25 Jun 2025 11:24:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 25 Jun 2025 11:24:55 -0400
X-ME-Sender: <xms:xxRcaIp0-3z8Y82Uxt2hVCZV8kIa1hAGuObc1oIZ1qXg6d_bgmERrg>
    <xme:xxRcaOq28oQPCOkPkxmycqOcEJpMG11hbwxIbqKkNmtPa6__qxPDueYPehkWMRG-h
    tLCuWUQn5O7MsURqQ>
X-ME-Received: <xmr:xxRcaNN1xi6iCfXozA66TncMfc37ecEv-3kURRDbr1QAlfUmdLucsgfW2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueffieeh
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgt
    uhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:xxRcaP4owxUiMUd1ZE-tIHcSRGwqSDial2gl1MrTtL-Jglnlq6xhBA>
    <xmx:xxRcaH5sWOVDw1NtamZwNzNWwSSVM8VfQdQt4h6T5WIcY4Zj0KWmIA>
    <xmx:xxRcaPgBLuEEfc09Q2iiwixCj4ufuP0YgnsrM_0n3-uKpzyiIV5SCA>
    <xmx:xxRcaB44mYkmJRvK5tl0T_uAVso9nWdY53Z3D2XoB-dwvhzb0DMU8g>
    <xmx:xxRcaKKlAAdPhdSHMinHEPHnUnZd7R9n-wzF9ZMBySHaqyhUGGWfu-3n>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 11:24:54 -0400 (EDT)
Date: Wed, 25 Jun 2025 08:24:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Message-ID: <aFwUxblhRjh24JF1@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-5-boqun.feng@gmail.com>
 <aFv_9f9w_HdTj9Xj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFv_9f9w_HdTj9Xj@localhost.localdomain>

On Wed, Jun 25, 2025 at 03:56:05PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 24, 2025 at 08:10:57PM -0700, Boqun Feng a écrit :
> > +static void synchronize_shazptr_normal(void *ptr)
> > +{
> > +	int cpu;
> > +	unsigned long blocking_grp_mask = 0;
> > +
> > +	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> > +		void *val;
> > +
> > +		/* Pair with smp_store_release() in shazptr_clear(). */
> > +		val = smp_load_acquire(slot);
> > +
> > +		if (val == ptr || val == SHAZPTR_WILDCARD)
> > +			blocking_grp_mask |= 1UL << (cpu / shazptr_scan.cpu_grp_size);
> > +	}
> > +
> > +	/* Found blocking slots, prepare to wait. */
> > +	if (blocking_grp_mask) {
> 
> synchronize_rcu() here would be enough since all users have preemption disabled.
> But I guess this defeats the performance purpose? (If so this might need a
> comment somewhere).
> 

synchronize_shazptr_normal() cannot wait for a whole grace period,
because the point of hazard pointers is to avoid waiting for unrelated
readers.

> I guess blocking_grp_mask is to avoid allocating a cpumask (again for
> performance purpose? So I guess synchronize_shazptr_normal() has some perf

If we are talking about {k,v}malloc allocation:
synchronize_shazptr_normal() would mostly be used in cleanup/free path
similar to synchronize_rcu(), therefor I would like to avoid "allocating
memory to free memory".

> expectations?)
> 
> One possibility is to have the ptr contained in:
> 
> struct hazptr {
>        void *ptr;
>        struct cpumask scan_mask
> };
> 

You mean updaters passing a `struct hazptr *` into
synchronize_shazptr_normal()? That may be a good idea, if multiple
updaters can share the same `struct hazptr *`, we can add that later,
but...

> And then the caller could simply scan itself those remaining CPUs without
> relying on the kthread.

.. this is a bad idea, sure, we can always burn some CPU time to scan,
but local optimization doesn't mean global optimization, if in the
future, we have a lots of synchronize_shazptr_normal()s happening at
the same time, the self busy-waiting scan would become problematic.

Regards,
Boqun

> 
> But I'm sure there are good reasons for now doing that :-)
> 
> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

