Return-Path: <netdev+bounces-205752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C4B0005C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28035604BF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE542D9485;
	Thu, 10 Jul 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5SFYYn2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414D20FA9C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146240; cv=fail; b=XBgSFYxCD9GEtWlCjqdrpe+D7Jio9Oz31tdDeMlyTQlHoBeSIizTCAQnyA13GYh1K4wPqjvWvKs7d69xtY3Ziqw7OR5lzUI+3BRPpxHtnHt6BEmXRyp4FncH6607xDpQ8y/abdtavzvGWagHdV67metp9f0gQ7JBbHSt/rT+lqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146240; c=relaxed/simple;
	bh=s3S6THEfHtZ2VfTNv1V27m2s11uk4XxqOtEThoyUCDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUuECgMdlwcrqKRArlJeHUtj1qjsXgN90AIRfEIz7Z90lrSUnKuGjWG5yWOpmxqu0r/gp5mSQGL2L8RMikoJe0fec9FsIDBCyZGybymGLOKJ2rn5sIJDXGKAfOy2urDDSVCVKl6OtUti/ikuTEyphVO+pYRthmpFkBYRgN2WqH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5SFYYn2; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFbulNAL92lNfIr8j11umR7lpkmeM/FD0A/flfCuw401m7G/xywVUKuvopCqQqzWQQWJ0ExjlVypnOY7QjJQPN0g9cdXDKACsjkYuUjvPiHTusZ00p17CwZ4kbUcGX4TLL/Y5KITkp9JZEDM/dVKaO0H/U7kZrZt/G4PC4skjfpUnn4mEvr7cLqTQLZDD25IavHaFwuyDkINf1fZ3gfMo/P3q3LPeWfD9oDs/CGFEOPQd/o8fOyIhUIMppf25RITnRm7K9ItWKXCdNejH3f/jZIOnysmCo0kfPS+sdeBzhNifhjrVeU/Shcl9a28O8oOsXnwwZMi3YQ2YGA0CIsx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFu5tsYWGL+03g0qbE8OxI4i2qffsf8wpeqY8n3TqTM=;
 b=cNFNUog9lZA2dvUzCn+XZ/uPJ5mscHOF1NoLL4hwMYdxT2xFpiBbg5SvLCBOfDRd8A4UR5rrsLctkJZYiwlunx8QGJV/D7UGXDPEJ0J1Qykt0PSw+FH8NPbnd/e3+wgAZeCVUpHZ5lJnF2uRrxQrvf2ZsIkRCnfLQJnKQ2+7FA+6xzGw4i9MpEFHdh5zldnbmBwQrW+vk2SA+FLwSfiumdSUN37l3xLJ++2iyP8JiHR4+LJ3DuNbSmwxyFg5YPUeANghj53V6rhNzqceojBYY7LVSEB/8X6MGRhTtF48R53oPGgY81ItRfh6LUk7klzWSf/arbO/8tWxYjAAmeB0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFu5tsYWGL+03g0qbE8OxI4i2qffsf8wpeqY8n3TqTM=;
 b=l5SFYYn2TbfdeCFGRHGYAhsTV62v/Nd8UG+bvHtDuWLOHi9L7cxTzrUcIkZ8Q2xU4/r4H8rfIjLM1mOtvcQYOSVUuD+0OBYBCzD/xsEMOKGFCqrSbBeGwrMHL13ZtRpB46vTH8GBsybL189nUK87HeFmIK/IBZBAruxhnqUL0AfSv9Sbzrc0H+NnDUe4rN+jTe44f2F4Ei7jff5kSFPqIRFGKgAdnPpcl63JonbvQrDpKW4mI446eGsBp9GIBbWgUBIVy0oMuqEb136YBjm7u1XzoQuLCjYuZ7SRZHOja9z2zcM2EDHUjrxTMQp7x/ots821F9n7C01aPeti53q0UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 11:17:16 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 11:17:16 +0000
