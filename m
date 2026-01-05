Return-Path: <netdev+bounces-247175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C84CF53E3
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66760304B95D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D071D33A9FB;
	Mon,  5 Jan 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dBCAbx2K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9D202F7C
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637789; cv=none; b=d+mB3xBUYLCFH145Z5ReTP8P6HlBdRTZYvvYhle+8prHV/3FSnUECLr73tuEWxPzLoqrwzi83PTM4mhc1oYfAXfgWNYBeKsOUEPT36qFzELsYMQFhPgQFx/A9yoMlFdi3gME2fQfbAJXFY68FtpY1mx28YDJu/51oHEPsx+Rqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637789; c=relaxed/simple;
	bh=Zg3psekTy30L6yNjm9l0y7AOlQMC7FbK5umKr1DBJHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II0c74Lif6kHvFnZbTmt+/0e650QfwDdDOvbmbR5VZAAOt7h5iZ0ExCN6/wz2qHMxNAWsV5Sge1QQutMXVKi1GluxDKQdj4Mox+iX1Wbt1nl/3gy4mhFQKoEwGUG+NtxkQHEWMBKumPCa8JmP5Wdv6aYwnplcIrRB5zBrTR09Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dBCAbx2K; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6447743ce90so230568d50.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767637787; x=1768242587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4a+r31/zD7iCge1OoIrCrypgZSSgdWhEAHL34XHEOc=;
        b=fGlOUKXpBElDqDq+9WA8et0M1KJKyYk0mrO3JMbHET9ueqg0Ga1G4GTl7l4uyvDBOP
         snm28PoB6U9rg9D25eYyqXMgIXi5lTIWwIfz+ECqOw+7zo6cjCHqgOmrsb3xUFiypKlf
         qsGebiZUO3HI6lBSCV8EAWJ8pZd29rW+YpalfYo0Ifs0zV+LFH4OUirF6+lkseiTMCvN
         o1ecOpgruMFtgZ06ZZA0RBD7xOmvi1jV7TK8Kh5YfYeS901nY6ufouKLEv/vjIgyOIZp
         Hp8XSvzRZKlOl6KbolkK4Dl9ZAfKtzKnf/jmUYUmKGjA3PgnBOmdI2uSZSk85Y7Szk+6
         7Row==
X-Forwarded-Encrypted: i=1; AJvYcCV4D3oo9DGz1p9B44wUHhzsf/bs8PW391HDC3gVzusA/HH2J6IeNq2qQHSGUL1vHSgWFrkEeGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTTQN9NBNeKGk5q6Ov6YF5v05nnYlY2QEQwKEgBDQdj8XF6Yp
	0wSEj4V9fsG01ycOxhVLzrRi8b78OtiGIZQITQhOe3U+it0Y8F0wl+hMNOipF1HRIC/XkxlHpYP
	X2aEZ9lFTt9iKClS4sjMe5Jvxh4Kl3kwvunQ3RPJu03ix6UUl43MBlVr4KQ5QSCpR9MtO/uuOVz
	JMyXNVFHJohr44sJbGS5EGzRCFtdiO+6gjizUxPVSpTOKYc7rKRMP4TknZ2sv2RZ4T1/fo5Xj3G
	HfUHsxwKzE=
X-Gm-Gg: AY/fxX4pJJd+Ys8Ryy2yGfgreE2/H6Pz530OWEaKduWsmdi2Xh6ixgNpvpu0wYGIVFC
	+Yw+p32q1YyUHRI8ASQI7J2exqF5Oq4CT6RsMqZLD7PimPcqCkL1OyOshp2+Fk0SrEPW1CCHwCg
	AfcswJ6gq9JwBUVxKnDVmijrfZ+AJVrebVMd2QYz8GA2Cnt7R0YzXUfqX6ax2pWocWTTG08FVTg
	rRI6jkmcAM6ADWoi9GgHIZe/3EhrwlGah3LsAZR5z9CDXzffyKirT5d8ubVv8ALEXegEsN45TKt
	gASy59NBJb7VcnabvLWiEF9YIaaEEvqaVYes31cBrdR+Rm52Y3g60fAFiAhtvt1XQhZwXx3vhPe
	nL5MsjUDdxnAu9LZR57AMkc6MPhGSOvyVqWYi74hLA/gyvrm2qMdMzf87v/txIPhR/vdo264X0+
	xgBi0/fEsgkjWbmvOXCfOgeMSFrmfdBrV69C8iGuJsoKDby2w=
