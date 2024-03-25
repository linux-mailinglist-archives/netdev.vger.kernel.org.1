Return-Path: <netdev+bounces-81518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21A88A118
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A71F354B0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25347171E61;
	Mon, 25 Mar 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWXHxH55"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543917D241
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350410; cv=none; b=kLoqaPzUUKZU2bZ8YApp+rui1CBPh+CoOmyg1iEA1laHff5OCRH+gnvnpys30C1+R12Sn13mBTp/SRFjLoij9hbCftcjuK8eKR97V9fi7k//Lb1HafYTcroA3Jfcgwr42dUkf+eClHdNvOlFICFx64dMAFXvB3Y+gTxqxF3wY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350410; c=relaxed/simple;
	bh=4+T6Fw5kJ5qTnZFBUHaK+QAVtrjjtAgBCLgSidabXqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBfbdccHpDAc91HdfbjCNg9D+YTfM291mV9QdcJX3BV0sChMFJPH0EsbM706Kgkw4vhziO/MAUZmrA6Pboi1dyINNB65dqmy2dNMzj/k9xvKtXJV+cWhTGohncBL2grB8r5udoc7BAnPHkyO7mgBkECPOSVQt9V8ISoAfyUcZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWXHxH55; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711350407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51pQDyFxYaSVn69uXtRlpc0U/V2gUslEK629TuIAH7k=;
	b=gWXHxH55OHn6ESU7xh4OCL3XhI/IStRwqqyzIlNe5YPaWOu/duajKczaYPnNDvtht4ryfw
	YCRsqfof1efBXyYAPp0AgGQZqKTGPI4Y3aewrRX8w7lBWaDHEpT/R6MFXZ7PVF27gutgEn
	NqXjdawPscgx3wQiu9pk6F028fFMJPw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-iFiHMB9gPJC6QHuW82lsVA-1; Mon, 25 Mar 2024 03:06:46 -0400
X-MC-Unique: iFiHMB9gPJC6QHuW82lsVA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8dc8f906aso1838215a12.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 00:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350403; x=1711955203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51pQDyFxYaSVn69uXtRlpc0U/V2gUslEK629TuIAH7k=;
        b=WS+am99aNR7znWPVssZwSJ6Bvgmo7+/w7xJ44Nx9SJTsRVs2DKA8XuZHJu4hqmT1l0
         HZiMsrUZn/SdsoBqj6I1OGWVRQcpQeLZ4p8OV5idPqa2Cjh1ndD/xwLfV2gQKGDOBjX9
         NcYTFO3S3RiGx2vTsbXpPByZQ0TE6yaTs5llbayLsT8w82iLk/pIrsEMNfKxWWk9YODf
         zB0mE4Zp1AbN3TAFWbi2VWro0rLjvfwoVG1QVyRkCKf4T4DRe8wSOElnp+yJR8VT7c4L
         byuKZnXYyVfH46rtlpSldoPVnIn1VO7GxphbQ+3wrgpODW6Ofuujy48KKNx38hGxklBL
         8iXg==
X-Gm-Message-State: AOJu0Yy7MVXej0InYaVMRsMfxY/zg3ZLfVsx8Nv/Vgd4uBiph6EVD3uv
	cFAXKxzFPB8EYLHxzHFfm3pNYL5T2umLx9Kz19C9s9nxdisoFH9zA0FNxK0qfsj+agQBu/0LUgo
	wlUsfcs/OctPnYKEVwZwuFCdbwDhs+1LIDwv9rJC8hBsetugsBVLaTmS0pkSvf/U9YgEnT3OKLm
	YtAVvI5AEUWxgStn4bx6sPf6fzoT/J
X-Received: by 2002:a05:6a21:a598:b0:1a3:af03:6b0 with SMTP id gd24-20020a056a21a59800b001a3af0306b0mr6698295pzc.7.1711350403210;
        Mon, 25 Mar 2024 00:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFt9XnVzAoDIuJWXHyslSXREhmiNfJ/P4OyG0+MvlUUa2SquZgoSA0VrhWpgpDf9mkq3QLzLWYQuBbJcNzJYw=
X-Received: by 2002:a05:6a21:a598:b0:1a3:af03:6b0 with SMTP id
 gd24-20020a056a21a59800b001a3af0306b0mr6698280pzc.7.1711350402928; Mon, 25
 Mar 2024 00:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
 <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com> <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
 <8f1a722e-a16d-4c17-a5bd-face60b4cf4d@linux.alibaba.com>
In-Reply-To: <8f1a722e-a16d-4c17-a5bd-face60b4cf4d@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 15:06:31 +0800
Message-ID: <CACGkMEs0K1YE3vBYht4LTsuF8_RUvZ0ZtBB3DUDQyujsB08JjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:58=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=882:29, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 10:11=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:17, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>> When the dim worker is scheduled, if it fails to acquire the lock,
> >>>> dim may not be able to return to the working state later.
> >>>>
> >>>> For example, the following single queue scenario:
> >>>>     1. The dim worker of rxq0 is scheduled, and the dim status is
> >>>>        changed to DIM_APPLY_NEW_PROFILE;
> >>>>     2. The ethtool command is holding rtnl lock;
> >>>>     3. Since the rtnl lock is already held, virtnet_rx_dim_work fail=
s
> >>>>        to acquire the lock and exits;
> >>>>
> >>>> Then, even if net_dim is invoked again, it cannot work because the
> >>>> state is not restored to DIM_START_MEASURE.
> >>>>
> >>>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> >>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>> ---
> >>>>    drivers/net/virtio_net.c | 4 +++-
> >>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>> index c22d111..0ebe322 100644
> >>>> --- a/drivers/net/virtio_net.c
> >>>> +++ b/drivers/net/virtio_net.c
> >>>> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_s=
truct *work)
> >>>>           struct dim_cq_moder update_moder;
> >>>>           int i, qnum, err;
> >>>>
> >>>> -       if (!rtnl_trylock())
> >>>> +       if (!rtnl_trylock()) {
> >>>> +               schedule_work(&dim->work);
> >>>>                   return;
> >>>> +       }
> >>> Patch looks fine but I wonder if a delayed schedule is better.
> >> The work in net_dim() core layer uses non-delayed-work, and the two
> >> cannot be mixed.
> > Well, I think we need first to figure out if delayed work is better her=
e.
>
> I tested a VM with 16 NICs, 128 queues per NIC (2kq total). With dim
> enabled on all queues,
> there are many opportunities for contention for rtnl lock, and this
> patch introduces no visible hotspots.
> The dim performance is also stable. So I think there doesn't seem to be
> a strong motivation right now.

That's fine, let's add them to the changelog.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
> Heng
>
> >
> > Switching to use delayed work for dim seems not hard anyhow.
> >
> > Thanks
> >
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
> >>>
> >>>>           /* Each rxq's work is queued by "net_dim()->schedule_work(=
)"
> >>>>            * in response to NAPI traffic changes. Note that dim->pro=
file_ix
> >>>> --
> >>>> 1.8.3.1
> >>>>
>


