Return-Path: <netdev+bounces-133463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26947996052
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8831C234D0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF61B17BB34;
	Wed,  9 Oct 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNVXQwm9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8F17A584;
	Wed,  9 Oct 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457723; cv=fail; b=E4R0Oj8gs5LhYnnuAJLU2bGYGRABBSE7rz1zBb0aH3t/6k5ycKtYrWYlKi22ltQLyXipzosXlCJJ7P39rynGU5YsjHuCdDpwGCNc2L54Gftj7YK4TSh1oxkyJ1iTMEw7bJ5h8y9zz/qx540Mn0NbYjjfeGivrb1jWpwb1dCNJ4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457723; c=relaxed/simple;
	bh=f+ma80DfBuL4dWuQ+qlcgXkzDGSfusXiyC2+H9Wl+wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E+WAVjgPzCnWiUZfQZDOZdOolx0ARz/jT+0TACzz+ID0mWwawppybJfm6DNiW6Mfh3yAXR/EWNO7LiT/t94U+gtLzD4wMqBL2GzoOz1oJPvF7j7Vw7DFu9NWp2srN0+/U9TCW+9LCra7n9K8ybwzg7hi6+GMnZhvGzfVu5NpCjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNVXQwm9; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmcSReh77pgEmhUTfkXzXqYpk/yKmMVEO0F26wkO2GWXAELtJFYLiM2SN22eFHJJ/5doQkHOVDV6qdblcGaN+h8rKN90jmYBcereKvaoDH+2Til7agbqVln5CS9X2zPOUp9PS2bUEPUU9DuQ38oWn1fR1l0eDMS/C8hHoTva9mI/8A31FeCzmpLXEthlE9vtYrJu/o6opQrZCgfYLW0+Xlzp9iTAVbQ/BsvIjEDEQxWJbtQP55gmY7sdtGF69aQ3TapsR120rYLBSTeiWeYvK/4XYMWoNptRGos0+vYJZTnNAZ8DldDjag/ZHcABdmiFLKUioAbOSv9DsYVtOYMW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+ma80DfBuL4dWuQ+qlcgXkzDGSfusXiyC2+H9Wl+wk=;
 b=xJ2vEeuN/90GNArM1EW1sFq/VZnzoX60eZsWDKEauGsk3Im/YBAMcVvuhBTHyOlmsfLmYU1NjufNB4Kj6pN5ZKjAM42m5xnd0/UUnKrxVmiX0ZmKARKsQCrNHcyIUO7pn9QyRsGQ42IEI6nwZCAI/Cqx8y1EIBMl1igO4F7vVmIFUmqpfSZvRXUJdLkkTnEmlAn2pFDnC5W1pYFEAs6UGz2llVmMFcxJyHQFF8U5JpXBWjcuWFlZ/FehcS4z131WswoOiS02WPeCKWAxQu5qubA2v4dJPFuoR+Gk3OXEcQQ46mZfpqYKZQRHsVkKoDBPzBPgB3l52FnvFEhZ6c7pBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+ma80DfBuL4dWuQ+qlcgXkzDGSfusXiyC2+H9Wl+wk=;
 b=GNVXQwm9++9hEeNZPRT+0CkZtHi6dI2SwfN6wRz1/7ZVZ8su3FCyvuv9iWEEm0izpSL22SJn+0SBT/tXS/EBWK2plucniZBHGEaYfkVHZdGzG/RHav+NbCm8CH/nv3EX/MrdnLA2xhMP+7tIXo4avtIROk3iDh86lOfG/sBjhMfL83us2EXQAt/ah4eZsmYWdMzhskCDNhvOsZV8Nkm46ZrG/9SmtIbAuXv+8xK/SLRWdl5vIvafxDdZx201bSvBsN8aWK/vOxH+rvfR0NrgYzA0JzA/I0UDAnaZolqCUAc/McTcby3XacfCewq0MJRwiXuP9g/LKZMYjl+symI48w==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 07:08:39 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:08:38 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "yuehaibing@huawei.com"
	<yuehaibing@huawei.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v4 0/2] ethtool: Add support for writing firmware
