Return-Path: <netdev+bounces-125597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D696DD10
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F00B22F0C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C417993;
	Thu,  5 Sep 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2JxaSBy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8E19EEA7
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548405; cv=none; b=C8Jh2eIjxGErDpO2X5dvTOYbmbxL2pIB242kvcu2SBaZuuEhT5xdKR+mzO2EZIA7WvtTdQ4Si5DGkjzN6jN2EBFd8ZxBs7RuYRlDk01x1rJqGyGIeXEBDu3yxCc3T6PM5uJq7oS36RPf6he/jBypiuZbZCfBSt+RX00bn92PmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548405; c=relaxed/simple;
	bh=1hB/LXrPgvAtTN9GXfwyJtxetvNDTX6pfIxTjqyczAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnIBUKs6+cOz3HkYBvTMruLuKEQkHaaCPjJQ9qr7hn9BdQ9dlUDVaTJMlHEoJTRwFXfQKCfUXv+uj4shXWRdV2MwZi3xxxvHR5ZwyGQzIkxD6LkeJEe7l3t5j/lBnkc8RG00pgaH9b8ZzpK9ohRDpS0nXlvbYOMU0biSUurM1y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2JxaSBy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c0aa376e15so456081a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725548402; x=1726153202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/vwaaOM7QgzJOv5+FIRA5/127R3JaMBCh3y7Puc158=;
        b=Z2JxaSBysVis3+ffUqMoIlqbVKTfa+brz4OuJ2wMs3aIAXygDeXP0RoftTKJr3WnOw
         dlfeMVuRDcL983YioBjZJ4TIWyW3C3Eq29pROhKs5wyHj/XPx//Mi+swqvIskLB8P9m2
         MaUvH5pwS2ThkZcKl/ZCmQMX8/8lvXg4fTSf/ypi5jkXf4TFcygA+B/ADcBK+XwNh+95
         1GhJH7xJHWHTVV6rVz9CkMWqIIlxoXOBI+0k1yRb835KecdG4OhErUU6/LGQjrG+CzqG
         XWjBLgLMUz4GMDhD8Rmbp+hJZFa53VQrziQDxGB7ncvYd7wbhcj9o3Pdmc8MN9oQ3BBP
         WDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548402; x=1726153202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/vwaaOM7QgzJOv5+FIRA5/127R3JaMBCh3y7Puc158=;
        b=mTkjoi6jz4hDW5uLPQS5FrVBxOf6gfNIndzlQN/keOZIrAEL4xpxr8RduKourDCCOe
         knP1U2gck6B6ObATKQG+mzE0VwdkBfcG0SirM+wartiD4kc/SfUk8LJZ9UpJHb3hbd6O
         VLbDrZCVVVVt6NaTUnj5QdoF5qi9UhCyxn5Zq7hWWiKMMtbQ2pn6VkpcquLrA7ng46U9
         SMFyAvypUKR2/FAK9hWQkyosKjPpLwr3uDV5Wzct5DIHR8UWxG7A+x3X6HEqOuqGkySk
         SEXroW/5almcUE/Yd1jxQOD7E0JamtNjawdoQUnLXl9Tz67czxAL41Vrx8r4Lg3epg63
         StSg==
X-Forwarded-Encrypted: i=1; AJvYcCXSfxe2qTQUca66vxEKTyf731BBrc2aWcMFhX+FX+5AeAh3YG3ZRZiq+fszVfsGKBLjzedDqrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZ/CRstc+L0vmRT49Oiclq5GudbdVwODtV4E8VnW+wgZT6DIj
	2fXvHsYSHfpUMI6yEXWz5cpIRoVyNj+awjbRQL4mO9257rLrkBR7EW6BxT3DGhny+NQRNXgbXNA
	onj1kDbjjIaeHZucndww1k73hbkfuR9KAZTM7
X-Google-Smtp-Source: AGHT+IHphqMnzPf1o9hHPytHh4YLrNaMKd8hVcLv5Sr+340Jfy4m7laRRKRGW534lvPcXgloqGZBr5GIP9lZYGTISW8=
X-Received: by 2002:a05:6402:5205:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c3cd77e61bmr2793811a12.11.1725548400987; Thu, 05 Sep 2024
 08:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-4-sean.anderson@linux.dev> <CANn89iKJiU0DirRbpnMTPe0w_PZn9rf1_5=mAxhi3zbcoJR49A@mail.gmail.com>
 <156719f8-7ee8-4c81-97ba-5f87afb44fcf@linux.dev>
In-Reply-To: <156719f8-7ee8-4c81-97ba-5f87afb44fcf@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 16:59:47 +0200
Message-ID: <CANn89i+3kwiF0NESY7ReK=ZrNbhc7-q7QU2sZhsR9gtwVje2jA@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum checks
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:24=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> On 9/4/24 12:30, Eric Dumazet wrote:
> > On Tue, Sep 3, 2024 at 8:43=E2=80=AFPM Sean Anderson <sean.anderson@lin=
ux.dev> wrote:
> >>
> >> The partial rx checksum feature computes a checksum over the entire
> >> packet, regardless of the L3 protocol. Remove the check for IPv4.
> >> Additionally, packets under 64 bytes should have been dropped by the
> >> MAC, so we can remove the length check as well.
> >
> > Some packets have a smaller len (than 64).
> >
> > For instance, TCP pure ACK and no options over IPv4 would be 54 bytes l=
ong.
> >
> > Presumably they are not dropped by the MAC ?
>
> Ethernet frames have a minimum size on the wire of 64 bytes. From 802.3
> section 4.2.4.2.2:
>
> | The shortest valid transmission in full duplex mode must be at least
> | minFrameSize in length. While collisions do not occur in full duplex
> | mode MACs, a full duplex MAC nevertheless discards received frames
> | containing less than minFrameSize bits. The discarding of such a frame
> | by a MAC is not reported as an error.
>
> where minFrameSize is 512 bits (64 bytes).
>
> On the transmit side, undersize frames are padded. From 802.3 section
> 4.2.3.3:
>
> | The CSMA/CD Media Access mechanism requires that a minimum frame
> | length of minFrameSize bits be transmitted. If frameSize is less than
> | minFrameSize, then the CSMA/CD MAC sublayer shall append extra bits in
> | units of octets (Pad), after the end of the MAC Client Data field but
> | prior to calculating and appending the FCS (if not provided by the MAC
> | client).
>
> That said, I could not find any mention of a minimum frame size
> limitation for partial checksums in the AXI Ethernet documentation.
> RX_CSRAW is calculated over the whole packet, so it's possible that this
> check is trying to avoid passing it to the net subsystem when the frame
> has been padded. However, skb->len is the length of the Ethernet packet,
> so we can't tell how long the original packet was at this point. That
> can only be determined from the L3 header, which isn't parsed yet. I
> assume this is handled by the net subsystem.
>

The fact there was a check in the driver hints about something.

It is possible the csum is incorrect if a 'padding' is added at the
receiver, if the padding has non zero bytes, and is not included in
the csum.

Look at this relevant patch :

Author: Saeed Mahameed <saeedm@mellanox.com>
Date:   Mon Feb 11 18:04:17 2019 +0200

    net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

