Return-Path: <netdev+bounces-112909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BD93BC1A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD2C1F23858
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659E1BF50;
	Thu, 25 Jul 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hv8Fb9le"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B36FC1
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886330; cv=none; b=MXXHo8sxd4fafLiMDOHFMBx3Ma5n93KO95EItcidyWf+dSs/ZSN4agnI9FI0Bv3l+Qp3ptheO8HKWXl8ctEzKVL5yMU/AmWNRCKubQwerC8Kxm6k/5GEnLf/62R/6Sy6lCcnJI413u857rEC/qhGf7dBthprsIDRTpJScH584yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886330; c=relaxed/simple;
	bh=fnDOBJ1x3V/HJ7Cxeerbykw3cIpSt0NoGHfHHQltVNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOZJlzA5Tbw3/jsMj2tOdUc336KD0CniFsb74B6yDZDKsNEBhKoCfIqn/FzXr7NoTvCpgCSPpTCcF2jsxd45vF6Yty3GXyvUOr/rqXlJM8+nFScGkOwWETvNoxPwHdBwJiGljIHI6rb6qYcYcYLy5B+phAH2rW6kUmwU4wMYF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hv8Fb9le; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-824ae03efbfso113041241.3
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721886327; x=1722491127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cuco6k9viQTSdp5gqXze5dAwNCGIVJ8CVD0EgRhsil8=;
        b=Hv8Fb9le2Im86ox6jDA+urn7Ikh7lErTz6YP8PbusKvQQfW2bf2Pr6aDmkm8eTgLF2
         7qBtwm22mxoLF4DKOuMmeuAa42W0ffJ4msH3omoN3TIEaz6b9FCo5u6+stDt5tjagO6N
         h1qDiy6DW+lQVF8VTxB6cQmxose4kxeVWA7eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721886327; x=1722491127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuco6k9viQTSdp5gqXze5dAwNCGIVJ8CVD0EgRhsil8=;
        b=fCgKQuGDSeBD+pIFggmEuAp99sC2jAdQInx77Hc0wLu2mXNK71RdlgCmAc86GXqPqA
         ++D6d6wuqoIEmcaja05ugnmuidk7jusbrJRTrfA9uVoApnC6IQe8N+4daVWLOK3wrG/W
         fD3BizIPD3JUAGFZxe6i0JVi2Vr58cIU7aG1wxKMn3wY4gYdWdIeqfJEXi17Axqew0e2
         AmCqQVdiEkL/a0p7SB73uEX0BTJQb/A0PfCbUoNaXJ/kR9JOsaKTIchc/CAmpEkSbThf
         /d+jzoGt/SFzQpI+Xvi/Y1hteiwNlspM46LFZb37Ocy8OvimYSzD9CYtw/w/EnnYxbyg
         vg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4eEz0x5ACjpospFjT/mcjYQicCeuXOma4jywgEsKtisSV0k5GaE8WKK5rBgtbCqPYOPUAeHSWyPvv9sj/KfsbLn6QlaMV
X-Gm-Message-State: AOJu0Yw8OjCZLRUtPIbbodeJlOI3qzS6nG/vgspw4SPhNSxhK8p+UVbk
	lCXIttz6D05NLiCjyuYAokrT5hNYT9yDdWyGiAtoJfxH6vZnAMJv4MUFGedqWXyvl/16DU/wl8/
	RdbraaMX4HQrnY2iAtTp4hQo17u2xEYP6foOh
X-Google-Smtp-Source: AGHT+IEbXy4zjmwe/xfKOidIWH/t+N/H4JBmJ27CLMIZuBD918V3dk7SKbADBQcvo9x+aQqH2rcyJqOopuSp88kPFOo=
X-Received: by 2002:a05:6102:c8c:b0:493:de53:9bac with SMTP id
 ada2fe7eead31-493de53a376mr62066137.11.1721886327247; Wed, 24 Jul 2024
 22:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721053554.1233549-1-ap420073@gmail.com>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 25 Jul 2024 11:15:14 +0530
