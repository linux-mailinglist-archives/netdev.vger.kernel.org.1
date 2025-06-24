Return-Path: <netdev+bounces-200576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EE9AE6253
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853D418983A6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5A286D53;
	Tue, 24 Jun 2025 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O2vtCA8G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB2284684
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760600; cv=none; b=AYeduFK8t0Bo5W/r5ODCWg+xM8/wFmrD+EMm+1YFrI/4EVnus8H5qSEtESBJzVXEpNdtA24cDMLCUGPGjt36Aod/9HIZmaXMXJ/F20LWchAJ2kdZWb/09sFzdqSjhgk95OvSkNR/KfMy0QmlaNuk0GAc+0RKEdRCMisOTMK4KAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760600; c=relaxed/simple;
	bh=rTd0T330C57QymGgrHb+7a6+4v5AlDLS1XI7V4lUVIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIaywKTCCxCIRPx9mBCiIJ8txf6+6iO+3qqunWyKcfSZhVe42ULgwYZnLhW8TDLXvdDrzysgNCZEdzkI5lcN6zyPbkepdAms8IOXmyRmXES8yGmjIKkvMgtkxjb3YejLokb8eyNamQQUIHVTIVzDmzCUSFKnS7104u1pqpBagus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O2vtCA8G; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e7fb730078so1379213137.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750760597; x=1751365397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/tBIYRg9aEVJ5Tza86yJNEh9Ayz2w4bl2o+Ycpw2f0=;
        b=O2vtCA8Ge6YHYoSkCtp6pLqC4c2gNUIwee3EBmH9/0PAe4T8SoPEN0ClAdLqkhsN/P
         9mv/kIpEUDipwbhR/6QrjTau2UEJxWg2Zx0znDEVlIZDCEjtIxicLcVyqUJ11EZkAifZ
         wWOLPCFd3PDpWeMD4HOp5tfr/GKF4tRKmSots=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760597; x=1751365397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/tBIYRg9aEVJ5Tza86yJNEh9Ayz2w4bl2o+Ycpw2f0=;
        b=q9YnOQhz1VeX+ZiyUfABpYrXNMUA+4Zr+W7tW9PRkcYuIn3XX94FtMXp+gB8cjgqCN
         2YwEH/e+hSdKE7qJTnRCBI38lA7rNomFnXR/qDxUco5Ly11OKYrXy5g7aLzKgmGDwjOx
         rIxKnUsGsf1O9nnzgxAGjvTjdwaygszhbDLu9KsNS4CFxR9hqQ7S0Bebj6sLDbQqqNNL
         HnDRHlN/DT/2EQdbu2GWlJefojVK2tGXPhfps/2Tw1M4ghoMpZ+rwKHZItjoo6mL2mo9
         y05APC9YHc9MMhtYMFa5TqASkh4V2R7tVoeR8Oz7Hj+G3A0GAIMVS5oUf3JD07P9nZkZ
         00Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXP4zFyitpcCsoGa7oPP5x5IJYNZi67zoThgYakg8KgYO4xapDYOMlsFPQwHsYN/9aPBLg2nf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWexZiRCgqBUXAH0RvPmS/atwMSxDgQispRgh/k6T4LFIouiy6
	3SDEZkNFefUGUujaQIPw7h0xcPaAGZIab3YZpV2Vp5l1vgLLV/aNP38s5ssErLavjMgAfTiOWkI
	45uBuj4Cb9K9o9N0yPlpL7LJ4qlfNmUbDjDA/JWpo
X-Gm-Gg: ASbGnctBBv+8PhtZgRawgqpImNGYz0HupRvAlzDel1+nHIwHKqpVkn+KI4AU6bi9DUB
	Yol0FoYpTuolfbiOliQLlPotvYlcV+lZnyONWW+t35SKzeQA4gop+zE1a9Wsiith95zm2+5Psv+
	/F/mNQ580JtGCP2ZTixN3YWhFynRLGeS/fEDtIYUf2sccufiBacJOpnAc=
X-Google-Smtp-Source: AGHT+IGQjJUnY5pJR6vGSEOmmfYy67KMpBLeG5BlMER0Plzvw9oOo1iL9KhjzVtGWoGOUJJQnxCdWW62T3nwRGushSo=
X-Received: by 2002:a05:6102:2c1c:b0:4e6:245b:cf5e with SMTP id
 ada2fe7eead31-4e9c2ef8dcemr10144286137.17.1750760596821; Tue, 24 Jun 2025
 03:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-4-vikas.gupta@broadcom.com> <6735a940-bce8-43f5-a6d7-7a48ace197c8@linux.dev>
