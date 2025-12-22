Return-Path: <netdev+bounces-245673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F225CD4BD7
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 06:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3893006AAE
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04A307481;
	Mon, 22 Dec 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z0Yk9191"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414935975
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766382844; cv=none; b=rexd9AF0bOXHmkGeVMUAY/dKW89QdA7+JKXkEA0s/epMSc+HB+YE1Lw1JfaqEzRnrkYfYz2DcrbZWvocjdfGF43YNmXCKo0bDtQAmjeKSVbdyJg9q1z92XH+PyRhOe4dElnzHjyJ+Sn5m0+n5Fmt5o2wDmOUZS2F/F+WJf+8Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766382844; c=relaxed/simple;
	bh=w7R+AhyadAFCW3QpmMni1EfNUY/CThdKLMoagvOydmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojPCR4HEjzAtRYWY9aDe33hiB0VhT17ytrM6MS1Bcr51iAvocD5f3g3Gl2gG9srNZmLwG+TCqwkZDnXrXEWj8CzZhWh7UZm1Tivu4SPSDUrd5cclmJC590bfKrQYSq6/DwGx+JI3M1P5XD3HjCoyHHB0fEsSUYCgJuYojNkEiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z0Yk9191; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0d52768ccso44914685ad.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766382841; x=1766987641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1V+a3qnB4tJcq8IWAyloGp41KKdmZlkcM30iqrOpgk=;
        b=IeBt+Ucvl1FLUhNCzOF44IFJ6i0Ireowwf50eA8YzxCvHLfmF9QUUISCmv3KhCg9zd
         upUgiZloelaU/mbTveAPc6jjL8gKAytGJDGm+XZ85AgKfiM3GIdWRXbiAcuNq9LJr3Pl
         wbJqEt0EDxx7ZOHGO/ulwILhiOAUIOznhn/xPzK5YYfcxYPmKAuhEp7WzvO2Juq1jvua
         97XPI5fY2dUTZz7jjCvHQ0JnZeMsRoEWuM+bN+BDkWEbmZdAEWAqaJPC26OuYlKGE2lc
         owfmZKeVlriXRlhzlNZWVpCN6RGyx3DA4QnvHSjgNwYPFeML/dbH+JxEopUOygHyND89
         1skw==
X-Gm-Message-State: AOJu0Yz8iCPcuQ1XoAq3SuwNxHPuIR1vjQx/3GLmRMswQeynUQNUs+mI
	YqSf796A5W6VkVWNlKtrQwaEVKrZ6hoAcqAeXVD5lpBbw6+qEYVIu+WqvHWvg2vH4BARd/E7DlY
	yAaH6NhOfnNedS7IK1sFrvNJwsWnLZKmmRLAf7V+LZovXUK1unXTzQKsYgUey4dvVf2Q+eSP9As
	4fA/B2T3Dxg4j/xgsRJVq3hPP12UoDHDtk+N2mKT2R6xYejBtSLmUTctTsxtzjf6oe2gN7JZNqJ
	N3hJaOqXCs=
X-Gm-Gg: AY/fxX59x8vFm2YcItoffEZ13qm3B3Utl30SXJZ92FJda1p6gWlzc4YSSo95RRCAzdX
	rH4dciXfHjqfWyVSgjh7jOZYmGD0v+sfTIxIEuIlJ91/8SBhSFYJY+McLzAJeY316QoXCHla7xN
	8+mppylQL42svs2czLRPkPUb6edYSabMqCPfwq/BDEJ2dsWmWE9P23mrZifWI8DtbNAa8UCuUsv
	My4rVPN5sPUOTSmAdRg6nQIOt/uWIQZNWhI7aAEb8KaO9sO5NfcIGNXLkdcY5jyDcemT+lWnD9w
	qiPhjMGfBmFrNeWqA9Rh1aVsqKFNKvd+8Qu0m/N8OIaAtQ5g7JGFbnbg/WEM+7K1D20M90HhgZ0
	Ed+oecJ03DJ+8sLg90iJ7p9y2JWIGMJ1g7hHNBDYJVDJH2MUJAczUkEfVelAz188ICsqtny/Hmm
	gRKEnak6yL15o0jCUC+nDiw4ejSWOBYVI09nus3RLyczxg
