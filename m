Return-Path: <netdev+bounces-206030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CEB01133
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 535177B80F8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8418CC13;
	Fri, 11 Jul 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyjAh3Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD69185955;
	Fri, 11 Jul 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201004; cv=none; b=jWDVhUJISlR5wVFlbdu+zbFuIOMPztEICTvbKSyOaUQdUmn/ruSpt84o2zgKUAMO2FXv4rDiFCTB2vEh9o4FUK3Fx80Mjvopuz7QbkxtQ3tfgtnC5O7Km0edtDCeShKGD9lIeuYdpYqAbtHsrYd5ZUV3Lj0UQUFqO4iCu7A0neI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201004; c=relaxed/simple;
	bh=pRH932/WFK2mHFG69WHcZG0wSeDYGRAA8UoON/oSkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHeYBAjgJJIYHe4mKzw5ax/Y919V8DooCr7UlLanG4QMrHgvM+NtxLcz662zAfTfxS5puZaIx0B8kAM1+L9evrUd8nSplmPgm5cthCi0g0bqphzru/Crn3+z1N6HX7FDDmElEq5twvZ/k+3bYJ0qZksk8LShcszjPaSuFc8aqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyjAh3Ly; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-701046cfeefso26703306d6.2;
        Thu, 10 Jul 2025 19:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752201001; x=1752805801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joJwdpZr71to6fGS8Aeh4XVjmt6jrwLFFyQp2yZMVcs=;
        b=jyjAh3LyCai42GaTp5f0bcZyLhtrtZ0Ev4xm2i9KpEUw2pIk0HPVFLERxE7JlabdCx
         tooyHGAGmSxt9XyTRqt5FQZ9VoTvQQLPcdbowZyeHBEV8VQ8QEgFuL+h2bvqewiuPv2O
         S8CB8NsG1ynvGmOPH829wtZDFM8J0dHBzFKLeLuYXlLG613TgQb26/+t3VlyDVDywC8i
         nIukmCflC9zTATco6rEoe+4PIwoatNzYmuW6jOPI55wepIUP5GuveX6YwkGvZYMlfLMK
         lv0HG+FajX+led+4gin/0PndtITy/U5tzqR+qd55rnD+9WX7K8UzlxYb3PXcNoJ93/Kg
         BKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752201001; x=1752805801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joJwdpZr71to6fGS8Aeh4XVjmt6jrwLFFyQp2yZMVcs=;
        b=H+d6RbJCxazD9Gol8lt/7cNTOmt3ImLICaKfxA/1JdMLJ5iE/KrTzMyHwMoWvoTNG+
         ugVWBTxP2bPycceCFlHJvSXPDifjRbqd/ps7LDD6KO+leX6Qby/Z+C9Av3m6RPtySjfA
         +4robMiCbwDRBeRaG7Ei50cKErxqJJkj2aAXYVgtjlM+N0fMw753NPEie7hz5xwRt2tv
         LXf96zL3t44OlzER4qgBPlV60BsjLLofc+kQeSjMlw/KlP+cb9eQFFBuAlBQx/GhjP7Q
         NLsRscWsSegRW3EF0WmpPt/k2Jzo8QQI4FzGm6xwp+gyujxBHtJcio08n5ZBCx6r3U1j
         fnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+JCaiMf1VPZbktp9C0p6AOaFhG1DMD0L2JnM60k/sNaFYBDf0uI+F+gWWcXYVlvopZjFjG2xKtUyoeRg=@vger.kernel.org, AJvYcCUw/3q/IWhYpQ+2THtfK4yMLAwwZ/PoizhrIWwByBKRy3DnAztz6gKxUFnGUidW7vREclr2135T@vger.kernel.org, AJvYcCVGoktpiIseEwE5sSdCTSPjA0s7YRs5/0fjOkge1IrrLCl4P1o15GAqfdOkOutaE1P5nxAN@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGjPGQ40TTnzZj/ToxCnlCddx3UjzLk8L9Y0F2BtymcJZ/XAd
	cggF4hJ3UJD3Mlp2QIXw5LxCPsqsPkJk1q91VTYT+19vYXc4uGznwTlF
