Return-Path: <netdev+bounces-113283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92CC93D7C9
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48739B21B1E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E062C684;
	Fri, 26 Jul 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eFy2p39G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235829CE8
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016033; cv=none; b=U67VkH5pfb9+4quLKIiKIn/QOsg2hFRcWVHBSbV+Gd6MO6aBgfN01fM+WREw+HF9NvqCM64wQ0OJyPcRciOAzplektEFFuqs8j2L7IM9AgHL5baT2kPUvXs2ICZFE0vlVCezbGhgOldxtjyjExGUOmpSFk0ueK8bcgv136kHATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016033; c=relaxed/simple;
	bh=QKksVS5MfpC9ecY+ef0lLjSaqYVdaNva9ECWxGj1ofA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn/YAAOrMqjdkYr2cb228oIVw63K1RM16azLIoA8P2FSNCbehp4XhWzTo7kDx9dcJypM/Y7MnQY1FEp3A6bG3wrPJdvELxPALEpCrGwFE/A3BrJbvqptxIMVLzJfLg8OK3L4RZEkkSGAdG0c42KjrzsnTc+8LBZv0NGtNBnX2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eFy2p39G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc52394c92so9039865ad.1
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722016031; x=1722620831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dBQDwfKWDfV8MYcreT/iCwp7WRLXRCnPqAyntD5A8w=;
        b=eFy2p39GIAmmc93LMdWS+xDMPNxSsiJx6WDv24/dSJClRw1EkIl5dl0HfaQlghnGWh
         Ex46Yx+Fy4jfaSJNUyKjAtNSKQsoGElhTufoqVaJ2EDd4v1XzhuMjDogso4iZkLNy3iL
         HWVli7n1AkioIx5lMu160o75asriwOdJLfWr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016031; x=1722620831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dBQDwfKWDfV8MYcreT/iCwp7WRLXRCnPqAyntD5A8w=;
        b=fofyEhjcbWt0ETCRvQDgRsBkmJg8RJ75sFiHqe5OIhme5yBnXRpMWqa6cufb2CCnW9
         iPJn6j+9fmDAUVWawW16uUEOvkfSCnwjlH3jCFDBPkRL/C6zh5fV2r9VwCujgTJWQ79f
         KKBdOU1TZqCf4lB5WvanUyh6RoZ/Yo0hKK90lCsFVo9cXCSczm87okCISMdyG5mjtN0N
         y4Q34XTceQIyUGR6KHfm300Y2wGez70dZT+VTXdZpzXBPlTAfUCvQhxWMDl3Gz3265jh
         nESzqopqngNmtAahu61HKhBHDfk5Ig34XF2iuCkf2TiR/U6ClTTR4ooERymS5AJBrMOa
         l0dg==
X-Gm-Message-State: AOJu0YxJLvoY7Wq+bddk5YRajosjI7scOv+P1+gBZTsdzu70j4aYk/RP
	UfIj5Z7Fsl7LlJXShCb4WU56IdSwZZuMPEI7xJlDrPnLhFZ449vTQ5Wd3lC8SA0=
X-Google-Smtp-Source: AGHT+IHIKqP61K6amS6eDVuU7jgDmPKXW1Clumle+YDHsIqqmE+j/nuBqMJmh83L6W4tasAe/Tey3A==
X-Received: by 2002:a17:902:fd08:b0:1fd:6d6d:68e7 with SMTP id d9443c01a7336-1ff048b07b9mr4167235ad.43.1722016031267;
        Fri, 26 Jul 2024 10:47:11 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fbd6sm35699985ad.62.2024.07.26.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:47:10 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:47:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
Message-ID: <ZqPhHMaeTcgwEJnY@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	kernel-team@meta.com
References: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
 <ZqKIvuKvbsucyd2m@LQ3V64L9R2>
 <CAKgT0UdyHu3jT1qutVjuGRx97OSf+YGMuniuc2v6zeOvBJDsYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdyHu3jT1qutVjuGRx97OSf+YGMuniuc2v6zeOvBJDsYA@mail.gmail.com>

On Thu, Jul 25, 2024 at 04:03:30PM -0700, Alexander Duyck wrote:
> On Thu, Jul 25, 2024 at 10:17 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Jul 25, 2024 at 10:03:54AM -0700, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexanderduyck@fb.com>
> > >
> > > In testing the recent kernel I found that the fbnic driver couldn't be
> > > enabled on x86_64 builds. A bit of digging showed that the fbnic driver was
> > > the only one to check for S390 to be n, all others had checked for !S390.
> > > Since it is a boolean and not a tristate I am not sure it will be N. So
> > > just update it to use the !S390 flag.
> > >
> > > A quick check via "make menuconfig" verified that after making this change
> > > there was an option to select the fbnic driver.
> > >
> > > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> >
> > [...]
> >
> > This seems fine to me (and matches other drivers as you mentioned),
> > but does it need:
> >
> > Fixes 0e03c643dc93 ("eth: fbnic: fix s390 build.")
> >
> > for it be applied to net?
> >
> > In either case:
> >
> > Reviewed-by: Joe Damato <jdamato@fastly.com>
> 
> I will add it and resubmit if/when the patch is dropped from the
> patchwork queue.

Sure; makes sense. I honestly have no idea -- I think maybe Kconfig
and docs are special cases or something? Just suggested the Fixes to
be helpful :)

- Joe

