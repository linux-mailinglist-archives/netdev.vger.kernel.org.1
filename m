Return-Path: <netdev+bounces-216987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B5B36FBC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4ED3B31E5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F772773F6;
	Tue, 26 Aug 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S+Dl8pgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939E31A569
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224751; cv=none; b=Bvm0W1VqAxb0wVNOledVfOAyk7/P94AiA3+hTCgphP3quz4xNvU0GpdmvdsUZIe35xikHnvZBpI7ao1qlx+6E6Gx/3nQ8OUOjQtPDdHOUWR2oYaWZdBEqwqGRTIbHKjcLuRpNb4qcPibqxQXRHtEFvuWmsXPr4qvAefMTfxBf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224751; c=relaxed/simple;
	bh=IFXtu7DyTHzZu9lv5ZR8zj1mOgB6S8QFYifY9uhoWK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ+09Kmf2lfvSvMxVQVZ1jYKlkM9stOeXVhP46F8Xnma11DE5CjaPm45fCGShEWLk8lfEcpb/hJBsTaSW3C9PdxJmaf8TcYpvncosDxGHvx64WuNai17jrotsQtSfcjBS6tP0MLWEvwCM+Ue/EHuz6xZoduE9y2p9b5gBA9UA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S+Dl8pgM; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-771eecebb09so2167138b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224749; x=1756829549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2WF1nXmPTckn36Fjl3rH1CQDxpfT0BomPnvGDxBvgyw=;
        b=iENLHcDXEsCBMsfom9ri66zs4BU3nZXHGLEoA5TKxflbxLRIUKtGkWZZxw9WWQCT1I
         mwT6njdjBnp2IaWE0LtlNnujJoPr0HQDrexmF5HcF4qpNzmil3YyO2GVoElRhQ8S0Ix/
         IQWqQ2QqX6NaE6wHffMQAwBNCL79qzvxRuCGaKd6p1JHFuG5XVMEz0IYgAXb1C6DlLRy
         G+4IpijwUDfMS8zkgAJqwpxRLZ8PG76PlR4xqNPcHj+TLA3W03NZPlpn5m6mR1zBMqBj
         jXvVi0ANGYt8pTLkIzy34qYgih8IP7zDGX7IIe7tBCwNVNB8Db3tusKeoDzxClEERfMp
         5YAw==
X-Forwarded-Encrypted: i=1; AJvYcCUwuxvvary4CRd7xToL6m8roDDWs2gfDi2Mb65sNPmpNGnAfUSDWL4ICKCCskt08cHPbeD15og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++qkxAWpfE/iUTqMP+XZbAgHcTKWgBqlqBUF4rBvf2Z4zAfs9
	SOSmOFLAp072MIM2lQdXtsLBNDdOe1tVxIHVG9oco71y+FJIqOJaf2kqux0vhkTQW8L2GS75ie/
	bmMftDh/zgncCPxwslXdfLqQhtweux1+Tc+vgMCNMTE41Ezz3uaPgGsElwCxGS8fav+XRJUrwz1
	FtST40FkjZsLBvYOOaOyevA0t5PzAY45XnUE4t/UEMLdNR9MsM8ieggjBz580ZMJhhmMcxDuRwx
	jw/brWZgKFb7YKONNyh
X-Gm-Gg: ASbGnctvkjR0tBmtACbQjvw9ZgIGdw4ee28rDj9z0lZL8HjBC0WSSzcKy4DsnxplfDS
	xHQLb6Zac3aruhC8BTAM/lr9ggr38qbhCCxePVf3sBdF9YS9t5ykBp7bfxDtbYG2CIk5lhkp4aL
	Lip27zdwqd20SvPtwArQuG+DO77KWI9aWg03Fg0X2Lj8MV3fUstjxs4qGNgn/xGmH3XVvKpe6L5
	FE9nbERk82YLNVM3JCXB9y7G28nV1COoVE/Evxn29swVvWnkb/d5cVdxHGwFliHl5/sAx7HwWe0
	Y1eiz6o7RD8iA4C9SCj3Y5Py2yYgzTaP13sjN+JsjZzioT1smqfQoEMkFuHg8gCmXE6/AbUAR9T
	UM69QGWqA22lQCVeLekkAEertBpJZP60ruESh+Q0KNDAkpWMmSnYY/hOiSQG92roP1CzTbT7+sd
	7J9TROHg==
X-Google-Smtp-Source: AGHT+IFbWx2e2S8Ob0Ga8C3qQ2lHP3kw2+egDSb48iWa/UBDW0CtpPswwYfPtD4NAP345ug/qNfylQPFGQE0
X-Received: by 2002:a17:902:da47:b0:246:cf6a:f009 with SMTP id d9443c01a7336-246cf6af466mr92608395ad.46.1756224749241;
        Tue, 26 Aug 2025 09:12:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32752fb99besm93147a91.9.2025.08.26.09.12.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:12:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-325e31cecd8so2144775a91.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756224747; x=1756829547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2WF1nXmPTckn36Fjl3rH1CQDxpfT0BomPnvGDxBvgyw=;
        b=S+Dl8pgMdRbXHO7NWorJ8esZKcJOhBeORb1ZofOQUn7vT/nT2YlQ9lFU8OHZiZT2OQ
         ckQY3O9iPFiARsWVEMG9sjIwXyDKFbS0VObSrjoVhTE3CZvph0/y8yplBa8VjFiTc+Mo
         JYRvuDByi055NdI1MevNsOzXjxNMcQc5MDMIQ=
