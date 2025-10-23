Return-Path: <netdev+bounces-231971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7CBBFF391
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761E819C6D23
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F0E263C8F;
	Thu, 23 Oct 2025 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iNkvZUMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD29258EE1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196120; cv=none; b=J1ynDCXguuexZm9ZSnmafIvc8OHEpK7rDk3pjKbrAklGznnsQgiyLZPc6NX2rvOdhUNyJk16RPpp+fsLfVFfTFPKUYl1jnSZgE8qZqSp3OReBwQUebNuXCy74Y3Lk67x0Pj8mtfagN4ME/LwQmIA7Nh7GKs7qIqokVS6gon4pMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196120; c=relaxed/simple;
	bh=+OdffEi9OH5LkPlbiWzNh7JfvU2+J/G9Dy/5RQChra0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq6tKjknJaAWzvYTjqFSQ8AuDVAtyf8o0gqESx5DhePerlxsP3KBDYxQ82Pk/9qOL0ooZaSdpreCq6Qj+FLksDxl9sOvdb0XIJjhFmf2p32hDhSREUD8MPEZHCZwN38mlGDFbM/eaWDNgj3jOLGWboThiCuC5FY7zAytvGDN4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iNkvZUMS; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-795be3a3644so2461196d6.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761196117; x=1761800917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2I2BZ8uyxTZs5bWbP6nwOAQfKSrE1VvM3LQsk2eOpoo=;
        b=tDOtJ6uVse377rgwcgRcb6vQicbqCgrNFjfRK3JIz8AKyXp0TUgOHJb2KeupA4KOD/
         vfB9frU2tlqGQRaT5TuDjRx54X8OTaGvpmZaoOK4IGWQOW7po4G4PcvSI5h50KETtZ0E
         Uj99f2KQuBEpEXv7txnRxsHkJrL0uel/eXsGxs/V4fvlCv0jYozn7VnOmvgmo2fn8Enx
         t8IWZeO3v500S6fXChrS73A3erlxyookBpV6ENWvqvM89l7JTVfZst5ZsAiVmgwVAcYW
         sPWm+Lqly/1arg6fs7t2/SrYqxIYvvP8jJkp0TL5Khm62/IdwiKNs+XDQfr8i5xVDevB
         LNZg==
X-Forwarded-Encrypted: i=1; AJvYcCX8W3RkY2YSOdheqwQ9hUFwJP80f4U4K+17MC0xILAZxv3p6YtpznMDmwKr7JhM6mY5vMfmry8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgIyHFU8iiUsxOhhKe93GmbNgtPi7vZYJWpHx1KW1OucvZRTU
	6SvBHili0juPzwVarFDvC9EDkGfvkKd2lMnURYSERTyDKKul8AchxruU1tEJaf79QloH1PORXlP
	ez7s4pkbVfYHwRiSPVeZjez90g6Jm+WCaH2g3STXQnABRq3qehyNtse7vBlzSFkajVMfAOqZQvi
	UG4wvqIrtfF46yJHHkgX3G4owpCc2DsKGgrG23BS0chyyNmk37RLOs++IxZO+3IxmshMhBbEOiS
	0q5N7kwlTs=
X-Gm-Gg: ASbGncuNRtsWD32pSFPumsfwWbRR4sZOwWzf7MGnV8GRuvUdMU7YAUnrigw4DZzQBUD
	UiqM7JjfepkAYdAUNDjXGPYvPsN8wXJWuORjMLhgQhDfiUPRWLaOmkCloJW3RXgEaUzLeS1cSdU
	pg8Sd0q2+JASxCFHKmL4IVWe+fOq/knr7KZj+hALudEeqB3XcT+eCbg+vvrq+JmWhU8S62r3CcK
	lsT0NDwiF60W+QWEI4HdtxgGcIuCpZaUXevttviJnEhVGV2UQY/SPld1WCFCVAhD6nQQzcUKiag
	hg40QEA7Q1OxcSSzcSmSCy/JLOh1aX4wHuDf9ym8XzoXRfLf8B6GTeGqDke8/gJ0BYVzsbSXOmm
	EAn7wcaGe5Z0ffuCmVJk+EBJiaHu/yhQiGBt3ouYkqGxmIw1qp+IYyixxBk36H24q2HOg0e4fQh
	sgQDRyVUJHwUbomO9/TssszutDXALlBd4=
