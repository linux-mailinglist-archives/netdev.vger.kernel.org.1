Return-Path: <netdev+bounces-243010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766DC9836A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7312A3A3FBE
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C2F32C948;
	Mon,  1 Dec 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHN0tNyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBE334C1A
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606055; cv=none; b=KiMl2zt7ELq75TxL08O5BypbI8R2nrTC8Vpm9FDbKgCI40Mp+g4YHULZCHsFdB0jLeaO7m/4kZEZm3e03aezIrqmiWlIroBnFk29msjc1NLputgq/8UX09HCdkZD/GdBJPrMvCKuBZxl3jCrbCOMzwrLSr7wo4YmzIH2PdjFi3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606055; c=relaxed/simple;
	bh=UGh95T3PZZexveHf31XlwWi+oBoMmqnztTKTscYBFRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOlbDuZhWwVu1rWYbVgsyqD9Se7c9rayksrimUfwyvpmF1dgtyDcQ7jRmq5sGV8EtTHKjGOisdDZMNfAwP0x5pdhaOHBnoSR65tBGCAC5mTcIa5b7Nj3zQb3vsyQuFLb+oUcLenW8gV5nEFwbIFhzLmqjMttDrL7GKbCxGXjh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHN0tNyL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8823dfa84c5so45657756d6.3
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 08:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764606053; x=1765210853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fIJJNRYlTE2jrREIoPO+BUl8r266ERcmFEsmp47F5Q=;
        b=QHN0tNyLoNVHUvbUKmDyyW9oPNJWQDwzb1LLkAC5osEXALutZTWYd3v9oUVAKSGY+3
         /6flAPeR3Ig8x4exEYC2LBoATp4o6LCGisvBGUOY9VzUZRWFnjsDuE5YyWs+hEGT4w2M
         4WLI0oDunD/HCsdUAx7wQMZX/GEHL1gRM1T+UP10xZxNIkI1fg4ojopt9p80/th2QrnU
         E/8BR5lNDZ/QIYecqnnAbzKAdRb9Ot68+jLWl6/Bmd2G1vYWxBSulQq9XjgZhzGxVEJn
         jX4mbz2h8ctNvfZVyHLLPu/RAZnQiWiNuYOzmB5WywuzBpYT8XZpVHX9XRrG9F0rjQId
         EYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764606053; x=1765210853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fIJJNRYlTE2jrREIoPO+BUl8r266ERcmFEsmp47F5Q=;
        b=MsW1qLPWXqx0ydyq3oVJZqWczNW87VEZIY6WH3t7L2RcDKmtfV49X+uZYMmJF+WzCU
         b1A7QKB7cLY9oddzft8y8PWIfz92mTqwjlQ+CIucnVs8gi50NDPLF1Rv9pg/MZjlbgAy
         9WT3dGeWe0qGeiflXFCaZtes1Y8ze2gi8xknZa/2/xJAyVZzwD4H9vSpwjks/AB1s2az
         PBkcU1lsXgSoNowJOed5iBFo6U8VAUxWQOnW4xY8zLsbKcRt1czvH07qOS6FeXzWVyk4
         rdf4xY8slkUh6CGxQRedDmBWCEUNZPlAPfct0AjbfKX62YUOGH0paira5IBYv7I4QuOv
         zjQQ==
X-Gm-Message-State: AOJu0Yw6fusptkxwtb8UbjjgSaJQ4094i9e0bjc0PzlMYWMgBwMEbfue
	Gkk7qcROq121Xz0coR6O6Gl04WdmahnAQ1OyW01DNgcDNs1G2dmoauBpSEDbMlCqvrl8/2MHDYV
	qnWKr/zpQU96D0CxpryIYnRl4LxhDCw==
X-Gm-Gg: ASbGncuCr981vIDsABP1C+M7NW3WV87vOfkTFpaPfH1xmWh8e0ucqiuJf9fk7pPz39F
	y5BGKTlzA/mbzVse5EzggVReOH2Btm+x9Mu4mzimFHTG1dtMxYVkWMQ/adKuGGK+lSTwDyhisSo
	KVoPDCzD1N+SoUQzkgYDO55+z4ak/s9rYLcDel+bEc0BJZs5eMaiq3tqmqdLtsfccxklTPiaj3b
	Aeh5UC1ZvZ6dBV/HFLmGSByncNoErU8fJRxAxrNgBG8v1DdeSM6qQnSPB62IY+ARiAZwPQ=
