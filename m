Return-Path: <netdev+bounces-45839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99547DFE76
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 04:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F241C20DD8
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A515B6;
	Fri,  3 Nov 2023 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EbXOK7Wz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3967E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 03:48:58 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A401A196
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 20:48:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so1778611b3a.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698983333; x=1699588133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wHapStzyo5bcpl/cD9B7p5ZPQDUX0ELpuSAYDKPQZF4=;
        b=EbXOK7WzfCpi/2dmsCEsUTA60fEak4GtBt3LmXVBWC+QPqVZFmsE0zDvQ+I8Wc8yA9
         o1BaEDRtoL9BtRQw+emtRRl8sprCB0bCydFRw9yREWICF6+7nY5PSyTEcc9b2/NxxzjH
         KHpUl9FpLC3rqsv1d8hPdZWh4HCoOfFBvPk2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698983333; x=1699588133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHapStzyo5bcpl/cD9B7p5ZPQDUX0ELpuSAYDKPQZF4=;
        b=oHKgLYbkuoiZi8+knJgeKjVG7SgHP1dI7Hg5TPhyaVvw9FzKpT5dUytVZb0usLceal
         CF/DQROK9LVvNViMKEvTSJDNz4EsZ64asOEptlGz62/QQo5lmMOcgrW4/ZnPU+6t5v1j
         tMkfM/2UzKGkB2MjoAVPuif5Jm6v/qGLF5q5hlSV7W2JO+LSuA2IG2/DLzaXzyDZWkjE
         yeM2GdcutFPa0nXsYlmUoR2M2outX11Jmw+DEZMlXBhbAJunCO5LzFiOEzAUkn3HW5Ya
         NHxyzEb+ZBOrdHGoq7hoG9PNjdb+heSftw4tJBpcYlTh2IgasQf2DYVuC5ib81LhpDfU
         6sAg==
X-Gm-Message-State: AOJu0Yz43V0EexhAJ0NlbqABn1A3rBpknG6h6pWVQOi+XNec2yZ1v/6X
	QeJZIJNS+mX8gUP29k1sfJYoxE8760sRsqRIECbWPN/CBsQf9klwdjWVLw==
X-Google-Smtp-Source: AGHT+IGZEU8quetx5FsHiopNj4X98qnvlIQzDCU5CPLQQkuLJPk1zZdK+VvrtIlkz2deSvPQLBMmyGKmHHNDBt9FA18=
X-Received: by 2002:a05:6a20:7f93:b0:181:5480:d400 with SMTP id
 d19-20020a056a207f9300b001815480d400mr7937208pzj.12.1698983333029; Thu, 02
 Nov 2023 20:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101130418.44164-1-george.shuklin@gmail.com>
 <CALs4sv37sniGKkYADvHwwMjFzp5tBbBnpfOnyK-peM=rnp63Bw@mail.gmail.com>
 <31a5cfe8-133d-4548-9814-cf3e61d89307@gmail.com> <CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1tGP0OPJg@mail.gmail.com>
 <5c778d51-ec87-4e74-9fd6-63dc4a9ae2a6@gmail.com> <CALs4sv3pGsNFQeZstmioiTxjhMu6HJm9_ES1u4_sbTZKrztrDQ@mail.gmail.com>
 <CACKFLi=0eRFGfGXBihLKwZaifKJAVWR5tK9HM82pyjDNA2r7pw@mail.gmail.com>
In-Reply-To: <CACKFLi=0eRFGfGXBihLKwZaifKJAVWR5tK9HM82pyjDNA2r7pw@mail.gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 3 Nov 2023 09:18:36 +0530
Message-ID: <CALs4sv3BTPo-FxNfJJwtNYoMti45sai3VonhKC9Cyp9khJegwQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH net] tg3: power down device only on SYSTEM_POWER_OFF
To: Michael Chan <michael.chan@broadcom.com>
Cc: George Shuklin <george.shuklin@gmail.com>, netdev@vger.kernel.org, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000011837f0609376290"

--00000000000011837f0609376290
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 11:19=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Thu, Nov 2, 2023 at 10:11=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadc=
om.com> wrote:
> >
> > On Thu, Nov 2, 2023 at 7:44=E2=80=AFPM George Shuklin <george.shuklin@g=
mail.com> wrote:
> > >
> > > I'm right now with dell support, and what they asked is to 'try this =
on
> > > supported distros', which at newest are 5.15. I'll try to bypass thei=
r
> > > L1 with Ubuntu + HWE to get to 6+ versions...
> > >
> > > I was able to reproduce hanging at reboot there (without ACPI message=
s),
> > > and patching helps there too.
> > >
> > OK. I am not too sure what we should do. The change as such looks fine =
to me.
> > Of course, the patch needs proper tags (tree.fixes, cc ...)
> >
> > @Michael : Do you have any suggestions on this?
>
> I think that this logic:
>
> if (system_state =3D=3D SYSTEM_POWER_OFF)
>         tg3_power_down(tp);
>
> is correct in the shutdown method.  Many other drivers do the same
> thing.  tg3_power_down() is just to enable WoL if it should be enabled
> and to put the device in D3hot state.
>
> The original commit to change this (2ca1c94ce0b6 tg3: Disable tg3
> device on system reboot to avoid triggering AER) claims that calling
> tg3_power_down() unconditionally is to avoid getting spurious MSI.
> But the dev_close() call in tg3_shutdown() should have shut everything
> down including MSI.  So I don't think it is necessary to call
> tg3_power_down() unconditionally.

Agree. So let us have this change in. George, can you pls spin a v2
with proper tagging/addressing done to the patch.
Please see https://docs.kernel.org/process/submitting-patches.html for
help. Thanks.

--00000000000011837f0609376290
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOWIVdtxSzqrgz6G3Fim8RrZI7UeEbXj
2tjLfP+HaeCcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
MzAzNDg1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBUYMioRPERS7QQqSryGWOO9l+y5OOS7DyVcsy2pHbJmRdYD8GY
K2TDi0dXWqu0j7CoJoXT7kSupIWCXvb86LASLKq0NDNbru1asv0FajR3bOs88nxk/M4z6t6S7uk0
S9zAaovEqQ/W6JGbLDxnWQGHNoYCmTlLKbmTgSn7CPEQtg5Si6Qa60CC5e20cryj/NhoFfYth5O+
0f+BxA0sOCRhzaK9xi6N3K9ZlnWySR7NKE3rZBKfw5efEoVeoA0G4AjwsUGh90QVqYAWa+5z0//8
SdolMh3XPH6wuFYMK/3i8ImvXy+32ELz5x1BAQReoXmc9HSzc9oJpwkfi7oVYNTW
--00000000000011837f0609376290--

