Return-Path: <netdev+bounces-188692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0767AAE395
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDB172317
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F89213E81;
	Wed,  7 May 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSEldiVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278261DA21
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629659; cv=none; b=HpSFcMCRBUFjF/D5usEMZ4tLyPJEPzGMM04WtD/9I+RBE1UtX/r1uk1YG3GdiYxqqbllTlKRDDWYMOwUcLC1keg3IjdN6/dDy+dS35oGUz1aON0/NdHgyI4E59y/dobmUtqm3v19xq2VDPRiPUyUT9LeEcTJ27xDRNbMOS+Wid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629659; c=relaxed/simple;
	bh=SoIhx7rYoma3x4QJjXwtem3r4voSekLN8KJ7DFJCUHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUGfcFn11fJ00vrGQiKeXLDJVV8H8fBwelXRtnMcsjYSsmILgjtqcgQndBSpt+YKKEox3rSoGcc7KBuC2KRc1ZW67w4ePMlROVvwf89hKnvdYQy9QVv6VrKvOF0Rudvkj8FB9llxtZn3r01we8L6mJgwuUwTlfGtqvi78ROSV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSEldiVM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376dd56eccso13659b3a.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629657; x=1747234457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOWpuGjSjBZGrIvkeONlnGI5lOqPZS+eJFMv5U1+B30=;
        b=WSEldiVMlvpXzZzti+3jPMBd3VV+owb6icFRLg7HjoJn50i8fp19gmQ3TXNFh9NC/C
         BFbQbqoudEmfC/ZEL+uhp6RSeEttNZfoYLnjOn8MMBtnR0WazYMKNc5Y8nYIzhixJS3h
         LjxzDTyDysW1fugtwm58LR4VQm01EIgDwZqkQ8lk8x5N8eINmbkxQvGnw+a56HsPDX4h
         zzYtzNasiUhuf4xBR2UrEUZ5/Vbc20V8ZSPU/qOkHU7wS/xaOOYeKtJuTHF0MMzeWulu
         lkCCAmcHlt3Z12B1yOE6bd7OPy6/f5fj+Gg9g4IDTOU8FWXr9ZgJpsoP2xe3QZ/rssOp
         bjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629657; x=1747234457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOWpuGjSjBZGrIvkeONlnGI5lOqPZS+eJFMv5U1+B30=;
        b=k4zMMw018CehRKLtz4EVlKjivHmpYTmcP+N3SYD2veY1AgDODUn373zmck8bs1503a
         mijHNpfpKg+bRjWxOhzC7spF/HhiMiy7V4iYuIQvLgIVXWgACDZvteZnzlj/TdXTWl9Q
         xiVEgzWrunD2/VwnmkZLA8MFu6aG1RHxdhfq7DrKkgMtkF6MqNahquzXDfmYOQytnD17
         d8dCjbydIwwfN/IAmCOOHnOurKCqNmbKm13HjfjlKZPb8TlWRHSU9MQqXz3l9qT9xLbe
         tptj6P8Rf+YoPXYPlY2+P9O+5snMyumSJyLNahachYC7p9hzMpKben78wsrz4FsMUv4A
         F3qw==
X-Forwarded-Encrypted: i=1; AJvYcCVvAutNTGyQ79kSVkMTTjp7bBaHCV6wm5NyKMgwQnA0UN9Rzxq0apmz6IIIFXXx97WpcOy1oBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mTVEah2DAOclH1RC/3WwijIIZrLTSQCUR7wypeJt1cObHzto
	zsJxFNs9AQYSXZjKxRDEiB3/TlitN07V63h5oF3H04xUJl2QfQggjaPg2E8aGpA7X+u/qNPNGaO
	/verEQ99Mo7d9OpIaCf7D+G/P1yqc/M/wAwY=
X-Gm-Gg: ASbGnctoJkcFyQCRbNbJLCFK/cSChNhMuV3OJLq4H88UnasMj5ExpzY6wMD2KRG/LLG
	zthUv+HVY+ZX5a3vFKPulLS0DYhlTcil2ccNaL56WnfJMbx0v0juH30JHAlUqySodaTuF7le2ar
	3X/+DySQnYlPRCkEr2WEN6
X-Google-Smtp-Source: AGHT+IFNvGZ+DEYEXKW0B9YV2+DO4I0tiY7sB529MeZ8z2cnx0UOs+r85SbOUXdVIFgaArcXxT5vljAEQMmGPcZyM1w=
X-Received: by 2002:a05:6e02:144c:b0:3d8:1e50:1d51 with SMTP id
 e9e14a558f8ab-3da73908592mr37437245ab.13.1746629647101; Wed, 07 May 2025
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507030804.70273-1-kerneljasonxing@gmail.com> <681b5ebc80a81_1e440629460@willemb.c.googlers.com.notmuch>
In-Reply-To: <681b5ebc80a81_1e440629460@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 7 May 2025 22:53:31 +0800
X-Gm-Features: ATxdqUF3LLyCla5RywYUlJILbIaorGy0nMY6kjwnpahuv7rJMFZ_9WvJuELitag
Message-ID: <CAL+tcoC606GBfwo3BY_7vn3jPQJdC=78h9q-110hC3DCYRg7jQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: thunder: make tx software timestamp independent
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, sgoutham@marvell.com, 
	andrew+netdev@lunn.ch, willemb@google.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Wed, May 7, 2025 at 9:23=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > skb_tx_timestamp() is used for tx software timestamp enabled by
> > SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is controlled by
> > SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
> > timestamps in two dimensions, this patch makes the software one
> > standalone.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drive=
rs/net/ethernet/cavium/thunder/nicvf_queues.c
> > index 06397cc8bb36..d368f381b6de 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> > @@ -1389,11 +1389,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, str=
uct snd_queue *sq, int qentry,
> >               this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
> >       }
> >
> > +     skb_tx_timestamp(skb);
> > +
> >       /* Check if timestamp is requested */
>
> Nit: check if hw timestamp is requested.

Thanks for the review. Will change it.

>
> > -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
> > -             skb_tx_timestamp(skb);
> > +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> >               return;
> > -     }
>
> The SO_TIMESTAMPING behavior around both software and hardware
> timestamps is a bit odd.

Just a little bit. The reason why I looked into this driver is because
I was reviewing this recent patch[1]. Then I found that the thunder
driver uses the HW flag to test if we can generate a software
timestamp which is also a little bit odd. Software timestamp function
is controlled by the SW flag or SWHW flag instead of the pure HW flag.

[1]: https://lore.kernel.org/all/20250506215508.3611977-1-stfomichev@gmail.=
com/

>
> Unless SOF_TIMESTAMPING_OPT_TX_SWHW is set, by default a driver will
> only return software if no hardware timestamp is also requested.

Sure thing. SOF_TIMESTAMPING_OPT_TX_SWHW can be used in this case as
well as patch [1].

>
> Through the following in __skb_tstamp_tx
>
>         if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
>             skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
>                 return;
>
> There really is no good reason to have this dependency. But it is
> historical and all drivers should implement the same behavior.

As you said, this morning when I was reviewing patch[1], I noticed
that thunder code is not that consistent with others.

>
> This automatically happens if the software timestamp request
> skb_tx_timestamp is called after the hardware timestamp request
> is configured, i.e., after SKBTX_IN_PROGRESS is set. That usually
> happens because the software timestamp is requests as close to kicking
> the doorbell as possible.

Right. In most cases, they implemented in such an order:

                if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
                        skb_shinfo(skb)->tx_flags |=3D
SKBTX_IN_PROGRESS;

                skb_tx_timestamp(skb);

Should I adjust this patch to have the same behavior in the next
revision like below[2]? Then we can get the conclusion:1) if only the
HW or SW flag is set, nothing changes and only corresponding timestamp
will be generated, 2) if HW and SW are set without the HWSW flag, it
will check the HW first. In non TSO mode, If the non outstanding skb
misses the HW timestamp, then the software timestamp will be
generated, 3) if HW and SW and HWSW are set with the HWSW flag, two
types of timestamp can be generated. To put it in a simpler way, after
[2] patch, thunder driver works like other drivers. Or else, without
[2], the HWSW flag doesn't even work.

[2]
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 06397cc8bb36..4be562ead392 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1389,28 +1389,24 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,
struct snd_queue *sq, int qentry,
                this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
        }

-       /* Check if timestamp is requested */
-       if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-               skb_tx_timestamp(skb);
-               return;
-       }

-       /* Tx timestamping not supported along with TSO, so ignore request =
*/
-       if (skb_shinfo(skb)->gso_size)
-               return;
-
-       /* HW supports only a single outstanding packet to timestamp */
-       if (!atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1))
-               return;
-
-       /* Mark the SKB for later reference */
-       skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
+       /* Check if hw timestamp is requested */
+       if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
+           /* Tx timestamping not supported along with TSO, so ignore
request */
+           !skb_shinfo(skb)->gso_size &&
+           /* HW supports only a single outstanding packet to timestamp */
+           atomic_add_unless(&nic->pnicvf->tx_ptp_skbs, 1, 1)) {
+               /* Mark the SKB for later reference */
+               skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
+
+               /* Finally enable timestamp generation
+                * Since 'post_cqe' is also set, two CQEs will be posted
+                * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
+                */
+               hdr->tstmp =3D 1;
+       }

-       /* Finally enable timestamp generation
-        * Since 'post_cqe' is also set, two CQEs will be posted
-        * for this packet i.e CQE_TYPE_SEND and CQE_TYPE_SEND_PTP.
-        */
-       hdr->tstmp =3D 1;
+       skb_tx_timestamp(skb);
 }

 /* SQ GATHER subdescriptor

Thanks,
Jason

>
> In this driver, that would be not in nicvf_sq_add_hdr_subdesc, but
> just before calling nicvf_sq_doorbell. Unfortunately, there are two
> callers, TSO and non-TSO.
>
> >
> >       /* Tx timestamping not supported along with TSO, so ignore reques=
t */
> >       if (skb_shinfo(skb)->gso_size)
> > --
> > 2.43.5
> >
>
>

