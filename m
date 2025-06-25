Return-Path: <netdev+bounces-200948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B07CAE774F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E702317F074
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35C1E2307;
	Wed, 25 Jun 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVl50A4K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8022097;
	Wed, 25 Jun 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833707; cv=none; b=SSdS6itAiCA7SUqM5zdOSD/w8UcFehshoIyK4JkT/JVsMw9wjxrZJWqFafcwxMWLbtHTqgSK3vFpO+tLAJyxUJ8W3P0tuOvqGhEZGvR/6p2TZcVMqiR12Zl7bBtmUETKzNmLTWVWbLJlFqJXoj6f+conZ8jJxXtv8a6fA0QOTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833707; c=relaxed/simple;
	bh=2aNN0LNK3Qf6tRAO1HF7UcVQnZGCt20oYm9NewVYg5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buyrUnXmUfu5vxIFYFvAJxB6c7CQIfyHu6pk6DpFoWAVOIl2mIIxalSjtrEFEjWZhmBBDdh8DPsKpzELzw+LlxzeMGrbtJvL+F0k6Qfz1o+oiG7uQK8DXksTHUmnN+PU2Mufs5OduDu7rv+d+oLrywSswgHVPwm6f/Lr3wL4rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVl50A4K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750833706; x=1782369706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2aNN0LNK3Qf6tRAO1HF7UcVQnZGCt20oYm9NewVYg5E=;
  b=WVl50A4KxelbLyj5pZ+I9SDtXuft4AXRzBGf0TpHNTf6r2e3jIgkyjeU
   lar5/idNsayIZcA8Hth35U/5g3rmkuJMLWDkW6r6Tbrl/8xgyBNJ/83Tw
   o8TFl7Fm34DY2luoL+Vv4M7nlgFuwk38MAY3+eHg17mVSlVuY2WMCRjun
   c4MCt1kOFjRakds6/YZ8MhfHVsRxbrJoW4sNhi/y/tTHf3IGRw30HVD0v
   +YBZnsWKBs4tM95CvrXbpgf9qpQOZePwhp877a9o2ch1RcGxc7g2PXaAy
   HwTX4SddUe4Un+84E/9nml8gqacFIp1N/ndiF2cHeSR2KVtXTmI5VivBK
   A==;
X-CSE-ConnectionGUID: r/T05TFlSUyJMShU9nNjkw==
X-CSE-MsgGUID: efOu1N8CRJKlmiaJ9+0AXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64149176"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="64149176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:41:45 -0700
X-CSE-ConnectionGUID: 04EyyZ8GQG+zDsxpDI2eYQ==
X-CSE-MsgGUID: xksZvrIrTn+FolWKwu20mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="175777901"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 24 Jun 2025 23:41:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A7934138; Wed, 25 Jun 2025 09:41:40 +0300 (EEST)
Date: Wed, 25 Jun 2025 09:41:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: zhangjianrong <zhangjianrong5@huawei.com>
Cc: michael.jamet@intel.com, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, guhengsheng@hisilicon.com,
	caiyadong@huawei.com, xuetao09@huawei.com, lixinghang1@huawei.com
Subject: Re: [PATCH] [net] net: thunderbolt: Use correct request type in
 login/logout request packets
Message-ID: <20250625064140.GF2824380@black.fi.intel.com>
References: <20250625063048.1602018-1-zhangjianrong5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625063048.1602018-1-zhangjianrong5@huawei.com>

On Wed, Jun 25, 2025 at 02:30:48PM +0800, zhangjianrong wrote:
> It doesn't make sense to use TB_CFG_PKG_XDOMAIN_RESP as the request
> type of xdomain request packets.

Same here as with previous. It is RESP on purpose.

Did you try this patch?

