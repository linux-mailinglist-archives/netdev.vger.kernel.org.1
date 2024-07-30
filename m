Return-Path: <netdev+bounces-113996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF221940932
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CAEB23B34
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7AF190061;
	Tue, 30 Jul 2024 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HmW0Tmzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD6190046
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323586; cv=none; b=j5GFjvjcNF7TdsB11zTK+k3PT9SsAwy4mYL3wOs3NhXNiess172liStNaBcWSQ9EelyHToueyzNK3ByCAV+vSFoKh8tAqj/8qU7rDMN2PkIT23CWpTwh3KLYelUUopNz0YHU2uBYHzpn9P5Ergg04yatf9wB+uhvtY361ZGFzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323586; c=relaxed/simple;
	bh=OKjfLeQQWKG0BSFRsS4/CO9mkoQXn7p3V6TvzeChxSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8xYlVjJ6WujdWtq9hH4GZT8JiVPqomkf5BDdtbck/4W02SyhbAJEtmV48fIb7xAmTPlvUoInT39wA1xqXZXSQ2ac/5R9XrhIcNqacE4GXcnvk6smulL26MR11KoBrDGfOz311Yfu+CtPWxl3vScabatYe4b7VOmhZzZfq79Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HmW0Tmzs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368633ca4ffso437731f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722323583; x=1722928383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KPTLWLekzUxyh9fC8CWnCkt1/pYTgCXaJag08Di2pc=;
        b=HmW0TmzsZlMPjyRsgef+4IHZaYX8oRj/ZsaqndA+VJyiN3+rsujEjtzzbeRzP0pujP
         S11mgfWjZZFvEd9bRCwhoWx6aMH8z/HI2i9g0IO2p8h8TaTaBoK3b/TyEmfta8+GIyde
         6Ufao1jLDFVbfBeuhE+ctEDTUx9e0g4speHfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323583; x=1722928383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KPTLWLekzUxyh9fC8CWnCkt1/pYTgCXaJag08Di2pc=;
        b=h1XS/4tpCQDKWSjUGQ2b9ctjXHl3AnkP6nyPoi/aO/eBalKoapLtTMoe0gBOQL/pcV
         rYlUniYL/vdIGkTmFaNJvghvbmS/GnGkoruNI11teBs9uM/LndlbqcE6vDPtGfxjydF7
         9vm/r1ptsgh3PjLO2rfZbnw6BJ70mhu6HMsWNw0iZEwfwozOlm7KOSsQBXwrobt131fM
         h/k6Grx1RjzWsAjnUy54j4tqtFZzRu1ven9+1juk3FYQTB9KLojR260tpqm3Jg8/7v07
         u9oaneY9QIUcAWrrAoi+rofO/LAaD+stXmv1+DzjdZfV8qnP+doqCev5qksqOpCSnfaq
         l6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUsCjD6V4ymWeKwDdyRob+i3Is0v7wF/de7X3+cpKMS88fWEZj+VJzZsAnMCgkF4iQgfJKrnHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79irT2klYn4BE6PLL9On+9aVqaGGEXXtFKuNp00KI22Au7oqg
	ZvhV+b3bMB1foPpw0HnkSxMhP6Vguci8PVx+aHbcbxC6rr4E3CWE5MJhxbQnpkA=
X-Google-Smtp-Source: AGHT+IFxKfMFbNl9HRLCWhOwSr18KHdJhSlm0eAzrgkXYf8GFau+PacOCxcxAX7cEIFXYegZVA+dog==
X-Received: by 2002:a05:6000:2a4:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-36b34e5ac7dmr6981818f8f.8.1722323582849;
        Tue, 30 Jul 2024 00:13:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e51f0sm13906465f8f.46.2024.07.30.00.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:13:02 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:13:00 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <ZqiSfC5--4q2UFGk@phenom.ffwll.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729154203.GF3371438@nvidia.com>
 <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 29, 2024 at 03:37:10PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..]
> > > We could say it can only be used for features we have 'opted' in +
> > > vendor defined features, but I'm not sure that helps.  If a vendor
> > > defines a feature for generation A, and does what we want them to by
> > > proposing a spec addition they use in generation B, we would want a
> > > path to single upstream interface for both generations.  So I don't
> > > think restricting this to particular classes of command helps us.
> > 
> > My expectation for fwctl was that it would own things that are
> > reasonably sharable by the kernel and userspace.
> > 
> > As an example, instead of a turning on a feature dynamically at run
> > time, you'd want to instead tell the FW that on next reboot that
> > feature will be forced on.
> > 
> > Another take would be things that are clearly contained to fwctl
> > multi-instance features where fwctl gets its own private thing that
> > cannot disturb the kernel.
> > 
> > I'm really not familiar with cxl to give any comment here - but
> > dynamically control the single global scrubber unit seems like a poor
> > fit to me.
> 
> Right, one of the mistakes from NVDIMM that was corrected for CXL was to
> explicitly remove the passthrough capability for global state machine
> controls like scrubbing.
> 
> Many of the "Immediate Configuration Change" CXL commands fall into this
> bucket of things that may want to have a kernel-managed global view
> rather than let userspace and the kernel get into fights about the
> configuration. So, I think it is reasonable to say that scrub has a
> kernel interface that goes through EDAC and not fwctl.
> 
> For the "anonymous" "Features" that advertise an "Immediate
> Configuration Change" effect those need CAP_SYS_RAWIO at a minimum,
> possibly a kernel taint, and/or compile time option to block them. Maybe
> that encourages more "Configuration Change after Reset" Set Feature
> capabilities which carry less risk of confusing a running kernel.

I think a solid consensus on the topics above would be really useful for
gpu/accel too. We're still busy with more pressing community/ecosystem
building needs, but gpu fw has become rather complex and it's not
stopping. And there's random other devices attached too nowadays, so fwctl
makes a ton of sense.

But for me the more important stuff would be some clear guidelines like
what should be in other more across-devices subsystems like edac (or other
ras features), what should be in functional subsystems like netdev, rdma,
gpu/accel, ... whatever else, and what should be exposed through some
special purpose subsystems like hwmon.

And then also what the access control guidelines should be around tainting
and and premission checks.

We've got plenty of experience in enforcing such a community contract with
vendors, but the hard part is creating a clear and ideally concise
documentation page I can just point vendors at as the ground truth.

I'm also not super worried about the uapi breakage scenarios. We have
plenty of experience in drm with sometimes horrendous hacks to keep
existing userspace and real-world use-cases going, while still being able
to move the subsystem forward and standardize more stuff as it starts to
make sense. But the "here's the goal" documentation, maybe with the
occasional update when a new subsystem like edac shows up, is imo the hard
part and would be really, really useful.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

