Return-Path: <netdev+bounces-208817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19418B0D407
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CC169068
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6228AAE7;
	Tue, 22 Jul 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CumHq/oP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C8273FD
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171050; cv=none; b=ECdV9OVcKqCicPCCS5fKTZxdiNPzFaferEeH71MJb3l8wO2l1S0p1tEWjNVgVs2r0NqmI9QT64ZIzE365ZnMaO65GgRcmwzdUI+mejkALZiQNHC2M2esQbkWmn0ydtq1kM/RNk7BLoRcnNAE49GiPRC7j6j9ALvit2VV4H6mrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171050; c=relaxed/simple;
	bh=2I320sRWWqhLCCHuz5f4uz2k1TOyTLwaA+qAHl8Ahdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7/PaHW/FpPDUNP+/X+qpMtVnh/4/LEbnPEDQhEdDgvs7kECcDP9OYD2/hPQp5zPtLNdeqE4KhFTioZPHtjdF73/2OvVeTqMG0jW9yr7yg+St7lnKoASOvv5aJfu6j2hwMT5OqvK/xEzmswydp9KQPRQrD6wJgUk4o0Tc8BbN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CumHq/oP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3a604b43bso875814066b.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753171047; x=1753775847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EKIN2rsiG3TucakxguO94ScLmpfebHqYzy9tRJ95c5g=;
        b=CumHq/oPrEmlWPl2ks3vMSkbvFQR+BuyiEdQ09XBPFjF9vqLN+BZoRXSNDavs4tArU
         HR7K7QJRu9tBCzLPqVQ92SaQQW8szXyPst5J+ZFrzUqa1ir9rX9bBUQ1x3CABwOeIRky
         MFC5Zb1YyTPKQmSm3hQeM4UBZ4RBlqffyTsTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171047; x=1753775847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKIN2rsiG3TucakxguO94ScLmpfebHqYzy9tRJ95c5g=;
        b=TAH+mIxryl4aqd3bk+oFFWFhNsdMUgsu2WPhjvbMWv8w85Dz5LS5U7+IujX6jmd87A
         +CIbjnOMk0DKl0mYY3WEwHLeI1y2czQz88RlATeswhhAnh0/HKdqRMqWrE8j830uSjkI
         BPMaVoWnKN+Br09FBqtqQvns0GaS91WVT9EbO+FnobXBVGVy+na9uB7eu7qP5s8rdB+J
         33YTrVi4v8ZANnJ1ZslhocZ7huuf8zmQmuFsQizq4qk7Y5At4Wm9Ohuw1Pk9aJ7v6om6
         TTXJw0nVOk3x/oJM18LypKBkeX/JKUe8qEV0GDxSzt6pp+9ECnCyWPjWv1BwN9YrTf7B
         8Vig==
X-Forwarded-Encrypted: i=1; AJvYcCXBixbZWidqeaHIdrm47C4jFa+dMnbKmmdV20ImL5HoXAGs9FcED5F+aoNW6C6EU+K5tXcX4rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUGOOFA/uX5nF40iR5WQW4ATq71fe49HL1aCJ4rOXf3EWCPIo
	0WYNHf5nkEWft/9t6Wz48Wzu0P21psqhsVbwqW+Y9O8i8N79HNv38/xQmSvOMzDRlEefv0Z7/JM
	l7BfaRPv8xb0hqcbG2jMkaQj0XICCO/XjdI0A12t9
X-Gm-Gg: ASbGncvhmtXGEs+/bJQYf8cGkkkOVOkoxEhyI7kowzYvm0kViiqvB/+FS8Focc/HTpR
	FknAhuFfhzxKmTp5Wh/vzwxnI5G5BgaoiLB05dg39FaMB7eOBwtIAxNHbuMQFM6zvU/SQGLD15r
	W/Wde74G4iAAJ02ZPSzXgVLLDlDcsZP5fMc7Tt8SW8B1cFz0TuwcN9QGy8tR9A7EJuMy1FEeUr9
	cB1WNpQ
X-Google-Smtp-Source: AGHT+IGORnCPTFMtKbbfxRUu37knKFrQbeNJm8dk2w4WVLD7pRAClJ9l4zlpyffOCYEA2g8VnhdB/wrvwBNPznMcVTo=
X-Received: by 2002:a17:907:d508:b0:add:ed3a:e792 with SMTP id
 a640c23a62f3a-ae9ce11c674mr2251234266b.47.1753171047249; Tue, 22 Jul 2025
 00:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722014915.3365370-1-kuba@kernel.org> <20250722014915.3365370-4-kuba@kernel.org>
In-Reply-To: <20250722014915.3365370-4-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 22 Jul 2025 00:57:14 -0700
X-Gm-Features: Ac12FXxD0rdpScidlaAY8qb-O_Qo30lqM0nf5GU87TMxWkT3SO3vbgUOOLJZLIw
Message-ID: <CACKFLi=EdZ1zisGZHZYQzqttQZx+8-vnoq5==mD98Tv80d1qxA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] eth: bnxt: support RSS on IPv6 Flow Label
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, pavan.chebbi@broadcom.com, gal@nvidia.com, 
	andrew@lunn.ch, willemdebruijn.kernel@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000877ae1063a7ff188"

--000000000000877ae1063a7ff188
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> It appears that the bnxt FW API has the relevant bit for Flow Label
> hashing. Plumb in the support. Obey the capability bit.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 1b37612b1c01..4b7213908b76 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1582,9 +1582,14 @@ static u64 get_ethtool_ipv4_rss(struct bnxt *bp)
>
>  static u64 get_ethtool_ipv6_rss(struct bnxt *bp)
>  {
> +       u64 rss =3D 0;
> +
>         if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
> -               return RXH_IP_SRC | RXH_IP_DST;
> -       return 0;
> +               rss |=3D RXH_IP_SRC | RXH_IP_DST;

This flag means 2-tuple so we should:

return RXH_IP_SRC | RXH_IP_DST;

> +       if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL=
)
> +               rss |=3D RXH_IP6_FL;

This flag means 3-tuple so we should:

return RXP_IP_SRC | RXH_IP_DST | RXH_IP6_FL;

Both of these flags cannot be set at the same time.  It can only be in
2-tuple or 3-tuple mode (see more below).

> +
> +       return rss;
>  }
>
>  static int bnxt_get_rxfh_fields(struct net_device *dev,
> @@ -1662,13 +1667,18 @@ static int bnxt_set_rxfh_fields(struct net_device=
 *dev,
>
>         if (cmd->data =3D=3D RXH_4TUPLE)
>                 tuple =3D 4;
> -       else if (cmd->data =3D=3D RXH_2TUPLE)
> +       else if (cmd->data =3D=3D RXH_2TUPLE ||
> +                cmd->data =3D=3D (RXH_2TUPLE | RXH_IP6_FL))
>                 tuple =3D 2;
>         else if (!cmd->data)
>                 tuple =3D 0;
>         else
>                 return -EINVAL;
>
> +       if (cmd->data & RXH_IP6_FL &&
> +           !(bp->rss_cap & BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP))
> +               return -EINVAL;
> +
>         if (cmd->flow_type =3D=3D TCP_V4_FLOW) {
>                 rss_hash_cfg &=3D ~VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4;
>                 if (tuple =3D=3D 4)
> @@ -1736,6 +1746,13 @@ static int bnxt_set_rxfh_fields(struct net_device =
*dev,
>                         rss_hash_cfg |=3D VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6=
;
>                 else if (!tuple)
>                         rss_hash_cfg &=3D ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV=
6;
> +
> +               if (cmd->data & RXH_IP6_FL)
> +                       rss_hash_cfg |=3D
> +                               VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABE=
L;
> +               else
> +                       rss_hash_cfg &=3D
> +                               ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LAB=
EL;

Here, it needs to be something like this so that we only set the flag
for 2-tuple or 3-tuple.  The FW call will fail if both flags are set:

if (!tuple || tuple =3D=3D 2)
        rss_hash_cfg &=3D ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
if (tuple =3D=3D 2) {
        if (cmd->data & RXH_IP6_FL)
                rss_hash_cfg |=3D
                        VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
        else
                rss_hash_cfg |=3D VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
}

We'll do more testing tomorrow.  Thanks.

--000000000000877ae1063a7ff188
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJZ3CwbeZi1mROeAGogGroHfX+A6e5jB
i7ngPH3qEpcyMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDcy
MjA3NTcyN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAFrs4lY4WsGy6QJsp2OLmT8enpO2F9Gn9hggNh2p/VOqLxxdjKBYlJY8+pA81corb28P
i/6fcdxW0tr0+fTFWwQZhkdgsEhfI5NbFwzRm7crUpY6S8tLajiJhrt7vcYhMddFUMHy5/aMVg1O
kcRsFSo5ObNIppZY66Gnkgfk0SvzUS5eM7J2o4QQoh3Ymf3VqmqIBvZfuCckN9iEWemLuwuSWQHt
L55sYk+yrH45RBOqcFFdRKpsXI5/bVBMkY7vS0+pm9nAbPMx0KIliHKNQzA6h+MrK7QXX2g8mqfB
d11vvxViRM5Lbea6gbiFM38mozq8to/9LJUR8JO3fD9qNH0=
--000000000000877ae1063a7ff188--

