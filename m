Return-Path: <netdev+bounces-182995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D4FA8A858
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CB33BBEC0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE92140E5F;
	Tue, 15 Apr 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0GOwwOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866E28E3F;
	Tue, 15 Apr 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746389; cv=none; b=hjMJbqztlTcpgzaIod6St47hne+dC/hjZePBtqdls9MEXlFQ6i9+o1asETkpuAwnCY0vyTfUiUlzFo8CRpgkY9yI9zaFC65aVFlEstsE187tox+Bx5ICvTf7wvbPmDw+aMNU8CRqkrZtXVI6YfQf5b7vOQISDET/Mk0W2t63hE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746389; c=relaxed/simple;
	bh=R+Zv6c2uPA4DC7TYi9vQVRn9j3j+LCicZ7RJzllZVAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFJCsPrcGQpiSAl3frUC/2NI99oHu+m3dYrzfG8LM36leEChPAHTsuHYTgN5a9NO2EFRnwqt+qOf4WZTr/Ny3tQNZSZ5bHo4AeVnm5UouqSz3/3KB8NOuGcZ/nyIT2oqfrCrfaIM23IGQx91EoXpCsKlZk3sYKl3aWcnyEljPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0GOwwOu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso58272101fa.3;
        Tue, 15 Apr 2025 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744746385; x=1745351185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqT6zRKs9SowwoAb4/yoSTd2DSJhi53YDhc/WhSwJjI=;
        b=F0GOwwOu63oyYy4/OKpgPQYH9pDk1AShoigWp6CEb7tGefYPu6vJrv1Sk48XwKsV9h
         7F4PusF0BlsvLIGOHMR8RGCkyr/lyW6q8HS04LE0NePV8lj0PchiQo16IF+MIymYijo5
         +2qjwBOx2my8kxR/C43PeajNIEd8suZk0/9ma0ybFQqYEeJVmGrX/J/DzfdmebMHyL6m
         O5t+CrQFAAAmVdu7CosUsdPtCo6+lxGxGB3/DAXGunV8IKs/ptHAM8uRspmI5ldZyuHn
         hvw+PvVV+/fdM0GWTa6pgAOLypk8if1AE6FFv0JIenQuHekeQwh19cHMNlJD89WSuBII
         xTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746385; x=1745351185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqT6zRKs9SowwoAb4/yoSTd2DSJhi53YDhc/WhSwJjI=;
        b=nbOyZvWQddBtc13cRllBLgG+oPzTQZO0JBvgJ+LgQAes8ABEAwRqHpq51j49fynoTh
         uNg8kDxAY1oM9mEGEi/dPI7Ui77zp7wtzZoYsahHzUL8PkJEv0Rhk7hSyXOlBEnVgMrP
         xXyFtJzqhqsBbDSDw3yMmc0Nn6qIYWwdroMPiuL8FtWaIZ51eKBa9JB+T8THZRP6FVCY
         Y3WBvZSnyDsVfyrJI/4Puk9N1yy/P5s3UQIPvFvw060OwRenMimhU/yy7NDzANv/QjGW
         MPPNFqQByDAjLDQa1EJRfAOaxYKfsSfWZ/jIfcr/l+0xFAcuWZTEU26o671rJfHfduz8
         jcOg==
X-Forwarded-Encrypted: i=1; AJvYcCV30k4oC6hcEKQwQvp82OpHKsGUXTj6+64/Lz3p6ZTJ7jE+lE5Z6FHs1AhVDYkXgZzfInSs2wNJ@vger.kernel.org, AJvYcCVGE0ZJj4IgdAWhhIyTEAk4DgVYpM3CYaSAccOVpThNzpjw7SfHsqGqxV08Sp+rz8rClPIVQ5vRdllGcO88@vger.kernel.org, AJvYcCWyrB0movLiDIpsPfljVv7F/kRvNhKpE8VlI+QfUggQnwsUI7wvw0p0qqqm3lF+O1GjAVMOQfGz134cFk93VyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxky1Swam52OmVOHY5kcC9ExE22V8SDUfbOG0JSnTBPTyHeFBOk
	xzD21+K2sMcHfNKqpc0YDKaC0Xdc/LtK86uIYDHpfpOPS8yhBsb77xnBVyCnJHNWk6Qnc5SCcOd
	IOEx7YMQE052/EGAPka3ASZ9H/bVEaS7Y7xJ2IQ==
