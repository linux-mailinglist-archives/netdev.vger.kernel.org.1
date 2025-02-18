Return-Path: <netdev+bounces-167193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264DEA390EE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6334188F622
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C77E0E4;
	Tue, 18 Feb 2025 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dawQy4uE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D845BE3
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739846817; cv=none; b=pU9K+fWGqw82+uzvnAcj8VNQibKKILjDbLEtbncHDk7HwJA7I9rLJdx5YxLZrkx1489mhs2O4bBUa5XlPrLjuLaJ8jOeLMnd+mCqcx1EeD7NYvpebfLC/FpeUyzpyMFIZzXeYOJ/KBrg3Pb2fpIQc5kP0xTowQGse/EsPOObByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739846817; c=relaxed/simple;
	bh=XONZ1AhlAsEL7X1/V0jeLvAl8zgnAHq9y2eAs1mKPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvF8vIZlV3EQSaNds6+iMr/JUVhJLl5bzd3mFhLosgAPyevHLTsNnt2HB9Joig8K29gAcd+lR/XGQrlHF8ru3eKczd/B/qB2JWsh2m4WpGxbOFLHzCFBccjf7/EXCst4cTjT5AndcPBW+4bGMAHn+L0Q7q0U/V4cC72S+BEVwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dawQy4uE; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5209ea469e9so1867853e0c.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739846814; x=1740451614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AM6obmCRf49o6BfonaeW/EArmWLgZ1M2Pz+ZE9SXXdM=;
        b=dawQy4uE8NoIep0N56UycuoS8J5h6YEpqbaHfwyOcbCwAMDVpWZoMgHvYA7pKdikma
         R0NFp2X9BisPVIZlgGwB0NIt2JRmjwQA3KTEPyWhdEbA0T9YTYPOuUqLnPZJSiZI1LC/
         oxCmba0HmoW7jIu/vE4euM6TGgsYrkqATbMas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739846814; x=1740451614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AM6obmCRf49o6BfonaeW/EArmWLgZ1M2Pz+ZE9SXXdM=;
        b=Kir6XkNKNo/Miy9GH1V0lPwUSG96eem8yxf2/yuu6eN1PBlpGTd0St8RGIAq3TCCcl
         C8BG3CdFvr3TyEQstdVjwPVQ4xvRiaiIJf43tRqyZf11jjFrmc0s3qrFfFmUdLnIueHg
         7jDXxQoJTBlvmqLBL/KVQnlIwCr4xCWgqlXmISkeiJaawKyTHfwXOh0wiw8maUfDUHE/
         NUefG12SMqvI7jfQAhkDtieJcgbbfOcVeLffUSYJuYHQoP/xL7tF7PWyQRlvYzinyeIj
         ng6CVSeE1lPd29QgXhcVUQzp+5Ojx3Hrtb18/3IWAu3FrLfKJD103x9LPt9uViFctapZ
         YCkA==
X-Forwarded-Encrypted: i=1; AJvYcCWyX++YVcsb5v4yjrvkMFfSEmV2KQ7oLkIc76SZArPH4My9tOZBgURTHahoQXY44ofghpa3AAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHkSJV+8bqMaj190KiaKh30JPd+8smBpwsiTASsLS8clp2Kz1
	VLLT2hOtuprS6laHoAb2Vl8hukoOb0Pteqq03jDMBARAgwExZ7pfQVYpRqdj+pzw6S+UODoku4v
	T+HVB2E/QyX02fBUuf973cHThQuQeIjv6YcP6
X-Gm-Gg: ASbGncspTLmpVDrUlN7rdi7uouBuBsJTcycD9k18Nfdzn0kJQhontL2Y2n/89qYFxBk
	QHOB2fGh1sa8NH4WYn0pOBRkFHBemqp3+s/cDNwzuPzewekcMWt/tsDcdHIKLj0LSSZ1PPZKd3g
	==
X-Google-Smtp-Source: AGHT+IH1jXAzFNI3nw3rXWAYD7AhGbQylFbPlKcVG17ev5n7QVBk37l/bLM0XyAd5uZLy/cpARKIlpYUcXbEMYTg9SA=
X-Received: by 2002:a05:6122:1184:b0:521:b3ee:4970 with SMTP id
 71dfb90a1353d-521b3ee4e69mr1480498e0c.2.1739846814634; Mon, 17 Feb 2025
 18:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com> <20250217154028.GM1615191@kernel.org>
 <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
In-Reply-To: <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 18 Feb 2025 08:16:41 +0530
X-Gm-Features: AWEUYZm3wbwgFu1jKUKQMq8gZdlJei2TqJLo6_vIYukmN4QyebSJKDR7mNPGIt8
Message-ID: <CAH-L+nM0axD3QWXixe6p7U4dyVx=qn9zh5crOXLTxTH9Gpd9dQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload
 supported in this module
To: Jijie Shao <shaojijie@huawei.com>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com, 
	chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com, 
	shiyongbang@huawei.com, libaihan@huawei.com, jonathan.cameron@huawei.com, 
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005d5581062e61a7e4"

--0000000000005d5581062e61a7e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 7:47=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
>
> on 2025/2/17 23:40, Simon Horman wrote:
> > On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
> >> This patch implements the rx checksum offload feature
> >> including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
> >>
> >> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > ...
> >
> >> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drive=
rs/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> >> index 8c631a9bcb6b..aa1d128a863b 100644
> >> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> >> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> >> @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct=
 *napi, int budget)
> >>   }
> >>
> >>   static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
> >> -                                struct hbg_rx_desc *desc)
> >> +                                struct hbg_rx_desc *desc,
> >> +                                struct sk_buff *skb)
> >>   {
> >> +    bool rx_checksum_offload =3D priv->netdev->features & NETIF_F_RXC=
SUM;
> > nit: I think this would be better expressed in a way that
> >       rx_checksum_offload is assigned a boolean value (completely untes=
ted).
> >
> >       bool rx_checksum_offload =3D !!(priv->netdev->features & NETIF_F_=
RXCSUM);
>
> Okay, I'll modify it in v2.

Maybe you can remove " in this module" from the patch title as it is
implicit. This comment/suggestion applies to all patches in this
series.
>
> Thanks
> Jijie Shao
>
> >
> >> +
> >>      if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) =
&&
> >>                 !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4))=
)
> >>              return true;
>


--=20
Regards,
Kalesh AP

--0000000000005d5581062e61a7e4
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
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIH/8BG/tt2860JmLranvbkSP71lCPs3CvjtfYowfmnQaMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIxODAyNDY1NFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC7b4oBuHwl
HTd5np5B9Jq35i1TStnZqZRDLM8EkIQ/UBhy2spC96GxWkdImXI9uf79wBb9VvrEcwzFcAMoUJkS
pI6VPY7pYvzv2AhdFkdxZS9penUnzxvYdDKcQXrfQ1n8AMeZkWmc9wZLJdPJPOtzNBT/41Blu473
Z8OoAGWf7k7vDxRnyiTp6HRd4HsbBLUo+66WF9A6KbSbW0YDUMqLnwvYXm0M5nPAM33xjl0pxfKl
2FIToPT3psUFxHlRKJE4ybI1sXfAaiuIL2MRJq3FX8E9qdBKaCFCqZxG9MHrED64IDOmyJTFdeDh
tdkiAf0csQsvL9QwVxwkM9uD7TfT
--0000000000005d5581062e61a7e4--

