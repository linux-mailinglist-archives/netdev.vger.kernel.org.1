Return-Path: <netdev+bounces-91637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDED8B346A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCC61C2084E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E213F42F;
	Fri, 26 Apr 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DewhGBVq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68C7EF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124859; cv=none; b=snnxG0TKgJ86VTzBFn2X3jOM37KU+gQEcsotw1ISNU1mM36WTAQEbH4uZZ0vqWgCE5juu2GcbvXa8eJD+jHbolhlwqV/QyyouesXcJA2dRWQ0Mk6cRLcntXCApAxag8h3V1bAQghwRHOyv6DCUz5w9oJGGnxoQDQAMEW0xG7tKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124859; c=relaxed/simple;
	bh=xbcsLuZFHYrAE1GwvThjDsgKiBFr7zhGHwmqzIhUd2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1n0p9sYZxMdguYDZ7vBDinvu+2S8+CPN5yEYhsn7QShJuKaIv2cn8/oMQuHSPYOwUIdL0KtwYItWWkUzp0QpHuImn7GbpcjZrR8mjhgTOzm3L3zILRrbB5sNFHSCeLFU6WvCE5qjVFw9HNHruVPk2tLIV4p3f0bcy4xajSApfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DewhGBVq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hvK49tB2YT+3zxNRXHcpvr+esiLKijY/ZDrQ76/LVaA=;
	b=DewhGBVqL4PKwHfjBJ1AvBqhUxAvMIzsorc0Sb831poEs1/QHf1kGGtj7VxsRJl6oPCtmv
	eE01p6f3UEUxsO5jq2qNfNiz18qA/CdwzJlK1zfG/LVl+szAwz8g8WURHHc/tXe2QRfYGr
	Gqg37vVRkEHVaerTk78ayziLewLNDPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-6cTBlL4WP7KdzVCkrrxvFw-1; Fri, 26 Apr 2024 05:47:34 -0400
X-MC-Unique: 6cTBlL4WP7KdzVCkrrxvFw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-347744e151aso246027f8f.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124853; x=1714729653;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvK49tB2YT+3zxNRXHcpvr+esiLKijY/ZDrQ76/LVaA=;
        b=SdaIpX/nQsTfm56dsOe3RamFFHyJB1zxJBSCHOyILZMMiYCpwfTRYH3jUdw+GLbaff
         D34c9+gJi4ItybuX1LgilWR06UIPpVJ4vruIRG/HUslQrAxWT/7zJIkYhvJQlyf+Qd6q
         8Z/lXIehSKH1plsjIjaxw2WR88IeEiOEPBT/xvJqlg1ORJI+91s5/Es+OqLT2fvYyQZx
         dYYnQWHn6LSbSnWpnNxnFNaIegv/nFyfBml8pyYhk8/OPCTNHYWAFM7ssqm7vY6vlw7v
         u4s/wM6db7bGXskPeKb0/dXsgCWkaA+sltQdeX3mzmrymgGlHKx1wMgz4RR9iYHBoV0t
         xYtg==
X-Forwarded-Encrypted: i=1; AJvYcCW/C56UncXn7WeTmnCWdB5tHtdFKzVZCDvErbwRlqTPdSrH8/JC8BQ7aRZ2RYZJ+zgETCNF9A68er2Rbh9ir9Wodb3XrOog
X-Gm-Message-State: AOJu0YxfZLnr1q9cS10ial/3VE7Yi2xRT11aX2QRc7Pj1RyV/R7q/z95
	tIA9Cy+RLzYP2BUFm/F+Hiw601VpbSYWByLbGSfN9jM5g0YlJAbL5x6YWn/xW5talktdZ68suUO
	O6PJyq4XEKH8TX0AStltCHixTUDmqXinXKZMr2mSmQBFQmot6rRds/w==
X-Received: by 2002:a5d:6ad0:0:b0:34a:546:a963 with SMTP id u16-20020a5d6ad0000000b0034a0546a963mr1406560wrw.4.1714124853559;
        Fri, 26 Apr 2024 02:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVUY+zhEVPSJOFluqbKjKwhtdMRgRRlDPWu98HVbxmbn+isAdtQGA+bDh4aQOpVDj5HVfjaQ==
X-Received: by 2002:a5d:6ad0:0:b0:34a:546:a963 with SMTP id u16-20020a5d6ad0000000b0034a0546a963mr1406543wrw.4.1714124853093;
        Fri, 26 Apr 2024 02:47:33 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034a44c615ddsm20008350wri.88.2024.04.26.02.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:47:31 -0700 (PDT)
Message-ID: <65aa390533d0529bc2e9ce4e459af1f5a4a04fde.camel@redhat.com>
Subject: Re: [PATCH net-next v5 5/6] virtio_net: Add a lock for per queue RX
 coalesce
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, jiri@nvidia.com
Date: Fri, 26 Apr 2024 11:47:30 +0200
In-Reply-To: <20240423035746.699466-6-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
	 <20240423035746.699466-6-danielj@nvidia.com>
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

On Tue, 2024-04-23 at 06:57 +0300, Daniel Jurgens wrote:
> Once the RTNL locking around the control buffer is removed there can be
> contention on the per queue RX interrupt coalescing data. Use a mutex
> per queue. A mutex is required because virtnet_send_command can sleep.
>=20
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 53 +++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index af9048ddc3c1..033e1d6ea31b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -184,6 +184,9 @@ struct receive_queue {
>  	/* Is dynamic interrupt moderation enabled? */
>  	bool dim_enabled;
> =20
> +	/* Used to protect dim_enabled and inter_coal */
> +	struct mutex dim_lock;
> +
>  	/* Dynamic Interrupt Moderation */
>  	struct dim dim;
> =20
> @@ -2218,6 +2221,10 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>  	/* Out of packets? */
>  	if (received < budget) {
>  		napi_complete =3D virtqueue_napi_complete(napi, rq->vq, received);
> +		/* Intentionally not taking dim_lock here. This could result
> +		 * in a net_dim call with dim now disabled. But virtnet_rx_dim_work
> +		 * will take the lock not update settings if dim is now disabled.

Minor nit: the above comment looks confusing/mangled to me ?!?

		   will take the lock and will not update settings...

Thanks,

Paolo


