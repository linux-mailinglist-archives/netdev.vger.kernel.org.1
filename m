Return-Path: <netdev+bounces-201692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF2AEA90E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B346D3BB549
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB425CC57;
	Thu, 26 Jun 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RS8nOKry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E96260577
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974751; cv=none; b=IWjsCUCGKcrXeLdanoWszomiASsm+j7HG97ZfhI7vSfE8tOWzByI97w6MZ96/TARrs3VKAvBe/IIU5JichYBm4vkRu+2Oc2tz08x4FFzFQtjWXffnJ6lDm+Gya8RQYIhI9lriWqj+w8rC8DSXL/e5OpXBemaG2SWATMLPh88ofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974751; c=relaxed/simple;
	bh=Ou0fe7xWkqJfzso0WWeGLogga144lqnr6BdCm4q+/wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgkpL7sefFRXz22XznXXk1s3vT8bhduVWsy5+Toei/85em8PtXUYFrZPrRLSTwXXkAi5oujZ6JvoIxnY4NYHOfbqIKYri+EYQ60UPIzWObYvmEkGKFjQ5X02R6imwZBi2i4RDgO1o1jBBh2HB5WluIgdz0SSOfW6Rcy/c/AIBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RS8nOKry; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad574992fcaso268377266b.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750974748; x=1751579548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4EOGhOVtZpu1+I81Bw9O6YPAIIo6c7BjJB19u4vYOU=;
        b=RS8nOKryO49191QYr55RVcn0Z5Ta7B7r5CBS2ZupNWN5wdwq2NTiIFDlsKgtyejEwG
         nHk3tLTG3PMMxTPkkmFqXioP+q1CiuKlx7PstcUAMDGujDwMXlbBQdCYwbAwbwYBySLc
         EtXqUSQiO2y/0VCCRDqMJau63DNd+MXg6FZ8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750974748; x=1751579548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4EOGhOVtZpu1+I81Bw9O6YPAIIo6c7BjJB19u4vYOU=;
        b=bN9qxpTRLeUt2GkLrmLd0mN6nlAipEG7d1RD0d64Jb+MO4Py66yKwPWUPoe0ojiC0i
         4onA36ZFSKsKGncOOeUu6Crz1Wmi7JBeDM0tUA/QO5df5Goku7RbRbmkTTLTPhKNc2t1
         QnGOK0tbLHSHvnJ1Z6ihjx5JGcAx2eyL4FnEKTMsyKq3/+UcxJr27WqlrDuroBxhVo2P
         rV7rben8Kws5GGpKGf+N+ySsTwWJ1G+MUIO+fwaW5DuED9g0ypl3qm+xRsAJtfgc344Q
         offVVXLmaAZonrSI0fUc60PVpqmRlydaWBeQRA80N6Z9fX76kvL5jotS31ZF9FbxbMa/
         eWdg==
X-Forwarded-Encrypted: i=1; AJvYcCWzUt4jEQF5ChT7gRigE1TFvx7CInhB+1IKJDyqR5ZIQjYNZNv8ketuqsKMobSiYQHmjeeW5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdywuvzpzcGzorRGP8xsJPPk1z7Y8+q7CYSpZLEt0oO20oy0WI
	PAtWriF0VsB4Fk9taJDOXw7VrRwgulY+ilKqv+6Qh2oQnKQeL6H4h8tewBwFQ7tXvtDmbLSs/51
	Gm2vz4Zol3d0DjLzA4zRAdxwMk7Il6crDG3+9W0yFOJN6ACI5xwY=
X-Gm-Gg: ASbGncujEIAFA6FGP4DYn4mUy5YPvy1slY2J0qfvoywTDC3RSmK7z0jiZaitucudeB5
	8RM6sWpQETNqtAD6JtY0TVpwnHSWkLnIwlugQIOPgrgIgW+mAJiXtPbJBgC22m4T9wsqFNdapKa
	y9OAPqigG4XPcKUtmcgG+IcrfaqpXvvoD1EXd4q6AvImh1
