Return-Path: <netdev+bounces-227214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19462BAA5AE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 20:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB434225F9
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C797246762;
	Mon, 29 Sep 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqi2sNAF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74826773C
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170974; cv=none; b=VOqevlY3JYxssnIoLYgXLNvL3qPLv9e0Flz2g80g44MsM8quVxEXb+HQXR9UOCCh+8VGo5hkDg5t298IOnzDdPDkcPdvWsct+2fACdCca2ItFvL37BlC2JajUo7GO2UFAoelV1+Dq83lh0/SRY35fRUtKWIDsa1BAa9A57ksy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170974; c=relaxed/simple;
	bh=GW55Gf+3wuhtJvmZrDyz1BnsxeLqML4+MG6B6+7cdyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ui2Tf/HVpT3yHZyn1QvToSmNGaQyeH9r9ii5VBQXxSuG6n++mf8GI+PHqTCZUAbkswPrgSLIWa1JvW6boWxwxGL9beMLELGyYJbyB3KCK0AXA/yyEb5AzphgpXIsphl72TI5QlmEB7I5uib05Cpq4g28dXRGfjvJYF+CimgG+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqi2sNAF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759170972; x=1790706972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GW55Gf+3wuhtJvmZrDyz1BnsxeLqML4+MG6B6+7cdyg=;
  b=gqi2sNAFRDhOshBK+TkWuWe0Y2flLWT9luxkxYY5r9hXHx0I+QlI2LAY
   3Jbly5tyNM4lj8FFZNoS5m5KY7wNNb0JXczY16wO9F95XAg9BFxZCg8/Y
   0lGv2h/JQDUf5wjiTNIKKS2j6hpa81c5edE6DRp6bI48Uwaud6GdInAUf
   9Y6URFWN1nG9zxHF/v0fXw/YXi2eim8/0AurJ+M/X4eM0zVZsdxjMgfMr
   e2QZ0v6OSxMRDDpq6Yi5yFoyDAfZP644N82vZVz/rUECoLtxYUQosRoE5
   8XucwSBjIMN/+7UpUmnFi8E075YFDMX0adRTKH6wrVAUg7Wj3/4DRfXNx
   A==;
X-CSE-ConnectionGUID: Xkzqc8xEQgWovFiv7QLb4Q==
X-CSE-MsgGUID: blx4cI2rRAalRpR/djCi8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61465029"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61465029"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 11:36:12 -0700
X-CSE-ConnectionGUID: jgLoAYPmTyWt0IPloqvRJw==
X-CSE-MsgGUID: vIU3sjQcR8O5OODapycc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="177875250"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.109.116]) ([10.125.109.116])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 11:36:10 -0700
Message-ID: <70bd29ff-4805-4ac1-947b-5b4f6edb2dae@intel.com>
Date: Mon, 29 Sep 2025 11:36:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/5] bnxt_fwctl: Add documentation entries
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, jgg@ziepe.ca,
 michael.chan@broadcom.com
