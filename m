Return-Path: <netdev+bounces-158839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDCA13745
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9D188A089
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B211D5CC6;
	Thu, 16 Jan 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WGw4H2Os"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA1139CE3;
	Thu, 16 Jan 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021782; cv=fail; b=qQWJ2o/gL9N/l3FBJ3aQ2D1qyrMia23YK1Zr0UUnMWvs0ZpOtgBsFpVBGEGH7D5eanHgA/SX2x5KNZQCUAJTKo5Ahc1YbZs6NbkGhYK1sQKFYdCj9cFRnFuMm8OfZU9V70LA8afD70hHOEEdxNjT+/y7r3tSVmPJcRZfC27O1n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021782; c=relaxed/simple;
	bh=TtORb8wdSYQb2HPA0rf1R0KUJV4TnCEknUnulJ4CNN4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hgo54bG633SIiPWZD0CywGtBrVwP/cgkCK0s3kCLi0gYE1mStnWewHFKOuHK+sTwZMAR+6oZcGiDsP2c8KzcICXJ92uavQ58tHz2qsOmZFlYaviHsFauoSjWCHiuP+C2mFCGtrGz+zvYP1TExt3queUTlGftkPz3MR/wHZ1rjQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WGw4H2Os; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0X4HaqA5xug8gORUs2FWO8WsfcuAFIb+Lp5hYDxtN/i6/YhbDhFdNopzHXtTL8oe6Z35yNzQBBi9TZsKym6S4ORss/oAq5cNp3bC0DqbcYVt1+7wJGzfOReSfFQtdvF9gbnj08h38bZCHY/hSFY6TqW0oqWIx7GLF6Xxwmeb6q4XHGMUai06FjoHPvKoTvhXq9DcFHyw0DhI7f4hsgba+m/xLQ1wqxSiEmoiYBGij+8+uiVi23UIp3J5/BktcW5zrB0gtad2ex3+Auq02m00pzMc39HwS27fV8xeSbDzGtyny/xxR68A+HjONy1ENmbCNg0b9FXGdywqbWfspRiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxjDUfpZxekhi2gj0L9i0BGEnM9p3rAw5JaieUEGVbI=;
 b=Uw+D9p2Qeh5oW9laBCB9m/YKNl8+w0K29zkei765llZCKOT7p4P2glzQGHIf3SGUTTiW1oLZb7hKhtihkgp2lD44ItO9amfkLZM8iEa9bKLcQ3zIEN5eNle1dd0nxnY1h/D4DRp0u0GMITCeAekHE+/eXVzcRyfT8kf4uauUztxcQb4uTxxpLSfHfTK3a8RPPzOghrnNf7TQVujl7H8JpCMZSNsO2yts4w1TdcqJ3KlhfEOeIuR9EFJKyqfQAC+cLTLxZDVqNReNRHa27iD4eIzmz6kZcTNDJnICHp8yWvnkoGcYWmqCKngUfq2nAwKzjZDXr2Ba+7rBqSdLTikgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxjDUfpZxekhi2gj0L9i0BGEnM9p3rAw5JaieUEGVbI=;
 b=WGw4H2OsmTCMJg8Z565tmNU9a1y3Vpyj0zyU4pEGKxgOCCzDGGVJ40pbIlWmKxVlXerg9XubVAxC6XS6swC7DZyrWDcuAK8U7k66n9aIfLXIiDShvjB4AbrVRC8DkpDurBZkchztPaBz7vEYiMVKQhovefBoO1ki00EaC+ljBM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 10:02:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:02:57 +0000
