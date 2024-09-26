Return-Path: <netdev+bounces-130004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B09878D4
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DD6B2320B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD31509BF;
	Thu, 26 Sep 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="nwzHccil";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="R3U2g4Gf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE764A24
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373862; cv=fail; b=BY22VkivbTIm5NNTq98uIM1aY1oWU8jWsB0UNcfNZS1dlN/Fg6P9E/pmgE21B8kY1tO8qJPpDgQWMpwVQL0wYkJBDwnVDbkCN0+nrV8kyrsaM3I3WUivvVUatmNVc4GZW0tzN+fc5PtyeMxZYOKRpx3MmuqmsVluABLJdoRiJyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373862; c=relaxed/simple;
	bh=tyzvHFIXanCra+r9ps+Wz5R/hYTLpkgnDxV3lTrvYKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fXMlQlmIhRe3JCwGQuwZ33b5KSXEnNzzTZxLH0AZdiwDC/o1LivOprZDsnVz6BASeyTU8ILZ4QeNGjU1/QdhiwGguAeCbj5r3IAXYMXWO2K6BGLJLl/UkNtulaRRumU6oCTwXTEkNQsHLdBE6PLpVrdM2Ytn9IQy4XJ+IS1yBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=nwzHccil; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=R3U2g4Gf; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAA45S006774;
	Thu, 26 Sep 2024 11:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Wfo3G3W86yrEmEEDlJdPAoYw0h88lGgyQabAbDKvP
	YE=; b=nwzHccil6u/j8D0cLbeVyLBPlQ9U99LuraKT042JLDIeN+sxNdRp7Qhau
	uov4TdgiAZ/5jguNfPX5SSblA5jNSSwTXbSTTlbRRso7qqf5bAIDIF+07BwaQiXx
	Llo+bwZrmtarNPBVnzwS9MmmIZIQjAfsbVwIHRCTG9qHXVLDKROpewW3L3KDnHfZ
	vmL2XvaaptEE7xFJSKBtEwzRy62Uzv8FvHhyvQ/zr1r8bBOOlhu/cXqgLaEBmH2t
	x6u9LdpzwC+tfA7ihlOSv2jqt1mYLfv6BcdRmnVBGyEsEtAka4hOM3G/U5k5suJj
	AxC1iod7dE1OHFS7c4s4JiXtqVxsQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 41sw7kwfp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 11:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/SkzSMCY46KYb+RZ7yVk0o9Ocz1kE6Y8BORTI2OJJ5tXBlbmXPyME59mgxV0pgLvJrLH4hIzvTRE3ely+cpkhMaovkKYp10vxQfre2A0u/ICzm9xjDBvgQoVoTXHw3shdXKGrKqYH3CEupexI+9xlksrsSE0Xg2wJg07wRNhGqN7F0Jb068SowNQ/OyjXgfCtMMTQNqBOZtSqHMnwRtUS9oUOmM0LU53HaVEhlNYLnyHcPdXunGxlIb7jF1lMCv+CH4eEUGovO0FfQLCVvXoCaARptTxpDO6y3uoFGCSlH0bgsV0PUO3j0GAW+2P/0zHylutnhotR/YNkN/2BBp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfo3G3W86yrEmEEDlJdPAoYw0h88lGgyQabAbDKvPYE=;
 b=cfMOfm/XjvoZ2fnL6GDLLYE/2S3skMtzs/Y+4Bwk4juJFq1k4Klieu7hD+3OR8BS6xb7jlTGtW3w4/DJ+fxHCo7IbdKKtIZMD4nLp9COogweg7QIX63bRzIyiax4k6P8dXsLB+qtjLq0Q0B08fRbl+xTqD/fxe44YuG+NrI1JR4maLPp1mr+hD7I5eBotW9A94hd7UJPlIrtJhtooXkjYoTSlRBHQHaLJ/J2vizegSoaqr2V++hA9v90wHqOk05ggLFKo8itCDOoCBBUNNsSGqwQyVt0Kvl+x77xdHrOb5vMqBRNbprnF7HXy+fvJLpIksBUB99BA7XdtPNdswrfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfo3G3W86yrEmEEDlJdPAoYw0h88lGgyQabAbDKvPYE=;
 b=R3U2g4GfIT8KRJhouTAK7ijQp/aUJpywHjyB3cTTFR9CL9U9ERhbfcEqcOmRA+CtbJoapcZ1R7bN6ZezBevHfz2ZB1dPwxDfwfIjz21EFSVqjarLLCu1kcDO8SknQUKUb1E+rzTxauF45yHVWey4NMgNz0o+vUVjetjdNWcFFpUhscTWAZAOOSOfbnrmSjwV26kC+7d/BfLnUHHpu58IOsbSsb1LD8hYLFSE4pjmfM+A0MpAyWY7LkMDh9ZFyLodensXNwhLkaP5bnlYKs3rk5FNCTqj3Jd4LuHDNKnPAu4mHxdi76k4fu1KOCnbK2eD2twexdxeoSrqRbUP1B30mA==
