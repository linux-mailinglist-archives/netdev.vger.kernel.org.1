Return-Path: <netdev+bounces-101686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3788FFCBF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40A21C2814F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354A154C19;
	Fri,  7 Jun 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i2vv2Z0O";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="i2vv2Z0O"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6EDDD9;
	Fri,  7 Jun 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743987; cv=fail; b=fP0noiulOfuvw0OLVkQR2uTKdDSn3h8OmSr5qXXT4nDVnHPCplYxNJ9+sGG8TTi6wY9z8Ec/sXuv78sBpTgvPvg8/1nlmi0lRDHZvGGWjBrbZJdldFCjUkfz/Hxy6TIfQ0lmuUzn20pD5zPyjATM9FLMKsS3zYK8Q0QgjKfh3kk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743987; c=relaxed/simple;
	bh=0/dLHwMEzHjKdp/O/nVPLb/fJU2HJCJWCdtZf9/9qBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4gFlJ5usE9Wrl31E3GVdhgm1TZrzXuD+rTKYk12Cr925JU0Q18IRspBLAFdtkYy0oFlb2Y6TK2IanrEgX3yVSEhUHOkXAvnO4bXICJah/o7DTEWtB4jcxtGhvcdmUoeAyhegw4QJFiFwVph0R+FNNE+JSPsbdUH70bReLbbLoU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i2vv2Z0O; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=i2vv2Z0O; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=d8qdv7qGTTPme1IoZX93SNOK4/9qmOkpE5bH0lzDcaVsPDL8+cAW9SS8iJOtOCT5ajdXLcz+XDYjYz2OVS8/76VyD4/3XUBxfdWahn46hq18cpOgiwwR4mUDMsuX/nQbCn66n3yl3agOWFXeXUY1BsTuUMVXp7XSwheHMsMT3X0W2KfH6xEBuvAreFNNboCCpb+QbCC4ZJvt/uMTf+ZCGFo6kclPiufCbmJKlvl7/nf9cX9YF6AiZuTkctNn7+VD9n3PwbFt4WwMSYgYrASY69pGCHcGy8VepaROBGoEb4WFIrErk9udNLmjuDAxgPXkQ6tQpv7XIFUMDlmz6PZsHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrgvc5wpTR2ENv9sbcCg0lJOt883pPgkTKDsZ2gyDLk=;
 b=B/DfWqFE9PDFFG/EjlY8nuhxz5ZDWnvBnS8vhHIfo0hscgM+MQhhbyjqCIqxCawLFinfP3bLvPz2W3CgsB7q/i0qoVw4IA3SzRFuVzXIcpuZ/IrRm+P4ekgMGsgEFgUbZzNmZGmkhdzMKmDxk8BpfDH1sIWqclswoynSwzKjTPZU3DtuFaZXAzrORzSH0hlhkmhE7sBMliyxWunrgnaMCwIRazUHKRxLzMi3skGRbD6L79QzehOW7uPcw4iRQlCT9/1lW4r6p6O3WIE4V3pH+8+QsEqIfZVj8gxwpHzcCDBR4HIS98y7siTBXUnHrE6ePKW02D/w39R9fFCgR3bswQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrgvc5wpTR2ENv9sbcCg0lJOt883pPgkTKDsZ2gyDLk=;
 b=i2vv2Z0OXHAvcUVbxjbfrJP5L4CRb5h4PUCzLzQE3KakjuTt/dR7qi4uzfcDVIF4P0/5o7i+7AWlXr14GpK53WL3A4h3OK/W5ajMgoJ6mkRgxB2mvjvpqmREylpgvL/AEQx/WkrIcM0KAO4/q9nIWQ9D+Gcr5Fi8Q8yeU0sl2G8=
