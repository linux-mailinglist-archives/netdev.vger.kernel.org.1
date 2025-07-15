Return-Path: <netdev+bounces-207010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5CDB05327
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA96173F23
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944B2C3262;
	Tue, 15 Jul 2025 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIllIkRX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036C255F24
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564305; cv=fail; b=aVMEAvKinYTZhXKyELwMsdpFnU+s9TE3AdZ2DbTWSD4hVGxnUZ1qPjTOAzE9fL1cCSfpWaHER7dtzT267hG49UjgoDei78n/pMGc8zPyakz1qZ9TIvDifuEwBY1ICDhHwnuGePlkrLr/HFZQjMi5IwvkdmJF7Q4xE/ahgHgmktE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564305; c=relaxed/simple;
	bh=0rTFgbQT8fMFzMn1REqIqxwEdS0aDSEb58qwa+xSS+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NpWExrAr7Zq4i4MFBXvO6vVdaqpVzmNhs+jcJrxjwNg9aUs8+9pv1OVvFQJAPqtxLguA+ULzRXkg062nlVIqc8TDoOmFvBHkwjOrwLgtwb7MlP22sNrpC2vgoKSQcasmJ2TDqiCHF0nivseKR/Rw6h0CiMmn7TGgL4D7IPJmwsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIllIkRX; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsYVjYzsgNMsVTe2Iyn5ZjQpNhGZZ4vUGyUwQ5SpOChoJicPZjvbMWxYR7VFP2DYc9COQJ7FDBngz/FNNYRt5NzAv2rqyOt3Ls1MEuV3zlsiEMwQon47c3Nm8UUh7GCIXPGZBaFgb6qiRMMXrUkEgDWzo7zmoO8kdbHxueqIp076/ssXXMs+eMznRfaCo4vgywPdyIb68bO3sNQ/EuWMd6+RT49DjzF2rrVn0CsjGY1nGWOZLEdpwyMVnKVffnX7XMhNNdpIERWFW5RiWZj6c2JyU02K2wes/Sm9X2o+mqWl+ZFvJRCvK8VWy+0gFB3rlzS9S8lFHdW8VGdp+UV8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjCcLXi9fmqaSR9RlHcFKDRV8x++3tHbdPZF/AeLufQ=;
 b=IJNNUIJMXkg7qlG+UwBTr2tdxZdbAtQ8jwm9AO4kOWQFjv1X63wAXMEZTWT+6RphvkwcA+AReTAxS51/zAqK4tytpwV8vif6gPrhhavpHpNIXEZvWdMYYSwXTMd/IU3NHiJee8Ckur1jWd78jM0ODmkvgoDVjm03GvydHxUJ67mkcxf9Y3josi+mU6pj8t2rOXDOZ3BD5W3g3ZhvEpsS6ueV8HQwiyGkGS8yY092EWk5D08M/cM115vQxOwlCVE4BDQ+7Gyhbfw9tESpXn6zvAr9NhVfujM/3q59m5Hxnl8XOXLM/sHy+NYuzYVT8wb92BZluwvsvZ10vnczAlUktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjCcLXi9fmqaSR9RlHcFKDRV8x++3tHbdPZF/AeLufQ=;
 b=QIllIkRXvThHF3kScq0SYS+sjtwxNKrnUqHoYqRUbLnoT5t6n0ria3yRzphB+r7iWd2ma0ZZFec4kSerPeHIQ4QwlWYn2U0t5LEceGFmJZGPqbaQ9rGMW9tG0F1kqasCgz9Izmrm3Ma7ujRMsaj6U/z3kZvChp0d1WtaA6RmJtKFwEfPSzd3gg9fzC74Ls2oiDf1iWqn9xr/gR6wsNNlVrYLbkbrUIoLuXREEzWnjyiSFzziXzFi/WlQX3iEBnX+zCiEkVXYSLeCZZLciUAICgHNgLZ1txaMZXiH/o9wjMXghAsvzldmnUNIRmbnlW71HdHUx5G8aoUQxDLGw52b8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 07:24:59 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 07:24:59 +0000
