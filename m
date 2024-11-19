Return-Path: <netdev+bounces-146217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3E9D24D6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEC8B2707E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F91C4A2F;
	Tue, 19 Nov 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKVAy7Kj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26E1459F6;
	Tue, 19 Nov 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015752; cv=fail; b=rJxSGT+J96HHrwZNEH8bh6I/s5CnHwDHpHW+AtF5p1mmzs0DTuijiIEIJejAiqpagxkGGDCjcTvriN0v3wmOQWabwo6t7WgH71lxMEM5gnVHSL9sKiex2QFwRrI54sFB7tnJZYs07uJ37LxHxzcvOyftpgMdhYfTyU632U3LbXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015752; c=relaxed/simple;
	bh=8odUTC+NshM72gZ6ESHwTaE6CqyFTo1ZOJYmRjqCTvY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eP2l0ausWL/xmeOlJoAXaBx50oAuirctjjUVI3bW1GwH2YsaL1j1bNNURkrr+mUS1aRc9X9gBlgc5rK13NJ6c8gZFTAkDBQYp+lfDgJmTb/oP2t1gEhJj3/HnR6DHTlX3uW7Dd83cGVI0vt8HN57nj/NA5/JNEtAE2dSWhrEGOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKVAy7Kj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732015751; x=1763551751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8odUTC+NshM72gZ6ESHwTaE6CqyFTo1ZOJYmRjqCTvY=;
  b=ZKVAy7Kj7DduHYK7QKPI33AR5VOQsOyv+uWxs0rd4puzo3tj97rqfdM0
   62d7ycvnHOYfO5r0mbi3Xq++XqgFDWU60sS/VVOEQI5YOs+CiRI0f8MxX
   iRljEPb/6B9w4WNCXWLEokHSESrSbuw/c2qi749vcpptf2/IP0WYlms7w
   SKRgOv8YsWpDrsztRlzjFLFN+Mq1jvov+M0dZXi/ggJ8Oo6DFh8qdYUA4
   TJjuqH0j4DMiOtlrdElAkIDnLrAqkH1bqoY4PYR7nzpDUhUhpvmseeaaQ
   9WUIlLjx84JdlcPPPzzeRAygZBmpi94ue27gboYqaiZs3EjjHxbUSeX/L
   Q==;
X-CSE-ConnectionGUID: InF/oG1ORBGyDzyIoMmy2g==
X-CSE-MsgGUID: WBNzb2ExQxid6HRQ/Lc8mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43391689"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="43391689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 03:29:10 -0800
X-CSE-ConnectionGUID: 7aHWgox3Tx2gY+oqScCnIw==
X-CSE-MsgGUID: ga5+qRsDSFu9n9gMu+uV3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89327129"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 03:29:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 03:29:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 03:29:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 03:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfdyHplA0KnY+SGG/4biFAy3sM9qLlDyVcA9u2/hioG+HLh5QsPTy6giVzO4dykQ1j2W7qG2eC9U9O7d8W5EhpeQQwe5KGsykz7FAGL1GOjxFY4Wafi3HoXjzelezcC58+l6oEGyMslUbV3sfJR9KgN8v45qMewxIhytF0KW1jd6OYJl5CXjj+I66gua85+fwP7eciL/6aXJozLxj93gKlnzcnf7YVBE/P3D4p+YjYEQCWC8pctRJvfMjui2EWLJJLyvf+n69vAe07+hQOuheNHhF3EWMbbZTC3bDSbFY2XeBNtp9lkpKvaiXYpNr3zXro2jqjGAey3l1MUwJzNR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzh+bZxVrR7ogZiPH4GL6Eq8feKfMVxfNfxWqcr/nJM=;
 b=wTLtKS5nkht1aoDeYWL8R5lki609iMW6WrIsk0Da0rBQ+cG3h2JJGjiTn8DlPLxR2xGJJ0N5iAmUO81EalrU8kUU807y7OWAqHXKuX8VqLpN811dKZeyJ/jUI8PdngWsNdvpfWu+P9a3bHatEkg/9rL9X4aDtEKFYHnV3LtP0U9jyQshO69BLCwnN3nJOd2mOZfO/x+KRG1dF2H/HAp6wfv+Tay2MtVTcLNjGIA9tZrkWy/qB9gFbq8AZzObeqU6r11UdwFF5BQj1yTMG46SxafdXt0UP/ik2fBGO3T8dOEciGG0/zKrmk+UaYu13xFpN//YzfKsFMvbaiikbd0RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 11:29:02 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%7]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 11:29:02 +0000
