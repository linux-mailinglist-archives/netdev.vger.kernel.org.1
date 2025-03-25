Return-Path: <netdev+bounces-177308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413EA6EDEB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6607A2A3F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D844254857;
	Tue, 25 Mar 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FM4547iW"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7F537E9
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899322; cv=none; b=n2v3ddeNufxLCBrZYNcpHpG/G6wxlNDhDBATn4Jbc24P/FJk85a38ytlDPp1HYyfoxZyUJBEZgceGhK1GGv9g4TvGa2D2VkUru0/DhEE/457vHTu2v+5JRPb7YnLpoBDQ9yAan8gO7888mNfY7ZuLmXmZo4u1wKD172Hmt9pMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899322; c=relaxed/simple;
	bh=oeejJ9QsMBajSRKn0+0g2cxUIth6DStbF7DSGbR5RY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hivkwu/QgfOlaAN3W1hqyE+mo+5cRq+xmHdaDvIDx/Yz527X+LRf3w02Oex3hg9fEeOB2SxygZs9YrmPKHpluRrhBrI3UlnEIGqwhBXH1ffC/RRtGbvWO/8k/gH+u974i5gSEEEaKpKjkbq54AFNkxj3SzEhmGNXCqA41nG1RXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FM4547iW; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742899317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV976PessGNrW4Do3I1JXJI6SL8uXNP/+1stgRQFulw=;
	b=FM4547iWYQjQlUKZlJ5/13iW63UbzSNd60H9ra8p3LsMjr/w2xXI0mL6bOcre4Mu/Ws0RA
	IIbhYqqp00c0iloAP8Y0I6B29l0vlgiXjuIaX3aaNZXAfwSoGIrrZHrYR8VBLrQw599kc1
	NqkA7pxosMFMo2nb/727lzgcTbxY+bU=
Date: Tue, 25 Mar 2025 10:41:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Kamil Zaripov <zaripov-kamil@avride.ai>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Linux Netdev List <netdev@vger.kernel.org>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com>
 <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
 <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/03/2025 10:13, Kamil Zaripov wrote:
> 
>> On 24 Mar 2025, at 17:04, Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
>>
>>> On Fri, 21 Mar, 2025, 11:03 pm Michael Chan, <michael.chan@broadcom.com> wrote:
>>>
>>>> On Fri, Mar 21, 2025 at 8:17 AM Kamil Zaripov <zaripov-kamil@avride.ai> wrote:
>>>>
>>>>> That depends. If it has only one underlying clock, but each PF has its
>>>>> own register space, it may functionally be independent clocks in
>>>>> practice. I don't know the bnxt_en driver or hardware well enough to
>>>>> know if that is the case.
>>>>
>>>>> If it really is one clock with one set of registers to control it, then
>>>>> it should only expose one PHC. This may be tricky depending on the
>>>>> driver design. (See ice as an example where we've had a lot of
>>>>> challenges in this space because of the multiple PFs)
>>>>
>>>> I can only guess, from looking at the __bnxt_hwrm_ptp_qcfg function,
>>>> that it depends on hardware and/or firmware (see
>>>> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broadcom/bnxt/bnxt.c#L9427-L9431).
>>>> I hope that broadcom folks can clarify this.
>>>>
>>>
>>> It is one physical PHC per chip.  Each function has access to the
>>> shared PHC.   It won't work properly when multiple functions try to
>>> adjust the PHC independently.  That's why we use the non-RTC mode when
>>> the PHC is shared in multi-function mode.  Pavan can add more details
>>> on this.
>> Yes, that's correct. It's one PHC shared across functions. The way we handle multiple
>> functions accessing the shared PHC is by firmware allowing only one function to adjust
>> the frequency. All the other functions' adjustments are ignored. ...
> 
> I guess I don’t understand how does it work. Am I right that if userspace program changes frequency of PHC devices 0,1,2,3 (one for each port present in NIC) driver will send PHC frequency change 4 times but firmware will drop 3 of these frequency change commands and will pick up only one? How can I understand which PHC will actually represent adjustable clock and which one is phony?

It can be any of PHC devices, mostly the first to try to adjust will be 
used.

> 
> Another thing that I cannot understand is so-called RTC and non-RTC mode. Is there any documentation that describes it? Or specific parts of the driver that change its behavior on for RTC and non-RTC mode?

Generally, non-RTC means free-running HW PHC clock with timecounter
adjustment on top of it. With RTC mode every adjfine() call tries to
adjust HW configuration to change the slope of PHC.

> 
>> … However, needless to say,
>> they all still receive the latest timestamps. As I recall, this event design was an earlier
>> version of our multi host support implementation where the rollover was being tracked in
>> the firmware.
> 
>  From which version the bnxt_en driver starts to track rollover on the driver side rather than firmware side?

It was done a couple of years ago, in 5.x era.

> 
>> The latest driver handles the rollover on its own and we don't need the firmware to tell us.
>> I checked with the firmware team and I gather that the version you are using is very old.
>> Firmware version 230.x onwards, you should not receive this event for rollovers.
>> Is it possible for you to update the firmware? Do you have access to a more recent (230+) firmware?
> 
> Yes, I can update firmware if you can tell where can I find the latest firmware and the update instructions?
> 

Broadcom's web site has pretty easy support portal with NIC firmware
publicly available. Current version is 232 and it has all the
improvements Pavan mentioned.