X-Google-Smtp-Source: AGHT+IHazgAMAHqCHyEjnxdwya3DLbz1AxKVtLuSOn/5x/aBW0pfye2ONs4kcLi9gdIgl/TLKCpMQYJg0Lf0gli5G3g=
X-Received: by 2002:a17:907:9443:b0:ae3:4f71:90f8 with SMTP id
 a640c23a62f3a-ae34fda2893mr67534766b.21.1750974748502; Thu, 26 Jun 2025
 14:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626165441.4125047-1-kuba@kernel.org>
In-Reply-To: <20250626165441.4125047-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 26 Jun 2025 14:52:17 -0700
X-Gm-Features: Ac12FXzyPJLWTaIhKtmX2etHRlQ63gXRP5vmFO88Od033YBKyUFNLL9g1lCAZYE
Message-ID: <CACKFLin2y=Y1s3ge8kfdi-qHGfoQr9S3BwOUCSKTCu6q8Y6D1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: take page size into account for page
 pool recycling rings
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	pavan.chebbi@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eb25f5063880934e"

--000000000000eb25f5063880934e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The Rx rings are filled with Rx buffers. Which are supposed to fit
> packet headers (or MTU if HW-GRO is disabled). The aggregation buffers
> are filled with "device pages". Adjust the sizes of the page pool
> recycling ring appropriately, based on ratio of the size of the
> buffer on given ring vs system page size. Otherwise on a system
> with 64kB pages we end up with >700MB of memory sitting in every
> single page pool cache.
>
> Correct the size calculation for the head_pool. Since the buffers
> there are always small I'm pretty sure I meant to cap the size
> at 1k, rather than make it the lowest possible size. With 64k pages
> 1k cache with a 1k ring is 64x larger than we need.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> CC: pavan.chebbi@broadcom.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index c5026fa7e6e6..1c6a3ebcda16 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3807,12 +3807,14 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *b=
p,
>                                    struct bnxt_rx_ring_info *rxr,
>                                    int numa_node)
>  {
> +       const unsigned int agg_size_fac =3D PAGE_SIZE / BNXT_RX_PAGE_SIZE=
;
> +       const unsigned int rx_size_fac =3D PAGE_SIZE / SZ_4K;
>         struct page_pool_params pp =3D { 0 };
>         struct page_pool *pool;
>
> -       pp.pool_size =3D bp->rx_agg_ring_size;
> +       pp.pool_size =3D bp->rx_agg_ring_size / agg_size_fac;

The bp->rx_agg_ring_size has already taken the system PAGE_SIZE into
consideration to some extent in bnxt_set_ring_params().  The
jumbo_factor and agg_factor will be smaller when PAGE_SIZE is larger.
Will this overcompensate?

--000000000000eb25f5063880934e
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOriAe6HYJAkpmx9YER5C/sR5vlAhqF1
TOcEg6EYytlCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYy
NjIxNTIyOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAJLavdyMRGEQdTb3UKduNEM2krdZcKW13il3PO2gHp1f1vaAqhwu7MOn6mWO4Z3cJPUi
CTnNaFJSPzo59MzgGSy+x/PR2RxYmFblmK9P6FS7IIKOH/OXbF3wrAqKQluX+KAc82LV8irbjyTm
gO1g9U8ng3iTJU2eY+zMNNI7aKRR2vebfm62Db+gJPj3LITjRSDzqyJqU0j2bUEFcFyUkSkpidHc
mXtYVvbX+Bf20zRlvGrPadvgsy0qktrFiOrZ016OMr0b4vbjWMAYZmT2CxfN237BBUA0NIuH0dUJ
2KlcNKUUjXDin5GB2+7c3aCTPd/swld3w8upTT020L7pg1Y=
--000000000000eb25f5063880934e--

