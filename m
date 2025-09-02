Return-Path: <netdev+bounces-219334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D296B41044
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FB116364F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14B3277814;
	Tue,  2 Sep 2025 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="6I67C4d6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEA26A0AD;
	Tue,  2 Sep 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853121; cv=fail; b=SlOHkgztoRn+NObnD/5HjUL2/MSI7q4BbFYrs9WY5KGTuogRrdEbJsxd1OdXiJQAqtFhLgKQU8fPHLMAIeO2mV2vST8JMsDTViUE/9K8AFU49o+rIjHs5srPJA3gmvaG/ugqa5F96JdDrwx6/FRgJT0hyEWbGtCFwnlll1A+dJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853121; c=relaxed/simple;
	bh=FCoKKQhA0S2wEtslpFVgbDJAsall0vBMauxRX731QDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHsEoa16hOec8BpE6LkG908H/B8hZjgeOzHqbJfibvWoDmLbaf/GoA8VzHIDl9ykQfDpgjRRN/EznrYqzMoInep3XD4Pf37RxMUkBLbsm/NYI7/4tJn/rqwbBm4o3F9pHSpV8qWh7dV8LbiB08TT8jvhioTzhP7Zqo3aOYwC+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=6I67C4d6 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIEdJurUucfEIoE9WiZSnuwTFQbwmNMXAfEdBPwRsF2QP+bAYgoVk0mD9xdFzimh8IHnfHluHXDnOotFN5gGiZQX3uVhDtE9Rm5i+Qc8jUXxEnHN3RjR3QxQ1kngYGLuk4o+XOwqyHFZvry1AvDZ5hT1uRIsVa0ge2LkrdXtRrgv+xWBR3f2+EaFgLZ1H0fK3FVL5+b/AyqlslmNvxH3sN3ZHcNrJ/nIP+Go/sJV/fjAPVcFvMraWCccGyXBPtzyFKBQ+G3C2Q1EWZlAijDzQX2OLJxy/JzhNzw20qq+br4mhgmikYmsFagNEFz0nPwihtuP9mh5xCZR4OJCFI1mAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF00xBp4aJFyg5Q/hIkZd/C5g7lSwN307a3HmCEVayU=;
 b=J1ZwuomDs5abyv6LF05ul1SqO78OL/L7p5sZmbkIjSMfB4dv+OBUiM9W8iHqReGYbcALVmst4wTOCI11DXKI+C7gJjEvnH89z+5Sr+6bWR9v4tglwNeZrVyFbNFS47OnBCnhwWWzL0kEYwiMV9vCysZcvvLnJ90Cfmw3/JgwHpunHhFhXQ7vn0AMd7+aMJx3x71BnZPqhoDh53BmhSdaSs+Iy+XW9CuKpCmDsBfHRVayxbeOe6CaUXS550Ghjir4nhRifh0x3zclACGsOnsALYyVGJrpw1/xiesruOgmxgWmSAagB2BPqigFZcpaz3E7WWskpozAnOcscB4T1Pn/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF00xBp4aJFyg5Q/hIkZd/C5g7lSwN307a3HmCEVayU=;
 b=6I67C4d6aPI2Z34bd9M0/dU85N2MO/ldmzfPptYz0Fx7BnYnA9chIPs2bb5uIy6MomVEW/+/24VfP6L4/kbFoVY7PWmV4Nx251c9YMlqxlc9w4CBf3RThBaMJFXoIGmq12910lDuNgc1hnqsDdNZBjd5cGBCarvdpmiSR4ujLJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8291.prod.exchangelabs.com (2603:10b6:930:c4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 22:45:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 22:45:16 +0000
Message-ID: <3d30c216-e49e-4d85-8f1b-581306033909@amperemail.onmicrosoft.com>
Date: Tue, 2 Sep 2025 18:45:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
 <20250828043331.247636-2-admiyo@os.amperecomputing.com>
 <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
 <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
 <c22e5f4dc6d496cec2c5645eac5f43aa448d0c48.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <c22e5f4dc6d496cec2c5645eac5f43aa448d0c48.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: dd503d97-bc2e-43e0-3324-08ddea7262dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YldkdEgrRlNCNWhYRVJhbFRGSkpMWWtGNXhLYTU4aU5YdmhrVXljZnJnVVJz?=
 =?utf-8?B?azVjTWs3am5VYXBEeE16TStGN0tZb3ZvR2RqTUFpTll4WjFVUEQxKzY0Z2x4?=
 =?utf-8?B?d0swVHduKzFKMytYWGY1MGN4dTA2a2VEM2NwMTg2cTRURklma3JIKzA0QTBJ?=
 =?utf-8?B?T1BrT1JBT3lUdklyeEp6YVU3WitpQ2VHVTBPZWthQlFSenNhcTE3eEhlanZ1?=
 =?utf-8?B?TXBqRlBMWjlscEwrdkQxNFNBQWl1dWFvcDJJU3JBUE5LMWlBOFlRWk9tckpP?=
 =?utf-8?B?RkVSWWViSVFreElLNjB0a2N2WnNOOGNmTVlwNjRjUW1aS1NFejBjWkZOcm5N?=
 =?utf-8?B?SG1Cb2lxV1A2Z3pzaTVvSFZ6K1NCM0xTNG5xSUdIR0dVMlZ4V1BYeDhvSE9r?=
 =?utf-8?B?YjhiZDVDcGx1VG1Ka2NqaE9VU2M5eWpQekV2bjlPOGorL1RxUWhyeDJaSXNl?=
 =?utf-8?B?STl6SzhUZUxVTHFHL1hDMlhVMU9YdHRqV285Q2FKekZKQWlMaTg1Y3c1cHVk?=
 =?utf-8?B?RnpvL1Z6MzZzZjZXZnNIZUNzMkNjdUN3OXZEQzkrZ3ZFVEZRSjBma0QvdmRG?=
 =?utf-8?B?T29VNzJuM3F4MjY5RTd1dENvRlRoUE1WOFBzd1htSkZpbXlmcnN1bTVlamZP?=
 =?utf-8?B?TGNGVjgyK00wMGJ6Qnp1aVViVWtieWg2WTBqVFVWUG5BOWFBRVVvd0wzKzJm?=
 =?utf-8?B?ZGtON25MS3JPZE5TR0NoK1YvaGhjelYwK0l5a3JvS05OL1dpaHV5ZVhxcXVP?=
 =?utf-8?B?eWQ5emY3UVpyaFVBeS9QakFkU1paaVZxNXZkRC9CdjdXUnpBVUNNUlA2RkR0?=
 =?utf-8?B?VjMxSkV1M1d1U1NsbEM0ZENVNituZG90UEpQdkMzK3h3anhXT2luenhTZHY2?=
 =?utf-8?B?SVhnbzZ6WjN0TzRjOUN5WUU3WmltSFVpVGdZMUM1UlBFU2F1dkY1VUl1UnJK?=
 =?utf-8?B?UUxnRlBpaDRaVjF1UUJaV2g5SWdKQ2QzbUhtRzczZGxVSld5cTFXcnFlN052?=
 =?utf-8?B?d0JLVXlWSk5oWDFBMERrRmc3MFFBZXAvazJVcDNEOTgveS91RmIwMVZVRnlZ?=
 =?utf-8?B?R1lLTXJUS3h6MGFQMGhlZGVBb2tNdHRpOUlBK2N2c2tSNUErNzM0eTE4bTM4?=
 =?utf-8?B?elRMc0MxOXp5Y09iTExkM2l2dkQvd0FDbDJmcVJOK0ZjNlY3Q0FVcVg4U3B6?=
 =?utf-8?B?eE1qc0ZnQ2hsUC83MWxsWWF3RnVBWWlIeGdGNW9xaGxQeHlvQk5FazVMKzJV?=
 =?utf-8?B?eVRzSUJFdExhQXZIVzduTEhadVhkWHJTL2tGVm9EdmxnWUc1ekE5WS96QWZm?=
 =?utf-8?B?UnBvWmduVmlYUm9La3YvVVVHYU9NS2VwaVNZZTR0TEdIN0JUMHBUT2gvWkxE?=
 =?utf-8?B?bWg0cng2cXB6OGIwclhaVVh6NWx0d2xzUm1idlZnYmJpNG5PZ2J5K2hkZGh2?=
 =?utf-8?B?d0srNkJlWVl1WDU3TDYzOXJIQU5qdm0rMnE1b0Nza1pSNGpPLzNPY1ZuYVF6?=
 =?utf-8?B?WUgwcHp1OGd4eTY0VDFWSEpCS0pGWld1NXZocjhFa3ArMVdkdFYyalJyVURs?=
 =?utf-8?B?dWJLcmNwVEVYckNuVGJNTGtBcC84NkUwMGtHSVhQbERCU00zWmpYVWxjQlZm?=
 =?utf-8?B?SlJNNzYwK2duaUY5TXlCYmJrUFY1bGF5VllPNXhkNmZrbklwTEhhWkErSFAw?=
 =?utf-8?B?L2IvMU4zWlVMSURuOW90bnpBRDhEQjdBNkNwMVNWSmc1bXNuWmt5U01TZ0hw?=
 =?utf-8?B?c05mKzNGNXFSekZGY3BLekJybjlYMmJnMlJOWlhXWXFmamtYR1lIcFNuUlZL?=
 =?utf-8?B?dkk3SGx1bzA2d0IwQnFEN1o4RUVQRlp0TGZpUU9CaDY3SzlITExyNThNY3Bk?=
 =?utf-8?B?aEQ0cWtOTWJMVklWNE9GVUljS29NdUUxTEFrNFFzSThYSmtIVm5Bcy9jZmJj?=
 =?utf-8?Q?ajCJeEjSzPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTFuSWptSWFkMUtNQkNwSjdJZGR3Wm1CVm5PVjlGeVhMNExqSXhWb3hhejNr?=
 =?utf-8?B?SFErSkpObVFPQmpYVWYrYkJUdWEzOVBDUUZlaWtSMjIvZWZib2V6ejBCSHJz?=
 =?utf-8?B?T2FtMWNsYXFPMUFBSkZ0ZVB1bnZsUnN5LzVRZC9ZdDFyUDdIWFNIUllVMGdy?=
 =?utf-8?B?SGQwVlo2a1J6K2xYSnFhV2NGTFlaQjlEWk8xUnVoZkhvM1REMHBLeUFRaHRs?=
 =?utf-8?B?WUdqdEV4Mkp3Sk4xKzFnWDJhMVdHbE1BS01DZFZWYXdXL3ZYa2hXak5TdzR6?=
 =?utf-8?B?aWdXT2lZOVhkZGZCVlBSMy9RYXhUdDJ1a0FlTEtVdUFUVjhjNm5jVmpWT3Vz?=
 =?utf-8?B?emR1QU9XNTl0ZHJNb0J5S2E5eWFTaStpcXd3SzVCTzRFc2xZVXRGVXFTdHNX?=
 =?utf-8?B?ZHR6ckNISjNXazkydDV5Ri9tTXFkcUZ1QXFVZlYyUGRrZVNKSk4wTlJFSWMz?=
 =?utf-8?B?UGtSend6RENVQkVmb0Fzd2ZpRFJIaElTV3VQSk1SYnBCdkg3MXp1U3E0RldD?=
 =?utf-8?B?VXFIVERPS3h3VjBLb2F2eVVKbTF0RmFXZnUrYkhENU8vTG4zbldrSWp6STJo?=
 =?utf-8?B?eUR3SkhIL3pXUi9sM3VYZmhnWnJpOEJBZDRRMThxOTc4N1NTTDBqamY3U003?=
 =?utf-8?B?MVlvd1RROERYZkdlNFRyKzNJZWcwLzRYWXhnUHJsMFQ1OGJKb2laek9EMDZp?=
 =?utf-8?B?cjdpMi8zNThiQnpxdWRKaWQxdGtwVWZsMTRiSml2eUlVY3kvdlA3OVl0WUN0?=
 =?utf-8?B?dGpaUCt6K0JSckxrb1Y3aUV0TmZCMDA3R0V5M2pIalpnTTBYMlpmRjJaL1Fw?=
 =?utf-8?B?WU9udVpobzc3Y0pTSzkrRENjOEF0NWhYRUNsQ2h5bXRiYUdlRy9BOUdZMDVi?=
 =?utf-8?B?a2YwUzVpWndEaUhQT1BUcWJEWjVlQUtNVHM5Q1ZJODFES2p1ZVcyQThMMlFD?=
 =?utf-8?B?dS8wUDZCU0x6djJiNjFQUTdwMVdKaDdEVmovd3RJSVFva3U2Y1N1T3VuMVJt?=
 =?utf-8?B?ZWxjNlJueE9QeHhwWkZGMTVPbW4wTGtYRmx3ays1SEFxUDJsSHZVTW9nVVl5?=
 =?utf-8?B?RTVvMmh6REs1N1cvVFhId0FjWW1mTkR5dDV3bjdxOS9YL2xtYmhUVXNUK21G?=
 =?utf-8?B?MmQ3dHN6T3h3QkkxcnUrT0ZLd2lIcWhYWUhzY1k0ek0wbC9Kc25IamtSaWVJ?=
 =?utf-8?B?TzJhRElIVlFhUmhzNEpsUURXa0pkUHNYcDNKU0JRY2VIM1F0a09EZEpZWHhu?=
 =?utf-8?B?Wjd6cGhUVythUk5NcUkzV1BzM0t2dHBmdnZPeTVEOEwrZWU2aWp6TmpwdmFL?=
 =?utf-8?B?bFZlZkVhTkRud3JwVjdwV0RuVFQvRmlWR1FodmZnbGtkVUdEbHVZL0E1K1Zl?=
 =?utf-8?B?S2hKcDR0dTNzWVd5blcxMGlTUG5CSzJlaUN4VHJnL2tuUHlRamJLdVZGSzRw?=
 =?utf-8?B?b05kbDM2TlF2WWVEK1BBZGQ4SU9mN3FrY3MzaFFJaWdZS3lmTDhCbkVrc1VU?=
 =?utf-8?B?K2NKRFc1Nm9ZL0g4TVY1eVkzMFI2dk8wSURLeGRYSi8yT0xBazNFcERnZXh1?=
 =?utf-8?B?d0ZpdzJ1UlpnaG5xWlNWUjhnRmJjbXR0R0lQNzRpUmozTytYNjhPYWE3dVlG?=
 =?utf-8?B?ZjVGdXpsNlk0bSszWTRhYnRzdVREamthOGxUaFN0eHFCNGtIeURDclhpS0Ez?=
 =?utf-8?B?SGRWRC9xTWQrSVFLZkhIdGM3UWk1WHVVcjdpc3RuMGpNTzNSS0IzK2RRVUQv?=
 =?utf-8?B?eGlDVTV4b1ZlSlpmWktzaG0zajh3cDJXYkM4aUlJVEU2aW84RlRQc003bzdL?=
 =?utf-8?B?VlhXckNPUmhqRXNNN3JtcTNLbExidTRpbG5IbHN2YUpRTzlSZzM4QzRzcDYw?=
 =?utf-8?B?Z1JTMHlUSUtkYUlFMFdlUHJseXBWbnBhbmF5bXJ1ZzM3c3dHWDRRK1crZUlQ?=
 =?utf-8?B?dC9hUUdMS0pGM2hSeTd1MHBhc2ZxQnVsOGpGeVUrSjVWMVAvRUkxbng1dysv?=
 =?utf-8?B?QWFDbGxsMmhHWEdMZ2lkTEkzSEVSb1k4SVpWNHVSbWtPS3dLY2N4amlNYTZ0?=
 =?utf-8?B?ZTllRXl3NlVXUUlacmpuY0xzQ2IxWTNqVTVIRG85bStWRW4xT0hnWHVvSDhU?=
 =?utf-8?B?V3NqN3l0WmNoZkRPUko0K1ZyM054OTJxWTJUTG1nMnZsUFFNOU5uUWxxSGtR?=
 =?utf-8?B?NXZVdTBnTCt1MHo2ejBtWkdTYUllQndvOEhtSmU1SVIvTko2cDJwTFMzM3F6?=
 =?utf-8?Q?E4/vTubLe1bSJJDybX7ZYpw+rRNGaxpUYykwQRvFwI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd503d97-bc2e-43e0-3324-08ddea7262dc
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 22:45:16.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNQ3P1hq91Ds298LSg3aDUTQH11OADHjdTP8EP9rKf7LH+W82FnuGkhbejYd2tkYE+K+cM+EMu+bEMCEkNFhFRyyDBlhJwnz2+UF1LWYfdrP/pFxqFPNdxLL8K3i4Bly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8291


On 8/31/25 22:31, Jeremy Kerr wrote:
> Hi Adam,
>
>>> Nice!
>> Yeah.  Had a bit of an internal discussion about this one. Ideally, we
>> would stop the queue one packet earlier, and not drop anything.  The
>> mbox_send_message only returns the index of the next slot in the ring
>> buffer and since it is circular, that does not give us a sense  of the
>> space left.
> I think that's okay as-is. If you have access to the tail pointer of the
> ring buffer too, you may be able to calculate space, but that's
> 1) optional, and 2) best left to a later change.
>
>>>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>>>> +{
>>>> +       struct mctp_pcc_ndev *mctp_pcc_ndev =
>>>> +           netdev_priv(ndev);
>>> Minor: Unneeded wrapping here, and it seems to be suppressing the
>>> warning about a blank line after declarations.
>> The Reverse XMasstree format checker I am using seems overly strict.  I
>> will try to unwrap all of these.  Is it better to do a separate variable
>> initialization?  Seems a bad coding practice for just a format decision
>> that is purely aesthetic. But this one is simple to fix.
> That shouldn't be tripping any RCT checks here, as it's just one
> variable init?
>
> 	mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>
> Keep it in one if possible (as you have done).
>
>>>> +       drain_packets(&mctp_pcc_ndev->outbox.packets);
>>>> +       drain_packets(&mctp_pcc_ndev->inbox.packets);
>>> Now that you're no longer doing the pcc_mbox_free_channel() in ndo_stop,
>>> nothing has quiesced the pcc channels at this point, right? In which
>>> case you now have a race between the channels' accesses to skb->data and
>>> freeing the skbs here.
>> (I have written and rewritten this section multiple times, so apoliges
>> if soemthing is unclear or awkward...it might reflect and earlier
>> thought...)
>>
>> OK, I think I do need to call pcc_mbox_free_channel here,
> You should ensure that the packet processing has stopped on
> ndo_stop (and has not started before ndo_open). Without doing that, you
> have two issues:
>
>   - the RX packets will continue while the interface is down; and
>   - you cannot free the lists
>
> If there's a way to keep the channel allocated, but suspend the
> processing of messages, that would seem like a good option (and sounds
> like it would solve the MTU complexity).
>
> However, on a cursory look through the pcc/mailbox infrastructure, it
> seems like the pcc_mbox_request_channel starts processing immediately -
> so it looks like you can not have the channel in an allocated-but-idle
> state, since the request_channel does the bind_client, which does a
> pcc_startup.
>
> So, I figure you have two options:
>
>   - only request the channel until the interface is up; or
>
>   - implement your own quiescing in the callbacks - keeping the channels
>     allocated, but check if the netdev is operational (ie, ndo_open has
>     been called) before processing an RX message

This is how I went:  during Add, I quickly request the outbound channel, 
get the MTU, and free it.  There should be no reason to get any messages 
during this window.  If we do, it is spurious an likely a Firmware error.

The channels are requested  during ndo_open and freed during ndo_stop.  
After the free, the packets get drained.  A restart of the device drops 
all messages in the ring buffer.


>
>> which means I need to allocate them in the pairing function. The ring
>> buffer will still have pointers to the sk_buffs, but they will never
>> be looked at again: the ring buffer will ger reinitialized if another
>> client binds to it.
> OK, but the skbs will remain allocated between those operations, which
> has other side-effects (eg, socket mem accounting). You'll want to drain
> the queue (as you are doing) if the queue is no longer making progress.
I think this approach will minimize the lifespan of the sk_buffs: they 
will either be waiting to be sent by the mailbox, or they will get freed 
immediately upon driver down.
>
>> The removal was to deal with the setting of the MTU, which requires a
>> channel to read the size of the shared buffer.
>>
>>          mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
>>                  sizeof(struct pcc_header);
>>
>> I could create a channel, read  the value, and release it.  The Value I
>> need is in the ACPI PCC-table but I don't have direct access to it.
>> Perhaps it would be better to initialize the value to -1 and use that to
>> optionally reset it to the max value on ndo open.
> If you cannot create the channel until ndo_open, I'd you will also need
> to check the current mtu value on open, and failing if it exceeds the
> limit of the channel.
>
> If you have some way to extract this from the ACPI tables, that may be
> preferable. With the -1 approach, you'll also need to ensure that the
> *current* MTU is not larger than the channel max, on ndo_open. For
> example:
>
>    $ mctp link set mctppcc0 mtu 1000
>       # sets current mtu, no max currently specified
>    $ mctp link set mctppcc0 up
>       # driver discovers max is (say) 500, now we have an invalid mtu

Note that I tested this and it now works as expected.

>
> So, if you're able to parse the max from ACPI on initial bind, then you
> can detect the error at the time of occurrence (the `link set mtu`)
> rather than later (the `link set up`, and then ndo_open failing).
Yep.  Makes sense.  Setting it on driver add is essential.
>
>> Check  me here: The channel has a value ring msg_count that keeps track
>> of the number of entires in the ring buffer.  This needs to be set to0
>> in order for it to think the buffer is empty.  It is initialized in
>> __mbox_bind_client, called from mbox_bind_client which is in turn called
>> from mbox_request_channel
>>
>> The networking infra calls stop_ndo, so it must stop sending packets to
>> it first.  I can netif_stop_queue(ndev) of course, but that seems
>> counterintuitive? Assume i don't need to do that, but can't find the
>> calling code.
> You won't have any further ->ndo_start_xmit calls at the point that
> ->ndo_stop is called.
>
>>> Is there a mbox facility to (synchronously) stop processing the inbound
>>> channel, and completing the outbound channel?
>> There is mbox_free_channel which calls shutdown, and that removed the
>> IRQ handler, so no more  messages will be processed.  That should be
>> sufficient.
> OK, as above, this will depend on the approach you on allocating and
> releasing the channels.
>
>>>> +       ndev->mtu = MCTP_MIN_MTU;
>>>> +       ndev->max_mtu = mctp_pcc_mtu;
>>>> +       ndev->min_mtu = MCTP_MIN_MTU;
>>>> +
>>>> +       rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>>>> +       if (rc)
>>>> +               goto free_netdev;
>>>> +
>>>> +       return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
>>> As has been mentioned elsewhere, using the devm cleanup mechanism is a
>>> bit unconventional here. You have the device remove callback available,
>>> which lets you do the same, and that way you can demonstrate symmetry
>>> between the add and remove implementations.
>> This has gone through a few  iterations and I thought I had it clear.
>>
>> I was trying  to make use of automated cleanup as much as possible.
> OK, your call there. Using ->remove allows you to be explicit about the
> matching ordering, which would be my approach, but that's certainly not
> the only correct one.

The last of the devm_add_action_or_reset will now go away: I don't have 
to free the channel when I clean up the device, as it will be done when 
stop is called.


>
> Cheers,
>
>
> Jeremy

