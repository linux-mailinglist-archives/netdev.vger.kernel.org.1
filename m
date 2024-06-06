Return-Path: <netdev+bounces-101241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150AE8FDD07
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2250C1C21CF1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B31CAA9;
	Thu,  6 Jun 2024 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geXN0IMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADE1B977
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642771; cv=none; b=qOegfMqfL5Y0qiel45PbMDjzl+04UsZx7/fB6jC106la6j3YJueTHTsu1qouCFxlEkZyVaJkrsS+50eKtJUKa5KA3ethc+npFnRudmrul4nDfS4s47u8RAVdNPJLCkZ0q5I9F9G3rcpPkkK1r159DFjpo/G4aLvU+6c1vurzI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642771; c=relaxed/simple;
	bh=s2KfiyndYiklIOGoHKxqXaBBH7eoyfFU1N5uIP+rMBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipj3zOhd2TkGbgiSsmKLufuejsRl153kMTdb1apPufLJgs27zz/IJ081qu1I/IUyo2l9II9xUFx7O9JEvUFlkGrKrr65tkChlShhHA8CAAeFN3fIv/EIfdDKQZ3hckRS0ATPO/j9Lv+hdw4sGn1ZudiMqHLNae3UNe1wWk9TyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geXN0IMc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b90038cf7so769326e87.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717642768; x=1718247568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlnHDS/XNGa9AMBkTV5bW3wG31YnJTczp1fJ77rTjqU=;
        b=geXN0IMcf7XBuGmIpjn9fLewQCNmixJaPeabXwa7aRUoApNCbY2lQEgrWN7ozSRqd1
         DwMuG3slm7CVPgPorhNT6eBZHIlLIpKLhh2+JL6wQ/acej9m8SORwm3yMcOsoSCYFPzR
         LYsX9f4SwH6AL//qZbtommwTi6ZLqrt2Gem2bVlpt3i9SmdLPQ2wgaLUlfDvGhpQ6e/Q
         jPt5cs5YmFqlxmfVaevAti0zTnCjLjpJszyUexEk3F+lXp5skAkeJCoYLKWfVdHvwB2b
         OQ82CbjE451PA0EQP0KW8KB790UXDb2tSOMTmK2rx6ghf3pZMcq0VfhrJ5Gs0BdrmBcF
         2cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717642768; x=1718247568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlnHDS/XNGa9AMBkTV5bW3wG31YnJTczp1fJ77rTjqU=;
        b=LtmW/cRAUJaRoedPd6KVGz+mTReERHZcfIfULMwsMPwub0sEOKVbYu95h9l4DMR9P0
         lWSwTcuu9ot7Z2rcWOrJFu9GBMRJkwmBfri9QgDUjUM/e8wuLYzyz8eEewaegALNnIDa
         m5gA9bhXefOh8Jcsw58Ob95SotgysE+ESos9sSvl6PdgqVU6O7gfmyoa/P8sEp8ubwk4
         CDOw65OyEQ1UUB7wihelrUQgJiG7oI0/MQbo8axt3v4OYdm2Xje5E2QHCnriotKP96jz
         4mXSwHqZikMKaOWYgqLmEUGZfHsHbaopl/CTGT13r4lES8n7KSNeHSsGc7U4bAKW0Chw
         EjFg==
X-Forwarded-Encrypted: i=1; AJvYcCWT/qAywWV30S2t01ax9k9rSNJ93Zlkb4G6aFdPc9JaJw5vACTjmz/3SCgqKhP9zqd24fhVkkMXNEBjmudlQapLfZDJ3oCR
X-Gm-Message-State: AOJu0Yyb2Gp1VfV/XlRLkBVNGJiwBPSsnwnQ6fSMGWaA68WrwzuwQjEA
	x/mfZMhcMELkbjRbj3ONhjbh36DyE5qjmK46WowdKMOtq+Ci2K4uXNlBJSd44dTXnn667CZZdGF
	Lm36ocYAljo5bK2FS0GUrOMp/Mfs=
X-Google-Smtp-Source: AGHT+IGkWq+CDSvTuEjGnIKNxqb7J4KvCuCOKeCb3i/QnbE971KgYpkxmz5M2tqA5rrRM+AlmV1lYyXSHAs/Dubt/LA=
X-Received: by 2002:a05:6512:3e07:b0:51b:e0f0:e4f8 with SMTP id
 2adb3069b0e04-52bab4cef34mr2688913e87.31.1717642767691; Wed, 05 Jun 2024
 19:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
In-Reply-To: <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Jun 2024 10:58:49 +0800
Message-ID: <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,

On Thu, Jun 6, 2024 at 8:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
> >
> > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote=
:
> > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> w=
rote:
> > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > > >>>
> > > >>> Add support for Byte Queue Limits (BQL).
> > > >>
> > > >>Historically both Jason and Michael have attempted to support BQL
> > > >>for virtio-net, for example:
> > > >>
> > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3=
@redhat.com/
> > > >>
> > > >>These discussions focus primarily on:
> > > >>
> > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical =
information
> > > >>needs to rely on the judgment of use_napi. When the napi mode is sw=
itched to
> > > >>orphan, some statistical information will be lost, resulting in tem=
porary
> > > >>inaccuracy in BQL.
> > > >>
> > > >>2. If tx dim is supported, orphan mode may be removed and tx irq wi=
ll be more
> > > >>reasonable. This provides good support for BQL.
> > > >
> > > >But when the device does not support dim, the orphan mode is still
> > > >needed, isn't it?
> > >
> > > Heng, is my assuption correct here? Thanks!
> > >
> >
> > Maybe, according to our cloud data, napi_tx=3Don works better than orph=
an mode in
> > most scenarios. Although orphan mode performs better in specific benckm=
ark,
>
> For example pktgen (I meant even if the orphan mode can break pktgen,
> it can finish when there's a new packet that needs to be sent after
> pktgen is completed).
>
> > perf of napi_tx can be enhanced through tx dim. Then, there is no reaso=
n not to
> > support dim for devices that want the best performance.
>
> Ideally, if we can drop orphan mode, everything would be simplified.

Please please don't do this. Orphan mode still has its merits. In some
cases which can hardly be reproduced in production, we still choose to
turn off the napi_tx mode because the delay of freeing a skb could
cause lower performance in the tx path, which is, I know, surely
designed on purpose.

If the codes of orphan mode don't have an impact when you enable
napi_tx mode, please keep it if you can.

Thank you.