Date: Tue, 19 Nov 2024 12:28:49 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih
	<pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net v3 4/4] rtase: Add defines for hardware version id
Message-ID: <Zzx2ccp65u+AkxHt@localhost.localdomain>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
 <20241118040828.454861-5-justinlai0215@realtek.com>
 <Zzsh3AjTAnQoKKTl@localhost.localdomain>
 <7c1a67a1ec7b4b1eb4965575b625a628@realtek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c1a67a1ec7b4b1eb4965575b625a628@realtek.com>
X-ClientProxiedBy: DUZP191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::10) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: ee17a3d8-d54a-4390-54a1-08dd088d5e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xHYKhH/WsXQcgz6hdo7NaWSBQ7K1avhGw0P7WBNLTfAxRNXrM2SfFkjm42XW?=
 =?us-ascii?Q?7ASIenraaHvoNlQOdcFcSF31mCo1HYJosgB4TU8ovSzJ5Xg6gDBb8t5n+x/k?=
 =?us-ascii?Q?EtPPug+PHzINKJHsJJp2PfgIxuwHsz2V9xZZ4m+d+4eNir17ipQeyxmuNPkc?=
 =?us-ascii?Q?yYSDvdr7yllqWz+pT3dKw9VT/3YeNRvM3J6ZjrOP8GUkcj0kXfOGzG2gq5P5?=
 =?us-ascii?Q?wOAbdVY2KRtez5Xw2IYsa0zu0Mxm8qOND9RACb8t2x7naNxQyE5ErnpD34V7?=
 =?us-ascii?Q?XZrzUGSwGoEFVVC1Pv/KOXRCIGnBiBweHtcmIVpaj2VLJocIdJ67jmni1ie0?=
 =?us-ascii?Q?Lb3N7RFD3ZSOfmjwHm48G+I4IGycbh4nw5VzchGEXCAmU8ESXuLsRyQzsmzE?=
 =?us-ascii?Q?UeM0R1BhsSpaQ4e9kgspoSQ8nTJ+lRWROQJD30S8i0mMskFp4dE8GTtVkKhx?=
 =?us-ascii?Q?88rVcdbTyTRR7Js0A6O/yoFT5+SoM71EoLUI6E1EB8yNl02CR/DqSPEM+cBW?=
 =?us-ascii?Q?4feSUvslRGWpxgDNHQTVN4PDICXQFjZoO9d6Ut92PdPMgb1Ui6MF9rCcBraX?=
 =?us-ascii?Q?IAM9QbbBiY7nJ2byCjCVA3GcHk5ZvpIt7qbpScDvN648SQ9jHIDOWEyxj69K?=
 =?us-ascii?Q?Y1L0TrmfnbjtpMq5xgDjSPHRnbYqtrnn2ZIlGhlqQAXGh/wH3vr4KACzsW1h?=
 =?us-ascii?Q?FmqZYXMn7OIZ0xjMLyvul0WVzth4rKwx2EuTnd8T98SGQv8Rvsi2EFGSnvDz?=
 =?us-ascii?Q?asM5WYtXIDWTxDVFKn9B5csmbl1F3+BO9yhTvZ/0Atd2wwQiP2AnB1J9FIKE?=
 =?us-ascii?Q?CTlibQ+hA6VT9pE2ZY/fPzRAnahFeRM1CYwWBoZE9Y4ltcpcWx3v3rcw0sa6?=
 =?us-ascii?Q?dwFy5CTwr3l1PObxPOJVgjoe5RgQIc8G5h983glKLb+NGXMMmvn1aWzhXB+U?=
 =?us-ascii?Q?OWIVH/ZqLcGzpQMYOM1jnImLztTqjqb3IRAMwEWp9UEwvsap21bDzT3uzXJe?=
 =?us-ascii?Q?Pry2mQiL1T+Z6eqP+fl2Wp93uBPw3piAFnM+gD4qj0ebq/Cm94ec6a72vZNj?=
 =?us-ascii?Q?IjHWtocAnmbq/Ppc0DoQyvZlscQzGO27Pzyw6dk4vpBVsTKLOb+8oDlg3ts3?=
 =?us-ascii?Q?im8D587XhwEq0HifwpOUUJVaDBVSCDwPlYvOxcCkru+sTdgRaRVy6h8l1VDl?=
 =?us-ascii?Q?l048txaRoHg9rTOAJdVDIkyQQAq4Q3n7W//SQs/M5fyvqBBN8VPCzeHJ+EA8?=
 =?us-ascii?Q?ymLs3oviyTGXfNkE5t0gk3vdvXT/olDd+O7hcOyEvw0AlTW5cNix8KnFa6fU?=
 =?us-ascii?Q?uMfn7Qi7W6ZsLKl2de6gQC1T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZprpbVbZwmB0YfQp6Du2yhomJ9aqTwJqdJookDu5RJMLcbv6C673/IeXGZU?=
 =?us-ascii?Q?miejHc1S38qAvoWTkr/qWZr1YQzqyZBRFR1KrqyC3frotqtae0G6J7ohJdmn?=
 =?us-ascii?Q?7dCC4wliwInqizH1cZFvOvxT3qH1a2EeVloPbmcm6F5MKBlgduArLxx4krbb?=
 =?us-ascii?Q?PNP0eiAb9Z69VKdFgX+E7u7b/CQO7nhxpkgCaCOUgE65iNiJRcnApmy8cTon?=
 =?us-ascii?Q?dBOcAR8lzLbjauSC1wikMjCvA5wAlfCaDf3mK2ax3MAwl4P7e5Hq4j1c//9n?=
 =?us-ascii?Q?f6LgjBWt7HbrBCc2qKPiZ3lcWTHUQrIAH3LDtmT8OvrNlaDE7QZYbkT1wlrL?=
 =?us-ascii?Q?IXTugeebMfQtomIuq9ZraQsHZuRjQmOOy0ucP/nwxgDvleRFcPGXZV/UVRIc?=
 =?us-ascii?Q?7pZhDKLK/pw8EWYj1HATn8H2DRB3sS9nCNpdlaXRafLNqqiFWpOGhbSa9+LS?=
 =?us-ascii?Q?fpBYWXpb3nNVlTrTwFwN6uLQ5CETByczKJ6cWSExi63FW4O0eR+AIHgrkCvF?=
 =?us-ascii?Q?ix/83BuP4pIlq6YhCiBYGxj2QlpZZ1aSKOOaxRA8qZC9C27W8hQC7yfMefl7?=
 =?us-ascii?Q?Eu/N5OlANtuYsCD58ulcf5VUHW0L0aJv1RP2lzCG0aheO0p2K7zx+zR+YxnQ?=
 =?us-ascii?Q?MuSoz7GP2J3wohk7HloZBvNAy9WuKVAUWGMbGF+Rv7uMgyfhaYNzrUGCHfbx?=
 =?us-ascii?Q?1IzqTXIfHyZpGOG6Orj9H9vx4K9wZbZw0deMN8ckAOBg/lnihNfumx3Bs0K9?=
 =?us-ascii?Q?C3K/qCVC7eEdIvgbR9LEojgph3Za8D5IhD10ntZO2o3av5WmMd1wSnD552Yq?=
 =?us-ascii?Q?GkWreTxZ8VRDqYNxuUNxPmpkgR2LWwMZowGD17fTNQHwV+j74cvdkmphD5lp?=
 =?us-ascii?Q?doAIPBvzKUNzDpFD2agFadH7AV29gm8XtqbRHfpQnM+afoJ7fvIz8e9XyT72?=
 =?us-ascii?Q?4G8pTjvJO4AnKd6oHjA6zxAHIichFTcPhVAmCiJrZIddXGaok69au81ZXZ9V?=
 =?us-ascii?Q?v3Ftp9kJdg1eYoX3Lr1MWnfSOSWS00NmyZfDEc9X8KuoNKQKBpX3I8UPf2wk?=
 =?us-ascii?Q?a7w/vyf3iotMzE7G/q4igKd4hHGvLrsEYAtWXAdX5FTZ4smWA6qhx37qMSXG?=
 =?us-ascii?Q?ykYSCloEZEFYerNZZT0D8I0bVzuHjwaVJPsics3tRTcw2CP8aNmZ3TqdCZEf?=
 =?us-ascii?Q?HVuz67KyLD+u2zRpATjSWU/AdtXgX//yRqsHb2Lch4eYwMl+xlouoWrK6x/m?=
 =?us-ascii?Q?4Jrup3UvmqfmnzFw84/J4EOdMWyGAf3I26Vu6lKpsRJQyhjXeFchZhDxp4n2?=
 =?us-ascii?Q?ktuU3BBJ21/i0g3BXysbB7RfsEuz1B6dVWtdV3S4kLTl36Rx1T3SsBRL+5po?=
 =?us-ascii?Q?VqMIvG1Yj21A/uSk+3yMW44h6UdQqQ7iIU3Au127jL3d+206hQ9ADBBpZ9h9?=
 =?us-ascii?Q?s7/RvxG6bmfrWxlFPVdMj59GMew98OJXUvf91PbypkeFOfxQv/I/Wqz+fMPx?=
 =?us-ascii?Q?dOKAH2NT0919aPNd8gd398qhK1B2jTw4PP7y0rlg7PAc42YmL9E7E37hjib2?=
 =?us-ascii?Q?d8+cYbfTcvvgJyWfbxBngfBQ2NR/9Lhf9Kc6wq3ZUm+W7/UvFzmpAjlFVPRa?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee17a3d8-d54a-4390-54a1-08dd088d5e1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:29:02.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi5rsqFqp5S9egkFgz7WtbBr9kfxaW0rqse7dMx1x4iH+w4MfMTFRyK65HClXZU/SWlFu6J3sJEb/pj8kF0IFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-OriginatorOrg: intel.com

