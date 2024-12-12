Return-Path: <netdev+bounces-151399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9C9EE913
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286121629DC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591A221D88;
	Thu, 12 Dec 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV8Tpkap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54412210DE
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014268; cv=none; b=OTBb5QOfrgLNby1yAV/GkyVvrEfLhXcYP8LUT02NVAynRpYQOOomXH5nczLaGyZUPgJwqpOz3b6Jr0Z8ycVqm9Ba4afRJGNDbbArXT9dXSiprNHcywRA49dL41p6/L9qznSY4CVLIvMDiYbO4MR+/Hvc+BtQBrjEMzXK6DQRvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014268; c=relaxed/simple;
	bh=+TlFvNHJHF5tho7Dqa+Y+pqCbAO32ol6liQK2HH/nQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZtRXhyBr4HYl/i9idTo8bCF+cJyH9LANB7Kw39BdcW+ZcpSfCZ+lvjZ2jjMaBydR4KbNJuLjSZp2V++I5OATyaD7Lh+sYC8QjnCHKC7/S23dGYBrZPHhXLxscd/CJ1zhlDhVQHoVkLYCwLZJHwpgMFwzxT4cZC/BREakckI4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV8Tpkap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734014264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/lNXI+8M0n8eJY5iUx6+M/CTKNVaD2xKSgg15F84h8=;
	b=SV8Tpkapijf+VL0anGcnal675AUWyR59hBAA44Y7XuqiVrWI/Q0aLsuFUaVSGkTTgMjwev
	WRVSg4VHxSOWUI+H8gmZy5lZt76Uynvrhtnt8gHk8vy/kOogNTNPlG2DPza0e7yMev+OOK
	rbs68zGnARiUh5Ytcla2k6Z/ejMGPck=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-dsTDK_dFMrWfnCpsB8sOLQ-1; Thu, 12 Dec 2024 09:37:43 -0500
X-MC-Unique: dsTDK_dFMrWfnCpsB8sOLQ-1
X-Mimecast-MFC-AGG-ID: dsTDK_dFMrWfnCpsB8sOLQ
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7fd481e3c0bso520231a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 06:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014262; x=1734619062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/lNXI+8M0n8eJY5iUx6+M/CTKNVaD2xKSgg15F84h8=;
        b=AZ1F5yH03I7C897sEyOVORP1RcIXVBU6MWnzvMDPlu4XqDpZPZA7U+jE5TeSxbUvOp
         XmwhxTk6oud8gL5TlJF/zg/N1qvrx6NQgLCh45Xc7/Ocre/tM9RCIaa6URb8tWK9Hmdc
         iQ1EuYsY8iXa64AoU7xaDWf57ny9YpAZo8TikmuSabiS8mIfQ07A+5UVxVoq3omipKYF
         5AowOal7AfavoBtwYb4LeDq73Sr5gDdv7LlLFamg9sAcFrJRkbAwwVeHlDWS8QuHbMcF
         xxit+Rvrh3ZT5eY8uM9QnY+I5ecx8mwXUKtsytgzfhtF2gKd7O/iLaoqNVvHgBFeGRAZ
         HFmw==
X-Gm-Message-State: AOJu0YxT5DhQqz3dIdxHvzGf9NgpF/CYzSojWH4RXpisaQIfoE96nQ1W
	ATI36gNwzoZOoLXO3Ivw5X0QFrEtFyt8BIrVB82HL2v6SfLc32J4FiqAY4Z7lMmP/SaKN/IO1Ec
	XTY2JA0xT1PSPpbpZdlDSAunZb/nTY+d6ktwjeNty4NKf7YOXCvqAP3ZW5bntxMXDCt7ldXzt8O
	rDtEszFiV4b081xlSfEqA9FCd1INE2
X-Gm-Gg: ASbGncvagaZwQYQ/CIFiTEah1YLrpPi+AGApeRkZLjjBRtPUOXLboH3gZeRCuRnp1v7
	SayH+MRAI7qz8mGavH1NRVgnHwIJbQCdZ2KKW2t7y1YEkKGGyYFRw5skKH1zf6UX2CMTc5g==
X-Received: by 2002:a05:6a20:a123:b0:1db:e338:ab0a with SMTP id adf61e73a8af0-1e1dab0aa49mr797952637.8.1734014262684;
        Thu, 12 Dec 2024 06:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHfe9XwTKVDY9ZgtiCkmKaVwbwJg1aTorRZobzbqft4LrMM1t7WMmFTzJ7s7SCwajPQGYRd3ULF9pkcTLmfN4=
X-Received: by 2002:a05:6a20:a123:b0:1db:e338:ab0a with SMTP id
 adf61e73a8af0-1e1dab0aa49mr797919637.8.1734014262451; Thu, 12 Dec 2024
 06:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733930558.git.lorenzo@kernel.org> <b4d34136f5ef0d43e2727c2bf833adb41216cdc1.1733930558.git.lorenzo@kernel.org>
In-Reply-To: <b4d34136f5ef0d43e2727c2bf833adb41216cdc1.1733930558.git.lorenzo@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 12 Dec 2024 15:37:31 +0100
Message-ID: <CAKa-r6shd3+2zgeEzVVJR7fKWdpjKv1YJxS3z+y7QWqDf8zDZQ@mail.gmail.com>
Subject: Re: [RFC net-next 4/5] net: airoha: Add sched ETS offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Lorenzo,

On Wed, Dec 11, 2024 at 4:32=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Introduce support for ETS qdisc offload available in the Airoha EN7581
> ethernet controller. Add the capability to configure hw ETS Qdisc for
> the specified DSA user port via the QDMA block available in the mac chip
> (QDMA block is connected to the DSA switch cpu port).
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 155 ++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 1 deletion(-)
>
[...]

> +static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
> +                                       int channel,
> +                                       struct tc_ets_qopt_offload *opt)
> +{
> +       struct tc_ets_qopt_offload_replace_params *p =3D &opt->replace_pa=
rams;
> +       enum tx_sched_mode mode =3D TC_SCH_SP;
> +       u16 w[AIROHA_NUM_QOS_QUEUES] =3D {};
> +       int i, nstrict =3D 0;
> +
> +       if (p->bands !=3D AIROHA_NUM_QOS_QUEUES)
> +               return -EINVAL;

maybe this condition can be relaxed to '<'  if priomap is parsed ? (see bel=
ow)

> +
> +       for (i =3D 0; i < p->bands; i++) {
> +               if (!p->quanta[i])
> +                       nstrict++;
> +       }
> +
> +       /* this configuration is not supported by the hw */
> +       if (nstrict =3D=3D AIROHA_NUM_QOS_QUEUES - 1)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < p->bands - nstrict; i++)
> +               w[i] =3D p->weights[nstrict + i];
> +
> +       if (!nstrict)
> +               mode =3D TC_SCH_WRR8;
> +       else if (nstrict < AIROHA_NUM_QOS_QUEUES - 1)
> +               mode =3D nstrict + 1;
> +
> +       return airoha_qdma_set_chan_tx_sched(port, channel, mode, w,
> +                                            ARRAY_SIZE(w));

it seems that SP queues have a fixed, non-programmable priority in
hardware (e.g., queue 7 is served prior to queue 6) If this is the
case, you probably have to ensure that 'priomap' maps correctly
skb->priority to one of the SP queues, like done in [1].

thanks,
--=20
davide

[1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/net/ethernet/mi=
crochip/lan966x/lan966x_ets.c#L41


