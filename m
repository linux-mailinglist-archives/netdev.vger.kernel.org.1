Return-Path: <netdev+bounces-200941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE0AE7654
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259D81BC1A3F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAE1DF26B;
	Wed, 25 Jun 2025 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVkxmwwK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A535280;
	Wed, 25 Jun 2025 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750828317; cv=none; b=eLVtAoF07ZMNNnQ1rCVwDYZc/tueOm9MvGY1iBE5Lw2CXti9/NIryGPI1a4pSaSDuro6pdCU9GDnqnXZvk7U8sZWLwuebwrksbuYJtjkGrdbSQ5Hko8tYnffiG7DD6IlrFsFULkDe806sTl0SHmH82ANzDptEAatZzUlg4LI3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750828317; c=relaxed/simple;
	bh=iJiJ493RnPIbnNIVIDYJPYx8ga4obhnvKqnibcxpBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o59+7wO8iWpQgf0KMe2FPF1GEI296IBtIIhr9GTZ1XqYpdvru/+7UfpurD31it+8Rb8K9ATN0GjXCO9bjFq3jvJ7+BfBrirUIFmNprzamllcMIyQIoqzVXO7Pz9dvtJ6oWQrO0d9Om3L/D2pYBrzLG0Ehwj3HsGpaRLN1klcLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVkxmwwK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750828315; x=1782364315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJiJ493RnPIbnNIVIDYJPYx8ga4obhnvKqnibcxpBDE=;
  b=TVkxmwwKmQQpc+xIkMdb78Q1h3p8G9mvFXMWimBMJm1VxxKp8aUHxeAk
   DaBINjddGGv1dJmWGN1joHZZfKtj2jG1r0Q+gJM/5zeUnUIg4azOKxu6T
   JS1UkjSZK8ts7PVi4yjkut5UmjNgwKI3gHFlq0KV84Jiyhvy0RNGPmToV
   qI+97DkIQhomdiNTztVpjnw7iWPAfZFTZ5//mLhD7va0nzsYNnON5XzR8
   8DuxwgNjyAkFTM1116bNKyFlZOV441PXF7JykRFpydSCzyDLaU4IS1C+x
   rCn2Yqn029Y/7TA1rHSZKyShjMtW/ew3nrIqERCwXWRYJ+JBHaIlrFhfE
   w==;
X-CSE-ConnectionGUID: OCjAfd4ASLG87tq96EbyGA==
X-CSE-MsgGUID: SP64GG4FSmin3bcpL7AdaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="55712615"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="55712615"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 22:11:54 -0700
X-CSE-ConnectionGUID: eYmFu9rsSvWSqPVvMQ+K3Q==
X-CSE-MsgGUID: UlYYHGLCRYqxPW7byIFbGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152238832"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2025 22:11:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E2C6B138; Wed, 25 Jun 2025 08:11:49 +0300 (EEST)
Date: Wed, 25 Jun 2025 08:11:49 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: zhangjianrong <zhangjianrong5@huawei.com>
Cc: michael.jamet@intel.com, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, guhengsheng@hisilicon.com,
	caiyadong@huawei.com, xuetao09@huawei.com, lixinghang1@huawei.com
Subject: Re: [PATCH] [net] net: thunderbolt: Fix the parameter passing of
 tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
Message-ID: <20250625051149.GD2824380@black.fi.intel.com>
References: <20250625020448.1407142-1-zhangjianrong5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625020448.1407142-1-zhangjianrong5@huawei.com>

On Wed, Jun 25, 2025 at 10:04:48AM +0800, zhangjianrong wrote:
> According to the description of tb_xdomain_enable_paths(), the third
> parameter represents the transmit ring and the fifth parameter represents
> the receive ring. tb_xdomain_disable_paths() is the same case.

Good catch this too! It works now because both rings ->hop is the same but
better to be fixed.

> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

