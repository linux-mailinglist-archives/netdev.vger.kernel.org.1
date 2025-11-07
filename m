Return-Path: <netdev+bounces-236793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4BC402E6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D1E189999A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984973168E7;
	Fri,  7 Nov 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT9miOed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066630ACF8
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523259; cv=none; b=BDkB2XnXnR/NuLMNe8uTBYEGVIOk7qakFLwBrLE7G/XeL3B93TAVATJfoioC7UmSp/3r+Glglu6VJeGqSI6AwEGAcfyhQCJu/aKgu0l07Rie0JTufMarQIGD1clGPMs7xqCP27f7A87vKlUUS39+cfewhc02am0uHFbtcDrakh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523259; c=relaxed/simple;
	bh=zCtUB0kJgbflfpJTzS83w9kNi++5EDfPqOkRqqFOjvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhzkPUFH6z0O+6XSdeqoMX+lyznPBGCPBxyE1b0VCCmpOUq6Q/fmzH0QRO933UgeUPGi7R367R4tQCZK4Z4QDIFsUuuNd1KZY+btVXK1w2pCIG2AzGUg4jkK2Phyu3TZekUEHg4u1JjUZasIO4Lavd7ak4b3cwBvqv1c4BNzE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT9miOed; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-427007b1fe5so429494f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523256; x=1763128056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWSPaSWS2zth6+PcTM9lvcWZNPGKHMYvx8IpRuSIilo=;
        b=FT9miOed/9myQdRUSCzD9jNy9IKNE9XPMMDHKqb9E7ZuK7654TUJcoDBWrtY9Cu5u4
         AwH9tsxcWDc8ac8ktlAjvtmPkwGX4Z5c4rvEZcmFzw02Pu2QzdpyG7O/S9YKGO824ZXu
         PJEdOAMbD5c4tTIcDBrcC0URP0pUK9Uvdxxfe1GcURmrYXMGsZdFOuh5H+cmYY9xF8KP
         usPhiyQVUDSSoCemy8Tjk0aNyiLnQ70+GXGB89Cxy/WDcKWihUWjoBgCFlSgACXN4/Mq
         qSJAYoiqh/jQONnpbtZ8xiTIDwblZjV8oZlabcbNbR9BuBOcZY3XvNZ1kcdUCXULkDYS
         b7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523256; x=1763128056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWSPaSWS2zth6+PcTM9lvcWZNPGKHMYvx8IpRuSIilo=;
        b=le8UAvkIVDBpJJwF9D5gLI/uZmEzgCvwzmbsck3pwbEYR/iSKlcYzxtPUrm6aq/KK8
         92fruL+vI0PCmPX5/DvjZi4jBzn+MCJabAvVHgKacS+8QtQhAmxRWk8DBNsU7aCGrnno
         pQk99OPUWWTs4Ofxi2xzarbr3RMpyQT/eCMZVIZUhfTelQbys5Ly4NT/C5MCBY6Kzb1I
         4d2gQSaZ/+bod+UkGgzlwZc+pM9Snh4XxXMlpN7/+e1KalzBrHXORZXYeQkDDsbZQiIr
         LeTyEOUPqHNpiA0r89L5ysoqHfL0DAFTd1gpBPNfuuyMFq6a2M3HRSzs18x+kpDmXapV
         inCg==
X-Forwarded-Encrypted: i=1; AJvYcCWNvUxzFT07MVCfFcdWHt6FseNdqHCVw6yUM0HR5tIrLuKi6u4M25fbaj6EF7Bagza5DxdHX5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1rThLfTIgb1517EWtz88IVUKwhlynIT75PGhK+j6QAwfmOay
	rMvJD2l6p6HVlCFn7Tzg+7M0KotWYpIkMqBi6El+ThV1lr3vwC9YmyIsXvqFJ/4GwUsQYba9xT8
	hpHhawVO/j5VfLoPyQoLAVrRKAe6VzYk=
