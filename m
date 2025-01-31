Return-Path: <netdev+bounces-161724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E3A23938
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 06:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B37E1689C0
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 05:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B68249F;
	Fri, 31 Jan 2025 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VLkqDGxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9510C146A60
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738300141; cv=none; b=uTYItbSu04vEUWKqoDrL2FuxTp9fQaQHddexU/Ihjr3aWr0XiKMPUuNGVPFGr6kRWKcNRvKLKfYRT8h4vYKwBGFH/HdHziDkqGcJDNC+ItJByQ8J2AUz1wIWauuiHj9unyKULg+mXF5q8DYr1eOTNSvHAHybGjnLld92mAxFKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738300141; c=relaxed/simple;
	bh=Uc3N0Oq2DUCKUEJbk7llxLDBKyrh1B7lTmXuROjQxos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPFyLDFnUX4UHqn65PXyfhjBni4na9f2ChIsHdQylOUTYawii7RVwUyFqK1dO6T3RP7ZmI6JJvasDnqK/jPKad4zUJUF0I7uKGNbGOoVSssjFU0Wt8IKXeenjI/khVd2S+hxfFBp32pt/bsWrzFzm58Ze6gl1ND6izFtWlP39TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VLkqDGxZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so2785637a91.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 21:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738300138; x=1738904938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bF3lwd4pS+M20v01G6DWqihg0Um/64edCRLH1Rr/zvQ=;
        b=VLkqDGxZO4koRZjgubtGNiTj05iApfM8NDMGDYmd3IqNPD8Mc7gUjP59DdKJu+kO12
         B+nVajyPCJRdsU0DsbZfnW1I4eOfjD5n9RHBMYeeVol0MA9zIGlON5FN8bG5QgaAgX0f
         I4ddp0gHp9igREwj2RN+ZNF4HeB7d3tO6gI50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738300138; x=1738904938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bF3lwd4pS+M20v01G6DWqihg0Um/64edCRLH1Rr/zvQ=;
        b=AHCRjMegDQU3JaQrfoa6kLD3LI1BV/GH5jVb+dyFE+9kTlYWGfz6TZGPMBZCa1O8zZ
         XSOx4UaqF/ynfVuvT7XVZq/7LWJziqMz6o4PJ7bXpSLdkdqNOaJSyqOv+Z7fnYbD08PK
         XWNPUtf4ZLCBF9RFeWsEp9mXpH+1m9ctqpoY8gcaknsVVjlt8IAlHYjH1/HF1TmHGQux
         2r0Xo54tmre/UnSTzaNpYhM0C848xdr7cx23T/zvRgVv22ygxi6dlcyukKvBu8hQRD8R
         P5vyikSN9B4B17wv1+P2ROyMhkLsFbAIPGMGtLbKvczNC62D9axAKZKncoX4G/yuXgV1
         hqww==
X-Forwarded-Encrypted: i=1; AJvYcCUusfQ0VaiKDHFTF6kaJbGfWMVZUSpntvFXyta94ekIPKc97WTIgM/zMpP7znKwjeS5n9N9Eu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/2mDkzBY5zkiB8hvik+GL/uIGWTvGYB97IXDODB00XlE+EMS
	QXKlzGR+ochV2dthiRoIgqbmyOCgfsyN37aMkZ8quaVtOOOgpYbskLhLfDFzLdOpT3tGGx67ca0
	fSQwXC8MBmpFynZ22hPVk3Qvn7nmIqlbBEUIa
X-Gm-Gg: ASbGnctK5d2RTQ7YhPPgboJkj7u7p6o+dkMWYV8es4Q7rrkY9G1HkY75nPGsnQ8sqDC
	o3Nkm7lPYNcNVdWr0u0/lTvpCn/yq+YjQEAmG46pFohV8Dvj+fhtAK+pDOdbSNQsbhB+YnQoGrg
	==
X-Google-Smtp-Source: AGHT+IGUe81zPT592rEkmcC8qZP/P2K/Oc6b0UQarA8RMFd3yVJmd9ekUDxYwfKQjUjnXUhQlsb471zELIU73JtSOcA=
X-Received: by 2002:a05:6a00:2350:b0:72a:a7a4:b4cd with SMTP id
 d2e1a72fcca58-72fd0c728ffmr14417760b3a.21.1738300137873; Thu, 30 Jan 2025
 21:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129203640.54492-1-lszubowi@redhat.com> <20250130215754.123346-1-lszubowi@redhat.com>
In-Reply-To: <20250130215754.123346-1-lszubowi@redhat.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 31 Jan 2025 10:38:45 +0530
X-Gm-Features: AWEUYZl7ocTdzdQQ8OswQTlCEoGeRLbTtZTRlM7toQVekt25Gt7vbvEnFAVrPy8
Message-ID: <CALs4sv1i3Sf5aCp5mJpTMxVcLVfWNjR3_92cVZea1mQLfQs-Qg@mail.gmail.com>
Subject: Re: [PATCH net v3] tg3: Disable tg3 PCIe AER on system reboot
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	george.shuklin@gmail.com, andrea.fois@eventsense.it, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f7550062cf98ab3"

--0000000000003f7550062cf98ab3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 3:28=E2=80=AFAM Lenny Szubowicz <lszubowi@redhat.co=
m> wrote:
>
> Disable PCIe AER on the tg3 device on system reboot on a limited
> list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
> on the tg3 device during the ACPI _PTS (prepare to sleep) method for
> S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
> as part of the kernel's reboot sequence as a result of commit
> 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
>
> There was an earlier fix for this problem by commit 2ca1c94ce0b6
> ("tg3: Disable tg3 device on system reboot to avoid triggering AER").
> But it was discovered that this earlier fix caused a reboot hang
> when some Dell PowerEdge servers were booted via ipxe. To address
> this reboot hang, the earlier fix was essentially reverted by commit
> 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF").
> This re-exposed the tg3 PCIe AER on reboot problem.
>
> This fix is not an ideal solution because the root cause of the AER
> is in system firmware. Instead, it's a targeted work-around in the
> tg3 driver.
>
> Note also that the PCIe AER must be disabled on the tg3 device even
> if the system is configured to use "firmware first" error handling.
>
> V3:
>    - Fix sparse warning on improper comparison of pdev->current_state
>    - Adhere to netdev comment style
>
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---

Thanks Lenny. LGTM.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000003f7550062cf98ab3
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOaFvIlbTcVZw0hZOh3YFBev34GNWA/y
6pNzEXJyEr80MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEz
MTA1MDg1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBp+uLagG2PNi7CidZAOms95YIS+THkHIXsQsO85Tlz3gMEouM4
cJdikZsNORUgplYBqcjRzwfL5dTvYN/Eiq23weOqC5SpDyB3ip6XBHojwjKNFXjtWoCNe84PGNk6
yNYKFgtZpSM3c4WqHuRZsLV3N7coJozb7nNr2EIFTas14fbsygOc4OX66e6hgBV4RE/hUVuDP/OY
zhij2pwSnYbECN+ihyalgbrTwZEsBzCfHC38GEocD1wie79MN9mAk7oRdV3U/eqgZG/ulF9i982J
bBbQBezw936VkbTspWmmXdbwG919azYWcwsfq9bQOZGUQBxiniCJmLtTB2fbC1NA
--0000000000003f7550062cf98ab3--

