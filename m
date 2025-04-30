Return-Path: <netdev+bounces-187159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626BFAA55F7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84C016BD3D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B72BCF79;
	Wed, 30 Apr 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQ4Ex/O5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE61188A0E
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045820; cv=fail; b=KdlFgNh3/QChnY90sxRGp1DbUrUbtaAsQphcC5UFhZK5JRSXadqfhymlkFIBWK2VqiSHSIuzRCnKQqkJ4DTgrIoLAGM+WtaHzNdAMtCi7g6Tm8as+imi8mtJ6LO1RWjxfW1Vi/B0b6MYdaDMRzxR06XOKknLywdWnZ6p5km2J0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045820; c=relaxed/simple;
	bh=KxCkS/x65ShVfDEusEtji4lIN2xIVJUJlT8zDwT38bg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyXUtAWiCizqJH6vZLJrfNUpkJ3bvRy+IZmq6tc9LpkaaKBI2EIt6HmITcDM9b0207xzFc3EyL31jV7xuFPZGOLBWHBYUMBlLkIA8cZlceqtWL0E44gDUG/luDhFYnkWnJZJbu2FFjfGcGqZOQN0Z1kVCIOS0Dzb/AZQvON2mPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQ4Ex/O5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746045819; x=1777581819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KxCkS/x65ShVfDEusEtji4lIN2xIVJUJlT8zDwT38bg=;
  b=jQ4Ex/O5OhaoBvL/6CYydDSgMDzTFStXt0LqftlbqYvW/nrmc8nxffb+
   1WeRVDQxNZG6H1pLPSXsZkEhDwtNACsQg2p8Fp40WZL3nAAGLIfZ91rmx
   HNOKlu2E6peSrDjv/ku8r/0FKHWMnQ79tbm9v7BCD5fpgFRcewArT+Yh4
   jy3qU93ZP5zWglK/EaoJDelUC1tLsKNAe/wMxQqSGFVTIe2CxvAYQPO2w
   fFJB+yyfc4tf4OPu2XhMB/vYzXL51QkHRYqKWSYN09bouxWGo2CVhXQ6k
   WSXmDYpqyyChKh5XEIGsZ2mHhC1dGnFyzrBOE77uIpP0Upo9DLNu7sKLk
   Q==;
X-CSE-ConnectionGUID: 4Wybu3nTQK2+SR3ISIc5rw==
X-CSE-MsgGUID: 7GbhbF8vRQqCnn3V/frejQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47439411"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="47439411"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:43:38 -0700
X-CSE-ConnectionGUID: /k823oh6QLG+n7fCbA9JNQ==
X-CSE-MsgGUID: qhDsvY1iQS+O7HmPp66CZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="133959623"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:43:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 13:43:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 13:43:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 13:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEjINQC3hp1XFV0HsDxbW9yRyjqnqEmvG5DxMBDOW4+nnHVRvDMS1lbEltvsec0BpQHz9frSOrbaCoe46YEkbdj+vmD4Lpfs9D7APUN/TljwnWI5zgbHBhGmC7vp4i/IiCleaDnUP5lUPGTs27DxiCVsaeEFJCqGYvWEu2tdKLNVrgyzdQYI+rRY2N6jJD/mB7tyzDNnuejmMwutxYh/8jbVYqg6q3oWmLRvwDXo0O5fkMSPjuPS9cv9iPUBbH9Hiqcle/knC7ZP0AtcIrFyp+dSXRbsaVMrY3bi25B7eQNffAlR9Cx0P1uWF0EUc3HDUalOuVTN2pKGQUkccKPHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+atZ9u+gS6kv3BF7fDP3ymkPuEvRss3n4Zc7EeYLaRY=;
 b=qYCrcUkq9vZD2woSY/fRKK+MSTKcjIruBRzWCrfD1t0G3rzIu3EVnDQMHq258f+kE+KyiLcL2kqUelmqh8hwX18xWDKwVl1AB96dNCOQFxX7cq1P7T+sqcW6TaSDRw/np4x/Foa6m4dS4ILu0GHiZ4qwNpZRaCsSpaMqAtUZmBGRNOu7xKPbjcd2VzqlBAZGedFVaXMDH0oBTxBRzOcBbE9cgJdqwPitUDtiwZg8e3tT5fUatlygKXeVwjnadUDexfT0EYR23NMfxjtg+aPsjD4tWl0QLJP02YbsPzLeCwuidg23Yqa3wEU3NU6SPcq5l1kVOqzUmaaIldmruGyBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 20:43:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 20:43:33 +0000