In-Reply-To: <6735a940-bce8-43f5-a6d7-7a48ace197c8@linux.dev>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 24 Jun 2025 15:53:03 +0530
X-Gm-Features: Ac12FXwQRAZjBl6RMQvRAgw8AETgP4X5dpsrcMKyU8huvsK-wTo0scY1dMN_oSU
Message-ID: <CAHLZf_uQyVUA2BrRNMRx99zOWqsFZppNKi7_h_JvKezEqFwOHQ@mail.gmail.com>
Subject: Re: [net-next, 03/10] bng_en: Add firmware communication mechanism
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, 
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007a6ce606384eb76f"

--0000000000007a6ce606384eb76f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vadim,

On Thu, Jun 19, 2025 at 6:13=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/06/2025 15:47, Vikas Gupta wrote:
> > Add support to communicate with the firmware.
> > Future patches will use these functions to send the
> > messages to the firmware.
> > Functions support allocating request/response buffers
> > to send a particular command. Each command has certain
> > timeout value to which the driver waits for response from
> > the firmware. In error case, commands may be either timed
> > out waiting on response from the firmware or may return
> > a specific error code.
> >
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
> >   drivers/net/ethernet/broadcom/bnge/bnge.h     |  13 +
> >   .../net/ethernet/broadcom/bnge/bnge_hwrm.c    | 503 +++++++++++++++++=
+
> >   .../net/ethernet/broadcom/bnge/bnge_hwrm.h    | 107 ++++
> >   4 files changed, 625 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
> >   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/=
ethernet/broadcom/bnge/Makefile
> > index e021a14d2fa0..b296d7de56ce 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/Makefile
> > +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> > @@ -3,4 +3,5 @@
> >   obj-$(CONFIG_BNGE) +=3D bng_en.o
> >
> >   bng_en-y :=3D bnge_core.o \
> > -         bnge_devlink.o
> > +         bnge_devlink.o \
> > +         bnge_hwrm.o
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/et=
hernet/broadcom/bnge/bnge.h
> > index 19d85aabab4e..8f2a562d9ae2 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> > @@ -13,6 +13,8 @@ enum board_idx {
> >       BCM57708,
> >   };
> >
> > +#define INVALID_HW_RING_ID      ((u16)-1)
> > +
> >   struct bnge_dev {
> >       struct device   *dev;
> >       struct pci_dev  *pdev;
> > @@ -22,6 +24,17 @@ struct bnge_dev {
> >       char            board_serialno[BNGE_VPD_FLD_LEN];
> >
> >       void __iomem    *bar0;
> > +
> > +     /* HWRM members */
> > +     u16                     hwrm_cmd_seq;
> > +     u16                     hwrm_cmd_kong_seq;
> > +     struct dma_pool         *hwrm_dma_pool;
> > +     struct hlist_head       hwrm_pending_list;
> > +     u16                     hwrm_max_req_len;
> > +     u16                     hwrm_max_ext_req_len;
> > +     unsigned int            hwrm_cmd_timeout;
> > +     unsigned int            hwrm_cmd_max_timeout;
> > +     struct mutex            hwrm_cmd_lock;  /* serialize hwrm message=
s */
> >   };
>
> It's all looks pretty similar to what is used in bnxt driver. Why do you
> duplicate the code rather then reusing (and improving) the existing one?
>
> I didn't look carefully, but in case it's impossible to merge hwrm code
> from bnxt, you have to make function names prepended with bnge prefix...

 Both the bnxt and bnge drivers follow the same protocol to send the
requests with the firmware,
so the HWRM mechanism is similar. I'll consider renaming the function
names in v2.

>
>
>

--0000000000007a6ce606384eb76f
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
YIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINrLTssR41d/T1+P03CYZJ1nRt0YmodODXY0
RBxXTXtPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYyNDEw
MjMxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBABd0RrBp58gxnSpzY+1CRe0bv+/jDw8nFwXVlY0DkUXJLyu5e3k56ODKXHFM4sHyc4YFB+R1
Dw6bnPxqVALxaGY9lOn54mwmIk9Y+vV/f+KxBYu82AioSpIv8vonCoMKzWcGHsoR9bsBvQYBK4qv
KivO+S/cC0DnVrrcWgoM5zT2QV+oY2uCwZnJ6ni6vO0SanhZvDmjJM4d2SJjleZpaoG4Lei+LLCM
RoNZtUisj1uJCoryZ6MzsWWhwXxAU8PQGNgaaecBFZxxdc/tEprwz7Ah9AVZG2pEBzXmPm97YQaK
uW23tM5ZLKZIhzcEBrcjAHy/GCHkHneNk0A/kGjzVzM=
--0000000000007a6ce606384eb76f--

