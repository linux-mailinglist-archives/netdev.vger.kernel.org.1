Return-Path: <netdev+bounces-201190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C4AE861A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220483B2E97
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8E262801;
	Wed, 25 Jun 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmMKYV47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963B264608;
	Wed, 25 Jun 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861111; cv=none; b=FI1QCTuCjfwRji6IlcSMtEcJbVOWZThcDgLM1D0LRBOKt75GsTxbmkQom0TP/sauCiS/w6gDMXs9xlZWv5Vt/5P+JBob2b+Yc+LqquPbQeBP15uuBuO6dw5lwMtUCyH4TxjFmAi6amCukGYcp7NqXi0DaNfFlDb1GLJTd0dVnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861111; c=relaxed/simple;
	bh=v8kTdUhjATpjI9S/z2ca5IIHJ3LI0Gt3dbKmgjAwh4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS5KPbUK2htVqIteOfp4GbQAAzE968WkA/doO+KQ653PVpIk77/eTWSzFWfT5N7u/Ot3A1uZzICQtsa5S/Dtvay/WJg0+RN4MxS6xKdYH20TfY+liUf5/rZx0zirhYe65ndMBSW6jYpsq12CPdS4lU5p29ECO/UsN3uN6kpCKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmMKYV47; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a4bb155edeso18152401cf.2;
        Wed, 25 Jun 2025 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750861109; x=1751465909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SApv73wV95/PW1AcOp5ta6WUGd2OuNz5QHUzFSvdal8=;
        b=JmMKYV47ed4AWxrmUKDs/1avnvPKTizPxumU+JqjleIPBWtlMcPafNz5vN9QmT4B+Q
         VbhXVewIwgNGRw9/Kr2yiTcI7hZYS/i4s9CVeb/mJ4NDDVbSFCfnjszposqGS05hXK0d
         31tc39+XAF+dlsTvgz01wV2eCuV5t/JtgQFkHjGCw8zmrUc2DMgR8d3QRNB2xFde7RGj
         LHk/toFnVFgpNpMnGVWY4nOXLGChMqPj5vnp2jjeuLh+aeWcPDZuPljmZj7+oBFfU/D+
         4Kdw264YCpTyeX6G4TLhA0AObxE7sz8cBD1fDMgh7pHtld0Vqnp2JO5yEubEh6GjfFvl
         0DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861109; x=1751465909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SApv73wV95/PW1AcOp5ta6WUGd2OuNz5QHUzFSvdal8=;
        b=Cu3fL+2JL6F+aFIKTuJEr9AOlxgctMiz/77S3zF86Fk8awWH5j6XaP73sHpl8z110e
         YkFscrdRlnDEsmSAfYB77XkbSfEmOyrw2yCfuyNfFXTUEdmHberpQVqHTGw2JgY6bQ/h
         536LO1Tja1F3G+S9Eyo8o81/TWkau299Mk8pxCnvQTsg/4vd4tkmUjrr6NyWI958TmZe
         F0IlnjNpUc1cihFNP2u0sA9ZcuKCFrcNHWFt0ViQSiwM+sFJT7C0KvgQ8233vUIU/POz
         oZ0bl7y4ZlBT2Xxec2WPqBumu8fr1IHmYdjle/6Pgy2UOCpa4zNuBWtMhvzTGmpf8EkG
         GJAw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ahJHXSGP2+Rxx4w3tkcAlBdKzZdrLoUCrBPyNrYQzIAL6CNZGUmtQI3vBMAnZg+A7v+g@vger.kernel.org, AJvYcCWt9mlFDDh+oXZYLKGlPhqbjfUolkO0wAVWOC0OmFTfhb3Sw7WQyGRhRVByZXaw1WnFLgdYT6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnupIEI7QPAfZrzUaKVLyRjEqgQI9FxUAE3qHhtQIgK7EvRH5
	keSFMMccCMVZSyD4wWKJZNTQBjsIlMJCF8fhF2hw/YW/ti5zebgYfl9A
