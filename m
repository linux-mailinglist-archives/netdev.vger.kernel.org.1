Return-Path: <netdev+bounces-226190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9DB9DBCA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386AE3B0028
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03E2E8B98;
	Thu, 25 Sep 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WaqjdGcX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A3192B7D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783336; cv=none; b=AxfeHWINEnpOpDH1rpd8Tw0PGksQzQP4aQr0SfpSFu1LRhvDJfMm/lQa2XcUCg7NXLcFreay0Bi53ztaosLFY85PFcFC0mLDDEjWNdj3Iim43eGwfQH7/VEDBU3/vcgBoicBNIg+QeN5ky8F7xdrqyP4Xcka0/upt0gLKorJPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783336; c=relaxed/simple;
	bh=vmpKPpJ9edGwvBU3WOJNXVFGcNmO3niUMMwVnvV8U8k=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=QdcziYUkF/1ty6XM2h7Kxbe86mvTT73EVaeeRICTxa0MtH6E+yU4cTb7lZgGkzkw5JC3g4xxXl9Pb33qsH1kA/oC/Yox2EpoPmUgJ3dw/sIafPIsJahCvaUBftxs70pqDx+iYpiWrCTQSxeqtxP899rbG7Qc10GyIOwGB4c4LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WaqjdGcX; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758783330; h=Message-ID:Subject:Date:From:To;
	bh=1K8NM0NRkVIQqV7UH16kP4yvZLTpy47lXatQvudXFjw=;
	b=WaqjdGcXEsh0IEKcn7/3cFSQOgqeMWuw7WGXZp5mLiSaTkgerJfCvttLnDWAWBMr0mvjC3GFIl5LBLOpSZ3oJjDicCrPLiQV/MiNhS6CpgG5Z64phnKFA4d9lYfPd+Nkdg4hPC+jVkyyOdOGF9AqLY5jOOA8gPduYrzISI4mH2c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Woml7Xo_1758783327 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 14:55:28 +0800
Message-ID: <1758782566.2551036-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 25 Sep 2025 14:42:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert  Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
 <cfae046e-106d-4963-88be-8ca116859538@intel.com>
In-Reply-To: <cfae046e-106d-4963-88be-8ca116859538@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Thanks for your review.

On Fri, 19 Sep 2025 15:00:29 +0200, Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> On 9/19/25 03:48, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
> >
> > This commit is indeed quite large, but further splitting it would not be
> > meaningful. Historically, many similar drivers have been introduced with
> > commits of similar size and scope, so we chose not to invest excessive
> > effort into finer-grained splitting.
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> if, by any chance, there were more than you developing this
> driver, it is the best moment to give some credit via Co-developed-by
> tags to major contributors

I developed this driver, no co-contributors.

>
> please find my feedback inline, sorry for it being in random places,
> otherwise it would take a whole day
> (but please apply fix for each type of issue per whole series)
>
> > ---
> >
> > v3: Thanks for the comments from Paolo Abenchi
> > v2: Thanks for the comments from Simon Horman and Andrew Lunn
> > v1: Thanks for the comments from Simon Horman and Andrew Lunn
> >
> >   MAINTAINERS                                   |   8 +
> >   drivers/net/ethernet/Kconfig                  |   1 +
> >   drivers/net/ethernet/Makefile                 |   1 +
> >   drivers/net/ethernet/alibaba/Kconfig          |  29 +
> >   drivers/net/ethernet/alibaba/Makefile         |   5 +
> >   drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
> >   drivers/net/ethernet/alibaba/eea/eea_adminq.c | 452 ++++++++++
> >   drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
> >   drivers/net/ethernet/alibaba/eea/eea_desc.h   | 155 ++++
> >   .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
> >   .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
> >   drivers/net/ethernet/alibaba/eea/eea_net.c    | 575 +++++++++++++
> >   drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
> >   drivers/net/ethernet/alibaba/eea/eea_pci.c    | 574 +++++++++++++
> >   drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
> >   drivers/net/ethernet/alibaba/eea/eea_ring.c   | 267 ++++++
> >   drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
> >   drivers/net/ethernet/alibaba/eea/eea_rx.c     | 784 ++++++++++++++++++
> >   drivers/net/ethernet/alibaba/eea/eea_tx.c     | 405 +++++++++
> >   19 files changed, 4048 insertions(+)
> >   create mode 100644 drivers/net/ethernet/alibaba/Kconfig
> >   create mode 100644 drivers/net/ethernet/alibaba/Makefile
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
> >   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8a770714101..9ffc6a753842 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -789,6 +789,14 @@ S:	Maintained
> >   F:	Documentation/i2c/busses/i2c-ali1563.rst
> >   F:	drivers/i2c/busses/i2c-ali1563.c
> >
> > +ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
> > +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > +M:	Wen Gu <guwen@linux.alibaba.com>
> > +R:	Philo Lu <lulie@linux.alibaba.com>
> > +L:	netdev@vger.kernel.org
> > +S:	Supported
>
> this is reserved for companies that run netdev-ci tests on their HW

Yes, so I think this is fine for us. In the future, the Alibaba Cloud instance
will provide the EEA NIC, and we will test it on such a machine.


