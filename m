Return-Path: <netdev+bounces-103272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90CB9075AD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A5285D01
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1C1487E1;
	Thu, 13 Jun 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsOcnnsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87229148301
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290139; cv=none; b=U8BlAdmHdbDRoPVOf9Rbb5gf4i2b5qV/5lellSvs0L1mcWk7Kg/J00U6CA3dsxwY1LKGxpXQ7UBpiJY02sPafDwiwf9aLwZfB0oNhW8ir8gRe6UVYk532FeY59+vyc0PbNOyncfVD4w7K+6UU2mNcy5rZ82M8u8kFPvXYXMJKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290139; c=relaxed/simple;
	bh=/jBa3gOS6JfiiZ0aZaySo6GxWT6uAm9HmhsYcceSfKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKT8MPVlncJ7NWFkLCVZBVAtl6KbxkSNJWkUvPof4MUnk0bR/M2qmagfn3/E8XX9sToqbAceDJHepELPT7yuQKiABo9j4CQF/yVMHVhm1PGms4lw2Ltqd5+sBBMcCCDYpADxKFyyamWw7f77UpD92NmVSnva76TdGNTf2jUhpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsOcnnsk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso11304121fa.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718290136; x=1718894936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jBa3gOS6JfiiZ0aZaySo6GxWT6uAm9HmhsYcceSfKU=;
        b=CsOcnnskyzUaauTk1pZSO6KbowoI6R2qeGYE+Wqs7PN4GXxpWoZ2AyxUZqC0SDJ77y
         ruWyMWeDMa+omtm07SMA2ln2eiYoYBldU+RN5xjeijnkaPCf8PyglqR84oFQL7gnqlpR
         PFbJsqCk9cxCzfYMeDeb89mbOTCVsz3Qebzr8pFjZS1viVyQr928TUlspRkrDh+X9XIG
         nukhZpjl9/ZOJYBVSAotMOs03Ze7CkjgcEv/BENJI8+5+h57DU/EthzCT0MlDWZ2aHk+
         O4ZhrLZAbYcstFPAd8FuxEOaUhUFF8Bp9+P25ZYFfnBfjbMWPUlEPBuykeH5O9M4QFEV
         oy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290136; x=1718894936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jBa3gOS6JfiiZ0aZaySo6GxWT6uAm9HmhsYcceSfKU=;
        b=lt5VyLDe0sZHW0cXjvQHwViCVl4JmE0es4tGNrjP7xBnAKJuWCUyP4jZkBQYbORGhm
         wS6gUlkbRPNROYd9hAqN8s0cz7mHjxCsaXUF8wAoJIPBgu7ceprrSRPpMHBVAOPh27SE
         T23bV2/lt9iDSewN9eGdgdkkzTjWB1ljcRptpBHn18k2pY2+fxsdal7o+2aqJF/esq1B
         K9ly26iVfVpm5eEVps/dPOsTz8eLEWTdNUQAqg0UKHhxlpbuFk+wYaCW5nSJ0MSH4luv
         2Tz6IBo4Uy0KfblrvwIRruSvo/6YxTt0OGN38ZMDqc+N9nWY0d1nnD4VN//znTbJZzCF
         dgTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaXh8jaP1nOlG9H4WwvzIfOkAF8YuIc3F5jXHIXFOU57ViqnUgiBPwFYnCtCvblFr213Sk32KqZp3VgYAJ471mPPVwBzNC
X-Gm-Message-State: AOJu0YwuNgLEreodY1yta9UXnlJdBakP5Atcy4VVZZXNMGo4/cf/2zJW
	S99wDFEcnx6rqXv4pmHPa0A4v9C3UR9b/7b8jnE80gHoUa2ScwBUs96omy9C6dP1spBZ3wzZslM
	KLoXkJbRJNrViM+O+3jZHoVD0e8oT8g==
X-Google-Smtp-Source: AGHT+IFBvLlrePbP3uAp2keCQjdzxMQkjTd9kidPRRSwNLzEMg4lEQz9UraW6vDpKu4YKqLLJp8z9UU1tFebTj66XJk=
X-Received: by 2002:a2e:9e44:0:b0:2eb:e505:ebdb with SMTP id
 38308e7fff4ca-2ec0e5b5211mr269171fa.10.1718290135282; Thu, 13 Jun 2024
 07:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion> <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion> <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion> <20240613035148-mutt-send-email-mst@kernel.org>
 <CAL+tcoDZ_8e9SDRdbQSDz=TCRGQ3w0toSZ0U8poUKpQcAHhN7A@mail.gmail.com>
 <ZmrxdwR2srw11Blo@nanopsycho.orion> <CAL+tcoBu0mCDeDTdEYZ5ccboYOuFeBfbNYvefo2dOWgoxAPg+Q@mail.gmail.com>
 <ZmsDfS24IJAWAmvK@nanopsycho.orion>