X-Gm-Gg: ASbGncuiEE1zGTipsc5di9n6Z1/PsslFYIrpm07tdrHARHMWk7XHOQQIz2W8Jj6AyqS
	LFLpBse4oy9fvOI3QQZhwXYgdH8+8VWu2+MPcmuOYDsXDt1plKTbUP4JZ7qC8eSHEH+Jp3XHR+b
	Fng+EGaKK1GAdmNx0QFyim
X-Google-Smtp-Source: AGHT+IEehIgfuhCpSOoMRsrBME8J6LhV2Lg0HPcZncHq/vGs0+w44zYagpm03a7RNX9nVZ5xUdMHyK3yI+7AL+rYKSc=
X-Received: by 2002:a05:651c:2129:b0:30d:e104:a497 with SMTP id
 38308e7fff4ca-3107c380ebcmr695751fa.41.1744746384989; Tue, 15 Apr 2025
 12:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411133330.171563-1-chharry@google.com>
In-Reply-To: <20250411133330.171563-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Apr 2025 15:46:10 -0400
X-Gm-Features: ATxdqUH8Hv9oSqzMq2vlQrKzsOgrs_OZu0KohZRh2a3Xl5iBvk309BmwueKUphY
Message-ID: <CABBYNZ+FkEcRBeVTr+dk0dn6MTd6X7g5G5F5-zn0U8GpemO_=w@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Introduce HCI Driver protocol
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Fri, Apr 11, 2025 at 9:33=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
> SCO data through USB Bluetooth chips, it's observed that with the patch
> HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> chips sometimes send out no packet for Transparent codec; MTK chips may
> generate SCO data with a wrong handle for CVSD codec; RTK could split
> the data with a wrong packet size for Transparent codec; ... etc.
>
> To address the issue above one needs to reset the altsetting back to
> zero when there is no active SCO connection, which is the same as the
> BlueZ behavior, and another benefit is the bus doesn't need to reserve
> bandwidth when no SCO connection.
>
> This patch adds the infrastructure that allow the user space program to
> talk to Bluetooth drivers directly:
> - Define the new packet type HCI_DRV_PKT which is specifically used for
>   communication between the user space program and the Bluetooth drviers
> - hci_send_frame intercepts the packets and invokes drivers' HCI Drv
>   callbacks (so far only defined for btusb)
> - 2 kinds of events to user space: Command Status and Command Complete,
>   the former simply returns the status while the later may contain
>   additional response data.
>
> Cc: chromeos-bluetooth-upstreaming@chromium.org
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c        |  65 ++++++++++++++++++--
>  include/net/bluetooth/hci.h      |   1 +
>  include/net/bluetooth/hci_core.h |   3 +
>  include/net/bluetooth/hci_drv.h  |  74 ++++++++++++++++++++++
>  include/net/bluetooth/hci_mon.h  |   2 +
>  net/bluetooth/Makefile           |   3 +-
>  net/bluetooth/hci_core.c         |  10 +++
>  net/bluetooth/hci_drv.c          | 102 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_sock.c         |  12 +++-
>  9 files changed, 263 insertions(+), 9 deletions(-)
>  create mode 100644 include/net/bluetooth/hci_drv.h
>  create mode 100644 net/bluetooth/hci_drv.c
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a9b89bcea22..a33c6b9f8433 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -21,6 +21,7 @@
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci_drv.h>
>
>  #include "btintel.h"
>  #include "btbcm.h"
> @@ -3754,6 +3755,57 @@ static ssize_t isoc_alt_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(isoc_alt);
>
> +static const struct {
> +       u16 opcode;
> +       const char *desc;
> +} btusb_hci_drv_supported_commands[] =3D {
> +       /* Common commands */
> +       { HCI_DRV_OP_READ_INFO, "Read Info" },
> +};
> +static int btusb_hci_drv_read_info(struct hci_dev *hdev, void *data,
> +                                  u16 data_len)
> +{
> +       struct hci_drv_rp_read_info *rp;
> +       size_t rp_size;
> +       int err, i;
> +       u16 num_supported_commands =3D ARRAY_SIZE(btusb_hci_drv_supported=
_commands);
> +
> +       rp_size =3D sizeof(*rp) + num_supported_commands * 2;
> +
> +       rp =3D kmalloc(rp_size, GFP_KERNEL);
> +       if (!rp)
> +               return -ENOMEM;
> +
> +       strscpy_pad(rp->driver_name, btusb_driver.name);
> +
> +       rp->num_supported_commands =3D cpu_to_le16(num_supported_commands=
);
> +       for (i =3D 0; i < num_supported_commands; i++) {
> +               bt_dev_info(hdev, "Supported HCI Driver command: %s",
> +                           btusb_hci_drv_supported_commands[i].desc);
> +               rp->supported_commands[i] =3D
> +                       cpu_to_le16(btusb_hci_drv_supported_commands[i].o=
pcode);
> +       }
> +
> +       err =3D hci_drv_cmd_complete(hdev, HCI_DRV_OP_READ_INFO,
> +                                  HCI_DRV_STATUS_SUCCESS, rp, rp_size);
> +
> +       kfree(rp);
> +       return err;
> +}
> +
> +static const struct hci_drv_handler btusb_hci_drv_common_handlers[] =3D =
{
> +       { btusb_hci_drv_read_info,      HCI_DRV_READ_INFO_SIZE },
> +};
> +
> +static const struct hci_drv_handler btusb_hci_drv_specific_handlers[] =
=3D {};
> +
> +static struct hci_drv btusb_hci_drv =3D {
> +       .common_handler_count   =3D ARRAY_SIZE(btusb_hci_drv_common_handl=
ers),
> +       .common_handlers        =3D btusb_hci_drv_common_handlers,
> +       .specific_handler_count =3D ARRAY_SIZE(btusb_hci_drv_specific_han=
dlers),
> +       .specific_handlers      =3D btusb_hci_drv_specific_handlers,
> +};
> +
>  static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
> @@ -3893,12 +3945,13 @@ static int btusb_probe(struct usb_interface *intf=
,
>                 data->reset_gpio =3D reset_gpio;
>         }
>
> -       hdev->open   =3D btusb_open;
> -       hdev->close  =3D btusb_close;
> -       hdev->flush  =3D btusb_flush;
> -       hdev->send   =3D btusb_send_frame;
> -       hdev->notify =3D btusb_notify;
> -       hdev->wakeup =3D btusb_wakeup;
> +       hdev->open    =3D btusb_open;
> +       hdev->close   =3D btusb_close;
> +       hdev->flush   =3D btusb_flush;
> +       hdev->send    =3D btusb_send_frame;
> +       hdev->notify  =3D btusb_notify;
> +       hdev->wakeup  =3D btusb_wakeup;
> +       hdev->hci_drv =3D &btusb_hci_drv;
>
>  #ifdef CONFIG_PM
>         err =3D btusb_config_oob_wake(hdev);
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a8586c3058c7..e297b312d2b7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -494,6 +494,7 @@ enum {
>  #define HCI_EVENT_PKT          0x04
>  #define HCI_ISODATA_PKT                0x05
>  #define HCI_DIAG_PKT           0xf0
> +#define HCI_DRV_PKT            0xf1
>  #define HCI_VENDOR_PKT         0xff
>
>  /* HCI packet types */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 5115da34f881..dd80f1a398be 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -31,6 +31,7 @@
>  #include <linux/rculist.h>
>
>  #include <net/bluetooth/hci.h>
> +#include <net/bluetooth/hci_drv.h>
>  #include <net/bluetooth/hci_sync.h>
>  #include <net/bluetooth/hci_sock.h>
>  #include <net/bluetooth/coredump.h>
> @@ -613,6 +614,8 @@ struct hci_dev {
>         struct list_head        monitored_devices;
>         bool                    advmon_pend_notify;
>
> +       struct hci_drv          *hci_drv;
> +
>  #if IS_ENABLED(CONFIG_BT_LEDS)
>         struct led_trigger      *power_led;
>  #endif
> diff --git a/include/net/bluetooth/hci_drv.h b/include/net/bluetooth/hci_=
drv.h
> new file mode 100644
> index 000000000000..a05227b6e2df
> --- /dev/null
> +++ b/include/net/bluetooth/hci_drv.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Google Corporation
> + */
> +
> +#ifndef __HCI_DRV_H
> +#define __HCI_DRV_H
> +
> +#include <linux/types.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci.h>
> +
> +struct hci_drv_cmd_hdr {
> +       __le16  opcode;
> +       __le16  len;
> +} __packed;
> +
> +struct hci_drv_ev_hdr {
> +       __le16  opcode;
> +       __le16  len;
> +} __packed;
> +
> +#define HCI_DRV_EV_CMD_STATUS  0x0000
> +struct hci_drv_ev_cmd_status {
> +       __le16  opcode;
> +       __u8    status;
> +} __packed;
> +
> +#define HCI_DRV_EV_CMD_COMPLETE        0x0001
> +struct hci_drv_ev_cmd_complete {
> +       __le16  opcode;
> +       __u8    status;
> +       __u8    data[];
> +} __packed;
> +
> +#define HCI_DRV_STATUS_SUCCESS                 0x00
> +#define HCI_DRV_STATUS_UNSPECIFIED_ERROR       0x01
> +#define HCI_DRV_STATUS_UNKNOWN_COMMAND         0x02
> +#define HCI_DRV_STATUS_INVALID_PARAMETERS      0x03
> +
> +#define HCI_DRV_MAX_DRIVER_NAME_LENGTH 32
> +
> +/* Common commands that make sense on all drivers start from 0x0000 */
> +#define HCI_DRV_OP_READ_INFO   0x0000
> +#define HCI_DRV_READ_INFO_SIZE 0
> +struct hci_drv_rp_read_info {
> +       __u8    driver_name[HCI_DRV_MAX_DRIVER_NAME_LENGTH];
> +       __le16  num_supported_commands;
> +       __le16  supported_commands[];
> +} __packed;
> +
> +/* Driver specific commands start from 0x1135 */
> +#define HCI_DRV_OP_DRIVER_SPECIFIC_BASE        0x1135

Or perhaps we just use the hci_opcode_ogf/hci_opcode_ocf so we have 10
bits for driver specific commands, since we are reusing the command
status/complete logic this should be really straightforward.

> +int hci_drv_cmd_status(struct hci_dev *hdev, u16 cmd, u8 status);
> +int hci_drv_cmd_complete(struct hci_dev *hdev, u16 cmd, u8 status, void =
*rp,
> +                        size_t rp_len);
> +int hci_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *cmd_skb);
> +
> +struct hci_drv_handler {
> +       int (*func)(struct hci_dev *hdev, void *data, u16 data_len);
> +       size_t data_len;
> +};
> +
> +struct hci_drv {
> +       size_t common_handler_count;
> +       const struct hci_drv_handler *common_handlers;
> +
> +       size_t specific_handler_count;
> +       const struct hci_drv_handler *specific_handlers;
> +};
> +
> +#endif /* __HCI_DRV_H */
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index 082f89531b88..bbd752494ef9 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -51,6 +51,8 @@ struct hci_mon_hdr {
>  #define HCI_MON_CTRL_EVENT     17
>  #define HCI_MON_ISO_TX_PKT     18
>  #define HCI_MON_ISO_RX_PKT     19
> +#define HCI_MON_DRV_TX_PKT     20
> +#define HCI_MON_DRV_RX_PKT     21
>
>  struct hci_mon_new_index {
>         __u8            type;
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index 5a3835b7dfcd..a7eede7616d8 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -14,7 +14,8 @@ bluetooth_6lowpan-y :=3D 6lowpan.o
>
>  bluetooth-y :=3D af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o=
 \
>         hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
> -       ecdh_helper.o mgmt_util.o mgmt_config.o hci_codec.o eir.o hci_syn=
c.o
> +       ecdh_helper.o mgmt_util.o mgmt_config.o hci_codec.o eir.o hci_syn=
c.o \
> +       hci_drv.o
>
>  bluetooth-$(CONFIG_DEV_COREDUMP) +=3D coredump.o
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 5eb0600bbd03..2815b2d7d28d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2911,6 +2911,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_=
buff *skb)
>                 break;
>         case HCI_ISODATA_PKT:
>                 break;
> +       case HCI_DRV_PKT:
> +               break;
>         default:
>                 kfree_skb(skb);
>                 return -EINVAL;
> @@ -3019,6 +3021,14 @@ static int hci_send_frame(struct hci_dev *hdev, st=
ruct sk_buff *skb)
>                 return -EINVAL;
>         }
>
> +       if (hci_skb_pkt_type(skb) =3D=3D HCI_DRV_PKT) {
> +               // Intercept HCI Drv packet here and don't go with hdev->=
send
> +               // callabck.
> +               err =3D hci_drv_process_cmd(hdev, skb);
> +               kfree_skb(skb);
> +               return err;
> +       }
> +
>         err =3D hdev->send(hdev, skb);
>         if (err < 0) {
>                 bt_dev_err(hdev, "sending frame failed (%d)", err);
> diff --git a/net/bluetooth/hci_drv.c b/net/bluetooth/hci_drv.c
> new file mode 100644
> index 000000000000..7b7a5b05740c
> --- /dev/null
> +++ b/net/bluetooth/hci_drv.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Google Corporation
> + */
> +
> +#include <linux/skbuff.h>
> +#include <linux/types.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/hci_drv.h>
> +
> +int hci_drv_cmd_status(struct hci_dev *hdev, u16 cmd, u8 status)
> +{
> +       struct hci_drv_ev_hdr *hdr;
> +       struct hci_drv_ev_cmd_status *ev;
> +       struct sk_buff *skb;
> +
> +       skb =3D bt_skb_alloc(sizeof(*hdr) + sizeof(*ev), GFP_KERNEL);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       hdr =3D skb_put(skb, sizeof(*hdr));
> +       hdr->opcode =3D __cpu_to_le16(HCI_DRV_EV_CMD_STATUS);
> +       hdr->len =3D __cpu_to_le16(sizeof(*ev));
> +
> +       ev =3D skb_put(skb, sizeof(*ev));
> +       ev->opcode =3D __cpu_to_le16(cmd);
> +       ev->status =3D status;
> +
> +       hci_skb_pkt_type(skb) =3D HCI_DRV_PKT;
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL(hci_drv_cmd_status);
> +
> +int hci_drv_cmd_complete(struct hci_dev *hdev, u16 cmd, u8 status, void =
*rp,
> +                        size_t rp_len)
> +{
> +       struct hci_drv_ev_hdr *hdr;
> +       struct hci_drv_ev_cmd_complete *ev;
> +       struct sk_buff *skb;
> +
> +       skb =3D bt_skb_alloc(sizeof(*hdr) + sizeof(*ev) + rp_len, GFP_KER=
NEL);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       hdr =3D skb_put(skb, sizeof(*hdr));
> +       hdr->opcode =3D __cpu_to_le16(HCI_DRV_EV_CMD_COMPLETE);
> +       hdr->len =3D __cpu_to_le16(sizeof(*ev) + rp_len);
> +
> +       ev =3D skb_put(skb, sizeof(*ev));
> +       ev->opcode =3D __cpu_to_le16(cmd);
> +       ev->status =3D status;
> +
> +       skb_put_data(skb, rp, rp_len);
> +
> +       hci_skb_pkt_type(skb) =3D HCI_DRV_PKT;
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL(hci_drv_cmd_complete);
> +
> +int hci_drv_process_cmd(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_drv_cmd_hdr *hdr;
> +       const struct hci_drv_handler *handler =3D NULL;
> +       u16 opcode, len, offset;
> +
> +       hdr =3D skb_pull_data(skb, sizeof(*hdr));
> +       if (!hdr)
> +               return -EILSEQ;
> +
> +       opcode =3D __le16_to_cpu(hdr->opcode);
> +       len =3D __le16_to_cpu(hdr->len);
> +       if (len !=3D skb->len)
> +               return -EILSEQ;
> +
> +       if (!hdev->hci_drv)
> +               return hci_drv_cmd_status(hdev, opcode,
> +                                         HCI_DRV_STATUS_UNKNOWN_COMMAND)=
;
> +
> +       if (opcode < HCI_DRV_OP_DRIVER_SPECIFIC_BASE) {
> +               if (opcode < hdev->hci_drv->common_handler_count)
> +                       handler =3D &hdev->hci_drv->common_handlers[opcod=
e];
> +       } else {
> +               offset =3D opcode - HCI_DRV_OP_DRIVER_SPECIFIC_BASE;
> +               if (offset < hdev->hci_drv->specific_handler_count)
> +                       handler =3D &hdev->hci_drv->specific_handlers[off=
set];
> +       }
> +
> +       if (!handler || !handler->func)
> +               return hci_drv_cmd_status(hdev, opcode,
> +                                         HCI_DRV_STATUS_UNKNOWN_COMMAND)=
;
> +
> +       if (len !=3D handler->data_len)
> +               return hci_drv_cmd_status(hdev, opcode,
> +                                         HCI_DRV_STATUS_INVALID_PARAMETE=
RS);
> +
> +       return handler->func(hdev, skb->data, len);
> +}
> +EXPORT_SYMBOL(hci_drv_process_cmd);
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 022b86797acd..428ee5c7de7e 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -234,7 +234,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk=
_buff *skb)
>                         if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT &&
>                             hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                             hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT)
> +                           hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> +                           hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT)
>                                 continue;
>                 } else {
>                         /* Don't send frame to other channel types */
> @@ -391,6 +392,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struc=
t sk_buff *skb)
>                 else
>                         opcode =3D cpu_to_le16(HCI_MON_ISO_TX_PKT);
>                 break;
> +       case HCI_DRV_PKT:
> +               if (bt_cb(skb)->incoming)
> +                       opcode =3D cpu_to_le16(HCI_MON_DRV_RX_PKT);
> +               else
> +                       opcode =3D cpu_to_le16(HCI_MON_DRV_TX_PKT);
> +               break;
>         case HCI_DIAG_PKT:
>                 opcode =3D cpu_to_le16(HCI_MON_VENDOR_DIAG);
>                 break;
> @@ -1860,7 +1867,8 @@ static int hci_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>                 if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
>                     hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
> -                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT) {
> +                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT &&
> +                   hci_skb_pkt_type(skb) !=3D HCI_DRV_PKT) {
>                         err =3D -EINVAL;
>                         goto drop;
>                 }
> --
> 2.49.0.604.gff1f9ca942-goog
>


--=20
Luiz Augusto von Dentz

