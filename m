Return-Path: <netdev+bounces-130461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B198A998
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A98BB2426E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B7192B99;
	Mon, 30 Sep 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UB1hQFup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDB44C6F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713129; cv=none; b=RjOUPzETmyViF4UnfcgJXN6Y7u11LOyrWT+TgnSWVuu33ca9xHgJEEdbOfJpNe4XFiOO2J06k7k7W4zTCULeCLEipO7nPTxjIHaImw58/UNDxL8C3H7VXgv5gjCjbHouJe+nPFtyM8adfXX59KmwBjc4JSOpmzI6wlK6SsJs1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713129; c=relaxed/simple;
	bh=R9/cKGZ5DoyHP9mQ4ZOE1J3f+thus+8nN60kinEMIf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEutPkrbVXKhwHtoy3gqPHM0mC7NHDLDZDCI+Bq+YGpZjH32a6z6B6PKzid8jhSHchyxvbMF0c2rXCJWb6a8PwWg1QO2fXQd75/6tlmYZARIS9I6xI+tpY217bPbi4oSMw+M7DdMglYH59Q2o4LE1LBfSk1Fai/avOlnhwuD8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UB1hQFup; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53997328633so1499261e87.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727713126; x=1728317926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9olNx5lYv5bGX1/YEVecjmbSFPThGw+U1bPOFF4z4w=;
        b=UB1hQFup5PJOG81HWy4puDQGICk5ceZXDQbKzTzC+HlwRaG8RrK2dBzbRLgi2Ser+u
         uPcw5f9ir7B1bY+ycR6RDo14MlBkoppdee5xSzj7PGh12mPOJLupD0qsnhBaewFkP6ZE
         5Ek5bQZlqioxmEUF1F3P1tD/uGNLZnkT5QWak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713126; x=1728317926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9olNx5lYv5bGX1/YEVecjmbSFPThGw+U1bPOFF4z4w=;
        b=RuNNGuygJjneTlVkqR5B5pF9Hjewa5ghLIDpqSXKL77rBkPujGeK7cqBy79gEXgxZD
         dYKCxci9PaVVDeiKZZz+kDah+uGhEwnbdp4ng5X2jERI4Yx5qmHMH6E8A1WSgDK7bZB/
         oxgz/JmNxgByb3pVrj8rL65uY0Z3kcDKRKNIjVES77DHTiEjyeY7ASX6/dm7JR33CSiW
         9qatTZtF0cnQHwvMmJIIJ6CkAUssApqo7UH9BR53Eb/wU9h7slkVx25bv16xbIWoDMML
         naCb74UaRVx3CvS56uwcRkQwDM83Jw/s0nj65tOwlLG+yEXpbq+mIS+Y2ZSkosq8QdXc
         w3xg==
X-Forwarded-Encrypted: i=1; AJvYcCV75818ubo+G9z46GygR++WqqEz6wZC4/lBbFbPv6tFWCC8lnaczLyNCwwZJeVJNf4rQcMLIfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZo5H/JPo/rwLey6sFCHtCTA9K9bzac+Twfq4gix0tbDqLA4uj
	H0vXWjbdCydFf4WEZ4VRYEkKxrvUsTFIxqxzh0d/bHB1GBniFRCRsc/9l1wry/9Ij+PIggTxye7
	rA6mI7nxGSuJhvapHsH1AP28JI569vTFwpdO8
X-Google-Smtp-Source: AGHT+IGigRT0yCkmtZ8InOp2tbjuf/SkpFtdf3UAEvBv/nqkw3gHS1Lf4fsBJZTC5sJdykycN+ilm4KARu7hOB8iGs4=
X-Received: by 2002:a05:6512:39c6:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53994f50221mr3264089e87.59.1727713125661; Mon, 30 Sep 2024
 09:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930153423.16893-1-divya.koppera@microchip.com>
In-Reply-To: <20240930153423.16893-1-divya.koppera@microchip.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 30 Sep 2024 21:48:32 +0530
Message-ID: <CAH-L+nMy5k7fvypd_7SczKs=5ZkpOZb2B3RwTz4sCHmrjdX7+A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Interrupt support for lan887x
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000289ce30623588fbd"