In-Reply-To: <ZmsDfS24IJAWAmvK@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 22:48:17 +0800
Message-ID: <CAL+tcoDk8_dvEmMLRdOQUH_Pj6dGz8qg72zXnU+Yiww-QJdryw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:34=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Jun 13, 2024 at 04:11:12PM CEST, kerneljasonxing@gmail.com wrote:
> >On Thu, Jun 13, 2024 at 9:17=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Jun 13, 2024 at 11:26:05AM CEST, kerneljasonxing@gmail.com wrote:
> >> >On Thu, Jun 13, 2024 at 3:56=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> >> >>
> >> >> On Thu, Jun 13, 2024 at 09:51:00AM +0200, Jiri Pirko wrote:
> >> >> > Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com w=
rote:
> >> >> > >On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnull=
i.us> wrote:
> >> >> > >>
> >> >> > >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.co=
m wrote:
> >> >> > >> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resn=
ulli.us> wrote:
> >> >> > >> >>
> >> >> > >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail=
.com wrote:
> >> >> > >> >> >From: Jason Xing <kernelxing@tencent.com>
> >> >> > >> >> >
> >> >> > >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sys=
fs for non
> >> >> > >> >> >BQL device") limits the non-BQL driver not creating byte_q=
ueue_limits
> >> >> > >> >> >directory, I found there is one exception, namely, virtio-=
net driver,
> >> >> > >> >> >which should also be limited in netdev_uses_bql(). Let me =
give it a
> >> >> > >> >> >try first.
> >> >> > >> >> >
> >> >> > >> >> >I decided to introduce a NO_BQL bit because:
> >> >> > >> >> >1) it can help us limit virtio-net driver for now.
> >> >> > >> >> >2) if we found another non-BQL driver, we can take it into=
 account.
> >> >> > >> >> >3) we can replace all the driver meeting those two stateme=
nts in
> >> >> > >> >> >netdev_uses_bql() in future.
> >> >> > >> >> >
> >> >> > >> >> >For now, I would like to make the first step to use this n=
ew bit for dqs
> >> >> > >> >> >use instead of replacing/applying all the non-BQL drivers =
in one go.
> >> >> > >> >> >
> >> >> > >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think=
, we can add
> >> >> > >> >> >new non-BQL drivers as soon as we find one.
> >> >> > >> >> >
> >> >> > >> >> >After this patch, there is no byte_queue_limits directory =
in virtio-net
> >> >> > >> >> >driver.
> >> >> > >> >>
> >> >> > >> >> Please note following patch is currently trying to push bql=
 support for
> >> >> > >> >> virtio_net:
> >> >> > >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jir=
i@resnulli.us/
> >> >> > >> >
> >> >> > >> >I saw this one this morning and I'm reviewing/testing it.
> >> >> > >> >
> >> >> > >> >>
> >> >> > >> >> When that is merged, this patch is not needed. Could we wai=
t?
> >> >> > >> >
> >> >> > >> >Please note this patch is not only written for virtio_net dri=
ver.
> >> >> > >> >Virtio_net driver is one of possible cases.
> >> >> > >>
> >> >> > >> Yeah, but without virtio_net, there will be no users. What's t=
he point
> >> >> > >> of having that in code? I mean, in general, no-user kernel cod=
e gets
> >> >> > >> removed.
> >> >> > >
> >> >> > >Are you sure netdev_uses_bql() can limit all the non-bql drivers=
 with
> >> >> > >those two checks? I haven't investigated this part.
> >> >> >
> >> >> > Nope. What I say is, if there are other users, let's find them an=
d let
> >> >> > them use what you are introducing here. Otherwise don't add unuse=
d code.
> >> >>
> >> >>
> >> >> Additionally, it looks like virtio is going to become a
> >> >> "sometimes BQL sometimes no-BQL" driver, so what's the plan -
> >> >> to set/clear the flag accordingly then? What kind of locking
> >> >> will be needed?
> >> >
> >> >Could we consider the default mode is BQL, so we can remove that new
> >> >IFF_NO_BQL flag? If it's hard to take care of these two situations, I
> >> >think we could follow this suggestion from Jakub: "netdev_uses_bql()
> >> >is best effort". What do you think?
> >>
> >> Make sense.
> >>
> >> Also, note that virtio_net bql utilization is going to be not only
> >> dynamically configured, but also per-queue. It would be hard to expose
> >> that over one device flag :)
> >
> >At that time, I would let virtio_net driver go, that is to say, I
> >wouldn't take it into consideration in netdev_uses_bql() since it's
> >too complicated.
> >
> >BTW, hope to see your per-queue configured feature patchset soon :)
>
> It's done already. See virtnet_set_per_queue_coalesce()
> if ec->tx_max_coalesced_frames is 0, napi_weight is set to 0 and napi
> orphan mode is used.

Oh right, I missed that... Thanks for reminding me.

