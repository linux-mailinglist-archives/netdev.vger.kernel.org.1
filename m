Return-Path: <netdev+bounces-158240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCCDA11344
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704051887A71
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21F20A5D2;
	Tue, 14 Jan 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KP6pnFwV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64953146590
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890977; cv=none; b=OaP3Q41/qbs7G/L4OXXmgil2BY14TDHUEx5MKxWN21AjtVQ0veM7/opTh+E2swqU7JESYKTAxOYwlfMbasmbnrFSFV5PH6Vd+8Op8HpocesQoA8A98T+cVGOv5DkY+NQ2IfP4kYDXZil+P17b+vqpIYGtZWGdhUe0NIjRmTVKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890977; c=relaxed/simple;
	bh=6AvUxuDd7HFYmEnmcynHxOXh3FwO/lsh2Uh+djCP3To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8aj3Si3jnUMAUQ04dPFgREuxOiorWUUmpneGIic4P0qwLG24gMbU6R5PXUW+vGKeMe8zJQrMUauqZPtxzDIf/bGwdP+C/MMZZ7frGz/MisdYj5oB0uHYDL2YElya26UMBR+Z9r4XqbJYOYmJDws5ftgZc7OThU4yscLob3Z2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KP6pnFwV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so10171270a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736890974; x=1737495774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pct5T3TbHh7yTZ34Hg8Mbq4R71BDZj1tD9UaEqdI9Wo=;
        b=KP6pnFwVztBo/5pPGbOrmV4NIPDyRHQXn4r2PKUjib6siJOt+Odn/ynogbwPKWTc8E
         onD0ffU3K5T9Vwhl+mORZ0az9X+1o0GZYVAqui5TgnJuStaaomhGo67HvQhRNrPCaPAF
         bv5W7MYcMSjS3OYvtmi3OruyToDBW57aND79s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736890974; x=1737495774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pct5T3TbHh7yTZ34Hg8Mbq4R71BDZj1tD9UaEqdI9Wo=;
        b=JZGAS+GlxI0tzZ0T8my5sKRIfrl92J0VIIO4KZaaie0Odf3Qs6cf+P+PIFjSMouHNd
         YEhAgxd2w0X5oj5kbllJZfdyNThVcCeFqHLLLik0XhdSlex725FhYlSTN24y4jf6lFOO
         uZvC8SVGNyUA2hqV9KybRMwmyc8GWYK25Q54MV42O9WeWmwFaGekTq2xm9UlQ0sXKLeH
         cTmmKvRD0FAjn1b+aNjue108YsJkdvnmlP81m9k/GRpiOHozZrAyzN8PAje3qnmqnLM1
         WxhXH1pek3sCIzL24lBR6TTPYtl7pQkXtu3A4btWww7J4jylXMMU/HdhvD9h4NzJ1L1M
         Hc7A==
X-Forwarded-Encrypted: i=1; AJvYcCVYHZEVdgn04XumMGsE3D42Yimlkvp8YE75qM0LNR0dxO4nEV5dS3j3eolx0vXLm6IEfB9XbbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZd54F36gUQSMp/vihwI3VwbUT3JzDmUBHVzXZNlOAFtIlf6Rc
	4Y6LucZDlWSpy3FsezPV/wA5aZ8ilHUFh73QL/FRt7Jg3A2ZREvPonFopQ6/LQ83RLacKC2CmWW
	zz3zdGX0V/djqrt37S+/sk+Uo+TF/x1QFAzz0
X-Gm-Gg: ASbGncsAEUNiZSq1upTV1cBbgk5JN8QJYaSi9Qo5pMdxcRDMcB5s5uz1zBhOwBrhael
	I5jQTbRpyZ0iYOLAzttI7O8y+fXOddupSq2Xc91I=
X-Google-Smtp-Source: AGHT+IE1UEU3G+adRgpoplunFVQCx6wgOJYhwtqn4J9YSM0dMbqqePbgrC+H1PKhW9HNQjWROMUcOwlO0iP3VxpfjBE=
X-Received: by 2002:a05:6402:4403:b0:5d0:e9de:5415 with SMTP id
 4fb4d7f45d1cf-5d972e08601mr23985964a12.14.1736890973748; Tue, 14 Jan 2025
 13:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-9-michael.chan@broadcom.com> <Z4TQK4pSFJd0y1Jd@mev-dev.igk.intel.com>
In-Reply-To: <Z4TQK4pSFJd0y1Jd@mev-dev.igk.intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 14 Jan 2025 13:42:42 -0800
X-Gm-Features: AbW1kvYY5dH50VLA4S3mtUj_73qNTW447PvyGkjew0SU76fgwyJ2HMhIU5lrhtM
Message-ID: <CACKFLimyogEMB4n9hJs2W+2=MB2iN3DWh1wXsfT9UWpzeKQqcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 08/10] bnxt_en: Reallocate Rx completion ring for
 TPH support
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	somnath.kotur@broadcom.com, David Wei <dw@davidwei.uk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000085da24062bb1711d"

--00000000000085da24062bb1711d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:38=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> On Sun, Jan 12, 2025 at 10:39:25PM -0800, Michael Chan wrote:
> > From: Somnath Kotur <somnath.kotur@broadcom.com>
> > @@ -15669,11 +15689,13 @@ static int bnxt_queue_stop(struct net_device =
*dev, void *qmem, int idx)
> >       cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> > -     rxr->rx_next_cons =3D 0;
> Unrelated?

This line is unneeded.  It gets overwritten by the clone during
queue_start().  We remove it since we are making related changes in
this function.  I'll add a comment about this in the Changelog.
Thanks.

>
> >       page_pool_disable_direct_recycling(rxr->page_pool);
> >       if (bnxt_separate_head_pool())
> >               page_pool_disable_direct_recycling(rxr->head_pool);
> >
> > +     bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
> > +     bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> > +
> >       memcpy(qmem, rxr, sizeof(*rxr));
> >       bnxt_init_rx_ring_struct(bp, qmem);
> >
>
> Rest looks fine:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

--00000000000085da24062bb1711d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILDPKr78MQMoxlSFgdC9ZzmfszhS22zk
zemWCfUValM7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
NDIxNDI1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBVPLzOWCfZSOw2FQHK5QZawfVtd9str9i3jHAl4nvGJjRln7eh
o1fla6i9F1H3OO2RGo0olGzNCCbCFjVtnZmQLLhXgBIUiWk40qVxXHMJYxPgNPXa3Ge9ZmK212my
bK9feCt1Npk2hL476r6w+SFrVw2SJlIdhKU1sAOYEj45SOxGveYupILqiEl2WlLiHLD49ZZi8yfE
sry+lx6Ztng5ow+a0jzxYZO/rUMxp0iEl7H/fgJX0YPGqbyC56vC3nl44vtVaMvlVx8lUnq3dTwr
vG25E8zCx6BPMQhu2Sk+wauPt5sO/cwhk3Dw0In8YyaUWARBfU07Gbm0jQhY1EFj
--00000000000085da24062bb1711d--