X-Gm-Gg: ASbGncs4vNUMfEMB61Nf9tpGcZWhqSdJF9m8dcwer9OyGFFhgsYfgShwkHdP/gyf2Pg
	GVUhpJq0GrckE38UXOIex9NAVR/7PxLZ7DjowffDtownFFfms9r8q0VfbpLQmTvXkjthQqF9TLf
	MPAfwDGZ4RVqseJSMrJpdJ80ua62sg5DT2SMjSP7fqZutw3tLHAxJQuB4O+7Zim0snJQz+6qh/S
	gtzEZJSEUr3epNSIeDhQptT3VOlu0vYxqp3kxXU/6qPDyJiO7Hd/WwyJ0IP14pcWGsL
X-Google-Smtp-Source: AGHT+IHoCbebjRQ/F0AyxfxqE5yFe7njZFryj4eYWvUfMZslexGJ65ZIOsJmR2KnVpMSLW4HS91VwaPplAc9t+kmEeE=
X-Received: by 2002:a5d:64c8:0:b0:429:cdde:be1e with SMTP id
 ffacd0b85a97d-42ae5afbd09mr2814924f8f.39.1762523255527; Fri, 07 Nov 2025
 05:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
 <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de> <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
 <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de> <CAGRyCJE1_xQQDfu1Tk3miZX-5T-+6rarzgPGo3=K-1zsFKpr+g@mail.gmail.com>
 <676869a2-2e0d-4527-8494-db910b3a0018@tu-dortmund.de>
In-Reply-To: <676869a2-2e0d-4527-8494-db910b3a0018@tu-dortmund.de>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Fri, 7 Nov 2025 14:34:15 +0100
X-Gm-Features: AWmQ_blkAQLtJ2tBRDYo_MNiveSgo6AZthE4z-ntNx8CP03ei1Xpu37X5c1GoDw
Message-ID: <CAGRyCJGRqJuh=d8AomhYx08bGuf4dcOJ8o0JrsqqUeVyK8SAcw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Eric Dumazet <edumazet@google.com>, oneukum@suse.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Il giorno gio 6 nov 2025 alle ore 11:00 Simon Schippers
<simon.schippers@tu-dortmund.de> ha scritto:
>
> On 11/6/25 09:38, Daniele Palmas wrote:
> > Hi Simon,
> >
> > Il giorno mer 5 nov 2025 alle ore 12:05 Simon Schippers
> > <simon.schippers@tu-dortmund.de> ha scritto:
> >>
> >> On 11/5/25 11:35, Daniele Palmas wrote:
> >>> Hello Simon,
> >>>
> >>> Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> ha scritto:
> >>>>
> >>>> On 11/4/25 18:02, Eric Dumazet wrote:
> >>>>> On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> During recent testing, I observed significant latency spikes when =
using
> >>>>>> Quectel 5G modems under load. Investigation revealed that the issu=
e was
> >>>>>> caused by bufferbloat in the usbnet driver.
> >>>>>>
> >>>>>> In the current implementation, usbnet uses a fixed tx_qlen of:
> >>>>>>
> >>>>>> USB2: 60 * 1518 bytes =3D 91.08 KB
> >>>>>> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
> >>>>>>
> >>>>>> Such large transmit queues can be problematic, especially for cell=
ular
> >>>>>> modems. For example, with a typical celluar link speed of 10 Mbit/=
s, a
> >>>>>> fully occupied USB3 transmit queue results in:
> >>>>>>
> >>>>>> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
> >>>>>>
> >>>>>> of additional latency.
> >>>>>
> >>>>> Doesn't 5G need to push more packets to the driver to get good aggr=
egation ?
> >>>>>
> >>>>
> >>>> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms =
to
> >>>> aggregate enough packets for a frame but not of several hundred ms a=
s
> >>>> calculated in my example. And yes, there are situations where 5G,
> >>>> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
> >>>> required. But the dynamic queue limit approach of BQL should be well
> >>>> suited for these varying speeds.
> >>>>
> >>>
> >>> out of curiosity, related to the test with 5G Quectel, did you test
> >>> enabling aggregation through QMAP (kernel module rmnet) or simply
> >>> qmi_wwan raw_ip ?
> >>>
> >>> Regards,
> >>> Daniele
> >>>
> >>
> >> Hi Daniele,
> >>
> >> I simply used qmi_wwan. I actually never touched rmnet before.
> >> Is the aggregation through QMAP what you and Eric mean with aggregatio=
n?
> >> Because then I misunderstood it, because I was thinking about aggregat=
ing
> >> enough (and not too many) packets in the usbnet queue.
> >>
> >
> > I can't speak for Eric, but, yes, that is what I meant for
> > aggregation, this is the common way those high-cat modems are used:
>
> Hi Daniele,
>
> I think I *really* have to take a look at rmnet and aggregation through
> QMAP for future projects :)
>
> > it's not clear to me if the change you are proposing could have any
> > impact when rmnet is used, that's why I was asking the test
> > conditions.
> >
> > Thanks,
> > Daniele
> >
>
> This patch has an impact on the underlying USB physical transport of
> rmnet. From my understanding, the call stack is as follows:
>
> rmnet_map_tx_aggregate or rmnet_send_skb
>
> |
> | Calling dev_queue_xmit(skb)
> V
>
> qmi_wwan used for USB modem
>
> |
> |  ndo_start_xmit(skb, net) is called
> V
>
> usbnet_start_xmit is executed where the size of the internal queue is
> dynamically changed using the Byte Queue Limits algorithm by this patch.
>
> Correct me if I am wrong, but I think in the end usbnet is used.
>