>
> > +F:	drivers/net/ethernet/alibaba/eea
> > +
> >   ALIBABA ELASTIC RDMA DRIVER
> >   M:	Cheng Xu <chengyou@linux.alibaba.com>
> >   M:	Kai Shen <kaishen@linux.alibaba.com>
> > diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> > index aead145dd91d..307c68a4fd53 100644
> > --- a/drivers/net/ethernet/Kconfig
> > +++ b/drivers/net/ethernet/Kconfig
> > @@ -22,6 +22,7 @@ source "drivers/net/ethernet/aeroflex/Kconfig"
> >   source "drivers/net/ethernet/agere/Kconfig"
> >   source "drivers/net/ethernet/airoha/Kconfig"
> >   source "drivers/net/ethernet/alacritech/Kconfig"
> > +source "drivers/net/ethernet/alibaba/Kconfig"
> >   source "drivers/net/ethernet/allwinner/Kconfig"
> >   source "drivers/net/ethernet/alteon/Kconfig"
> >   source "drivers/net/ethernet/altera/Kconfig"
> > diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> > index 998dd628b202..358d88613cf4 100644
> > --- a/drivers/net/ethernet/Makefile
> > +++ b/drivers/net/ethernet/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_NET_VENDOR_ADI) += adi/
> >   obj-$(CONFIG_NET_VENDOR_AGERE) += agere/
> >   obj-$(CONFIG_NET_VENDOR_AIROHA) += airoha/
> >   obj-$(CONFIG_NET_VENDOR_ALACRITECH) += alacritech/
> > +obj-$(CONFIG_NET_VENDOR_ALIBABA) += alibaba/
> >   obj-$(CONFIG_NET_VENDOR_ALLWINNER) += allwinner/
> >   obj-$(CONFIG_NET_VENDOR_ALTEON) += alteon/
> >   obj-$(CONFIG_ALTERA_TSE) += altera/
> > diff --git a/drivers/net/ethernet/alibaba/Kconfig b/drivers/net/ethernet/alibaba/Kconfig
> > new file mode 100644
> > index 000000000000..4040666ce129
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/Kconfig
> > @@ -0,0 +1,29 @@
> > +#
> > +# Alibaba network device configuration
> > +#
> > +
> > +config NET_VENDOR_ALIBABA
> > +	bool "Alibaba Devices"
> > +	default y
> > +	help
> > +	  If you have a network (Ethernet) device belonging to this class, say Y.
> > +
> > +	  Note that the answer to this question doesn't directly affect the
>
> I would say it does (at least with your proposed `default m` below)

??


