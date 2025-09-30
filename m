Return-Path: <netdev+bounces-227236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AADBAAC96
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F0E189F979
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B38140E34;
	Tue, 30 Sep 2025 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c2rNMhLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A98C133
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191954; cv=none; b=BWKf77xggn1NVPCu72C4PQHVGCYBTx0qL2+eFU8JEXRvzCpLwvbwptJvB5RWlqQ8fObQN9GIqmBCjOd8Z2ncj+e+5nLHOg3jJzrcPjNaSP9fACsK49KuAdcA5rd1ifqmeMEyB13vtRnMTPffhWB+e5aAbMvgGnnI++G1XuI0ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191954; c=relaxed/simple;
	bh=WZmS2QUgEaVefehY35lS//7dflJCPJHf11vEyCO6FEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JioEvYgtgsI78RkTZn0pHMTnoDuYneBeuBWOimxjBIuwiZrag02+xr7lvcWD9mB2gzoqdWWNru+GR/mk9f3tbQdgASLwTERpodlGSa+8Bbsm2szPXV+00kq0jD6nOeURAGNXyM1M74AdMEW1OTHLxLG2VwIb4T7NSizQhWEihHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c2rNMhLK; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-781206cce18so3510803b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 17:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191952; x=1759796752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZmS2QUgEaVefehY35lS//7dflJCPJHf11vEyCO6FEA=;
        b=hvhq8l0N0a/JFBY+RywFyYU9xuQY03lWU3pNhps0VhVXHYZCc8gFtIJ+oT5ATTt+eD
         aTmQ+fpkT3yQbRyB9gjQ70c1hDrt2JSJuvl9olDf+aTx5TyXp00Dzvsb9VQGk0uUhSDb
         sJUWuaTvi1MQuQTMCEzsAtZ4CSGt+VgyXXmwmZ8EfMq2t2iLbjwMuqLMZKOJSzOxtWOT
         Bq4LGbuK/6lWlWR7vP1criwPxDVtdtM+4KSfk0o0gRbYNEwrs3kgTxrDh1J1WMHJTb0a
         DlnXp9o/wUEVN+QRZFOL5EdLVbkr6QKg01SxdJL9lPou1uWUnoWvCfW1BiHn8N+s/UED
         NXPw==
X-Forwarded-Encrypted: i=1; AJvYcCW9PIBdGkI6aZMVpAboNiBh15H++O4yQDF3EKz+7JKXtyFDtayMDsG6mg9+MHtG3Zhxj1Y2PW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XdlzPc34YVIRef327Nv0ffbsjCoc+SqHiCi4FJ/h7bX3weNx
	mLkDn8zj6uqFFFeAo6as1BFB4d5m0r7ZhCKHw0CoeInMGE/Gf8Fn3cf5KC+MHpuCfmbzZLSi5zC
	D3Vq1/MimeDufGovpXGzmtHPkdRR+97xAj/NvNx7Bl7BI5fciBbIeAl3XgCND0kSIUPcE2/tzCx
	SMkUaJ2gI7RC/qdetBfqllM4Uqtpy4a2muEFtc0GGF1da5MTRMakB5KAR2Bh1KT1DyEQ1nyhTYM
	IE1FoKLx4E=
X-Gm-Gg: ASbGncssRo/MBHzhh6JhdcTnva38ggTsOUk8daN0dIEi6qzlu1Nz6FbFr3VMDoKo/lu
	S0s5FnB+GSZiBrehRTuc8Xguz3eQ3PxtOlRHOz+XrxSp7iCFaFIX4Om7gyi26+6neJqPowQaaJU
	1+pZCuw0M+q2wOQv6P5rRfZjO5/jmlg22liCaruR3GxK+OvRnWwynXSkUkhm8kO/BYaAXOHZfRo
	RavY6NFR7oEw6vRVM/K3B5QOMOuKzBQOXcIlhSFxNzroOeaYlDW/HWw6k9nute/Ue8usnlPQX/e
	sfHsVv6S9Fqv2BS4iyvRLLI+Z67uemsxaOgYVUza4Sofit8GSiWU35GIPYnZuXm+/uaa/gp7dGU
	p8ufaka+0EJT0hJ6ZWrlBc/++2rrMLYl5h40d9P7aGyonwMJ67AwOarj5FTbHLafex/SOSLCzZ+
	0qbDoAC0A=
X-Google-Smtp-Source: AGHT+IGUkqAXqROkS7XmrhPWFVM4hrKWN6yEy2Lo9ilzosO3EguL7vHEQWVRDZSHqJC4QAzqEiOOMgkFA542
X-Received: by 2002:a05:6a00:cc8:b0:77f:1016:d47f with SMTP id d2e1a72fcca58-787c80a7a2bmr2385497b3a.8.1759191951676;
        Mon, 29 Sep 2025 17:25:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-78102aee0e5sm711696b3a.10.2025.09.29.17.25.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 17:25:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so4408919a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759191950; x=1759796750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZmS2QUgEaVefehY35lS//7dflJCPJHf11vEyCO6FEA=;
        b=c2rNMhLKmSyR0++zsg5/bS8JPkRbDrtgBo09F1JJMqJUK2/4V4JxE/4vqbJ7qeY2aU
         y8bqZ7lsL8zP/dWrGmzRoBcW42y8q3dSvHmeL4Rv0LbFmfTZdnVXmR5GanMw8z3w/JMJ
         rnmX2jZBOW7lM9ZQQkepAYHKLJ2tfoOTXeQjY=