X-Google-Smtp-Source: AGHT+IH6jJXqgrlrda0FG2gYokmd/j7wEG6XU4iwnbgzPWbMktWMNw+W8Y4H9FESVYWClzxK4KFImZ9OJsPEcc9chXs=
X-Received: by 2002:a05:6214:252a:b0:880:278d:d4aa with SMTP id
 6a1803df08f44-8847c488142mr597525806d6.7.1764606052679; Mon, 01 Dec 2025
 08:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130131657.65080-1-vladimir.oltean@nxp.com> <20251130131657.65080-5-vladimir.oltean@nxp.com>
In-Reply-To: <20251130131657.65080-5-vladimir.oltean@nxp.com>
From: George McCollister <george.mccollister@gmail.com>
Date: Mon, 1 Dec 2025 10:20:41 -0600
X-Gm-Features: AWmQ_bnG_JXDC03J57BWDiMTa0mC3TJnoqOH0LvxO5s-6Kirui7PEaJcGnAe664
Message-ID: <CAFSKS=MkkTWC81Gd4FASBHsiBFsZjmKYNJhWooHhKORBTcikVg@mail.gmail.com>
Subject: Re: [PATCH net-next 04/15] net: dsa: xrs700x: reject unsupported HSR configurations
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Makes sense.

Reviewed-by: George McCollister <george.mccollister@gmail.com>

On Sun, Nov 30, 2025 at 7:17=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> As discussed here:
> https://lore.kernel.org/netdev/20240620090210.drop6jwh7e5qw556@skbuf/
>
> the fact is that the xrs700x.c driver only supports offloading
> HSR_PT_SLAVE_A and HSR_PT_SLAVE_B (which were the only port types at the
> time the offload was written, _for this driver_).
>
> Up until now, the API did not explicitly tell offloading drivers what
> port has what role. So xrs700x can get confused and think that it can
> support a configuration which it actually can't. There was a table in
> the attached link which gave an example:
>
> $ ip link add name hsr0 type hsr slave1 swp0 slave2 swp1 \
>         interlink swp2 supervision 45 version 1
>
>         HSR_PT_SLAVE_A    HSR_PT_SLAVE_B      HSR_PT_INTERLINK
>  ----------------------------------------------------------------
>  user
>  space        0                 1                   2
>  requests
>  ----------------------------------------------------------------
>  XRS700X
>  driver       1                 2                   -
>  understands
>
> The switch would act as if the ring ports were swp1 and swp2.
>
> Now that we have explicit hsr_get_port_type() API, let's use that to
> work around the unintended semantical changes of the offloading API
> brought by the introduction of interlink ports in HSR.
>
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> Cc: George McCollister <george.mccollister@gmail.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/xrs700x/xrs700x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/=
xrs700x.c
> index 4dbcc49a9e52..0a05f4156ef4 100644
> --- a/drivers/net/dsa/xrs700x/xrs700x.c
> +++ b/drivers/net/dsa/xrs700x/xrs700x.c
> @@ -566,6 +566,7 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, in=
t port,
>         struct xrs700x *priv =3D ds->priv;
>         struct net_device *user;
>         int ret, i, hsr_pair[2];
> +       enum hsr_port_type type;
>         enum hsr_version ver;
>         bool fwd =3D false;
>
> @@ -589,6 +590,16 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, i=
nt port,
>                 return -EOPNOTSUPP;
>         }
>
> +       ret =3D hsr_get_port_type(hsr, dsa_to_port(ds, port)->user, &type=
);
> +       if (ret)
> +               return ret;
> +
> +       if (type !=3D HSR_PT_SLAVE_A && type !=3D HSR_PT_SLAVE_B) {
> +               NL_SET_ERR_MSG_MOD(extack,
> +                                  "Only HSR slave ports can be offloaded=
");
> +               return -EOPNOTSUPP;
> +       }
> +
>         dsa_hsr_foreach_port(dp, ds, hsr) {
>                 if (dp->index !=3D port) {
>                         partner =3D dp;
> --
> 2.34.1
>

