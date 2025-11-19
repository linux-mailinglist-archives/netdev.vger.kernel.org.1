Return-Path: <netdev+bounces-240080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F4BC703DC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A467D3C617D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B413371DCA;
	Wed, 19 Nov 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qY9G/hhs"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1D361DBC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570020; cv=fail; b=AIoLPeqd1TVO5dUQVrBSaVDVu8uASWNuP/dFzXDVG3G+Mn0rXE2JMk9298CnsyrVOyzfIdtJNfmbDjLHXClQnaQdS+uA8z+BfuQYls06ObrLCkUG1XBS+JdyjQeWEbfijez0cJ/aP55dLTqSdveHaUcKNHsFMcTG2cq+iDu/sZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570020; c=relaxed/simple;
	bh=Pj/yKJABGp85rien6lfTh12GRUcxwpzllVqJ/wG9w7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSaE0AWozh3eFc+6gEfOY9bxX/GY8oIWlcKZMjEiOAEpRjSVuq27+URcabO6qY8dQCeoe5MSPvdTvLKoJmaVyIa3mIFUf5FRUrYd07jW6jeIc4gE36T3uvGST+dznJ8XMvk4saydQV4A9z4l0ouxqFS7lG1JQGyn5lBBKYDrjDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qY9G/hhs; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS9CXW8faq0OPpppqcC+dj/dcwRFpT9ezSuAl4GohpudcTEJwhDLUBKJuFRO+kefd4fcJ9rZ21Nb1CtlchECnWXmNPEvTewULuJSSlw3o40UfrPJ3P57kqgUFVmtCLHLVfZ6jF3Zqce0FWHWlj/UCRGlinQ8tvDeknwx4jIBe+fTyo3TFgrrszUMYOQZGAvmTv+nc5JlJVGQMe+jU3g6dxF3k/DGo8XmNypJypn1j8OY7DJOSS1a0ghwc4NqiGFjAwUebWBRR0BcDP0KDgsY0qRew8vN5Pm6Id/2fAaKlB2rKkaZWeb78XbLifb+E5XJ6KMWSNcJMUZPDoxQSA2fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FVIS1Iw+SVIJ8kBFLEpHZzjwSLAB2XciKwEQW5aVBE=;
 b=l0dmQ0LcdnaSQLiVi4wveIvwrcqovJyvNS+icFjDl6JLeYyOeJ6hupF5azpj8j++6z0hvTJdmbaTQG902YYsbwPWcLPiwFkTAhStbeVCuIKfYEvA0TJaonsGr3/7fdI1IJIXMDevs5pFi12hWXXjlvMW6kKdaJ3kmRd3MK5eRlCEbhzVb9efHweoeeftl+kaXq/9fiTd64P4kQjOZJOS5mkBPXfZD540iBTWRxizD/xK86zzVTvIuFKSCgIDtp/SvLUfA881cEckYg0lmAcA3FmAjy5FlFrX+8Z8ORae07umtYe6OV/E8RGcgABWTf9UqVlwtxYIjd0Ajj35/igCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FVIS1Iw+SVIJ8kBFLEpHZzjwSLAB2XciKwEQW5aVBE=;
 b=qY9G/hhsKhox7IkVziW7bue0wwUS130JqtJRYe7YtSqYCquce38dCxffY/m/yPKUrlaWz3+QAVkZsDzGX25oyF1uQm9orvESkRxDX3zMBkL/t/GJ6dvqqibxfzExM7Yg9QFsqcwyU7tFaVdvaGgL88PPNOSw4Po+e4+nVQBlNoi89n5qQKVztVNzE/gbm3VJj2lNSn5eG4LySmtY/IO7yyklF3inZ8+ASkdhkSgPsn5u/YtPdVciqP/l1GpwfJWAVzRxjSdg0JMsyEkoTWiNBCkyzWf/woJhoZL/xthKBob1ytsWyrNTymsUeMkrslW6XmLHhoP2PJa3cgYL6I9NDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 19 Nov
 2025 16:33:35 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:33:34 +0000
