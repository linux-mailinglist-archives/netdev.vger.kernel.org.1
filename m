Return-Path: <netdev+bounces-147986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B99DFAF0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 08:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E492811AA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFABD1F8EE7;
	Mon,  2 Dec 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I0pKggZk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D21D61A1
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733122822; cv=none; b=q70ZxyC5ETgSVj+B4TDk2DMFJ5NSutOxuhsU8m13aIwzZU3f+R+sK6TMcDbLKCR+HVhflqdsp2FIgVnjv1TS+L0O8lAJlC6WZk99908OConj0Tq+qvJOpGZXHrAGwnHfyHVfU9LGJ3sKPTOxXBIaPoWGDVQQCR8izihypSccfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733122822; c=relaxed/simple;
	bh=2C6Yrt2urDlmAVMXR485Z5Hh0y/vI6IHuUXjRMnThDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNGtfrOmFfFPUA5jF5rDmRLpwyrQ8waogIzFxNW9UxBklYhlU/YBI+Bgjufzy0MNp2l0rbJ6ZqQWuuhgpgjlebaUPNeVTUxCFqW8oT84VHcSJqwMdttXOzdBHv7fk6d6wgxK53O6gLLgwZS4VQxwwp9nEOXYOMLFvaRx2pud85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I0pKggZk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso440217a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733122820; x=1733727620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWCf7nPk2Xcr//nmycGCs1K48k3d0D3DC1CuBkuYhZ8=;
        b=I0pKggZkU0QrwKkuFnP38ANMblbztyD+QGST7ht0oId6aDzGRFCrRaDvRiJhb7Mq2d
         pK1w4Bno7Rsd+9swNdhIUdaORZeGj+N5SmVx3sr+wlXpEK9GKFaQbbnpEMCAXK6XcgEN
         2MXhI6gfL17qraI6AUSAiao9HC7cwCuep4tK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733122820; x=1733727620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWCf7nPk2Xcr//nmycGCs1K48k3d0D3DC1CuBkuYhZ8=;
        b=OMMlzOZvCXj0rOjX4d1HjARkyw1y22V3luVJCn4xnswKRxG0+LG4NMz0tTHNI6BsSh
         NUkD1d7MzjlmPQdNdCTyOrtPi8XtfMpUmj4ryAhYjeqrlRWsQsWRuanwxB17fPtiRk+N
         4pzmDNxrQEjL69BjVBGEARz3Flh4XKRlr7QK61JiJq6FYlR+4djMT30QNSiRrlAqgINl
         SwHHmLTZ1XI5S9Ql/+EMMpMPnPaZcVbhxoMCyQzTSO5pLGI+2kFAHxw3cxzIP3rABJVL
         V4bFZhLzDna61UvsgQKKeeBGCs0lnqpYU8H+aqMv3/aHeeefn6Y5H2GQjh+nA02kCHHV
         IHag==
X-Forwarded-Encrypted: i=1; AJvYcCVUKX2Gryv1kJDrtmvKk3SseP9JduW6rQTrTHjtM4anu4wjmzj8nZvXgm5MKUE64vroQ303f4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7RRUxGaOk7fRzHzkCkhir+nFHwQc8Xz6iwcnkjmIgwh7Dkol
	xUogw5Y2hKO+8EuFqjoKWcCPuxmDc4zcmh8gLQKYcaR6HmVhe599VszJ5hZ5YitbhCExsUWAC9A
	TI0GbJd6sBVZIzOzjNpmE8Jz5v8yrygKD0Oht
X-Gm-Gg: ASbGncumaB3EJ9MQ/hk3vDyit7c3lbqbO4cIxCodB5Vm2FOY6NSiHp13FSfUNSLPi5l
	Es6pI2Ah/N32t6JhwuP5Oy7gJdFMPpD8=
X-Google-Smtp-Source: AGHT+IGvmYoDrdIzwnrn7AxfIo5VP7V4JZAIUJ5mIySK7wnf3MYZziqR2sFggpey94MYsTnSUqnk2ZOa0vtjaR0BmU4=
X-Received: by 2002:a17:90b:4b4f:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2ee08eb2f04mr30022157a91.15.1733122820263; Sun, 01 Dec 2024
 23:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129203640.54492-1-lszubowi@redhat.com>
