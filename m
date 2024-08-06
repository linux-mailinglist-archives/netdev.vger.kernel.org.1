Return-Path: <netdev+bounces-115959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDB9489BF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC3A1C2311E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7AF15FA9E;
	Tue,  6 Aug 2024 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zXh0TTIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4215FA72
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928022; cv=none; b=sOR7mhA8k4cLvKxUGN8b6dv9FMQWzWeBelCuq7v62Do3W4VfKSdVFeosOJ1wNI5uWWg1TlslBR+P+v65tyXRgjzFcxSApdQ2ibFXU5taR4zBO8VSsLAmQJkI/S8/0X6WNhiHGeDcnSU9dTIzufTdAy2TPIY5R2inimPQGP6O0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928022; c=relaxed/simple;
	bh=la6dR4Ok57pRe5dA55FKkoGW4N727dPAkEUCZ+HxM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7StkVF4jJe3cBzfY912G0sG/L8RPrqhYyeytmoSdqGDLuev/VlUGUFVhgtlVWqYLvT6V/ZxBnqAI9ki3CTef4Sk7i6awIZWafI0J/8sDQxN+6g1RjIqPkyscmTA/Dw0H6gPnuxmbRtxUH9sCns0A84ejxNV3Igln2+sX9ErSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zXh0TTIm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so242902a12.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722928018; x=1723532818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy+Q3RxBODZsGfiT5WEwhl9omUvs/HM0XsaNmbxB5Zc=;
        b=zXh0TTImx7vFBVII9zvVlAB37vuDhbBnwoTxH7GuudNwKWQ/2vma+KltjZbZe15mxQ
         0waO7uOwai8gf0QwFtfEyvATjkoZG85EEOjJ/BSwpremBuDUPXOXbYO6p4tVwe4gqduL
         I6OTozVdBCIOvHK5LRYrMdq36X+8NMKKqhyUK1GRuZmHrF6g8LvO6X32PfhZ7tp8VDXT
         E6TzwYZUWrbrM/h+ktMPSTvlOvExStW8i+LBfeJELPs8Q819OO5UK8EpNzLKJFP0btDq
         EaawFPZwYBsYCtdGG27v2IsNW/+849TjHrvownG2NUCepbUWy58rv4ES7Doby31z2XKg
         8B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722928018; x=1723532818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy+Q3RxBODZsGfiT5WEwhl9omUvs/HM0XsaNmbxB5Zc=;
        b=QBWZF8qCg0nRXJdNJjojxkm2FflQv85uAOSz8m+vs4U6+NgVH9WlvNGfhEDEs0wyxA
         SKdXxqaFgY+F52NXzbg9JDSze6YJZlshEzZagk2CtZ1DsVxW/EhUhc/pQfvqioezQezB
         3kgx9Hp/rqgXcRypogFAHe1B2QG5QzlO7db6yPYGqw9mB58mT6Ff9my2d4n+GMSqcJV7
         Qo6bjQb1hTm+pZmvmktoY+dKvVaOTnQfjO7go6+RBgw1BYpNtzZzV85rMlRfpBjJnn8S
         xDWIsqRDEqbnZHbjhSVgVE1sUDgI6LpJXgGq/bvkqqQ5q3qe+/rmUyQq8CeGMIqcr5WQ
         ej2A==
X-Forwarded-Encrypted: i=1; AJvYcCWtcg2XEfPTtBKf0Klk+Bi+YbKJEddbUqAgiUFgtJc1gncaBSJBoYABiy2ZchOht8IM0sriY8tb9LdjbQt1IT/FzhN/pHY6
X-Gm-Message-State: AOJu0YzLWVlLwU45B/HXs0na1B1RGI9PMvSQZrKn0CCzACMnNqM2d3xM
	23c1TABg8aOBQ7OhWByAx066u420kRjS2s8t1hhqau0UKUZjG1A1YhzchC6KZEjBeZDPSHHne+3
	8
X-Google-Smtp-Source: AGHT+IG3VhfkSpwWxHqaUPW+A9jjr/toGUKnvHBdpuf9ZHXzsrrGx/YQ8lKSM6Dxq6TSWADRPTePkA==
X-Received: by 2002:a17:907:3f1d:b0:a7a:952b:95b1 with SMTP id a640c23a62f3a-a7dc4e287demr1015543966b.24.1722928017930;
        Tue, 06 Aug 2024 00:06:57 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d43065sm522079366b.98.2024.08.06.00.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:06:57 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:06:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <ZrHLj0e4_FaNjzPL@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
 <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
 <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74a14ded-298f-4ccc-aa15-54070d3a35b7@redhat.com>

