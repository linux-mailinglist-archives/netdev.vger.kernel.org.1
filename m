Return-Path: <netdev+bounces-132289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB009912D8
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E028448E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837814F9EE;
	Fri,  4 Oct 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjjxUZCK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55F231CA3
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083701; cv=fail; b=R5y81hKc3LdUUoejL7EZDk3VPXMZTPYnw1fjdwVXMMx4DYB1XHnn3QHnJjbEc5eFIp6AC3oMJLotz6GsBtJTptIcDJhSOW6TrIBduCn2KzVscVQhG9LuFg/YJyAVSA/pn70wGy0Gqh75k8BdCdIFJIdlOvevWbjC29z4y+2r41o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083701; c=relaxed/simple;
	bh=YVd4UHarnY8KSvXKJk0pk46e8nkwJHKz4fyrr0EQDQA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WJ67bvT/87srie96yDQLw6p7aGjVzdZHLV3Op8FI+Pnrg0McEMY0K8EbkAhK6rLhCc01vWgK33HcOufIQaMcrL9AWIzFABbFdTZymRTwMnqrHKTAuUpcZ70Fb1pciWUe0V65B+K5GvxeONndVEl35iE+u61vLZao2sdZ6cQ/p9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjjxUZCK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728083700; x=1759619700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YVd4UHarnY8KSvXKJk0pk46e8nkwJHKz4fyrr0EQDQA=;
  b=SjjxUZCKOPmB71N1atiKRAO1b4mKZeTQjAog0m1EcpQmBx3i9e+XwycJ
   iri0ukJV21gM086BfvkxBIcoNK1rXet+64IBajFTsd+FbkbLSM5v4+4Uk
   U6cc+iZPXWTvl70YDKoyKxFipyq3ncGmpTOCXWs+T1hFgrMxYlhpZGM+a
   0kRtL7ieK9iqu+t/seGPw7onQwd2UscYLS69kHRxitcqnQDv3kohG6nFR
   8fiW16seSygwxupdbi3pxRmYYxN1ykVnjrHnHPchiiqBl2TPz4Rq4kcc6
   1lN1FFLMiqDJCCpEg4UsRNCiV32Dc8hGQz54PBnr96kBvyu0GJjbRTAwh
   w==;
