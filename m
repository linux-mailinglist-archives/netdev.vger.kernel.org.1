Return-Path: <netdev+bounces-64528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B448359AC
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28804282FDF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAB63C;
	Mon, 22 Jan 2024 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9CohAEd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCEA7FA
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705893287; cv=none; b=rM5jagwwOSDg/mWErMZ9RgcsAGM9rUVru2iIYeej1rFN66fsYUwyhKGA854Pfji3wuJKICoykJ1aRG/nmiH1KXRSU7+U6vicHJ02Z2OgCs+YIb0SfrG6ChkbPGU1mLL+pUqFrqmVaDgXzBHJJ9m16ghedVMtNWCLqUq1ehNIZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705893287; c=relaxed/simple;
	bh=fvf1TqBmGgn1KaVHdzvH8DL6axWc4da2mBL4/vceZns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzkON2iEnGh3+uJI3XLKYGKcRpWvO0H7K8kYYBQ0weOkR1tLvAdNUA+pcBqi4FmAYMvB7+THqaJkDA4PWLeLwiIDHuU1cxJjCQ3AipS2Dfo+IwqJPV1KLkCq3op7TKxGeOJ6W9SM7dVVQ3HaQjTGkSiTSEr+UCbjbMJ3kyxjLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9CohAEd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705893284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MteD9F9typUYU+7m2KP18kT8d6QN2AVdSUyThZ0N6ug=;
	b=d9CohAEdXKParUEGOtW5dC3+CZxNjzMokuuzSm6A3+5SqQPpicR+TrY2vxSqFzNoVON+U/
	0vwdrzOyNTVxOIfN8eR//KLECExYQpkLY838r5mKfuy2ZawubeSnbQonsoO2YNenM0D0sr
	JQN/JQIN07xMZdrS1oDDlupX95cqsEE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-3mDa3RNwMyS52EYsS1kJOQ-1; Sun, 21 Jan 2024 22:14:42 -0500
X-MC-Unique: 3mDa3RNwMyS52EYsS1kJOQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29013127d49so1154254a91.2
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 19:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705893282; x=1706498082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MteD9F9typUYU+7m2KP18kT8d6QN2AVdSUyThZ0N6ug=;
        b=vML+9/Q+OHPHpWN+5NF563shRAksMeWeV4B06m8tzjOQANr4ExntVMI9iump6u2lAX
         7hMl9gys9PG0G2VbmgqYj4kyLimGvfEaGwb4uAH1eSthtl9JjWbRyeaadm4xs5JDWaPn
         NEhEgVXmPt7AFSGoACPKIBNFmYh/ZIytSAJZeT65DCKtsW+KzA3Vu3oQVvHxMkynZab+
         PFZodJr0PbhfaZKOghXKUy1v4UDi33uOvg9x8jy9990hBdutyyQNsxQ9IBpE1yOti7p7
         Pwj/EA2e80Z5RHFbpg+ndaJ/J8mgVstTXC0OFeE19JdjXbgzObDbCmV+CMOHKDuou7G9
         /l7Q==
X-Gm-Message-State: AOJu0YxmN0qJeJhwi3NQAd9TCqlBTmLd0Ysde658dEKf/rbNvtdhb4bK
	ZqKb204mjLuahajoKZ0htviL5dG5/9Ct+jRV65sEI+xus5+slupdC224xebr7Y/v2JbsK0bF84k
	kxy7eMPy/1A/hN8nulCpUFmp0K1Nq/wX5FOXfi3CvUkGFxsQH0kOLgc0h17wPy5JyyQjvYdkQFy
	EzyCLgAwYEg2/TrceB7bJ1O3vCVTAs
X-Received: by 2002:a17:90b:1281:b0:290:bbe:c9cf with SMTP id fw1-20020a17090b128100b002900bbec9cfmr892860pjb.13.1705893281643;
        Sun, 21 Jan 2024 19:14:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5IoI3Y9sXZSuwvVIZRYnnwTmxpm6QJ1feuwFw5YpeLtijhwLSh9l1fXzf+uz+55QgYleus1ZYmbIRGt72jfk=
X-Received: by 2002:a17:90b:1281:b0:290:bbe:c9cf with SMTP id
 fw1-20020a17090b128100b002900bbec9cfmr892852pjb.13.1705893281331; Sun, 21 Jan
 2024 19:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev> <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch> <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
In-Reply-To: <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:14:30 +0800
Message-ID: <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
>
> =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> >>>>> -           !virtqueue_is_broken(vi->cvq))
> >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> >>>>> +        if (timeout)
> >>>>> +            timeout--;
> >>>> This is not really a timeout, just a loop counter. 200 iterations co=
uld
> >>>> be a very short time on reasonable H/W. I guess this avoid the soft
> >>>> lockup, but possibly (likely?) breaks the functionality when we need=
 to
> >>>> loop for some non negligible time.
> >>>>
> >>>> I fear we need a more complex solution, as mentioned by Micheal in t=
he
> >>>> thread you quoted.
> >>> Got it. I also look forward to the more complex solution to this prob=
lem.
> >> Can we add a device capability (new feature bit) such as ctrq_wait_tim=
eout
> >> to get a reasonable timeout=EF=BC=9F
> > The usual solution to this is include/linux/iopoll.h. If you can sleep
> > read_poll_timeout() otherwise read_poll_timeout_atomic().
>
> I read carefully the functions read_poll_timeout() and
> read_poll_timeout_atomic(). The timeout is set by the caller of the 2
> functions.

FYI, in order to avoid a swtich of atomic or not, we need convert rx
mode setting to workqueue first:

https://www.mail-archive.com/virtualization@lists.linux-foundation.org/msg6=
0298.html

>
> As such, can we add a module parameter to customize this timeout value
> by the user?

Who is the "user" here, or how can the "user" know the value?

>
> Or this timeout value is stored in device register, virtio_net driver
> will read this timeout value at initialization?

See another thread. The design needs to be general, or you can post a RFC.

In another thought, we've already had a tx watchdog, maybe we can have
something similar to cvq and use timeout + reset in that case.

Thans

>
> Zhu Yanjun
>
> >
> >       Andrew
>


