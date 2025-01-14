Return-Path: <netdev+bounces-158258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6FA113E2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C803A0F83
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB137213252;
	Tue, 14 Jan 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JlyNEdum"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85120CCD2;
	Tue, 14 Jan 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892649; cv=none; b=hLRscTxcXJABk++WH1DLTQM07/Ua63FkcrGpwa3vyNRF6gtZLHsgqp1Q9I6SqDGkfgF0qzzRdTLibEmW0osGlnBSWvHkDhP4sgIW3FHCTOATdkXLeHGu3whhVl3jsBTlunlR2jsGYVH2/RifGPGxUDq3faKHAaVYlbVA661Xe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892649; c=relaxed/simple;
	bh=wZ2aumVWad6ojJcN+pesJTiokTymrxWdiTwf7DBlvKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmPzjtUakTo3KXiLzD+sCRXYESPWrCWXFfGwKHYdvo3afHmNvLW5CUjSSjA8/KhW2I6Vy52NqgIo1SEvaEzD2zagnUl6sO6PF0TuF6VGE7qk6QxurRLWfZkdAGx5qiQJch3cJapiUPv8GOSQ/HUfQQ2hlYWf8juCkqeE4kktavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JlyNEdum; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFURub005899;
	Tue, 14 Jan 2025 22:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kpkg8Z
	RNaBCx0LdYq1kZUif9nqPGH11+aM8P8oFUIdg=; b=JlyNEdumOpmggrw97leKDB
	O8aD3t0oXfYBT3JjdZhzcCbjPJoQ+plOjW/OGBZmZnlKnvNIEw0gjGapr8gh/IhM
	ci/fqGGAgSGkAXMJo05HriUArsKMHv0w7rLNsd+ukmZqADGolfNivZPbcJvHkwAy
	DR5ZACXVMOPYpj7lwEsFCeeomEvs+zqUOpBXFEdfMrZajc9TzkgQyJA/o1hUsIT5
	B5o5EB3Mjr7+/zY80rEExurmz9l/RDVYhoT2YGMyBjQpdF6szegyX0HVF63/y8ji
	/oJ8pnBR3VmambmAo/Co/qvIflRzqWo6xNO9BCwSW2b3LP35yA2wNJoMwyB4w/EA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmghp5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:10:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EMA2Jh032360;
	Tue, 14 Jan 2025 22:10:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmghp5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:10:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EKYumK004526;
	Tue, 14 Jan 2025 22:10:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ysnhgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:10:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EMA0md54723054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 22:10:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F1958068;
	Tue, 14 Jan 2025 22:10:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB4058054;
	Tue, 14 Jan 2025 22:09:58 +0000 (GMT)
Received: from [9.61.120.113] (unknown [9.61.120.113])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 22:09:57 +0000 (GMT)
Message-ID: <c8fa4a3d-9cbc-49ce-9d76-85e57453fb04@linux.ibm.com>
Date: Tue, 14 Jan 2025 16:09:57 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC
To: Rob Herring <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com,
        andrew@codeconstruct.com.au, netdev@vger.kernel.org, kuba@kernel.org,
        joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        ratbert@faraday-tech.com, eajames@linux.ibm.com,
        devicetree@vger.kernel.org, andrew+netdev@lunn.ch, minyard@acm.org,
        krzk+dt@kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <173637565834.1164228.2385240280664730132.robh@kernel.org>
 <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>
 <20250114000727.GA3693942-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250114000727.GA3693942-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_6PYVa29mNhrKAYYwhcM5Xcjd6o3IGx
X-Proofpoint-ORIG-GUID: wZefgua35hP2KPe6COMauRr6HOrmFlvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=859 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166

Hello Rob,

On 1/13/25 18:07, Rob Herring wrote:
>>> My bot found new DTB warnings on the .dts files added or changed in this
>>> series.
>>>
>>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>>> are fixed by another series. Ultimately, it is up to the platform
>>> maintainer whether these warnings are acceptable or not. No need to reply
>>> unless the platform maintainer has comments.
>>>
>>> If you already ran DT checks and didn't see these error(s), then
>>> make sure dt-schema is up to date:
>>>
>>>     pip3 install dtschema --upgrade
>>>
>>>
>>> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:
>>>
>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
>>> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
>> This is a false positive. So ignoring it.
> No, it is not. You need to define hog nodes in aspeed,ast2400-gpio.yaml.
> See other GPIO controller bindings that do this.

ok, I fixed it. Thanks for the review.

Regards,

Ninad

>
> Rob

