Return-Path: <netdev+bounces-95278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0B8C1CD0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3FCB2090F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44AE148858;
	Fri, 10 May 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IXUEai3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65029CE1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310650; cv=none; b=RcwOsQop1vgRq9cvWHZAaxlhQANH1Z7HN19ERfTrcPlqsAP0l4Vdmgg55XBeMX1wOiRrpKoAxYCMDj1TLAXsi6U83uJV+IUzSWq10TnWCMqkaQG0bM43d9ZcMZbVBjDtmJ7wk+3k/ZyCx2LdCK8eqG4T18UaiTct1o15qkyUaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310650; c=relaxed/simple;
	bh=cQXFRHNNqkkfc5+wNhbAJPhcx9qfEzxhKLg9Mkar4dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYLyp1ReOdu/65zJUvG9P2Gnqx2LYHTjIN8OfYOstov57nUwdVKoghyiyZLXDGDivwGb2EZ027zH1m5Y5hGpDkRllfAwVzMbeUd7aEbYtVx4Vt9lPZ46tdzXn8U1YUqEPBOkNqOuD0ZbBc6dDuGaRlej77Zm3ykmCk8zvFJAvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IXUEai3h; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7f3317ff3c2so467828241.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715310648; x=1715915448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EH2OiFBZrApUcz/BPva1zTKhsT47pnj1B7SQzlmzUxM=;
        b=IXUEai3hZpOx+gtHAqvPn/Ej9m8+Q4FD1LIMCt6XEdajmBWOom+d8fzUKltCpKYRCh
         6qy3SkRNKKCXzA/M5wQGQOSgKC+Uy/uIuinCFboXhrcBhGfk9pRK5idIjOmCyiHu2gVi
         gRHyFaSCkYn+slGhaJcIbo/LMWskZyLgylwf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715310648; x=1715915448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EH2OiFBZrApUcz/BPva1zTKhsT47pnj1B7SQzlmzUxM=;
        b=ee2fhfRyVSYGszvCt1SHh1WBiJ1D+QVInzj8rMytWVfIS1QsqUeXAtk6//cSPym1wN
         Rabc3RAvLFiO2zasQyezV10kUPeu+4CmIr3Nu6SylRl17Sc0xLSVPZ4bbGnfVBpshXDU
         DsK9/v6fRF9F47+N3/ZU5FvJTCdcf0bWeVTtrOW2EaUSDURqbhnXq91Tji9zi7neSQKH
         GMSIdXGE+SHtDCjz/KEavjX8PrOVZYGIqbN4cPiBWlXOJ4gs31OkhwaLuANYUwcxC89A
         PQtEhp2k3BkyzxpV0sct+iMFiiHCj4+asxJT4iWhLZXBxw1Y3AYwr70/MBX4irAfLgae
         qQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWICKwHoerEteMYR6+u5kp9BnyCgDuBtTNqrz2NfBOV2THVntcNACrcl2s5491d6oHmNeduO507sZiWSiIJ3wiXSJ+bU+9m
X-Gm-Message-State: AOJu0YzjEd4rwvyjS97JNwyIRU1ebEBO/UuO/SQMaAbyU58NMq0IRkGZ
	lHAYM61c5Bz7nTDkbVvtGuu49uq21vp9Xb1wT1ajP1Z/ak4CP3NeDMKPGYXa1hhcXgdYrEVENW6
	yxjIAi5gUmeM2mHEHIMtzZDvU+wAyy88a374O
X-Google-Smtp-Source: AGHT+IFJuSX44NqVs2r/U5GHYoXwdi1J6G95y/KWwvepUrEc9R8Vmh0ux8iHyli1z0reSz3HIpuODRWo/SoDmXr0E2E=
X-Received: by 2002:a05:6102:4187:b0:47c:2a81:a98 with SMTP id
 ada2fe7eead31-48077e176fbmr1877791137.20.1715310647325; Thu, 09 May 2024
 20:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509162741.1937586-1-wei.huang2@amd.com> <20240509162741.1937586-9-wei.huang2@amd.com>
In-Reply-To: <20240509162741.1937586-9-wei.huang2@amd.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Fri, 10 May 2024 08:40:34 +0530
Message-ID: <CAOBf=msuCassc=XAQ3DFVwKEfrT9sJfwnkEmEsYaySv=Aa3q7g@mail.gmail.com>
Subject: Re: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, bhelgaas@google.com, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com, 
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com, 
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dfae8b061810e1ce"

