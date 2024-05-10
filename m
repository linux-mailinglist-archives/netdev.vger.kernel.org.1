Return-Path: <netdev+bounces-95305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E38C1D73
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C40D1C20BD1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FE1311BA;
	Fri, 10 May 2024 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKakDSlh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15D20309
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315464; cv=none; b=BtHuptqArPGhimTc26moTDQIFv/Lv7rydMsYHTti9qCL+gRs3pSk61VLg39rbNSyC5YQX8TkMmWT6UY17PwAOVYspaKJX1xqLhq+SwSXUTmBGlw1qOt/0lDV2YyBkvwFS4H9A66plhAKZAuGOWIZu2mYVKcppUgh3znCAbF579c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315464; c=relaxed/simple;
	bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR2vJgCiO2CHO8F4gJrfBZ+uWiapUG7F1NKKmys45+XdyghCDIQIWDTK4Xe+VK/0NvklsS2A5OsoJf5T3cUihmS7d2hhl/CdHBXXUzRuSht7NCPOT5ANBTFTKlc8cPt/k3E+T931h00jg3aYvyWTxC7L65WXKmIscRPC03G3JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKakDSlh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715315461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
	b=TKakDSlhLy/vpf7Ld1nD/ZgTf8+M5z9Z3Lzen6s5dcCFzXXYwOYlAewHNq8BRM7mGBZnlq
	Zkser2wIeuXk2Hu+WD8/uz/bZRhUKCkT9Rm+JmoQPJ+IJl7B1TgFqitoVEIju59PLREB/M
	nR47/DVx18NzZ6Txaxs4W5aPalCiyfw=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-oQpw1P9fM6-A7ov4FDtMXQ-1; Fri, 10 May 2024 00:26:00 -0400
X-MC-Unique: oQpw1P9fM6-A7ov4FDtMXQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-47ef5764ac1so1145505137.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 21:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715315160; x=1715919960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEqqwukL9Q24UARv+N+sHgZpoaoS+D0fOox2cDR5hFM=;
        b=UKFyTXv0hpte9xBUQOLugrP0v7QCRbSqQHuN8TRH64zUu4rurDTnUK42dixi0bQkuD
         IzPAVp1YDFfKLeFAxPiKDWYR5zqHsUk6Q8m/UvBjeJXXoqlKYUnjzfWZc4IAZakjPXHt
         JEwTOqWu8SeE+U6hrqAG5OeZyIF5C0gn3NoimdWjV5hWMYx36PG3bqcsHew2/o8tbFmc
         f6RoZw3iBKclr4qTuLA+L+toawkxrp5s6q4S8PYdrqK6w0KCRA2UlJ67Mh27Eiws43IC
         i4TaItfTkjODK6QSf11xdllXUDFcWoS4ruFqjEBR3FfuReD+K9ZhapxhslaBikl1yN/o
         eraw==
X-Forwarded-Encrypted: i=1; AJvYcCVvJByEpR4sPRz2yK2wnsEm5h22PDpUvRgk41oj2uzYjRmvFGOHnjVgOizc8NbW9BI09482Ib3I6IjLdB1/xAY6vhN0Cjhh
X-Gm-Message-State: AOJu0Yy8vn+wXL2w3S+vOLfAM31r+vPMvlBXvIBbi3SIf00+FTQsrTjs
	yGlgJYFws3JSPMHNyNzw+6qzFul0ZE0/+UcWhfJPcuhoE16eT2h89omoENpsbBB9bomKeA/LQ9Z
	gJ/11WuF/D+aauUIvEi7SR8NP2nqOdunbbr0KNY4uMM39+fkllHqqYtmCbDkipFr3GkrWCbasqB
	zo0IAMbeMiOkrizMV+SCrvqzI7GdsO
X-Received: by 2002:a05:6102:3f48:b0:47a:40f0:d343 with SMTP id ada2fe7eead31-48077e5a533mr1780937137.32.1715315159944;
        Thu, 09 May 2024 21:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEEEOdJZQ7i1dfa9row+zOLZLNzLwHZdkwYF+AIhApxX6Yn+s1XdqbC0eBGXhy/7vVcS1maFJSENv3OZfq9II=
X-Received: by 2002:a05:6102:3f48:b0:47a:40f0:d343 with SMTP id
 ada2fe7eead31-48077e5a533mr1780922137.32.1715315159615; Thu, 09 May 2024
 21:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion> <20240509102643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240509102643-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 May 2024 12:25:45 +0800
Message-ID: <CACGkMEuniiViXuYZK9fvqGbeiayX8L2cYHBw66=qZtz2h=8VsA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> > Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> > >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> > >> From: Jiri Pirko <jiri@nvidia.com>
> > >>
> > >> Add support for Byte Queue Limits (BQL).
> > >>
> > >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> > >
> > >Can we get more detail on the benefits you observe etc?
> > >Thanks!
> >
> > More info about the BQL in general is here:
> > https://lwn.net/Articles/469652/
>
> I know about BQL in general. We discussed BQL for virtio in the past
> mostly I got the feedback from net core maintainers that it likely won't
> benefit virtio.
>
> So I'm asking, what kind of benefit do you observe?

Yes, benmark is more than welcomed.

Thanks

>
> --
> MST
>


