Return-Path: <netdev+bounces-191000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03816AB9A50
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E758B3ACE95
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22B233D9C;
	Fri, 16 May 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8syxgkg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040622FF35
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391979; cv=none; b=Np1oSq3JVBJwuGto8Te9LgwaK+pmxO8vYK538uSCewpOdrHO4Xj3ulP5aCpzkJMFMnFAPmxDA7QUugYZXYzZeeyps+DA5hQ7mKDc4GgEw0Ipdz1fARmLttPMSrFlp37kuNwcYwhAW6VQubPJoSFs9BoGJ1/O8D1Mzh6Tx+svTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391979; c=relaxed/simple;
	bh=NCB+3lMyOx+fn/S3zX/Y6sTtiI24gcvf+J1THi9Qmbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbqBI3hWBTFu4aY3b+xJrWAl30vq79sZbzf++NjrQgbGB1jNcN199YpcpF08ArtL0F6IC1jDWIeedXDTQJVJjRru/WVPAHRAEQi3yDMrxQCrJajyybxAKr7kl+568wa6b6mzG1hAxFfX324YrbiEw6XIhXTITxtjaP4qfI0AsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8syxgkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747391976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQQMDEIIwXkuHEhIKpxJjnKfw2Oug4GMJkHufoFzpm8=;
	b=T8syxgkgBrSCv5Et+vQSRk2PFd4IYS4+mZ5R313qIfiUyFSZO26wjLWSr4fYU1GRFF3wxD
	ADLbWyrFNzgC61TLRhRrl4W6QN6JZcxHM0sY8UDyZL/4gBNMq5Cb1us5sNp/M+CXJCRZAh
	yrD5L0afrUuuAurae/KN87UnwVhcfzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-YuSzqABNPjWK_VJrgYSimA-1; Fri, 16 May 2025 06:39:34 -0400
X-MC-Unique: YuSzqABNPjWK_VJrgYSimA-1
X-Mimecast-MFC-AGG-ID: YuSzqABNPjWK_VJrgYSimA_1747391974
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so13873015e9.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 03:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747391973; x=1747996773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQQMDEIIwXkuHEhIKpxJjnKfw2Oug4GMJkHufoFzpm8=;
        b=grCP+bHNwYOqZeSdtp1QCs821CgSH9JT3Z7Tou67KBvb6aSniTDO2G4DcX3Odcntcc
         xAQN2/Gj4AiNxA54GL9Ktv4QE054rM6zMB6K0XoxzSo2BpZU+YmXj4g948EBSh08TFyM
         g+B3BN7vndAZguwv8H9rSr0VwVcIII9kpWRD0tvZ2et3dgl03iom3dlUURlXZ4awCHXN
         86f+sm+xf6znISaxQ+ajWiA26LGmiHhu9Yfzjf+DZ8tSnbYdGI5QY0qgdfN2ZAF1xjhL
         4wzKQNO/cAEfSUjaWr9lZtRLMIsrVnrkfoSluT84kcdWPKULX3K3urQVcPP9WOIWi/Df
         m3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5CiEbHRyCA5zlBjcxXHRkRLWNKN0U9f6LqLSFYly5KwSS1kh+a6k8ZwFjdKFNOnH5+kWLIdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5Mk1MWJFlcyntOFboVJA0Lwpa3TcUPxMYJ2qwiGP9wLzvN1o
	j7MFm99cf7MZ6PM7js0opUDLkZTNu27vsgvgKRDb7BLNuAP15zzZhZLCOWOdHWGS5UKzzaU5mH4
	H6QSzoR2KEBHVplbT3eEaeWZb5e2KsIfLXmEOuaGbuXcMt2nJt5scbw6ZSA==
X-Gm-Gg: ASbGnctYbQNa1kpZYiV3RFJ8mCpWE3FFDcUIhZoFnGYIGckNd0ufOBROjs6oJTRAiTq
	k+Ook0nCq8eITk4jEYJazOEcOWdMnaj9Z9MCJGN2RDzDTnYv3UlbIrJv5NJscknroR8oBIjYx7B
	uGFoQ43n8+5LqQES13TPY7UDXg7e74dQrFioEXIBh/zaEQaDwynIlsL1Y60lS918X+JoJbivv7Q
	B+Knv3OGIEjwpJW+ZUoCQrYdVqnn4J2JQW4ZbmsOBz0ZUl2eQxNPxPBM2edg2SFDe5C4laaG0bT
	fntHng==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr14689535e9.20.1747391973548;
        Fri, 16 May 2025 03:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDKW6n87RVrzA4EIoIWUAPNw+ypMh5iiPl+xjV6leqnmea0yfCg/OCjfh+iHgxZSJtpf0sYw==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr14689315e9.20.1747391973129;
        Fri, 16 May 2025 03:39:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f338070csm100008995e9.15.2025.05.16.03.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 03:39:32 -0700 (PDT)
Date: Fri, 16 May 2025 06:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250516063659-mutt-send-email-mst@kernel.org>
References: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org>
 <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org>
 <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
 <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
 <20250515021319-mutt-send-email-mst@kernel.org>
 <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvQaUtpsaWYkU6SC=i1tXVbupNrAVPBsXm3eMfAJHzC=Q@mail.gmail.com>

On Fri, May 16, 2025 at 09:31:42AM +0800, Jason Wang wrote:
> On Thu, May 15, 2025 at 2:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 14, 2025 at 10:52:58AM +0800, Jason Wang wrote:
> > > On Tue, May 13, 2025 at 3:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > > > On Wed, Apr 30, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > > > On Tue, Apr 29, 2025 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > > > On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > > > > > > > > is disabled, and any attempt to use it will result in failure.
> > > > > > > > > > >
> > > > > > > > > > > I think we need to describe why the default value was chosen to be false.
> > > > > > > > > > >
> > > > > > > > > > > What's more, should we document the implications here?
> > > > > > > > > > >
> > > > > > > > > > > inherit_owner was set to false: this means "legacy" userspace may
> > > > > > > > > >
> > > > > > > > > > I meant "true" actually.
> > > > > > > > >
> > > > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > > > > applications need to be modified in order to get the behaviour
> > > > > > > > > recovered which is an impossible taks.
> > > > > > > > >
> > > > > > > > > Any idea on this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > >
> > > > > > So, let's say we had a modparam? Enough for this customer?
> > > > > > WDYT?
> > > > >
> > > > > Just to make sure I understand the proposal.
> > > > >
> > > > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > > > think it would be fine if we make it false by default.
> > > > >
> > > > > Thanks
> > > >
> > > > I think we should keep it true by default, changing the default
> > > > risks regressing what we already fixes.
> > >
> > > I think it's not a regression since it comes since the day vhost is
> > > introduced. To my understanding the real regression is the user space
> > > noticeable behaviour changes introduced by vhost thread.
> > >
> > > > The specific customer can
> > > > flip the modparam and be happy.
> > >
> > > If you stick to the false as default, I'm fine.
> > >
> > > Thanks
> >
> > That would be yet another behaviour change.
> 
> Back to the original behaviour.

yes but the original was also a bugfix.

> > I think one was enough, don't you think?
> 
> I think such kind of change is unavoidable if we want to fix the
> usersapce behaviour change.
> 
> Thanks

I feel it is too late to "fix". the new behaviour is generally ok, and I
feel the right thing so to give management control knobs do pick the
desired behaviour.
And really modparam is wrong here because different userspace
can have different requirements, and in ~10 years I want to see us
disable the legacy behaviour altogether.
But given your time constraints, a modparam knob as a quick workaround
for the specific customer is kind of not very terrible.

> >
> >
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


