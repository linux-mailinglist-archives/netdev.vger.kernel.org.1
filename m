Return-Path: <netdev+bounces-84700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B72898106
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72339288CA6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5991145941;
	Thu,  4 Apr 2024 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKngJEij"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CE286A6
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712208949; cv=none; b=hFem91xNdlNsQ2cqH1LUjfnao9/EFR3ed1trFG6SAQk2LAYUjGLHrsznD1VpF7rdhVqCIu32o6n69GqRUO2iWpZRE6E2jVObRh6fBHzLJC5hvdYG7pGzOm18mug3D6dj6jXfeGgVsbjQhEG50L3HgPlKbGdnfMhsaumpg9dWM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712208949; c=relaxed/simple;
	bh=Ym38qLEOUNfy/4hL6ENnTMzg8xPqYlCnX/Fr3RLE/U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/vQioblm1sBwh28baNdJ2s0lmuRQxN9RAIXzVq+CB+xTiUGl2DyH4FeYjyXKkRIdlhCWaoKKaurZjfLJz7AA+vJaUhX2ZIWj3EP4GGPPgoKcn9jEW3ko1sgBy78+EEe98L+IePNtypSC0ezVqFw5wxxss0JqWO/zPyoP3v0K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKngJEij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712208946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gaCNfh5JQ71P8XHmMhbBbFyQnfQUNQ6Qvksh5dYu/Jg=;
	b=MKngJEijNtLYHHEutmTMeEj1emj71sE2Z0m90NjOvt78gL6BOgyupJTP8HQhCGFoeW560b
	Ii4ZbsXOPmVdNFsog0a417nfDriSpVp8NjIyoSV6qtioJh2/Q7BPKIRgGbeO6MDoB3PpE+
	5xrVyjS5J8lpqmv8Hvh+zh98gzh5vR0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-1buSRewMOECNZyJgKVYt3g-1; Thu, 04 Apr 2024 01:35:44 -0400
X-MC-Unique: 1buSRewMOECNZyJgKVYt3g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a467a6d4e3eso22400866b.3
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 22:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712208943; x=1712813743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaCNfh5JQ71P8XHmMhbBbFyQnfQUNQ6Qvksh5dYu/Jg=;
        b=NZGF+5P1ZlZ1o373k6zEq0Htv57YOGYIk1ZNwYW0mIwaZYCoGccYARYqazx3hqBn/I
         CqjjqZosrzOAgAj9AtFGQtGPXjZNiInq6aNKrjxZ3+J26s3vvd9LFPSimxqU2+IVp2oR
         rQvpJxsxlKTO+D18CbtSVNQFNDnGgmoJ1lNPACGIFSX3U9Fk7qozlNn8KdOnzsitaEfy
         MzIuHIqqZGODDo5jz6pxE7yqDMDkc5MZrRWed0FZqt6XJJQ0Jjw7Aje+80Bev/WFj1lv
         Ds+CLq6MKAL8pPKyjVZVniu94Ewmf5I4yotw4vij7dnwCYPrYpKz8IXiCOZqV1C32dgh
         L7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWEF9FxN2acWI11lZVmQ6JLdFiNxtviPSyF03DlwO+c5dNg1kSS6+h8e8V9Y0F+klbEQkCEqq5oNtmPWDIZdgfsVZcqj5TW
X-Gm-Message-State: AOJu0YylW15yNofjn788XR4zrn6ys10LFcEk4ZJYinL4/CDSEdRViaxy
	Lbj95VqfhgLkuQz1py2dOYpgM6d44iXCrkwGOk/MUdwEAjTTcQdMJ1QmjRG4sH2JCmD4lceW+Md
	pfVvZXeK6kqk2NLfGk7tLLydmC1gpnnVXq586gM5vIwjdVeadsvLtZnoV4hn0p/M56nH7eGZG6T
	WKun1FKTZzdHbHqgWX/HF+u2SW4vu+5rdB3x+rE6I=