X-Google-Smtp-Source: AGHT+IESkrBkO6Rb6V+aZfWRM7w+90yyymEAWiCRLDKQPrEda3ts0+2DpWyjXX7P43tvxfc1c1bUVuGE305s
X-Received: by 2002:a17:903:4b4c:b0:2a2:ecb6:545b with SMTP id d9443c01a7336-2a2f220307amr119944605ad.2.1766382840955;
        Sun, 21 Dec 2025 21:54:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d06992sm10632295ad.32.2025.12.21.21.54.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Dec 2025 21:54:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29efd658fadso117482135ad.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766382839; x=1766987639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1V+a3qnB4tJcq8IWAyloGp41KKdmZlkcM30iqrOpgk=;
        b=Z0Yk9191et3hXP/QwpFUjIfPYQBxn9LHMvA5I1x3aSM0M8uhFzx5oceoIE66naZDYn
         S/FaEwQoA00+TO6PwQ85IIYUpLkoU2cLSWmZDszGXSzurcB0xZ7vjqMkwMAB8KmFRNhS
         1Oy7WMMlUpaIqKUHTklfPV35SMwJdlEwVB/nI=
X-Received: by 2002:a17:902:e548:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2a2f283de59mr95744525ad.39.1766382838612;
        Sun, 21 Dec 2025 21:53:58 -0800 (PST)
X-Received: by 2002:a17:902:e548:b0:295:8a2a:9595 with SMTP id
 d9443c01a7336-2a2f283de59mr95744185ad.39.1766382837396; Sun, 21 Dec 2025
 21:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221175050.14089-1-noam.d.eliyahu@gmail.com>
In-Reply-To: <20251221175050.14089-1-noam.d.eliyahu@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 22 Dec 2025 11:23:46 +0530
X-Gm-Features: AQt7F2r_9bCJfxY9dGDzlP0AEG3bj7O_-fHXNDfktmmqYh_sekV_k_487_t94wY
Message-ID: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: netdev@vger.kernel.org, mchan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a8f6a20646840d02"

--000000000000a8f6a20646840d02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 11:20=E2=80=AFPM Noam D. Eliyahu
<noam.d.eliyahu@gmail.com> wrote:
>
> Hi all,
>
> I have not contributed to the Linux kernel before, but after following an=
d learning from the work here for several years, I am now trying to make my=
 first contribution.
>
> I would like to discuss a reboot-related issue I am seeing on a Dell Powe=
rEdge T440 with a BCM5720 NIC. With recent stable kernels (6.17+) and up-to=
-date Dell firmware, the system hits AER fatal errors during ACPI _PTS. On =
older kernels (starting around 6.6.2), the behavior is different and appear=
s related to the conditional tg3_power_down flow introduced by commit 9931c=
9d04f4d.
>
> Below is a short summary of how the driver logic evolved.
>
> ### Relevant driver evolution
>
> * **9931c9d04f4d =E2=80=93 tg3: power down device only on SYSTEM_POWER_OF=
F**

I think this commit id is wrong. Anyway, I know the commit.

>   Added to avoid reboot hangs when the NIC was initialized via SNP (PXE):
>
> ```
> - tg3_power_down(tp);
> + if (system_state =3D=3D SYSTEM_POWER_OFF)
> +     tg3_power_down(tp);
> ```
>
> * **2ca1c94ce0b6 =E2=80=93 tg3: Disable tg3 device on system reboot to av=
oid triggering AER**
>   Addressed a separate issue and partially reverted earlier behavior:
>
> ```
> + tg3_reset_task_cancel(tp);
> +
>   rtnl_lock();
> +
>   netif_device_detach(dev);
>
>   if (netif_running(dev))
>       dev_close(dev);
>
> - if (system_state =3D=3D SYSTEM_POWER_OFF)
> -     tg3_power_down(tp);
> + tg3_power_down(tp);  /* unconditional again */
>
>   rtnl_unlock();
> +
> + pci_disable_device(pdev);
> ```
>
> * **e0efe83ed3252 =E2=80=93 tg3: Disable tg3 PCIe AER on system reboot**
>   Combined both approaches, resulting in:
>
>   * Conditional tg3_power_down based on SYSTEM_STATE
>   * A DMI-based whitelist for AER handling
>
> ```
> static const struct dmi_system_id tg3_restart_aer_quirk_table[] =3D {
>     {
>         .matches =3D {
>             DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>             DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
>         },
>     },
>     /* other R-series entries omitted */
>     {}
> };
> ```
>
> ```
> else if (system_state =3D=3D SYSTEM_RESTART &&
>          dmi_first_match(tg3_restart_aer_quirk_table) &&
>          pdev->current_state !=3D PCI_D3cold &&
>          pdev->current_state !=3D PCI_UNKNOWN) {
>     pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
>                                PCI_EXP_DEVCTL_CERE |
>                                PCI_EXP_DEVCTL_NFERE |
>                                PCI_EXP_DEVCTL_FERE |
>                                PCI_EXP_DEVCTL_URRE);
> }
> ```
>
> On my T440, this combined design is what causes problems. Simply removing=
 the DMI table does not help, since the conditional tg3_power_down logic it=