--000000000000289ce30623588fbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:02=E2=80=AFPM Divya Koppera
<divya.koppera@microchip.com> wrote:
>
> Add support for link up and link down interrupts in lan887x.
>
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
>  drivers/net/phy/microchip_t1.c | 63 ++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t=
1.c
> index a5ef8fe50704..383050a5b0ed 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -226,6 +226,18 @@
>  #define MICROCHIP_CABLE_MAX_TIME_DIFF  \
>         (MICROCHIP_CABLE_MIN_TIME_DIFF + MICROCHIP_CABLE_TIME_MARGIN)
>
> +#define LAN887X_INT_STS                                0xf000
> +#define LAN887X_INT_MSK                                0xf001
> +#define LAN887X_INT_MSK_T1_PHY_INT_MSK         BIT(2)
> +#define LAN887X_INT_MSK_LINK_UP_MSK            BIT(1)
> +#define LAN887X_INT_MSK_LINK_DOWN_MSK          BIT(0)
> +
> +#define LAN887X_MX_CHIP_TOP_LINK_MSK   (LAN887X_INT_MSK_LINK_UP_MSK |\
> +                                        LAN887X_INT_MSK_LINK_DOWN_MSK)
> +
> +#define LAN887X_MX_CHIP_TOP_ALL_MSK    (LAN887X_INT_MSK_T1_PHY_INT_MSK |=
\
> +                                        LAN887X_MX_CHIP_TOP_LINK_MSK)
> +
>  #define DRIVER_AUTHOR  "Nisar Sayed <nisar.sayed@microchip.com>"
>  #define DRIVER_DESC    "Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
>
> @@ -1474,6 +1486,7 @@ static void lan887x_get_strings(struct phy_device *=
phydev, u8 *data)
>                 ethtool_puts(&data, lan887x_hw_stats[i].string);
>  }
>
> +static int lan887x_config_intr(struct phy_device *phydev);
[Kalesh] I would suggest you to avoid this forward declaration by
moving the function definition here.

>  static int lan887x_cd_reset(struct phy_device *phydev,
>                             enum cable_diag_state cd_done)
>  {
> @@ -1504,6 +1517,10 @@ static int lan887x_cd_reset(struct phy_device *phy=
dev,
>                 if (rc < 0)
>                         return rc;
>
> +               rc =3D lan887x_config_intr(phydev);
> +               if (rc < 0)
> +                       return rc;
> +
>                 rc =3D lan887x_phy_reconfig(phydev);
>                 if (rc < 0)
>                         return rc;
> @@ -1830,6 +1847,50 @@ static int lan887x_cable_test_get_status(struct ph=
y_device *phydev,
>         return lan887x_cable_test_report(phydev);
>  }
>
> +static int lan887x_config_intr(struct phy_device *phydev)
> +{
> +       int ret;
> +
> +       if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> +               /* Clear the interrupt status before enabling interrupts =
*/
> +               ret =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_=
STS);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Unmask for enabling interrupt */
> +               ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT=
_MSK,
> +                                   (u16)~LAN887X_MX_CHIP_TOP_ALL_MSK);
> +       } else {
> +               ret =3D phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT=
_MSK,
> +                                   GENMASK(15, 0));
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_=
STS);
> +       }
> +
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
> +{
> +       int ret =3D IRQ_NONE;
> +       int irq_status;
> +
> +       irq_status =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_S=
TS);
> +       if (irq_status < 0) {
> +               phy_error(phydev);
> +               return IRQ_NONE;
> +       }
> +
> +       if (irq_status & LAN887X_MX_CHIP_TOP_LINK_MSK) {
> +               phy_trigger_machine(phydev);
> +               ret =3D IRQ_HANDLED;
> +       }
> +
> +       return ret;
> +}
> +
>  static struct phy_driver microchip_t1_phy_driver[] =3D {
>         {
>                 PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
> @@ -1881,6 +1942,8 @@ static struct phy_driver microchip_t1_phy_driver[] =
=3D {
>                 .read_status    =3D genphy_c45_read_status,
>                 .cable_test_start =3D lan887x_cable_test_start,
>                 .cable_test_get_status =3D lan887x_cable_test_get_status,
> +               .config_intr    =3D lan887x_config_intr,
> +               .handle_interrupt =3D lan887x_handle_interrupt,
>         }
>  };
>
> --
> 2.17.1
>
>


--=20
Regards,
Kalesh A P

--000000000000289ce30623588fbd
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
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIMpPrqUQ3ywfOEj9b0iKJHYg13bAaNi2pcRRYG/v9IevMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkzMDE2MTg0NlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMAZkXfVbc
49JQeoyJ67xQcSqYtghhwuvxCaauGk53DN9YGMzBi326WQ3N6IfghKyFiPmbJGRyd5q62gvZjjEL
7hk9h6Xqu96M31Z7AVnfJ+Ug3Shx0X5Y+RyWGSBqEpNOMRFiamB0QMsTv1z3cuMRoZBJ4S9L2GWE
qm+b7bmctbW8O7EX+R4av+6cJ2JjNumpzeua7HjLdX2cCLamuld8iFMe6MnY79uX4C+c5H3y/kgq
UL8MpfQCMp7zRb0CN3lKTupmIeIMww74qSQBRzxanTdlYECKQxBN5DfcX7DjtfHs+QTYKcN9c5hv
rKAh2LQ+61pP790WzFjeGPpxevWE
--000000000000289ce30623588fbd--

