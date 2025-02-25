Return-Path: <netdev+bounces-169373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D80A43971
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5DF1882903
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DE020C026;
	Tue, 25 Feb 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPbN64AZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A294C80
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475448; cv=none; b=gHhF3GyPwsG9B0G4GdX7l6mqrPKcEy69aG26/cQUEuyWM3acJkoN/Z3SW4VZPxBkthluywE4OK9JFMBjs5acLrSisTZeoTl7C2m03H6ntm1i7t3GrEiPokGzkWU/Afhgm127x6hJrNDS1hNqPYzuxTS4jBQ15Q6kXg6yQFrFtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475448; c=relaxed/simple;
	bh=kC00upbw2CNPSxlB1c1v2NPeDqUKHdWijPcrPdFqNQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUAG35VX3iH5NknE30TbZujkbFGWJIEaopr7dQLG8FjUGJ1sRA5PCr+NQ9jISzYBEmKSZ51TRQR2fa8qnrxdCCiNNw2yi9JIS3x8vTdwgVV1t732WHhk/Ktq3GDFOmMjEoflObmLxa3Xiqsztkq5T58XlvWy6tyVnAg4zRK+/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPbN64AZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740475447; x=1772011447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kC00upbw2CNPSxlB1c1v2NPeDqUKHdWijPcrPdFqNQU=;
  b=FPbN64AZZE2n9/D2kbvPymeb+8JH0x8g/qTtybVayuCjk/VLzzBfVOia
   /5F75XUHDnhwSPOVNhRqFsYnVWm0BGzCtj27GaCmml/0Wr/OOBLaCGVKq
   MQP5VpPAIe0BpAeoXIHrUhIHFJ7gWfggxWa8lojy5znggE95C9+2GmASN
   dclTLTje1sq+gQjXrF/oc9xuwBoyjXJqKQNY4fxvshfcIs7F6mRBDYd8/
   4Q8btojsQLcKcKuAFS/Xw8ZvAwG8RYBytApYNewzjfmGvWm8qsSGLt46V
   cJKzHsvkX29Twe5ydZBALOTm/zz/pOPOTbul3xakr0MP5DgXt95DJaBrg
   A==;
X-CSE-ConnectionGUID: 5nkrn+1ASWq0ONCtnTm1Rg==
X-CSE-MsgGUID: Cybm8B9DSDOtYGLLNiVFdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40508222"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40508222"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:24:05 -0800
X-CSE-ConnectionGUID: Aa5eIeEKTQeWDyLsGULWuQ==
X-CSE-MsgGUID: JvZ6gVF+T++oBW7DINoAew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117262505"
Received: from mszapar-mobl1.ger.corp.intel.com (HELO [10.245.112.135]) ([10.245.112.135])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:24:04 -0800
Message-ID: <95382347-8e05-4164-98b8-eca168bf3969@linux.intel.com>
Date: Tue, 25 Feb 2025 10:24:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net 0/4] ice: improve validation of virtchnl parameters
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250218194415.GL1615191@kernel.org>
Content-Language: en-US
From: "Szapar-Mudlaw, Martyna" <martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250218194415.GL1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/18/2025 8:44 PM, Simon Horman wrote:
> On Mon, Feb 17, 2025 at 11:27:41AM +0100, Martyna Szapar-Mudlaw wrote:
>> This patch series introduces improvements to the `ice` driver and `virtchnl`
>> interface by adding stricter validation checks and preventing potential
>> out-of-bounds scenarios.
> 
> Hi Martyna,
> 
> The above talks about this patchset in terms of improvements rather than
> bug fixes (that manifest). If so, I think this should be targeted at
> iwl-next (i.e. net-next) rather than iwl-net (net). And the Fixes tags
> should be dropped.
> 

Hi Simon,

Thank for looking into this. I believe these patches provide fixes and 
would fit better with iwl-net since they correct improper value 
checking, ensuring that the driver can properly handle and reject 
invalid inputs from potentially malicious VFs.
I sent v2 with rephrased cover letter and some commit messages.

Thanks.
Martyna

> ...
> 


