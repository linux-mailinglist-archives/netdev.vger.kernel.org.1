Return-Path: <netdev+bounces-180541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104ECA819E7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A220421472
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794612A1C9;
	Wed,  9 Apr 2025 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G7LOa6Jv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684EAD5E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158920; cv=none; b=DCK6Qd/R8EpN75r4vQOe/rP92TFXScr5CieVaDyhO9f/mbfX+hr4Df2b99YG9H8wc1aaXIaBJtuKobq91QMjENSyjvZZcwz0AkPstuF9rCV+jY5MTKs0cutKa3//BWCTrAZksY/uRoddON9nVkkU9xocR0SmU4AIxt50cN0YlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158920; c=relaxed/simple;
	bh=mRJyzO8HR+KYF1YgBUd4Ms170j4GEAisNE1tw+lkWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpHeOQH92j32Wyh6D+lpGTfM0LPnpfv7TCTHZoMG4jfSoWAAyP0swoKgKmWosEWS19cIwcm5Qbyg0kr9hhd1gIeV6ZJQOCprHYBqt9/6LcW33SyCw2IrHA9BP1QQYIxCQ9qHloKHcPh3EUWtmo9fmmbfxlNhnQ3+nQq9KaYHJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G7LOa6Jv; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6e2a303569so3425542276.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744158917; x=1744763717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hYBW0jrMvEvGUc9pGBkM0IAgP1rWMhgEr5XlSl12OYo=;
        b=G7LOa6Jvqvlskytlwjo/mxeOXK8PFUSolYIlc2d2UcuAKURJssY3f/7silYKy9t+ZA
         pj+jwpAbk+axTWke6T3yUvVsiTa+Q40+YYO92gN4gHZbHdzhYKwDzkukp3xXyqisRfyQ
         OOO0S2r/FtOnrUYAdk7YoPhJey0B0MxFle2Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744158917; x=1744763717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYBW0jrMvEvGUc9pGBkM0IAgP1rWMhgEr5XlSl12OYo=;
        b=DxTfHb+R5yy2lq1dBHGsScsq0ps95JvrfY/YdRp+Y6PLk+Bk2hnKYN2rm8fyUb5E6S
         ZUhNxJe3wN5ua1/z7wVyndZ1ADchtuCn8ldeWGvF0djgkVwneXkbf1bdJ7tlzUGhmEP9
         +CgY6dTPQhn1AqwusJeb79/1vkcv0gTfTNdfjtr2IVpcbGh/WJq6OhWFV8jw5kCxABdC
         63/qM9EfKaZU1fbR4LV7/QXO8DH5bcQC1ZphMkGfjeUK5vnjXEQK9QVFNni+qN4vpRcW
         1OvEe3+04sk0oP9FN07ImvThXekzJIoaCySkjEoF2VTh6YBMQhTpxNFaSvO79eAY1BoR
         L65Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX0Manli/JBirJ6q/7dlngvY33lRNIfHEnCIcRh7t3egYtxSREozfV0nqmUHb2nwUZGIoKORE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH24EQ96DMOFKczBmWHkZFD6T7rnO9QP0lCLVFs7W0gtT0cV/Y
	DhANn/eJvZ1zrteZUxWl3rVjZS9MN78JmATMbRi+/+x8kLs0WT+ZDNjFlx+xn6rwcJ06JR+/JlT
	vj5V+KUmxMBAUsZUKkWFfW8DoxCXQq7HnT9DC
X-Gm-Gg: ASbGncsbTA9HGvj+4FhSrxR0qvyU2TsDS2yj5SSJc9O5+SyZoG41DfFSh9IcRptNKbv
	YvtXDLuozeFBikadStKwbn3EjKQMAXg/TSeku1xkaCrW1sKdUxruaA4N+ISEXV9KMaz3UCjwV+2
	sA3BWQh5NxMQV2iH7I8heDUWTd+j0=
X-Google-Smtp-Source: AGHT+IG0JikKoKz9r4WoCdDK+DKqKrLTmDWcgE5G62sEGZhRaArPAwf+e1PLjjoiNEptWc8DtLVtfE++zgh3Yvf+VZA=
X-Received: by 2002:a05:6902:2183:b0:e6d:d7d8:7fc2 with SMTP id
 3f1490d57ef6-e702f0d444dmr1762636276.45.1744158917618; Tue, 08 Apr 2025
 17:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408043545.2179381-1-ap420073@gmail.com>
In-Reply-To: <20250408043545.2179381-1-ap420073@gmail.com>
From: Hongguang Gao <hongguang.gao@broadcom.com>
Date: Tue, 8 Apr 2025 17:35:05 -0700
X-Gm-Features: ATxdqUG-zxEKRQcLUKKEVvkd5sbzQc1pNPS5aN8zcblIMrQBYpJNokqGZE-qExY
Message-ID: <CADYv5ecv3iz=B_Lve-0oK273a79Qqa=Eh08kbfhBHLFXDgotSw@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory TCP
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, netdev@vger.kernel.org, dw@davidwei.uk, 
	kuniyu@amazon.com, sdf@fomichev.me, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bb459e06324da4eb"

