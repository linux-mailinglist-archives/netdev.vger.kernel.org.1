Return-Path: <netdev+bounces-223051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8BB57C12
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61EE3BA4D8
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783830CDB0;
	Mon, 15 Sep 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGLk04rc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412F30C629;
	Mon, 15 Sep 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940907; cv=fail; b=tKdDGjSvz38mvDMxejHzhTX3/pFHJAMkwxT+4YCbpB0aQi1z/U5bKZIqv76ORMy7J/W5QfZK4u+UGZFqk47anmspOwUjTvciWYEw5v8Maiq6D7WUwRbj0pQOsEtcqj5TQPqqmzSrXCI5nE3IuPxGepgnbijxe8znET+a9qc/W04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940907; c=relaxed/simple;
	bh=VNOTfuXWAsTs3FCPBqic0TYVpQREK4DQe/wnFJEy1ug=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oEt1/pL2lz2ZjUetWzdKRf25mMl6Ss9j1jwQhGcWYTXSVbio9v4GbDfV90Bt0vGjJ19eJkiaaQdL7EGHJCpZvaWEPpa49chCN1gJpmpLIH5sVw1e2P/UxFgR56pLhWO6GB+o3RnK5gv0JV+24XYG6mPh2kXNJbYSaDWTCoNa29s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGLk04rc; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757940905; x=1789476905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VNOTfuXWAsTs3FCPBqic0TYVpQREK4DQe/wnFJEy1ug=;
  b=WGLk04rcjQNy4txcxis/mF3+OoaYu6yY/vOhLOAy9eblI319D3uX9NKx
   c1EAhCxzcd+I7Nha7X56tfeyuBCuwDdoM5JA+XNs5VHwnWXrjxvW+TpvB
   xylCrwcSVVrCgflVQchcYFixNBOXiQSt1bJNm/AAH6ZUFnjVSxJzpnFYX
   9u2SdJ1bT+ZSt6Nedgq+iE6Qmi86DLKXQOn8sDqG7okJ/jqs5rOGs6eX7
   gp8x1wYMQNt1Z5jgmi59DmrwV7Ysn79SIPtjf6NfSDBSjNUSX4gCtPAwC
   wpkXZ6ltEyaGU8gU8A3WHhnwSRNcxGq3s6Vw3sDYEuDL+mzICl6Vsa2l3
   w==;
X-CSE-ConnectionGUID: C1Hn8edMRtqS43c27KXAww==
X-CSE-MsgGUID: d2RF5K2dTmyrau7lyvIa9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60249518"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60249518"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:55:05 -0700
X-CSE-ConnectionGUID: fIKxj7LPTsu1AvMDEVE1mg==
X-CSE-MsgGUID: ztyZFGYKRCuzBN6JZhtDzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="173936244"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 05:55:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 05:55:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 05:55:04 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 05:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weqxtwUvFd1wbjOpodjsvaTvlnVnb3q6GnHnjJHrBy2pSIBQdqnk6ivbZmFDjRWznlOf1S8KvZi638JeVen+SFnY82j2ZPaZPJwHY26ywBxa20+dMFgHt/Lm2B2GkcvbXVtMMsAjr6teod2V4lH9tupYtzlZwN5e6shi40VXkbvsMQrQkMoafl7SYFCpvla1fCXRBRedJ3VLupYAPB9v8kKe9Thnt0tAdg5qua5jteGGrhbOdKwAPrDfM/cib0mn+1cWeptPHPVd624nVZDe5eqYwX0f4pwUA3vRHNl6qXumoSdJyCzJiIs6fXqYXDemMJYKHwq+Y8dXH7HiBRFc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Swh/Pe1UUACu7oWu6bcnv0Ko06jV8ZoVpaykul+//g=;
 b=UFGk9CgHokAQ/trsne9buHu4QxkYOqL8jpzxRnFOgCyFNj+SiBsPJpOgoB0S/3aV0AKOKVQudqLbai/pNiFzHsLnUn1NtzUCznUVfj8RzMtp6/whs+s8a3lSi+1HExnpO/sOeoAYnGJngLO7oL+Hc56xFoBY/vkC2Atw71/wTz4SkQ9C0QBdKhfB6FFzcW+hbTc+rc+4ZXlOCDUFL2pbSa1aq64INGevW7Olylt+oSb7sMuURSNHNwze+PzcOBc+CIg2icqahth0T6MVpM6VhQSqpGVF4OIckn9kuK301kIu8IUWKVJ4vHB1ojKCj9GD8JX9PiVnZYgH7Xcznc4OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:55:01 +0000
