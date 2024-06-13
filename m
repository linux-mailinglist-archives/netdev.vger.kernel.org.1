Return-Path: <netdev+bounces-103279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2379075CC
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFB281FD7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97C13CA9A;
	Thu, 13 Jun 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIj78LMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF482C76
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290556; cv=none; b=tfKUu6WYMsgRkeJxAeSoRMwaR0WHH69wHGNNTlIYeRzSAXWQGvCVwesvUimA0QUKBULzDbY8ZmEOdx+9TZYqoCwbBzqOr5TBcwLfdSMhKlPoHL9dtnIDVf6maI0yImbWsbGbwUbgFS6JukcbZ0JfMzLpvissHdTL+kCUDK+Xp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290556; c=relaxed/simple;
	bh=I9eCKOXgkAwUuXOFl5nEg/hz71moPfgCgg6FblIWQZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cflb7OW3/QB2JTE1imuU9A/VlZCFi2P0Ztv0BTgQvUe/AC/kmQj2zXSN99hc45fwTti3Jra9Vy0vBhMODVorlPTxfUGwUAD+PIMG9/+gnrav0/2RkUz/AF73sMye7LRQR6cPw8JPqRLNffzuqQ9Ddb7EMXwo3/LRUUDyqq4oL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIj78LMH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso209417666b.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718290553; x=1718895353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9eCKOXgkAwUuXOFl5nEg/hz71moPfgCgg6FblIWQZ0=;
        b=dIj78LMHHQAlgHUeHMuGX8k45QLgSpHmDedUD+Fdo3vkka1eN9GH6cBfLm7s2qPUXL
         suR/53bNk/Pn+XT3sEYsSMK8OV4F1w0iLjSPO2aYV157SBeugxp+DUK0wGbyp/Tg1xN+
         Pk6rz0/N3z4d5HHGmL3Hwevp6w0ToxfuHCFIv+Nx4Apu7SLWhc1r0XQEWn4lu2SpCf1N
         PYtUfGHxeBLV8bYd3y8GXHgFdunf/L2xaKUsi5xKH+Zda9+PcH3c3IgNarLt2YLYKEFs
         FLeLyom6YMIlWbMgjOvp/Ygh9gKMC1GFWH1hzuGhzjIQh7if4BS18KtM84KhH38raMkb
         5Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290553; x=1718895353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9eCKOXgkAwUuXOFl5nEg/hz71moPfgCgg6FblIWQZ0=;
        b=CzLNccdZkN2WF/jTmbFkGmn63tcMvoLk/1CclkbP8yvxbJJvABbQo4S/HGMKkHOedA
         LPcZ+d5HuWkwC18/TKmYM0e5IQ2BflueDuK6abfMLm3L26cBoVslhCDwe8TUFItcGAhM
         /sefWU52uhj3TzQV2nyGmF3PNsEM51/GaMs9Gpw4ij6Gq6iJzfYBjk44/GwDUvTB5kmE
         vpkdu9n4VW8h2kXypGOh4RofQLqy3KKatxAUKJNWIy1/i6Fp/AqqCChzsIteKKm+NUfc
         vSkjCcT+TGAa5Mm5QTbV1Xr+dWTtn2sDb5jPo5xw1Sms0E+YF4M9hfp9zeeOr/eZk+zS
         f/aA==
X-Gm-Message-State: AOJu0Yw/FpKqoFk6XDKf7e6+3JeiJW6ENokcKK4RhEJbD0pfNruj6uQ0
	v8rMQ6CifgFItFxE5f8vxRDwh5R2CaFEUn9utu0UVtFhpiHlh4I9wRRFnuNoAWV5PpkWnh6tdA/
	sQyAe45FY9ZBHQaf9n+LF1Jhz3fs=
X-Google-Smtp-Source: AGHT+IHU39xBmv4HOV7um4Ve41iC980h91Na4YJv90/BwgO94R8iI5wQVVQ0Ej/e4QumTdA5Mmof8rDrngCecSattkk=
X-Received: by 2002:a17:906:7f0e:b0:a6f:55e3:ee5f with SMTP id
 a640c23a62f3a-a6f6082e3a2mr4911166b.9.1718290553234; Thu, 13 Jun 2024
 07:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023549.15213-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240613023549.15213-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Jun 2024 22:55:16 +0800
Message-ID: <CAL+tcoAP=Jg3pXO-_46w5CbrGnGVzHf4woqg3bQNCrb8SMhnrw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag
 for non-BQL drivers
To: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, leitao@debian.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
> BQL device") limits the non-BQL driver not creating byte_queue_limits
> directory, I found there is one exception, namely, virtio-net driver,
> which should also be limited in netdev_uses_bql(). Let me give it a
> try first.
>
> I decided to introduce a NO_BQL bit because:
> 1) it can help us limit virtio-net driver for now.
> 2) if we found another non-BQL driver, we can take it into account.
> 3) we can replace all the driver meeting those two statements in
> netdev_uses_bql() in future.
>
> For now, I would like to make the first step to use this new bit for dqs
> use instead of replacing/applying all the non-BQL drivers in one go.
>
> As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
> new non-BQL drivers as soon as we find one.
>
> After this patch, there is no byte_queue_limits directory in virtio-net
> driver.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hello Jakub,

I wonder why the status of this patch was changed to 'Changes
Requested'? Is there anything else I should adjust?

Thanks,
Jason