On Tue, Nov 19, 2024 at 07:22:46AM +0000, Justin Lai wrote:
> > 
> > On Mon, Nov 18, 2024 at 12:08:28PM +0800, Justin Lai wrote:
> > > Add defines for hardware version id.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > ---
> > >  drivers/net/ethernet/realtek/rtase/rtase.h      |  5 ++++-
> > >  drivers/net/ethernet/realtek/rtase/rtase_main.c | 12 ++++++------
> > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > >
> > 
> > The patch is addressed to the "net" tree, but "Fixes" tag is missing.
> > Also, the patch does not look like a bugfix it's rather an improvement of coding
> > style with no functional changes. That's why I doubt it should go to the "net"
> > tree.
> > 
> > Thanks,
> > Michal
> 
> Hi Michal,
> 
> This patch introduces multiple defines for hardware version IDs, rather
> than addressing any issues related to the function logic, which is why it
> does not include a "Fixes:" tag. The reason for isolating this change in a
> separate patch is to maintain a "single patch, single purpose" approach.
> Additionally, these defines will be used in other patches within the same
> patch set, which is why they are included in this patch set as a whole.
> 
> Justin
> 

Hi Justin,

I understand the purpose of the patch, however the patch is addressed
to the "net" tree. Each patch sent to "net" tree should have "Fixes" tag,
because that tree is for fixes only.
You may consider sending the patch to the "net-next", (which is closed
now because of the merge window).

Thanks,
Michal

