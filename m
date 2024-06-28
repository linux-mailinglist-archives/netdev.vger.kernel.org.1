Return-Path: <netdev+bounces-107784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62691C580
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE151F216B6
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1564CB37;
	Fri, 28 Jun 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="cGE4sm7d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2128.outbound.protection.outlook.com [40.107.96.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87C25634;
	Fri, 28 Jun 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598413; cv=fail; b=VqqVxuKGnh69+y0KiFLhc9VEmj9GAXkWNyexbQSMnXqnMpowOPX26A4tdkcrzDavdFFigFGd+0lWBVCPGCC9E0q7uB3qbTXfL6cjJt+CjKUboW05ijO3QfoTXoEKHrr0XBIAQwLW36ox1NSuva0MGLw5p5+Aw7v/+nbdCnXhzec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598413; c=relaxed/simple;
	bh=pATul0eRKRc/0kSJNfT1QvuJJP1sHV3/vQJ5qKiZ2zU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuLsFjxudtCqqK1bx754esxoloutbYJe209a6KtnyWuXtYc3vsb42GvNMSLEO9D1rHMHxmq3dQ8CRqJIjOiBFOLtY9XDVKrbNabhZhsbsmTADiaU/df/4twSkGYzRjVJslQ5aIwf/GIvRIZ0Tun6j4Do/C9Nxh6d5g+shj6HKpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=cGE4sm7d reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.96.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIXmBL3FaP84s7gThmXzvpDe0kE+etwZm07gwrBZH5v9Ej8bgR50zWyecys+cTNcVwoLFvGRMd4xaXqTzZmI2W8AuREfmZNZJdHQDxz4TqgiMd8byIr6t8qJRA6/ssV+nL/1bjy9BBPCO2x1XkEX/VPTCjUIdxIZZOTYOMpj7VZtL9fYYmwOmwGx31q8F/Dr7xjl8h3JhRnC9mf+iV6HaCtPyXhZ+FqgYE6s9mnbEZEB6ns13JPIPyvlsYjQ94UYytIAtDqGa9QJKuBCKOtIyfXeIULs0L+OZPYdS2vpBB1tFJu4xjk/S4l5T3mBzLmcoZsOJr6Q4eBozBJbz9OFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh91Rk7YteccUV/IcbOhhQamQorK4aZXycSs0H258Zc=;
 b=VVx8GU6v2rwLni7hLkE7R5cWhf0o0dObk3LGIihBVQLv9E2TLO/OCiaDK8rPG2DsGOHeFyWjaQbeq+8zvV+08mSc+nCSM1QCUWUS8+FyZ9XJJvKBx09Erb+LZoqEECiVM1wf5ka74ea5kbumlXGbKQ6apRDEaKOSUGDEL7tNxxLeUA83F1pg0B1FfRWaBurxr2wQZPRYm/Qatj7VBDhj8W5axxxiioW9Jok6DUW06GcjDEo1gOz8CE1rAs9cLJEpv9nh9X2ACUNHsZwwI7eyu1/olveK/hbNlqIfQBI0Ui9vB+3edfukO1p6j8GioMJaq82GgjED4KYsrXDfJ+G4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh91Rk7YteccUV/IcbOhhQamQorK4aZXycSs0H258Zc=;
 b=cGE4sm7dP0cbkThGOFRSpEfmcAyxkarMyNpgMKM5xeLIksYAMcguwNrdqeK9PVjkhrJPRgnmkuKd32PtlWEJ+v9uJSBGO/CyKb/K7qm24swTonZOJKYhp3jmLly0s6UrfX4/Fha1nF59emge47hb+qR4qXRFwnX/QnMaWw/oCoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW6PR01MB8272.prod.exchangelabs.com (2603:10b6:303:249::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Fri, 28 Jun 2024 18:13:26 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 18:13:26 +0000
Message-ID: <cda3dac1-3ad4-4c52-8b07-15a1f8b002fc@amperemail.onmicrosoft.com>
Date: Fri, 28 Jun 2024 14:13:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
To: Sudeep Holla <sudeep.holla@arm.com>, admiyo@os.amperecomputing.com,
 lihuisong@huawei.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
 <20240625185333.23211-2-admiyo@os.amperecomputing.com>
 <ZnwJH5lJpefkzaWg@bogus>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <ZnwJH5lJpefkzaWg@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW6PR01MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a199cce-aaa3-404b-8aa9-08dc979e0140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGhjNjFmZXVvQmFaRW9ObjRkQm5WcGdDU1hRb1JYTXVhUHUvK0phWlljK0dk?=
 =?utf-8?B?by80Y1k0TFJNZ0haOVVYOEFRd3BPV2VBMU95cWZ5TFNHekNXWlhhYVBDenJY?=
 =?utf-8?B?YXhWWVdUd09KbTFTQlp3d3lRZ1FtaTRLREwrSVBDbHFMRGU4ajNIU0huV0E2?=
 =?utf-8?B?a1Vja0Q5Um1GQVR6b0JpMFUxRWhEMnB4dExCbUt6ZzN3WmNmSk5LcGxvNnlV?=
 =?utf-8?B?TTVhVHlPWk5XbjgzR1dWMEozcGRKbWFUWE9SK3IrRVo5T2JJWk40UWRzWVc1?=
 =?utf-8?B?d3FxV1FOU3N3NUx3SVEzaDBaSlkxcG5lRlNBclo3NFArbE56c29uMWhFazFk?=
 =?utf-8?B?bXF3dHVuMjhSVDY2UE1sOWRwTFAwd0kycTYrNERiTWU4Z00wNUg5aTdjZ29M?=
 =?utf-8?B?UURXa1NkTWVIQTduMk5IblNObldSY2V3M3hmYUJOWlM3QStuWTg4a0ZiRXNl?=
 =?utf-8?B?ZDdGVGsyRExjVGVUUFN5VDY1NDhhRTVsTEVEQ2NwVGFwZEhKbVNnbkhXR1NO?=
 =?utf-8?B?MVg5K0lsdHI4d01DbyttUGFoZmJkYTJJU1VsN0ZMRnV6VHpUWjlrSXd0NEFq?=
 =?utf-8?B?OWd1WkVqeXlWUm1tZDdIWlRuWVliVjFBQmpPWFNacjZIUC9vWVhZTVZqSTZ6?=
 =?utf-8?B?eWFsNVZhSVoxVWxCOHhqc1VXMXBQQU53eElDWVFNOGg4b0NES1BBd2g2QUUw?=
 =?utf-8?B?ektBMHdRTzVBdTA4cVBNQm9oaHcrZ29Vd2dzcTJzQ0dSVHBPNG15NytKTmhS?=
 =?utf-8?B?aWVrNTBQUUVyYVNBVEQ1OHpzNUVScEkycVV1WlVQMnNpb1prV0IvWlR3dWZV?=
 =?utf-8?B?cjFQVVFZM1BadytSR3d1UjRRanlKRFM4WWVEVVdLeGJxQm1MMk9rTkRmV05P?=
 =?utf-8?B?c2wrWG9sclFFKzVPQ3EzQjNFMHdua0QwV3B0eUliUTY4TzJOZXlNYmUzSTRj?=
 =?utf-8?B?T040RkpqbjBQMm52Z0s1cktSRW5lNGRaRytzZ0hwYmN0clMzRGNqQncvZWp1?=
 =?utf-8?B?TDlVZ29xb1I5L21XeDU0K2dxK1lOeTJvS3FPdGpHaG9WSHlHbGNEL3VlM2M5?=
 =?utf-8?B?NXFrTUZySXVnQzM3OW9ockFkb0RxUjFlWUZUV1pDU0hrRXUxd3EvbW11OEoz?=
 =?utf-8?B?S3JHbFNGYWZiS3V0aDlnbFJDZlhNclNWcis1cytLeWN4Q0cvRTNKeEFmVjNX?=
 =?utf-8?B?TzRxY25hNEJUd05PRnIzUm9nbWFTeEZKSStseTdTakpIRnpWaEpHUE9ET3JD?=
 =?utf-8?B?ZlU1NFduMWwzMkJEUXRIamY0MmFKeCs4UGVLd3h5Wko2U1hQemM5ZDFvT2FP?=
 =?utf-8?B?MlY5NUNVQ2JpRFR6SVFyMUk3VE9lVXhFUHpoTkxMTnlMTnBSNTNqNk9qYlVi?=
 =?utf-8?B?a2Y1NGFlaktiUXJwbmREN0ZNS0wxV2F5RnVXODVPZ2w2NnJWNER1dldPQUFX?=
 =?utf-8?B?S1hGNUV0Z1pjWkFYa1RXUGVZMWo3ZFozZ0lQQVRCR3lwOWkrOTJiaC9LVzVz?=
 =?utf-8?B?UUJ0aXlzVE5FdTg5UFpoR3A5eGpuY2c3NlpwQ0g2RjhlMGhKRms0STJBK2x3?=
 =?utf-8?B?c2Z6ZTFqZFYyZEVuaVJsRmhKa1BXdnV6RXdEYnZSQ1lIZklxK055dG1rcXpp?=
 =?utf-8?B?U1VCWXBjckhvTHdkSFZZZlpsdUN2WFdVQ1pYZEZBRFpBd2dUM2JQN3ljc2Zp?=
 =?utf-8?B?dkJac3B4Qy9hZmZYeVE1UjgyM2tzSm1nY0ZDc3BvcHFrbzQ4dnF4TlJickl4?=
 =?utf-8?B?TGhwWTd3WEcxeHJpYVpIajIraDlXWkMzUmUyMDhZSWtEbUREdC9Bd0lQdmFM?=
 =?utf-8?B?dE1TYkVvN09BZEdleUh1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlE2cERlMlpFeDc4M0dpRWF6VnFsMW9SUUFZajFKcG9qVkRIYkFWaFhPa2RB?=
 =?utf-8?B?dGViL2NtWUhBUE9ycmdFNWFXQmpzWGlQamxRdWFHdnR1NVBpY2pWeXQ5R2NN?=
 =?utf-8?B?NXl3Rks0MGdJOUF0S0lUdmFXOWs1MnM4N1QyNEFTUnlxSUJ0ZUxSV215bTdQ?=
 =?utf-8?B?KzA5aVpIRmU4blRYdjVhVTZGU3BvRUxPMjU5SUd0WWhHcGhwam9MODE4MjNw?=
 =?utf-8?B?UWhBWG1qYmRhaWpWQVZGUURnaldQQ0N1VkNXUktlZDRrNkNiTG4zbThuTnZF?=
 =?utf-8?B?VzBoQlgwTjhTZWFGWXVQTkdJQUVFU1czYUpOdWl6QytBV0dHWERNTjJHSVRq?=
 =?utf-8?B?ak9ITDFWRXZuOXRlcldqSUpPSWxHNFR4R1NrRjNnZWt3NG9LeXgrVTJrejY5?=
 =?utf-8?B?M1VRRmFaMlJDeUxPTHMxQ1JWNVZtNUs1V29sSHVXTktURVF6YW9ETkw4VzZh?=
 =?utf-8?B?TmROVkdmcDR0eFRBRVJna1UvZXAxaU5zMUVrSlhXUC9zOWhwSzQ3M1cyd3dw?=
 =?utf-8?B?RlExYXJuVmVvMEh2K2RKc0dMQkY3endkZDV6SkJZaDk5MVllQW5XLzRrZGJy?=
 =?utf-8?B?KzhJQzNaRmQvbE02MXNzUjJFVkVhbm5JVFZNdzF3OFQrVEh5SHJJejVIQU9l?=
 =?utf-8?B?eGJydVBQK2t0ZnJxWnkyMm5hU3QzZkV4bjFXUkJwNVRpeXdhZy9YRTNWSUVp?=
 =?utf-8?B?aDViUldpUE53Tm41Sm9XdW5GQVRWVElmbWJhUkdrd2JZRU1kUThFY0xMMG5i?=
 =?utf-8?B?QVRTTmhMcUVwSWNJWHlWdVk0U21rMStvVFhrSGl0cllkK0FDc21KR3h0MDJB?=
 =?utf-8?B?a29aYURqUDU0cnU1U2k2UU1IaVlXb1Y5cnNSYmRwc2pmUXpwdzhvTUg5NGJU?=
 =?utf-8?B?eXhKaXk5dkpubVFsRFFCVStndlFUbU90ZGhLRDZMSDdqU0U1N3dnQ3F3aDZQ?=
 =?utf-8?B?V1JUb2FiZ3JmaDhXZGFiR1I0d1A3cXFMS3N3eGlybUNXOGdtQ1FKMFFnU3Q1?=
 =?utf-8?B?eXIwVXA4RE03K0xKMlRQUFdlam1aZjRYcmNpbFJnMDJ2Q0duNy9wajJOT2th?=
 =?utf-8?B?WEdJbXVvb0x0NDNBbktmWXcxdGZrckVGeGx4RGZSaEdwRjN1TzJzKzIrbkR6?=
 =?utf-8?B?blFob2VzKzRLaGV0Mmpuc1l2cS9JMW1rUHV5ZS9FTkgybUtPVFBVRFRvWnNq?=
 =?utf-8?B?cHVWb2FMQmRlSE5kamV4NEcyVzZ3Q3FPcjR2MEZxSEpZRVdCM3o4cld4bVdS?=
 =?utf-8?B?bi9ZVFRqS0QvYkdibllWYXcxSjRMS2hVVFpUWFZGZDUrZk9OaHplY2lVcmVu?=
 =?utf-8?B?MXBXL2svcURzb2xEVXA1L2toWk5NcC9oOFFJYkZ6bG5mNUdRUThGVW4wZVFs?=
 =?utf-8?B?ZHlBWUhpV3VuRVgvTVZ3U0R2UjVXVTJuNVAvbk5zMFlYVDVBTy9kSXQzaHdm?=
 =?utf-8?B?TVJWeldzUEVsK1U5Z1owMmZtUkRVZkVaUEplMlBDb0gvSGVnbUNUQzdXNGJp?=
 =?utf-8?B?Y0Q1d0J1aGQ0bmZOVVJvU1dpZVd4YnRHUDVEUzA0S1BHQ3I1ei9uNXhkQWRv?=
 =?utf-8?B?L0hNbEhmQkIzandZNUM1c0REY2ltZ1VvVGlkdkQ0My9DajVRaXlUZWN6Nnhw?=
 =?utf-8?B?OS96UExGNnl5Tm0rSTkxR1VFazZYTUFXR3A2SGJYbVUxZEpIbERhNVhUQ2Ny?=
 =?utf-8?B?am1DWWtuVFRlcE5vaEZEVXQ5Q285V1VaMlFma3lEaHJ2MGFOa0k2QWMyYUJ5?=
 =?utf-8?B?SFl0c25kaEE4ZW8zZ3l5N2EveCtIZGhiRDgra1ljWFpQSzNoSG1QcnhzdDBF?=
 =?utf-8?B?SExhV0JiSDJ6MGZiRk1Vb2ZjZ3J2NnZrUFlPOXZNbjdudGlTQWlYY2h6eHZ0?=
 =?utf-8?B?amd3NDhCZHJndW1ya0NRaWxLV3d4VEhSYWdRVjdSZHYwd3UwVytnK0dYdUVK?=
 =?utf-8?B?OGNtRm4yOHVRZUo1ZVBUUzIxMnNVVml1MVkwUGNZV242ZHFVeWo4K3FTalNm?=
 =?utf-8?B?RlVZaXI1T1Z6QUYwckJpSDd5TFYyRlo3Y2s5RVNENjdkTjN0OWFURDRRNElZ?=
 =?utf-8?B?T2xBL3FZbFpIK0paOU8xNExFelExRUlZTUtrWnFsKzh4d0o1MEc2L0VucUxZ?=
 =?utf-8?B?aVRTY3F3N3hMNklCemNxVGZaUC9XUHlnR0JaODhCZGhzV3NsM1A4czZQQWZ5?=
 =?utf-8?B?b1Zqb1ZSN09XTnAxOVNzUGdmOGlQTTRjTFRGZDl0NHNBaWpjTE44OFhVMmJP?=
 =?utf-8?Q?2H6TEL5l19psw0E0fdsmGb4isASoNkQg3feiZ7cBjk=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a199cce-aaa3-404b-8aa9-08dc979e0140
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 18:13:26.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPFpjLM1ZoeN6SxnBCbaE5GlCIG6J6GQw9TUo0s+h6s7hDWWx7+y7FikQ2i40nHJ4TQcDAKu7znwIfEAbi3qM4SgFMJpZiNv/29BulkwQFBdqf2oW871Z0WKHGW0AaAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8272

  Huisong Li you wrote the original patch that I am working around.

What would I break if I disabled the IRQ ACK?  It should not be the 
default behavior as it is an optional feature.

There needs to be a mechanism for the driver to trigger the ACK, but it 
needs to be based on the content of the message buffer.

I was thinking it should be in the return code  of the callback, but 
that breaks all of the other mailbox implementations.

I suspect a better approach would be to provide a function pointer to 
the  driver and let the driver decide whether or not to trigger the ACK.



On 6/26/24 08:27, Sudeep Holla wrote:
> On Tue, Jun 25, 2024 at 02:53:31PM -0400, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@amperecomputing.com>
>>
>> Type 4 PCC channels have an option to send back a response
>> to the platform when they are done processing the request.
>> The flag to indicate whether or not to respond is inside
>> the message body, and thus is not available to the pcc
>> mailbox.  Since only one message can be processed at once per
>> channel, the value of this flag is checked during message processing
>> and passed back via the channels global structure.
>>
>> Ideally, the mailbox callback function would return a value
>> indicating whether the message requires an ACK, but that
>> would be a change to the mailbox API.  That would involve
>> some change to all (about 12) of the mailbox based drivers,
>> and the majority of them would not need to know about the
>> ACK call.
>>
> Next time when you post new series, I prefer to be cc-ed in all the patches.
> So far I ignored v1 and v2 thinking it has landed in my mbox my mistake and
> deleted them. But just checked the series on lore, sorry for that.
>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   drivers/mailbox/pcc.c | 6 +++++-
>>   include/acpi/pcc.h    | 1 +
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 94885e411085..5cf792700d79 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>   	struct pcc_chan_info *pchan;
>>   	struct mbox_chan *chan = p;
>> +	struct pcc_mbox_chan *pmchan;
>>   	u64 val;
>>   	int ret;
>>   
>> @@ -304,6 +305,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>>   		return IRQ_NONE;
>>   
>> +	pmchan = &pchan->chan;
>> +	pmchan->ack_rx = true;  //TODO default to False
> Indeed, default must be false. You need to do this conditionally at runtime
> otherwise I see no need for this patch as it doesn't change anything as it
> stands. It needs to be fixed to get this change merged.
>
> Also we should set any such flag once at the boot, IRQ handler is not
> the right place for sure.
>

