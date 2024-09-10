Return-Path: <netdev+bounces-126974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0973711
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24BA1C23D16
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3F819004E;
	Tue, 10 Sep 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iHY3QZFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFD18FDB7
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970835; cv=none; b=qy6BElozR40hiBsJgARuNxX8y5gbKsRGYxsF2ym489+VgfRBV1xNW3m5F0RZeD9RRlOtOu5vHl+L1ZATZStaENIcpjEClXUiD9W7cr3iQDPkeZGgKfspDVwo2jVKZd+iiZt6YUTv+waayz8cSFnsg41A3usOY/Ysr1xcRKCcqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970835; c=relaxed/simple;
	bh=6e0f+5IU0h9CMqKHBmd0sHtMYKBHFYoL94oIvdD7SRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUEQHS0j4em9SeEydZzwMRuaqKZp5LLdbFIHdsL9E15d+wa99IAH+awV3vtv7pGIQtRs8fO7u5SAxWhgNlOwdZoMsyhV7tJ6EwlJU8fxCfpnZop1tzfasVng5PakV35BtiZS18cGCFcGT68/zUNd0MUTFasn1zDRrx7NY+4OMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iHY3QZFv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356ab89665so6450518e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725970832; x=1726575632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4vGShHWlh6bigl97YUyIj7CV2hXLvJLNVfPj9vapEiM=;
        b=iHY3QZFvcHA79UdeFtEHat4SAUF6iyzYY85H56OrQ4tyiYrZiO+HUdvT5ZgIJsAiim
         BAblCkaJtLZ/+G/8ke+LLmGTlGGg4d4VXKCAeWC3z0pEUrI/4+291MhEYnL9eQ9H+hTU
         FNxxbf7xx3RAqfIuxP7vx3pWThMsJG2S6RQDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970832; x=1726575632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vGShHWlh6bigl97YUyIj7CV2hXLvJLNVfPj9vapEiM=;
        b=WQbr+UJFFt6KmUr8lNQBPs378Op2hC8r47uhpocTFdZVybYGRNZFU1EvucfllCnCrX
         PlDuvNmgXy73/SlU6vE+rYG6A/M0BHl7du1J4lUaq7TegfAgflZR4WfSQGW6xeJ3+oBS
         SMS/ioV3VlRa0zWV2QaRFNGN5BnLaEuvxxOXtfjXitLWYrSUF+waEiXXuJ1puErzH6iz
         1YMcH4anofLCtEKYAUurRCw2SQzxbd7y5Yqn2WCEcedPLPaRimjIYU4bgRpvFLMJYs2F
         uJalfcbo6VAwqPFA82h5jH3CzNu5r4DCCCdC2ec5blz6l5yNjrLagVtMOSSfsjLNLspc
         VBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVYJozQqskTH/MgWF7WwQUNMoMd/ur+RWqtMHTTN+DNG0BO9W/RsOe+fEDKiz2jQXAukrclyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kdmNcSaXl9OwK5x7fHzf0DEaha1Y1yvsGZklCqsAPC/Zom3P
	1jwJT2AEkVRCXY2ElxzK72SwDfnTNMmXr/qW/LysP9WBVP5IWm0hCayZdmfoaUYWzfKVbgL5Fji
	Sry2r5InuX2vB/dE+978Il1Cq2dh6ilv2KIM7
X-Google-Smtp-Source: AGHT+IFOhcJDEeAuoCVEk+2x7EaaNyOntXSXrIRJF/Ykd/jDkmND7EM1c7af0RQn+qmcaX8TUoRgdf2ZOJiAAf7Z0Rg=
X-Received: by 2002:a05:6512:224f:b0:535:6ba7:7725 with SMTP id
 2adb3069b0e04-536587aa4d4mr8659704e87.3.1725970831388; Tue, 10 Sep 2024
 05:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-6-shaojijie@huawei.com> <CAH-L+nMPOyhkjt530-L9EvAAQ87nBJ7RdShgHJ+VOC4fpvLXoA@mail.gmail.com>
 <a8cf886d-415b-4211-8c70-e8427cc67921@lunn.ch>
In-Reply-To: <a8cf886d-415b-4211-8c70-e8427cc67921@lunn.ch>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 17:50:18 +0530
Message-ID: <CAH-L+nN7k-AuzRsQijp1wtMnz0Mmko2ZhsdBV3cQb4JzP3YkmQ@mail.gmail.com>
Subject: Re: [PATCH V9 net-next 05/11] net: hibmcge: Implement some .ndo functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, shenjian15@huawei.com, 
	wangpeiyang1@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com, 
	sudongming1@huawei.com, xujunsheng@huawei.com, shiyongbang@huawei.com, 
	libaihan@huawei.com, jdamato@fastly.com, horms@kernel.org, 
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, 
	salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005d7a110621c2e67b"

--0000000000005d7a110621c2e67b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > +static void hbg_change_mtu(struct hbg_priv *priv, int new_mtu)
> > > +{
> > > +       u32 frame_len;
> > > +
> > > +       frame_len =3D new_mtu + VLAN_HLEN * priv->dev_specs.vlan_laye=
rs +
> > > +                   ETH_HLEN + ETH_FCS_LEN;
> > > +       hbg_hw_set_mtu(priv, frame_len);
> > > +}
> > > +
> > > +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu=
)
> > > +{
> > > +       struct hbg_priv *priv =3D netdev_priv(netdev);
> > > +       bool is_running =3D netif_running(netdev);
> > > +
> > > +       if (is_running)
> > > +               hbg_net_stop(netdev);
> > > +
> > > +       hbg_change_mtu(priv, new_mtu);
> > > +       WRITE_ONCE(netdev->mtu, new_mtu);
> > [Kalesh] IMO the setting of "netdev->mtu" should be moved to the core
> > layer so that not all drivers have to do this.
> > __dev_set_mtu() can be modified to incorporate this. Just a thought.
>
> Hi Kalesh
>
> If you look at git history, the core has left the driver to set
> dev->mtu since the beginning of the code being in git, and probably
> longer. It seems a bit unfair to ask a developer to go modify over 200
> drivers. Please feel free to submit 200 patches yourself.

Hi Andrew,

I did not ask Jijie to make this change. In fact, I had added my RB
tag and added this as a comment saying this comment has nothing to do
with his changes.
Sorry for the confusion.
>
>          Andrew



--=20
Regards,
Kalesh A P

--0000000000005d7a110621c2e67b
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
AQkEMSIEIHSaWt71Z59yg8zVKTj1m4CXiAiFVMjcGyp09xkNulaUMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDEyMjAzMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAgFnxzEIee
DnozjnYuLAxlz1Aw1OfeyLqfcBiZnPz45i1KWXelprAaUjE+ivyuAvbzc6HsPNDQaXuVjGtt9ppv
6PhOsdaejtes/JrNvFd0Xlwa4Dd8+UKLZbZO9tPct1S64QCD4T6JAOTI1SsyByZB1yDAIuxpoYMl
sUmP7jghbD/BvulGzgieY5Aaai1ucJxPR+f2diLSqdcqqAQ5l/QVRHKA9KH5lkKp+FCgkf6YmZMa
Bag/EbhfJ77Nh39aECA5AAJ/Yb+iNDfErXhQVVJd7HN1E84dOciW4x8nX1Llr3d8Jeu2SOgancAG
wPwGaN1MkgvoML5Gom/ev1lgxuDP
--0000000000005d7a110621c2e67b--

