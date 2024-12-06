Return-Path: <netdev+bounces-149581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B749E653B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDA281A8D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB115183CD1;
	Fri,  6 Dec 2024 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XrA61OCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626BBC8FE
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457667; cv=none; b=eXbwDDfwJayxvI64rj0wgiVuZ6EH3PX8OdTTdkqBYcRDxeylSwvHz5HX/O0Y6g63+5Du7FHFSXg1PENyoHDf649qFEV00TaUmN2ox9t9mtZPhSgQtaW5E6gjbHZAYJomI/KKktv0L89dlnzeYR/ALZ9mYGiym7XArJIn31glcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457667; c=relaxed/simple;
	bh=qLFyfKd8qjWYYggWlA+8gnH2EmlzoAVX22NyePirYac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuNyn784thr7PgGDFgSlx4+9PvWoO+6kvxAYQbd99C1bk4iIVDLLhD0Z7laQjaen6lAObfklVY75AkGoVshRPk8J/mzHkXf5XPQy6KteGkv+KkMdCp19AJZSvocxvjf1PYoBFU2sakplB00elRqog98HuHu9TX902E1iswl3m40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XrA61OCn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e224bbaccso1811708e87.3
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733457660; x=1734062460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgoZ5EPnVcJtIPlBB5urwCNI3WWoKEKxaCFusW2wZHQ=;
        b=XrA61OCnKqzSGa9tPHewITtZuwFj1jzOesPeHuvLzMIDCO+SpZ3Y0jgFqdlQQ96etl
         1t69EJRUQ5amcMXQ1J00EGoKsDVJ8ZeuIGF/0qfCJJnwodFFmYMtMeeLJr3o1O1YeRNE
         uEGTIek7plJpL+f0EYeF4gsltf3i3bOBC391c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457660; x=1734062460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgoZ5EPnVcJtIPlBB5urwCNI3WWoKEKxaCFusW2wZHQ=;
        b=uM/Fq8/glX29WCBC+1ZdLuU5jXwhPP2pa0Rpiobse1GO9FPFnYRARJjYP8ptd3zo93
         K6xYu5Q/pZChLQSvAzYnttNwEj5fBPGrmOQ+B39GJgXY5jI7e3GGYkbsWtYv3pBYPFxR
         reB0xl3mKrrfw8uQNM+/UyY7jSkF6MVTRS5ckwJYF3alqpMh56YpmZOk8ro3R6mmJZtO
         xgfznTCknsqlyrnUmCNIDzgYZCkLKOF7oqPyJwaJf2JwbclfszE5xkOnKliVTdtnQQ99
         /Z9LU4zh43F9dICmIVV8E3SYD0rUrl7ha84ecOXiCqsJwUJy5RYD8Q56HIqctfcnam2V
         3qoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrjqZlPq03D/MtDA0p4yoguAYsbRq2yziGYHtlbmKEd2a37ddL65tGsr0rqljZWU1aGP2bGMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkvz35lbKLRVBezMeZLWnqWzbj+EmL97APj/EXe4udGWzQsR7B
	nvpAY3uTuIyY2/gLuSmUUvXDTPDBNfzfwHUZgC2KekxJgflKZDULLwm0QhMK7MYpDcG02Wl4LYJ
	XQ4m6GGqbUuNCtVCfC7k0Mz6pBoTITUHk8b+P
X-Gm-Gg: ASbGncseUZm3sx/B6/CrhiixZqCiAypPta/rVH7YyXk6nl9pNZga426N4fPP5J1zAxK
	xAWJqtpA1A6ccu/FqL5GA2BUpoPxfL5dA
X-Google-Smtp-Source: AGHT+IHlNfIQpcxbeBmRsr/yfMu+dVHztwR8zwbBWiTVNXFJqvVdRvEAxNTuRGvlg4osu3m61OOxsPWdIciR8DI4gKE=
X-Received: by 2002:a05:6512:4024:b0:53d:a132:c68f with SMTP id
 2adb3069b0e04-53e2c2efb2fmr523371e87.47.1733457660445; Thu, 05 Dec 2024
 20:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com> <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