X-Gm-Gg: ASbGncsP6O8sx7Qr8T/MOdk76FV3GWl59h3TICIEGFRWI22gPd8ap/t3J49on6loTPv
	eWGsEz5eG1zBYopnQ5KWUve9gCCWjkRoAGGQTvXsQgzmWtdXuozyCaT4/fK3HA2TPZbJfyifmLD
	a0XhrRCrh6NVV1QVU2lc8XzcCCfojeC8XQiO/cddG/HdOeO2oTRuu6cgK89MKkZhw9z6sQvmKIY
	K2aUcR6g6OuOSEtPHDtJXCH1h9aLVjH8QLyYst361ZIK8eUzP9T2ua3ldyjco1pzmgoewIP3zva
	4X8EQKgcG8aibGUjEXxhsdM1LISa6Py2EB0OweXDoL5hCMpQhS/iA6K+1IDO31jJWE60iiV17pY
	HoKv3b7khX4yqWKl4grpUD9kw5P9/+OM+rV99qPjNZPef5rj6gaZ24Es5tHYUmgrErcl8I3ipKu
	aX3nQhdSir04+O
X-Google-Smtp-Source: AGHT+IFDFNxyUaT8MaglPqgeFif3HqB/8lIk+ANyovj0h/4SsijRsQXdXuriTdyeRIFmRBpf9n+e4Q==
X-Received: by 2002:a05:6214:4006:b0:702:d6e6:a062 with SMTP id 6a1803df08f44-704a3591c9fmr29016646d6.22.1752201001037;
        Thu, 10 Jul 2025 19:30:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3d3b0sm15162686d6.80.2025.07.10.19.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 19:30:00 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBBD4F40068;
	Thu, 10 Jul 2025 22:29:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 22:29:59 -0400
X-ME-Sender: <xms:J3dwaHGG0bSPzTOTifx-Whcrq728djzPkQEabN-JJoTRbHRnSKaX2g>
    <xme:J3dwaK7N0T_sV49RecfKuRBte1I4VlVJsCdB5LXGiEF-k0BSgxYfy54SYLEuRXuLX
    nF3qaaIK2g2v3yCnw>
X-ME-Received: <xmr:J3dwaK1EakApuFdPG1yW0t2wreJunoSxDYUB7ODfaGzZq5VCRWBcsxnk5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvihhtrg
    hoseguvggsihgrnhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtth
    hopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheprggvhhesmhgvthgrrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J3dwaOj9Xe7Pz0pOBCM3zgqKMLCC8Qda78VZ8iT1GoTFh6hRetIEtw>
    <xmx:J3dwaOTDuVbInZIEwFTkCbIe1jAE3ADuZ2nzk7HkfK1JKZoUETG6Wg>
    <xmx:J3dwaI40pjsqVFeW0Yb0LzAmyI6usyTRuMff2ZIGfnVyXppEdmte5w>
    <xmx:J3dwaOzLtcw6qGpywwZXpirqH2XxNJ4jtCNa6SGT1gtbuCuvRQLg4g>
    <xmx:J3dwaAAkeldoesRFzTsMg3bym031PQs0DjrwjavW2h0Mqa29oTsii09P>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 22:29:59 -0400 (EDT)
Date: Thu, 10 Jul 2025 19:29:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/8] shazptr: Avoid synchronize_shaptr() busy waiting
Message-ID: <aHB3Jt9dwKZummjR@Mac.home>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-5-boqun.feng@gmail.com>
 <a6172f7c-fd1d-4961-91c7-8c682e2289c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6172f7c-fd1d-4961-91c7-8c682e2289c6@paulmck-laptop>

