Return-Path: <netdev+bounces-130916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BC98C08F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626F1281239
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DF1C8FAA;
	Tue,  1 Oct 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="x1elmxa7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A81C6F73
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793882; cv=none; b=gU4liPboLBHOBeMJmYgYUxTXT8PHK/Zln1ArQlLL4ScD4tu41+UvWOFmv791LbzzP0mtK4fwdCg9a1LCC3Ue1cplUs7DTh/W84vk7o7ZrI3O4OcZUqanivjOmiawrfx/DtUOlidSlSuw3TnsQaoMSnJnEQyV35NWiDW7xW/qel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793882; c=relaxed/simple;
	bh=gDWT4STT6JUFpSYPJCBcdHVnW/ovGRmL/WGKx4dlZZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU794s5qP1WWm6OMDjHPZ70w6mG9rfJEYI7ImoMoEos3tSvLKyKjZ7hnQelfM2IVTiPfsfRQy3HP3DP3jQZEXKgI1PEjmGfY5d3DTLbI0Obyj5yo6b7cpHPF5X2dPTlNx+yUdEnnOgkgLqBCndSBHB/Ouu9Xm8G3frO4wtOdHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=x1elmxa7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bc2970df5so1651155ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727793879; x=1728398679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xBuxdwkvAWBb4tsrg44inPQWvKApsZPZtxVVoPfSQs=;
        b=x1elmxa7odQaD6/TefIQRXlkhwouT6l//MtzpZ+uhfeITCE7ayC/ulV29r7LeCm7MA
         G685BAnpGTiq4H2aU+FkpxoVji52xzyKY/1lxF+a+mENVbYSdzxSg5f2XtpQ0hmyP8Y/
         KGb+k9UG3Erd8nyIIFkDGkoB9lY+ABW7K20GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727793879; x=1728398679;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xBuxdwkvAWBb4tsrg44inPQWvKApsZPZtxVVoPfSQs=;
        b=F4DRTLd+ibJuEKdWb4XmbkafzsppRQHj33QZ8epDZMZJ9Y5sGN6kzzbOJ5sJftRC4C
         7kIRERkBdzilBFh5h5o4vRoYp1I1+YcFKzzl9tQkSR6PXdSGcJzb6NRwwaBKPge2pSsr
         oOw2i7vQsBGif6WOOVFG3m3Bbt2NNw/HNtuowGhQ13J8dPlA0FjqIP+fZ9yTuzzxMsQV
         Bjnl73GClKGrLEULbBJ7RQ7/P5A3JDEMCcxbpR4+0cGF0k2OPF670A2+jITXziMdZjjM
         HTmWBOckoiib+CmBmDfYP5B4K6RhTI9IfyzdabBtJZpUZVG/vp4N/PMe5eliOsSs0xo0
         cOCA==
X-Forwarded-Encrypted: i=1; AJvYcCXUr3d/gQjrDrHe2uUoBjTNBKk17IEdnLeWe/IJWDvqjyYLfavLE1oVLoxo40hEiPWvajcWJiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kCkxopPK2s5pFyKUAWm24FjsJ7qiTXWNQPF8qbXzoGEQcFGZ
	YomJtXIV5/M0mlui/dbAXZVsa/kL/HlUvSJ5CHIVqpIzpvZVBnzrslQRcnYI+jE=
X-Google-Smtp-Source: AGHT+IFrL++WrEKmj9fGaGHTFlHosE8dClJc0XF1vbqkiHKt2WaJxn/SZxsD4FVlPmKCFMnGxnIe3Q==
X-Received: by 2002:a17:902:e5cd:b0:20b:9680:d5c4 with SMTP id d9443c01a7336-20b9680d828mr78255135ad.4.1727793879333;
        Tue, 01 Oct 2024 07:44:39 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d68a93sm70530125ad.56.2024.10.01.07.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:44:38 -0700 (PDT)
Date: Tue, 1 Oct 2024 07:44:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Message-ID: <ZvwK1PnvREjf_wvK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>
References: <20240925180017.82891-1-jdamato@fastly.com>
 <20240925180017.82891-2-jdamato@fastly.com>
 <6a440baa-fd9b-4d00-a15e-1cdbfce52168@intel.com>
 <c32620a8-2497-432a-8958-b9b59b769498@intel.com>
 <9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>
 <Zvsjitl-SANM81Mk@LQ3V64L9R2>
 <a2d7ef07-a3a8-4427-857f-3477eb48af11@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d7ef07-a3a8-4427-857f-3477eb48af11@intel.com>