X-Google-Smtp-Source: AGHT+IFluH3MiwGrJnw033esuxyzl04Vwq5iQgxQOBYdchuRb6t+wU7vH7uspueyfCQhaREPWfo3JdCEeyiZ
X-Received: by 2002:a05:6214:29ce:b0:87c:2373:7dd0 with SMTP id 6a1803df08f44-87c23737fcemr297741846d6.67.1761196116893;
        Wed, 22 Oct 2025 22:08:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87f9e82e0a2sm1006476d6.34.2025.10.22.22.08.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:08:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5db22e321b9so311682137.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761196116; x=1761800916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2I2BZ8uyxTZs5bWbP6nwOAQfKSrE1VvM3LQsk2eOpoo=;
        b=iNkvZUMSRIHmcaXLVlPug6LU2ToJVp+aqJS79v8PVybh6CPsrDZ6hoUtz4965LUjRt
         qBB+z2GmhOvm78LZDJ0LRV84fhDhWVas1lJ/UBgkd3DeWIoyW2bzieFm6Md3tvIkaxWx
         QdptKpibj1G0nM7pJ3Onb5W+T+j6o8r6RHjr8=
X-Forwarded-Encrypted: i=1; AJvYcCVZ9SDRF8yXbhoHn04dsLdhiQawg3MThwas2OVZRA4HdrxKaDsO9cDvMgz7rKUlyZHhY2Samts=@vger.kernel.org
X-Received: by 2002:a05:6102:3706:b0:534:cfe0:f83e with SMTP id ada2fe7eead31-5d7dd4c5091mr6136600137.3.1761196115856;
        Wed, 22 Oct 2025 22:08:35 -0700 (PDT)
X-Received: by 2002:a05:6102:3706:b0:534:cfe0:f83e with SMTP id
 ada2fe7eead31-5d7dd4c5091mr6136582137.3.1761196115279; Wed, 22 Oct 2025
 22:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
 <20251022105128.3679902-2-ajay.kaher@broadcom.com> <fcabc415-17ef-4a68-8651-c55d4388db2b@linux.dev>
 <CAD2QZ9b9+TP1YnpL0DkNqn5kdgxseMooBr8xJ9fMu+0tgtX=vA@mail.gmail.com> <679df304-ebbf-4268-9834-b851d96e8366@linux.dev>
In-Reply-To: <679df304-ebbf-4268-9834-b851d96e8366@linux.dev>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 23 Oct 2025 10:38:22 +0530
X-Gm-Features: AWmQ_bl2Q6-hgPXDrO3lHnJGDGk9t8FusQi3aH4PjPRrWoo5w7eidE9QUNyX82A
Message-ID: <CAD2QZ9bpLF6N1g0SwTx8xyJAc47=5LHyyfwWMeJeQWasZjTwbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, davem@davemloft.net, richardcochran@gmail.com, 
	nick.shi@broadcom.com, alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, jiashengjiangcool@gmail.com, 
	andrew@lunn.ch, viswanathiyyappan@gmail.com, wei.fang@nxp.com, 
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com, cjubran@nvidia.com, 
	dtatulea@nvidia.com, tariqt@nvidia.com, netdev@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	florian.fainelli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com, 
	tapas.kundu@broadcom.com, shubham-sg.gupta@broadcom.com, 
	karen.wang@broadcom.com, hari-krishna.ginka@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ea3ae50641cc6cb0"