In-Reply-To: <20241129203640.54492-1-lszubowi@redhat.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 2 Dec 2024 12:30:07 +0530
Message-ID: <CALs4sv0HUQjFEv_mZn0jabSDuxfuu4K6f9vFmUuzMtjZLVKc8A@mail.gmail.com>
Subject: Re: [patch v2] tg3: Disable tg3 PCIe AER on system reboot
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	george.shuklin@gmail.com, andrea.fois@eventsense.it, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000168f190628441a17"

--000000000000168f190628441a17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 2:06=E2=80=AFAM Lenny Szubowicz <lszubowi@redhat.co=
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

Are you saying that if we have tg3_power_down() done then the current
new issue won't be seen?

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

Not too sure about this. The list has some widely used latest Dell
servers. The first fix only did pci_disable_device()
But looks like this fix should be the right one for the first ever
reported issue in commit 2ca1c94ce0b6 ?

Also you may want to address the warnings generated. Also note that
netdev requires you to wait 24hours before posting a new revision of
the patch.

>
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 59 +++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 9cc8db10a8d6..12ae5a976ca7 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -55,6 +55,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/crc32poly.h>
> +#include <linux/dmi.h>
>
>  #include <net/checksum.h>
>  #include <net/gso.h>
> @@ -18192,6 +18193,51 @@ static int tg3_resume(struct device *device)
>
>  static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
>
> +/*
> + * Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
> + * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
> + * be, powered down.
> + */
> +static const struct dmi_system_id tg3_restart_aer_quirk_table[] =3D {
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
> +               },
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
> +               },
> +       },
> +       {}
> +};
> +
>  static void tg3_shutdown(struct pci_dev *pdev)
>  {
>         struct net_device *dev =3D pci_get_drvdata(pdev);
> @@ -18208,6 +18254,19 @@ static void tg3_shutdown(struct pci_dev *pdev)
>
>         if (system_state =3D=3D SYSTEM_POWER_OFF)
>                 tg3_power_down(tp);
> +       else if (system_state =3D=3D SYSTEM_RESTART &&
> +                dmi_first_match(tg3_restart_aer_quirk_table) &&
> +                pdev->current_state <=3D PCI_D3hot) {
> +               /*
> +                * Disable PCIe AER on the tg3 to avoid a fatal
> +                * error during this system restart.
> +                */
> +               pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
> +                                          PCI_EXP_DEVCTL_CERE |
> +                                          PCI_EXP_DEVCTL_NFERE |
> +                                          PCI_EXP_DEVCTL_FERE |
> +                                          PCI_EXP_DEVCTL_URRE);
> +       }
>
>         rtnl_unlock();
>
> --
> 2.45.2
>

--000000000000168f190628441a17
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
XzCCBUwwggQ0oAMCAQICDBX9eQgKNWxyfhI1kzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE3NDZaFw0yNTA5MTAwODE3NDZaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDFBhdmFuIENoZWJiaTEoMCYGCSqGSIb3DQEJ
ARYZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAK3X+BRR67FR5+Spki/E25HnHoYhm/cC6VA6qHwC3QqBNhCT13zsi1FLLERdKXPRrtVBM6d0
mfg/0rQJJ8Ez4C3CcKiO1XHcmESeW6lBKxOo83ZwWhVhyhNbGSwcrytDCKUVYBwwxR3PAyXtIlWn
kDqifgqn3R9r2vJM7ckge8dtVPS0j9t3CNfDBjGw1DhK91fnoH1s7tLdj3vx9ZnKTmSl7F1psK2P
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA0v3rC4wGVTSyOCBnK/dc4F8K9vvFsF
Gi3ux7dOK5SOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIw
MjA3MDAyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAL4UDyntSuwxw8ckhSXIZgA6bCPxxRDydc4a0Ypxus81QiFr1e
nMBxOgu70yd2Wq9p/hZwYpWkUL0Vd33l3zCEc50xsPQMZh6f+HJXWi3IkJFX7zFrCktCxXue/FhL
EoCzffEnHmn2SExAoQDrRN/OQzQK1166+3gbwmFnpTT5gmghGWSRZ6lXD0R4I0gkrX4Tv8Z+/Na7
kUmEw2EmFXkKws8J7Q+JhgD9riD0AAb55dfdMZiFDl2eE9fA87C7eWz0CyJBbpgsA2eFhSpkCdH9
/ufVp5wfC2kP1uWlfZ/+JjD6SepbcxnEpgxCgefDfzXRB5jWJE1nDKGAO6f6bJoM
--000000000000168f190628441a17--

