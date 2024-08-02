Return-Path: <netdev+bounces-115306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86AA945C74
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C8B28375C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7081DE86A;
	Fri,  2 Aug 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eI9fQ0y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312A14D2B7
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595797; cv=none; b=pwpFLIvMIyYfjl4CrkJu0R/bxNM9FVh4Hmj0K2+x79VVBO+jn0b8YgsTWR/L9lL5GpfkWM7oTpANrdPBhZilARmBht+LypM8UClkZCrIot6R7ddHxDgWD7190k2f3zL4FIpB7O74McbZfqpExiuBkTEF2uBtTNMvw2CR8um4Aac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595797; c=relaxed/simple;
	bh=BMOSw0O9baXTXqBSXXYmmjtZgqYqxLS3PnpJx9b/H0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlATgTjTm+rmbKrw2VqGqDR++qWxg6eSZnvfs2nCdtCR41BWcufyFdKl4EzuKTZUW7BvtYrnKJpivNxO1hyS5YUEncDReeI18QgbsI1itMDVoLN9zoaPEtX+MgdHtujXkwkJJn18cuL+AXpGmhoKcQZ5m6CkWYMl59jjH4kCDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eI9fQ0y9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso4001116f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722595793; x=1723200593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2/pTjwHdFWxaDItmhEBsOFFXmnEJFPoViM4aY7mBZ8=;
        b=eI9fQ0y9/YPHCUuv+zyZVk3FfD8uFJE91a1cYxnTC+4yIyNmzLYMTDVCC5C2ZwEUHr
         nftAjMAixiTJVywaFOkQZjhgvNil9/QXA0pyXcU6tZaZQ88LgMzveb1Gg6P0gzAFn6Ig
         9Q5OMXvbHgf1hU5bdKz9gHY0rAhAcvHk9sNnDr1wV2K0I41icovWQGlkrekUoY/D0f0/
         LuAuk65sv2Z0XqeEH4XMprJnFd0O/XJEX98k21nYKKKFWtLPfg7eoomQYn3ekUYVLqn/
         C3WPdFX1CkMrqCYZbkpONxu6mqUZm/6IW4gHIEYJ9g9nNsFa0cvxe4wLtjBWO2TEqPLf
         VZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722595793; x=1723200593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2/pTjwHdFWxaDItmhEBsOFFXmnEJFPoViM4aY7mBZ8=;
        b=C9uW56TmecFu/SYLIvMGbi79bkyq/wE+Z3cXTL/BqbCaZsbZxlPU7axSPUpUv3nVfv
         GmA2HqPPosprmjSg359lGvN1J8/JuGcXTlA3Qfh5yAENdgYYqnoPCJQ8fqxnOAk6XDqd
         XJB0fEpedIpQlNVViHRmSfdbnjYJLUk6Nb9ZPZJmtVSg5w2oBzOXra/w5Xg5PX8cuyys
         KNv6oPqP72Zr6bp6+Mwryj+mS6UZsuKERMyfwlKM/i7dlxD8y+h4EiL6GbifnNFTlzv5
         jVbqsvUN53aQv5v+I59h0zmIyBlNnxJJvD1mJTjQZW2g6ZtuHV3wtYQWRK6+YXkwR/bO
         5QFA==
X-Gm-Message-State: AOJu0YyUDA9dvI8bt9DPDNpgLXKKpTC9e90gs5oFNtllI1WIPFNOsdch
	gbpcNPVD3dZZlfDtomap5FQD82N97FkgciefwaexeNTfm+rbzkp8ye6ngxyuqQo=
X-Google-Smtp-Source: AGHT+IGoWNSu7JSzo/yVYVdi8UQ2q1j8HW+36/E/Zi6fvVF5oRGKJ/CFA0B84WZFIuuw+PyU3PGSqA==
X-Received: by 2002:a05:6000:1faf:b0:368:d0d:a5d6 with SMTP id ffacd0b85a97d-36bbc1beb75mr2026661f8f.50.1722595792334;
        Fri, 02 Aug 2024 03:49:52 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0dc8fsm1668340f8f.6.2024.08.02.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:49:51 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:49:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <Zqy5zhZ-Q9mPv2sZ@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
 <ZquJWp8GxSCmuipW@nanopsycho.orion>
 <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8819eae1-8491-40f6-a819-8b27793f9eff@redhat.com>

