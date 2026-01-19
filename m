Return-Path: <netdev+bounces-250986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB393D39F25
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 07:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3DFB3012954
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A9E28AB0B;
	Mon, 19 Jan 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8XuBhCj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512728850C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805922; cv=none; b=T9GbHJfLNvI9ce5VZghrf1MpOfZ+wk4v/gpjdpKDRyhzeK9K7qv0bW+pZGGBJRMBC8Ldmt6zQ9AcDtbt0LnFuBa8jEG7Wn1/rPWDju1ZAbjV+IVfsnHr6JT+sAjGPd3SnmnkCNWmBFxr7kaTxOTtYO2kiO4PvPrZhbrDaKl0N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805922; c=relaxed/simple;
	bh=0BwQeahUPD8CqR4tKlGaMTqzMmoD49vM7xWLtA81blY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obZ8ITA0kSGMAvTJi0Fd2IbMesIi5I4MJHRyhd2EpvKQhxw+sM7HoGaIZe1mfKKbmEeLR2seJEXhwDH21Qg3wSq7rswIer88MD4hxUMeKwDlb/jrziZ21Jf5bRE6PCAFvqslkNKPD9F8Uo/1Nw1es3x5kleaUaNr2GRXjPnGtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8XuBhCj; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-793fdbb8d3aso157797b3.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768805919; x=1769410719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VixfVNO0CFNlNWWSbG+RCuPGrtUhPs3GIPuSoRoHegU=;
        b=h8XuBhCj/lG9L0u1QVjZu0hun0KXRexV1eSfZobfZequE+rGc3Hch5oc/ksklb/CD7
         YSyHsTnZ3DKXAEhYCL3W71BXpSJv2BzvIyUsEq84V5HbailQp7m7M3Hhp1XuBllqy7Qp
         VyGtNTDI4B9r7BLOZp6AV50yaeehhCAe9+DsBMoKbmBkcybG0uUNwQesSSYgV3IcOHOS
         Es9pOO/SFaBtg/EB1g+WzPazU8QV0rlYtp1I2EXGLyoe+ZJMWozHuGQ7eQS/tAkew8bK
         QeqgamXKiTYuaRuHt1fQjY4fzmE4FhK7UznoCI/3yLPGRUaJZtPl0g9SNganN8CZexiZ
         otrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768805919; x=1769410719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VixfVNO0CFNlNWWSbG+RCuPGrtUhPs3GIPuSoRoHegU=;
        b=raIp58b30gZh3olIbzqEE/c+FPDTlqZwQKyPlxkr0WdYkMWAgRCMPHXu4jdmOpsrTS
         A6AuRICH0fQ6+XFgskB2Jneh/fEMgc9a/gcciOFHkYHEPfKcGac38/Gs3jjOZujkwQE5
         +bKCUFLaiJT7qu/GCr7AgjD5vkuqEKYDryW3ykBazywbjzMXUELbXoYPtC5QFzFs4vFm
         xqOxwmsrHRA8GHWUXsqan1qML4w+KPS+cD6i4emvqk5vQWoXUvI5HN60uHQjMfRS1lZ9
         bMZUkVKRYRk7qW70L+Qmz3+pfEswpu6GTEsxhk+mt+NsmWBksXiHSFpkQS/sMfDM7iZd
         OBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUj3jWui9PjE3LEKR9yqCBgjhHdAgNgWEglMJpr2TN0e5mZG8fYGHCIMPgGaMTjWvyb+NfiCKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TaSNhibV1fIGlxhCXVrBUhL5FAxDixdaJ6yAGU3T3IRnGS9s
	LMXyn0C9JRwnR7Xl5SZRkuZL26aMUuoIS7OsPi/WHkXNKyLzDMMXZ+1+8V0B2Iu1XelEk2uOuCC
	VqJaphtLaBQfjX4Xjl//yePY9xD84BKo=
