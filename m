Return-Path: <netdev+bounces-242126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA2C8C8B8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3DFE4E1467
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16726B971;
	Thu, 27 Nov 2025 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KK6QPprO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bERCBZQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158325F7A9
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206853; cv=none; b=sElsP80IRJvwaVLZDPYBArF8QqgwuOlQRP2SP0aExuJWLeTmSr4XwWV5bfv0w4AC5yCTTWPsJEDkU6Yo+EGnkw8onADslDYWPBD9nLsssgY3Ip8KJo7Cbp8LlcP645RTkK+oyQ1LJCxl5bL78yTHnClHqYxpzC/9P1sQlyAV+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206853; c=relaxed/simple;
	bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUZm9dlXPf/LdZUn4GQlNnpYFJCLB4idnnbF/FzWK9aoi+azuspOs8QgZ3CMVgxKdXUzgc2wr2QFZ/w/NwhEUS1NAD/ZOgzJyX27EjnHsB3w++qQRQbY+BrxzePnDUtfzdMNDydRFh+0WpWDYjQ07eBdpDwKFt+8yiys2q8yCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KK6QPprO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bERCBZQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764206850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
	b=KK6QPprOBURh7khs98li9D7aDzCMvdD2xl2Qy7TEa2qLpIyIj1CTWQbDbQntRVBtZwxUH8
	Ee3uXybI0AXTTtYYN70Emc238D/srv2cDNO1ekIQ/0TUKKLTTypeuXWqcvEzUZ3k++4D0B
	b4kvV+wYaFiUFbkffJIu3Wtk30nUTXo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-ftgeO4bZN5CitDi396F9uQ-1; Wed, 26 Nov 2025 20:27:29 -0500
X-MC-Unique: ftgeO4bZN5CitDi396F9uQ-1
X-Mimecast-MFC-AGG-ID: ftgeO4bZN5CitDi396F9uQ_1764206848
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29809acd049so5277965ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764206848; x=1764811648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
        b=bERCBZQYUGwgL0m4L0S3iRhKc6tLxDAtCdSl9QlhHJQWH3fFubKM8vZKPabGXLxIh+
         G0ddr3jPyPx9oEllFzZmSJCcwHrVq5Du1nkEWiAH0c3s+qrY6GywLkhRXb8mHccRF8w+
         VatO4ESzIPJMz88JbWITOcqEYL5eNwzSQJxjnZ6AB5iMWM0JyHMncV31IBXovgCni2tU
         MNC+F0T+DOPLIXaKhNeEWvKCywPj48AJZKA2Mi2OgHDTCmzYSxsDvETJym//rnigkPxA
         EitnLYh5aSSsk138glVifUgxDwXzTbFk3bCcEQkxZlTZEqJ9FKOuHOh/KY4YT2TYIWBs
         YleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206848; x=1764811648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r7KEz8iqgaXG1/tonNQbAHreoU8BpvA4RzO7XTtNj+M=;
        b=F9CvDrIgEiP9EzR7Bv1JO9n2IVFu/McTLpWSdq7ci4Wncy594iBcGhK3S3UFtgxWxs
         +JVs4BzLfTpAcHj2GjwwtferitF2L2wXjc7FRprvVBFK45kGzFRzSy+26Soy05H1YJRQ
         MncDsn3q00sn6G/bYMAn+i4wu7kJuzKYcX9UMkVie8WeVcIqRBM7oBSfMlOBahiiVhPZ
         gfZ+HuJTnHfe3PZMpvpxoY0WG/p0rmTxBaG4EQt0rwAjeB6Dkg7DQ4NV0OC9f6Utzjbg
         PgAguvmyV6asD4gE3ISFCVUx4ppIAKvVMevi+T5isPZQ5bTH6ranf4epwlNLqvpbJ6U6
         eHlA==
X-Forwarded-Encrypted: i=1; AJvYcCU9IZsq2cV7bBxexbtNKCQd3Hh+NhTeNhfCowQ9/C/dhgqDcQIl4z4Ozoxfv810vdG9rqjadxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsKda62worS3Kpg+zHUanpNZVTI+EVEXAROreMCkJ966D/j98
	4EmMeG5nBAIaDIKgvbfOHLwrAQjcPBjbj8aKbTGJCLR/Q7GmVdsUdXbEfGKQr4XCA8LRLC3wx8g
	lLKuft+/GG00OzrwJ1lcvzQdf1EiF6ItF8Hb2UsW+VmEQh/EIAFY9Unbudhfp9jqXjKQkAkqsS0
	jaQ+dgX2xonA6ALwo+eOepgC8ao0nhQY1M
X-Gm-Gg: ASbGncsFZSf/5igXj4jJABFE8SzgsKUsmiwcse9Kjqcoaw+bJe4SXonbNMR6GfwX0yj
	3nxM1YcuAinCsdcKyACvgm/geNdqUcAfLfZjYKiGL/409oJYO3Dnc37kvdylFBSKiepeZ7mNNLL
	YRu8WMn5Ng9ZgMPdl/EXXURS9AWcOAo3SSYUeIbafR6ra6D0aesw2tzroMGEWIXnyp
X-Received: by 2002:a17:903:1ae5:b0:295:3a79:e7e5 with SMTP id d9443c01a7336-29b6bf3bd68mr239483495ad.34.1764206848302;
        Wed, 26 Nov 2025 17:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkO8PdlOXSckshzA60VPUWOZAaeSJuC4qSXUdbHgCezX+9REgWbWrPJr0c4cJsSiRA2TS68/Axo338N+hgPfY=
X-Received: by 2002:a17:903:1ae5:b0:295:3a79:e7e5 with SMTP id
 d9443c01a7336-29b6bf3bd68mr239483305ad.34.1764206847831; Wed, 26 Nov 2025
 17:27:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125222754.1737443-1-jon@nutanix.com> <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
 <8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
In-Reply-To: <8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Nov 2025 09:27:16 +0800
X-Gm-Features: AWmQ_bmCfWxgTJtsgAzMnemOZLmAhjUF-FCkJ83NqHraHOHyDs9XYJ5GbyTvy2Q
Message-ID: <CACGkMEt2FFSiodAN=FFT7JnV78pmVRN4VTr_XDm05J0xpSfmHA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation
 on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:12=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
>
>
>
> > On Nov 26, 2025, at 1:29=E2=80=AFAM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Nov 26, 2025 at 5:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> >> GSO tunneling.") inadvertently altered checksum offload behavior
> >> for guests not using UDP GSO tunneling.
> >>
> >> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> >> has_data_valid =3D true to virtio_net_hdr_from_skb.
> >>
> >> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> >> which passes has_data_valid =3D false into both call sites.
> >>
> >> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALI=
D
> >> for SKBs where skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY. As a result=
,
> >> guests are forced to recalculate checksums unnecessarily.
> >>
> >> Restore the previous behavior by ensuring has_data_valid =3D true is
> >> passed in the !tnl_gso_type case, but only from tun side, as
> >> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> >> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> >>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO =
tunneling.")
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > (Should this go -stable?)
> >
> > Thanks
>
> It could, sure. This made it into 6.17 branch.
>
> Would you like me to send a separate patch with a Cc: stable
> or could someone just edit the commit msg when they queue
> this?

I think a new version might be better.

Thanks