Thu, Aug 01, 2024 at 05:12:01PM CEST, pabeni@redhat.com wrote:
>On 8/1/24 15:10, Jiri Pirko wrote:
>> Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>> > +    type: enum
>> > +    name: scope
>> > +    doc: the different scopes where a shaper can be attached
>> > +    render-max: true
>> > +    entries:
>> > +      - name: unspec
>> > +        doc: The scope is not specified
>> > +      -
>> > +        name: port
>> > +        doc: The root for the whole H/W
>> 
>> What is this "port"?
>
>~ a wire plug.

What's "wire plug"? What of existing kernel objects this relates to? Is
it a devlink port?


>
>> > +      -
>> > +        name: netdev
>> > +        doc: The main shaper for the given network device.
>> > +      -
>> > +        name: queue
>> > +        doc: The shaper is attached to the given device queue.
>> > +      -
>> > +        name: detached
>> > +        doc: |
>> > +             The shaper is not attached to any user-visible network
>> > +             device component and allows nesting and grouping of
>> > +             queues or others detached shapers.
>> 
>> What is the purpose of the "detached" thing?
>
>I fear I can't escape reusing most of the wording above. 'detached' nodes
>goal is to create groups of other shapers. i.e. queue groups,
>allowing multiple levels nesting, i.e. to implement this kind of hierarchy:
>
>q1 ----- \
>q2 - \SP / RR ------
>q3 - /    	    \
>	q4 - \ SP -> (netdev)
>	q5 - /	    /
>                   /
>	q6 - \ RR
>	q7 - /
>
>where q1..q7 are queue-level shapers and all the SP/RR are 'detached' one.
>The conf. does not necessary make any functional sense, just to describe the
>things.

Can you "attach" the "detached" ones? They are "detached" from what?


>
>> > +    -
>> > +      name: group
>> > +      doc: |
>> > +        Group the specified input shapers under the specified
>> > +        output shaper, eventually creating the latter, if needed.
>> > +        Input shapers scope must be either @queue or @detached.
>> > +        Output shaper scope must be either @detached or @netdev.
>> > +        When using an output @detached scope shaper, if the
>> > +        @handle @id is not specified, a new shaper of such scope
>> > +        is created and, otherwise the specified output shaper
>> > +        must be already existing.
>> 
>> I'm lost. Could this designt be described in details in the doc I asked
>> in the cover letter? :/ Please.
>
>I'm unsure if the context information here and in the previous replies helped
>somehow.
>
>The group operation creates and configure a scheduling group, i.e. this
>
>q1 ----- \
>q2 - \SP / RR ------
>q3 - /    	    \
>	q4 - \ SP -> (netdev)
>	q5 - /	    /
>                   /
>	q6 - \ RR
>	q7 - /
>
>can be create with:
>
>group(inputs:[q6, q7], output:[detached,parent:netdev])
>group(inputs:[q4, q5], output:[detached,parent:netdev])
>group(inputs:[q1], output:[detached,parent:netdev])
>group(inputs:[q2,q3], output:[detached,parent:<the detached shaper create
>above>])

So by "inputs" and "output" you are basically building a tree. In
devlink rate, we have leaf and node, which is in sync with standard tree
terminology.

If what you are building is tree, why don't you use the same
terminology? If you are building tree, you just need to have the link to
upper noded (output in your terminology). Why you have "inputs"? Isn't
that redundant?

If this is not tree, what's that? Can for example q6 be input of 2
different groups? How is that supposed to work?


>
>I'm unsure if this the kind of info you are looking for?

I'm trying to understand the design. Have to say I'm just confused :/


>
>Thanks,
>
>Paolo
>