X-CSE-ConnectionGUID: DZ7GFjRKRrSrOgX6M6M48Q==
X-CSE-MsgGUID: 74FolhKrRAeLM64F++ZFtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30202646"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="30202646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:14:59 -0700
X-CSE-ConnectionGUID: YvY6o4iAQ3qMzGvkkGSZrA==
X-CSE-MsgGUID: hLOOwZrJRNeRjp93RNbeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="105698911"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 16:14:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 16:14:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 16:14:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 16:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd5lCmf49551/hEFaVcIBMw6t708d74H8T8UfFHNWO+B6OZKHjjcn+YF9OhMipYy/lo8s4Kcj2xf/V7R5criW5E7dObnHYOaK2NKzdW1gSVVCy56NgY456hC7eOm0YoiAGGuhs2Qo7gAykIuW3Ps/mttEtidDE5QNvVCV/jQbhRbSWqMPiccTSuCi5PS4GHeHrSgo8eiL1v5iiIPNgg5MK/mhR+MiE4ZmR4r84eZthkVJ/eEq5BXjqT+dzPRY6GEDrFRdscCaI2jwdz6tZtUfEQ2WyOGIk58qAeNmkxyCmszlt9vI7TlcqWWfFR6/rYoyj/nbAOiTDpOVhdYRJZodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM0tR5ikQ+ptgHF1O9Mvr0/Z6TH+vhEx/puPH0/dVV4=;
 b=jgOeO1ZNbDZ/efh7AGIU+vgFUxKRTxgaSHylepjZy+dcrr7hr2HdQExdYJgYCk3Ap96YS8DnKWXd78J77xslsWtdoFcs656MwXwfShRGJa2HTITIbrJA3nP9VkqQimZaVhGbdkrsCML3nhdW6LP06ySIiLIk4tEw/xOsmlNMG/I7+4Vr96RJGQX+cANojnvtr9qKNCF8JG6AyD2EqKIKpFgn13Amly/qJT+bjoP5flUMzxh7gyQD5cay2zOVBkE6KAyGnZy5crhEB5U85hCFeGwXOx8IoMkT7jixchGbPRK91LJwo6FbpIGVDIBQd+TPlRE/ffOnYGqLG6Gw3qCDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DS0PR11MB7530.namprd11.prod.outlook.com (2603:10b6:8:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 23:14:56 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 23:14:56 +0000
Message-ID: <a64b3bfd-8a85-4523-aad8-e4b534448a0b@intel.com>
Date: Fri, 4 Oct 2024 16:14:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] eth: fbnic: add RX packets timestamping
 support
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-4-vadfed@meta.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241003123933.2589036-4-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DS0PR11MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: b41ffc18-5449-4cef-d4e7-08dce4ca5aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnJGbENoWVp3bXdPTExPZWRaNW5JM3kzMTNWRkprcEN1UmszUVovZmRBWXAr?=
 =?utf-8?B?c2VkWmhtRU13RjkxQ081cy9QWkZvUnBvV1hjdkoyV1Rtb3RWTDRwRmRGWEh3?=
 =?utf-8?B?d2xtRi9qMklETjBJWG5sSi9mR2J0VzViZFhpbUh3dlpKZUtMK3JYZTZHcy8y?=
 =?utf-8?B?RGNieGx5MjdUdjA0cklvQmxNWHh2OUVXb0VoVUhlMFozZzlrZ0ZWbEJ6Nnpj?=
 =?utf-8?B?UzhiN3lrMk02RlRSN3BQQ0V0ckhxakk2RWlYd1RvQk1Lb1lQVVJUcDhuRmFC?=
 =?utf-8?B?c0UwNUwxaUUzNEpqeWdrUzR5S25vYUxiMUwweXRMaEMvK0RnV1FaSk1BRVpu?=
 =?utf-8?B?VlFLanhvNjNJcjZFYy9uUXcrYkZHcit2VHJuNlhhaXJHVHBJMmR2YmhIRGJh?=
 =?utf-8?B?MXBHZVErM25pSXk1WkliRUZ2bDJGYjJzby9HV0MvanJlcXJNOTNFT21iYjlY?=
 =?utf-8?B?U2ZGNUdPenVVVVZTRk5rbGZoZ2pGOS9UMTZHU2Z0Sjd4ZC85RTZvUVhpT1pu?=
 =?utf-8?B?MGtzSlRVZE10bEdVU3VkMHJPVWJVYm1iZzlmMzE3VGJhR3hIbjF3dTkramZ5?=
 =?utf-8?B?L0ZYMWNON0NiOXduS3VSeHNxRjhTV0l5N3cxV3oxNGVLWnVVMXF0WHAwQjNq?=
 =?utf-8?B?a0tCQ29JWG9Qdk5GL3Y0djdNdERxUXBEZm1HNEdDM0habmV2OU5FSEhvWmRD?=
 =?utf-8?B?Tzc3OW1IUHZxVGFDcDBvZ25ucTIyNjRoYlZ1ckhvbFdMd2htUTlWRnlmTVpn?=
 =?utf-8?B?ak5pMnZyb1pWTUk4YjhHRkRYNVlTNTJsSWh2eFVzaWpVUmpna0NHOFNJcHdV?=
 =?utf-8?B?a0YyQkJBNXNZalBJdlZaQW9hODVRTTh6dUl2ZnR5WjBZRmhlR2g4OEhDVHl4?=
 =?utf-8?B?aGRhVHFBR2hYMDA5NFQrZkRHZmNWTHdkV1NmYSs4enZTcG4wb25zK2ZwMmdK?=
 =?utf-8?B?OUh3S25zcWRvdzdsa1VTRHpnbkhZZ1Q4YkVKSkl4c0pPc292MjJFTnlTNFMz?=
 =?utf-8?B?cGJnWGswQ2JkaytUL2dDSHdnMGp1dTBOQm9KUVFkVlE2K2hFRnB6U3JpeFpC?=
 =?utf-8?B?QXFTTmJmNGdoaGhLNU9USTdUejJDWnNPSDIzcFVsTUtQNEFPbHljQjh4KzBy?=
 =?utf-8?B?Q3psekFDdWpHSXlqMGJvUFExZUFvanRMYlgvUXVRYkZGcUdhTHMrUFl3YkVQ?=
 =?utf-8?B?MnpQN25xR0FNVFJRYlM2ZHVFMldDRFg4bXI2Zmova08yWVZlUmdpUzh3endY?=
 =?utf-8?B?S0ZIZzdEemg5STRaMEw2bkVSOVFPb1EwN1VVQU5aSG9lVlFRaktYN24yZmlH?=
 =?utf-8?B?OXpaWDhBeVE1R3pKc3RyRWsxbnNTalF0eGZnUlpmUXdaZW5zY0dPNEpwejR0?=
 =?utf-8?B?MTd3UHN4WDZnaGVGZTRGSkpuZzVYN3E0Z1Foait4WVFOMmplckJzWGhxV2Zn?=
 =?utf-8?B?TURXT1I5anEvZkorS3RwRzBDTGM0NHk5OFh4Y0orK0pGL01wa0JRMFFqRStp?=
 =?utf-8?B?aEdYS3JCZkw5RXYrT3FvSndpcC9rYWYxM0JxR2UyNDF0ZGJ1QnlFNGwrY2xN?=
 =?utf-8?B?N2gzK1hoM21nZG5wV29xVi9QaGU4YXIwenlsL3hqWElneFFoWncwVzkvS0hY?=
 =?utf-8?B?RnhYakF3UUtrczh5UzkxSFJhMG92Q3dHVTdINzJ0d2ViWmNYNVU4VjdUUmds?=
 =?utf-8?B?ZlRrUzZ3MzRBb2VEaUpxV3k0bUVPNHZ0aVFCU09tRngwYWFQY1E4THhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBtUXhxK01qSDF3eU5jT01HbVJiUjhaWG1xcXBPSTZycXREMkQxTDd4Z2h0?=
 =?utf-8?B?c2hqSSsweDRHNUN5cnpZc0lXZUlTZmdoNHFSc1Q4ZFZJZ3JWZjA1T1NUeWNS?=
 =?utf-8?B?V0tMRUZtdXlmS1JUa2lpd1hUYk5xbld4ODZrK1VBWmpRSEozdDJEekdnMnE5?=
 =?utf-8?B?M1ZKcFBuZGFpK1Q2cXYrb1Y0bjRvTjU2TS9xeTZBbURFOFY2U0VEMU15WUlH?=
 =?utf-8?B?SmVNNERtcUlxdWIxY0tvUmN4cm80SDMwRXlpcnVIWFBLMU9hdXQ3UTFUUDlE?=
 =?utf-8?B?Q2hRWlZXR2VZNEVMOHA3V2hMa0dFcVRoK2tSeFlON21Vd2ZLcGpnZGlrdWNJ?=
 =?utf-8?B?a0c0cVNmbzZPV3VwRWZJVnVQNUcyanVhM0VqM0c4dG1tY3NYai9tOEoyZ0d4?=
 =?utf-8?B?WENKTFBLMFJsWktFQUd1Um96YTZ6Ky9NU29JWll6d2VUQXBVUGdXNFN0cEdT?=
 =?utf-8?B?LzNoWFhYSkxldk5BRTNmczk4aVptUHJpcHYxVlZmWUl6VFZlbHZpMzU5UndK?=
 =?utf-8?B?dlRxbFZCZjJNM0lZM3hFaHlPZjZyMWJXVzNmdFJDT0cyL2ZJWklIbU5TbnNK?=
 =?utf-8?B?TGFtL3p6RWR6b2c3Z1NWcGNyNGp1L3FYNys4S2d5Y1hWbnUyZzR1ZXRYcUVI?=
 =?utf-8?B?TmZZVi96LzhVcUpOemY5T0NJU1JOZjNteUh5RzltY3NDdjRZVGJrNDdFaFBt?=
 =?utf-8?B?eVJtc2Jwb3MvRzlZYy9XMXRnN2R4TEhDcjdDSUozMVhZVVVvTzVYajhOZVRV?=
 =?utf-8?B?ZmpNREJJRllXVGttODZuNUdUR0xQNEFWWlhRRDd0L0loSW13ZFI1R0VGS0NX?=
 =?utf-8?B?aFpvTmZJMFZlRy9pSW5ycVVaSFN1WGJBTXdiNStGNnBDSVp1RkJuYzQzVEhK?=
 =?utf-8?B?akhaZWtlcW4va1Bvbm1BZ0pBZzAzQkhzRVNlSFNzN2duL2xjQVB3dEI4bHk4?=
 =?utf-8?B?UktTYzRTaUdMVXhmcEN6eEJBTnFzLzQyVDBTZnQrM2Q2ajFZR2NNT0dMS0Zl?=
 =?utf-8?B?ODFYOGdzc1Nqdkc5bFJWQ0N1dWNKbjFrMG9RTDQ5TDM2VjQwMERMTXFOckJ5?=
 =?utf-8?B?b0hQaC9uR0VZQloyRy95SHRRa3Y5S0FZRUprL0JmY29GekNQdW43d3dsRzFn?=
 =?utf-8?B?Q3p2TFo0RmFmUFNnU1Bpb1BWL3pORFg0RGk1SGZMOUw1Z1hBbGNEZmx0TUMr?=
 =?utf-8?B?TUV6algyaGw2RzVDL1JKSEM3RmhzdG5FOXR1N2psRDZKb1Z1OXRkendCaU0y?=
 =?utf-8?B?djhBY2g3OEtMaUVCV1RCYVlhcFVHVHFhNUw4eUNRVUhpd0dVMzhBMDNYSllS?=
 =?utf-8?B?TEFiT0trTFh3a0lZbytoV2UwaDh6a3R6NFdkTWM0ZTlRT3V6ekp5REZwUHp1?=
 =?utf-8?B?bVA4cllzdkZuUEVTK2dxTnI1aXZtNTVUbTZONjZ2NlFaMyttczJTanMralMx?=
 =?utf-8?B?MThXQVVDMDNCTXZieG9zaFB4ZnJPbXNIdlp2Rmpwc3crNGVHa0drOUVPb0J6?=
 =?utf-8?B?cFQ1ZHpOZW5jRDl6MlN1ZTFtSzhKNU5VK0dTSmxyUEt4UEJOcFFEL3ZiZ3oy?=
 =?utf-8?B?ejI5ZHgwOHVXb0pYZ2djUTVJdTI5Z0VOcGJFTEdla3ZNNjJ2Y1NaTGRsTk1i?=
 =?utf-8?B?aTRwUVR5WTZZTUFHYmlRZWgyb2g4ck9XZU9tRW1oTU1YeUR5V2xaMm1KcDIx?=
 =?utf-8?B?UVlXbUpyU29jSjdycWhFdEZqbUNyTllETlB1MjZzOTdJQUwzeWIwM3p2cnhL?=
 =?utf-8?B?L0hKYUsrd0Jqd203RW85VFpEOU9WOEZ1c1FmZFVwQUgxajBzd1lqTG93NHVE?=
 =?utf-8?B?bTkwL2VOZkNDZDExSFBuQjlUaHh4WFh0ZUN2VGZYU00wUUF6YkRNSnhPSGNy?=
 =?utf-8?B?TnRFczRjZmxyWUZqYlZhUG5DZThIWlRSRk1BR1ExblB6T3pybjVqQm1JMkIz?=
 =?utf-8?B?OEsyUXM5UXFWODREbVlwMzJrY05GYjBIZU9aaFArMVBES1NHUlVaK21vTURu?=
 =?utf-8?B?VWtYSHBlQVdoV3dLYmhScU1oTzB4NlN5T1N4YUo3N2VzODZLV0VWdmFEYnhG?=
 =?utf-8?B?aTFENWVuY01vSXFiUnFZa1ZUNUhmREJ3UFFZd2FoKzZNaGl2ZEdkak9sZVFH?=
 =?utf-8?B?YTViaGhiNmZaM24yWkhvVm0yZVVHU0JudkJENkpYU29lQ2lFa1VUL05mamVL?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b41ffc18-5449-4cef-d4e7-08dce4ca5aed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 23:14:56.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyjnNkMUdiBNBfpA5ED1a9fakLobgWKsuQM8FaQD/eszZdPAmPQjmihRPTKkEZbbAUqUL0j4OsAP9OKmzAdDeNzqxSjSenuojvW3J9KXHTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