Mon, Aug 05, 2024 at 05:11:09PM CEST, pabeni@redhat.com wrote:
>Hi all,
>
>(same remark of my previous email). My replies this week will be delayed,
>please allow for some extra latency.
>
>On 8/2/24 12:49, Jiri Pirko wrote:
>> Thu, Aug 01, 2024 at 05:12:01PM CEST, pabeni@redhat.com wrote:
>> > On 8/1/24 15:10, Jiri Pirko wrote:
>> > > Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>> > > > +    type: enum
>> > > > +    name: scope
>> > > > +    doc: the different scopes where a shaper can be attached
>> > > > +    render-max: true
>> > > > +    entries:
>> > > > +      - name: unspec
>> > > > +        doc: The scope is not specified
>> > > > +      -
>> > > > +        name: port
>> > > > +        doc: The root for the whole H/W
>> > > 
>> > > What is this "port"?
>> > 
>> > ~ a wire plug.
>> 
>> What's "wire plug"? What of existing kernel objects this relates to? Is
>> it a devlink port?
>
>
>I'm sorry, my hasty translation of my native language was really inaccurate.
>Let me re-phrase from scratch: that is actually the root of the whole
>scheduling tree (yes, it's a tree) for a given network device.
>
>One source of confusion is that in a previous iteration we intended to allow
>configuring even objects 'above' the network device level, but such feature
>has been dropped.
>
>We could probably drop this scope entirely.

Drop for now, correct? I agree that your patchset now only works on top
of netdev. But all infra should be ready to work on top of something
else, devlink seems like good candidate. I mean, for devlink port
function rate, we will definitelly need something like that.


>
>> > > > +      -
>> > > > +        name: netdev
>> > > > +        doc: The main shaper for the given network device.
>> > > > +      -
>> > > > +        name: queue
>> > > > +        doc: The shaper is attached to the given device queue.
>> > > > +      -
>> > > > +        name: detached
>> > > > +        doc: |
>> > > > +             The shaper is not attached to any user-visible network
>> > > > +             device component and allows nesting and grouping of
>> > > > +             queues or others detached shapers.
>> > > 
>> > > What is the purpose of the "detached" thing?
>> > 
>> > I fear I can't escape reusing most of the wording above. 'detached' nodes
>> > goal is to create groups of other shapers. i.e. queue groups,
>> > allowing multiple levels nesting, i.e. to implement this kind of hierarchy:
>> > 
>> > q1 ----- \
>> > q2 - \SP / RR ------
>> > q3 - /    	    \
>> > 	q4 - \ SP -> (netdev)
>> > 	q5 - /	    /
>> >                    /
>> > 	q6 - \ RR
>> > 	q7 - /
>> > 
>> > where q1..q7 are queue-level shapers and all the SP/RR are 'detached' one.
>> > The conf. does not necessary make any functional sense, just to describe the
>> > things.
>> 
>> Can you "attach" the "detached" ones? They are "detached" from what?
>
>I see such name is very confusing. An alternative one could be 'group', but
>IIRC it was explicitly discarded while discussing a previous iteration.
>
>The 'detached' name comes from the fact the such shapers are not a direct
>representation of some well-known kernel object (queues, devices),

Understand now. Maybe "node" would make more sense? Leaves are queues
and root is the device? Aligns with the tree terminology...

>
>> > > > +    -
>> > > > +      name: group
>> > > > +      doc: |
>> > > > +        Group the specified input shapers under the specified
>> > > > +        output shaper, eventually creating the latter, if needed.
>> > > > +        Input shapers scope must be either @queue or @detached.
>> > > > +        Output shaper scope must be either @detached or @netdev.
>> > > > +        When using an output @detached scope shaper, if the
>> > > > +        @handle @id is not specified, a new shaper of such scope
>> > > > +        is created and, otherwise the specified output shaper
>> > > > +        must be already existing.
>> > > 
>> > > I'm lost. Could this designt be described in details in the doc I asked
>> > > in the cover letter? :/ Please.
>> > 
>> > I'm unsure if the context information here and in the previous replies helped
>> > somehow.
>> > 
>> > The group operation creates and configure a scheduling group, i.e. this
>> > 
>> > q1 ----- \
>> > q2 - \SP / RR ------
>> > q3 - /    	    \
>> > 	q4 - \ SP -> (netdev)
>> > 	q5 - /	    /
>> >                    /
>> > 	q6 - \ RR
>> > 	q7 - /
>> > 
>> > can be create with:
>> > 
>> > group(inputs:[q6, q7], output:[detached,parent:netdev])
>> > group(inputs:[q4, q5], output:[detached,parent:netdev])
>> > group(inputs:[q1], output:[detached,parent:netdev])
>> > group(inputs:[q2,q3], output:[detached,parent:<the detached shaper create
>> > above>])
>> 
>> So by "inputs" and "output" you are basically building a tree. In
>> devlink rate, we have leaf and node, which is in sync with standard tree
>> terminology.
>> 
>> If what you are building is tree, why don't you use the same
>> terminology? If you are building tree, you just need to have the link to
>> upper noded (output in your terminology). Why you have "inputs"? Isn't
>> that redundant?
>
>The idea behind the inputs/outputs naming is to represent the data flow
>towards the wire.
>I'm fine with the parent/children naming, but IIRC Jakub was not happy with
>it. Is there any intermediate ground that could satisfy both of you?

It's a tree, so perhaps just stick with tree terminology, everyone is
used to that. Makes sense? One way or another, this needs to be
properly described in docs, all terminology. That would make things more
clear, I believe.

>
>Thanks,
>
>Paolo
>