Cc: saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
 corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 selvin.xavier@broadcom.com, leon@kernel.org,
 kalesh-anakkur.purayil@broadcom.com
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <20250927093930.552191-6-pavan.chebbi@broadcom.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250927093930.552191-6-pavan.chebbi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/25 2:39 AM, Pavan Chebbi wrote:
> Add bnxt_fwctl to the driver and fwctl documentation pages.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  .../userspace-api/fwctl/bnxt_fwctl.rst        | 78 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  3 files changed, 80 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/bnxt_fwctl.rst b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> new file mode 100644
> index 000000000000..7cf2b65ea34b
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/bnxt_fwctl.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +fwctl bnxt driver
> +=================
> +
> +:Author: Pavan Chebbi
> +
> +Overview
> +========
> +
> +BNXT driver makes a fwctl service available through an auxiliary_device.
> +The bnxt_fwctl driver binds to this device and registers itself with the
> +fwctl subsystem.
> +
> +The bnxt_fwctl driver is agnostic to the device firmware internals. It
> +uses the Upper Layer Protocol (ULP) conduit provided by bnxt to send
> +HardWare Resource Manager (HWRM) commands to firmware.
> +
> +These commands can query or change firmware driven device configurations
> +and read/write registers that are useful for debugging.
> +
> +bnxt_fwctl User API
> +===================
> +
> +Each RPC request contains a message request structure (HWRM input),
> +its length, optional request timeout, and dma buffers' information
> +if the command needs any DMA. The request is then put together with
> +the request data and sent through bnxt's message queue to the firmware,
> +and the results are returned to the caller.
> +
> +A typical user application can send a FWCTL_INFO command using ioctl()
> +to discover bnxt_fwctl's RPC capabilities as shown below:
> +
> +        ioctl(fd, FWCTL_INFO, &fwctl_info_msg);
> +
> +where fwctl_info_msg (of type struct fwctl_info) describes bnxt_info_msg
> +(of type struct fwctl_info_bnxt) as shown below:
> +
> +        size = sizeof(fwctl_info_msg);
> +        flags = 0;
> +        device_data_len = sizeof(bnxt_info_msg);
> +        out_device_data = (__aligned_u64)&bnxt_info_msg;
> +
> +The uctx_caps of bnxt_info_msg represents the capabilities as described
> +in fwctl_bnxt_commands of include/uapi/fwctl/bnxt.h
> +
> +The FW RPC itself, FWCTL_RPC can be sent using ioctl() as:
> +
> +        ioctl(fd, FWCTL_RPC, &fwctl_rpc_msg);
> +
> +where fwctl_rpc_msg (of type struct fwctl_rpc) encapsulates fwctl_rpc_bnxt
> +(see bnxt_rpc_msg below). fwctl_rpc_bnxt members are set up as per the
> +requirements of specific HWRM commands described in include/linux/bnxt/hsi.h.
> +An example for HWRM_VER_GET is shown below:
> +
> +        struct fwctl_rpc_bnxt bnxt_rpc_msg;
> +        struct hwrm_ver_get_output resp;
> +        struct fwctl_rpc fwctl_rpc_msg;
> +        struct hwrm_ver_get_input req;
> +
> +        req.req_type = HWRM_VER_GET;
> +        req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
> +        req.hwrm_intf_min = HWRM_VERSION_MINOR;
> +        req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
> +        req.cmpl_ring = -1;
> +        req.target_id = -1;
> +
> +        bnxt_rpc_msg.req_len = sizeof(req);
> +        bnxt_rpc_msg.num_dma = 0;
> +        bnxt_rpc_msg.req = (__aligned_u64)&req;
> +
> +        fwctl_rpc_msg.size = sizeof(fwctl_rpc_msg);
> +        fwctl_rpc_msg.scope = FWCTL_RPC_DEBUG_READ_ONLY;
> +        fwctl_rpc_msg.in_len = sizeof(bnxt_rpc_msg) + sizeof(req);
> +        fwctl_rpc_msg.out_len = sizeof(resp);
> +        fwctl_rpc_msg.in = (__aligned_u64)&bnxt_rpc_msg;
> +        fwctl_rpc_msg.out = (__aligned_u64)&resp;
> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
> index a74eab8d14c6..826817bfd54d 100644
> --- a/Documentation/userspace-api/fwctl/fwctl.rst
> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
> @@ -148,6 +148,7 @@ area resulting in clashes will be resolved in favour of a kernel implementation.
>  fwctl User API
>  ==============
>  
> +.. kernel-doc:: include/uapi/fwctl/bnxt.h
>  .. kernel-doc:: include/uapi/fwctl/fwctl.h
>  .. kernel-doc:: include/uapi/fwctl/mlx5.h
>  .. kernel-doc:: include/uapi/fwctl/pds.h
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index 316ac456ad3b..8062f7629654 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -10,5 +10,6 @@ to securely construct and execute RPCs inside device firmware.
>     :maxdepth: 1
>  
>     fwctl
> +   bnxt_fwctl
>     fwctl-cxl
>     pds_fwctl


