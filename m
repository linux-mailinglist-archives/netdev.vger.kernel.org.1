Return-Path: <netdev+bounces-206961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47244B04DF3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3384A7047
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A718DB02;
	Tue, 15 Jul 2025 02:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D65FEE6;
	Tue, 15 Jul 2025 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547551; cv=none; b=ZQKGFsJ25O1k8ZHchpW6QkaS4RVkuwSaO033fC1hWEoOM+0F90Q40ND68c655P2LqAnG9FYyrFLKyvxAE1ncE+Sr6sRK0hMmsUE4oF4ACf2G8zWk4iXyQvlmdVO5BETyCuqKlnoKCivkNhJQ9iEl9KlQcHMBzcsRuXD529eLNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547551; c=relaxed/simple;
	bh=IPujZZvDTGIIsO9vfeVs1pB9VAV5sn2BHH0EjtjZcqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOVC3SVO5Qh3eQtsoEYZZmTaBbd/RFi1b945bq13L6LdHmtac/CG12lEetda7+rg4DWSS8IAcayp8ftH9qbn9+Z0wFGvzBMOmh07+WmQ2rilZGbusRBfqQ6G0XQf4QSODVOtSDyndslLMze0j86c27Ikrk+/7fFzLPTTWfOzGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bh3VY3pJmz27hct;
	Tue, 15 Jul 2025 10:46:45 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C69101400CB;
	Tue, 15 Jul 2025 10:45:46 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 10:45:45 +0800
Message-ID: <df739d27-9b9a-492c-a573-abf7dd66d5b2@huawei.com>
Date: Tue, 15 Jul 2025 10:45:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: mcast: Simplify mld_clear_{report|query}()
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250714140127.3300393-1-yuehaibing@huawei.com>
 <20250714152701.GO721198@horms.kernel.org>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20250714152701.GO721198@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/14 23:27, Simon Horman wrote:
> On Mon, Jul 14, 2025 at 10:01:27PM +0800, Yue Haibing wrote:
>> Use __skb_queue_purge() instead of re-implementing it.
> 
> Hi,
> 
> I think some mention of the changed drop reason is
> warranted here.

Sure, thanks.
> 
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> ...