Received: from IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10]) by IA1PR11MB6443.namprd11.prod.outlook.com
 ([fe80::7e9f:7976:bf62:ec10%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 12:55:01 +0000
Message-ID: <2a0b4669-0867-4d8c-a88d-22df714608e5@intel.com>
Date: Mon, 15 Sep 2025 14:54:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs
 prints
To: Sebastian Basierski <sebastian.basierski@intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cezary.rojewski@intel.com>, "Piotr
 Warpechowski" <piotr.warpechowski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-3-konrad.leszczynski@intel.com>
 <20250901130100.174a00f6@kernel.org>
 <40c931b2-f565-478b-8900-1a6aad6d9e0c@intel.com>
Content-Language: en-US
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
In-Reply-To: <40c931b2-f565-478b-8900-1a6aad6d9e0c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:802:2::18) To IA1PR11MB6443.namprd11.prod.outlook.com
 (2603:10b6:208:3a8::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ce3620-809c-42aa-5b24-08ddf457151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUVYQUlVRElva1dwWTg5VGFrOW5RMFZZZ2N1UDBGRWdLRk9acU9jSHUrTVdq?=
 =?utf-8?B?WW1TVXViVVQ4RXF2bVczN1JFc24zcGNYWkFzNjVqb1ZnOU1FVllIZUxrcm55?=
 =?utf-8?B?bDJHQTNpK2Q2WVl0T2IrNWYxNk1uVU8rbVVoMmszazlEQ05JWU5XQmVMUDZr?=
 =?utf-8?B?a21NZWZxNk4veUJ4VUtyL1FTME8vVXBuUnNhemlsZjlDazlkL01sZTQ4Zmln?=
 =?utf-8?B?Z1kzVTNRYU5YSnh3blFRLzArRUtFWmZXRkV0LzYyaFlkdGcrTkRqZkV4b2Vo?=
 =?utf-8?B?cSs0NzVhWjFwYnZSOWVhcDM4M0VjRCsxSUJCakpUNEhoWE5kZ3dYMW1PS1l3?=
 =?utf-8?B?SFBkMXBDRmtwVTV3cEJ4ckFmL0RPK1RyZDU5bVFZOTFxY0dGR3JUNWt1enNa?=
 =?utf-8?B?c3lYKzlwd2FNQXp4cWU1b0tPY2crTVQyQkdWZlhjS1pvZkRXVFQ3TnVlMWNt?=
 =?utf-8?B?VUFQbUczcXhSbFBKNVVPczZ1WUF1cTY2RHErbXVMVktZTzBVR2ZxSE03MlRN?=
 =?utf-8?B?K3ZnOWRMK0I2THU5MlVLeVk5a3d2bkpPSHVNTXhvKy9SSWg1Nng0cjNQM05t?=
 =?utf-8?B?WERscTBaZFBnNmxEaFl6WW1NcW8rVldXdGk5NDM5YWwwVnI5VnpZNmp1bGZo?=
 =?utf-8?B?UnFGNVhMS05XaEg5ZllTL1FrWU1EaG5yenJNc0RQSnpnemZDOW8yZmZ1NHdo?=
 =?utf-8?B?WDlrOC81Yi8yS2RUeHVnd0ZrdGwxN3JsOGNlcmdwbWhIdWh2QlNQM0RsZzFj?=
 =?utf-8?B?NTJZMFdoeFdTaS9hWWlMR1o4Y3h3Ty9hYnZPeUFiMk1xN3E3S2JMbldGNlIw?=
 =?utf-8?B?STRkVldlcm1MQ0NsVVZWUUpUalBlQjB0Z0xnd3lnR2dLM0tJcTVSZGRORUEy?=
 =?utf-8?B?SUtrMkFpZng3L1dtbENGcGFXWms4cVdmSTRvUXZ2NlN3Q0JnbVdubDl5aUxm?=
 =?utf-8?B?RE5aTmdiaStpWjRFbkR6ZWJJRnA4SElnVmdxYmdiYllhM1Baa2ZYaDdvNGxt?=
 =?utf-8?B?R0Y0cWFCN3Vnb1BOT0N6NTB2dFFPTWl0bGM0cHBrUzZXNHkxbGMzM2hFNlB0?=
 =?utf-8?B?YmJESzl5Y1ZMMTFqMm1xbkFiSEV6WGtmL1ZHS1FmVkFTVlNTckFOcnVBMTl3?=
 =?utf-8?B?bnBGNnZqanV2OHhGUk5uT3JVNUhIYWpBYlJaQUhFUzNVZlFrcTAwQU1LQ2pO?=
 =?utf-8?B?Qm5nRUVFcnI3S2tvMFh2QkdtTHBsTGUzRnBKaEFSd3k2YWJCSjBFdHR2ekhk?=
 =?utf-8?B?Y1VUOE9wNVpuSkFCVmlVWXVhZUxaT28vU2ZwdVpIM3JzWDdHNXhZdUxnNmlB?=
 =?utf-8?B?ZEhBV085OGFaeTVpS2tzbG50RHlDQ3p1cE5QSUtrQkgxdlc0YmEyYVF6a1ZP?=
 =?utf-8?B?azcvZGxMcGxSRlJHMDNrb2FIZkNjcVdjazEyYWRRRlBIbGp1QS9TUTZTNUVS?=
 =?utf-8?B?NWNGdElYRTVTNXdwZTNyRkVDN1BOdlJMR2p2eXdxOTI3ejdTOTlBTmVUeTkv?=
 =?utf-8?B?UnhtTzhoMnJWTnpnSFJQNktyZStXc2xIR2pKMEJTa1g0eEJBMERoK0lQYVFV?=
 =?utf-8?B?SDFubk9UbGRWV3MzeTFRYWRKYnljdDRSMEcxLzZWallkZ1dkS0VtY21SSi9K?=
 =?utf-8?B?bXllKzloblp0UjZmQUN2REpGYnZlQlRPUnBibko3bnJlVUlNeldLaWtJY1pQ?=
 =?utf-8?B?RCtHanltU0pqMlJiL0JHY0t4RzJQeVVTL1FDaEJZRStiTnphaEJUVyt6RS9E?=
 =?utf-8?B?RHZlbWdzekIzb0pyRkxXRndNRUxNUWlEbHc4ODZtc1ZNWUJITnpHZzhMMVdW?=
 =?utf-8?Q?Rj8HOmjROJwLSFp4KhsrXXC5x8qbE99xVfTys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWVVZHFOR2U0ZmNRcHpudGJhUnpVWVRBenAwUVlkdkVidzJ5eWxXODloSmZ3?=
 =?utf-8?B?cm5kbk1xZE12YUI2WENMK0c5N3hvcXBsQ09ZRFRsUGNEbVFoQkVJY2hYVXBz?=
 =?utf-8?B?SlNZSUNLbURmZTBXcktjV0dlNmRUSUI2a0pWMjhucXJXUHZ2dnh6cW1qQW1T?=
 =?utf-8?B?WlRwTVBHV2hWWjR1RG5YRTZvd3VjSHlTOUpkaEY1Q2ptaHE3clFKZlBOZUEr?=
 =?utf-8?B?bFF2RjBaOE9qYTZBUjk5aXdDUnFhcHFCbFhIQkcxcWRoOGRienVmREYrTUlz?=
 =?utf-8?B?VnJOTnE1UzNvQ0dQWXIzYlMwdkljOXVQUGR4QlFkZkNrU0ZaTnUxUTdGdFk5?=
 =?utf-8?B?c3pWallxSGUxakNVL3J1VEhyT0V2VGwyejdCVTVrTW9nUFJhTXo1U3Q1R0Nn?=
 =?utf-8?B?RDlSbTFxTUFnVnhzWUJsSUNUM0kzZy8xUS9PMmswdXQwT3l3am9EM09ySzNU?=
 =?utf-8?B?bEh3Qkh4aEhrdGFsUUVTOS9HMXZTdGhjSjhPQ1g1NWd1T3BjZEFGQnJaMm9m?=
 =?utf-8?B?eGV6UW8zMUMyVUlRYkVCSHl0TXNHNUhVaU1kMVkxd2dxQ3BndHVPVnBtVlVF?=
 =?utf-8?B?TmJUamhqemlTZU56NmprbTkxWG82L3UwR2RDU01jcEswSVhRWG95MGphaENW?=
 =?utf-8?B?ZWpXd240OHE5Z2tTQTdzaTMyb0FRbVdVUkRmNjV3N3pLTTFTaC96WCtQRHdH?=
 =?utf-8?B?VzV3cVNsaXNTeStYZStMMnFaTStNUzFCejMvWW1JdGdHN3FvdTF3c3ZDT3Ax?=
 =?utf-8?B?d1N4ekFZb0pTdzdvU29SYmFlWDhNdTRRTVVoUFhIcVZhazRFbUQybkR3SW0x?=
 =?utf-8?B?TTl5eHAvbHFCOWJLdnhoWEtENXZwbVBHeTA1SDJNbnBWMUhiTEpPNjBsM3g5?=
 =?utf-8?B?NEs1SVhOSmtySXQzbUJaZGQ3YUZwLytqS0t1MmxybThVc0lMNEZLRlBsazJl?=
 =?utf-8?B?LzFLSlJuMkNDUm41NzhUd0JZMmJKSHlhTHd6MFYrNHpKVW9SaHRqbWxzZUo3?=
 =?utf-8?B?Qlh0QkRycVhPa2xtZjdaUjZMTlNOdWpicER6YURyVEZIRzlnQWxyRkYwdC81?=
 =?utf-8?B?Y24zRDFyTEROS1RlTEVjWTRVdTNBTzJTa2FaNDc4dTI4M0VJWEZZSUZjWDF1?=
 =?utf-8?B?dUU3YW9aUHhHYkk4cU13NzBYTlgzb0UwRUM5RWpzMkZVdXg4dXNUdUdYckh6?=
 =?utf-8?B?ZXVKeVRuSXNjU2Z5d1dtbXhTNGl5bnQvS2h3cE15cVBTYVhJMmphQ1ZWRk5W?=
 =?utf-8?B?NlRvWC8yL2FMR3RtQTNEVlRqNTIycGFRYXAzMkJSZVZhbzhVMjZOdCtRZ0k3?=
 =?utf-8?B?a0w0bmMvT2cxamtvYVpyK0t2akc1SVVOcEhORUc2K1duYkZJcjV0NW5rZXFx?=
 =?utf-8?B?TVRTK2FIUy9Za3VzbmFmMW5RbUFBellKNDM3QUp2WWJFZWJxUzIzdUNvMmVw?=
 =?utf-8?B?ZHBPSzJpM0ZJWm1PTEFFcHRoWnJ3aDgyaDVIdjF5aGVhZDdmdFRBRE8yckRN?=
 =?utf-8?B?ZmlxdU9vR1pLYkZvSmZWckNMZEhEcVRXVlIxZUF5aC9GUHhZZFFVdFBoUDdl?=
 =?utf-8?B?aldIK2RTdm5WQzVuQ3FFNHh6ZkhOTEo1cDV3K3J0OUF2Q2Y0NWYydFp1S2xZ?=
 =?utf-8?B?all4RTNFOEwyVVk5Q1FpaVJvSjc0V1E3M0EwM0Z1YjZCaCtDZ05wS295aU82?=
 =?utf-8?B?Skp4VWIzTS8wdXU0RXBWTnViRmZLQlluVVdZTW5DdFdGbit4dUJ6MTJxRHpK?=
 =?utf-8?B?V0VQKy83SnNuM1FkTndnZ3IrNDcvYmpqQWxNWjcyc1Q1anFuT0ZhRFJ0cGF2?=
 =?utf-8?B?NFpXQUJxT1JJd3BRRXU3cGdLdVM1eWZYUXY1T3RGdzBFVDBUb0E5RXZWUTFH?=
 =?utf-8?B?U0tpaHRCWEtnSVRFWlZsa2E0OWk1VytMYldvL2tidHBHSGg2dlNRUCtxSGIr?=
 =?utf-8?B?bExWdCsvVzlMdzQ1UnV1ZWhmR29aQkhzZWF3aFJ5TG9EeXRIRFU4V3JtL2N4?=
 =?utf-8?B?d0p1ZU9Wb0VtejMvYzdPK3FGZklmaTB4UGpTb3VXMEVoYmx2K09LOEUwTnFi?=
 =?utf-8?B?cTc5dDRTS0h1eG9STFFBbHg0NG1HTExsM0dRTWhCTmJyS3RuSTB3cUdMYWhy?=
 =?utf-8?B?NGpXOERoemxaSTIwSndMdkN0NUo0WXVpUGNOY09QcFh1WmZBQmgvcXJzYWhP?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ce3620-809c-42aa-5b24-08ddf457151a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:55:01.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYnGvhs0EH6SYGod1rt5zovmiLofI6Gl6V89ypwkqlBF+N/jQYfV0dyvDAeabIsEd5TzExJMeLsa9G+NV7cutSBTmlrcxFU/cUiV4CWjsNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com

On 04-Sep-25 20:54, Sebastian Basierski wrote:

>
> On 9/1/2025 10:01 PM, Jakub Kicinski wrote:
>> On Thu, 28 Aug 2025 12:02:36 +0200 Konrad Leszczynski wrote:
>>> It was observed that extended descriptors are not printed out fully and
>>> enhanced descriptors are completely omitted in 
>>> stmmac_rings_status_show().
>>>
>>> Correct printing according to documentation and other existing 
>>> prints in
>>> the driver.
>>>
>>> Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code 
>>> duplication")
>> Sounds like an extension to me, so net-next and no Fixes
> Sure, i will drop this patch from this patchset in next revision.

Hi Jakub,

Would it be ok to remove "net: stmmac: correct Tx descriptors debugfs 
prints" from this patchset and add it to already existing one for the 
net-next changes as next version?

https://lore.kernel.org/netdev/20250828144558.304304-1-konrad.leszczynski@intel.com/



