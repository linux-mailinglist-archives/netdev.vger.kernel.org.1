Return-Path: <netdev+bounces-212566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C9FB213D9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E031906AF0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2662D47F9;
	Mon, 11 Aug 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XLrVJN4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C228505A
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935702; cv=none; b=p47dWukbQZSYyRvbLTKJDssn2ioMqKlyOToWG1SxoQY3Gk7u+XEErcw0FMSrH2mU3HWaw37J2WsiH0ZV6RuAT83YjR/rmlw5ru4uVyLmcqZoBkg04GLsMTTulzbaLBtfKk4vIpH7BWrY7cWu0Olhu5Wjqip3sxL6/7+8ZvUF5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935702; c=relaxed/simple;
	bh=AF6qul6K1nl5fEDNVrvxMszxobq0kDSCeSvFPUrX5lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcvmYecbCc6RjIfNrIadWAprygFZ/3pJ/jKneKdmB9RlVf5ba57XSuA9Sq00R+OyB5LAAwuHQmJJWOfie1hnKTYNUL0BikSYa9lrVJ5LFAZnzdkgk0NqhN8xo/fH18j/jCp5PD2DCgtVsjbew/n8CZA8WzuVnTW7PtS/aMJFNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XLrVJN4e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso4323763a12.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754935699; x=1755540499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHtP/w6fbcfEIdGOGQ2TrSBToCCATF3ihwwxY7O08SE=;
        b=XLrVJN4eoUCy8zb15PlkTytNHwFdXd1ID22kha1dYgNozbeCI8b9YNZiymq01Yverc
         LlRqQNrriT0AU2infhHfShtSQFHMuFN4p5xtQ37ZFlRI7UlVA8sAsUy5n4gg9N4XDmaX
         yWRMXPJt+um/uw5xRPBUiyAxvwI0Jju3Ls3AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935699; x=1755540499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHtP/w6fbcfEIdGOGQ2TrSBToCCATF3ihwwxY7O08SE=;
        b=ht6rBCmRfC7mo008opI32OwvTCsB7URh300cR7TWHMs5eBzMICxtbrQowqv0QfaHnj
         mDwqMh4KQatW7UBnyMU6t5bxD7qKQuzAdMKvzjORElWubdwiGItopgwzDZX/Rfy/Hvsz
         gdnHYyWM+A17b2nq3UsVTN3cvBcdcot5vDxmEmYWK+v3o/3jB/siqM3aa46EPYfiEINb
         YtPcuZH8d4s6C+t2kgqKwf0fK8AW8L4CJ7ogm/zu456HMY/cDq2K4Of52iddKFu+t0Oz
         OydH7eozuWhc3DX0KTgh5OWdETtnJJPrABeCwBDDiyOFxsOaS4w4qoHP5jzdyx8HKX0H
         L0cA==
X-Gm-Message-State: AOJu0YyQxsJJtipOEerrDTHb+uxmPMuQFbVPSm7pKFBS03u4nFq4Adqq
	C7041vQCQEP8/n3GeE8XZO+sWwgd66CTt3mqkyMVwFD80vHo7EQalAEW8moK8yl337Sfx4/5KhB
	kCJ/684u2i3DpWgL45/naL0mbGgUvayljW0rFKhUe
X-Gm-Gg: ASbGncuruxIFhc5QMi6izRHhhkFM1B0EZ+fdyixHEo+cb8IPhmz+AVGYODkUbXdVAPJ
	qDtoP0pVvPDFBg7NDYhELvtpWOKAUD+LwTFsq0YPFmXvWRAmn3REIVx4w4Zqon8KYFQMBNqA5nd
	KZmns44h+fBNPDN2TU0RvPF4d3TZA25u4nXFFeP7EzOmPDhOgpbf24rC7mwGBax5P7XZvBqqlM8
	+VZUSX9
X-Google-Smtp-Source: AGHT+IGahv6AMaKPOKCZqym0KNdjzYr6bqYxeKZf42c+1kY0Hnfe+EYGyl5cdzyV9Tc2UC5Foficmy4vc/fog1aWPD0=
X-Received: by 2002:a17:906:6a1b:b0:ae3:d100:a756 with SMTP id
 a640c23a62f3a-afa1e1542f6mr35325366b.56.1754935699045; Mon, 11 Aug 2025
 11:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811174346.1989199-1-dw@davidwei.uk>