Message-ID: <11dd7fca-0862-4a56-85e8-06580b041f3b@amd.com>
Date: Thu, 16 Jan 2025 10:02:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
 <c3812ef0-dd17-a6f5-432a-93d98aff70b7@amd.com>
 <92e3b256-b660-5074-f3aa-c8ab158fcb8b@amd.com>
 <6786eab3a124c_20f3294f4@dwillia2-xfh.jf.intel.com.notmuch>
 <7fc0b153-9eea-af2c-cd42-c66a2d4087bc@amd.com>
 <6788a451b241a_20fa294f9@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6788a451b241a_20fa294f9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::29) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 5859fcba-19d0-4e78-c679-08dd3614eb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVM1cDE2NFlzNy9sWGlrR0VKMXpyNUVaamY5blkvdnlBRzZjZ1hhczdGZ0FD?=
 =?utf-8?B?RVgvYm9Uc3RNbkNJZ1VuTmdJa3JML2MrL2FmZmdpdWRUVnJud0trWXJzUmcz?=
 =?utf-8?B?aTQxd2Z3VEhhODJCWHNJd0dSR01FVTZVMk02dXhxK2dKSDdETzgwMDB5VWlB?=
 =?utf-8?B?TEVLRUlVYmRldVRWaEpPc3FnVzMyNUxUOUswNVhYRDN6d1Nrd3R2Y3ZJMHg3?=
 =?utf-8?B?SFYyaHZYdlBCbFhNaXVOR0NrZTJ3SHR0RDhlTFJKN01UTWJtSi9ZTmxSYTVR?=
 =?utf-8?B?YUtUc2h4cFR0MC8xZ2dXbFh2bExETVVwOCtGU1FuVDFOTCsraE5kdFVXRWNR?=
 =?utf-8?B?TFI0NDhCUkUxSkFmWUpyT041TTMrTlRmSlkycm9yZjNvMVpOMkdjMmMwZm5F?=
 =?utf-8?B?UVZSWDJ6RmxZdTNYR2wyektwa2VJMUkvWnRsU0xWWmladExmRUtZRi9Kd2RG?=
 =?utf-8?B?RjlhQnVrL0MycUFFN2ZHdE5QWFQwa28wVTI1RFRHREliVWU5S1hqaFVTbmV4?=
 =?utf-8?B?QjF6Y1NXUHVRTDZWWXp6cEFqRjZOSDhEUFR3OFkyeXlIdk40OWQwTlhBdEZk?=
 =?utf-8?B?VjFNNWN5cnU1VWE4R0x0SC9QRW5LRlBvQlF2bXpTZEp1MjllOFMyZmhISzJK?=
 =?utf-8?B?MEZBdHhONWQyQzc3clo3dUpLR2Nlb3lSbHFoVk16bWtDU21DeFhnZHdFZkhk?=
 =?utf-8?B?THhsSGg3OGhSR1RCZEV3VVN2VTJ0YVBnbjBHN1FkZHMyZGh6MG1RZUM4MzJ4?=
 =?utf-8?B?NFdScWN5ZHhKWjZyL2dnUHNSVXdTKzVmK0pHMlFEUXVrOC8zNExvQm5IOXQv?=
 =?utf-8?B?YUxybFoxOURMelZqRXA0ZUF5TWcwcjVTNFdpUHRpLytIejFTV0dTWlNGT0Ra?=
 =?utf-8?B?d0I4KzFSdkJkYS9PZjZZNkRHb2tUbFk2TW9pQWY5aHFwREVhMEVMbit5Vnhs?=
 =?utf-8?B?MGc0aWFQYlJDTGFVRU00L0Roa1FtVHVLWHp2em4xS0hNbi9zSFVldHhCZkZJ?=
 =?utf-8?B?dlIxOUNWbWZXV051dDh1d3c2RFYrdWo1cHRXZDFvekxRTXhobjFGWHF2ZE4z?=
 =?utf-8?B?cnd6U044MjJ3Nkh0VVRYSUtTRXpKa1NRODZuODBycDdueHl1dFlnZGpvbEhR?=
 =?utf-8?B?TzdOa1RKR0FIcUdGc3B2QkZKcHhEbzcrQnFuS1RjVW9yU2dpcnQ1VDFqblhJ?=
 =?utf-8?B?RFdxY0dFcmJPcEhpdHcxczlOZkVrcDVMRlRaUzE2ZitBbkpleW9Bd1MrcjJ0?=
 =?utf-8?B?a29HM0dzOE1ZQ0l0ZytVRVVOUmlpWGtXbS9mVjRmWG5iTE93M05XQm5SVFo4?=
 =?utf-8?B?UU5lbnpMaHRveFRVSGYwQVgyaTJVYzAwRlg3Ym1ybWFBbkhpb0ZXTEtIaVdq?=
 =?utf-8?B?cy9MdVBrVnBKUXltQUxTWU5QUXFtbUIzc0tCRHpDRWdvNWJBUnJHWkh0UldG?=
 =?utf-8?B?Tk8vZ0drd1MxcWlzZ1h4bExvSWcvcmVHV2w3Q0dhZGNUK1N1Z1I1dFRLRW9J?=
 =?utf-8?B?YlpkYWNRSjdtbExYV0RzQll3dXl2SEJnUjF2NW5mQ1VQWHFMN3A2UmFCaEZM?=
 =?utf-8?B?d3BOWGtFa2JLZXprT3ZjaW5DNTc5Z1FTR1BHalVDMi9ZNjBDRWRWVnJrUCs5?=
 =?utf-8?B?WTV1cnhiZzJCMFY4WDNaOUlmcU83dlpKSGs2Sk5OUkdCbTRWTWJyMjQxRFFO?=
 =?utf-8?B?dlJIWFhGM2Rrcjd0cjJLVXpXeTlBUmlRcVRMQ2ZtZlF0eDl3ZkNiQXlERjBm?=
 =?utf-8?B?bFZJUjVid25uM0hvSmlWdjJIZFNieUN4WmhEMHhKUEJWTlFpOEZsRlFSVGRZ?=
 =?utf-8?B?SFczWm96VExzWXFPS0FOK1ZaNmJic1RaNWZ4Z2RZRWZ2VnhBMDduYlJLK2tE?=
 =?utf-8?B?emFWWXNkOUlKUkMrSDFrS3RNZkJtV2NrZ2J0S280ejJoVFJFUDlVZGo5Y0x2?=
 =?utf-8?Q?QEG0zITOdX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjduQ2ZOc2RyZHdaeTFIQVpyRXRUeTVTVjE0bkk4SURtZkhRdVYyZ2Y4WWNZ?=
 =?utf-8?B?V0E1NUcwVXBrN2padmpkUjQvZDR2VHZUMzRTSVU1STJrNzdJZ0tMWWwzQW4y?=
 =?utf-8?B?SXY4d1VVRCtENUVJekN1M3BBRVA2L2M4b0JuLzlFdUlpMHF2ckphNVdmbGdp?=
 =?utf-8?B?bldlaEFycUwyK01USkMzMFBKbG8xQ05LZHd6MXZHOG5NOHo4RFVrR2h0NnQ4?=
 =?utf-8?B?L01QRmlQeTViU20vN2t1MEtwNkZzL2FYOTFGeTBoaGVINi9OUWlQS1FSSGpK?=
 =?utf-8?B?MWdaL2pqcitocmJFeWlRM1dMNmdPVHBUdFRlZGo0NGFjTW9ULzcvQmJoRGFL?=
 =?utf-8?B?eGczSXRWL3Q3VVFmV0xBT0t1NGRDQUhEYm1tMVZnZFpnQzBibXpQWHRvaUxz?=
 =?utf-8?B?aEw3SGR5OTV5N1RFUXNIeXdZQXpzRHUzOFB1QUlhMW95NmdpOVVEMEJuUEI4?=
 =?utf-8?B?NllYTmluVHFVUi91RjQzOG1GQmNOS3FhSXV5MjJSQnZQYitQVjNsYWsyeGpN?=
 =?utf-8?B?SG9Sb2R0Tzdpc1JFc0pxM3lkT3M1Z1M2c2lRQlE3SjRpNElkR3JRTVBHcGlE?=
 =?utf-8?B?QVA4MGs3cTlvNTdrZXdNVVNSb1V4UXB4RGdEQ3RtL0dIUTh6bDB6NENUYkxs?=
 =?utf-8?B?RVA5L2NQYThxQ1dJM0V4VmQvWU5GY0llWDNtZXRPT3ovRnlCNXlRYlllaklF?=
 =?utf-8?B?emtvUFRDdytOdFd5R2diZWVOWEZoUGxydkRwTnFaL1BTMGVUWk9xWmYzNFJY?=
 =?utf-8?B?UGtXQjk2WC9LU0dKbXFscEIyS1ROcHJ2RWxET2FQUXlId1lOeVZWOTlJbUFQ?=
 =?utf-8?B?M0hFM1dSWis1b2VWck9uUGJvc1dJdWIzd3VGbWpiZit6RGxwRytYTE1pUW5B?=
 =?utf-8?B?a3A5eFN3bFJ5ckNjMnREY0FGMUlIbS9lZ2ZvTUxDeUFmeGlDRU42Z0plMURC?=
 =?utf-8?B?RVhvK3ovY3NoTFFGTzRlaS9hU0ZYV0kzcHFFcUo1dDFyd1pnWWEzVHhvbXA4?=
 =?utf-8?B?RFhCZUN1VnErM0pHTEgxSkZuNWQrdXZxNnlvTytYaWJQVUFQOTV5WEFEWlBr?=
 =?utf-8?B?djlmVHc4ODhNSE0reVU5QXpPQUJkZWZGN1h1TVVEQXNueGtKb0FQZHJ1UGdU?=
 =?utf-8?B?b1lsY3laTkszY1VYV2YwaTJ5ZE1pK3RmcUZ4bWV5Uk42WU01MW9iaitEWDJy?=
 =?utf-8?B?cXJreFJnZEFUTys0WnVtYkpCakRqaTlqdkdOQnBFbGdweGVmMWhPWURhTEJt?=
 =?utf-8?B?SmIzNlF5cDZ4NWtqMFl0ZUNoQnl2VHgrUDA0eS9MRDFzZGZGVGJnRnNzVlNr?=
 =?utf-8?B?MHd5UWlpUkw2aXMwbGVCWU5NMmxoUUwvL3NHaFltV0F6VWFaMGhlYnpZSDFv?=
 =?utf-8?B?VUxJRnZyNEd0ZXNwaS9nQTdoWk5wSFJDNDN0WitxajN6OFlZTUtXS2FHWnNx?=
 =?utf-8?B?L2FQSEt0RzhLZVBzM1p5UC9BbWl3ZlhkY1hwVFpEcmdpYnVBWUxCVHNYNHlm?=
 =?utf-8?B?RnRMTTBUT2MyMTUrTUZ0U0Z2RWt6NDd0VHVPdnhzM0hQSXBBR3h6UU84ZWNO?=
 =?utf-8?B?YTdzZUphU1FjVHpvcG5mUzlOa3FncVhQWGRWYlU1eXRwYWF0R2VYQUM4Tk9k?=
 =?utf-8?B?b0JQTHR1SjhCWWFUQkdKOWdja210NzhuQTAvV1ZhbGdxMTRyQlNORm03MWU0?=
 =?utf-8?B?Sm9qYzA1eWl6YkJrNmszSjlCbUJXODg5MWV5SUhnTlJzbkxhRkx3R3JwUGRv?=
 =?utf-8?B?alByOGJPNndHY3ZNUEIxMzJzc1M4NTRaTzZsM293Z1dZL2hCTnpqUjJIMGox?=
 =?utf-8?B?R09jVDNVbWJURnhSaCs4ZlBKUEpBNnlzM3pqcGNHUThMVGR3bWh2bTBCQjNP?=
 =?utf-8?B?OHM1eHpjSkg0TXpubGtaSW1vaW4yaGgvTHFHL3pGVnE1ajh6QlEzRmdCQ3Zw?=
 =?utf-8?B?WllJMGFpWjNVS1BRVklKMWpGVEsyZFBuZWtoalBiY3BGdWN1amo4bC9HcVpV?=
 =?utf-8?B?MnBJS3J6ZWtjaFp2cTk2UFdmY2M4NCtIWUIvZVJvK0F4Uy9XMkd0cVRGU2to?=
 =?utf-8?B?MU9xMFRWRXdETndha3VyNTBQalVaUloyaWtpVGNFMEJFUGNrU2VuQU4wcTFt?=
 =?utf-8?Q?p/RnX0sWVElMNh/bWUG1XNkPU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5859fcba-19d0-4e78-c679-08dd3614eb12
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:02:57.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUASideanYugndLAJmQQ8gvlNpXLS7V0VgqBFHveKdX8HacDxYLET7CcdFSjM39EDQAeeb8gbqK7pfB6iFczkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044


