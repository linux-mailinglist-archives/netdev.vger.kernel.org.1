Return-Path: <netdev+bounces-200580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A6AE6276
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510AE19249F0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB378286430;
	Tue, 24 Jun 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AklwMj+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43726B652
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761132; cv=none; b=DxlhLgnkTQQPTGoL/Fq+ageC+QJFHsrutmiq5Ab3jxC8JuHEVGwJJtSa1/pOVQNqZlsP39J64YctYBUzSWzb5kPntJ8403TVgMc4ARFhoiMAqEPi34d+qZqK2hQvHicUr0UG6vW/JNxgX20kVixWjo2l5Q1qTfIZUOcEJHgbSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761132; c=relaxed/simple;
	bh=dlKjZ4xqdyBk/1u2sxQLvuufR4kgguRA0OreL0ChRXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In/SGtqTSCR21dKZxcgHnSnbP2+vNLkb+gIcBctNTRkIDGC53/rNo/fBXT+0gqw4COXxBiIhpjiZ1EjqiuDFYbRP8VDPhtcGTKjfi07Ti7rhiO0c7cWhdef+vYnsUTOryQNAswl9qGoNewm9gq2O5szlvzPuYYPLnLybWM0EvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AklwMj+5; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-88150e9fba7so1443641241.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750761130; x=1751365930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oeyXjF5qV/wAy8FnIN/C/rT1kU5mDalYioZEl6hvezI=;
        b=AklwMj+5Zn4Ari8ShwQd3IWn6ovlhOdzPXaaCaC8VGmdHjkAScmphBNhbf7CoGr9WR
         2WjnY1lEvsfHe3ju/RlKbVT/WG1JSb8X5LYL1lDWctewOVs5d6emusFbxotH6QATRPg4
         1LvYON0JmwPR35/46zG7NHpKGM77HtAva4k/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761130; x=1751365930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeyXjF5qV/wAy8FnIN/C/rT1kU5mDalYioZEl6hvezI=;
        b=Q+PVDBUWtXvSuXIHYC2U4KeUYDrffeAYE833/cPYnjVRFZfqDuZejl2XfFYBfZm3so
         48TVRKau49uTF5YEp/wGSXdpYsGoCZAWet/4GDrKIzQewQBKcwLGOtveKBBolV9QIH/v
         gXnD/MJkNvNwVNe4uGSiPHP23NErZ+eGMN2YI2PDzD5uZh01OjUx0iC6HwGU9XLDyM+a
         CPlIN+3meUXm+XksMsePvoyn5Sak72LCg1P5+w91sHLgNeU87LQDzW/0eFfB0dDx75WJ
         v9/+yhSHYY1tOCgqyw6g+8a9hItMGaO9fqSHSvSU5nHMm9oYi98DfBk/ZOb+mzoiceQG
         CCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe627Bds0CX3xxItQrFbjClhSCPOdX67cASr47SsJY1qXo+9y+k6/hSnvq9efChivaUUGCeaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC33ZroNEzWR4xfUSZuYobKpOVMFeSRXD1yRbOlnb1Y4h9NTGI
	M2pT2AXQVcmlLeQEPFcCbKRECgmqK80MIFtwpQXLLCNpav96djWbDxddsoK4TO27pzLRG+3iOHa
	Ci+E4sadsZlIZnd4M3ThYOYiWsMnDvrgydgSTwXNr
X-Gm-Gg: ASbGncsPHrZPfZZi1+ZGDxQT+d6jV+9to6DqYyAm9Gu3791g7i1f57UtOteVyodP10y
	T5sZDlE71WpfkwLqcJ9M00W4qfr3hjdNG6pSyOWLRbiQNh3+kAJC2QutiVCP6Pnkqd29HGCXk5h
	64mVR/snn9sGIueWUqoctpS+OtxOj7H9bVHnSGI3SzMvUY
X-Google-Smtp-Source: AGHT+IECe4K84LEv35ZlZpP2NpE6ZlQB9rYJJnXbuS6npoHMi368g3O/TASHzvcKF9Id9r3BuGW7a0FaLWHVNSsc0jU=
X-Received: by 2002:a05:6102:b15:b0:4e4:5a1f:1414 with SMTP id
 ada2fe7eead31-4eb52bb4d83mr1458687137.12.1750761130123; Tue, 24 Jun 2025
 03:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-8-vikas.gupta@broadcom.com> <b1bc7c4e-0fe7-43ad-a061-d51964ddb668@linux.dev>
