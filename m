Return-Path: <netdev+bounces-112118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB8935200
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F375AB2235D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D381ADA;
	Thu, 18 Jul 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE+nBl7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FD145FEB;
	Thu, 18 Jul 2024 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329335; cv=none; b=YypNugSNOMfsctckNVKHTtrOQ7IZyMXkBOeEoMWRXtIb5gGxz8ZQSRHbqt2ppvnWvqgwKEppW0gPncNU0X69570eMGWJHkmnhlZmei5EX1fYmbbdiSkgq5WTEdADQF5RRZiR9hdleE9FZ824tGU7S3pXNdS1a7iT+0IkiOvok/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329335; c=relaxed/simple;
	bh=Vf1c6MHXAJAakEAk2zVgC8sGSfMOwrNISy4mAhGlqrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buZpO9ypcy7a/j5nfKsS33XzggI74PkNgVE1Pmq/xf6B+51QwhAU4qEXRj8Vf/KZsMs4URBFzChvXblIYi3hbwOX8GyB7SIgYLOP3dn0a0cfSJ05yFn8+xW0vxL2gs1TdnxpeQ08j8/pmW40FQZeVe4RAy/8KiO65ib3AAfBuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE+nBl7J; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee910d6a9eso9459731fa.1;
        Thu, 18 Jul 2024 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721329331; x=1721934131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icxl/F0Cf5QfVAp4CrQNZhkUGgwo/Lr9s4sG0v2Z9sM=;
        b=VE+nBl7JCTBp0Dp1H/06PEmrouZKa/uPUmTNwvCLFoaVWMh8p5OkRZtE9UNEOw6Qt8
         KY2hr09IY1odePOcV6QM9joo21IM9/nwc0WUCTK6h3LIO1k5MRHOIxsGibJSaXNjZFwF
         GlFMs4986PySkaNU6MWpCWdVk+8yq0+dsoJExaJNJLE1KUWlKo8i25ZNThcvnkbf0zQc
         Wja9oIqct56sD6SJ90iulmZ8vksBBc2XyNjROmXzZ1sDGuAOsl7oxSKyrO5o98etIrQJ
         GOEB3/xGl5gArYAjNkvSpP8+3fGAeaFwadV+uY5n5/H3m3gPqiJFkDGvSjyKYjVP+A9Q
         K19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721329331; x=1721934131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icxl/F0Cf5QfVAp4CrQNZhkUGgwo/Lr9s4sG0v2Z9sM=;
        b=CCMXk2QtetTygGwQnuLy7GUuRp1utPW/a1ZexzOvouEB1V/MYqADMSt0PRo5fcSzvY
         BUpPweE4YcIMyawghT/xtuEe4MDJwcLl/5IJp0KFeBKbUQvmh1Ui76PkgEd+FhQOJhs7
         oX4kpH5ssSPcwoX3bw1kvQXOkdL9ifWmHHb+Yre9qewVm/wbgCF/mziot0L6tW7sd0CC
         GOUBDdJfrvSX3h9faFesbVyxNE62elELSQzpzffulJtiMbqELLTkt1Cq5g23sgP+s8AW
         N4EfVq4d1uu3kXK+JoBmzwTjTmHA1hM+0CI/ZWjAi9TRcthy/X0yKm6N1pYlQC9OLUpR
         DtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYdrijuGYLZQIcXiDlIXpWuY7AZ8PK/M6KDkqEyuW6jTzjIjRxlkFYiXrK5kpQTGSFdjMr+cHDu7E60hpY6QNVD+9uNjTeLuuHDHLhSDs06ztMCWp3qr9jyUrwY8q+8IV7jIm3aNlYpXS5S8Ef0lRRhN/xy6cjOThapfRQ9rWhYBlGlQtrZYRrG+YN84kHRjTblyUYLjDZWbG+nh9zvxYZjw==
X-Gm-Message-State: AOJu0YyLKAEeJ6a1vJmoNHryjDTRAB/IOP8r2WaTn148XwLooeZXPH0n
	fyPZURYI9pKs4AVI/zO+BLhzBV6XYsL381vtLRI/Yw272g38xOkzhvuRUemfhFJY4FgIZmziO64
	s8zd3G8QD0dWWsXX+7GHyuDWENvQ=
