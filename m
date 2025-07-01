Return-Path: <netdev+bounces-202753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65207AEED65
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687B47AB2D0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EC1F2BBB;
	Tue,  1 Jul 2025 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IuQ5vBiJ"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037001F239B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751345826; cv=none; b=B+0HkNZh9IohVot3n7gHmA9BDyy6B+ZUB1tb/qvEdNm8dfAF4GqyJpirJh8QOVCwltj8kDfQvODsbtx+6XFYHbROA3yuToCDayJAHkj9vU2Isf3xOmgchCMO5U69YDNM5WxGpItoLUvB5frewpE05oiGEix7YM+E/cfMjVDSzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751345826; c=relaxed/simple;
	bh=sIalOvU0IZjWGEvFmMEZXjZhgYNrj4Lp8vde0AUoUJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kZNwuPwFY0HSldOR9c4VKk+0zlWzT/DmLGoipHKoWIE+wSrGvjnMBvZGaNg8RElm3l8pIzvgAOQrrDbxu8Pu2+FfWkW5vfCb1G4YDKqmrfXmOeTzk0MRtCSgB5imJH5P/rxxrbYCR1MqpJd8r4H2bsceCOf1jh7DTj50cymy02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IuQ5vBiJ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5614upI03525618;
	Mon, 30 Jun 2025 23:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751345811;
	bh=SwIs49mn0joPRRpBmEaKnHCDKZw87rwwcjS2b6w3Oww=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IuQ5vBiJZB+0DD3cc/PkxPANhsnvq7KgVXgG9Xw/1g5JmvpThBD7rnGYDoPZsg1OD
	 6mgE3TMyfEe9Wp9LLTzLFeWljdAwKGtmxhgPDgKQEAnXCiBkHU7vzXNl+HFr+lXUo0
	 Lav3uYC67phh8LSsz98ANs2/OSKtiHXUVLWehUOQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5614upOv2231536
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 30 Jun 2025 23:56:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 30
 Jun 2025 23:56:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 30 Jun 2025 23:56:50 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5614umTB653906;
	Mon, 30 Jun 2025 23:56:49 -0500
Message-ID: <b202725b-49a7-4d61-a61a-13e4529dd6a1@ti.com>
Date: Tue, 1 Jul 2025 10:26:48 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next v2] pretty: Add support for TI K3 CPSW
 registers and ALE table dump
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <mkubecek@suse.cz>, <danishanwar@ti.com>, <netdev@vger.kernel.org>
References: <20250619171920.826125-1-c-vankar@ti.com>
 <182fd7c0-52ad-4ff6-b08d-43480ee660f7@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <182fd7c0-52ad-4ff6-b08d-43480ee660f7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Michal, Can we please merge this series since there are no further
comments.

Regards,
Chintan.

On 25/06/25 15:21, Siddharth Vadapalli wrote:
> On Thu, Jun 19, 2025 at 10:49:20PM +0530, Chintan Vankar wrote:
>> Add support to dump CPSW registers and ALE table for the CPSW instances on
>> K3 SoCs that are configured using the am65-cpsw-nuss.c device-driver in
>> Linux.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> 
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Regards,
> Siddharth.

