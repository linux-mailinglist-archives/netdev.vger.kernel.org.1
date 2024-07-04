Return-Path: <netdev+bounces-109138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918C927168
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12231F23058
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8EC1A3BA1;
	Thu,  4 Jul 2024 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ErEQX3IQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38411A2554
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080847; cv=none; b=lKSYg+zEJgqqYdiPJT1CppCu6XtYn8kziUlaT8p4LEsjP+eZ9/IpCzQvP0VhHxz9rQFZfqRfnFjMaIxD1lpouY0RcQLkEnI+pDbsgP47Nzayy2exaPu9Mcb4cjrO/aLBKP2vyE5KxRtp/QbeGn1Hw0ONKKze43piNFFQxQJPiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080847; c=relaxed/simple;
	bh=9kxFg+U5vohFDaOrHsw7iOpXC2zbytAL6gmiH4LFCIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko1afiNyTUfO7FHZE9QJD6+imTDe65Q6D/PDS58fVjnIYbmNUA9Ip9YmDHKaTVr857pglOAXwr56bv3MUrBNs2Y3M286HObcy2DGgskIylbmaf1fD1+EC+mBFLZzhPFiLKPR8w05Tm5fH0DluAExaa6fuWQ0yAHZzdk+b6CXFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ErEQX3IQ; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48fe7627026so165154137.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720080845; x=1720685645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A5Z/sGZBaQE0FZ99T15l7+TdnOpgxhWJwJVLlsghS0o=;
        b=ErEQX3IQufAjqc9U+GjW0TmHLo4H8wh47zIvOA7qZ4T6kt4g+fvhrOfm7mnE6LpRbH
         OnNusHjZcw1A727pwIzq8U+wqvAw88b+bw0e8Zh9WTywak8bX1EmUi9RV/20KenaBWiv
         7xT/sILj6h1eIO3tFh7rG30nNTNK47cJomaTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080845; x=1720685645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5Z/sGZBaQE0FZ99T15l7+TdnOpgxhWJwJVLlsghS0o=;
        b=qadWJQuSnUz5RTWwZzt9jcCMQlPHKlW2wsje0Nd3VN5QyHxoxUC0HZx0Whq/XeDu7c
         RzvbtY9wlqBWyroB8REqrawOTDUzsHmj+g+2uCWv1p8OJnzZID+2a/TMvRsEYiuNalqD
         UVyEC6a+hvA8bGRQDN+NxrYoiJNOiElnaynL4pKT608hsOcZbEKvL278JYwYkhJEKyda
         O4lRFBuA1o72qOf2iOSGNBudD8H1XBFuNb+aCiDJsp7wI3gZKlPeq2UzRpfCVjC/rXDu
         1uR5EVAL4x/wdDcpWYlWSjQj31Xt9e0yYyEX8b3AwBq/ZD1ffVsElABcDZkRATM5uCCe
         FHzg==
X-Forwarded-Encrypted: i=1; AJvYcCXiVj1TuqcA2OH7nuXxv0RFuim//75rbqiUjoOk8JHSu47XTo/xzcMztCin2QAEJNjzOqsDH50t/MLViYLQtWLKskgyHWtX
X-Gm-Message-State: AOJu0YzNqVg21j8d0ur91bONIgcY7k7I7uppJfbpQdjaNcBoMkmsSIN3
	8/ny8FJ9oZSOyuEN8g3oN5+NAW4002vZwu097TKeQweK4nUkXwBWRTFLiNBraY/m9ZB24veXfhY
	/99rIrwx1yz8Sdy+bZ9QIQ2PDfJcrYkwHrH74
X-Google-Smtp-Source: AGHT+IFSW5gpzxUBfvjSnfYjtugoLwllm2CMe74+cHrJdpsfBCK+tPF+Le9BJZyvUszo7l8nbwrGdHvnd+UP0qERRyY=
X-Received: by 2002:a05:6102:2326:b0:48f:e09f:5176 with SMTP id
 ada2fe7eead31-48fee6db93dmr822887137.32.1720080844681; Thu, 04 Jul 2024
 01:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704074153.1508825-1-ap420073@gmail.com>
In-Reply-To: <20240704074153.1508825-1-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 4 Jul 2024 13:43:52 +0530
Message-ID: <CAOBf=muJWjXyZaWfnFLZz8mJf75=tUtZPUHepM_O=_xoDZeOUg@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: fix kernel panic in queue api functions
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c07f6a061c6787c7"

