Return-Path: <netdev+bounces-134746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCC699AF96
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 02:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE631C210EF
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE5B672;
	Sat, 12 Oct 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIlmPiEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA44C8E;
	Sat, 12 Oct 2024 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728691327; cv=none; b=PGNOZPcptpTx/UU2KoPiAig9fafD9BncUvCwBLp/iovLtGhNhBdpBjchoh8i1HwFPIhOQO31pxRWfu5SFv5EdaEWw9vFmwpJL9zuUL3H8ZHNFMmt8hc48ZRpSVZKYqe0SAVpC/J01knM/vVx24F+GrgEw5u/zKDuDXx1gy08JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728691327; c=relaxed/simple;
	bh=inisj0qXEnK+aY63TUEt/c4faAVgXrCtnrWVeh9QOow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeWqtoJNad5BQ4GwMDtVDNcDIDvrpJKcZuLF3+EqJTuyQRSy6ETBfuiTqDIjbnJCU7rrlg85dV5GL1ZKFrx1YhWcVeb/788PuoA4gRos/tCMOY0DL9RMWPzPTFPOx9lP1aQBFVlUXLywX7QjSBTNRjPrHYS1xJAvbE2D9qkg2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIlmPiEu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2884910c846so1209930fac.0;
        Fri, 11 Oct 2024 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728691324; x=1729296124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03G2GFYZsrpJ8WSLrBwkbv3+91P5DL8eUfyktwcLjE4=;
        b=LIlmPiEukMNhhjSTfggfFqOUkThnLjbu8lHBR9EnX8wERbyKKpGmo0EapDNHXuClhm
         kAdnkH2PZBZjE6c83+/XRYj3AVm/CuKM4GM+CC1S5kO4BSClRa/hE5kca45SPYFwWA2N
         PFEAx6J+nW8TRSgpYT3ADR324xx97qcESKzpglaqKE5g2F4sROE9jtMK7UCQL9Hxlqq3
         cReQRf6lkKjo1NcxE5oVNqMvEFLfdnw7Pp+PRueSAp5Dv5i3sTrrFA3NUy4iWK8hrOYo
         vWJ2nhZsd/5GbqZ9+HSE021WgOnhfXWF7LLR6XPBnAIV8u7T58l6eBAvSm2zbxxU/pKI
         oS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728691324; x=1729296124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03G2GFYZsrpJ8WSLrBwkbv3+91P5DL8eUfyktwcLjE4=;
        b=sfYypcFyneIp9ybK79xNATfLCOCpuUs2rmV3NFJ4zeRrdwSvjhHxzKPak+9r0IJEJL
         NTSfMDK+c2mhxJhnSk/GfJzZtAmpeCO6wNzAAKo0dpeg2WVhnTJA/cBXhAUZBP8jrO/H
         GJ/H2dEuXgXljeqGh9B1z0kxht9BixC7r3Kbx40WyZm68cA8axd9JS8ifj1huvGF5CVn
         6Ls25puzAakDAs2A7rYh2jwJnTAkvsnlACJu8SYIZe59tRztXRBAguZbFF2ukviJ+pEc
         m20n3MQC12IZohYml3LhvGN9VHIzvKNEOkeIu8sMx/hdr0v/y55+sTeRRT5VD6GycXYD
         Qh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGRfUujZihUYwHMTDSSFcg+b+e1fCKBLFyimtlwDnxo6bFgy7ib+87lQ5sR4YrC8gshcvS4IAEru7hzg==@vger.kernel.org, AJvYcCXagcdum28r0X3PjPQO/NGJG/k/unAhSBtKMiEfInYlBZUwck8YKBRhuPz3payDVlJgi+HDfgVMmfWxHB52@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqKyWjoO9fbLIrdQ37fVl9mSI/9m7RWFAVpqYsIbr20gERxh9
	ialrddXSaGdF6Dq2VEDYDq4cRDLCNI3p5ZzA+hSpAK9heZapF1E/KqF4lZRMaAqUJHEyqdcYOg9
	qPIK01W6z3pLu7y0Vzpd6tfteeSM=
