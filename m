Return-Path: <netdev+bounces-163540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E98A2AA72
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1971672E5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D271C6FE8;
	Thu,  6 Feb 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QalG9uTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624821EA7F6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850051; cv=none; b=YJYJXylib1kUr5rCURUw5zUpW6K5aE3SfgPC1qf9Q1Y2ozdc7ZH0I2zA/dTh7t6BAiGJ9NBMWEFaoAZOsHeb+VphXbtD0aQajko8TF1EZiuNZgfTFmsm3KndoULTnR9Frd65mJjz9s5P2Xzpd3Lny5n3wHTYAMhcZp1TifWWzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850051; c=relaxed/simple;
	bh=sD3W2pTNIk/sfrfGtLR1H6fgpVJgyvEuZjQxPRE9I3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSf1IU93rSkOKeO9DMX99LIlFkpguQJNsv3W4GsahUv4BiCu2sN7E0JMiymBPvhkG1rX2OW6e1ZQec/2vHSX8QZ8gNizfAWrRS1uxUb6XRN2zTOgbyWYYSyj/uvuBYnztu3YQRjqE/YBH1tbomJV66jk+KM7Yyd2P4xtJ7A2Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QalG9uTJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f49837d36so1674555ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738850048; x=1739454848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cf3mlOaejsKZ9ax/ZskOU83xdB6ceu0QUVUBo/DMpU=;
        b=QalG9uTJm8fUN62XMNw64h8l43u2zmzEssfq0+w4lF2E9VsXy0YV+MrrpVoTMuhb0Z
         Vq+vTyrNtpW9lpaL2qGnllHBSiwdVB3jY6arJv2jKlS5OJlmV0pCuHG+xOu3prWY+Qa5
         4N1mJJDW0JzSYMNtsYo8mpe/dr4pNwnPqDk9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850048; x=1739454848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cf3mlOaejsKZ9ax/ZskOU83xdB6ceu0QUVUBo/DMpU=;
        b=ZXh+z5FrUYby6riv5neA7aaUXZHmdJK7GzcdFEkBlM+inOjxNHzYoBQz2TEc2hQZT5
         mF//4wx4Nv+e4xFQMJKSKzu1aeRARRlZ/atz6uIkvJXI7HEygK1A8cgKRiQkBbgK3r70
         lFwBteKixef2/9dX9UQ7DeoFoCPVhpsLhioUpOSCdsrHzyNzlNQxm8expzPF9z3OMWpy
         kOXK2MwfvChUTMolkMCRYYNobIikN/acjQuQCdfc/OhKW8xNbaMbCK3weeEfPP9ZZxL0
         jxjhvJYnK631jy4V2muglHFD5SwR3lKzn5aeeqNtwqanPVyiVF+zRRTrxHkRhJKcsTxG
         eR0A==
X-Forwarded-Encrypted: i=1; AJvYcCWbd//d4qjvYG7eFdhn72Zu156DsKg8EZ3GshAY+KUw6oKxVzvJtBYRq81OiaZgAPk8N/uxUNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtJ5VHJbml6l4y61VkuBUgNyJNXsarEZtyMX6KsDF0dL66SFK
	bqDmCVQqcxYyFaVs9TA3ACMJoNYLWn4zHpeMYYZYgkHFNR4ZxI1Ok/Et/yPkb9k=
X-Gm-Gg: ASbGncu4r7J2n0KhRso1mxwEOvwggpyWt3hAbbQ5l/5yXp4cePQOE+XQVl8T5KjTXCe
	J+4v+QxNz92KS2n/u5rPF3XweUstme9oSpF1WGJ6wUydZOjXoUaw4FX8o6fsedAA6VHnvMBIuKC
	DhOfJrHsuODGUwd/xXvSOhHnflIHIKsqNhPPbwThuVxc22JTwx0ds19WfyfcEog/oa5KABqUU5G
	FIME5/s7YrIlIadOteOJc6AJ04RBx0comHHfmPtnC1sAFWw6e00E7bCYRm+qAiWPIoP04vyKZ93
	c8tS9a0LG/FSBL9OZstxlwQZXxDQ/UP+VbGkdZAxw3KLDYBvVuvpUtbUbw==
