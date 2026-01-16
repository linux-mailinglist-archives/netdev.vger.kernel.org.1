Return-Path: <netdev+bounces-250461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECBD2D3EF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219ED30AE792
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF82E2D6E78;
	Fri, 16 Jan 2026 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ/nBwKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07E224240
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548622; cv=none; b=Vk1fyklB0rEhHbCYMNOcvdWek4YrxndVuDl1MkmXInBaE7m8LPLA5iKKeLl1ERuxmRUQxFrvso66Ozd1r8BZETfZXhLY/NSv5BCTQR3HzwAwOtPilNmG9YwJN0/mz4/dak7gB5JkY0Xjkwp3Up0DhHNLsBoBt8nx2U19WbaNvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548622; c=relaxed/simple;
	bh=RPrmbhlRjeC9B6lKapFSPe5foqxNQg2mqncsblfOEhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAqIrYVbhHCqcF3iHWWWI/f0WaTPCOYWbXDdTfAEUweq3eNWwxeRci/nC4A9sM2HFTmRNduL5OoqXCVFNFd68ZckbMME+sFFFXaYv/VrJoBHHd3sHCuewFNzrZpgPLKCiXeyyGcuHQt7t0vSO5xqGylJcEDyPqvEV5ZrB0LXPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ/nBwKE; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fb7704cb4so15457677b3.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768548616; x=1769153416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvCEgi6yDhLUYKAxP3i0juhxbr6yYjr6OOXNRCvrU6s=;
        b=CZ/nBwKEFkJn4Rfub6ZGRCi6R57lzii3EgJU+9fqJlglYburyWea4k+UnhvNF1qqlj
         N38QdQ/BMMfqjI9STf6nr1D9X2oaGpWFWKawURBQBWka7ya3ycGetRJzOshcxTZcMS2K
         RPnqL/1zF175f86JtqesxKLZi+0eaw/fGk9QIoIIG1YfnSdLbB3z3Mo2Py09YnF7WL+m
         K6ULroO2luitZxdbTZ1chOzdGtzrvkyLhC9M5YtRX8mDw62dg73VOZS3oKY1D/koml4b
         nbfBlQhqLeTj4jxj2/E1LohwZ1VKdMsM//mGUHT7tNbmWlkCdl5Et/QyC0fRL1VahZcc
         qJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548616; x=1769153416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvCEgi6yDhLUYKAxP3i0juhxbr6yYjr6OOXNRCvrU6s=;
        b=quO0uMhpnvjlkuxnWU+uuzmuvMgrkjEtHkF9FeINyc5jn8b8fNq61VgdZTDz4mp6A6
         CihmzILlFWxUElT79pKaFANHKSUr4YuXRfMkCArom7nJxT1FkOZmKBKTxxp7sJBWcVwT
         T1AOrblR8eiBnwuW3b2CTLAXDKzcLjXF86UMIWqHP4XOwX01iuHL/Mdu+7fJcThfgDB9
         sQ2LsEcVXf9y68PgRHEPZWAegQnJU49Ek9xHJpdyT58QEwO1aTx8ryQUjiQywq6/E8Sv
         WbGI08au45BMNCDiMwNWghKOuUArXDBBk7+VxRuEL0OKDP+ZAY3QafSx5Evm3hRdp0yf
         r7eg==
X-Forwarded-Encrypted: i=1; AJvYcCWpWzpNkJowtq+tjWeiNbttZW1rn+uaYAyf1m6UxbVZx8qzrgQwHd0cs2KVWhUHtoLQfWyiTPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5RIIvUj5in6r3SoPKdm3OZWr6fS+AIy591yfwwnuoerzfGhj
	RNMy5Ydk2a8J9bs9hWqAskk9nmnEEVwt/etvMkc3ObzwiFjv82PKcwncHvxamhmqnUbvgLJjn//
	jl/ZeBfSDszTyTmRway3nSxTwEAl9DEfszG0auW0+sGD4
X-Gm-Gg: AY/fxX4JYrLdGZT2nhSHmm5n8LORjY/81b16ZlYfGCQcZZzKlz8neIDsoDcecru6OLP
	ojd3zbkGCOq2XDZyJEzWQPGDta7N/RMFES1ClPsi8TAlWkCiTcM19vnPI7MSIOJ6XAKYSAlcBkK
	zj6Gx2160hHLy/RIraYuXYTiItHi6XX4KdsxVse2e4dPCthCUK5t+iTHygMaYIeqjQCmwkRoy+e
	Bx4uE7FShlAdGXTknfI83U6DK4ZPIz4/OQFxHDw+so4vV0ymqB0jIX9FmYKMKDPGuidobN+/BZW
	Bo4o
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id
 00721157ae682-793c671d3eamr14808567b3.25.1768548616280; Thu, 15 Jan 2026
 23:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114025622.24348-1-insyelu@gmail.com> <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
 <1b498052994c4ed48de45b5af9a490b6@realtek.com> <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
 <f3fe05ea76794cd09774cd69e85623d8@realtek.com>
In-Reply-To: <f3fe05ea76794cd09774cd69e85623d8@realtek.com>
From: lu lu <insyelu@gmail.com>
Date: Fri, 16 Jan 2026 15:30:02 +0800
X-Gm-Features: AZwV_QjVD0ydO6Fjz9UulYNcgGXDCuEtaNdNkj3cVu0PmFKKQiIXoqnOflrXF_E
Message-ID: <CAAPueM57HHjvyCtBf5TEy2rn6+1ab7_aeSpJ0Kv4xUYt+SfFtg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: r8152: fix transmit queue timeout
To: Hayes Wang <hayeswang@realtek.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de" <tiwai@suse.de>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hayes Wang <hayeswang@realtek.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=BA=94 11:11=E5=86=99=E9=81=93=EF=BC=9A
>
> lu lu <insyelu@gmail.com>
> > Sent: Friday, January 16, 2026 10:11 AM
> [...]
> > >         netif_tx_lock(tp->netdev);
> > >
> > > -       if (netif_queue_stopped(tp->netdev) &&
> > > -           skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
> > > +       if (netif_queue_stopped(tp->netdev)) {
> > > +           if (skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
> > >                 netif_wake_queue(tp->netdev);
> > > +           else
> > > +               netif_trans_update(tp->netdev);
> > > +       }
> > The queue was stopped because it exceeded the threshold. Attempting to
> > refresh the time at this point is clearly too late.
>
> Why would this be considered too late?

if (netif_queue_stopped(tp->netdev)) {
    if (skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
        netif_wake_queue(tp->netdev);
    else
        netif_trans_update(tp->netdev);
}
The first time xmit stops the transmit queue, the queue is not full,
and it is successfully woken up afterward =E2=80=94 OK.
The second time xmit stops the transmit queue, the network watchdog
times out immediately because the transmit timestamp was not refreshed
when the queue was last resumed =E2=80=94 FAIL.
This scenario is logically possible.

There is no clear evidence that netif_trans_update imposes a
significant CPU load.
Please help me review:
https://patchwork.kernel.org/project/linux-usb/patch/20260116023725.8095-1-=
insyelu@gmail.com

> Based on RTL8152_TX_TIMEOUT, there are about 5 seconds to
> wake the queue or update the timestamp before a TX timeout occurs.
> I believe 5 seconds should be sufficient.

>
> If there is no TX submission for 5 seconds after the driver stops the que=
ue,
> then something is already wrong.
>
> Best Regards,
> Hayes
>

