Return-Path: <netdev+bounces-178368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4549A76C2E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8CB16B494
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971821481B;
	Mon, 31 Mar 2025 16:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3462E630;
	Mon, 31 Mar 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439720; cv=none; b=pnLYCVOdT1KWbmYVJ4qIUzdcW9WT+ogURXbRnq8E15locRo4O83ubcShDv0lA4RTIBNvF8cYTvfUKw8QyMBNrUtwPQ17bzk2wPBrZGszCvnoAAs2p2vqWztXsa/NvG0B+7MgTFbBnXz6EMHxYH1ALTlJ9Q7ED8lEQXQzsHkhvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439720; c=relaxed/simple;
	bh=CHf4F+Vs2THX+O+eioOWULMiJfIIbhKmgIxfWXMsmMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9MOQs67utp0cmEtV/2uGdCBESH5I3T4V8DNvs/wOSiVXGFJQDC0o6RxRDl1mA20plArmu2y9xqObUTGvAogUQMCJ6JIRLzlZCtiLOsz6CkqFkp4hDrU1bZL8UVYjVosAFxt6g+iU7FiHx/PVZsRbQYzrZjrB75XOn2cqpK7crA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac73723b2d5so455795066b.3;
        Mon, 31 Mar 2025 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439717; x=1744044517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E8+H59wzbXfu7vdIDwS2i7uceTsCJ9EpwxfmQG2Njk=;
        b=ZMWPTSVjR2eK4PcVTv96kWC6dmV7o9brf3sZZFNAHgC87ObVss6Vwa9lEvSsgmUc11
         ptevtVjqo+wO3c0Qc4/uZpS9jCAy1cAlKqns8gmscKusKfYBdBv0DYs4i78hjje3zuIH
         AA9fd42poZpLkOeh7FZVZXwywnS+lLH3z+Vk9Bj9QZHdWO/m+uAXimD5hfloTWFqjlKL
         9UBOdUVvovFaxrRibnSEYiGwqwe3TYCb4cjfYjQefLj0ePv7dG026MMjwa2j0H02ryxE
         e4t4ZTrXkBc9mWov8mZcsg1am6d8la77KRi7DlVYzU37AWSiIJtbBKftealmzKaDQPa/
         VKew==
X-Forwarded-Encrypted: i=1; AJvYcCUUsbXAr6Mq1GWiGbwy+hOyT4JVNHUld1q2Mav4XNUArZVy2Uuda/LDh7xDjUAe3ajSWjvvDiUj@vger.kernel.org, AJvYcCXeOHq5J48V8QQf77cG4Fn9stbQJPRfGnfJfYyWI93sjgfXrPWmyRljA79pYLmxAXSn0/T3gCpukIdbfP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9AJewNlUMUumsXVKWRyMdKYOZRxA/11UR+1vjAUNnIOmBmmG
	LG02ymjX6YjI0osBZRm/EgJUwhNX4HSlKVgx53+/Bm2cQtzAp16s
X-Gm-Gg: ASbGncvZJlEQZYxkeAH9SSZ+NnX1pBAYAmLRKtHEZ8c7RJG7mjHcLE3rMr8E59NfOvV
	Vj+PlrWev46mPa0KkORD0T3aLI3KgtCKY0IHTshneFdlIXWM6UanycW6fYVGI9FHhkPm1+UgPLE
	aimoQFt/R5y84j8i4IRf9+Y+8YyMpV4Snnn/pvsbMkcQACKvVRA6g8cYpvHEa/hlMykqVjYx/Ez
	KRTWJJ3WS13j/R7jemVndybkOHUV88zdwsGPRgT4XvO5H4TnjPX6XocL3FcFV1SbM4qr1l6Xt01
	ILX+BdZL4c2xfb/vy6nccw3rWW/KsNlOixg=
X-Google-Smtp-Source: AGHT+IG9Hetq4icmncBIQ+Sho5r6qqCRy3N2GORfFwLBOGtVM5myc3g/zvhQdJi3y87ufObaGZ6lBQ==
X-Received: by 2002:a17:907:7fa5:b0:ac4:16a:1863 with SMTP id a640c23a62f3a-ac738a50991mr890792466b.26.1743439717179;
        Mon, 31 Mar 2025 09:48:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b027sm639547066b.47.2025.03.31.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:48:36 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:48:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <llong@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <Z+rHYq0ItKiyshMY@gmail.com>
References: <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
 <Z-QvvzFORBDESCgP@Mac.home>
 <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
 <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>
 <67e44a9f.050a0220.31c403.3ad3@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e44a9f.050a0220.31c403.3ad3@mx.google.com>

Hello Boqun, Waimn

On Wed, Mar 26, 2025 at 11:42:37AM -0700, Boqun Feng wrote:
> On Wed, Mar 26, 2025 at 10:10:28AM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 26, 2025 at 01:02:12PM -0400, Waiman Long wrote:
> [...]
> > > > > > Thinking about it more, doing it in a lockless way is probably a good
> > > > > > idea.
> > > > > > 
> > > > > If we are using hazard pointer for synchronization, should we also take off
> > > > > "_rcu" from the list iteration/insertion/deletion macros to avoid the
> > > > > confusion that RCU is being used?
> > > > > 
> > > > We can, but we probably want to introduce a new set of API with suffix
> > > > "_lockless" or something because they will still need a lockless fashion
> > > > similar to RCU list iteration/insertion/deletion.
> > > 
> > > The lockless part is just the iteration of the list. Insertion and deletion
> > > is protected by lockdep_lock().
> > > 
> > > The current hlist_*_rcu() macros are doing the right things for lockless use
> > > case too. We can either document that RCU is not being used or have some
> > > _lockless helpers that just call the _rcu equivalent.
> > 
> > We used to have _lockless helper, but we got rid of them.  Not necessarily
> > meaning that we should not add them back in, but...  ;-)
> > 
> 
> I will probably go with using *_rcu() first with some comments, if this
> "hazard pointers for hash table" is a good idea in other places, we can
> add *_hazptr() or pick a better name then.

I am trying to figure out what are the next steps to get this issue
solve.

Would you mind help me to understand what _rcu() fuction you are
suggesting and what will it replace?

Thank you,
--breno

