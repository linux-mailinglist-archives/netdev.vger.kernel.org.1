Return-Path: <netdev+bounces-132334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52443991446
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C1C284A8B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 04:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3222067;
	Sat,  5 Oct 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KK4O5mRR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF93A8D0
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728102226; cv=none; b=ULi1XYyDxsaFJMEXm9kXoTuGxjS9PZulPXbPu2r8yhhCUe52UKQUBGZu1sA+HZ5AnEx0J1IDDIEUF9kejnahWoLfR5ONFr+QctdGDoB933q9m3K7V2WDcByym2A/nIjLwFare5Q5VOtKehhp6NOzHpn2a39BbJmGQpO2sjnDYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728102226; c=relaxed/simple;
	bh=AFd1Ny4HuqwuVOI67bvomZACMSSfEpfM7qwiSUC0Lak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZS9OhFkbru0KjPZ4Hr27iXuwuC46gPGvj6TxzrVo1GrJIfhFFFVfJmbw5F4JFqSqCWmqfDQRZd6FHRYdxhh6yv9tU6ekYO8tCn0IUm6J1eUGvJJqg4DeI/twAJHc/pPfK1gzJPOaQ9Tt4BNHutSCmeVraaMMTObFRrMa0FgaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KK4O5mRR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53993564cb1so3209197e87.2
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728102223; x=1728707023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wJqKCPcA6yzaD+SBwswKGoaZ5dBaVSEC31DVLqv2oc=;
        b=KK4O5mRRsq4VdSvET+PwNwSPHtm5bhET7fXx6HR2nBBDceFUOjf2wYfwlD3K17f/o1
         7HO3LaxLZU0JyAem3FgEQVta4qcknIg53uxrrIIOgCVsi1ybpmd9bNxTko4vK9X/zStc
         RL7P+kgLob4G6YmMeZkBXqLydbgzRA5F34kHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728102223; x=1728707023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wJqKCPcA6yzaD+SBwswKGoaZ5dBaVSEC31DVLqv2oc=;
        b=ZxPvpCPad+H1TQ+l3WNmcVQpgfVzVXIxpDR2iVHr8eKV6MP0kjn5JvQxySf6IjrQdt
         JZKqY+mT+prIP+rzqMEzuxLTA8VYtl1v7cY3+9NEYvy+66hFI9zBJs52wKbpx7A3RQKe
         8xmIfIrccDETyMOvUP67hnFk7ZjX/0tcyJFuDLFTzoxg/aiR7ckqZKDROozNHAjh2QdX
         i3YFc/5BPFnxyZby77ofbx8FxpVVyJWH9Z+jHw9YCjo6zb5hwEWisooyJvwKSeAR++Q+
         Ae8dwFIf65n3SR/BhrRaRdgtkcA8VuCHvEKSsXpK+edfUFiEHC7Q5YalxD/fJnthE0p0
         gO5g==
X-Gm-Message-State: AOJu0YwlISRiEfy4A5h+5wBf3QcANdh1Jv54t8m/G4SeLhisW2RF1S+T
	K4TYv8uSTF+1ze6Q5lzFZK51qZiBCnwepla7LQPFkA+W6CGYlYfVuou5mb9W5yfC5Ff+H+UyWyv
	W1Ah6nNqM45tMsUOji5Dy+eX5TAWTGQVH5FCd
X-Google-Smtp-Source: AGHT+IFcTRMTcHjGUNjOo2TbAvfaLyRY77q7zaPrDz6VjK0/ZatYp0EdmgjZmmdDQgYuK2AKSVETssloCvsVEDjHU1k=
X-Received: by 2002:a05:6512:2315:b0:539:94cf:e327 with SMTP id
 2adb3069b0e04-539ab8ae2b0mr2624151e87.37.1728102223018; Fri, 04 Oct 2024
 21:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004204953.2223536-1-sanman.p211993@gmail.com>
In-Reply-To: <20241004204953.2223536-1-sanman.p211993@gmail.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Sat, 5 Oct 2024 09:53:30 +0530
Message-ID: <CAH-L+nO6U12TRCUWNxjAFTSwaMfeadt+iHYtYFZHVJFOZH0sdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net, horms@kernel.org, 
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch, 
	linux-hwmon@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002acb7c0623b32722"

