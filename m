Return-Path: <netdev+bounces-240455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166AC751DD
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4554353FD8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50543644CF;
	Thu, 20 Nov 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0Tkp7HL"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783834D91A
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653196; cv=fail; b=SKpDnKqQKrXrkbxU5QdLNfqhJHrSiNdgrCU5KaVRO94RM9JnaSpvkr37J/Kf5pZV7euxgTlKZF/es8gHVVLj0QJCpybqpwyDYKACh2z/KTo9ayo3K4Qnxy1defhRDzbVq3hDLAfGg27Z8xKqFkkJqD9E94a/4tQPctKvLl5E9F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653196; c=relaxed/simple;
	bh=G3pjMYqj1Vmb2cHUBordmBtXvy4drCdDnlpAct2PtBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZA2F+QCAGxl+ahOtDuEHNRaXrbKDLfjuNbHIgo7hkE9wOLZZ/EvbHh5IiW+lNVSHY/sMr+SQ7D0HHOullyENUk0eWSwq1L7JwYPc6+DlkkfRFwLi/lrrKlcfx3Vq1UYoz/NSfw8GLbc08uPZOKSqAzyzb8ZOW2OC7VT7vt2YfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0Tkp7HL; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t61tO/ZWDd/1doQsJ0Fo27s/5GKUbMFv7KOkpnEFD7M8/xtR1wTsx3n9q1/gYAUwjmjYXGjGlFxkbgUTsVySqDejlijuC4TRafDhcxCD2taYnY2FdEhHB3evp4kqwe1ozBh/Al5FTwr4b0u/I7ASTrxMB9GmywmM+Uu5tbc+4Jh0k5PgbMUMHZwSZZn0iudQSM7EEJf4FgqbDJAhCZKjcdkPQg9TUNnsPxslYqv5hQXg7wxE+54Ejt5ue9M3syxypluMhfL4h2Rw9AX1w2/Y1Q5uhg6mrX+lRRnTO4uGBL8YybbU7N1JemEgvVy9PW5Mm+WmS4m02fUhV3TTcTZ9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJa5NGcj9vj5Vx6YyHEKzZiMFtwfRNsFARG0UK4UZ1k=;
 b=eJSC2S9HRshVvzb8pjlyKOMQ5YzVWkSo6y11x3K25OQVyKQX/JHvmHVaczU0MgFKeCX53EhycAQYCaRn4rUUDYJx/ghebalYJA+dNVw+Fb09YRKTQCpGIsEaOsbsOnKwtz/C+piCk8nQB4Td+PfirM3XsWwSvuMjW495riXZ/f2qUojZrebTXZaFcKtzQBMJOwY/Kg1O8h+UCMbTkEg2iTxdPg7xuokeLDT5DrtXWgmb1CWRKBbXeS8eydKdOLKvcank+0XWc0VWTnh+9v77nvyEJ72TrjystMnbvL+PeX1UafELaBPDRB2WoUuhyAiNKkY0Yqcjkk4Pp/OSmlT3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJa5NGcj9vj5Vx6YyHEKzZiMFtwfRNsFARG0UK4UZ1k=;
 b=H0Tkp7HLJ4qCpczXzbJRYHf5Detp8P/qRMc7SzB2BDxmlBUnjqh77AS49mtT9Q8+MnP8a9V7l6fsZxYXdp6EUlmdwSeyc3s9K8RzZ7J+VQHSNa5G1tvdcvwdOe5jH9uvGJ9LeFko7Q8xXkG5u70DtbypphKHYuTtb2ypydtijLWPnG3PgG3HBgOPCTUoXbFoTAtLeZhq4LixZz+D2IAV9Q0XBy+73RZk12q6WiQcXCfupVk4X8OqFWpi/akCQ2TLEUdxwBJguVqHR2/cTclnZYBAEQ518IgKZP2MdOF6rs3WZ9ossbcvPG93hsyJZ6SJZtC+o6fJotnU1Soy4Swcew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 15:39:50 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:39:50 +0000