Received: from DU6P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::12)
 by DU2PR08MB9989.eurprd08.prod.outlook.com (2603:10a6:10:497::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 07:06:19 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::8) by DU6P191CA0012.outlook.office365.com
 (2603:10a6:10:540::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 07:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 7 Jun 2024 07:06:18 +0000
Received: ("Tessian outbound 81830094b942:v330"); Fri, 07 Jun 2024 07:06:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 507ec241984d3344
X-CR-MTA-TID: 64aa7808
Received: from 16c5e17d012a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 897B81ED-CD4A-422E-8A80-22A703404A28.1;
	Fri, 07 Jun 2024 07:06:11 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16c5e17d012a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 07 Jun 2024 07:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZXNg6jWXnquP1jCs4IonblHk5cNyyoACepotmeYRFQpXqkT2FccBQ8ODL3Eoym2qd8yJJ5FeqdeO9muc9Sys2JNKIizxiuTXu7oX8K87KLhY1t+sJCkS3/qzjU4HcGYB3rIGYkBIZOWR1+H+gR/CTM00CJD0KpJEN8m2DsnjcpXqNc3xrouplPfwKLpggQNJytYAp66bfd1531NSCK8uWJihHl4d5eBFw2BXVA62QJTzS77RRYSQiNg32c8km3aYJsPQRJjGs3CyOqCukl/Cgq9PJDC6b75gB3R9l20Lr2C0h6KUlFvvWVi82O+iqBOx5XtNZ7H0U7UPnkdBLMdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrgvc5wpTR2ENv9sbcCg0lJOt883pPgkTKDsZ2gyDLk=;
 b=Lb2fp2J5K8ynVJIMHCeYNz4xjVN7SXP2RsK28tRI+E0JarpTXEzA4wB2DlH0+miRnUIsoETkzN8eQIREE3SzJ5gKxs/OGAPE7jg7k5SgWBPVlVFjmob8fCImCVIYfDJwM4PeXvBNHb4LWtV+Kp3MSm4wN8XgPVdk0rJozOd92RzQ5AX/J152+oi8K3X6zAbOyrj/RHIb2Q3M5yJbT7o+gmIsQt8O8Lo7hoVKcfTKfCHzdkEkEL5VhkCV1z7CfAYTQQHKGjm8Y6BxdFd4p2AyEeocmkdlPyg/8jSgxI0/wpigQg26yHHIX6Jibe+H+Hg9wmLaKcu6ilbslL90aop9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrgvc5wpTR2ENv9sbcCg0lJOt883pPgkTKDsZ2gyDLk=;
 b=i2vv2Z0OXHAvcUVbxjbfrJP5L4CRb5h4PUCzLzQE3KakjuTt/dR7qi4uzfcDVIF4P0/5o7i+7AWlXr14GpK53WL3A4h3OK/W5ajMgoJ6mkRgxB2mvjvpqmREylpgvL/AEQx/WkrIcM0KAO4/q9nIWQ9D+Gcr5Fi8Q8yeU0sl2G8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB5PR08MB10236.eurprd08.prod.outlook.com (2603:10a6:10:4a5::12)
 by PAXPR08MB6575.eurprd08.prod.outlook.com (2603:10a6:102:156::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:06:09 +0000
Received: from DB5PR08MB10236.eurprd08.prod.outlook.com
 ([fe80::5877:519f:e3c6:5cdf]) by DB5PR08MB10236.eurprd08.prod.outlook.com
 ([fe80::5877:519f:e3c6:5cdf%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 07:06:09 +0000
Message-ID: <68439d55-af34-ab8a-dec4-0c2d95ed4294@arm.com>
Date: Fri, 7 Jun 2024 15:06:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/3] MCTP over PCC
Content-Language: en-US
To: admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nd@arm.com,
 john.chung@arm.com
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
From: John Chung <john.chung@arm.com>
In-Reply-To: <20240528191823.17775-1-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB5PR08MB10236.eurprd08.prod.outlook.com (2603:10a6:10:4a5::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB5PR08MB10236:EE_|PAXPR08MB6575:EE_|DU2PEPF00028D04:EE_|DU2PR08MB9989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e07d203-781c-4708-2045-08dc86c05420
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eGhNQ2pBTVg1K3JCSklYN21VR2RJejdLVjc5dEd4MnVNZ05IRE5JUTZ4d2xj?=
 =?utf-8?B?SFVqd2RIRWQ3eFRlMUZzdWNoVGcxcUdRYTZZMTZlbVhFZ0Z1djJ5M055TEVk?=
 =?utf-8?B?ZDRadlp4Z2djR3g5aTE4aERZUGRYNkxIcGZBV0FnK3dTcmlrR05hbFE5MkU1?=
 =?utf-8?B?UEFFM1MveHZnUlAwSnNIaUVoNm1UN2JXVkV4UUtEZlZFMHljYmpVSC9pZzRX?=
 =?utf-8?B?SFhoeXdmWGc4MnNLdE5FTnAzdkxtQ29JU2hHbkI0ZkYyVndrZ0pRZkZMaENp?=
 =?utf-8?B?Mkk2Wm01YTNVWFd2RVIyTlFvNENVQ2R3ZWs2ZlVKaWM2ZnRqV204azBOdFI4?=
 =?utf-8?B?djR4cXdpeFVLYkVHVWdFZ2FSd1BYZGIrMFlyVUF0NmFNVmFmcmE3VjIrOG40?=
 =?utf-8?B?YXpzNDcwR2NwS1RZYktwWWpqbDRuMWZVT2VMVHlqUUtKMFd0bEQ4azBSODVB?=
 =?utf-8?B?aEZYS251c3M0OTJSQlJWbXE3V2JoWmNOR01JaFU5MlJrZjcrZHRKeERwNklu?=
 =?utf-8?B?Zy9DaUppZnJ4citTbWdUZ2F4QjBET2ZXR0ZBZWhWS3dZUldtRUh1NjBOQXJF?=
 =?utf-8?B?a2d0K3JuVHIrMHBDdk1WdlFJNHJZdjl6bkdocXU1YXQ4M1FaNXVpSFpKZ0Z1?=
 =?utf-8?B?ZWY1Z1NwMXBxNldhRW1BcWxycEZSeTFxN1dYaFdjRDhBcWtFd05IemtRWk9a?=
 =?utf-8?B?Y1BrQUtwaFNrZk0zeUZLT1E5bmtwU0tSQXlJNVNzS3hIK0VHVzhKRCsrYXdM?=
 =?utf-8?B?eUdaazlwTzFUQ0hIY0lKMy9GYW1OaXZoSjdwRE9BTVdiaVBGM25qRUtKWHRp?=
 =?utf-8?B?UERCamw1L0JTZUc5QzAwQmExZ3A2cnFuYXJVaWVVMC9KSzUyREVRaCtxcXAw?=
 =?utf-8?B?S2Q2UDBzYll4UFZ2MTlCeG5STzJKNGNnZzFzeEIvem1CY2YyZ0lQREJobzB2?=
 =?utf-8?B?UVFvSlpJWWhvY1MyQ3ZYZ2J4RWdLWDZSN01Cc3RCTE9EMnlwL25vaitQZmgz?=
 =?utf-8?B?dGxFeDlVM090VE1PUXlSWkJLbzUwZGIvSHpmajZhZ2dUNlN0RnZUUU56UXBX?=
 =?utf-8?B?bk5tMkVYT3BGSDN5eWtpRDdFUjRoQ2pkTTNVdm5QOEJPOHlxd1lNZkx3M1NH?=
 =?utf-8?B?MlRrK0hscXZ1NEVGczZJSFFQbTVpVTJOMXRJOEN6QXByL1c2RzhBTUhtOVJN?=
 =?utf-8?B?OHFwWVJtZTFvMi8xSkRhQi9BUmNxVG1PS29pbE1EaW13b1dSYVBNYjFQdWlt?=
 =?utf-8?B?aEt6VjN0N0ZDaEhjZytTTUlyRzBpTnorMWxYSW9DTXNNeWQ0SWhzS1p3MXZp?=
 =?utf-8?B?SEZDWGxzYWwvUU8zLytjS2lOQW1hU1RCSTRjSkJ4UE1vdHd4WG1LZi9tS0gv?=
 =?utf-8?B?eFBsODhvd1BsM2o2a2tyYVBraTU4c3lLdlZkZ2Y5ODYzMHVCcnc3dTUza2xZ?=
 =?utf-8?B?QjBXQTk1ZVliQ0tHcUJHWWhSdEJuT3JBSmI1UDBPTUdMNjVlQ0dJdnI0dlFF?=
 =?utf-8?B?WHZaQ3lMaWNYMlZwSkxyZHNteXRwNTZMR0Y2cTdpMHZPVUZGRUkzWDA1K3kz?=
 =?utf-8?B?WENTUWNiVmZJMWtPaHZueFNtRmxFSTNqclllcnVMZVl1VDlpQnNXRjJqbCtv?=
 =?utf-8?B?RUpoaDdGRzI4TlZpY2pGZjF1U1hKREdtNHpqa3pkOVhjWTBiZFd0WjlUWmxu?=
 =?utf-8?B?WTVTOHdFbFVmajBaMXZHUnFxZEpLQ2kxZDJVaVArbk8vVDJJY1YwSGVXQzVO?=
 =?utf-8?Q?guIAv1+057CDHATSnA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR08MB10236.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6575
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f50a3708-a11d-4b1e-a397-08dc86c04e85
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|35042699013|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEVVYjhTLzVqL2hkemVSQ1BUY1g2S1hyOWNtY0dwYjFBd2hZVzlFcE9QaHpo?=
 =?utf-8?B?eHV6bWs5amM3VWdNd1RqSlVheFpER0JrTE0rUi80N2Z0dU1mSmZlekVMNG54?=
 =?utf-8?B?T2c2dTJsUnhBcHR0cmRLeFhBVi9iWDRVbktHMitXVTlGV2xKM2Jpa21MOUpJ?=
 =?utf-8?B?ZHV4VFZKaHpWMlhTM3dNK3JBaFpsYmtOSXJ0cmJtYmUxbUJPVXQ2b0owOHkv?=
 =?utf-8?B?ZHZhMlo0WWpXUXZNTGluVFFncDBsdEVzaU9JZWtkeDF6Ny9kQnZmYVlFRFFC?=
 =?utf-8?B?R2FDSmp3OEtOL0pkWHNKcjdmUzBOWm1oSGhEQWdZS3UxUndDQnUwWlp5NlNK?=
 =?utf-8?B?b0k4aU94cFFLYm10TXROMDNkZnRiaU5kQnNpazRpVkFkY29NUjFBSmJ6aitW?=
 =?utf-8?B?aEhvTEJvOGJoalNTNnJBZGd1V2RWRmpkcXRDRGx1Ykk5eDJXVlFtU0N3V01i?=
 =?utf-8?B?TlNId2V6MVhmUWJ3QVhIY1lQSy9lelBCRi95VWZEckt5TUhOSVZIbnJGVE5I?=
 =?utf-8?B?WHhaOFNDSkJTRC80eExNdDc3ZmljVHo2UWM2cys1RlBVbVZLMFRQd1g3ZlNt?=
 =?utf-8?B?V29ENEh2MmlSRVRxMnBSTm9pNTVZQVhTM21yL3I4QkdXZ3gybmZTNWpxQy9Y?=
 =?utf-8?B?MUVMQ2dmaU9TbktrMDM0NGZpT3F6dHRETlI3VDFkVVc5akJ0VU5oemhzOC9i?=
 =?utf-8?B?L3AzbVQvTEFMSWQ1cTNjU2wxTHpVT0ZsdnFXVFdvY1poWVN1SlZuK21Sa09Q?=
 =?utf-8?B?bG1ZMnhnYmVrZWpIYzZrZnMyWkFtQndpZ1FHQ1lnbXVyYWJsZDFlcHRGSTdj?=
 =?utf-8?B?cjcxOTcwd1lTempPYXM5dVhLVWVHaEhFRjExY0dINTJ1SnFDU1BiRzg4elRH?=
 =?utf-8?B?S1pqY3RiRzVKWVdEMTVlZS9zN3l4YVEycHFmNWh1a3R5aE9ZK21CQjlvK2JU?=
 =?utf-8?B?V3FMVU9pNXh4aFBaY0haUzhkczhMdjR6TEdrNkNjdFYzQ096dDNIN0FkY2Ra?=
 =?utf-8?B?WWRlUm5NZjkzcUNoVjJxYnFzeTM2UzF2bm1ZYWxzNEgxR3pvU3IxeENZNTQy?=
 =?utf-8?B?eXRxdmlPamFWbXlQMjJGZjNlWVFHVTBSQnp4RDhSSHl3bng4akFmeFMyemRv?=
 =?utf-8?B?cUpFNnN5cUtIYmR5MUg4dis3SUZuYVlXc0t0WGhWc2NyVlRJdGNHenVIMmNP?=
 =?utf-8?B?bExNeDRkQkVNRVJ2TnRaRUk4OVRDTE50eU5CcUgzeStrMjVqaEpxL0FuWU9B?=
 =?utf-8?B?dmUyNTc0eDJ2TExyUVB3Z2hoSW5taWEwL2QvVzVJMXdaQVdXWThncGxZWGZR?=
 =?utf-8?B?NVZzOERvYVM3djBPOWZBbyt5Z29YRkpRdkVLbHBxVVdKd1FwQmx0dVdBMG9v?=
 =?utf-8?B?N2RSbkx2Q3kzQlV4QzNxazM2VVgvWVdiRFhRTXoyVWFLc2YzTlo3T2JRemU1?=
 =?utf-8?B?V0YybmV0Q3dLSDVMcGRvZDlnbGZublN1Zk9YM2JNK1VsUVdnSGRxQ25rTU1m?=
 =?utf-8?B?TERLVUlOSkRnc0cxWW1FOVdGUjMvaXkzbWtHZEFMNG50WmZoay9nVmVIVlRh?=
 =?utf-8?B?YTkxcGVOSEppbDdXa1pnYTFlWmtjS1dWbDdLWkFGL1lmUlZ4QUNoV1N3Mnlh?=
 =?utf-8?B?U1N6Ris4aW9lS0tNSzJyM1NzNGExaDZhRzFsQ0pVSXBzTnFZZE5xY1M5Nm5o?=
 =?utf-8?B?WkhkWWxkL1hOWHdpRW9lNlB3b3VRV1ZxZlJSdElWUjM2Z080Uitob2M1Q0dE?=
 =?utf-8?B?eUg3K1hHUE1CcldQVzQvVkpqZWw2TFdrd0k2TXhlei94TkZPQUx6TkYybU5J?=
 =?utf-8?B?T3RqZVFVdzZhNHV2VVYxQUcxai9oaXpDbXAzZkJUcHgwUzZuWndoR1ZJZFZD?=
 =?utf-8?B?eSttZnMwVG5ZTXJTVFhnN0c5NHFMZCtZaWFMdVhhRGxlTnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(35042699013)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:06:18.2845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e07d203-781c-4708-2045-08dc86c05420
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9989



On 5/29/2024 3:18 AM, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> This series adds support for the Management Control Transport Protocol (MCTP)
> over the Platform Communication Channel (PCC) mechanism.
> 
> MCTP defines a communication model intended to
> facilitate communication between Management controllers
> and other management controllers, and between Management
> controllers and management devices
> 
> PCC is a mechanism for communication between components within
> the  Platform.  It is a composed of shared memory regions,
> interrupt registers, and status registers.
> 
> The MCTP over PCC driver makes use of two PCC channels. For
> sending messages, it uses a Type 3 channel, and for receiving
> messages it uses the paired Type 4 channel.  The device
> and corresponding channels are specified via ACPI.
> 
> Changes in V2
> 
> - All Variable Declarations are in reverse Xmass Tree Format
> - All Checkpatch Warnings Are Fixed
> - Removed Dead code
> - Added packet tx/rx stats
> - Removed network physical address.  This is still in
>    disucssion in the spec, and will be added once there
>    is consensus. The protocol can be used with out it.
>    This also lead to the removal of the Big Endian
>    conversions.
> - Avoided using non volatile pointers in copy to and from io space
> - Reorderd the patches to put the ACK check for the PCC Mailbox
>    as a pre-requisite.  The corresponding change for the MCTP
>    driver has been inlined in the main patch.
> - Replaced magic numbers with constants, fixed typos, and other
>    minor changes from code review.
> 
> Code Review Change not made
> 
> - Did not change the module init unload function to use the
>    ACPI equivalent as they do not remove all devices prior
>    to unload, leading to dangling references and seg faults.
> 
> Adam Young (3):
>    mctp pcc: Check before sending MCTP PCC response ACK
>    mctp pcc: Allow PCC Data Type in MCTP resource.
>    mctp pcc: Implement MCTP over PCC Transport
> 
>   drivers/acpi/acpica/rsaddr.c |   2 +-
>   drivers/mailbox/pcc.c        |   5 +-
>   drivers/net/mctp/Kconfig     |  13 ++
>   drivers/net/mctp/Makefile    |   1 +
>   drivers/net/mctp/mctp-pcc.c  | 361 +++++++++++++++++++++++++++++++++++
>   include/acpi/pcc.h           |   1 +
>   6 files changed, 381 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
> 

Tested OK on Arm FVP.

Tested-by: John Chung <john.chung@arm.com>