Message-ID: <a6341aa1-dd8b-4449-ba95-38bb067d6483@nvidia.com>
Date: Thu, 10 Jul 2025 14:17:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Fix set RXFH for drivers without RXFH
 fields support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250709153251.360291-1-gal@nvidia.com>
 <20250709172508.5df4e5c9@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250709172508.5df4e5c9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a3531ff-69e2-4f44-577e-08ddbfa35371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVhlVHBpMk9DN3dQaEhVTjFpaHNnQnZPM3NFcEZQcUFNZ0NBTEE0T3NnTjdX?=
 =?utf-8?B?elIyVTBGZlpXYUFzZDBsTXNlT1FXc2I5N2xhKzdsRjFPN3RTNG1mdDZacFZj?=
 =?utf-8?B?U1lOVW9yamh3TzVNam40eVZ5UFl1YlcyUUdMeFB5NGpSOXpxTUZiTGwxQU5m?=
 =?utf-8?B?bUJpT1M5RTY5OXh5cDlLV2VlVDBnWGo4UGdGUTFyc2VSYkpaOXdUQ3ZlWUc2?=
 =?utf-8?B?RXlWNUZTdGdraXZWbUVQYXRrbU94VnhxQkNGY0ZGSU11cENSRzdMbkhWNUF3?=
 =?utf-8?B?WEhvUnIyVmZLV0ZBOUlaWjE0eUx0VERNdHRUQXhLcHR6SVhrV0JtNHpZVzcv?=
 =?utf-8?B?SjBtMWcrWDMvQ2dtVlhtSlVqemx2UGREQXNybHIvai8reWt5UUtweUw5ZDNG?=
 =?utf-8?B?UGpTRzlTTVhtMkIrS3hKTXJ2SlZ4SnlDZ29WNmljNUw1ZkJFbXAxaVlibWV2?=
 =?utf-8?B?ZmxMSXVCNWlqVCttZ2JIckZTQTdyWFVWbXJzc1YrS2VUVk5ZdDRjV3JXU3Ni?=
 =?utf-8?B?bnF1UFFaN3JycXhlVWNnMi9kc2ZHNC8vMm9FL3d4RE5NSlZZbEdkaDRjUlpH?=
 =?utf-8?B?Q1prWC82Zyt5dmN5QlIyRjk5dXUxcVpwRUhjTkFTWXYzeDZJU2MzU0FhaC9y?=
 =?utf-8?B?eFFuaXBuU2t0dE53ZzBENmJPM05pemF4ck5oNlVnbFZGR1BRQWRCWmd5cHJD?=
 =?utf-8?B?elJ5RC9mTE1TRDZCSWt3akFpY053clNsdnBFYytxMk04V3JIMWtpV1JrTkxn?=
 =?utf-8?B?VzZUUmZPMEhyME8wQVZxTkovcmdwT1h0b3FzeEZYdlZsT1MrbUlCVnZwSFpk?=
 =?utf-8?B?bHR3MW1FcW4wZk9jeW5jc3ZUSEtJcU5PRitSeE9Rb3hPdmltVDJzaEl2T3NO?=
 =?utf-8?B?cm00SFpiQ3NoWEZ0Ukp3U2RnU3YwRWJ0OFhqUDhBVXlPQ3pRcXpQZUxrcGYw?=
 =?utf-8?B?UXFMYllKdXFUVzNZbFhvOW0wZ1lhMitFdVhwazk4ZEVlcnFVbWZQRTZNbDJR?=
 =?utf-8?B?NVc0cnBaY2h0M1NCZUxlUW9RczcyVzdnSFVPcmdPa0xCenR0eVFrcHVGbTh1?=
 =?utf-8?B?UjZ3b3ZEem92QStCWlBMOHJYYnZvZ1kxOW5EMEd1WkJ0UVQ5ckp6YUc4eG43?=
 =?utf-8?B?SW0wdmdyYlh5SkhwazJnTDk5RW43SVNzQ01NQzdpYkxMcDlRUy9QRWhVbmpi?=
 =?utf-8?B?eWxLR01TcDdUUEVnUWpEV2doMENYU2pVY2NzVjFvMjZMTWhEOFg5L2p6YmNp?=
 =?utf-8?B?ckxBNTAyUHB3QU82ckpNL1cyYTE5OHdDeDdjVE9FaHZLZERKZFd1MTZBWFY3?=
 =?utf-8?B?SkNrN0ZpOG1KUmVVUGVEL2tHYytIWUxaTHRUYU9zc3E0RFZvVXlXM3U5UDJo?=
 =?utf-8?B?NFNlZlJETUIvMGhZQlh3Z1B6cnU2cE1WY1VYRkgzekc4RUtzWVZKQUt0QnUv?=
 =?utf-8?B?akMvQnpzSWZkcXVYd1JUVWFiZXg2ZlVvbWNWaTRPLzJCN2JuRkFRV0xWSktM?=
 =?utf-8?B?V3I4UE91dkxSMFl0UW5qM2FpRlRkamxlaDZ4Z01ORlF4ZWhtd3FQSGZBS0Vm?=
 =?utf-8?B?eXk3T1pPUzJPU2d0WjVoby84amd4L0N0Z3I4SmRTdnJqcXhET3N6R3VCWkN4?=
 =?utf-8?B?OFdDQjVha2FlUFlQMVJKKzFRRVoxMmRjeXNNaWN5TmE5TXE5S3B0M0YydG15?=
 =?utf-8?B?VVJuY05FOVA0bXZOcWQ0R2JaSFBtMTZvYVpzbnFFOTI4OVNlb0t2dWIxeE1x?=
 =?utf-8?B?cGQyekxIZlpKM25lRTdqSVJ3Rk95OHBuNWJVdzlwVFhzS1lUUnVqbUdTMVd2?=
 =?utf-8?B?QWtBZUZkY3FVakJwV0RpWnFhMUtzUms2TERqM1NZWFR2UGo4b25zVnh1YnUr?=
 =?utf-8?B?Ykl0a0kxZlowTHZEbkhlcGcxd3ZoVnZrNDBpV09sMXRZcUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpvTUFrMCt4MEtRSUVxMmF6Nlg3Z1pmK2tUb2hVOE1sL1FDamJPVFpnTHQv?=
 =?utf-8?B?ejEwOFVPWHIxU2x4SjZnd0REZ0swMzBlejZGWW9mUnE2b1lQdzVER1pncUdJ?=
 =?utf-8?B?QXJITGcyOThzeHVJNGkrYUtBbDBDV1JtWEFuU0RGNWY5V2tZdUg5azhUSWM5?=
 =?utf-8?B?MFM1NVN5Q2lMT3JNZmpjcEF0UDFhV2xHbkFXVGZXcUp0YlJPSlQvbHRrL2ZE?=
 =?utf-8?B?a0lBVEFFcW0xMGQ0WTRwWTdvcVFhLzBRMjZRTEN5M0FyVkNFRlIwa0J3cElM?=
 =?utf-8?B?S041U1NJS3U3dGN2N0xpd1gvQTVmMlRnSWplSHVuaG1QY1Yzeko5cnFqbWJi?=
 =?utf-8?B?L3lHR2pnYnl5eHo3K0t2eE1TZlFHdkZXckwzdXg1TUN0cXl0cExZRXdBU1Nm?=
 =?utf-8?B?SGtoNVhNOUdoMU9BUWI3ekMyOENtMkF2T2pjSVc5Qkkxbm5ucjJhTmdvSWxn?=
 =?utf-8?B?bGJGSGcrTkk4blM1NDJLcDFpdVEySzJ1U2ltK01BclBRa2JEdHNYWWZ5Ly9q?=
 =?utf-8?B?ZkF1SUlNTSsxN2xFM1FhOXhEaW5naFVMMTZ4cnhQVTlmVG9wdjdLYy9vekR6?=
 =?utf-8?B?RldNaW1INkV2WVlDOUdLenNrdkNxVHZZczZVQjRNQUVtRkRhY2M0ejhOVVg3?=
 =?utf-8?B?N2sxOCswUE5icm1MNm9PenlBOUhTeVgvU1dLL2FIR3pDaUdxQXJGWjBiWUpI?=
 =?utf-8?B?QWtLbVlnUDNubGl6dzcyUWlkRFFwcVR4SUplQVhPUEJqdlRYOVBZdld3SDBB?=
 =?utf-8?B?aUhnb2RwbDllUU1mbGY4TlpoaVVmaDRjSE83S08rUnVnK3JDSTRCMS9TRGRW?=
 =?utf-8?B?VG5DVmhoMTFldjlxMjYyb2l5a3dyVkUyZzJNV2NSMkpBeUdHYUwvdUtjanVH?=
 =?utf-8?B?dTQ1eWY3NnRmSnY3OWxla09jeGo2NEZQUUdMVHljTS9TRTNGUmxxZS8wYjBl?=
 =?utf-8?B?SSs1SVlFT1JxNTZmSkh4OVVpY2kzVGtrNVRublUyQUlzVVR0TG9OazhSUThF?=
 =?utf-8?B?Uy9aRjBWSEtrVUhWdzBSTVU1M293dVZ2NjBwSFpTR2tWVWI2RlNIZ1huQ0NH?=
 =?utf-8?B?UTlPSCs1WEZQNTY4amlxbDVWRGI3WjBVOHV2MlVsYnVRdE1kcFJjWndIdTNx?=
 =?utf-8?B?YVJ2OXVQRGJ2UVJPcjQyS2V6UldPZnVjVzVMay95OGovQys3dDZ0RVNGTmJ2?=
 =?utf-8?B?Ykt1Z0VLb0FMOXFyQkpEQ2NCaXlTMDlKejloa3dIMTRZNitISlhwVFlxWnBR?=
 =?utf-8?B?UzhPOGU5Y1FUekp4U1IxczZzTVZqZTRSZ0xIdFZKZDVKbXFJSzh5UjFJMTdW?=
 =?utf-8?B?Uk5aUmtiUk05UGJVK2dzUy8rYVlQMkxEaFpjOThDZEIwUm9tMXdLMlp5QjBT?=
 =?utf-8?B?ZnkvUFpHYUJrai9PUWdxbFhIaUE2ck5DcmxwVkZqNmhmTHl4dnpDV05wM1l0?=
 =?utf-8?B?eWJ5Q0Q5Tit5azhaQk5hMFBXL0dHNUVGTTBJM2tEUzYzcjI5elEvdWgwU3Fx?=
 =?utf-8?B?VGhTMWRwbjdkNWFTZUhXK2trRmZkMExwdHNOWW9OaU1IUTZiUkw0a3lWQ2hj?=
 =?utf-8?B?ajhvVjZ0WnVHYTZtYk9QZGs4c2NKTFBubS9TZGtRY2hqaEk3Smxpd3dEREd3?=
 =?utf-8?B?VWMwdEFxRU03MEdXcm85azhNK1RNZ1lkUVd4WmMrK2krTmVlQWpkMkVMeVRH?=
 =?utf-8?B?OWI1d05wemlRYjg0bFE5eU5HUmpiVU82RHFBdnBLbjZNWGEvZmtIM1ZnQmlS?=
 =?utf-8?B?TnZ6L1dtYlVZMXVxai80Z1NnK1p1b2Nrc2tSeis0VGZ3MWEvSFlDdytUNjZ0?=
 =?utf-8?B?bUtCc2pIMHdKdFAreVRpVVpQdm1mUFc3RHVqbE5IektzM0VEeHc2Y20vZmll?=
 =?utf-8?B?Y1hMS1U1WEJXdlRmOWlnZGxOOStDaklJblRzUWQ5N2EvOHJkQlNEcnN4SytS?=
 =?utf-8?B?MUs0YUxDNTFzZG5lM1IyeU50YmpjVU9hM09QWWRtVGdSaWNkamxQa1FZRGZp?=
 =?utf-8?B?V29qYXJGSHVLMm9TZmttK2MzWHhjbUlnSzlINFlpR2pXbGlRN09wU2dFRXNi?=
 =?utf-8?B?R2N1b1RXdXFTNHJ1dDZSU0pxM1JSOW1JUXQ5N2hNNENTRlA1dENYeEhwRGoz?=
 =?utf-8?Q?PcSbnVJsJleYZhFSq1fz1S3zb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3531ff-69e2-4f44-577e-08ddbfa35371
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:17:16.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsmwQJPvd+fQKTqz1IOZWUmo7NNZ/jUeysgg51PaWOc4rE7senmhpJhh4imVj0bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476

