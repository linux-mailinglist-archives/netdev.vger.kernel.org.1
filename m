Return-Path: <netdev+bounces-135253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A099D2FA
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AF22893E6
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEB1BFE00;
	Mon, 14 Oct 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DblQ85ed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAF1AC891;
	Mon, 14 Oct 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919739; cv=none; b=YG+PynKOVPx6kylQCWMeAjqoI3Tovva09HsLxTqH6HUA/nWT1MN5JqUaBxEo/U7vebNFVC/TrA9VizVOTfZwNWpx5xswjZTO5493Wm8/CPyuhHMLdioNJSILU4mLfy4Jx830OI3fNiDNAfzoET4n+ZTpL1npNA0VDgQOkfCxzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919739; c=relaxed/simple;
	bh=PogWZZjax9IZWJwtk4CQvC7zmGO1Lq5k/JDMfSGCqxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOXADQJ3d2mxV93nnoZMrdXDHbPl1z3CXjdJxBqMF4BqWvg/jW6IyycLBJDIw5Y4i7zcqWEG1WdKqFK5FdyEteeY5uRcVFG0Qwd5RYqZ2T52QFguVR/OZTIEmx2ndIgq3uIMx8FT988BHIL3rvpLlVPsdtq0ZGbDaKlqbweQmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DblQ85ed; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5e8d819df48so2130479eaf.0;
        Mon, 14 Oct 2024 08:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919736; x=1729524536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U69epB+PBHEm4lnnMk3UF3Ps6wRshO+w9Fraq6RhfM=;
        b=DblQ85educeJLtpiuue3QP4xLv27Df9vDfTajKq+7obZNljprWTFRyI2REcqKlD0m8
         mKHkLNvDmM85h3ByJP2BjG0sWv+rP2iUJzjuCAK+sZJjQtXmFvtFajpikMEDLNEXNuSv
         6D0XxhG7WXCT+uYF5iCclm+C+wiQlLHZGXf2VkKzxvbKETYxb3cpI+WuW191ir6BXyoo
         jxPG2s9/mDheK79rBKSN7ns072XlV54vyFYoMN36G04lkAnQlRTCEL54AYQ0yF4edXQM
         O34zKwjB/9T5UXGNmRYhZT1/05t9YUqNNAdFpHim3FrJPulL2NmtbdLcImVH/kubhqvq
         9Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919736; x=1729524536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U69epB+PBHEm4lnnMk3UF3Ps6wRshO+w9Fraq6RhfM=;
        b=pqq+1nrxYn/vxtfGDhpxVLDoJv9h9kSk7C8vvfnP4iE/I+kmuFMn5v7nyWbl1HYpTw
         lNGo/TSZmN1tMimGayLfE6zDADUoLtQ5HUu7bYfXoVbdTqQmLBVpekPMtv43bLRCiY5x
         kZUdCl4yc7stDFngXDYJvqo+qwNCEjZjpT1kCPlmM3k3++pgXhx6epeiYE1iQpICmxWv
         QMVR2b6DJyVZpteHtYP1rtT/Gf+U1dy61B3583LogzHUIhj6KNk8rX7dw4Tadb0OVLRx
         SOdWCJGzHyn4d+5ox924iZW0H2vgeSRDpxqi31oN36+sI1ggQ6Ua1YJfT64qxhakfzrc
         +V/A==
X-Forwarded-Encrypted: i=1; AJvYcCUGD/mfeScTWs49nEWE3D8ebJetiOGbitDFQJBtZFZaH8vJkXJJlrIT62COv86TNmeKrZqNkn5xyB2obA4v@vger.kernel.org, AJvYcCVB8DdtP27gSL7TDepufplnKDvQ+ADL9W7ICuUkiIlf2lAXcU1BawFqx9SmuG2jFqwmW4HBAXWVI3vFjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLS2wlVHgbUA0UvNbfFx7Qodf6uXEJZEWQxwoaHt/ktTmFIPQz
	RrU5aMu7Ea04sX5/sUkKytGw3dZlHS8XID778R3tKRXd2CW+KWVPCwy1de1PbTZiMmsRhG3+ft8
	PA9hpW4OhgQUsc7JLpMfBD7o+GCM=
