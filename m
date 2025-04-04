Return-Path: <netdev+bounces-179337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2FA7C07C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050CC189C8BE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7781F4CB7;
	Fri,  4 Apr 2025 15:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542B86344;
	Fri,  4 Apr 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780277; cv=none; b=QlK42YUYoXVthteFy6CDKf58gv5QS4hL6oCkEGMq/Px/M4YsWs822RZt+KT3jkI7a+uCreM6CkniXRVcoA6snm3/hojiiXKRUo0MK4tGgfffvKe/7vXvGN4pvLyOJTa7+BEOwwu9VooZubImzDk8XdwUHCDygIEixGylI9Dam54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780277; c=relaxed/simple;
	bh=XIaT9WsyFMUG1vEDalOP24NzQJ+j12Xrs+RDtxU2IwM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOMJUEBzueXtiYVHJ/ILHgUURmYLJvKRTsnf4tq1HBiCTxqHuqgfh/ngzDqyq2DA8rOaUHtx0gdBzD/3BfUbv2U+/wpErdSZesdRA3ukU6pPfY3PIGbpp2h5I9FC1I20VOLKQOrPbvKCvLOyxIXwPk5X2oUJHYUiAvYRxPl33dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTj792bTmz6L4vt;
	Fri,  4 Apr 2025 23:23:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 165C2140595;
	Fri,  4 Apr 2025 23:24:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 17:24:31 +0200
Date: Fri, 4 Apr 2025 16:24:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v12 01/23] cxl: add type2 device basic support
Message-ID: <20250404162429.00007907@huawei.com>
In-Reply-To: <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
	<20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 15:45:33 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Hi Alejandro,

I'd have been tempted to break out a few trivial things to make
this patch more digestible. Things like the movement of DVSEC devices
to include/cxl/pci.h and the other bits that are cut and paste into
include/cxl/cxl.h  Whilst I know some prefer that in the patch that
needs it, when the code movement is large I'd rather have a noop
patch first.

Maybe also pushing the serial number down into cxl_memdev_state_create()
to avoid the changes in signature affecting the main patch.

Anyhow, up to you (or comments from others). It isn't that bad as a single patch

I'm not sure we long term want to expose a bunch of private data
with a comment saying 'don't touch' but it will do for now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..f7f6c2222cc0 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -1,35 +1,14 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#ifndef __CXL_PCI_H__
> -#define __CXL_PCI_H__
> +#ifndef __CXLPCI_H__
> +#define __CXLPCI_H__

Might be reasonable, but I don't think it belongs in this patch.


> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..1383fd724cf6
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,209 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */

Given at least some of this is cut and paste from drivers/cxl/cxl.h
probably makes sense to keep the Intel copyright notice as well.

> +
> +#ifndef __CXL_H
> +#define __CXL_H

Similar to below. I think we need the guards here and in
drivers/cxl/cxl.h to be more different.

> +
> +#include <linux/cdev.h>
> +#include <linux/node.h>
> +#include <linux/ioport.h>
> +#include <cxl/mailbox.h>
> +
> +/*

/**

Let's make this valid kernel-doc

Make sure to then run the kernel-docs script over it and fixup any
warnings etc.  Maybe this is a thing for another day though as it
is just code movement in this patch.


> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */

> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..c5a3ecad7ebf
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_PCI_H
That is pretty close to the define in drivers/cxl/cxlpci.h
which is __CXL_PCI_H__

Maybe we need something more obvious in the defines so that
we definitely don't have them clash in the future?


> +#define __CXL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif



