Return-Path: <netdev+bounces-226762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC0BA4D8B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9D517C4EF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA730C62A;
	Fri, 26 Sep 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQHQQ9XW"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF030C63E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910146; cv=fail; b=USvOSw/aFyqaN+aSareCLrrHoa5z8xBHxurUgxqtPIZSa6zo9gZ7Z8fMKkM9vvnMwa6lic8jyNAycAaT9S7OWRmtTazQ0mcTH+l381irn7Dz9axMCT1iBtJLsmO2muh3zE9PJ2eMM15Vuh3q4LpcdWGRTz1By5Wib1I2K7ugjFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910146; c=relaxed/simple;
	bh=FfKDLKbQDvCe/n144WYAo4wTEw3tiwgHNnDxWhS5+3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmYvG4Euq32hWd3+E7rqZTyhQFaXMvAg5+AjSnNeD86OxIHpzFzfm1GNe3bx6lToCU5PgLFVMwa8QTvwAJvghLzoktPu67KuqsnbFH63/5uIR59XAx7y17BiDqO1ELuHdP73ug2PFvbDDr4S5oxqsxIR4FyGzbLSMPd+2B08lRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQHQQ9XW; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjnHgRjdQ5hXTw2ChK+IRUi+yjtgtD4tyA/vh326PvppAgP1aJndK3LuIjT9g6JfCkIx+efSkR6/m3KRJJGC94H+xqoXw4iYHDUvJXvcOnZyhzbQvvpqzY5TRqlg/ZsDSGr3aSogAAVq2dnttD98L5wNmPvDc56j3z48GjNYZ32dypUxrZreb5xuR1K5cbRo8drWengpQ7v+0pqQDms1fzDO+akgdh7XmsMfspVI8E7snBs4jwDwbqzdY2XM4wfi90nRCji8SoXTb0M42YXkoXOPN/6RD0NzbYQ3KqKdGerkZtZ4B69TwtiVS08Mk8NxCNDwtCVGfEaLD8TpiG/dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls+5sxTdiaJX/kbLJg7IgNrAtUu2J7pprN4F7AZOgHk=;
 b=ajUZ8dh40ALZp1/uTGeIMeU6iInj8gDrvZp7nwBC8s9X6xN+XaADNTlgIl2D9WV0wiIOW66hHI3VW89DLahiFlVmC/a1dt6p7b8ru8OwJYIzbS5DGHyxjCMh942zh+KY231dcidDXC78bMuzBJtenr7KeY+BFRdUujWfWjWpghR4RuV9/kPn4yxmrb7OMNuvb3TeeJhXoam2OEaw2o3iL2J9C2ZMaIw2trSBBytLxfKZU+tzFhwrGEre0194iQ5cGBa5oBYZZqh8EYcj9/7pGMETb+jUdlWbG/7ANwry7zRf5YF0K/PSwMY8Ww6ZlaRbeFKDeROmue2XO7egzSPhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls+5sxTdiaJX/kbLJg7IgNrAtUu2J7pprN4F7AZOgHk=;
 b=CQHQQ9XWGIwQHUZyE3E2HCWkhxmdNXuYc3bSa3IaRYU+kOXAggw+ODHXGn8Yn5vvXq2nYnlR3Z6W0RUf/UNR+NGAyQIjG6f/ay8kAMzhJ23ieSqE4z1wgy/FcUG4gHmxAeGZz3oVQmbpkr/BQD+yH5PqX7X0Fb335xnXUawMfLf/sBsvop/9TGpdhitcoGu5NM/cwBc1qYcOvu2YkbCEe6bvOac8FBD9yTD4oM+fN7tNGYDuuOEdTb+i/sO5P+3dw2crGSMYRgvNn/De2mxgmtexmYuGh7NJJJMQQiEXOZ7XC34uML1YHXDYaKAPJH+VH9KthHcCg33DSPRKhVKSjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 18:09:01 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 18:09:01 +0000
