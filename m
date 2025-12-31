Return-Path: <netdev+bounces-246437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C32CEC256
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C062330036E5
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D69233721;
	Wed, 31 Dec 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VnIU1dgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017B19644B
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193835; cv=none; b=pSQK170k1E8c7dTbI+DF+KWH8s8P7DGLo4W018urkgKIGvk143psDHoJtlkU3hW+AOG2j/6QJntuzk3LJuDyVV88MbfG6y8DSJtzJlTisVPgyZshorDDxUTIqhP4DmgZSmxKCRfeR3zI1KnJB90yHNFzMEErvQgy9uflNyH652Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193835; c=relaxed/simple;
	bh=FXbn4ekXRLaTR78D+ljQHAOpWUIXd+6+z5pyXlBbYRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Unf3HhigMro4jHIJxXQypSkPVOKcU1YTjGIfPIEh0aDEAGroZjs58Q7qTmRywF80Zg8tnhUo2RhA26YLZqBUDN/lmaUgFaPwrlT5wy2a4gwVTaVG9O8duDwGVH2QW/naTZ9+Wsc6a+3H61MtJjvDt18yEO/DZgWRL5PYcbAfWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VnIU1dgP; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c6e9538945so7817475a34.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767193831; x=1767798631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ySRBidCBbhvDmawxI5qxPDx7hc60A606cDToL/e0k=;
        b=VPhRaVUTVzby8YeLnPDhJ3XN1EneFLv6622K859o7PNw34bMbrY4QGTS3nD+jwxWlj
         3XopgKEN4ISJBssduQmw7RE0ZBtxvjynNCo67FjaY199Ul6dlZ3J9qDmsORu/havWUxu
         v/O1bq0BGvAaaUs0vBx6mU8t2wTven//NwSRYoU0U0xXIBFKQIglfrhKP+t2IZ+Aj+31
         msGfdW2ZeVlHDF1ET8b44GiC4wrd5vAOD4tYUuMucX0kHmiwAb2ePCmu9i5qQuVf4a1G
         AEHOyjmjy20VTEfuWpbysUxoR+0uvrfRvKDIo/tl+mz312XWeEMaBqX9MJj+MeKAbWXF
         TYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB0bDBr+PgBTEmgbQ+whA69RD8K3ri4fbklR+e/OWz+B2qJjgDJLznbUoekCy2AG7sRQVWSSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLajBdJIX7OCsmcpD6bdskK3vD4hOhdHZZjmepV/+1mgPesUt
	YSgwkJTHubFKr78T/7lT9qTUgA7RmSebJMq0C+88ai4ERulBhjZg3/zQjTjGvkznGTqKvCi9t1K
	gh93FMutK41OGqQm+WbI/pCIengzZReKijnAH0bc4TK7ILF4i833DRizZs6PL/toSxlsTgHIRIO
	ndH7u5jH2z4B2U0B/fTu8ATg+UG1e7HQQ4o94LIDR5/6QQPr8JQLTUoGYyUOGDTymLBOyCZnOEg
	UnX8GCyfWY=
X-Gm-Gg: AY/fxX53Bqjtl8nnKTy0JG/3UdSznqMtPiKfbWZYEci8Do4gQca6faFkrD7DoFtvAH9
	L8hglPfQpqS6co9QZgPzSa3XQkYewBm8dO43uppBTm9QW2DIBUd1MlzCNpRwbtAbfE/YU/Io+aj
	oLbdHWwMEPjbj471TMCBOhmGjlCSWgc1qZaX+jr2u3sry1GkEm3AGGOJCWkXyD9fEOoNYh9bzEh
	OjVfe4v+MykzIF2SBs0uEtchGp60s7DWhLHCc0maiD4L1XQeht+HjJw+/rhvM9oGwlWMFT4sMun
	0xpjsmfn9cz3VYCL5knSxPGrK71gwK/o5EyzNkIpqQGbpg0/LLkq5TC1eXvXASTWWYp3oz0E0Ee
	mwkMGlhNr1XqSUiITDEjBN69C8UHHW562903JFNZHS4WtSbVdP806cXnRE2wBRSvZs32N/xWRGW
	axjDvdGp7aV3nlg045f3UyiB8gwPIIQgXqkKzaWGDIQQ7LVEk=
X-Google-Smtp-Source: AGHT+IHXQL60PV5vM+gMBGihIPEwREeWF+DxVpD+cnYHK8thJXumrfdUdfjZiB1Mn1mZHGnDY+rbGlO6jQ/z
X-Received: by 2002:a05:6830:264b:b0:79e:7e5e:7c63 with SMTP id 46e09a7af769-7cc65e736fdmr25173982a34.14.1767193831148;
        Wed, 31 Dec 2025 07:10:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cc667ba104sm4533520a34.3.2025.12.31.07.10.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Dec 2025 07:10:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c1d27c65670so5450776a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767193829; x=1767798629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2ySRBidCBbhvDmawxI5qxPDx7hc60A606cDToL/e0k=;
        b=VnIU1dgPjrFWid8Z2i3tpjs72IQmv9BIr3y96j0MFJbiEYg22ipMBHJLxfhHZtHGPf
         JJtN53b0pO7ntJn6onrWPue/YPpg81QBvanCoQu76TNvYszwvTmypGWUfhlGZj55QqEx
         eZpGJtszkPsBuAWs7Bf0x+tu8kJ23EIP2uMO8=
X-Forwarded-Encrypted: i=1; AJvYcCUvciIAZF3kZh8anQ4GcsHknqFMt0vtgcrvtJaBrMdxrI9xLeZ548uzed9QTXJ4SsUuyh6JDmA=@vger.kernel.org
X-Received: by 2002:a05:6a21:6d9f:b0:343:9397:c4d6 with SMTP id adf61e73a8af0-3769f335237mr34892463637.23.1767193828897;
        Wed, 31 Dec 2025 07:10:28 -0800 (PST)
X-Received: by 2002:a05:6a21:6d9f:b0:343:9397:c4d6 with SMTP id
 adf61e73a8af0-3769f335237mr34892441637.23.1767193828421; Wed, 31 Dec 2025
 07:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALs4sv0EYR=bMSW6pF6W=W_mZHhQBpkeg=ugwTtpBc7_FyPDug@mail.gmail.com>
 <20251224165301.2794-1-noam.d.eliyahu@gmail.com>
In-Reply-To: <20251224165301.2794-1-noam.d.eliyahu@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Wed, 31 Dec 2025 20:40:17 +0530
X-Gm-Features: AQt7F2o-hmGNq6izxPSNdMLvmcFwX27Xh9pt8ugJKFdZzKaCUjLlPTXgDVNTuLM
Message-ID: <CALs4sv0BdhVHawBkkxN2v2o_jqGyFRAe1RVJjGu9d08HM2Jwug@mail.gmail.com>
Subject: Re: [DISCUSS] tg3 reboot handling on Dell T440 (BCM5720)
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, 
	George Shuklin <george.shuklin@gmail.com>, Lenny Szubowicz <lszubowi@redhat.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000714dde064740e07a"

--000000000000714dde064740e07a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 10:23=E2=80=AFPM Noam D. Eliyahu
<noam.d.eliyahu@gmail.com> wrote:
>
> Thanks for the quick reply!
>
> On Mon, Dec 22, 2025 at 11:23 AM Pavan Chebbi <pavan.chebbi@broadcom.com>=
 wrote:
> >
> > On Sun, Dec 21, 2025 at 11:20 PM Noam D. Eliyahu
> > <noam.d.eliyahu@gmail.com> wrote:
> > >
> > > ### Relevant driver evolution
> > >
> > > * **9931c9d04f4d =E2=80=93 tg3: power down device only on SYSTEM_POWE=
R_OFF**
> >
> > I think this commit id is wrong. Anyway, I know the commit.
>
> My apologies, I likely copied a local hash; the upstream commit ID is 9fc=
3bc764334.
>
> > This is going to be a problem, please follow the discussion here:
> > https://lore.kernel.org/netdev/CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5a=
Wj1tGP0OPJg@mail.gmail.com/
> > where regression risk is flagged and it came true in
> > https://lore.kernel.org/netdev/CALs4sv2_JZd5K-ZgBkjL=3DQpXVEXnoJrjuqwwK=
g0+jo2-4taHJw@mail.gmail.com/
>
> Thank you for the links.
> I understand the need to prevent regressions, especially in an area where=
 it happened before.
> That said, I still think the design of the first and second fixes is prob=
lematic and needs adjusting.
>
> The original bug (Fixed in: 9fc3bc764334) was triggered by SNP initializa=
tion on specific models (R650xs with BCM5720).
> The fix, the conditional tg3_power_down call, *was applied globally regar=
dless of models*.
>
> The second bug I mentioned (Fixed in: e0efe83ed3252) was triggered mainly=
 due to the conditional tg3_power_down call.
