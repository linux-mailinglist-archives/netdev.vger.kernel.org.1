Return-Path: <netdev+bounces-241795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64075C88467
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678EC4E1A8E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97736314D39;
	Wed, 26 Nov 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv2uUHj+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZpH0zdO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23A316905
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138618; cv=none; b=TtJRULhISEHSz887u1mstaUtxNt7pjqCykVXo7YFGe64Ht3eK5vB0aIOyOgTJ+oAdIJhCHxivECvmhvmMJWcadyXdwCJZ04bJ2gF3iLWB/Id+mXOmWPbF319QXkEhJO/Xo5rsU+kRE0KLpUySWxmxKzfD0Qprlc043dRYZt6iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138618; c=relaxed/simple;
	bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUZ+rHYz+hlw6R1AdrA4RdI7jdNGGceI2IB/Tr8f+0/3YQMTYuzxdxzqnpLyB7Qpf72EkjfReZEBP8llhphYb3ml3gn3cFU8rivPs8MtTA1w8QGMast4KTmAhcBkGzJakmzHR1W0MqMT7vCsRWG/zKg8EElNTvWGuGHB3uX1oCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hv2uUHj+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZpH0zdO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
	b=Hv2uUHj+R4wtwKBzfHOsyWPkP+SkT2iDXeSQc++FeLtJIH/CApmnIVa+DqCsk4tNBrdfkd
	BvA+cw9i9VfH9u7JeBPDiZlsND/xSIGbd0nrOrI2UxvUST77DWuwsd+D5jFYg6qZy0BuH/
	oCRi/LEex7gmShthZFwFSScZC2GnRTI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-e91AXvZYMx6DS3I3lJwwng-1; Wed, 26 Nov 2025 01:30:14 -0500
X-MC-Unique: e91AXvZYMx6DS3I3lJwwng-1
X-Mimecast-MFC-AGG-ID: e91AXvZYMx6DS3I3lJwwng_1764138613
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343daf0f488so6473429a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764138613; x=1764743413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
        b=UZpH0zdOGRlHs6kxRtcOUADQ5YtGZzb6lz/Fckn/FTASHVkPPGuTk7bKiy6ihSP7Km
         1bn6S1I3pxkVDFhv5NW3H7OB+OA/0pS10n3ARCMNxcfoc/4td0Ez4IJPwYNZpxW8WuTI
         fX1rNVHoxHWeyU6/3zl/vq12SvSuYp9sfV3J6bFQyqRVX0Bzg5Ua64ZDTm2Gozu4ITMJ
         HsvSy2zeUVehAgOAZ2ElHGaFqijQdJ5A5mQGRvaiwuLnazfPuErJWjNP7qIi0n20ttHt
         lgha8CZf0PlaeM7V6AeYs3UpfMwxoMszlxYhdjKIk/acOzexhIc0D+Q7xgjKCJswBc+P
         A60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138613; x=1764743413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shDW0bp9CYlSovPFi/gL4KjEH8ciVonuyi+rYc3qW8U=;
        b=HX7gfZmJ+sFlMtmfu4z4IzVOHHXMLOoRKPjexz3n65bERyoATZ9g6LItWcif+X4Jqs
         aYaRHk9UIqbaLQHtfP70CKvUyuFDYzb+Vh+mcMpdVmZOuLvFebsQZxb12Xxm83m+sq7t
         yOe8Q2YEUyqyfwl4gMrL8x3CRLvu48Ny+9kZZFUVRVoqEv/dofea29iZ1/bFtM11eU12
         f+/CyplKNFt/27gUwto0gbWIYnZ5mxhjHXvSeCmsdGtQWTMhjQZ/4jteQm/Vv2yPw1oj
         dV4LJO0Pd7giwxDYo8e9HOgFIBJie9WuwVO77opPccqNQ8GraR7PkNO1iwhX43UQINMv
         UYfg==
X-Forwarded-Encrypted: i=1; AJvYcCVEWli0ihzDI5mXgM+IcN3mFVRVkuFE4xDZtYcmolFy3hvsR/nMQlblgyexAfjVSxV36dm8+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMg5rEoKJK+Cj7pKUOWYr3YQ+SbEcZq7x+bskOa7ehGQxqpvEY
	vNg/kwTpJg4T0AUX8MmtSpsJLmgTJ3rd2EQYpWRPUR8f5u6SlMrhmMrqMORg/X5wipado8Y0+68
	JO/Uj1BK3JaBxl3sR3cCvarz0n2BFciZB3eMp/JKbvnB3VmWYKepQzZjCtvuFYVo78puZ0zGJ+L
	rYHO3CxjIjTLodCxNe/kC1JnHxg6Ax1K9i
X-Gm-Gg: ASbGnctQ1cj9aOQp68eBLtcjNmRlDszfTSp2k5W0gMS+RzvFzCDvMYPtPHrDPmrL5W/
	eF8H6ymxtyq6bSNr8xqyU1Lyhb/lPkDzH5RNPbTLDjwcTqmg9IMJI4xfq7iCAnmdG7dLRnKncxY
	aCm6CKAklUt1TI5StLf0EfxJCwoZYlTBIz872XrzKezPJeUBhUyk+XfTXOjtOW8tgiTVc=
X-Received: by 2002:a17:90b:2f83:b0:341:194:5e7d with SMTP id 98e67ed59e1d1-3475ed51453mr5743351a91.24.1764138612822;
        Tue, 25 Nov 2025 22:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeL2+MjlKvJTulnscTHHFaOIKShldd6HAyu8s9k6V/8uabjg3AQSXsiYn3FxybeY1hV6sKpHRSMvuAzqJKStI=
X-Received: by 2002:a17:90b:2f83:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-3475ed51453mr5743332a91.24.1764138612403; Tue, 25 Nov 2025
 22:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125222754.1737443-1-jon@nutanix.com>
In-Reply-To: <20251125222754.1737443-1-jon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:29:58 +0800
X-Gm-Features: AWmQ_blHu1BZqv-6yOkAhpdiGvIH6FCxP2EMvVPtPSNF_eBgleWvB8nW8HekDzQ
Message-ID: <CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum calculation
 on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 5:46=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") inadvertently altered checksum offload behavior
> for guests not using UDP GSO tunneling.
>
> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
> has_data_valid =3D true to virtio_net_hdr_from_skb.
>
> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
> which passes has_data_valid =3D false into both call sites.
>
> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
> for SKBs where skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY. As a result,
> guests are forced to recalculate checksums unnecessarily.
>
> Restore the previous behavior by ensuring has_data_valid =3D true is
> passed in the !tnl_gso_type case, but only from tun side, as
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

(Should this go -stable?)

Thanks


