Return-Path: <netdev+bounces-212328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314EB1F4B3
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 15:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F7E188A107
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84070299920;
	Sat,  9 Aug 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Duc/2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9378224AF9
	for <netdev@vger.kernel.org>; Sat,  9 Aug 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754744976; cv=none; b=tiU/sIO5CFiAV7Sw+y6kCY3NuaqHQbPqzEDIhgs/lgI0IHbVIbJvXH92wS/6H4PglJgwxWq8tw6lreLXDJJgEHVrfq4gYPB1q8wIO9KDZW8lAs5FLjXYRnawqqgAaArzJYFuE3KBysDBaXfs+wQX/k1WuDpQmb1XvS5tY4th3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754744976; c=relaxed/simple;
	bh=uSbdygyrBVvZxJUr1ov8s2P/BqjVWCpkbgQ3U7jw3V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4aJfkmxhpFGhmsTNLqFM9MQ1EhzFxv/emzg9tQT+Cnn17cl/3gf5jI0wzAUvHTHwchSR361O7wFFeNHQaPOPtRW2ByX/xygd/3G1mOzPU5WzlIz6iVWuUmC+fEMKgVL2aAQCIWrjdAAfBq8RWpia4+zNaSY9UOT/5ftKTzphGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Duc/2V; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e51dc20af6so30062235ab.0
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754744974; x=1755349774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OrjFGAwkfNSFAA+5ug9IBizh7kH96douvTjqdvEjYE=;
        b=O8Duc/2VwJ9kFl8vlhCjoZ2w1tpiWblenYtvog5cLnfAymx3EHmZhDw9AW7kJ3Y06F
         AqJg+zJBbl9Hnd+2oUqi212aj60CXTr31tt0e03gex7Vf12R2k2679CBWzBoMnRJ+1nT
         wOmQFElRyEXOK/zazGAXIdywpVZtIdNjkscB9imWDNdHH650ghm+mmyjIi8L+u1z8Pnw
         VXZfmgmBDiOugDX/t5gOi2SQIihBTfxZ+tXbmKMHEh9UbE+3DFHkssYBPGiKl2lxhQmG
         uXoqKCoxxzlC7ACLTUMSCGaF16tpZoYhKMy8LbFd/UdGRFiB84opS1/XKR8OTxP4kEoP
         Hxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754744974; x=1755349774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OrjFGAwkfNSFAA+5ug9IBizh7kH96douvTjqdvEjYE=;
        b=WN+B1ktoIBgAd6zqd51zbbWTO1oZeKzTA+S5r7F/G5l/dbE8mw3GKG/2pA1gYVNtK7
         iMbyyXPHIrxBq59wa8InVJf7UMJRHmNMMPF/DtEh5CfAcUSN+auEh42ibQFvAa8NdHoF
         soQasOZybDgQVcdumfegh5ewDFZ94PnL61f/DDl1syu1rF7Kr3sCdEltn9bv1DBPinxy
         dgRSTUwghjl9Gu8ITEjNeQaBgC1zSnwTyHBd+Awb6fSt/k0rMyYleM5RU8CUM98+9Xmz
         oxP6wVhsa4S9hcPidWSojewd9g6YdRgQZJdw7jWFtPyvfZ6jXZXikP7PFVF0QuUL8y3C
         A+7w==
X-Forwarded-Encrypted: i=1; AJvYcCVJVx0BbKG4D/4+ORQoConVNRi/xwzOO2RAQeFAtn0hkP3c+EQ+NTnMq5Jji+A77oxQgnYNpaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxilWFy2YESsVYV44LzfFPApr2Gld2pEp15x3W8DkQYLw+RNxHX
	XyC7QvTdjasjblU9SvBOg5vrXta7eNsPSVDzxHK4x+e7kFD7czSTJe4bw1W5HOAr1BajgZMp9Ma
	dmraFYwglUW1pIoCmTNcy2syRdi3P3PY/jzK0yT8=
X-Gm-Gg: ASbGncvtzfd0AJ1wt20odOBhQvhdC64rLQbQFCXrjVxT5dwGJ3EqkmVmFk/PQf1RFX3
	fkj3oigv23rJe1JeeZunVHuGnqZ+jX5GzIKmJHq7Vl+U68Ac8+Gc0DIrLuQiCryGomRN9Wl+Q3e
	OOGJuhvGeLhEOMwKg85q1qhrWyzZMlorOiYV53lcZap4gEIQKgPCvi9kGm23Lhq1RQH8osa8AFx
	OaJHw==
X-Google-Smtp-Source: AGHT+IEj/5diw1x6t3oBja6pdYbs7BRP7xf/2ER3ZQVGxRyqo2mjGTRIKy4RYDPHOMzD5+tv7qBPUwZ6TxnN3a/LCP4=
X-Received: by 2002:a05:6e02:4803:b0:3e5:4002:e827 with SMTP id
 e9e14a558f8ab-3e54002eab1mr29650055ab.6.1754744973831; Sat, 09 Aug 2025
 06:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808155310.1053477-1-michal.kubiak@intel.com> <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
In-Reply-To: <f0752ae6-25f8-4504-b23b-052f60007deb@molgen.mpg.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 9 Aug 2025 21:08:57 +0800
X-Gm-Features: Ac12FXx4B1r38bknRw5Xn30GyYa0hLcpfX0rKbL00PRYhHhmWKJ6R_KfYOGkoTo
Message-ID: <CAL+tcoAwKcy-E6LkLhwvKA9+es5RuFmg4+kPZ8dV08-s-VopPA@mail.gmail.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation failures
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org, 
	maciej.fijalkowski@intel.com, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com, 
	aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 5:38=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> Dear Michal,
>
>
> Thank you for your patch.
>
>
> Am 08.08.25 um 17:53 schrieb Michal Kubiak:
> > Currently, the driver increments `alloc_page_failed` when buffer alloca=
tion fails
> > in `ice_clean_rx_irq()`. However, this counter is intended for page all=
ocation
> > failures, not buffer allocation issues.
> >
> > This patch corrects the counter by incrementing `alloc_buf_failed` inst=
ead,
> > ensuring accurate statistics reporting for buffer allocation failures.
> >
> > Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side"=
)
> > Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> > Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> Thank you, but I merely asked to send in the patch separately and didn=E2=
=80=99t
> spot the error. So, I=E2=80=99d remove the tag, but you add the one at th=
e end.
>
> > Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> > ---
> >   drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 93907ab2eac7..1b1ebfd347ef 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *r=
x_ring, int budget)
> >                       skb =3D ice_construct_skb(rx_ring, xdp);
> >               /* exit if we failed to retrieve a buffer */
> >               if (!skb) {
> > -                     rx_ring->ring_stats->rx_stats.alloc_page_failed++=
;
> > +                     rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
> >                       xdp_verdict =3D ICE_XDP_CONSUMED;
> >               }
> >               ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>
>
> PS: A little off-topic: As this code is present since v6.3-rc1, I
> wonder, why this has not been causing any user visible issues in the
> last two years. Can somebody explain this?
>

From my limited experience, upgrading to the new kernel (like v6.x) is
not an easy thing. Plus not that many people monitor the driver
counter on the machine with the ice driver loaded. Sometimes we
neglect this error because it doesn't harm the real and overall
workload even when the allocation fails. Things like this sometimes
happen in other areas :)

Thanks,
Jason

