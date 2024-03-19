Return-Path: <netdev+bounces-80679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09CE880557
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568831F23413
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690939FE4;
	Tue, 19 Mar 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeeL8Nap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47139FD6
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876282; cv=none; b=pv5yy12TpBSChNmiTLD0T2YtWvizCLVN+u4vgmlI6vVEcDJ49y36KofwUTbG/joCyNMnGcjHGwxsbVJn9kEFxcltSKnvi4xnpIm1/Fe7rVsrngjk8FoWPVd3eyZ6hrd5hAFjr4cvYcXQbvuMk5AVAD8go+KQrFsbDcO9OkE925M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876282; c=relaxed/simple;
	bh=SPOcqFOa4IEJC4nSqQwjCzcE1cmOqlod9iEJDt4l1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7GjqSY/Zb+wpEUoJYsJwavaUOz2e9emGs5nUbFYHD/xzlB1FrHDsYOpLd8gMwXTyWvyOeUysDGLlQAXANiI6i9F4jBBWowluBbupPNI6A2f+KIWjg8GFeyaytuWOCo7RempyW4pAHmKOFJG3oFrzqfxgJQyD/KGpRvtROcVEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeeL8Nap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710876280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=054PSwUxcEoyTTyT0YXDp5Ih5pKTqj1jctjnvFZE9RA=;
	b=VeeL8Nap3UdyG6Qo6qhwWOhjKp6QSQa7bCic/5In+FdMlVR5dyDvDS3e3yffCGjmAOLrbn
	9kXVmkdp3uXslUPYnIvbVDmwbqE0iSjhfS7a9mAXM0+u8lLYeAtdwTAbE2rqaz62aqyYFg
	4dgPL8iXPB5BbFMCy0iQgCtXxkxsUSU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-HMM76NjvP_OkfLoG-paKPA-1; Tue, 19 Mar 2024 15:24:38 -0400
X-MC-Unique: HMM76NjvP_OkfLoG-paKPA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ed483c2ecso2027721f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 12:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876277; x=1711481077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=054PSwUxcEoyTTyT0YXDp5Ih5pKTqj1jctjnvFZE9RA=;
        b=SLC+y7O9bcX5Y4560kXsYAjc73AlPRyJvXJ16zBZEHFWvjzWSx2ZfURtPqkGrl40oc
         Fx4NOo/t9ZclK9zX0flGKFhLFCV8U6T4+/OHHLaAuAHPUvxuVLM8Z3dpZYeIqJqMRGZG
         vv9EtJ4bvXccGI40H0F2mM+UvjMrInUjXg4m/8b5MNicjEt5pCO073R7kchaY4ba3X0O
         UCYPiBePr8lpohBumKOfT/ppUyNOpm2qz5kgXDtSB4VXe2dRCG2H7p54+2RnVEp3qMpY
         eO+UF7n0pBxZgDXmri8XOj7m0sMNZbVjAYQ/1KmHEJBFV2ctcSPpQ6XxRucPX8R51ITr
         5UJw==
X-Forwarded-Encrypted: i=1; AJvYcCWJwIfVLuIbIePEck3TiuEdcy/rPvFELx+F0GHjeiNh0WEXuozZuR0qOMf17A0ecmzgg2qB6tMn6x91NHz/OFnNLAHAkgw7
X-Gm-Message-State: AOJu0YyDD3FRltWTrCmlDIWHK8mhHrzS2DA+Qv1wcfjJTEODMVWA8dlk
	ESi5sjHplpsm+8CI1WZgw2ZY+y934jKsu/o3F6qQpxYwVOhYjf0bqYBdY7BzVlvn58GljJmrq4p
	ce+w23HNGmw8oVEv7Q4DHeHZ2R6JLLghFPzZY0mirOFBNXJh8hwvsSQ==
X-Received: by 2002:a05:6000:104e:b0:33e:d1fa:6627 with SMTP id c14-20020a056000104e00b0033ed1fa6627mr7835985wrx.50.1710876277023;
        Tue, 19 Mar 2024 12:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQZid9lWxUAfX9KUhv4EBBJ2gUziSxS4M3VUS2nzuzhpo41M0C+zkRsiu9Q7+Z7XgReUIshA==
X-Received: by 2002:a05:6000:104e:b0:33e:d1fa:6627 with SMTP id c14-20020a056000104e00b0033ed1fa6627mr7835957wrx.50.1710876276421;
        Tue, 19 Mar 2024 12:24:36 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b0033e052be14fsm12994886wrm.98.2024.03.19.12.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:24:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 15:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com, andrew@daynix.com, david@redhat.com,
	dtatulea@nvidia.com, eperezma@redhat.com, feliu@nvidia.com,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	jean-philippe@linaro.org, jonah.palmer@oracle.com,
	leiyang@redhat.com, lingshan.zhu@intel.com,
	maxime.coquelin@redhat.com, ricardo@marliere.net,
	shannon.nelson@amd.com, stable@kernel.org,
	steven.sistare@oracle.com, suzuki.poulose@arm.com,
	xuanzhuo@linux.alibaba.com, yishaih@nvidia.com
Subject: Re: [GIT PULL] virtio: features, fixes
Message-ID: <20240319152109-mutt-send-email-mst@kernel.org>
References: <20240319034143-mutt-send-email-mst@kernel.org>
 <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi363CLXBm=jB=eAtJQ18E-h4Vwrgmd6_7Q=DN+9u8z6w@mail.gmail.com>

On Tue, Mar 19, 2024 at 11:03:44AM -0700, Linus Torvalds wrote:
> On Tue, 19 Mar 2024 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio: features, fixes
> >
> > Per vq sizes in vdpa.
> > Info query for block devices support in vdpa.
> > DMA sync callbacks in vduse.
> >
> > Fixes, cleanups.
> 
> Grr. I thought the merge message was a bit too terse, but I let it slide.
> 
> But only after pushing it out do I notice that not only was the pull
> request message overly terse, you had also rebased this all just
> moments before sending the pull request and didn't even give a hit of
> a reason for that.
> 
> So I missed that, and the merge is out now, but this was NOT OK.
> 
> Yes, rebasing happens. But last-minute rebasing needs to be explained,
> not some kind of nasty surprise after-the-fact.
> 
> And that pull request explanation was really borderline even *without*
> that issue.
> 
>                 Linus

OK thanks Linus and sorry. I did that rebase for testing then I thought
hey history looks much nicer now why don't I switch to that.  Just goes
to show not to do this thing past midnight, I write better merge
messages at sane hours, too.

-- 
MST


