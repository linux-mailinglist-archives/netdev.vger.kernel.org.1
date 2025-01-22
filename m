Return-Path: <netdev+bounces-160196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302BA18C63
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1C1885AB7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF31B424F;
	Wed, 22 Jan 2025 06:55:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A381A9B4E;
	Wed, 22 Jan 2025 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528940; cv=none; b=rikd7YEKCWb5fFFNhRL/uAiE6iJf9+LlkYXmAvyFgFLcUwIdGDJ75hkPpwLeUdlsnuK1iztBHRZdPgKtn+AAwv8gg5e/LCNYRhDV2Od1cXdBYxra2JAhrG1ENZx6YG4aUOWL/KQ5Ui+epVz6Wg31aXi+NxztI97ECu9pIYSyDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528940; c=relaxed/simple;
	bh=9EgEYI2zaQqMWwarkNInCEJONpKjuj6Zj6CocwsWjGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPsoylG9gBxddG+sX/vxMlHfHBtbKe/1g7QOrpzksfwMO32vyYg0Rpuy1/zbHigHWntPdNE6gmExukQ76biPMf/pjsd9MTxG20bXCs3rHYX363HVuGICePUm4X64pzDzdm3bEb6c18M2IhSMD9qUHz3N5Bn+fKfA7eN/3oW0PcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YdFCm1TCvz6K92s;
	Wed, 22 Jan 2025 14:53:40 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 7221C1400DB;
	Wed, 22 Jan 2025 14:55:35 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 22 Jan
 2025 07:55:22 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <przemyslaw.kitszel@intel.com>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <helgaas@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<meny.yossefi@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shenchenyang1@hisilicon.com>, <shijing34@huawei.com>, <sumang@marvell.com>,
	<wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v04 1/1] hinic3: module initialization and tx/rx logic
Date: Wed, 22 Jan 2025 09:07:52 +0200
Message-ID: <20250122070752.3966233-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <3bc8a815-96c3-46cd-ae87-b46b61648bca@intel.com>
References: <3bc8a815-96c3-46cd-ae87-b46b61648bca@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > Auxiliary driver registration.
> > Net device_ops registration but open/stop are empty stubs.
> > tx/rx logic.
>
> Take care for spelling: Tx/Rx; HW (just below).

Please elaborate. Spelling of what?

>
> >
> > All major data structures of the driver are fully introduced with the
> > code that uses them but without their initialization code that requires
> > management interface with the hw.
> >
> > Submitted-by: Gur Stavi <gur.stavi@huawei.com>
>
> this tag is not needed
>
> > Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
>
> your tag should be last
>
> > Signed-off-by: Xin Guo <guoxin09@huawei.com>
>
> no idea what Xin did, if you want to give credit to someone
> you could use Co-developed-by: tag (put it just above the SoB)
>
> > Signed-off-by: gongfan <gongfan1@huawei.com>
>
> It would be much appricieated if you will spell the full name
> for gongfan, at least two parts (like you did for the rest),
> especially for someone you put into the MAINTAINERS file.
> OTOH, please keep in mind that maintainer should be active
> on the mailing list (regarding this driver).
>

Ack

> > +
> > +Global function ID
> > +------------------
> > +
> > +Every function, PF or VF, has a unique ordinal identification within the device.
> > +Many commands to management (mbox or cmdq) contain this ID so HW can apply the
>
> s/commands to management/management commands/
>

Ack

> > +L:	netdev@vger.kernel.org
> > +S:	Supported
>
> there is a (relatively new) requirement that the device needs to report
> to the netdev CI to have an "S" here, so for now you should use "M"
>

Ack

> > +	# Fields of HW and management structures are little endian and are
> > +	# currently not converted
> > +	depends on !CPU_BIG_ENDIAN
> > +	depends on X86 || ARM64 || COMPILE_TEST
> > +	depends on PCI_MSI && 64BIT
> > +	select AUXILIARY_BUS
> > +	help
> > +	  This driver supports HiNIC PCIE Ethernet cards.
> > +	  To compile this driver as part of the kernel, choose Y here.
> > +	  If unsure, choose N.
> > +	  The default is N.
>
> the last 3 lines are very much obvious/redundant
>

Ack

> > diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
> > new file mode 100644
> > index 000000000000..02656853f629
> > --- /dev/null
> > +++ b/drivers/net/ethernet/huawei/hinic3/Makefile
> > @@ -0,0 +1,21 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
>
> too late
>

Ack

> > +
> > +obj-$(CONFIG_HINIC3) += hinic3.o
> > +
> > +hinic3-objs := hinic3_hwdev.o \
> > +	       hinic3_lld.o \
> > +	       hinic3_common.o \
> > +	       hinic3_hwif.o \
> > +	       hinic3_hw_cfg.o \
> > +	       hinic3_queue_common.o \
> > +	       hinic3_mbox.o \
> > +	       hinic3_hw_comm.o \
> > +	       hinic3_wq.o \
> > +	       hinic3_nic_io.o \
> > +	       hinic3_nic_cfg.o \
> > +	       hinic3_tx.o \
> > +	       hinic3_rx.o \
> > +	       hinic3_netdev_ops.o \
> > +	       hinic3_rss.o \
> > +	       hinic3_main.o
>
> in general, any list of random things could be sorted (to ease out git
> merges in the future)
>

Ack

> > +	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & BIT(HINIC3_SERVICE_T_NIC))
> > +
> > +bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
> > +{
> > +	if (!IS_NIC_TYPE(hwdev))
> > +		return false;
> > +
> > +	return true;
>
> this is just:
> 	return IS_NIC_TYPE(hwdev);
>

Ack

> > +static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void *buf_in,
> > +				 u32 in_size, void *buf_out, u32 *out_size)
> > +{
> > +	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM, cmd, buf_in,
> > +					in_size, buf_out, out_size, 0);
> > +}
> > +
> > +int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
> > +{
> > +	struct comm_cmd_func_reset func_reset;
>
>   = {}
>
> > +	u32 out_size = sizeof(func_reset);
> > +	int err;
> > +
> > +	memset(&func_reset, 0, sizeof(func_reset));
>
> with "= {}" above, memset() could be eliminated
>
> > +	func_reset.func_id = func_id;
> > +	func_reset.reset_flag = reset_flag;
>
> alternative would be
> 	struct comm_cmd_func_reset func_reset = {
> 		.func_id = func_id,
> 		.reset_flag = reset_flag,
> 	};
>

Ack

> > +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
> > +
> > +#ifndef HINIC3_HW_INTF_H
>
> please add two underscores to the header guards
>

Ack

> > +#define HINIC3_HW_INTF_H

