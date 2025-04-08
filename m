Return-Path: <netdev+bounces-180271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE7A80DAC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84E01B616FD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C021DF268;
	Tue,  8 Apr 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aGieJI9z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58A1DF252
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121818; cv=none; b=fyPTj8sGK8L8iJlBA30axmOuTfhj0jItgv6Kfpailwghy1JC1npooULWN9ACgqLdojlNet3Hbv7VM92fjC7AUuDxERP9OnaGF0LiOWqNpOGyjDh2Ig+AVA/xyyMFMv8PDFtv356eO5zcdaxTkhPXOawyxcPXlXcHwIGYdgEKRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121818; c=relaxed/simple;
	bh=CAfFYhE19lEpha0uyT3WZB6DyLmE8lndc3YNKLogOUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5pQSkMqrTb0KttiYt54A8NKAfZtZ2y0sulgcwqJoghGQL4eSIiYyapcM8hQpkeFXVIf9nLkS4k6Rdrg49PSUYqdkoU7LNPNN5fzFuAFvqw0WEkSsmW/rOvmEahGl6lJsEEtim6p9JYA/htCdDSPTXkCgMhyJPX6JGImrafbG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=aGieJI9z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so54257265ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744121816; x=1744726616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwjLKgy7tflbw5YfoSZwuNmuCR/J9lq7qfAaB3Q9YI0=;
        b=aGieJI9zzMUyVSsiQhjQeN5JhBOQVnLRE/f2AV+6Dt1WDx9vdQP7GXG7jQ9y7XSxdd
         iO3BbgDRJK1dKA5ua7TrfOd2JlhUu6HARN74TefhZLsRm/p393L4G3R4ritI4NWBeGWY
         lBmbnwy57B61GpjaEz1xZeArbbi1GSlZbz2NWweUd0q/D4vx5VN+9nXZvWnEvnEKBZ6B
         gYCLHVpQuG40fyhlXmNDSsIlnHPKESQJHG58KRwxM3ZDV6eHhOsAkZ5pJALmIKRxN0Lt
         fa9Ew9bTRu5L/VI4ax3hV9jPGXs8BSc966sCvWtio6pg0Ge779XmnU1urvz+ZBtySq3O
         wm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121816; x=1744726616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwjLKgy7tflbw5YfoSZwuNmuCR/J9lq7qfAaB3Q9YI0=;
        b=l/0w8RJcQCHV+1ydp3H0RTu2ZpJjgf3KlDRq0kpvJTuCbeGYRbX1MJXNtzOVqMEnRI
         leYUIcgGx3zMmEaZi+cTeJfuC4DmhUQgF6+cYaqVdgut/5i5GPkWWZrxNvoVT4wZMd/a
         IfG0SoDoRMgwq3+xYa/yM5Pw+3djG+ziDfy0xJeZW5jsIqdOfQk1Xunavg9lOB5pCdv8
         h9Vms38mVZKsNCxIqIIHnB7xVJEsCyxV2UqtOv8VaxlUK4I7rWOlIOBxBhbI7N+wAevr
         sxFQZXQ8KfFgGmF1dojMaQUUeoY1Zj5MORSiv1y8WpOEQeP0clCeAbZbjlY2VtxETCZZ
         mSyw==
X-Forwarded-Encrypted: i=1; AJvYcCVaQui4qNPTDdThA1Hn1fhSmWL5vlPEXWXzkH3/ilt5BFmtEzlYRGzFSI5n/l2OOaElbU9BU+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRgYYpBpLUq5eGFvsndPj5r4KHxovNS+WwB4FFqlrNByEfDT6
	qVtDGpMXPDZ3l/bvgAFmB/3JmDj1BYOfsVjH/VboEeKag7XG7sQuAphhhsW/r4BuIMevk80/9zt
	3HCpUyq+Z2XOF4XUeoI4uh1vpsqUsNeIIIBwq
X-Gm-Gg: ASbGncuKsrfFL3n2MNfYsqlOt0Q1M3C1+NzPtAV2CBjK1vtTxm55YQ0rID0t1lL7byx
	QxUs5FzvJzvsXDVPkNrRJfUFayZdoqHE1wBOYvfgVAftioroeoJRK1hRCWBviNgHq9iCrRXQZJW
	R3cYN+YmNPGhrI9dIiJPdvF9u8Kw==
X-Google-Smtp-Source: AGHT+IGSWYdq3Ahz6Ex1a1swRK+oEYlgjp+ct/ud0FYFYaTFhWab73ciNHNnrUQdmu8aVyW+kQFfuJL8lwa4djUvsuA=
X-Received: by 2002:a17:902:e805:b0:223:4bd6:3863 with SMTP id
 d9443c01a7336-22a8a85a489mr214712985ad.10.1744121815994; Tue, 08 Apr 2025
 07:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308184650.GV1955273@unreal> <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal> <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal> <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com> <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
 <20250319191946.GP9311@nvidia.com> <CAM0EoM=7ac-A=ErU_PojZuuB4eHnoe-CdPxBi3x9d+=PxikfgA@mail.gmail.com>
 <Z+QiKan/j3UIhwL1@nvidia.com>
