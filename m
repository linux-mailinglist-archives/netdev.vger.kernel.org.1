Return-Path: <netdev+bounces-71757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE82854F4E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4482BB213CF
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C34605D6;
	Wed, 14 Feb 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF3d/G5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA055604BC
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929934; cv=none; b=tm7tsFO27lMlZt46PelagW+aU/nAkBtaX+2yuW46tLCDREDEWh+kWVJTSoi21Dvs196eD0O6DrAY7My26FuU10AQG0hFhoXbNqgPTQlJ+ZIQw0cEkRzP6eiC/leATSR7D/B9T+kHyGz95Oo3iaiw3cAxzYaRaw/QwNpCyx+xSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929934; c=relaxed/simple;
	bh=OSsaNG2FvzVU0LHsrYNC/eZp5qr5JVJ6bAlNSP1GGaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edj/MusEAzk7y2lV6rzIUvL8EHfTh5bRG5AUzOO6QxVLImD3m1jBCjYNkn/WfRX/JmdrkLh074FbX/x55iLig2eucFusK0Oxldd+eClWJ3WViBNQX0DtJhxt8bKviirpAzzyvhnVbHlGoykLECT1S5G4y9N0nF1/jpaypW+IFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF3d/G5z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so27915a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707929931; x=1708534731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyOK3EJeEyKJEt81jU19f6sSTlRmH4ZoITaYsVw9nEo=;
        b=ZF3d/G5zDd+JCzwBb6Z0JSjev/gYAck3SRMrFgzDy7jip8jjj3ifVxsuS61A1IF1Ne
         KrKN6PccBPXHoOtMNHLt+UaFzqAwHmgY085ezuWAddlXL20wMu59SwCVa6zygN3eUq7c
         Su14HW9NP0bsm/CWe0hW8AM8biONOmKFOKR6Sawd+oa7CKf8oAn4gpPsWZqph7jrzZeh
         7MHnxWGJ7mogYpXA+latifu9NVqnEriZxBckvy5LPr8ec+9ncAUh7TVHoztwb1DVyfKX
         dc6mNQNge954Yl8/obotKSo4koZbU8dFmVXnp0VSbVwDOuUFmZ1PgjM6007KtVxyYh6Y
         xQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929931; x=1708534731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyOK3EJeEyKJEt81jU19f6sSTlRmH4ZoITaYsVw9nEo=;
        b=QdSjTjlkjFb9FhVp6fRr/S8FTonMUQLRj4Xp/DhoSPwFQf1DouJ3ugRbcNrZTxrTvX
         v5LWXrnx9qcuhPtA5xFyL9doUbSyU/shJkuajJlbkl0kKjrvMa5Jpz2fnY1hZ8Zjd30i
         1gSm1Jbnj+AGqNECIgzysJQJV3hQnFyAYS1mDjQITlLjfpsHr6fYXe3ibzWd0zsqagP5
         f6W2O5t+si4JJGg7oSRsY8d5jY/23bjvzkXX1BAXKi3SS/a7zJsH7z6tPmpr0dmCrXYS
         FuodspQzVZLh58V5tsaTyrKKAjOJawo1HAAdWTaFhdDevPQ44A3UEBeNfDWwvdUbRzgM
         Ivog==
X-Forwarded-Encrypted: i=1; AJvYcCV13SJq4HvrIbB42JcB2RbE7xMEhdZeJ9I2aqPWfT34WUwfUy7IdZJLmCvhz/PoLxxVoyjG/assYc4Lm05ERn2Kd5Sy0nGo
X-Gm-Message-State: AOJu0Yx7xpNZ6sNoW+2/2HSKguCAFXONor3GouXPenfiY18YyFf9THdq
	yiFbrwExMZjacpNbezIk/nXrQsCqpLUScBRFQu1NySjl9fvG8YeUzoydHwRF0ipW3gCkaW5pY+R
	8mmYg0eQ6EWDDNq6nLNKG2IWA/Pmbxe3C0fv7
X-Google-Smtp-Source: AGHT+IE4tG1X1dYxzIYp2Bzh7QoWLOwjRxwWH/t/jCIoU3Yg+wA31sQ+QEU+t1UUq0hSu9m5cPhcEd5LSb+oOd0di18=
X-Received: by 2002:a50:8d13:0:b0:560:1a1:eb8d with SMTP id
 s19-20020a508d13000000b0056001a1eb8dmr205884eds.7.1707929930734; Wed, 14 Feb
 2024 08:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202165315.2506384-1-leitao@debian.org> <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org> <ZczSEBFtq6E6APUJ@gmail.com>
 <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com> <ZczvGJ90L7689F6J@gmail.com>
In-Reply-To: <ZczvGJ90L7689F6J@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 17:58:37 +0100
Message-ID: <CANn89i+zF3k4OyhJsK3sg5zNsFzKAQ5G_ANYEaxOfc41B7S18w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg <johannes.berg@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:49=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Feb 14, 2024 at 04:41:36PM +0100, Eric Dumazet wrote:
> > On Wed, Feb 14, 2024 at 3:45=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> > > > On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > > > > Please note that adding other sysfs entries is expensive for work=
loads
> > > > > creating/deleting netdev and netns often.
> > > > >
> > > > > I _think_ we should find a way for not creating
> > > > > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  direc=
tory
> > > > > and files
> > > > > for non BQL enabled devices (like loopback !)
> > > >
> > > > We should try, see if anyone screams. We could use IFF_NO_QUEUE, an=
d
> > > > NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQ=
L
> > > > would be pointless"? Obviously better to annotate the drivers which
> > > > do have BQL support, but there's >50 of them on a quick count..
> > >
> > > Let me make sure I understand the suggestion above. We want to disabl=
e
> > > BQL completely for devices that has dev->features & NETIF_F_LLTX or
> > > dev->priv_flags & IFF_NO_QUEUE, right?
> > >
> > > Maybe we can add a ->enabled field in struct dql, and set it accordin=
g
> > > to the features above. Then we can created the sysfs and process the =
dql
> > > operations based on that field. This should avoid some unnecessary ca=
lls
> > > also, if we are not display sysfs.
> > >
> > > Here is a very simple PoC to represent what I had in mind. Am I in th=
e
> > > right direction?
> >
> > No, this was really about sysfs entries (aka dql_group)
> >
> > Partial patch would be:
>
> That is simpler than what I imagined. Thanks!
>

>
> for netdev_uses_bql(), would it be similar to what I proposed in the
> previous message? Let me copy it here.
>
>         static bool netdev_uses_bql(struct net_device *dev)
>         {
>                if (dev->features & NETIF_F_LLTX ||
>                    dev->priv_flags & IFF_NO_QUEUE)
>                        return false;
>
>                return true;
>         }

I think this should be fine, yes.

