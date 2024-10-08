Return-Path: <netdev+bounces-132952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B7993D70
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9768D1F23595
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1C33986;
	Tue,  8 Oct 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hk7ckB0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7B2AE8C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357643; cv=none; b=HYLfwP744jPPt2M+dwVLH90rfZlVwTrG4Q8gWkrD66vxgGx4xciH4KhdCu5ZnavM9Tbat1QSb6CkCvxukDJndDXLDfRaG0rxlAi8eiLbgQbjRGZF32k30ocGPcJwSmZZpMQYt3rOVujMFVWFIKp1Rpkjzu8yQnvhINcCGpf4Bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357643; c=relaxed/simple;
	bh=ZE1YbacyrYOKXVi7KxJt+r0ThIE1K06OJs44ut3Xq1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ne2Z/XIg8helBE6FGjpsbhD26GEE+jaRuBYIEXLQuhB+OS27pTSvTNuIl+vnBRq38GNy0fLi3AX2U9S1NVI1lu0lB2EiJgtPnzvZuaDhNNMfyzGaKRLOUjz70Nb2S8SJ52IZhZDMx0Wp53smrqg+tVILx1HH2lVBNcuw1AM2Ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hk7ckB0x; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5389917ef34so5873512e87.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 20:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728357639; x=1728962439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awq09QHH3rvN6KvXBH5uUMFC13JRAP2vzJ5PlZOuk0U=;
        b=hk7ckB0xJLIYC7BEuv9buE8yDyZ0ggS5LX5o4yfjtoVSDrLEa/dMYqv6thlvNXt7XF
         Xf0sOx5e4fB6oyTV2ENQU04AFjRFu8UmqpA8CBvzUTJa137kkFL9XBumbth+F4W/6HHo
         BdxsGZw/jyz+2V3s1igffzd1kF/MDQUy3b3Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728357639; x=1728962439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awq09QHH3rvN6KvXBH5uUMFC13JRAP2vzJ5PlZOuk0U=;
        b=UEh5224topfy9BYXUZIBYUHmVCAFlpTuBynqoX1oTrOlEJqx/3C2M2Wupom8ABGcU/
         82aQA27bh7ziMh9Y96Y0aj4l085XI2rS1zJl0MDrYAQ9IrrTsiFoUz9mAZfDNUeKlWiA
         25AtfLwEqn9yjmi/kfDqxfZ7HFgSVoPhsIGXYdCrF5POjfSulLJfs9qBF1R69cZbUyYd
         arDX02MESST2TW5AsHpGhfyKRJdawtYIn+nMHC1SwEWXcazetJVQp8oyAJcCUMt5ib5h
         IMZporSj0z33BzpiX4C8nlDhlxfLWonIrigQuKnOTrwpB4Da4BPNg33vM/zr4Kef/DtY
         FADw==
X-Forwarded-Encrypted: i=1; AJvYcCVTjmzzIam6xT10iQMsiIrrN8IXYpi60IzYvEW/fCgKg9TTXX6jlsrinEFJkkPS1oJiSU8XAPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIjuSPTZ88wZsM9FQdzHIEo2jqJekMveyqUynxq/CenqgL/Pb
	1lMCUq+wBuT5k6mh9jp289GuwOQ2n0jmuPJd/vLIPIO7Br1G/5yWUfH/I+dVI8qsJZQEWGAGaBR
	svdF3CVaEJruuuZ4BbIY6TyeWCs11TLxC/R2G
X-Google-Smtp-Source: AGHT+IEHa6+eNK5U1LhIiO0/6B2GPO1KeLdYhSCgr67Xox2/uhjVlf1uVwGjcy90Fg6Dhckr6MzhP99E2xnVESp7/l8=
X-Received: by 2002:a05:6512:3989:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-539ab9d031bmr7280919e87.43.1728357638784; Mon, 07 Oct 2024
 20:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004204953.2223536-1-sanman.p211993@gmail.com>
 <CAH-L+nO6U12TRCUWNxjAFTSwaMfeadt+iHYtYFZHVJFOZH0sdw@mail.gmail.com> <20241007165611.3ee5bc73@kernel.org>
In-Reply-To: <20241007165611.3ee5bc73@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 8 Oct 2024 08:50:26 +0530
Message-ID: <CAH-L+nOrXuffynLQpPWvd8WaBJMseRCD3vR33CJ2er2fN1-06g@mail.gmail.com>
Subject: Re: [PATCH net-next v3] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org, alexanderduyck@fb.com, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net, horms@kernel.org, 
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch, 
	linux-hwmon@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020c9460623ee9f6d"

--00000000000020c9460623ee9f6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 5:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 5 Oct 2024 09:53:30 +0530 Kalesh Anakkur Purayil wrote:
> > [Kalesh] You should change this label to "hwmon_unregister" as you
> > should unregister hwmon in case of failure here.
>
> Not really, but you're right that there's a problem with the error path
> here..
>
> > > @@ -297,7 +299,7 @@ static int fbnic_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
> > >         netdev =3D fbnic_netdev_alloc(fbd);
> > >         if (!netdev) {
> > >                 dev_err(&pdev->dev, "Netdev allocation failed\n");
> > > -               goto init_failure_mode;
> > > +               goto hwmon_unregister;
> > >         }
>
>
> .. I don't think we should unregister HWMON if netdev alloc fails.
> We will enter "init failure mode" (IFM), and leave the driver bound.
> HWMON interface can remain registered, just like devlink and other
> auxiliary interfaces.
[Kalesh] I see. Thank you Kuba for the explanation.
> --
> pw-bot: cr



--=20
Regards,
Kalesh A P

--00000000000020c9460623ee9f6d
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
AQkEMSIEINSJR/+yUC+w+TNEWXo3r+VBk/qlu1akpi1d5QPMtHlJMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAwODAzMjAzOVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB64iDQc7ht
wOQDW4i8/6QfDGkP452NCi6+zhriqqevgoaPyBbjcafA8T6Hw0eps3HiP+cwCuRd9eEuQnKdQtmM
nYDHBHPos90M1aHCUJGtGdsfWK2jCfosa7kCmmyrrsToZJ1aVAOzmoT8sIm9wEffCMv3LXadfLu/
qR8J94eo24pLPYko1BCdfpPzqyAO+Xo33YEGhfCkA/OaZAU6f3OpYFBzFkQhKk/PGE+CYmOffGSf
N+OuB4H9IAebWEbXiVQvjMxab5Q2+u4P+ZYhrzABEOgdYlrO1Sgkvujf6oyzijPiU26qTCAlQhpi
ccqyKeam/IX+Yd+f/EZMJb9kVLYP
--00000000000020c9460623ee9f6d--

