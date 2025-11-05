Return-Path: <netdev+bounces-235908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A0C36F87
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B181A27B66
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2333B94B;
	Wed,  5 Nov 2025 16:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B3324B19;
	Wed,  5 Nov 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361907; cv=none; b=IVMWKZuAKpChghcAOvVGt0J2rNRjXKsrmwFsZ8bHxpNICT5o8nJKfrWte90FYEQ0knLf6RHXCYafakylca6QVcF3hAcqz8s3qQQnFOHgXNdZeVI0yE/wABdSiqehxv2Bunps1xaHmw1Jc/Pe3bSWEW4KQMu7hpYRIn1LCcWLQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361907; c=relaxed/simple;
	bh=9xrSG4KwzBel0h3uoDLn9/0RebfvkZQ771TsmVilbdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YeenuwE8gdFhECj8IrAna1S50ZFo1y0jPHadm8QrZPPjXe5Kg6VuovRQcDtt3npMlvFWV+6TzRdBs+tvqfNrSP0A5UVmibSdJu2adVH1RFgR3o3a4GbXl55MvwLrqS5DKKlc621EoiaM9eA3vwV6S3SDvobPl8yke+rk+2oAK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1s2c4zrkzJ46Dk;
	Thu,  6 Nov 2025 00:58:00 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D57A1400D9;
	Thu,  6 Nov 2025 00:58:22 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:58:21 +0300
Message-ID: <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com>
Date: Wed, 5 Nov 2025 19:58:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
 <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 05.11.2025 19:29, Eric Dumazet wrote:
> On Wed, Nov 5, 2025 at 8:15 AM Dmitry Skorodumov
> <skorodumov.dmitry@huawei.com> wrote:
>> If main port interface supports GSO, we need manually segment
>> the skb before forwarding it to ipvlan interface.
> Why ?
>
> I think you need to explain much more than a neutral sentence,

Ok, got it. Will resend the patch with more description: I expect there will be v4 anyway.

The reason is that this function is a protocol handler, installed on main port (with dev_add_pack()), so if main port supports GSO/checksum offload, OS will send us big/non-checksummed packets (tested with scp to IP of some child port). This packet is forwarded to child. I believe we may not expect child ipvlan-iface be prepared to RX big packet, without checksum. But I agree, that I should investigate behaviour in more details. May be I missed something and it is possible to force corresponding  TAP to somehow do this.

> Also I do not see any tests, for the whole series ?
Ok, If modules like this have some kind of unit-tests, I should study it and provide it. I haven't seen this as a common practice for most of the modules here. So far all testing is made manually (likely this should be described anyway)
>
> I have not seen the cover letter.
Cover letter was sent to netdev@vger.kernel.org. Wasn't sure that it is a good practice to add to CC every maintainer to each email of the series.
> Also you sent the series twice today :/

Well, I've sent just 000* by mistake. And immediately resent patches (as v3 in cover letter) after noticing this

Dmitry



