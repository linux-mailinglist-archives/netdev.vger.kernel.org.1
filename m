Return-Path: <netdev+bounces-226755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777CBA4BE5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 19:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC21BC7716
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648B301026;
	Fri, 26 Sep 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B3icIpfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8B15B0FE
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906698; cv=none; b=UXNWRWtA+nK6exkhEjBzwhGnXmgBS0zepnS6JsofedOBPo3FOyDbISCNNc5CCZEVo/IfPQnk24MS4ED8WDz3Rh7eKffy/g/W3gGUnn3vfntEfNvNB2pLXqnnjy/mdINZuj94+hTH0Cm/v/eJxKb99OanECqyYf9IgmxMr8MyOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906698; c=relaxed/simple;
	bh=sQmZfbtulkySjSeVegznf2FDXPfAPv76mxj+IloQK8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYr2rGTeADAPxEFfnvIVdiOstEgZ5jZuInVYVXriQeZxrBz0CHlesgrjM388S1AjEEJAbX7+L0MK5QS7HAqEc4CecwdjJ0Se2shGd4SeGLLWLxaXdX6v4RYgE6Fdfz7SmZMpXuF+aOfU9rVKubCjfl1fMv6taGPqwEt35WbAdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B3icIpfe; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-71d60528734so25108727b3.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758906696; x=1759511496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+dZBJhlgPbdr4blYJgZXcVBNkB4L88ISsyPq3YMh+4=;
        b=DQZ/yvKE/hd/vb1e7BryJrMclIe+lDNpZfwc897Tu2Zr1IjY8XE6R2cL1WoABZHNcR
         dq2Lio/L9DIYEmQcbjMm0ULpnYAfb4e8HK0ppMpu6ZDhVH8MBOG5W7q5TcFJtK2tE+Wo
         Y4Ug8ryGJ6oiplsuEiq5SpQImpOR489vPWYZlO456wFak15C1GBdiQn/xfU/21K4Q1sv
         LWeZidwkkBQEM+sW59TxDhbzUvHAARJX/5l9obmR4234j3i11UxK92865wqK04oRAFGD
         PzOaAnzjAzwJPgqbLvv276M9iEGxzQfp73fqTxQDxI/8sWC6UdzT/8OCW7QPEg7BcNxu
         EXAg==
X-Forwarded-Encrypted: i=1; AJvYcCXirOZ3MCwX+KgTZ9vjKmCmTSX4dHbR3BpctgIbzce/NUuJfWpCy5z8atwR6HmnYq4Qlf8h2ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOca8aQaEaXNbCs+98S5GQKmahJsLICpiCEIy4CREkgXYjXL+6
	MC2gBfj9Xa0dDkXFuG8/mslo2xRF1E4HD8ttNNKvZtWfifuwGD3JtL9gTzM+fFoOLpl6w1vI29f
	2mm7u142n00GNP3VZwThg9y10SX0G5p0djab3RdVz/2Z1ZJmQK1kUhqHhRLQJOhsMYQkLMeauSC
	tETfdDYjDD0DdqfZDvOo4n3yRbBnRvuR+C6Oz9G+GDJTxJEtXdn2HlmZLeJ0lxyK7ONHA839tHO
	k8y8U8rcfFw4g==
X-Gm-Gg: ASbGncu2E9PyTkg5rd19NjZR7jKxErx4bwFsVaESbGRqNBzwd9lple7FqwE0UnB1bYG
	lvT8+YkxqnIL8hwmoNA/WOAXH7kBnB08MINKfyFj7zp9wRizbpzhKwGNfPfsIT9fySuL9ePsuRV
	+iTZMXx3lE39BM7IV1Rb7LmAepy0BntqVMPL4SqRyb0+qCyfgbJmzMYFLvGW2PoaFJ6DmYL6ZqJ
	FWi0w+kFV+TYS6xm1IU6L9azS33kyLc9BiLmXdbHmHRYiXWMaMXg0/8+5D1UXeEz6cwlTmAOech
	cVkRHurWCzqZ8FP5FFcFxh+iUCVQ39TiVEb19kLeMlJ5uNLhfT5S+GRkGuTvJHeV0mLo9U61jKK
	nZFwtcqaVOs6AVeoL237cbmwct4GwXEoPEfnlIP9QiMQa2yIAzkAHdgu7N2aZwdrCtcrpmklC2Z
	Ig3w==
