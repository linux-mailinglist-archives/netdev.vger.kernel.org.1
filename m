Return-Path: <netdev+bounces-126884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB3972C64
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CA1287400
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BD187857;
	Tue, 10 Sep 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hXIrGUOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763718754D
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957683; cv=none; b=kHE+7ixuYgLsEukpsIbHErZQXtgaAINRF7BQFhBBb8B1kVxYE29S4aeCNOyiwcrNsWY32NMZSo6UNoqg1vaolWtvDgTQ17gjX6itWeyPK+CnUb8v4J6pYbkWB4yia06AjKhOzRtKqRXidAYIh1ypvwiKVBEkbnS9oaLbD6BRoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957683; c=relaxed/simple;
	bh=h3cd4gSZ2HmOylFhWWptsXjKQ96ZljxG3F3gMUmWV7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awc/QL2K6fdHkmxriwETNfR7Lxe+1BjZSxATfzDYwKWwAb3H8ZluWq+dd7Gjv3z1O+oN8DPAP5QIEV3Csjz3vabAj7IbHlybcmOJd55rWZ/myZVwDjxnLaHTAjd3m18yaq/FiVdaHCKOkYMx1QzK21tZmW1pgWWbH/o+w+MYd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hXIrGUOr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53653ff0251so6219243e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725957680; x=1726562480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uW2QdQj0wloRSWFt8Gzz+LlVmrD8yr5NNCkCqNcwXLo=;
        b=hXIrGUOrAF46MN09Glw/CK8qgSDgjS9KUy30XTig8sY+jEokZXX0QAxHbJH4BOvIfO
         WlktH2fKrIfJSJTv2b5taQWHqNpJq6LxQLXrBp1j2Qlp5vIXcSACInYlsTeqW5nH2B2z
         DNdG1KpeXRW4Vfce7v/wIBAtKdsUUHJoLH2Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957680; x=1726562480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uW2QdQj0wloRSWFt8Gzz+LlVmrD8yr5NNCkCqNcwXLo=;
        b=eiM82jTD19BdpIBbLw23G72rpKllh4ty7aSne3vminuy3DocQuxPhpZz52ThWNCblN
         FL35zxa9ws6lK1x25C44mqd+wqBD5QNTNdxskZ1fHLN5DRlCgMZBXJ3QnmIRiCZAJ4Se
         z+Cm14Xe3x/F2xFR1pVtSQj5harF4t6EGGKIgfFWpV9XpxtdpNw4Z/2dki0XgkpZsO/B
         1XZjQe/u1a1GsfFg/UJdvht2xDtwZWq140VS9JMiNP18aKD3rkHNC42rEq0lU4XIkghG
         8+gxlUrlFWod24wh130j4MLfY1DQHMQcZrW3kB7TPFVsQOIshkQFDRDn3ZHBKjo65X4w
         qEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU53nDyhEJCB1pC4Sq0FEXyxwMHpMgFUQv8+5w+oh+9GICWfiDfYebGYUDqcK0wVvPh/hUavLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9X1hVOoSSs1OhyNsL3AObZJ7B/U1LmuF1Po1N4DtE9gK/WY7y
	xYWtTBJ0s+e516MTDQ3kILBAdLA8sR02pCCFv0f6W6vJsfnvK6rdaSq2C5nmsju6MJ+PseveO5m
	26IrsHojveQiYeQi62R+Ro++BW5WhUPHdXp/m
X-Google-Smtp-Source: AGHT+IF8g6kvgX7mKw1bv/O6WZUDdVt2r95JVoG0Slu/IUNC0c2XDvoAirWIhaByyxBD351VDNV4OOq+DzYHU0h7bV8=
X-Received: by 2002:a05:6512:10cf:b0:536:536a:3854 with SMTP id
 2adb3069b0e04-5365881a749mr7055762e87.60.1725957679532; Tue, 10 Sep 2024
 01:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910075942.1270054-1-shaojijie@huawei.com> <20240910075942.1270054-9-shaojijie@huawei.com>
In-Reply-To: <20240910075942.1270054-9-shaojijie@huawei.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Sep 2024 14:11:07 +0530
Message-ID: <CAH-L+nNmkJt2TXh7YLb68pET-mBEwtbMS03=iVzeVke90E=AQg@mail.gmail.com>
Subject: Re: [PATCH V9 net-next 08/11] net: hibmcge: Implement some
 ethtool_ops functions
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, sudongming1@huawei.com, 
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com, 
	andrew@lunn.ch, jdamato@fastly.com, horms@kernel.org, 
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, 
	salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006f598d0621bfd64c"

