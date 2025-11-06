Return-Path: <netdev+bounces-236187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC3C399AB
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF78735021D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACA308F2E;
	Thu,  6 Nov 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaM2lrOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C66308F25
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418323; cv=none; b=UDbdbsqQ4QwkWrr1bSMHrdp/tbuSodRV3lxnLWgNxagBkTMAhZbPVWgvYBCwFxRPeeBAc6m0zCedOMzlE0WKHbbMsb5GkmsF0R3VHN6NByPcpPDZ7iiSEUqQWOWKyqhbcHVSY3+a8OUmlugkg/bm5iESepxWmfQlOeaM8ivR/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418323; c=relaxed/simple;
	bh=6x/2ReiXGNUqbmEF1+512pnU1mLdfUCAbQISuBJZ8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJKrfMddNCwjiV6be4LjHlH+u6/THFZD4DbHwyg8uWjNfOOf7cGmEnHDyO+WLbFMNA3SxGpd1QWRVxfB7Y1nx0KKgKkaKQW58jCEazILm6T0aW/5I9wI7QPl6CStlz3aN12sTUIN8lyEO0jhyI0mwRt/f3RDET4l2TIF7FpJfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaM2lrOP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426f1574a14so377702f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762418320; x=1763023120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf22DxiJKidt7zn+YqzlU5+UFZlDZr1co6jaRkh7sD4=;
        b=aaM2lrOPfqE0SBcsCzd0gyWpX/o5XXhtLs+oyq6hziaWBHmnyABv5cPb2gjRSkGENX
         Ci8snao4DiXIXfXYNQidkvnjHFUBaRUIlX7zM2ftJJ5oqrU/wKt+UnBC0oe4AM9fQkhI
         gp+IRUdmNWxYfHksoKqLse/e8kLvMMeUlpx87uDUBbXe49a9VHh/KyN3GEsjOYHn6KX+
         g39NTU7vEAxPDjcscIsS3KlBeIHFj7ssA7smP8Be7AJvcAgoc8duqlKkxjboMd7Xl30/
         VrcfccqrpY4kR1d5nawtciFYo0UFc7Sy7LFilfC6/5qtk6NgvcHMwP6nylK+RjpOZmKv
         PLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762418320; x=1763023120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf22DxiJKidt7zn+YqzlU5+UFZlDZr1co6jaRkh7sD4=;
        b=eIZml1ow+JyDYvT2U9blFMyBAJ2buuhVhV99Kypc9dhzNryaPOpX6/RKVKpYHiVQxX
         EBgefzAzgm1NiYqPCul9m4CrC2jvmOUfzsaB+Kwsd308R5fpN5xo2Tm8Fvexm1F2y8Li
         mB6nCl1Q3W6xsax1Oc4bu1k1Vn4bu93rZZsmIbioD9zmkAv3JKYXFASd6YjZ3Mc+HlmH
         wMrQyTmT+WYw3BNN177fjV9bP6QHSllygm07C6bjSDKnt7kHKzJj01rBfeZul4pWHZBZ
         9l238TzCd8OoMWifQ3wTyo3XKB4gwKqTQVFaJA4U+HQ4YOV+B8tS5GDUY+zzH9PzkW53
         EMkw==
X-Forwarded-Encrypted: i=1; AJvYcCWusJAn2IuBr50r9xDvlpybht39KHFlgZXjza9pmFXM+pUCiSjgGrjEf4kOMLffZp8o8W+U/VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/33P2mP8lEqKjwpXw4TTj+5tLkXvkeiTrNO1XSTdVTod5PPh
	Uayc3QpTELtuereNHE8WicYDO0Ao50nYJa4ekvMK4pQ4rcm2xn3hLtxu5ZRic4tKKIPnf7kgpvN
	aH7eP938E/dl9m9FzUp29r1xyOHd7dlg=
X-Gm-Gg: ASbGncu7s5cyzaSYEBxfMDq/qp4hSw/igb7EJQ7Ym9RUnMATKbjBYGgB7+4j1UBAzsk
	jdxnvE4h9LjZIuIK4WvKW3FY0uPWwhZ2RZzOlSJNzmYFYaamPk2a+G4FbxcvNDe/xMfK6fK5EaH
	7Z0GAIwNo8BJB1dLlRP9ea+HEXYvemp1FaMxAigrde4Hi2aeKteCBO0thjSdJNBmVpJcOkOwcMk
	cASllMbn6jAp5OdbKnzp4GwT5onH2gyJzBWOiLA+dE6cSwdSHDoo+6KhKaT
X-Google-Smtp-Source: AGHT+IGPURHI8ENgPvqdQX7Mov6yZoSClcZi+fUXPLz6ZWGpKNYXySUXy3i2zNqHCAeXBsyc7pP6b+3An2fvvvX/Wng=
X-Received: by 2002:a05:6000:2f88:b0:427:5ae:eb89 with SMTP id
 ffacd0b85a97d-429e33064aamr5149183f8f.34.1762418320048; Thu, 06 Nov 2025
 00:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
 <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de> <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
 <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
