Return-Path: <netdev+bounces-153328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA99F7AB9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AC1895651
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4152236F4;
	Thu, 19 Dec 2024 11:52:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3611FCFCB;
	Thu, 19 Dec 2024 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609166; cv=none; b=WdbBPTrJSp9eMcgBVjVH25r0zJKegSgWUiUwYxtfPETuTzrkva9dBSDvBNSahw26npxe5XRbKfIl3MYi8RW2A/3DLPGqOaLTlm9UH3DSdJMnSrYbEc6qo0YSYb2sK/YFyCwHRx6DxLxdiBaI1pGDWbGLp/9E5ZFD+tnAK7RRf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609166; c=relaxed/simple;
	bh=raguRzv/psMKMjxkwE0wtv/geBl15sNV8LnnXYQGi6c=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UtVagZd3/5HrLs7O3/ZIjDlvUAiQKPUYsnpTKCRYs43ScNb/e/ofrH3wQiY4QlhHdGi3emEy3uNtbXAmZbVSlVdoGp8Uaq/KSn66vird/nBjOwTwQfMLWEKQ3khzveNMDkA02t1hQMsGzOUjyOPRvB7/8e5X6F4mLWmoFUEEIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YDTQG3lQ2zRjR1;
	Thu, 19 Dec 2024 19:50:46 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 46E56180087;
	Thu, 19 Dec 2024 19:52:40 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 19:52:39 +0800
Message-ID: <074725d9-ae47-4e8e-860b-adc7b8025421@huawei.com>
Date: Thu, 19 Dec 2024 19:52:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V2 net 6/7] net: hns3: fixed hclge_fetch_pf_reg
 accesses bar space out of bounds issue
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-7-shaojijie@huawei.com>
 <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/18 17:29, Michal Swiatkowski wrote:
> On Tue, Dec 17, 2024 at 09:08:38AM +0800, Jijie Shao wrote:
>> From: Hao Lan <lanhao@huawei.com>
>>
>> The TQP BAR space is divided into two segments. TQPs 0-1023 and TQPs
>> 1024-1279 are in different BAR space addresses. However,
>> hclge_fetch_pf_reg does not distinguish the tqp space information when
>> reading the tqp space information. When the number of TQPs is greater
>> than 1024, access bar space overwriting occurs.
>> The problem of different segments has been considered during the
>> initialization of tqp.io_base. Therefore, tqp.io_base is directly used
>> when the queue is read in hclge_fetch_pf_reg.
>>
>> The error message:
>>
>> Unable to handle kernel paging request at virtual address ffff800037200000
>> pc : hclge_fetch_pf_reg+0x138/0x250 [hclge]
>> lr : hclge_get_regs+0x84/0x1d0 [hclge]
>> Call trace:
>>   hclge_fetch_pf_reg+0x138/0x250 [hclge]
>>   hclge_get_regs+0x84/0x1d0 [hclge]
>>   hns3_get_regs+0x2c/0x50 [hns3]
>>   ethtool_get_regs+0xf4/0x270
>>   dev_ethtool+0x674/0x8a0
>>   dev_ioctl+0x270/0x36c
>>   sock_do_ioctl+0x110/0x2a0
>>   sock_ioctl+0x2ac/0x530
>>   __arm64_sys_ioctl+0xa8/0x100
>>   invoke_syscall+0x4c/0x124
>>   el0_svc_common.constprop.0+0x140/0x15c
>>   do_el0_svc+0x30/0xd0
>>   el0_svc+0x1c/0x2c
>>   el0_sync_handler+0xb0/0xb4
>>   el0_sync+0x168/0x180
>>
>> Fixes: 939ccd107ffc ("net: hns3: move dump regs function to a separate file")
>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c  | 9 +++++----
>>   .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c    | 9 +++++----
>>   2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
>> index 43c1c18fa81f..8c057192aae6 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
>> @@ -510,9 +510,9 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
>>   static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
>>   			      struct hnae3_knic_private_info *kinfo)
>>   {
>> -#define HCLGE_RING_REG_OFFSET		0x200
>>   #define HCLGE_RING_INT_REG_OFFSET	0x4
>>   
>> +	struct hnae3_queue *tqp;
>>   	int i, j, reg_num;
>>   	int data_num_sum;
>>   	u32 *reg = data;
>> @@ -533,10 +533,11 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
>>   	reg_num = ARRAY_SIZE(ring_reg_addr_list);
>>   	for (j = 0; j < kinfo->num_tqps; j++) {
> You can define struct hnae3_queue *tqp here to limit the scope
> (same in VF case).

Hi:

To keep consistent with other code styles of the driver, this may not be changed.

Thank you.
Jijie Shao

>>   		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_RING, reg_num, reg);
>> +		tqp = kinfo->tqp[j];
>>   		for (i = 0; i < reg_num; i++)
>> -			*reg++ = hclge_read_dev(&hdev->hw,
>> -						ring_reg_addr_list[i] +
>> -						HCLGE_RING_REG_OFFSET * j);
>> +			*reg++ = readl_relaxed(tqp->io_base -
>> +					       HCLGE_TQP_REG_OFFSET +
>> +					       ring_reg_addr_list[i]);
>>   	}
>>   	data_num_sum += (reg_num + HCLGE_REG_TLV_SPACE) * kinfo->num_tqps;
>>   
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
>> index 6db415d8b917..7d9d9dbc7560 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
>> @@ -123,10 +123,10 @@ int hclgevf_get_regs_len(struct hnae3_handle *handle)
>>   void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>>   		      void *data)
>>   {
>> -#define HCLGEVF_RING_REG_OFFSET		0x200
>>   #define HCLGEVF_RING_INT_REG_OFFSET	0x4
>>   
>>   	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
>> +	struct hnae3_queue *tqp;
>>   	int i, j, reg_um;
>>   	u32 *reg = data;
>>   
>> @@ -147,10 +147,11 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>>   	reg_um = ARRAY_SIZE(ring_reg_addr_list);
>>   	for (j = 0; j < hdev->num_tqps; j++) {
>>   		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
>> +		tqp = &hdev->htqp[j].q;
>>   		for (i = 0; i < reg_um; i++)
>> -			*reg++ = hclgevf_read_dev(&hdev->hw,
>> -						  ring_reg_addr_list[i] +
>> -						  HCLGEVF_RING_REG_OFFSET * j);
>> +			*reg++ = readl_relaxed(tqp->io_base -
>> +					       HCLGEVF_TQP_REG_OFFSET +
>> +					       ring_reg_addr_list[i]);
>>   	}
>>   
>>   	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
>> -- 
>> 2.33.0

