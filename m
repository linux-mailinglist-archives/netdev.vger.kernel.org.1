Return-Path: <netdev+bounces-65022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9146A838E43
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416C4286FBC
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06C5DF12;
	Tue, 23 Jan 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuNV6SFU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F65DF03
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012129; cv=none; b=bSC7xeyesWBocr5nGvMkL0fi9ofzdj+5n4/i/ImPgbscg89AG9mfQVVnLJKFwrlA5XKwlwhAmpPpGCaY37xGbZYUPE7YDc5n4adguZb9J5SrQw2H98au7ogXFU00NkmW7UXZpMI1+ksEk2J0XEufRcuqkhCOYC4TZ1Krab8MlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012129; c=relaxed/simple;
	bh=z2CYtE4B0zlAAHri2T5wv5Y8CYhhRh/8FWoptwvGhbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=neFLP2SpBVGtOKk2e/DtMaxtYywtSOJlPol210MCAnD+1KPqnVobgGMVNTGrzWaqh2NX7iekEdZ71v82oY4jZWpH7AKDMAtJPqwN1HJoTgKd/7mGTV7gyYTMMxlrh/n2QnRqD+BSGOtDCE4FBsiM7QPZuc/99u1qFQ+P8/2fS/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuNV6SFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706012127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qGPd3R+PgSrU/W8rbfTS1R5qWxRAo6HR62gFiGEB6lU=;
	b=FuNV6SFU2JgA0gsish/e9U7UR4MasRwSb2j4MYZQTjmKtrfKeDRk4ttkV0Sgz6LNF0LRk1
	78L/8kwXsOJa1t//3ooQb8/kK41LqsY+5PciSj15nx67hyhsLU7AOP6EJLEeA88TblLCUY
	iQ9UvV4v7gj3R2fnb4gJgSG/cHflKZ0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-TpXXB5RBO1esGX2JIlwZNA-1; Tue, 23 Jan 2024 07:15:25 -0500
X-MC-Unique: TpXXB5RBO1esGX2JIlwZNA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-429b32b01c7so12175501cf.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 04:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012125; x=1706616925;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGPd3R+PgSrU/W8rbfTS1R5qWxRAo6HR62gFiGEB6lU=;
        b=jcYJJEgOoZNcLYQTSr26/a3kEDOBrUuqaW1PS8QToV6L4kuSrtuhpRuSnnAmOx2rJU
         sVhHDmgZmWjyB2Phso7ALV0/VKZpcFYowexC479Of69hwCv3XaOsyy8KIPC0xbNDkVGG
         Jb0Ve2EecYs2Tc+DlvZ8TwuxMw5PLDbAKGReBfhS8KcMU5DdjK0lTEuTPSo+Jxy5eO4t
         XhB5bViUdWdOrMc4OKCbUi0QL8N8V4kDJOUEILJCtNRiT6pWkMwmTqVl4uuuhrghJXqn
         cLCZNtNIHr8i83E+qfsUc7/9VgegK0pkdPmDjIMKyZC17RsyOZsSGcOB6ninb3Yj4O1/
         8QGw==
X-Gm-Message-State: AOJu0YxSMn8gN4V6K9gZQaOUyCTcLswoIXgSLzhtrfXLhtcpAc1s5wfi
	3AG6AFygBr9uQ/VeIb4Ocjb3AWi+2aNmwQSAMaUHjaWDwej1ZPGzmpKlYgzrc6cGOG6sMPu2D1h
	3XXsleUHQOBNbaYvYFlYj1UrGPJG0VljRIqkWrsC5mDJFIKacjJp9xA==
X-Received: by 2002:ad4:5e8b:0:b0:686:9fb0:b101 with SMTP id jl11-20020ad45e8b000000b006869fb0b101mr1666412qvb.1.1706012125378;
        Tue, 23 Jan 2024 04:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNplBrW5bUxuISbSW8nfOr8z2Hvwd61sjm3wYhsGrL5ZumkGZM5HqoAve/EBu29qfPBpsbqA==
X-Received: by 2002:ad4:5e8b:0:b0:686:9fb0:b101 with SMTP id jl11-20020ad45e8b000000b006869fb0b101mr1666391qvb.1.1706012125063;
        Tue, 23 Jan 2024 04:15:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id e3-20020ad44423000000b00680f8a7c026sm3359535qvt.65.2024.01.23.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:15:23 -0800 (PST)