X-Gm-Gg: AZuq6aJnyDF8UEJz6D8atqPF9zbh3ndrGBKsG6rZWFw9gGvCnJcidjqezwc/8LASCBE
	QUzxX/KvT7pIObhLr0WULHXNTk2ucvXHyO0rlAW/HKEg8ucYFhWOSY0jJXzMBIaXnQnZE4W93ax
	wRsOrsdHssliGDwzoP9F05f1B8na3snJ+ql/MdxLKlp7QhpE4OVnoAkzVdt4DUm6AnxPdwNHw4C
	A4jVjU45I756Yghi1+tlh3nvUWr3WMX1XNYPlp9hm2xlJRbfBMVVFRy7GvqYUzf8oz7J5miYFzD
	Ynikjb/7vZl/fhA=
X-Received: by 2002:a05:690c:d8c:b0:78f:a544:c45d with SMTP id
 00721157ae682-793c52b199bmr77213547b3.20.1768805919615; Sun, 18 Jan 2026
 22:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114025622.24348-1-insyelu@gmail.com> <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
 <1b498052994c4ed48de45b5af9a490b6@realtek.com> <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
 <f3fe05ea76794cd09774cd69e85623d8@realtek.com> <CAAPueM57HHjvyCtBf5TEy2rn6+1ab7_aeSpJ0Kv4xUYt+SfFtg@mail.gmail.com>
 <ae7e8fc22fcf415d9eb5e4d36ed74231@realtek.com>
In-Reply-To: <ae7e8fc22fcf415d9eb5e4d36ed74231@realtek.com>
From: lu lu <insyelu@gmail.com>
Date: Mon, 19 Jan 2026 14:58:27 +0800
X-Gm-Features: AZwV_Qj0XvqXEOCiPSfKd8c0lFcU4MlofMkQbn7Xgg8yWggEh_lv825eXz0ujMc
Message-ID: <CAAPueM6_GQLcqz+xxKVDOaUZZrDNOnYB_tQ2gaxrUKnDQSZ9cg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: r8152: fix transmit queue timeout
To: Hayes Wang <hayeswang@realtek.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de" <tiwai@suse.de>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hayes Wang <hayeswang@realtek.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=B8=80 10:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Original Message-----
> > From: lu lu <insyelu@gmail.com>
> [...]
> > if (netif_queue_stopped(tp->netdev)) {
> >     if (skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
> >         netif_wake_queue(tp->netdev);
> >     else
> >         netif_trans_update(tp->netdev);
> > }
> > The first time xmit stops the transmit queue, the queue is not full,
> > and it is successfully woken up afterward =E2=80=94 OK.
> > The second time xmit stops the transmit queue, the network watchdog
> > times out immediately because the transmit timestamp was not refreshed
> > when the queue was last resumed =E2=80=94 FAIL.
> > This scenario is logically possible.
>
> This situation should not happen, because trans_start is also updated whe=
n the driver stops the TX queue.
>
> https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/netdevice.h=
#L3629
>
> A TX timeout occurs only if the TX queue has been stopped for longer than=
 RTL8152_TX_TIMEOUT.
> It should not occur immediately when the driver stops the TX queue.
Thank you for the correction! Upon review, I confirmed that
netif_tx_stop_queue() already updates trans_start,
so the timeout scenario I originally envisioned does not actually occur.

>
> Therefore, what needs to be done is to update the timestamp when the TX q=
ueue is stopped.
> Updating trans_start while the TX queue is not stopped is useless.
if (netif_queue_stopped(tp->netdev)) {
    if (skb_queue_len(&tp->tx_queue) < tp->tx_qlen)
        netif_wake_queue(tp->netdev);
    else
        netif_trans_update(tp->netdev);
}
This change continuously updates the trans_start value, even when the
TX queue has been stopped and its length exceeds the threshold.
This may prevent the watchdog timer from ever timing out, thereby
masking potential transmission stall issues.

The timestamp should be updated only upon successful URB submission to
accurately reflect that the transport layer is still operational.

Best regards,
insyelu