Message-ID: <243fa8a5-4872-40b3-9859-af475b4d6ad5@intel.com>
Date: Wed, 30 Apr 2025 13:43:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: factor out provider part from
 mdio_bus.c
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <88f05558-21f5-4554-8f3c-ced45019b937@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <88f05558-21f5-4554-8f3c-ced45019b937@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0322.namprd04.prod.outlook.com
 (2603:10b6:303:82::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: a865115f-8441-4274-be05-08dd8827ac7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG5xaTYrVzhGWVRJamlNYXM4YTJicmRoSU9FdGhDT2M4ZzFCVGxobjNtMExQ?=
 =?utf-8?B?Q3BFeFp5YmwrVG00M05UZkRaTkptaFNnU3FQS1VSZmdSMW1HUDdraW51U3M3?=
 =?utf-8?B?SXRwVW5qb1E5azhOemQ3enVaQ2Z2TGhOZXdVMmppemo0eTdHTS9pOUtQWlU1?=
 =?utf-8?B?eWtKdFFVcHJFK1BDUnpCeDYzTnBDRHpuelhYWDMwVWk4aTg0YmVUTVhWUE5S?=
 =?utf-8?B?blMyNXVlVzdQU0sxa3ZJMUtzM3NlSVB1aHNDMHFqN3hnNVpFTmpFRU5ETUY1?=
 =?utf-8?B?djMxc1EvOVJPK2gvSmIyWXZRMHVSdzN5SWIxMHNxTDF6Q09vREhHbGx5RFl4?=
 =?utf-8?B?bnlxaXZobGlMWDJPZG1Fb1k2RENaaFpyS0lVS1lOMmZ3Z3ptVGRKOWFHbUxW?=
 =?utf-8?B?MWR1d3FPbkNqT2NwS2ppMEYwc3Y0cyszV1lBaGJJRU43T3ROMUsvdFFLa1h5?=
 =?utf-8?B?TGNBQVdwbjlYY0pOd3RiMmtrempqa2lGb1FWWUNLTkRPQ0ZPTllpdkI4MWsv?=
 =?utf-8?B?aG85L2lrVERqaXBXM1lOVW1ybEsvWG1LMHRHR09OWlhaaVZ6TkFUZVJOak91?=
 =?utf-8?B?V3lCczJTY29mSXRyM0IrMm1yWEdXSjBvWERpamgza1RBMm8zMXJoQ2QrcVNO?=
 =?utf-8?B?STFTdGw3RCtPZHliUFhvQ2RsZjhjc2xtOFdpRFJkejA1Rktwd0IycjFHZXJK?=
 =?utf-8?B?MldFTU9wNm00K3ZCYWs0Q1pJdEpOZEYwdFhjdTJrMlh0MXBZdGVoNEFpSkxD?=
 =?utf-8?B?emZ5dE5qbytGZTZrdDUvNnVVZ3pKMjd3Z3hrN2lLb05hR256emZKNGJQcmRo?=
 =?utf-8?B?TmVGVE13bk1qVjVQRGN3ckJlRHVDbUp1NDlPOXgrMUpqd3RweTc2QXdsWUpO?=
 =?utf-8?B?b2ZwK2p0NUZ1VEdwNUVkYU9rdm8zczFyc1UyNFgwejF0dkg0M0xHbW9iNFFu?=
 =?utf-8?B?SnVWUW52MWFId1Y5QzNBVVluUy9MRmtBb3BoY3gzU1NqckdmQ1hVZzJCQmg4?=
 =?utf-8?B?OE13cnU2NUNMQ3pwU1BuTDRqTFVPaUU5cHozTWNSV1orN0hOb3dhRlpmYm96?=
 =?utf-8?B?UktGUEt5ZjhWMzNiUDRmMmp3aVBMVW5WTEUyM2ZiTXhyZHpWMGF0ekVzendI?=
 =?utf-8?B?N01nV3ZJN2prdFFFamoycW15SW1ZVHYyMFI5Z1UzS0JxSlMrbUVsSUdXMEtx?=
 =?utf-8?B?Yk8rNnBLMlE2S2xmUWFLZ2FYVjBvUUxXUExpV05SdldmdUdYditxMy8xMWhQ?=
 =?utf-8?B?TVl5NjIrLy9pUTgxK01YYmlRWVpySEVBaTF1YTJwemsvakFIVnFTUW5BTXU2?=
 =?utf-8?B?Z3hWQ2Irb25YZlY3ODVCTVhCWGFWajlNNVFNRW5lYVVOZndPNDFwQ2VDNHo5?=
 =?utf-8?B?VTA1SEJ0Wm1GcHhubURLelZLYXFpZGtrRHdNZE4wMTd2TExhSVNHNHV0VjJR?=
 =?utf-8?B?K0RqSzFpRk5VNzIrQUc4ZExZSUtnak5rTUZ5Y0NJYXcrYmg5RlJDRlJHd2Js?=
 =?utf-8?B?YlpjMHhKaktaWTF2dlkrTGYza3c5VzVEQ1RUenNqcDB3WmlHNTNSVEhsaWJp?=
 =?utf-8?B?OE54RWtpMzNaekRnelJKZm9QOSt0aHN2bFNTTkVVUGdacElWQ2k1elJlRWJq?=
 =?utf-8?B?dlMxUk5PRElMZjhtQlpZUVpvV29YSFQ3OVJ6WHh6M1RLRlVFWlppMmM2M3hG?=
 =?utf-8?B?QUZEWExwbmFET2lMeVdTL1d0L1o3MEt3bXFoVmxsaWErSjdDOHdzcDdiRThJ?=
 =?utf-8?B?YUJCY0kxMVZCdnVOOVRXK0pWaUgzQ0wrQXdtdHlweVRKcjJTYzBKS0lMY0VW?=
 =?utf-8?B?a2lxSm8wMDF0MVk5Lyt5eGhWR1RNcTd4bm1OTzNOM3JvaXBSL2pScFNYNmYy?=
 =?utf-8?B?VkN6UTRraHdtNG5TcGlFTlNwOXBXbk5BTk9nb0hpQkNIcW5za3ZNbDIrZWg4?=
 =?utf-8?Q?HvRdvnWp/4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERBb0ppcFNkd3dMazR1TDdidnUzRXk5WE5lbUsyalVQRWFDRDNuQ29wc2xQ?=
 =?utf-8?B?YnQ3L2d6QXlJZkx6SEdNbGE5N3l5VWViVHVpSGtPd29QV2ZyVG5tRFNPa3RE?=
 =?utf-8?B?RlV0a1VtWldhblFYWjZmZUVLaC9aNC9ETzNQMVFoQzZlSS93RmQ2azNSN1h5?=
 =?utf-8?B?amlRcnU4NXRUbXhhNTlVaG9BSnNNcExqSmpiOHNhaWt4cDlSeTNOWjVmSVNj?=
 =?utf-8?B?aDNmd0s0R2pIbjVjbVdMNFdKb0JzRjdhOVMxTlQxbFRURVlvZ1c2cVI5bXI4?=
 =?utf-8?B?c3MraXNXbWpIMkYzZmUzclNUeWRPYVd2ZitWWnlRdjlyTFVWdEdHSlVUN0ow?=
 =?utf-8?B?emUrc0RLem1SSHdxRS9yeEJPemwwZ1ArdjNORVhkU1NreGlhbFhJUGxaUlJq?=
 =?utf-8?B?ZGZqL1U4U0Znd1NPMVd2OXo5L3hSRkJ4SVZ1VGF3bmtSeUxsdFlXYk42WVZw?=
 =?utf-8?B?K2NSM0pLUEdCbDVLd2IwTFpVQjRTV2FLL200R21WT1VINnoxMXRacVdUUjB1?=
 =?utf-8?B?Tk9aVWpPeGlwRDkyM3FyenNjdFArT3lRZTNuQ1hYcmdVbitQTXNGTTd1U04w?=
 =?utf-8?B?dkgxdFV2Q1NZNG15UC8vSXpMNTRKaWJYRkdiTHhIMXJ0U2EvOHR4a09xdjM5?=
 =?utf-8?B?QkVLckRWUGZqVWNzV3pXOWdkdWhMdFBJb1VlZGRLM2FoekV4MDVKdXhuZkU3?=
 =?utf-8?B?djNaVXliTU5mSzhyeTh4ZUpDVWpyMVBoYXB3MGJZNDFJd013clZLZ0pqVTg1?=
 =?utf-8?B?NlBZQm5yZ3ZzN29JQXFZcVVYSEo1eUh0Ym9DbFljekR5dEtXSHZFK0VQNkln?=
 =?utf-8?B?L003UG1uSnBVZ2c3NjYyN3BiLzg3NXAxZ0tXQjVxdU45cy9peE1oZnh6b3dx?=
 =?utf-8?B?WDc5SGlOQzlsUUVPVlRjZDhDMGZ0Yit6NnZyS1UwbkVQWjFsQ21PUnhEYWhV?=
 =?utf-8?B?c29pM250aXlEYkFCREx0SFdZUndqMDE5Ni9HK1hPTlpNVzRwejBhbDgyL0Yy?=
 =?utf-8?B?NmJCTTVSTUZuR2RRaHlDOUpGUU5oOXBmS2xpZFZqVzdvSVpsdExqWG1JelNH?=
 =?utf-8?B?cHZtZ2pJMmQ1NGE1TG5xT094N1c0QnQrQ2FSZGloMFFNLzd4Yk1vQ2tqbmRX?=
 =?utf-8?B?bUFKRUdOVjZRNFE2VWVvV1BZTkVtUTAxRURpYkZVdzgreHQwZUxVV2tRU29y?=
 =?utf-8?B?Nm9sbFMxK2IrNGxVNDUvUm5peU5NTmNGZnJjZHlhM0lZOUdQM01kNHpnUGFW?=
 =?utf-8?B?NCtLTjdUcGJudW5scE5SdldsZDBKRG8wYmhoOWhaTEZXUnhBdlRWQU4xT0xT?=
 =?utf-8?B?MXZ3UFdLaFNHUkQxL1dDRkhaMFNUQTJHb0VLV2ZSRklvYVpVbS9UZE1jNzRP?=
 =?utf-8?B?bWpuVTZXbWQ2cmJXQTFmcWxEbld1ZWNZQVRNc0dGT2FxaDBHcDZ4RVFaSTl5?=
 =?utf-8?B?QTBjNTdUam0raVpKMFprd3NVUXN3N2hYM3FDMkdTc3FkdWFrVnpHU1FNVm5D?=
 =?utf-8?B?RTlQczFtUGFGM2JDbUJYMWRpeUpHRW5OQklpczV5T3V4ZHBhamZOQ0FMK2ox?=
 =?utf-8?B?OVJzazV6TnE3N1Z5eWI3S0NuT3FIZ1U4cmdLRmNYUmFreDZ3a3I0aDUzLzNl?=
 =?utf-8?B?amlES0QzaE10RnppUUVNRW9zRDFyR3lQRG5wempnc2VVUG5PUFF2L1lqRXhK?=
 =?utf-8?B?Y1FNbVN5RTVEVjI4M0ZwWkVKUmxKYVpma1FMK2Z5eWM3UkNTZnN6VlVBM1lh?=
 =?utf-8?B?V05MVHRLdklyUVlWcExWREFob3N1NUIvNjVGdFJqRDd6TUhSQUZGUUFXZ1hk?=
 =?utf-8?B?VExQb2UweWxwQXVORGYxWmhJQWxtdWh6bnZwdXpYeTVOY0FFbnkrTmlDa1Ry?=
 =?utf-8?B?RTRKbytXRk82Vy94TkY0V3lTMDcwUWhqb2psUTRBOEpRVit4UWI0OUZZamQ5?=
 =?utf-8?B?UGFQTnVCY3dpQ09WbW01K3ZJT0o4SGxUbWdvVm9LbmY1cjBXVHovaGpyamsy?=
 =?utf-8?B?OVFWanVld012VTE3SFQxSW5yRFNHQ0h4UWIvaVlEUUJXRzI4ZTU0akxNSkJh?=
 =?utf-8?B?ZGR2TGZuNEdmZnQ4d08vKzJ5N0ZhOUoweFh5aE1PNVNlejdydDZmM1h0WWpG?=
 =?utf-8?B?V2RNZUc2WFhZNlRrRWtmenJ1S1I0MXYzR2RZYlR4VmdaWVdhZ2E3VHBRWWhZ?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a865115f-8441-4274-be05-08dd8827ac7c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:43:33.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3OukuVAPtlgYuwso3fCkR/lbdn0GK5WeW2nd43vNQ2wSsASRkMmxMnnB/8MWMklNlaawGBxu6A4VcmY/ycsck21xgyHu7klo5U8aJKXFDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com



On 4/28/2025 1:53 PM, Heiner Kallweit wrote:
> After 52358dd63e34 ("net: phy: remove function stubs") there's a
> problem if CONFIG_MDIO_BUS is set, but CONFIG_PHYLIB is not.
> mdiobus_scan() uses phylib functions like get_phy_device().
> Bringing back the stub wouldn't make much sense, because it would
> allow to compile mdiobus_scan(), but the function would be unusable.
> The stub returned NULL, and we have the following in mdiobus_scan():
> 
> phydev = get_phy_device(bus, addr, c45);
>         if (IS_ERR(phydev))
>                 return phydev;
> 
> So calling mdiobus_scan() w/o CONFIG_PHYLIB would cause a crash later in
> mdiobus_scan(). In general the PHYLIB functionality isn't optional here.
> Consequently, MDIO bus providers depend on PHYLIB.
> Therefore factor it out and build it together with the libphy core
> modules. In addition make all MDIO bus providers under /drivers/net/mdio
> depend on PHYLIB. Same applies to enetc MDIO bus provider. Note that
> PHYLIB selects MDIO_DEVRES, therefore we can omit the dependency here.
> 
> Fixes: 52358dd63e34 ("net: phy: remove function stubs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504270639.mT0lh2o1-lkp@intel.com/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
I checked this with git show --color-moved, and indeed the bus provider
code is unaltered.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