X-Forwarded-Encrypted: i=1; AJvYcCWBUDd8eVKKfcfuIee57/LdqxZQbq/L3XbfK7UkKDW8oqz6L7HngfCpvCDuY09Vo3kvxiIXaqM=@vger.kernel.org
X-Received: by 2002:a17:90b:1d8a:b0:321:ca4b:f6cf with SMTP id 98e67ed59e1d1-32515ef1564mr19461556a91.35.1756224747261;
        Tue, 26 Aug 2025 09:12:27 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8a:b0:321:ca4b:f6cf with SMTP id
 98e67ed59e1d1-32515ef1564mr19461529a91.35.1756224746887; Tue, 26 Aug 2025
 09:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
 <20250826164412.220565-4-bhargava.marreddy@broadcom.com> <a4ad132d-ffb7-465d-b19a-4c5e0c0665fa@oracle.com>
In-Reply-To: <a4ad132d-ffb7-465d-b19a-4c5e0c0665fa@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 26 Aug 2025 21:42:10 +0530
X-Gm-Features: Ac12FXzqerVz7iI6d4FC_-NZmbbB-YF94XV5JZ2hKsaJ74_jQiDxEF2mfFdG5ng
Message-ID: <CANXQDtaM725=xtAPH_wK1y5WjTXz286u8gM_BRp1Ni+9Jx12DA@mail.gmail.com>
Subject: Re: [v4, net-next 3/9] bng_en: Introduce VNIC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003d009b063d46f09b"

--0000000000003d009b063d46f09b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:31=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 8/26/2025 10:14 PM, Bhargava Marreddy wrote:
> > +             /* Allocate rss table and hash key */
> > +             size =3D L1_CACHE_ALIGN(HW_HASH_INDEX_SIZE * sizeof(u16))=
;
> > +             size =3D L1_CACHE_ALIGN(BNGE_MAX_RSS_TABLE_SIZE);
> > +
> > +             vnic->rss_table_size =3D size + HW_HASH_KEY_SIZE;
> > +             vnic->rss_table =3D dma_alloc_coherent(bd->dev,
> > +                                                  vnic->rss_table_size=
,
> > +                                                  &vnic->rss_table_dma=
_addr,
> > +                                                  GFP_KERNEL);
>
> @size, first calculation is overwritten by the second.
Ack. I will fix it in v5.
>
> Thanks,
> Alok

--0000000000003d009b063d46f09b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWIwggRKoAMCAQICDH/Bh55Nn6Pe2/qMjjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4MzdaFw0yNTA5MTAwODE4MzdaMIGf
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xITAfBgNVBAMTGEJoYXJnYXZhIENoZW5uYSBNYXJyZWRkeTEt
MCsGCSqGSIb3DQEJARYeYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEApKt+sLxPSTFE+ruMyTpA8tU2ux9z4w711yS/nB4tbYArbQNC
KF9dH3b5h4X3Q6Fq9BLFbCWH7pJ/tEiQ7W19TQkQxiJbj1gdIzalTi4YFPMdTzD6/BaU8IELCGCs
Gjv4zuV2kN5uGAZ/K+WtRFRipB33fat/f0FWZ/FhdjAgTCTBrJ4nt7ENYOjNOZN4fjh78vjZqsul
Q+65ExyCjaRwqzdvCy5NQIZ78a6tvGl2Oj1lK7931edumLgCU6qbvk2FfhcD6tRp0xNL2jwL6Yn1
i2qNOdId5F0Uw9myUIwlW7Zg22U2c0Ce3GZggAfhiUwLYFfT2HXj+2kqrhLjK1T8qQIDAQABo4IB
3zCCAdswDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0
cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIw
MjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVy
c29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8E
QjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwLmNybDApBgNVHREEIjAggR5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0O
BBYEFFh9UQJiPboINUMOwOo9HGoA4rwXMA0GCSqGSIb3DQEBCwUAA4IBAQCx4SG9qg18y5lkgQ4d
aBLzpJdJ9WDhmZ44XpTLWPl1MfjO1slu0OOnDU5YVCMikelOWoIm8CK4bkTJtEj/byNXz/X4yJ0p
Gc6hcQ+sxONsIIJxJiNHbpbUaA/cnobVUgEfxvz1tIDMKsHYia+tKFdJ63yd9IXdtBwark1k/D+L
+dDHf0sRsASxceuhNMc+BAs4rNgE6dqAhyNJnd0jL7m0SiCjJsHYElWwYrVH73TUAWgxOFw9ow68
wsf9W+/wSEvI3N6OBMoRcIL34Z0xhrMZDHNOkYxArYhN5BraAmSU/obLBAbwbfEsOtHgFQpTtcHo
C+fgh5U7No8Z3dJYOsl0MYICYDCCAlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIg
Q0EgMjAyMAIMf8GHnk2fo97b+oyOMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCt
qgB3sAYiDf5W5SIZ9F67qq63a55GinpzpLGm4SWxOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA4MjYxNjEyMjdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAcwkaXY835vOz+9HdtgxxXZEJFT+zN0MSZcxX1
hwO6G7FTUsS7Bxa2mlvtgxUaauY4P8tUF0TeFRdHqMjSOH4UxyB0e2Dp7OPQgtqga3EAn5US+0I7
wsCbPILBXVZ+oaeio3ttWcMhqA7yDS/MDLE6O/J/5TTwpUFIyhDrre+UWJJJxKBS7jzVQ9ZFp/PB
HXrWoY2ExtBmPEDv0AXIVsXjemOyPRm/9pYKJIDcU85d6YdIXrNyaT5Ncg2vDREdt/8f0T9xXjhi
q/gPjhecs1n0IUcWP02QSShmYrjEhZKzeeWcySQSiZhhRHfvSAIBMt/cnP036hy0DpSFo5QV+wMy
--0000000000003d009b063d46f09b--