--000000000000ea3ae50641cc6cb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:47=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 22/10/2025 18:27, Ajay Kaher wrote:
> > On Wed, Oct 22, 2025 at 4:43=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 22/10/2025 11:51, Ajay Kaher wrote:
> >>> Implement PTP clock ops that set time and frequency of the underlying
> >>> clock. On supported versions of VMware precision clock virtual device=
,
> >>> new commands can adjust its time and frequency, allowing time transfe=
r
> >>> from a virtual machine to the underlying hypervisor.
> >>>
> >>> In case of error, vmware_hypercall doesn't return Linux defined errno=
,
> >>> converting it to -EIO.
> >>>
> >>> Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
> >>> Cc: Nick Shi <nick.shi@broadcom.com>
> >>> Tested-by: Karen Wang <karen.wang@broadcom.com>
> >>> Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
> >>> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> >>> ---
> >>>    drivers/ptp/ptp_vmw.c | 39 +++++++++++++++++++++++++++++----------
> >>>    1 file changed, 29 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
> >>> index 20ab05c4d..7d117eee4 100644
> >>> --- a/drivers/ptp/ptp_vmw.c
> >>> +++ b/drivers/ptp/ptp_vmw.c
> >>> @@ -1,6 +1,7 @@
> >>>    // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> >>>    /*
> >>> - * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
> >>> + * Copyright (C) 2020-2023 VMware, Inc., Palo Alto, CA., USA
> >>> + * Copyright (C) 2024-2025 Broadcom Ltd.
> >>>     *
> >>>     * PTP clock driver for VMware precision clock virtual device.
> >>>     */
> >>> @@ -16,20 +17,36 @@
> >>>
> >>>    #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
> >>>    #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
> >>> +#define VMWARE_CMD_PCLK_SETTIME VMWARE_CMD_PCLK(1)
> >>> +#define VMWARE_CMD_PCLK_ADJTIME VMWARE_CMD_PCLK(2)
> >>> +#define VMWARE_CMD_PCLK_ADJFREQ VMWARE_CMD_PCLK(3)
> >>>
> >>>    static struct acpi_device *ptp_vmw_acpi_device;
> >>>    static struct ptp_clock *ptp_vmw_clock;
> >>>
> >>> +/*
> >>> + * Helpers for reading and writing to precision clock device.
> >>> + */
> >>>
> >>> -static int ptp_vmw_pclk_read(u64 *ns)
> >>> +static int ptp_vmw_pclk_read(int cmd, u64 *ns)
> >>>    {
> >>>        u32 ret, nsec_hi, nsec_lo;
> >>>
> >>> -     ret =3D vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
> >>> -                             &nsec_hi, &nsec_lo);
> >>> +     ret =3D vmware_hypercall3(cmd, 0, &nsec_hi, &nsec_lo);
> >>>        if (ret =3D=3D 0)
> >>>                *ns =3D ((u64)nsec_hi << 32) | nsec_lo;
> >>> -     return ret;
> >>> +
> >>> +     return ret !=3D 0 ? -EIO : 0;
> >>> +}
> >>
> >> Why do you need to introduce this change? VMWARE_CMD_PCLK_GETTIME is
> >> the only command used in read() in both patches of this patchset.
> >>
> >
> > Vadim, thanks for looking into patches.
> >
> > I have added ptp_vmw_pclk_write() where cmd has been passed as argument=
.
> > Keeping the same format for ptp_vmw_pclk_read() as well, also may be us=
eful
> > in future.
> >
> > Let me know if you think it's better to keep ptp_vmw_pclk_read() as it
> > is. I will
> > revert in v3.
>
> I do believe it's better to keep code as is until you have real use of
> new feature. And I'm not quite sure which command you can use to do
> another read?

Sure, I will revert the changes of ptp_vmw_pclk_read() in v3.

-Ajay

--000000000000ea3ae50641cc6cb0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIESp
Ucj3vPM4jPhbv6vFFufxuvgmbJ0szdAUUon9+d+IMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTAyMzA1MDgzNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAB0ZqQSB8lsC1kPKRq6gDkEaVKY6TQlV0OHy7zk5
Kzu5vFRU/uMJnInJKEdCXrXH+VzjX60Xfrca3FspLE0ipawYkGlFmp1v+hxYVvq7QXUCUE3F+o6H
22wgrKv2DHJ6uFdBzv/Gz6RSFk5B480Gmi01ygfHvb+/VPjlOVlKFZ6+0Bnojf6OylgNI0JY9AA8
Qy/8BaZbaY+3e8Gz35cYB68q+REJQhq0RDONfnGHHV/HAkmy7QpXCajROaOP92hirlBUQ6Jfioha
MSIuUQAeJqpS5J5uMgA741/A+hPbCwQtSL4PllyotaTJ7XZB6LOEecZ13/umKvFJ4kNYu6NLzEo=
--000000000000ea3ae50641cc6cb0--

