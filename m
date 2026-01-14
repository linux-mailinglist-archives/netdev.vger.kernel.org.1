Return-Path: <netdev+bounces-249722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF0D1CA6B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55D343020FD0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330836C0AA;
	Wed, 14 Jan 2026 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNXONgZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49C36C0CD
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371510; cv=none; b=ILHADMyzjzr72zE5OET/KyeE/PkI2CH/LA8TNtb9I3cwmoKrDIzXYmC8RgdW3WGa7pI+bZ3tNUR4qscnwiixqStmKDRtyCuP1rwaTkKMoxVGWwQYBV92t4G8fxM6rwH6pA+i5C9lRMXsaGTBWtIhAKlTqFCJUy7HT9HDWrmaxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371510; c=relaxed/simple;
	bh=clNpslq5ijBOI5A2tm/usi5tDYC+ESDLpBpGDtp4m8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfAkmMqEDAUEFY6oKtdPeI9KWZ/hmZEQCcWqxqadSPUQeW7k8NlHOq+Q85ppu7ehvvuHueDtG28OnotRThMFGAgkv18iZ15tVwIBjFxJHubJrCq0T7O843cshK8aKZWq6lSjn+wIgzqI4EfvGAoQ3e01kZGHrO8TgFThIx6vULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFNXONgZ; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12339e2e2c1so7101c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768371504; x=1768976304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjBxkaqSZJtmI8IUKVCM6gYETHbHEi7hreoNNxicvxw=;
        b=NFNXONgZ0yhzB88pTvIvsf58llypwEtxB0nhrmw80pljJXOCxBKjYymN61AWiE1u9b
         V6TfBw2An14TnlJAd1gMiDc8DGhwIJc5mOF5sd3gW2JlEZXUcjUGa0F81z8+i7uFXa1d
         cD/TVncOL0IH1RyEy0XjhHT7fTfuUW2LXoCaYh8qXysaeYdmRE0Z4+b23lztlqd336qK
         d5DngQZyA5FPus5b+dd3gyXdJT+9gKdOb/AEpqJienzxW/uTixzx1YhTuFWEUwjpw13A
         nutC/J453joz7rPoF4qQb7wsn72+zLPy5z8Nb4nLhCmqu+olZxa+h/8K3v8XLrDSuQq0
         /g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768371504; x=1768976304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjBxkaqSZJtmI8IUKVCM6gYETHbHEi7hreoNNxicvxw=;
        b=weG6ewA8QMAGMknrKlu0yydZRMdxRzZ4382jQU3MhJtud1iPiUOQzUGCsxirBL3RIP
         mWBDtiLdWWPRWx9rU+fEg/uEJbtoOGWBFETvUMcECHNUShgZhDx2dbTpuWRI+NPHSjWT
         +gAXhMsJbWZdLs1c0JuI8CPCSx8/SkxW3etWemd/MOaRsKnnFd5fn/YkKOaIBIgJiGnO
         JmoJWU04NfujH35vpVubzMazvdnaka6Go6EejAlgyrF7swAH++6ZG14ANoDNEtkjtyDd
         7C50ZLCwXl9NQa0gzr3FZzq2WMhquGlbBsdu3S1k7iiZF6Zn1vwxHPhDEK3838jBkpF1
         s6ng==
X-Forwarded-Encrypted: i=1; AJvYcCUul8A8fPLWHLzXvqvgRiI7aIYPllFc/7Tr+UkDdYSFZHFyvSFEWI9xVRvZeUYVsjATQWP3UVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+UCXekpsW+AMHVBFYv74DNlqnDZBRLSXSMQ0TqrUiOkxDYGn
	VgZ+TKzOvi303xAnCGvQrNGtraerH0FCMLXfH21GubSoheUbGT4/XNDu7iio0hrOxbVv0G3Jctu
	jzK+N5czcVm7hBsBE6ELvuOP0HzZvev8=
X-Gm-Gg: AY/fxX4tsCDZ9jEVkYzEbK/u7YNHeyuHfIee6ktqsHnVLATk7UOEutCoEsyUqzF0Ifu
	dMN11FWM6XFohtPm/9oxr+xZcfYtmsg/F3JfvWkXQ5RWFhpw9+7sEgE/mBWoBdTQliTJBcmhUvM
	oPzZQrD7KhfEUdVCXyfMCBcQhdfMnQS2flUPq4L6QHvs+qLGKOUVBU6wIzmiS/u4Lg7+kiuyi6s
	iuXNFPCGCuHfLCzISNZZdGaul/bMPHt3i2zQRiPWVopGazKspEG7jAjjuWHGLaTQXzPa1Rz3RQu
	G1vzPrE=
X-Received: by 2002:a05:701b:231a:b0:11b:9386:a383 with SMTP id
 a92af1059eb24-12336aafea9mr1292835c88.22.1768371504531; Tue, 13 Jan 2026
 22:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114045509.1281217-1-saiaunghlyanhtet2003@gmail.com> <17dcbb5af344c64488806ab2e291d4d7a0de3c51b8d9b0478bb1f0106a584530@mail.kernel.org>
In-Reply-To: <17dcbb5af344c64488806ab2e291d4d7a0de3c51b8d9b0478bb1f0106a584530@mail.kernel.org>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 15:18:13 +0900
X-Gm-Features: AZwV_Qi8wCT_ok_yzffNsUzGGwwG4eOcdtdj552inJPzrpEf3gLKyb96CVsFhLo
Message-ID: <CAGF5Uf5tRdt0Bpky+53AursJNAj1Q6-+0jkm2SQxxK-eAv=Nzw@mail.gmail.com>
Subject: Re: [bpf-next,v2] bpf: cpumap: report queue_index to xdp_rxq_info
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, netdev@vger.kernel.org, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That makes sense. Reverted the changes in veth.c in v3.

On Wed, Jan 14, 2026 at 2:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 14e6f2a2fb77..4a409802cdac 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -648,6 +648,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct ve=
th_rq *rq,
> >
> >               xdp_convert_frame_to_buff(frame, xdp);
> >               xdp->rxq =3D &rq->xdp_rxq;
> > +             /* Preserve original queue_index from frame */
> > +             rq->xdp_rxq.queue_index =3D frame->queue_index;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
>
> Unlike cpumap.c and devmap.c which use a stack-local rxq variable,
> this writes to the persistent rq->xdp_rxq structure.
>
> In veth_poll(), the code reads queue_index before calling veth_xdp_rcv():
>
>     int queue_idx =3D rq->xdp_rxq.queue_index;
>     ...
>     peer_txq =3D peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NU=
LL;
>     ...
>     done =3D veth_xdp_rcv(rq, budget, &bq, &stats);
>
> After processing a frame from a device with many queues (e.g. queue 32),
> the next poll will read the corrupted queue_index and pass it to
> netdev_get_tx_queue(). If the peer device has fewer TX queues, this
> causes an out-of-bounds access to dev->_tx[].
>
> For comparison, cpumap.c uses a local variable:
>
>     struct xdp_rxq_info rxq =3D {};
>     ...
>     rxq.queue_index =3D xdpf->queue_index;
>
> Should veth also use a local rxq variable like cpumap and devmap do,
> rather than modifying the persistent rq->xdp_rxq?
>
> > [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/209830=
17884