X-Google-Smtp-Source: AGHT+IGLGhRKegLf4Led3KlrOKuthvu9HEiUwgXWawZCF6iA/lnMFBxptbEZF9T7WnOuCiMWDEc7KUc5QturJw7wIEk=
X-Received: by 2002:a05:6820:22a6:b0:5e1:c6ae:d93 with SMTP id
 006d021491bc7-5eb18b4f12fmr6819537eaf.2.1728919736005; Mon, 14 Oct 2024
 08:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011235847.1209435-1-sanman.p211993@gmail.com>
 <CAH-L+nN8UQeznWkJrZn4nTNeA+OW6MBq8RhCb0Nn0Q2C+uM8Gw@mail.gmail.com> <CAH-L+nNFP6d65f_c7gY8UW5UMJMQLd4e4ij5YxCkhZ3V0KDC=g@mail.gmail.com>
In-Reply-To: <CAH-L+nNFP6d65f_c7gY8UW5UMJMQLd4e4ij5YxCkhZ3V0KDC=g@mail.gmail.com>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Mon, 14 Oct 2024 08:28:20 -0700
Message-ID: <CAG4C-Omvwf2E_fRq6CerCry=MtSXBpHv0u8XrzzHe_fMRinCdA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] eth: fbnic: Add hardware monitoring support
 via HWMON interface
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org, 
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, jdelvare@suse.com, linux@roeck-us.net, horms@kernel.org, 
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew@lunn.ch, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 at 01:25, Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> On Mon, Oct 14, 2024 at 8:49=E2=80=AFAM Kalesh Anakkur Purayil
> <kalesh-anakkur.purayil@broadcom.com> wrote:
> >
> > One minor nit in line. LGTM otherwise.
> >
> > Thanks for taking care of the comments.
> >
> > On Sat, Oct 12, 2024 at 5:29=E2=80=AFAM Sanman Pradhan <sanman.p211993@=
gmail.com> wrote:
> > >
> > > From: Sanman Pradhan <sanmanpradhan@meta.com>
> > >
> > > This patch adds support for hardware monitoring to the fbnic driver,
> > > allowing for temperature and voltage sensor data to be exposed to
> > > userspace via the HWMON interface. The driver registers a HWMON devic=
e
> > > and provides callbacks for reading sensor data, enabling system
> > > admins to monitor the health and operating conditions of fbnic.
> > >
> > > Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>
> > >
> > > ---
> > > v6:
> > >   - Add get_sensor implementation
> > >
> > > v5: https://patchwork.kernel.org/project/netdevbpf/patch/202410091920=
18.2683416-1-sanman.p211993@gmail.com/
> > >
> > > v4: https://patchwork.kernel.org/project/netdevbpf/patch/202410081432=
12.2354554-1-sanman.p211993@gmail.com/
> > >
> > > v3: https://patchwork.kernel.org/project/netdevbpf/patch/202410042049=
53.2223536-1-sanman.p211993@gmail.com/
> > >
> > > v2: https://patchwork.kernel.org/project/netdevbpf/patch/202410031736=
18.2479520-1-sanman.p211993@gmail.com/
> > >
> > > v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e=
87@roeck-us.net/T/
> > >
> > > ---
> > >  drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
> > >  drivers/net/ethernet/meta/fbnic/fbnic.h       |  5 ++
> > >  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  7 ++
> > >  drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++=
++
> > >  drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 23 ++++++
> > >  drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
> > >  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
> > >  7 files changed, 127 insertions(+)
> > >  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> > >
> > > diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/e=
thernet/meta/fbnic/Makefile
> > > index ed4533a73c57..41494022792a 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/Makefile
> > > +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> > > @@ -11,6 +11,7 @@ fbnic-y :=3D fbnic_devlink.o \
> > >            fbnic_ethtool.o \
> > >            fbnic_fw.o \
> > >            fbnic_hw_stats.o \
> > > +          fbnic_hwmon.o \
> > >            fbnic_irq.o \
> > >            fbnic_mac.o \
> > >            fbnic_netdev.o \
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/et=
hernet/meta/fbnic/fbnic.h
> > > index 0f9e8d79461c..ff0ff012c8d6 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> > > @@ -18,6 +18,7 @@
> > >  struct fbnic_dev {
> > >         struct device *dev;
> > >         struct net_device *netdev;
> > > +       struct device *hwmon;
> > >
> > >         u32 __iomem *uc_addr0;
> > >         u32 __iomem *uc_addr4;
> > > @@ -30,6 +31,7 @@ struct fbnic_dev {
> > >
> > >         struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
> > >         struct fbnic_fw_cap fw_cap;
> > > +       struct fbnic_fw_completion *cmpl_data;
> > >         /* Lock protecting Tx Mailbox queue to prevent possible races=
 */
> > >         spinlock_t fw_tx_lock;
> > >
> > > @@ -127,6 +129,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *f=
bd);
> > >  int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
> > >  void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
> > >
> > > +void fbnic_hwmon_register(struct fbnic_dev *fbd);
> > > +void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
> > > +
> > >  int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
> > >  void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
> > >
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net=
/ethernet/meta/fbnic/fbnic_fw.h
> > > index 221faf8c6756..7cd8841920e4 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> > > @@ -44,6 +44,13 @@ struct fbnic_fw_cap {
> > >         u8      link_fec;
> > >  };
> > >
> > > +struct fbnic_fw_completion {
> > > +       struct {
> > > +               s32 millivolts;
> > > +               s32 millidegrees;
> > > +       } tsene;
> > > +};
> > > +
> > >  void fbnic_mbx_init(struct fbnic_dev *fbd);
> > >  void fbnic_mbx_clean(struct fbnic_dev *fbd);
> > >  void fbnic_mbx_poll(struct fbnic_dev *fbd);
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/=
net/ethernet/meta/fbnic/fbnic_hwmon.c
> > > new file mode 100644
> > > index 000000000000..bcd1086e3768
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> > > @@ -0,0 +1,81 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> > > +
> > > +#include <linux/hwmon.h>
> > > +
> > > +#include "fbnic.h"
> > > +#include "fbnic_mac.h"
> > > +
> > > +static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
> > > +{
> > > +       if (type =3D=3D hwmon_temp)
> > > +               return FBNIC_SENSOR_TEMP;
> > > +       if (type =3D=3D hwmon_in)
> > > +               return FBNIC_SENSOR_VOLTAGE;
> > > +
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +static umode_t fbnic_hwmon_is_visible(const void *drvdata,
> > > +                                     enum hwmon_sensor_types type,
> > > +                                     u32 attr, int channel)
> > > +{
> > > +       if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input)
> > > +               return 0444;
> > > +       if (type =3D=3D hwmon_in && attr =3D=3D hwmon_in_input)
> > > +               return 0444;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_ty=
pes type,
> > > +                           u32 attr, int channel, long *val)
> > > +{
> > > +       struct fbnic_dev *fbd =3D dev_get_drvdata(dev);
> > > +       const struct fbnic_mac *mac =3D fbd->mac;
> > > +       int id;
> > > +
> > > +       id =3D fbnic_hwmon_sensor_id(type);
> > > +       return id < 0 ? id : mac->get_sensor(fbd, id, val);
> > > +}
> > > +
> > > +static const struct hwmon_ops fbnic_hwmon_ops =3D {
> > > +       .is_visible =3D fbnic_hwmon_is_visible,
> > > +       .read =3D fbnic_hwmon_read,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info *fbnic_hwmon_info[] =3D {
> > > +       HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > > +       HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
> > > +       NULL
> > > +};
> > > +
> > > +static const struct hwmon_chip_info fbnic_chip_info =3D {
> > > +       .ops =3D &fbnic_hwmon_ops,
> > > +       .info =3D fbnic_hwmon_info,
> > > +};
> > > +
> > > +void fbnic_hwmon_register(struct fbnic_dev *fbd)
> > > +{
> > > +       if (!IS_REACHABLE(CONFIG_HWMON))
> > > +               return;
> > > +
> > > +       fbd->hwmon =3D hwmon_device_register_with_info(fbd->dev, "fbn=
ic",
> > > +                                                    fbd, &fbnic_chip=
_info,
> > > +                                                    NULL);
> > > +       if (IS_ERR(fbd->hwmon)) {
> > > +               dev_notice(fbd->dev,
> > > +                          "Failed to register hwmon device %pe\n",
> > > +                       fbd->hwmon);
> > > +               fbd->hwmon =3D NULL;
> > > +       }
> > > +}
> > > +
> > > +void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
> > > +{
> > > +       if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
> > > +               return;
> > > +
> > > +       hwmon_device_unregister(fbd->hwmon);
> > > +       fbd->hwmon =3D NULL;
> > > +}
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_mac.c
> > > index 7b654d0a6dac..aabfb0b72f52 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> > > @@ -686,6 +686,28 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fb=
d, bool reset,
> > >                             MAC_STAT_TX_BROADCAST);
> > >  }
> > >
> > > +static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, =
long *val)
> > > +{
> > > +       struct fbnic_fw_completion fw_cmpl;
> > > +       int err =3D 0;
> > [Kalesh] No need of local variable "rc"
> Sorry for the typo, I meant "err"
> > > +       s32 *sensor;
> > > +
> > > +       switch (id) {
> > > +       case FBNIC_SENSOR_TEMP:
> > > +               sensor =3D &fw_cmpl.tsene.millidegrees;
> > > +               break;
> > > +       case FBNIC_SENSOR_VOLTAGE:
> > > +               sensor =3D &fw_cmpl.tsene.millivolts;
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       *val =3D *sensor;
> > > +
> > > +       return err;
> > > +}
> > > +
> > >  static const struct fbnic_mac fbnic_mac_asic =3D {
> > >         .init_regs =3D fbnic_mac_init_regs,
> > >         .pcs_enable =3D fbnic_pcs_enable_asic,
> > > @@ -695,6 +717,7 @@ static const struct fbnic_mac fbnic_mac_asic =3D =
{
> > >         .get_eth_mac_stats =3D fbnic_mac_get_eth_mac_stats,
> > >         .link_down =3D fbnic_mac_link_down_asic,
> > >         .link_up =3D fbnic_mac_link_up_asic,
> > > +       .get_sensor =3D fbnic_mac_get_sensor_asic,
> > >  };
> > >
> > >  /**
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_mac.h
> > > index 476239a9d381..05a591653e09 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> > > @@ -47,6 +47,11 @@ enum {
> > >  #define FBNIC_LINK_MODE_PAM4   (FBNIC_LINK_50R1)
> > >  #define FBNIC_LINK_MODE_MASK   (FBNIC_LINK_AUTO - 1)
> > >
> > > +enum fbnic_sensor_id {
> > > +       FBNIC_SENSOR_TEMP,              /* Temp in millidegrees Centi=
grade */
> > > +       FBNIC_SENSOR_VOLTAGE,           /* Voltage in millivolts */
> > > +};
> > > +
> > >  /* This structure defines the interface hooks for the MAC. The MAC h=
ooks
> > >   * will be configured as a const struct provided with a set of funct=
ion
> > >   * pointers.
> > > @@ -83,6 +88,8 @@ struct fbnic_mac {
> > >
> > >         void (*link_down)(struct fbnic_dev *fbd);
> > >         void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx=
_pause);
> > > +
> > > +       int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
> > >  };
> > >
> > >  int fbnic_mac_init(struct fbnic_dev *fbd);
> > > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_pci.c
> > > index a4809fe0fc24..ef9dc8c67927 100644
> > > --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> > > @@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
> > >
> > >         fbnic_devlink_register(fbd);
> > >
> > > +       fbnic_hwmon_register(fbd);
> > > +
> > >         if (!fbd->dsn) {
> > >                 dev_warn(&pdev->dev, "Reading serial number failed\n"=
);
> > >                 goto init_failure_mode;
> > > @@ -345,6 +347,7 @@ static void fbnic_remove(struct pci_dev *pdev)
> > >                 fbnic_netdev_free(fbd);
> > >         }
> > >
> > > +       fbnic_hwmon_unregister(fbd);
> > >         fbnic_devlink_unregister(fbd);
> > >         fbnic_fw_disable_mbx(fbd);
> > >         fbnic_free_irqs(fbd);
> > > --
> > > 2.43.5
> > >
> >
> >
> > --
> > Regards,
> > Kalesh A P
>
>
>
> --
> Regards,
> Kalesh A P

Thanks Kalesh for reviewing the patch, I've submitted v7 addressing
your comment.

Thank you.

Regards,
Sanman Pradhan

