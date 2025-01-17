Return-Path: <netdev+bounces-159309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B044A150EC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8023F18826F3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81E1FF1A1;
	Fri, 17 Jan 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PGfr1hml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08ED1FDE31
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121934; cv=none; b=FhKHXO7a3AE5+LEzMLI8A/ealAmq1/CjlvrLLqDfd0fZ0n7oVZv0tMIoWtHVx84sAbaO/IXA64OcZPgT5ptQ8uKi3Jy/foUcV+E50R0He5m2eemvZK+VTmbWffUH5BOQ1hWN0dBqXn2Qr9DlQ+mjfbkfMkKTgyFvthNtr3Jadlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121934; c=relaxed/simple;
	bh=INlhrDyUZBfPNDGAInqwpsYxytD32kaeftPh4V/bCxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvNoM2vphSmgke5R7qUdi8wjpCPL2XzeHgYrJSIYo9RSWqRpTSpfLHrA7ac6pW9TmCjxbc/LwYDzYfYbaNG19Trq3O2TtKO3S6+cz6Kg3olH5gX+UY4SY+UykAZIPBBFL+XSYVFfHBRErF6r+zOXGrfXvLqG+i/muGPgBKdfHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PGfr1hml; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3661215a91.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737121932; x=1737726732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INlhrDyUZBfPNDGAInqwpsYxytD32kaeftPh4V/bCxg=;
        b=PGfr1hmlMciByT3RoH+I9GBsEMDtNmYK2VWq1+Dw8LTTMpV5e6W65W2hrp2ZmSfk0r
         lKw/cC8rgrnbjJdlDNqPaW89+woewLdFUHDYi7rJr+9unILvfusk/jhWvEdseZ98tnzz
         GedfN5Vagr17TRpb7IZbaiiC/2S8vIe1co6xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121932; x=1737726732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INlhrDyUZBfPNDGAInqwpsYxytD32kaeftPh4V/bCxg=;
        b=XFMCkkfg9ze3KHMaGDy0R+/M8o1ylnVgWRQ98QrB0T1Krm66sOPC47O7EkI0OCNlRh
         A+Vby9xqQIFTfyww2LEebPIv7SajQh+PMF7hc7GjhTzHl+yCPshxhYbTPPPvmbqkBzt4
         2VbDvLehUW6BiK5NgZoXdT+mX3JS5NicHFg3oBCzShHTUBnDaNLg92DjkUoVVRLmVLwq
         xSTZXnAVfUCicVVSBjKSOAkv4xXZucdt0ns6feY9qAydxYavSH1uoXJa4lQna+RJ0Ets
         759XnHbh/o/vJ3Vm51QUUX7UDNoRai1xr4q9u+b33bVrDN3mk8cunEw9mZsU+eNHAcf2
         ICig==
X-Forwarded-Encrypted: i=1; AJvYcCV/2xvxW9rhYEN9rNuDLDdKHF1uuStIi3/Up9AXX6go0n9mT6ZHGqIfb201CwWDf/4XbhmbmVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywip/JzFzm20jDGf9IJRpYHn7vFZO5RkOWPDioDoQc3xUf/nPEw
	Of86+/L5QTdhoGwvcivGz7IIrhS80TjkdaCyJ/MaADx+uIr304jYlyoFsGtkCb02wWNN8aKR35D
	238IHvJQ5TeSkHLgNSduDpd1MxMg7vSAyiIyE
X-Gm-Gg: ASbGncvrH/cmjvWg/vpFgMUEtSbYE/McP4pJ3xhH81PLES36/huJR+Nz2+5KSeBZsS9
	srfZaPZ1mt1RwsF7/E42rEHXdgy9xwR0jWQHkGsk=
X-Google-Smtp-Source: AGHT+IHO+x0ko0A74ViPvGEp2cc0l2fSuMmhLUC/DYEbUZmSW38EC/dkvgaoG1uQ3r5xT93QFm5sNh4IHkcWE92sW1s=
X-Received: by 2002:a17:90b:4c06:b0:2ee:a4f2:b307 with SMTP id
 98e67ed59e1d1-2f782c628a3mr3904927a91.4.1737121932279; Fri, 17 Jan 2025
 05:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117-frisky-macho-bustard-e92632@leitao>
In-Reply-To: <20250117-frisky-macho-bustard-e92632@leitao>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 17 Jan 2025 19:21:58 +0530
X-Gm-Features: AbW1kvYd2hs3Kn1OFL3pG7UTYt9Co5BNbrb9SXQak4rlnJN1c7WXmTGMjvqGIVA
Message-ID: <CALs4sv2pjRKKLUK8sFDkAGxK_6gkPO5zDX5gDsHw6FF99eKK7g@mail.gmail.com>
Subject: Re: bnxt_en: NETDEV WATCHDOG in 6.13-rc7
To: Breno Leitao <leitao@debian.org>
Cc: michael.chan@broadcom.com, netdev@vger.kernel.org, kuba@kernel.org, 
	kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b91243062be7374d"

--000000000000b91243062be7374d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:38=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello,
>
> I am deploying 6.13-rc7 at commit 619f0b6fad52 ("Merge tag 'seccomp-v6.13=
-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")
> in a machine with Broadcom BCM57452 NetXtreme-E 10Gb/25Gb/40Gb/50Gb and
> the machine's network is down, with some error messages and NETDEV
> WATCHDOG kicking in.
>
> Are you guys familiar with something similar ?

It appears that by the time netconsole selftest completes, bnxt stops
receiving transmit completions and triggers a reset. The subsequent
hwrm_ring_free (part of the reset) completions are also not received.
I also see nvme driver reporting timeouts. Maybe all because CPUs are
blocked. It is not clear to me as to what could have led to this
situation.
Michael may share his thoughts. Do we need to investigate the 4 locks
held by bnxt?

--000000000000b91243062be7374d
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH9QAlcReKR0Oaf50xdJknyCUXEwhqKr
OCeFyT33cw7NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDEx
NzEzNTIxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBujQSMp2y7UBTuH1Bfv4IROE0qAes7DCbVRS3I9ENSWiFdjL8H
zLVU5zr+7VptP9GeHULQnd7PQFtaRmmo5Ul5jMcDWfyFf629RiLPkN662By98dYdGHKoqrWw3LLK
+EYPLPY29908Iw85VerLNs5ybqjzNpESapYDI1tsv+gnOYvNVn8UnVKVnFOiCpfKVyHbvwohqauU
CpQR7CpeeNjJ2ONzmpxDLWaijqDfNbwWwwMJXRMHpbqAQkkdVkhMUg84HvGJoF2Zwf5EQ/4GRH6H
DhBBRmnxqadTvfzCpQVANU43BzQ9Qi8V1pu37f9y+hdw4UmnCcEuW7M7x/Ym9zCg
--000000000000b91243062be7374d--