--000000000000bb459e06324da4eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:36=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> Currently, bnxt_en driver satisfies the requirements of the Device
> memory TCP, which is HDS.
> So, it implements rx-side Device memory TCP for bnxt_en driver.
> It requires only converting the page API to netmem API.
> `struct page` of agg rings are changed to `netmem_ref netmem` and
> corresponding functions are changed to a variant of netmem API.
>
> It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> page_pool.
> The netmem will be activated only when a user requests devmem TCP.
>
> When netmem is activated, received data is unreadable and netmem is
> disabled, received data is readable.
> But drivers don't need to handle both cases because netmem core API will
> handle it properly.
> So, using proper netmem API is enough for drivers.
>
> Device memory TCP can be tested with
> tools/testing/selftests/drivers/net/hw/ncdevmem.
> This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> 232.1.132.8.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Hi Taehee,
Thanks for submitting the patch. Overall it looks good to me.  Please see
2 minor comments below.

I'm also in progress to test this patch, not finished yet.


> @@ -3777,15 +3811,20 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *b=
p,
>         pp.dev =3D &bp->pdev->dev;
>         pp.dma_dir =3D bp->rx_dir;
>         pp.max_len =3D PAGE_SIZE;
> -       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +       pp.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> +                  PP_FLAG_ALLOW_UNREADABLE_NETMEM;
> +       pp.queue_idx =3D rxr->bnapi->index;
> +       pp.order =3D 0;

Nit, set pp.order to 0 is not needed. The whole struct was initialized
to 0 already.


> @@ -15766,7 +15808,7 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         xdp_rxq_info_unreg(&clone->xdp_rxq);
>  err_page_pool_destroy:
>         page_pool_destroy(clone->page_pool);
> -       if (bnxt_separate_head_pool())
> +       if (bnxt_separate_head_pool(rxr))

Should be:
        if (bnxt_separate_head_pool(clone))

Thanks,
-Hongguang

--000000000000bb459e06324da4eb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mULU8ZK3Tl7crejhU/ck3WrbUYKADGSTXn3GidVz2A146H621l3QV6yiokkLGZgKWrMdhTkAa1sp
6gPzprBwQBG2PSUZESRSSZBnOrEv67WUGjMQ2xKFl5QtV45AJsjwPv347WWEeRdwKKYqej+92zBW
Cy2bw1PMazGOtjTrXONkd2Hl91SPFtxzSmLmm/5ym8rztHNPjSbr3KD7AgMBAAGjggHbMIIB1zAO
BgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUF
BzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0g
BF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEW
Jmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0f
BDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMu
Y3JsMCUGA1UdEQQeMByBGmhvbmdndWFuZy5nYW9AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSKHph2Val8
0poL1cCemsH9smPYlDANBgkqhkiG9w0BAQsFAAOCAgEAWutujvKFZAVdJRrHwNB7y7c6pdfqz8hW
gZKnOKTC7pLuaklYzo0gm3t0PefLSnJoHpG8Ne72rWQbbjphkq2sPItB9EkI7MN8NWJT0NFb4d9p
7FMPidn81rqWfgCyUm0ZnxQ5kUvb0rEl6AtGWu1QeAtOQ2Yb5ywmBeoNbTfMRh5PiUWLw5yIc8jV
9ncHJbql0kO/qtVpGdYpQAs1BC0IM+5o59vCfhaRkIUKKOaEvD9R1qTbBLji0FqQ8H+B3hXl/Y0+
ZSyzTSXi17Fnzm0Zd2qiPL+5za87WYxVTXjMnvoUmSlLpkQlObVj9ygIWTX/emdVrksC5y9PiFmy
c61l4H8fP7UNtl512FH4ifkOIC0BVhh0YYumIoxnWQCxHLDNh2zrUOr84JdYonX//0gw9MXIoGJT
5m6UYttJzkZTm9pp2iVevd2tyOZnAGTGEztuVUuAR7f2lwC/7zbZc0e/hZte4WAWUFqv2fVkdNPW
woMhJ8FueSq8+KYzgFzJQoL2HaU04lr3QkRddLuvFrLhKu9hhR0A3KLpiQyZUFHCBcCxr/CtqZXt
js4a/l8yVFoVdTFTKggp3F8g/azSQwnJ9YabyIODwzEcgwP7OJqTNME23ruqveoJiLMzC6q0gH06
oJRbQELZ/hpso63dwEFbXOrxArN8O6bHUeWJlQdSKD0xggJXMIICUwIBATBiMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzAgwcZO9cF1vgOQ35XQYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEIOyr1HXG155jwFwc5yCaXVsWZmvUIeCJUGfBnyq20haDMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQwOTAwMzUxN1owXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJurkH/tMOwC1rwaQTrOybIxRVHd
+XYhGAtQPqXj0aOp5FSepJFt3NVVr0jRUtBoZAen/gCNP1nGQCZsFmFmvh5x3EGBWnAP6lLkNXcz
Pbpie/t91wz/HHY1vHsydmIaYcEdS0mmMEW06oJLzJtKbp1O7E6LYbozP6XU6Fa8HXv4Q4lmKSt+
7Wfq63obOZjZgFdXeROIRwqgn9+4hgunZmukV1fSJ+RUmYhBuCqAB243EsNqsWxeIPb4xL+KQaTY
HQoqht9q7a/Jfq1d07ZEbFfhfdlZAHa0swMxU3MUP7kVEGY7zHnw38oAA5W/dVE51G54dcvf0Nj6
Cerdxhd0sic=
--000000000000bb459e06324da4eb--