X-Google-Smtp-Source: AGHT+IEQ4O2l0eLpWWIPmAcZ4vhin5bo69vdn/lQ5f79xUFS570WXXCamMIxkv2FiPeG7OXchX+0LrAZzy64
X-Received: by 2002:a05:690c:6087:b0:739:634e:b430 with SMTP id 00721157ae682-763f87770b3mr73629377b3.7.1758906695438;
        Fri, 26 Sep 2025 10:11:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6361e9416d5sm234034d50.14.2025.09.26.10.11.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 10:11:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55153c5ef2so1729147a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758906694; x=1759511494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+dZBJhlgPbdr4blYJgZXcVBNkB4L88ISsyPq3YMh+4=;
        b=B3icIpfevkYBQr3E6xmrgZypXfzHMlO09H53+nBZMY/TLUJ9ArIE6dv1/Dh1hXM9p/
         HcWw+E7UXvoTCboBjGN3pM/ovawSTitD05SYxLjzRzrH3kcNPgeWwp04Qr/mazS8nCGO
         SCjKUqrUOlHTOfxVa2CxDqH7LqdXhpLXCbtcg=
X-Forwarded-Encrypted: i=1; AJvYcCXt6vQqp271ZnF+wuvrefeN4tp2LnhjXiWGlN8FqW2WNstZiZTSBiIC0iSLoLotET30VEqs9F4=@vger.kernel.org
X-Received: by 2002:a17:90b:1a8b:b0:32e:59ef:f403 with SMTP id 98e67ed59e1d1-3342a299099mr9208989a91.17.1758906693944;
        Fri, 26 Sep 2025 10:11:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8b:b0:32e:59ef:f403 with SMTP id
 98e67ed59e1d1-3342a299099mr9208960a91.17.1758906693534; Fri, 26 Sep 2025
 10:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
 <20250926085911.354947-5-pavan.chebbi@broadcom.com> <5f581053-b231-4f37-91dc-4f2fd8c571a4@intel.com>
In-Reply-To: <5f581053-b231-4f37-91dc-4f2fd8c571a4@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 26 Sep 2025 22:41:22 +0530
X-Gm-Features: AS18NWBCxZkGewpzCNyKF6JbZlR59xuNZzNvmuf4NnxK91jSZZtNqchqW8SYO4o
Message-ID: <CALs4sv3P_W=ipS5MWKQrThDkPXmdFnfxRroDiZXbdrQXXqetsQ@mail.gmail.com>
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
	boundary="000000000000b45d39063fb760ed"

--000000000000b45d39063fb760ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:31=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>

> > +     if (msg->num_dma) {
> > +             if (msg->num_dma > MAX_NUM_DMA_INDICATIONS) {
> > +                     dev_err(dev, "DMA buffers exceed the number suppo=
rted\n");
> > +                     err =3D -EINVAL;
> > +                     goto free_msg_out;
>
> Shouldn't rpc_in.resp get freed with an error returned? It's leaking rpc_=
in.resp on all the error paths from this point onward.
>
> DJ

Isn't the caller taking care of it? The fw_rpc is called as:
void *outbuf __free(kvfree) =3D fwctl->ops->fw_rpc()
I was expecting that outbuf will be freed once it goes out of scope,
regardless of success or error?

--000000000000b45d39063fb760ed
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBXO3kA
0bhdeOIePSeKLHcIMh24CJfMpCFHhy5lRaPV0TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTA5MjYxNzExMzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCLlVTjx19hxHsee47EZON49nt5vYmOOnmZy75+4zvk
zlar3RhIj3mRzsc9B0IJVWgm4Vi5IixNgdGpYLlANN7r47jhvJM5wevt7ThxhzPt1xlUIoX8Tg33
qMz4RDxqCkb5cU5fEK+2g2H0f7WzMfW5iOmwf+pKk221MpcQR4TajfJ+IkawKkESJBOMAYtADulx
vmwE3dz6doFzMZ8pFj2m2Of5P9dxA95ze8LgLjaXIQGjuxCCu4CuqDe1bXENc21HVsNszdxognNU
pV6x1kHrIAtY2n7NXKZGgIUUv1fARHjUjoJpxLJ9/qPIGdoY4fT24VU6Ebg15v8lNsv6ukHR
--000000000000b45d39063fb760ed--