>
> > +	  kernel: saying N will just cause the configurator to skip all
> > +	  the questions about Alibaba devices. If you say Y, you will be asked
> > +	  for your specific device in the following questions.
> > +
> > +if NET_VENDOR_ALIBABA
> > +
> > +config EEA
> > +	tristate "Alibaba Elastic Ethernet Adaptor support"
> > +	depends on PCI_MSI
> > +	depends on 64BIT
> > +	select PAGE_POOL
> > +	default m
> > +	help
> > +	  This driver supports Alibaba Elastic Ethernet Adaptor"
> > +
> > +	  To compile this driver as a module, choose M here.
> > +
> > +endif #NET_VENDOR_ALIBABA
> > diff --git a/drivers/net/ethernet/alibaba/Makefile b/drivers/net/ethernet/alibaba/Makefile
> > new file mode 100644
> > index 000000000000..7980525cb086
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/Makefile
> > @@ -0,0 +1,5 @@
> > +#
> > +# Makefile for the Alibaba network device drivers.
> > +#
> > +
> > +obj-$(CONFIG_EEA) += eea/
> > diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
> > new file mode 100644
> > index 000000000000..bf2dad05e09a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> > @@ -0,0 +1,9 @@
> > +
> > +obj-$(CONFIG_EEA) += eea.o
> > +eea-objs := eea_ring.o \
>
> eea-y := ...
> as *-objs suffix is reserved rather for (user-space) host programs while
>      usually *-y suffix is used for kernel drivers (although *-objs works
>      for that purpose for now).
>
> would be also good to start with this (and other, like #includes) lists
> sorted

Will fix.

>
> > +	eea_net.o \
> > +	eea_pci.o \
> > +	eea_adminq.o \
> > +	eea_ethtool.o \
> > +	eea_tx.o \
> > +	eea_rx.o
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> > new file mode 100644
> > index 000000000000..625dd27bfb5d
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> > @@ -0,0 +1,452 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/etherdevice.h>
> > +#include <linux/utsname.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/version.h>
>
> would be great to sort includes
> BTW, do you need version.h? (IWYU, but not more)
>
> > +
> > +#include "eea_net.h"
> > +#include "eea_ring.h"
> > +#include "eea_adminq.h"
> > +#include "eea_pci.h"
> > +
> > +#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
> > +
> > +#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
> > +#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
> > +#define EEA_AQ_CMD_QUEUE_DESTROY_Q   ((1 << 8) | 2)
> > +
> > +#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
> > +
> > +#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
> > +
> > +#define ERING_DESC_F_AQ_PHASE	     (BIT(15) | BIT(7))
>
> EEA_ prefix

Will fix

>
> > +
> > +struct eea_aq_create {
> > +#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
> > +#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
> > +#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
>
> move #defines out ouf struct definitions

OK.


>
> > +	__le32 flags;
> > +	/* queue index.
> > +	 * rx: 0 == qidx % 2
> > +	 * tx: 1 == qidx % 2
> > +	 */
> > +	__le16 qidx;
> > +	/* the depth of the queue */
> > +	__le16 depth;
> > +	/*  0: without SPLIT HDR
> > +	 *  1: 128B
> > +	 *  2: 256B
> > +	 *  3: 512B
> > +	 */
> > +	u8 hdr_buf_size;
> > +	u8 sq_desc_size;
> > +	u8 cq_desc_size;
> > +	u8 reserve0;
> > +	/* The vector for the irq. rx,tx share the same vector */
> > +	__le16 msix_vector;
> > +	__le16 reserve;
> > +	/* sq ring cfg. */
> > +	__le32 sq_addr_low;
> > +	__le32 sq_addr_high;
> > +	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
> > +	__le32 cq_addr_low;
> > +	__le32 cq_addr_high;
> > +};
> > +
> > +struct aq_queue_drv_status {
>
> add eea_ prefix to all your structs, fuctions, and defines
>
> > +	__le16 qidx;
> > +
> > +	__le16 sq_head;
> > +	__le16 cq_head;
> > +	__le16 reserved;
> > +};
> > +
> > +struct eea_aq_host_info_cfg {
> > +#define EEA_OS_DISTRO		0
> > +#define EEA_DRV_TYPE		0
> > +#define EEA_OS_LINUX		1
> > +#define EEA_SPEC_VER_MAJOR	1
> > +#define EEA_SPEC_VER_MINOR	0
> > +	__le16	os_type;        /* Linux, Win.. */
>
> really?
>
> > +	__le16	os_dist;
> > +	__le16	drv_type;
> > +
> > +	__le16	kern_ver_major;
> > +	__le16	kern_ver_minor;
> > +	__le16	kern_ver_sub_minor;
> > +
> > +	__le16	drv_ver_major;
> > +	__le16	drv_ver_minor;
> > +	__le16	drv_ver_sub_minor;
> > +
> > +	__le16	spec_ver_major;
> > +	__le16	spec_ver_minor;
> > +	__le16	pci_bdf;
> > +	__le32	pci_domain;
> > +
> > +	u8      os_ver_str[64];
> > +	u8      isa_str[64];
> > +};
> > +
> > +struct eea_aq_host_info_rep {
> > +#define EEA_HINFO_MAX_REP_LEN	1024
> > +#define EEA_HINFO_REP_PASS	1
> > +#define EEA_HINFO_REP_REJECT	2
> > +	u8	op_code;
> > +	u8	has_reply;
> > +	u8	reply_str[EEA_HINFO_MAX_REP_LEN];
> > +};
> > +
> > +static struct ering *qid_to_ering(struct eea_net *enet, u32 qid)
> > +{
> > +	struct ering *ering;
> > +
> > +	if (qid % 2 == 0)
> > +		ering = enet->rx[qid / 2]->ering;
> > +	else
> > +		ering = enet->tx[qid / 2].ering;
> > +
> > +	return ering;
> > +}
> > +
> > +#define EEA_AQ_TIMEOUT_US (60 * 1000 * 1000)
> > +
> > +static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
> > +			     dma_addr_t req_addr, dma_addr_t res_addr,
> > +			     u32 req_size, u32 res_size)
> > +{
> > +	struct eea_aq_cdesc *cdesc;
> > +	struct eea_aq_desc *desc;
> > +	int ret;
> > +
> > +	desc = ering_aq_alloc_desc(enet->adminq.ring);
> > +
> > +	desc->classid = cmd >> 8;
> > +	desc->command = cmd & 0xff;
> > +
> > +	desc->data_addr = cpu_to_le64(req_addr);
> > +	desc->data_len = cpu_to_le32(req_size);
> > +
> > +	desc->reply_addr = cpu_to_le64(res_addr);
> > +	desc->reply_len = cpu_to_le32(res_size);
> > +
> > +	/* for update flags */
> > +	wmb();
> > +
> > +	desc->flags = cpu_to_le16(enet->adminq.phase);
> > +
> > +	ering_sq_commit_desc(enet->adminq.ring);
> > +
> > +	ering_kick(enet->adminq.ring);
> > +
> > +	++enet->adminq.num;
> > +
> > +	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
> > +		enet->adminq.phase ^= ERING_DESC_F_AQ_PHASE;
> > +
> > +	ret = read_poll_timeout(ering_cq_get_desc, cdesc, cdesc, 0,
> > +				EEA_AQ_TIMEOUT_US, false, enet->adminq.ring);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = le32_to_cpu(cdesc->status);
> > +
> > +	ering_cq_ack_desc(enet->adminq.ring, 1);
> > +
> > +	if (ret)
> > +		netdev_err(enet->netdev,
> > +			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
> > +			   void *req, u32 req_size, void *res, u32 res_size)
> > +{
> > +	dma_addr_t req_addr, res_addr;
> > +	struct device *dma;
> > +	int ret;
> > +
> > +	dma = enet->edev->dma_dev;
> > +
> > +	req_addr = 0;
> > +	res_addr = 0;
> > +
> > +	if (req) {
> > +		req_addr = dma_map_single(dma, req, req_size, DMA_TO_DEVICE);
>
> no idea how much adminq you need to send, but it feels wrong to do dma
> mapping each time

Not too many. If any issues arise, we can improve it in the future.


>
> > +		if (unlikely(dma_mapping_error(dma, req_addr)))
> > +			return -ENOMEM;
> > +	}
> > +
> > +	if (res) {
> > +		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
> > +		if (unlikely(dma_mapping_error(dma, res_addr))) {
> > +			ret = -ENOMEM;
> > +			goto err_map_res;
> > +		}
> > +	}
> > +
> > +	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
> > +				req_size, res_size);
> > +
> > +	if (res)
> > +		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
> > +
> > +err_map_res:
> > +	if (req)
> > +		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
> > +
> > +	return ret;
> > +}
> > +
> > +void eea_destroy_adminq(struct eea_net *enet)
> > +{
> > +	/* Unactive adminq by device reset. So the device reset should be called
>
> s/Unactive/Deactivate/
> but this comment does not belong here, rather to the caller/s
>
> > +	 * before this.
> > +	 */
> > +	if (enet->adminq.ring) {
> > +		ering_free(enet->adminq.ring);
> > +		enet->adminq.ring = NULL;
> > +		enet->adminq.phase = 0;
> > +	}
> > +}
> > +
> > +int eea_create_adminq(struct eea_net *enet, u32 qid)
> > +{
> > +	struct ering *ering;
> > +	int err;
> > +
> > +	ering = ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
> > +			    sizeof(struct eea_aq_desc), "adminq");
> > +	if (!ering)
> > +		return -ENOMEM;
> > +
> > +	err = eea_pci_active_aq(ering);
> > +	if (err) {
> > +		ering_free(ering);
> > +		return -EBUSY;
> > +	}
> > +
> > +	enet->adminq.ring = ering;
> > +	enet->adminq.phase = BIT(7);
> > +	enet->adminq.num = 0;
> > +
> > +	/* set device ready to active adminq */
> > +	eea_device_ready(enet->edev);
> > +
> > +	return 0;
> > +}
> > +
> > +int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg)
> > +{
> > +	return eea_adminq_exec(enet, EEA_AQ_CMD_CFG_QUERY, NULL, 0, cfg,
> > +			       sizeof(*cfg));
> > +}
> > +
> > +static void qcfg_fill(struct eea_aq_create *qcfg, struct ering *ering,
> > +		      u32 flags)
> > +{
> > +	qcfg->flags = cpu_to_le32(flags);
> > +	qcfg->qidx = cpu_to_le16(ering->index);
> > +	qcfg->depth = cpu_to_le16(ering->num);
> > +
> > +	qcfg->hdr_buf_size = flags & EEA_QUEUE_FLAGS_HW_SPLIT_HDR ? 1 : 0;
>
> x = !!y instead of x = y ? 1 : 0
> (when needed to map to 0/1)


??

>
> > +	qcfg->sq_desc_size = ering->sq.desc_size;
> > +	qcfg->cq_desc_size = ering->cq.desc_size;
> > +	qcfg->msix_vector = cpu_to_le16(ering->msix_vec);
> > +
> > +	qcfg->sq_addr_low = cpu_to_le32(ering->sq.dma_addr);
> > +	qcfg->sq_addr_high = cpu_to_le32(ering->sq.dma_addr >> 32);
> > +
> > +	qcfg->cq_addr_low = cpu_to_le32(ering->cq.dma_addr);
> > +	qcfg->cq_addr_high = cpu_to_le32(ering->cq.dma_addr >> 32);
> > +}
> > +
> > +int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 flags)
> > +{
> > +	struct device *dev = enet->edev->dma_dev;
> > +	int i, err, db_size, q_size, qid;
> > +	struct eea_aq_create *q_buf;
> > +	dma_addr_t db_dma, q_dma;
> > +	struct eea_net_cfg *cfg;
> > +	struct ering *ering;
> > +	__le32 *db_buf;
> > +
> > +	err = -ENOMEM;
> > +
> > +	cfg = &enet->cfg;
> > +
> > +	if (cfg->split_hdr)
> > +		flags |= EEA_QUEUE_FLAGS_HW_SPLIT_HDR;
> > +
> > +	flags |= EEA_QUEUE_FLAGS_SQCQ;
> > +	flags |= EEA_QUEUE_FLAGS_HWTS;
> > +
> > +	db_size = sizeof(int) * num;
> > +	q_size = sizeof(struct eea_aq_create) * num;
>
> would be best to use struct_size()

will fix


>
> > +
> > +	db_buf = dma_alloc_coherent(dev, db_size, &db_dma, GFP_KERNEL);
> > +	if (!db_buf)
> > +		return err;
> > +
> > +	q_buf = dma_alloc_coherent(dev, q_size, &q_dma, GFP_KERNEL);
> > +	if (!q_buf)
> > +		goto err_db;
> > +
> > +	qid = qidx;
> > +	for (i = 0; i < num; i++, qid++)
> > +		qcfg_fill(q_buf + i, qid_to_ering(enet, qid), flags);
> > +
> > +	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
> > +			      q_buf, q_size, db_buf, db_size);
> > +	if (err)
> > +		goto err;
> > +	err = 0;
>
> this assignement makes no sense (please check if there is something
> missing in your source)

