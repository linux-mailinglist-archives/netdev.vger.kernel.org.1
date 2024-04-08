Return-Path: <netdev+bounces-85741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580489BF73
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE5B23152
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7A7442A;
	Mon,  8 Apr 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W15dvdJ9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104796FE1A
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580654; cv=none; b=JWSIOUtFYp+d+GgfY2cqEHuO+gHFYHy4f3zGGMazFr2ptCiA7GTeKWrfVbeReIS94S/F7/7XCyCKBKLBdmlckaFTZYn6uKCGnWb0INcvD4OuRYp/+izzS89Pyww3gWAAF4ojPyJMPFR9chnzOt0bF/aO2QDrAMXN08WwJZ+NNPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580654; c=relaxed/simple;
	bh=t6rY2U7J7pGdzJQQnj7Amc0EfelzVuwnd+M+I4FgGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmU0cLfjm1IjFjvez52HuDTAcGqpHmfFyac62QacfW7LMxwPjMi0B0VJEh0kRQ6MUcAb1s7ulR+oKVVVv2KKu93MfGsgAj+4GDTZhoHn/qFgYh1XnxySgXg5gVXsR6OMe/xjFsefO5gmMrUchlUuc9M+BVT1smNw4B6NXNvcdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W15dvdJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712580652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
	b=W15dvdJ9TA3730gS/AMNRxIc8wq3wYXgX4Su1hXKIoXc40lMJaUTf70kvhajY2JwAuEPVf
	by92uLFro3casX3yXBcippOl10AnmSttki/+Ib9XiSSFdwFKg/l/NDh3WQ0budI+9bkk5f
	XBcO8Ah/unt7aEw9Da9LZZriLQ/khuo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-mF7njwxwPFO5ikwbiZKWiA-1; Mon, 08 Apr 2024 08:50:49 -0400
X-MC-Unique: mF7njwxwPFO5ikwbiZKWiA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d871310b3aso23076001fa.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 05:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580647; x=1713185447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgyAj+d0mXsaKlJNf1FRqd+kTl9TVEHoCjOdqUp78UU=;
        b=hk39PLLDIvf/BvMQ2WsTMMr2aD65GmY6dG2HOGa87QOojTMsA51Z7MHsXoeIhqTEtd
         aSH0hs47y048cSVqVeEl216ShHB8d1MSQLoHJRFO43dzR+koOeKvIsYPZlA8MvlD0b8e
         +iXc1kzDNNPnw0bLI1PjlMt2+qGnRhWxEqikJDYMtWfPAphYuAhCc/NjeAaIBp6FAkV9
         4h9Ejb3YvhNeb/yp0gRJmH+Vx8/p3ZtZoBz4P6w01UU2LelZuc9qTleIJsk8Ct8R2KSV
         nwxCSOV4LOOBVCXiPPw1VicU9h9WpnYPXCc4D+n4O5kRgCmRTfZBZWYifalL/E6n1BG1
         AcCg==
X-Forwarded-Encrypted: i=1; AJvYcCXY6AnX6arnIf4v9PUyNp066HSwFFAwc+t8odVDcbIVSFGDDiaKa9RLnu8eUQlCEP66JqGqo/DZrGZUCbm/lX4ZLuTlNeY+
X-Gm-Message-State: AOJu0YwswEgynnp+oCI7SoKRZ7srBxHfKKkXoBVCM3OU/lNa+z4Jfw0A
	MBAC1UuTlvHyeZ5ny1nFGMYxFST+P/UPeDNDu4k+Ke3Ke09cIDYt/bZIgHZeI9Qe6mT4iMJqR4Y
	ol2SWpknQHu01McB2vcx+7dApjJaOjeuUm7giuR/OpMcx00JBjJYkHQ==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644112ljl.8.1712580647635;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlvCW0RSMUg3H9tBOc1SwabjdiTPzS2Fm8vr4WbbbbyDGcjVCN/zOPqhNUznAU5UGSgB/nQg==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr6644089ljl.8.1712580647022;
        Mon, 08 Apr 2024 05:50:47 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b00a4e8e080869sm4432937ejb.176.2024.04.08.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:50:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 08:50:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Add reconnect process for VDUSE
Message-ID: <20240408085008-mutt-send-email-mst@kernel.org>
References: <20240404055635.316259-1-lulu@redhat.com>
 <20240408033804-mutt-send-email-mst@kernel.org>
 <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguUL=Kteorvyn=wRUWFJFvhvgRyp+V7GNBp2R33hK1vnSw@mail.gmail.com>

On Mon, Apr 08, 2024 at 08:39:21PM +0800, Cindy Lu wrote:
> On Mon, Apr 8, 2024 at 3:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 01:56:31PM +0800, Cindy Lu wrote:
> > > Add a document explaining the reconnect process, including what the
> > > Userspace App needs to do and how it works with the kernel.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> > > index bdb880e01132..7faa83462e78 100644
> > > --- a/Documentation/userspace-api/vduse.rst
> > > +++ b/Documentation/userspace-api/vduse.rst
> > > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> > >     after the used ring is filled.
> > >
> > >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > > +
> > > +HOW VDUSE devices reconnection works
> > > +------------------------------------
> > > +1. What is reconnection?
> > > +
> > > +   When the userspace application loads, it should establish a connection
> > > +   to the vduse kernel device. Sometimes,the userspace application exists,
> > > +   and we want to support its restart and connect to the kernel device again
> > > +
> > > +2. How can I support reconnection in a userspace application?
> > > +
> > > +2.1 During initialization, the userspace application should first verify the
> > > +    existence of the device "/dev/vduse/vduse_name".
> > > +    If it doesn't exist, it means this is the first-time for connection. goto step 2.2
> > > +    If it exists, it means this is a reconnection, and we should goto step 2.3
> > > +
> > > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > > +    /dev/vduse/control.
> > > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory for
> > > +    the reconnect information. The total memory size is PAGE_SIZE*vq_mumber.
> >
> > Confused. Where is that allocation, in code?
> >
> > Thanks!
> >
> this should allocated in function vduse_create_dev(),

I mean, it's not allocated there ATM right? This is just doc patch
to become part of a larger patchset?

> I will rewrite
> this part  to make it more clearer
> will send a new version soon
> Thanks
> cindy
> 
> > > +2.3 Check if the information is suitable for reconnect
> > > +    If this is reconnection :
> > > +    Before attempting to reconnect, The userspace application needs to use the
> > > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FEATURES...)
> > > +    to get the information from kernel.
> > > +    Please review the information and confirm if it is suitable to reconnect.
> > > +
> > > +2.4 Userspace application needs to mmap the memory to userspace
> > > +    The userspace application requires mapping one page for every vq. These pages
> > > +    should be used to save vq-related information during system running. Additionally,
> > > +    the application must define its own structure to store information for reconnection.
> > > +
> > > +2.5 Completed the initialization and running the application.
> > > +    While the application is running, it is important to store relevant information
> > > +    about reconnections in mapped pages. When calling the ioctl VDUSE_VQ_GET_INFO to
> > > +    get vq information, it's necessary to check whether it's a reconnection. If it is
> > > +    a reconnection, the vq-related information must be get from the mapped pages.
> > > +
> > > +2.6 When the Userspace application exits, it is necessary to unmap all the
> > > +    pages for reconnection
> > > --
> > > 2.43.0
> >


