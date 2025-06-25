Return-Path: <netdev+bounces-201239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F0DAE893B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBE3A322F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E717A318;
	Wed, 25 Jun 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft6uPaQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A226A1CF;
	Wed, 25 Jun 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867798; cv=none; b=saTNiehjKrKEfznAAGQRVeD2SfSuyQyE1efv9Eq45ZIqVOG1n8/bpEI5uky+l2EjIaLyBzYxdUBMI245VdRxfyH7tkBsuR7b0o0l+ClWi7ygE6DKhsaMWhINwRkoAcMF1zCuajlUpIhSimCk14JgpDeTC4TFH2sqgrKdgSDzaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867798; c=relaxed/simple;
	bh=XcujPXMq0SgwRgGcyvHtvax+x0rV8Zggez8M12wwghA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8a7O7vY9xWKCGOYgQUKbVj2iCnJrMdwi60asF4QrUkbvFc7bz6sSqSeFNUjaIX90R1pxmMuRedM/9k/doGKU83oxByZCE/YemfroUSNMOHz7BVVTVH5g/6u173HXqn0T765QAbPda9zO5KOkCxhPOPWLhTnOjjwiAGcsSC5M5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft6uPaQr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso881306d6.2;
        Wed, 25 Jun 2025 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867796; x=1751472596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPhczO6D/8eJ5ZW1VQow1Wu7VLrhbANFKfpYebLr5Do=;
        b=ft6uPaQrYhmYTYTCZn3agr5e3fO0N3pLnxzDyYD4VK1ibqG000IGSOHYsHYMz93Hlo
         Cxi4udZWc59MFIMt1jq/GjSDew/v6x9F5Bfqn4xVAeJG6YA/s+NqWsgr1rxTLKGRD07j
         fprFmi8MgPxqZyHSQxr0TOW4yIKB1690Pjkjl1CBg6OoOycAV8Z/9oDULIhMGrZYSdw7
         7IyCRXOjnszHn23NK6TnevjyhDppHa/t5pjlMXi8N3iB5ZnSmAxd3NssZC3frl32yNAq
         q0fQPgsZK680nevWj+YAeceuRYHsltYMYKLTgdlxFOcJFmhAZneMbitqUi58jKRCKdWn
         smGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867796; x=1751472596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPhczO6D/8eJ5ZW1VQow1Wu7VLrhbANFKfpYebLr5Do=;
        b=cMZ9hoLJVJc4+4/oEGdHBaK4Jqg2pm2B+kL4qGGZK3/VFytkhBrbKFKnldmJqKCwhh
         phIRHnvYialRPOAhlS2SOp6FfUaDZj0j6MVdj+B0CficboF86b857SqtF96aK1S7vkFh
         mIYw6XztJRrrseUxQm8GtlcOZi/+j5oAHoWn9TZlJcCDHcXIjRsoogdYI1sI2PFQgc3X
         uzpX0of8P1g2bN6zNA7RRuykqMcrD0al7jeu/sSB1IZLpBCqaHMeMmqcPTVk8BODAYy6
         bkREgNUWeT492x+3Q1EFCIifzP+iQpGyHhrXmMnBEm1Nr1hdf1D/mVPCG0xmWTqf/w7q
         QQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt/AYvww00T759hOg8hPYg13C30olnTce8A2QdaIBWVIWZs7UhCqyO0qM4V7adsg/8thCjZYI=@vger.kernel.org, AJvYcCXQ2FhC6GC1EHfvNXNAMgXrBobI8upMqssZxb6FoqbGxQxDlNktPIvM97ziu4z8V2H6zRaw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xz8A8xMQtsL/YQd11UCf4h1JHyLwCM5ftkD44nyFEjdwp6QR
	KzOWaD0Dgp8dHQD+EZkImh8Im0s2vllUtlAF+QYOvPUH9+LhFOJhu3Cd
X-Gm-Gg: ASbGncv8ucrbkIKkQjqNzA4+LzOY9pIZWCc02R3nfu0+YQeHtXDRxlb4Kuy8aY4LIkm
	31BveovLIkBAHG5TO/s6fgpiNUdNSwOOvNKBl1w2tG/CBzjA+hp/KW3mleXrOgvEAiq8X39Ago0
	tLp3M49B9QYL33mReNHmKn8/pGOJ+JTYohd7ToRpTcaj9pfXV1mlmfOeUTXVEeiOGFlCyiUZWA7
	zs7K3ZDe4WSOogteB1RVdxBOSt6xpa5MCqsY6TQFaiQ4ewZ8WDFsl5kv6qNtuxTRx3E7mhgt7p1
	ociOP2jd8lebCFO1VS970C8p39sY6htscuhG2d/jCrILb69VtYQxbLPJ7hO7wcXWDLVhRLBlMDn
	UAHBwpsJLmFvjUoRxYKXUGAQM5Gg+BWg+eylNOLsz486qd3JhWMO3