In-Reply-To: <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 6 Dec 2024 09:30:49 +0530
Message-ID: <CAH-L+nNxO2NHG07JOqUnmWLNhVYRKJOHsAN7uiEnAibBTmaATQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/28] cxl: add functions for resource request/release
 by a driver
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, 
	dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b54a60628921074"

--0000000000001b54a60628921074
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:11=E2=80=AFAM <alejandro.lucero-palau@amd.com> wr=
ote:
>
> From: Alejandro Lucero <alucerop@amd.com>
>
> Create accessors for an accel driver requesting and releasing a resource.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 53 insertions(+)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 8257993562b6..1d43fa60525b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, st=
ruct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource =
type)
> +{
> +       int rc;
> +
> +       switch (type) {
> +       case CXL_RES_RAM:
> +               if (!resource_size(&cxlds->ram_res)) {
> +                       dev_err(cxlds->dev,
> +                               "resource request for ram with size 0\n")=
;
This can fit in one line?
> +                       return -EINVAL;
> +               }
> +
> +               rc =3D request_resource(&cxlds->dpa_res, &cxlds->ram_res)=
;
> +               break;
> +       case CXL_RES_PMEM:
> +               if (!resource_size(&cxlds->pmem_res)) {
> +                       dev_err(cxlds->dev,
> +                               "resource request for pmem with size 0\n"=
);
This can fit in one line?
> +                       return -EINVAL;
> +               }
> +               rc =3D request_resource(&cxlds->dpa_res, &cxlds->pmem_res=
);
As an optimization, you can return directly from here and thereby
avoid the need of local variable "rc". In the default case, you are
returning directly anyway.
> +               break;
> +       default:
> +               dev_err(cxlds->dev, "unsupported resource type (%u)\n", t=
ype);
> +               return -EINVAL;
> +       }
> +
> +       return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource =
type)
> +{
> +       int rc;
> +
> +       switch (type) {
> +       case CXL_RES_RAM:
> +               rc =3D release_resource(&cxlds->ram_res);
> +               break;
> +       case CXL_RES_PMEM:
> +               rc =3D release_resource(&cxlds->pmem_res);
> +               break;
> +       default:
> +               dev_err(cxlds->dev, "unknown resource type (%u)\n", type)=
;
> +               return -EINVAL;
> +       }
> +
> +       return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *fil=
e)
>  {
>         struct cxl_memdev *cxlmd =3D
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 18fb01adcf19..44664c9928a4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>                         unsigned long *expected_caps,
>                         unsigned long *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state =
*cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource =
type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource =
type);
>  #endif
> --
> 2.17.1
>
>


--=20
Regards,
Kalesh A P

--0000000000001b54a60628921074
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
AQkEMSIEIC6ln8mIbbgYchIc+VLsscn5hzFWd7nh9DkEsHiushnYMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIwNjA0MDEwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAOsTBBLZpD
RN7OS29LWQ2jTVBEHgD72FFzheiz4QJt9xm8NuBAMXYyN1Z7SRKDfPOM1//hO1ST5eEpVhH0SXSm
A+Ob6gbayI7ljqWaflNtPuvk4pTXky0ZxnpMmQZ5+HOyVOaEwq9ItonSYyS1AUD3zv1P2t1tQeEI
QUTrJ2PvwhI5c83zqgUo8UvENe9DycrGAKJEC3hrQb0e/IJ2UxNtOsCao7AaWDALMuUgUtNBwGzn
MWfVoFqKnZWZAprsySwQJXqHu1gO0ioshFYtdVNYZzWilNqGbp05qp6BDW43zpXlVkRCfv/Tb9d2
t3jaJ6TKTynUkkMP2TQinwK4riBx
--0000000000001b54a60628921074--

