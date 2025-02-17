Return-Path: <netdev+bounces-167023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1123DA3852E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95A21885108
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CA721B18A;
	Mon, 17 Feb 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LpBNVlsM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0421ADA6;
	Mon, 17 Feb 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800489; cv=fail; b=tOVzAAkVmTdRqQr7XYIVgEIn4lCYx+C4KTWZw34VlXXhvhtBf9AElKtSkbgTHat3rC63nNjJqEepihEmA6wrYw7mJ5Rd1XxihtxUHakG2hycP1sRMKDrTB2n7Ktfw2fW5SzpxhFUSg9hBwLvOF5NfRbQooJNn9gltRCYitA0T0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800489; c=relaxed/simple;
	bh=57ejX0enHe3H9a5Omp9ffn9IefHkZ4OSQsyhX9Wfa0M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LeZ9BVbI8yfeV1yXtFDT9dRSw6s9l98YVZmudzR1lB3AMBQh3AxB0//KwHsDCUsfsoeW19JMg6XiafyWbeyXYPiEuNF09gvOPeluvOy7NQvC9UX/qqh6bn7v2cMSrLlP2SNCXKCx7GuufS7GX6R9ZCNMiT/cowKdJ+clQYRr3xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LpBNVlsM; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H27p/YW6wM/eEHcKMTV5Z7Qyc7je+SWGeHBRFIG8NcIsplMLc88WyeOTFOY2tt6g5vzM4NaUjWdo3eWk1dXupmPi+M8QliJrGF+bhTcxqO/5vtd1pw6BD7nuf8nViL27DvUnN19MxXRU87uBGK3VS/OpCGhbE7FRlhO7je23CSCQrdJCVcyCxeXITEsaBW+xSS9h9Syxuo07AEoaQUuBidGO4PALn49gcCP5j3Hs3mUjeoE6QaHZ0x0P6BqH5L86kvE+R05fFr3obQtJ5O859QOtdr17cS/3rQV7y8JZHyPs31bhOr7x1cwF4dT/OJxO+2iXWpGuzs7lRXh+Buf5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLRnBwAb4OS0Yco/JHpcNfxHtfCgWFIHT/6DcRAJCXg=;
 b=UjQ2Adu5uvsI7hwsAnEEknbpF5RWr27wzpqT3uR55HR95rT8L87/tyCi1ZJ9RXvBHOeChqtodo01M1TeCK10nc6A6iGFmD59KSaAuTG3CLEyauiTcdDozBHB3MfdUimSx9C4v9izVke8gnHEPWqIiGOLVSreMYdZWWw5ga/RqUPZ59P0MKMbFoUHl40AAG7Z0nayt7O+uUrUF4IHUWsbAzgRo8AyqxCa3U0AeyXrdVu3NQFLcpgv6czjfrJJXAnmygqk5NcLCVTtawQW06d/il6p/2X0eyAe2IS5lKm5uK4Tc3lty3ldg6Y6FSVcvTckNdovBOp8omYUgZdAxHuZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLRnBwAb4OS0Yco/JHpcNfxHtfCgWFIHT/6DcRAJCXg=;
 b=LpBNVlsMKAwN3Jmdr5/rQJ4SyVoWAO9sFsb86GOr/5kQ2CsciQTbIsW9iYQZDYB4Xn2qT2PIIHXqv63++ftfOfxwCFbTNZVFLYVrb4e2CREP32v4Bv4LIuPjtLN2J+TaUOfV3901sthWb0gtBVnk2E6o7Vl0Jhyn3HArOl3A26c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:54:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:54:45 +0000
