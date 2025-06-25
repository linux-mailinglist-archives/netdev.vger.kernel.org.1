Return-Path: <netdev+bounces-201188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D39AE85D6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5161B5A7845
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58716265288;
	Wed, 25 Jun 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU0kBddW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCE264A7F;
	Wed, 25 Jun 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860544; cv=none; b=CbZKMv2C8yRMXE1GynCywNvMflkkb3Rt+xctmhQNfmTfEng8i3NmSbAk75uPVVBWpgvLVPbVig8/T1q6s2OxAC97zE5zhR5MK89Pq5WN36OZmuzdfLYF5fxYxGbSMRTHI5S3/hdg8TPGCEE0anqtkuvuQGjYj5C1+bMwYZ+j1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860544; c=relaxed/simple;
	bh=WpwnfGVGjxp5of/6IZTd6KwuTsBR7L32KPSN66Lelok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUbAdooXDDtDQQ5+o4nK77C7S+Qb6U4snCj9Dj+Atvl/uchEpBn73zikHBQZKlbPk/VzV/2cIuG8mw68308DKdPwlCIOMU8rMQcfDpDhyLiPL9DFbQEG1gVSIFyXSL5ezqJXy1kLh5vJX6EJ5icwJbCh0RJEH0PLpKFSbr/KuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU0kBddW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d0a2220fb0so818294585a.3;
        Wed, 25 Jun 2025 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750860541; x=1751465341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJCFyxNIJ7B2fFTdwEw8L9jsO7+gbSPGHGFr4LFZGcg=;
        b=XU0kBddWkLI8Rs+F5wilCqHuckRIqbw0Wl/+v7L3udgjt/SRf0uDAiN0+3OT0pHTDJ
         CnieZNQ/+936h66/nGU/fkIiORIJtTtjvUTW1BPR2naE7zjtbdAXZIGnv6uJ8ih6mPUN
         8zOasVN7T5hBxZn8TqB/xTo/IVkloy164ya5jQn2WZHrAugmMIXOnF8cEGQcHCiWjwNf
         I6c6zHKH5nt/hMolThArxBCnbtu1vQBZwz4N+0TClme+tLLRXzeczhbxCs2EOgIxcrTd
         hP2hjTrRUjwNWHpoG6bfzyWnztPj+PiV8ENygMzwjhwyCVx0cmCA53n9MSkledgIKKJG
         01ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860541; x=1751465341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJCFyxNIJ7B2fFTdwEw8L9jsO7+gbSPGHGFr4LFZGcg=;
        b=XAvU0mzU2MxxqkAU5hyiEm9ZKdp9AYm764fjgr16gtpUmwlkNbrQaiTzOlLitAOkX+
         9K2SbMCwXQjB1MmceElLD0LopKMdHUcMxjZd2s61A72jz7tQQaomS5FJpydd6/UzhNdA
         cFgWkwchcnbc1nQQgrgoYw+6ETB2EB1HBp08mcQjUy+WE+X2jICbRE8C8u2lwsb69Y8x
         IKH9sYw5ZDRZEXXQAoiHmZhFqV2LiygtXWHiCwOTb3H8NJ6p9B5LajAgSnfV8D+Sa2aF
         5F3OYNGGeaEReNqzciiAIRA7aKUxDVNqL6zT6rJRsN3rLa0lS8leTjGinrwXvdXToeGJ
         1VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJNub4JQaacroUiDfENLCIZw4jKX5mX1MIpbhPy2t/UJwYQ4U77fnzQwqwzsOR01LTTukR1OA=@vger.kernel.org, AJvYcCVuGXWQQxY44lMCy42JXhpftrm/jTmr1UtYVrpu83IdC5MCz6cuSlm7NCjvfOUg2n2+5iEs@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVzgzInLOIRIaDvskuLZAkW9YPzGAi2boJk06mV+jQ30ftBsz
	amH2h1JjyuPJophrtcjOtptN61XuTI4TCgWUHWv4ULH40U36Uk9jExs9
X-Gm-Gg: ASbGncvWppp3lpvq12rVUfIYmk3Qeu1+m/94ZHGq2D2emETvFUw8xgoHMuwYdShKwRF
	Wgu/ftohbBhkypc7ZmtFKHzXwptKOf90wszZjghniSlMaRLXnLaag0PK9QBT9hYuGaiuknKDUQD
	kOwGpB7Cvr4ZwjHq5h0MHj8n6mB4guUkpE8zf5XsTOMDejT2NAOiaWGbDJqsJ/6aCmWC5L4SfZx
	wozNV86KKCTugagTKZLllsywYmJM/vIYamAXXeieZef4pumke65D27qulHZZW5GPdbx26VDAeUi
	v9mCRDA2kkrVVaAUeqSipS/p/uWYB6w/OZ6e/ninyQOY5KheHZehsfDQFqhQhwwfMImeUH22pJk
	MpAwDmRidW84/HzPjafEUz5urLcCu60D9yuhwcAhq5QlzhWMoxrQY