In-Reply-To: <Z+QiKan/j3UIhwL1@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Apr 2025 10:16:45 -0400
X-Gm-Features: ATxdqUHuD2W5uOjswbSNs20uZCmjGnd71HyB8P8GbR36Wa0qvd5l7_4T6bufB-k
Message-ID: <CAM0EoMkdTuJ8Oe+S2L+t6m3Q4UdMfJhFFhdjpdZbD7HLAadsdg@mail.gmail.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Nikolay Aleksandrov <nikolay@enfabrica.net>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Shrijeet Mukherjee <shrijeet@enfabrica.net>, alex.badea@keysight.com, 
	eric.davis@broadcom.com, rip.sohan@amd.com, David Ahern <dsahern@kernel.org>, 
	bmt@zurich.ibm.com, roland@enfabrica.net, 
	Winston Liu <winston.liu@keysight.com>, dan.mihailescu@keysight.com, kheib@redhat.com, 
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com, 
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com, 
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com, 
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry was too distracted elsewhere..

On Wed, Mar 26, 2025 at 11:50=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Tue, Mar 25, 2025 at 10:12:49AM -0400, Jamal Hadi Salim wrote:
>

[Trimmed for brevity..]


> > For a read() to fail at say copy_to_user() feels like your app or
> > system must be in really bad shape.
>
> Yes, but still the semantic we want is that if a creation ioctl
> returns 0 (success) then the object exists and if it returns any error
> code then the creation was a NOP.
>
> > A contingency plan could be to replay the message from the app/control
> > plane and hope you get an "object doesnt exist" kind of message for a
> > failed destroy msg.
>
> Nope, it's racey, it must be multi-threaded safe. Another thread could
> have created and re-used the object ID.
>
> > IOW, while unwinding is more honorable, unless it comes for cheap it
> > may not be worth it.
>
> It was cheap
>
> > Regardless: How would RDMA unwind in such a case?
>
> The object infrastructure takes care of this with a three step object
> creation protocol and some helpers.
>


[..]

> > When you say "driver" you mean "control/provisioning plane" activity
> > between a userspace control app and kernel objects which likely
> > extend
>
> No, I literally mean driver.
>
> The user of this HW will not do something like socket() as standard
> system call abstracted by the kernel. Instead it makes a library call
> ib_create_qp() which goes into a library with the userspace driver
> components. The abstraction is now done in userspace. The library
> figures out what HW the kernel has and loads a userspace driver
> component with a driver_create_qp() op that does more processing and
> eventually calls the kernel.
>
> It is "control path" in the sense that it is slow path creating
> objects for data transfer, but the purpose of most of the actions is
> actually setting up for data plane operations.
>

Ok, if i read correctly thus far - seems you have some (3 phase)
transactional approach?
Earlier phase with this user driver interaction which guarantees
needed resources being available that subsequent phases then use..

> > If my reading is right, some comments:
> > 1) You can achieve this fine with netlink. My view of the model is you
> > would have a T (call it VendorData, which is is defined within the
> > common namespace) that puts the vendor specific TLVs within a
> > hierarchy.
>
> Yes, that was a direction that was suggested here too. But when we got
> to micro optimizing the ioctl ABI format it became clear there was
> significant advantage to keeping things one level and not trying to do
> some kind of nesting. This also gives a nice simple in-kernel API for
> working with method arguments, it is always the same. We don't have
> different APIs depending on driver/common callers.
>

agreed, flat namespace is a win as long as the modelling doesnt have
to be squished into a round-peg-for-square-hole abstraction.

> > 2) Hopefully the vendor extensions are in the minority. Otherwise the
> > complexity of someone writing an app to control multiple vendors would
> > be challenging over time as different vendors add more attributes.
>
> Nope, it is about 50/50, and there is not a challenge because the
> methodology is everyone uses the *same* userspace driver code. It is
> too complicated for people to reasonable try to rewrite.
>
> > I cant imagine a commonly used utility like iproute2/tc being
> > invoked with "when using broadcom then use foo=3Dx bar=3Dy" apply but
> > when using intel use "goo=3Dx-1 and gah=3Dy-2".
>
> Right, it doesn't make sense for a tool like iproute, but we aren't
> building anything remotely like iproute.
>

My point was on the API. I dont know enough so pardon my ignorance. My
basic assumption is there is common cross-vendor tooling and that
deployments may have to be multi-vendor. If that assumption is wrong
then then my concern is not valid.
If my assumption is correct, whatever provisioning app is involved it
needs to keep track of the multiple vendor interfacing - which means
the code will have to understand different semantics across vendors.

> > 3) A Pro/con to #2 depending on which lens you use:  it could be
> > "innnovation" or "vendor lockin" - depends on the community i.e on the
> > one hand a vendor could add features faster and is not bottlenecked by
> > endless mailing list discussions but otoh, said vendor may not be in
> > any hurry to move such features to the common path (because it gives
> > them an advantage).
>
> There is no community advantage to the common kernel path.
>
> The users all use the library, the only thing that matters is how
> accessible the vendor has made their unique ideas to the library
> users.
>
> For instance, if the user is running a MPI application and the vendor
> makes standard open source MPI 5% faster with some unique HW
> innovation should anyone actually care about the "common path" deep,
> deep below MPI?
>

I would say they shouldnt care because the customer gets to benefit.
But on the flip side, again, that is counting on the goodwill of the
vendor.

cheers,
jamal

