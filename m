Return-Path: <netdev+bounces-138975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85BF9AF90D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC3D281E33
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376218C012;
	Fri, 25 Oct 2024 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CD+SoW2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB082485
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832566; cv=none; b=AuOVHkrFQVQkp+ZMwqymM71xbtJUo4f7F0AhmVxJJ2x7kwEY2bgCW6YzFY3iYdVTjcsWJKhRlrdhXGvQ7r0RBYidHiu+IyADFsu9O3ZMwGAMHZaw1CH5CC0c/1rAXFsYPnfcxYFdofP+3qetnQFcAdn46o0C7l7N9r1ggZmYrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832566; c=relaxed/simple;
	bh=4mYCmC+d1bThJe7WUqaKGOxO3+WsNfAoY0fbCR7ZjZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFTK5KH8rhdcmp0lU11HGYlf+xW3hLpgYDg1B+EO3A0zUZHUM/xSk+uydrGfpj+ztdD/VzNNo8CpkQ/xbtLyiLrPmxSbT09d5Z9Nj5K4sIK2tj+MfXvuJ86QFxrPo7+MD6HmJs8r5zw5tMlko+G/71HuKfjcnHHVxWxKRfUthYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CD+SoW2g; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso986819a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729832562; x=1730437362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dt89QTNY3FniyGQQuRfrjz9eO/n4ofKR5LzO4sCM+0=;
        b=CD+SoW2g0lH//Glf/h11iIapg/3nlkoU8+/dJqKeuBVNbtj1e6DwUqdaot1GC9Y3I1
         NHpsxoEePHtIKacnjs6mnSju4RrpzJBJVG68E1+COhkAyXOaZpD1mZjNFliUXOCfLRrF
         onHe+UPgYFx58Yfxd56+AM1F7G6KoOPEHsiiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729832562; x=1730437362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Dt89QTNY3FniyGQQuRfrjz9eO/n4ofKR5LzO4sCM+0=;
        b=VMMDXGEvhkGAWg9dB603zp8XK6UTwCSzMt/JzwbkMx+GqrB2GXQYqYql/OIgeTztKu
         b/11yKbCQFUhKE9nZT999Wn/u4LhGZdOL6E8riIf5k43zSAVirezAumgl+4mC0ohx3Sp
         bDq0e1P6MV2mvj419VDx7ycBIkaB5AcOBPQ6lc7y5914m5/qFoH6USIVrv1eE4gvj2ZY
         tTUbxzIcqwsga7tAatjEJTryldylXVI2wXzaAfLY1SMuQvCBLtx4ZaLMyg1IctZs+8qk
         7RDupFRSVPIj/Fiz/E7ME5bbvcQixNsP8/yo7Mq/gY+Gy3se7jyneCI5kTEPDdfjPeVc
         37ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJMspqEV1smuLWUPsjrHfzXrAeR2a76Rlpp4lUXc+r9UpObc+DaIptWakqU90y5tBMotgPoH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gVBZ8XGfcoXb4N7h3za6K+iwMqmmqJ5W1BU+/y7BZyiMn2BC
	M7HHKDLzjjMTCHVGDUocU+emdQNDqS2JfhcZyjMTOd6FCcjINNbN9vwbWUXoG/XEOjA8GgWMjpb
	vfDmg2TVW6De5CbsUlNlq3ENehbRhdKRcpPj5
X-Google-Smtp-Source: AGHT+IG/dZQ4jywnbZFTj5NDhEIaZGr4F167NgRxo8Xk7BVzIxbsd7OTlP9fZ5N9t+G8AYmV19MbKCLlMl7xajYFziM=
X-Received: by 2002:a05:6402:1d4a:b0:5ca:8b9:6e06 with SMTP id
 4fb4d7f45d1cf-5cb8b1907acmr9323170a12.12.1729832561906; Thu, 24 Oct 2024
 22:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-3-ap420073@gmail.com>
In-Reply-To: <20241022162359.2713094-3-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 24 Oct 2024 22:02:30 -0700
Message-ID: <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006861890625460792"

--0000000000006861890625460792
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> NICs that uses bnxt_en driver supports tcp-data-split feature by the
> name of HDS(header-data-split).
> But there is no implementation for the HDS to enable or disable by
> ethtool.
> Only getting the current HDS status is implemented and The HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows rx-copybreak value. and it was unchangeable.
>
> This implements `ethtool -G <interface name> tcp-data-split <value>`
> command option.
> The value can be <on>, <off>, and <auto> but the <auto> will be
> automatically changed to <on>.
>
> HDS feature relies on the aggregation ring.
> So, if HDS is enabled, the bnxt_en driver initializes the aggregation
> ring.
> This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v4:
>  - Do not support disable tcp-data-split.
>  - Add Test tag from Stanislav.
>
> v3:
>  - No changes.
>
> v2:
>  - Do not set hds_threshold to 0.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++++
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 0f5fe9ba691d..91ea42ff9b17 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

> @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
>
>         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLAC=
EMENT);
>         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_=
THRESH_VALID);
> +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
>
> -       if (BNXT_RX_PAGE_MODE(bp)) {
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);

Please explain why this "if" condition is removed.
BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currently
don't support HDS in XDP mode.  Added Andy Gospo to CC so he can also
comment.

> -       } else {
> +       if (bp->flags & BNXT_FLAG_AGG_RINGS) {
>                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV4 |
>                                           VNIC_PLCMODES_CFG_REQ_FLAGS_HDS=
_IPV6);
>                 req->enables |=3D
>                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THR=
ESHOLD_VALID);
> -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
>                 req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
>         }
>         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);

--0000000000006861890625460792
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKaMKIwuuv9asRr7vRGvL1OuJhrClFcx
dh45HKEXCiBmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAy
NTA1MDI0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB79N6kup2gJ/GMAcGHjrOAJ5JMTOdIffTSRSE7qE9KXfPwUYkR
YoCnHVnhN5ZeoeWHXnOMgGbWO/YipA5SNGA7ZwpcyBJhWY3ZZCT/vZaT9muwD9wkUcEunZOl5vTR
8ZSdu+Qdo0BxiK0evIBun6HtkO8f7x5+RqL5s+EZjFsbkj2NvXkIQdXrjxb/PO69sTTaluhc/tZV
UJ8HUw3Zm2Qk1ISUwPBHnrDkJvNtGhfjz7F7e/5lP/g16nImtMre2KRiDS/YxjjiYJOSmuCo7dke
cs5V8oy76JXMRCJkWbZy149Zp62MU5oMAp3kEu06y+muXxmMmLmuPMxMAoV5mNBA
--0000000000006861890625460792--

