Return-Path: <netdev+bounces-201640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F5AEA2F4
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAA71894F90
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E152356D9;
	Thu, 26 Jun 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDh0diAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD2218E96;
	Thu, 26 Jun 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952852; cv=none; b=Ao2qvP3AJpkFsL9TknOc5rJl4fW8THOh1z0InQLnuzzMsotTuxtTQVBUYNlXKbujLOoykP7KFLXsyUhbdf6TmpegbVARdDa4NGxRaEiiF7rSqt55gPoClHnSIdgNcSB4TPuWE/H7Gdbi2oo8CIDCowbkSJ5BKHzX3QV4vcToTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952852; c=relaxed/simple;
	bh=GWh6XhJMCVTqRA2wBhoPAZXgdLaG2+SShV0Fpkjiq2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0rbKO6KYXxGWEwqHL9so+a9Q/I2YMnHVfHUVrj9pWtpnT3s0xWtzZZFqbdfQ3NzKLQFcwiKQX10IpExU9PRQLNgmhoCBDg8uvWeei2hifi6nGQNLyFnIpAs86xzB3ZGDxn6Jr6M1CyrAC3U8EDj0E8S4FSZDq/LGCfqjQAqbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDh0diAC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a44e94f0b0so16297601cf.1;
        Thu, 26 Jun 2025 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952850; x=1751557650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhLqdfALuy79ecMu0yMGQplKZjT3wYfhZtz/kdHd2hw=;
        b=KDh0diACGmylXMqecQXjw0fJfoqtW0iP5O7TivPlyto/XgDfhqVdMUr76bR3CgzdFr
         gDOUAgy+j1knTHBPhMo2vjVrWeujzqutV6djlNLJjqx5NFNEgLTLVXNL34xVqWHTn82q
         ar8MqlzLJlAVyOxoK4gGjXq3CsdNeKa3A3ujAtmTZoxE6awhIrJozC4V8u8APaJuYwXr
         1Su5npTc84Jbt6QmscSvj6FnXzbnp6E75VWhpctFvo4oq/tXIV3pNMmsaONNr9UKZD0U
         2TYzzy3c+yeJl57So6ex3qnie+gJF46aWgDFrzxNDZNupmg3VfaBJH3lVH0tanLutmLG
         9JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952850; x=1751557650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhLqdfALuy79ecMu0yMGQplKZjT3wYfhZtz/kdHd2hw=;
        b=kYIw34o3a+QA8aKLCU1Z4U+eOw20oySZraLyOyScrfhy/YOynmkEVpaNi7LECtwjAy
         /lPtaQUG2I+OUV467kTnr55xVYZTtFK3LRpLdZZOtcms6+xC6glClFkCaqA2z1mqyVN/
         beOKLoakw2wN5nQlkbbMFnHevCgisxY7qE0aB8qcF5/nVgaqq0z50T1+xp50uSO97kVX
         cjtvngJ9/1zIgi0P93ZuFMiSvfMQcDYXRdA2FWean985wfMFWDdj7dPBaY7hXQ4XS6OX
         3JMNvEo9t1ELxKSM4M+JWXd9r6Y137OwFl9RWTa70tB1/UKU6OtFryv20xr9UNKSXc7t
         kLow==
X-Forwarded-Encrypted: i=1; AJvYcCWXeIucBZsmV7hCYZIe0qn0nf8lGCi7VNLmpQPkMv1lNkIjLyR70bQEQgGuKespYlBA0Otf@vger.kernel.org, AJvYcCWpqhEP7yJno6F5mYbw4RdBEzAFduGF0KOJ2Xxk70UKsDz9k4Hjy70OKCBmF3GZb8tDIxTSZy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lDm72bN1MTyfxQXh7DNgryFkE4lbXB7cOmvdTJK8+kFywXn7
	57K+J8YXbrb4p/Z+xJyvZMRDz7n6tN8SN0IAzTGvOg+TBQhM/Rcg31aR
X-Gm-Gg: ASbGncteP7tmjF/e+lljw215biGbMBT+fH8VH3/LEsyyAA8q3uGU2b9X5rKg2jkOf57
	bufPEHbkAADA0IOcHqZvyn7wkNr3G/Ih7MZiWMtADRPYswg9PPAJAz2fmG48DE0dzfUAunEwJ56
	npne2BZgsx3me+bhsZA5MnkzeC1Rft6Q3ekalIckoArW/ztTESu9JxDyz3WUt+yBW/hNZHvVlxW
	QDymcWDn5FADfQ39GId+4cuMLrbX04DFdEgH8nIujsxYetqVdBRYmh6+C/0lNbx2HmRrWBWSbqu
	rXVEO1dqMrwvQqFoI8nhLLFCWo04BgShD//EErjUaxkphm7XEXYIFi53h3AaiKtooYBZOLpld4m
	qouNuJmUz4CHjw2rM5YNEeQdAd0f+69x7rz4smUo1nh5NjJwmRt7Z
