Return-Path: <netdev+bounces-78758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A58765C7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3382B1C20A26
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F93D0B9;
	Fri,  8 Mar 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GofPnRJp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC13BBE1
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906328; cv=none; b=qXfOoYANMZ4P+N5rama3LEKfqadV7HB5rMc5++4tlwjngV2ZXxQml87Ko/Ulvry8WQMv2E/xKXSpdTg1J0BuSl9HPUuBi3uNUhiAW6jwXw1VL3GnVWCp8EZtKZC4YcPtZTkcKHbq2FoxGAHTc0yCHDHqcyUKkjwt9xm0s2Mh2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906328; c=relaxed/simple;
	bh=A5c9YnK1XD9ztw+bdW/Fk6cIH6yGwP9iehA1nCjEi4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzxXVDgSZ/N3riZOn2YzN9SuHwuZEEep66eWRIyNdCYppHTtMgebG33XUmmwoeOlhA3vcg6y7YubIPbUIOPoAOK72iL3sMY7J5mbEG5KnGVuZG5i0vJwEIBAroGIBeS6q1jj5yLemt9iZJVUCF0ezm90kVTd7xb6DPtuO9b/DPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GofPnRJp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso8531a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 05:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709906325; x=1710511125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBuF/mE2iPFE868dDTOlE0JcE/uZlhA0RB3KdQyjGQw=;
        b=GofPnRJpRAfaOK58ko4ChMpBx/aS11ZXqFvb7fUSY9kZXk5K1MuLMJNUE15/1KG8g7
         COo7E9ORzGYycnnGOImLmnnkBbl27GsfV73XwgTbmN1aNAQmzkGHsu/LyidsADujVHSw
         cMcOvyw2aTn8H9pDGKztWeOqIRhE1nPlk7BImZC1KShyJf0CYe1kz/kIp504ABx+BLvj
         Fp+X8EtpIuvPwoxfycwiJrHteuoco7ZMP/299TPptctFABkVGIfZrhChj5r4+PdKQ97P
         7MVawTIa2yNhi4nZqK4dH7wlt6apWgEHkKvvxc0usfVJXrsbPGAEaEPpz233B8NxyzpE
         dxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906325; x=1710511125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBuF/mE2iPFE868dDTOlE0JcE/uZlhA0RB3KdQyjGQw=;
        b=jhALIoQat2cgzNYv5TsQwPihMJpzxQCzMfMm3qdRJ/e20omPnJ2fAhLsC9xHGkLhvH
         xZtbTmm3XrSyI18be+lz7NFpAJHJ6jyNzXN2oJzaAY0QFPbQ4LNq6sPr2QBNcoLHLbz7
         25SWAcc7+Dk/ZQVCvKwU/CU3+sstudNpxR6LButfZuhMgD4vDHbIRqGaLFf/6wCJ1EeA
         p+eUtkVKxpxT1MYdIt1iimKx/9s9B7gw9mV0wfN90ykj0Qve5riuZNQFKIjMEsphn0kd
         i8x9DUUq/zDPh+LKe1IWrX+z9iel17owouLDWn6KYik3DtkkBxvtI7Xi5JhuW3B8T12b
         40Kw==
X-Gm-Message-State: AOJu0Yx1XmmrI4wD1+gvbr411anFkXlGlxMysierednXnOUWZZB80UjB
	GCkFTTBQkIEwkHAKNtNxtjZQJkvJ4NnLwEyMe6cXi0wAiUpf0V7K/iEK3ulPDLiGcYq+cyjMRhY
	cD74WEsex33/i1nctBpNH1+OlTP0g0b891qFq
X-Google-Smtp-Source: AGHT+IEPWOFnbJg6WMrmkfNOZFtD9RE1AXOQNc1JoZLoDt1clsy51MvKrKJBXMcXzd9Ed4AvBLsruItkGrALYbUZqEg=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr490497edd.6.1709906324710; Fri, 08 Mar
 2024 05:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308115722.14671-1-gakula@marvell.com>
In-Reply-To: <20240308115722.14671-1-gakula@marvell.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 14:58:31 +0100
Message-ID: <CANn89iJ2euG8SgmTpifRK2DV1N+PSPAgiSoZP-W+7YWE3Ygv6w@mail.gmail.com>
Subject: Re: [net PATCH] octeontx2-pf: Do not use HW TSO when gso_size < 16bytes
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, sgoutham@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:57=E2=80=AFPM Geetha sowjanya <gakula@marvell.com=
> wrote:
>
> Hardware doesn't support packet segmentation when segment size
> is < 16 bytes. Hence add an additional check and use SW
> segmentation in such case.
>
> Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index f828d32737af..2ac56abb3a0e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -967,6 +967,13 @@ static bool is_hw_tso_supported(struct otx2_nic *pfv=
f,
>  {
>         int payload_len, last_seg_size;
>
> +       /* Due to hw issue segment size less than 16 bytes
> +        * are not supported. Hence do not offload such TSO
> +        * segments.
> +        */
> +       if (skb_shinfo(skb)->gso_size < 16)
> +               return false;
> +
>         if (test_bit(HW_TSO, &pfvf->hw.cap_flag))
>                 return true;

How is this driver doing SW segmentation at this stage ?

You might perform this check in ndo_features_check() instead ?

otx2_sq_append_skb() is also forcing a linearization if
skb_shinfo(skb)->nr_frags >=3D OTX2_MAX_FRAGS_IN_SQE

This is quite bad, this one definitely should use ndo_features_check()
to mask NETIF_F_GSO_MASK for GSO packets.

Look at typhoon_features_check() for an example.

