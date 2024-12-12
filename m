Return-Path: <netdev+bounces-151451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F89EF510
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90AB1750E1
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3022333B;
	Thu, 12 Dec 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMefTAdC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817A2153DD;
	Thu, 12 Dec 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022978; cv=none; b=ZOIrse7/GYRVH9EzzuUJzPCcM9wQeGyhYOWOUS87Pd/nGz1ZW/sVK6eXdKP4JZz5ySh/JBnf0QESVidL6Li/Hm6DvAV2rkVHESRslh8SORZErBcSTUVBqz7imRX7PZb+LbuVjNP1Th/BsCrAxvV/Cl62eUcWzHiD2c3VwQsu4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022978; c=relaxed/simple;
	bh=watSS0fbqpZzsEyFSLcvfFuZ8P0NH+THumoSLSiJVpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=smD3hFrHN7PBotwTGBvJtvBDd3LeXURz+TL9d04TwzsNx0/jLvuRVQosuGcAWXSfbUcCI4+TBbjJV4CkgKaX9D3aO/c+L+slQq/c1ojhxfSfdUZWNZ4DSpfulS/+rUUXTl887MlLga5ar3FMHyYfr86dqVdzy7W+J00MOQClj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMefTAdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67389C4CED3;
	Thu, 12 Dec 2024 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734022978;
	bh=watSS0fbqpZzsEyFSLcvfFuZ8P0NH+THumoSLSiJVpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oMefTAdC1o9FrilMO7zCuxGHjtpkebrdNsL5j3ShSTqRYIAiUgsWAsMFVpiG/Osul
	 VUgXAUOa2P5X4mN/rdHDKXmLf2DFnMHqFv4ZMIkycfy4l19NtL5+u4ZZE9appWl63B
	 x0dBOWkYQiFOQ9hnbHT14EVKoGAPJX/Ifwn3HftsEUWSucluT3yUKmCsZodFosKDrZ
	 NNmTurhUDX8NEiKj/wSXCfYHfKYQh6KDiHiHP/66lQpTRohXeGhpOfYoMYHlWOrc3p
	 0Rmz4xt5DDIpGgXMgUe5Bmj8BKjsIsTj8Y6UkizdX0WatmxDFBOZkMVNJDFrg30a8M
	 fLtxOy6CXWH5g==
Date: Thu, 12 Dec 2024 11:02:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v02 1/3] net: hinic3: module initialization and
 tx/rx logic
Message-ID: <20241212170256.GA3347301@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d62ca11c809ac646c2fd8613fd48729061c22b3.1733990727.git.gur.stavi@huawei.com>

On Thu, Dec 12, 2024 at 02:04:15PM +0200, Gur Stavi wrote:
> From: gongfan <gongfan1@huawei.com>
> 
> This is [1/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional driver.

> +++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
> @@ -0,0 +1,136 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================================================
> +Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family
> +=====================================================================
> +
> +Overview
> +========
> +
> +The hinic3 is a network interface card(NIC) for Data Center. It supports

Add space before "(".

> +Prime Physical Function (PPF) is responsible for the management of the
> +whole NIC card. For example, clock synchronization between the NIC and
> +the host.
> +Any PF may serve as a PPF. The PPF is selected dynamically.

Add blank line between paragraphs or reflow into a single paragraph.

Is the PPF selected dynamically by the driver?  By firmware on the
NIC?

> +hinic3_pci_id_tbl.h       Supported device IDs.
> +hinic3_hw_intf.h          Interface between HW and driver.
> +hinic3_queue_common.[ch]  Common structures and methods for NIC queues.
> +hinic3_common.[ch]        Encapsulation of memory operations in Linux.
> +hinic3_csr.h              Register definitions in the BAR.
> +hinic3_hwif.[ch]          Interface for BAR.
> +hinic3_eqs.[ch]           Interface for AEQs and CEQs.
> +hinic3_mbox.[ch]          Interface for mailbox.
> +hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ.
> +hinic3_wq.[ch]            Work queue data structures and interface.
> +hinic3_cmdq.[ch]          Command queue is used to post command to HW.
> +hinic3_hwdev.[ch]         HW structures and methods abstractions.
> +hinic3_lld.[ch]           Auxiliary driver adaptation layer.
> +hinic3_hw_comm.[ch]       Interface for common HW operations.
> +hinic3_mgmt_interface.h   Interface between firmware and driver.
> +hinic3_hw_cfg.[ch]        Interface for HW configuration.
> +hinic3_irq.c              Interrupt request
> +hinic3_netdev_ops.c       Operations registered to Linux kernel stack.
> +hinic3_nic_dev.h          NIC structures and methods abstractions.
> +hinic3_main.c             Main Linux kernel driver.
> +hinic3_nic_cfg.[ch]       NIC service configuration.
> +hinic3_nic_io.[ch]        Management plane interface for TX and RX.
> +hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS).
> +hinic3_rx.[ch]            Interface for transmit.
> +hinic3_tx.[ch]            Interface for receive.
> +hinic3_ethtool.c          Interface for ethtool operations (ops).
> +hinic3_filter.c           Interface for mac address.

Could drop "." at end (or use it consistently).

s/mac/MAC/

> +2 mailbox related events.
> +
> +MailBox

s/MailBox/Mailbox/ since that's how you use it elsewhere.

> +-------
> +
> +Mailbox is a communication mechanism between the hinic3 driver and the HW.

> +The implementation of CEQ is the same as AEQ. It receives completion events
> +form HW over a fixed size descriptor of 32 bits. Every device can have up
> +to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited
> +events that are responses to requests from the driver. CEQ can receive
> +multiple types of events, but in practice the hinic3 driver ignores all
> +events except for HINIC3_CMDQ that represents completion of previously
> +posted commands on a cmdq.

s/form HW/from HW/

> +Work queues are logical arrays of fixed size WQEs. The array may be spread
> +over multiple non-contiguous pages using indirection table.

Add blank line or wrap into single paragraph.

> +Work queues are used by I/O queues and command queues.

> +Every function, PF or VF, has a unique ordinal identification within the device.
> +Many commands to management (mbox or cmdq) contain this ID so HW can apply the
> +command effect to the right function.

Add blank line or wrap into single paragraph.

> +PF is allowed to post management commands to a subordinate VF by specifying the
> +VFs ID. A VF must provide its own ID. Anti-spoofing in the HW will cause
> +command from a VF to fail if it contains the wrong ID.

> +config HINIC3
> +	tristate "Huawei Intelligent Network Interface Card 3rd"
> +	# Fields of HW and management structures are little endian and will not
> +	# be explicitly converted

I guess this comment is here to explain the !CPU_BIG_ENDIAN below?
That's quite an unusual dependency.

> +	depends on 64BIT && !CPU_BIG_ENDIAN

> +++ b/drivers/net/ethernet/huawei/hinic3/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
> +
> +obj-$(CONFIG_HINIC3) += hinic3.o
> +
> +hinic3-objs := hinic3_hwdev.o \
> +	       hinic3_lld.o \
> +	       hinic3_common.o \
> +	       hinic3_hwif.o \
> +	       hinic3_hw_cfg.o \
> +	       hinic3_queue_common.o \
> +	       hinic3_mbox.o \
> +	       hinic3_hw_comm.o \
> +	       hinic3_wq.o \
> +	       hinic3_nic_io.o \
> +	       hinic3_nic_cfg.o \
> +	       hinic3_tx.o \
> +	       hinic3_rx.o \
> +	       hinic3_netdev_ops.o \
> +	       hinic3_rss.o \
> +	       hinic3_main.o
> \ No newline at end of file

Add newline.

