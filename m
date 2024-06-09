Return-Path: <netdev+bounces-102140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A69018D5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 01:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87B280E97
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 23:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1034315F;
	Sun,  9 Jun 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNTVvElf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA71CF9B
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717977397; cv=none; b=pCijxWtS2yubfIpMuOpCX5niWQOLf9D3GthXIn7fbLJ99yx58S0B6Bw3AEDDzPQxMwni8hOQ57bF7XVbuiI+AYetNCVMkG2P19/Lv64z6aJ23rZq5bU0XYmeUEndgUZuKYc1z33n5RmkvwG8meJQr1wmvnaTKO2Aybn4SUd0U3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717977397; c=relaxed/simple;
	bh=ugWYcF5Kg7oqw5DUPG+7t2fDNzZecP8X/AUzjpkQYsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE4XaEc0Q815aieml2O35/qW51kHTBGxTvStcoIHcJ98MK51wKWs+Ted1Rnackx0RnlaULuDduNUvvlo2dDZdhtIaGn94nE/Aj1Pz4TGBqL4yVLR8v6W9GgCNvr1+na+ZcPXhZw5Wvw/jNvI7blDCbI0K869MRrXd8bJ5LVzhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNTVvElf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1cb7a40fso809319f8f.0
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 16:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717977394; x=1718582194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugWYcF5Kg7oqw5DUPG+7t2fDNzZecP8X/AUzjpkQYsk=;
        b=dNTVvElforop1dZEmCcyQDanUOkp+q9Qi+b6TNiV3YzE/KtU1xXZhy9aXJIyBto4Fy
         aPSO2HPBAAqMRN5DLJuOh3FxJA0CAgGerPZIacwld4Y0e3Dkz2AjveQesJ/SjO+zpEhu
         KGqZLesG9RvkgylSgk/lWdC4LgNTwPcaOdO++2Q93JqP3/YAFuQAHs3V1ZwKrK33/xSx
         rT4U+f5B87h3N5upQWYEWa6Bq5KVzM4y59kRbGOrwniUJt4ZpWifJD/8OfAuP6HkL6Dk
         b/ZiF82pOsuPjxiImnH/hiaDWf2Mz/P4y59Ue9jpXO7yIDdHFx+RojO3k6w6z4+NQsps
         0MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717977394; x=1718582194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugWYcF5Kg7oqw5DUPG+7t2fDNzZecP8X/AUzjpkQYsk=;
        b=b/TJSyPBbu0B0tzclGzZz6lkYZXlJaRNBWNIYrP6F5CGueYyq1ncSRLJFr63/5/jyn
         UMvZo2CvUObPt3GnBPabtbIZ8Q9bKqyhJd+vwtvdA+ZWpU/hojVZ/Xc9SMVv71MLwyjB
         WWeq3PkiQhnP40FaMgnKvlmkM7Pu3aFMD3lcy4xW3i7LghA0Xp8F0JtHoJk0N2Ab1n6q
         x34tFwto6skzFCdGxZ6Wed818dGDsDVbLC45oLPDXu9/jK64tVev56UM5+JnNnlODr2V
         v+EsSmnJ2lEt6Pk7Va4E8UZ4wlCT5OGMpwJF3TPrGGQsdb+uAiKpI8mK3nZR9tFwH+Y/
         ETkA==
X-Forwarded-Encrypted: i=1; AJvYcCXgxto2bx9i8un5tCfSvaQT/gXKBAma71FTwJqP+fasBwldKR7/9hhGkgfDuFT7jS5pfZHJlUfIw9g7KVe21Q16DRHu8sQp
X-Gm-Message-State: AOJu0Yw3ox3RoKaLZ9e/RtsuoW3awaEt1wAeeMu33oylmwuB6GwzKt9M
	Phvcnb0xnaT5HpXK0SBGeCfAK+azPEAnFUA01sABoRAh8O9rHIRKhKIbRHe/M+eY/5gpwdLZTAk
	d6lwz0p0E06dEGOydvMVIUd1aR7s=
X-Google-Smtp-Source: AGHT+IEBrxih8fvuR9fAW/rVqtU4blOSQM8ck7JJe30iexzsgIVryM7RhfUfGrOKiFognmJkeV800TSZ39yUNMjoJzg=
X-Received: by 2002:a5d:5f8f:0:b0:354:ddba:303a with SMTP id
 ffacd0b85a97d-35efedd7dbfmr6247072f8f.54.1717977393536; Sun, 09 Jun 2024
 16:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609131732.73156-1-kerneljasonxing@gmail.com> <CANn89iK+UWubgdKYd3g7Q+UjibDqUD+Lv5kfmEpB+Rc0SxKT6w@mail.gmail.com>
In-Reply-To: <CANn89iK+UWubgdKYd3g7Q+UjibDqUD+Lv5kfmEpB+Rc0SxKT6w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Jun 2024 07:55:55 +0800
Message-ID: <CAL+tcoCGumdRKgd_1bQj1U_sNPsvYmsNOKwSWxazU0FwmeNTwA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device feature
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:42=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Jun 9, 2024 at 3:17=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> > BQL device") limits the non-BQL driver not creating byte_queue_limits
> > directory, I found there is one exception, namely, virtio-net driver,
> > which should also be limited in netdev_uses_bql().
> >
> > I decided to introduce a NO_BQL bit in device feature because
> > 1) it can help us limit virtio-net driver for now.
> > 2) if we found another non-BQL driver, we can take it into account.
> > 3) we can replace all the driver meeting those two statements in
> > netdev_uses_bql() in future.
> >
> > For now, I would like to make the first step to use this new bit for dq=
s
> > use instead of replacing/applying all the non-BQL drivers.
> >
> > After this patch, 1) there is no byte_queue_limits directory in virtio-=
net
> > driver. 2) running ethtool -k eth1 shows "no-bql: on [fixed]".
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> I do not think we want to consume a precious bit from dev->features
> for something like that.
>
> dev->features should be reserved for bits we used in the fast path, for i=
nstance
> netif_skb_features(). It is good to have free bits for future fast path u=
se.
>
> (I think Vladimir was trying to make some room, this was a discussion
> we had last year)

Thanks for your reminder. When I was trying to introduce one new bit,
I noticed an overflow warning when compiling.

>
> I do not see the reason to report to ethtool the 'nobql bit' :
> If a driver opts-out, then the bql sysfs files will not be there, user
> space can see the absence of the files.

The reason is that I just followed the comment to force myself to
report to ethtool. Now I see.

It seems not that easy to consider all the non-BQL drivers. Let me
think more about it.

Thanks,
Jason

