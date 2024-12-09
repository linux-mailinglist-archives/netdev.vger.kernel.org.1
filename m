Return-Path: <netdev+bounces-150032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5C09E8B24
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAC0281163
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371F1C232D;
	Mon,  9 Dec 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTNFDvzx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD91C4A1B;
	Mon,  9 Dec 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723155; cv=none; b=RtgsL5WmahWpWfBpP/f5DQDUkxy+gfaUVYQk7Z3qq1RQYv6LUSoaITx2Vy9bCn3TLxHQBHOkX6L/FRuzH0m8uTVG6TB/hFrHlKMqVAU/7bZCJ8UI+OU676N6dLNljZrrE/2CIJcz/Nu5CdgrRe1JF8npBI9imwB6ff9kWYK/chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723155; c=relaxed/simple;
	bh=3X70tRunR7lYHlKpNIgdPIP119iuLEn/uQ0tKEhyDe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk1PVSqheJzwz//VOtHagvxWKDKo1y2Jl+8N+Ojcg2NsM8x4IdLJXf2hbKjl2681wN9O3Pw3Y/8I49z9BZ4Q0DE0zobUBPEOyTx3Z5j8YsdvYl+lhS3TKBkmyTHIefVxlcOMHaSMGCpNOoorWetCdZ9ijLHXz6q0K+MdbMVBNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTNFDvzx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733723154; x=1765259154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3X70tRunR7lYHlKpNIgdPIP119iuLEn/uQ0tKEhyDe0=;
  b=OTNFDvzxXKN6lSpN0V6pH2kUaHpC4t9FpQQX4yuxFzC/iK9vTY5LFFrx
   6qxglRO5wfT1O9PkyNE/yJ/vZg1ntR64fdx63qIPKVnvfRJbCHCY+W2uA
   mV/zkRLLwunrXLyNdxHEbmlrwIy2DeyRD0LwLU4I7v+QmLtdwjxRshGu7
   KAS4eAQAQ+06qoLDkul3db8BZhDfmgbIOlQc0Brms33LNHWsS8yHkKmf6
   4P4sUMHI3E7T5ln4uQp7Yz1POIafzrpHFK5SI8KRm2cPFCu+X9dub43rD
   +aPm8XrK2nx0+Vz8gTdqNMTG3IpG+nXUDQPkkMCGNS/8AAGzsQr00GGXf
   Q==;
X-CSE-ConnectionGUID: M1Z8xtfwSoeKKgoDzpDCWw==
X-CSE-MsgGUID: xTBJrFfFTJCUjZLx4oQYkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37934839"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37934839"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:45:53 -0800
X-CSE-ConnectionGUID: Jmfx+m5HTp6cwNLutHY53g==
X-CSE-MsgGUID: Ojm1sNYFT6mihTvGQ9LVPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99419996"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 21:45:51 -0800
Date: Mon, 9 Dec 2024 06:42:49 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, michal.kubiak@intel.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Refine the if statement
Message-ID: <Z1aDWTa2VzXiPpNf@mev-dev.igk.intel.com>
References: <20241206084851.760475-1-justinlai0215@realtek.com>
 <Z1LVqssDBEZ7nsWQ@mev-dev.igk.intel.com>
 <20241206084158.172dd06d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206084158.172dd06d@kernel.org>

On Fri, Dec 06, 2024 at 08:41:58AM -0800, Jakub Kicinski wrote:
> On Fri, 6 Dec 2024 11:44:58 +0100 Michal Swiatkowski wrote:
> > I am not sure if it is worth to change.
> 
> True, tho, FWIW, if it's the maintainer of the codebase sending the
> change it's generally fine. Our "no pointless churn" rule is primarily
> for randoes.

Sure, thanks for letting me know.

