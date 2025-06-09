Return-Path: <netdev+bounces-195905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D8AD2A77
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0ED188F879
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018A22A7FE;
	Mon,  9 Jun 2025 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JanCvUCc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E059227E9F;
	Mon,  9 Jun 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511587; cv=fail; b=VvdyIgCa7sPFRUcYu/2xbKJAbKLUuLecauia9DuypfOZhXpR0DG2//6GyCapi2sCVQQDCpJWO163VekATQBDqyW/Jtq3pZ7RYjOLfcSgNIFkZOL3flZ8lH2RMwZrixOh1e/eHbdkKoy0xTRrH2BrBgyImhnH9BdCH1qzYXjCjWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511587; c=relaxed/simple;
	bh=mMMKcCGY8kBA7Kaxi7uw+ZA7JSUy7fFZD41kO3jxpu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSmRNZiFwE4xiLoKpVq8LK0yHPqHnstgHnmhIJ1bFpGK3ATsiSlPG1oBaz1aM8+lhZmrRBpP5B/6ezQuk8SeGQc3Ra4tr8bcF6afczHPKdpU+aC4qYaBU2SiZWYd41KzmqNFkXPpNH8EQ8pAXiwcTITWqbKE6MllXQJfGx2xYEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JanCvUCc; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV0NElqkGmRId/gDw6pieKfmoQPywcFLd0zYs8Ylio4/ZXVdTYVlrGOhmhkQ3nL9ZzaRkXKyuuvCTzGSW/mXwwTX8lLn1+Iuc7QKhVKqE3AwCFJUrixM/1a52WhC2KhQHXAbJ+Uy9Y87tK5n11b2zlj7B2q6K4gBnt+xuC/OYl5RfJMxfO4cBDCiJUg/LbFqTK54JUFvE9XGtV4dKJiAS/ddYE0kac+b6JGMSxtl0R/RoiQNN0bYNBEVshkad/s67kJGGezkFbAsSO3/k1zoD03vVrILsE9PgBV7gyHVnHRV4QAQgksg1kFe1nrPqTB2Dy7TWBDiiDn563B0LfgqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okPw98SM3lzuoJ63L3GpV52a5lgNJBguxASdffqBOxw=;
 b=aQps72XPzwVoukHrOXShyBZ5Jh/HpoZq3BWLnSi8gMcaRvUDFuDOqA/4j1W4cVfyw2EZvGU4wozL8VkPOamYPAYY0RRaZhh1q2QpUrIc6A8mOnpkQQWJwk1O4vr8adC2rFBz2GkiTj7gy18eaWEY1pJ1VcqPP8XBKuxnx9Ddy4ECW7zMbED7rHK2qibfZlCETQvxnAqyv7Ezz5Ptw5JPGaJAr9fVPLfgfnIw4Bqpu3ujrC7ApRQqOSCKrnG0ulDMDM1DUikuxIsIkjLEzsRYH6hGgnRACEWmCkXqjkFod6tHU4V8M9E6gGTnMnwJZ1NC+JV2gfDa6y/yBwOu0mf9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okPw98SM3lzuoJ63L3GpV52a5lgNJBguxASdffqBOxw=;
 b=JanCvUCcAFQNPmfihJtrY/76SwwsYnRJWQHhUsIXsMfYjdQUCALXqCm5eMcmOicgHP2PImmKHlY+mE8ngsdV55DjOyzZ7/r0kQ9CQp4sMORMvticGlUdOTnzcSBnk70YUks+p42hdyKjbh5luFMTYOE85lYzrMqZvJzZaRAnaUB9UiBf+IzWNiwXCmav4O89Qp0T+YSNReUJwhs5rTb8J5ki9Akf/Rt3R/OsazX5Eszytp7zd3ZOfmhlq+X9QXmCu4H5mLIBFxS4VHerwoqZvF/cdZji0yiKKtGjSsWCsRba0zG2PmBLRSyl+b78SpuQiswfNcib7z5dB18sAIj2kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS0PR03MB7581.namprd03.prod.outlook.com (2603:10b6:8:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 23:26:21 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 23:26:21 +0000
Message-ID: <67bae815-b210-461d-902e-e844e876bad4@altera.com>
Date: Mon, 9 Jun 2025 16:26:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250609163725.6075-1-matthew.gerlach@altera.com>
 <20250609221527.GA3045671-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250609221527.GA3045671-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS0PR03MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd10af8-d65e-4ff8-da2d-08dda7ad0ae3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWFjODFLaWg1NlZhaDVDNFJnbE94VWhHc0c2c0tHUWRkTWQ0QWRoZWdRcm9D?=
 =?utf-8?B?cTJVbEl2VGcrbFdPaEE1S3d6L3FwQ3BBTENZbFpJeHZsVTRuWnkwSzhJQjVr?=
 =?utf-8?B?ZmtGM3R1a2c3WjZmd2FlN2JvbUFrRHFiY0UvRXNjRWk3RGtVUDUzb2FNZWZC?=
 =?utf-8?B?RjRIaFhBbDEyQWFyOXhyYkMxV2ZnMnYxdWJCRTNJbVkwSlhvejNwd096OFRu?=
 =?utf-8?B?ZDU2NnVMWFdndlVhSWtYUXBUazVsZ3Uwalp0SXl6dGJKQmZ4UDRFRWZhQmtt?=
 =?utf-8?B?czdZRG5DT1d2QWhTaFpURDhBU3Ewdm43UDcrQWVqZDIrSGd6KzVKYm8xNlBP?=
 =?utf-8?B?RnNLQ2JtMUUvdWdTWUo5eXpCZUpsdWxCYUlBNFkrRFlNejloNzR1ak8vN2V6?=
 =?utf-8?B?QStUb2diQm5zdHQwd0hKVTBGcGlWWnl1dUwxM1poMUxQV2hROXZqZ1pVd0NX?=
 =?utf-8?B?M0ZrKzRleVViODI1Z3lKaWlXakgwTXNYVEFPeC9ZTXZXQWQvR2czMXBjWG02?=
 =?utf-8?B?c1VhZVI4MW5BSnhUYnNJVG96K0VSNVg5aGt4VzhHUUd6LzBRVy8vMWlTRVlo?=
 =?utf-8?B?RFR6aTExYlNaZ0p6U0ovZXYzNXRvcFlUeHJjb1BwZ0xhV3g0Rm9wejdFdlly?=
 =?utf-8?B?bXMzbWF2Nmx3L1pET09wMkN2alFCZzBmZ1g2bzBCaURxOFYrOHRsYzNIcWV1?=
 =?utf-8?B?QTJmZFl1bkFYa2F5aWU5a1JjNnhweGVjTkh6eERYR3N2RmM5dHFSSGkvV0tH?=
 =?utf-8?B?b1Y5RzJkTnBkRGJHeVI5UENtbHIxR0lIVUdmeXFWNXlyMFJ1STROZ0UrTWhU?=
 =?utf-8?B?K1JmMkFyOUYrM2FCOW9oeVNDZGhjM1dweXZwWDFJYnorT2Z5OHVqNGUzWVhP?=
 =?utf-8?B?R1NkdGNpRVZzMWNhemJmUzBWNkJnelgvQmx1dlVwdVhUelEyampYQWd6T0xX?=
 =?utf-8?B?a1prZCtsMDRwTnNCZlZzanVybWdlZGNxSTRkOEhqOTdEdlk5Qnk4bUFpNlUw?=
 =?utf-8?B?dHFzbVVmQlRXRURwbDBWTHlJNE1Edm5BakVuY1kwWllzSlJQeVpSMTlJSVhS?=
 =?utf-8?B?OG9aS25SRTc0bklHeDFyckpZOFR1anlaM1h6K3Q1WUtyN1p4a250S0cvRHRl?=
 =?utf-8?B?NWxNVFhuNVlxcHd1WG5VKzFEUWhNemEwSHZjWXhkdWRqZWxTdURmQ0FKZmZ4?=
 =?utf-8?B?bDRKR296ckVQekVEV0xRSis0YWNzTGlEMlZDOGpFUjlDTDVVU0hKYUxReFlr?=
 =?utf-8?B?QlVsTDdlSzlFVE85TXN2UGg4WWZ1eE13K29WdWVmVG56eXJJN0JPZDRxZFdh?=
 =?utf-8?B?czlPRDg4SzM3cno1cmcyc1ZUVWNsSHA5ZG1mZmZzNmpHOHB2UVgvK3dJQW5K?=
 =?utf-8?B?SHp5SjJRbFUzZ3FJZ0pwZ1JCdG14N2poKzQ3SWp0Q3BOR1NqdXIxVjlaQ2Fv?=
 =?utf-8?B?ejRrdHpFOGRUQnFKc2g1WWkyNExZNzNJcnBDTm1JOGJINGdlZm9naVd3K0Fw?=
 =?utf-8?B?NDl1WHBjN25rT1d6MVljbTVudFBUSUlPOHFVbzNBbDM4Qnk3WU5tOHNadFlX?=
 =?utf-8?B?THpkR09LWkxDSEFWN3JkbktyRVExWU10bktHY0FMbFRCWUdXTFJwYWFDTHM0?=
 =?utf-8?B?VGUvNlZZZVhaR2RJdi8rTUI2M3J1aWZNVHlqSE1GWTlrWklvanhFMDZibmZD?=
 =?utf-8?B?Q1p6NUd4bjhpNTVHM1ZBSm1wVWtJU1p1QW8rdW1FbjQ5QnQ5cmk2QVpBZHVJ?=
 =?utf-8?B?RW9yTDE0dE5nTWJVTGJaamxsT2ZwT1lncm5zVU56Q0pZWkJOWVJpYnRSUURS?=
 =?utf-8?Q?im5UCh0WE3TA0q5qWKHEQtQrezYM6fDbaBZx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QllqMzlURGFON2FhRHpaTktTQmhrSmNjYmFwVHNUcSsvQzM4Y0JDNGU0M1lq?=
 =?utf-8?B?OWtXZWRZQ1ZKZnA1VGpFTGxacE8zcEhRcWhwaER6dnBtUGMyUzBURm1RaEtG?=
 =?utf-8?B?cmlGWlpPRkZtWlhyZWZlRDNFc25zYU5HWERKV1M4b2pzTWt0aGczRHgrQmt4?=
 =?utf-8?B?L2NINEdNVERVVWYybUVDNlFTN084VldtdkxQYWViWEZRaG5rTmQ5QmVoRnE4?=
 =?utf-8?B?SE1Ybm5keU4wczBQZlhIcHV5Q0toaER5NDdTMzRCMXNFTUdxbEV4aW13d1Rl?=
 =?utf-8?B?c0UxSitVOVZ3TTNZbVdkdFhTQkxIUmRFN3BJRnJlRGpyQnlIM2dCT205c05B?=
 =?utf-8?B?U251eDJ3dlBVYnI2RUxuRFJRMGlPTEk2dFlLQ2c3amtrSHhBeGJFMEN4c0Rj?=
 =?utf-8?B?RWJ1cnB4WC85Z1ZpUmlTdzNlUHBxanlNOE0rNDZYQ1cvcmduUlRpMlhNcFdi?=
 =?utf-8?B?SE1kbS90VjZjZ0xSWlRVMzcwMGJVRlB4b1R3WmViNXBPWkpDMmNZOHE4bHdr?=
 =?utf-8?B?T1pZT3V3VDNlTTJRR3N1b3dtOHlRTXpHYzA4L1JydE1IaE1SVi9IK0lZWGlI?=
 =?utf-8?B?aTFvcEQvTTlYZjRoVWcxLzFhREJZQllMWnk4S0pabVVja0t2U0l0OE9INEky?=
 =?utf-8?B?UE1YQU80K3BkSlN6THozVUQ4U2dBS2NWS3JRZWlxV1V5UUxBVEducmJMZ3lV?=
 =?utf-8?B?MWhYWFhZdjQ3aGhtNmRJYUJEL1ExZWFna25zOC90WWhGaTFobGswUzZwdEZM?=
 =?utf-8?B?WmovZDVwdTBla1huenBtWW0vMTQ1aVEyb0FnOVBDV2VRaVJJL2F0WmpHcXlV?=
 =?utf-8?B?SnlMTldpeGZ2RGJna1pHeFcyZG12eFBpT0JpTkFYVjhROWpHT0VsRVB6NXBO?=
 =?utf-8?B?VGJoSFV2NjRoeTZiWldmazFFZGFPZGlBZC92ejVYeWRUdjEzZm54Z2tEd2FK?=
 =?utf-8?B?d012bVpOMCtUWU0yV3FWdmcwZkZKSG1ROUI0ZXFsNi9HUjFCWEMrMFdxYWsw?=
 =?utf-8?B?NkpFb3dXRXYrUEJ0VU1iTHlUOEFiZmFyTnhBSmxZTk5MeTl0U3VjRy9rTG1n?=
 =?utf-8?B?SkxwdlNZQ2lKbmhvdjNRVzFCVzdqL3lZUWxHd2wxdUhPTlB0UFZtK2NxM01G?=
 =?utf-8?B?WW5UL043U09yQ24rVkQ0bUFLTUN0cG1tZXVkN0UycStCOHAvb2hVTnE4cWNW?=
 =?utf-8?B?Nm0rNCtOMmoxbnlUQ2JBQjhqL3BKRU9kZlB6OVdIWnFOeHJEM3NtUW1hYTBK?=
 =?utf-8?B?UjR3QzB4ZlltZmpaT0gva0w2dHR6S09xYk9lZ1UzUlRJVlFZOTZVWE16YWVz?=
 =?utf-8?B?SGE0cC9neXQwcGNnUWdUY3NIOUJhZWpJaTMzT0NuVHhyOC9PbktvNDBCaWlz?=
 =?utf-8?B?VUNJUXdSNEs3aE5UNDRoUFFjUXNuYUx1alNRdDBxSkdqN3p4bnpWRHVsdkVs?=
 =?utf-8?B?bjB1Z01vZm9YdzlETnJNcjhXdDJhVnc4M2RyYS9NTmdWZ3BxdGpBbHRDNnRs?=
 =?utf-8?B?cmNBUmF3cnlrRHQvZ2hiNGNqa0JtWFcwNlM4Nk1xL3pXekN0QUlyWFdGanoz?=
 =?utf-8?B?U0hvQml4cFB1QWJ5VGNkTnFNTjFUanJpbXZnV2JNVUJpcW1qT3JPVTV5bFds?=
 =?utf-8?B?cmNoSFJXQkZRRG54dVp2Q0tHVFcxS05tb0g3YlRqanVLUEFqdGYySlpHZTht?=
 =?utf-8?B?N28zcHc5WWtXTldiOHRSL0p5cXZJYVV5cUdZeC9qOW9pNCtQbllaNkZUaHh1?=
 =?utf-8?B?ekZYWnZvd1JqVFZNZUx3OWVmVFpDVWc3WjJwWWVRNHord1dxMWt0MGR2UFpH?=
 =?utf-8?B?Sm1zZElhdXdheThKZ2RCaUxhUHZydXd6Ulo1Q2FieUF3Y01PaEtvK1g2Vnpw?=
 =?utf-8?B?UXhjNnNxcFNQMnEyZTh4Y2pSM2U0N29VK24xSExhU3Z3blZBMFFtNUkvbHlz?=
 =?utf-8?B?a1AwMFR1RmFsVlUxeGFQQXlBWUsvZ2d0ckVGTXJNcUFzSnlzWWlSdHd1N1JY?=
 =?utf-8?B?b05MMUZFaEE5dCthdTJ6N000UjhYZHM2cnVabTJhZWZnRVNIZWNmOGZTc0dt?=
 =?utf-8?B?KzNJc09ua1NCTTBRVTk3US9KeFVzYjE0dSsxbDdxVngwUjF3aXY1QUlHUUtq?=
 =?utf-8?B?cVIrNWE1cmMyTkQ0a3ZoaFYwUkh1MHdFYlpaYjRpYWlSZm1NNmpPVUtnWXN5?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd10af8-d65e-4ff8-da2d-08dda7ad0ae3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 23:26:21.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77vsxH0GIG5NULSODFbxHfsMhLhEGXeW4jrYa1UD2AWCujR4+zUw2S7na9es7oXW473Mkq4IUW9ch+BqZGjpjjxUyD9l6Mj4XLiZHroNSv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7581


On 6/9/25 3:15 PM, Rob Herring wrote:
> On Mon, Jun 09, 2025 at 09:37:25AM -0700, Matthew Gerlach wrote:
> > Convert the bindings for socfpga-dwmac to yaml. Since the original
> > text contained descriptions for two separate nodes, two separate
> > yaml files were created.
> > 
> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> > v4:
> >  - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
> >  - Updated compatible in select properties and main properties.
> >  - Fixed clocks so stmmaceth clock is required.
> >  - Added binding for altr,gmii-to-sgmii.
> >  - Update MAINTAINERS.
> > 
> > v3:
> >  - Add missing supported phy-modes.
> > 
> > v2:
> >  - Add compatible to required.
> >  - Add descriptions for clocks.
> >  - Add clock-names.
> >  - Clean up items: in altr,sysmgr-syscon.
> >  - Change "additionalProperties: true" to "unevaluatedProperties: false".
> >  - Add properties needed for "unevaluatedProperties: false".
> >  - Fix indentation in examples.
> >  - Drop gmac0: label in examples.
> >  - Exclude support for Arria10 that is not validating.
> > ---
> >  .../bindings/net/altr,gmii-to-sgmii.yaml      |  49 ++++++
> >  .../bindings/net/altr,socfpga-stmmac.yaml     | 162 ++++++++++++++++++
> >  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
> >  MAINTAINERS                                   |   7 +-
> >  4 files changed, 217 insertions(+), 58 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
>
> altr,gmii-to-sgmii-2.0.yaml
The '2.0' in the compatible string refers to a revision of the converter 
IP. Wouldn't a single yaml be used to describe multiple revisions of the 
IP, like net/snps,dwmac.yaml? Having the revision number in the filename 
appears to be unusual.
>
> >  create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
> > new file mode 100644
> > index 000000000000..c0f61af3bde4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +# Copyright (C) 2025 Altera Corporation
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/altr,gmii-to-sgmii.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera GMII to SGMII Converter
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com>
> > +
> > +description:
> > +  This binding describes the Altera GMII to SGMII converter.
> > +
> > +properties:
> > +  comptatible:
>
> typo

I am very surprised by this typo; so, I rechecked. I used the command, 
make dt_binding_check DT_SCHEMA_FILES=altr,gmii-to-sgmii.yaml, which did 
not report an error, but I did confirm the bot's error with the command, 
make dt_binding_check. I will be sure to run the full 'make 
dt_binding_check' before submitting.

Thanks for the feedback,

Matthew Gerlach

>
> > +    const: altr,gmii-to-sgmii-2.0
> > +

