Return-Path: <netdev+bounces-231272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E8BF6D40
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3E3B5628
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02602338587;
	Tue, 21 Oct 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rh8MgFI3"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915233345C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053936; cv=fail; b=cOmBV0u7niP4rA10+o8XppsmjJV6QhZfIJNnQ1s5nKk/Gbe9VAAOP/DYSlmQTsGcNSNhkmLPDQq1Ukyqc0O/NQtDBSTjJw6FMVx/FwiAZghZe54tS1LWpocepC8xqkWOAAGsJSho3wbCPARIuAqoRFMWnMi7m9+QJy7LFoKTwEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053936; c=relaxed/simple;
	bh=wHVxl8CI1M/MdypO23Ofd308lznnv0S4BllVoJOeWNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qn7fmbK5d8KyhLwaGd9JxLgRG3n70iM6ENIFUMeDo2TVbMCJLIdS3OH1m66WrrUECv/Zf3aLtI+AVeKCLX26g31adcU9ibmXDfjIEfz9qI20N+fGMDCEc64ouBNrC39ffxhcZ9Cqn8To1sM+mNCHpDOldhPWuLe3wHzaXQn1b78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rh8MgFI3; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGVIo9mp7D35HwBNTflY5R+JwkiDMPp3BEQvXoC2q1wuo9C1n7QoAHKLIjU1QywzLkVehifp7mGoDZu0Fs4yW7/OV/nKyWsYKJJcA/GxvJQ6UioXuVlQtTtoWXkzzZLr7qm6WrI/Rw6cxrp//amrNtRKFSWWD9tM/EnNpn5DxlBjWDySIO3rYJMddGdgRXTMSAQUH1AaPYHUG2cS3z838HZ5H6+KOuQwbmp6yV2WU99qM3TqDt2fWu+4Aj5A94MIJl57l0U1ssN9sy6t7pq4ALNdV6PRx32YYqUw9kUdABU/1wMsUlwvFn2IQn9qy7dylMO9j9Xk89B4RTKN05cq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U75906ZFgaGNBHDq/umxR3wxDu8n5YD/DZ4fdmApIAw=;
 b=ijSb+53DneWqPhgFreJfN/rNrEypcxp3eaFEpDCUEGJif9e31/QhTcUvGwrNiodazdJXIT929xhw5wpOoGEX5cS7/2JUtUhlKJZVbs2zSRI8MvR3hhsuCnqxf2OUjCva5e5GJtXNxmHFz+wBZK0qlMeIExe1xAXjjIHoA0Z5UYw6CjqD5uXS77ZO4VkkQc04n3793GXL3/akpx2baCbb5lFWBqgpXI6DPtpMrNAFjIRqF6qyUxu62tXk/JlWv7aaQi+ka2vyDShYIb/9pAgAkbu9yhUKrocsVkafIS1WQ+PGlxpmYmywT0FKNQhJhlsNzPLOkMrhpMAs9Ky66C44zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U75906ZFgaGNBHDq/umxR3wxDu8n5YD/DZ4fdmApIAw=;
 b=rh8MgFI3feaazxjBMkVURHEovhzLN8bKohb/OpWqNj3BoB3/RrlqlzjAwK+2skf9uDJByzlcyCxilZH/LLD914bnfPsL+xrzgBrkQ0Qn6rdy1SiLA4fVC33BF6tjfbLS/t1k/CEjgNatPxrkjFd1FamTEd45FNmrTQL6k8FWgDhAYdd4Ww5nVh6no6YtDgAkyPXAYr5o0/ojsnyKZA7ZsPdefF//k5L/UYuxaUxmE9FGwTsNSioZqtoL1dr7u7wDVCNj1q/rnMDjadbRBRuwYypWKtXJ4NisdKt/hGxcoiOWBsIqMWXjFkNf8GAg3MC5tKlOUHdoR1fp4xCgA/dcjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 13:38:50 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 13:38:50 +0000
