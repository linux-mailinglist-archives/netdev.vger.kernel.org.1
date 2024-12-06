Return-Path: <netdev+bounces-149674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF99E6C84
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA07282EF0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718651D47A2;
	Fri,  6 Dec 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJftculi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E262171;
	Fri,  6 Dec 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482080; cv=none; b=gtBzcB/qXxQ+Fv0pnJ7ecuAKdpQzOAeuG0ydkbmg1NKMKmAre9wac1OgwMH4ltv7NzuiOSMAMcKO3iu/haMhv33rMmD+xykRIKmHnCVIyioEKZfXtLAUexIbgHEv03s6foj60pA55q0u9Vw8v/ooj8R4inn41WjKlXw7KHyU7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482080; c=relaxed/simple;
	bh=kcsN2DMsf06BNl0qVghcB3m7/GuYTLDs3HRtB9VaMG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdx5jVxA48O4tWWCV+PyZRzWbT3NfUFsetjC8U3vYIcaxUANL/fur1w27VpZ6PJTcRwS2krDt9WyzLRHjPdakJmrFqwwxXOq/GxCePWSU/X6ChJ/d3tlPtRcYimuDBtIS/O1ejKPbk6DaMoKisM/vugcg+YDUozOhoB117JvN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJftculi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733482079; x=1765018079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcsN2DMsf06BNl0qVghcB3m7/GuYTLDs3HRtB9VaMG8=;
  b=XJftculi1DnyVdgHADDIzGTG7foVQyFHLNYrvZvdX+ASudeVrfhluQ1Q
   0mnQ2fqZhnHGjRjfZvCVRyth3XdWn5oVp84sCXq8S+i62xn1SimWwnhcX
   gNwJC0ALWAo4XG2Yp43T58ZnMfCQ9Sb7V6bcAZK0lD+/TbHVuTEFj2Lcr
   OykP7TNHhgYu9Wi6rfy13ovUjCPgICxF468VI6yVZS1IVpnHkonUcKbqR
   JDPxFUElcOQLnPSvyW1S+E7XGeERujs30f3luXOF+McnNJG01BblmwGua
   WW68GByQvb/5V9qizZ7kb3vqsrQWZnVy2FxcJeI8fdveUfY/VBAHs4yXa
   g==;
X-CSE-ConnectionGUID: zedaaq2zR8KHpPeCt8bq1A==
X-CSE-MsgGUID: 8tXpbM/2QUKV01uAcxjt5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51246010"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="51246010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 02:47:58 -0800
X-CSE-ConnectionGUID: YtMh9HGsRlyzjvAjcAu/OQ==
X-CSE-MsgGUID: Toj8KIEiRFywPi37RvufWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="98443317"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 02:47:55 -0800
Date: Fri, 6 Dec 2024 11:44:58 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, michal.kubiak@intel.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Refine the if statement
Message-ID: <Z1LVqssDBEZ7nsWQ@mev-dev.igk.intel.com>
References: <20241206084851.760475-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206084851.760475-1-justinlai0215@realtek.com>

On Fri, Dec 06, 2024 at 04:48:51PM +0800, Justin Lai wrote:
> Refine the if statement to improve readability.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
[...]

I am not sure if it is worth to change. However, looks correct:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1

