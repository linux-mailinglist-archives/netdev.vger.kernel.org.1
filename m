Return-Path: <netdev+bounces-147332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECB89D91CF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 07:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447A9B2152A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 06:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2946335B5;
	Tue, 26 Nov 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XnKphy8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C08653
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602839; cv=none; b=nJw+wOU6giu268KnCk4IY/kScFbCOt5y5bfZI/PSle1aG/+k+Y9HkHKyOwTO3U1EJxvSan3y+nh4d0E73r9owvL78TyccpETQqeyqaAyCVzPa+4riLaRtah5NUDizRlil27bJ6Irx/TlbuCPrfiKuiYnNQmncZDmL+JVAquKc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602839; c=relaxed/simple;
	bh=daesccIW0K6lyxBmWOlGBRLy/qPm4O4zYTqmsPN4F5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKtaQOKsQOU99w2Ixwp9s5LKCnpH/V3dGzTSarR7QSMN9WX7LDKMMCQ5O9oCUtVS5lQrl4WKGyzt/Km89jFyZCICsbCjJXZf2GpxEU0SSm35eu/sUCISJ5MvB6Kx722PeCEi67Sh4CTOuZy96utCNKn9OVQ9YvYBdqfAjly2oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XnKphy8W; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4aad848f2f1so1453724137.2
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 22:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732602837; x=1733207637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h91ksujD3yrmFYjX0tumYSD3cFUUbjXJJ/fiqtiV4N8=;
        b=XnKphy8WtFpgAxhGhPJFtAzdXU9D2zobmLbygSwFuHQjYLqvFYiv+FPMDfJ5+yjN9Q
         CdYB43GRtX1O7vEKDm15R399bPTg5vZeYpOxvqLwrCuFb52WCkM1n34cAMKA8rP9fxn1
         iUTFSS/HEbfLGPg88ZUTv/ShX7wQg5h09Sjns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732602837; x=1733207637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h91ksujD3yrmFYjX0tumYSD3cFUUbjXJJ/fiqtiV4N8=;
        b=gsYvbZCGgAAikZ3Zjjf8HAVmuQ2au9QghPnI3KAXxdku+Swc6OswrkbhqVSE06j4gw
         Vrmzjh/8HejhmrR/2nOYCn/1JS79i5YqBic0jp5vBpwyExUFByQSwYlZHEDPN8wBfdkq
         DSh1y0MkSOxOJiUEmgc2OVMIbTY4M2qJtDgyO4BEaeccnb0EHbvGrGKxF3A1eEyGuQdO
         Px76ryY7YH1ShPD07eXAX9iMecF4yxtb0FwGQ+1flM9f5ZhMhiJDXHmKIRMHe1OqN3tK
         8nTKbonZAi+Ctss5smLLlFLx1a30qqRm9Qquj6dGF4aH/m0kX1UivKYJjUfn6xLHJJSj
         1eTQ==
X-Gm-Message-State: AOJu0YxQLMBM+QQp0j0IxkxV89N+LkN7KO/VMny4FL9GItFxj/L1pJrS
	kW8GZS+Nb34VPDF20eVkp/HD7tBtQWLoUDo7Gqx4rdXgPn0JVASwv1kjoDVlAo+eDet30MqDzeb
	amEzdBst7ohXt3/encgTZKZy42WbrOO6RPvZE
X-Gm-Gg: ASbGncu7kTBYFbFE+SeEKKt1eQ02LdpUbjTxG/H91vtwG7ljpR/wwXubPLqgy7bNLq3
	GYCuIyvS+0yGH+01k42UjcZJJjtRQb0NV
X-Google-Smtp-Source: AGHT+IFhc+v+bQcvtHknktWd6FAmpZ6jq8W3cSRwGu4l0cRUDXAMCn3Fes/juzYLFlFF3uzwaGu5LoFm/z8zehRbevc=
X-Received: by 2002:a05:6102:5088:b0:4af:3e23:2183 with SMTP id
 ada2fe7eead31-4af3e232393mr226426137.5.1732602836841; Mon, 25 Nov 2024
 22:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125042412.2865764-1-dw@davidwei.uk> <20241125042412.2865764-4-dw@davidwei.uk>
In-Reply-To: <20241125042412.2865764-4-dw@davidwei.uk>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Tue, 26 Nov 2024 12:03:45 +0530
Message-ID: <CAOBf=muDXtrsMMszA+Y8raaT7cGYrotU88s2YMN9B2r80gcm_Q@mail.gmail.com>
Subject: Re: [PATCH net v1 3/3] bnxt_en: handle tpa_info in queue API implementation
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a4d8f70627cb08d1"