Message-ID: <b37d8e3e-ce0d-4778-8b1a-022cbd854cbd@nvidia.com>
Date: Tue, 21 Oct 2025 08:38:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251016050055.2301-1-danielj@nvidia.com>
 <20251016050055.2301-6-danielj@nvidia.com>
 <20251021091259-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251021091259-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 737a642d-5f8c-4fde-f063-08de10a72b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9RZzlMTzZNR0UxK0ZvVHlncDc1aHEzZ2RoUVUzd2tBbjRkMUYxUzYvOVM4?=
 =?utf-8?B?bGR4NW13WUhwSGtnZlBxK2NLU0JWSzlSYmZyY0JwaFFUZTBkWWlybHZjdlpO?=
 =?utf-8?B?c1EvMWpzd1RHRlpBWmVEcy9nNk44NitFeFA0a3hPSU1Nc3ZHTFU4bXpVY3NO?=
 =?utf-8?B?VGxYbythbUhNKzZreEwrSUR6SW5tU2tLak5mRjJiOWJqSHJSdmF3OWNQZEhB?=
 =?utf-8?B?Nm9RUG9QNGpFNzM3aDZ0dUtpSmlEYUlSVFdRUVBKbjl2N0Y1QjJLaWZ1MWtH?=
 =?utf-8?B?S1FIKzZ3YXB0dzRqN0IwREtBbFBqem5VcytCNUVCVDFmWUJlbHc0Q0tEZFdB?=
 =?utf-8?B?UzJTL1dncmFtQmU2c0NlZ01WWmtlVzQ1ekNYMzEwaGhaZGRPdVovMUVvY3A5?=
 =?utf-8?B?VWpMSC9ET0pZUVgwRmdSY1Rra1kySUFiOS93NjVtQ1hNL2hNbU1VUUQvTnli?=
 =?utf-8?B?SytoQmhwTHo5blhKOUxWbjlpeExyeGZ5KzdIQStQQnluME9FSHhoaVI3ZHVy?=
 =?utf-8?B?anFNRGtaU2NCQThHbERPQW1ZbnI2cEJ6bzgxdHNQc0wva0lzZ3EvL0MvN1NE?=
 =?utf-8?B?a1dpdnlwNWlEZ0ZqQTdFSU9VUHFuTDBOQzN1a05NSlJRMEx5czRkT016Wnhr?=
 =?utf-8?B?VzFXTG9CM0FVT3FHZnhYTWtTMms5TWoxQzRWY2NmSDZEWDZJTXpMdGkxNHl3?=
 =?utf-8?B?LzhDdS9JUitwbkV2ZXNKSE03YzJqY1ZITkxkUkkxTUdIMU8zbVlWODNsL1Qr?=
 =?utf-8?B?djVRN3p0ZXpPUnVIQmw0SmhSOTZYeC9EbnhIZ1ZHY29uZ3pTdXpWckEva1dx?=
 =?utf-8?B?ZXRHVk5wL3pSOTF3R0FzOUpjaS9xUFVJQWRnYTYyUGVmSm5TWHl5QlordHlV?=
 =?utf-8?B?YUlJSVZQaDNjU1REUXlnTytxVitlOVFTU3NZcGpMb1pDWklXdVFLb0xpMDN2?=
 =?utf-8?B?ZUk1VWJTbThCQ1M5RDQ4NEdBVDdBeWsrMEVSemRSZTZhbWtPS1h3cTVRVGlY?=
 =?utf-8?B?K2gwZnhIaVU1UEp3WEg3WmRuM0FEbWdGRFZLKzlXM3Q3UGdUOVBsTlNsVEZr?=
 =?utf-8?B?UzVOSUd5NkdxcGtXZGo2R0t1OW5xTEJlZ0JudjBraFc1ZlBjRmtySVNSN0lS?=
 =?utf-8?B?WmlJOGdJNHFEQkpZSnJxUXN5RmRveENCQUI2djJGOVFEVzJVNEtxbGQzREhI?=
 =?utf-8?B?Z2pCbHJTejhhbFhWaDFZOCtMRFVYQXpJekhoVXE5TFQzNWZVVWVtU3dndENM?=
 =?utf-8?B?Zy9pbzd2b0dmMnR1NWsrVGpzZlk1TTJNTFVGekxuQXY3ejJWUTBaMXYyc3RE?=
 =?utf-8?B?bmYyN0VUa3Z2ZFBWT0dUcm9qa3VLSzhyOUxMUWV3YzZkVlAvVDFlUXdodjhF?=
 =?utf-8?B?T2dyeGxpVTRnYklJOTR6U29NdVk4aGE2cTlHWEdJcWNZaHd1MnR6VWkxVXAv?=
 =?utf-8?B?WW5QR3hwZlRIajRLM1lEZzNaUkg3MDlBek9ZRjg4TXBTeUtJemFwWUdOUzds?=
 =?utf-8?B?K0YvRlJmSEdJcVQzWU5QZXFqY3hFYTJwZThDbXQyVi84YnBRR3ozVDZCUC90?=
 =?utf-8?B?TFIyRDh1cDU3RGtGNEwxRHV3T1loQjMwd20wdURPY08vTEw0NGM3S2paMXlq?=
 =?utf-8?B?RGY1RDFMK1ZhR0VRK0VKbjNkOTQxR3ZyL3lEZUxxN1JwdktOcXZmL3lXM2NQ?=
 =?utf-8?B?UHBOU3BvMTFMY25iWDFhMmVuZklwL0JGR1NKd2t2RmRDRWZMbHRqUXFzc0xU?=
 =?utf-8?B?VE5DRUFEUjRwY0Yrand6Vzl4RTlRZ0pJcmZtWXFCWlJ4cWx4Q1l0SHl3clRP?=
 =?utf-8?B?RUlxeEM0cS9DcFloeWdDcmVHNlBCY0Rhd3JBd21oWGJBSDcwVXAwbndjYTRB?=
 =?utf-8?B?NTI0TDgzKy80bjFRMTcvZitMQXBUWnQwWnU4R1NlYWJaTGlVenZZdXdFa2N6?=
 =?utf-8?Q?iWeHgN+96UZCLt8jhkvokk4ftF823usT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRlTk4xcWFBQlZmUGdyZjBPSi8zdkJBdXhhdXhhRmpNYlFaOFdSZllMRGRs?=
 =?utf-8?B?N2lYZHBzSDVENkU3NElmU2dKUDhjNWg3UENiQkxyL0lnd2xRQlVlUlBudFdo?=
 =?utf-8?B?MVhRKzZTWWFXL1EyREI1OVFTeEdwVEVSZ3JHeTRjUGdyanZnWXl2SFNyZWRX?=
 =?utf-8?B?N21IRkszUVVzeXEwbHVpVGZGV1c0MVNkNzRHNlpQaHdiTGhuMitwRTRaVXFR?=
 =?utf-8?B?UWpZM1BWRDBVK1lLcEN6RHEwMXpmcGZFZ3ZCVSt6S1krMGR4QXE5bDRMYnBR?=
 =?utf-8?B?SkJlbnJtRWpHUjErV2lyMy9zMmVBZnVjNzZuY0pYTXliNU85SDFEWXlmS2xv?=
 =?utf-8?B?SXFyOHIrNGE4WS9xaTIrb3F5UEExemwycEoydWxJNmZ5MFFCaEg5Ykw5Y1pJ?=
 =?utf-8?B?STFJT3JUeVpCRWp6aVJ4TlNJcVZXV29SMk50VmJ5N1A4UnM0eFUvZVNoNFlo?=
 =?utf-8?B?dWxoTHlTRFRlVHhxQUtUOXZkd202a0Y2V3UxWFE4TTZPWDFORTNYYjJmMWtq?=
 =?utf-8?B?TE0rbkx4OGkyK3VzT3pQZjlUZ0xINGFNa0dhelBJOG5ZanFxYkF0TUVCYzJr?=
 =?utf-8?B?Y2VDWmZoanlySi9kOUhRaHFlOGNyUmozOWNrS1NBQ2lIYzlZaE5mR3Q4MTJC?=
 =?utf-8?B?K2k5VDllc0prcUdzaGNQUEQ2dVdtbTFxL1RLY0JIMUpwT0Q0aVBLcm9nbXcx?=
 =?utf-8?B?UjlVdytnWXRtWXRTWENpQ3UwbFM5Rjg4WU5zMm5RVlJlNExQbThadGh4cE41?=
 =?utf-8?B?eTlmT1BnaGdtNnZ4VkRHZGQ4U1hMN0tuTXdIVzRhclZ2b21nejlNTkxtTVV6?=
 =?utf-8?B?ZTJrbkNLOElYNGlNcmVCSEZPRnBNV05MamlEdFhsQ0NLWTczM2hCS1graXBs?=
 =?utf-8?B?UnZJQlUwcXUvM3FpVVJ1OFlXajh2dmhNS2VwaXVXTG9FMFRtOUxDZDQrUkpF?=
 =?utf-8?B?R3Y3aTJGbDcxY01MQWdZVDRoYk1pTnhOczBxWnh4amFDbUxuWS9GU1QwRTRm?=
 =?utf-8?B?U3VmL2cvb3FQU3NhcHlHTkdZL2c2WmYwNWhVWVVyNzVjVHovdHl1RnAyTFYr?=
 =?utf-8?B?MjRCRkh1b3k0L29KMzRTUDdsamYvbDlqR1lkM2FVV01DWFBYSTdqVzlEOElD?=
 =?utf-8?B?bVQzdTlwQU5ocjJUU2lxL2cvbDYwakZyWGhhcFNHNjFVTGZPU2ptZUphME1G?=
 =?utf-8?B?ekxycXlQZmhKWHVCNDdXL3l0bHZzZDdWQjR3SERJcXZyUFZkN1A4UlgyODgx?=
 =?utf-8?B?UjFHeHF0VVNieTJncGxYWkE3Z3JEUW0wM0NIWkZSY296citJSVlyTXI4MndO?=
 =?utf-8?B?akVSR3dEdXA1STdiNVJ5V1dOVE9nTFpQUFZaZWx1NEFMcEU0MU5maXlUeWxL?=
 =?utf-8?B?aWZZNmw4SVcyQzNRUHp0dFhDZ0IzS3FHdDl1L1RpQlVEZzlzdm95NFJ4ZzRB?=
 =?utf-8?B?Y2Q2bjZoZzhMQzVKU21aTGIrZ281SWltNUsrYTRobGlJZHpPV3ZIM003V052?=
 =?utf-8?B?aFBXOHNBOGhWL0NlQTkydHh0WHN0NnBXRjN2MUlpYUxFUmtNWWcrQ3FiR0RK?=
 =?utf-8?B?b0RpZXJwTUFmYUhIOHd2Slcrd3E3L2ZILzgzR0VheWpsMXg5Z1FkbitEbUtN?=
 =?utf-8?B?d3pvT0g4T3ZwNlNtR21jSFgrZUptSW9EYnlheGZhRENaRkdBcnJlUDRqaWFU?=
 =?utf-8?B?Wmo1MUJCRnRpcnFCUWsvc1ppMXQwKzNFWlQ3d2c0R0RzWFJVOVZ1aTZBL1dv?=
 =?utf-8?B?bVdYR1JRZjhvK0hVSitKa2VGUm9TK25UeUJobC9jQTh0U2tia3IyOEhjMFhV?=
 =?utf-8?B?dlI4Vm9XZnhNMDFyREpTUlY4ek9aVU1LVDA2T0U2WXJuTkwrOCt6bnpOVU5C?=
 =?utf-8?B?NHp2ZVJNR3M5Q05jSXdEMnVjWkg5bCswOXBBVktKQ0ZoYkt3dUxVbGNnWmkz?=
 =?utf-8?B?Sm1ZSERLTnU4bTBwWGJWOTArNW5TNVN1eXcvUE9XV0F0YVhIaFd5eFJyOGtB?=
 =?utf-8?B?MTRjSnJJNDBPdElWdmVrbHdPM1NMT3NpMFIwaEpYV0RUeUpDOWJLbDRJemtO?=
 =?utf-8?B?cUYrejNtNmpQelU4b0JadE0xcnBNQmQyeGNHTitkWXoyMWtqa2dEeXZHbWlH?=
 =?utf-8?Q?AwIYFsFF8eeS08FV58aALkogB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737a642d-5f8c-4fde-f063-08de10a72b07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 13:38:50.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZHITQl/L8hOp2SF6YYmkkbRHFPgpgAPv2T679fxnQeNzuycT7CAZTDp6tcQmvZZDkMo7msjTeOUz5bfWM4j3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

