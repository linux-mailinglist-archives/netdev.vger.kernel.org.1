Return-Path: <netdev+bounces-288291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMdJDdkPB2qirAIAu9opvQ
	(envelope-from <netdev+bounces-288291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01E54F5FC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1203730F3E4B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D044E047;
	Fri, 15 May 2026 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7kH8/av"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6354478E2C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846034; cv=fail; b=OciUTvQdF62bDOouqR6RQs4MNo9fFTue96cw30HW0Qs1v36oVgZcxxmhGCOFly06TNWAX0AOOv+rRrmtCtJH6khVegHiRt1pxwXlVPzPwdVlzm+om+Khv0wqeZIKjESbCcTJWXpnsqGhWx90E2+rHo0bC9b93QGK7caaFhGW5m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846034; c=relaxed/simple;
	bh=LMpxFjFXDn6rRfRAlAEPmbso9jd0/HNvXyewVsKCeRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYJ94kL+Fs/aXGiIGqBesmrfQJCTOgaLqqZczd9LKTo4ucW18+N0J4Z3Gr24LWtb9P/y+HL9cFKT+H2+sp7NrJsTRw5P44CEV2z2FcxDMncoUvNpOwR9mlauntKGdDLPaDFmAAlQut+WQjFqsCkzsA9PGL8PGVT0SwXbSmsnjqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7kH8/av; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778846033; x=1810382033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LMpxFjFXDn6rRfRAlAEPmbso9jd0/HNvXyewVsKCeRM=;
  b=X7kH8/avvQzdUYL41lyNsPf4S4UsZWN16741RNOx/b+vLL03FPISOXXp
   3twe6Ch78Z//HPza5hwBIJWOSdhsp3E0O8w+GhmFpzn5sRAMNr1IZqYC6
   7v0Xw7dAY0ql3x21cKylpiwBicXv/C/9wdzWcka5ojYzgAlJN/nuhLRhI
   SVIQpUn1AzJUgB+XXHgdRuFTFRaiAm+X54wRqju8Vz0mzLSsB1WEmmw7a
   77z/m4MTBGBtffZbJvjXuvKy+TH2Zjm7LX/4QmSTu5bBoIjJoXcqchg6e
   ZXJO9OmMijuetxkKKOxVUHAl0INf5vwESyo6dMEy3RjfDJfJtfGYrOq9q
   Q==;
X-CSE-ConnectionGUID: ih+o7Q/RRGapOi7jNuPHaA==
X-CSE-MsgGUID: b74BLDGUTZO0CwatXtxvdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90903969"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90903969"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:53:53 -0700
X-CSE-ConnectionGUID: EXlzXuPMQKuoOgmiEDOVWQ==
X-CSE-MsgGUID: UioF4wv4TMCS7lEhgEfpuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234241158"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:53:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:53:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 04:53:51 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 04:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNXfc81TxPH8WnzAb7zimkM3szaJudVNYnDchzP7u9Vg1ti8t0DqSueoFLSPYDy1IZT2/gyBRp27uer3K3qdqZOnwZ2DAR3sxH9373WtV1GgaJ3iGZlbNFn35agDY7rUNOIepVMiw9F8VRrHBAc0wTe1eGjL/J6q5frU7lY7InQOAT3kg9sTYjHOqD8rs/H4i2s+EPUSqmXlbbXbsNYfjkE/r2Wk2FumgJfGvFYYwQo8NqYHu0I6hnFP2E3+IujlR3EVMTTyT8X2BwoAplRAEjZlH+4YheNXcl8j/N/4xajEaC+raUly5tvqlcCvb6L6dVFpvHINLc3Ho/o6M9XN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMpxFjFXDn6rRfRAlAEPmbso9jd0/HNvXyewVsKCeRM=;
 b=IaJT/ro4FTmjN7oMoDluindlP32ExAQ3PSE0Z3ECaoCfePKkJzfQdmMMlLN/569ZS1fGc5DRc/S9LTjM5Vs+qVPgP4ZvnAchEDZeZtC5pzthzDtnV+h3i/V3uRSEBA9w5uIGhPALBjsCceKEeF2+ib4rSqgZ8BGC8CPE+khyUQxsyFEf8AUNIesRwu6uJJk9B+f4uKe2nzgdjJSDrTncwTETavJtoY8Dwni7ID+kMGVfEWG9NSGHke2FaCBZmQPmuJjP2mPxgLWtSlX5KNv7pxyILOIo8lqZFH4ep92u1JT7IVbjFDWgikVSyR6+muej5pRSX011PUjdVepFBlKHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CHXPR11MB9652.namprd11.prod.outlook.com (2603:10b6:610:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 11:53:49 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 11:53:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: add missing xa_destroy for
 sched_node_ids
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: add missing xa_destroy
 for sched_node_ids
Thread-Index: AQHc48KcmQQ/y3FnzUGTMaAsEi6X9LYO+zjQ
Date: Fri, 15 May 2026 11:53:49 +0000
Message-ID: <IA3PR11MB89867D172ABBE0537B91CC26E5042@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
In-Reply-To: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CHXPR11MB9652:EE_
x-ms-office365-filtering-correlation-id: 2e13938b-fa30-4559-4eb0-08deb278a073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3023799003|22082099003|38070700021|56012099003|11063799003|18002099003;
x-microsoft-antispam-message-info: pQeATFf+r8sTO8k2HroCKYakugcETJHELyZb8p0RCP14S0MIweJKCfFY/CymgbM6Ff05UjvP9KhOIaKJZzZKZSX5CLrw4tiL5/mW8/q6M7FayzwHY8WdZSRJmswAXQK8IvPSBvq0soJT3QgCci2sM+j3N9onFWTKEIQdKaaqpmM+5GNaZ5nfZ1xOqnBK6/zYuBCxcIKCVDQbH/4CzvxpRqFYv1tRgojLgy5AJW4/4Xx3MKrdEYG0XxKjwPGZwy5+CPYuQoCgFxvbXvSdM5UBZhVU2LfMkAzbLrPSiKDL7VB07XIRikI7v0gDgXOttZU1e+iJ6JM8hQaU96YlLVX28aup/Mj4HHwqOOwFmpd17JFlRwpHiixuYFKCmKDDm1DHyDNvWTms/IPrpw0ed203MyVGYFkb0vsjnKIFSqSh2h9L6+zgAGlJev8FatxAiPqVC8sPIrkxtrY51Rtk4LPGEk9TIpxCstS65OT1de/Ge0R1vhj0/8Xwwse6l1GaVBLfNIGSHLGAiquDChSecOGkg9AQekSvkcDBKGCKpT4DznaGqBR5kS98+ZltHUfQNh0afdtih5tUfBwPSNQDu5cZ6y3pwSkswSIBudu5MEBAXvULrdvt/5gP2y76C3P7Y8kB+JWe7kjZC7D885oRohZ2a2m9r/4wHMPWkHp1zooD+AK5JdsMwLW3ga1vr2r8zqFAu7MVx+g0Q5qXKKeA0Ma++vakRiw/cCfmtEuTuaZOPa/2wH7GLCigtsqn+oWqTx3O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(22082099003)(38070700021)(56012099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L092WDMySXpydXgveTg4K0g4bi9RY2VxM0JobjNmV2Q4TnhnTGtWaUpya01E?=
 =?utf-8?B?VDZSRVJXRW82Z0lGdmlNeTNyWXltTWkxZWdGNGc4NGcvZ3pNZnFHcGNlc2wx?=
 =?utf-8?B?cU1YaGx4QW84UWhkNHlLQjJFL2tPYlUvUmFDTi9PaTl2eUZ0K01ZajJBdU5X?=
 =?utf-8?B?UGpKTG56cjVkSitZN1p2RHJyc3J3QlBkaG9oMlVTWmMxb2JJSjBrbkxpZHVT?=
 =?utf-8?B?UU91K2JzcFhrMXl0ZnptOTNuckZjT29XKzVDWmdnUGUxaWRXMSt3U0pQYTRS?=
 =?utf-8?B?TER3cy84SVl2RVY3dVJQS1VnRzJiQlJEczMwcXEwV1FkNG94YlQrNm1WUFdI?=
 =?utf-8?B?d2l4Z3BnbWdBV09MU0xTeHA4K0ZNYjdqSXluaXM2QTc2WXJBTDZ6aUN4dDdR?=
 =?utf-8?B?MkhycGIxbVFJcmlPUmpKZ3BsenVaQ2JuQjFJNkp1SkUyRUdCRTYxSGtBcU1w?=
 =?utf-8?B?ODlMMXppN1l5TWdxbEl6dmltUXY5eThwQ1g4WHdTNms1WjkxV1VBeSt5RUVQ?=
 =?utf-8?B?b2xEc0tqZUtFOG5kVkIwRjI0RUhTamFWdjVZODNaZzd2SG9nNTFqNlJibXc0?=
 =?utf-8?B?eVNYMncyR2xjbVFaT3ZxY3plZGZYWStDQ1VNSnpwTXR4UkhZOXdYL2d0RU9a?=
 =?utf-8?B?WkJHMVN2aFBkbHJaaVVnZlhHY1lNOXBMa2tyK1JZcGMvTkhqblhsOHZGb3By?=
 =?utf-8?B?cU0yZ0syVHJIcEhtVmRRZTVwankyNlhOb3N4NUs1TEJxNHZwUHdqMU9VWHRD?=
 =?utf-8?B?UFZhRWI2QS9WWmVVYzdiWUd1V2dRVG5KMW5vdUJmT0lWaGZ0RkFvYXlhb2Zi?=
 =?utf-8?B?OUJ1WE0wbVR2Wk80UmJFdVhKYnNRVnhoS2dpdHNCZkJ6am4zK0xGOC9DWC8w?=
 =?utf-8?B?QmtFMFIzOG1VUUJaMnF3dnNxL1h5aU1iV0twZEQ2OUNkRTRwbFZsMWdSakpo?=
 =?utf-8?B?Q0JOUDQ0Zmk3S1VpZm10a2cxZ1hUcS9qV2ZGbmdXSmNtNERNZFgwOWdxZVVz?=
 =?utf-8?B?cFh6SGROejNnYXptQzhNZ0ZyakE3eTJvcHFXa0wyL3YxTGRHUytpV2pBSS9V?=
 =?utf-8?B?N2w0U2Z0cHJwWmxlMnJyTytyY1g4WUN1TnRldURBYUFjZ0xiaUJMbDZNRmR0?=
 =?utf-8?B?Y2NUc1QvamZKMjc3VVBUa1huYk1ialV4MVlCMC8wVXdTQ2I4Y1BUSXFiMWVl?=
 =?utf-8?B?WEpQNXZRWkVTZS90QktZMm9nOHZiUFRQZzRHL0s5cUhEMGhmWFFXd1gyK21U?=
 =?utf-8?B?SEc5cE4rOHBNRTFaZlBRSktnSVk3emFmOWlERXhQRnBpUEVCd1cvWDh6aVBi?=
 =?utf-8?B?dERBOUZha2RnOTNFaCthcWMzblBFMjhtLzdJZVY1T0FpeHNGcDdPVkRsc0xM?=
 =?utf-8?B?UHRGb1hEVTBLMDFnTktzdTd1K3RXVGkvY2xCck9BSU5SeklJa09TM01vTk1v?=
 =?utf-8?B?REhaamY3cktNQjhhcks3VjVPVlZkN2puVTN3UTROWjVqOVViWFNPaTRNaDBY?=
 =?utf-8?B?OUZLeDY3RnAzS0ZOallYVjVSTUJQS1pGNDhycGFOYVZFdjNjSklyUGpRWkw3?=
 =?utf-8?B?WTN3Q05rd0dhOHNRdmttVW9qVzhIYWRZV2RZOGUzNHZjYlNTZDRldTQwRzZD?=
 =?utf-8?B?dkNxdGhNS0czMGFXSnhrbU9Ja2xpaGE1ZUpDUEpsWmg5MEUrZW45MkFrbVJx?=
 =?utf-8?B?dnphazV3TXh5RXljK1dkY2s4UnpWdThmWGlFTU1BMG1sK2FYbC8wZUZRRzV3?=
 =?utf-8?B?Ry9sMGVxWHRCbWpkWXUvaURMTFVwL0YvNm90UW5YNW1MbUMwbG9NOTMrcjNs?=
 =?utf-8?B?MFlFdHc3eUEvU0ZzcW91dGdmdEJNUHFyV0dRUnpQUFRkMENYSnAvQjk2c1hG?=
 =?utf-8?B?UHBJanlQandiUjJQYk10OXBFTGU2eGV6cms0RkRNODhJTVB2bjU3eHg0N1ZN?=
 =?utf-8?B?bGY5cWtTT05zNHRwNzliMGtCSnNENHB1V3ZuSTQzcnducHA1YSswbnVkMjZk?=
 =?utf-8?B?UmlYWVB4WHRtSjZEU1ozQk5RMVh2UktONUkyYmJYS3JvN0tkWFlqL1ZnVkMx?=
 =?utf-8?B?VElkV1ZlNStncGVzSlRBWG40blVhbTNUWXFtbEUxQUJ1aWF6WGJETWRJTVpY?=
 =?utf-8?B?R2tlSmhDckovOTY2dWZMZlhtQmhBcWR2QVV2bEQzTExtSGk2Nk41clZyUTR6?=
 =?utf-8?B?dHFlK2hqcjY1cTJoSmRoV2xXdCt6K1lYeFdqdHNRWmR4QUh4d2Irc0dKc2pB?=
 =?utf-8?B?L1VvSzZGQlp0NERoWmtJZmJ6amF6TjNpbllDa280NTZzd0ExRi9OWDNsNmRV?=
 =?utf-8?B?OXdYd0Z2cm1JWEt4WHRNVjVqUEZWTkxKN3NGNlZ3TVN5MG9kZTBBdnFRZWds?=
 =?utf-8?Q?OCbZAi2vpzJ0BCic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J4/bpIl9klLNWJw6uMILUyJiQ54xM1Y0zUa7ieDy/gT2/bQ8zyHzenaVm2WgA6XPGQ0kZ0pz8rlY9SpEcnp7gPj7WDAXbrE+JG2nvA0SymdYOXym43YrfSmsZYnmxa0nK2iAsze/Oq1D/WaQRC53h1bE0XtsQEaWdqGAiNRb2zAIcu2pa3XGtM9nar2X3xdbAA/ByVdg4woT5MDYS7QqA/44fC20DnFRfLbD98CFIqIyI35CL5VblXLWBsNU6dN/nqQpXPkNZguDNJHq2wInzJCkLQosFLwt+KF3K6vj/gOgGhNdxbqPPruXzauuEQcISj+GHAyvzAJg1ysRCByxCQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e13938b-fa30-4559-4eb0-08deb278a073
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 11:53:49.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8ODQTOJUKx7vi86m4aNzmiZG9z8ICvLSphihVKcZity1TNVa1Zc4dxMOm/mqHiZqcsk2z1o0aRfZ+A+OUuSyK7F0X+c+I4qt7qbBJf7Iwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9652
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9E01E54F5FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTQsIDIwMjYgNjo1NSBQTQ0KPiBUbzog
Tmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwN
Cj4gUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IE1pY2hhbCBXaWxj
enluc2tpDQo+IDxtaWNoYWwud2lsY3p5bnNraUBpbnRlbC5jb20+DQo+IENjOiBpbnRlbC13aXJl
ZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgS2VsbGVyLA0K
PiBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV0XSBpY2U6IGFkZCBtaXNzaW5nIHhhX2Rlc3Ryb3kNCj4g
Zm9yIHNjaGVkX25vZGVfaWRzDQo+IA0KPiBDb21taXQgMTZkZmE0OTQwNmJjICgiaWNlOiBJbnRy
b2R1Y2UgbmV3IHBhcmFtZXRlcnMgaW4NCj4gaWNlX3NjaGVkX25vZGUiKSBhZGRlZCBhIHNjaGVk
X25vZGVfaWRzIHhhcnJheSB0byB0aGUgcG9ydCBpbmZvDQo+IHN0cnVjdHVyZSwgYnV0IG5ldmVy
IGNhbGxlZCB4YV9kZXN0cm95IG9uIGl0Lg0KPiANCj4gU2luY2UgeGFycmF5cyBjYW4gYWxsb2Nh
dGUgaW50ZXJuYWwgbWVtb3J5LCB0aGlzIGNhbiByZXN1bHQgaW4gYQ0KPiBtZW1vcnkgbGVhayBl
dmVuIGlmIGV2ZXJ5IGVsZW1lbnQgaW4gdGhlIHhhcnJheSBoYXMgYmVlbiByZW1vdmVkLg0KPiAN
Cj4gQWRkIGEgY2FsbCB0byB4YV9kZXN0cm95IHRoZSBzdHJ1Y3R1cmUgZHVyaW5nIGljZV9kZWlu
aXRfaHcoKSwgYW5kIG9uZQ0KPiB0byB0aGUgdW5yb2xsaW5nIGNsZWFudXAgcGF0aCBkdXJpbmcg
ZXJyb3JzIGluIGljZV9pbml0X2h3KCkuIFdoaWxlDQo+IGhlcmUsIHJlbW92ZSB0aGUgb3Zlcmx5
IHZlcmJvc2UgY29tbWVudCBleHBsYWluaW5nIHRoZSBuYXR1cmUgb2YgdGhlDQo+IHNjaGVkX25v
ZGVfaWRzIHhhcnJheS4NCj4gDQo+IFRoaXMgd2FzIGNhdWdodCBieSBTYXNoaWtvIGR1cmluZyBk
ZXZlbG9wbWVudCBvZiB1bnJlbGF0ZWQgY29kZS4NCj4gDQo+IEZpeGVzOiAxNmRmYTQ5NDA2YmMg
KCJpY2U6IEludHJvZHVjZSBuZXcgcGFyYW1ldGVycyBpbg0KPiBpY2Vfc2NoZWRfbm9kZSIpDQo+
IFNpZ25lZC1vZmYtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMgfCA3
ICsrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9jb21tb24uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9u
LmMNCj4gaW5kZXggYjYxN2E2YmZmODkxLi4zOGQwZDdlNTk0OTQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9jb21tb24uYw0KPiBAQCAtMTA1MSwxNCArMTA1
MSwxMyBAQCBpbnQgaWNlX2luaXRfaHcoc3RydWN0IGljZV9odyAqaHcpDQo+IA0KPiAgCWh3LT5l
dmJfdmViID0gdHJ1ZTsNCj4gDQo+IC0JLyogaW5pdCB4YXJyYXkgZm9yIGlkZW50aWZ5aW5nIHNj
aGVkdWxpbmcgbm9kZXMgdW5pcXVlbHkgKi8NCj4gIAl4YV9pbml0X2ZsYWdzKCZody0+cG9ydF9p
bmZvLT5zY2hlZF9ub2RlX2lkcywgWEFfRkxBR1NfQUxMT0MpOw0KPiANCj4gIAkvKiBRdWVyeSB0
aGUgYWxsb2NhdGVkIHJlc291cmNlcyBmb3IgVHggc2NoZWR1bGVyICovDQo+ICAJc3RhdHVzID0g
aWNlX3NjaGVkX3F1ZXJ5X3Jlc19hbGxvYyhodyk7DQo+ICAJaWYgKHN0YXR1cykgew0KPiAgCQlp
Y2VfZGVidWcoaHcsIElDRV9EQkdfU0NIRUQsICJGYWlsZWQgdG8gZ2V0IHNjaGVkdWxlcg0KPiBh
bGxvY2F0ZWQgcmVzb3VyY2VzXG4iKTsNCj4gLQkJZ290byBlcnJfdW5yb2xsX2FsbG9jOw0KPiAr
CQlnb3RvIGVycl91bnJvbGxfeGFycmF5Ow0KPiAgCX0NCj4gIAlpY2Vfc2NoZWRfZ2V0X3BzbV9j
bGtfZnJlcShodyk7DQo+IA0KPiBAQCAtMTE0Niw2ICsxMTQ1LDggQEAgaW50IGljZV9pbml0X2h3
KHN0cnVjdCBpY2VfaHcgKmh3KQ0KPiAgCWljZV9jbGVhbnVwX2ZsdHJfbWdtdF9zdHJ1Y3QoaHcp
Ow0KPiAgZXJyX3Vucm9sbF9zY2hlZDoNCj4gIAlpY2Vfc2NoZWRfY2xlYW51cF9hbGwoaHcpOw0K
PiArZXJyX3Vucm9sbF94YXJyYXk6DQo+ICsJeGFfZGVzdHJveSgmaHctPnBvcnRfaW5mby0+c2No
ZWRfbm9kZV9pZHMpOw0KPiAgZXJyX3Vucm9sbF9hbGxvYzoNCj4gIAlkZXZtX2tmcmVlKGljZV9o
d190b19kZXYoaHcpLCBody0+cG9ydF9pbmZvKTsNCj4gIGVycl91bnJvbGxfY3Fpbml0Og0KPiBA
QCAtMTE4Niw2ICsxMTg3LDggQEAgdm9pZCBpY2VfZGVpbml0X2h3KHN0cnVjdCBpY2VfaHcgKmh3
KQ0KPiANCj4gIAkvKiBDbGVhciBWU0kgY29udGV4dHMgaWYgbm90IGFscmVhZHkgY2xlYXJlZCAq
Lw0KPiAgCWljZV9jbGVhcl9hbGxfdnNpX2N0eChodyk7DQo+ICsNCj4gKwl4YV9kZXN0cm95KCZo
dy0+cG9ydF9pbmZvLT5zY2hlZF9ub2RlX2lkcyk7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IA0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IGM3OGJkYmE3Yjk2NjYwMjBjMDgzMjE1MGE0ZmM0YzBhZWJjN2M2
YWMNCj4gY2hhbmdlLWlkOiAyMDI2MDUxNC1qay1maXgtbWlzc2luZy14YS1kZXN0cm95LWQzZjkw
ZjM3MTFiZQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBKYWNvYiBLZWxsZXIgPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3Yg
PGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQoNCg==