--0000000000002acb7c0623b32722
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sanman,

It looks like you missed one comment. See in line.

On Sat, Oct 5, 2024 at 2:20=E2=80=AFAM Sanman Pradhan <sanman.p211993@gmail=
.com> wrote:
>
> From: Sanman Pradhan <sanmanpradhan@meta.com>
>
> This patch adds support for hardware monitoring to the fbnic driver,
> allowing for temperature and voltage sensor data to be exposed to
> userspace via the HWMON interface. The driver registers a HWMON device
> and provides callbacks for reading sensor data, enabling system
> admins to monitor the health and operating conditions of fbnic.
>
> Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>
>
> ---
> v3:
>   - Add missing "id" initialization in fbnic_hwmon_read
>   - Change ifm_hwmon_unregister to hwmon_unregister
>
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241003173618.2=
479520-1-sanman.p211993@gmail.com/
>
> v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@r=
oeck-us.net/T/
>
> ---
>  drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
>  drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  7 +-
>  5 files changed, 99 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
>
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ether=
net/meta/fbnic/Makefile
> index ed4533a73c57..41494022792a 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -11,6 +11,7 @@ fbnic-y :=3D fbnic_devlink.o \
>            fbnic_ethtool.o \
>            fbnic_fw.o \
>            fbnic_hw_stats.o \
> +          fbnic_hwmon.o \
>            fbnic_irq.o \
>            fbnic_mac.o \
>            fbnic_netdev.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethern=
et/meta/fbnic/fbnic.h
> index 0f9e8d79461c..2d3aa20bc876 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -18,6 +18,7 @@
>  struct fbnic_dev {
>         struct device *dev;
>         struct net_device *netdev;
> +       struct device *hwmon;
>
>         u32 __iomem *uc_addr0;
>         u32 __iomem *uc_addr4;
> @@ -127,6 +128,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
>  int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
>  void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
>
> +void fbnic_hwmon_register(struct fbnic_dev *fbd);
> +void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
> +
>  int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
>  void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_hwmon.c
> new file mode 100644
> index 000000000000..bcd1086e3768
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/hwmon.h>
> +
> +#include "fbnic.h"
> +#include "fbnic_mac.h"
> +
> +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
> +{
> +       if (type =3D=3D hwmon_temp)
> +               return FBNIC_SENSOR_TEMP;
> +       if (type =3D=3D hwmon_in)
> +               return FBNIC_SENSOR_VOLTAGE;
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static umode_t fbnic_hwmon_is_visible(const void *drvdata,
> +                                     enum hwmon_sensor_types type,
> +                                     u32 attr, int channel)
> +{
> +       if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input)
> +               return 0444;
> +       if (type =3D=3D hwmon_in && attr =3D=3D hwmon_in_input)
> +               return 0444;
> +
> +       return 0;
> +}
> +
> +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types =
type,
> +                           u32 attr, int channel, long *val)
> +{
> +       struct fbnic_dev *fbd =3D dev_get_drvdata(dev);
> +       const struct fbnic_mac *mac =3D fbd->mac;
> +       int id;
> +
> +       id =3D fbnic_hwmon_sensor_id(type);
> +       return id < 0 ? id : mac->get_sensor(fbd, id, val);
> +}
> +
> +static const struct hwmon_ops fbnic_hwmon_ops =3D {
> +       .is_visible =3D fbnic_hwmon_is_visible,
> +       .read =3D fbnic_hwmon_read,
> +};
> +
> +static const struct hwmon_channel_info *fbnic_hwmon_info[] =3D {
> +       HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +       HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
> +       NULL
> +};
> +
> +static const struct hwmon_chip_info fbnic_chip_info =3D {
> +       .ops =3D &fbnic_hwmon_ops,
> +       .info =3D fbnic_hwmon_info,
> +};
> +
> +void fbnic_hwmon_register(struct fbnic_dev *fbd)
> +{
> +       if (!IS_REACHABLE(CONFIG_HWMON))
> +               return;
> +
> +       fbd->hwmon =3D hwmon_device_register_with_info(fbd->dev, "fbnic",
> +                                                    fbd, &fbnic_chip_inf=
o,
> +                                                    NULL);
> +       if (IS_ERR(fbd->hwmon)) {
> +               dev_notice(fbd->dev,
> +                          "Failed to register hwmon device %pe\n",
> +                       fbd->hwmon);
> +               fbd->hwmon =3D NULL;
> +       }
> +}
> +
> +void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
> +{
> +       if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
> +               return;
> +
> +       hwmon_device_unregister(fbd->hwmon);
> +       fbd->hwmon =3D NULL;
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/et=
hernet/meta/fbnic/fbnic_mac.h
> index 476239a9d381..05a591653e09 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> @@ -47,6 +47,11 @@ enum {
>  #define FBNIC_LINK_MODE_PAM4   (FBNIC_LINK_50R1)
>  #define FBNIC_LINK_MODE_MASK   (FBNIC_LINK_AUTO - 1)
>
> +enum fbnic_sensor_id {
> +       FBNIC_SENSOR_TEMP,              /* Temp in millidegrees Centigrad=
e */
> +       FBNIC_SENSOR_VOLTAGE,           /* Voltage in millivolts */
> +};
> +
>  /* This structure defines the interface hooks for the MAC. The MAC hooks
>   * will be configured as a const struct provided with a set of function
>   * pointers.
> @@ -83,6 +88,8 @@ struct fbnic_mac {
>
>         void (*link_down)(struct fbnic_dev *fbd);
>         void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pau=
se);
> +
> +       int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
>  };
>
>  int fbnic_mac_init(struct fbnic_dev *fbd);
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/et=
hernet/meta/fbnic/fbnic_pci.c
> index a4809fe0fc24..debd98ea55e2 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>
>         fbnic_devlink_register(fbd);
>
> +       fbnic_hwmon_register(fbd);
> +
>         if (!fbd->dsn) {
>                 dev_warn(&pdev->dev, "Reading serial number failed\n");
>                 goto init_failure_mode;
[Kalesh] You should change this label to "hwmon_unregister" as you
should unregister hwmon in case of failure here.

> @@ -297,7 +299,7 @@ static int fbnic_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>         netdev =3D fbnic_netdev_alloc(fbd);
>         if (!netdev) {
>                 dev_err(&pdev->dev, "Netdev allocation failed\n");
> -               goto init_failure_mode;
> +               goto hwmon_unregister;
>         }
>
>         err =3D fbnic_netdev_register(netdev);
> @@ -310,6 +312,8 @@ static int fbnic_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
>
>  ifm_free_netdev:
>         fbnic_netdev_free(fbd);
> +hwmon_unregister:
> +       fbnic_hwmon_unregister(fbd);
>  init_failure_mode:
>         dev_warn(&pdev->dev, "Probe error encountered, entering init fail=
ure mode. Normal networking functionality will not be available.\n");
>          /* Always return 0 even on error so devlink is registered to all=
ow
> @@ -345,6 +349,7 @@ static void fbnic_remove(struct pci_dev *pdev)
>                 fbnic_netdev_free(fbd);
>         }
>
> +       fbnic_hwmon_unregister(fbd);
>         fbnic_devlink_unregister(fbd);
>         fbnic_fw_disable_mbx(fbd);
>         fbnic_free_irqs(fbd);
> --
> 2.43.5
>


--=20
Regards,
Kalesh A P

--0000000000002acb7c0623b32722
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
AQkEMSIEID4tH0XwOY8UhRVgVWgQxzOwZealKSKAMKnttrEZsOlaMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAwNTA0MjM0M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBetdFFRfL9
IuKL71c9LpN2DS3iDnTpTd9Ls/8WQ6NeCmkO8syf/xt2I15pKpcgjRj4glOx3pBWBnrUPnoSKbK7
gL62TakCnzDLPRRvHRfc9FXBn71VEzdp0udcR9hUe+RvV7VLP43xELsB+DNWRPg3EF+PqlBvvwk7
ATviUkY/NnyiV1PwS4TX6+BLhI6sKd8rBt2Z5tCZ2/uE0P/JpF7onJ4wqip49l0X6DscxP0s26N6
58zIV2F0GxvOAwFeVTW2G3exo7TIsZ2YXtKf9m2QV+YB8ds4aD1bCIgn9tll93AdVMjTKvUk4FfM
wOBZ9EOGMsLMAAZrQbFTPO5mF0vJ
--0000000000002acb7c0623b32722--