X-Google-Smtp-Source: AGHT+IE/4lYV0oBaumMcoJvWlF0VrUq9JTndbb3FruwLbZfGuOTngmPWHu0rhT3zJQKs9DS+zTKiVQ==
X-Received: by 2002:a17:902:f64f:b0:215:8270:77e2 with SMTP id d9443c01a7336-21f17d114d9mr130276725ad.0.1738850048578;
        Thu, 06 Feb 2025 05:54:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687d169sm12740875ad.202.2025.02.06.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 05:54:08 -0800 (PST)
Date: Thu, 6 Feb 2025 05:54:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6S-_b7XwT9ebpIZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
 <b2c7d2dc-595f-4cae-ab00-61b89243fc9e@uwaterloo.ca>
 <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhS69zRTBM7ZLNR08kL+anYuffppzU5ZuNORxKGQgo7_TA@mail.gmail.com>

On Wed, Feb 05, 2025 at 08:43:48PM -0800, Samiullah Khawaja wrote:
> On Wed, Feb 5, 2025 at 5:15 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> >
> > On 2025-02-05 17:06, Joe Damato wrote:
> > > On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> > >> On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > >>>
> > >>> On 2025-02-04 19:10, Samiullah Khawaja wrote:
> >
> > [snip]
> >
> > >>> Note that I don't dismiss the approach out of hand. I just think it's
> > >>> important to properly understand the purported performance improvements.
> > >> I think the performance improvements are apparent with the data I
> > >> provided, I purposefully used more sockets to show the real
> > >> differences in tail latency with this revision.
> > >
> > > Respectfully, I don't agree that the improvements are "apparent." I
> > > think my comments and Martin's comments both suggest that the cover
> > > letter does not make the improvements apparent.
> > >
> > >> Also one thing that you are probably missing here is that the change
> > >> here also has an API aspect, that is it allows a user to drive napi
> > >> independent of the user API or protocol being used.
> > >
> > > I'm not missing that part; I'll let Martin speak for himself but I
> > > suspect he also follows that part.
> >
> > Yes, the API aspect is quite interesting. In fact, Joe has given you
> > pointers how to split this patch into multiple incremental steps, the
> > first of which should be uncontroversial.
> >
> > I also just read your subsequent response to Joe. He has captured the
> > relevant concerns very well and I don't understand why you refuse to
> > document your complete experiment setup for transparency and
> > reproducibility. This shouldn't be hard.
> I think I have provided all the setup details and pointers to
> components. I appreciate that you want to reproduce the results and If
> you really really want to set it up then start by setting up onload on
> your platform. I cannot provide a generic installer script for onload
> that _claims_ to set it up on an arbitrary platform (with arbitrary
> NIC and environment). If it works on your platform (on top of AF_XDP)
> then from that point you can certainly build neper and run it using
> the command I shared.

I'm going to reproduce this on a GCP instance like you illustrated
in your cover letter, but there is a tremendous lack of detail to
get the system into a starting state.

As Martin explains in his follow: I am not asking for a generic
installer script for onload. I can definitely compile that program
on a GCP instance myself.

What we are both asking for is more information on how the system is
setup or, as Martin has repeatedly asked for, a script that gets the
system into its initial state for each experiment to streamline
reproduction of results.

I'm confused why your responses seem so strongly opposed to what we
are asking for?

Neither I nor Martin are against a new mechanism for busy polling
being introduced; we are both saying that a general purpose
mechanism that burns 100% CPU even when the network is idle should
be carefully considered. Wouldn't you agree?

The best way to carefully consider it would be to include more data
and more measurements of important system metrics, like CPU cycle
counts, CPU consumption, etc.

I don't intend to speak for Martin, but I'm asking for (and I think
he'd agree):
  - More rigorous analysis, with more test cases and data (like CPU
    consumption, socket counts, message sizes, etc)
  - Better documentation of how one configures the system, possibly
    using a script. It's OK if the script only works on the exact
    GCP instance you used; I'd like to create that GCP instance and
    know 100% that I have the same starting state as you when I run
    the test.
  - If more test cases are going to be tested and the data extracted
    for a cover letter, a script that generates this in a standard
    format with all of the metrics would be very helpful to ensure
    we are all measuring this the same way, using the same command
    line tools, with the same arguments. In other words, if you
    decide to run "perf" to count cycles or cache misses or whatever
    it is, capturing that in a script ensures we are all measuring
    this the same way.

If you think this is unreasonable, please let me know; your
responses suggest you are opposed to more detailed analysis and I am
trying to understand why that might be.

