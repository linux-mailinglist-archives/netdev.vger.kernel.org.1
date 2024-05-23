Return-Path: <netdev+bounces-97732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24C08CCED3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377A51F21E06
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740C13D26B;
	Thu, 23 May 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh11Bsrr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7013CF93
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455701; cv=none; b=fIZeYcXMX0TplpFr8jfKymcoTmv1IgbQ2CFPynRCiqhnMoLz/0dsQE7RlU72IkoCUKmvfQyHUkPzm3v03DwFIS9X5YMBzAjq0CYkQHoRqUtwRCwuhO4hc+x1Qn1qFfJVH6OPx7fsBia13aT7bir6OLVXLYG4alfLwi5hRITxTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455701; c=relaxed/simple;
	bh=/lMyxSjqLAl6OgWHts/xND+IPoIxTxQRqei4HueBex0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mp5BBN0r7L54rC0YRjC6jn+nFDw0aTT334EbFxHeeOVEOjvLOg/2t0jAkPXsxY20XCI2G+yCBI/XhOqd9L6lyQ+bnGTXh7HH2rqu2bvL37fkZa3OCGRl3Ixiab0hGUjwbPV4WnXw2aqvlBFzG8dtfSZRccjnIo7fdnHfSQeYYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kh11Bsrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716455698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z1PA5QvJHm8ykHTiGZm5aAca1OGkhXqgReaXY3/hb/k=;
	b=Kh11BsrrmgaMTLw/6ARNc5JgGaol1+oPbNrllapKjK25kVDOTB3cm7fkIEN8/8CqyWfdZu
	vv2bv0lhefQvoSSj1hLzkFkHAZxu7IPOHObQcmGptZt7n2iu7JO8Y/AGT34Z7ksh2BS4fW
	Zl4/qT8pQWyF4byAukr1P8jSvSMuOCE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-S6Bw9_bEPD6Vg5QdgqNIMw-1; Thu, 23 May 2024 05:14:56 -0400
X-MC-Unique: S6Bw9_bEPD6Vg5QdgqNIMw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792c88ab364so26946185a.3
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 02:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455696; x=1717060496;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1PA5QvJHm8ykHTiGZm5aAca1OGkhXqgReaXY3/hb/k=;
        b=CJtAbZ8pSiTejS3tln7T41XxB19jZ7zwaV8Lcc6HiOIObZtoqbws38pihnywVTLCfv
         PXVu3Jjmr6+oiYxd5Dk3lFjtaiA2xVWCAusEgEBST/H/hNpoGkQZB7RyzUCW9pp8lmU8
         TBSkRO+7ZjxWZBRRdQth1KzW3v6bwwPNXnfmwTC03S6/W+pNHFKqGPvJUMXLJUqK+6/H
         y8hncooJWO/yn7edO7D9N+JqUwLHDSsyKe0NMK9AKgrrQv+ywx+Tz/FcObOlg7vKUYvb
         zdJQ8Y0HUowZVsTypLWb3RRhrOr1OJjpokZ6hENs+6DbVTVn21Qw1fbiw/vGLbcdjizU
         1Ozg==
X-Forwarded-Encrypted: i=1; AJvYcCUoVE7vSI9pKTv7seZ9KUmTuEQhvmVaoVT0lnMIy+7ui6q1QXqx1rbUZjFB+PtaLVA+DTwlGb8Z4cdC70n1D4nC6o2UB+Kd
X-Gm-Message-State: AOJu0Yxa6sAcMGNA1iY/MRBgo9v0+hZct5XwdK8HiPtkfGKB1D9CnBOw
	+yAEC5AzYYsjgNa9FpzYshwXGJcT5uCkpsWRNLWUd6zN93P/xZa18iERwDlTwrywn63LGwPOjQB
	t5kxeY7qZGPsJpUA1jJOhtu2BDiCZdwUisbRolbvjLxmjWwi2EY9skA==
X-Received: by 2002:a05:622a:1a27:b0:437:ca6d:13f1 with SMTP id d75a77b69052e-43f9e0b65e2mr43549911cf.2.1716455696286;
        Thu, 23 May 2024 02:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElwc+jZj9lrO25a2CjKzzWCgMw9ch4Fg63jKPkRB/jxh+xOlJFXYNQENPC+6K3Ua0ypfW6GQ==
X-Received: by 2002:a05:622a:1a27:b0:437:ca6d:13f1 with SMTP id d75a77b69052e-43f9e0b65e2mr43549701cf.2.1716455695822;
        Thu, 23 May 2024 02:14:55 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e09f7862asm156096621cf.91.2024.05.23.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:14:55 -0700 (PDT)
Message-ID: <e21fa14dd33ddac7dcdd08a50fcad3f87a8f76aa.camel@redhat.com>
Subject: Re: [PATCH v2 net] net: fec: avoid lock evasion when reading
 pps_enable
From: Paolo Abeni <pabeni@redhat.com>
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, shenwei.wang@nxp.com, xiaoning.wang@nxp.com, 
	richardcochran@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev
Date: Thu, 23 May 2024 11:14:52 +0200
In-Reply-To: <20240521023800.17102-1-wei.fang@nxp.com>
References: <20240521023800.17102-1-wei.fang@nxp.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 10:38 +0800, Wei Fang wrote:
> The assignment of pps_enable is protected by tmreg_lock, but the read
> operation of pps_enable is not. So the Coverity tool reports a lock
> evasion warning which may cause data race to occur when running in a
> multithread environment. Although this issue is almost impossible to
> occur, we'd better fix it, at least it seems more logically reasonable,
> and it also prevents Coverity from continuing to issue warnings.
>=20
> Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock=
")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 changes:
> Moved the assignment positions of pps_channel and reload_period.
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ether=
net/freescale/fec_ptp.c
> index 181d9bfbee22..e32f6724f568 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -104,14 +104,13 @@ static int fec_ptp_enable_pps(struct fec_enet_priva=
te *fep, uint enable)
>  	struct timespec64 ts;
>  	u64 ns;
> =20
> -	if (fep->pps_enable =3D=3D enable)
> -		return 0;
> -
> -	fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> -	fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
> -
>  	spin_lock_irqsave(&fep->tmreg_lock, flags);
> =20
> +	if (fep->pps_enable =3D=3D enable) {
> +		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +		return 0;
> +	}
> +
>  	if (enable) {
>  		/* clear capture or output compare interrupt status if have.
>  		 */
> @@ -532,6 +531,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>  	int ret =3D 0;
> =20
>  	if (rq->type =3D=3D PTP_CLK_REQ_PPS) {
> +		fep->pps_channel =3D DEFAULT_PPS_CHANNEL;
> +		fep->reload_period =3D PPS_OUPUT_RELOAD_PERIOD;
> +

I think this does not address Eric's concern on V1, the initialization
still basically happens in the same scope.

On the flip side, quickly skimming over the ptp core code, it looks
like that the ptp core will always call this function under ptp-
>pincfg_mux mutex protection or at device unregistration time.

AFAICS that makes pps_channel and reload_period update safe, so overall
patch LGTM and I'll apply it soon.

Thanks,

Paolo