X-Google-Smtp-Source: AGHT+IE9F74H2W0XQVBrzikCeMeh9SfLqX8XmBzc8W/oBXIwVnRCzmuMYabb1TiTsCMHOBY+VNPq63/l2v/A6/UzGc8=
X-Received: by 2002:a2e:3517:0:b0:2ee:7a95:1819 with SMTP id
 38308e7fff4ca-2ef065cf29fmr8404901fa.25.1721329331086; Thu, 18 Jul 2024
 12:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com> <20240718-btaml-v2-2-1392b2e21183@amlogic.com>
 <BY3PR18MB47078CCD43FD8B1DB6D9AE78A0AC2@BY3PR18MB4707.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47078CCD43FD8B1DB6D9AE78A0AC2@BY3PR18MB4707.namprd18.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jul 2024 15:01:58 -0400
Message-ID: <CABBYNZKO_02eBmDDKN2ReviM+SpEzozYPbohjBPjYtf1MqAzuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for Amlogic HCI UART
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "yang.li@amlogic.com" <yang.li@amlogic.com>, Marcel Holtmann <marcel@holtmann.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ye He <ye.he@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On Thu, Jul 18, 2024 at 2:43=E2=80=AFPM Sai Krishna Gajula
<saikrishnag@marvell.com> wrote:
>
>
> > -----Original Message-----
> > From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
> > Sent: Thursday, July 18, 2024 1:12 PM
> > To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org=
>
> > Cc: linux-bluetooth@vger.kernel.org; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; Yang Li <yang.li@amlogic.com>; Ye He
> > <ye.he@amlogic.com>
> > Subject: [PATCH v2 2/3] Bluetooth: hci_uart: Add support for
> > Amlogic HCI UART
> >
> > From: Yang Li <yang.=E2=80=8Ali@=E2=80=8Aamlogic.=E2=80=8Acom> This pat=
ch introduces support for
> > Amlogic Bluetooth controller over UART. In order to send the final firm=
ware at
> > full speed. It is a pretty straight forward H4 driver with exception of=
 actually
> > having
> > From: Yang Li <yang.li@amlogic.com>
> >
> > This patch introduces support for Amlogic Bluetooth controller over UAR=
T. In
> > order to send the final firmware at full speed. It is a pretty straight=
 forward H4