Message-ID: <aaa3f215-5f03-4a44-aa2c-ebf8cee36b04@nvidia.com>
Date: Fri, 26 Sep 2025 13:08:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
 <aNa43PNoWKOGSqpT@horms.kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <aNa43PNoWKOGSqpT@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:5:54::46) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 665bbe6e-9041-4776-0c4c-08ddfd27c527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDBjSFNPbStiZWlSNFhOYjg4dVQ1MW5qdk5ZK3BscWZ3ZmlLVXZJLzZ5Q3dK?=
 =?utf-8?B?MUc3b0wyWXB5bEh2QXcxWHNoRDBDUisvVDlTT1hnRjcwczRUVGVIbnE3c25v?=
 =?utf-8?B?anczc1hPc2Y3azZlMjA2OEhrczlpQ0hEeFBUSEV4R0ZqZzg1Nnkya2xlUmFz?=
 =?utf-8?B?VTFqQVN1enBVaUIwSHRtTjBXNkcxWTZCQXMzQTBJdG03Z3RRdUF2ZHZJM1Zu?=
 =?utf-8?B?MlJURzFGNUVETU5oSWFldWR0eFg1UCtMdmRkcEhWV25HT0c1TG1Td2t2TzFp?=
 =?utf-8?B?QmJkWExSdk5UQTNKUXhRek1rZ1NHcGFWd0RzRTVyVnp6blZ1b3ZOcjN6RGZr?=
 =?utf-8?B?MVk5Q29GVHZEWW1WalhkNU05WUxZR1dXSy82UmJMZHhzV0lxRVJoVlI5c1cr?=
 =?utf-8?B?RUFocDNzbW80ODAvRlJGSkM1b0NxMys0enhSK2ZHaUJlZkVOUm9Ra0dQN0ZN?=
 =?utf-8?B?WHV4aGhFa1NoZFlpK2NYV3lLblAyZGhYYW9naC9kMUlzRzd5RElxNFFFWnlL?=
 =?utf-8?B?TENPWEIvUCtRN2N4d09BeHROb3dCOExvekpsMDdtaG1JeXRJV1FMeWpVU0xV?=
 =?utf-8?B?YWMrUW9hdmo0aER0RGZGbU51a0REWEVjdG1vSTFHYWd3Wm1XWTlMUnRZV2FK?=
 =?utf-8?B?b29MUUNoQlFRbmIrS1RmWjREZ3JRUTFCNzZTWWZWK21EQUJscDJneFdPbTkr?=
 =?utf-8?B?RGJLQW5GWTBkTzBCajJ0VDFWQmtpMW1NRXhrcW9YUlhzdWVtbjRrU1ljVzVE?=
 =?utf-8?B?UmJaRlh3Uk1rVEpIV0lGenBJV09VdjEveDI4ZHE2NjJhV3UrTFpDc1l4My9j?=
 =?utf-8?B?dEwvN1FMdkZHbXZmeUhxMkJPMlFhNFhKbFJtK0QvMmtkQm9lYlg2NTVoMktY?=
 =?utf-8?B?SmdKc1R0NmV3bW4xRkkxcXM3L3NSZWxUaThLRVNvbXduM2NyV2tRMkUvOElp?=
 =?utf-8?B?dTBKNFd0cnFjTnJ3M3RDODlGT3QvNTd3a0p3TnhzeGVnTFY1NHZac3JBZXVV?=
 =?utf-8?B?ZldvTWdmdVViWDZYKzEwcjNtR3BaZ0tKSmFIa245Um16WWRJYXYydWo1VHJU?=
 =?utf-8?B?MFYwWnlCN3JuWmhrbW5ScWdKQVNQY3MyaElLMzRwU0Z0OVlkMzEzRFdQcHpY?=
 =?utf-8?B?VEhJNDVqcFBEK2RhSzRyYXJpYXltbkRBaHR3bDA3V2M4bTJzL2I3QXA5K0pS?=
 =?utf-8?B?dXVrb1E3dy9WbzIwK3lkV0VkWWtUMjYyOHpFYUt0UTNROTVGRE45UnVJK0Rl?=
 =?utf-8?B?ajRYSDVJTWZ4YmphY2tvYjhWczBtaXp6V1g2L1ZmVTVjcStHK3lveVlpcCtz?=
 =?utf-8?B?RmZDN0w0Z1R2aDUyOWpjeEpjd2wweDljdGFOem1NTERDYmJ1cWRKU3FmQTNn?=
 =?utf-8?B?Q2hObzlwZ2Nqb0tDYnZUQlhzM2h4SDNDeEhXRDg4T0xGS3BUZmxPejIrUHht?=
 =?utf-8?B?U29YN2w2SXhpMU1oS2d5dWVmUDZ2ajFraE9SS3VZR2w1VDVyQTFqUEs0aVZJ?=
 =?utf-8?B?Mkp4dWlPV0VEc1BVTytDWDhXODFnNVFIQ3NGNzBSUjRkN0NrWnVsL01XMjRB?=
 =?utf-8?B?aXV5M2pKZUVXN2RnU2xycTh4L1B4OVhxMVk5Q2M1MjNCZm9RM1BEM3MxREd2?=
 =?utf-8?B?YVBTWlFPdGw1dUF0WUVZZXVWQ2hyS2crQkFndXNYdmM4Qm9LdVR2SDZNdW5m?=
 =?utf-8?B?NmU3RGJDV25MZkYxTmJ2VkE1SDM1OFV6TTFWajB0eXhDZzUwZzBJTm0wK2d0?=
 =?utf-8?B?NHFHZkVGcHV6Z0grZkw4VWhOTWpnUGVDa1BGQjlLeDhpdXhXTUx5K3E2cTZl?=
 =?utf-8?B?RldEVExSK3NUdXNuZXZHVGVWR1dhc3JIVEJMcnB0SUNjVjhWRUtRQmNIZVRI?=
 =?utf-8?B?K1B0Q3NrdmFsdjF1ZnJrMnd6a3BZL3dYaWxvWFRzejJna2V2eklSU2pvZW5j?=
 =?utf-8?Q?fUcKG/GX5To8pIN1dsuVtIwqZH1e6KLr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG94cG1UUVV3RTg1Y0hXMkdFNTBqa2lKQU9ZVXZhekx0WkR3YzdHcHpxb3FC?=
 =?utf-8?B?QWJaSHEzbE9HSUNuQWgwb0puSEZyQTErL1dkVnZoRzREV2hrSUJuaEZCYlZo?=
 =?utf-8?B?MHpDMVpSMHpWbTlyYnZuTXgydytnWVppTUVCdjdMeWtuWjZGUDJCb2hmWDBw?=
 =?utf-8?B?ZW5WN3QrRHJmNVlQNm1YMW5ma1FJN2xsQ2hoMWU5emtMQUFHUTNVc1B6RXRw?=
 =?utf-8?B?dzR4TXlybnhaKzQ3MTZNMDJOVGdES1loK3lLQUw4VzU1dTd4bGFTSlB6VURt?=
 =?utf-8?B?WXlSY1RhaENjcUU1amJQdUZlVVk3Y2hvSyt1OWEyU0hJaFhJbnY0ekRSSmNM?=
 =?utf-8?B?aDF5RTBNQnlTNm9qUnU4OENQQjdrdG01MnRWLzFla0svb0c1TFBQejRXQUE0?=
 =?utf-8?B?Y2t6cy9DT1F0QmlMOGFPVThHZENWc3l5QjZDS09QMlZ2M2tDditWWDBtQU8z?=
 =?utf-8?B?UThoQmg2K2gxNXZXSTA5K25nVTNHemdWZWRJSk9NdWFaVUVXY2hMdFZMZWxX?=
 =?utf-8?B?TVJuZW5MdkQ1NWFIa3I3bEhYQ0pOZVhDaG1CdkJHcXlXWHNxVWw5QWJrNkxa?=
 =?utf-8?B?elRlU1ptVGlLNmU1Zng1VUNVclFZYzhzUDQxQnZRSTVNaWFEa0FpWUJPdUdY?=
 =?utf-8?B?Vkg0bVVnem9mVy8yUzlUZEVNaVRNaGh6WVNRU1pBTVFYTWdRRmszM2FnYWFX?=
 =?utf-8?B?V3k5eWpMREN3NVM0ZG5kU2YrNGV3amFVM3dKdGZrcU1tY2hiajRGOHpoZnYz?=
 =?utf-8?B?aFNkak5PakU4V2hKck9yOWhHbVJFc3Y1OEZUdDFmRHkvQzdMSzF1MSttYXk1?=
 =?utf-8?B?UTNmYUNpbVo2ei9sdXlFc3pZc2dWb2VqUktFeFd3UFlBREJpRXR2RkdJbFpS?=
 =?utf-8?B?alYwMEpGRjR3czMrOEh5bnAzMFA4VnYrc2VDeG0zclh5UjlZMERZVCsxYnFK?=
 =?utf-8?B?YStraDhxVlg2RUFHVHYva2VMelhUclZjN1RjMlFCWkdaVjFqa2ZZeGhKUDhz?=
 =?utf-8?B?VGEvam14UDVEelJQWXZDNGNsR04vS0gyZmF1SkhXZjVpUEFoMTY0YTRodWdC?=
 =?utf-8?B?VVFsb2JtK3g0dUtLWGxqWDVJejNmQjJ3eTY2Qi91OTRscFBjUnZUSWNqTjVI?=
 =?utf-8?B?YStsVE5ScmFkVmFDa05vclNQK0tXYjlDNEJ4MHZmclQ4UktBYmJSWi9OY0Ey?=
 =?utf-8?B?NTlycmZyaVJicHljbE9RUVRWQlhqQjZ6UXJlRmdkdi90Nk9DMlVrK0dOMkJV?=
 =?utf-8?B?aW9sMW5zZmlZYW9iSVUydXFUMytYeThHZHFhV0Q1d0F3OFpRZmV4MnhQa0M4?=
 =?utf-8?B?bFUwdkM0djVCZjUxNTY2ZDNOSjVocGRnT2g4TUVtMzU5TWNNaDZtVDBoR0NU?=
 =?utf-8?B?ckIyUnAzdjBCWGMyZVp0ZEo1YzF2MUdDa2U2Z0xaZUhhZk1DNFRQcS9TWWZi?=
 =?utf-8?B?T3ltUDhFSytFL05LRHVZd0JTek0wZEJ4aHhjaVpYMmZPbk1BSHhrUDFxUW1H?=
 =?utf-8?B?KzZoa2lPV1dNWm15UU96cTZwbzhWaTljcThRdzdwZmRWRVlGL1Z6Y0lUdkFC?=
 =?utf-8?B?QXpJU2xjcW5heWFwZnZac3V4YlJYcy9uMWR4NkN6aXM1T2paWGVTK3ZjZ1VB?=
 =?utf-8?B?NnJsWnpWcFFKZFdUMGFPamdLN2pwbEpSbWltK2JBdTM3UUl0czl6RCtVREZB?=
 =?utf-8?B?dWlhRnpKNHdDVExXM3hyNURPWDNpQ2RZRjZUVWVaZmcxVVdyUEdzZytETnZE?=
 =?utf-8?B?a3lZOWdjQWtEUDhaK3VjVHd6ZVVVV1I3MlowcW12YS9CQkV1WFM4Smpzekxz?=
 =?utf-8?B?dVZQdnhSN0p6dXRRazRXZXNnR2lDaXVCVkNmczFJRzI1QVFxaHhTdUFkTXlt?=
 =?utf-8?B?M0R5a0NyUDJlZTFTTEJwa0YrU1lGVHMrQ0MrN1lBblN0b1JKcDJhL0l6RDNT?=
 =?utf-8?B?dS9YWlM4NHF4TGxxZnlaUWptaVRlclJMdG5yV1BReG5Xc3RXMysvRXFMN1d6?=
 =?utf-8?B?TGhIbFh4dFErWHNaakgzbXlHbjJJUGZNOUh5S0MwdDlpdFZLWHlKckZrUlVm?=
 =?utf-8?B?L1QvM3F4a1M2Y0JlMXROL1ZVN0RDMXNSYjVhMTNBd2VLK2ZVaytvYVRjNG81?=
 =?utf-8?Q?/6rpqK0RzY7jR8wD0AXpsHw2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665bbe6e-9041-4776-0c4c-08ddfd27c527
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:09:01.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eormFuYghUBhEopfWZ2Xx4cUCGZtD/tl5CyQIpnUMFTwAKBhxTeEKAQqSegsyZBgVUTtZ9QVRqIrZXJUFo96lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042

On 9/26/25 11:01 AM, Simon Horman wrote:
> On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> ...
> 
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..a35533bf8377
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -0,0 +1,55 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> + *
>> + * Header file for virtio_net flow filters
>> + */
>> +#ifndef _LINUX_VIRTIO_NET_FF_H
>> +#define _LINUX_VIRTIO_NET_FF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +
>> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
>> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
>> +
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
>> +};
>> +
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[];
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
>> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
>> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
>> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
>> +
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	struct virtio_net_ff_selector selectors[];
> 
> Hi Daniel,
> 
> Sparse warns that the line above is an array of flexible structures.
> I wonder if that can be addressed somehow.

Right now it's aligned with the VirtIO spec. Changing the type to bytes
would satisfy the tool, but that's all.

> 
>> +};
>> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
>> +
>> +#define VIRTIO_NET_FF_ACTION_DROP 1
>> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
>> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
>> +struct virtio_net_ff_actions {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 actions[];
>> +};
>> +#endif
>> -- 
>> 2.45.0
>>
>>


