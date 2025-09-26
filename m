Return-Path: <netdev+bounces-226756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387CEBA4C46
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 19:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DDD188FA2E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748343002CA;
	Fri, 26 Sep 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KWOdcNWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DB155C97
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907430; cv=none; b=I+WhfAVX/6xHe58FudA0K73oNpiXObpEnh05UXmHHXByth3kiONovLhmhW5FD8iXNR53CEs4U8QgXpEWllbmPtWZljimbXE9aah/klsRsynOB0L1SEzUbMizlseNJ8sintv6tpyYQV8ytdeMj2owkAlT9OnbgnVwf7jJLqMegSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907430; c=relaxed/simple;
	bh=hcpvErHxHB+DEreETzyem37npiXbN4vCs3OzUfQyRng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDrralfwOE4gO/S0FuLHjo0Cqr6DADmSoC8ucm3D2721gjCmjSfKBoJpWwtewvIb7LhDrm+MbJfwrAbkFH5aNLvlQ6VnxjN2ZWFi0PKrY1IsRWjua2IqPM5pX3LiScvKMYMtvm5IOMIrhU33nsp2DD47PaLdr5O65InR/A6/CCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KWOdcNWZ; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-4278a8ecf9fso3996765ab.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758907428; x=1759512228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t0QolULlc3VuPbuO/n3TlX7LsO8RmJSjCATNiECqeYw=;
        b=Rr0jHiMwCcrvat6SbrRcLwQm3PS0wF5ZisrBsmPN+rgiOlIBOkAGNOywfMDBr4RZ7g
         ZZWXHyuyUo8UAd58oAbmLSPai+KJEXdiPRic/A4YCo48NP70lbvlERSGCO8ZqosukgyZ
         +Hw6qs9es4FiNXIvAzPH7iEnMm9ZVJgQXJ+EM4J1hvAPBJ9O8mA8o4v4wh31HfZjvuyc
         rK3lmNx5Zs87qHvOB5aXee+T+EFAwfY8SjYZwC02JJ32L1j50eyn8HTwtEyKuuBeFI9C
         MbiGYpcPrmY07xCl/PO86CR2trtPl+3BMuMmKEveGuvpsDvsFF3XeFShtjZBoOkCN+/t
         qdPg==
X-Forwarded-Encrypted: i=1; AJvYcCV8cp+GF6xtWSV8kvkVaAjKqyPMwnmS0x8YMBUiJ+SuC3ag4SgocabNV0LA9ZV34Kr4/JkWb3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctxDwk/EF8B+POEP1RpWerGeuarDSHEHuQrbqh5EnUvms6l7p
	IA17aFmAHU2ivEXIJji6C8TyMMQdqsGuYy08y5DUJcVXjWwZntYoQNQeb+dwM6ujVo6b+u/Mu/G
	9Zfy01qo+Xg+u+dZAn8cT3sUEdqj+1kxqy2kBpUryzExaT21rV5zvtCpSrnOUzbbZBkgzePy4Qd
	mSsZzNzmsEqS/sG+5f61w+xSQiCw2fA9QFfRLpURBbN6gKmTwtmfk6bYdfe2deOCfLkxTmslLKY
	TJGFAHOil8i5Q==
X-Gm-Gg: ASbGncsvbSx84NX/L0KjSX4me3Xl+uD1UBrgu2mU8k0siF0xy8zoS1pTufKic4QoBTh
	uQDpXvymsswlOQ7rx9POBrL2/ImJ5UFi18E6hj/Ac6bEhM3PrMNNts05qyqcFp7en6RRXbskOUF
	dbaAWMVvhiu0L/SNs8etJTJKm8jgSSkgWd9O8ZQdszSQ3wHUYQztzCfhRpr+g54bPOlDpe4OoHA
	50g/S21GPdsZMoKbLkqvz0w9QsgGqLIYl3sGx3c8zIq6r7IdXedZqdMzw54dCvdi+JJEB8sIKse
	FUrZdiwLDqduxXLGs1ZRL8YFF23Og75xuNzZqgy1qqf5aip+hDPSPqWy+M4c3iAyU0sTS7euSNN
	1OTawVV/OHy0rwXL1bMpI2RVRo3qHcvVA+rz00m77MVgGp1x/cS/z2Hfa1/nHV+Mx3cU1NAT3DN
	Zz0g==
