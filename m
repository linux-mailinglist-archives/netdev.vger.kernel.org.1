Return-Path: <netdev+bounces-178492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA754A77404
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 07:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74583164EA9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 05:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DBE14AD20;
	Tue,  1 Apr 2025 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wknj1KQV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C8C2C6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485965; cv=none; b=LsO0fny+wm6E8o2/IkQAars0V1GwBBXjrYzoyPdQqg4I0Ezj8f+dpzCZ8YdZb3RcXyywbUB+nGRyzs4I/LmgxV1JRCtX9zspnvq3y9QnSvx6qIgYUkMG1+Of/+Eok87ul/flxb4wA6deLAwxcHb2PDb2mSoGmkjzSa+ymNp9fSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485965; c=relaxed/simple;
	bh=6n8d0nqlqI5l32k66jz9R7Hyn3aszh21lQeUCdEr9Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aESt4o40FGQzP1WxZkzi4QMpzuDlSW0Qg5TPGWPG5BCc8UZhjaXPkxeGW8S1kdLCEnPHaEnHNctfogcU1OuCau+ePRs97VRRR7kyxUWoL+3X9AggSbS5cq7Sr8p/kIU5r2x/vH/HM8Suj6VwL0UrEavtpBQYNNh3tmQQEzBeV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wknj1KQV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so914303266b.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 22:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743485962; x=1744090762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/o79n3ElQHBrTem+jndKDHsKaN2Kw4wFyKi5mHX/sFg=;
        b=Wknj1KQVaKvGgzG61e36Tef1aLL6TUSwCx3O0n5mhTWWdQlzRj4qfbx+c+yZflRFPW
         gbt3EH5Ygqc8qDn4vDOwQWR2SISK4Fn7u/jbGFZcHCgGGl4qo8g1j8e0bZz5wTsA8kd+
         gq1TgEeVqhWrK3rTkjbS+pWepVESpcbozSWYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743485962; x=1744090762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/o79n3ElQHBrTem+jndKDHsKaN2Kw4wFyKi5mHX/sFg=;
        b=WOR2b1xlWo7L9JYOQ3h+ML1uVICxbtLsxXqWbQwmsBmewdGmH3BOBy6iGPJW4cwLzm
         97eox1tBHoP9j/IlP/BmeMpIW439w2+bOXQc5g9i0xlADicNhoC/Pr0PIGvzZV70B9ih
         9dpQ7VwvmY+c5lBvgfMloEmwYDeXk6cV1cGEu3O9rqn8y/G7YuFwyZ2vxohKx9xE8ThG
         BluzEZsiko1gUXSItngNh5boLYcvTPT7dzXI7e6HTHmnblq0Gm670rZRDGPUT9jEM1Ye
         Txfrq5HRb9lSg66oUiI1ONn5H/DxA6F0dlOq1ReGyHu1se5qr4rek02MKwZYGhnDSl/W
         6inQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp7D1HYh25hNI+80iErLoEJ+4jsCJZ9tkCrTtoLYTQHAcAN2zB83wHXtQn2StHxI52h7+wCT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoB8SsYJbbY+Kf5VxFkq+x9cG5N/vB6Tq736dxxKIFDOUgoU/
	3vddDM8b7XyFOcieUQeHCWeBPsztX86TjodQyiZIFvzXLWZ4ag00wIEeEZbstDbpY3oL+T+bi0A
	e/omj7FHqgzF3KP4ipYytLVbUMshxIgqkumVg
X-Gm-Gg: ASbGnctCHAkRv26UODZ2uCikTsWW2mq1yUCm+KN4AwqC9gAVnhS1oVuF+fX8EXnOEZK
	CwCrQ09wscpIAZ7y4otNuMK1fVxFe6OnrlNbpVG00P2GG8MDy6yQKEm182H9HPUNWFLEq452VlF
	a2i0ywfuEnkEz67mXVa18eWsz3FvP8J1z2obG/0g==
X-Google-Smtp-Source: AGHT+IHq0YpoLEsQECLxXkXKXx1sWFcke8bXxoOqRqB/8R3NzxEoRKDEAa6MCFYs0nFivI0oZH1FzVHgrFmUxCYLwkE=
X-Received: by 2002:a17:907:7b8e:b0:ac7:1602:813e with SMTP id
 a640c23a62f3a-ac782e3d4efmr135110166b.37.1743485962334; Mon, 31 Mar 2025
 22:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331114729.594603-1-ap420073@gmail.com> <20250331114729.594603-2-ap420073@gmail.com>
In-Reply-To: <20250331114729.594603-2-ap420073@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 31 Mar 2025 22:39:10 -0700
X-Gm-Features: AQ5f1Jr7maOzFOffb1s-SO5-Zt8ekEbBRg8pjBFMPBpl0WZg3o2VT9CXY2TirTE
Message-ID: <CACKFLinMwcWpv1Z13Si2sDPFUeRYx_aMfS=_46PWTBYmHvMm5g@mail.gmail.com>
Subject: Re: [RFC net-next 1/2] eth: bnxt: refactor buffer descriptor
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org, dw@davidwei.uk, 
	netdev@vger.kernel.org, kuniyu@amazon.com, sdf@fomichev.me, 
	aleksander.lobakin@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007b012c0631b0f583"

--0000000000007b012c0631b0f583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:47=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 934ba9425857..198a42da3015 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -915,24 +915,24 @@ static struct page *__bnxt_alloc_rx_page(struct bnx=
t *bp, dma_addr_t *mapping,
>         if (!page)
>                 return NULL;
>
> -       *mapping =3D page_pool_get_dma_addr(page) + *offset;
> +       *mapping =3D page_pool_get_dma_addr(page) + bp->rx_dma_offset + *=
offset;

Why are we changing the logic here by adding bp->rx_dma_offset?
Please explain this and other similar offset changes in the rest of
the patch.  It may be more clear if you split this patch into smaller
patches.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 21726cf56586..13db8b7bd4b7 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -807,7 +807,7 @@ struct nqe_cn {
>  #define SW_RXBD_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_CNT)
>  #define HW_RXBD_RING_SIZE (sizeof(struct rx_bd) * RX_DESC_CNT)
>
> -#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_agg_bd) * RX_DES=
C_CNT)
> +#define SW_RXBD_AGG_RING_SIZE (sizeof(struct bnxt_sw_rx_bd) * RX_DESC_CN=
T)

I would just eliminate SW_RXBD_AGG_RING_SIZE since it is now identical
to SW_RXBD_RING_SIZE.
Thanks.

--0000000000007b012c0631b0f583
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICiMkqJLDzGIZCfN/SrvdVbpisFnfkeP
lx0SoRPy6GsNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQw
MTA1MzkyMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAFAz5lVosg97vk39tQPB1c/asQO6k/1RyPXuelaHszVeaZALhNvXCHLLJjPJEO9KCm/4
e3Rsfr42ZMnTYUS9bDgEYlMZfH0EewnXROQg0jh1JPr+KDeT6O6+C3GncbQhx1yO796A+OqON4MB
S8BH6jmCLGD1B1dzwXAlS0If5JsdwwI8nC+F9FO9rY8RlglCJ55C3OCFMFnOTY267Eg+k/wJFtTB
dkIVb8SbuvM8N7HO3/7yGkbgHvsVBq+4wa65W16ZBFXVEmK8E7PHcF6lGWo3BhkHSLBhdsGXfna0
7RyWoKkQor7f+SW4iX/Jw/2J0Fsha4QEZQ3dPBVOUiGZY34=
--0000000000007b012c0631b0f583--