> > driver with exception of actually having it's own setup address configu=
ration.
> >
> > Co-developed-by: Ye He <ye.he@amlogic.com>
> > Signed-off-by: Ye He <ye.he@amlogic.com>
> > Signed-off-by: Yang Li <yang.li@amlogic.com>
> > ---
> >  drivers/bluetooth/Kconfig     |  12 +
> >  drivers/bluetooth/Makefile    |   1 +
> >  drivers/bluetooth/hci_aml.c   | 772
> > ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/bluetooth/hci_ldisc.c |   8 +-
> >  drivers/bluetooth/hci_uart.h  |   8 +-
> >  5 files changed, 798 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig inde=
x
> > 90a94a111e67..d9ff7a64d032 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -274,6 +274,18 @@ config BT_HCIUART_MRVL
> >
> >         Say Y here to compile support for HCI MRVL protocol.
> >
> > +config BT_HCIUART_AML
> > +     bool "Amlogic protocol support"
> > +     depends on BT_HCIUART
> > +     depends on BT_HCIUART_SERDEV
> > +     select BT_HCIUART_H4
> > +     select FW_LOADER
> > +     help
> > +       The Amlogic protocol support enables Bluetooth HCI over serial
> > +       port interface for Amlogic Bluetooth controllers.
> > +
> > +       Say Y here to compile support for HCI AML protocol.
> > +
> >  config BT_HCIBCM203X
> >       tristate "HCI BCM203x USB driver"
> >       depends on USB
> > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile in=
dex
> > 0730d6684d1a..81856512ddd0 100644
> > --- a/drivers/bluetooth/Makefile
> > +++ b/drivers/bluetooth/Makefile
> > @@ -51,4 +51,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)   +=3D hci_bcm.o
> >  hci_uart-$(CONFIG_BT_HCIUART_QCA)    +=3D hci_qca.o
> >  hci_uart-$(CONFIG_BT_HCIUART_AG6XX)  +=3D hci_ag6xx.o
> >  hci_uart-$(CONFIG_BT_HCIUART_MRVL)   +=3D hci_mrvl.o
> > +hci_uart-$(CONFIG_BT_HCIUART_AML)    +=3D hci_aml.o
> >  hci_uart-objs                                :=3D $(hci_uart-y)
> > diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c =
new file
> > mode 100644 index 000000000000..575b6361dad6
> > --- /dev/null
> > +++ b/drivers/bluetooth/hci_aml.c
> > @@ -0,0 +1,772 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +/*
> > + * Copyright (C) 2024 Amlogic, Inc. All rights reserved  */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/property.h>
>
> ......
>
> > + * op_code |      op_len           | op_addr | parameter   |
> > + * --------|-----------------------|---------|-------------|
> > + *   2B    | 1B len(addr+param)    |    4B   |  len(param) |
> > + */
> > +static int aml_send_tci_cmd(struct hci_dev *hdev, u16 op_code, u32
> > op_addr,
> > +                         u32 *param, u32 param_len)
> > +{
> > +     struct sk_buff *skb =3D NULL;
> > +     struct aml_tci_rsp *rsp =3D NULL;
> > +     u8 *buf =3D NULL;
> > +     u32 buf_len =3D 0;
> > +     int err =3D 0;
>
> Please consider using reverse xmas tree order - longest line to shortest =
- for local variable declarations in Networking code.

First time I'm hearing about this, is that just for the sake of readability=
?

>
> > +
> > +     buf_len =3D sizeof(op_addr) + param_len;
> > +     buf =3D kmalloc(buf_len, GFP_KERNEL);
> > +     if (!buf) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     memcpy(buf, &op_addr, sizeof(op_addr));
> > +     if (param && param_len > 0)
> > +             memcpy(buf + sizeof(op_addr), param, param_len);
> > +
> > +     skb =3D __hci_cmd_sync_ev(hdev, op_code, buf_len, buf,
> > +                             HCI_EV_CMD_COMPLETE,
> > HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             err =3D PTR_ERR(skb);
> > +             skb =3D NULL;
>
> Better to capture the error before nullifying skb, like below
>         err =3D PTR_ERR(skb);
>         skb =3D NULL;  // Nullify after capturing the error

That is exactly what he is doing, and actually it seems to only be
doing that because it later calls kfree_skb.

> > +             bt_dev_err(hdev, "Failed to send TCI cmd:(%d)", err);
> > +             goto exit;
> > +     }
> > +
> > +     rsp =3D (struct aml_tci_rsp *)(skb->data);

This code is not safe, you need to check if skb->len because trying to
access skb->data, anyway you are probably much better off using
skb_pull_data instead.

> > +     if (rsp->opcode !=3D op_code || rsp->status !=3D 0x00) {
> > +             bt_dev_err(hdev, "send TCI cmd(0x%04X),
> > response(0x%04X):(%d)",
> > +                    op_code, rsp->opcode, rsp->status);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +exit:
> > +     kfree(buf);
> > +     kfree_skb(skb);
> > +     return err;
> > +}
> > +
> > +static int aml_update_chip_baudrate(struct hci_dev *hdev, u32 baud) {
> > +     u32 value;
> > +
> > +     value =3D ((AML_UART_CLK_SOURCE / baud) - 1) & 0x0FFF;
> > +     value |=3D AML_UART_XMIT_EN | AML_UART_RECV_EN |
> > +AML_UART_TIMEOUT_INT_EN;
> > +
> > +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_UPDATE_BAUDRATE,
> > +                               AML_OP_UART_MODE, &value,
> > sizeof(value)); }
> > +
> > +static int aml_start_chip(struct hci_dev *hdev) {
> > +     u32 value =3D 0;
> > +     int ret;
> > +
> > +     value =3D AML_MM_CTR_HARD_TRAS_EN;
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> > +                            AML_OP_MEM_HARD_TRANS_EN,
> > +                            &value, sizeof(value));
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* controller hardware reset. */
> > +     value =3D AML_CTR_CPU_RESET | AML_CTR_MAC_RESET |
> > AML_CTR_PHY_RESET;
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_HARDWARE_RESET,
> > +                            AML_OP_HARDWARE_RST,
> > +                            &value, sizeof(value));
> > +     return ret;
> > +}
> > +
> > +static int aml_send_firmware_segment(struct hci_dev *hdev,
> > +                                  u8 fw_type,
> > +                                  u8 *seg,
> > +                                  u32 seg_size,
> > +                                  u32 offset)
> > +{
> > +     u32 op_addr =3D 0;
> > +
> > +     if (fw_type =3D=3D FW_ICCM)
> > +             op_addr =3D AML_OP_ICCM_RAM_BASE  + offset;
> > +     else if (fw_type =3D=3D FW_DCCM)
> > +             op_addr =3D AML_OP_DCCM_RAM_BASE + offset;
> > +
> > +     return aml_send_tci_cmd(hdev, AML_TCI_CMD_DOWNLOAD_BT_FW,
> > +                          op_addr, (u32 *)seg, seg_size); }
> > +
> > +static int aml_send_firmware(struct hci_dev *hdev, u8 fw_type,
> > +                          u8 *fw, u32 fw_size, u32 offset) {
> > +     u32 seg_size =3D 0;
> > +     u32 seg_off =3D 0;
> > +
> > +     if (fw_size > AML_FIRMWARE_MAX_SIZE) {
> > +             bt_dev_err(hdev, "fw_size error, fw_size:%d, max_size: 51=
2K",
> > +                    fw_size);
> > +             return -EINVAL;
> > +     }
> > +     while (fw_size > 0) {
> > +             seg_size =3D (fw_size > AML_FIRMWARE_OPERATION_SIZE) ?
> > +                        AML_FIRMWARE_OPERATION_SIZE : fw_size;
> > +             if (aml_send_firmware_segment(hdev, fw_type, (fw +
> > seg_off),
> > +                                           seg_size, offset)) {
> > +                     bt_dev_err(hdev, "Failed send firmware, type:%d,
> > offset:0x%x",
> > +                            fw_type, offset);
> > +                     return -EINVAL;
> > +             }
> > +             seg_off +=3D seg_size;
> > +             fw_size -=3D seg_size;
> > +             offset +=3D seg_size;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int aml_download_firmware(struct hci_dev *hdev, const char
> > +*fw_name) {
> > +     struct hci_uart *hu =3D hci_get_drvdata(hdev);
> > +     struct aml_serdev *amldev =3D serdev_device_get_drvdata(hu-
> > >serdev);
> > +     const struct firmware *firmware =3D NULL;
> > +     struct aml_fw_len *fw_len =3D NULL;
> > +     u8 *iccm_start =3D NULL, *dccm_start =3D NULL;
> > +     u32 iccm_len, dccm_len;
> > +     u32 value =3D 0;
> > +     int ret =3D 0;
> > +
>
> Please consider using reverse xmas tree order - longest line to shortest =
- for local variable declarations in Networking code.
>
> > +     /* Enable firmware download event. */
> > +     value =3D AML_EVT_EN;
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> > +                            AML_OP_EVT_ENABLE,
> > +                            &value, sizeof(value));
> > +     if (ret)
> > +             goto exit;
> > +
> > +     /* RAM power on */
> > +     value =3D AML_RAM_POWER_ON;
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> > +                            AML_OP_RAM_POWER_CTR,
> > +                            &value, sizeof(value));
> > +     if (ret)
> > +             goto exit;
> > +
> > +     /* Check RAM power status */
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_READ,
> > +                            AML_OP_RAM_POWER_CTR, NULL, 0);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret =3D request_firmware(&firmware, fw_name, &hdev->dev);
> > +     if (ret < 0) {
> > +             bt_dev_err(hdev, "Failed to load <%s>:(%d)", fw_name, ret=
);
> > +             goto exit;
> > +     }
> > +
> > +     fw_len =3D (struct aml_fw_len *)firmware->data;
> > +
> > +     /* Download ICCM */
> > +     iccm_start =3D (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
> > +                     + amldev->aml_dev_data->iccm_offset;
> > +     iccm_len =3D fw_len->iccm_len - amldev->aml_dev_data->iccm_offset=
;
> > +     ret =3D aml_send_firmware(hdev, FW_ICCM, iccm_start, iccm_len,
> > +                             amldev->aml_dev_data->iccm_offset);
> > +     if (ret) {
> > +             bt_dev_err(hdev, "Failed to send FW_ICCM (%d)", ret);
> > +             goto exit;
> > +     }
> > +
> > +     /* Download DCCM */
> > +     dccm_start =3D (u8 *)(firmware->data) + sizeof(struct aml_fw_len)=
 +
> > fw_len->iccm_len;
> > +     dccm_len =3D fw_len->dccm_len;
> > +     ret =3D aml_send_firmware(hdev, FW_DCCM, dccm_start, dccm_len,
> > +                             amldev->aml_dev_data->dccm_offset);
> > +     if (ret) {
> > +             bt_dev_err(hdev, "Failed to send FW_DCCM (%d)", ret);
> > +             goto exit;
> > +     }
> > +
> > +     /* Disable firmware download event. */
> > +     value =3D 0;
> > +     ret =3D aml_send_tci_cmd(hdev, AML_TCI_CMD_WRITE,
> > +                            AML_OP_EVT_ENABLE,
> > +                            &value, sizeof(value));
> > +     if (ret)
> > +             goto exit;
> > +
> > +exit:
> > +     if (firmware)
> > +             release_firmware(firmware);
> > +     return ret;
> > +}
> > +
> > +static int aml_send_reset(struct hci_dev *hdev) {
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     skb =3D __hci_cmd_sync_ev(hdev, HCI_OP_RESET, 0, NULL,
> > +                             HCI_EV_CMD_COMPLETE,
> > HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             err =3D PTR_ERR(skb);
> > +             bt_dev_err(hdev, "Failed to send hci reset cmd(%d)", err)=
;
> > +             return err;
> > +     }
> > +
> > +     kfree_skb(skb);
> > +     return 0;
> > +}
> > +
> > +static int aml_dump_fw_version(struct hci_dev *hdev) {
> > +     struct sk_buff *skb;
> > +     struct aml_tci_rsp *rsp =3D NULL;
> > +     u8 value[6] =3D {0};
> > +     u8 *fw_ver =3D NULL;
> > +     int err =3D 0;
> > +
>
> Please consider using reverse xmas tree order - longest line to shortest =
- for local variable declarations in Networking code.
>
> > +     skb =3D __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
> > sizeof(value), value,
> > +                             HCI_EV_CMD_COMPLETE,
> > HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             skb =3D NULL;
> > +             err =3D PTR_ERR(skb);
> > +             bt_dev_err(hdev, "Failed get fw version:(%d)", err);
> > +             goto exit;
> > +     }
> > +
> > +     rsp =3D (struct aml_tci_rsp *)(skb->data);
> > +     if (rsp->opcode !=3D AML_BT_HCI_VENDOR_CMD || rsp->status !=3D
> > 0x00) {
> > +             bt_dev_err(hdev, "dump version, error response
> > (0x%04X):(%d)",
> > +                    rsp->opcode, rsp->status);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     fw_ver =3D skb->data + AML_EVT_HEAD_SIZE;
> > +     bt_dev_info(hdev, "fw_version: date =3D %02x.%02x, number =3D
> > 0x%02x%02x",
> > +             *(fw_ver + 1), *fw_ver, *(fw_ver + 3), *(fw_ver + 2));
> > +
> > +exit:
> > +     kfree_skb(skb);
> > +     return err;
> > +}
> > +
> > +static int aml_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr=
)
> > +{
> > +     struct sk_buff *skb;
> > +     struct aml_tci_rsp *rsp =3D NULL;
> > +     int err =3D 0;
> > +
>
> Please consider using reverse xmas tree order - longest line to shortest =
- for local variable declarations in Networking code.
>
> > +     bt_dev_info(hdev, "set bdaddr (%pM)", bdaddr);
> > +     skb =3D __hci_cmd_sync_ev(hdev, AML_BT_HCI_VENDOR_CMD,
> > +                             sizeof(bdaddr_t), bdaddr,
> > +                             HCI_EV_CMD_COMPLETE,
> > HCI_INIT_TIMEOUT);
> > +     if (IS_ERR(skb)) {
> > +             skb =3D NULL;
> > +             err =3D PTR_ERR(skb);
>
> Same here to capture error before making skb null.

Ok, this is really the wrong order and will overwrite the error, that
said replacing goto exit with return PTR_ERR(skb) would be enough here
since there is nothing else that needs to be cleanup.

> > +             bt_dev_err(hdev, "Failed to set bdaddr:(%d)", err);
> > +             goto exit;
> > +     }
> > +
> > +     rsp =3D (struct aml_tci_rsp *)(skb->data);
> > +     if (rsp->opcode !=3D AML_BT_HCI_VENDOR_CMD || rsp->status !=3D
> > 0x00) {
> > +             bt_dev_err(hdev, "error response (0x%x):(%d)", rsp->opcod=
e,
> > rsp->status);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +exit:
> > +     kfree_skb(skb);
> > +     return err;
> > +}
> > +
> > +static int aml_check_bdaddr(struct hci_dev *hdev) {
>
> .......
>
> > +
> > +static int aml_close(struct hci_uart *hu) {
> > +     struct aml_data *aml_data =3D hu->priv;
> > +     struct aml_serdev *amldev =3D serdev_device_get_drvdata(hu-
> > >serdev);
>
> Please consider using reverse xmas tree order - longest line to shortest =
- for local variable declarations in Networking code.
>
> > +
> > +     if (hu->serdev)
> > +             serdev_device_close(hu->serdev);
> > +
> > +     skb_queue_purge(&aml_data->txq);
> > +     kfree_skb(aml_data->rx_skb);
> > +     kfree(aml_data);
> > +
> > +     hu->priv =3D NULL;
> > +
> > +     return aml_power_off(amldev);
> > +}
>
> .......
>


--=20
Luiz Augusto von Dentz

