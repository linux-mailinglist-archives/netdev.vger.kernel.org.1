Return-Path: <netdev+bounces-103120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB81D9065B2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308AD2812AA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64613C8E3;
	Thu, 13 Jun 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY+B625d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624980039
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265202; cv=none; b=F+ogfTODvTTCzEbPvrkqzqNbhKuRMwepWFFFHw0A5f8j2BFDVf+NUvEzHBPVT7RajrolVa38jhfMvm49P8RKztS3hmPSbHbcvr/WrRT0FW7Myp6QkDqBKVN34sgtMmDhOo/ajtn8jNOhwKgEqL2n5hJ2NS5dt0Ogf0olrbehXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265202; c=relaxed/simple;
	bh=8e3L4WK3PiJTDR6uIZTIoKaxuIE/cJVWU4KrOpZPQEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j67oSeS0phJxpld0HmJoACpMwkgmnwlkjXc+jTjuKJnkde4ml3n/VbVtb59q+uNfuTvgsziqrE3UsNEPj1wUDGYcUIux/6hP3VTT+TKxhUT39FTtCq985Kkk15YAsJ+tw7SVlhKa6V5dGEGGZVIusGkz43+4apE+4ayoe6Gkd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY+B625d; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6ef64b092cso82803366b.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718265199; x=1718869999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8e3L4WK3PiJTDR6uIZTIoKaxuIE/cJVWU4KrOpZPQEo=;
        b=SY+B625d3ch4FBxdz0iy4bezf+QgugS4a1fvnr37wTbeY0qy1opfQhIogTLrxQcWfX
         GGWjJSPaphSTRFfyZiSeE8n3m8fiqaa8fVON1ovPn6N0gO56gbwo23fqYoJ5dovrEgGa
         KiAKgX3GRK8nDbjTKRFtdJ3s5nG3HGzTt2daqoOogGqnseqs892LjjhpNbRjc+I29mVX
         C1Sl3zYgU0pciCowOivXouWUsB2uuAFtDXdmTz7f6d3gqPm/FbQOMeQ8MkZzc3FOyJ69
         qwSv7ZxLIxTqDzG1GB3utcoA1yMrtwFxQiQpCgz0stiI2aolDTeTHhMidXGZLPagTfDX
         O3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265199; x=1718869999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8e3L4WK3PiJTDR6uIZTIoKaxuIE/cJVWU4KrOpZPQEo=;
        b=bPBJMN78VSg+LbMsGCuR7HhDEiy/0sciqLKg+ay2Pe1lwsEnNKvBZLqsVuY2ETcPt2
         EZ9n/xAPiAg8Scodt/jbJCsyRBtARHtsVYulOOyj+tA0JsjY++7RFanpgI1Jkyni7THR
         pUAuB/d9wMHE7Ezdo0FGcoFt3Xh4I0I0+P91dnX9RdLzFB6JTJSEkpz5YIAwFWWsz3xc
         IitSAUrsiL6Sf+ZlpMY+VflGets5EcyZaZ0bTzfx+Q1l6085/aKZ49sDN/EIZ1HsKpdm
         ypnDWPswKi/0xnAE4hCMXhKKuAP2inz4xiWvF+MFWIi2sX4L7rP1D/acUIuVD8o+QCRY
         ic9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJZ2SLM3C3+pqCZZk/FjQ8PgGXWOuhkfpwLh5gYV184gUXzcAg8zJ4qeHChhmDNlBiAlkfqezztu/z1ua+fBIEDhXjeHws
X-Gm-Message-State: AOJu0YwJ9uz0xSsbajdJrm14+22tXgRLXFh9cDsQ7UnjBfJjMYCoHTFt
	abKaA+mfi1KEQSnYH0DlJifnI+6SnhdZsV+rzcvTkbbBFdB5W/6MA91Qp0XJM06ztPtgpz8+UIK
	Jc12ve0aeO+lvwcte64Xe02s4ssc=
