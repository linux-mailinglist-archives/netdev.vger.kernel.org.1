Return-Path: <netdev+bounces-216386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC93B3363B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0484B1B21AA0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DBA27A129;
	Mon, 25 Aug 2025 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PXigMWz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697326CE35
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102196; cv=none; b=o8m87gLJ5I4UIHnFT1AX34SguV9XFFZvlc4JjDfwOlRpoGyLzgGMlJ2KbmCh1u6HlktfpbyYOTFcz+RG6n1oWATk3PG8Fr8Sn/hO9+nSWmL4Cw+HAIzhxbLYudKq5air+3VkiNa2KoQFjykZhjPIutz8AxqjF82N4eFOCY1wWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102196; c=relaxed/simple;
	bh=dBOBNHuSG/hyKdZdDViU7AMj4QDE08syKg2DA2DO1Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEc6YoBhMV2l2ScJMjdPiDqvOD/vyzqSd0I/OvMT5jFx9g4Lh8bVR5XtODvvDM6/IA/FIsFQ0XDgOD/OvliT8TT4HooLvhhzDCerFuF/I+VuqcRqUfONFpwUDBg/Aj5egAcGvcgfVVbiyjkekJah4yFTNEYe58CKvU3qDGWVVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PXigMWz2; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso1484181a91.2
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 23:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756102194; x=1756706994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNUMM2a5VUgs6R0p7IuVvJENrqgxZmsJDbNSWjyPw4E=;
        b=KCq56r0HctKcGpZX4OzQZhmiEaFBOM2PfjVxcrdUKMDljSn57xy5Uqd+DJcDXiX3KX
         OooQbuivd/dHHGSwdsGehXDWFVoOgHveBiXdA6dWCz6jiByjc7A4S3rEcWW33FVudcCa
         9sjCIIF+hN3leIE1jrSnl0Yc3xWnq3IYgTBvzXdtdp3kgR4NMHAIvn7s0mmO2EeNaaVm
         guDLitbwBUnVPEXkbeoRn8ElWF5O8GzwkmZtnI02tKwGOw4F5hzxWaEsMTaOOdkDRMvM
         DQGUmrS4NTlk8JpIOQAaxt72ar5hWAGEO1QhPOZ9QYL5DCRfMri9EySZ19MKgQCTMHmY
         UF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHnWdlJJD0RMqEG1OKn9c3N9VIUFqVhJVNAS07UcHgnvxBCYyZMiqju2QPiuLsvII4iHkEHsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLunqlm4Z0jO9AfE4KRr+/KHLQEOhGJf84R2c1FAj1ZOGbOIS
	2mbealc07Z0kYaqBeuwX6NsnBNWdbJ/aBLstF8WVo4x3B38+sowaWu98kLEE48MfTa9RbUM9Jf/
	0T55NiYo0Ynqfo2C7nstAQwitxbL7VeRKHvqfZmI8MydNdy5uDCaoyEcSpSu2ac0gGpvztP3yOE
	xOz8Q8E7iW0+URJEx5wYJgOeKIff1DhUwfKJD885ZzG5meJYLW6TB0AzcX7WpZLTl2Nj21kPlzX
	X3NGFHOpdRf
X-Gm-Gg: ASbGnctvHAyZH8OUyNADUas7KuxdQaV0OqRHgaHOoSCBJkhiVCaQr2ZRV2fOqyTzgHc
	QNQ3YNla0hDy/E+ThApFbpLz4woL3HO0+DMR+FTsTGjJBHRFIcYIIP1NxWowkSUZELVi2f0zbHY
	aeQd/lw5EnkNJFsmIn9KczegQPul1UMKZk3O6BjC0ynTOPAxdnyA5DNMLW1GMoFSei8pDSIcJ33
	VIXKMK7dsUEHnkRXSBcj+xRj4+0FGEtODQ5EuNYhHakIhBcfpQaI3/1qc4jXjIV67LBymNQNgEx
	SeRbKR/Sng2obPTPe0gjNWLFWT9AQB9pms358QUB7UB60wd4o5lFNfCWsWEEUE54xGmUlaZ9YVU
	7E7ZLFr6BbOgO/4cYiG/YbGer+yj0O67OjSX9VMTQ/qnPiSMptBpeXqlVgqTOy4z8ak4sOKt0FQ
	3T
X-Google-Smtp-Source: AGHT+IFHMI32kHkd1M0lgxjpiJfPB18A8OnZBMQ3uP/EnKKJMw5FAXNKB3ZkNU/Lg8JVBFZdSmapZ6cko2Kj
X-Received: by 2002:a17:90b:3905:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-32518b82606mr16316835a91.37.1756102193698;
        Sun, 24 Aug 2025 23:09:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4c19ea7e57sm143276a12.1.2025.08.24.23.09.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Aug 2025 23:09:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-89247460de9so2161935241.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 23:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756102192; x=1756706992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNUMM2a5VUgs6R0p7IuVvJENrqgxZmsJDbNSWjyPw4E=;
        b=PXigMWz2f5NGQcStMO74zTOfDqJjRr2kWi7pFEOlg/84fd9x+yle1RZb77it8aIrV5
         VFT98i5LJzFcMHuhH5GgmVDRgwUubqzi5CF8qZ/Tud/NZ6z8h4m5HVKW+rfm2fGsWTTN
         qYxcMj9vrLWlC5BLad7gDqrVbae8crrS3MDSw=
