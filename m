Return-Path: <netdev+bounces-290491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFolBYMkD2paGgYAu9opvQ
	(envelope-from <netdev+bounces-290491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:28:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA7F5A8542
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0178305EAA3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D13B961E;
	Thu, 21 May 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2upU4yb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDB27466A;
	Thu, 21 May 2026 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373463; cv=fail; b=Z9gdjQ7EUvBBHCG80obDxdMAKa65b4N5bwL/k3eFLZC09FOr2f4lbWIbg936/Yi3hnC02oCcVNOJvHIySTXlcMI+nkMJ64/QoxUyjUfTz6N1cldaujbbcHkKe8lzxFwKXnGce/PsyH0XwhY04DBCH2wy6TcE93RPjEMWeyfNBcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373463; c=relaxed/simple;
	bh=UNLvy0tzerFCHS4hhOrhxeR+GNTxCaUqMkShq6jrjr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pcl2/BtOmIHIT0k34uey6CJ9IOer9m4hrjwLKs2vH8DkKVPAWw412cr/m+uzrMFX/mXUIv8KXsAzXp7ScajUoebNxSa+STMPg/7NLshCxDVhwpqzJuQ52VsHO0qYeJXHMGC3/oBW0OXLWyh1iVysMlubvjSgDHcqFSt5HkrO2fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2upU4yb; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779373461; x=1810909461;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UNLvy0tzerFCHS4hhOrhxeR+GNTxCaUqMkShq6jrjr8=;
  b=Y2upU4yb9M4G7LR0o1KdEZY79R3DyCE4Lh/6Ii44GKKmKgEttg9Xx4c3
   RYTEWJC2+LoegeqrFL8Ejr8GWWBxdRMST7WJAQJ/z7ZLMiXrrQVloaj0f
   B9eWnROzbIIKnoITy5dsr0LudCqQc3jUT6jGMjzQpfV38g5yNcM2mLm+z
   hzqM3lkKWOoZjxXKyCgjkWuhedW5HLGlrOFCtupq16TWJk9lg9x890qrz
   dSsDjn/FKQeq8K+O91eTw+a1RSoXGuEmpGmlWheZP5tk6FvrBmfBKXtYE
   PNAHzLAaRyjjBd+Wlxog+G4WNYMIqIyJGywRFW1IhXJs/Yjud1p2xOm4p
   Q==;
X-CSE-ConnectionGUID: DPC/hVF+R4e7p1240lT6OQ==
X-CSE-MsgGUID: yGUTyEddSYqNshE1VYyKAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79321870"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="79321870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 07:24:20 -0700
X-CSE-ConnectionGUID: SP86yg06SSWQ134py8ywSg==
X-CSE-MsgGUID: aN+RK6Q5QNO9wMAUcoWs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="244820907"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 07:24:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 07:24:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 07:24:20 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 07:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9pqTTgsrHCp+FKYIJy6btyJvecMCneMNATf93WorOSkvSPIOrcZTGaAF9icS0IsU4sHQHTVcApSeqSVtjBhjOAF2qt2S8dlaK2MtAdOJdOaRtS9LL6NX9Lek5ImohIVVpZWOXil29Y6ZEkeUnWloCmAjC5BkQaefVZNte9r9I5jXXoe6bkFRWAdsGKLUcNlQxoiHi/dpuupxl/ZWCfVB9Coiho3SV6Dskk7ncNpoFhuK17Zjjdp5qdRicfC0Hcqj0jFwzYuQglRBAZMoXWqeYGsw/FG5Qjy9vyhhNJ/4tNYA5oIyh5u9Gze7+hHFXgMQGVkVg35S0aA33c96a5q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/vSlN/hK6X7k/V8L0fYdCU4gfUgHe3cb1mLBCfTyCY=;
 b=k0RrWOgIU1xlvq/KHINpo09VsImdnvfcJwjHt6URg5ibZw5c05cF8yGCBYv+jMgEzu5UAZ8sz9fcpnuuaPXqua2CeLx70keq1FbKyPmaoNB9daNbaL08Gi3Fn+G3aGYqi7aB01ts62QcKyo33wb14DO5851djfJkpKzvxreED29ed1+8VQJzN4etaOSYI9hle0rcc9OnvCM0FZKtNJbzg0XYqwInb6KapcUR5/Mm/Ez2s3+3Qoy4qG9mGbWNm2z2ejFERGvTVKkUCWeQPMgefwP2ktf9OAJncANadgcblz68JcLmyCqmwcDrX4JaqomoNF424yDKolMHzQCW2xCd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Thu, 21 May 2026 14:24:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:24:09 +0000
Date: Thu, 21 May 2026 16:24:01 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Message-ID: <ag8VgX2TxYIMJZB/@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer>
 <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer>
 <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
X-ClientProxiedBy: VI4PEPF000001D5.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::85a) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 400da3c8-8e2d-4571-254f-08deb7449f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|4143699003|3023799007|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: eBfARz+8rs0GWypXANjA7ubRpUtcF14+mizQw6pO07h/VQLS4T0d6aLnPpkys9n7mhmcZsfV8ltiY7Z4D2q6Bn7E8MDhXh7yeEmVmDEst96MgELMuicPLpVQh438dUMBNvMRY6a+IojoQqCoXNVZ01K2V9nN9ReEmNfhmOIzGeqS4Hg9RZ+2QPu03ti6Kv5szX4swvuLhZ3/ewNye7FMx9FrRHTy9cCJbYB9DReaMH/N5pqvbNtEKvRP2oouStj5SZgfmqi9vnTarU7z3sgtLqsPq5fWMP7c/EqQ0CIk1nzRxlS1rS9FK48iMzrh80KMVzca78T0iG4YQAiDIguVqrRjdtRd7RSHEeHZ2MO2M1HDrRsE/W/2cRY8Pqbw2qcMrcMdupofWM+Ikl1yzlG+rQp1KAnG/Ye4I2cEUt+GReP1V3WWi3D46USqoM+KVoT/o+GPkcoxMZQ27T/FACH0mk57ES6xBte7TBhFRZega2hWmqttD3pSVI1hCn7We6DXMqqmzVr8tP5uUqJBg4EHmWV3Cirfc+qTAI3wiP5hQD/6Ey26SLkPtDkA7rEm+P2ylYZ/zDNbJnugUG8vwShqoXRegVAns4vfFkfGpJbcUd6bam+6XAVkqe2+OSlvVY5KMtNOhswuzpBOVA5UkIQLZpfAUtKxGkZBOgGNMSNgzoTrQSvrYnmDn5uHOiZ1Nzvh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(3023799007)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ROeDJwOCtzZm9GZEhKVERZTzRhRllKZUEzMEYwc2grYmhRYVBLL0taWTlj?=
 =?utf-8?B?dHNRUktmOTZSZWJJUE0wU0ZTamtXZmNRcDFoWDhzd29sZFVmR2xMQVZQSm5q?=
 =?utf-8?B?emdET0FRbWZEYllUUTc0Z1JJcUV6WDNtcFJ3QVI0VGRWQkxVR2FiMXhWcnRX?=
 =?utf-8?B?N0ljWEtpL0VKaXBHWEI0blZsZmZQUUFKb3JiWWptVmZEQVRlY2VsaGp2dkdr?=
 =?utf-8?B?S3NwS2hRT0s5Qmw3Um5YLzVTV1BvV3BiODlUNGNJakN0enkyWWM5R0o4NlB4?=
 =?utf-8?B?YUllZlhpcnluU3AxMlJvelF1OE1UQ0ZzbndjdVpPT2xXbWowSm9xbWhKTlN5?=
 =?utf-8?B?aFI1ZDN1Zm16RUVlMVdTNGZrdks4Q0I0ZjlkVnBuRFZIOWp3OU5JMXBabzNI?=
 =?utf-8?B?YkV0VWdYRzh0bWRDdDZwNmxTWTJVTEFpMmxDSDJvMnlmTHVvMFlYM2puY3hv?=
 =?utf-8?B?TklHeFJBRWtLWmw3dWI0WHBFYzlXVmlhM3MyWVFBVnNxTkk2RTdpbHV5bzBx?=
 =?utf-8?B?Sy9UMTQ4TVVGTXdJVE5SR1lRTENlUkMxWDNGN25aSTJFNXl1NWFFR2VGSzR6?=
 =?utf-8?B?N1pWMkY2NFhRdVhXUS9OdW04NmlmNVZGMXd3Wk0wWTUwaUpqWUVlRnVEUlRQ?=
 =?utf-8?B?U2xzcVVYdDllWlpDa29zcHRhaEVZNEprbERNUHFENnZpekR1Y2Z2SFdEVlp3?=
 =?utf-8?B?ZHpxVlAwZUxHUUlieXJiMmxnc2FiV3Jkd3daWTR0T2QzaERyOGc0WXgrRmJP?=
 =?utf-8?B?MXE5QkhuQTF2UEJBY1NOM3pXN2g4MjZqblg4N0JacFFlSUF0c0d3R09WekM5?=
 =?utf-8?B?L1I4SlQxUmlpQTRGTHI2S3FxVlprUWQ3NjVqa3ZMZi9jcTE5M0l3ei9XZXpE?=
 =?utf-8?B?bm4vSmlrSkVNL3NGWE9GYy81N3pVWi9nZUlSdjZBd3VZd2szWk5VN2RvVnI4?=
 =?utf-8?B?cVkzNUtjR2w2cWQ4SDJVcTUwZUVISFVPTm1uK3dYNmhNQ3oxV1RzS1JHYXlW?=
 =?utf-8?B?NlFLRU9nZlpKQjV2MXRnWGExN1hpWlZYR0diMm1MQXpncVBRYzVFUjdwcldM?=
 =?utf-8?B?SGM0Vm80VlV4U2RkRXZ3QUtEWlpOZmNlalNBM1IzM0xiaXdZUWQzUTBhUUVC?=
 =?utf-8?B?ZTI3MG1KWUNnSnZrdTJ2bmk2S1AwU3ZnYmNIRm5SUXZ0ejUyenpiN29lVjc2?=
 =?utf-8?B?ZlB3aERQekdUS1lGZlk2Wm5jdysrUjZ5ZVVnMWNRNCtsQVU2M2I5RjZFTjg4?=
 =?utf-8?B?S3lzU0RJREtCYUhpNmhvaUlOODAwaEJ1MmV6VlBoVzdvZW5EMXRqV09RWlJ3?=
 =?utf-8?B?NFRYYTExaW9SK1JuVTVDMk5yZGJMRFpGa3VEbGthSjVRLzViTWMzeWlWVW9k?=
 =?utf-8?B?UkEyR0VwN2FCblJGNEZrRTRNenRBaDlQcWtzaUd1R0lHV2xMYzJEaFBVcHpv?=
 =?utf-8?B?dHBoc0RiUXgrbjNCQmNVN0xwUVFwZDhuNy9BNjcrNUhxaE5GS04xNUxtVVFH?=
 =?utf-8?B?Q0JlcDluKzVxWExDZE55UHVCVUlqekpXYkdpRkZQYUdnSVhSNHBzcnJwQTBs?=
 =?utf-8?B?VXpSK2dQQm9RQWNCTzVqd1gyaHlYZ0VpNUQ0cTFQYnZBVkNidXRKaitZbDcy?=
 =?utf-8?B?TS9BeERUeEt4Ym8xYVp3cVY4WGdvUkYrT1VseHhMSEVFSi9wMVdpZWh6YlF3?=
 =?utf-8?B?Z3ZYVTlHT2NkZkVNRHZ5QS9VQ2lNVm02dnVpTlMvU0s3ZkJUbHZuY1NuRWpP?=
 =?utf-8?B?NTFMZmMyTnptUXkyYmEwRGlYREhMOW9nQ3VseWtSdW1mVTE1ZS9rTitXaGhE?=
 =?utf-8?B?ZkhOVGN0ZTdHdy9wRDlMNDlDekJPV3VrS0ozcHhRVHhjMDF4dkFWdFhNeTRk?=
 =?utf-8?B?ejZ2ajgwTmV1YXduOUpwVTNDd293VERmQnZ2V3d5cFcxaHRzVm9CYUtoSTlU?=
 =?utf-8?B?ZHVyTnd1d21KUHJCRVpVejQrbi9HSitxVTRVRy9XeHMycFgyeVljczFlczdj?=
 =?utf-8?B?QzltVEo0R2VIV1lONXlxKzdDOEE2VEdUVFZXSHcyS3F2SFRTRlZBWUFFSFR2?=
 =?utf-8?B?NVNBMFpKKy90dFJMdi9DdStYQ2plOXNSNnM4STRjekZSeDhtandLWVdmYnBv?=
 =?utf-8?B?RTFEd0pOS0RmOWxXYjlnS3o0cUNsYUtDSkJQQ2NkbHkrNlpQeW1jRFdBcUxY?=
 =?utf-8?B?UDZVS1ZsYTVOMm5Ndjl6RU5KNzhBK1gzTEhTVEZjcEFIZFdrVllBNWlDOUFk?=
 =?utf-8?B?em9SQ3BpN2dVN1ozZVM0K052SmJPMFd4RldWQU9nMGtORXZ4TWp4aWhCc2Vp?=
 =?utf-8?B?MVBtZkE5UFUyQjVLUFQya0pNeGtqb1d2VDdBN1h0ZmU3ajFjaGNrTTA2QXc5?=
 =?utf-8?Q?kicisfzO4/3iZyNA=3D?=
