Return-Path: <netdev+bounces-83161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ECD8911E5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F1428AF6B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140B38DF1;
	Fri, 29 Mar 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwYXjBrW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D339AFE
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682427; cv=none; b=NfSwRUlTn9/2OAfAmHclFtDOBQcuSWcxkXlgvrC/SfxN0yeDmjN8Rd/tUVrppJW6GAExKJvsREr3UA1J5ZGECCf3sxE7cSvasVES+7Wn5/o3wS7qYJsTuM6X5uPAk9UfmfmeX5OHZWM9p7ToQ6F8pTqzT/ZCNR2loLvIC8TtUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682427; c=relaxed/simple;
	bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+6hZ6/O+2I+LeyDRL+Qi9FbWX/yuqg7KJG6XSlfFBZge7z27Q2dKufsSkXqp4tCHvt6ANwRAJaEMNNaSOuYJHbhJOTe7/IG0PBJ20Tp0JK/bUX11kSc4tAv9Lgi7bYSJh5m9t5rChJND1ZiUSpQ7sibrOzKoskiUbbeEYtFeuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwYXjBrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
	b=dwYXjBrWg9l1ek4BZBk1B0Tuah01qWLBo0i9mYVFD4lZ/BSbVaADL5MNz1h/SXhdSVrEJ7
	IedBfftXcKCyIgHHlzHsIsxlF2pXOCpPdIWbOm6ZxZI4iFFBJK3D4ewZrHUKOaUD+xr7x5
	ythZqOvl1mSSCjAbO5itJDSC0On+Gwo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-RThtr7P4N9Ob6R4zm33kvA-1; Thu, 28 Mar 2024 23:20:21 -0400
X-MC-Unique: RThtr7P4N9Ob6R4zm33kvA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b8f702cbfso1321024a91.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682420; x=1712287220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
        b=iLAUGIIIoFOT26IPWxSyBeg9Doym8p6FhS8ak+QinIdoiHottv15raRQ+nH27yWexF
         4ihR1zIy8pFeujSg0vQT7eahhqzbfw1ahklef4AOzb7k/FLqo2mBQ/UgILhnUV3+4/83
         vzk5EOnLJiPlMxfazamPfSfv75elFPTLkQWovVGgf0zeInsDj4EwpSAircywkTbApBSY
         2MvOxVhCfbglW8Ena1zXO1HXVI5Qt07n3CbGhjn7OMQWA7UUrWPvU6P+YvJa8C1qfK5R
         g/Hsg9u5k7oArXzLecRxFDNKgRpjLiwu65ob86LscqAOykflOTo9SmHkooIi8H6ggaJt
         nn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUhKx9PENKfY2w8/xCizPtbRahObfBGyXfIw7DyOjLY6JwusANcrnK9z2StTcpkqLG+sH5uevaaP5rqN8K3AaGzauBX5eig
X-Gm-Message-State: AOJu0YzETua0s7BCE7NvkxQsEKJOSINU6/+DEW8sCF0cKShAZJe7/fy4
	y3j0f3/2DyXwgGTR3yksyXTAz4zeHhXAHWMDgfMLjy1GA0FlvjySjs/MnsiDt5KOtnXX2Cyq5MM
	MaHleeNj3eN3sJmbySY7KCimGSxiwfOTL0uXzp6PCti0eaKRw9DH0gRMVgtNjv8SupntG6SFWn2
	5bJT3rfesORaYfapuFEdTGrSYrE1l6
X-Received: by 2002:a17:90a:b784:b0:29c:7701:bbe1 with SMTP id m4-20020a17090ab78400b0029c7701bbe1mr1195690pjr.28.1711682420300;
        Thu, 28 Mar 2024 20:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLFlTvxRS+moINK4pF+4OyZLos3uKx1aCQpB+PaMG2JDkOAVbT80rpeJgJ3hFmOo7yKS42b5cBs1na3WeoaVw=
X-Received: by 2002:a17:90a:b784:b0:29c:7701:bbe1 with SMTP id
 m4-20020a17090ab78400b0029c7701bbe1mr1195679pjr.28.1711682419994; Thu, 28 Mar
 2024 20:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com> <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:20:08 +0800
Message-ID: <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Now, the virtio core can set the premapped mode by find_vqs().
> > > If the premapped can be enabled, the dma array will not be
> > > allocated. So virtio-net use the api of find_vqs to enable the
> > > premapped.
> > >
> > > Judge the premapped mode by the vq->premapped instead of saving
> > > local variable.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> >
> > I wonder what's the reason to keep a fallback when premapped is not ena=
bled?
>
> Rethink this.
>
> I think you are right. We can remove the fallback.
>
> Because we have the virtio dma apis that wrap all the cases.
> So I will remove the fallback from the virtio-net in next version.

Ok.

>
> But we still need to export the premapped to the drivers.
> Because we can enable the AF_XDP only when premapped is true.

I may miss something but it should work like

enable AF_XDP -> enable remapping

So can we fail during remapping enablement?

THanks

>
> Thanks
>
>
> >
> > Thanks
> >
>


