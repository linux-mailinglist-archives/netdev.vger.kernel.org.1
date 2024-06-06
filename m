Return-Path: <netdev+bounces-101286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0E8FE046
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4802870DE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBEC13B2B9;
	Thu,  6 Jun 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ubwkp1KC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D413AD0E
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660632; cv=none; b=caCW54BvAIo22mFaQEDlWPIHSJrYIjAEroC8D1SgwQ802F/0UoXpLGY1tykyquxtj00zEgs0+NScgYQ19D4bO+k7HorwWkB+axaVRPjJRH2Vz6Ynm7tMhx09+ubWVyB2IjvsTOZIaZj2tFAOX0bKPA7KCVjFAX8n7Ac9rXXNumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660632; c=relaxed/simple;
	bh=fEctaKe23/K7WPGYjFfGzC2gcpDNq3frPQpRj0MtfrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUcoa5VCa8xz2+Ov9NZbQSYI5NXrrcmED5a7ic1wqbQpR8p/Mhi9NVi2G15n5fZ6Jcy3Eiir7g8fA5NWIfP6FqyK4+3/z2fGeZlFyUxz268X3on5rJ6kZG0FWzDKk4Tf0t3L5f+nTLc6Rr3ZUN+1XXsb8iE49fhVfIAkFGra8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ubwkp1KC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717660630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaFEJRL2VRwXC7VyjrS58e/68QUO+dkEzJQeXtx2VPU=;
	b=Ubwkp1KCeUFKc6Ha2thSHw+GwuMButT5HUL3fuJp7UspvDPr5psK+NGip5aNKj/F9kslce
	Qcc34kXDXnnzoDhSJTcA2yKtROijc0fhdp4bkdov5Pwwd731c+uDBTEJz8HgX9lqn63bUb
	8PJenZ35knFHWKETWRZbTlnnYDG/iO4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-VyGVzWTUNH6WkFC6NAZxfw-1; Thu, 06 Jun 2024 03:57:09 -0400
X-MC-Unique: VyGVzWTUNH6WkFC6NAZxfw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2a64145c8so124003a91.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 00:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660623; x=1718265423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFEJRL2VRwXC7VyjrS58e/68QUO+dkEzJQeXtx2VPU=;
        b=KvlQKHWP7jYmE/C18flDwa+wuK1cXgAaJF8Ut/5UwrgaXqhTupBLQS6jdR6BtYeHmx
         Fyy3y6xvdOId0k0sm2W8p+AqdYCviauZ9oKT6H+Ec2UaTqdBOfkh6jPp8yWSLAhO5vQK
         e/xHJqH4Kz9QAB4Kafr5MnFbU/cs1xIXi1yrvQx+x28VcQ+unQ3NOoAPCKd9HJWwn/6l
         8IGNvPu4S6GxRmFfcoRbHe4n9Ei4ok+FZ9xPGj0Gmdffsrup/K00EI2RfcmGjU8m3t5Q
         ZWUPeTXUhbkPhqtY4/5ln3OhM8MdzJGCVTkWEyTLUE6P6bfvbhH1Q0XYfbAyG+Ok6pKK
         yNWw==
X-Forwarded-Encrypted: i=1; AJvYcCUscnzHlY6MktytmUmL9aPxQx6yfaJmzlSOkxfVEgqRGhD0gA3ZTvJvJxOfGh/KpdcvjYHf6PKfyg1sakpEwChoAm0xI7om
X-Gm-Message-State: AOJu0Yxfkz6w+bkxvkjV44G4us3k2OqrHdp26G5qwm6SB1l/8KTj15Nd
	n4yWvGoDG9iCIo0RBBJaY6i7pmCtktOh/NfjHi2nY7kuqRH/fFRkd+NHFj2eO6j6jg2pD1VzYVv
	Wbl58aEnf2JwpT96RUydWQG9PuMCC+FqpRiW5ylUqZiwZYDhliLD1X/ZnmY3muogBSyGdS+JTBw
	3w8ZPB1qEzInYL6qNnJCze08Zqpw7v
X-Received: by 2002:a17:90b:19d5:b0:2c2:29a2:9b08 with SMTP id 98e67ed59e1d1-2c27db68d96mr4631207a91.40.1717660623027;
        Thu, 06 Jun 2024 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx5FHfbmCVrZnzP5RH2OsZ/UgbANNHRFGgh64ntvVLDLJiWa5M5s21+OcBXx3ux62OTfutvdG9UWDZQFe7x5g=
X-Received: by 2002:a17:90b:19d5:b0:2c2:29a2:9b08 with SMTP id
 98e67ed59e1d1-2c27db68d96mr4631184a91.40.1717660622618; Thu, 06 Jun 2024
 00:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com> <20240606020248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240606020248-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Jun 2024 15:56:50 +0800
Message-ID: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> > > If the codes of orphan mode don't have an impact when you enable
> > > napi_tx mode, please keep it if you can.
> >
> > For example, it complicates BQL implementation.
> >
> > Thanks
>
> I very much doubt sending interrupts to a VM can
> *on all benchmarks* compete with not sending interrupts.

It should not differ too much from the physical NIC. We can have one
more round of benchmarks to see the difference.

But if NAPI mode needs to win all of the benchmarks in order to get
rid of orphan, that would be very difficult. Considering various bugs
will be fixed by dropping skb_orphan(), it would be sufficient if most
of the benchmark doesn't show obvious differences.

Looking at git history, there're commits that removes skb_orphan(), for exa=
mple:

commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 28 07:53:26 2012 +0000

    mlx4: dont orphan skbs in mlx4_en_xmit()

    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
    completions) we no longer need to orphan skbs in mlx4_en_xmit()
    since skb wont stay a long time in TX ring before their release.

    Orphaning skbs in ndo_start_xmit() should be avoided as much as
    possible, since it breaks TCP Small Queue or other flow control
    mechanisms (per socket limits)

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
    Cc: Or Gerlitz <ogerlitz@mellanox.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

>
> So yea, it's great if napi and hardware are advanced enough
> that the default can be changed, since this way virtio
> is closer to a regular nic and more or standard
> infrastructure can be used.
>
> But dropping it will go against *no breaking userspace* rule.
> Complicated? Tough.

I don't know what kind of userspace is broken by this. Or why it is
not broken since the day we enable NAPI mode by default.

Thanks

>
> --
> MST
>