On Thu, Jul 10, 2025 at 05:56:00PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 13, 2025 at 11:00:51PM -0700, Boqun Feng wrote:
> > For a general purpose hazard pointers implemenation, always busy waiting
> > is not an option. It may benefit some special workload, but overall it
> > hurts the system performance when more and more users begin to call
> > synchronize_shazptr(). Therefore avoid busy waiting for hazard pointer
> > slots changes by using a scan kthread, and each synchronize_shazptr()
> > queues themselves if a quick scan shows they are blocked by some slots.
> > 
> > A simple optimization is done inside the scan: each
> > synchronize_shazptr() tracks which CPUs (or CPU groups if nr_cpu_ids >
> > BITS_PER_LONG) are blocking it and the scan function updates this
> > information for each synchronize_shazptr() (via shazptr_wait)
> > individually. In this way, synchronize_shazptr() doesn't need to wait
> > until a scan result showing all slots are not blocking (as long as the
> > scan has observed each slot has changed into non-block state once).
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> OK, so this patch addresses the aforementioned pain.  ;-)
> 
> One question below, might be worth a comment beyond the second paragraph
> of the commit log.  Nevertheless:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 

Thanks!

> > ---
> >  kernel/locking/shazptr.c | 277 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 276 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/locking/shazptr.c b/kernel/locking/shazptr.c
> > index 991fd1a05cfd..a8559cb559f8 100644
> > --- a/kernel/locking/shazptr.c
> > +++ b/kernel/locking/shazptr.c
> > @@ -7,18 +7,243 @@
> >   * Author: Boqun Feng <boqun.feng@gmail.com>
> >   */
> >  
> > +#define pr_fmt(fmt) "shazptr: " fmt
> > +
> >  #include <linux/atomic.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/completion.h>
> > +#include <linux/kthread.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> >  #include <linux/shazptr.h>
> > +#include <linux/slab.h>
> > +#include <linux/sort.h>
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(void *, shazptr_slots);
> >  EXPORT_PER_CPU_SYMBOL_GPL(shazptr_slots);
> >  
> > -void synchronize_shazptr(void *ptr)
> > +/* Wait structure for synchronize_shazptr(). */
> > +struct shazptr_wait {
> > +	struct list_head list;
> > +	/* Which groups of CPUs are blocking. */
> > +	unsigned long blocking_grp_mask;
> > +	void *ptr;
> > +	struct completion done;
> > +};
> > +
> > +/* Snapshot for hazptr slot. */
> > +struct shazptr_snapshot {
> > +	unsigned long ptr;
> > +	unsigned long grp_mask;
> 
> The point of ->grp_mask is to avoid being fooled by CPUs that assert the
> wildcard after having been found not to be holding a hazard pointer on
> the current object?  And to avoid being delayed by CPUs that picked up

Mostly for this.

> a pointer, were preempted/interrupted for a long time, then do a doomed
> store into their hazard pointer?  Or is there something else subtle
> that I am missing that somehow allows a given object to reappear in a
> hazard pointer?
> 

Also notice that the hazptr pointer usage in lockdep is not a typical
one: I used the hashlist head as the protected pointer, that means after
synchronize_shazptr() finishes there could still be new reader
protecting the same key. So I need this grp_mask trick to avoid readers
starving updaters.

Will add some comment explaining this.

Regards,
Boqun

> > +};
> > +
> > +static inline int
> > +shazptr_snapshot_cmp(const void *a, const void *b)
> > +{
> > +	const struct shazptr_snapshot *snap_a = (struct shazptr_snapshot *)a;
> > +	const struct shazptr_snapshot *snap_b = (struct shazptr_snapshot *)b;
> > +
> > +	if (snap_a->ptr > snap_b->ptr)
> > +		return 1;
> > +	else if (snap_a->ptr < snap_b->ptr)
> > +		return -1;
> > +	else
> > +		return 0;
> > +}
> > +
> > +/* *In-place* merge @n together based on ->ptr and accumulate the >grp_mask. */
> > +static int shazptr_snapshot_merge(struct shazptr_snapshot *snaps, int n)
> > +{
> > +	int new, i;
> > +
> > +	/* Sort first. */
> > +	sort(snaps, n, sizeof(*snaps), shazptr_snapshot_cmp, NULL);
> > +
> > +	new = 0;
> > +
> > +	/* Skip NULLs. */
> > +	for (i = 0; i < n; i++) {
> > +		if (snaps[i].ptr)
> > +			break;
> > +	}
> > +
> > +	while (i < n) {
> > +		/* Start with a new address. */
> > +		snaps[new] = snaps[i];
> > +
> > +		for (; i < n; i++) {
> > +			/* Merge if the next one has the same address. */
> > +			if (snaps[new].ptr == snaps[i].ptr) {
> > +				snaps[new].grp_mask |= snaps[i].grp_mask;
> > +			} else
> > +				break;
> > +		}
> > +
> > +		/*
> > +		 * Either the end has been reached or need to start with a new
> > +		 * record.
> > +		 */
> > +		new++;
> > +	}
> > +
> > +	return new;
> > +}
> > +
> > +/*
> > + * Calculate which group is still blocking @ptr, this assumes the @snaps is
> > + * already merged.
> > + */
> > +static unsigned long
> > +shazptr_snapshot_blocking_grp_mask(struct shazptr_snapshot *snaps,
> > +				   int n, void *ptr)
> > +{
> > +	unsigned long mask = 0;
> > +
> > +	if (!n)
> > +		return mask;
> > +	else if (snaps[n-1].ptr == (unsigned long)SHAZPTR_WILDCARD) {
> > +		/*
> > +		 * Take SHAZPTR_WILDCARD slots, which is ULONG_MAX, into
> > +		 * consideration if any.
> > +		 */
> > +		mask = snaps[n-1].grp_mask;
> > +	}
> > +
> > +	/* TODO: binary search if n is big. */
> > +	for (int i = 0; i < n; i++) {
> > +		if (snaps[i].ptr == (unsigned long)ptr) {
> > +			mask |= snaps[i].grp_mask;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return mask;
> > +}
> > +
> > +/* Scan structure for synchronize_shazptr(). */
> > +struct shazptr_scan {
> > +	/* The scan kthread */
> > +	struct task_struct *thread;
> > +
> > +	/* Wait queue for the scan kthread */
> > +	struct swait_queue_head wq;
> > +
> > +	/* Whether the scan kthread has been scheduled to scan */
> > +	bool scheduled;
> > +
> > +	/* The lock protecting ->queued and ->scheduled */
> > +	struct mutex lock;
> > +
> > +	/* List of queued synchronize_shazptr() request. */
> > +	struct list_head queued;
> > +
> > +	int cpu_grp_size;
> > +
> > +	/* List of scanning synchronize_shazptr() request. */
> > +	struct list_head scanning;
> > +
> > +	/* Buffer used for hazptr slot scan, nr_cpu_ids slots*/
> > +	struct shazptr_snapshot* snaps;
> > +};
> > +
> > +static struct shazptr_scan shazptr_scan;
> > +
> > +static void shazptr_do_scan(struct shazptr_scan *scan)
> > +{
> > +	int cpu;
> > +	int snaps_len;
> > +	struct shazptr_wait *curr, *next;
> > +
> > +	scoped_guard(mutex, &scan->lock) {
> > +		/* Move from ->queued to ->scanning. */
> > +		list_splice_tail_init(&scan->queued, &scan->scanning);
> > +	}
> > +
> > +	memset(scan->snaps, nr_cpu_ids, sizeof(struct shazptr_snapshot));
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> > +		void *val;
> > +
> > +		/* Pair with smp_store_release() in shazptr_clear(). */
> > +		val = smp_load_acquire(slot);
> > +
> > +		scan->snaps[cpu].ptr = (unsigned long)val;
> > +		scan->snaps[cpu].grp_mask = 1UL << (cpu / scan->cpu_grp_size);
> > +	}
> > +
> > +	snaps_len = shazptr_snapshot_merge(scan->snaps, nr_cpu_ids);
> > +
> > +	/* Only one thread can access ->scanning, so can be lockless. */
> > +	list_for_each_entry_safe(curr, next, &scan->scanning, list) {
> > +		/* Accumulate the shazptr slot scan result. */
> > +		curr->blocking_grp_mask &=
> > +			shazptr_snapshot_blocking_grp_mask(scan->snaps,
> > +							   snaps_len,
> > +							   curr->ptr);
> > +
> > +		if (curr->blocking_grp_mask == 0) {
> > +			/* All shots are observed as not blocking once. */
> > +			list_del(&curr->list);
> > +			complete(&curr->done);
> > +		}
> > +	}
> > +}
> > +
> > +static int __noreturn shazptr_scan_kthread(void *unused)
> > +{
> > +	for (;;) {
> > +		swait_event_idle_exclusive(shazptr_scan.wq,
> > +					   READ_ONCE(shazptr_scan.scheduled));
> > +
> > +		shazptr_do_scan(&shazptr_scan);
> > +
> > +		scoped_guard(mutex, &shazptr_scan.lock) {
> > +			if (list_empty(&shazptr_scan.queued) &&
> > +			    list_empty(&shazptr_scan.scanning))
> > +				shazptr_scan.scheduled = false;
> > +		}
> > +	}
> > +}
> > +
> > +static int __init shazptr_scan_init(void)
> > +{
> > +	struct shazptr_scan *scan = &shazptr_scan;
> > +	struct task_struct *t;
> > +
> > +	init_swait_queue_head(&scan->wq);
> > +	mutex_init(&scan->lock);
> > +	INIT_LIST_HEAD(&scan->queued);
> > +	INIT_LIST_HEAD(&scan->scanning);
> > +	scan->scheduled = false;
> > +
> > +	/* Group CPUs into at most BITS_PER_LONG groups. */
> > +	scan->cpu_grp_size = DIV_ROUND_UP(nr_cpu_ids, BITS_PER_LONG);
> > +
> > +	scan->snaps = kcalloc(nr_cpu_ids, sizeof(scan->snaps[0]), GFP_KERNEL);
> > +
> > +	if (scan->snaps) {
> > +		t = kthread_run(shazptr_scan_kthread, NULL, "shazptr_scan");
> > +		if (!IS_ERR(t)) {
> > +			smp_store_release(&scan->thread, t);
> > +			/* Kthread creation succeeds */
> > +			return 0;
> > +		} else {
> > +			kfree(scan->snaps);
> > +		}
> > +	}
> > +
> > +	pr_info("Failed to create the scan thread, only busy waits\n");
> > +	return 0;
> > +}
> > +core_initcall(shazptr_scan_init);
> > +
> > +static void synchronize_shazptr_busywait(void *ptr)
> >  {
> >  	int cpu;
> >  
> >  	smp_mb(); /* Synchronize with the smp_mb() in shazptr_acquire(). */
> > +
> >  	for_each_possible_cpu(cpu) {
> >  		void **slot = per_cpu_ptr(&shazptr_slots, cpu);
> >  		/* Pair with smp_store_release() in shazptr_clear(). */
> > @@ -26,4 +251,54 @@ void synchronize_shazptr(void *ptr)
> >  				      VAL != ptr && VAL != SHAZPTR_WILDCARD);
> >  	}
> >  }
> > +
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
> > +		struct shazptr_scan *scan = &shazptr_scan;
> > +		struct shazptr_wait wait = {
> > +			.blocking_grp_mask = blocking_grp_mask,
> > +		};
> > +
> > +		INIT_LIST_HEAD(&wait.list);
> > +		init_completion(&wait.done);
> > +
> > +		scoped_guard(mutex, &scan->lock) {
> > +			list_add_tail(&wait.list, &scan->queued);
> > +
> > +			if (!scan->scheduled) {
> > +				WRITE_ONCE(scan->scheduled, true);
> > +				swake_up_one(&shazptr_scan.wq);
> > +			}
> > +		}
> > +
> > +		wait_for_completion(&wait.done);
> > +	}
> > +}
> > +
> > +void synchronize_shazptr(void *ptr)
> > +{
> > +	/* Busy waiting if the scan kthread has not been created. */
> > +	if (!smp_load_acquire(&shazptr_scan.thread))
> > +		synchronize_shazptr_busywait(ptr);
> > +	else
> > +		synchronize_shazptr_normal(ptr);
> > +}
> >  EXPORT_SYMBOL_GPL(synchronize_shazptr);
> > -- 
> > 2.47.1
> > 

