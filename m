Return-Path: <netdev+bounces-156501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B4A06A75
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 02:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A618879B0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8931A8BEC;
	Thu,  9 Jan 2025 01:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9082AF07
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736387697; cv=none; b=sEwHOPsjnLVY+WCKdgfePWqM6/YLBwrAOT9DFKVFsH/ptkwKB0vQtkkVf6aheJ/TKUhP+u55xmLLGtm3qMP+tqxh3h18TcXC5vVz0DW5JEP9emxyPev9jwvO+9X3f5mk82qMcIn2ZqwrOvLMxmG3F1NdYOIYajAYtbcgsNzjm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736387697; c=relaxed/simple;
	bh=KA1mFtWEyA/U+SHopxCzbEI8qUKDzP4QHsSxbSBJkLk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PKomagvJwAUzbtwuefEzb4doi14AqF0UiF4Pgu7jPax6rTFABh8IAW71FbrLSi2J8mMTkTo2aE6y6kUFUXYP5HsC/DO4Yq+eEAC877cbdWX+uG5vl1dmpA54ue1fksrCLw3mOyGFWNJDmvfop2HBXPDh5Qix2iY63hPqYVJtOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8AxPKxlLH9n61JgAA--.3642S3;
	Thu, 09 Jan 2025 09:54:45 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowMBx38dkLH9nkHkaAA--.44590S3;
	Thu, 09 Jan 2025 09:54:44 +0800 (CST)
Subject: Re: [PATCH net] ice: fix unaligned access in ice_create_lag_recipe
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Daniel Machon <daniel.machon@microchip.com>, intel-wired-lan@lists.osuosl.org
References: <20240131115823.541317-1-mschmidt@redhat.com>
 <e6f59bda-9de8-3d30-3f37-3ab1ec047715@loongson.cn>
 <54c34e2c-82f9-4513-8429-9ea19215551a@intel.com>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <f3f4f561-8402-d030-2ee9-38a80662168d@loongson.cn>
Date: Thu, 9 Jan 2025 09:54:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54c34e2c-82f9-4513-8429-9ea19215551a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx38dkLH9nkHkaAA--.44590S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQERB2d+-8QDJgAAsR
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyDGw4fZrW7ZFy3ZF4rXrc_yoW8ArWUpF
	1rtF4a9rs8tw18Ar4S934jgr4FkasrGasIy398tw15JF47Ar13Ar4xGa1UGFn5Xa1fuF4I
	kw4Sqr9xWayDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU

Hi Przemek,
On 2025/1/8 下午4:59, Przemek Kitszel wrote:
> On 1/8/25 04:09, Hongchen Zhang wrote:

>> Hi Michal,
>> On 2024/1/31 pm 7:58, Michal Schmidt wrote:
>>> new_rcp->recipe_bitmap was written to as if it were an aligned bitmap.
>>> It is an 8-byte array, but aligned only to 4.
>>> Use put_unaligned to set its value.
>>>
>>> Additionally, values in ice commands are typically in little-endian.
>>> I assume the recipe bitmap should be too, so use the *_le64 conversion.
>>> I don't have a big-endian system with ice to test this.
>>>
>>> I tested that the driver does not crash when probing on aarch64 anymore,
>>> which is good enough for me. I don't know if the LAG feature actually
>>> works.
>>>
>>> This is what the crash looked like without the fix:
> 
>>> [   17.599142] Call trace:
>>> [   17.599143]  ice_create_lag_recipe.constprop.0+0xbc/0x11c [ice]
>>> [   17.599172]  ice_init_lag+0xcc/0x22c [ice]
>>> [   17.599201]  ice_init_features+0x160/0x2b4 [ice]
>>> [   17.599230]  ice_probe+0x2d0/0x30c [ice]
>>> [   17.599258]  local_pci_probe+0x58/0xb0
>>> [   17.599262]  work_for_cpu_fn+0x20/0x30
> 
>> I encountered the same problem on a LoongArch LS3C6000 machine. Can 
>> this patch be merged now?
> 
> What kernel base do you use?, we have merged the Steven Patches long ago
My test is based on 6.6.61 which contains Steven's patch:
  8ec08ba97fab 2024-05-07  ice: Refactor FW data type and fix bitmap 
casting issue [Steven Zou]

It seems that Steven's patch can not solve the unaligned access problem 
caused by new_rcp->recipe_bitmap, So is Michal's patch (may need some 
change in ice_add_sw_recipe()) still needed?

-- 
Best Regards
Hongchen Zhang