Message-ID: <CAOBf=murqFTmyZ6J2a4_9hYOj=wyLPRZJk0DSG7sB7cEr_earg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e6fbd8061e0be64d"

--000000000000e6fbd8061e0be64d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 11:06=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
>
> An old page_pool is no longer used so it is supposed to be
> deleted by page_pool_destroy() but it isn't.
> Because the xdp_rxq_info is holding the reference count for it and the
> xdp_rxq_info is not updated, an old page_pool will not be deleted in
> the queue restart logic.
>
> Before restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 4 (zombies: 0)
>         refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
>         recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
>
> After restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 5 (zombies: 0)
>         refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
>         recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
>
> Before restarting queues, an interface has 4 page_pools.
> After restarting one queue, an interface has 5 page_pools, but it
> should be 4, not 5.
> The reason is that queue restarting logic creates a new page_pool and
> an old page_pool is not deleted due to the absence of an update of
> xdp_rxq_info logic.
>
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v2:
>  - Do not use memcpy in the bnxt_queue_start
>  - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
>    bnxt_queue_mem_free().
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index bb3be33c1bbd..ffa74c26ee53 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *=
bp,
>
>         rxr->page_pool->p.napi =3D NULL;
>         rxr->page_pool =3D NULL;
> +       memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
>
>         ring =3D &rxr->rx_ring_struct;
>         rmem =3D &ring->ring_mem;
> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_devic=
e *dev, void *qmem, int idx)
>         if (rc)
>                 return rc;
>
> +       rc =3D xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> +       if (rc < 0)
> +               goto err_page_pool_destroy;
> +
> +       rc =3D xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> +                                       MEM_TYPE_PAGE_POOL,
> +                                       clone->page_pool);
> +       if (rc)
> +               goto err_rxq_info_unreg;
> +
>         ring =3D &clone->rx_ring_struct;
>         rc =3D bnxt_alloc_ring(bp, &ring->ring_mem);
>         if (rc)
> @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
>         bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
> +err_rxq_info_unreg:
> +       xdp_rxq_info_unreg(&clone->xdp_rxq);
> +err_page_pool_destroy:
>         clone->page_pool->p.napi =3D NULL;
>         page_pool_destroy(clone->page_pool);
>         clone->page_pool =3D NULL;
> @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device=
 *dev, void *qmem)
>         bnxt_free_one_rx_ring(bp, rxr);
>         bnxt_free_one_rx_agg_ring(bp, rxr);
>
> +       xdp_rxq_info_unreg(&rxr->xdp_rxq);
> +
>         page_pool_destroy(rxr->page_pool);
>         rxr->page_pool =3D NULL;
>
> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *de=
v, void *qmem, int idx)
>         rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
>         rxr->rx_next_cons =3D clone->rx_next_cons;
>         rxr->page_pool =3D clone->page_pool;
> +       rxr->xdp_rxq =3D clone->xdp_rxq;
>
>         bnxt_copy_rx_ring(bp, rxr, clone);
>
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000e6fbd8061e0be64d
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAp+aqZpU2HhpdPPf+ydVhH7tCWP
4i7fsOhbL0qYprEtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDcyNTA1NDUyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBr6OeHkngw+eg5cCiKY3dtetDu7W+dJGPJ5plrhL+Mr+3q
B6/63OQSMaRjLESdeIKCUXUoXWnjPSaLIVz2StlXir5OEy7Sh13lgxPfchmTrUTgXa8VH1iLymch
sBYcUBVPR2j9uhP0Y6LnLTwI52Nk26iQq73xxrOnbA4/bRDXez1mvR9+lRQ2FBFYDuNXJStaQaHh
CMTwLR6OSm9450jqvzRPK/uiYY3ruqXHSxYqVLybYvQ2gkRTTuUlb9/qDOs8vUblBumg+doJddHx
+G+EiBaCxafC/zEKDiYK4i3i9ryPn2HDepCSN3nCps937ItY1ympdCDWQvcF7VQzN1hE
--000000000000e6fbd8061e0be64d--