Exactly, I was just wondering if this patch had any effect on the
overall throughput performance once the aggregation is enabled.

Hopefully I'll be able to perform some tests once the patch is merged.

Thanks,
Daniele

> Thanks,
> Simon
>
> >> Thanks
> >>
> >>>>>>
> >>>>>> To address this issue, this patch introduces support for
> >>>>>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamical=
ly
> >>>>>> limits the amount of data queued in the driver, effectively reduci=
ng
> >>>>>> latency without impacting throughput.
> >>>>>> This implementation was successfully tested on several devices as
> >>>>>> described in the commit.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Future work
> >>>>>>
> >>>>>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> >>>>>
> >>>>> Only for rates > 500 Mbit. After BQL, we had many more improvements=
 in
> >>>>> the stack.
> >>>>> https://lwn.net/Articles/564978/
> >>>>>
> >>>>>
> >>>>
> >>>> I also saw these large SKBs, for example, for my USB2 Android tether=
ing,
> >>>> which advertises a network speed of < 500 Mbit/s.
> >>>> I saw these large SKBs by looking at the file:
> >>>>
> >>>> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
> >>>>
> >>>> For UDP-only traffic, inflight always maxed out at MTU size.
> >>>>
> >>>> Thank you for your replies!
> >>>>
> >>>>>> To
> >>>>>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO=
 but it
> >>>>>> did not have the intended effect in my tests. The only dirty worka=
round I
> >>>>>> found so far was to call netif_stop_queue() whenever BQL sets
> >>>>>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue=
 would
> >>>>>> be desirable.
> >>>>>>
> >>>>>> I also plan to publish a scientific paper on this topic in the nea=
r
> >>>>>> future.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Simon
> >>>>>>
> >>>>>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthoriz=
ed-biography-61adc5730b83
> >>>>>> [2] https://lwn.net/Articles/469652/
> >>>>>>
> >>>>>> Simon Schippers (1):
> >>>>>>   usbnet: Add support for Byte Queue Limits (BQL)
> >>>>>>
> >>>>>>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>>>>>  1 file changed, 8 insertions(+)
> >>>>>>
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>>
> >>>>

