Return-Path: <netdev+bounces-211132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CE6B16D6E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7B61AA24A4
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221D21A92F;
	Thu, 31 Jul 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekzP1M4d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D882C60
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950213; cv=none; b=obE+cwslw8R+LBtXPrlNyzTGG4nwQTiGraVsdhCwPru8tHu93YcuNRUg6CXyAaRT+TcrqSFStQVeOtDkcnIOldcliuV6GtphkExDIA5cnNfgnJEtrHCSx86oWgBBfQdyfLTAdWNoxnW2p4w9rzYNgAeDXuti8NrPvaIc7kVFkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950213; c=relaxed/simple;
	bh=j1oBD01ZEISzjeSMRyPmgUYmgeo2iK1WwGILML0O1B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kLKeC6aPbcwhxxYr5tE1UXpbAcQvrZZ/kAnWLvJpk8FAH7lvZIyEVhvKZ4W3UtxspFvmtTaj/s/8xUinxvYntf8TvWxlKMhroDYCPC0QtNik3VQ/NGz5IGtGzkfuA1zFtOwcUfV1HhSEGC2Jc/Tq+qqLFy/xBKllf+XPwb8PQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekzP1M4d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753950211; x=1785486211;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j1oBD01ZEISzjeSMRyPmgUYmgeo2iK1WwGILML0O1B0=;
  b=ekzP1M4d5DCNb98G/IjwMEjDQ9f+jRqbYJZRTZdJvKxClSP8z7GaCtyK
   tCJK2/ZDS2rLQrcZWFqxnxzAsyWcOX5AmzRWnHktMA8k2xaKrYxBWAYS2
   i9yRJdoUsGpwjKJvNXRAG5kYf8qyhNFnwrLRV7PXux1kC4eDHEG6Da98b
   826QzQ+RR68+PVjHq5PTERSg9IGBQjGzPaoQ0CX9UkShfg1W2QKnjmCAN
   aYCso3lwlrbt1yagSu5lCSuIQCQLWlmZEiUmVhDWOnBLtFA3qziYeZn1+
   j2mHSBf0jyu29+gmZaUuDC+2SjPL0cLsMZUhcmBKa1zdWzWUwEWP72Qwf
   A==;
X-CSE-ConnectionGUID: QkgxwdGjRwqOKvzA0sJEEA==
X-CSE-MsgGUID: r7MgYWD3QfeUvWUp/slIfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56196322"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56196322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:23:28 -0700
X-CSE-ConnectionGUID: 4k6TXLqsT8WAQWnwBXZuxg==
X-CSE-MsgGUID: pavE8WqYRsevH6T0jAj/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167430170"
Received: from jkuryjak-mobl1.ger.corp.intel.com (HELO [10.245.115.185]) ([10.245.115.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 01:23:27 -0700
Message-ID: <4d88953a-8ffd-46a6-b1ab-16d9587b6e90@linux.intel.com>
Date: Thu, 31 Jul 2025 10:23:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
To: Luke Howard <lukeh@padl.com>, netdev@vger.kernel.org
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-31 7:35 AM, Luke Howard wrote:
> A DSA frame with an invalid source trunk ID could cause an out-of-bounds read
> access of dst->lags.
> 
> This patch adds a check to dsa_lag_by_id() to validate the LAG ID is not zero,

checkpatch is saying this line is not wrapped at 75 columns

> and is less than or equal to dst->lags_len. (The LAG ID is derived by adding
> one to the source trunk ID.)
> 
> Note: this is in the fast path for any frames within a trunk.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

> ---
>   include/net/dsa.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 2e148823c366c..67672c5ff22e5 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -180,6 +180,9 @@ struct dsa_switch_tree {
>   static inline struct dsa_lag *dsa_lag_by_id(struct dsa_switch_tree *dst,
>   					    unsigned int id)
>   {
> +	if (unlikely(id == 0 || id > dst->lags_len))
> +		return NULL;
> +
>   	/* DSA LAG IDs are one-based, dst->lags is zero-based */
>   	return dst->lags[id - 1];
>   }