X-Exchange-RoutingPolicyChecked: rO0uw/7oDPLsHhi1/pyUiya3kUctpF0//QzVUBqmaegNDU3wGP9kWOdvaEhdic5X6KpUuKvi9q0WQt/vX5dg3yg2BfJnVTJpu93MC9cVtnKAQrkL86IoPhBwNgMdV9VYObyJdN30ICe1VVaQiEpra1wsX0fX7HTktoB+582BxfipuBLpj9l2r/eo3SdbT8+CwvtBXDO866QQN61MIlrLz4wnQVxJvv4r+3xioKPbxObXCrcwVqiqMYmynwQBWKy91DIfOq01MKWYSW5z4ZkEC7Pg2N4Vc/oUsNfgY6TsFrBY9d/In3+sunNFAXrvX8OiXUl4EgG6vnM4r91Q5kUIhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 400da3c8-8e2d-4571-254f-08deb7449f25
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:24:09.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0u3QZa5dHwUeNH6efC8WWHRzKh6pVJCjYUu0sJt8ff2EnC8jG3+iz83AUCysmnvnWrVkKROy17WJ2IDEA7cbOQOHnAI7pHSxp25tl4e5T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290491-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8CA7F5A8542
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> On Thu, May 21, 2026 at 9:00 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > On Thu, May 21, 2026 at 8:24 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The series is the product of previous review from sashiko[1].
> > > > >
> > > > > 1) META
> > > > > patch 1: address TOCTOU around metadata.
> > > > >
> > > > > 2) PUBLISH of CQ
> > > > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > > > >          overflow occurs.
> > > > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > > > >          publish its address when overflow occurs.
> > > > > patch 4: like patch 3, but only handles the invalid descs cases.
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> > > > >
> > > > > ---
> > > > > V4
> > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
> > > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > >
> > > > > V3
> > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
> > > > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > > > overflow case (Stan, sashiko)
> > > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > > 3. adjust the selftest to make sure it passes in either virutal or
> > > > > physical machines, which includes add usleep to support physical machine.
> > > > >
> > > > > V2
> > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> > > > > 1. adjust selftests (Jakub)
> > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > >
> > > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> > >
> > > Thanks for the test. But I've tried with ixgbe driver...
> > >
> > > I noticed there are some flaky tests which have nothing to do with the
> > > series. Can you confirm that it's not caused because of the series?
> >
> > That explains the different results as i am using i40e/ice which have
> > multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> > Broken tests are from mbuf cases.
> 
> That's weird. I never expected the failed tests to be about multi-buffer.
> 
> Are they the same as the output you attached last time? Or something
> new? Could you please share it so that I can investigate the root
> cause?

# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
---------------------------------------
not ok 94 FAIL: ZC TOO_MANY_FRAGS
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF

# 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
1..108
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
# [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
---------------------------------------
# [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
# DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01# 
DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00# 
DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....# 
.... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 
---------------------------------------
not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF

# 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]

Summary:
XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]

> 
> Thanks,
> Jason
> 
> >
> > >
> > > Thanks,
> > > Jason
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > Jason Xing (5):
> > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > > > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > >     __xsk_generic_xmit()
> > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > >
> > > > >  include/net/xdp_sock.h                        |  1 +
> > > > >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > >
> > > > > --
> > > > > 2.43.7
> > > > >

