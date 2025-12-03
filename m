Return-Path: <netdev+bounces-243372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E29C9E3C2
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C463A2AAE
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DBA2D4B69;
	Wed,  3 Dec 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JtEcCRbp"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784A2D480F;
	Wed,  3 Dec 2025 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750973; cv=fail; b=c4r7TwTp9BgTB/ZB2gNPFr+u9svMsGZtwBZ1N03MCXMBNDx1WWsNPjSJLkiacbw/1pumOt8i4Fb9pcXh4vtm1qtvYs74Yc7yqmoRYKuts1pKwXqlX7QJcZw0BBLyCNQpFfNDQOhnml21Xq8wq+Dedy/D57d9U5NVepnwoIYdj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750973; c=relaxed/simple;
	bh=Kpr05g5bYEsgTtfGR7AC2m4Oc6FoMv3TKi2ksC/w+1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F7e0r+UOQdLykJk+osP9TYZBRMy/Yk0A/7ZYwyG9NtNnJpUNnmEvr6g4OgX3hfotJY5m20qFwRIXRkgOMh6Bm9nWW2zLCg7rJxFoYr6Ug2gQkfwEDVlwM+kPqMNlnka5RLe3/KeZc1e4fkvG6/yEWmTl51ljVRmLDj7IlYVO0z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JtEcCRbp; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgNiQ+B6aZxJi5zo6JCBwsghb5l3Guj++hXigeH7mQ0RrCZ4tMW6c7E8vtUvdMnWEzmen5k/Zd5etvABomuEiDp4QSkSyWcz/xd3NI97MgxQwJK4OdxlJJq1FuVkMJxslHQiL4OoX0y2kEUcsLtKTfYDD7m0iAFGk+vGIQI0BTcWc1uRWEwYC41tBMd/UEQL01bFFO5ACR/r+2GWDNpmYcZdoWoQJuHF8xXPzXSit3XJNjbgVFRQkx3ATZ8d81FmrgSVCmr5mwvuKwzs4nD8eBDsrMx6oVIiB2AbQUVDEVX8F9ab5YLS3obpW6k/DfmpDhC9zPuLiMlKPEQlbrUFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19XeNcoH7ahwSs2W88aJ1H1UQ4ONvMhT1stk2+Kt510=;
 b=d478APnKEKqycKN87ExXhwgsMhwytfFsgaFd6wuhWYhGU3DK7ho/seiF37SmcdGj0pz+x/46w79iBKv8IlPI5Ph/09gDG3EyNJDV6gbPW/xlSi7N/K5wQjbBu8IitIYY0kUomh4WebzWM9qY7MeyibUG1HjOMpYgoQhoUb8e5DuCZ4MlVYefkPw9N8ZFdh7LSd2ZnN3Q7nRw0Q7Dn1LdvVjqxrHzV6Rw4kEuAAUDYaLboeGxWo/PFztnT1/qQ27EpvwjDQrwe3ff5G7jpl6KAhSPjgmYP3s37WC3YT8RHYc0VWTxi2+jQNXYpMe4s4Ovkt1C7Lkp9nX9VZ/9VV4bxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19XeNcoH7ahwSs2W88aJ1H1UQ4ONvMhT1stk2+Kt510=;
 b=JtEcCRbp0hfyDb5atVU+fCjbKTtZ2xRebZ7m5Visb659hSTuKU4XvoNn+fuekg5lNYTEDBy2lE/z0wLJ56IySq+EjSCd9YdZiJRbvPNSsZF6ubd6+Zq2Bhn7Zdpcm7z8bySU2sAmTqFBNdRMV0v9/cbq6xGuVV+1OagSP1tEQVUY07Ej3lgqX/PKnTnpWaUCa+QI6tyFVofFANhx8xg88h9wsCEplHuBa1bCJnWLjbBssEAFizckWXl6H5dXZDRBkmYGW9+HjOlO2pOlKSPBu19EPBuICaPG43BYN7O9XftTHMLST/Swq5Lh4YsE6M/05eNgxf1OBHK7ga1UGN/chg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:36:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:36:07 +0000
