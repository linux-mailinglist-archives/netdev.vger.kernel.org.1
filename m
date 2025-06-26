Return-Path: <netdev+bounces-201499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF7AE9902
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9DC16698E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD745295516;
	Thu, 26 Jun 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTwC8tHq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E2218AB0;
	Thu, 26 Jun 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927932; cv=fail; b=HtABZu3K6wD0iHZn1zFnmwCiMPFdftFddRcLiEXKbyxZ0+/dP2mvcKTjdA0MeX9Ey9ZFDMgKKEiuqxBMHhq9t2YkyvsmEUaibafwtR/ExtEUcr68wnWcZyzvG/Dn70sKGM+7NxcQmg/ywHlji4JjhfT+a9wnYtqGcYOGEawQ0cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927932; c=relaxed/simple;
	bh=EqxUo8o7eACVgAEfPHgZLAOoSOmJYZyAjEyWuOgGa7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQdSS1X3CQoHsA1pXQhjOvbdo7htnlavyvKLqjYGRVv7gXx7y2ttcej8/0kvDunO/663unQV4Lw3SGL6lvB7Xuh2Y5HqVb5R/IzxJ766lCbON5GXtVsSphFA5V+I3eQQ7sokNhzRQi7Vhrqv9bOtOURZVr3jmaJa/8OJlLRGJYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTwC8tHq; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq5H9UuNr5Vb5T90a3OmV7BYJWb8vO9HE6+kQwBvSu+7UVcCYM3KB7XVMggdJM/6YOGDSA0sF7ID19Q8c2+ZIBYE5fE5KM1oqIgJMYx++FR6iSb1S4ySHZpUK9hRXiLHivdcAeE9M+5EmjK2SCBF0GYGb47QR8qYgcqH3WzT1ZUfkrnosKTQJZV/lsBxGWx+82m1Z7f2CT4IVpX3ikpQyezf8NkSrVdS5aoZUd0tj7ReZLkzRw67RTJl74qpwDyger+K8CAcFrsQn8zltwEJbUZgDwNUDPPkNw1g6nNiRnyRkbmodhBRO8NC8jqTfw2571qwSgsNMfwK1cIA0SY0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFbYm35WwxY2P7N87jRqU9IMZCIsOCnlUi4UL6xR05c=;
 b=zGx67JP6hI4CAsFK0J52PKleSy4TcUaBgJdvZN+XQW/8mLDqOpin9qL21r8RdEpBGTgPsCWfOiamyr8yH3zW6gHH6zPk6hMXdyXksFZ5u9DEwndcSJbonB59V1Ep8kL/Bx4d/PSjVW+vSGsELui8TCloNPhq0VYvnT1MsurbRCwhua0QVmTPG4pmkFf2AxgzHXUlngzapt+DK0JSaOgAc6skAW4XLUWdFoW3OKxmZu11cPMfiTzmHU2Biy+68zZWSADRPNkgS07GJCldnvgKONe7uSuP+2Z4jk+3HAjZOPSFaRI3riS+oPPUXUzetvd19aTEurFKpMXGNWe6o9ATXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFbYm35WwxY2P7N87jRqU9IMZCIsOCnlUi4UL6xR05c=;
 b=CTwC8tHqLwWf/Ll7QHwbW/NQc10W0M0vdCuy7Ws/sfSqRX0xaqqFckJMr5cjq7SMSmB7GntzEV0kynpbs1RKMNHHx5yAXHnTOaAYvgYWfWEB6QXU9xQooLRZOhiivL0UDXo1GAQ/NLzxGvHymVsyCYfHDkT144l0rZycSa1406AF1hXFtUnNNto7TbPTTZvivjuGoMtKr7ocuu3hU0N5/e6zTVY317WmYdPdJ3NtrrbgUEAQSMhC+QzDvkWaR09dph3Lr8Na+kH12N1K5K/8abhaYa1mRsL6L8vxi5stb49qa3fUbCV1Tad3Tc7A7xpHKy6uZkQRqMHBJG1SkgRmiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 08:52:08 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:52:07 +0000