X-Forwarded-Encrypted: i=1; AJvYcCVvyo21iVMllqrC6er+3+UzRgx9ALZTbHsJIa7q1bkERNB/s47WyxHlCN6jTcMdiv9MJ+kJW5s=@vger.kernel.org
X-Received: by 2002:a17:90b:528a:b0:32e:11cc:d17a with SMTP id 98e67ed59e1d1-3383ab456d6mr3023528a91.4.1759191949872;
        Mon, 29 Sep 2025 17:25:49 -0700 (PDT)
X-Received: by 2002:a17:90b:528a:b0:32e:11cc:d17a with SMTP id
 98e67ed59e1d1-3383ab456d6mr3023503a91.4.1759191949478; Mon, 29 Sep 2025
 17:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com> <20250929114611.4dc6f2c2@kernel.org>
In-Reply-To: <20250929114611.4dc6f2c2@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 30 Sep 2025 05:55:38 +0530
X-Gm-Features: AS18NWCLPh2QeJdN4MqIX-OwB6Gbqn00nwwJYjKRuyKWQOkUqmkM7kj9_4zhAxw
Message-ID: <CALs4sv2tRYnDV5vOWum9+JQSr61i-ng1Gaok17bi+JSP-uLSNg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
To: Jakub Kicinski <kuba@kernel.org>
Cc: jgg@ziepe.ca, Michael Chan <michael.chan@broadcom.com>, 
	Dave Jiang <dave.jiang@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, "David S . Miller" <davem@davemloft.net>, 
	Jonathan Corbet <corbet@lwn.net>, Eric Dumazet <edumazet@google.com>, 
	Andrew Gospodarek <gospo@broadcom.com>, Linux Netdev List <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004925fa063ff9cb4e"

--0000000000004925fa063ff9cb4e
Content-Type: multipart/alternative; boundary="0000000000003db155063ff9cb45"

--0000000000003db155063ff9cb45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sept, 2025, 12:16=E2=80=AFam Jakub Kicinski, <kuba@kernel.org> w=
rote:

> On Sun, 28 Sep 2025 12:05:36 +0530 Pavan Chebbi wrote:
> > Dear maintainers, my not-yet-reviewed v4 series is moved to 'Changes
> Requested'.
> > I am not sure if I missed anything. Can you pls help me know!
>
> There is
>
> drivers/fwctl/bnxt/main.c:303:14-21: WARNING opportunity for memdup_user
>

Shouldn't it be treated more as a suggestion than a real warning? Are you
insisting that I should change to use it?


> somewhere in the series.
>
> Please note that net-next is closed.
>

--0000000000003db155063ff9cb45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Sept, 2025, 12:16=E2=
=80=AFam Jakub Kicinski, &lt;<a href=3D"mailto:kuba@kernel.org">kuba@kernel=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, 28 Sep =
2025 12:05:36 +0530 Pavan Chebbi wrote:<br>
&gt; Dear maintainers, my not-yet-reviewed v4 series is moved to &#39;Chang=
es Requested&#39;.<br>
&gt; I am not sure if I missed anything. Can you pls help me know!<br>
<br>
There is <br>
<br>
drivers/fwctl/bnxt/main.c:303:14-21: WARNING opportunity for memdup_user<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sho=
uldn&#39;t it be treated more as a suggestion than a real warning? Are you =
insisting that I should change to use it?=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
somewhere in the series.<br>
<br>
Please note that net-next is closed.<br>
</blockquote></div></div></div>

--0000000000003db155063ff9cb45--

--0000000000004925fa063ff9cb4e
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCkWi2v
cmTaM300hGCwtP6q+ouA6Xne53kCvRpjmn6WLjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTA5MzAwMDI1NTBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAw60Gzg47JW0W+UQr8+EhH1Sr8cT1eEICg3XG2MgC2
peJE7qSwAa02ZMcIHXpIukmPjxwb/MUxE+8iR4kynmJM+2TIeQt1UuGyZusEukxgXyomlroTTjsu
R6MUsyT9xViXv3K8dykFiq+6XVRzpQagqr69XeI23haSpVIzxm+ClxVXTQqx/WyHf19JeauqR4Lj
N3XAXXo9Q8kx3I2mL+9IYa4tkm6mnzS1wJ2OTEkRt7/vl57kp2CquPj2RnNCbbQJP6J9L4Px59N8
1+ZH2pc1F6BxjEGXN2REM2ZPuQ/o8LrrIh0C5UuOdKwNh2Ob6dikZ4057muYcDQ0oCtyjHwK
--0000000000004925fa063ff9cb4e--