X-Google-Smtp-Source: AGHT+IGP3xXAQS3aRTeDmPFsQlYIlwFJjsOntFEA1J01weuYZPTG6VG9nUgH89lQn3xG0BigJ5bv8w==
X-Received: by 2002:a05:620a:2902:b0:7d4:e3e:6606 with SMTP id af79cd13be357-7d4296d49d5mr473909885a.18.1750860541118;
        Wed, 25 Jun 2025 07:09:01 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f999bfdasm618007285a.1.2025.06.25.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:09:00 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id C6F9FF4006B;
	Wed, 25 Jun 2025 10:08:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 10:08:59 -0400
X-ME-Sender: <xms:-wJcaJdwbGZBmxEN9j6y_78lQL4fcdBQvDTlOCyqeew87MY_tXnEHg>
    <xme:-wJcaHO2fQ7GEaRxo6xqYDR28zh9SO-8ANjsQIwEDCtQd40EvDSAFHyG6ll5l7hnG
    u-Ol92oGK7gJditFA>
X-ME-Received: <xmr:-wJcaChZ1gB2oei1fHWaEjpsWflJu3QQnVqBK3jhFv5uI2C5hjTofK4kKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlih
    hnuhigrdguvghvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilh
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopegurghvvgesshhtghholhgrsghsrdhnvght
X-ME-Proxy: <xmx:-wJcaC9SIRUxm3GO8s19-RXkdVH_rArIOhzfzpcmzNM-_d39bSt6Ew>
    <xmx:-wJcaFv8nbBOJLcGByCnAxajdWVjxopT8SmEcUiCmBZZYZC3PgMoTg>
    <xmx:-wJcaBHRyDLwhfOzIx4pKXsYEiKQJhUSMNQ4wc5h5L1PAdmOSr8nYQ>
    <xmx:-wJcaMPbn_fTVl6EW6q6E9gbgVJTQ0WkpFPVpeq40MWWr-yF0GC_iw>
    <xmx:-wJcaOOQ9shCLPu7c6XInbYEihY93p9riyskcRSe86qZBaWl3X3bFgqB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 10:08:58 -0400 (EDT)
Date: Wed, 25 Jun 2025 07:08:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
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
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <aFwC-dvuyYRYSWpY@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <aFvl96hO03K1gd2m@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvl96hO03K1gd2m@infradead.org>

On Wed, Jun 25, 2025 at 05:05:11AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 24, 2025 at 08:10:53PM -0700, Boqun Feng wrote:
> > Hi,
> > 
> > This is the official first version of simple hazard pointers following
> > the RFC:
> 
> Can you please put an explanation of what hazard pointers are
> prominently into this cover letter?
> 

Sure, I will put one for the future version, here is the gist:


Hazard pointers provide the similar synchronzation behavior as RCU:
readers are cheap, updaters need to wait for existing readers to go
before they can free the objects.

The difference between hazard pointers and RCU is that instead of
waiting for a grace period, which all the readers have to exit the RCU
read-side critical sections, the updaters of hazard pointers only need
to wait for the readers that are accessing the objects they are about to
free. For example, if we have 2 readers accessing different objects and
1 updater is freeing one of them:

using RCU:

	Reader 1		Reader 2		Updater
	========		========		=======
	rcu_read_lock();
	r = rcu_dereference(a);
				rcu_read_lock();
				r = rcu_dereference(b);
							synchronize_rcu();
	rcu_read_unlock();
				rcu_read_unlock();
							<synchronize_rcu() returns>
							free(a);

The updater will need to wait for reader 2 to finish before it can
free 'a', however when using hazard pointers:

	Reader 1		Reader 2		Updater
	========		========		=======
	g = shazptr_acquire(a);
				g = shazptr_acqurie(b);
							synchronize_shazptr(a);
	shazptr_clear(g);
							<synchronize_shazptr(a) returns>
							free(a);

				shazptr_clear(g); // <- updater doesn't
						  //    need to wait for
						  //    this.

The updater's wait can finish immediately if no one is accessing 'a', in
other words it doesn't need to wait for reader 2.

This means for a particular workload, hazard pointers may have smaller
memory footprint and less updater wait time compared to RCU, while still
have the similar performance on the reader side.


That being said, it does come with some cost, the readers would need to
provide their own hazard pointer slots (allocating memory) in general
cases. And in the simple hazard pointer implementation in this series,
although readers don't need to provide their own hazard pointer slots,
they need to disable the preemption to use the hazard pointer, and the
performance would downgrade (to a naive SRCU implementation probably) if
they want to protect multiple objects in one read-side critical section.


Regards,
Boqun