In-Reply-To: <b1bc7c4e-0fe7-43ad-a061-d51964ddb668@linux.dev>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 24 Jun 2025 16:01:57 +0530
X-Gm-Features: Ac12FXxVW4QOxWFtgZlhwpztVbAdXiz00aYvqwmI1Nb657jnRBfUxu8cg5WaDj0
Message-ID: <CAHLZf_s1gk_GOuVkp7T_s-iYn8t+g-a-9c=SQue+g+2vRhgHxw@mail.gmail.com>
Subject: Re: [net-next, 07/10] bng_en: Add resource management support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, 
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000044ba4c06384ed7c7"

--00000000000044ba4c06384ed7c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 7:09=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/06/2025 15:47, Vikas Gupta wrote:
> > Get the resources and capabilities from the firmware.
> > Add functions to manage the resources with the firmware.
> > These functions will help netdev reserve the resources
> > with the firmware before registering the device in future
> > patches. The resources and their information, such as
> > the maximum available and reserved, are part of the members
> > present in the bnge_hw_resc struct.
> > The bnge_reserve_rings() function also populates
> > the RSS table entries once the RX rings are reserved with
> > the firmware.
> >
>
> [...]
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_hwrm.h
> > index c14f03daab4b..9dd13c5219a5 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> > @@ -104,4 +104,14 @@ void hwrm_req_alloc_flags(struct bnge_dev *bd, voi=
d *req, gfp_t flags);
> >   void *hwrm_req_dma_slice(struct bnge_dev *bd, void *req, u32 size,
> >                        dma_addr_t *dma);
> >
> > +static inline int
> > +bnge_hwrm_func_cfg_short_req_init(struct bnge_dev *bdev,
> > +                               struct hwrm_func_cfg_input **req)
> > +{
> > +     u32 req_len;
> > +
> > +     req_len =3D min_t(u32, sizeof(**req), bdev->hwrm_max_ext_req_len)=
;
> > +     return __hwrm_req_init(bdev, (void **)req, HWRM_FUNC_CFG, req_len=
);
> > +}
> > +
>
> Could you please explain how does this suppose to work? If the size of
> request will be bigger than the max request length, the HWRM request
> will be prepared with smaller size and then partially transferred to FW?

Thanks for pointing that out. After checking the firmware code, I
understand that
 bnge_hwrm_func_cfg_short_req_init() is not required. I=E2=80=99ll consider
removing this function in v2.
However, to explain your comment, this was aligned with the firmware's
behaviour.
if hwrm_max_ext_req_len is less than the command length, then only a few me=
mbers
 are accessed by the firmware.


Thanks,
Vikas

>
> [...]

--00000000000044ba4c06384ed7c7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
1Z53HzleM75CAMHDl8NYGve9BgWmJRrMksHjn8TcXwOoXQ4QkkBXnMc3Gl+XSbAXXNw1oU96EW5r
k0vJWVnbznBdI0eiFVP+mokagWcF65WhrJr1gzlBAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGHZpa2FzLmd1cHRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUQUO4R8Bg/yLjD8B1Jr9JLitNMlIw
DQYJKoZIhvcNAQELBQADggEBACj8NkM/SQOdFy4b+Kn9Q/IE8KHCkf/qubyurG45FhIIv8eUflaW
ZkYiC3z+qo7iXxFvNJ4irfvMtG+idVVrOEFa56FKvixdXk2mlzsojV7lNPlVtn8X2mry47rVMq0G
AQPU6HuihzH/SrKdypyxv+4QqSGpLs587FN3ydGrrw8J96rBt0qqzFMt65etOx73KyU/LylBqQ+6
oCSF3t69LpmLmIwRkXxtqIrB7m9OjROeMnXWS9+b5krW8rnUbgqiJVvWldgtno3kiKdEwnOwVjY+
gZdPq7+WE2Otw7O0i1ReJKwnmWksFwr/sT4LYfFlJwA0LlYRHmhR+lhz9jj0iXkxggJgMIICXAIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMFhgQqM5emFpsS5wwDQYJ
YIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEII1ou/c8vWMGjhq/3nN70t61FlZImSULTQ9I
GnWSgTLIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYyNDEw
MzIxMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBALA0DcrqcjuhY8XxmdX6Wkhhg4zwnICPSP87XKtm2TwhqpQI88I8VldkDJswcWB2/QXv8Pd0
aR7tniUVdxDJoPlpUB4FP1Zhtf74wrzOvuLXDAVhjBjVdNGVSVTzI4oeH2z/zOBKahaOUdhX2Fhm
igDDxgtFDpWrHkfNRjbJpyQ8xps1ZxiUz727Y3jLIdHxN7/do7FyMgm0CoGmhTWlwofL2JhHCREp
1sBuFSFZsH2nE2Xb2ZVuob+U/pyNGzMV+CxevG2x/fdr6dci7Uv44yLDBA8VMlZk9Q8psOHk4pTM
G4eUeTNO3aSAbNKoh+C60gvUtmZaEBX+9oxuHiksLxU=
--00000000000044ba4c06384ed7c7--