self also causes issues on this hardware. Adding =E2=80=9CPowerEdge T440=E2=
=80=9D to the DMI list avoids the AER error, but this does not scale well a=
nd requires constant maintenance.
>
> I also could not reproduce the original reboot hang that motivated 9931c9=
d04f4d when running current firmware, even when initializing the NICs via S=
NP (PXE). This makes it look like the original problem has been resolved in=
 firmware, while the workaround logic now causes trouble on up to date syst=
ems.
>
> ### Possible ways forward (from cleanest to minimal)
>
> 1. **Cleanest (recent firmware only)**
>    Remove both the conditional tg3_power_down and the AER disablement, an=
d always call tg3_power_down. This restores the pre-workaround behavior and=
 works reliably on my system.

This is going to be a problem, please follow the discussion here:
https://lore.kernel.org/netdev/CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1t=
GP0OPJg@mail.gmail.com/
where regression risk is flagged and it came true in
https://lore.kernel.org/netdev/CALs4sv2_JZd5K-ZgBkjL=3DQpXVEXnoJrjuqwwKg0+j=
o2-4taHJw@mail.gmail.com/

>
> 2. **Flip the conditioning**
>    Keep the DMI list, but use it to guard the conditional tg3_power_down =
instead (only for models where the original issue was observed, e.g. R650xs=
). Drop the AER handling entirely. This limits risk to known systems while =
simplifying the flow.

But I am not sure how systems affected in the commit e0efe83ed3252
will react. Can't tell 100pc without testing.

>
> 3. **Minimal change**
>    Add =E2=80=9CT=E2=80=9D variants (e.g. T440) to the existing DMI table=
. This fixes my system but keeps the current complexity and maintenance bur=
den.

I can understand the burden. But unless Dell gets involved I don't see
a better way. Intel i40e also has a similar work around.

>
> I wanted to start with a discussion and a detailed report before sending =
any patches, to get guidance on what approach makes sense upstream. I can p=
rovide logs, kernel versions, and test results if useful. My testing (down =
to 6.6.1) was done on my own hardware. I could not reproduce either the ori=
ginal SNP reboot hang (9931c9d04f4d) or the AER ACPI _PTS failure (e0efe83e=
d3252) on current firmware so currently only (2ca1c94ce0b6) seems required,=
 which suggests both issues may now be firmware-resolved.
>
> Thanks for taking the time to read this.
>
> Best regards,
> Noam D. Eliyahu
>

--000000000000a8f6a20646840d02
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDAdUr1
RhrdPQSXktpCtVsieYP2WWHELXmRFcp9M6KP0DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEyMjIwNTUzNTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCvzWjMx+eeM1bJRZOQaKzrQGktGaBfZj5nJywWYVbn
NxycKoUrZFrXn5NGMV/nFr0ntWGjT0eYhw+ysXAVKk2wMqyruShe/G/aQWsd4h0Y+ryhhZASC1fe
NHJ/j4b2R54jGk2NCefA7eGdPr7AWCC3FIfa2aPRWLVerOqu9LBRgTacBDaMUhySmCPc//yJviXc
xWSuVzEClvZk2Dm09y84O12r/kzc93tCiG7+ofeoSw9lNh9nziEJw2Na5sCBGY7/8zwrXd5w4eZW
jXMgC5bLKK5v01jhUrRI9QL+VEwQQ1sfDnhbGgxfvqGbH4Z+4qMuRlKFczDjennhYfU2zg60
--000000000000a8f6a20646840d02--