In-Reply-To: <20250811174346.1989199-1-dw@davidwei.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 11 Aug 2025 11:08:04 -0700
X-Gm-Features: Ac12FXz4el9BTd4iSW595WDz8wZKujDG-BI6tdyeo3ni0lIs40XQlYnMbMYDSZU
Message-ID: <CACKFLimKpAtt8GDGT7k5zagQfzmPc_ggt9c0pu427=+T_FST1g@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt: fill data page pool with frags if
 PAGE_SIZE > BNXT_RX_PAGE_SIZE
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fa2d26063c1ace0c"

--000000000000fa2d26063c1ace0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:43=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> The data page pool always fills the HW rx ring with pages. On arm64 with
> 64K pages, this will waste _at least_ 32K of memory per entry in the rx
> ring.
>
> Fix by fragmenting the pages if PAGE_SIZE > BNXT_RX_PAGE_SIZE. This
> makes the data page pool the same as the header pool.
>
> Tested with iperf3 with a small (64 entries) rx ring to encourage buffer
> circulation.

This was a regression when adding devmem support.  Prior to that,
__bnxt_alloc_rx_page() would handle this properly.  Should we add a
Fixes tag?

The patch looks good to me.  Thanks.
Reviewed-by: Michael Chan <michael.chan@broadocm.com>

>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 5578ddcb465d..9d7631ce860f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -926,15 +926,21 @@ static struct page *__bnxt_alloc_rx_page(struct bnx=
t *bp, dma_addr_t *mapping,
>
>  static netmem_ref __bnxt_alloc_rx_netmem(struct bnxt *bp, dma_addr_t *ma=
pping,
>                                          struct bnxt_rx_ring_info *rxr,
> +                                        unsigned int *offset,
>                                          gfp_t gfp)
>  {
>         netmem_ref netmem;
>
> -       netmem =3D page_pool_alloc_netmems(rxr->page_pool, gfp);
> +       if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
> +               netmem =3D page_pool_alloc_frag_netmem(rxr->page_pool, of=
fset, BNXT_RX_PAGE_SIZE, gfp);
> +       } else {
> +               netmem =3D page_pool_alloc_netmems(rxr->page_pool, gfp);
> +               *offset =3D 0;
> +       }
>         if (!netmem)
>                 return 0;
>
> -       *mapping =3D page_pool_get_dma_addr_netmem(netmem);
> +       *mapping =3D page_pool_get_dma_addr_netmem(netmem) + *offset;
>         return netmem;
>  }
>
> @@ -1029,7 +1035,7 @@ static int bnxt_alloc_rx_netmem(struct bnxt *bp, st=
ruct bnxt_rx_ring_info *rxr,
>         dma_addr_t mapping;
>         netmem_ref netmem;
>
> -       netmem =3D __bnxt_alloc_rx_netmem(bp, &mapping, rxr, gfp);
> +       netmem =3D __bnxt_alloc_rx_netmem(bp, &mapping, rxr, &offset, gfp=
);
>         if (!netmem)
>                 return -ENOMEM;
>
> --
> 2.47.3
>

--000000000000fa2d26063c1ace0c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJVBVB6GwlPxYwRgXYrqcQcwk51aCkZM
vHeQJATjEMIuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgx
MTE4MDgxOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAB0mtl3ttg2k1Uj7gD1slZpiJcyTWRnXLjcZOenMzs0qx4Y+aEoCObTZxJmevx1fG6yL
+qjQ1+86/UtwoNRhmuHf2lAeVmVOhS3SVv9cY1rS8Pd1SpTqhosO9DKA1e5wOebccaRUNRg0g1z6
f/6Z/zRgmVjj8z3e4MRW7HM+JVXkytXQOzJLcEZc8HVAQ1ucqrPUp+vwBijAMg1wta03V96et/iN
RGaQ51u4ZxfsyQ8X6Ho+dJpXfO1Zv4qx8hdB3+uzPueywNz3KBBWhqcr4kQfoRqV5h5a76V6OfDk
lsIOdbEUUXURdehtDPvdkY6Smo6krtvntm/v7oDHnoLkIms=
--000000000000fa2d26063c1ace0c--

