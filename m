Return-Path: <netdev+bounces-184295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077BA945FB
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 01:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8566F174A69
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D71B87E8;
	Sat, 19 Apr 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+iAE/1/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9366C1CAA7D
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745104715; cv=none; b=ZpVSUKEz3nxxIe+I6hH845whwLSoZ9Wnq2wuplgP1k1r+DHVhESOZAbjNOridoAaNK6d0TH24MFLnBJ8qX1zVPpzNC05wDjkX1Xu46Jw/RwI0LmFN+bH+UzEI7kyQhw1zf03psZ+1Z1o+DCoQZGlzSLG8DiwGJnx8oaWPPf5MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745104715; c=relaxed/simple;
	bh=v441QENE3dm+uxHiDevuc/hDGN3UGYwAinCmO0+WXbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6zk16E/0ymJPTlisq8S/FpluTQYo4RsBV9wCZzanOoHSHcO6VIXeq9mfO1xgbxPs3Y5P1BojSCZB0yyTqEwq4BR9Y6EQlz0a8j5S8yt6hLes7nN0PEe1yh6FckW957Ozdag2I3uz6RZ5wlX7xuf1AHbUl60GDNlGyVvqgfGbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+iAE/1/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53JMtN5U012338
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 23:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vId/+tLWa/wbLus+uikHHP4vkWH9AXcXLbmMas9sRxQ=; b=l+iAE/1/ymei/2/3
	jqM7E+v9JmW/4w40e7AfIkjfWkyVWDtqXVnm8RG3yQj2VsoIV0L2u07c8l4jSX9Z
	/SpiiTXOUPl1xs6suDil40clCiP8LaRmeDSRvDoEqs57N5wxVZ/oVKyKn7XlJjiq
	tyXpvJo04qGVtaYXM2uhUnGsqiP0qXz1LiIZ+JyOSjunhlLbEkdEnIApIRaAXOpK
	e6zb5Qsw47PSxouFb6tIkf4vavNql0zbb6VAxmjCUVoEk/XlguKqHbjn5JvlejAs
	Dtr8Yo/Md5S2Ev7vBNUdAUUKfE+XTbTaJZ92zcnjki0xpt2RVD2MElb+c22gtg2Z
	fE9Fqw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46450p91rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 23:18:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso2047809b3a.3
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 16:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745104711; x=1745709511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vId/+tLWa/wbLus+uikHHP4vkWH9AXcXLbmMas9sRxQ=;
        b=KJfZeupeMeC6MQ5TjI6pzjduZfBTjiI4kQJuiwMI+3dlRrsKpbHqeT/Kpq/qoeR2wG
         D+4y3ECxnjzJ2BLzWw+hnTFnyrxSSa8X73wUj0Ht6UIgkdu9dlQOimU9uIplm5BljLsD
         6fkc8daAphEVxK6+ynBiSZrg/rXhFGgFnd2Rl/bboT5rz5zKR8WeYAGzjSPVRkPVfDVV
         um9YI7UcAtX0aTIQ1PwZ533zTsvMFBGy4gQ4Z4iidHZdrO+pf8/zTr5I+462doZ3M6kD
         Iw5G5wPT9sWeijvUbQ9QIPP2nPdAUPJzY04NYOxSK/LK4lq/dS3Kp2Fu/p+JnrqLWJNZ
         hKkg==
X-Forwarded-Encrypted: i=1; AJvYcCWlUvRO9MszRlPdCXwIUDdTdVfx1OdJhn1xRXfOWVvGIDz1mqMPuIXz/ruaMK3zFUyokb8RMwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgvmaulzh3W4CmDx+lsSJVpB2ZGgHNmgk3WHZlMneq6EQXX5L
	LYtsJT+wwubbnZgql4AzfwzDgb7Tk1gyxQ7ypGqtrc73IWPN3N/zx/86G8A9054zXsyeEG0l84U
	zYidw/TD80MbMpmyjuNPZXOXuZnynNmqN+JEKFhq1z+dAx4l8cHRFytY=
X-Gm-Gg: ASbGncuA5+7fxkTnNSVNPM4/OncW3RcuyobcK4IV53rdNnNspiajx9UUUnXdcjhZvKi
	NdxQepbwf3RY7klaCmzYlzMc5Tiu3BlNmNk2JE761Vn6O/JQ7EhubxS33G86ccZEEgw+a4aYlM+
	7d8srBNYVnF7X/C/Bzewj/G0wEJFm2f6kYveSVBA5iXzqwQzv87v56I+agRui+d49Z7ji3GbXF4
	wF+E8g88OKQyQrpdE6IW0GJ/F9DAb/sZHvSovL5Ie2HerZiIkDwk+ALGT8op9qHzzq+YKvnxDUT
	1IkIdT5/CPIOx6rUFAyvo0BaFEEEBiDCSmw8smpuZW0=