X-Google-Smtp-Source: AGHT+IH+VPiG4llt+zKIDyHg3aZshzK2BNg146s3BLcBYxf9MN+XPS1Gp8Gh0jXjIVY1rS8+eGCIaZ47BJDM
X-Received: by 2002:a53:c204:0:b0:644:60d9:7517 with SMTP id 956f58d0204a3-6470c98a40amr244807d50.91.1767637786995;
        Mon, 05 Jan 2026 10:29:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790a87a557esm270947b3.2.2026.01.05.10.29.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 10:29:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7d28772a67so24446566b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767637785; x=1768242585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4a+r31/zD7iCge1OoIrCrypgZSSgdWhEAHL34XHEOc=;
        b=dBCAbx2K5sdwGMfPcQobJmWfqvXRmeAo+FLzxaWAdJ2w7UENdF4c6GW0dmVCX8v1lP
         JI5MlkDYfsQDfFQsX9VoZwwTCjJwdl4Jgqc+9G3DjIRNKcQ3BIZGYnYdZH3uwjVSvRGP
         DoUVBRYMIm+J1vrXMziC4Tu9jc98OQtEAQo8Q=
X-Forwarded-Encrypted: i=1; AJvYcCVVqe1hWlcNTFsn0cQ9MzpgaVusbJN82PJ76KJDhDssLFBrgbGdr+EB/lXKLXBTorhTs18rqN8=@vger.kernel.org
X-Received: by 2002:a17:907:3e9c:b0:b73:6d2f:4bb8 with SMTP id a640c23a62f3a-b8426c223c3mr71180566b.2.1767637785383;
        Mon, 05 Jan 2026 10:29:45 -0800 (PST)
X-Received: by 2002:a17:907:3e9c:b0:b73:6d2f:4bb8 with SMTP id
 a640c23a62f3a-b8426c223c3mr71177466b.2.1767637784967; Mon, 05 Jan 2026
 10:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org> <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
 <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com> <aVv885DfEfngQuZJ@shell.armlinux.org.uk>
In-Reply-To: <aVv885DfEfngQuZJ@shell.armlinux.org.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 5 Jan 2026 10:29:33 -0800
X-Gm-Features: AQt7F2q36z__1kYCrwIwIleuJJL4DBeYr3FDFz4vF5Ok8w4sYfyZoM7OCQPK2As
Message-ID: <CACKFLinXhq9G1nn301OEjTH+E_31RmnDPwQ=VSEMD=+FVGiuaQ@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Breno Leitao <leitao@debian.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004f6c230647a83e10"

--0000000000004f6c230647a83e10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 10:03=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> I'd like to restate my question, as it is the crux of the issue: as
> the PTP clock remains registered during the firmware change,
> userspace can interact with that device in every way possible.
>
> If the firmware is in the process of being changed, and e.g.
> bnxt_ptp_enable() were to be called by way of userspace interacting
> with the PTP clock, we have already established that bnxt_ptp_enable()
> will talk to the firmware - but what happens if bnxt_ptp_enable()
> attempts to while the firmware is being changed? Is this safe?
>

I believe we have code to deal with that.  During FW
upgrade/downgrade/reset, the BNXT_STATE_IN_FW_RESET flag should be
set.  The operation that needs to be avoided in this window is reading
the clock registers.  A quick check of the code shows that we take the
ptp_lock and check the flag before we call readl().

--0000000000004f6c230647a83e10
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCHI9u9
MrqX23VtIiLIPQxdl6ZgQuuZFRzfgBNIanGUKzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDUxODI5NDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAbN08uOJZmzKPjOenKwY8xBXa61kV/svOpsT0pM6CW
FF0ZvJqJwK+7U0jNAyj0zlZ3Y4pqwfpzSd8fFsmtzvViL3JucCyKe3n1qpfr/ob+2guD/Q8UaDfY
oVnazYEPL1/L7B9u6aV6XfKqp9WFkaTY66U6jxrS53+xSDR2HKfEPHMn20S4UKJV8eKF30nXcRQ8
VdGUsufB59aYhyyQez6Q84GY8gN/9B6NAn0gjj6Vj2808LPM7xbP5XHNKwpevNrC4pYyyjhJ16Ix
G+5PhIjLTqyftcMFJAtX4H0PV8Ep+DpRa3lul9JyrfG5Gt7Cvt/biWpof++ZLh70EBugjSdP
--0000000000004f6c230647a83e10--