--000000000000dfae8b061810e1ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:02=E2=80=AFPM Wei Huang <wei.huang2@amd.com> wrot=
e:
>
> From: Manoj Panicker <manoj.panicker2@amd.com>
>
> As a usage example, this patch implements TPH support in Broadcom BNXT
> device driver by invoking pcie_tph_set_st() function when interrupt
> affinity is changed.
>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 2c2ee79c4d77..be9c17566fb4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,7 @@
>  #include <net/page_pool/helpers.h>
>  #include <linux/align.h>
>  #include <net/netdev_queues.h>
> +#include <linux/pci-tph.h>
>
>  #include "bnxt_hsi.h"
>  #include "bnxt.h"
> @@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
>                                 free_cpumask_var(irq->cpu_mask);
>                                 irq->have_cpumask =3D 0;
>                         }
> +                       irq_set_affinity_notifier(irq->vector, NULL);
>                         free_irq(irq->vector, bp->bnapi[i]);
>                 }
>
> @@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
>         }
>  }
>
> +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +                                    const cpumask_t *mask)
> +{
> +       struct bnxt_irq *irq;
> +
> +       irq =3D container_of(notify, struct bnxt_irq, affinity_notify);
> +       cpumask_copy(irq->cpu_mask, mask);
> +
> +       if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> +                            cpumask_first(irq->cpu_mask),
> +                            TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> +               pr_err("error in configuring steering tag\n");
> +
> +       if (netif_running(irq->bp->dev)) {
> +               rtnl_lock();
> +               bnxt_close_nic(irq->bp, false, false);
> +               bnxt_open_nic(irq->bp, false, false);
> +               rtnl_unlock();
> +       }
> +}
> +
> +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
> +{
> +}
> +
> +static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *ir=
q)
> +{
> +       struct irq_affinity_notify *notify;
> +
> +       notify =3D &irq->affinity_notify;
> +       notify->irq =3D irq->vector;
> +       notify->notify =3D bnxt_irq_affinity_notify;
> +       notify->release =3D bnxt_irq_affinity_release;
> +
> +       irq_set_affinity_notifier(irq->vector, notify);
> +}
> +
>  static int bnxt_request_irq(struct bnxt *bp)
>  {
>         int i, j, rc =3D 0;
> @@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
>                         int numa_node =3D dev_to_node(&bp->pdev->dev);
>
>                         irq->have_cpumask =3D 1;
> +                       irq->msix_nr =3D map_idx;
>                         cpumask_set_cpu(cpumask_local_spread(i, numa_node=
),
>                                         irq->cpu_mask);
>                         rc =3D irq_set_affinity_hint(irq->vector, irq->cp=
u_mask);
> @@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
>                                             irq->vector);
>                                 break;
>                         }
> +
> +                       if (!pcie_tph_set_st(bp->pdev, i,
> +                                            cpumask_first(irq->cpu_mask)=
,
> +                                            TPH_MEM_TYPE_VM, PCI_TPH_REQ=
_TPH_ONLY)) {
> +                               netdev_err(bp->dev, "error in setting ste=
ering tag\n");
> +                       } else {
> +                               irq->bp =3D bp;
> +                               __bnxt_register_notify_irqchanges(irq);
> +                       }
>                 }
>         }
>         return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index dd849e715c9b..0d3442590bb4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1195,6 +1195,10 @@ struct bnxt_irq {
>         u8              have_cpumask:1;
>         char            name[IFNAMSIZ + 2];
>         cpumask_var_t   cpu_mask;
> +
> +       int             msix_nr;
> +       struct bnxt     *bp;
> +       struct irq_affinity_notify affinity_notify;
>  };
>
>  #define HWRM_RING_ALLOC_TX     0x1
> --
> 2.44.0
>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000dfae8b061810e1ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHWb6CVByNUeKT9WdKLXET+1bIF1
UmOFoE9yd+mYBVhqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDUxMDAzMTA0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQClK6L/ZX5ZyvUJU+OxAFO9vzpKDl9ffWUFn+Gf6XkP8O3p
zyKmsQrldHwkHD+5Zo881jCwOunoFEGkBYqEz//CEFQ4ui8lMRCPiI4pJWL55855KBF3lB02lQmy
2f21KvfGxO+E+UIZlCKZC1gXcxtRToRFN1VRa14m0ppK9qO8+wY9eM95vOil11QiImc3dMk3Ib8Q
a4jqw/8P5RVpzhK80RcIcqROQApR2GZp5rdKoE2G+jiXdvoz/LKqund9nwwFxWckJYtocqzI6X+9
/f72RLLLDe4yFkvXlLB8dQhlsty95yLr+Eg9fx4/nGn54ZoX9LHZOD/XXYBnzwNjtXCc
--000000000000dfae8b061810e1ce--