X-Google-Smtp-Source: AGHT+IFGhDRREH3gHeUx79lJ5VxzKJvTjEFfsbt4u2kIHQe0XYfcSk9/RB20l94+X4h2aOgKgRNKtQ==
X-Received: by 2002:a05:6214:3c9d:b0:6f8:bfbf:5d47 with SMTP id 6a1803df08f44-6fd5efac5f8mr43788206d6.24.1750867795877;
        Wed, 25 Jun 2025 09:09:55 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999a14bsm623199485a.13.2025.06.25.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:09:55 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8CA8CF40068;
	Wed, 25 Jun 2025 12:09:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 12:09:54 -0400
X-ME-Sender: <xms:Uh9caBV3GZ6rVcDATtwA0qmFIRhO6ZhjoQ9y5fBqbsz-gL3B8pP44w>
    <xme:Uh9caBmuJneho1_SeL03jdFLJ7g6iRzC4UndmG9z9QiMwI9Tt7rup_MJ2meQixu7q
    myiXy3BXgfj1PWM5w>
X-ME-Received: <xmr:Uh9caNbuTqB9mzm_ScOkuYJnOL_qJPelsPpCo7UGQhNwg96-t-wyfG6eJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhlohhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdrnhgv
    thdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Uh9caEVhWzKC8z26i0kuQBvNRCUVl9eoHG0oev3CF3ZqWENnnCv-ZQ>
    <xmx:Uh9caLksLEiezojUwLvXeEXzGitCJ3VxoVnP5VN7rGgOyISupD0NOQ>
    <xmx:Uh9caBfdb5Q7qvJIjVpYdkWMC46I4XNOk3H1nucNBnVu52OyI1KPNg>
    <xmx:Uh9caFFeFer0mMaGBy5rIqeFSQTtOD_G6belVQL_KV6ra-9_95S3Dw>
    <xmx:Uh9caFm7Mhd8DAfWqYNPLxaz5mjMb4d1lYGeGa1K1wlBaQi3lzhsIzOo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:09:54 -0400 (EDT)
Date: Wed, 25 Jun 2025 09:09:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
Message-ID: <aFwfUCw2izpjC0wr@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
 <c649c8ec-6c1b-41a3-90c5-43c0feed7803@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c649c8ec-6c1b-41a3-90c5-43c0feed7803@redhat.com>

On Wed, Jun 25, 2025 at 11:52:04AM -0400, Waiman Long wrote:
[...]
> > +/*
> > + * Acquire a hazptr slot and begin the hazard pointer critical section.
> > + *
> > + * Must be called with preemption disabled, and preemption must remain disabled
> > + * until shazptr_clear().
> > + */
> > +static inline struct shazptr_guard shazptr_acquire(void *ptr)
> > +{
> > +	struct shazptr_guard guard = {
> > +		/* Preemption is disabled. */
> > +		.slot = this_cpu_ptr(&shazptr_slots),
> > +		.use_wildcard = false,
> > +	};
> > +
> > +	if (likely(!READ_ONCE(*guard.slot))) {
> > +		WRITE_ONCE(*guard.slot, ptr);
> > +	} else {
> > +		guard.use_wildcard = true;
> > +		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
> > +	}
> Is it correct to assume that shazptr cannot be used in a mixed context
> environment on the same CPU like a task context and an interrupt context
> trying to acquire it simultaneously because the current check isn't atomic
> with respect to that?

I think the current implementation actually support mixed context usage,
let see (assuming we start in a task context):

	if (likely(!READ_ONCE(*guard.slot))) {

if an interrupt happens here, it's fine because the slot is still empty,
as long as the interrupt will eventually clear the slot.

		WRITE_ONCE(*guard.slot, ptr);

if an interrupt happens here, it's fine because the interrupt would
notice that the slot is already occupied, hence the interrupt will use a
wildcard, and because it uses a wild, it won't clear the slot after it
returns. However the task context's shazptr_clear() will eventually
clear the slot because its guard's .use_wildcard is false.

	} else {

if an interrupt happens here, it's fine because of the same: interrupt
will use wildcard, and it will not clear the slot, and some
shazptr_clear() in the task context will eventually clear it.

		guard.use_wildcard = true;
		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);

if an interrupt happens here, it's fine because of the same.

	}


It's similar to why rcu_read_lock() can be just a non-atomic inc.

> > +
> > +	smp_mb(); /* Synchronize with smp_mb() at synchronize_shazptr(). */
> > +
> > +	return guard;
> > +}
> > +
> > +static inline void shazptr_clear(struct shazptr_guard guard)
> > +{
> > +	/* Only clear the slot when the outermost guard is released */
> > +	if (likely(!guard.use_wildcard))
> > +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
> > +}
> 
> Is it better to name it shazptr_release() to be conformant with our current
> locking convention?
> 

Maybe, but I will need to think about slot reusing between
shazptr_acquire() and shazptr_release(), in the general hazptr API,
you can hazptr_alloc() a slot, use it and hazptr_clear() and then
use it again, eventually hazptr_free(). I would like to keep both hazptr
APIs consistent as well. Thanks!

Regards,
Boqun

> Cheers,
> Longman
> 

