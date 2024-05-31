Return-Path: <netdev+bounces-99839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82678D6ACA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD3B21E70
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F8B17CA03;
	Fri, 31 May 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgzTgIjj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F383208DA;
	Fri, 31 May 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187781; cv=none; b=t5dbtZZ5kGnADVHcuTHyPnkAzA6zXbYQDaPu3nq2lF4RJ2kVMntlSVgk5e3FTijyhGCvqOZvIE58L86C6DJkv90cQNZMzCgNaAPyRyFbMHiBTDkM5wpt6VuJTveUj8Xy68geZNUokZCrGIbdYYnyIRtsmbGpHO6tVD/yV4kJn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187781; c=relaxed/simple;
	bh=WdOxa9rbUS6q9NaRbl/yb1oNoDnPk7wE0Gs06YTBa5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1svYIUpLiLhpc16ehyBtzdG2xYVxKS/mEvrhMfoi8qzwLL1rG7aBeRk6GZdvhY+CHbFz7IdHSC8iESVh1fFItrJUMKw7VNjDf/En+cX2WBsxJgVe1oVwGKY0UuhbSPTWqh98WniRTbznhAv6zEe5aNwPQ4RpvBK3d7Ym2OYHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgzTgIjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5434C2BD10;
	Fri, 31 May 2024 20:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717187780;
	bh=WdOxa9rbUS6q9NaRbl/yb1oNoDnPk7wE0Gs06YTBa5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgzTgIjjAbBDZJJ7SdGkQGn03Ke7koI9sJcvxzGG85wTTVXYUoUXrCv+9F2+Fr/p0
	 5ann9Kudtmbhm5NuShztMv0EAjFKOaxiiV420z9fm1LqUhVPUVOjjqLne17p6ZqDO6
	 CcaaVgkybPhHQeBRx2sqjj+RSW+PjtVnZWl+o4Vr8Oxjr9x7Bb1Cx03QlEgURZp6EG
	 16FKupbqrEl+oHu3VZYCeT6Mx98i18EH8N3S3AP2mWIg+PYTuDZWK6dcQ/bk5MvmF6
	 fSkyQ45BE5IcQWascYcv86qbwspWcJ21Qps/yZ3OASZ6k7bTUBrGBqENi+FNwL1/53
	 BTJoDAANj2F2A==
Date: Fri, 31 May 2024 21:36:12 +0100
From: Simon Horman <horms@kernel.org>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>,
	Ze-yu Wang <Ze-yu.Wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <PeiLun.Suei@mediatek.com>,
	Chi-shen Yeh <Chi-shen.Yeh@mediatek.com>,
	Kevenny Hsieh <Kevenny.Hsieh@mediatek.com>
Subject: Re: [PATCH v11 08/21] virt: geniezone: Add vcpu support
Message-ID: <20240531203612.GU491852@kernel.org>
References: <20240529084239.11478-1-liju-clr.chen@mediatek.com>
 <20240529084239.11478-9-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529084239.11478-9-liju-clr.chen@mediatek.com>

On Wed, May 29, 2024 at 04:42:26PM +0800, Liju-clr Chen wrote:
> From: Yi-De Wu <yi-de.wu@mediatek.com>
> 
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

nit: I think there should be at most one From line,
     denoting the author of the patch. Based on the Signed-off-by
     lines I assume that is Yingshiuan Pan.

     If there are multiple authors perhaps
     the Co-developed-by tag should be used below.

     And on that note, it's not clear to me what the significance
     of the Signed-off-by lines, other than that of
     Yingshiuan Pan (presumed author) and Liju Chen (sender) are.
     I'd suggest deleting them unless they are
     accompanied by Co-developed-by tags.

     And, lastly, the sender's signed-off-by line should come last.

     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> 
> VMM use this interface to create vcpu instance which is a fd, and this
> fd will be for any vcpu operations, such as setting vcpu registers and
> accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
> hypervisor to do context switch to execute VM's vcpu context.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

...

> diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
> index 25614ea3dea2..9cc453c0819b 100644
> --- a/drivers/virt/geniezone/Makefile
> +++ b/drivers/virt/geniezone/Makefile
> @@ -6,4 +6,5 @@
>  
>  GZVM_DIR ?= ../../../drivers/virt/geniezone
>  
> -gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
> +gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
> +	  $(GZVM_DIR)/gzvm_vcpu.o
> diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
> new file mode 100644
> index 000000000000..1aca13fef422
> --- /dev/null
> +++ b/drivers/virt/geniezone/gzvm_vcpu.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <asm/sysreg.h>

nit: It's not clear to me that sysreg.h needs to be included in this file.

> +#include <linux/anon_inodes.h>
> +#include <linux/device.h>
> +#include <linux/file.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/soc/mediatek/gzvm_drv.h>
> +
> +/* maximum size needed for holding an integer */
> +#define ITOA_MAX_LEN 12
> +
> +static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
> +				     void __user *argp,
> +				     bool is_write)
> +{
> +	struct gzvm_one_reg reg;
> +	void __user *reg_addr;
> +	u64 data = 0;
> +	u64 reg_size;
> +	long ret;
> +
> +	if (copy_from_user(&reg, argp, sizeof(reg)))
> +		return -EFAULT;
> +
> +	reg_addr = (void __user *)reg.addr;

nit: Perhaps u64_to_user_ptr() is appropriate here.

     Also in gzvm_vm_ioctl_create_device() in patch 09/21.

> +	reg_size = (reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT;
> +	reg_size = BIT(reg_size);
> +
> +	if (reg_size != 1 && reg_size != 2 && reg_size != 4 && reg_size != 8)
> +		return -EINVAL;
> +
> +	if (is_write) {
> +		/* GZ hypervisor would filter out invalid vcpu register access */
> +		if (copy_from_user(&data, reg_addr, reg_size))
> +			return -EFAULT;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = gzvm_arch_vcpu_update_one_reg(vcpu, reg.id, is_write, &data);
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

...