On 1/16/25 06:16, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>>> I could add a function for accel drivers doing the allocation as with
>>>> current v9 code, and then using your changes for having common code.
>>> Let me go look at what you have there, but the design principle of the
>>> CXL core is a library and enabling (but not requiring) users to have a container_of()
>>> relationship between the core context and their local context feels the
>>> most maintainable at this point.
>>>
>>>> Also, I completely agree with merging the serial and dvsec
>>>> initializations through arguments to cxl_dev_state_init, but we need the
>>>> cxl_set_resource function for accel drivers. The current code for adding
>>>> resources with memdev is relying on mbox commands, and although we could
>>>> change that code for supporting accel drivers without an mbox, I would
>>>> say the function/code added is simple enough for not requiring that
>>>> effort. Note my goal is for an accel device without an mbox, but we will
>>>> see devices with one in the future, so I bet for leaving any change
>>>> there to that moment.
>>> ...but the way it was adding those resources was just wrong. This also
>>> collides with some of the changes proposed for DCD partition management.
>>> I needs a rethink in terms of a data structure and API to describe the
>>> DPA address map of a CXL.mem capable device to the core and the core
>>> should not be hard-coding a memory-expander-class device definition to
>>> that layout.
>> I think you say is wrong because you did not look at patch 8 where the
>> resources are requested based on the parent resource (dpa).
> Patch 8 does not make things better. It leaves in place the confusion of
> cxl_set_resource() which blindly overrides, without locks, the values of
> the DPA resource tree.