X-Google-Smtp-Source: AGHT+IEOhCnZ8pLf+a8YISSrdtX9i9DRdF2aOmnf8k9SuaTDa5tYgK9sUyuwL4gFJ0WEU0fYrkJSJQ==
X-Received: by 2002:ac8:5815:0:b0:4a6:f57a:8638 with SMTP id d75a77b69052e-4a7fc92eb01mr944141cf.8.1750952849998;
        Thu, 26 Jun 2025 08:47:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57ab7csm623191cf.56.2025.06.26.08.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:47:28 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 928B7F40066;
	Thu, 26 Jun 2025 11:47:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 26 Jun 2025 11:47:26 -0400
X-ME-Sender: <xms:jmtdaOBhWCQr_1RoVYrLbkMaVl4xG_cEcfa_VyONpjmXUhO6i_bDyw>
    <xme:jmtdaIgIB6SW3O-22P0wL799HMZeTfdtkMyIkWmt1oPovWlft2zgoRDt020yT7ckL
    GB8ifg14p1LB9vrHQ>
X-ME-Received: <xmr:jmtdaBkqae0xmz4373Cz4FNzIVKXrpX4_EvAQtduxj8NulqnxuTj8K36Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    ephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedtnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpvght
    vghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsth
    hgohhlrggsshdrnhgvth
X-ME-Proxy: <xmx:jmtdaMzOiFP1auxdZ543LCBYDNuMIB9gJ3LwNG5oP7lYb_Bty_YL7w>
    <xmx:jmtdaDQZX0OUOQEZFDv0vi28epE9xJgmsNJ59H1rO_YRlWkr2-g9eg>
    <xmx:jmtdaHYP-fQI6gZcHUXW_09piY57gdLkATHY-HQRjlwnRhG3o94LXg>
    <xmx:jmtdaMQqVRnKLMPLXvi6jhibmrKKtUqVxl-HKNC1bbRCew7pMK_rYg>
    <xmx:jmtdaFAaELug5nmB8PlJJ2lQusAQ7LK3zw-X8I9UVjWj5Lhdi2V2A7Rz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 11:47:26 -0400 (EDT)
Date: Thu, 26 Jun 2025 08:47:25 -0700
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
Message-ID: <aF1rjV8XQozi7hXB@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <aFvl96hO03K1gd2m@infradead.org>
 <aFwC-dvuyYRYSWpY@Mac.home>
 <aF0eEfoWVCyoIAgx@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0eEfoWVCyoIAgx@infradead.org>

On Thu, Jun 26, 2025 at 03:16:49AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 07:08:57AM -0700, Boqun Feng wrote:
> > Sure, I will put one for the future version, here is the gist:
> 
> Thanks a lot!
> 
> > The updater's wait can finish immediately if no one is accessing 'a', in
> > other words it doesn't need to wait for reader 2.
> 
> So basically it is the RCU concept, but limited to protecting exactly
> one pointer update per critical section with no ability for the read
> to e.g. acquire a refcount on the objected pointed to by that pointer?

For the current simple hazard pointer, yes. But simple hazard pointers
is easily to extend so support reading:

	{ gp is a global pointer }

	Reader				Updater
	======				=======
	g = shazptr_acquire(p):
	      WRITE_ONCE(*this_cpu_ptr(slot), gp);
	      smp_mb();
	
	if (READ_ONCE(gp) == *this_cpu_ptr(slot)) {
	    // still being protected.
	    <can read gp here>
					to_free = READ_ONCE(gp);
					WRITE_ONCE(gp, new);
					synchronize_shazptr(to_free):
					  smp_mb();
					  // wait on the slot of reader
					  // CPU being 0.
					  READ_ONCE(per_cpu(reader, slot));
	}

	shazptr_clear(g):
	  WRITE_ONCE(*this_cpu_ptr(slot), NULL); // unblock synchronize_shazptr()


Usually the shazptr_acqurie() + "pointer comparison"* is called
shazptr_try_protect().

I will add a document about this in the next version along with other
bits of hazard pointers.

[*]: The pointer comparison is more complicated topic, but Mathieu has
     figured out how to do it correctly:

     https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/

Regards,
Boqun

