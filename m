Return-Path: <netdev+bounces-68877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C7848A1F
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E561F239F6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FE816;
	Sun,  4 Feb 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbOP3nku"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE491C0F
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009636; cv=none; b=Uh2t3hS8Jdl0O1u88Xr3pgyQaYgGT5Rf2HcUdhN5tPjpFB5cHK9L68SYKD2VLmqsniXooB1hJFRek85dlkT/5/7XzGFfD5tH4FjPipWNC1sqUAg7PqfAcZ88c3QQ+VJtZDwXQld3XozgyAElXMx/WYfoeVZbD3BTvk2vEOWGZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009636; c=relaxed/simple;
	bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTy7a60AOLOmKlAF8FQsINoCq9og7rGJSYKrVJMb0RXlwJGIunW5IuthkjguMqZQofWY5UPt6BT1AJPKpcO6eWiY6T1dJLd8DSCdpgbh2zqItGmIeLqNvBYmChGQc08Ky3Hs5Iy5+KVcbeXoBOc/Yp/MBoV+6dBKNCKu8sy+UCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbOP3nku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707009632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
	b=VbOP3nku89BtM+p7ZgKTjZZPjaGlzc/cFB7pf1Eu3F4d5fX3EaqgfAomtTC1TwW6PZCd2k
	IzKACsTQBBCT7xPE9slcOSAhHslNQVevLWgzXwphrVkuJTVhUEFuwSmFDfusiD24IZ3M74
	MATL29NSDZCzFxhUnUPYzmIRHdN7/x0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-P31Y88H1NB2-7Xr0IZmUVw-1; Sat, 03 Feb 2024 20:20:31 -0500
X-MC-Unique: P31Y88H1NB2-7Xr0IZmUVw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e03ce1cfd9so67297b3a.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 17:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707009630; x=1707614430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrLn6m3UyHUH3/hc/boqpLQuQEwf0Xhn2F1etqYsfrw=;
        b=iXJx5aneOyYiu/xoyhtZw8al0OGFKYYy8ITN+zip213VsTAcEhFUEhF15PBOu4jMh3
         o3X3ZoKMq5qu8K5XTKShQFIDi9vzsEvh6Bkgd9rV6AcVbVmAPDX644v87sPdBazx/PUd
         rMN4P46T+YHCr1IDiYV3faN4GaSga+8WOKDar2453VZl/iGow3noTSMGHHXqy+V1kWxv
         Djl0uJ4LftYQBCHBYpgxcUvopxwtcX7nR6RYJxioOnowz5fsZLTVwizhjUvSt0XSqUNB
         54gePBKnq/bCQAe2wpuP5qpevB74pp4zugddX48eoQ3HOg9mXzanQaLc2nQ6Up/o+OFx
         hjJw==
X-Gm-Message-State: AOJu0Yxg9Kd/vLAgUoTXU2Aqi88WV82gupFJMQPrcs6Y1VIRgRAkQ/1l
	pElkFBhcLdkNb1lBzO38tbPQWqn4OhYTOBYNX5eQCBsxzXPBRAXfA8rTyCFR+PpHqe8L2b2l5tx
	owKPqfElGYMUT57ReuWPn4Ux0Q+kNv32lgpB/WF82yoWwgkPLuac9WdLyAb/qvQhCLm2a6KPRp1
	MAdk/Ip3LYRYKZP9YIRaQQIdx+leMw
X-Received: by 2002:a05:6a00:2d9e:b0:6e0:39eb:4458 with SMTP id fb30-20020a056a002d9e00b006e039eb4458mr740456pfb.13.1707009629938;
        Sat, 03 Feb 2024 17:20:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpEqw0qeg+3LkvyM090gl2kRntiMNEEAMPcCtEOcygOBp3Ndl+KISIbO/hY3TpjCUGrq5QZrOz0t80A5hhj10=
X-Received: by 2002:a05:6a00:2d9e:b0:6e0:39eb:4458 with SMTP id
 fb30-20020a056a002d9e00b006e039eb4458mr740448pfb.13.1707009629660; Sat, 03
 Feb 2024 17:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
In-Reply-To: <20240202080126.72598eef@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:20:18 +0800
Message-ID: <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Daniel Jurgens <danielj@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > Can you say more? I'm curious what's your use case.
> >
> > I'm not working at Nvidia, so my point of view may differ from theirs.
> > From what I can tell is that those two counters help me narrow down
> > the range if I have to diagnose/debug some issues.
>
> right, i'm asking to collect useful debugging tricks, nothing against
> the patch itself :)
>
> > 1) I sometimes notice that if some irq is held too long (say, one
> > simple case: output of printk printed to the console), those two
> > counters can reflect the issue.
> > 2) Similarly in virtio net, recently I traced such counters the
> > current kernel does not have and it turned out that one of the output
> > queues in the backend behaves badly.
> > ...
> >
> > Stop/wake queue counters may not show directly the root cause of the
> > issue, but help us 'guess' to some extent.
>
> I'm surprised you say you can detect stall-related issues with this.
> I guess virtio doesn't have BQL support, which makes it special.

Yes, virtio-net has a legacy orphan mode, this is something that needs
to be dropped in the future. This would make BQL much more easier to
be implemented.

> Normal HW drivers with BQL almost never stop the queue by themselves.
> I mean - if they do, and BQL is active, then the system is probably
> misconfigured (queue is too short). This is what we use at Meta to
> detect stalls in drivers with BQL:
>
> https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
>
> Daniel, I think this may be a good enough excuse to add per-queue stats
> to the netdev genl family, if you're up for that. LMK if you want more
> info, otherwise I guess ethtool -S is fine for now.
>

Thanks


