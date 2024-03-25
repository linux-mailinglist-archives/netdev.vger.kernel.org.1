Return-Path: <netdev+bounces-81515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5488A0D5
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BB01C36C16
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD105B1E8;
	Mon, 25 Mar 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw5cg6to"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B1156F21
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348185; cv=none; b=XgyJT2Mip+BQlte8Wj8icWxVjxuco6KpAl+FPiuH7EZK3XOHVfTMTxbKyV9Se3t5CMAPLG/IP/XvHP6CM2qpEKKNdLwl1/wrkDM/f7ebAev4O4U1BcRIyZzcTsgAZGah11DfkhTBmXvXsuWBd4MB+McVN0oA7atltHttm2nwtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348185; c=relaxed/simple;
	bh=kZZ3nRF+Zxf6lGkAZahLRBxEqX9+XhF3TpFGqRFvXpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8za6w8TpymTA3nE3sZqGfdjEdXutmPGVdDvMkchAeM5gp7JoEiBFfUV2BCDVTznTm0sk/ifzOKsn0PBugdtXYYkV2cHay/eWQBz2T0MIRSj2r7tonUPxcxuMT0Xc0FpbiEz58xRKs2lUbVSoAU3llJ0N5lQy91C8ZlZY5vrst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw5cg6to; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711348183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmUXm4ncHueirLlVukeTUtsWlGWpKrR/EAFJ17idPmI=;
	b=Sw5cg6to3YTo4F2u2uXsORe6dHdxDaGfUI4+dKlBnimYqlbeBpRBGIvBDb1/PidRuA3HWw
	+bIJuTH/4EYXwF+woCPiF4LsuSWbST56tKHXrbMoMpDnNR0zVmKT12LwEYuuTh5TiBsx9m
	Wgf+Y6j47h5o2d2DWeKfJfkzuCvnCX4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-h7JwY7ppPy-bt5MoiIgtUw-1; Mon, 25 Mar 2024 02:29:39 -0400
X-MC-Unique: h7JwY7ppPy-bt5MoiIgtUw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e0ac20241aso7771435ad.2
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 23:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348176; x=1711952976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmUXm4ncHueirLlVukeTUtsWlGWpKrR/EAFJ17idPmI=;
        b=nZT5h4u+xLRBpIdWVIMg+jFjCul0VtnzXtKHiKu7yypToxPFG95H17/kFT4QHkB9qu
         p0oz0GcNq+I7ZLS/y7Px7KaSB+1C5k0Tgey8eMr7eJREX6UpTCZEuTXjiM9UeqEpAADQ
         ll12ADeRyWWUPbnRfYPZpcVETv/2VRUimXUF9PLF5+zBjxUHzqRSJl+4oJMqZ/koh0CC
         c4Ke9gyfdtOkFs4AsZ0nlaip7mzc467e8+7BuayQSUr+EkXtQEpVouZExomjC5sPL/Jh
         R/HjlOXRD0cKM0rBHDEp7xEvXEBcWGR4M+pqvGeXh6Y7ia0kKPtqlgQ6WZI9kIW2JYwr
         +htQ==
X-Gm-Message-State: AOJu0YxzqBkGK9TTXop4Z26csJv8UA3J5Aq0EXGfotOzKwF+22T4/RNA
	ywg3ZHuNh0l/Z5nOHNkSeewnKaj+XxYGL+eY2Z6csqDEmaT4eQI1TJKu9mF7bOvYuxfT5ROKal8
	argu+jXwuAp67wJ7sIUzstCdASPva8KhKVmQgv1kiuAiaFFXx6k2aeVnlOyWjjaR3aRnrA4vDFP
	0CrixlhxeTulCF8Axd9ZAOdla3bloCVq2PllxY
X-Received: by 2002:a17:902:eb8d:b0:1dd:d0b0:ca86 with SMTP id q13-20020a170902eb8d00b001ddd0b0ca86mr6902506plg.59.1711348176384;
        Sun, 24 Mar 2024 23:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qsTTLgML0tM8VWrcjTYz0S0YxyaeiYmoln0LfAi4uQ85q+QaIwg8B27H/hFotSkBi4HB7q9ALjDSXiUzUsw=
X-Received: by 2002:a17:902:eb8d:b0:1dd:d0b0:ca86 with SMTP id
 q13-20020a170902eb8d00b001ddd0b0ca86mr6902495plg.59.1711348176086; Sun, 24
 Mar 2024 23:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com> <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
In-Reply-To: <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 14:29:24 +0800
Message-ID: <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:11=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:17, Jason Wang =E5=86=99=E9=81=93=
:
> > On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> When the dim worker is scheduled, if it fails to acquire the lock,
> >> dim may not be able to return to the working state later.
> >>
> >> For example, the following single queue scenario:
> >>    1. The dim worker of rxq0 is scheduled, and the dim status is
> >>       changed to DIM_APPLY_NEW_PROFILE;
> >>    2. The ethtool command is holding rtnl lock;
> >>    3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
> >>       to acquire the lock and exits;
> >>
> >> Then, even if net_dim is invoked again, it cannot work because the
> >> state is not restored to DIM_START_MEASURE.
> >>
> >> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >> ---
> >>   drivers/net/virtio_net.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index c22d111..0ebe322 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_str=
uct *work)
> >>          struct dim_cq_moder update_moder;
> >>          int i, qnum, err;
> >>
> >> -       if (!rtnl_trylock())
> >> +       if (!rtnl_trylock()) {
> >> +               schedule_work(&dim->work);
> >>                  return;
> >> +       }
> > Patch looks fine but I wonder if a delayed schedule is better.
>
> The work in net_dim() core layer uses non-delayed-work, and the two
> cannot be mixed.

Well, I think we need first to figure out if delayed work is better here.

Switching to use delayed work for dim seems not hard anyhow.

Thanks

>
> Thanks,
> Heng
>
> >
> > Thanks
> >
> >>          /* Each rxq's work is queued by "net_dim()->schedule_work()"
> >>           * in response to NAPI traffic changes. Note that dim->profil=
e_ix
> >> --
> >> 1.8.3.1
> >>
>