X-Google-Smtp-Source: AGHT+IEPnRDotOzYiwDQfEA/uH9PhgClz2wA4CriHkU9seUO0MXfkKriKjashboDSjowHxHaZ1/SMNCEH4XfdRtmFcU=
X-Received: by 2002:a17:906:2da2:b0:a6f:309d:f889 with SMTP id
 a640c23a62f3a-a6f48013fe8mr254833666b.54.1718265198975; Thu, 13 Jun 2024
 00:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
 <ZmqFzpQOaQfp7Wjr@nanopsycho.orion> <CAL+tcoAir0u0HTYQCMgVNTkb8RpAMzD1eH-EevL576kt5u7DPw@mail.gmail.com>
 <Zmqdb-sBBitXIrFo@nanopsycho.orion> <CAL+tcoDCjm86wCHiVXDXMw1fs6ga9hp3x91u+Dy0CGBB=eEp2w@mail.gmail.com>
 <Zmqk5ODEKYcQerWS@nanopsycho.orion>
In-Reply-To: <Zmqk5ODEKYcQerWS@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 15:52:41 +0800
Message-ID: <CAL+tcoC-aQh_4Mmon1w0eVoZoaSi96x4bwQ_g2FD4xTReDqsog@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 3:51=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Jun 13, 2024 at 09:24:27AM CEST, kerneljasonxing@gmail.com wrote:
> >On Thu, Jun 13, 2024 at 3:19=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wr=
ote:
> >>
> >> Thu, Jun 13, 2024 at 08:08:36AM CEST, kerneljasonxing@gmail.com wrote:
> >> >On Thu, Jun 13, 2024 at 1:38=E2=80=AFPM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> >> >>
> >> >> Thu, Jun 13, 2024 at 04:35:49AM CEST, kerneljasonxing@gmail.com wro=
te:
> >> >> >From: Jason Xing <kernelxing@tencent.com>
> >> >> >
> >> >> >Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for n=
on
> >> >> >BQL device") limits the non-BQL driver not creating byte_queue_lim=
its
> >> >> >directory, I found there is one exception, namely, virtio-net driv=
er,
> >> >> >which should also be limited in netdev_uses_bql(). Let me give it =
a
> >> >> >try first.
> >> >> >
> >> >> >I decided to introduce a NO_BQL bit because:
> >> >> >1) it can help us limit virtio-net driver for now.
> >> >> >2) if we found another non-BQL driver, we can take it into account=
.
> >> >> >3) we can replace all the driver meeting those two statements in
> >> >> >netdev_uses_bql() in future.
> >> >> >
> >> >> >For now, I would like to make the first step to use this new bit f=
or dqs
> >> >> >use instead of replacing/applying all the non-BQL drivers in one g=
o.
> >> >> >
> >> >> >As Jakub said, "netdev_uses_bql() is best effort", I think, we can=
 add
> >> >> >new non-BQL drivers as soon as we find one.
> >> >> >
> >> >> >After this patch, there is no byte_queue_limits directory in virti=
o-net
> >> >> >driver.
> >> >>
> >> >> Please note following patch is currently trying to push bql support=
 for
> >> >> virtio_net:
> >> >> https://lore.kernel.org/netdev/20240612170851.1004604-1-jiri@resnul=
li.us/
> >> >
> >> >I saw this one this morning and I'm reviewing/testing it.
> >> >
> >> >>
> >> >> When that is merged, this patch is not needed. Could we wait?
> >> >
> >> >Please note this patch is not only written for virtio_net driver.
> >> >Virtio_net driver is one of possible cases.
> >>
> >> Yeah, but without virtio_net, there will be no users. What's the point
> >> of having that in code? I mean, in general, no-user kernel code gets
> >> removed.
> >
> >Are you sure netdev_uses_bql() can limit all the non-bql drivers with
> >those two checks? I haven't investigated this part.
>
> Nope. What I say is, if there are other users, let's find them and let
> them use what you are introducing here. Otherwise don't add unused code.

Please take a look at what I just wrote. I found one.

>
> >
> >>
> >>
> >> >
> >> >After your patch gets merged (I think it will take some time), you
> >> >could simply remove that one line in virtio_net.c.
> >> >
> >> >Thanks.