Thread-Topic: [PATCH net-next v4 0/2] ethtool: Add support for writing
 firmware
Thread-Index: AQHbE/9lAG33dTw5r02g88ctyYIhIbJ9ANAAgAEJMRA=
Date: Wed, 9 Oct 2024 07:08:38 +0000
Message-ID:
 <DM6PR12MB4516D35F01B7386EBB0DC63AD87F2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20241001124150.1637835-1-danieller@nvidia.com>
 <20241008081152.772df3e8@kernel.org>
In-Reply-To: <20241008081152.772df3e8@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: 68f7c4c1-1ab6-42c8-2cc7-08dce831330c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2FkcG1iNmNwaWFTY1dlVGxlOGJ5bElLYUNmRGtIUS81MzVpZFdET3c5NnBT?=
 =?utf-8?B?V0NKUVVPTzd6dDFmMzZWN21lR3YyNEhQMytMUDVEem9zblVFMXo3NkVNYWYv?=
 =?utf-8?B?VUlsMGx4VjhTQ2treEVyN3VMd3psbFNXaFd1ZUVHMDY3QmU0VGlXY2ZOTWZS?=
 =?utf-8?B?Z28vcUY3Ulp3R1JTa2FyOVN1alYrR0YwL3RkYkJ1YzRpeGJBTE92YlpwVXF1?=
 =?utf-8?B?RlZnVTZwTzcyOVNNYk1DL01mSmQxeTh3T2s5RlQ2cTdVL21ySEY5dERDM052?=
 =?utf-8?B?Z1k0MUhKVW84UllwdG53MWd5K2RLVjhTRVhBT1MrOURRYWRrakNJQ2VzbGxS?=
 =?utf-8?B?TWdjd0pQd2IzYjBraHd6dWFuODdhVUVibFBkQ3lCdWw3R2VycHVoVlhsN1hj?=
 =?utf-8?B?OXFYQWRSWGdtR2RDN2dMZ20wNlJoVGpVbnh2VjVwbVdpT0lWOFJOWG5ZTmhn?=
 =?utf-8?B?bUVTajdtZDZrS3dxV0RDRlVhWCtyVnhtb05MWTNUUGs3a1lvZzRLSEp6OVFP?=
 =?utf-8?B?WVExV1pzYnBGOHRUeHNJWHBiMDUraWR0LzI5MXNSQWlLam5ETVhTK2p6aENq?=
 =?utf-8?B?WUloUTZuSlhGWjhRbkloVXNJOUQ5c0oyMVdRM29raXI0dkxVZjk2S3dRaFpL?=
 =?utf-8?B?MkN2aUNOdVh1UmwwMGF5dkYvNXpndENtTjFTb2x5aFgvTExkOU5BRHRTQ2pl?=
 =?utf-8?B?SWFnRnVCTUJVbFBMRkM1blV2ZHBKSWFBVUVrWldTRXlrNTQ4U1pHa0FKOXo4?=
 =?utf-8?B?cmowQUxJTW1NY21aMEtRMjN4aU81SDVvTU01RWpkRStnVlVFTm9ZZnMyWGxM?=
 =?utf-8?B?UHdQeUY3SnNOdG8xaHJoMk1kV2h4UjBtZDk1TE9mT1FqdjBKenNBeXIrN2tr?=
 =?utf-8?B?M21mdUZRYjBTcHZGK0Vvb1IranNSeGtWdFNtNWlsZzRsNVRucHJSMGcreTFi?=
 =?utf-8?B?ZmFuQmJvRVJXMnJ6ZTJYOWZaZm5GbytKTng0K2dOUmdyOEhEd3ZoaTBWUFI0?=
 =?utf-8?B?L2tKNUtBMkcraVJZZkM5TEUxaWFmMlVGVkszS2JZMjZpSEJmVkVRUElFTy9m?=
 =?utf-8?B?SG5rMFJQejhTSUZMQ3BPWUtzeElkNFNNY1ZLYVBTY2hYVFBxRlF1THRHSmJr?=
 =?utf-8?B?QlNLaDEzd2xOMTBGbStsdHN4R1RyL0xZUDFHdm1udnNna0xVZjEwMWFEcWVU?=
 =?utf-8?B?TkVRSFZvclZtNEl3QTVPREJzZGNzanZPTjRyaStZbXdYR080UU5ZSm1mT0lF?=
 =?utf-8?B?NllvYUV5dTNwajFFM2EyNWFzSkdDZXFRdGFhYzBxQXlhd2Q3TEI0aUZNZGRh?=
 =?utf-8?B?NFpFSUlnMVQxOFBjU0FOWGkzYzAvQXJuOEdQZTcvcGlFbkxYbEJyVWp3NStO?=
 =?utf-8?B?Q25BK0VWQzF3ZVJzc0lnYUFYaWVvdjVBS3VkVE1EN2x1WHpTYnB4ZzdGYWZS?=
 =?utf-8?B?ODQ2d201ck1iNldLL25vemxIaE5WdmEyaUZMcjVzbFpCSi84RGFobGxpMEJG?=
 =?utf-8?B?ZktxWnJtdkdFQjl4RWl3WkhmT0dSSEd1VkNuWkh3dUlHMVBFejdlMnRQMFZM?=
 =?utf-8?B?NFNTSVd3VjBUMGpCOEYrNmZxQUhjQWxRVlFPaWVkdThoaUNYbEc2SEFYdVI1?=
 =?utf-8?B?aFBlbVh6UjF2cFdZeXhMNUtLLzk5aE44eXU0QzBjRERqKzl1bDd4YUVDVmd1?=
 =?utf-8?B?aytFYy9mbTBrdk9CNVRaSVFYeEpsRERXQVdhbDExUVRsb2RmTVd5QzNrVHJF?=
 =?utf-8?B?ZG5MK1F6MnNQNzc5V3oyNE4yNnp4UlZYcjIrV1RRSHBCY2ZCM3JBNkt5ZVdM?=
 =?utf-8?B?Y291QXBsSDltVVR2Sy94dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXpLYTh2UkFZb21aUC9Ic1MvZU8wR1p3L2FGa1U3UjkwbFVKamFkQUdkV09I?=
 =?utf-8?B?TjNIYUtwVFZYeVk4dnRmN2Jscmc4OU51U0hvNEZCQVNWSVMwS0d6RzdiNGdy?=
 =?utf-8?B?OWdyUG5OZUg5RktENnRBcThVK2NUVkxhK3NKMWszVHVtTEUrQ2tWNFpWSWJQ?=
 =?utf-8?B?UU5RZXZYdlZURlN2U1RXK1FmMEF2ZGUvVDQ0RU85RWkrMmU4NEszd2VwNkdl?=
 =?utf-8?B?cExtdG9CdzRabmlkMDRuZ1o2NnpFdGVjMis0Z0FYeEU0OUppYWFWK1dWTDYw?=
 =?utf-8?B?bFFhYkQ0TXgrUDYxMHdHR2ozSmFxd05KenE2b25wd1J5TFlaQmtvKzRTR3J1?=
 =?utf-8?B?VVM3SjdxTy80Y1JzdGZKSm1WUWdwRjF6ZXJIWmgxWi9QNFRQc1Q1YTNFaFR4?=
 =?utf-8?B?MFFBRWVoTTJvY05pN2V4N1FqVGduNnNYNDR6VHlhR0ZNdWQ2YjNaemxkZE5H?=
 =?utf-8?B?RmRtSHR2WmJlN3JVeW1WOVB4ZjlUSXlUYU1rSkk2bEpVQ0JEbmNvdnRKOFA0?=
 =?utf-8?B?ekwwYzNQUmhTeUdrK1laY0UyQjY3U01zMnRHN3BkeWVjdFhqV0dnOXVSUEsw?=
 =?utf-8?B?a3NMaUQ5ajR5b3BmTER4TWdvNkhPRXFDMEpFc2x6dy9JUDkyYUhhN2llOUFK?=
 =?utf-8?B?VGp6TC9OQ1dNMDczZ1VDOWNoZEQrK3hyazhoSnVWWEE2N29uOXF5YmhGTkN6?=
 =?utf-8?B?Z3BMVVExMHE3MDNMQWVtbFBUdFBXVE5idUNlMUZ4VTNaQkVtdDNuV3Z6ZEZV?=
 =?utf-8?B?R1FZUlZmcExJMS9FVFc5RnhZeHJXVW4zOVRKRWt2ZmFyYTJZVEVucCtRQkEr?=
 =?utf-8?B?bUN1MEY5Q3Y4VmFhb3lYQ3VoRlFxcGRDdDE0czkvY0QrTnZKTEUyY1ZoY2hO?=
 =?utf-8?B?Q2VIbHpWa2hXRGN0UVRFSE1FdkZsL284dXg4VWdRNGVkWVNyeFpRMkVCQ0I1?=
 =?utf-8?B?c2duUUt0SUttMWE4aUs1Q3NDcFhraGR2eDcxMCt5ZjgrYytObFVtZjJKWS9w?=
 =?utf-8?B?enUxenFJU1hyTnNocm9DYnQ0QnJQRzZ3WmZMNGxrZEZNaHdIZmdsSC9kMXFh?=
 =?utf-8?B?RlRzWUN6ZDd3Rm9SY01XWFZKZ2xmalROUEViRUVFS0xsVHFsRkRKSjdUcFd4?=
 =?utf-8?B?aXowREJQUEZLaTdLaDdmRERsQ3d6TVNZL1NpMXk1bHRXQVpRekhwR04rdzdY?=
 =?utf-8?B?dFhRVzVpd3pQazNzRXBEQnBFUWF5cHRKMWxERWJGSDB0OGUvMXFmTjlGNFlq?=
 =?utf-8?B?djhaZnFsMnVoeVVrck5FVjRYclE4dS9rcGt4b2l3Ky8xNGhQSU5EWENIcGg0?=
 =?utf-8?B?blJuRWxPMXg1MkdrSi82ZHZBclRVdEJSYjZscXRraEtiSlhuRStrMUp1bUZ3?=
 =?utf-8?B?dzZ2dE5QRzdpWGJFeTBmekpzSXRpYy8yaW53TFFoV0VnaGNjK0NNVFpWbUxI?=
 =?utf-8?B?Y1o5VHVKSjZmdTd3bDRuRG5pNU9Gc1cwZVpEbGlwSlhpOFVFU1pNQy8xZW9a?=
 =?utf-8?B?K211ejZIRHhwTy9WditYbFJxL3UrSzlzV291S28zOWQ5MXE0aGk4UFdvOGZO?=
 =?utf-8?B?OFhHNmVDV21YdWZraXZ4UjY4RWpJQ3oya3YyVEV0bHBlT1BxdERvRVNadjZ5?=
 =?utf-8?B?VUJtODVNMVN2elNZSzFLKzlrdXRGbHNhaDk0K3ZuVDdXOEkzdXZ0Y0J3Q3Vx?=
 =?utf-8?B?VjMwamhhS3htaE9EamM2SlpDOUhjWVhCdVRkdkVzc0w2NlN1cEJrL2tUZVhY?=
 =?utf-8?B?OEFBc1FIZHRHS09vem9QQXhuekNHazNjRVFhMTBxNHBTbmpwYllJb0t0OUpa?=
 =?utf-8?B?Ti9nWnNqUHh2TS9DUjZieGZEM01Qa2NmWVpVOEd2K2VSMEYxZGtZZ3pJT1F0?=
 =?utf-8?B?NUdDdHhncUlTRUQ1UVFlOXcrUkVvZVpXZ2c3Nlp6OERuSEcxS1hsanplU1pI?=
 =?utf-8?B?UWQ1dm12b0s3Z1YvWmYrdzU1U0NVMytUYnNZS0ozWHRSSDZhTWM4cFIyaXRN?=
 =?utf-8?B?MmR6MzkwRzFsb0JURVJNejJvQTVWTFdYUUUxaitqeWVPYXYvTGlWT0FyQm9E?=
 =?utf-8?B?TUk3SEZpc0FuM0YvejkyaFJiYVBpVXQ5RWwzRVRITSt5QnQ2dWlaYUFtS0RC?=
 =?utf-8?Q?DisnMg5k3PwgNfWVVGq9ZAa8Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f7c4c1-1ab6-42c8-2cc7-08dce831330c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 07:08:38.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf6wiB8Zj0x96xfRsKfNWTnQSDn6Sjfr8i/hB54HAhDZulSsRoEBwYNoF0KtVKbwNbWsP6rrr4R4umqBNWmzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5
