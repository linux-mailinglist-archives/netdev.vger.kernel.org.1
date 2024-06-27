Return-Path: <netdev+bounces-107082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93E919B92
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BD2832B0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B6629;
	Thu, 27 Jun 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAxQHA7R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0C4C6D
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446574; cv=none; b=HwTS0nCkEhXfFDEGH5zOJ1MBd3Rb7Rql1SyW7HX6Kgf8+uTBFxPCfPFF7N/d/R1H+z5QVY2CPnNcafBb6En1ejA6hiZVzqgFUC+oaiUB/apzHYlT6oID1xCO6BvLQCGtEOz2RbEm9grC3IEccAVznAHxhSh5sEfWciG+LspUdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446574; c=relaxed/simple;
	bh=m8dYd71ZgQj/j1p3AmMSu7U7kjBQL7OOUdrL5H6PoKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZIZN7nVpOqaz8T1Hz/Te69yWkqhYlNsJCU/15A+cC8N83XB8d/0xkK6MUOJiEj4u02FhFxLcS0em+8Sizn1f98Yvrdcivm6pp7xhVCOKA4h89pquvQ6rHzDpaYOOfRI8WTeYE3uTr9gRtStlWNh5iUaA/PB309VqVuZVxMbi+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAxQHA7R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719446573; x=1750982573;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=m8dYd71ZgQj/j1p3AmMSu7U7kjBQL7OOUdrL5H6PoKc=;
  b=gAxQHA7RxfL2ZE0SA8S7uqCllD5ZqrnVV0VzfFtiSwbJxcJf5topPaRL
   OJkL1kBSNgWzSxebwDGbAsxULbOcLWdTwfxRhI8zDnxIaqe5bDvxWtF5k
   9RSzRsL2u/FUNl6SzAZvMZzkMJunifipNCLu/D2ai/yJTIlKUfd/wvtKt
   8/Z9W7vOBBPYvlNBDUeTyLG25asfLocGp2ax7YpS+t6bBQPZRnf9Rwqbs
   lTq/BrqUno+Pndol2NRjarhcNSWVd/wukZJOTo0mBzmpVH2QsPFp3yknv
   g5twv4sbBJ1GMh4kFZwMuj+5ItrKNPVv3qrfVvUXVoaCnHtPr86Ul8AbC
   w==;
X-CSE-ConnectionGUID: uD8aalFeSzCWpQ61RLQ5eg==
X-CSE-MsgGUID: uza1IGzQR0qS+h0YC8jwKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27949014"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27949014"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 17:02:52 -0700
X-CSE-ConnectionGUID: tBrthuaZROaz6RO6m1y5Pw==
X-CSE-MsgGUID: R3TfP28uTBC0yoW+QwOgzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44597666"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.58])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 17:02:52 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "shenjian (K)" <shenjian15@huawei.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Kurt Kanzenbach
 <kurt@linutronix.de>
Subject: Re: [PATCH iwl-next v3] igc: Add MQPRIO offload support
In-Reply-To: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
References: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
Date: Wed, 26 Jun 2024 17:02:51 -0700
Message-ID: <87zfr75k2c.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kurt Kanzenbach <kurt@linutronix.de> writes:

> Add support for offloading MQPRIO. The hardware has four priorities as well
> as four queues. Each queue must be a assigned with a unique priority.
>
> However, the priorities are only considered in TSN Tx mode. There are two
> TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
> Therefore, use the legacy TSN Tx mode, which performs strict priority
> arbitration.
>
> Example for mqprio with hardware offload:
>
> |tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
> |   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
> |   queues 1@0 1@1 1@2 1@3 \
> |   hw 1
>
> The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
> frame preemption is not supported yet.
>
> Tested on Intel i225 and implemented by following data sheet section 7.5.2,
> Transmit Scheduling.
>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v3:
> - Use FIELD_PREP for Tx ARB (Simon)
> - Add helper for Tx ARB configuration (Simon)
> - Limit ethtool_set_channels when mqprio is enabled (Jian)
> - Link to v2: https://lore.kernel.org/r/20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de
>
> Changes in v2:
> - Improve changelog (Paul Menzel)
> - Link to v1: https://lore.kernel.org/r/20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius

