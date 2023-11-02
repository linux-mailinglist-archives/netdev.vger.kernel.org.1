Return-Path: <netdev+bounces-45776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F27DF865
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8E3281310
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDD1DFC0;
	Thu,  2 Nov 2023 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JRIFfk8U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2479FE
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 17:11:28 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803B196
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:11:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b999980689so879809a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698945080; x=1699549880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuxumWnr30rAsXzgPWFwlxyXg8F9wBQLNznMhgquZ/k=;
        b=JRIFfk8UotQt3w6kB/danyAp6Q5ixtb0njG+a2yRF6ne1khbyKYCdJWmqXARYi1okN
         LTGotOhEjiPz+s82RfbyJpt1Dq6e0tZr9N1F8Urq7JlQ1Qcw/lDZt6AaCh4UF9bmcmOw
         EPPxsYGwIwwHyk1JDt8CbctSiAvVSKoLHOH4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945080; x=1699549880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuxumWnr30rAsXzgPWFwlxyXg8F9wBQLNznMhgquZ/k=;
        b=je2MN/5d2rDFLNs6/1XRfj7wnL1HX5XjOHxEBe6uv31RJRzcGxOOqLc3pO9GpgjYcc
         pbwX8InY9Xfpv4hNyJ8U1LDNZ/xNSL1skELLiqCfe4mcTlE7znKiOT5f4I5CPi5+y2eh
         bo+J+923I+YiN2wZU+hugBB0OD+mBh96XAz7kTL4mO4+wc7asObxQ/1VxAdTzwtqmtbN
         jaK4RFBOrXYWgzud0kHHbrIeKlhGqJh4+EZTy6lJmY3ELyBT6nLq/tnqfuUKehpVrT6c
         XKv8zDFixYIBui1sBlxuLby0icwgZGHz1EbWg9GYPJmBIVUspGWR882F3lbxcte0+NeP
         aXew==
X-Gm-Message-State: AOJu0YxfwX1KRykuU6NXSua+qGGev/4HtosjX2WyhqEOWHWk2mkLk9lA
	aP+AV1KO+ts1Dc62rjvf+Cuy9ezqu6uMlPuduSGsBw==
X-Google-Smtp-Source: AGHT+IELpznnBpBK3nOxF7mKYYrFFUQ4EWBbohkEnkXfQwc7RGQDHxv7oJsJtaiHSqnIQXEm4nKl3NqpsYSaQJ5UbdU=
X-Received: by 2002:a05:6a21:3398:b0:181:a8ed:4898 with SMTP id
 yy24-20020a056a21339800b00181a8ed4898mr1704173pzb.38.1698945079908; Thu, 02
 Nov 2023 10:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101130418.44164-1-george.shuklin@gmail.com>
 <CALs4sv37sniGKkYADvHwwMjFzp5tBbBnpfOnyK-peM=rnp63Bw@mail.gmail.com>
 <31a5cfe8-133d-4548-9814-cf3e61d89307@gmail.com> <CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1tGP0OPJg@mail.gmail.com>
 <5c778d51-ec87-4e74-9fd6-63dc4a9ae2a6@gmail.com>
In-Reply-To: <5c778d51-ec87-4e74-9fd6-63dc4a9ae2a6@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 2 Nov 2023 22:41:07 +0530
Message-ID: <CALs4sv3pGsNFQeZstmioiTxjhMu6HJm9_ES1u4_sbTZKrztrDQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH net] tg3: power down device only on SYSTEM_POWER_OFF
To: George Shuklin <george.shuklin@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Gospodarek <andrew.gospodarek@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000002b6e906092e7ab1"

--00000000000002b6e906092e7ab1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:44=E2=80=AFPM George Shuklin <george.shuklin@gmail=
.com> wrote:
>
> On 11/2/23 09:04, Pavan Chebbi wrote:
> > On Thu, Nov 2, 2023 at 1:28=E2=80=AFAM George Shuklin <george.shuklin@g=
mail.com> wrote:
> >> On 01/11/2023 17:20, Pavan Chebbi wrote:
> >>> On Wed, Nov 1, 2023 at 6:34=E2=80=AFPM George Shuklin <george.shuklin=
@gmail.com> wrote:
> >>>> Dell R650xs servers hangs if tg3 driver calls tg3_power_down.
> >>>>
> >>>> This happens only if network adapters (BCM5720 for R650xs) were
> >>>> initialized using SNP (e.g. by booting ipxe.efi).
> >>>>
> >>>> This is partial revert of commit 2ca1c94ce0b.
> >>>>
> >>>> The actual problem is on Dell side, but this fix allow servers
> >>>> to come back alive after reboot.
> >>> How are you sure that the problem solved by 2ca1c94ce0b is not
> >>> reintroduced with this change?
> >> I contacted the author of original patch, no reply yet (1st day). Also=
,
> >> I tested it on few generations of available Dell servers (R330, R340,
> >> R350 and R650sx, for which this fix should help). It does produce log
> >> message from
> >> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1917471, but, at
> >> least, it reboots without issues.
> >>
> >> Actually, original patch is regression: 5.19 rebooting just fine, 6.0
> >> start to hang. I also reported it to dell support forum, but I'm not
> >> sure if they pick it up or not.
> >>
> >> What would be the proper course of actions for such problem (outside o=
f
> >> fixing UEFI SNP, for which I don't have access to sources)?
> >>
> > Thanks for the explanation. I am not sure if we should make this
> > change unless we are 100pc sure that this patch won't cause
> > regression.
> > I feel Dell is in the best position to debug this and they can even
> > contact Broadcom if they see any problem in UEFI.
>
> I'm right now with dell support, and what they asked is to 'try this on
> supported distros', which at newest are 5.15. I'll try to bypass their
> L1 with Ubuntu + HWE to get to 6+ versions...
>
> I was able to reproduce hanging at reboot there (without ACPI messages),
> and patching helps there too.
>
OK. I am not too sure what we should do. The change as such looks fine to m=
e.
Of course, the patch needs proper tags (tree.fixes, cc ...)

@Michael : Do you have any suggestions on this?

--00000000000002b6e906092e7ab1
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPMWwcoxjFJyLSEqPbjnhPun9URWnDFC
Wldh/yrUqTWkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
MjE3MTEyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAMWC+9v/Fz4raR0DYN0YUviqSV1vrbV6JfbW66JhVtNc4Jn56c
WRqFWKDvhfsfpbmMm5c3IG9RyNm6JMk9JXKyLIPYQtEN5InU4fgkFtflGMikQtUayZ/rbAkV4+QO
tnhnosY9UCemJ/TJinp7tYtNrZ/fqdqtPLRAkMWC4iTaoYO0CfX7Bi1/w+3nQYBFmCsoUhumDT28
lEJeNqFh4ZUdx524rRBddO6rlzOgBkTgk7L48awnR3PtdoHYKAquYAxBXrisAu30Q+Hq3izagmlL
1C977vu++5BNvTM4qDl/WfyazNM0u4EHrXQ49TDaMVVbQfP0li6zuW+i4yZL4eBR
--00000000000002b6e906092e7ab1--