LCA4IE9jdG9iZXIgMjAyNCAxODoxMg0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJA
bnZpZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IHBhYmVuaUByZWRoYXQuY29tOyB5dWVoYWli
aW5nQGh1YXdlaS5jb207IGhvcm1zQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgdjQgMC8yXSBldGh0b29sOiBBZGQgc3VwcG9ydCBmb3Igd3JpdGlu
Zw0KPiBmaXJtd2FyZQ0KPiANCj4gT24gVHVlLCAxIE9jdCAyMDI0IDE1OjQxOjQ4ICswMzAwIERh
bmllbGxlIFJhdHNvbiB3cm90ZToNCj4gPiBQYXRjaHNldCBvdmVydmlldzoNCj4gPiBQYXRjaCAj
MTogcHJlcGFyYXRpb25zDQo+ID4gUGF0Y2ggIzI6IEFkZCBFUEwgc3VwcG9ydA0KPiANCj4gV291
bGQgeW91IG1pbmQgcmVwb3N0aW5nPw0KPiBJJ20gd29ycmllZCBwZW9wbGUgd2hvIG1heSBuZWVk
IHRvIHJldmlldyB0aGlzIGRpZG4ndCBwYXkgYXR0ZW50aW9uLCBwbHVzDQo+IE5JUEEgYnVpbGQg
dGVzdGluZyBnb3Qgd2VkZ2VkIG9uIFJ1c3QgY29kZSBkdXJpbmcgdGhlIG1lcmdlIHdpbmRvdyBz
byB3ZQ0KPiBnb3Qgbm8gdGVzdGluZyBjb3ZlcmFnZSBvZiB0aGlzIHNldCA6KA0KDQpObyBwcm9i
bGVtLCBJIHdpbGwsIHRoYW5rcy4gDQpQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgcGF0Y2ggd2FzIGFs
cmVhZHkgcmV2aWV3ZWQgaW4gdGhlIGxhc3Qga2VybmVsIHdpbmRvdyBhbmQgd2FzbuKAmXQgYXBw
bGllZCwgYWNjb3JkaW5nIHRvIHlvdSwgYXMgdGhlcmUgd2FzIG5vICJjbGVhciBlbm91Z2ggc2ln
bmFsIGZvcm0gdGhlIGRpc2N1c3Npb24gdG8gbWVyZ2UgaXQgaW4gdGltZSIuDQpUaGlzIHdpbGwg
YmUgcmVwb3N0aW5nIHRoZSBzYW1lIHJlcG9zdGVkIHZlcnNpb24gZnJvbSB0aGUgbGFzdCB3aW5k
b3cuDQoNCj4gLS0NCj4gcHctYm90OiBjcg0KDQo=