Date: Wed, 3 Dec 2025 10:35:56 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Message-ID: <aS_2bPm-ZC9ghGPD@shredder>
References: <20251125181930.1192165-1-jon@nutanix.com>
 <aSawDrVIMM4eHlAw@shredder>
 <8EA496BE-669B-44C1-A3D7-AF7BD7E866ED@nutanix.com>
 <aSgK2wfLJurn2df5@shredder>
 <B4079F8E-E823-4848-A3CE-81D319B1FC4F@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B4079F8E-E823-4848-A3CE-81D319B1FC4F@nutanix.com>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 676df16e-02d4-4686-500a-08de324700b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1vU1NwN2J5OUVENW5WUHh5Nm9HUmpHMWJ0VzNZRGpDeE81S1JzRCtvZ1VS?=
 =?utf-8?B?OXZCYlJEMkRBYXlVYWxMVEhYN0NFdjJ4a2VZanYrTmZXZCszYkVoQm16UjRn?=
 =?utf-8?B?MjI3a09HMFVmbEdBK3lLY0FmMmM5WHBrSFB3c3VRSTVRS0I0Zy81VXV2OUZn?=
 =?utf-8?B?VThEQzNrWFRhZGQyQllpRU5rQmxZazBScXlFcERqdGtQOE94Y1dBSjRweHdM?=
 =?utf-8?B?a0hqZzVJSys5M0ZlM2g0b2RnYzI3Z0IrelhJQlpjU3JkM05pSUc1NllCelpp?=
 =?utf-8?B?SS8vVndkYzB2a3JBVUpUZHpSaWhmS3JlY2dQWXozclVZWUw3dFRod25kSUl6?=
 =?utf-8?B?SlY0RkhQQ2hVYlNlVXJwTFZ0VmxLOUw0alZ0bVkrTVQxZGJTSVU3c0ZWcXV3?=
 =?utf-8?B?MDZKVnFOQ0RiWHF2ZnFGOGY1di8zZi9UV0hrRXE2K0ROYUQwdTRTdW45Mk1C?=
 =?utf-8?B?LzlNWjM5WldnRGdDU2JySGVVSkJEbm5nd1BYQi9RZzNnSURrVWNadUMxdDVX?=
 =?utf-8?B?REZBMEdOaVBkRmJSVTBkWHVqTjNTNGpSMmc1My9kRUlpcmhVWU5lalpmWTkr?=
 =?utf-8?B?Y0ZrZGpxME05bjJlcTRPbUF6NllZeEJ5ODRVVW1yYTU5dGljMWpkNzBYRGg2?=
 =?utf-8?B?ZUVGSUZob3RtSlhwSG44WVdCeEV3VllxVXVyY1pNMXRDb0UvR0krRmFxVExk?=
 =?utf-8?B?VFZhdkpzWFkwQi9jQ0tyVG5TUVI5REdvdVczZ0R5UkVpYlM5M2U5eGhyaFF4?=
 =?utf-8?B?K1BDZ3FRNzBzZ25JMStRY1JrTnRveFVXVWUvTEY4Q3BBUjRIeE85T1ZCMDJK?=
 =?utf-8?B?WEc4UEUvYnFGTFJlajlmTmw4NkZKL0MrZW1IUklraU1UVXFTRmRLMFVZRXF2?=
 =?utf-8?B?ZXpxTTFGUjFvSWJpZ3RFdHNRNkxKb1ZKWXlLZjY3bThTTlBCb2ZtRVNQYkVx?=
 =?utf-8?B?NjN4SkUxRWorNnhQeVN2MG5lS0ZZMUZRWm1tUkRYY2QwQm5jMVJmdi92dzRN?=
 =?utf-8?B?TXFMSyt5dk1xYXIvdjVoeGllQVNDUXdpZFoxYVBjRHAxSmozU2J0V1JjaVAr?=
 =?utf-8?B?UzFpdmIrUmljVTE1b3Q4TXpUOUpPZGx5NU1mOCtwemZDTTJHZTR6dHRiSCtm?=
 =?utf-8?B?VUUrcnVuNWRMWkNHT3ZDMi8xenR4WlhPcEtVMWlYZTJxd0hsaTRZN2UzV1p1?=
 =?utf-8?B?azE3VkU5dzZqZXl4NXhDN1F2ajBNKy8vNW1xUnR2aWtqR0t6ejhIemZzbm5K?=
 =?utf-8?B?RnAyYTlzQ1ZKVTVYK295SGdrRVplb1ZLekI4RkhSTmpJL01xNTRiTjlJTzhT?=
 =?utf-8?B?Tk4vRXpBLzdqQ05KYTlJUXk2YWp6Y0lwTkV6UitOQ2hyMjlXUTJHYmRXMmxM?=
 =?utf-8?B?SFl4TWxGMWt5ZlhuWFBoYzYyLzFzYVhra1Z4ZXNTNUU1WVlZVzhLK3FNSmlK?=
 =?utf-8?B?ekdFVGFSY2c4bWRiMDRjeWsreVBvUytWK0tVWXFIYXh0L1RWRDJMbi94Sndr?=
 =?utf-8?B?VThhZGtkMS9xc1d3WGJDZktvRjQ5RlFieEtEdWxWazVpVjM2ZGZySFcxbFV0?=
 =?utf-8?B?QnFDczhTN0NubDBsbmhmZjVuMlhrUlhWYlRoSVRGQ01JTmVwMU82SHpRdnFI?=
 =?utf-8?B?TWRrazBwbEl4U29VdTk4bzQxMk5JV2Q0M1hPMG1rNVZKMTNhcXh0Y0NGRkFJ?=
 =?utf-8?B?bjhCT3VTeFNIU0YxWmg1OEtuR2ZlOWlwbjFtcGpqTlZGVGgxcGMyK1E3em4r?=
 =?utf-8?B?d2V6Uy9kbzBjQ005QXl0c2VsazZRSDFmd3lmUGdBODM0TTduR015SkJXZzdD?=
 =?utf-8?B?UEgvbFl4Wmovb1FPdno3WDFwK0FaaitSMjBrdlN6R2M4bW05K3NrejB2UnA1?=
 =?utf-8?B?bDJReUZnU2lRUlQxSkFvRS84dCtFTHR3Rk9CQk5kaVNGSy9lOHluNFFka3Ru?=
 =?utf-8?Q?q47aDe40UlaE/TdA14ZuiZj8jG/JH9t2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0J0MGhFRzYybDdwWURTWkFjblhobzBWbVYzbHViVUsrcGVZUVVXUmQ1cVZj?=
 =?utf-8?B?aWtOYVpTRmgvTUR2eU42WXNidlFIbGRFV3BJTHNxcmNDNWZkQWtaYjZNMDlX?=
 =?utf-8?B?Zkt0YWRkUjNUOXN2Q05idGtrTkdNUHdDc1prMElzU00zVi9xdDRtYTdENm9K?=
 =?utf-8?B?T0lud2t3NkJDSVQzcjBwT1pzcmo5K3ExMTE1Nng5Rno0MjVMVE10Nkc3Zk4w?=
 =?utf-8?B?N3hiQThMckpYbzJwcnpvdFNicUtnekNKS1JFVmVXN3NibVdZOE1XelBXeUlt?=
 =?utf-8?B?b1BtaC9uRUJzcXRWYUdML3JEZStGYTdWNVBONy9CUndVR28wWUVITnY0cmE3?=
 =?utf-8?B?VGNNeVR6aWFTemp3RFVlLzFtTGJhNjdpd2hJQzNYRWJpckZwdm5YaHZNUU1m?=
 =?utf-8?B?VEtYM1g2MG5HVmcxaGFtU1VCSmhEamthc2tOMXdnMVEwV0JLMmEvWmxoUEdi?=
 =?utf-8?B?c2tPckQycnE4d015RXNFbmVTQmw4MW9OMlJRcHNiVjhiRW8rYzFCdnZPSEUx?=
 =?utf-8?B?a016Zmp3TlluY3FaZG5RdDNsbktyVDdVMi9CM0xUVEw1K2VmZW5DUFM2OGFV?=
 =?utf-8?B?Ym1XZmVGZ3c2WEwvNVJMMnNxekhyYlhWNWl6VXFJblQ0cjV3VEZGUG13SXJO?=
 =?utf-8?B?OW83VEpxVm90a1kzcE52cGxBWXNYN3ZZVU5RY1kxUWUvWURXeEkxWENaOEdv?=
 =?utf-8?B?UTUzeHpSdlZJcnEwMXZMUngvU3JUTWYxeUNlT0pXZDFHbURORnFxeUc3WWVF?=
 =?utf-8?B?WHZBTjZjV3pqeDV2N2VGYWFwRk9qSGhOL1Mrd1BUSmtxTkF1QkdmbFdqQ0hD?=
 =?utf-8?B?YXc0bXo0S1NCZDZSSmNTZHFKaXVjaXFZOG82aDBzTHkxSkh1Y1FCbUsvWHFL?=
 =?utf-8?B?VXNKZWRHVDNWbzd3OHpHUU1zNlQ5bHdRdWdPRjhMcWZvRHVUZ1pqcjZPU2gz?=
 =?utf-8?B?NSt4UzlhdnNXLzErV1N2SEMrZFdqVFhxUEMwTDQxbGtKdjVXRG15aDU3d2V5?=
 =?utf-8?B?K1RUSXdBOUt5blVycFRLeU81ZmVoMkIzRGI0K2k3SGVzaE44SVB4cW1tanBF?=
 =?utf-8?B?dFlpWGZrdGNucVg1b1NVNi8wUys5TmhpRE1rWFBCV0plR2ZQUG9EWXdPMXZE?=
 =?utf-8?B?LzZHRjFXKy9OL21PTmIzdXdTOUZtek1NdE51NmdQQzEzMGxHOWNZeTlKNmRj?=
 =?utf-8?B?ckdoaS9EL0dtUmJ1Ylk5Ullrbm9nVGFnWitNNjlCQzZUZm9Mb0RpbFZUcHI5?=
 =?utf-8?B?bjNZRGVHS0xPTDRxREh2a1l6c1B0SjNGOUIrYU1aU3hlbVJ6OTBKakhWSEgw?=
 =?utf-8?B?VjN2dG9sVE5WcHpUbGttYlROTTBJa2hxbzY0c0Z5ZWxzc3dZaitNNk9VNU9w?=
 =?utf-8?B?STA0NTdFdXNPWG5KSXpPMTRYZlRsc3Rsa1ZTZUtOaTd2Qk5VUStMSmtrckNm?=
 =?utf-8?B?RU5WYU93TkhlUjU0M1ZxUnBmdUxXazJYend4MDBJNlNiSjBMQ0kydlRBVHFS?=
 =?utf-8?B?bGRKM2xHb08xNHJmT2o0RmRWY2Q1c25aUFNFalpOekVkTzJNZ1BrUzk4MGhl?=
 =?utf-8?B?NmlzaERUR1ppVXkyL3ZUZjY0WjZHZmQ1Tms1UGM3ekZMUVBDeXFWcVQ0UkRJ?=
 =?utf-8?B?TTh2eGtucUgyemthMXFPRGtOM2R6akNPcHBkeEU3UEwwcHYyeExkVjlGVzZ2?=
 =?utf-8?B?dGUvdUZwaWpaTmZ4cUdvTGtCL2t2THVRWDJxQXNDelJKV29nYW9mS1RobHF6?=
 =?utf-8?B?L1FQRHVPejZwaExTdFhaZUdvNDRnL2FSSXF2WEtxUGlFMVJqWE5VSE4vYTN4?=
 =?utf-8?B?TmxxZ1JwVE5IbkdsOW9EMlpRU3Y5OGpxVmJIQ0hQek9ZMzRoWm1CcEltZGdG?=
 =?utf-8?B?K2dPOFJNYzZtU05TTG1zbkVvTmI2YUZKcTMvajB2cU02OUo4dThSRm1WVENm?=
 =?utf-8?B?V3N6dmEwTGJsWjU1eFgrUnFUQ2Z6ZllVTStMZTd5TzNhb1l5NGFLYWo3dmEy?=
 =?utf-8?B?SE83Y3k2K25XYVVQaStUSk1Cb0c5WWF6QkMraVpSb3JySHIwR0U4SGlTNlh2?=
 =?utf-8?B?cGFxSkdaeUdvYXorSGJKajFOb3pYbDlWckZoamxwYWh2K0R4S1IzNDdYZWw2?=
 =?utf-8?Q?nj5+8T+6hBEIvKXhgb/8TKS3k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676df16e-02d4-4686-500a-08de324700b9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:36:07.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSDfwXhhAaBF3AN4i/3lzlZD588yzCeZ/KYrfu862UTZ1IrjEV+H33BJbzfll49MIe0J7ghiFzHdbadiHOmbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

On Tue, Dec 02, 2025 at 04:53:43PM +0000, Jon Kohler wrote:
> I thought about that, but the nice bit about doing it like I have it
> is that the flow keys / L4 hash bits are getting evaluated properly.
> 
> If we do it like you’ve suggested, we’re asserting that L4 hash is always
> true, right?

Yes, for some reason I thought that the flow dissector always sets it in
this case.

> How about another helper, that only tun consumes, which does all of these
> things, such that the code still stays clean on the flow dissector side
> and we don’t have to mess with any other callers?
> 
> That would be the middle ground between what you suggested and what I did
> 
> Thoughts?

Not sure. We already have __skb_get_hash_symmetric_net() and
__skb_get_hash_symmetric() and now we will have a third variant. In this
case, maybe adding a 'save_hash' argument is better. It also means that
the next time someone needs to calculate a symmetric hash they will
pause to think if it needs to be set in the skb. I believe that when
skb_get_hash() was replaced with __skb_get_hash_symmetric() in tun the
assumption was that the hash will be stored in the skb as with
skb_get_hash().

