Return-Path: <netdev+bounces-200579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776AAE6272
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E067016B547
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D172820A5;
	Tue, 24 Jun 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R/aFE5W9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69F26A1BE
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760985; cv=none; b=fzgfHsriUnqGqjY8Rv6K9wnldT9QgzjCPfctdojxUarfgqptGS2+0c6wOJ2CGtgDrI4kvpOedp//rRKy3CKnEaQXUnbnKFLrr0EhzbxQqVzwsoDuPdwDaUrRmSP/+OiwhosbCcCwtsTQsknczJ0qON9NT7jXQahQUFU07G0CxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760985; c=relaxed/simple;
	bh=HcrTKTPscukZBazgWou2j8uRbaDWtBOLxf2W//G2/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxdqKDf6Aepm9AAmOUC9K9yozOjvLvT222nM6Rw8BL4pJqD/QBvpKroAtzxuuxuycfdNe51FNqGj06C4u1toeAxmatGvxGw5F/L6TkmOmf8BDWhI0UJyiE3DXHrz0iMKWkIdTucU7L/Qj5npjNlGh+NHayHNtjfsKIJZY4TWRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R/aFE5W9; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso172527137.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750760983; x=1751365783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dF7gKxPuIPfrHQhMRnCpvQN5PxlSTdIpoRHcu2Z7huw=;
        b=R/aFE5W9U0i1jpQYSnda5OQ4RDKMI5tu40ZDUrT6OFibghzJcVj+xeJQoqveJFKX1Q
         EAOpUA8goF9mbQVH2Xh0SS53Npb9S//Eddo2TFuvusb309fWJ7svIrYpILv2pGfcLv2j
         YbbxdoOvwn8ermKCKeouyZbq3NMeDtFVvV/e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760983; x=1751365783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF7gKxPuIPfrHQhMRnCpvQN5PxlSTdIpoRHcu2Z7huw=;
        b=J+/lv7Pm+tJ3JP22WcU+YTcFF+Z3cIz/YcyVwsrMuUVt/A5Le/QKsI7FX+A4UaaP8H
         VXbbkfEY/iauBvsof7Rd9W/X1TuD9nXw1LDzaRCr9rlTgm+3yLSRpBDk1IgLrB3VCpaP
         7QZGA7lKakSARomol/iB3BS+ZREO1s+Hqvt7yvE7j4HX3clhg88kF+uT1he9yOznTBci
         pc/9KlVWloLvi3j9R4Odr/55c7qOPPSqWEmSLkJsWZL8gp61TkOP9VmBWFHeHTslfgu3
         RtNEbXtYRqCX7M00M2/3u9rxYs706OM1roOz2sUjIxHaz0r0q1l2IHLq0uidPvxnWVjD
         gVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP2oDTyX01BEv3JWamiVzIkYt2HLDS+3MsTbynDG96h15NncU9T7eJwKRt+nmqvAuU4L+xs28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINxryutrycGp/lkZR05pwruMO3nMHUVSR/1tRYWvq0gcC5aMF
	ReQMlB2c+yes+uFHtqusPyFbzuyKnUzQuKRW4sYYes3r9VUNCPTgPdC2yQq4ct8eVnmELQdpiOS
	c0jCkCQ1ZJ8IG3VMCCHJw/X1jC+xefSwrfEiyiyqq
X-Gm-Gg: ASbGncslKucms7tPTtQYUm2DPkIp1Bfri7eV2xBcsNeJXKq5dIABhHy6a3zeuSXQIXs
	J3+psYNh3aUAXz9A0SLuFz/r4E+CRsvbpN5OJfKPm7ev2DNMyPnKTqmWAtTpSSAR7ET+tJ59FAG
	wTPiuFo1EQl3MG0x9s57GV7mgt+6YcAKgC7/ZTjhOtLI9L
X-Google-Smtp-Source: AGHT+IEeuQOT/CJ48z1wuSddYCbOyVTBffaExKbjUB9yjE5Rm7BYMeqYh4K8FHOdev5+C90PP4BYoUUPQ8RzTliBfOk=
X-Received: by 2002:a05:6102:504d:b0:4db:e01:f2db with SMTP id
 ada2fe7eead31-4e9c297a3dcmr9303834137.0.1750760982937; Tue, 24 Jun 2025
 03:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-7-vikas.gupta@broadcom.com> <decb802a-7327-4a9a-8a4a-74970474f42c@linux.dev>
In-Reply-To: <decb802a-7327-4a9a-8a4a-74970474f42c@linux.dev>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 24 Jun 2025 15:59:30 +0530
X-Gm-Features: Ac12FXx6GzNVXk4G2spjUx_60lXYg14psaYs-oH__12CWsnqfQbniYgRaCI2Wgc
Message-ID: <CAHLZf_uByWcXJmdo++fPM=o1GyZZ9pEZmSx8bSy4wbSiGcLDnA@mail.gmail.com>
Subject: Re: [net-next, 06/10] bng_en: Add backing store support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, 
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007ee1e206384ece91"

