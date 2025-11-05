Return-Path: <netdev+bounces-235832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE62FC36390
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 16:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B201A205F6
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047032E6A6;
	Wed,  5 Nov 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeecVev+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+VhSKs5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB062221578
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355288; cv=none; b=fwJP4jRl1RUR75c7CXETeO91PPuKuRLIqCx2Yc1fVqj60u5sw3HwEVAiY2K9SzAKpqzGidtPu9Z0bV1HQHcsdhzQQJBks9h2Y6WriLHIDs9y2tfS8vMk4oMVppkT32onOT+MiI8FBsMI5Kznsfws32xTraPpVTEkYxHoeUP8e4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355288; c=relaxed/simple;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8zyHle/WinF98LCPpSQ1vMZ7UQVnAY3yVQuACRWbPhu1K0eDdEFv2OLDtNEBzHTGtKq0K4b2d8lT7go+ju/9tqDoZ6k2jZv9H8uQcPp6X2WFFYAcdoB06MR5dRR3O5+pIcDLnVlWELpU5hJQNTNtgjxcufSESPkBtUm+rGCaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeecVev+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+VhSKs5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762355285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	b=PeecVev+3s9fakJdP3mprGvod2Kw5Qd0zUzoQD5ST0EAJX2kY/qNI/NRPS/6Mx48nXXcv6
	Nur9n98KtT4mMzDyQjeZ/zo1AwFKn5sfR+fTuJVVl3VEwU2UQf5dQDrvsDTPIKv0s4UH8l
	sNz8QcMACGVegVviN+ubmEbD2vkjl64=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-QrydOSp6PRmSkDF5R_5ECA-1; Wed, 05 Nov 2025 10:08:03 -0500
X-MC-Unique: QrydOSp6PRmSkDF5R_5ECA-1
X-Mimecast-MFC-AGG-ID: QrydOSp6PRmSkDF5R_5ECA_1762355282
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7270cab7eeso59028166b.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762355282; x=1762960082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=E+VhSKs5SJh45HFSv2dfh4byTipz3JBUuXq2cmafniGyY1LOU2Y/5Hfm2O+5q6xElQ
         MpZ8hXEgAx+hKxFiItQqf2EPRWpLqZ/KDhWPjnBl8ShEqGkyqusem0EJx+Ke0SrKROPT
         dZaVWrN/J+oxW+dDGB/UpEvjBQ9I+GeNZIaXON4wEsVEVUbrKCtkQtQPI4jcUhvXhGJw
         eCCOSId/EcvAbpl5TEhLVby2jDhtpub7Xd49lH9pc4D8L7IUoIlmfaGgxU055bot6ltl
         ybDsIFwnRZdgWIzVYuKp0Ve8jQqtAp1PqyFLnvrq7cbuGA7PsmemCOhyckjgsbERpVAK
         TQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355282; x=1762960082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=jG1MBZYzQBurYN1ps2kvXM0EklWBhgrjjhW8Ds2Q8xzSlVXKrACaWG69ibBRLkZJ2I
         WbTETjtYycMmr5x7Sis78HhMmFiohv7TgR9WPYhKKawa4AMOUMZ8eE97E6JGl/IQLbft
         8Unt8KPW70fDduleZx1uR6YIIGOtIXth3BOwCT4zYZm1X26Hwho541UicrsqOEGhbpwF
         /QoDoUXbLIx0hiH0aYxXhOhfUS3Hgz7vRS3pHZ4tv9GTIF1HJupMk0oPbwzmHyUF6eUT
         bDnb5tn1PIIo601ZmYGb/6wYTsOfqLSFx+IMhM40/aGnEeHhCx6JjDdTTtlckrtYmyHQ
         gjeg==
X-Forwarded-Encrypted: i=1; AJvYcCV3395tht7OjXff5otIXX6dVil7Ui29W/CYIh8xtLYevG2yWLbz4mEDPuDvqROce4L9WkwMsK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtmaMMo2HlpndhJhiIH34Xaj6UFq/DazjdrxjgvOb35gPz1+d
	bzYOiqrl+gSTLItweE4czVaVFdqY2h+OW8QaFumSe55PoNPFKqm+BIwZ5MZhyUnJyRWB6BK70o1
	fxl3m37afluyfA0cxsscQw/iCx1nfM1pLHgDdePzs9WUm7S2z2RyM3R/JXfLH5zT3jo5ZS5+e4r
	5GbMNCExgSR93anu+2uJ/JEa9YKflwq9xr
X-Gm-Gg: ASbGncv4cHCao0u8iMJhYK3NC6QdOPoSbagOy2/9AWnyzuxHtO54Jmi5GxqiF6Vjy5L
	16QmhYOLWAZ2ayr0fsdTgLIcp+BuEWTKptvv5YTuvsbKOp6e3vBv/VcRMoZESckjYIx5VS19bVG
	0iMEcSOBpZrMEOKg7JOrnhjjnDWZ27npRIUyryLtQpDraF1b0aEk7jS8b1
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id a640c23a62f3a-b7265568be1mr330078766b.50.1762355282295;
        Wed, 05 Nov 2025 07:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOQsjYVyVVrNvkq8akL5ZkGRlDA5wjcsUyQMOyzqYmrxUAS+dfw/oU0IlQDgyfAtyrlbYChyW3M7kMF0tLDI=
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id
 a640c23a62f3a-b7265568be1mr330075866b.50.1762355281900; Wed, 05 Nov 2025
 07:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
 <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 23:07:25 +0800
X-Gm-Features: AWmQ_bn6PCV_WZmKEJ3xHMkBMOhvHDcRetwwHLmBCefOcZy0CYLo96d-gGmw7e8
Message-ID: <CAPpAL=xDpqCT9M6AWHTfNuai=3ih-452sW4g43gduiw7TptToQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Lei,
>
> On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wro=
te:
> >
> > Tested this patch with virtio-net regression tests, everything works fi=
ne.
>
Hi Jason

> I saw you mentioned various tests on virtio_net multiple times. Could
> you share your tools with me, I wonder? AFAIK, the stability of such
> benchmarks is not usually static, so I'm interested.

My test cases are based on an internal test framework, so I can not
share it with you. Thank you for your understanding :). But I think I
can share with you my usual test scenarios: ping, file transfer
stress, netperf stress, migrate, hotplug/unplug as regression tests.

Thanks
Lei
>
> Thanks,
> Jason
>