Yes. You are right.


>
> > +
> > +	qid = qidx;
> > +	for (i = 0; i < num; i++, qid++) {
> > +		ering = qid_to_ering(enet, qid);
> > +		ering->db = eea_pci_db_addr(ering->edev,
> > +					    le32_to_cpu(db_buf[i]));
> > +	}
> > +
> > +err:
> > +	dma_free_coherent(dev, q_size, q_buf, q_dma);
> > +err_db:
> > +	dma_free_coherent(dev, db_size, db_buf, db_dma);
> > +	return err;
> > +}
> > +
> > +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
> > +{
> > +	struct device *dev = enet->edev->dma_dev;
> > +	dma_addr_t dma_addr;
> > +	__le16 *buf;
> > +	u32 size;
> > +	int i;
> > +
> > +	if (qidx == 0 && num == -1)
> > +		return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL,
> > +				       NULL, 0, NULL, 0);
> > +
> > +	size = sizeof(__le16) * num;
> > +	buf = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < num; ++i)
> > +		buf[i] = cpu_to_le16(qidx++);
> > +
> > +	return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_Q,
> > +			       buf, size, NULL, 0);
> > +}
> > +
> > +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> > +{
> > +	struct aq_queue_drv_status *drv_status;
> > +	struct aq_dev_status *dev_status;
> > +	int err, i, num, size;
> > +	struct ering *ering;
> > +	void *rep, *req;
> > +
> > +	num = enet->cfg.tx_ring_num * 2 + 1;
> > +
> > +	req = kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KERNEL);
>
> sizeof(*ptr) instead of sizeof(type) when possible
>
> > +	if (!req)
> > +		return NULL;
> > +
> > +	size = struct_size(dev_status, q_status, num);
> > +
> > +	rep = kmalloc(size, GFP_KERNEL);
> > +	if (!rep) {
> > +		kfree(req);
> > +		return NULL;
> > +	}
> > +
> > +	drv_status = req;
> > +	for (i = 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {
> > +		ering = qid_to_ering(enet, i);
> > +		drv_status->qidx = cpu_to_le16(i);
> > +		drv_status->cq_head = cpu_to_le16(ering->cq.head);
> > +		drv_status->sq_head = cpu_to_le16(ering->sq.head);
> > +	}
> > +
> > +	drv_status->qidx = cpu_to_le16(i);
> > +	drv_status->cq_head = cpu_to_le16(enet->adminq.ring->cq.head);
> > +	drv_status->sq_head = cpu_to_le16(enet->adminq.ring->sq.head);
> > +
> > +	err = eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
> > +			      req, num * sizeof(struct aq_queue_drv_status),
> > +			      rep, size);
> > +	kfree(req);
> > +	if (err) {
> > +		kfree(rep);
> > +		return NULL;
> > +	}
> > +
> > +	return rep;
> > +}
> > +
> > +int eea_adminq_config_host_info(struct eea_net *enet)
> > +{
> > +	struct device *dev = enet->edev->dma_dev;
> > +	struct eea_aq_host_info_cfg *cfg;
> > +	struct eea_aq_host_info_rep *rep;
> > +	int rc = -ENOMEM;
> > +
> > +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +	if (!cfg)
> > +		return rc;
> > +
> > +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> > +	if (!rep)
> > +		goto free_cfg;
> > +
> > +	cfg->os_type            = cpu_to_le16(EEA_OS_LINUX);
> > +	cfg->os_dist            = cpu_to_le16(EEA_OS_DISTRO);
> > +	cfg->drv_type           = cpu_to_le16(EEA_DRV_TYPE);
> > +
> > +	cfg->kern_ver_major     = cpu_to_le16(LINUX_VERSION_MAJOR);
> > +	cfg->kern_ver_minor     = cpu_to_le16(LINUX_VERSION_PATCHLEVEL);
> > +	cfg->kern_ver_sub_minor = cpu_to_le16(LINUX_VERSION_SUBLEVEL);
> > +
> > +	cfg->drv_ver_major      = cpu_to_le16(EEA_VER_MAJOR);
> > +	cfg->drv_ver_minor      = cpu_to_le16(EEA_VER_MINOR);
> > +	cfg->drv_ver_sub_minor  = cpu_to_le16(EEA_VER_SUB_MINOR);
> > +
> > +	cfg->spec_ver_major     = cpu_to_le16(EEA_SPEC_VER_MAJOR);
> > +	cfg->spec_ver_minor     = cpu_to_le16(EEA_SPEC_VER_MINOR);
> > +
> > +	cfg->pci_bdf            = cpu_to_le16(eea_pci_dev_id(enet->edev));
> > +	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
> > +
> > +	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
> > +	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
>
> what is the benefit of this?
>
> > +
> > +	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
> > +			     cfg, sizeof(*cfg), rep, sizeof(*rep));
> > +
> > +	if (!rc) {
> > +		if (rep->op_code == EEA_HINFO_REP_REJECT) {
> > +			dev_err(dev, "Device has refused the initialization "
> > +				"due to provided host information\n");
>
> do not break strings that users are supposed to grep for
>
> > +			rc = -ENODEV;
> > +		}
> > +		if (rep->has_reply) {
> > +			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> > +			dev_warn(dev, "Device replied in host_info config: %s",
> > +				 rep->reply_str);
> > +		}
> > +	}
> > +
> > +	kfree(rep);
> > +free_cfg:
> > +	kfree(cfg);
> > +	return rc;
> > +}
>
>
>
> > +static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
> > +				 const struct eea_stat_desc *desc,
> > +				 u64 *data, u32 idx)
> > +{
> > +	void *stats_base = (void *)syncp;
>
> needles cast
>
> > +	u32 start, i;
> > +
> > +	do {
> > +		start = u64_stats_fetch_begin(syncp);
> > +		for (i = 0; i < num; i++)
> > +			data[idx + i] =
> > +				u64_stats_read(stats_base + desc[i].offset);
>
> nice trick
>
> > +
> > +	} while (u64_stats_fetch_retry(syncp, start));
> > +}
> > +
>
>
>
> > +static int eea_netdev_init_features(struct net_device *netdev,
> > +				    struct eea_net *enet,
> > +				    struct eea_device *edev)
> > +{
> > +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> > +	int err;
> > +	u32 mtu;
> > +
> > +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> > +
> > +	err = eea_adminq_query_cfg(enet, cfg);
> > +
>
> no blank line between value assignement and error check
>
> > +	if (err)
> > +		return err;
> > +
> > +	eea_update_cfg(enet, edev, cfg);
> > +
> > +	netdev->priv_flags |= IFF_UNICAST_FLT;
> > +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> > +
> > +	netdev->hw_features |= NETIF_F_HW_CSUM;
> > +	netdev->hw_features |= NETIF_F_GRO_HW;
> > +	netdev->hw_features |= NETIF_F_SG;
> > +	netdev->hw_features |= NETIF_F_TSO;
> > +	netdev->hw_features |= NETIF_F_TSO_ECN;
> > +	netdev->hw_features |= NETIF_F_TSO6;
> > +	netdev->hw_features |= NETIF_F_GSO_UDP_L4;
> > +
> > +	netdev->features |= NETIF_F_HIGHDMA;
> > +	netdev->features |= NETIF_F_HW_CSUM;
> > +	netdev->features |= NETIF_F_SG;
> > +	netdev->features |= NETIF_F_GSO_ROBUST;
> > +	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
> > +	netdev->features |= NETIF_F_RXCSUM;
> > +	netdev->features |= NETIF_F_GRO_HW;
> > +
> > +	netdev->vlan_features = netdev->features;
> > +
> > +	eth_hw_addr_set(netdev, cfg->mac);
> > +
> > +	enet->speed = SPEED_UNKNOWN;
> > +	enet->duplex = DUPLEX_UNKNOWN;
> > +
> > +	netdev->min_mtu = ETH_MIN_MTU;
> > +
> > +	mtu = le16_to_cpu(cfg->mtu);
> > +	if (mtu < netdev->min_mtu) {
> > +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. "
> > +			"Here we can only exit the initialization. %d < %d",
> > +			mtu, netdev->min_mtu);
> > +		return -EINVAL;
> > +	}
> > +
> > +	netdev->mtu = mtu;
> > +
> > +	/* If jumbo frames are already enabled, then the returned MTU will be a
> > +	 * jumbo MTU, and the driver will automatically enable jumbo frame
> > +	 * support by default.
> > +	 */
> > +	netdev->max_mtu = mtu;
> > +
> > +	netif_carrier_on(netdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct net_device_ops eea_netdev = {
> > +	.ndo_open           = eea_netdev_open,
> > +	.ndo_stop           = eea_netdev_stop,
> > +	.ndo_start_xmit     = eea_tx_xmit,
> > +	.ndo_validate_addr  = eth_validate_addr,
> > +	.ndo_get_stats64    = eea_stats,
> > +	.ndo_features_check = passthru_features_check,
> > +	.ndo_tx_timeout     = eea_tx_timeout,
> > +};
> > +
> > +static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
> > +{
> > +	struct net_device *netdev;
> > +	struct eea_net *enet;
> > +
> > +	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
> > +	if (!netdev) {
> > +		dev_err(edev->dma_dev,
> > +			"alloc_etherdev_mq failed with pairs %d\n", pairs);
> > +		return NULL;
> > +	}
> > +
> > +	netdev->netdev_ops = &eea_netdev;
> > +	netdev->ethtool_ops = &eea_ethtool_ops;
> > +	SET_NETDEV_DEV(netdev, edev->dma_dev);
> > +
> > +	enet = netdev_priv(netdev);
> > +	enet->netdev = netdev;
> > +	enet->edev = edev;
> > +	edev->enet = enet;
> > +
> > +	return enet;
> > +}
> > +
> > +static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
> > +{
> > +	u64 ts;
> > +
> > +	ts = eea_pci_device_ts(edev);
> > +
> > +	enet->hw_ts_offset = ktime_get_real() - ts;
> > +}
> > +
> > +static int eea_net_reprobe(struct eea_device *edev)
> > +{
> > +	struct eea_net *enet = edev->enet;
> > +	int err = 0;
> > +
> > +	enet->edev = edev;
> > +
> > +	if (!enet->adminq.ring) {
> > +		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	eea_update_ts_off(edev, enet);
> > +
> > +	if (edev->ha_reset_netdev_running) {
> > +		rtnl_lock();
> > +		enet->link_err = 0;
> > +		err = eea_netdev_open(enet->netdev);
> > +		rtnl_unlock();
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +int eea_net_probe(struct eea_device *edev)
> > +{
> > +	struct eea_net *enet;
> > +	int err = -ENOMEM;
> > +
> > +	if (edev->ha_reset)
> > +		return eea_net_reprobe(edev);
> > +
> > +	enet = eea_netdev_alloc(edev, edev->rx_num);
> > +	if (!enet)
> > +		return -ENOMEM;
> > +
> > +	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> > +	if (err)
> > +		goto err_adminq;
>
> would be best to name goto labels after what they do instead of
> from-where-you-jump-there
>
> > +
> > +	err = eea_adminq_config_host_info(enet);
> > +	if (err)
> > +		goto err_hinfo;
> > +
> > +	err = eea_netdev_init_features(enet->netdev, enet, edev);
> > +	if (err)
> > +		goto err_feature;
> > +
> > +	err = register_netdev(enet->netdev);
> > +	if (err)
> > +		goto err_ready;
> > +
> > +	eea_update_ts_off(edev, enet);
> > +	netif_carrier_off(enet->netdev);
> > +
> > +	netdev_dbg(enet->netdev, "eea probe success.\n");
> > +
> > +	return 0;
> > +
> > +err_ready:
> > +err_feature:
> > +err_hinfo:
> > +	eea_device_reset(edev);
> > +	eea_destroy_adminq(enet);
> > +
> > +err_adminq:
> > +	free_netdev(enet->netdev);
> > +	return err;
> > +}
> > +
> > +void eea_net_remove(struct eea_device *edev)
> > +{
> > +	struct net_device *netdev;
> > +	struct eea_net *enet;
> > +
> > +	enet = edev->enet;
> > +	netdev = enet->netdev;
> > +
> > +	if (edev->ha_reset) {
> > +		edev->ha_reset_netdev_running = false;
> > +		if (netif_running(enet->netdev)) {
> > +			rtnl_lock();
> > +			eea_netdev_stop(enet->netdev);
> > +			enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
> > +			enet->edev = NULL;
> > +			rtnl_unlock();
> > +			edev->ha_reset_netdev_running = true;
> > +		}
> > +	} else {
> > +		unregister_netdev(netdev);
> > +		netdev_dbg(enet->netdev, "eea removed.\n");
> > +	}
> > +
> > +	eea_device_reset(edev);
> > +
> > +	/* free adminq */
>
> please remove comments that say nothing more that code around
>
> > +	eea_destroy_adminq(enet);
> > +
> > +	if (!edev->ha_reset)
> > +		free_netdev(netdev);
> > +}
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> > new file mode 100644
> > index 000000000000..74e6a76c1f7f
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> > @@ -0,0 +1,196 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_NET_H__
> > +#define __EEA_NET_H__
> > +
> > +#include <linux/netdevice.h>
> > +#include <linux/ethtool.h>
> > +
> > +#include "eea_ring.h"
> > +#include "eea_ethtool.h"
> > +#include "eea_adminq.h"
> > +
> > +#define EEA_VER_MAJOR		1
> > +#define EEA_VER_MINOR		0
> > +#define EEA_VER_SUB_MINOR	0
> > +
> > +struct eea_tx_meta;
> > +
> > +struct eea_reprobe {
>
> would be best to name structs as nouns, and reserve verbs for functions
>
> > +	struct eea_net *enet;
> > +	bool running_before_reprobe;
> > +};
> > +
> > +struct enet_tx {
> > +	struct eea_net *enet;
> > +
> > +	struct ering *ering;
> > +
> > +	struct eea_tx_meta *meta;
> > +	struct eea_tx_meta *free;
> > +
> > +	struct device *dma_dev;
> > +
> > +	u32 index;
> > +
> > +	char name[16];
> > +
> > +	struct eea_tx_stats stats;
> > +};
> > +
> > +struct eea_rx_meta {
> > +	struct eea_rx_meta *next;
> > +
> > +	struct page *page;
> > +	dma_addr_t dma;
> > +	u32 offset;
> > +	u32 frags;
> > +
> > +	struct page *hdr_page;
> > +	void *hdr_addr;
> > +	dma_addr_t hdr_dma;
> > +
> > +	u32 id;
> > +
> > +	u32 truesize;
> > +	u32 headroom;
> > +	u32 tailroom;
> > +	u32 room;
> > +
> > +	u32 len;
> > +};
> > +
> > +struct enet_rx_pkt_ctx {
> > +	u16 idx;
> > +
> > +	bool data_valid;
> > +	bool do_drop;
> > +
> > +	struct sk_buff *head_skb;
> > +	struct sk_buff *curr_skb;
> > +};
> > +
> > +struct enet_rx {
> > +	struct eea_net *enet;
> > +
> > +	struct ering *ering;
> > +
> > +	struct eea_rx_meta *meta;
> > +	struct eea_rx_meta *free;
> > +
> > +	struct device *dma_dev;
> > +
> > +	u32 index;
> > +
> > +	u32 flags;
> > +
> > +	u32 headroom;
> > +
> > +	struct napi_struct napi;
> > +
> > +	struct eea_rx_stats stats;
> > +
> > +	u16 irq_n;
> > +
> > +	char name[16];
>
> IFNAMSIZ?
>
> > +
> > +	struct enet_rx_pkt_ctx pkt;
> > +
> > +	struct page_pool *pp;
> > +};
> > +
> > +struct eea_net_cfg {
> > +	u32 rx_ring_depth;
> > +	u32 tx_ring_depth;
> > +	u32 rx_ring_num;
> > +	u32 tx_ring_num;
> > +
> > +	u8 rx_sq_desc_size;
> > +	u8 rx_cq_desc_size;
> > +	u8 tx_sq_desc_size;
> > +	u8 tx_cq_desc_size;
> > +
> > +	u32 split_hdr;
> > +
> > +	struct hwtstamp_config ts_cfg;
> > +};
> > +
> > +struct eea_net_tmp {
> > +	struct eea_net_cfg   cfg;
> > +
> > +	struct enet_tx      *tx;
> > +	struct enet_rx     **rx;
> > +
> > +	struct net_device   *netdev;
> > +	struct eea_device   *edev;
> > +};
> > +
> > +enum {
> > +	EEA_LINK_ERR_NONE,
> > +	EEA_LINK_ERR_HA_RESET_DEV,
> > +	EEA_LINK_ERR_LINK_DOWN,
> > +};
> > +
> > +struct eea_net {
> > +	struct eea_device *edev;
> > +	struct net_device *netdev;
> > +
> > +	struct eea_aq adminq;
> > +
> > +	struct enet_tx *tx;
> > +	struct enet_rx **rx;
> > +
> > +	struct eea_net_cfg cfg;
> > +	struct eea_net_cfg cfg_hw;
> > +
> > +	u32 link_err;
> > +
> > +	bool started;
> > +	bool cpu_aff_set;
> > +
> > +	u8 duplex;
> > +	u32 speed;
> > +
> > +	u64 hw_ts_offset;
> > +};
> > +
> > +int eea_tx_resize(struct eea_net *enet, struct enet_tx *tx, u32 ring_num);
> > +
> > +int eea_net_probe(struct eea_device *edev);
> > +void eea_net_remove(struct eea_device *edev);
> > +int eea_net_freeze(struct eea_device *edev);
> > +int eea_net_restore(struct eea_device *edev);
> > +
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp);
> > +void enet_mk_tmp_cfg(struct eea_net *enet, struct eea_net_tmp *tmp);
> > +int eea_queues_check_and_reset(struct eea_device *edev);
> > +
> > +/* rx apis */
> > +int eea_poll(struct napi_struct *napi, int budget);
> > +
> > +void enet_rx_stop(struct enet_rx *rx);
> > +int enet_rx_start(struct enet_rx *rx);
> > +
> > +void eea_free_rx(struct enet_rx *rx);
> > +struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx);
> > +
> > +int eea_irq_free(struct enet_rx *rx);
> > +
> > +int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num);
> > +
> > +/* tx apis */
> > +int eea_poll_tx(struct enet_tx *tx, int budget);
> > +void eea_poll_cleantx(struct enet_rx *rx);
> > +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
> > +
> > +void eea_tx_timeout(struct net_device *netdev, u32 txqueue);
> > +
> > +void eea_free_tx(struct enet_tx *tx);
> > +int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx);
> > +
> > +#endif
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > new file mode 100644
> > index 000000000000..df84f9a9c543
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> > @@ -0,0 +1,574 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#include <linux/iopoll.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +
> > +#include "eea_pci.h"
> > +#include "eea_net.h"
> > +
> > +#define EEA_PCI_DB_OFFSET 4096
> > +
> > +#define EEA_PCI_CAP_RESET_DEVICE 0xFA
> > +#define EEA_PCI_CAP_RESET_FLAG BIT(1)
> > +
> > +struct eea_pci_cfg {
> > +	__le32 reserve0;
> > +	__le32 reserve1;
> > +	__le32 drv_f_idx;
> > +	__le32 drv_f;
> > +
> > +#define EEA_S_OK           BIT(2)
> > +#define EEA_S_FEATURE_DONE BIT(3)
> > +#define EEA_S_FAILED       BIT(7)
> > +	u8   device_status;
> > +	u8   reserved[7];
> > +
> > +	__le32 rx_num_max;
> > +	__le32 tx_num_max;
> > +	__le32 db_blk_size;
> > +
> > +	/* admin queue cfg */
> > +	__le16 aq_size;
> > +	__le16 aq_msix_vector;
> > +	__le32 aq_db_off;
> > +
> > +	__le32 aq_sq_addr;
> > +	__le32 aq_sq_addr_hi;
> > +	__le32 aq_cq_addr;
> > +	__le32 aq_cq_addr_hi;
> > +
> > +	__le64 hw_ts;
> > +};
> > +
> > +struct eea_pci_device {
> > +	struct eea_device edev;
> > +	struct pci_dev *pci_dev;
> > +
> > +	u32 msix_vec_n;
> > +
> > +	void __iomem *reg;
> > +	void __iomem *db_base;
> > +
> > +	struct work_struct ha_handle_work;
> > +	char ha_irq_name[32];
> > +	u8 reset_pos;
> > +};
> > +
> > +#define cfg_pointer(reg, item) \
> > +	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
> > +
> > +#define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
> > +#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, item))
> > +#define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
> > +#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(reg, item))
> > +
> > +#define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
> > +#define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
> > +#define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
> > +
> > +/* Due to circular references, we have to add function definitions here. */
> > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > +			   struct eea_pci_device *ep_dev);
> > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
> > +
> > +const char *eea_pci_name(struct eea_device *edev)
>
> generally such a thin wrappers for kernel API are discouraged
> (this driver would be part of the kernel, if someone will change
> function that you call in a way that requires change of caller, they
> will also change your driver;
> it is also easier for reviewers and maintainers to see something
> common to them instead of eea_pci_dev_id())


I see.

Thanks.


>
> > +{
> > +	return pci_name(edev->ep_dev->pci_dev);
> > +}
> > +
> > +int eea_pci_domain_nr(struct eea_device *edev)
> > +{
> > +	return pci_domain_nr(edev->ep_dev->pci_dev->bus);
> > +}
> > +
> > +u16 eea_pci_dev_id(struct eea_device *edev)
> > +{
> > +	return pci_dev_id(edev->ep_dev->pci_dev);
> > +}
> > +
> > +static void eea_pci_io_set_status(struct eea_device *edev, u8 status)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +
> > +	cfg_write8(ep_dev->reg, device_status, status);
> > +}
> > +
> > +static u8 eea_pci_io_get_status(struct eea_device *edev)
> > +{
> > +	struct eea_pci_device *ep_dev = edev->ep_dev;
> > +
> > +	return cfg_read8(ep_dev->reg, device_status);
> > +}
> > +
> > +static void eea_add_status(struct eea_device *dev, u32 status)
> > +{
> > +	eea_pci_io_set_status(dev, eea_pci_io_get_status(dev) | status);
> > +}
> > +

