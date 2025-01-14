Return-Path: <netdev+bounces-158028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE99A10219
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A83418859AD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAF9246327;
	Tue, 14 Jan 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUaNKl7k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BE24024E;
	Tue, 14 Jan 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843634; cv=none; b=NmDGbX1O12wCbOsGvwjy4qprGdOQ8rZb/U1aiZohh9VL+MJwnkQiQTd2uPyn9QH4nfE+rxZD5XUMo4fLSi4Piba+ug21fvbCXtn2sEH8GeRu9itb8OMkypGNuQeG/7QWN/XaE77HTPzmsjzk47aDm4T5V5igXiaddw2zv895HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843634; c=relaxed/simple;
	bh=mRyUb7Ff3YbSTGrXqXvusDymcKq6lNrGUWgRP1Fzq24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW08KlVwZcAtGMQCZ5lRX98e5zqTz/ev02cdo2EkAiW4qYVNHAarv7kzgMQCCUZn8A0sffFgFPB2WFaSjqM9oGGJj+KNcIHkKBJY3HNzuk2bLmECbzUWgv+hgVWklm9VtvdLKsFeNK1CjBcuP8vGQlgPt7qSH5+ibC8O4ud+rMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUaNKl7k; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736843633; x=1768379633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mRyUb7Ff3YbSTGrXqXvusDymcKq6lNrGUWgRP1Fzq24=;
  b=mUaNKl7knXifi1G5gJhXgG6aQZouAv+noTuUUU/y8Ragl0Hm7TEUSfg5
   PLDoWKEs8v2HDb4z2IBmgRcqv53KoWjYQlBKSdk5IPK+rsM0UseBhJNvH
   OAIfEc26NNHsaehDdPXZfgMTUKaDe7oBBtf4RvY3tYoUyjlDtIUyzraqL
   ZLR1/+G7NSB61oz0ejphkJ3Z8RoOisgsQQDjvyMGYC3Ec/ej09iqxNqLV
   HW+yPG7ebFbPauKEvMB/6yF/Gg1PMHxc/U/kpqwp1vhpRU4EygYk1S7FN
   +BRNIEH43RovY2rKLE3+ki1eC7V/Sl50kmoQfLL8tq6DhLFi3UQ9IQaBn
   A==;
X-CSE-ConnectionGUID: gTjQABmZRb27FtGtvzNCoQ==
X-CSE-MsgGUID: IaIFEfb/QPm2hle2J8CyKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40809258"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="40809258"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:33:52 -0800
X-CSE-ConnectionGUID: r+EGSRCgTzCXktYzbJkyLA==
X-CSE-MsgGUID: mkq+NfL7R+Kq8q7XwvNfyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104909414"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:33:48 -0800
Date: Tue, 14 Jan 2025 09:30:29 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com, linux@roeck-us.net,
	mohsin.bashr@gmail.com, jdelvare@suse.com, horms@kernel.org,
	suhui@nfschina.com, linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev, linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com
Subject: Re: [PATCH net-next 1/3] eth: fbnic: hwmon: Add completion
 infrastructure for firmware requests
Message-ID: <Z4YgpZ+QgV6w7BYR@mev-dev.igk.intel.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
 <20250114000705.2081288-2-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114000705.2081288-2-sanman.p211993@gmail.com>

On Mon, Jan 13, 2025 at 04:07:03PM -0800, Sanman Pradhan wrote:
> Add infrastructure to support firmware request/response handling with
> completions. Add a completion structure to track message state including
> message type for matching, completion for waiting for response, and
> result for error propagation. Use existing spinlock to protect the writes.
> The data from the various response types will be added to the "union u"
> by subsequent commits.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic.h    |  1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 79 ++++++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h | 13 ++++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 50f97f5399ff..ad8ac5ac7be9 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -41,6 +41,7 @@ struct fbnic_dev {
> 
>  	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
>  	struct fbnic_fw_cap fw_cap;
> +	struct fbnic_fw_completion *cmpl_data;
>  	/* Lock protecting Tx Mailbox queue to prevent possible races */
>  	spinlock_t fw_tx_lock;
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 8f7a2a19ddf8..320615a122e4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -228,6 +228,63 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
>  	tx_mbx->head = head;
>  }
> 

[...]

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> --
> 2.43.5

