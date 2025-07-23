Return-Path: <netdev+bounces-209255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B4B0ED04
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FA83B16A8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E727991C;
	Wed, 23 Jul 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgB17DSE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE402797A4;
	Wed, 23 Jul 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258755; cv=none; b=Dn2BLRjNknkXNk3EXowJr7hPJEDv46IrCnEam44lJwFh+pXmvxqdpF7UEd3d694TvegmjvO+e042zoWeYT+V6avA4pCZUFqPVzfPo7NZ77nKRwosuwByrTJitU814ibjdC96fCXFoqxWQAJk08P932uFt3b0adXoT4JiJecgqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258755; c=relaxed/simple;
	bh=zt9Qo87c6GQ+qZFQ/rW4OVrNszsm3KfmfrOniuhUpHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxO7yjLU9lmvXx/qKXnY7qXQz1CDT4PV2P8iNbCXH/uBd9O/6JEGF1b8kBPiAg91MRUig+AHggFt0fD1xa12mU6VbNh6I+af5PRwcUp5/V3ntiglgeyNomei6jKKLVJVYP5bVMmDj0E7gRUR/RD2Uk5lPFuzn+UO7pkw/ey4298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgB17DSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7ADC4CEE7;
	Wed, 23 Jul 2025 08:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753258755;
	bh=zt9Qo87c6GQ+qZFQ/rW4OVrNszsm3KfmfrOniuhUpHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgB17DSEvogPZOReGL8TNRDU1xw6PrnH9uHRmRPImf7NSbpfgJXJW/Vj8yoEwjVfJ
	 fm/JF+XfTuVcZOBi5aS1irPJPaNkD3XuliFF6qK7SYv/ZtezZwx0m0fbs7HDYCc5a7
	 kHxY1CtI+oWdGQ7WwjYHG3abjssoLgUrPkkt6bHQvb2FavcTuu2VTnfEcqQDUpyDDA
	 IYI9lY0ZXmSVRRdrLYb5BUCZfrtsHBhsnzMH5grDhMRyhS/N/u3fWdPaAeGnChwFid
	 hCLV5J1WKW6O5Zg8aW98ZXk0Wds5MZx+mRiRzppDkAheTwG33vYhff8j29cARYdJzf
	 cif31QqbIK1Kw==
Date: Wed, 23 Jul 2025 09:19:08 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Fu Guiming <fuguiming@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v10 1/8] hinic3: Async Event Queue interfaces
Message-ID: <20250723081908.GW2459@horms.kernel.org>
References: <cover.1753152592.git.zhuyikai1@h-partners.com>
 <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea50c6c329c5ffb77cfe059e07eeed187619346.1753152592.git.zhuyikai1@h-partners.com>

On Tue, Jul 22, 2025 at 03:18:40PM +0800, Fan Gong wrote:
> Add async event queue interfaces initialization.
> It allows driver to handle async events reported by HW.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
> index 0aa42068728c..a5aaf6febba9 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
> @@ -51,3 +51,16 @@ void hinic3_dma_free_coherent_align(struct device *dev,
>  	dma_free_coherent(dev, mem_align->real_size,
>  			  mem_align->ori_vaddr, mem_align->ori_paddr);
>  }
> +
> +/* Data provided to/by cmdq is arranged in structs with little endian fields but
> + * every dword (32bits) should be swapped since HW swaps it again when it
> + * copies it from/to host memory.
> + */

This scheme may work on little endian hosts.
But if so it seems unlikely to work on big endian hosts.

I expect you want be32_to_cpu_array() for data coming from hw,
with a source buffer as an array of __be32 while
the destination buffer is an array of u32.

And cpu_to_be32_array() for data going to the hw,
with the types of the source and destination buffers reversed.

If those types don't match your data, then we have
a framework to have that discussion.


That said, it is more usual for drivers to keep structures in the byte
order they are received. Stored in structures with members with types, in
this case it seems that would be __be32, and accessed using a combination
of BIT/GENMASK, FIELD_PREP/FIELD_GET, and cpu_to_be*/be*_to_cpu (in this
case cpu_to_be32/be32_to_cpu).

An advantage of this approach is that the byte order of
data is only changed when needed. Another is that it is clear
what the byte order of data is.

> +void hinic3_cmdq_buf_swab32(void *data, int len)
> +{
> +	u32 *mem = data;
> +	u32 i;
> +
> +	for (i = 0; i < len / sizeof(u32); i++)
> +		mem[i] = swab32(mem[i]);
> +}

This seems to open code swab32_array().

...

