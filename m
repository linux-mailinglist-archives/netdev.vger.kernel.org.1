Return-Path: <netdev+bounces-147170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50B9D7C2D
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 08:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C492810DF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643E1537D7;
	Mon, 25 Nov 2024 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8NHXyP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AE2500AE;
	Mon, 25 Nov 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521205; cv=none; b=UGNeSwwHwibCTUt5PFid9IF60Lq2t6eubxdsNZeYOFEGlCeiAz2DtIN9Ni3LGWjtYYtDrwLJ4Dp1N/SGy2hh22pbxmhp1owfgPftBfjkCSdxZnNjv29CSzkk8XgUFum3ZPJOCTTQs6gf4gNL3L6PDLkdOpAI3CjpDSAU9PfY7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521205; c=relaxed/simple;
	bh=4+aIIrQDQdN2RNvt3CBdaOdj4skj9Ysc1EKakDy+zIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQoVZlR6G1lIlrfCdvvv5N+V6+Fq0V7zmoy88xqBdSJ4LwNyEEU/4ehiPJiUlRFTq4VCULuMFxMGjj+ixGHxVg3wQec8Fcn/IK2+mJ5aKdAAEzvYjCJz5kyfYe4Yekuyu0PRU3rQO/pUk/TY72SEoymVPAbrR1Vv/gkj5Elv+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8NHXyP4; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5fb8a4e53so2094596b6e.1;
        Sun, 24 Nov 2024 23:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732521203; x=1733126003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWnVvKzBa5sPQS45/emYeIHJMUXVoEipvvJ273SRfMk=;
        b=f8NHXyP4M3a11nIKq5/owqkLB1xxyBdY33pi3wTurnyrMsKdJfpTEx1m+JIm9IZm/n
         hHlJnG2u1qpX+wQ9Bl4H8fNfP0bbu4owmVeltrwdDVx/IOHVDmtwD234pAn9Dn+jLxsq
         iz3CrY9HTyIW3yzWBDt0c/FYZirS9HGzUjUKodEgLUjCCbc4pnHoPy3SjVddThw0sB4I
         VqyIJy8j5L8MDc8FK7mABMNLRxLqrC+Bv1/af04dKXwezmmemo5QUW3PCoLndh2Q71YF
         zMYDOK66V4D3i9wj+0Pq8ULU56FBQqbenMnqPYcU1xwchxtV8jgueWE/B6dxh2sR64oa
         R90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521203; x=1733126003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWnVvKzBa5sPQS45/emYeIHJMUXVoEipvvJ273SRfMk=;
        b=Q++yOxHc4nUYR60cnttG4fNoXnQhgBW6rchzDjn02LE19ol/EL93SqKZcEUaU1C+So
         Ftrd3262Nh+F7+dEVMQHBpdF222hcuYxrm7MydAuCwmbRRndrvwBqddZxUqTO7ecZKGH
         I0jQnqNci4V1efQlOrVRnDBtALzlMM66vgckCGOo/Dxws41yLXp9OPsqGXwAGLJCkNxX
         RcWThvjRChvReGdymnIWw94IfG5oui261MAKrbVNRMCDgoqjvxR+7IYhr5JTquQpBqtJ
         4wAQg5FN4nxh9Tnurrapz540F5/8yNu7UXUDUNq6ENaRklowA/X+mldcH4PNU2+Kkulv
         y7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCULwJt8DK2JyLNpqCIWzNVuRx69HpoXmilg5KiL6eVXDjUUuskY06WgIgpdwW++W/Vb1KFutVH5wMLIr2D+@vger.kernel.org, AJvYcCXJSuqpJy7Jmo99JFyuC0ZGEIX/206xgEKj2lejncUa2+p7tUbZLgTAMvp2IcrpqpAHWFc7uYkPtNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkhEUGPvtkteyfp6uk5fKPUw4b84mz+SHvcae+NEasqOt31kaN
	HBzNymC4DazGuXGFoHd5uV8A9v5ygSVZLO59VbxEDKdg9+IbXmKA
X-Gm-Gg: ASbGncuNzMjdt4/n76SigWNt+V9EkoQTChpNWLVQyiklQIAf+BObcSIMFfwgVvTuBcK
	xw8jgl3FeSXWZQ8rfOGTA8LUh91nE89BMoMDyLPtyuWquspPwH15P5aRpta7GCKcPf5bnWJ7+1w
	FBcDd7CbWoZKaRTvSH/WkP1Cq/BaA7xQXaS5DdLaPpVVvi72DAJIMHBE/5Yy1gEMxlDXe3j5YDc
	TUXgCTS+s3AliFGQeyzkEcY8YFTFmXjT0nZdEiguL/Gxe/PYw==
X-Google-Smtp-Source: AGHT+IGVYemCxBGvIesFVI34du6YgsSgcjK88qfjRCFD04Du0gMVqc54Mw6q6tyWHsfyyagNiQRCww==
X-Received: by 2002:a05:6808:10ca:b0:3e6:6145:d0eb with SMTP id 5614622812f47-3e915aef01emr9362891b6e.30.1732521203005;
        Sun, 24 Nov 2024 23:53:23 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724eb968e65sm4624255b3a.54.2024.11.24.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 23:53:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 0BF9B4218356; Mon, 25 Nov 2024 14:53:16 +0700 (WIB)
