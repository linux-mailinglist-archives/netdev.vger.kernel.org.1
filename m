Return-Path: <netdev+bounces-68312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B184688A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 07:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0ED1F25F9F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2D4C60;
	Fri,  2 Feb 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K//hfUV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C01774E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856820; cv=none; b=DJTY+T5hGg3y0lI1zVEAEQl7CgX6/kaygF6xM91TOUAXQdHiYkacK7Gm+lzPuF5fpBslT830tPloipvvU64jo07G2okfcD1xrqpRGdk1E4qzDaw6xKYjhT86Pd9WPCHZfj4Z9qDKbLx54nEMX14wXsYTDoUGsWvfPX0mQvH8QYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856820; c=relaxed/simple;
	bh=ytxKKoH6m1FpvOOP2xrdqPW7rQRGcgbpp2Hofo4i82g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqp+0yWHk0lNPcngAoTQqI9N38j+KGTi89Mcio9FTpP/ORJNOAiKq1+ItIj1G1UA3QU6p/W7/GnW39ZITptyGvZiHXvBuI95+BgBOfQYq2hRqOy/WyR8j6si9qMaz6ou8+GBb3tOgOUiXllIon4H7EUSkoDmHOnF4t8fbgX6Wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K//hfUV7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55790581457so2541634a12.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 22:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856817; x=1707461617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAf503YgteKPE3E8ZXGS7zG1wXVaCsQDoyqCH3wVqBs=;
        b=K//hfUV7L3OuEEq06wGJrsqirsHMUzF14fy0sQKvfW5Sam+lqZ3La3kkKE9agDoBGb
         IezXRC5h8hwgq6frCr1/6Ymql59WN/jj3kqxnPp+OYF4Gx43oQYFqCaF1H3VY6MCW1Mt
         GWqpZXpQnX3/KWxJpkLOBJjfjBOtdg/w6XrzaNlddwsAeuBgVzbt93m4gYfSfJnfXBiS
         cn9rPttizmM3QmBOzdT/+cZNcGXSTBgg+bTHG90hj9SCapMF5D/3km5N8KH4ipYdoHBl
         2P2nWNqa24IB3SUMdPwyCNrMzEu3u5der9+MqqoNwt3u4Arf2913BRliYvU2o5I0aTlX
         pOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856817; x=1707461617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAf503YgteKPE3E8ZXGS7zG1wXVaCsQDoyqCH3wVqBs=;
        b=CsOVjKN6SNvSl8A9fAnX2SQBjtmDnjL+SAyWm+YQtRu0C3vqaOVtjZb1JVglLoxLBB
         K8VC29FY1S2OdRzEMiMLkF7LeCN/YrXMVyZGU0cOIVbffY6MxLgx8Tq0J17ROwVm8ENg
         GiFR/HnJ8FlFkd5TAmGbHYF3hZ54uZIyZAQRPHiHKZhiUNULrenayzi4JHi9RD9zTe8i
         2ZXCAt6HC7wAr/8JFvNOhRDJujkrSdpsP6D/IgDuzZHX5Q8JFvvsFMzyq3EHUvGWkALA
         itDVTJILxpyqi1lK51955HRi2TflSo/fUmF2zG5DdkCVwVFSc8Bm78ygrM6mGmyBGxl/
         j/Yg==
X-Gm-Message-State: AOJu0YwWrrrxn9b2S2csfPZBLHzh+Q4DrGIYEt8c79CzYhx8Lm0G6wT/
	LM4xN+A46xn+SA65cgBuS1lb7Ne7VKLAytvYbraptLx+n6rrGERagR4XJnXiu+rWN4qdqE4fmCT
	AEWwD74p/AtNiLEXLk0/aXIsg9sftEBvd5GhMGw==
X-Google-Smtp-Source: AGHT+IFSnJi2norEH5W/UpLjlPsSq2FcH7Nrf5O3rTb2MutI1ES6hpawvaZT7z+uaATyDRcDLlC4fFluOy1XAaFM9PY=
X-Received: by 2002:a05:6402:164e:b0:55f:a1af:a1eb with SMTP id
 s14-20020a056402164e00b0055fa1afa1ebmr662798edx.23.1706856817038; Thu, 01 Feb
 2024 22:53:37 -0800 (PST)
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
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com> <20240201202106.25d6dc93@kernel.org>
In-Reply-To: <20240201202106.25d6dc93@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 2 Feb 2024 14:52:59 +0800
Message-ID: <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 31 Jan 2024 10:54:33 +0800 Jason Xing wrote:
> > > [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep 'stop\|wak=
e'
> > >      tx_queue_stopped: 0
> > >      tx_queue_wake: 0
> > >      tx0_stopped: 0
> > >      tx0_wake: 0
> > >      ....
> >
> > Yes, that's it! What I know is that only mlx drivers have those two
> > counters, but they are very useful when debugging some issues or
> > tracking some historical changes if we want to.
>
> Can you say more? I'm curious what's your use case.

I'm not working at Nvidia, so my point of view may differ from theirs.
From what I can tell is that those two counters help me narrow down
the range if I have to diagnose/debug some issues.
1) I sometimes notice that if some irq is held too long (say, one
simple case: output of printk printed to the console), those two
counters can reflect the issue.
2) Similarly in virtio net, recently I traced such counters the
current kernel does not have and it turned out that one of the output
queues in the backend behaves badly.
...

Stop/wake queue counters may not show directly the root cause of the
issue, but help us 'guess' to some extent.

Thanks,
Jason