Message-ID: <f7ea5d79-4aff-4d8a-a966-5d77e2c60b51@nvidia.com>
Date: Thu, 26 Jun 2025 09:52:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>, Thierry Reding <treding@nvidia.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
 <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
 <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
 <b54afc33-5863-4c8b-8d6d-24b4447631e1@nvidia.com>
 <4861a4cb-d653-4c5d-8d96-c7acac501004@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <4861a4cb-d653-4c5d-8d96-c7acac501004@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: d9159ef8-6123-4605-f743-08ddb48ebb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhadFBoT2svMjkxbmpPUlZySmIvQVI4T216bmJWVDdVZEp6WTd2QUpIRmhF?=
 =?utf-8?B?V1FiY0lacmxZcWxwODdLTlcvRVJHQ2UrZjJ4UEtSN0xqSDFSc3BpQmlUc1Jj?=
 =?utf-8?B?bWl2RSthVXhPVTJsb3hiTkZlMjdZbmhLYk4vN2U3d0hBcEhSUGNtcHZ5cTNq?=
 =?utf-8?B?UTRxRXhncllHaE1OSlp4bDBXL29EbzBtcVNxZUZVME5idk9wbVl1OXJaeVIw?=
 =?utf-8?B?ejA0MkZ2QkJWZnJkSWRUTFZqOVdzVXd0cldUTUpKbzJrdTdlNmdwaVRsNjAw?=
 =?utf-8?B?aG1kcDlEdk94SXZYZmprdkVHK0ZIN1JzVVJzbVBOdEpnaTR3L2tlaktJcis2?=
 =?utf-8?B?dUxJRHRHY0F6OUdJNVh5bGdKREZnVm82aWVwbnFNNEhCN3p2UjgzWWorSHps?=
 =?utf-8?B?cFpIOWVUUGgvOUszUm5ueVN5QktvMW94dTlmZ3lZdGhLZEV2cjhCTFJ1cTNK?=
 =?utf-8?B?aTk2SElWNGlwZS9najlFVGE0MEN4YmV5YXdKcEpMMVBQeFNmWGt4NHpRZTR4?=
 =?utf-8?B?dGF3RDlULzJvYW0wQ2dRWmhvMlNObzVONFV6MzRHZTcwV1F4QS9lbkZZWmha?=
 =?utf-8?B?MHZDam82NWhCVWUwWjdZdFI0bVMvNkQwSlg3cktuRGh1OE9IYVFDclRQWkVW?=
 =?utf-8?B?UmFJRHZnc3cvbEpTVjd4aThTMHlQTjl1ZlptT1phWEpvbXY2c3dxeTB3b0k0?=
 =?utf-8?B?c2RqRjJkdjBWdVJORUUwSjZvQS9VUmF4dlRLR2h3ZFJ1UVJiSTRqQ3NIQ0wx?=
 =?utf-8?B?cmMxNy9Da1V1MjNLTGlGcnJaYmtWMUIxTkJMYlkvd1lrM25xUTRGR1hjRVRl?=
 =?utf-8?B?VFRVTVhsRTBWRUZnQlpKVUk0eFZrS3REM2RsR2E1dzNabGFOd3c5RmFSeDk5?=
 =?utf-8?B?cmErVmpQN3hmUHlxZldTZzUxcnVFeFVlbU92d29SOTdoMFE5YysxZUtucHdO?=
 =?utf-8?B?NDV6OE8wT1VOS0xsaFlySmJCR29QTlFvbG9LcG5LZUpGNnJYdThUMUV1d1VM?=
 =?utf-8?B?MEZlMFZmMFVxRGdMVklJcTJFV2QxM3BERXk2MURzd0tRWVNRZG5QQ3FEaUpF?=
 =?utf-8?B?anZyNHFLUEpqSFFmWnk1SDB2YUo4UGtTMkdmVHlPL2hNbFhhQytTZmVkSzJY?=
 =?utf-8?B?Y3E2VENuT3JZOXp6TVBPeXkxSjdmWWs3bFFyTG1lcGpvNjlWdCtYUGd6dVVy?=
 =?utf-8?B?RHM1cXk2L0JiU3RqcytlaXVuRDBhWCtTMFYybFY0d3B2cW5FMWYwQ2JYMDdH?=
 =?utf-8?B?N2VHbDhlU1ZvUDU4MjlEbXhvdG9oTmRsVTNGcWFiNUFsZnRLb2xxNjM0WGZl?=
 =?utf-8?B?azVxbTJmMjAwY0VRWGcxM2N4dloxZ3V6c2VsTVIvNGFPUGdmWWR0QlhxakVY?=
 =?utf-8?B?QWdzaHlrWDdoaGFtMWx6N2pTaDZXMjZ3amlLdmlGSnc4ZHBwbUVlU2pibFdu?=
 =?utf-8?B?NkNzc29oS2dCOWd6SXMxNEh1ZEFEM05CTWc4aFZadmoreGU2TEdWVHlVbXpW?=
 =?utf-8?B?aVYxVXZ2eUF4QUs3SHBsei9lR003ekhLQ3Q4UDhKQ3NrV3pjVVFHS0MwZmRT?=
 =?utf-8?B?VG91T3BDK1EzYUJ0QkJPNzZZaTRCRmxQL1dQdG5xVE5IMHhsQllrZTdsOUh4?=
 =?utf-8?B?QUVRVW1LSHpkNEVIWnVvUjE0dDUyejlBbkFyMXhSd3dIOG53eFZuQlFEY0JM?=
 =?utf-8?B?WHBNSzFXQW14eGltYmtLN01kVC8zdmFlS2hsTU1CNkptMjFTK0pZZnNNOUZT?=
 =?utf-8?B?ZXliMWdUaFkrYUl6Um9RY1ZVa3d4NFhiVFRlMGJUY3BSaVdnU0ZSdXF2bDg4?=
 =?utf-8?B?WVJldkQ1Yll0L015WFV5M3NTa1VUOU9zVHBFZ0JrM3p5UXZVd0xZYVZjYXFL?=
 =?utf-8?B?NkhXdTV5MXN5VEpsZVZ3c1hqSEx1RFJiTXU2UmRTUFNzTk5sRzU5L2xYSGRq?=
 =?utf-8?Q?H+Yl4lNFv8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGZ0RU5RcXdITzZQNHFKMmhyUUlJbG52M1dndjhJcnZiVTdOOGNuelNremZD?=
 =?utf-8?B?Y0F4SjZxT1VIT1haeUNERFN2WUZTcHZ1Skt1UmxBQ1FiTWszZ2dQRURLZWI3?=
 =?utf-8?B?SXFscTNTcDNHVk5xdzRzdWNpcS9QZGx2UWlvYzdMOTBDVlE1NmRlOEcwOWc1?=
 =?utf-8?B?NzF1VjdHcHhNTGFVbHozc0RaTXFQTFZXbmYxeWsvYWRKYmVlUUkwUm95dUk1?=
 =?utf-8?B?U296QXZ2RHBvVE9VMjAwMUJ2L2lvcW1sdCtPZ1Rvb1RoeTVhcjVhTFNsZUFj?=
 =?utf-8?B?emRKRVRFQmxsNm9SWENqMGxWSzNlbmQvTXMxalFteTJXSFlZMmNNalhQYXB6?=
 =?utf-8?B?TGxEMDJ3dkRVbGNPQUlvSjVrWG9FUlNrcC93N2VOajdMM3JRNzlNMkx1Zkd6?=
 =?utf-8?B?bHR6U3gyandNME1KM0NVODFYWTNRQkI1bGQ0Y1JGVGYybTdWMk11cjhFeHdG?=
 =?utf-8?B?NEozNndHclhCMDdEQXlub2tOd0xaazY2eFJncnlMck13ZThBZ002ZmNnZkJM?=
 =?utf-8?B?TXVUNWEzYUNSclA4ckJuNFN4YU82QXJFd05vTGhqV1NIU3gzZjZ3REkxNGZK?=
 =?utf-8?B?V3RqdnpJNFVhclZPcXFSaDFJd1VkVC9jeTFJM3BxV2krck10QmJyNGNIbGxZ?=
 =?utf-8?B?VjFLZ0M3M1gzQ3Q0UEtVQnMzbDJ3Tk1LU1VpY1I4OXYrWnV6QkMyRHA4N2h6?=
 =?utf-8?B?NDY4SDRtMEhieFFPOGhFVkEzR3JOaitIWmloM1daWmFlbEhwVFVFcDFhL09Y?=
 =?utf-8?B?TU8xcmNDeVJVdnk3RFZOa3lyU3F3azVwQ2hXVm9QdEVIWHQ1RldkRFoxQ1dO?=
 =?utf-8?B?VWg4TThqQnF4ZFJ2Uk1JNDZ5L1RqRDhBRnZKOE9kUVZpdFZoc2g4S3p4T1Bw?=
 =?utf-8?B?OXg4SUF2ODRHSFN2Zi9qbDd3b0V1cDBqdWRLdS8xR1pEa21WeXRLUXFHREpp?=
 =?utf-8?B?YmJQK05JNXlkTVVTREl5NjVCRjlQKzVYQTRYRXJVaXNZb3JtakRvdFVjcXBx?=
 =?utf-8?B?TFVoT0NmYUJUcEFWY0cvbk0zWmxob1V3NWNkcWlxdU5YWnV1WXdYd0FHTXBG?=
 =?utf-8?B?cWt6aXRjbzMvRjNUUzZqNDhtaThSbzlnKzBTN05rRDYrbE1vdWxEcm1LSjY0?=
 =?utf-8?B?MXR4dlBqS2xJU3lZL3hIQUhlWTJ6enozWEZPd29JTVd2NjBDVm0rSExvNUNa?=
 =?utf-8?B?c052RVVHa3JmRURBQ1RGTUZxL0VzOEQvL2o0Z09COWpNKzF1MjBNTXpIMXlB?=
 =?utf-8?B?TVZrcVJsU1R1UGF4RGxzNFV1a3NhNm0vRFAzWXVySG9BR1pSY0JBSFFTdzVJ?=
 =?utf-8?B?VS85blFjOEVEM3E1VVRGWWl5UVRCbG1ySmsyejNVeHRzTmdhazhZSGlxWHFD?=
 =?utf-8?B?STcrTXUzSXVuWVE1dHJqMVNTQ1JlN0dzRWk2dG5vUEZzTmNIV1lVdDlmRUdF?=
 =?utf-8?B?WXlTVCtsVnpGNjlLTFBjeWx5bHRPcHBMNDdWdHRpT1VmSGs0VW9oZENVS2FL?=
 =?utf-8?B?M3dyRktlMGJGbThCNEVCR25jWTZyY1UwdU1FcXkwYTJRZ0lpVnZ4dUIrMWtQ?=
 =?utf-8?B?RDZxeW55OGlYdm1kMkFYdHV6Nmp0WVRiS01ZWUc5YVgwaER3SVdSQWlSN2Va?=
 =?utf-8?B?NG04UWJ4RTlZSDF5Ym5IYWdXbWo4SnVEVFVRQXZFZU9kTlpRaGdyNUIwWjlO?=
 =?utf-8?B?WFFJc0xlUVJBOWlBRkxWMW8vSnFZOE9KaC9XTmgxQ2c1ODlHMzk0djlGRnNz?=
 =?utf-8?B?dWt2bkVKNjZMMWQ3RkwvRjVCQlZ0VzQrVG5iTXNEdllWdHZtRWpaNU9nWkZ0?=
 =?utf-8?B?eVhnS3BETjJoSjJUcTJDM24yQ3FmVXZ4dU92L1NMcDlvelI4YjVwQ3owWnU2?=
 =?utf-8?B?ODdWc2tvU2NndlA3a0ZOcHZGRE5uU1RHanFyOElydElnSG5FUnlWRVR2UVht?=
 =?utf-8?B?bWloYnhMbU93MHJQRmdyVFF0RVNvbC9EbCt6bnlZM2Z2d3IrMFUvcjlrcmJI?=
 =?utf-8?B?WHdYOG1rMDRKMzFGVkZpdU1nakZyZjJKb2t1ZURkNmxLNlhsWlhRZjNDd0o0?=
 =?utf-8?B?OGVUQTUvdjRvVmYvbkYrMHJzWGhxTUxsdmlZazdBZERNWWxPRkJYaG5QK3Bm?=
 =?utf-8?Q?fo8F84g/YF/LQDRoEv0GZmsuw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9159ef8-6123-4605-f743-08ddb48ebb45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:52:07.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vofM+TI23k44AukPbpfy5bgCI4XJX6JzSbYDYg5nOdJHbqFEWpCfGxYf6Lyj8Z5r7jGgYYdsgwIHFjst2GRnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763


