Return-Path: <netdev+bounces-130888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182B98BE58
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D654CB249D4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8A1C578B;
	Tue,  1 Oct 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU96LzE3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871921C4601
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790555; cv=fail; b=bjjSYvmR80961j79knNlAJPD+EKhYvR/jR60nwewT6A3tn4nv8/PxJnp5IQ78l5EEdHE5e+aijS4Q8yaQoq+6zcOYbxsPzbQLj0NcMJYYWTXp/HRiBAIzYqntnUn/gga62UNx96+ONzDT3fhKt3Lrn7yUgMCFBpLDC4LXkWSOOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790555; c=relaxed/simple;
	bh=k/RrBQ/rb617O+LwZQmPe6cUY+u9xN9ag7zEXuyBMhQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TcXJ/wj5PtG/kl0ixgytPFHLGV79hcQSPur9e/zyGtqLfYqVjTYO7YWleArjOfmv/XOTsAum5HbwTmTwvIqx0yWxWU8NbjyFZwslBZy1Dr8sdID4DqhshxXtMFUFNQKabGBIvXdFGGXFqQz8nwhD4gvq9HOrBA1Cd1O5GH4MFhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU96LzE3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727790553; x=1759326553;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/RrBQ/rb617O+LwZQmPe6cUY+u9xN9ag7zEXuyBMhQ=;
  b=JU96LzE3yVw3fcpsHnFTCk/nWvpCSL74mR8ep6IAzcKtzrKb9+qXqagI
   8lZmb1tngYd33bjW4By0CbE6T8mm2RzSCZmuIWknAtceLlTo8hvIII2ex
   m/noYQ55z2Z7RtVc/Cy3qs6R0siTWV4JEkZSju73NA+Yiby3A9jVYKe+n
   O/+XKqen+lFhjtMTBU0UjVUkvlKdgixsgfRxfD+o8ARVjuSi89tdm4oJV
   3u/nOBQc3W61V2b7X0kv4pwWzvpIIqDfPtA6svRXlEDI/+HD7N8HpMYs6
   KyQZzrTpw6AFjyLRg2ASfzKbI8erokaQZQXo5U7T6PrcXEAIUA/h/x31R
   w==;
X-CSE-ConnectionGUID: +wmHL0XtSmC0jQg0UK9A5g==
X-CSE-MsgGUID: tI07mTE7SPaIosl/314xEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26809605"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26809605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 06:49:13 -0700
X-CSE-ConnectionGUID: yN9hWJ5ES3ygJNqKOwVO7Q==
X-CSE-MsgGUID: KrNgUsYJQkCXfuyi5ilusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74087462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 06:49:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:49:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 06:49:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 06:49:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 06:49:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqnxEo2tzqXGWDeitrib6JToGQubuIHvjrkUbMuf3xs3ZCNAe5b1eRHZLluW+y2c2tZNR/25dNeMWXNgwO+zrFI6PRMqjlTb3mRMxaTvMuRtdVOtRIJOhXhjxzZVd01Zp9OVfjI+Zkjnw68WpIydEyIkH0feAPk+MpWQqn82YxY4yi9Ul3xN+mKwr6G2/Md8nMXo0Nvllbmh0c2TBqlY+pB2mx+wy6KEo+Sw8LRlG3hp/rmFgCibK5tcu1UX3k6ZiECBWX0km1Pm12Glp5YKuuRglGnTR8OX19aDJ8wtHl1kailJ/s3A+DykgHGfK8dQVCzc2frWe8P/PmgPLE4uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUAUbMMENS1pwqgXXllH+M337w58evmPOi31SQl3xG8=;
 b=kRWjGQqo7c28Tgosgzon7ptlqeCM0/x+3zNSDqGcInvL4dVwXU6PEwhd5q2h75cJ8aaopocfJFF99otwYhnx82a4KlzfioOAsC6reSvFAdYi3ED5dj5sZsDQ4MHqPuCC/sMMIwsBVmzdFkqd8ztI8lfvb/GqAumDpnfHPqAvWzZvEYgPN2tp/MP9EBBqNl+qBiYOA1hhcQaREMqVYsajUcT5fkk07ntqwishyVwaai9EtbiVrqDs9GSYkGzCw7uQ+Q86BpoNCntG8BN6RmL2Z/tSH1AOKOaTOVQeu4nT+uexwzW1Iu5zrO8o2P9dKalg1HnyPvPfTDgywhtX+S5T+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Tue, 1 Oct
 2024 13:49:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 13:49:08 +0000
Message-ID: <8453bc43-f1b2-44d0-8d85-d7d2c147d4a2@intel.com>
Date: Tue, 1 Oct 2024 15:49:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 07/14] iavf: add support for indirect access
 to PHC time
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: Wojciech Drewek <wojciech.drewek@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <horms@kernel.org>,
	<anthony.l.nguyen@intel.com>, <kuba@kernel.org>, <alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-8-wojciech.drewek@intel.com>
 <9e708174-d6c0-4b8b-9a0d-5807463d6c43@intel.com>
 <1d4f2504-efa2-4121-b176-11777d043b41@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <1d4f2504-efa2-4121-b176-11777d043b41@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 01335969-eb27-47d5-3f26-08dce21fd22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTlGbytGQ2w3aGtBd2drUVRlN1ZHdlRXN0FEekphdzhacGhDWHViSnk3cDRB?=
 =?utf-8?B?MDJESkRNMEV0d0Y2V2xmRzNZcnFXQW9aSFlvQzNzRVFuWk9iMWxXRmxTNVdG?=
 =?utf-8?B?MWlPK1lHMGVxRDExN3V0UFdnb0w1TkFISmlLRUhJQWtSQlBHY2xQc3VQRHp0?=
 =?utf-8?B?OEVUL1pqODV0aHF0bGpRR0FRVDYxVFkxRGNJeDQwYmh4Z1N2a0daQ2VSU3Vl?=
 =?utf-8?B?NXZTMHQ1QnF3T3ZiV0pnN0pwNFRUNElQb1JhcGE3VzJiZ1pNeld6aGpnTkNT?=
 =?utf-8?B?N0FnRFpjNGtJeDIzKzRSMW9qcXZrVHUvdWhpMHBqU3NNdkZMa0JuNlk4NzZr?=
 =?utf-8?B?dVZodXZKT2FCWldEQ1M3Zmk4TWMvbEoxN296MFdJVFZxMVk2dlZpcjVMaVAv?=
 =?utf-8?B?MU1neXN3Vzh4cFNta1BuQjh1Yzl3NEFBVzZSb29JbkxTZi94WUd6MW1SZVFs?=
 =?utf-8?B?bGtaVDN4T09ISVFHZVNpUXNoZ1Z1QWtVTi96K1RXenVYd1gveXVkSEVDYXVr?=
 =?utf-8?B?NmVVMmhRS3BBNnV1eEFCNzVEa012RmF5N3FoWXYrei9JTEwweG5oRjRuUXp6?=
 =?utf-8?B?akd1VkNWaWNKR1dLeDN6NjMvaXM5VitJcVN6N01LOEtZaHRmc2VIRjJ4ZnJz?=
 =?utf-8?B?STBweERybGNwUHVzZlpIaWZVT2FkVkxPZDdlY0lTWDNVTTljRUcxWnRzamc0?=
 =?utf-8?B?Z0M1WWdaZFZIVWNmZ2Q2T2ZxYzdTcW1TL1FHc2hpcFJNWmpqcG5LVWFJcGFt?=
 =?utf-8?B?RHFESytwVjRad05TaHlyWjJNdmZVQlZWTlNrRnVrUHR5MXc3MGQwQmpWb2ox?=
 =?utf-8?B?dHV5MDh2TU81ckhNRXh4YjFmR2ZmWk9YWFhUSVhVQWJxMHNCUm5wMFBQV0xw?=
 =?utf-8?B?TFRESWpyVWJZM0d1aERWNlhLaGZkVVdUak5aZGYxUEUwV1ltbFlXRElmelQv?=
 =?utf-8?B?eWdSSGVsTHRmNGxacXU1LzFHSmd6VUxoV01Gc094MkxTS1hJOWtUQ1Qvc29Q?=
 =?utf-8?B?dGpQUEVzQ2Y3eWorOW81QXJpbU5RNXFlUERqdjBlK0tSY0VoWmVCOVg5emN4?=
 =?utf-8?B?ZnVzWjlkd1ZFMDlMU3FOS2JyUXdCQ2d2WkN5a3BOMUNuaHFzQkRzR2JIQ09O?=
 =?utf-8?B?c1AvNE91UVFBZkNSM3pMSkVwM1RMMmtBdm1OVjhnNU5Fa28xRmMrVk5xSzZC?=
 =?utf-8?B?RE1nb3hDc2pla2NxSDJPSS9pc1hGVEQ1SlZTcmMxcXFVRDVqOFh4b01uZkRl?=
 =?utf-8?B?RERMWUpMa0xVWU42cjh1MENxWWJXc2pzZ0R6cVZ0RlVsOVQyamJsbkN1dUQy?=
 =?utf-8?B?ZlMvWS9Pc0VmN0kwU0lBY2NLUWJ5MWE5cytjTWJZVFRYTStaaWdCand3Y0V6?=
 =?utf-8?B?aDBUTGVaNzhjT3h1SXdraC8wbEQ0Y08wMkVoRlBlK2NzVFVOYjZuc3EzNmV2?=
 =?utf-8?B?Z3BBbTBlZVN6b1RFeEZOZ2QveVFMZ1dyUTN1ajdxcUFVVEJYMmNvMnBZOENZ?=
 =?utf-8?B?V1hFZ3lHck00a2J6NllndXV4QVdQZWRoUTFDL0FaZXJNcm1RcnJoVGxCTkkv?=
 =?utf-8?B?bFJvaWNUNmwvUDRHbGgxMFNmSWVTcE1BOGs3YXNXZkxianI4NTZWK3hsWU5Y?=
 =?utf-8?B?MktNcUI3dkd6Z01Eck1oUmJ4dWdSQnBqSVFhNlkvalVWVTBWMVM2cHR4ZSs0?=
 =?utf-8?B?S1pvVzRUeGo4TGVLK0hweGN0L1pjOUg5M1lHb3d1ZWJFamppSzdsazgxQkYw?=
 =?utf-8?B?a3FHM3NBeXdheStWanAxZUF5cW1nenMyM0hmQ0c2emlDSURpcmM5QU1aMDd1?=
 =?utf-8?B?dVA0UmgwZk5wYXdkV2Vmdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVWZ2tLZVFKditGUHNUWnZzUnVQMUg5YnpIZWd0ejQwL1BhUlZOR3VzNmxi?=
 =?utf-8?B?cUFmaXlhMDNvVFE0MUtEaWhxVmNyWVdsNUpIWnJEbzhEc3pOVjF3ZWlPd29D?=
 =?utf-8?B?dGNRcjNDclRmdmdUQm1xTG5yM2tWajNZM1dIT3lnME9jRUFCSjVCdUpUZC85?=
 =?utf-8?B?RXcrZ0ZnVEF4d0NGMStjME9wTExONy9TTW1sU3hzRDZ4VnlodFRRMjduSlNZ?=
 =?utf-8?B?TWdWN2xFcS9KUU0yNGZ5akRxUEdxdzI2S0FodmY1bEFYbTRhUWRQNmttZ2JZ?=
 =?utf-8?B?M09GRkV4eVNXejdDKzFSVUJnRVhHemUvS0I1eUgxWVBnVS9IMTM0dmZ3ZUxm?=
 =?utf-8?B?dXhyQTVPd3k5bGdTRDNGKzRNZXRWdzhDM0g2VW1JVjd3ZEZJMWxlajhvcG9u?=
 =?utf-8?B?eklrd2VoUDRlaVE0UlZBSHFZTUdxc2NSbTNsY2RSTUpRN2pTMW9Pb0JmV1NB?=
 =?utf-8?B?aDVxMDVha01xQUJ5amlSelJ1d1BxSmlDUEJaUTEvL01ZQ0oxK3d6azc3T2tK?=
 =?utf-8?B?RkpKNXVueFU4UzhNWFhvc3RVclhLMWUzelppMGJ1OHp1citaYzBiRjZadmJh?=
 =?utf-8?B?ZXQ0S05FVmdRRlowN29vUGl2Nm03dVRDUkNQMXI0Y0UxQWU1VDY3V2czcWFN?=
 =?utf-8?B?dHpydTFmMndxb2Q0VlVPb0xxSzlJeWI0bGxCejBlQWFWb25naUtjQjlaQW9P?=
 =?utf-8?B?aER3cXBQcEhEaCtHVzh4aWVSVVN1UVMzMTcyZnQraXNJbkQ3RXVHRm1BMGdK?=
 =?utf-8?B?ZU1OcTNiVjRnRjlmdXJNbUExOWkxVWs0ejZEY3BxYjl3RTZFUHB6NHJuZnFQ?=
 =?utf-8?B?eG1aYU1ETGVHUXVDekFKWS9WTE9VWjJNRE5NTzc1cUhLS3hBY0NyZmFaYk41?=
 =?utf-8?B?Mk1CY2ZET2c1bU5CVTUvN0d3WXNQa0g3MHo1Q2JlTndiNkhxWWgydXJiVWlP?=
 =?utf-8?B?aXlGQW1VMHVreWh2UDVSVDdDVTBCRXIra3ROYkRlbWhRNlFaRXVNbE44dENh?=
 =?utf-8?B?SGF4aWttaktkMzNNcE1lQ0pyQTZtN2FtM3h3ZStHTE5MMmZGSDR3dm5wdkl1?=
 =?utf-8?B?RHdMaUVUeFEvRmdXaXIvYTA2dXBTOStxcHlDTHBOeXZNUmZnWTVtcUFvUURo?=
 =?utf-8?B?RFVWejlMY3hRK3N0VTQwQ2RZK1JTSElTR3YvVVd3b1ppZWMxNHhiN3Yvb1lC?=
 =?utf-8?B?Z090cjhYdDFIb2dNbklQMktzTWhOZGtMdEd5YjNtejVOSzhjUmpQdk9XRG9B?=
 =?utf-8?B?QnBZNWliU2RVR2FNWkFiV1NLaWpqODl6bjJyNTBqUStERVBKS2U3OGJmUERi?=
 =?utf-8?B?TlpjVThiUXN2VEtUeENuUU9jaStnNmsrN3FWMHFtRVR5YjFsZThJNDZ4THNk?=
 =?utf-8?B?VGs4eEN3Qy9DV1pzT1dScmN0SGtva0NGSmpyMSsrSGZPYVBGM0pxVkpOVFor?=
 =?utf-8?B?dW9EdVE3RS80ZExvd1pKNWsrbmZRSGVSc25WNWpkak04ZHFROHJ6aUxFVXBp?=
 =?utf-8?B?amVUd0VhOUJlWUliVTJpa2NHM3dqNlpua0RWcGFDa0I4cm1Nenhya2luSGhT?=
 =?utf-8?B?N1hwc0RnclRwQWdxNXFreFk5K2UxLzJUdkExVndzSHdyanl5UUVJV2h0cDNG?=
 =?utf-8?B?T0hTWjZwb2dMa0VTNU1YcnVpbXJXd3o4TTAyMnBzSk1aRyt2S3VjQUdXNmcw?=
 =?utf-8?B?VHlhSFRTOWlBZjhnTDVtbUlLb0ZLbGtmQzZnYS9DUHF2WWJPMzNkNjdHNndT?=
 =?utf-8?B?VnVlU1YxRjkwVXJ6cVZTYTZ2VzlDVkl5Um9VcVdNdU8zNXVBQkVtMFZjbyta?=
 =?utf-8?B?cU1nUGUyM1ZvSHlER1BIbWlKbW15L0k1eXFTdyswekhqaTJXS0Vnb3JVNDNy?=
 =?utf-8?B?V2JpOHBNSEdKeEVYdmlIZEM1OWdMS0lwdmQ4cllyTjJ6U1lGTlZBRFMwRGU1?=
 =?utf-8?B?M05hT20zWEc3VDZvb1NXSmJQLzkyQ1oxUUlla3U2cmNtRGZNMTNTZVZEU2xl?=
 =?utf-8?B?T2dWeEtTS2VydUgrY3hYV0M3MS9oekR2T2hGaXZreG5MWDJPdVA0a0JtL1Zk?=
 =?utf-8?B?NHdzTElYaUxNY0Y2RVZwbmhxNDZERVc2MFBMMHpQTjZ6dUY5dzhzSHRRMW1S?=
 =?utf-8?B?aVRLR2tCYzQwcmpxa3Yyd0o2OUczYnVVWjNZbktDTVlQanFBNHRCb3hxREEr?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01335969-eb27-47d5-3f26-08dce21fd22e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:49:07.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubPX/na2jDH/djqW2F+z/CstE9t4DI1x9Jd8tTBfm2KtKYQvRaRukUkjV35+j6NRwkod+kV+RI9vGPnlECY3PhYLqKrVHpaaMygH2+eZJNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Date: Tue, 1 Oct 2024 09:20:14 +0200