On Tue, Oct 01, 2024 at 03:14:07PM +0200, Alexander Lobakin wrote:
> From: Joe Damato <jdamato@fastly.com>
> Date: Mon, 30 Sep 2024 15:17:46 -0700
> 
> > On Mon, Sep 30, 2024 at 03:10:41PM +0200, Przemek Kitszel wrote:
> >> On 9/30/24 14:38, Alexander Lobakin wrote:
> >>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>> Date: Mon, 30 Sep 2024 14:33:45 +0200
> >>>
> >>>> From: Joe Damato <jdamato@fastly.com>
> >>>> Date: Wed, 25 Sep 2024 18:00:17 +0000
> >>
> >>> struct napi_struct doesn't have any such fields and doesn't depend on
> >>> the kernel configuration, that's why it's hardcoded.
> >>> Please don't change that, just adjust the hardcoded values when needed.
> >>
> >> This is the crucial point, and I agree with Olek.
> >>
> >> If you will find it more readable/future proof, feel free to add
> >> comments like /* napi_struct */ near their "400" part in the hardcode.
> >>
> >> Side note: you could just run this as a part of your netdev series,
> >> given you will properly CC.
> > 
> > I've already sent the official patch because I didn't hear back on
> > this RFC.
> > 
> > Sorry, but I respectfully disagree with you both on this; I don't
> > think it makes sense to have code that will break if fields are
> > added to napi_struct thereby requiring anyone who works on the core
> > to update this code over and over again.
> > 
> > I understand that the sizeofs are "meaningless" because of your
> > desire to optimize cachelines, but IMHO and, again, respectfully, it
> > seems strange that any adjustments to core should require a change
> > to this code.
> 
> But if you change any core API, let's say rename a field used in several
> drivers, you anyway need to adjust the affected drivers.

Sorry, but that's a totally different argument.

There are obvious cases where touching certain parts of core would
require changes to drivers, yes. I agree on that if I change an API
or a struct field name, or remove an enum, then this affects drivers
which must be updated.

idpf does not fall in this category as it relies on the *size* of
the structure, not the field names. Adding a new field wouldn't
break any of your existing code accessing fields in the struct since
I haven't removed a field.

Adding a new field may adjust the size. According to your previous
email: idpf cares about the size because it wants the cachelines to
look a certain way in pahole. OK, but why is that the concern of
someone working on core code?

It doesn't make sense to me that if I add a new field, I now need to
look at pahole output for idpf to make sure you will approve of the
cacheline placement.

> It's a common practice that some core changes require touching drivers.
> Moreover, sizeof(struct napi_struct) doesn't get changed often, so I
> don't see any issue in adjusting one line in idpf by just increasing one
> value there by sizeof(your_new_field).

The problem is: what if everyone starts doing this? Trying to rely
on the specific size of some core data structure in their driver
code for cacheline placement?

Do I then need to shift through each driver with pahole and adjust
the cacheline placement of each affected structure because I added a
field to napi_struct ?

The burden of optimizing cache line placement should fall on the
driver maintainers, not the person adding the field to napi_struct.

It would be different if I deleted a field or renamed a field. In
those cases: sure that's my issue to deal with changing the affected
drivers. Just like it would be if I removed an enum value.

> If you do that, then:
> + you get notified that you may affect the performance of different
>   drivers (napi_struct is usually embedded into perf-critical
>   structures in drivers);

But I don't want to think about idpf; it's not my responsibility at
all to ensure that the cacheline placement in idpf is optimal.

> + I get notified (Cced) that someone's change will affect idpf, so I'll
>   be aware of it and review the change;
> - you need to adjust one line in idpf.

Adjust one line in idpf and then go through another revision if the
maintainers don't like what the cachelines look like in pahole?

And I need to do this for something totally unrelated that idpf
won't even support (because I'm not adding support for it in the
RFC) ?

> Is it just me or these '+'s easily outweight that sole '-'?

I disagree even more than I disagreed yesterday.