On 10/21/25 8:18 AM, Michael S. Tsirkin wrote:
> On Thu, Oct 16, 2025 at 12:00:48AM -0500, Daniel Jurgens wrote:
>> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
>> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
>> +		ff_mask_size += get_mask_size(i);
>> +
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> 
> overriding ff_mask_size seems unncessarily funky.
> use a variable reflecting what this is?
> 

I can use another variable, and check that it matches the original.

The code below is just validating the mask data is sane.

> 
>> +	sel = &ff->ff_mask->selectors[0];
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->length > MAX_SEL_LEN) {
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
> 
> You also need to validate this is all within allocated size.
> 
>> +		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
> 
>> +	}
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   ff_mask_size);
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	ff->vdev = vdev;
>> +	ff->ff_supported = true;
>> +
>> +	kfree(cap_id_list);
>> +
>> +	return;
>> +
>> +err_ff_action:
>> +	kfree(ff->ff_actions);
>> +err_ff_mask:
>> +	kfree(ff->ff_mask);
>> +err_ff:
>> +	kfree(ff->ff_caps);
>> +err_cap_list:
>> +	kfree(cap_id_list);
>> +}
>> +
>> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>> +{
>> +	if (!ff->ff_supported)
>> +		return;
>> +
>> +	kfree(ff->ff_actions);
>> +	kfree(ff->ff_mask);
>> +	kfree(ff->ff_caps);
>> +}
>> +
>>  static int virtnet_probe(struct virtio_device *vdev)
>>  {
>>  	int i, err = -ENOMEM;
>> @@ -7116,6 +7277,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  	}
>>  	vi->guest_offloads_capable = vi->guest_offloads;
>>  
>> +	virtnet_ff_init(&vi->ff, vi->vdev);
>> +
>>  	rtnl_unlock();
>>  
>>  	err = virtnet_cpu_notif_add(vi);
>> @@ -7131,6 +7294,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  
>>  free_unregister_netdev:
>>  	unregister_netdev(dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  free_failover:
>>  	net_failover_destroy(vi->failover);
>>  free_vqs:
>> @@ -7180,6 +7344,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>>  	virtnet_free_irq_moder(vi);
>>  
>>  	unregister_netdev(vi->dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  
>>  	net_failover_destroy(vi->failover);
>>  
>> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
>> index 039b996f73ec..db0f42346ca9 100644
>> --- a/include/linux/virtio_admin.h
>> +++ b/include/linux/virtio_admin.h
>> @@ -3,6 +3,7 @@
>>   * Header file for virtio admin operations
>>   */
>>  #include <uapi/linux/virtio_pci.h>
>> +#include <uapi/linux/virtio_net_ff.h>
>>  
>>  #ifndef _LINUX_VIRTIO_ADMIN_H
>>  #define _LINUX_VIRTIO_ADMIN_H
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..1a4738889403
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -0,0 +1,91 @@
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
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + *
>> + * The limits are reported by the device and describe resource capacities for
>> + * flow filters. Multi-byte fields are little-endian.
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
>> +};
>> +
>> +/**
>> + * struct virtio_net_ff_selector - Selector mask descriptor
>> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
>> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @length: size in bytes of @mask
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @mask: variable-length mask payload for @type, length given by @length
>> + *
>> + * A selector describes a header mask that a classifier can apply. The format
>> + * of @mask depends on @type.
>> + */
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
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: array of supported selector descriptors
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	struct virtio_net_ff_selector selectors[];
>> +};
>> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
>> +
>> +#define VIRTIO_NET_FF_ACTION_DROP 1
>> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
>> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
>> +/**
>> + * struct virtio_net_ff_actions - Supported flow actions
>> + * @count: number of supported actions in @actions
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
>> + */
>> +struct virtio_net_ff_actions {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 actions[];
>> +};
>> +#endif
>> -- 
>> 2.50.1
> 