> 
> 
> On 8/21/2024 4:31 PM, Alexander Lobakin wrote:
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>> Date: Wed, 21 Aug 2024 14:15:32 +0200
>>
>>> From: Jacob Keller <jacob.e.keller@intel.com>
>>>
>>> Implement support for reading the PHC time indirectly via the
>>> VIRTCHNL_OP_1588_PTP_GET_TIME operation.
>>
>> [...]
>>
>>> +/**
>>> + * iavf_queue_ptp_cmd - Queue PTP command for sending over virtchnl
>>> + * @adapter: private adapter structure
>>> + * @cmd: the command structure to send
>>> + *
>>> + * Queue the given command structure into the PTP virtchnl command
>>> queue tos
>>> + * end to the PF.
>>> + */
>>> +static void iavf_queue_ptp_cmd(struct iavf_adapter *adapter,
>>> +                   struct iavf_ptp_aq_cmd *cmd)
>>> +{
>>> +    mutex_lock(&adapter->ptp.aq_cmd_lock);
>>> +    list_add_tail(&cmd->list, &adapter->ptp.aq_cmds);
>>> +    mutex_unlock(&adapter->ptp.aq_cmd_lock);
>>> +
>>> +    adapter->aq_required |= IAVF_FLAG_AQ_SEND_PTP_CMD;
>>> +    mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
>>
>> Are you sure you need delayed_work here? delayed_work is used only when
>> you need to run it after a delay. If the delay is always 0, then you
>> only need work_struct and queue_work().
>>
> 
> Sorry for late response but I was on quite long vacation.
> 
> Regarding your question - I think it is needed to have
> mod_delayed_work() here, at least as for now. I agree with your
> suggestion to use queue_work() but this function takes as parameter
> work_struct and in our case the adapter->watchdog_task field is of
> struct delayed_work type. It uses the function iavf_watchdog_task()
> which does plenty of things (including sending ptp cmd). Changing
> adapter->watchdog_task to be just struct work_struct is not applicable
> here as in iavf_main.c file in few places we add it to queue with
> different time.

Aaaah I'm sorry I didn't notice that watchdog_task is used in other
placed, not only here.
Ack, leave it as it is.

> 
> Make long story short - I agree with your argument but as far as this
> 0 delay is not causing performance regression then I will stick with
> this solution implemented by Jake.

Thanks,
Olek

