Return-Path: <netdev+bounces-114950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D7944CC3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E83F1C22B76
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D71A4864;
	Thu,  1 Aug 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEWQ8nNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C841A4862;
	Thu,  1 Aug 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517454; cv=none; b=XXMal8pCo7tpuhlE4msfzFoQEThC2N4LDhdrFQ8kWs/1lGfmIwG9saN7gYeDrQMmBv0rINh34HvLtXZv6mLI4zoFWRah9EhC6oQMdMjvHCAWysz8pfEj2QnD9sekjv6+l+Bz+VRlwl4erfkDQCSQfJxWaNE83E4iMRat8qjiBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517454; c=relaxed/simple;
	bh=yxN77Kv37QGsUWOriuotXaBx3NAe94XdeLns7YSshOA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B09X0YzyThN3ZwnGOA8SKEsW6DjzKakPtjhVRf/L1tpYPRYmhN7vaStGLuTztqjo/5oShjK2sxFG573RCxW+rUUXRBIBSlyV+JCt5NBxxIcwd/TypD++ZTWmQJUqRmRJmrzf6NQSxyytukEZkJg6rzCZEgDvsqn9kt+XYhI47Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEWQ8nNH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b6199ef089so39946896d6.3;
        Thu, 01 Aug 2024 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517452; x=1723122252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxN77Kv37QGsUWOriuotXaBx3NAe94XdeLns7YSshOA=;
        b=bEWQ8nNHHWSr3V+5I2kVsJ1BTm7pNI+19mpvAm9AvhXf4QB2sYBKob5HUdGnUP2qDc
         aXPLEWnkQcd6DXrob7MKB+HUzP7Uqh137fNSLXjXsWXPy7GMSJDFaA1XTcCz7LOxN0Qa
         vXq0kKWEPGHtmLHzYmbHGHuaJxRdETxG4FMBzo37yB+aJkRiEA0+nAmmcRWYnknBxCBa
         +FR118XSqOBNwwFdv2kGZpHUq3u0iPFQ7P4Q26QJgqYokm814jeSYGOX4xGZYdh4T20P
         EdSgKAzpzMDUDIRogwJ90bWytGNhvdlTcf4iGE+bii7YBIip+SaPEzLwFmZ5ScsP5cvJ
         Cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517452; x=1723122252;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yxN77Kv37QGsUWOriuotXaBx3NAe94XdeLns7YSshOA=;
        b=SbqplVUSRdxDqwWWns+2Cb8Dd0GhRRvrpwlIOK2ZJmD+Jm2UTLrog7eLJKGBLsRlDa
         ZGUQKHOqD7I6YF+J2MaontvgrpKL76ekGGflkuy+hUanb4856/wQrQuTLgoDUy30jVqY
         sbtWhRPOya7lU3DT/UQ70eYD/OnzADRLoZoWQ+sXrU2ySObgu68go3sXzRktrsRh14Ht
         NdAnTpf3PWoljLUnSnVySMxiDRO+GjwpcEn+Si7OQeCnBDfHgYz8+JyRGXSlmql7gKPs
         DL1dUrnIjnW02aTIsAEsYiXi1jjZMM9cU8xRsoQUuah3OJNAKWWiJVO/40dNhhdLp4Gf
         5FOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyqM13p6Ywip7eOnUFfmVRJavJEvROhJ8yHAUY/vasdLZwWpZoaoBjXYv7i08cAReL++RTQLgHO7sfoc/S0Z5YkGbop0O2iPdGh8ws
X-Gm-Message-State: AOJu0Yx/fQvVzYeVo44nIqg0U1oE3nUz2tfLZNX8uSZYKADoJNTzVYaa
	NHY9VDQqPITJobfAuEF0/U6Av8GfsdYjamCLvQvSwXzfSaRGj4Wd
X-Google-Smtp-Source: AGHT+IEODW/rPQ34dQnW8bd6Aaf4ABwQIHg0KqfbZPE91QhHjlu9ov3PcmiUU9dQUqwe/ReJYQ4+3Q==
X-Received: by 2002:a05:6214:4519:b0:6b0:8fe5:4a98 with SMTP id 6a1803df08f44-6bb8d79e94amr7121056d6.36.1722517451491;
        Thu, 01 Aug 2024 06:04:11 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f8b91sm84412456d6.43.2024.08.01.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:04:10 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:04:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Randy Li <ayaka@soulik.info>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66ab87ca67229_2441da294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
