Return-Path: <netdev+bounces-158030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BBA1023B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0AD164671
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7E284A40;
	Tue, 14 Jan 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzu0WGFI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE291CDA19;
	Tue, 14 Jan 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843941; cv=none; b=fyJNvqMiTzA6UcQfJeDCN66hNuNfd7IFwQxHEMXb/tP5nJ3nKVQ3rF5awploYeP9oJtVxnMzL9Da9vXPkU7dHiS1JrVAHSxlrR+VUD36HE9dvR6YBEHqEYQ8xsCUbQqr6TV2fkvtqOqBP2xd3nzHbHJh0BXg58pNO9WYR7ycYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843941; c=relaxed/simple;
	bh=yjGa/XOca+kr7ntzRGUA8aW3yZEFIEKkisZvNDZ1fYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3JJ+HvZcWcD6CpBLsMKhYRYkcibjfrT8UTC6pzVc+pALGH5zNq8h1ZYoQLR8Ph5jeiI9malvQK8w/KHv3Z3lYFu7/4CgqSfjSWaIfq0CP9ZLV9nPPvkdowHI7fKhkRenXCZK2I6iklT8RAh0AebzHwH5/8QjxeYkD274KU4n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzu0WGFI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736843939; x=1768379939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjGa/XOca+kr7ntzRGUA8aW3yZEFIEKkisZvNDZ1fYE=;
  b=jzu0WGFIDBUwtWSo6boo8aF9xsfO/rjP+OCbuQAKG6HB/MZA60kottPE
   lJThLM1Krjhapek9lwis0bquEHkzmTzdQqxawrQ4kmx17xGWIITtfUDfC
   DfsIbl0D3MNPexQFGZyd2VOEHfni+2G8goLc0NfT2Llx5d7bZOArq+QL0
   e316pfZQq/G8iObRrYyIOf9yIPI4sLHCVHcM3f1Hl27MyAhlxefCKBUx9
   phxNd/evWoV9MFAKnUlGS20gKSvEwC1b8hUy3p5X+0Z3qhn1qdQE+G4S1
   G+SY3YXexllxhcgOc7Y7T1VOt++YmqPMBQtTQ9zD7SJi4b3AWLOSPS1E6
   A==;
X-CSE-ConnectionGUID: 5NJUdpxKTOWIazBsJygw6w==
X-CSE-MsgGUID: Tt4QNg7+QgeC2AFAVynOOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37359031"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="37359031"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:38:58 -0800
X-CSE-ConnectionGUID: GOn1L+FSSJ602cTCsmYN7g==
X-CSE-MsgGUID: dErzu0uiSk+QpPDsPklT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135617278"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:38:55 -0800
Date: Tue, 14 Jan 2025 09:35:36 +0100
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
Subject: Re: [PATCH net-next 3/3] eth: fbnic: Add hardware monitoring support
 via HWMON interface
Message-ID: <Z4Yh2EgkymBLE+hy@mev-dev.igk.intel.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
 <20250114000705.2081288-4-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114000705.2081288-4-sanman.p211993@gmail.com>

On Mon, Jan 13, 2025 at 04:07:05PM -0800, Sanman Pradhan wrote:
> This patch adds support for hardware monitoring to the fbnic driver,
> allowing for temperature and voltage sensor data to be exposed to
> userspace via the HWMON interface. The driver registers a HWMON device
> and provides callbacks for reading sensor data, enabling system
> admins to monitor the health and operating conditions of fbnic.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
>  drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
>  4 files changed, 89 insertions(+)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index ea6214ca48e7..239b2258ec65 100644

[...]

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 2.43.5

