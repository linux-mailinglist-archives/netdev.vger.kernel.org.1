Return-Path: <netdev+bounces-205422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3DAFE9F8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBDD170D27
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE328D8EF;
	Wed,  9 Jul 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="peL+eUcU"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75928DF43
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067230; cv=none; b=A76JGcWqtEWL9vp9+O4ZX5Ek+zlTVjix7IkLoCiLFIVlhiWN5ZWZciyWiOee/Uh9d+3RH8bPziTmEa6vGE+HMEf6TxVErM/kajFZRqub1ybpyynTck37FqCboEDpB/Kvo30irC0OD0KST4fYLmD2/DA/ern7qqhk15D/x5z8b9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067230; c=relaxed/simple;
	bh=V+2EPrgkkzWuOdEbqmNF6WGjcqD7p1t3JxPmCI2+YIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6oYbDOqdurNRbyBCtxTPeNA8zXE8RKv6ehvVkblH65910F1AC4koGrutkOoUSzYOReVJ/qR42RjfpOXzDHkCYt9mHaEWu+HpcHNLqGkmr8z1dOHBF/9wuW2WSwcZRpDsPY7RNYLg2oUmuh7ggJObivi51G361bQTXnTf2fvCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=peL+eUcU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e1da86d-d544-425d-b1f6-fcc88bc49eed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752067226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6AkmueMs31ei/4o3raKBuieFooL6H+6Yz+Dy9SBapE=;
	b=peL+eUcUa9XgjfFgzUDgjYn0B6v5WqUErJ/O6Y6n5GCrfJNHFUgdNM1mPDanr/5ScRZYhE
	Fn4AJGXMgr+QycfKYtHj+DDK5zEDFfmg3yXPiUnpV1faEIa9ngTiKmbhap4UOePsquedGK
	uc53+NBbak/51yF9srk9ATTokD98xMY=
Date: Wed, 9 Jul 2025 14:20:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v06 5/8] hinic3: TX & RX Queue coalesce
 interfaces
To: Simon Horman <horms@kernel.org>, Gur Stavi <gur.stavi@huawei.com>
Cc: andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, gongfan1@huawei.com,
 guoxin09@huawei.com, helgaas@kernel.org, jdamato@fastly.com,
 kuba@kernel.org, lee@trager.us, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, luosifu@huawei.com, meny.yossefi@huawei.com,
 mpe@ellerman.id.au, netdev@vger.kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, shenchenyang1@hisilicon.com,
 shijing34@huawei.com, sumang@marvell.com, wulike1@huawei.com,
 zhoushuai28@huawei.com, zhuyikai1@h-partners.com
References: <ef88247b-e726-4f8b-9aec-b3601e44390f@linux.dev>
 <20250709082620.1015213-1-gur.stavi@huawei.com>
 <20250709115614.GZ452973@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250709115614.GZ452973@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/07/2025 12:56, Simon Horman wrote:
> On Wed, Jul 09, 2025 at 11:26:20AM +0300, Gur Stavi wrote:
>>> On 27/06/2025 07:12, Fan Gong wrote:
>>>> Add TX RX queue coalesce interfaces initialization.
>>>> It configures the parameters of tx & tx msix coalesce.
>>>>
>>>> Co-developed-by: Xin Guo <guoxin09@huawei.com>
>>>> Signed-off-by: Xin Guo <guoxin09@huawei.com>
>>>> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
>>>> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
>>>> Signed-off-by: Fan Gong <gongfan1@huawei.com>
>>>> ---
>>>>    .../net/ethernet/huawei/hinic3/hinic3_main.c  | 61 +++++++++++++++++--
>>>>    .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 10 +++
>>>>    2 files changed, 66 insertions(+), 5 deletions(-)
>>>>
>>>
>>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> Procedural question about submissions:
>> Are we allowed (or expected) to copy the "Reviewed-by" above to future
>> submissions as long as we do not modify this specific patch?
> 
> Vadim is free to offer his own guidance, as it's his tag.
> 
> But in principle tags should be carried forward into future submissions
> unless there is a material change. In this case I think that would
> mean a material change this patch.
> 
> But if in doubt, please ask.
> Thanks for doing so.

As Simon said, in general if there are no changes in the patch you can
carry forward Rb tag.