--000000000000c07f6a061c6787c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:12=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> bnxt_queue_{mem_alloc,start,stop} access bp->rx_ring array and this is
> initialized while an interface is being up.
> The rings are initialized as a number of channels.
>
> The queue API functions access rx_ring without checking both null and
> ring size.
> So, if the queue API functions are called when interface status is down,
> they access an uninitialized rx_ring array.
> Also if the queue index parameter value is larger than a ring, it
> would also access an uninitialized rx_ring.
You might want to rephrase this as  'if the queue index parameter is
greater than the no: of rings created'
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 1 PID: 1697 Comm: ncdevmem Not tainted 6.10.0-rc5+ #34
>  RIP: 0010:bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en]
>  Code: 49 89 f5 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 8d af 40 0a 00 =
00 53 48 89 fb 48 83 ec 05
>  RSP: 0018:ffffa1ad0449ba48 EFLAGS: 00010246
>  RAX: ffffffffc04c7710 RBX: ffff9b88aee48000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff9b8884ba0000 RDI: ffff9b8884ba0008
>  RBP: ffff9b88aee48a40 R08: 0000000000000000 R09: ffff9b8884ba6000
>  R10: ffffa1ad0449ba88 R11: ffff9b8884ba6000 R12: 0000000000000000
>  R13: ffff9b8884ba0000 R14: ffff9b8884ba0000 R15: ffff9b8884ba6000
>  FS:  00007f7b2a094740(0000) GS:ffff9b8f9f680000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000015f394000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x70
>   ? page_fault_oops+0x15a/0x460
>   ? __vmalloc_node_range_noprof+0x4f7/0x8e0
>   ? exc_page_fault+0x6e/0x180
>   ? asm_exc_page_fault+0x22/0x30
>   ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 2b2843e995211f081639d5c=
0e74fe1cce7fed534]
>   ? bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en 2b2843e995211f081639d5c0e74f=
e1cce7fed534]
>   netdev_rx_queue_restart+0xa9/0x1c0
>   net_devmem_bind_dmabuf_to_queue+0xcb/0x100
>   netdev_nl_bind_rx_doit+0x2f6/0x350
>   genl_family_rcv_msg_doit+0xd9/0x130
>   genl_rcv_msg+0x184/0x2b0
>   ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x54/0x100
>   genl_rcv+0x24/0x40
>   netlink_unicast+0x243/0x370
>   netlink_sendmsg+0x1bb/0x3e0
>
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> The branch is not net because the commit 2d694c27d32e is not
> yet merged into net branch.
>
> devmem TCP causes this problem, but it is not yet merged.
> So, to test this patch, please patch the current devmem TCP.
> The /tools/testing/selftests/net/ncdevmem will immediately reproduce
> this problem.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 6fc34ccb86e3..e270fb6b2866 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15022,6 +15022,9 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         struct bnxt_ring_struct *ring;
>         int rc;
>
> +       if (!bp->rx_ring || idx >=3D bp->rx_nr_rings)
> +               return -EINVAL;
> +
>         rxr =3D &bp->rx_ring[idx];
>         clone =3D qmem;
>         memcpy(clone, rxr, sizeof(*rxr));
> @@ -15156,6 +15159,9 @@ static int bnxt_queue_start(struct net_device *de=
v, void *qmem, int idx)
>         struct bnxt_cp_ring_info *cpr;
>         int rc;
>
> +       if (!bp->rx_ring || idx >=3D bp->rx_nr_rings)
> +               return -EINVAL;
> +
>         rxr =3D &bp->rx_ring[idx];
>         clone =3D qmem;
>
> @@ -15195,6 +15201,9 @@ static int bnxt_queue_stop(struct net_device *dev=
, void *qmem, int idx)
>         struct bnxt *bp =3D netdev_priv(dev);
>         struct bnxt_rx_ring_info *rxr;
>
> +       if (!bp->rx_ring || idx >=3D bp->rx_nr_rings)
> +               return -EINVAL;
> +
>         rxr =3D &bp->rx_ring[idx];
>         napi_disable(&rxr->bnapi->napi);
>         bnxt_hwrm_rx_ring_free(bp, rxr, false);
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000c07f6a061c6787c7
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPXXx2M61EsHerdTTFqRjHtzlAgL
Hfj3PSLvqj64CuOjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDcwNDA4MTQwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCIuhTJL276R2HcoDMyIcXX1YNLSNiW3w1b89EQuiLx8ms5
1k+fFWPq+BJrCPn5nUD80pC7QYDX1dnjI04wgyTYC+y/X+IMHiK9g+QczMxqFVbtRrWFduxGVhFT
j3EuSa9INEDwG+tySRkbueVbCvKNiKujyhBFcrwmBHMIP7WUxKNQnuE9VjHlYwBal5vAtSAs8ype
DC0MP3rm37B0+0Qp5t0MmaBe5s4uVEbeMKWn78XsGYRgkOoOS59/rtZJQNvEnVLmtSr84cGIjTn/
PaL8IIn+iGrNCVRbVLqlHMf+/oatXH8KXHnLzsF5arKxO4Yi85xIBP/r/mtL5w+0ibbn
--000000000000c07f6a061c6787c7--