X-Forwarded-Encrypted: i=1; AJvYcCXAapaN0wzXTEoaV4Ke99SbqLXmNEes1xkbzPdZBUqR6zC8XqLbK23NTSivlUllwVTvMpWeU+E=@vger.kernel.org
X-Received: by 2002:a05:6102:d8f:b0:521:f2f5:e444 with SMTP id ada2fe7eead31-521f2f5edf1mr804236137.17.1756102192536;
        Sun, 24 Aug 2025 23:09:52 -0700 (PDT)
X-Received: by 2002:a05:6102:d8f:b0:521:f2f5:e444 with SMTP id
 ada2fe7eead31-521f2f5edf1mr804208137.17.1756102191412; Sun, 24 Aug 2025
 23:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <51c3dd0a3a8aab6175e2915d94f7f7aece8e74d3.1755499376.git.asml.silence@gmail.com>
 <CAHS8izOs_m9nzeqC5yXiW9c1etDug4NUoGowPzzPRbB4UFL_bQ@mail.gmail.com> <cbbb4ce9-146d-4491-afd5-7ba54e13a724@gmail.com>
In-Reply-To: <cbbb4ce9-146d-4491-afd5-7ba54e13a724@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 25 Aug 2025 11:39:40 +0530
X-Gm-Features: Ac12FXymBpvXdReacdIvOr9zcXAYp7QDBYxUUEE9KZUiM00MFwhxryUS5Z4LfZo
Message-ID: <CAOBf=mv_3pQtkGpRCjpcMqpkbd4KKRHN30xd83AMGJJ6gktiMw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/23] eth: bnxt: set page pool page order
 based on rx_page_size
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000064f2fe063d2a67b4"

--00000000000064f2fe063d2a67b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:23=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/19/25 20:43, Mina Almasry wrote:
> > On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> From: Jakub Kicinski <kuba@kernel.org>
> >>
> >> If user decides to increase the buffer size for agg ring
> >> we need to ask the page pool for higher order pages.
> >> There is no need to use larger pages for header frags,
> >> if user increase the size of agg ring buffers switch
> >> to separate header page automatically.
> >>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> [pavel: calculate adjust max_len]
> >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >> ---
> >>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c
> >> index 5307b33ea1c7..d3d9b72ef313 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> @@ -3824,11 +3824,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt=
 *bp,
> >>          pp.pool_size =3D bp->rx_agg_ring_size / agg_size_fac;
> >>          if (BNXT_RX_PAGE_MODE(bp))
> >>                  pp.pool_size +=3D bp->rx_ring_size / rx_size_fac;
> >> +
> >> +       pp.order =3D get_order(bp->rx_page_size);
> >>          pp.nid =3D numa_node;
> >>          pp.netdev =3D bp->dev;
> >>          pp.dev =3D &bp->pdev->dev;
> >>          pp.dma_dir =3D bp->rx_dir;
> >> -       pp.max_len =3D PAGE_SIZE;
> >> +       pp.max_len =3D PAGE_SIZE << pp.order;
> >
> > nit: I assume this could be `pp.max_len =3D bp->rx_ring_size;` if you
> > wanted, since bnxt is not actually using the full compound page in the
> > case that bp->rx_ring_size is not a power of 2. Though doesn't matter
> > much, either way:
>
> Yeah, thought it's cleaner to derive it from order in case
> sth about rx_page_size changes again and it was already
> overlooked once, and it's pow2 anyway
>
> --
> Pavel Begunkov
>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--00000000000064f2fe063d2a67b4
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
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHuctcoVFrpRh5htSAZTtRhN5Y0i
Gaq7gkco4cGkY6NcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDgyNTA2MDk1MlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAIj/Qq8nG9M15zt+s3OET/JXLYmsEDkt5/HUsaJ5rj9elDp6e++MFzwgTzk7aE9A
nzxa0dabeTyfnv8g3K7k5fnvcnljcTyeLia+jbuaxOL9OpHbP+AGjeGtYmfQg+8N0xfvElv6Jh5X
iVYuqh1QFFCkF9JoQdZJIehKvJ7iMmOSVai9W8B9J9IblYtZcg3LS3OFMqmagXLRMTZyx9EnouwE
MDxO4CnwvgA98oO4EzCAFiQCzzNSLorS2NkC6O2Ic2ePP32NbfWRqmWifmvH/kWMU5Xl3Ymhk1cT
BthNecwrz9tEL+EQPqzVbFLBplJ0OyfmDjl74b6n+8oIfzDycmE=
--00000000000064f2fe063d2a67b4--