X-Received: by 2002:a17:906:3e50:b0:a4e:9591:c2dd with SMTP id t16-20020a1709063e5000b00a4e9591c2ddmr725276eji.39.1712208942842;
        Wed, 03 Apr 2024 22:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6977Prz4EA27qaIn9ShWtc7ls7nUld0dGYjMeBaoZgL/dkR13B3ZOUXg8GK3+bvqSwQUifVVp85zJvDVRczk=
X-Received: by 2002:a17:906:3e50:b0:a4e:9591:c2dd with SMTP id
 t16-20020a1709063e5000b00a4e9591c2ddmr725266eji.39.1712208942439; Wed, 03 Apr
 2024 22:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329093832.140690-1-lulu@redhat.com> <20240329054845-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240329054845-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 4 Apr 2024 13:35:02 +0800
Message-ID: <CACLfguW5GxYLtgL-8itH6b9re25bGsorKBWwDW9z5kBucSPLVg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Add reconnect process for VDUSE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 29, 2024 at 05:38:25PM +0800, Cindy Lu wrote:
> > Add a document explaining the reconnect process, including what the
> > Userspace App needs to do and how it works with the kernel.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  Documentation/userspace-api/vduse.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/user=
space-api/vduse.rst
> > index bdb880e01132..f903aed714d1 100644
> > --- a/Documentation/userspace-api/vduse.rst
> > +++ b/Documentation/userspace-api/vduse.rst
> > @@ -231,3 +231,44 @@ able to start the dataplane processing as follows:
> >     after the used ring is filled.
> >
> >  For more details on the uAPI, please see include/uapi/linux/vduse.h.
> > +
> > +HOW VDUSE devices reconnectoin works
>
> typo
>
Really sorry for this, I will send a new version

Thanks
Cindy
> > +------------------------------------
> > +1. What is reconnection?
> > +
> > +   When the userspace application loads, it should establish a connect=
ion
> > +   to the vduse kernel device. Sometimes,the userspace application exi=
sts,
> > +   and we want to support its restart and connect to the kernel device=
 again
> > +
> > +2. How can I support reconnection in a userspace application?
> > +
> > +2.1 During initialization, the userspace application should first veri=
fy the
> > +    existence of the device "/dev/vduse/vduse_name".
> > +    If it doesn't exist, it means this is the first-time for connectio=
n. goto step 2.2
> > +    If it exists, it means this is a reconnection, and we should goto =
step 2.3
> > +
> > +2.2 Create a new VDUSE instance with ioctl(VDUSE_CREATE_DEV) on
> > +    /dev/vduse/control.
> > +    When ioctl(VDUSE_CREATE_DEV) is called, kernel allocates memory fo=
r
> > +    the reconnect information. The total memory size is PAGE_SIZE*vq_m=
umber.
> > +
> > +2.3 Check if the information is suitable for reconnect
> > +    If this is reconnection :
> > +    Before attempting to reconnect, The userspace application needs to=
 use the
> > +    ioctl(VDUSE_DEV_GET_CONFIG, VDUSE_DEV_GET_STATUS, VDUSE_DEV_GET_FE=
ATURES...)
> > +    to get the information from kernel.
> > +    Please review the information and confirm if it is suitable to rec=
onnect.
> > +
> > +2.4 Userspace application needs to mmap the memory to userspace
> > +    The userspace application requires mapping one page for every vq. =
These pages
> > +    should be used to save vq-related information during system runnin=
g. Additionally,
> > +    the application must define its own structure to store information=
 for reconnection.
> > +
> > +2.5 Completed the initialization and running the application.
> > +    While the application is running, it is important to store relevan=
t information
> > +    about reconnections in mapped pages. When calling the ioctl VDUSE_=
VQ_GET_INFO to
> > +    get vq information, it's necessary to check whether it's a reconne=
ction. If it is
> > +    a reconnection, the vq-related information must be get from the ma=
pped pages.
> > +
>
>
> I don't get it. So this is just a way for the application to allocate
> memory? Why do we need this new way to do it?
> Why not just mmap a file anywhere at all?
>
We used to use tmpfs to save this reconnect information,
but this will make the API not self contained, so we changed to using
the kernel memory
Thanks
cindy



>
> > +2.6 When the Userspace application exits, it is necessary to unmap all=
 the
> > +    pages for reconnection
> > --
> > 2.43.0
>