--000000000000a4d8f70627cb08d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:54=E2=80=AFAM David Wei <dw@davidwei.uk> wrote:
>
> Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
> page pool for header frags, which may be distinct from the existing pool
> for the aggregation ring. Add support for this head_pool in the queue
> API.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 294d21cdaeb7..e4b7ff9f6dfa 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15378,15 +15378,25 @@ static int bnxt_queue_mem_alloc(struct net_devi=
ce *dev, void *qmem, int idx)
>                         goto err_free_rx_agg_ring;
>         }
>
> +       if (bp->flags & BNXT_FLAG_TPA) {
> +               rc =3D bnxt_alloc_one_tpa_info(bp, clone);
> +               if (rc)
> +                       goto err_free_tpa_info;
> +       }
> +
>         bnxt_init_one_rx_ring_rxbd(bp, clone);
>         bnxt_init_one_rx_agg_ring_rxbd(bp, clone);
>
>         bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
>         if (bp->flags & BNXT_FLAG_AGG_RINGS)
>                 bnxt_alloc_one_rx_ring_page(bp, clone, idx);
> +       if (bp->flags & BNXT_FLAG_TPA)
> +               bnxt_alloc_one_tpa_info_data(bp, clone);
>
>         return 0;
>
> +err_free_tpa_info:
> +       bnxt_free_one_tpa_info(bp, clone);
>  err_free_rx_agg_ring:
>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
> @@ -15394,9 +15404,11 @@ static int bnxt_queue_mem_alloc(struct net_devic=
e *dev, void *qmem, int idx)
>  err_rxq_info_unreg:
>         xdp_rxq_info_unreg(&clone->xdp_rxq);
>  err_page_pool_destroy:
> -       clone->page_pool->p.napi =3D NULL;
>         page_pool_destroy(clone->page_pool);
> +       if (clone->page_pool !=3D clone->head_pool)
> +               page_pool_destroy(clone->head_pool);
>         clone->page_pool =3D NULL;
> +       clone->head_pool =3D NULL;
>         return rc;
>  }
>
> @@ -15406,13 +15418,15 @@ static void bnxt_queue_mem_free(struct net_devi=
ce *dev, void *qmem)
>         struct bnxt *bp =3D netdev_priv(dev);
>         struct bnxt_ring_struct *ring;
>
> -       bnxt_free_one_rx_ring(bp, rxr);
> -       bnxt_free_one_rx_agg_ring(bp, rxr);
> +       bnxt_free_one_rx_ring_skbs(bp, rxr);
>
>         xdp_rxq_info_unreg(&rxr->xdp_rxq);
>
>         page_pool_destroy(rxr->page_pool);
> +       if (rxr->page_pool !=3D rxr->head_pool)
> +               page_pool_destroy(rxr->head_pool);
>         rxr->page_pool =3D NULL;
> +       rxr->head_pool =3D NULL;
>
>         ring =3D &rxr->rx_ring_struct;
>         bnxt_free_ring(bp, &ring->ring_mem);
> @@ -15494,7 +15508,10 @@ static int bnxt_queue_start(struct net_device *d=
ev, void *qmem, int idx)
>         rxr->rx_agg_prod =3D clone->rx_agg_prod;
>         rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
>         rxr->rx_next_cons =3D clone->rx_next_cons;
> +       rxr->rx_tpa =3D clone->rx_tpa;
> +       rxr->rx_tpa_idx_map =3D clone->rx_tpa_idx_map;
>         rxr->page_pool =3D clone->page_pool;
> +       rxr->head_pool =3D clone->head_pool;
>         rxr->xdp_rxq =3D clone->xdp_rxq;
>
>         bnxt_copy_rx_ring(bp, rxr, clone);
> @@ -15545,7 +15562,6 @@ static int bnxt_queue_stop(struct net_device *dev=
, void *qmem, int idx)
>         bnxt_hwrm_rx_ring_free(bp, rxr, false);
>         bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>         rxr->rx_next_cons =3D 0;
> -       page_pool_disable_direct_recycling(rxr->page_pool);
Intended? Not sure I understood this one, while I got the rest of the patch
>
>         memcpy(qmem, rxr, sizeof(*rxr));
>         bnxt_init_rx_ring_struct(bp, qmem);
> --
> 2.43.5
>
>

--000000000000a4d8f70627cb08d1
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJcn2uKJ6UZ63UFBmIpkL4pwR8sX
F0D2ZezOSyyNovoxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MTEyNjA2MzM1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCjIY2dtyDHuiOec1opUzmb9n1i5NTp2FTWLmd6B3bJLGOw
0N36qjXBCNBdO2KltlbflKoteM31u7ZvbbZTdVc3nIoJva3kzkk8JMua09c39qAC+XbPOqXqcvu8
45xbQa0BQQvDZz+gvwDY9JhH7lK9ap3gCGTgAF2/ofKta/TzpqF/XW97faGoyPdcHi6SjPIrkK5b
IgLxdSYwgnGcXIG+LF2n+e7SVoAojxMqB4ybgZgdeDd0M82nDO3eQZ5hPpPi4x4TU5hPmyWZa0ry
ZINgR0e6bIl7NyJk/94lqwsd5g6RdmFbKhiLkl63pi9vNIj98JMfkBdjhIFg2YNez965
--000000000000a4d8f70627cb08d1--

