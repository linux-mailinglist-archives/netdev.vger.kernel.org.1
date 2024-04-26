Return-Path: <netdev+bounces-91633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D578B344B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13011F23212
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7013F01A;
	Fri, 26 Apr 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaIt/ij4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8D13F425
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124324; cv=none; b=WZgw78bpUwj3Sm8vL0wyAcoJvnT21Fj+sl/9ds9s7bYYKNu/JpTwD3rBAppHrMuiM+FcEaPx2sEhGiMa92LQ1ZeEL4sTQ7j+Cc3qkSKxH3asVirWBkd7u4oUjci7XUhBgQUWgOCuM/9WoykxO0hqPqKbAC2Lr7qShWaSyUP42YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124324; c=relaxed/simple;
	bh=/IMnWUJN7Q3D4LM0fy1BZpkSinIzUgYgjn73ZN0OOOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idsb/4hbyLJJzakfgLAktPrIVNnvu9SbhU7DZRrvUlUBGqCSfU/LdENmA1iUHGJgf7TvAvigBc1nDT4ilbrar0hIMz8R7+poLT4Mx1oe6CeYSMEJ5kk1RNZvKTFCBY/SNOmFbHqZMTsm6Fm71XnZ620JJ+Ry4IKlWDPNGx0DsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaIt/ij4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714124322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YU6Awx91uEd0fhHdAhRSF/jDv9V7XVOFJ5HFPl2ijFI=;
	b=gaIt/ij4Htc/baP0bP9wjqInLy2z8r7V4QCNwsN9CD9muAnfobBJm9NKHG0dsOL5AYL496
	wFWSQA5yPx19BsfwA8SiRep7MXcrppCsFimtVpo2dQ5/pSg7NAMraowcy78m3Dib5Zl4k0
	rGt3vPYAETVn4VxxLKZyQZI1eX67xFI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-9rjKQLANOzmLtTHfSSJE1w-1; Fri, 26 Apr 2024 05:38:37 -0400
X-MC-Unique: 9rjKQLANOzmLtTHfSSJE1w-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51bb2e13253so226328e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124316; x=1714729116;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU6Awx91uEd0fhHdAhRSF/jDv9V7XVOFJ5HFPl2ijFI=;
        b=onhznp64IKc7rF6X57dFTpyeQC+Vze1lm7eD1TLEWgYWmaZ0Hjco8tM3Kb0G3Gc0YM
         NRhDIbTQNieYhjhMP6a/5sn09zW+KNpUPRcawkGNA/16PqwrhUz78ViYoZ4mW1mX0TNd
         iwxt/PVSL3Dq/2RNRSgvh2o0IvdN603nairP6zu9u2hljc4fk9qlld3FDfgy3/AC+K3B
         fdOu16caH5qxyxNBTRXzJ4OSkCuN/8UuX+rPBL2LbFb27eFoSGkAZqLHEJsCy5zdD5p5
         1EiL6BkCWY1UzRRskIquBrnggqhQv9RcSoz+XCNBoeXNb/GDmtCXG2zGTfO1MOdSsrHs
         WyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHN2T0iiu8YtbkberI3N+8WCO8DusDbLl0DxFnQ7xK2wypbwvyWeYErvlMtYjYa3hBbtcGZyvxHxBMpTPnnXynoqpFyQD
X-Gm-Message-State: AOJu0YzJ4n8u0soUvj1wAdz3F3wuuy3cqX6B+Mn4wnBY6KOJtdhYkJ+W
	xEkWlyawYY4Di4Jg2GYnxJPtE4A28vM/6vpQARFZCV6Af/ASApyOUHidIiCUC15gMWhgrVjf0B4
	OFUqrbqDSZdFG1vnPXKa59F3Sctrzfkx+D+nLwKBjQqPnj26tTfyb9g==
X-Received: by 2002:a05:651c:10a3:b0:2df:4bad:cb7f with SMTP id k3-20020a05651c10a300b002df4badcb7fmr855146ljn.2.1714124315994;
        Fri, 26 Apr 2024 02:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeJjqnv5w0izlNbNJudktCo2QCp3nsMsfhzDoRgclEPJZvGzidJagSLjfc2lu9aRqPQwHS7A==
X-Received: by 2002:a05:651c:10a3:b0:2df:4bad:cb7f with SMTP id k3-20020a05651c10a300b002df4badcb7fmr855133ljn.2.1714124315604;
        Fri, 26 Apr 2024 02:38:35 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b0034c66bddea3sm679600wrx.37.2024.04.26.02.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:38:35 -0700 (PDT)
Message-ID: <d2359b1cc8a89234f1130db83e07963ecd1270c9.camel@redhat.com>
Subject: Re: [PATCH net-next v5 3/6] virtio_net: Add a lock for the command
 VQ.
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, jiri@nvidia.com
Date: Fri, 26 Apr 2024 11:38:33 +0200
In-Reply-To: <20240423035746.699466-4-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
	 <20240423035746.699466-4-danielj@nvidia.com>
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
> The command VQ will no longer be protected by the RTNL lock. Use a
> mutex to protect the control buffer header and the VQ.
>=20
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0ee192b45e1e..d752c8ac5cd3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -282,6 +282,7 @@ struct virtnet_info {
> =20
>  	/* Has control virtqueue */
>  	bool has_cvq;
> +	struct mutex cvq_lock;

Minor nit: checkpatch complains this lock needs a comment

> =20
>  	/* Host can handle any s/g split between our header and packet data */
>  	bool any_header_sg;
> @@ -2529,6 +2530,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>  	/* Caller should know better */
>  	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
> =20
> +	mutex_lock(&vi->cvq_lock);
>  	vi->ctrl->status =3D ~0;
>  	vi->ctrl->hdr.class =3D class;
>  	vi->ctrl->hdr.cmd =3D cmd;
> @@ -2548,11 +2550,14 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
>  	if (ret < 0) {
>  		dev_warn(&vi->vdev->dev,
>  			 "Failed to add sgs for command vq: %d\n.", ret);
> +		mutex_unlock(&vi->cvq_lock);
>  		return false;
>  	}
> =20
> -	if (unlikely(!virtqueue_kick(vi->cvq)))
> +	if (unlikely(!virtqueue_kick(vi->cvq))) {
> +		mutex_unlock(&vi->cvq_lock);
>  		return vi->ctrl->status =3D=3D VIRTIO_NET_OK;

or:
		goto unlock;

> +	}
> =20
>  	/* Spin for a response, the kick causes an ioport write, trapping
>  	 * into the hypervisor, so the request should be handled immediately.
> @@ -2563,6 +2568,7 @@ static bool virtnet_send_command(struct virtnet_inf=
o *vi, u8 class, u8 cmd,
>  		cpu_relax();
>  	}
> =20

unlock:
> +	mutex_unlock(&vi->cvq_lock);
>  	return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>  }
> =20
> @@ -4818,8 +4824,10 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>  	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		vi->any_header_sg =3D true;
> =20
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
>  		vi->has_cvq =3D true;
> +		mutex_init(&vi->cvq_lock);

I'm wondering if syzkaller will be able to touch the lock in some
unexpected path? possibly worth always initializing it?

Thanks,

Paolo