X-Google-Smtp-Source: AGHT+IHpC3hUpsdOxkGGFpIkmzHLX0S6dft1BqlO40RvYpRCqx2XF2vBhmmjwJtkDmwGJ1VvHKZ1bd6a30fm
X-Received: by 2002:a05:6e02:1fc8:b0:411:6759:bfad with SMTP id e9e14a558f8ab-428752ab8e0mr5070185ab.10.1758907427524;
        Fri, 26 Sep 2025 10:23:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42717780677sm2022745ab.32.2025.09.26.10.23.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 10:23:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso2183171b3a.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758907426; x=1759512226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0QolULlc3VuPbuO/n3TlX7LsO8RmJSjCATNiECqeYw=;
        b=KWOdcNWZ7tXcYHGllJXyDdwjHfFjFcCZ4paJsdVrLWKsIMaBosXbKPhSSQr5ElFggn
         TRPp1ULMQdpowq8IddENyamr748vN7WAID+XQx2tstplYm5hAokbPJUV4P3T+lGg6ozd
         GzC2HKpfHtUrHUJzRY2oP5YWkUpqPA4dINcZo=
X-Forwarded-Encrypted: i=1; AJvYcCXfpcNwA4Y4Ccr/M+WPxx1vfkvV6cfCSpSVoSCkap2t07YQEZzY9tj9fl/SfatMbry/FeMUgWw=@vger.kernel.org
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr7319115b3a.10.1758907425519;
        Fri, 26 Sep 2025 10:23:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id
 d2e1a72fcca58-78100fcf632mr7319067b3a.10.1758907425113; Fri, 26 Sep 2025
 10:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
 <20250926085911.354947-5-pavan.chebbi@broadcom.com> <5f581053-b231-4f37-91dc-4f2fd8c571a4@intel.com>
 <CALs4sv3P_W=ipS5MWKQrThDkPXmdFnfxRroDiZXbdrQXXqetsQ@mail.gmail.com>
In-Reply-To: <CALs4sv3P_W=ipS5MWKQrThDkPXmdFnfxRroDiZXbdrQXXqetsQ@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 26 Sep 2025 22:53:34 +0530
X-Gm-Features: AS18NWC-_wsPKwOZ6MZpkpwf_QPbGLRjrS73S_yqJcp282b8Mdrs7IupfK7YGCM
Message-ID: <CALs4sv2Eqx7On04w15WnFw9pDkeeF1DRAoVD5aFjTyHpbzD1GA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] bnxt_fwctl: Add bnxt fwctl device
To: Dave Jiang <dave.jiang@intel.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com, 
	Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net, 
	edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000052bfb9063fb78c18"

--00000000000052bfb9063fb78c18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:41=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadco=
m.com> wrote:
>
> On Fri, Sep 26, 2025 at 9:31=E2=80=AFPM Dave Jiang <dave.jiang@intel.com>=
 wrote:
> >
> >
> >
>
> > > +     if (msg->num_dma) {
> > > +             if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
> > > +                     dev_err(dev, "DMA buffers exceed the number sup=
ported\n");
> > > +                     err =3D -EINVAL;
> > > +                     goto free_msg_out;
> >
> > Shouldn't rpc_in.resp get freed with an error returned? It's leaking rp=
c_in.resp on all the error paths from this point onward.
> >
> > DJ
>
> Isn't the caller taking care of it? The fw_rpc is called as:
> void *outbuf __free(kvfree) =3D fwctl->ops->fw_rpc()
> I was expecting that outbuf will be freed once it goes out of scope,
> regardless of success or error?

Oh, the buffer is not returned when there is an error :( I should have
seen that.

--00000000000052bfb9063fb78c18
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDxwDim
o55L4J7jBPC9y+ao73xoMqYPPKlGctN5Z5b1kTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTA5MjYxNzIzNDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCAcSc2hH3+mUWDeBvZnfgWm48zYEFQR6o0JcmCkhms
Pv/hlM8vwGwitK6+soagE4qYQkzq2gEVHI7K/U7LyRnXNedGDxh7AdvmAUxX5xej/e+GAcPnEi+5
cjnvxo7TbZXAsJ0JrHJjRjxi2p/f5CFVhSoUDJ0NccremumgjZPrWgOsjENyykaxC2chsu1sdByt
AbxYYCqD+ipsOsovL/1NrG8zIsRoHNCd42GTFbOzcJYXxaEnPEHiJw0CST4Pnum7h5uWoa5U6asQ
Tb+j3E2KrQpOhgnIQjfplomHFHM0JM1wjt4cX+Z1X3x/cOwo5ylkU9+subQEJBYdc++uZmo2
--00000000000052bfb9063fb78c18--