Message-ID: <095dc6eb-a3c6-4809-b231-61875b52b376@nvidia.com>
Date: Thu, 20 Nov 2025 09:39:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
 andrew+netdev@lunn.ch, edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
 <20251119175149.6bc8f7b2@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119175149.6bc8f7b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d4aa13-0e75-4724-8faf-08de284b0aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzNGcmpxcmhHKzNEb3EwaVpvM3B6RzcxUXdTRWlhN2F0MDV5VFJXaEt3TzVF?=
 =?utf-8?B?czhTclVPWnl2RXVsYjJrWnQ1MGt0amRrU3h2bGhRNWd0SEdnUno3M1p4V0Vw?=
 =?utf-8?B?L096OFFLRTVjWE4xb2x2bStBQzZtZzZvTFNZai9pNFJTUU9PSWhkVW5XcUo4?=
 =?utf-8?B?Q0lDbzZRN1c1Yzl3YWh1VWZvSFg1emlZWTVxUFkzeVZkU0JFRnd6Q01xVWNB?=
 =?utf-8?B?eWVFZlJMclh4eW1CTURXWmlScnpoS0c4YnF6TnFjcTJqaCtWUWlVdC9Galo1?=
 =?utf-8?B?RFMrNTAreWgyOVdXVlJJL29hZlRHVUZmc3RUYjVPaytFSDg4SmFETkF6cTZp?=
 =?utf-8?B?djk0dkxtWS8wYjBnTERoaVcyZHZWTVdWWG5xOXBJUmVMclowWUR4NURJZ3VG?=
 =?utf-8?B?T0p5OUtPdGloNS8xdG02M04wMWZmcFhWSGE1SlNmN0FzaGNqTlNRWVNNb0li?=
 =?utf-8?B?U0lDcHFKcjVGaS9icnl5SXRZTzRDZUlNQk1OV3FQd3ZYK1owUnZDWFlIL0ZZ?=
 =?utf-8?B?SzlnWlJ6ZkNWN24wRlYzeVgzQzNwODREd3NKcWpHZUl2aVppNEEyeU1rN25I?=
 =?utf-8?B?K0hjTUNVRk5DMGNiRTlodTZQTHFsdWFFRFZONzlnSmJQVUR5VlJ0Wk5OVmZq?=
 =?utf-8?B?S0s5STRDYXU5WGpzZ2ZGZlVWdmZYeUlGRzdRYkJmZkxoSUJvTGdZVVQzMWR3?=
 =?utf-8?B?Q2Izbmo2R296RUxCU3pYOGMwR2dNOWlOZlZTb1p1NWlaWlQ0dGlvTnFZdXAy?=
 =?utf-8?B?bmhQais3ZHJvaGVaVzVRK3UwamhkQ1JGdTJEYjd3ZmpSamQ0TEg4ZEtLaDQ5?=
 =?utf-8?B?NWs4MVVrYy9ubFpRNU11SXhxREo4RWtkNXhhdVIyYU11N1h3RHZaMUNmOUpO?=
 =?utf-8?B?MzhLMzJLL3g0bHBQa3UwQ2dERWFYbmJTdlJWdUI4NTNvL09EMTFuNFlSUVZI?=
 =?utf-8?B?MWdPVjJUQ285K0RGQ2N5TDlHQ09rL2J0WThCU0NwK1ozWjZrcmFqZUNMeHVZ?=
 =?utf-8?B?d1crdTE3S2Z6RDVnZlJKaDZYZ0haUEhLYW1PL2pxMlVzODY2QS9pNlpLVE9F?=
 =?utf-8?B?MFlDOXkwTmhFREJvMkZGckE0UEJSYkpJTUdnaGF5ZnZ4Rmk2cUphTE5RdW9u?=
 =?utf-8?B?c0VSUnhPWm5qQWRHY1NkOVZrRW1WelZrbGlHWVhLWE55N0NzaVpJRjB2Rzhr?=
 =?utf-8?B?K3ppYXh3WVFmS2dPSXlaaXpJejBiaGtGRXNwaVM5ODdCTW9YNDNKWjgvVlhh?=
 =?utf-8?B?R1JPQzlFUHoxVVNCcXpEMTY0ZlVESXNlOXVvRko5anlkem5MRExlNDhwNGZI?=
 =?utf-8?B?T1FjME9ib0FzOHhBMzR3SGRTTW0rOCt1Z2Y3VWphdnQ4aFpkSVRXQXhZSW5r?=
 =?utf-8?B?WDhPdW5zUDlKS3U4NzNRV2RsSGdNMWtTOE5BRDZuaklxbGQwN3JGS2FXTWVD?=
 =?utf-8?B?aUlSWUNNQzRDd0dVMHZoSXhYTFhlWnk4ZjJKTDV1NEdzbXJacmZjS3g3Y3VJ?=
 =?utf-8?B?Q1djelZRek9CZGUyUHlpQ2NsQ3dLcWlTcEFwRVR2NHdaakNxay93dkpZN2NO?=
 =?utf-8?B?ZmhheTRDNUlyKzRtYk5NbWlXTFQ0amVOT3NnMUdBd04vUWJBM1p1TVQ2MnVm?=
 =?utf-8?B?OThKZFBwSExnMmtydmlJVDhjSjJhc09WQWtET0FTSFNJeVNsbG0xaTUvQlQv?=
 =?utf-8?B?SDdhSGNBUFZQU2tXWmUvRVpHNnBOUTlTeGh2KytGS3dzZ3c3dkhEenp2dU9W?=
 =?utf-8?B?cE5uL0szbWk5bjdOVkgxL3ZFRFFNZWk3aFBCaUpiMnBqZHp5em9RbUtycERv?=
 =?utf-8?B?eWV0c2lTTENCbllUNDhXNjdDZmlEU2tGNG1UYi9LYkVVYzZpZ0trelVya0pn?=
 =?utf-8?B?cllHV3R2cXJON2lHZXd0QWdIbnhZbkszeG1jOHM3Y1VTZW1vUTFXOGJpbW1p?=
 =?utf-8?Q?hy09/j/rjJHFzn2YOI6dwOuPztKTLjh3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhqTlZ0NC80TTF3U0FFTjNGRGhHWG9tdzNGY1NQTWdGSFREUGR3Qm1ieENO?=
 =?utf-8?B?aVhzQ1o0NHZZcER1WXhuSkJtTFBHTnhvRUJxYVRERUgrKzEraGl6ekMwZlJt?=
 =?utf-8?B?NnBWT1YrTnJwT3M1KytqUVZnMFg0RGNvcFRabGlFOUZSdW1HQnlKclBtUlk2?=
 =?utf-8?B?Qjd2blFiczFKaFVCNk1rak1Kam9sRmtzSjAzVGJXcTR3TmdBeVNQaVp6eHFo?=
 =?utf-8?B?MTRVWXNCTUFkTlZtRXBRNWFhaVMrWUR1ck52VEx5YVJMU3FxOU9sQVRDQWhn?=
 =?utf-8?B?WEFlWGtVeFRWZHlCZW5JV2ZtRlZvVVZKQ3lOMjBtNjZWMjl1bmt1Z2NoTFlo?=
 =?utf-8?B?MC90cXpraEFkQkpDcTFvalcxOFEyWmNHcDRDM3dwVE9TSEJZdnBmeGVzZk1I?=
 =?utf-8?B?U1BZbXBCa0NLU1ZuZlBKM2pxUSt6ZEFzeGRoaHhid2xmbEpJVXU3R2FSNHBQ?=
 =?utf-8?B?MUUwSVRFSk85YnhtRkVuZ0kwRnVuTlJDNll4L09YUGtXUVBkWkNvVnRKWmZl?=
 =?utf-8?B?czkrOVVSZVdmUWQ3MXV5UkNGRW9GcDBDcC9salgwTHpFcXJCVExhalc5NkVC?=
 =?utf-8?B?ZUZ1T2NXblpPMFdWSEtneVRGME1zZ2UrT0g0VDY0ZS9sOGJqU0hQMFJTUmVO?=
 =?utf-8?B?YlBCbE45NXZJTmU2bzV2SXFZVHZNaE9tcUpuU3VrVVlnR055bTAzOWQwUk5t?=
 =?utf-8?B?NUpGRlU3OGM4dFdHNmZyVHcvKzZVUjY4anpBZnpwQ0JpRUJpWXFtVWVLN1R1?=
 =?utf-8?B?NEQ0NEl1VEJrbkR5T1pGTmt3ZUZlSUNxZFlFVU5zMFJvV21uRkFBdGdiaHJw?=
 =?utf-8?B?dXhDUHd6T2kwRkRRWGtOcFVhM21jci81RThjS2VaVFdkaXZaWVQrSXNYUHMz?=
 =?utf-8?B?Z3o5blJvTGxKeTFxZ2VSeENrSzJzTXQ0UTlYM1N4cFBYVzI4cDJGamhjMDBl?=
 =?utf-8?B?ZVBGU2JtMCsxdk9lNlg5VUIxT2N2dDZWa0tEbWt6WHJ3T0lsQ3pONU1YMk01?=
 =?utf-8?B?Y0taS3FxeEdOdWJKcmJnL3pncFNxQ1kycmhWMG0vYU9WMUxGbXRxVmVyZGlM?=
 =?utf-8?B?QWNkcGNRYlpYOTI3WUFYRG5RRitQcU0yU212c1FQdWhpQi9lU2Q0N3NnRE9z?=
 =?utf-8?B?UGhMcHI4bzlVQkE1dTRna2ZsZHZhMUNIUGlOTHkxMVJoSDk5VGJtMzFwSERi?=
 =?utf-8?B?cHNrSUtwWklJVU8wci9FbWJNc2tXRUlOeExUbTRtbndMRnJvYlFpTzJuYzZ6?=
 =?utf-8?B?L3U4VEROb0JXLytzOGNzMUx5RENMK2Q5WVE5NzVNOTdvYVNLN01MZGNvR2Vo?=
 =?utf-8?B?d1lucklVdjBmekhFWHFzWVhTclo5YnRUb2RMcFdmejhxclVXVnZ3Tld5VzZY?=
 =?utf-8?B?ZmRpRTh0MkU4NTlOOG1SZ2NMa0oyazFZM2g2eW5TSWdZZVBzZU5uZkNQK1lM?=
 =?utf-8?B?bzU3N0hyNng5N1VNUytIMmRWdWpjaWE4NTREcldxQjY1dHB6M3dCOXhmZy9E?=
 =?utf-8?B?cE1CRG5Tb1hOM0xTUTAyZTNFYjhEem80bk1JOWRMWjVhaGx0WVMreWIrbjAv?=
 =?utf-8?B?eStJbGdnRHZuOXJHdVMxSHlENHltM0FNVnJ1Tmsrb0R3VEtIcEVtTnorMURS?=
 =?utf-8?B?ZkUwbTcwUDNwYlJHSTdvRGJjSExFa1lOWHQxNFJ5NkJNbVhNa1VaYWFEQnNI?=
 =?utf-8?B?d0pKdWtNKzl2bWhlWWVlelpPeGRjUU55US8xVUNJbk0wcnhzMC8wOC9ZeVQ1?=
 =?utf-8?B?aXFvYXozQUVFa3djQTJ3Q3ZaNGVIWUY2TTR5dGVZTWpuSllZQWZjd1dmN01O?=
 =?utf-8?B?b1JXYXpPUCtPWlZJQXpUTGRRZVE1cTlBZ2svbFBDN2dpTytiYTRYWElpSHpn?=
 =?utf-8?B?bWlra3YxUzJnUXcvZldjMXkrdnNCZ3dKM0ZOWi9jOHFwVFYzZFlwV09oamsv?=
 =?utf-8?B?ZWZCTlcxa056aEtCTXI4MXduTDFZYWF0eEMvVzdDM2tueDZEWXd4dkZSbXNy?=
 =?utf-8?B?VEk0TXlUeXhKR3B0WjhEaFBjWW94MW9UeVp2MXNtWjVJT2k3WXNhWjZIYzBs?=
 =?utf-8?B?OWVPMnUxU29CZUdsNk8wQnowdXVEMTN0ZnRqdVErdHNUQjRBVUk3K2xZUlZD?=
 =?utf-8?Q?lsJqdSwFcyPCOHXn2CA+k324c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d4aa13-0e75-4724-8faf-08de284b0aa2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:39:50.1166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L91ZXNS1HtOHk3M/GKKHVzFpIyXexp+UCiQkFGVoGzvaEAxDPmVkGsOTnFeCXIUVUyC52J7+gsqro2NMjLfHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

On 11/19/25 7:51 PM, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 13:15:16 -0600 Daniel Jurgens wrote:
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
> 
> pop in a :
> 
> 	/* private: */
> 
> comment here, otherwise kdoc will complain that @reserved is
> undocumented.
> 
>> +	__u8 reserved[2];
>> +};
> 
> That said, if you don't mind pls wait for Michael's review with 
> the repost. Unless someone else provides review comments first.

Thanks, I have it queued up for the next version.