Message-ID: <62a03ffc-b461-4097-af03-25d4cdd1388a@amd.com>
Date: Mon, 17 Feb 2025 13:54:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/26] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-16-alucerop@amd.com>
 <67a3ea6d8432e_2ee27529434@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3ea6d8432e_2ee27529434@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 472981ca-3cfe-4b3e-3b3b-08dd4f5aa2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vms2OGt2YU9pRllZeFRtMCtZSVFMUDBSV0pqZDFmSmc0Y0xBUmxZcThxNUF6?=
 =?utf-8?B?bzZqV3dNemNJSm0vbGRwTWx5OEN1UE9xU1lxTHdEaDk0amZ3WG03VGpDM2g1?=
 =?utf-8?B?Z1VDMzB5MjRlOHdwSktoZGxyM1Y4N3h0aFRVVDFnVXl6OERyZzQ3cVY5b2ZC?=
 =?utf-8?B?WXVwcmNMdHdNSGg0OEp6ODJ4cVVLeVBHZWR3MnpvVVJoMHZiV242L3dPMmtU?=
 =?utf-8?B?ek1PWnJiNDQva2UvOTNFMTRoUWhSdU8wQVd2UERuYTRYSkJBY3NPVlNnUUZp?=
 =?utf-8?B?M213TnF0d3BxSk1yRmR0MmFLN2Z4NWtBbzhUZUo2SlVQZE8rSUU2Ukp6RGJ2?=
 =?utf-8?B?TGRmUXNaelorOWpld0dyNjRMK0dFV3ZvVkNmZUxGdytXQ2hSRkJRRzVLQXUv?=
 =?utf-8?B?M3VkVmNOb3lQV0UvdkZuN0plVmU0M2laaWRJWUJQMlcyTDM0QTJuZG1UclJs?=
 =?utf-8?B?anlhKzBRSFQ1c2FnZFdQbmp3YzVwc0JuQ1RrUVBFdTQvYTloV3EybVkxdUxz?=
 =?utf-8?B?MzkwQ0lvVzJiYXNlQlpvZTRmRnN1eTFzVVN5dXIyd2wxSCtROFA2bHpTOXRp?=
 =?utf-8?B?RG1pTlpScXUrbVNHTHg1TGNvMjkvU1J4ZVVXRGhxWWdwOXJlSDNTaXY5aHps?=
 =?utf-8?B?NnJBZU9ScndkTkJWdVJLNk1LeU5jTUw5RUw4azkxdmt2cUQvYnVYdzJXSW1q?=
 =?utf-8?B?ZzE1WU5ac0FLcEZaMHFEWDBCOU83ZUc1Q1NpTjVKR3VrbUkvcE9QenJhOE1Z?=
 =?utf-8?B?eFIyUy9QTHFSYVZPYzVlejZsTnlYRS9DakFtRC9paklnUVhIQXZWN3paS3dB?=
 =?utf-8?B?bmFrbXZTa3BvR1JDMEpLeWYxWDlKbkh6bks2ZXlYT3dBZ2UzLzZmZ1RJRnNF?=
 =?utf-8?B?N2lGU21acnpPWXcrWW9nTWRLU2xSR2JqY3AxYXJVK1lNNUV6TjQ3MUZVK3VY?=
 =?utf-8?B?ci9XcTlmMHVCVW5BK0NFeVdSbHRoNjNNcFVuZG9oSWUxZ0N3UlJSajgweklL?=
 =?utf-8?B?Tm9Gdmp2Y1F5Y2p2MUZGd2Z6L1RLQU5xMTJ3L0h4Q1lnS2JjWElCcjM3aG5j?=
 =?utf-8?B?T0VjTnVoUTBEaE8zaUFod284bHExVk5HbS8zODRzclFMaEVRTjFFWGdrNXdM?=
 =?utf-8?B?WVlJMUdTMGR3cnFnczRBRjYrTzZ5dEVRZ2IyY3loUDhZUUFibitrTXRnRkJh?=
 =?utf-8?B?UmJsc0F1NWlENWl0YjlpUGFrVEZSK0ZlU3NvZGpmNEQ0V2FVU3ZGV1ZJdGJu?=
 =?utf-8?B?aU1pbXVXNXJpclVBeWdUanJnMW9mWUZ6NDYrVm80VHE4SXFoTzZXd3BIMW9R?=
 =?utf-8?B?OHBHREtXbW54S3kzUnU1RFdQSnA0S0dxRFJqYW9MQVdRRC9iZHh1UHJnbnBi?=
 =?utf-8?B?c0l1M3RocFh6cEhmdDdTU09uMHJLZEFvaTBtQis4aVE3K3ExYkE2M0xpSHQv?=
 =?utf-8?B?b0VHZnR2dXZHNTRFMHJuUXU1bC94SFVCSU9vUVc1a05RQXhBdSsxUWNHaHdV?=
 =?utf-8?B?eFZrQWJvQXVnNGZyTUM5WUQyK3VncHljVWZXeXprRDZqb1dacEtYU1ZxRnZQ?=
 =?utf-8?B?WUQ2dnRmc09SeERVT3VyVXdqa2VqMWM5OFpZTHYvczBUT3hnZi9xc3E4YWZD?=
 =?utf-8?B?YkdraEFCR2ROVnNhRjVTRXR0ODVHMkFSeTFIMi9KUVZXcEJmYkpXQzhXdmNR?=
 =?utf-8?B?RnZkWWY2Rk1HbEZpcC9pSFNwd1Q3ZUQ5eDJQdzR1TUh0TEo1cXpncythNEZs?=
 =?utf-8?B?cHowTTVpNXpuakhCSlhaM1dSWEZuM0hPaDQrZ3dOc1pwT0pQZC9LMUFrR1M4?=
 =?utf-8?B?WmQ1NWZXWUxWVE5UdzRQVFFxelhjRUl0UU9RVGw1aFJ5TmUwMFJNckFEdlM2?=
 =?utf-8?B?Ky9zVzNNc0owZkw2cUtQS0tqdEN4alc2clZWclRKZWpTdXlTSzIxMUY5MERU?=
 =?utf-8?Q?+z2VGuTdwAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFVpamljQ0IxS1BFbHZSamxyNFdKbUNlNHppOW85bUJCc0EzaTRyT1U0M0hS?=
 =?utf-8?B?MVlubk14cTNMR2Y4djc5cDVnc2xZK2oyaUprcG9vL0FIWU9yUFJBaFBxTXRP?=
 =?utf-8?B?cEI5RmlkSHZRUitwZjRUL2FuOXJSUTFxYVhyVlQ1Z21vYlRNZ09icmdiY3hF?=
 =?utf-8?B?ZkVNZnp4VVVqNHRQZnZFWXdoQzdvVXNibGpJN1pIWm15VjhEVVFZUlI1QnQ3?=
 =?utf-8?B?TGxoVy9Kb1psMlNvdVdKajRMMmZBQko3U0hyVnRmUU5iTUE2ZndOQnhzQjVw?=
 =?utf-8?B?NUwyRkh6bWRoU0ZrK0U4Uk5nWU9RSEFMRmoxQjFvQjA5TGVNTUU2SUFGc2hh?=
 =?utf-8?B?a3FyYlFXWitqb3hkbTR4WTN3aG5oM09iUHQ0ajVMK3RYSFBDbXpQMHEweC9m?=
 =?utf-8?B?eDdIMThDbXRkKy9FUGhYOUdkdWdsMnBsNy8zaHdGWE1RbkVmOHhodEhlaGJE?=
 =?utf-8?B?WEpma1hadmkyamZDWHF4TnhFYVdqVWpZQk4xSHRENUpvVlRiOFlERmljMmtm?=
 =?utf-8?B?N3ZST0ZVbUhabVgycFIyamNVUllBZ3dDWitvdDBlVUdncG9DbmxvRkdraGM0?=
 =?utf-8?B?REdjc1RrRW5ZdytsaTdZVmdwY2dBam4zRkx4c3JmQlN2V1E1NGNtTkxKMDg2?=
 =?utf-8?B?TzhWeU13YUYvVWhtRXBqS3BQWnRMdm5MamtOWFQ0MmJ5cEhFKzNwQVE5RTFE?=
 =?utf-8?B?TFVOY2lSclFHVjd1STNwWmJJblk0L1cwb0c4WXhNdlVpdldrWlVna3p4RHZ5?=
 =?utf-8?B?Ykx4QkZ6UUVtbU5FQXNYOGpmWnZWQlFvTzJFNG9NWi9jQ2l5SVVlWjJTek1G?=
 =?utf-8?B?RzJmKzBlaXNGdTVwZkRRZVFOcWUzQzVZTlJOcytpMHdzMlo5c0ZWN2hDQkFk?=
 =?utf-8?B?bHdtd3dnd1QwdUJxVkhXa3VicTBJejRjeGhUbURJdnd4eWZ6QWhabzViaHdj?=
 =?utf-8?B?eG8zYU1XeHd0MjI0NWRuTm5NekNLTVFoSk5UVU5aNndhRGJrMEY4TmV6OGJs?=
 =?utf-8?B?L1RRa2lwR0QvNGxDK1FiSlVIZnd1Z3FjZkNDQkh6T0Z6ckRRTTBjekY5L25M?=
 =?utf-8?B?dzhhS1FGbmN1TDVmU3ZXMGQyUWI2cnBVZ2x4Y0tLczUwdDNwTjlpeUEwajE2?=
 =?utf-8?B?eUhBYTI2Q0pWU0ZGNDUyRjgxVXRuWklCam9FVFJTT1h4dUhwOEJBMVkrVTNx?=
 =?utf-8?B?S1VNVUNEZjd1QmFIV0daaEgyci9HOWVzbmloOHByUkRSS09PR25XTE10QlYr?=
 =?utf-8?B?V2lua29razI0QUloYUFWRFJVT1UzMDRhK1RBQ3k2SU8wUkdoRkUzYkFVVUt6?=
 =?utf-8?B?OVpETktmTHJTeGtsejlvd2FIY1d2TzRobGRiNndRNk1vYk1aVUMrbitCSVN1?=
 =?utf-8?B?c3c2ZTdKUWNObks1ak5YcmhOTlBEY29ZTFRpQzg4RkdmOUZkbnFRY0NMQktO?=
 =?utf-8?B?MUV4VnFOenlXL2ZwaXVsZkRqZlN5M3d2NkNqT0NUQk9QQUp6V0xIL0lpbTMx?=
 =?utf-8?B?amhCUDVsQVQ3aitvMEFpcG1Yd0JrZElhRVdIczBvR0VaMFo0NjZQMzlwbkwv?=
 =?utf-8?B?eWpabW5PK3czZTkxY0s3QVIvdC9lRjhUeHlHQmlJbU5lbGFSQzJRT2cwSnU0?=
 =?utf-8?B?OEZqcis3bGRXU1VNbnpzYStKb0NYTGtSMTRzTTkydHdJM1NYMjd0b0FQeVVZ?=
 =?utf-8?B?TWlULzZTbm43T1pRSnl1amhpM05yZm9ualN2cFdGZFlLcUlIVUVYK1l4OHlt?=
 =?utf-8?B?VUNER0dnQ3pVTEdwOHR6dUhETkZ6KzhzYkU5MGpYVkpYNWRYUzFtb0t1dXZz?=
 =?utf-8?B?c2dtRVdRNzRRRlBVcHQ3UXhmMkJsUWtjSXU2aEpQY1RScDFoa0JUYlFmZk5S?=
 =?utf-8?B?Sko3QWdyZVl6WmRmZzZPK1RMVDNIajBtc2I2SWdKK3NJbnhCTmJES0VmOXZH?=
 =?utf-8?B?am1OdXozWHlodmREVlZqWS9zU3Y1ODIyOVA2N2lYK2Q0M2E3eVlzT1J1ZVJq?=
 =?utf-8?B?Ti9hc1dJQnVtSjVDeGZNdFhHVHpRVkRsSTA0dHpxS241UVRUSDV6WXhXN3pU?=
 =?utf-8?B?aFhUR2YxdmRRcDQ5RFBNNXNNeDJMaEtDUG5JY3FEd3FVbEtESDhOd3lNOFJT?=
 =?utf-8?Q?arLpKIn8nUOEPTe8dG84iRYs9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472981ca-3cfe-4b3e-3b3b-08dd4f5aa2b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:54:45.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJu8oqBuiAxp7VYfBdskcXj7XDTad3l0LEBWDQKk7cEH6zISMQL/f+0/VLLN1b850k9/QrH7fgRSxD+PCkOS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131


On 2/5/25 22:47, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
> [snip]
>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 774e1cb4b1cb..a9ff84143e5d 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -25,6 +25,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>>   	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>> +	resource_size_t max_size;
>>   	struct mds_info sfc_mds_info;
>>   	struct efx_cxl *cxl;
>>   
>> @@ -102,6 +103,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err_regs;
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> Won't the addition of CXL_DECODER_F_TYPE2 cause this to fail?  I'm not
> seeing CXL_DECODER_F_TYPE2 set on a decoder in any of the patches.  So
> won't that make the flags check fail?  Why is CXL_DECODER_F_RAM not
> enough?


It does not fail. I have tested this and I know other people have had no 
issue with it.

It seems the root decoders needs to have specific support for type2, so 
this is required.


> Ira
>
> [snip]