Message-ID: <18cf401f00c953d434a0ef36b0d68df0270dfaa6.camel@redhat.com>
Subject: Re: [net-next v5 4/4] net: wwan: t7xx: Add fastboot WWAN port
From: Paolo Abeni <pabeni@redhat.com>
To: Jinjian Song <songjinjian@hotmail.com>, netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org, 
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.com, 
 vsankar@lenovo.com, danielwinkler@google.com, nmarupaka@google.com, 
 joey.zhao@fibocom.com, liuqf@fibocom.com, felix.yan@fibocom.com, Jinjian
 Song <jinjian.song@fibocom.com>
Date: Tue, 23 Jan 2024 13:15:19 +0100
In-Reply-To: <MEYP282MB26978032980360EBBB1DAFF9BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240122090940.10108-1-songjinjian@hotmail.com>
	 <MEYP282MB26978032980360EBBB1DAFF9BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 17:09 +0800, Jinjian Song wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
>=20
> On early detection of wwan device in fastboot mode, driver sets
> up CLDMA0 HW tx/rx queues for raw data transfer and then create
> fastboot port to userspace.
>=20
> Application can use this port to flash firmware and collect
> core dump by fastboot protocol commands.
>=20
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v5:
>  * no change=20
> v4:
>  * change function prefix to t7xx_port_fastboot
>  * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
> v3:
>  * no change
> v2:
>  * no change

Minor nit: you could/should omit the 'no change' entries

[...]


> +static int t7xx_port_fastboot_tx(struct wwan_port *port, struct sk_buff =
*skb)
> +{
> +	struct t7xx_port *port_private =3D wwan_port_get_drvdata(port);
> +	struct sk_buff *cur =3D skb, *cloned;
> +	size_t actual, len, offset =3D 0;
> +	int ret;
> +	int txq_mtu;
> +
> +	if (!port_private->chan_enable)
> +		return -EINVAL;
> +
> +	txq_mtu =3D t7xx_get_port_mtu(port_private);
> +	if (txq_mtu < 0)
> +		return -EINVAL;
> +
> +	actual =3D cur->len;
> +	while (actual) {
> +		len =3D min_t(size_t, actual, txq_mtu);
> +		cloned =3D __dev_alloc_skb(len, GFP_KERNEL);

Minor nit: the variable name is misleading, as the skb is not cloned.

> +		if (!cloned)
> +			return -ENOMEM;
> +
> +		skb_put_data(cloned, cur->data + offset, len);
> +
> +		ret =3D t7xx_port_send_raw_skb(port_private, cloned);
> +		if (ret) {
> +			dev_kfree_skb(cloned);
> +			dev_err(port_private->dev, "Write error on fastboot port, %d\n", ret)=
;
> +			break;
> +		}
> +		offset +=3D len;
> +		actual -=3D len;
> +	}
> +
> +	dev_kfree_skb(skb);
> +	return 0;
> +}
>=20

[...]
> ++static void t7xx_port_fastboot_uninit(struct t7xx_port *port)
> +{
> +	if (!port->wwan.wwan_port)
> +		return;
> +
> +	port->rx_length_th =3D 0;
> +	wwan_remove_port(port->wwan.wwan_port);
> +	port->wwan.wwan_port =3D NULL;
> +}
> +
> +static int t7xx_port_fastboot_recv_skb(struct t7xx_port *port, struct sk=
_buff *skb)
> +{
> +	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
> +		const struct t7xx_port_conf *port_conf =3D port->port_conf;
> +
> +		dev_kfree_skb_any(skb);
> +		dev_err_ratelimited(port->dev, "Port %s is not opened, drop packets\n"=
,
> +				    port_conf->name);
> +		/* Dropping skb, caller should not access skb.*/
> +		return 0;
> +	}
> +
> +	wwan_port_rx(port->wwan.wwan_port, skb);
> +
> +	return 0;
> +}
> +
> +static int t7xx_port_fastboot_enable_chl(struct t7xx_port *port)
> +{
> +	spin_lock(&port->port_update_lock);
> +	port->chan_enable =3D true;
> +	spin_unlock(&port->port_update_lock);
> +
> +	return 0;
> +}
> +
> +static int t7xx_port_fastboot_disable_chl(struct t7xx_port *port)
> +{
> +	spin_lock(&port->port_update_lock);
> +	port->chan_enable =3D false;
> +	spin_unlock(&port->port_update_lock);
> +
> +	return 0;
> +}

The above 4 functions implementation are exact copies of
t7xx_port_wwan_*() functions in drivers/net/wwan/t7xx/t7xx_port_wwan.c

Please reorganize the code to avoid such duplication, e.g. renaming the
exiting function to something more generic, making them non static, and
declaring them in some t7xx specific header.

Cheers,

Paolo