On 10/07/2025 3:25, Jakub Kicinski wrote:
> On Wed, 9 Jul 2025 18:32:51 +0300 Gal Pressman wrote:
>> Some drivers (e.g., mlx4_en) support ->set_rxfh() functionality (such as
>> setting hash function), but not setting the RXFH fields.
>>
>> The requirement of ->get_rxfh_fields() in ethtool_set_rxfh() is there to
>> verify that we have no conflict with the RSS fields options, if it
>> doesn't exist then there is no point in doing the check.
>> Soften the check in ethtool_set_rxfh() so it doesn't fail when
>> ->get_rxfh_fields() doesn't exist.  
>>
>> This fixes the following error:
>> $ ethtool --set-rxfh-indir eth2 hfunc xor
>> Cannot set RX flow hash configuration: Operation not supported
> 
> Ah, thanks for the fix!
> 
> In this case I wonder if we wouldn't be better off returning early 
> in ethtool_check_flow_types() if input_xfrm is 0 or NO_CHANGE.
> Most drivers will have get_rxfh_fields - still there's no point
> in doing the check if they have empty ops->supported_input_xfrm

Makes sense.

> 
> We could add a:
> 
> 	if (WARN_ON(ops->supported_input_xfrm && !ops->get_rxfh_fields))
> 		return -EINVAL;
> 
> into ethtool_check_ops() and we'd be both safe and slightly faster.

This is a step further.

There could be a driver that allows setting of input xfrm but not rxfh
fields. Failing the netdevice registration is different than skipping
ethtool_check_flow_types().

Maybe there are no such devices and we shouldn't care?

