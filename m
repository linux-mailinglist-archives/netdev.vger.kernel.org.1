Return-Path: <netdev+bounces-217831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B2B39EEA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C748C7C7076
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359E3126C3;
	Thu, 28 Aug 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNT3D2Qr"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AF311C01
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387787; cv=none; b=IeJ4TTg+X2XQLCtHtyA9Di8OF5L3OBWs1VaXKOG1zu+islDX9/4v5GgP8gSmTeU8z1kyB4d9J8Hpp/aAgeHW0Pp3MQ8OgT+TuCXMbqtsPT8klyc/RpjMGePoh+kxDyJyZuUIbGoC9I3IuRq4fHqEmykMyhQ71b3VyKJcpHLJRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387787; c=relaxed/simple;
	bh=0Lfc7/gisKl0GuyU0xae9i6tusRkuqMIzRZ4P5WcZ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+3pfmMBsKW4XXycsaUJVyztzEvCgqArkV2sdUjD5tuZejmq14/WO630ShdCaLBHfl8oupWn5eRL4fiwGuvQe33COt33koBcp8u3Vsgchku7gbttDcl+sN6FngnJT5HbvNxLE3niWlLLDgoj4M5Fth9H9TE0Ah0OwxmSiliH+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNT3D2Qr; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <892b525b-964b-4a7e-bcc4-8aa0cb8d0068@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756387773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+iREffaG1KUC32E2neaplXOub9NOMnRAdzW/PQKR+E=;
	b=MNT3D2QrgNDlrKe58D6lF5YfPjz48afQbrkMLjANS9KVCfr2YKfCfCCPFdpWvvY4LLkxCn
	c7XgvYi73nuRkRIkKQwF3bVnlhlp3COAXk0V7awNzGo3RbNyGVfQdFD7W8WdWdhk0iloPk
	Ea1LqORduYHIlv8uKYaxWlhUdBiwFLU=
Date: Thu, 28 Aug 2025 14:29:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/3] net: stmmac: replace memcpy with strscpy in
 ethtool
To: Konrad Leszczynski <konrad.leszczynski@intel.com>, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-2-konrad.leszczynski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828100237.4076570-2-konrad.leszczynski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 11:02, Konrad Leszczynski wrote:
> Fix kernel exception by replacing memcpy with strscpy when used with
> safety feature strings in ethtool logic.
> 
> [  +0.000023] BUG: KASAN: global-out-of-bounds in stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000115] Read of size 32 at addr ffffffffc0cfab20 by task ethtool/2571
> 
> [  +0.000005] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000003]  dump_stack_lvl+0x6c/0x90
> [  +0.000016]  print_report+0xce/0x610
> [  +0.000011]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000108]  ? kasan_addr_to_slab+0xd/0xa0
> [  +0.000008]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000101]  kasan_report+0xd4/0x110
> [  +0.000010]  ? stmmac_get_strings+0x17d/0x520 [stmmac]
> [  +0.000102]  kasan_check_range+0x3a/0x1c0
> [  +0.000010]  __asan_memcpy+0x24/0x70
> [  +0.000008]  stmmac_get_strings+0x17d/0x520 [stmmac]
> 
> Fixes: 8bf993a5877e8a0a ("net: stmmac: Add support for DWMAC5 and implement Safety Features")
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