--0000000000007ee1e206384ece91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:32=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/06/2025 15:47, Vikas Gupta wrote:
> > Backing store or context memory on the host helps the
> > device to manage rings, stats and other resources.
> > Context memory is allocated with the help of ring
> > alloc/free functions.
> >
> > Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnge/bnge.h     |  18 +
> >   .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 168 +++++++++
> >   .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   4 +
> >   .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 337 +++++++++++++++++=
+
> >   .../net/ethernet/broadcom/bnge/bnge_rmem.h    | 153 ++++++++
> >   5 files changed, 680 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/et=
hernet/broadcom/bnge/bnge.h
> > index 60af0517c45e..01f64a10729c 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> > @@ -9,6 +9,7 @@
> >
> >   #include <linux/etherdevice.h>
> >   #include "../bnxt/bnxt_hsi.h"
> > +#include "bnge_rmem.h"
> >
> >   #define DRV_VER_MAJ 1
> >   #define DRV_VER_MIN 15
> > @@ -52,6 +53,13 @@ enum {
> >       BNGE_FW_CAP_VNIC_RE_FLUSH                       =3D BIT_ULL(26),
> >   };
> >
> > +enum {
> > +     BNGE_EN_ROCE_V1                                 =3D BIT_ULL(0),
> > +     BNGE_EN_ROCE_V2                                 =3D BIT_ULL(1),
> > +};
> > +
> > +#define BNGE_EN_ROCE         (BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
> > +
> >   struct bnge_dev {
> >       struct device   *dev;
> >       struct pci_dev  *pdev;
> > @@ -89,6 +97,16 @@ struct bnge_dev {
> >   #define BNGE_STATE_DRV_REGISTERED      0
> >
> >       u64                     fw_cap;
> > +
> > +     /* Backing stores */
> > +     struct bnge_ctx_mem_info        *ctx;
> > +
> > +     u64                     flags;
> >   };
> >
> > +static inline bool bnge_is_roce_en(struct bnge_dev *bd)
> > +{
> > +     return bd->flags & BNGE_EN_ROCE;
> > +}
> > +
> >   #endif /* _BNGE_H_ */
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drive=
rs/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > index 567376a407df..e5f32ac8a69f 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> > @@ -10,6 +10,7 @@
> >   #include "../bnxt/bnxt_hsi.h"
> >   #include "bnge_hwrm.h"
> >   #include "bnge_hwrm_lib.h"
> > +#include "bnge_rmem.h"
> >
> >   int bnge_hwrm_ver_get(struct bnge_dev *bd)
> >   {
> > @@ -211,3 +212,170 @@ int bnge_hwrm_func_drv_unrgtr(struct bnge_dev *bd=
)
> >               return rc;
> >       return hwrm_req_send(bd, req);
> >   }
> > +
> > +static void bnge_init_ctx_initializer(struct bnge_ctx_mem_type *ctxm,
> > +                                   u8 init_val, u8 init_offset,
> > +                                   bool init_mask_set)
> > +{
> > +     ctxm->init_value =3D init_val;
> > +     ctxm->init_offset =3D BNGE_CTX_INIT_INVALID_OFFSET;
> > +     if (init_mask_set)
> > +             ctxm->init_offset =3D init_offset * 4;
> > +     else
> > +             ctxm->init_value =3D 0;
> > +}
> > +
> > +static int bnge_alloc_all_ctx_pg_info(struct bnge_dev *bd, int ctx_max=
)
> > +{
> > +     struct bnge_ctx_mem_info *ctx =3D bd->ctx;
> > +     u16 type;
> > +
> > +     for (type =3D 0; type < ctx_max; type++) {
> > +             struct bnge_ctx_mem_type *ctxm =3D &ctx->ctx_arr[type];
> > +             int n =3D 1;
> > +
> > +             if (!ctxm->max_entries)
> > +                     continue;
> > +
> > +             if (ctxm->instance_bmap)
> > +                     n =3D hweight32(ctxm->instance_bmap);
> > +             ctxm->pg_info =3D kcalloc(n, sizeof(*ctxm->pg_info), GFP_=
KERNEL);
> > +             if (!ctxm->pg_info)
> > +                     return -ENOMEM;
>
> It's a bit hard to be absolutely sure without full chain of calls, but
> it looks like some of the memory can be leaked in case of allocation
> fail. Direct callers do not clear allocated contextes in the error path.

After the allocation of context memory, it could be in use by the
hardware, so it is always safer
to clean it up when we finally deregister from the firmware. The
bnge_fw_unregister_dev() function
handles memory freeing via bnge_free_ctx_mem(), instead of freeing up by ca=
ller.
I hope this clarifies your concern.

>
> > +     }
> > +
> > +     return 0;
> > +}
> > +

--0000000000007ee1e206384ece91
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
YIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJJYzq59UPcuaqAWQaMp5HMJpbNm5eMbN9EF
4nEO9R5yMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYyNDEw
Mjk0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBAHuTiXFl1X9prmGd+ktHaqi2xMYbQxmbbd2hO8hi/N9gnBtSqc05CW9QtoCKFtp8DwTsHS2B
ogzBsUom9t3VpoiB1D2xEqOEvDX2VMP2WfnEMQfLYFvIlRVXbiyDB2yw8zqihANxlH5inKZGU371
jf6Satfv0u4Feb9rBM+h7jSyxyzgK+p0vcJtHOakTz2tebmN71dy7ZIehav5eTHp3jV0nHSA150T
G4okNDv2rVTPCsCY5aL6LV4jO6YqqZ5aM9jTHZrTe791c0ZOiUHNLIxM5sjmt9FoY0doEws+oYBH
vk2Ye7LR1ICQvja1tOjzP6HsiS3oSu4gR/WyMGMu4Gw=
--0000000000007ee1e206384ece91--

