Return-Path: <netdev+bounces-180865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9980A82BF7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F69A77D1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D72690CF;
	Wed,  9 Apr 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OSBPE+Ii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294E268FC0
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214354; cv=none; b=tb+gJQAdIwCZtxTtn/wK4c1SBoizPz8dfp9B7O8PfM40fjcl5yBXsrkMCcXXWLOru1B2pX6A1VbRS3H7BSQFmUI8jsC8XyjSnu5cpyD1IU60fVZriIpnt/NpIR8CcY+lc4yzxTRNitiac9lyLLK6B0PgfpZ/+pLn9MQ6SceNAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214354; c=relaxed/simple;
	bh=anBsj4GvqIsItzKvKqca3Ich12O7hzIpDPQdyk0UvBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWeIlb5XJ17DvDsFbUxQ3jMjNVGs7gEDhWZHv9638OTvb4UBqzNEeni6AGDDIDPan9iwH01KDRofIJ6iwwNpoHGhuuMjcvge+Q56iq0VQ9xm4gK91hG9Je9j84ux7+/q4hVMDnRcNitN8trfVcYncn8/ervwv5G06IxCp/ApxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OSBPE+Ii; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376e311086so9283689b3a.3
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744214352; x=1744819152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8PlMWZR0WUDTJdbI0lonJBcsSvrubmXJR+XeHZ32+qc=;
        b=OSBPE+IiCIojWbJseT8eWu3ZdHafmTp6esv9EolW7bOAhSCatA7ktj7/1d0w3vCHtW
         dlkmiejhS1PZXE4UjSmIaPrIrItPMxt7+A7NnMKJbjyczTe9gcBHNOFvyKLdHZYotEZm
         +5N20WoOHhyC6N2WOn9h8sqyTMy/D8GkxI/bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744214352; x=1744819152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PlMWZR0WUDTJdbI0lonJBcsSvrubmXJR+XeHZ32+qc=;
        b=QDf29A1a01lcSeS79X0xqhVHRugRb2JNWNWuHBFAV/vn+kT0ehRGhEE73v9oa33xNB
         Xl5Ckgph/aToExBQr38j8GI/IN9I9/NikO5orjv11EnfLiu7Dj+tFHB0iYfNjlk+cYkT
         68hwrNoYwUZDhlUOYBdFB84LzFx6K8RthD92oav8Xq+qpgH9mWbCSd/o5Un4OEbO8nuo
         bBlsJxbnEWvd/gMMsIVEsLT5uGfo/qgc01wCjK8pImLOQx45jc+TpTW5wEc59wtuEGse
         F1XIjARghREh40/JYzRujlcwhIXORqij/sztwjLutFiz+cn4oOhb4dF/HQtMAIlip83X
         N9jw==
X-Gm-Message-State: AOJu0Yx2w2Vatyo+puUCevPThZZY1cbllP6dqh4nV9SGgVOLuuhA32C+
	r8gIwbyC6lf9QDUj91NTAbdmi7VRn1dHHH2sjxBZ4AeNIgoMedmB1QXnilqQT1rlRs3AgQlL4Sb
	J/5g/kTz6sMmEaELIMKLNkxprc0UfqIbOm9Hd
X-Gm-Gg: ASbGncuvfpg1E9BrIFEcHZEZg3Kq3UVd5sFfohnW5XFQY64YYN012t9NCbHceem9MAj
	2b7jk8ikdAX3LDCVznE1XIi3qFHoKBuHgwJ9mDgOnDrzYk/V8ETdMoXvaQkrcvodyf3jxbMr8ab
	rxjRryY5e0h8HWJ2+IQHxrIw==
X-Google-Smtp-Source: AGHT+IHO03SDPfA9WGj3Cs4m7SjQs6u2HnfmUHnV0oPm9/4XpwhsNbi4vNCiA+6F7aVfCxgWQrL1EEANVUSsb3zybZ4=
X-Received: by 2002:a05:6a20:9f8e:b0:1f5:7eee:bb10 with SMTP id
 adf61e73a8af0-201591580c4mr5687772637.8.1744214352392; Wed, 09 Apr 2025
 08:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409151509.31764-1-sedara@marvell.com>
In-Reply-To: <20250409151509.31764-1-sedara@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 9 Apr 2025 21:29:00 +0530
X-Gm-Features: ATxdqUF6fa7l1GLeuluZL1wwoRwSKDJUx7qPwm05elJIn8V4a0mjTdzWt0g9SSE
Message-ID: <CAH-L+nPExSU1jEa7+RnC=LhRaAvdymGFyR8+8am2=_dQp2ZGXA@mail.gmail.com>
Subject: Re: [PATCH net v1] octeon_ep_vf: Resolve netdevice usage count issue
To: Sathesh B Edara <sedara@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, Veerasenareddy Burru <vburru@marvell.com>, 
	Shinas Rasheed <srasheed@marvell.com>, Satananda Burla <sburla@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e7544906325a8cd8"

--000000000000e7544906325a8cd8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:04=E2=80=AFPM Sathesh B Edara <sedara@marvell.com>=
 wrote:
>
> Address the netdevice usage count problem in the following scenarios:
> - When the interface is down
> - During transmit queue timeouts
> Additionally, ensure all queues are stopped when the interface is down.

Looks like 2 different fixes and better split it as two separate patches.

Also, please add Fixes tag for bug fix patches.
>
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/=
drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> index 18c922dd5fc6..f16b5930d414 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> @@ -526,6 +526,7 @@ static int octep_vf_stop(struct net_device *netdev)
>         netdev_info(netdev, "Stopping the device ...\n");
>
>         /* Stop Tx from stack */
> +       netif_tx_stop_all_queues(netdev);
>         netif_carrier_off(netdev);
>         netif_tx_disable(netdev);

netif_tx_disable() will internally invoke netif_tx_stop_queue() for
all the Tx queues.
>
> @@ -819,7 +820,6 @@ static void octep_vf_tx_timeout_task(struct work_stru=
ct *work)
>                 octep_vf_open(netdev);
>         }
>         rtnl_unlock();
> -       netdev_put(netdev, NULL);
>  }
>
>  /**
> @@ -834,7 +834,6 @@ static void octep_vf_tx_timeout(struct net_device *ne=
tdev, unsigned int txqueue)
>  {
>         struct octep_vf_device *oct =3D netdev_priv(netdev);
>
> -       netdev_hold(netdev, NULL, GFP_ATOMIC);
>         schedule_work(&oct->tx_timeout_task);
>  }
>
> --
> 2.36.0
>
>


--=20
Regards,
Kalesh AP

--000000000000e7544906325a8cd8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEINz23tDBDTAtWoRQivD3OS/Yec/L7PiX8I0euUAgWakuMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwOTE1NTkxMlowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGyFfDCmWhwHqlZU5hMUycjqt9dO
56UBBGNuaTgKL6cWUgWKngVhCgcMf8cWvXCOEzywgsTWc3k7EOuD9aB7Oq5EaBzLnYdxhWR3IGxP
QMINRGCEx8CR794H/yCzFgwAUnWCvkBqWmB7iGKdczCpDqkzUAjEolHiKr1+8pkpGXpyXowEA+Sm
RNwXrvAq0YjX28+87luCz3T0QC859erbjEd7794s5t41ph55lz4ewxTbPk9l1BBGtHvnquVoct1V
55XK1DyyCPd+ccR9JGu0HVi0aTERW+EIA3QjiMnXaUpX2AhknZ1OuHdJkI4nzK41H6ohbiGGJMnp
kyrDmaqaG8U=
--000000000000e7544906325a8cd8--

