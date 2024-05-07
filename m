Return-Path: <netdev+bounces-93953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D878BDB74
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7842E1C20EA9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0323A6F060;
	Tue,  7 May 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5fWc/cT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBF6D1BB
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063369; cv=none; b=RPrPXxgEns4FQmCDsScKuoeBfBXoxNYQqmpA3dpt2RvUesSQCnOM9P7uVRrTwQgOiQPvUK4daDpPtNzfCuJ8Js9S9W3KmFL78qFe1y4yeMai5IMlC3oCODzubGOEVhS39x6pjjr9jkFtfuXe6Wst7/3NazoQdsbfNbdEjt9UP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063369; c=relaxed/simple;
	bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4IF7A2KJufeWpxzam02CCCqmdATzWuEisRioRTmJdrLTkBj0bU2H83tsoxgDprVM7NmTkarp54NDi4GT6DkDOEBXm7MgOvRSZoKBA+/Lj5pWTvA9DOFVyBPT1KCGnPqsgIeiHrrfSGVCtOt7ySEzPfp8EMZm0zfri98bZemL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5fWc/cT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
	b=d5fWc/cTZVmRLvyCp1dwxbaAG9L838JoSg0J0dY/E8AX02+9au9Xxr7usoci0/eP/A3H5i
	Ww9Uaw+WhoRzkffPLmTNefASB56QdgLOatzfrfLlCo++DzMZHTwPRmoUfXPpVusBCIdAjh
	E1JABQFKYX+08DCs5+ltIRyGHgbFx6A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-y4TW7vivMAyUOVXu1H6tUQ-1; Tue, 07 May 2024 02:29:22 -0400
X-MC-Unique: y4TW7vivMAyUOVXu1H6tUQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-61c4bbe49e3so2971266a12.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 23:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063361; x=1715668161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
        b=mslSvJAmFGZZJ9JZSYj4nRaWM5fUMQ95yf//1yaZKccl0Y/GiPxazF5dXvL6DIQI/+
         gTto7Ygj2DHUmVdatHkXINefvti196jcliBNlV1s8woCRarBruCtm97pNFmYPlZoJzsH
         KU8QpfKOf3KpTQ+hnsLnD0T4oMFMl2fkE9hHww2/MxOqGq2rnFV3XQzZuvTedpTnOUSR
         sOr3QfLNtH5zePFpgRdxrplBNG4HFZu3U1oBrSNNb+Ts37H4lsUZS8lUCf9/quYjdkgp
         tghaLEnRHrsl9LRdANtnldvyxtflUNXT6IGoLCNXRjly+hfLHKKwH2ulaHmDc2/RIb19
         Pb2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJp/2gX+Rr4nsyiW/rQQdQeq4gMNDgWvSj1WDerk26S/AQn2ECGzml14+MvZ6uIM1W30g71krl8BYzALcZ3GayjkcivOkE
X-Gm-Message-State: AOJu0YwmhofnfUXOkJMrdvpwTpJ+gAxXHu8mkwHYBPdpAwt5hQt8xs35
	YF5VQ8p8Ai0Jx3O/KzDuN9Fg5uTVc6fxyBasvmW+PqVPuqLb+PBZjxhFepDYu3vjYfaaq0T8Jsj
	RxxC8wghM0E8czSDX32f5Lzvo1VVGeCbppchoHkxdRI5PE/G3c8fJpZJB3StkPH8BDuJGHQr5Md
	CnM6dJ0kh8avPr/ysW7i8wtc4oBuvR
X-Received: by 2002:a05:6a20:9d90:b0:1ae:3812:945e with SMTP id mu16-20020a056a209d9000b001ae3812945emr16600637pzb.62.1715063361674;
        Mon, 06 May 2024 23:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEau7qXr2ROZrlqu5ZAhJM3ZigbzDbHsrm8pZqf6knZQNd/Yb0kztQ6agTSako5xF/rXdcv9NN3dcTVY8IlWxY=
X-Received: by 2002:a05:6a20:9d90:b0:1ae:3812:945e with SMTP id
 mu16-20020a056a209d9000b001ae3812945emr16600622pzb.62.1715063361332; Mon, 06
 May 2024 23:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503202445.1415560-1-danielj@nvidia.com> <1714976172.0470116-1-hengqi@linux.alibaba.com>
In-Reply-To: <1714976172.0470116-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:29:10 +0800
Message-ID: <CACGkMEvAEu1TaPEj6x2A2J0EdrJj_CkHM5-qBM9_OHo2O5uKzA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/6] Remove RTNL lock protection of CVQ
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:20=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Fri, 3 May 2024 23:24:39 +0300, Daniel Jurgens <danielj@nvidia.com> wr=
ote:
> > Currently the buffer used for control VQ commands is protected by the
> > RTNL lock. Previously this wasn't a major concern because the control V=
Q
> > was only used during device setup and user interaction. With the recent
> > addition of dynamic interrupt moderation the control VQ may be used
> > frequently during normal operation.
> >
> > This series removes the RNTL lock dependency by introducing a mutex
> > to protect the control buffer and writing SGs to the control VQ.
> >
>
> For the series, keep tags:
>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> Tested-by: Heng Qi <hengqi@linux.alibaba.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