References: <20240731111940.8383-1-ayaka@soulik.info>
 <66aa463e6bcdf_20b4e4294ea@willemb.c.googlers.com.notmuch>
 <bd69202f-c0da-4f46-9a6c-2375d82a2579@soulik.info>
 <66aab3614bbab_21c08c29492@willemb.c.googlers.com.notmuch>
 <3d8b1691-6be5-4fe5-aa3f-58fd3cfda80a@soulik.info>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Li wrote:
> =

> On 2024/8/1 05:57, Willem de Bruijn wrote:
> > nits:
> >
> > - INDX->INDEX. It's correct in the code
> > - prefix networking patches with the target tree: PATCH net-next
> I see.
> >
> > Randy Li wrote:
> >> On 2024/7/31 22:12, Willem de Bruijn wrote:
> >>> Randy Li wrote:
> >>>> We need the queue index in qdisc mapping rule. There is no way to
> >>>> fetch that.
> >>> In which command exactly?
> >> That is for sch_multiq, here is an example
> >>
> >> tc qdisc add dev=C2=A0 tun0 root handle 1: multiq
> >>
> >> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst=

> >> 172.16.10.1 action skbedit queue_mapping 0
> >> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst=

> >> 172.16.10.20 action skbedit queue_mapping 1
> >>
> >> tc filter add dev tun0 parent 1: protocol ip prio 1 u32 match ip dst=

> >> 172.16.10.10 action skbedit queue_mapping 2
> > If using an IFF_MULTI_QUEUE tun device, packets are automatically
> > load balanced across the multiple queues, in tun_select_queue.
> >
> > If you want more explicit queue selection than by rxhash, tun
> > supports TUNSETSTEERINGEBPF.
> =

> I know this eBPF thing. But I am newbie to eBPF as well I didn't figure=
 =

> out how to config eBPF dynamically.

Lack of experience with an existing interface is insufficient reason
to introduce another interface, of course.

> Besides, I think I still need to know which queue is the target in eBPF=
.

See SKF_AD_QUEUE for classic BPF and __sk_buff queue_mapping for eBPF.

> >> The purpose here is taking advantage of the multiple threads. For th=
e
> >> the server side(gateway of the tunnel's subnet), usually a different=

> >> peer would invoked a different encryption/decryption key pair, it wo=
uld
> >> be better to handle each in its own thread. Or the application would=

> >> need to implement a dispatcher here.
> > A thread in which context? Or do you mean queue?
> The thread in the userspace. Each thread responds for a queue.
> >
> >> I am newbie to the tc(8), I verified the command above with a tun ty=
pe
> >> multiple threads demo. But I don't know how to drop the unwanted ing=
ress
> >> filter here, the queue 0 may be a little broken.
> > Not opposed to exposing the queue index if there is a need. Not sure
> > yet that there is.
> >
> > Also, since for an IFF_MULTI_QUEUE the queue_id is just assigned
> > iteratively, it can also be inferred without an explicit call.
> =

> I don't think there would be sequence lock in creating multiple queue. =

> Unless application uses an explicitly lock itself.
> =

> While that did makes a problem when a queue would be disabled. It would=
 =

> swap the last queue index with that queue, leading to fetch the queue =

> index calling again, also it would request an update for the qdisc flow=
 =

> rule.
> =

> Could I submit a ***new*** PATCH which would peak a hole, also it =

> applies for re-enabling the queue.
> =

> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 1d06c560c5e6..5473a0fca2e1 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -3115,6 +3115,10 @@ static long __tun_chr_ioctl(struct file *file,=
 =

> > unsigned int cmd,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ns_capabl=
e(net->user_ns, CAP_NET_ADMIN))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EPERM;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return open_re=
lated_ns(&net->ns, get_net_ns);
> > +=C2=A0=C2=A0=C2=A0 } else if (cmd =3D=3D TUNGETQUEUEINDEX) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tfile->detached)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return put_user(tfile->qu=
eue_index, (unsigned int __user*)argp);
> > Unless you're certain that these fields can be read without RTNL, mov=
e
> > below rtnl_lock() statement.
> > Would fix in v2. =

> I was trying to not hold the global lock or long period, that is why I =

> didn't made v2 yesterday.
> =

> When I wrote this,=C2=A0 I saw ioctl() TUNSETQUEUE->tun_attach() above.=
 Is =

> the rtnl_lock() scope the lighting lock here?
> =