Message-ID: <23d0c617-228c-4498-a36d-f74bf5490e2b@nvidia.com>
Date: Tue, 15 Jul 2025 10:24:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/11] ethtool: rss: support setting hfunc via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250714222729.743282-1-kuba@kernel.org>
 <20250714222729.743282-6-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714222729.743282-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 8933334c-5a0b-4240-f886-08ddc370b451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhVNk9iMFBsSnpiK0F5WTRPc092Y1JoOUtjaWEvdGdQbzlTQjB0cTZXZ05M?=
 =?utf-8?B?YUFYTWE3dlJoWTgxbGl5azU4V1MyLzBVQnBRTEFTN2Z5c3Q5aDRmcEszZXcy?=
 =?utf-8?B?NnZjQ210OHFMTytWNmhYSFhua2w2bnRIUkNwVmR0dzlvT3NxY3NJOGRzdCtB?=
 =?utf-8?B?QkVKZFRzbE5maks1VGE1OUpQZ2ErZXNvR3hPT0h2MW1jUEE5b0xVS3R6dVhX?=
 =?utf-8?B?ZEFJV1ZDczU4NlppbjZpOE1iZy8wd2ZoOWNFcitEMGpXbEk3aVpyWWhPUEpk?=
 =?utf-8?B?OGdIQWtpdkgrdlpWaXo1YjVFaTRiUTNJNW9QNWxsekZGank0d1RyV3FvQVZm?=
 =?utf-8?B?YzdMZmpEWmRacThMa2ZJV25jWVhYSFc3KzhiSXhUU3JybEZLdkdZMGpUdlBu?=
 =?utf-8?B?YXgycnhKY0swUzEyREFYUEJPdHkvTFQ4bFFCM29VR1pramFQekxZRmk0U0RF?=
 =?utf-8?B?VWFscUdBN1c4NWVUdTBkYjRZa2k5YnNjcVl1MU1rT1F5cjZHUGphUG9nMS9K?=
 =?utf-8?B?bnRJZWxhOWJPSHFuZ2RPcUp0NmtncExMUldFbzNmblhwNk5WWkJKWFdBbGVB?=
 =?utf-8?B?cy9zZ2lFWTZ1UktiOVh4ZVRiTGJrUzJFSnRVVUF2d1ZLcTVWUWFhRHVpeUxR?=
 =?utf-8?B?UkZaU290Z0VHM1ZzV2luYWhHd0hVM1pndHBDbDFzcDdkZ1U3TDB3MEJSWWhx?=
 =?utf-8?B?OWVHYUtHc2IvSlBISzJlZGtjbHhqbHFvT2hTYXBWd0pOYjZSMTRQNjJQcERw?=
 =?utf-8?B?eTRjYVd6Qk5ydi82b0txOHJJTEFvMlZYbkFxa0trdnN1cEdEZlMrR2N5M2hK?=
 =?utf-8?B?QXJ1U21FRmsvaFA5eTMzR2tGRGdqaTVXRWFiMUE4amQ2RE5mU2poYmUzaVdG?=
 =?utf-8?B?cDdPR0Nlc0tTK1NzOFpmQ0J1OEJ1OHNwRE1hQ0hPZjJCYkV4dFFXQ0JacVp5?=
 =?utf-8?B?VTY3YjI1c051VUVHcWxJM3JURkt4THJBdjFQZUtVb0tZVUYxbllDNkxYeVFP?=
 =?utf-8?B?dExvUzdnVmtTYmZ1clR6bGp4dVdILzBBaVdKMVgrR1N4ZjhmSHNhUDVFZkdh?=
 =?utf-8?B?VHExM1EyZFpiRzAxb01mL05SaHIxaVJRRzlFMWk4VXV2M09sUzlkT3pVZi9H?=
 =?utf-8?B?bDFOZlkya1V5T1Jma2dXV083ajd6ZnlKRE5JRWoxemtlNTVESU1KZEM4U0s0?=
 =?utf-8?B?RWV4SUZSVXJsam5KV1c0WU1UWTByNWhvRVc0U2ZCTzdoaVowdXhIaVgwby85?=
 =?utf-8?B?SHRJRW8vaDU0TlBMT3VIMjZ3YVJqd2dIZTZSZkZ3Y1JGUEZJbzgyUzdyOEdI?=
 =?utf-8?B?QXVJcVpFWnNwV2kwL1NPYlJjL0xQSVd3dUFVSTk1VnA2SmwwNUI1UmZGeUhN?=
 =?utf-8?B?Z2lYZ0xlL0VBNDJTenFIK1RiTC9VekltSyt0aGZEblRWd3cvT0pxdDJGbWk0?=
 =?utf-8?B?VU1KcHBqVWNDZTRWcWVoKzF0YTNXK3dic2toVVlmdG5nRkVjMk5iQXBsZUkw?=
 =?utf-8?B?MUdDWFEwMk84a3JLTkxZaStQYVU5M0N6OEh1QTc4aWg3aHlEL0VuWHdtWmJQ?=
 =?utf-8?B?cHNjYllsY05oSnJVRmFjK2g4UktBcElYcWM5TFc3aWd4cEx1RDVLTUx3QnZO?=
 =?utf-8?B?Rm03RXkvcFl5Y3cwRW1ZS2hZYWZtZDI0bmhiVk0rU1RyLzlqZjQ5SDZJeGJj?=
 =?utf-8?B?Zlg3UGFGeHRLQ3dHbU5yN2Erb29IcTZIYk9QVU5ZTUNydnRNVzk2Q0RaU1ht?=
 =?utf-8?B?M3VRL29QWkpzNkpNT3JpV1JsRURsUFZkbUI3STVMNXdiamxFWkQxT3ZCZ3RS?=
 =?utf-8?B?Zy9zOHkvZVByRFl6VzhTUEpjTEJFN1BiNWJwbVZYU2VTVnozMkVMZFhPTGFj?=
 =?utf-8?B?dDYyejYxbnJwOEVwanFpdXZJUHM0eUFJMm9USG1nK1B3Vjh1K2VZRVhySkp6?=
 =?utf-8?Q?9WZPcRDa/KQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDhSRVRvZmR6WWQwcms2cmNXNFJ6bG5Yb3RsRWZFdnhFMHNXTXh1cUlhaW1k?=
 =?utf-8?B?NmZEOEhJMFFVTXgxbFJqWDJXUVhaM0N1b0dpQ2tsZXV2OUJYRjZjMVpqK056?=
 =?utf-8?B?SnlScTd5ZVN3cFRJdmpHbkhrZ3p1QWIrV2xlWkMrQldIdGtxT2xMKzBVYmRZ?=
 =?utf-8?B?ZzBCRlBQL29mM2hjWVIyWmM1QTh0MUEyRkpEWlpYdThrRGNVZE5IZlZJbFdQ?=
 =?utf-8?B?UG9seWpWZVpTcndZMStUaytkUmFnTWhrZzdWSHZyazhlVXBNclNJTkFLaG8y?=
 =?utf-8?B?SXVpdmZSUzROS3lFRUg2VTl2b0JQR0VwdXF1cm9QMEhkY01JVnlOamJlOFBx?=
 =?utf-8?B?NUtLRlFLSWFPKzdMTGxNdSt1VnduZldUdHZycGZFbWw3cXdWVHkzTjNIK1dm?=
 =?utf-8?B?OU11bC9tRWIwb21GNkRFdTIyWHREa3pybnljWFF1Z2FXcDVha0lUbU1nMWQ0?=
 =?utf-8?B?ZDRweWk1RlcwTmdnSm5DQjNoOE9mN1paOHlYV2R4TFBhK0VyeUd0UXRITnpD?=
 =?utf-8?B?UnNGVVcreGlwYkhOWkEwVGtseW9rdTNGYVd0S0VOWTFMRit2Z3h0Ui8ybW9v?=
 =?utf-8?B?OS8wVHhLZGZiTlI5WTlYSEY3YThrVVdNK0VYNktOTjlRejZVT0F3UEhFWkNX?=
 =?utf-8?B?SGVCMVF5NWNYWTJYRXFoaHpuektJTVZDemlRWlUwL05HWFduZXo4S3p2a1RO?=
 =?utf-8?B?aGxuMFoweHQzTWNLMWVtWkNMRFkxTnNBOE9ORHJQamczUWhiR01pSndmdEFV?=
 =?utf-8?B?bmVSbzJBUU51TlNaT05sODNNU29VbWZiT0N4ckpoWDd2blJ0QkNNc2tVd0ZO?=
 =?utf-8?B?NDM0Yis4MXJoTlZzekRkWm5iYUdScWZqc21Ic21yTzNpUnZyT1JXNTk2R1hy?=
 =?utf-8?B?bmsrRS9QWkE2SFhMV3Z5bmpXZDhkd3dlK0JRSzJUUU9LSEQvWEM4THpWajVm?=
 =?utf-8?B?WjVib0dWcTFqdVkxeDExZVZSbnFQSkhBOVZTYXVvaytpVGJ6V0xKM0dZMUV0?=
 =?utf-8?B?TmM0SHgzNlRWRWlHaDZ2VGlWYzlLTGEra284ZUsxM3Fxd0lNMGdEN1pPVkhz?=
 =?utf-8?B?WmE5Wmo4R0JrMC9Pcmt1WFFHYUs4Z29yeU41YnR3d0VKSnhxMmlQeVVkaUV4?=
 =?utf-8?B?QS9SZnp6ekpjVlN4QmdWeDNNSWJZRUNxY2pqZU9xUUsybVF0Y09uQkhSNCsz?=
 =?utf-8?B?NVZuM0FiZTlrbHFMcUU1Nk1ta1FHT2Z5MUVPMFVrd0YzdW9ibDhycy9HT0x2?=
 =?utf-8?B?eUhNdDFPN2QzTHVYY0daRy84SFhWWFpKQmF2V2dPc0poVDFHSGYxY2lYSUFz?=
 =?utf-8?B?c1o5UDNVR2tQWXNkOUZJKzFCZGFHdmV4NnlCVi85aXBYRG1VQWY3SHhTVXRR?=
 =?utf-8?B?STJUSWhXVml6VDJ6YnF5aXVlb3RxN2RmT2x0em5zM2lzYWxma3FEV2NMUmMy?=
 =?utf-8?B?RHU0S045d09vOEQ5UUVBb0FQNEhYaEordGhOenZhcHlkZ3JmZzAyRDRBZ3Zl?=
 =?utf-8?B?ZWg2dTlaQXlsZUovbHhJcFoyQTY0d3VuU0FWSmVRUXBaeHI5REtsc1phdE9U?=
 =?utf-8?B?ZWF1ZGVFbTVNcWovZjVMWHpXVjdMNExvK20xYjc5bzNCa3lwMnpuZFZMOFJL?=
 =?utf-8?B?MXo4K3ZGMVV1SVBhZmRaVzMxSUxWMG1GZitRMG1QZ1Evd29aSEF1alF2TGo0?=
 =?utf-8?B?cGJ1bkJXekNYUkVnem5BaXpyandxdnQ0MmhCVzB5MjhqL1ZLMERrRE9ZRXMy?=
 =?utf-8?B?YzZaVHpNSVJjMjNqQ20zSUxDM05Mazh2azFSWjQzWlpKK3ZJOXpCSTNaRnNy?=
 =?utf-8?B?dldrbzBVbldBWjV1aTVvelQ0WVZnSzNNNmpJcy9EQjdCZGtJWkFxY3A1TlRM?=
 =?utf-8?B?dDhxNEoycmtGY2phbTh2czFkUzlodXpYdThXM2RPang1UXZPLzJ6RE41MTJ0?=
 =?utf-8?B?eXg0SzZXWVJoNnpsUVQzWG1SOGNncVFQaHErQzhIVm1UUkFsWEJRWFlHMkIx?=
 =?utf-8?B?V0V4dzVQRjBoSitaWkZ2VS9Dd0IxejlVbVAyc2x1Nkd6NjlOekJhMFNSd1Nv?=
 =?utf-8?B?OVBqUWpzb0NTemlmdXRMdSs0T1FvNzgvdWlXcGYzY0JwcmdkZXcwakVtUHUz?=
 =?utf-8?Q?CcoWX2gBC0/ZlvOoQCO3uhzM/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8933334c-5a0b-4240-f886-08ddc370b451
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:24:58.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouyu4wQFqmUbabQIFleXFbbJy43HjJ5+XbyRX1BoJFQWpOSz3xKdn/L90vOCdDTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320

On 15/07/2025 1:27, Jakub Kicinski wrote:
> Support setting RSS hash function / algo via ethtool Netlink.
> Like IOCTL we don't validate that the function is within the
> range known to the kernel. The drivers do a pretty good job
> validating the inputs, and the IDs are technically "dynamically
> queried" rather than part of uAPI.
> 
> Only change should be that in Netlink we don't support user
> explicitly passing ETH_RSS_HASH_NO_CHANGE (0), if no change
> is requested the attribute should be absent.
> 
> The ETH_RSS_HASH_NO_CHANGE is retained in driver-facing
> API for consistency (not that I see a strong reason for it).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