Received: from CH0PR02MB7964.namprd02.prod.outlook.com (2603:10b6:610:105::16)
 by BN0PR02MB7966.namprd02.prod.outlook.com (2603:10b6:408:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 18:00:08 +0000
Received: from CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::dfe7:62b1:b932:fcdf]) by CH0PR02MB7964.namprd02.prod.outlook.com
 ([fe80::dfe7:62b1:b932:fcdf%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:00:08 +0000
Message-ID: <88ba593e-97ee-44a6-9428-37b8abb1e720@nutanix.com>
Date: Thu, 26 Sep 2024 19:00:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: avoid potential underflow in
 qdisc_pkt_len_init() with UFO
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com,
        syzbot <syzkaller@googlegroups.com>
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-2-edumazet@google.com>
Content-Language: en-US
From: Jonathan Davies <jonathan.davies@nutanix.com>
In-Reply-To: <20240924150257.1059524-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To CH0PR02MB7964.namprd02.prod.outlook.com
 (2603:10b6:610:105::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB7964:EE_|BN0PR02MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8f1c56-fc42-4220-aec8-08dcde550ea7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2ErUWZXVlplbTZmV3g0ckZnSmJOMjhlT0xPeVRWc3BXbEZ4em9Da2dRbzZJ?=
 =?utf-8?B?aks3c0p6M3BqSkZBNjBxZk90RXNjM1Z2NjZBM3lpVk16dlJRQm0xQUllQmtx?=
 =?utf-8?B?MnVsd0hsTkhyenBwYU15WExTSE1pL0tvU0V5dE8ra1FGbmR2ZEhTN2lsV2hk?=
 =?utf-8?B?ZzdhTXJjNE9GY3BOS2FVNkEzT2tVSzZhdkcyanQ1VUd4bWRkcktSSUdiU25p?=
 =?utf-8?B?SUNQRnhFa1hLK1JlR3dSTFRadkIyVVVDamtVakJZT3hVQ241OUtRZUJ0ZWFr?=
 =?utf-8?B?OHVRV0Vsdjl0N3l1KzM3Y1FJQW5WbklCQXRVeFQvYlZSRmQ5c1lsZzFZcC9I?=
 =?utf-8?B?bms0R1BiakNGNUw0bFRhNHBCM3NSaFhxNmxORTc5dDduS2Y4dHNTTkgyUzIx?=
 =?utf-8?B?bjl2OHhUU3Vxd1VqTEdjekJnRitWOWZtK3dTYWJSQnJ4MEUweU9QQ1REWThN?=
 =?utf-8?B?eUR5VVR4ZUQzQUhjRWd0UHFnaUR1eWlob0d3YkJTUThGbStreTFrVHIvVFUw?=
 =?utf-8?B?V0I0cGwxVHdDRVNzTkFCSHhEQjFBMEd0UXg3UGVuQ2VRMEIyQjhGNmxUVGlk?=
 =?utf-8?B?c2FJWFJYa3l2cXk3c2JCRjd5cHNsUTVhNmtTUGsxUTJBRnFVejFpRDRCOXhr?=
 =?utf-8?B?ODQ3dWRWTnRjYlA1dkNQdndoNENzSFhsZHBlVlJCVVN1VVVMdDJHQktCVmNY?=
 =?utf-8?B?SFdsWVVxcDVJTzh4OEhhYytKUkcvWm9aK2xBNUova1BTNWdzN29wK2IwYlUv?=
 =?utf-8?B?aXI1cGlpQ2hQN09pSFNRN2hqRGJFZUNQK1BKV01EOFJDT3FNT051MXU1TG1v?=
 =?utf-8?B?OW1rWnkzc1Mvd2d5aGpsclhLYk9OMnRMUnJGTmFjb1d5RTRJWTJYVFVuU2hz?=
 =?utf-8?B?T082dWF6dGJoaDRET2hGZ2tBN2JoNzFpWC9FUU9GMysyMC85em92Y0Y4ajJ5?=
 =?utf-8?B?QWp0V29NOXQ0YnRvQ3dFY3NSVjdLZjlzbTVpbnB3U2VZUTRXdkVtZ1RROEk5?=
 =?utf-8?B?Wld1RXIzOHpYQjFnMVdQanlOdnFzRDkrUHZ5d1lQS3FIQkUycmRuYWxKbEx2?=
 =?utf-8?B?VlAzdGRQS3BEVyt4dGF0cEVPZlZpYklFVmVXNFpZQTZ4RGtrWmk1eW16S3Jo?=
 =?utf-8?B?R1Bta2pEWDZVdkhHREc0bjJ5bUthaUJSY1FXMzFwQmUxZDcxL2RLUEd2QjV2?=
 =?utf-8?B?dUltY1FNTzRhbkhJZEJwL1N5TkUzS3ZKU3ZUQkIwNEhHK2VZQS9QS2RKbU13?=
 =?utf-8?B?TURWNHVQVFUxcXdxTmlrVTZIVkpWOUNCWUVROXJYenRDbVF2MDI1SnZFdGhs?=
 =?utf-8?B?dm1oMURYMUd1akhndHdWSm1EVlBCOTdlSCtMQ1NtQzRyOTQvR0VwNWZPNlp2?=
 =?utf-8?B?MTRZSis5S3M2K1VLQ1dQOG5IcTBRdzlRbzZYQ29GREs3TWZmZU9zL3JKdFFS?=
 =?utf-8?B?TUNhbTNpVDUwblpmTXZnZjUwdWpBYzFkd1VWVUk3WHNCS09rV2orN3krWmJ0?=
 =?utf-8?B?Z1pSRTJyN09JWmJ1cHNQRHN4QUV6NjJJUXhpVGN3RXk4bmdQSkM5Y1k0dVdF?=
 =?utf-8?B?R1ZDODJmV1p5QWRoRFl4NWF2dTZhbGtpcEt0bzJBUDVtOFpEK2JLaTUzeGRl?=
 =?utf-8?B?NXVSVzJmdHlkS1lvai9xeDhXQjRqYllFRytPMlZBaURhdlBybVNjY0ppNk9R?=
 =?utf-8?B?MnZoS2N1amx3QnV0VVVoSWphOHlQb1VaOGd0MVBRYTBSR1VNRys5WGV2cURn?=
 =?utf-8?B?YU96L0pSOG5lVHEzUUdNVC9WaFN6WWd3Q3ZCN1dOWUIrQ0g3dFU1NXBEcjRj?=
 =?utf-8?B?TmpTUUZYdzNSN0h4amtvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7964.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25xdlRkSThGejRpMHd0Snd5YmxGSGFjRnRveGNEWThUejBkdFhoeTBLYVcx?=
 =?utf-8?B?NDAxUENmQ1dXa1c5VUFDZzFxM0J2S1B0RjlQRHdwSURmc21kdW9Pdkt0VWND?=
 =?utf-8?B?Ukk2YkxQRlY5dDRXbnYyb042VkFJSldmODhWdmludTBVWjQxRHpkbHlkYmRO?=
 =?utf-8?B?NCs5VVVqakEzU1ZaTlNxU2FmOThFK3JrVGczZWpLRGhxK3haTVl6OFpQQUo0?=
 =?utf-8?B?UUU0dzR0VGlNWWptSGhjMVZFWkFVcVBWaUNxU05abDlsbDAwc0FUYXVjWTZo?=
 =?utf-8?B?YWdLRTN5MlBhbE5qZHliTVNma05qZDZKT1VYUTNBdUNSVzM3aTMxdnZOdHZk?=
 =?utf-8?B?WW03SWNCY3psNkxVWFBqWHBDRStEMEpLN2tNRW5zVHNIdEptQWlRYzRReDB4?=
 =?utf-8?B?MnVNQTFrRHFqM0RnWTFhM0IyKzNWbjVDNkJzNXZVZ2JKTFdmaXYrLzV3dSt6?=
 =?utf-8?B?QjNJc1pubDI5TGpOdWFyemM4U0dHUFF1NUx6N0dyZlFuNUx0aUxqSW1oZmlR?=
 =?utf-8?B?b1FXREN4OUxHaCszTlNVZmZqbDQzdWdkL2srbHJ0SExrVkdlYnVJaWJaVUZt?=
 =?utf-8?B?aVQxc2VMQW9UdElyOTFEeGhMdlNMQS9PaEJUaHRlMUR0bUdOWGUyQjBEUUda?=
 =?utf-8?B?QXlhY3BNK0dGaEQvVUozNDA2NG5VakI5d2xvNFNWTkNzejBSZFIvd3BPZjFt?=
 =?utf-8?B?QTdxcy81bFdwZzhncmJnTWJTOEdISFQ3QW91dUVQRURtK1RERUV2NGtnS3Qx?=
 =?utf-8?B?Z0ZxVzN2Sjh1d0Mwdis3OVhLcmtoOGg2ZUFHcnVpNCtnVDFpVEd5OGFUQmF6?=
 =?utf-8?B?MldXdEdyemRTT1RZazlDZ1FtM1VNcVpTZmlhU2pTaS93NFZYVVdGVUoyaHNY?=
 =?utf-8?B?YmFoSnQ5QTZRV0FMdlFHbWxXb3JuK0I3ZVp4OHFhVDRRb3JlRmF0VTBsNTg3?=
 =?utf-8?B?NjBOQzM0cEl1ZHBhTytVT3UzeFFFUE14THJkcmFQU1ltcm5DWVJVWm03VVJz?=
 =?utf-8?B?UjhKY1ozekx0azVaeWhtS1FoRU1ndmRHUlhLV0VhQmNzYlBtL1A3aGp0U1Qy?=
 =?utf-8?B?emwyaFhmWWZtRVpMQUNMQVE2YnpyNEdVOHUzNUd6aTNWNHptditXN2ViZTJN?=
 =?utf-8?B?djdSTnVKSHVyNzEwMXZBTDVIVG1Rb1VHYlU0UmJHMktrb2RRa0dzYXBDS3o4?=
 =?utf-8?B?WnNwbWV0UTROMURzL1NhN2wxQnlGaGVsRlNaQlZwblVOekRZYmJQcktiaEFI?=
 =?utf-8?B?QVA5cGtFUFA4WlFnbkU4M0pyQjhnNTJneXJvV3ZIQmpITzdMMGl3bTNMU0I5?=
 =?utf-8?B?dXQ4c0N3bmIrWnpHMzZCcUdDSGpPdWNQb3hBQkNjci9GT2NNMG9QQllNaEM1?=
 =?utf-8?B?ZGlFajNWVkxQdmdnc1ZyQ3pEaGM1ZGVsdzBHS0RVWDNOTmNNNEJxSDNLTnh4?=
 =?utf-8?B?NE5XWHlTR2IrSHVwTnd1eHVqOTJvcmpwQXU3c3diY205U29XL2Q2cUN4MzVN?=
 =?utf-8?B?SGJsMHdHS25wM05ZdFVJT0p6UHU4M0dqbTh1S2JmaEUrQ0pUblNMVExUQXNS?=
 =?utf-8?B?L29lVHJZZG1EMGhvU0dSMDhNQnFTQ3dXTkt4ekRnVU5zQ0JkdW56T3g2bnhK?=
 =?utf-8?B?YmFwK2ZHVHM5b1ZyZVAwcVg2cTJhRFR2a3ZCUGNNZGF1RThyaHFDUGpDSjV0?=
 =?utf-8?B?YU4yN2pjY29FVVQ0QmhPeUgvMUtWY0ZJYklzQ3RxcjNxNFBiRkFyYjNBZi9z?=
 =?utf-8?B?bjl3TXN3U1U5YWs1d2ljMFhjY1NqVFhjQU1Qb25VQjIyQUtYajRRU1owdzdC?=
 =?utf-8?B?NllSRVFxVDJLaG9jNnFCRGxUZVZTZXJEeVBray80NFlCbzBNTlNqMDgzZzZi?=
 =?utf-8?B?ZmxnK3NGYjRhR2ZXVlNWaXBMRys3TExiLzNhd0tvQkh4TndQSjh1OGFnOXlE?=
 =?utf-8?B?L2lVWW5Hd2RkYzMvb0dPSVl2RHp0K2NKM3BHemhiYjhCSkZ0WmxkK3IzT3JX?=
 =?utf-8?B?MU9wY1liRnlJY0d1RGJhZUJqZzJyYVkwQ2NGMHNRZWh3RHhxd2JyTEJCbCty?=
 =?utf-8?B?RHBNakRtZVl1N2wzWUFmTlBqRzRiNjdkNmN5eGg2Z3JOdnhKV0NlSnBkRzhu?=
 =?utf-8?B?NXViWDNsVHJxeFFjZ3c4d1psellkMmtXNGd3ZmdiVU14cnlqQ2M2MUxyWFl2?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8f1c56-fc42-4220-aec8-08dcde550ea7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:00:08.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHQFut5ZMgzi73cBEMg/DUcExbKdJi8/++RZSrohX0lLStMxjySYUVrcY1rrgfhXwp+vPYQJH+NL9cuZoZKNvaOeqbjvB9/LQNbBFIRkjFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7966
X-Proofpoint-GUID: M-UBrUDLKv4CZWTE2t5bJS-GOgIxjnXx
X-Proofpoint-ORIG-GUID: M-UBrUDLKv4CZWTE2t5bJS-GOgIxjnXx
X-Authority-Analysis: v=2.4 cv=E6ifprdl c=1 sm=1 tr=0 ts=66f5a12a cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=4RBUngkUAAAA:8 a=1XWaLZrsAAAA:8 a=lvdKJX6Kg4st4nprBhsA:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Reason: safe

On 24/09/2024 16:02, Eric Dumazet wrote:
> After commit 7c6d2ecbda83 ("net: be more gentle about silly gso
> requests coming from user") virtio_net_hdr_to_skb() had sanity check
> to detect malicious attempts from user space to cook a bad GSO packet.
> 
> Then commit cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count
> transport header in UFO") while fixing one issue

I've tested that the issue fixed by commit cf9acc90c80ec isn't adversely 
affected by your patch, so:

Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>

>, allowed user space
> to cook a GSO packet with the following characteristic :
> 
> IPv4 SKB_GSO_UDP, gso_size=3, skb->len = 28.
> 
> When this packet arrives in qdisc_pkt_len_init(), we end up
> with hdr_len = 28 (IPv4 header + UDP header), matching skb->len
> 
> Then the following sets gso_segs to 0 :
> 
> gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
>                          shinfo->gso_size);
> 
> Then later we set qdisc_skb_cb(skb)->pkt_len to back to zero :/
> 
> qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
> 
> This leads to the following crash in fq_codel [1]
> 
> qdisc_pkt_len_init() is best effort, we only want an estimation
> of the bytes sent on the wire, not crashing the kernel.
> 
> This patch is fixing this particular issue, a following one
> adds more sanity checks for another potential bug.
> 
> [1]
> [   70.724101] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   70.724561] #PF: supervisor read access in kernel mode
> [   70.724561] #PF: error_code(0x0000) - not-present page
> [   70.724561] PGD 10ac61067 P4D 10ac61067 PUD 107ee2067 PMD 0
> [   70.724561] Oops: Oops: 0000 [#1] SMP NOPTI
> [   70.724561] CPU: 11 UID: 0 PID: 2163 Comm: b358537762 Not tainted 6.11.0-virtme #991
> [   70.724561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   70.724561] RIP: 0010:fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
> [ 70.724561] Code: 24 08 49 c1 e1 06 44 89 7c 24 18 45 31 ed 45 31 c0 31 ff 89 44 24 14 4c 03 8b 90 01 00 00 eb 04 39 ca 73 37 4d 8b 39 83 c7 01 <49> 8b 17 49 89 11 41 8b 57 28 45 8b 5f 34 49 c7 07 00 00 00 00 49
> All code
> ========
>     0:	24 08                	and    $0x8,%al
>     2:	49 c1 e1 06          	shl    $0x6,%r9
>     6:	44 89 7c 24 18       	mov    %r15d,0x18(%rsp)
>     b:	45 31 ed             	xor    %r13d,%r13d
>     e:	45 31 c0             	xor    %r8d,%r8d
>    11:	31 ff                	xor    %edi,%edi
>    13:	89 44 24 14          	mov    %eax,0x14(%rsp)
>    17:	4c 03 8b 90 01 00 00 	add    0x190(%rbx),%r9
>    1e:	eb 04                	jmp    0x24
>    20:	39 ca                	cmp    %ecx,%edx
>    22:	73 37                	jae    0x5b
>    24:	4d 8b 39             	mov    (%r9),%r15
>    27:	83 c7 01             	add    $0x1,%edi
>    2a:*	49 8b 17             	mov    (%r15),%rdx		<-- trapping instruction
>    2d:	49 89 11             	mov    %rdx,(%r9)
>    30:	41 8b 57 28          	mov    0x28(%r15),%edx
>    34:	45 8b 5f 34          	mov    0x34(%r15),%r11d
>    38:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
>    3f:	49                   	rex.WB
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	49 8b 17             	mov    (%r15),%rdx
>     3:	49 89 11             	mov    %rdx,(%r9)
>     6:	41 8b 57 28          	mov    0x28(%r15),%edx
>     a:	45 8b 5f 34          	mov    0x34(%r15),%r11d
>     e:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
>    15:	49                   	rex.WB
> [   70.724561] RSP: 0018:ffff95ae85e6fb90 EFLAGS: 00000202
> [   70.724561] RAX: 0000000002000000 RBX: ffff95ae841de000 RCX: 0000000000000000
> [   70.724561] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
> [   70.724561] RBP: ffff95ae85e6fbf8 R08: 0000000000000000 R09: ffff95b710a30000
> [   70.724561] R10: 0000000000000000 R11: bdf289445ce31881 R12: ffff95ae85e6fc58
> [   70.724561] R13: 0000000000000000 R14: 0000000000000040 R15: 0000000000000000
> [   70.724561] FS:  000000002c5c1380(0000) GS:ffff95bd7fcc0000(0000) knlGS:0000000000000000
> [   70.724561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   70.724561] CR2: 0000000000000000 CR3: 000000010c568000 CR4: 00000000000006f0
> [   70.724561] Call Trace:
> [   70.724561]  <TASK>
> [   70.724561] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
> [   70.724561] ? page_fault_oops (arch/x86/mm/fault.c:715)
> [   70.724561] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
> [   70.724561] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
> [   70.724561] ? fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
> [   70.724561] dev_qdisc_enqueue (net/core/dev.c:3784)
> [   70.724561] __dev_queue_xmit (net/core/dev.c:3880 (discriminator 2) net/core/dev.c:4390 (discriminator 2))
> [   70.724561] ? irqentry_enter (kernel/entry/common.c:237)
> [   70.724561] ? sysvec_apic_timer_interrupt (./arch/x86/include/asm/hardirq.h:74 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2))
> [   70.724561] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:58 (discriminator 4))
> [   70.724561] ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702)
> [   70.724561] ? virtio_net_hdr_to_skb.constprop.0 (./include/linux/virtio_net.h:129 (discriminator 1))
> [   70.724561] packet_sendmsg (net/packet/af_packet.c:3145 (discriminator 1) net/packet/af_packet.c:3177 (discriminator 1))
> [   70.724561] ? _raw_spin_lock_bh (./arch/x86/include/asm/atomic.h:107 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:127 (discriminator 4) kernel/locking/spinlock.c:178 (discriminator 4))
> [   70.724561] ? netdev_name_node_lookup_rcu (net/core/dev.c:325 (discriminator 1))
> [   70.724561] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2210 (discriminator 1))
> [   70.724561] ? __sys_setsockopt (./include/linux/file.h:34 net/socket.c:2355)
> [   70.724561] __x64_sys_sendto (net/socket.c:2222 (discriminator 1) net/socket.c:2218 (discriminator 1) net/socket.c:2218 (discriminator 1))
> [   70.724561] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
> [   70.724561] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [   70.724561] RIP: 0033:0x41ae09
> 
> Fixes: cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count transport header in UFO")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jonathan Davies <jonathan.davies@nutanix.com>
> ---
>   net/core/dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1e740faf9e783b047b2dc7d9fd4242e4e6c7317a..f2c47da79f17d5ebe6b334b63d66c84c84c519fc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3758,7 +3758,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
>   						sizeof(_tcphdr), &_tcphdr);
>   			if (likely(th))
>   				hdr_len += __tcp_hdrlen(th);
> -		} else {
> +		} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
>   			struct udphdr _udphdr;
>   
>   			if (skb_header_pointer(skb, hdr_len,