The confusion is mine now. Why do we need locking here? It is at cxl 
accel driver initialization time, no memdev has been created yet, no 
region either. We have just created the cxl_dev_state. What can make use 
of this requiring locking? What are we overriding here? In my view we 
are just initializing the cxl_dev_state struct.


> It further perpetuates this "enum
> cxl_resource_type" proposal which I think is an API mistake given we
> already have "enum cxl_decoder_mode" complication relative to new
> partition types being added by DCD.


A decoder is not mandatory so we need to make the distinction.


> The usage of release_resource() is
> problematic because that deletes child resources, and static DPA
> resources do not need to be released when ->dpa_res is also being
> destroyed.


It does not delete anything, just releases a resource.

I agree it could not be needed if always relying on dpa_res destruction, 
what is the case at least in our case. Having the complementary of 
request_resource does not seem problematic to me, but I wonder if it 
could be really needed. Maybe there is the case for virtualization when 
assigning the device or parts of it to a VM, or other cases where a 
driver does other more complex things.


>
> Much of this stems from the fact that cxl_pci and the cxl_core have been
> too cozy to date with assumptions like "cxl_mem_create_range_info() can
> be lockless because it is easy to see that the only user does the right
> thing".


Again, I can not see the need for protection during cxl driver 
initialization. What could go wrong? Or where are the potential users 
colliding here?