X-Received: by 2002:a05:6a20:9e48:b0:1f5:7007:9eb8 with SMTP id adf61e73a8af0-203cbc55934mr10054605637.16.1745104711107;
        Sat, 19 Apr 2025 16:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXu+UY5tISyRd0HanI7ugo7i3QTEPZ/7lNgMa/0Vxb8QHqeaW6HOFXcOtiJKZBlitFBeYLNQ==
X-Received: by 2002:a05:6a20:9e48:b0:1f5:7007:9eb8 with SMTP id adf61e73a8af0-203cbc55934mr10054585637.16.1745104710688;
        Sat, 19 Apr 2025 16:18:30 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.228.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db157be12sm3295244a12.64.2025.04.19.16.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 16:18:30 -0700 (PDT)
Message-ID: <817cf0ff-5ecd-f6b1-d9b9-cf6b2473ed23@oss.qualcomm.com>
Date: Sun, 20 Apr 2025 04:48:24 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
 <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
 <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
 <9e9854d5-1722-40f2-b343-97cf9b23a977@gmail.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <9e9854d5-1722-40f2-b343-97cf9b23a977@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68042f48 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=M6NtEvFuFW5htA+UmNA0rQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=vUNyb6OlYlovoomfCmQA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 5_oV6U0GuIQ6A2xfe9fFnb2fP0j9XdIg
X-Proofpoint-ORIG-GUID: 5_oV6U0GuIQ6A2xfe9fFnb2fP0j9XdIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_09,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxlogscore=707 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190195


On 4/19/2025 3:48 PM, Heiner Kallweit wrote:
> On 18.04.2025 23:52, Heiner Kallweit wrote:
>> On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
>>> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
>>>> Hello Krishna Chaitanya,
>>>>
>>>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
>>>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
>>>>>>
>>>>>> So perhaps we should hold off with this patch.
>>>>>>
>>>>> I disagree on this, it might be causing issue with net driver, but we
>>>>> might face some other issues as explained above if we don't call
>>>>> pci_stop_root_bus().
>>>>
>>>> When I wrote hold off with this patch, I meant the patch in $subject,
>>>> not your patch.
>>>>
>>>>
>>>> When it comes to your patch, I think that the commit log needs to explain
>>>> why it is so special.
>>>>
>>>> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
>>>> in the .remove() callback, not in the .shutdown() callback.
>>>>
>>>
>>> And this driver is special because, it has no 'remove()' callback as it
>>> implements an irqchip controller. So we have to shutdown the devices cleanly in
>>> the 'shutdown' callback.
>>>
>> Doing proper cleanup in a first place is responsibility of the respective bus
>> devices (in their shutdown() callback).
>>
>> Calling pci_stop_root_bus() in the pci controllers shutdown() causes the bus
>> devices to be removed, hence their remove() is called. Typically devices
>> don't expect that remove() is called after shutdown(). This may cause issues
>> if e.g. shutdown() sets a device to D3cold. remove() won't expect that device
>> is inaccessible.
>>
Lets say controller driver in the shut down callback keeps PCIe device
state in D3cold without removing PCIe devices. Then the PCIe client
drivers which are not registered with the shutdown callback assumes PCIe
link is still accessible and initiates some transfers or there may be
on ongoing transfers also which can result in some system errors like
soc error etc which can hang the device.

The patch which I submitted in the qcom pcie controller, removes the
PCIe devices first before turning off the PCIe link. All this
info needs to be in the commit text, I will update it in the next
version.
>> Another issue is with devices being wake-up sources. If wake-up is enabled,
>> then devices configure the wake-up in their shutdown() callback. Calling
>> remove() afterwards may reverse parts of the wake-up configuration.
>> And I'd expect that most wakeup-capable device disable wakeup in the
>> remove() callback. So there's a good chance that the proposed change breaks
>> wake-up.
>>
After shutdown, the system will restart right why we need to enable 
wakeup in shutdown as after restart it will be like fresh boot to system
Correct me if I was wrong here.

I want to understand, why shutdown of the PCIe endpoint drivers in this
case rtl18169 shutdown will be called before PCIe controller shutdown,
AFAIK, the shutdown execution order will be same as probe order.

The problem PCI patch is trying to do is, not every PCIe drivers are
registering with shutdown callback, in that case if PCIe controller
driver if it cleans up its resources in shutdown and the PCIe drivers
which don't have the shutdown callback doesn't know that link was
down and can continue data transfers which will cause system errors like
noc error.

- Krishna Chaitanya.
>> There maybe other side effects I'm not aware of.
>>
>> IMO a controller drivers shutdown() shall focus on cleanup up its own resources.
>
>>> Also do note that the driver core will not call the 'remove()' callback unless
>>> the driver as a module is unloaded during poweroff/reboot scenarios. So the
>>> controller drivers need to properly power down the devices in their 'shutdown()'
>>> callback IMO.
>>>
>>>> Doing things differently from all other PCIe controller drivers is usually
>>>> a red flag.
>>>>
>>>
>>> Yes, even if it is the right thing to do ;) But I agree that the commit message
>>> needs some improvement.
>>>
>>> - Mani
>>>
>>
> +Bjorn, as this is primarily a PCI topic
> 