X-OriginatorOrg: intel.com



On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
> Add callbacks to support timestamping configuration via ethtool.
> Add processing of RX timestamps.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>  
> +/**
> + * fbnic_ts40_to_ns() - convert descriptor timestamp to PHC time
> + * @fbn: netdev priv of the FB NIC
> + * @ts40: timestamp read from a descriptor
> + *
> + * Return: u64 value of PHC time in nanoseconds
> + *
> + * Convert truncated 40 bit device timestamp as read from a descriptor
> + * to the full PHC time in nanoseconds.
> + */
> +static __maybe_unused u64 fbnic_ts40_to_ns(struct fbnic_net *fbn, u64 ts40)
> +{
> +	unsigned int s;
> +	u64 time_ns;
> +	s64 offset;
> +	u8 ts_top;
> +	u32 high;
> +
> +	do {
> +		s = u64_stats_fetch_begin(&fbn->time_seq);
> +		offset = READ_ONCE(fbn->time_offset);
> +	} while (u64_stats_fetch_retry(&fbn->time_seq, s));
> +
> +	high = READ_ONCE(fbn->time_high);
> +
> +	/* Bits 63..40 from periodic clock reads, 39..0 from ts40 */
> +	time_ns = (u64)(high >> 8) << 40 | ts40;
> +
> +	/* Compare bits 32-39 between periodic reads and ts40,
> +	 * see if HW clock may have wrapped since last read
> +	 */
> +	ts_top = ts40 >> 32;
> +	if (ts_top < (u8)high && (u8)high - ts_top > U8_MAX / 2)
> +		time_ns += 1ULL << 40;
> +
> +	return time_ns + offset;
> +}
> +

This logic doesn't seem to match the logic used by the cyclecounter
code, and Its not clear to me if this safe against a race between
time_high updating and the packet timestamp arriving.

the timestamp could arrive either before or after the time_high update,
and the logic needs to ensure the appropriate high bits are applied in
both cases.

Again, I think your use case makes sense to just implement with a
timecounter and cyclecounter, since you're not modifying the hardware
cycle counter and are leaving it as free-running.