> Look again at the changes made in the commit referenced by e0efe83ed3252 =
(2ca1c94ce0b6 as the original fix):
> ```
> +       tg3_reset_task_cancel(tp);
> +
>         rtnl_lock();
> +
>         netif_device_detach(dev);
>
>         if (netif_running(dev))
>                 dev_close(dev);
>
> -       if (system_state =3D=3D SYSTEM_POWER_OFF)
> -               tg3_power_down(tp);
> +       tg3_power_down(tp); /* NOTE: the conditional system state based t=
g3_power_down call was problematic */
>
>         rtnl_unlock();
> +
> +       pci_disable_device(pdev);
>  }
> ```
>
> The changes in 2ca1c94ce0b6 caused the regression which later led to the =
AER disablement in e0efe83ed3252.
> The problem is that it was decided to apply the change to a specific set =
of models, even though it originated from 9fc3bc764334 which was applied gl=
obally.
>
> If we apply the conditional tg3_power_down specifically for the R650xs, w=
e can guarantee no regression, as the logic for the models with the first b=
ug stays the same, just now limited to their set of models.
> By applying the conditional tg3_power_down this way, we won't need the AE=
R disablement at all.
>
> > >
> > > 2. **Flip the conditioning**
> > >    Keep the DMI list, but use it to guard the conditional tg3_power_d=
own instead (only for models where the original issue was observed, e.g. R6=
50xs). Drop the AER handling entirely. This limits risk to known systems wh=
ile simplifying the flow.
>
> > But I am not sure how systems affected in the commit e0efe83ed3252 will=
 react. Can't tell 100pc without testing.
>
> Regarding your concern about systems affected in e0efe83ed3252: my hardwa=
re (Dell PowerEdge T440) is one of the models affected in e0efe83ed3252 but=
 not listed in the initial DMI match list.
> I tested all of the solutions I suggested, others have reported the same =
regarding my first suggestion (to remove both the conditional tg3_power_dow=
n and the AER disablement) online, and most importantly, the e0efe83ed3252 =
commit itself references the original fix (2ca1c94ce0b6) which didn't inclu=
de a specific set of models and was considered a viable fix.
>
> If we restrict the system_state check (from 9fc3bc764334) to a DMI table =
for the R650xs, all other systems would revert to the 'unconditional' tg3_p=
ower_down which was the standard for years. This would naturally prevent th=
e AER errors (as I and others had seen on our machines) without needing to =
touch the AER registers at all.

OK I now understand. You make a lucid argument. 9fc3bc764334 does
indicate that the problem it is trying to fix is very much limited to
R650xs. Hence while I am almost sure that your proposal (about adding
conditional tg3_power_down for R650xs alone) won't break anything for
cc: George, we need an ack from cc: Lenny, to see if he is OK with an
unconditional power down, and that he had no other motive to disable
AER in tg3 config space. In all possible logic, it should just be fine
because e0efe83ed3252 is fixing 9fc3bc764334.
P.S Sorry for the delayed reply. I am on vacation.


>
> For reference:
> - https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?id=3De0efe83ed3252
> - https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?id=3D2ca1c94ce0b6
> - https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?id=3D9fc3bc764334
>
> Best regards,
> Noam D. Eliyahu

--000000000000714dde064740e07a
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCtLvr8
keiQetqQ/Dq/PnN4Yk+XEXtxyoRQYJQ1FbzGZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEyMzExNTEwMjlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAb1f8PLwshICs9RgJtOlAoACnN9egk8nSjJtgyMKxu
BBFWZGzsTUWOMlbE5x7JCwLKo3FqvMZmFc2Vk3rkN1nNj4p3Sm+PjcSsC/SM206wFQP/840P4gd3
tVILYWlgDu7f9DDCm5rEB6sYHmqgvPO7az6ThBIh2gUV7NJSw5cXrbSCJ4uFa9VSFE1z79UmwOQe
Jk1AjZELD89zEFdx3E26BA3NvDGaABpXnQJAKC36Cl0xvy2QB1K9nr5FpvZPPfmCTwMdFKljPMEp
cyTt4WK8zuZQcUoz0wKOP+ukJMyWmOslr1vkXOLtlZMnnrwqhK8B9k1H+8acdYosnMI8UtiK
--000000000000714dde064740e07a--

