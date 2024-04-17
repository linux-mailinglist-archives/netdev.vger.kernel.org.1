Return-Path: <netdev+bounces-88565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50A8A7B52
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCD1F21220
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC74086F;
	Wed, 17 Apr 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3mtB7YO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1554084D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327552; cv=none; b=P9r7iPqMgRLKvqL+UykbUSucE/5S1T2uAuegtPpcxtwE8mTjZjZB/2O0TUaqdhu+VIn/ytR5Ljg1F8+DYoi7KlGVEPz4Lg7/rDHZ9wmrjWcoGxG6TNURvYBBEiiq9Qkqcuwm+y2jIyMP22iLBO44D6J5LLnONSPjX7UlmqTiBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327552; c=relaxed/simple;
	bh=IuZKBVSrmeMINBFUWU6LOpzrMGfJ4n+e2vbFpaZL6/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1VSAaV/OFQsVDysYXJYoqYvv9D21x06pM7kxmdWBcqO1Jq3XcGpUfHA5rFZTTPNC8DhsM/RHFoExKgyZ7iIof4cdwO/pDVqtIWegcNTB7G+ZXrfLbYYu3KjexRsyN81UjxxF9KowxV0PQiLa1K8y7c0ZhFnA6/YKUyiSHmKaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h3mtB7YO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5194cebd6caso123716e87.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713327549; x=1713932349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YPUkAv1pePBeCQT3fZQZgxBfLEi/YuD/zOmHJo6SDow=;
        b=h3mtB7YOFHgTKLmohWMGyigbcFe9rficJU/XTSXnFG17dhleNYTe8jw5sKNhBoXCp7
         5+OSGlOKUKPZ2MfdB9P7mHH+d+MBbvTYeersvWQXEnPeFgJXMqY5qqMRz6maTwH7S+kq
         0Vn152OMeAsn+N6kPIKgkDJ9GPtVp2B6lbgc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327549; x=1713932349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPUkAv1pePBeCQT3fZQZgxBfLEi/YuD/zOmHJo6SDow=;
        b=CHHa4v9oCjHS3TsKdO/PsC3Ik2hZljJvzzFgVHH1WB5ja2Xesho33hR8ciXXTLfq62
         5Y3+v+Y731k9Q6P8Ng5ZnroosDLhku4X72bJjyETE68gF75FtiKFy+bIESymuCLlD3Q4
         bGU9PrA3qlwufcA86O+KO7LIt7BGkBQVYJxzkjMKSY3LsoJrA0wQnq0khRM4Qyi0ldRO
         NIBRdTN0vea3dMzt7HzjevbgSUp/GKp9Q3wiWVNSmEL4IircUa8OF6zoXTFnELj0rdjJ
         +adYCXr8B6Gv3v+AaFZfAAoBPgdx70lZjA3AheKwMpguzrpLGXk1QtdVMXi+qz11K/PS
         yInA==
X-Forwarded-Encrypted: i=1; AJvYcCUqTMrrqvJH8i5JvJzphOgDBtWuTbYPKkhN/9D42uX/ud/rInb+4APWfZCmwYHCWAzbdaYxCWx9OzwNAWeWuTcR6DOX+fD4
X-Gm-Message-State: AOJu0YxnQgpTJ4JFXMD81Sq68cH66LzZxB3WCF79ZggFF0HFd8xfeRgp
	gAg4StoQKi4NKGFnJJC2zn/dEMtxnRsTL47WYS9RddkqAFzwRYm7awkQ/W8A/95sOV86a0FBOvI
	qvByeHRk4HaRx4/qgzAHvdbmTRFKhi8bXMzF2
X-Google-Smtp-Source: AGHT+IFfZhZ28KblwpGf8nHin1JEE2ve/wT6eRGg5KP+50ksyVaIiNScJzo1Jbw20HWRxZ80UadwfW+8IVtHS8Gfulk=
X-Received: by 2002:a05:6512:4023:b0:518:a628:7b4a with SMTP id
 br35-20020a056512402300b00518a6287b4amr9674937lfb.40.1713327549252; Tue, 16
 Apr 2024 21:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713262810.git.petrm@nvidia.com> <449181a5ed544dd4790ae4d650586436848007cd.1713262810.git.petrm@nvidia.com>
In-Reply-To: <449181a5ed544dd4790ae4d650586436848007cd.1713262810.git.petrm@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 17 Apr 2024 09:48:58 +0530
Message-ID: <CAH-L+nNme442ST30dxGNm0e41ZPqRWNmmNpbK_HjJc0fLXw=VA@mail.gmail.com>
Subject: Re: [PATCH net 3/3] mlxsw: pci: Fix driver initialization with old firmware
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com, "Tim 'mithro' Ansell" <me@mith.ro>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fad293061643275e"

--000000000000fad293061643275e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:57=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> From: Ido Schimmel <idosch@nvidia.com>
>
> The driver queries the Management Capabilities Mask (MCAM) register
> during initialization to understand if a new and deeper reset flow is
> supported.
>
> However, not all firmware versions support this register, leading to the
> driver failing to load.
>
> Fix by treating an error in the register query as an indication that the
> feature is not supported.
>
> Fixes: f257c73e5356 ("mlxsw: pci: Add support for new reset flow")
> Reported-by: Tim 'mithro' Ansell <me@mith.ro>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethe=
rnet/mellanox/mlxsw/pci.c
> index 4d617057af25..13fd067c39ed 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -1545,7 +1545,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const =
struct pci_device_id *id)
>  {
>         struct pci_dev *pdev =3D mlxsw_pci->pdev;
>         char mcam_pl[MLXSW_REG_MCAM_LEN];
> -       bool pci_reset_supported;
> +       bool pci_reset_supported =3D false;
>         u32 sys_status;
>         int err;
>
> @@ -1563,11 +1563,9 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const=
 struct pci_device_id *id)
>         mlxsw_reg_mcam_pack(mcam_pl,
>                             MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURE=
S);
>         err =3D mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl=
);
> -       if (err)
> -               return err;
> -
> -       mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
> -                             &pci_reset_supported);
> +       if (!err)
> +               mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
> +                                     &pci_reset_supported);
>
>         if (pci_reset_supported) {
>                 pci_dbg(pdev, "Starting PCI reset flow\n");
> --
> 2.43.0
>
>


--=20
Regards,
Kalesh A P

--000000000000fad293061643275e
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
AQkEMSIEIPQMRHG2hOCikv566vIdQ33w+sJxN5yOrr8RUlLaLpS6MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNzA0MTkwOVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC77C5EF+lC
lBkdyXIUIiAyCdL/6m54qkH1q0hYVwxj3hzSG9e7Jf/MiapJ4IRQOmp/k7v7Pos+EzRR0DD82bEb
P3aBGETHp8volb2ZcI6OtJkV4bdFpfTXIjIleLssxjaE/dllUaCSRpPkj0Lqbt9Rky2cz5d2NzBK
V5BIGXht2sUJMDS+y0zBCcNWzLgRdvBiWh2EH1lr50FYAL/vIQ0KNf++B6S44BLeYz01/644GXMV
aQmX3IdJaVDRgs7rLvgNwV/5TtLHn3AukgMJcB90LXEv+4hogMhtS3HZPHMVr6QukuC8T58l0aVm
0P1PclMVaWtSBYXkyIZDrm1g5eTU
--000000000000fad293061643275e--

