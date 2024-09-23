Return-Path: <netdev+bounces-129303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2097EC67
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BCEB21758
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CE197A9B;
	Mon, 23 Sep 2024 13:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9538394
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098686; cv=none; b=UVPis/ycD8EV2lZaM176uM27HobEhp3XCJUiPx8WqbJB/np3wZnZ2FI/2Gv4TFXWBpNTSlSsX4dL63BIUT9xQgj8pcUrh/1Zp4uf38CQb/WtXtihtU6Q0KXSUmgRiVaYKtaBhWKAFT1FaKAfcNLn/4PqZ4rJKJLhI45hb41qufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098686; c=relaxed/simple;
	bh=2+x7zIEudbHVhbheuIQ3ifMbGrLxB2lrB2iq2GDipcs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nRmRLdNUlmZgyxHexiyFU3rPKceIu6ibJU/i6BoAkWhzMp8s7UADHa/yRlnVd0eV1524c7DqVOpJyVkSbMjrLUuD/QBqQssj+tV1r68HKuQix8oJit8C/N01fJita0D5jS5fwisdZtd0kJyuPmNP1ApY737zjhNLxIx7BWnSqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XC3w71fkPz1ym9N;
	Mon, 23 Sep 2024 21:37:59 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id F23771A0188;
	Mon, 23 Sep 2024 21:37:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 21:37:57 +0800
Message-ID: <fb813399-b1a5-489f-9801-f9f468e2beb0@huawei.com>
Date: Mon, 23 Sep 2024 21:37:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>, =?UTF-8?B?6ZmI5pmf56W6?=
	<harry-chen@outlook.com>, =?UTF-8?B?5byg5a6H57+U?= <zz593141477@gmail.com>,
	=?UTF-8?B?6ZmI5ZiJ5p2w?= <jiegec@qq.com>, Mirror Admin Tuna
	<mirroradmin@tuna.tsinghua.edu.cn>, Salil Mehta <salil.mehta@huawei.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>
Subject: Re: [BUG Report] hns3: tx_timeout on high memory pressure
To: Miao Wang <shankerwangmiao@gmail.com>
References: <4068C110-62E5-4EAA-937C-D298805C56AE@gmail.com>
 <56bbcfbd-149f-4f78-ae73-3bba3bbdd146@huawei.com>
 <F90EE18D-1B5D-4FB2-ADEB-EF02A2922B7F@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <F90EE18D-1B5D-4FB2-ADEB-EF02A2922B7F@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/23 21:11, Miao Wang wrote:
>
>> 2024年9月23日 20:58，Jijie Shao <shaojijie@huawei.com> 写道：
>>
>>     
>> Hi:
>>
>> in dmesg, we can see:
>> tx_timeout count: 35, queue id: 1, SW_NTU: 0x346, SW_NTC: 0x334, napi state: 17
>> BD_NUM: 0x7f HW_HEAD: 0x346, HW_TAIL: 0x346, BD_ERR: 0x0, INT: 0x0
>>
>> Because HW_HEAD==HW_TAIL, the hardware has sent all the packets.
>> napi state: 17, Therefore, the TX interrupt is received and npai scheduling is triggered.
>> However, napi scheduling is not complete, Maybe napi.poll() is not executed.
>> Is npai not scheduled in time due to high CPU load in the environment?
> Thanks for your analysis. I wonder how can I verify the scheduling of NAPI.

You can use napi trace to verify it:
echo 1 > /sys/kernel/debug/tracing/events/napi/napi_poll/enable
cat /sys/kernel/debug/tracing/trace

>
>> To solve the memory allocating failure problem,
>> you can use kvcalloc to prevent continuous page memory allocating and
>> reduce the probability of failure in OOM.
> I'm not so familiar with the hns3 driver. I can see several places of memory
> allocations and I have no idea which can be replaced and which is required to
> be continuous physically. I'll be very happy to test if you can propose a patch.

All right, when the patch is proposed, Please help to test it

Thanks，
Jijie Shao