Message-ID: <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>
Date: Wed, 19 Nov 2025 10:33:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <20251119041745-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119041745-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac61c67-9848-4684-465c-08de27896202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXNvaGd4STRLNmY5anoyZ2x5OVM2VFlRK3cycUx0YmlLR0UzUFcyTFg3ekh1?=
 =?utf-8?B?VW94TFE3d2xkcGtDanQ3WmlwMU9GREVQWUd4OUVOeUFNREtGT3A2S21qd3lv?=
 =?utf-8?B?R21YUDBMWVhYL1RvV2pVK3dWWjRtRTRsMVF2YXBLNUlvWXF3aS9Bck9lOWhN?=
 =?utf-8?B?Qm5Qd1ZTb2FtaW9LbFB3NjFJUHdUQm1UTVk3MXZuQjR2R1pUc3BRYzVwcHNn?=
 =?utf-8?B?VU5saVgzL3dZL0pNQWxjb0Mwbng2dnFJTVdKeW1oWG9zeEFJTklHNlJ2VXJH?=
 =?utf-8?B?M1RzRGZscmtNYzRTQXRwTENUZHRhejN5TXluTHdQLzJPdExwNXZnc3FMNnpk?=
 =?utf-8?B?M0RsYWRBd3dUWGhqRndCY1B3eEdadWVjUDNHWnZ3K2R1eGg4VGJrQnVpcE5w?=
 =?utf-8?B?R0RJalI3K0VBOEJETWE2WU0vS01OclRTY2pweVREcEFGNnU0SGlhamxndS8r?=
 =?utf-8?B?M1ZCL1orQUxuYlJlUjVPUDVqZVZ5VFNVUjZ6TmFUOVVVT3lkRzhkbHhWWFFs?=
 =?utf-8?B?OHY3Q2cwd25xN0F1OTBFRGpPT1dHUzdkeEhJRHpDNExtcGR5Z2lHOEM1UFpw?=
 =?utf-8?B?dWNLZzJocjJPSkp5anR2eGdXT3FPSUVFMnlBVitZTmROUjhDQUtsQ2dISGRV?=
 =?utf-8?B?VHlrRThlU2dzMDBad21nemxoVWVvWmRBZ0RxQy9sMFNuZW5sYjdTdWY4aXZE?=
 =?utf-8?B?RUh4YUV5RGNzOEdSYVE2dEI1K0s3blVqclRtSVhQRDdMZUUxeDg3czFvSE4x?=
 =?utf-8?B?RlIzVDdIbU4raEptc2FydkxCai9wbkJGTlRiYUxDNGtwU1RDeGVKbzN1OTEx?=
 =?utf-8?B?KzhCNWVpSzk3eFRRdU9NaGNhTmxudmEvNnpOZjhDckpVcHVYY3BkSW5OTHh3?=
 =?utf-8?B?dWFXL3I2OFo0aktUK2RmamJRQnlqN1hKNmJXcEVnd1p1aEhFUXVsYmh0M0Qw?=
 =?utf-8?B?bFArQ2pJTU93dkVJV01xZndwekk3Mko0QmxOQWVGZG9YQnlZMWNRdDNqOEp3?=
 =?utf-8?B?U2dtOHJkNEU5SW9BSzFnM2QrTUdaeHZJSm5jV1ZiekdpOHZxUXh6Z1VGa0NE?=
 =?utf-8?B?VDJTMXZPTWdZNGxsTmZ2cHpINjlrY3RUUHc4cHNOdkE1Tnc1QzRaa1djeGQ4?=
 =?utf-8?B?NXpQSTV6NkRUb2k5VmVCUWZISi85dDV6YUtWTHpJREp3Qk1YWTd6SVBnemlO?=
 =?utf-8?B?a3RiZnI2ZUllUTFpRktnUzEvNHphQ2lZQkF1WGZuNU1GYitQN2VnYzEwNENx?=
 =?utf-8?B?cy9rcWFWSnU5bWRlZHVKcCtrK3NDMVN4Z2grNWMwaDFVam5tSzgvMlIzcTc0?=
 =?utf-8?B?UEF5NzBIL3pja3Bick9Pa0VlVk1TaUVyTG10QWFvRUxSclZwRXJFb1RTVnVR?=
 =?utf-8?B?RjVRTVBCZ2Q5TnhtaE9ZcUVrZ0drd3o4U3d0V0pYdi9jNWUwdUc5VS9uV3Jj?=
 =?utf-8?B?YTNNekRYSTBRcWRVMkVMeVJkMThZRmkyL3NqQjZGSS8wZFNlTk1odjVrbThM?=
 =?utf-8?B?bkRhU3JySS9Tb2tuY0lXem53cVd4cHFneVExeU55eXlaYkljSllWVzM4anFR?=
 =?utf-8?B?TWtXYXplSlFMMThZMHpDMjlPcWoyQUhRamlaTmRtTUhDMkJWOVJwdy9jNGhZ?=
 =?utf-8?B?UkhKdEI1eVF3ZDVYVHowNzBOM3FkNUdjckg4RjRkUzRRK3phUFcxOG50c2kv?=
 =?utf-8?B?aUtVUndoaVBzT1NQL3orSklvVUxVUjlVNlVLa1FwZXdvKzRhbWlUVVR1dTJ5?=
 =?utf-8?B?VGd3cmsvTk9wZ1VGL2pPdXlXQUZmU1A2Y1NCS0JqU1B1MEdocFZBN09TWG5W?=
 =?utf-8?B?MlJKUEllTVFSU29NWEdtYmxLcWN1STRsbE9OTFdQeWs1SjVrbzNIcjNXZzRr?=
 =?utf-8?B?cWlyY1h4QkM2Wm8yd3FuZU9rY1VYMnJnajhZWUIzTzRrOU12VmFEVkRaTks1?=
 =?utf-8?Q?1X0bRm4rCuZpXuPSchl2VHy0vPGVOWSq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGh5OXJzbDRsbm5EY3lJVG4vUHhjNjRBYzBaampCYmV5cXdKbXJqZ2Q0VTMv?=
 =?utf-8?B?S1FJQXR5NmpWQ3ZtUkRyWE41UVREQmNFS0tVVEJLMDJoM2dZd1o4NkNmWkpN?=
 =?utf-8?B?aWxQUGIyRXlFcTRjekp4T1JUemo5SkQxanZmQXMvS2E0U0VOTTF5VHBtTmVi?=
 =?utf-8?B?cTVISVI2SWZ0WlZMSU1tQ0hodTE2TW5Ia0xnTWNvQURzSHgvN2VhYyswQUFv?=
 =?utf-8?B?eGpKOXFDSWh6UlFtQk9OTU1ieXRFeUFxR2lWTXNXUDRiSXR3Y1BjcEdJSmJN?=
 =?utf-8?B?N216TEZLeklJZVBkQ3pkQmpYRFo5dGNyNFR0OVo1SlNXM3h0NjRibGdqOE1w?=
 =?utf-8?B?M3BLK2dPWDlkTk1wakp0SHozR25lZ2thZHhSM2l3T1VyNGt2SUhQUi8vNjJV?=
 =?utf-8?B?NENKTzU1SUo4MW9ITUZGTUN1TlAvWUI3R0J1MzMrdDlvVkdaaGgrWFBpcEpu?=
 =?utf-8?B?djFzN2hZOTY3QnB4UE9KeEhSbkYyQmwxcktiV3NzdW4vTm5DYW5NUEN2b1VF?=
 =?utf-8?B?eGVRTTc2NGNQcEhxQmMzZU5VSGt2Y1U5VHM1NHRhRVJMUDVrbHJRRTNQbVE3?=
 =?utf-8?B?SnFwV2x1UE5RcXUzQkx6N0d1V2ZYQzdrYWhFNHJpNTl0RGNncUVHNHQ4OVps?=
 =?utf-8?B?QUswdWVaREhxcWFoQ1BSUDBiMjRHOFEyVm1DRnNrNEw4djNxMEhtd2VnaXJV?=
 =?utf-8?B?amJaUEVid2JWd3JPcFhVOFdKY0gzVHlXMFVrMXMwRFUyc0RtaitiWG55WmZs?=
 =?utf-8?B?VHdEMUZoVlBFcXplR3J3dVVIT2pvL3lBeFpEZ2lLUWJkMlJrZ0xDMC9XZXAy?=
 =?utf-8?B?UlFlcDRhb2VHRUtNa3ZCOVpnMWlDNnprTXFRR2hJc3VqOUFxRDEwSlZwc0Y3?=
 =?utf-8?B?a1NsczQ2eVIrdHdTK2ZJdUxuTHkyN3ZIZ0R1N0dBV1J0ODVKdU9HNWdSK2FX?=
 =?utf-8?B?ZFRUSWNKOW5scWhPdi96YUdKSWhIb0pxT01QbTRJVGhVaGRUSFljb2dtZVA0?=
 =?utf-8?B?MFROSitHZm9leTU5K0ZUdkZDYmEvSyszQ0ZjRlJYN3M1a1RYb1UrSlN6K2Fo?=
 =?utf-8?B?c3p2c2VlRWM4MVpGcSswdVpHQWFhMHZOQyt1Ri9FK3RrSzJIaWNQcndxSmpN?=
 =?utf-8?B?RHJWRU1aTDFnYXd1U0craG9hRnZ4MGFBb2hTaEhYU2VxUmJia1k0M05TcDVl?=
 =?utf-8?B?MW5mbnVEYzBIVUl5ZTZ1Q3IyWFBnK210dkxMeXlHTzlMa0FyRU1YMHVocjVa?=
 =?utf-8?B?QUx3MXhEY2tuSFk3RVUvNmdpY1JPL1FuTHA0UDNrTjNhemlWQTFla2x5WG9t?=
 =?utf-8?B?Q2lSV2NsTTV1QXh3cWd4UFV2d0hhNlptZVk5TXJPVXAvbVk2QU5ZR2tEY3NZ?=
 =?utf-8?B?dmtFVE05TVF6MmlxQXMyei9qNWFQVkljRXBFdWpqOTVydHRPQWJSZzRoaDgz?=
 =?utf-8?B?cVE5SkR1SWtHOXBkOWlDMWIxWTVuOWVyaVl5K2diSmhYQTRCOHFUSHhlYzhl?=
 =?utf-8?B?eGsyZCt3Ym9hcUpnd2hFaDBIR3MxTHlMd1JnK0VqQ0JEaW9GSTJ1NzgyWFhD?=
 =?utf-8?B?KzdRR01uelJEN1Y3UmM4N3h2ZThYVDhGVjZGNXByQ214MzUvYUYwYS9aKzBH?=
 =?utf-8?B?OUlnZUNmMTJ0eWdSNUQwaE9Ec3hQbHduQUZqN0hySXBocWtVU3VMZW5YSG9t?=
 =?utf-8?B?Z2gveXpHT000WGhDdzBMOHhVY1pyMThhVTBidlpJbHQyTERFNFhRZ1VMejJk?=
 =?utf-8?B?U3kwbE15ZVl5cUVEWmhGZ21DR3RUUXIvR2REMHZOMkNSeS93NGRZTHNzMFRZ?=
 =?utf-8?B?ZFQ0ZU5KN0IrYXdZa3EwdHU5d0dWY04vN2JIbUU5WFFORElhUys4K0ZQcUh2?=
 =?utf-8?B?MmlkYXVSVW05UU00aHU5WkIzQzdNblE0aUQ2SjNWRnNTMnphc2Fudncyc2FE?=
 =?utf-8?B?VEloZHRHWi9qSWpBMGdnT1JzcnVpWVVoSFpzckt6VGxjYjdVQlFFRGpLVjUw?=
 =?utf-8?B?MDlINzNXTE9tNW9rbmpldi9pVzZhZlVXWnZicjhqRWtSZTEwZTdOVmhCclJ5?=
 =?utf-8?B?Wmc2Zlhhd0RYb1NtMENTU2NSVkx1d1FnZVdoRUdiTDVJT1hUVWNlN0xrRFdY?=
 =?utf-8?Q?RjCBtHjMDCm7rPYsLZknID3vU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac61c67-9848-4684-465c-08de27896202
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:33:34.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQuLqLPDaTnJxABMUjUimqL8UpGE5w5XUU+jUG/z68SteKJYMbrIOsNXJ3OPiyJav6+ujRuB8BteaCPUiAQREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

On 11/19/25 3:18 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
>>> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>>> +			     u8 *key,
>>> +			     const struct ethtool_rx_flow_spec *fs)
>>> +{
>>> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
>>> +	struct iphdr *v4_k = (struct iphdr *)key;
>>> +
>>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>>> +	selector->length = sizeof(struct iphdr);
>>> +
>>> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>>> +	    fs->h_u.usr_ip4_spec.tos ||
>>> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
>>> +		return -EOPNOTSUPP;
>>
>> So include/uapi/linux/ethtool.h says:
>>
>>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>>  * @ip4src: Source host
>>  * @ip4dst: Destination host
>>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>>  * @tos: Type-of-service
>>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>>  * @proto: Transport protocol number; mask must be 0
>>
>> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
>> documentation? But then shouldn't you check the mask
>> as well? and mask for proto?
>>
>>
>>
> 
> in fact, what if e.g. tos is 0 but mask is non-zero? should not
> this be rejected, too?
> 

Actually the tos check should be removed, there's no guidance it should
be 0, like the other fields. Our hardware doesn't support it, but this
will be caught in validate_classifier_selectors.


