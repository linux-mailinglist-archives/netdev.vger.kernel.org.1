Return-Path: <netdev+bounces-236431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C62C3C208
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC8A1892D2A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61882BCF5D;
	Thu,  6 Nov 2025 15:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4166224AF7;
	Thu,  6 Nov 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443714; cv=none; b=tUL+7dpsxtHb4KF61GBPhR1lTmKwNdxPvnelihJZUB5XZtaXlUvZOn6U5HSvJJ7RvXbZhGYxPMZscj9klsvr7HLjv4hj3ADTrXQtPXfvYUbm2/WsikPYP+bUVzi7zdd6QbviUK2Dik0vZk1KVp47IVt9Q+hHq8u1VwZlVetZeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443714; c=relaxed/simple;
	bh=UIJGSC6YNaxBD56Kik4Ckk90LPsOa5jzEU8QrfP1NZk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KnEJG/8CxPSFddrJrZTtfy+m+jW17L74LcY15MWP9Jo1NWbzPu+KrMO1AZKrbeiC+T2KHlKrgP2Zq/kGYwRkeKSsLgR4UaVCMYPxQE/Kyf52v4VxPu4BqOoCOmeP+p7/uT/Gz9EiDRzWlOOknHQqy0EAUSe5tKzsnQm8/wbnGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d2RHz6385zHnGcV;
	Thu,  6 Nov 2025 23:41:35 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C92D1402EE;
	Thu,  6 Nov 2025 23:41:43 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 18:41:42 +0300
Message-ID: <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
Date: Thu, 6 Nov 2025 18:41:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
 <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
 <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com>
Content-Language: en-US
In-Reply-To: <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 05.11.2025 19:58, Dmitry Skorodumov wrote:
> On 05.11.2025 19:29, Eric Dumazet wrote:
>> On Wed, Nov 5, 2025 at 8:15 AM Dmitry Skorodumov
>> <skorodumov.dmitry@huawei.com> wrote:
>>> If main port interface supports GSO, we need manually segment
>>> the skb before forwarding it to ipvlan interface.
>> Why ?

Hm, really, this patch is not needed at all. tap_handle_frame() already does everything needed. Looks like I had another trouble and this patch was an attempt to fix it.

>> Also I do not see any tests, for the whole series ?
> Ok, If modules like this have some kind of unit-tests, I should study it and provide it. I haven't seen this as a common practice for most of the modules here. So far all testing is made manually (likely this should be described anyway)

I see that currently there is no any tests for this ipvlan module (may be I missed something).. Do you have any ideas about tests? I'm a bit  confused at the moment: designing tests from scratch - this might be a bit tricky.

Or it is enough just describe test-cases I checked manually (in some of the patches of the series)?

Dmitry