In-Reply-To: <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Thu, 6 Nov 2025 09:38:26 +0100
X-Gm-Features: AWmQ_bmwvnkfYCXkSH2o_3U8zoA1yeZsi6gyY_TwK7wXxSjK2NJJsBdDI5hCg8M
Message-ID: <CAGRyCJE1_xQQDfu1Tk3miZX-5T-+6rarzgPGo3=K-1zsFKpr+g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Eric Dumazet <edumazet@google.com>, oneukum@suse.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Il giorno mer 5 nov 2025 alle ore 12:05 Simon Schippers
<simon.schippers@tu-dortmund.de> ha scritto:
>
> On 11/5/25 11:35, Daniele Palmas wrote:
> > Hello Simon,
> >
> > Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
> > <simon.schippers@tu-dortmund.de> ha scritto:
> >>
> >> On 11/4/25 18:02, Eric Dumazet wrote:
> >>> On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> During recent testing, I observed significant latency spikes when us=
ing
> >>>> Quectel 5G modems under load. Investigation revealed that the issue =
was
> >>>> caused by bufferbloat in the usbnet driver.
> >>>>
> >>>> In the current implementation, usbnet uses a fixed tx_qlen of:
> >>>>
> >>>> USB2: 60 * 1518 bytes =3D 91.08 KB
> >>>> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
> >>>>
> >>>> Such large transmit queues can be problematic, especially for cellul=
ar
> >>>> modems. For example, with a typical celluar link speed of 10 Mbit/s,=
 a
> >>>> fully occupied USB3 transmit queue results in:
> >>>>
> >>>> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
> >>>>
> >>>> of additional latency.
> >>>
> >>> Doesn't 5G need to push more packets to the driver to get good aggreg=
ation ?
> >>>
> >>
> >> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
> >> aggregate enough packets for a frame but not of several hundred ms as
> >> calculated in my example. And yes, there are situations where 5G,
> >> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
> >> required. But the dynamic queue limit approach of BQL should be well
> >> suited for these varying speeds.
> >>
> >
> > out of curiosity, related to the test with 5G Quectel, did you test
> > enabling aggregation through QMAP (kernel module rmnet) or simply
> > qmi_wwan raw_ip ?
> >
> > Regards,
> > Daniele
> >
>
> Hi Daniele,
>
> I simply used qmi_wwan. I actually never touched rmnet before.
> Is the aggregation through QMAP what you and Eric mean with aggregation?
> Because then I misunderstood it, because I was thinking about aggregating
> enough (and not too many) packets in the usbnet queue.
>

I can't speak for Eric, but, yes, that is what I meant for
aggregation, this is the common way those high-cat modems are used:
it's not clear to me if the change you are proposing could have any
impact when rmnet is used, that's why I was asking the test
conditions.

Thanks,
Daniele

> Thanks
>
> >>>>
> >>>> To address this issue, this patch introduces support for
> >>>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
> >>>> limits the amount of data queued in the driver, effectively reducing
> >>>> latency without impacting throughput.
> >>>> This implementation was successfully tested on several devices as
> >>>> described in the commit.
> >>>>
> >>>>
> >>>>
> >>>> Future work
> >>>>
> >>>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> >>>
> >>> Only for rates > 500 Mbit. After BQL, we had many more improvements i=
n
> >>> the stack.
> >>> https://lwn.net/Articles/564978/
> >>>
> >>>
> >>
> >> I also saw these large SKBs, for example, for my USB2 Android tetherin=
g,
> >> which advertises a network speed of < 500 Mbit/s.
> >> I saw these large SKBs by looking at the file:
> >>
> >> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
> >>
> >> For UDP-only traffic, inflight always maxed out at MTU size.
> >>
> >> Thank you for your replies!
> >>
> >>>> To
> >>>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO b=
ut it
> >>>> did not have the intended effect in my tests. The only dirty workaro=
und I
> >>>> found so far was to call netif_stop_queue() whenever BQL sets
> >>>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue w=
ould
> >>>> be desirable.
> >>>>
> >>>> I also plan to publish a scientific paper on this topic in the near
> >>>> future.
> >>>>
> >>>> Thanks,
> >>>> Simon
> >>>>
> >>>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized=
-biography-61adc5730b83
> >>>> [2] https://lwn.net/Articles/469652/
> >>>>
> >>>> Simon Schippers (1):
> >>>>   usbnet: Add support for Byte Queue Limits (BQL)
> >>>>
> >>>>  drivers/net/usb/usbnet.c | 8 ++++++++
> >>>>  1 file changed, 8 insertions(+)
> >>>>
> >>>> --
> >>>> 2.43.0
> >>>>
> >>