--0000000000006f598d0621bfd64c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 1:36=E2=80=AFPM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> Implement the .get_drvinfo .get_link .get_link_ksettings to get
> the basic information and working status of the driver.
> Implement the .set_link_ksettings to modify the rate, duplex,
> and auto-negotiation status.
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> ChangeLog:
> RFC v1 -> RFC v2:
>   - Use ethtool_op_get_link(), phy_ethtool_get_link_ksettings(),
>     and phy_ethtool_set_link_ksettings() to simplify the code, suggested =
by Andrew.
>   - Delete workqueue for this patch set, suggested by Jonathan.
>   RFC v1: https://lore.kernel.org/all/20240731094245.1967834-1-shaojijie@=
huawei.com/
> ---
>  .../ethernet/hisilicon/hibmcge/hbg_ethtool.c    | 17 +++++++++++++++++
>  .../ethernet/hisilicon/hibmcge/hbg_ethtool.h    | 11 +++++++++++
>  .../net/ethernet/hisilicon/hibmcge/hbg_main.c   |  2 ++
>  3 files changed, 30 insertions(+)
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
>  create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
>
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drive=
rs/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
> new file mode 100644
> index 000000000000..c3370114aef3
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2024 Hisilicon Limited.
> +
> +#include <linux/ethtool.h>
> +#include <linux/phy.h>
> +#include "hbg_ethtool.h"
> +
> +static const struct ethtool_ops hbg_ethtool_ops =3D {
> +       .get_link               =3D ethtool_op_get_link,
> +       .get_link_ksettings     =3D phy_ethtool_get_link_ksettings,
> +       .set_link_ksettings     =3D phy_ethtool_set_link_ksettings,
> +};
> +
> +void hbg_ethtool_set_ops(struct net_device *netdev)
> +{
> +       netdev->ethtool_ops =3D &hbg_ethtool_ops;
> +}
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h b/drive=
rs/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
> new file mode 100644
> index 000000000000..628707ec2686
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) 2024 Hisilicon Limited. */
> +
> +#ifndef __HBG_ETHTOOL_H
> +#define __HBG_ETHTOOL_H
> +
> +#include <linux/netdevice.h>
> +
> +void hbg_ethtool_set_ops(struct net_device *netdev);
> +
> +#endif
> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/=
net/ethernet/hisilicon/hibmcge/hbg_main.c
> index a8d0e951633b..b06524c336e2 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> @@ -6,6 +6,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/pci.h>
>  #include "hbg_common.h"
> +#include "hbg_ethtool.h"
>  #include "hbg_hw.h"
>  #include "hbg_irq.h"
>  #include "hbg_mdio.h"
> @@ -235,6 +236,7 @@ static int hbg_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
>         netdev->min_mtu =3D priv->dev_specs.min_mtu;
>         hbg_change_mtu(priv, HBG_DEFAULT_MTU_SIZE);
>         hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
> +       hbg_ethtool_set_ops(netdev);
>         ret =3D devm_register_netdev(dev, netdev);
>         if (ret)
>                 return dev_err_probe(dev, ret, "failed to register netdev=
\n");
> --
> 2.33.0
>


--=20
Regards,
Kalesh A P

--0000000000006f598d0621bfd64c
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
AQkEMSIEIASItLQirSc+d8DK88FI1t5Ruoj9sxK/h1A0fKB1hsj9MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxMDA4NDEyMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBIdFRaI3Ug
8pXAzMpauC7K8wuNnkJdoNt4M7FxRr9BLChT/uZgCieRvsUkMzCriZ+Xf1gnJDjCJ/Ikx2bj07wS
3fW+Z15EqiBFJNt4ntwTNAUmjuYerkErvoxLQ6sveOnfRa5gN3ae1Kf+UUjVTujNUuNOSYK85m28
Cb473e2QvwsfMJBRg7KxA8op5hIR/1LaeXOlKiftypzm+Z2x2X0NZ03lUWRdAICHBza1edE+P6VC
v9TQWv9RuYZBdMfb4ZyAJ1PEfvAhhFSCG7dvetPHbMPdTzYcTHkaaSoiZwdZacpDqoN0ZwA1vAFS
zfS0R/9rsSFmEvtI43PlGfSOawiQ
--0000000000006f598d0621bfd64c--