On 25/06/2025 17:24, Andrew Lunn wrote:
>>> Now, lets consider the case some devices do actually work. How are
>>> they working? Must it be the fallback? The ptp-ref clock is actually
>>> turned on, and if the ptp-ref clock and the main clock tick at the
>>> same rate, ptp would work. I _guess_, if the main clock and the
>>> ptp-ref clock tick at different rates, you get something from the ptp
>>> hardware, but it probably does not get sync with a grand master, or if
>>> it does, the jitter is high etc. So in effect it is still broken.
>>>
>>> Can somebody with the datasheet actually determine where ptp-ref clock
>>> comes from? Is it just a gated main clock? Is it from a pin?
>>
>> Looking at the datasheet, this is a pin to the controller and sourced from
>> an external clock.
> 
> So the fallback of the main clock is not likely to help, unless by
> chance the external clock and the main clock happen to be the same
> frequency.

Actually the fallback to the main clock is not applicable here for this 
Tegra device because we don't have a clock called 'stmmaceth'. In fact, 
that is something else we should fix because for Tegra234, I see ...

  tegra-mgbe 6800000.ethernet: Cannot get CSR clock

However, this is expected because there is no 'stmmaceth'. The fallback 
to the main clock is only applicable to !snps,dwc-qos-ethernet-4.10 
devices but this should also be applicable to 'nvidia,tegra234-mgbe' as 
well.

>> AFAIK we have never tested PTP with this driver on this device. So the risk
>> of breaking something is low for this device.
> 
> So it seems like the simple fix is to list both ptp-ref and ptp_ref,
> pointing to the same clock, along with a comment explaining why you
> have this odd construction.
> 
> Please could you test that?

I am sure it will work and yes I can test. I am a bit concerned that the 
device-tree maintainers will not want this because strictly device-tree 
should describe the hardware and adding workarounds is not ideal. Don't 
get me wrong this is a massive oversight on our behalf to begin with. 
Ideally we would handle this somewhere in the dwmac-tegra.c driver.

Jon

-- 
nvpublic