Date: Mon, 25 Nov 2024 14:53:16 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Leo Stone <leocstone@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Documentation: tls_offload: fix typos and grammar
Message-ID: <Z0Qs7AyIxkZ75xPu@archie.me>
References: <20241124230002.56058-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EiBVjQO62PxNCZBe"
Content-Disposition: inline
In-Reply-To: <20241124230002.56058-1-leocstone@gmail.com>


--EiBVjQO62PxNCZBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 03:00:02PM -0800, Leo Stone wrote:
> diff --git a/Documentation/networking/tls-offload.rst b/Documentation/net=
working/tls-offload.rst
> index 5f0dea3d571e..7354d48cdf92 100644
> --- a/Documentation/networking/tls-offload.rst
> +++ b/Documentation/networking/tls-offload.rst
> @@ -51,7 +51,7 @@ and send them to the device for encryption and transmis=
sion.
>  RX
>  --
> =20
> -On the receive side if the device handled decryption and authentication
> +On the receive side, if the device handled decryption and authentication
>  successfully, the driver will set the decrypted bit in the associated
>  :c:type:`struct sk_buff <sk_buff>`. The packets reach the TCP stack and
>  are handled normally. ``ktls`` is informed when data is queued to the so=
cket
> @@ -120,8 +120,9 @@ before installing the connection state in the kernel.
>  RX
>  --
> =20
> -In RX direction local networking stack has little control over the segme=
ntation,
> -so the initial records' TCP sequence number may be anywhere inside the s=
egment.
> +In the RX direction, the local networking stack has little control over
> +segmentation, so the initial records' TCP sequence number may be anywhere
> +inside the segment.
> =20
>  Normal operation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -138,8 +139,8 @@ There are no guarantees on record length or record se=
gmentation. In particular
>  segments may start at any point of a record and contain any number of re=
cords.
>  Assuming segments are received in order, the device should be able to pe=
rform
>  crypto operations and authentication regardless of segmentation. For this
> -to be possible device has to keep small amount of segment-to-segment sta=
te.
> -This includes at least:
> +to be possible, the device has to keep a small amount of segment-to-segm=
ent
> +state. This includes at least:
> =20
>   * partial headers (if a segment carried only a part of the TLS header)
>   * partial data block
> @@ -175,12 +176,12 @@ and packet transformation functions) the device val=
idates the Layer 4
>  checksum and performs a 5-tuple lookup to find any TLS connection the pa=
cket
>  may belong to (technically a 4-tuple
>  lookup is sufficient - IP addresses and TCP port numbers, as the protocol
> -is always TCP). If connection is matched device confirms if the TCP sequ=
ence
> -number is the expected one and proceeds to TLS handling (record delineat=
ion,
> -decryption, authentication for each record in the packet). The device le=
aves
> -the record framing unmodified, the stack takes care of record decapsulat=
ion.
> -Device indicates successful handling of TLS offload in the per-packet co=
ntext
> -(descriptor) passed to the host.
> +is always TCP). If the packet is matched to a connection, the device con=
firms
> +if the TCP sequence number is the expected one and proceeds to TLS handl=
ing
> +(record delineation, decryption, authentication for each record in the p=
acket).
> +The device leaves the record framing unmodified, the stack takes care of=
 record
> +decapsulation. Device indicates successful handling of TLS offload in the
> +per-packet context (descriptor) passed to the host.
> =20
>  Upon reception of a TLS offloaded packet, the driver sets
>  the :c:member:`decrypted` mark in :c:type:`struct sk_buff <sk_buff>`
> @@ -439,7 +440,7 @@ by the driver:
>   * ``rx_tls_resync_req_end`` - number of times the TLS async resync requ=
est
>      properly ended with providing the HW tracked tcp-seq.
>   * ``rx_tls_resync_req_skip`` - number of times the TLS async resync req=
uest
> -    procedure was started by not properly ended.
> +    procedure was started but not properly ended.
>   * ``rx_tls_resync_res_ok`` - number of times the TLS resync response ca=
ll to
>      the driver was successfully handled.
>   * ``rx_tls_resync_res_skip`` - number of times the TLS resync response =
call to
> @@ -507,8 +508,8 @@ in packets as seen on the wire.
>  Transport layer transparency
>  ----------------------------
> =20
> -The device should not modify any packet headers for the purpose
> -of the simplifying TLS offload.
> +For the purpose of simplifying TLS offload, the device should not modify=
 any
> +packet headers.
> =20
>  The device should not depend on any packet headers beyond what is strict=
ly
>  necessary for TLS offload.

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--EiBVjQO62PxNCZBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ0Qs5gAKCRD2uYlJVVFO
o67MAQDQ58+mtn8D2IBIMaGfoAtkiQx6dHiiXnQSvGzJINGnJwEA3SrNkrRWbDkE
nP6gV2zl7E8btMvOQvoIk1BWhrGUDgA=
=dqSX
-----END PGP SIGNATURE-----

--EiBVjQO62PxNCZBe--