X-Google-Smtp-Source: AGHT+IGbA2CI0++XIKxWRBOMA5k+a8D5AmXeMBe6Bul+D6n+zuT5Ax39yBzqkSindS/t4Y8RFGzq/dtuxhm82UupY70=
X-Received: by 2002:a05:6870:79e:b0:25e:1edb:5bcf with SMTP id
 586e51a60fabf-2886dcdf17bmr3927099fac.6.1728691324357; Fri, 11 Oct 2024
 17:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009192018.2683416-1-sanman.p211993@gmail.com> <CAH-L+nO1DMBEmbW0SamSkE+Su2sRPAJc3wO0uyKXNSpvf-qC8A@mail.gmail.com>
In-Reply-To: <CAH-L+nO1DMBEmbW0SamSkE+Su2sRPAJc3wO0uyKXNSpvf-qC8A@mail.gmail.com>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Fri, 11 Oct 2024 17:01:28 -0700
Message-ID: <CAG4C-OkEpuOp0wN5pc+V5_Q5BuWNcnm8nniazKzNbm9gNmNxbw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net, horms@kernel.org, 
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 at 21:34, Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> On Thu, Oct 10, 2024 at 12:50=E2=80=AFAM Sanman Pradhan
> <sanman.p211993@gmail.com> wrote:
> >
> > From: Sanman Pradhan <sanmanpradhan@meta.com>
> >
> > This patch adds support for hardware monitoring to the fbnic driver,
> > allowing for temperature and voltage sensor data to be exposed to
> > userspace via the HWMON interface. The driver registers a HWMON device
> > and provides callbacks for reading sensor data, enabling system
> > admins to monitor the health and operating conditions of fbnic.
> >
> > Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>
> >
> > ---
> > v5:
> >   - Drop hwmon_unregister label from fbnic_pci.c
> >
> > v4: https://patchwork.kernel.org/project/netdevbpf/patch/20241008143212=
.2354554-1-sanman.p211993@gmail.com/
> >
> > v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241004204953=
.2223536-1-sanman.p211993@gmail.com/
> >
> > v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241003173618=
.2479520-1-sanman.p211993@gmail.com/
> >
> > v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87=
@roeck-us.net/T/
> >
> > ---
> >  drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
> >  drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
> >  drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
> >  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
> >  5 files changed, 96 insertions(+)
> >  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> >
> > diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/eth=
ernet/meta/fbnic/Makefile
> > index ed4533a73c57..41494022792a 100644
> > --- a/drivers/net/ethernet/meta/fbnic/Makefile
> > +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> > @@ -11,6 +11,7 @@ fbnic-y :=3D fbnic_devlink.o \
> >            fbnic_ethtool.o \
> >            fbnic_fw.o \
> >            fbnic_hw_stats.o \
> > +          fbnic_hwmon.o \
> >            fbnic_irq.o \
> >            fbnic_mac.o \
> >            fbnic_netdev.o \
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethe=
rnet/meta/fbnic/fbnic.h
> > index 0f9e8d79461c..2d3aa20bc876 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> > @@ -18,6 +18,7 @@
> >  struct fbnic_dev {
> >         struct device *dev;
> >         struct net_device *netdev;
> > +       struct device *hwmon;
> >
> >         u32 __iomem *uc_addr0;
> >         u32 __iomem *uc_addr4;
> > @@ -127,6 +128,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd=
);
> >  int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
> >  void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
> >
> > +void fbnic_hwmon_register(struct fbnic_dev *fbd);
> > +void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
> > +
> >  int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
> >  void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
> >
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_hwmon.c
> > new file mode 100644
> > index 000000000000..bcd1086e3768
> > --- /dev/null
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <linux/hwmon.h>
> > +
> > +#include "fbnic.h"
> > +#include "fbnic_mac.h"
> > +
> > +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
> > +{
> > +       if (type =3D=3D hwmon_temp)
> > +               return FBNIC_SENSOR_TEMP;
> > +       if (type =3D=3D hwmon_in)
> > +               return FBNIC_SENSOR_VOLTAGE;
> > +
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static umode_t fbnic_hwmon_is_visible(const void *drvdata,
> > +                                     enum hwmon_sensor_types type,
> > +                                     u32 attr, int channel)
> > +{
> > +       if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input)
> > +               return 0444;
> > +       if (type =3D=3D hwmon_in && attr =3D=3D hwmon_in_input)
> > +               return 0444;
> > +
> > +       return 0;
> > +}
> > +
> > +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> > +                           u32 attr, int channel, long *val)
> > +{
> > +       struct fbnic_dev *fbd =3D dev_get_drvdata(dev);
> > +       const struct fbnic_mac *mac =3D fbd->mac;
> > +       int id;
> > +
> > +       id =3D fbnic_hwmon_sensor_id(type);
> > +       return id < 0 ? id : mac->get_sensor(fbd, id, val);
> > +}
> > +
> > +static const struct hwmon_ops fbnic_hwmon_ops =3D {
> > +       .is_visible =3D fbnic_hwmon_is_visible,
> > +       .read =3D fbnic_hwmon_read,
> > +};
> > +
> > +static const struct hwmon_channel_info *fbnic_hwmon_info[] =3D {
> > +       HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > +       HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
> > +       NULL
> > +};
> > +
> > +static const struct hwmon_chip_info fbnic_chip_info =3D {
> > +       .ops =3D &fbnic_hwmon_ops,
> > +       .info =3D fbnic_hwmon_info,
> > +};
> > +
> > +void fbnic_hwmon_register(struct fbnic_dev *fbd)
> > +{
> > +       if (!IS_REACHABLE(CONFIG_HWMON))
> > +               return;
> > +
> > +       fbd->hwmon =3D hwmon_device_register_with_info(fbd->dev, "fbnic=
",
> > +                                                    fbd, &fbnic_chip_i=
nfo,
> > +                                                    NULL);
> > +       if (IS_ERR(fbd->hwmon)) {
> > +               dev_notice(fbd->dev,
> > +                          "Failed to register hwmon device %pe\n",
> > +                       fbd->hwmon);
> > +               fbd->hwmon =3D NULL;
> > +       }
> > +}
> > +
> > +void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
> > +{
> > +       if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
> > +               return;
> > +
> > +       hwmon_device_unregister(fbd->hwmon);
> > +       fbd->hwmon =3D NULL;
> > +}
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/=
ethernet/meta/fbnic/fbnic_mac.h
> > index 476239a9d381..05a591653e09 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> > @@ -47,6 +47,11 @@ enum {
> >  #define FBNIC_LINK_MODE_PAM4   (FBNIC_LINK_50R1)
> >  #define FBNIC_LINK_MODE_MASK   (FBNIC_LINK_AUTO - 1)
> >
> > +enum fbnic_sensor_id {
> > +       FBNIC_SENSOR_TEMP,              /* Temp in millidegrees Centigr=
ade */
> > +       FBNIC_SENSOR_VOLTAGE,           /* Voltage in millivolts */
> > +};
> > +
> >  /* This structure defines the interface hooks for the MAC. The MAC hoo=
ks
> >   * will be configured as a const struct provided with a set of functio=
n
> >   * pointers.
> > @@ -83,6 +88,8 @@ struct fbnic_mac {
> >
> >         void (*link_down)(struct fbnic_dev *fbd);
> >         void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_p=
ause);
> > +
> > +       int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
> Thank you for addressing the comments. One last question.
> [Kalesh] I do not see the corresponding implementation of this
> function. Am I missing soemthing here?
> >  };
> >
> >  int fbnic_mac_init(struct fbnic_dev *fbd);
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_pci.c
> > index a4809fe0fc24..ef9dc8c67927 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > @@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
> >
> >         fbnic_devlink_register(fbd);
> >
> > +       fbnic_hwmon_register(fbd);
> > +
> >         if (!fbd->dsn) {
> >                 dev_warn(&pdev->dev, "Reading serial number failed\n");
> >                 goto init_failure_mode;
> > @@ -345,6 +347,7 @@ static void fbnic_remove(struct pci_dev *pdev)
> >                 fbnic_netdev_free(fbd);
> >         }
> >
> > +       fbnic_hwmon_unregister(fbd);
> >         fbnic_devlink_unregister(fbd);
> >         fbnic_fw_disable_mbx(fbd);
> >         fbnic_free_irqs(fbd);
> > --
> > 2.43.5
> >
>
>
> --
> Regards,
> Kalesh A P

Thank you Kalesh, for pointing out the corresponding implementation
and reviewing the patch. I've submitted v6 of my patch for review.

Thank you.

Regards,
Sanman Pradhan