>
> In fact part of the motivation for the 'EXPORT_SYMBOL_NS_GPL(..., "CXL")'
> symbol namespace was to flag potential consumers outside
> of cxl_pci to consider that they do not know the cxl_core internal
> rules.
>
> For accelerators, which may be spread across many drivers in the kernel,
> clearer semantics and API safety are needed. I.e. with accelerator
> drivers are entering an era where the cxl_core exported APIs can no
> longer assume a known quantity cxl_pci consumer. It needs to be a
> responsible library that limits API misuse.


Sure.


>> After seeing Ira's DCD patchset regarding the resources allocation
>> changes, and your comment there, I think I know that you have in mind.
>> But for Type2 the way resources information is obtained changes, at
>> least for the case of one without mailbox. In our case we are hardcoding
>> the resource definitions, although in the future (and likely other
>> drivers) we will use an internal/firmware path for obtaining the
>> information. So we have two cases:
>>
>>
>> 1) accel driver with mailbox: an additional API function should allow
>> such accel driver to obtain the info or trigger the resource allocation
>> based on that command.
>>
>> 2) accel driver without mailbox: a function for allocating the resources
>> based on hardcoded or driver-dependent dynamically-obtained data.
> Lets just make those cases and the memory expander cases all the same.
>
> The DPA resource map is always constructed and passed in explicitly, not
> a side effect of other operations. Whether it came from a mailbox, or
> was statically known by the driver ahead of time, the cxl_core should
> not care.


Right.


>> The current patchset is supporting the second one, and with the linked
>> use case, the first one should be delayed until some accel driver
>> requires it.
>>
>>
>> I can adapt the current API for using the resource array exposed by
>> DCD's patches, and use  add_dpa_res function instead of current patchset
>> code.
> The DCD code is also suffering from the explicit ->ram_res ->pmem_res
> attributes of cxl_dev_state. That needs to cleaned up for both this
> type-2 series and the DCD series to build on top.


Perfect.


>>> I am imagining something similar to the way that resource range
>>> resources are transmitted to platform device registration.
>>
>> I guess you mean to have  static/dynamic resource array with __init flag
>> for freeing the data after initialization, a CXL core function for
>> processing the array and calling add_dpa_res and aware of DCD patch
>> needs, and the resources linked to the device and released automatically
>> when unloading the driver.
> The DPA address map is not dynamic. Once it is initialized there is no
> need to release them.


I meant the statically resource array created by the platform driver 
like in arch/arm/mach-omap1/dma.c with the res array defined in line 79.

It is used for giving the resources to the platform dev core then 
removed due to __initdate. In the SFC case, we can do a similar static 
definition, but I guess other drivers or SFC in the future requiring to 
create such array dynamically.


> The DPA child reservations need to be released, but the
> initial map is released just by freeing the cxl_dev_state. Notice how
> there is no DPA resource release in cxl_pci for the top-level resources.


Yes, I noticed that, but not child reservation for ram or pmem released 
with the current code.


> I am taking a shot at putting code where my mouth is to unblock the
> type-2 and DCD series. I.e. just converting ram and pmem to an array,
> and splitting cxl_mem_create_range_info() into cxl_mem_dpa_fetch() and
> cxl_dpa_setup() where both the accelerator case and expander case will
> share cxl_dpa_setup().
>
> Going through tests now...


That's super. I hope it can be integrated soon.


Thank you


