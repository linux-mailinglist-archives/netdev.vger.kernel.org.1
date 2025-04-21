Return-Path: <netdev+bounces-184384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A952AA9527F
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7283A9E92
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C464A8F;
	Mon, 21 Apr 2025 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee9IrGNV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2742DDBE;
	Mon, 21 Apr 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244525; cv=none; b=KdJedJzrhSfbWxOl86KZicaLU6Hsaj72euK8AaaqSndbLpR8VLEG+SHH3Kc97RQG1u/5TdNF5vPOftCsUsMQFxPzJZwaYRI3i8IO/AhV9sqjNZ/Vgz0LwN7jv6hCO/DCi5Ha3CWFEwl9FInruuUvuanXJSENI0bgt5pdhsSC0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244525; c=relaxed/simple;
	bh=y+u9o3uYT+ExmvtSXbLZr8bAFVgoBqK/gneBhs8PZLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glRW3uMvVRee8JF1emTXrCF5XeV5m+hVP74PWYsOkaOmK2cXAXigSCefr69wbOxf3Hjf3eiJewMWP+k+3Jsg6k10nNC8b0ZJYCyYZHnLjGL4lTPYYAJ0xqtem8nQ0YrJyn9ZIv0a7Z0lv/ILLbp3jUP7bX+sN7QYadMaNKjmi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee9IrGNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA64C4CEE4;
	Mon, 21 Apr 2025 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745244524;
	bh=y+u9o3uYT+ExmvtSXbLZr8bAFVgoBqK/gneBhs8PZLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ee9IrGNVBY468I0nIZFGOEwSSO4iJvmV3Vd8XmWujePOkW+RQw0qoTf5gPE74TnZX
	 C8qwUs7dBOH7vUuZLAMHPY+whZ5y16Alj+g6qhK4NH9aSW8/lQwyAugMGUmHKBPgkX
	 Ts1mQDeM8F3kFazN6V7zQoAIWI9/BkSajNLajuJFM0ROiLpWxVBeDRz0eNKGLZmJSl
	 jLi7vAzRyzF0K2AP8N2qSWfhDO6AFW5+6nFbaFugRIYCz8i1SYJEZgZLK5F91i+MwP
	 7PLXue2MFhNahQ6ie5tjBbSvEt2QfpqOrxjN8pZJABKrBwRH6YHk0J4IJEkLmDcQTW
	 sZljmP2HBMWYw==
Date: Mon, 21 Apr 2025 15:08:36 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next 03/14] libeth: add PCI device initialization
 helpers to libeth
Message-ID: <20250421140836.GH2789685@horms.kernel.org>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-4-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408124816.11584-4-larysa.zaremba@intel.com>

On Tue, Apr 08, 2025 at 02:47:49PM +0200, Larysa Zaremba wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> Add memory related support functions for drivers to access MMIO space and
> allocate/free dma buffers.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/libeth/pci.c b/drivers/net/ethernet/intel/libeth/pci.c

...

> +/**
> + * __libeth_pci_map_mmio_region - map PCI device MMIO region
> + * @mmio_info: struct to store the mapped MMIO region
> + * @offset: MMIO region start offset
> + * @size: MMIO region size
> + * @num_args: number of additional arguments present
> + *
> + * Return: true on success, false on memory map failure.
> + */
> +bool __libeth_pci_map_mmio_region(struct libeth_mmio_info *mmio_info,
> +				  resource_size_t offset,
> +				  resource_size_t size, int num_args, ...)
> +{
> +	struct pci_dev *pdev = mmio_info->pdev;
> +	struct libeth_pci_mmio_region *mr;
> +	resource_size_t pa;
> +	void __iomem *va;
> +	int bar_idx = 0;
> +	va_list args;
> +
> +	if (num_args) {
> +		va_start(args, num_args);
> +		bar_idx = va_arg(args, int);
> +		va_end(args);
> +	}
> +
> +	mr = libeth_find_mmio_region(&mmio_info->mmio_list, offset, bar_idx);
> +	if (mr) {
> +		pci_warn(pdev, "Mapping of BAR%u with offset %llu already exists\n",
> +			 bar_idx, offset);

Hi Phani, Larysa, all,

I think that the format specifier here should be %zu rather than %llu.

On ARM W=1 builds gcc 14.2.0 flags this as follows:

    CALL    scripts/checksyscalls.sh
    CC      drivers/net/ethernet/intel/libeth/pci.o
  In file included from ./include/linux/device.h:15,
                   from ./include/linux/pci.h:37,
                   from ./include/net/libeth/pci.h:7,
                   from drivers/net/ethernet/intel/libeth/pci.c:4:
  .../pci.c: In function '__libeth_pci_map_mmio_region':
  .../pci.c:92:32: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     92 |                 pci_warn(pdev, "Mapping of BAR%u with offset %llu already exists\n",
        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  .../dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
    110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
        |                              ^~~
  .../dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
    156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
        |                                                             ^~~~~~~
  .../pci.h:2704:41: note: in expansion of macro 'dev_warn'
   2704 | #define pci_warn(pdev, fmt, arg...)     dev_warn(&(pdev)->dev, fmt, ##arg)
        |                                         ^~~~~~~~
  .../pci.c:92:17: note: in expansion of macro 'pci_warn'
     92 |                 pci_warn(pdev, "Mapping of BAR%u with offset %llu already exists\n",
        |                 ^~~~~~~~
  .../pci.c:92:65: note: format string is defined here
     92 |                 pci_warn(pdev, "Mapping of BAR%u with offset %llu already exists\n",
        |                                                              ~~~^
        |                                                                 |
        |                                                                 long long unsigned int
        |                                                              %u

