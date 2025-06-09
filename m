Return-Path: <netdev+bounces-195899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E199AD2A37
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3C41633FF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E6C225A4F;
	Mon,  9 Jun 2025 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ADCMFzqU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC821E0AA
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510243; cv=none; b=NFT4K2QrwTcMhiNM7+ieK0KIkuqtImGJ3U1AZKbwhXYcD+aUSGdJtPMVyBjbHol5NN1m97WqMUaZZ6l/jP8tEZrM5Klhs3fuESHFZMLDJ6nqSMnXJr+hzCI4UdahyH6ADX/v2fjJz8fUpRpt2AjrKdppuQVjqwAzDFJGH9hCZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510243; c=relaxed/simple;
	bh=tkkIZNr65LWsxwdURqmTje7EhYRpALq/aQlIKmUidJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzrGp3iUbGSN2ZU5vpTWfKu6MKScFWdJmzyNbZnmR48TnRcFus80VEpCQSkKFZfmXOFuy6qZX0ywBX+e32ZGP3srM0xe2T/w5Xpa9ognv7K454Gq5jaw/IHHJkd1XfNeJNLry+h4XkXh962jM2iq8NFHF30l9U/a8H4U0gnlCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ADCMFzqU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso4011100a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749510240; x=1750115040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IwfHQri8pp29e7WFlO9ldRHFDXlcbjRxh+UPJ7dEfDs=;
        b=ADCMFzqU4BZ4QmZFQf26m+WNJeCyUCOPevNFocFfVeGoHCvveWNrcwvdIZmlaWdoKS
         5gTadvMjNMxZhAW56JLDK5S5dcLmaPgueOOhbmtuUIyw1zF1umhW2a6g5oh0SuBWRJNI
         +u0E3HK2Er1ZhKc6+OAolkMYXxG4y8rlBHaNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749510240; x=1750115040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwfHQri8pp29e7WFlO9ldRHFDXlcbjRxh+UPJ7dEfDs=;
        b=Y+RKQWq0p+jKfPXz4Phi+pKLTsgY5ZD9Rm3hvqrgzcVBqEKnsOVbVHyiRxErIeSnoo
         MLRLZWKFRoOZTaudz2kWJRFS/tJ4R81/579A1w4rWcZ0jwCIcfOTmHjpu7YFmQFfKwE/
         UZh90KPp3cMal6fAib+yCx/FoSkuOq2xHP0U8uditexmefOBC/TUhJgpkq6BrT1BmYzj
         Z1UWFVyIve9VrSR6aNxDE4cX7uUxj43puUPOg3Odxs9DdJJZJTVRIbrU8DM5bFBTzc0x
         M2qx8B06D9YubjJYlN7Rn4H45y/JiPi+j4NZ0/SA6Nu3m7B6mYTFVJCrEGOXYK5M2Jo1
         jO1w==
X-Forwarded-Encrypted: i=1; AJvYcCXRaXF7rMXJr8dkRWAT+2R9T58X3jOivyJtUB9wHAyFkkGVXgksA3LWb6ptYoaAfh22HrjMrCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rgMEdFL3tgUiDEBtmCyuAJybIrRuNuSrp6aO+f1mSGEfe7HS
	sLVVZAkcs6Dwitve+AaGxepQww1zahFwv6ZJULR4utf5S/mUUIbO974/yxRxAN+APNsQNN1ZkxM
	M3yTO5cCZiKr/5cgXUQQNdlGM6YEYiJCfNbwvud4x
X-Gm-Gg: ASbGnctIqEvKR11lXqnJh38WG1ZTJCD//O8m4cj8gksmZoPQImknjkRZFGHPpRUwWVA
	nQ6syoaMwfohwYNQjezsMN/1plJtu16mbFfmyziTEki/8cNWXU/XWdFFgGeXmV78UBdX5M27/7+
	6uvMb/3Q9ZGj/SR7OUn5y4unWs8xxcW5U/L+J8XSRIYJpJ
X-Google-Smtp-Source: AGHT+IG8ZIEq+oYHfO4jfUeUw1YirBadtHVF9dVKc90niDaz3HPHGf+5gKFouB2iRhqgS16hfuSkNoEJlA+WzpnrBbQ=
X-Received: by 2002:a17:907:7206:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-ade7ad5b37cmr32768666b.56.1749510239968; Mon, 09 Jun 2025
 16:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609173442.1745856-1-kuba@kernel.org> <20250609173442.1745856-5-kuba@kernel.org>
 <CACKFLik-ri1gkE4T8UWEwCPZMtPE6PPZXYVbnYJSM26LwQqtnw@mail.gmail.com> <20250609114424.6e57da26@kernel.org>
In-Reply-To: <20250609114424.6e57da26@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 9 Jun 2025 16:03:48 -0700
X-Gm-Features: AX0GCFuliz7HrMG-dBz3ab1wWpRWxakryKK508FdTf6FcCNpgVtIEFB_UQnYez0
Message-ID: <CACKFLimwEPmYSf5ZAKxTPuhKmO_Dd9PwO2+01M8Gp-LkEWcS4Q@mail.gmail.com>
Subject: Re: [RFC net-next 4/6] eth: bnxt: support RSS on IPv6 Flow Label
To: Jakub Kicinski <kuba@kernel.org>
Cc: pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000067384c06372b98fc"

--00000000000067384c06372b98fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Ah, sorry, something like this?
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index fd9405cadad1..4385a94d4d1e 100644
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
> +       if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL=
)
> +               rss |=3D RXH_IP6_FL;
> +
> +       return rss;
>  }

Yes, I think this should work.

>
>  static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>
> Would someone at Broadcom be able to test (per cover letter)?
> I'd love to have the test validated on bnxt if possible :(

Yes, we'll get this tested in our lab.

> I can post a v2 with the snippet merged in if that helps.

You don't need to post v2 just for this, unless you have some other
changes you want to make.

--00000000000067384c06372b98fc
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICPc775j2qHPGsRAjGbZB6QNzRds0L3R
jB3KRCJ7JpcnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYw
OTIzMDQwMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBALAShJ+pCE+56krh5cU172golEsO5e6SXL/7CnhlNCWWHNxkUCM/u22W3QNVeJso7AIk
U7VrUd/kxB5hswkryNgxtDmJ2xqqSaT+WVpNLFwEhku4gk4Opw/6IrFOgBg/oMhwFXVIfgj6cViK
/gAqLgqhAW1vO6xQcid/Pu4E9PmE/jlZIz++d6e14JWwHUWLTRZrFjINlg8VlOQxE4r6jjldbwfp
D+4fQO5NiuFflY30/Le806IdvZZMMzZoaik7lRtIJy8V/uYJoQbQ+5h+ZG6CL+AF7p61NK7htmgB
ZW5IbmJWDQbtb2hO+cq2+2rKRPn1fK1EDbRE8zAZJYIHIL4=
--00000000000067384c06372b98fc--

