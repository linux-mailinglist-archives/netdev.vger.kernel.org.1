Return-Path: <netdev+bounces-230673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95BBED0C1
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E29019C0CA6
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAAA1DED57;
	Sat, 18 Oct 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eR/7eJ6g"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CA76026
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795534; cv=none; b=MPGegEf3RZ+fkvFCVqlU+xTtZdJECfqdvst34/2or+fDhsT0lHoZqAGP5FdrrtrdVnii5GFfz/ANQgLzZ+1ep/wR7in4+6Vf79H+PHlF+zcyOZ6gzL5FGu3xDfqeeyF78h1Ko/UXp8fg5Gdq2EUkXIOToeLPU5+u5nIFd3Bk+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795534; c=relaxed/simple;
	bh=rT76/HeKoCiPJNIM87b1fnkohuL6do2cs6pkSNtqkow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b00AXXQgeKV30lliUOdd8lPOA8u9gk9sgd/vdCyhbjWCP26BvynV4KWCuJPcQDuUHHNHLAHJ+j65kEJ7QDI8R0rJrfU/8owRpzBz16m9JoUH4ZVoQ2LCodlFkVgslT+AWlVucOrNt+9BVINkxd3I0oWgvfrD1WGTIVfeLkBFxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eR/7eJ6g; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eff0d886-ff55-4771-9c97-d7535081dfc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760795519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ah5E5pE2rrp07qf+X9HdubOtTWT1FIdVXucOT8I550c=;
	b=eR/7eJ6gHdysSobPZaTw1HgiA8ifFvrD1yryusB0LaboqhIY9d36YI4Do4eZAgeLDu1krr
	BptH8xluJtjbtBlHSyciqnvc1jSiKWD0nwVJz2rxNXmZyfpOCrOYa87AF1GiAYxy7bXdiN
	YUH32B3bw8xDo99HQ/oSKuV/z+4SV3w=
Date: Sat, 18 Oct 2025 14:51:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 10/14] ionic: convert to ndo_hwtstamp API
To: Brett Creeley <bcreeley@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Igor Russkikh <irusskikh@marvell.com>, Egor Pomozov <epomozov@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Brett Creeley <brett.creeley@amd.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20251013163749.5047-1-vadim.fedorenko@linux.dev>
 <20251013163749.5047-5-vadim.fedorenko@linux.dev>
 <6641d925-b953-46b3-9e45-2284d5e2e8ad@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <6641d925-b953-46b3-9e45-2284d5e2e8ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/10/2025 18:11, Brett Creeley wrote:
>> ionic_netdev_ops = {
>>          .ndo_get_vf_config      = ionic_get_vf_config,
>>          .ndo_set_vf_link_state  = ionic_set_vf_link_state,
>>          .ndo_get_vf_stats       = ionic_get_vf_stats,
>> +       .ndo_hwtstamp_get       = ionic_lif_hwstamp_get,
>> +       .ndo_hwtstamp_set       = ionic_lif_hwstamp_set,
> 
> Nit, but if you are changing this and you have to re-spin the series it 
> would align with the other ndo callbacks to rename these by removing the 
> "_lif_" portion of the name:
> 
>    ionic_hwstamp_get
>    ionic_hwstamp_set
> 
> Other than that LGTM.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>

Thanks Brett, I took your suggestion before sending out v2.