X-Gm-Gg: ASbGncuYeEZJyxo1wZ+REBiaSvFwT8fNqsgZZRBvn+U/y1vcaOYanp9/ZT3kv1yO6E2
	zF/e1DCJAdSWM7lgI0RLbKLl+GIa+Gn83WbuQUb5LTKp3P9H+33h3JpeehCUf+5rPakvwiYrOaa
	oFr9k5zA9K9erBxjrdqFGE88l3BNOPKoKv16ohp0SfeZWvJsHGyQ7892CaYoyZHeLnAaYE4FPke
	e2g9oxPhKqxVrdOAJm33tiYsZYpQp7Ii51Wq1M5I43T/6jdG4Ht1woVHAMV9FF9dvGqad3i187n
	WOl2oG4sULyO2E+G2epncv/DYT4cdHJ9JvO/c5tFrRh6JVc+VpcJkdA8S5khh5RlYf9cSBxTG1M
	CgoVjiF0EBzVqFzHbN0XIOIOr4yjEYdywm7lZuQlImflns/4bc+sjYYj5ZDNmp/o=
X-Google-Smtp-Source: AGHT+IFajQmaBSIi950oGCwkkGhdcIDigDTu+52BcWLWhXdTGrL+WmNf84aM6QjCMYIHqOhD0NhhMg==
X-Received: by 2002:a05:622a:506:b0:494:f1e7:65ef with SMTP id d75a77b69052e-4a7c08452d9mr53303541cf.44.1750861108315;
        Wed, 25 Jun 2025 07:18:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e5d262sm59894161cf.50.2025.06.25.07.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:18:27 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21392F40067;
	Wed, 25 Jun 2025 10:18:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 25 Jun 2025 10:18:27 -0400
X-ME-Sender: <xms:MgVcaOwCVCagevnS9sW-PJ7ylYPYtdu6iXaUdfYmg2HNwWYMt8UPMw>
    <xme:MgVcaKRi623tvmF9P0BvaTyMyAvAcocMsiFXhFMwHt-3WicPtos_Ah6cAKtW5mJV_
    XMWv-KLXacVdLQ1Gw>
X-ME-Received: <xmr:MgVcaAWwaGbiUqOhNRJq1dJuqpKzsYsUstJI_7KFdqlU7_4N1XX-Iat9HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgt
    uhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmh
    grnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdr
    nhgvthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MwVcaEjcNogxlCJElq5Ale1bJ6pJZUTJdaXABNsyrKdceAsKRxft7Q>
    <xmx:MwVcaAA_6AfgxN3VXiJPIlFf5fAKOd1ovbVo0vsoEOvkLjTAj515Sw>
    <xmx:MwVcaFJvY5vFTAcHAX_cpzwNn-nVmedOU6MB4Aoenx3yRVhBiB8WMQ>
    <xmx:MwVcaHCjj62N_PPcE_CoPkoZG03OBmd1OkYqSXajhjwJ_k_GNAZO2w>
    <xmx:MwVcaIwD8Mb8OCae105Kdepdt-LxOuJmSd7xTQiTc0SL56i1uNop8Lmq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 10:18:26 -0400 (EDT)
Date: Wed, 25 Jun 2025 07:18:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
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
Subject: Re: [PATCH 8/8] locking/lockdep: Use shazptr to protect the key
 hashlist
Message-ID: <aFwFMf3K_hBygBED@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-9-boqun.feng@gmail.com>
 <20250625115929.GF1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625115929.GF1613376@noisy.programming.kicks-ass.net>

On Wed, Jun 25, 2025 at 01:59:29PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 24, 2025 at 08:11:01PM -0700, Boqun Feng wrote:
> 
> > +	/* Need preemption disable for using shazptr. */
> > +	guard(preempt)();
> > +
> > +	/* Protect the list search with shazptr. */
> > +	guard(shazptr)(hash_head);
> 
> OK, this is the end of the series, and so far every single user is doing
> both a preempt and a shazptr guard. Why can't we simplify this and have
> the shazptr guard imply preempt-disable?

You're right. The background story is that in the beginning, the hazard
pointer protection was placed at the callsites of is_dynamic_key(): one
in register_lock_class() and one in lockdep_init_map_type(), and in
register_lock_class() I could use the fact that it's called with irq
disabled to save the preempt-disable.

So given the current users, it makes sense to fold the preempt disabling
into shazptr guard.

Regards,
Boqun

