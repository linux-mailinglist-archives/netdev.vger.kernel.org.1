Return-Path: <netdev+bounces-294984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CgKGM0DFIGoN7wAAu9opvQ
	(envelope-from <netdev+bounces-294984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0563C0A3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GPKwOlbd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294984-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 967373014C03
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FD1F09A5;
	Thu,  4 Jun 2026 00:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAD1F16B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 00:17:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780532269; cv=fail; b=WVwWsUZ8168v20wZx6QtdIkLZ198eKvH0zta3K2DZ1Tk9dXvJZHGHWLAqmO8bxnHRsbesbNuB2977NjbSM/3eDrtLFCAAqmO64tppAbhpf6EaNK8HcrdWjdi3obyD+XjUIqQWFPTkCP3rnVwWWDI/6+MlYRlzlgMZj+5Brv0qtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780532269; c=relaxed/simple;
	bh=4Y2pEcjetwfpdaYP3ZZB+6egsYzdPW/U6azyVVf3t0s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJr0qJMymtsMQennBRyDqbLgaQLy6hbflqLfVvgJqFDoXJpGsnImrPcv970sUIj6B3So6GnpWNlydQHYEf0oTx56RvZ+/z97i+vHKJFKolT6Ce6uLvd9/rAqAyNLr9JC9Pf0BXzs/AZf+71x1blw3t7bF4k9/vWpxHJNDyA/xuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPKwOlbd; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780532268; x=1812068268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Y2pEcjetwfpdaYP3ZZB+6egsYzdPW/U6azyVVf3t0s=;
  b=GPKwOlbdxl/ERYSZni78y/ObjMauGN0fk7yJpXkMgUflcVQmk4uoThoT
   NB+GmXTmEcwDKebQJTByRlLHN+87dJ5IwToc/vorlsSZYY7JJNwoCSPSw
   rYj+1bNkfK0AmmTq8ux+mBxPxGbbn+nNvLiJUsINSZwHSwTw7uxyTf+3f
   mnTA5yEoKPjgg7WDfCgJDM1I7pQC6nwJCiVagxjifgHa/jwuAKI4+byNF
   kA0sLkHJ+ywRkGELZOd9tCvsUTfjklfqJlPm4O+uehzgHbWxsQY10YAgb
   Ibk60qDUSDPwoaKgTpme3sjOkZ/T+fuAO2DXz7+HWxhPYEyAJtuFbCM34
   Q==;
X-CSE-ConnectionGUID: /KRKJpg+SNSU45JECRQ+uQ==
X-CSE-MsgGUID: E2e2WUB/R02RQzDofXkq9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85244513"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85244513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 17:17:47 -0700
X-CSE-ConnectionGUID: WfTgGVCmRfu3XN4s5B7Kcw==
X-CSE-MsgGUID: Zac/HMscQAa1OXewoGjfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239913517"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 17:17:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 17:17:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 17:17:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 17:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwYjcb71EsaizK5oOv027gyizJiW1MLoyXreqFk589GP2Oo66KhII/oD21Z1h7y7OX3zXeFcIfU/g1309NLGKknpIwd14r9nCK5Byni0z7oIlqTDOC4yMRlb4PXHGZQuObKeB3OGKPoi0LzC2BkTgNr/DpfBvV5YMYdYzmNP4UaB+BDH0hzF9601HMTGay8l1rW1sjhA4mlHejBbntb55MVX2uJXlDEug1l9O+hI+iMeMPYJieNHdoz1YAgEr5znrYbG3svljgHbF9cRNdlSlrJjXAR1HHQWfopNJuPdqyUNEcKidF7GaCw1vqenfEt18PlIXkx4nmvZOR0MVxRiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUCww8Tqu8KPb9GVbBWry0PlA3hSYXbCXr1Yi0fRn6U=;
 b=kcMMNHkt4Tc5WnhoJ13D0I85itZ+IyEVNp19VymJFgbnplmnxrD48mzR3AUQjk/Cai4g/3hJaFKoSgRIukcjQ2V3FgsiLUJi2etwsrMdCagxjOWrxdf9tsSgdlS8NjzaJucg21Z+VAq0Natm6wkgU9SJ8CKwasQ3ErjcRCX57Nal4Ucs4cBOTi92nmo5h9GNxPqJ8g2XFdB1hAsBKGvIINy5X06+TiN+++QjTL38GtdghAf4tSJkXTwkyz1Qv7D/rlYgCs5qz9+xjZvnGoElipMj8oGGS3AmUEv2ydSAKS25Pub22bC954yn07VZB/8vw/ecscCU6dBtZT2H3ISALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 00:17:42 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 00:17:42 +0000
Message-ID: <3ca7d6b6-1aeb-4e7b-9263-64f4b427d1ef@intel.com>
Date: Wed, 3 Jun 2026 17:17:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl: try to avoid the very slow YAML
 loader
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<donald.hunter@gmail.com>
References: <20260603210810.2636193-1-kuba@kernel.org>
 <508a922f-c8e4-4b31-8670-43d44d45f467@intel.com>
 <20260603163518.7bde747a@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260603163518.7bde747a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:303:6a::24) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CY8PR11MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8cd4dd-8e0f-49a6-735d-08dec1ceb1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|18002099003|11063799006|4143699003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: xqlboV1DLGJUO2IAXUrO+pJ9vIfhwlhSa+Pvqx2kUkknPP7bfqYgCf+pnkLJ//NxNj/WB5NHwz+XixG6Gz5oJCOe5BayFpnCF4/qIyJRAeS4y0sfpzuMA5ChJOasxn1dqP+JlgHRl+40hu+nZASY7T0OnTdW8IjFIcU4ppM8z+IVcHM0twq2rtzp0TpHC7QykjeNZ04DFolGAmcMjqUuKLXvEysP7jQ0FVWE6DYeFNqSZhv4R2vC2v+v+0L8SfO/cqorH/RUe+DUksOkXoHiEr1xcZlgsTqBkU6AMoLiYY2QSkYHIg0RXX2tbJ/P7/YKOzZdf5QPlDtWjfIRwcPrPSwPRUMivhVtU2jZ0Ln7ht/fjEikYhhfiCvmH8FhahqP2P1DzyFDfGwCAT0zefGmh0YNjxxbIC7EcW3sWXFuP9eK78ExZS+GsJwiNAGrlZ4RuIIFcMWRW3NVgxbN/hV6rJVpRuiS535KOmkD9eqm55ezjJPRVve+zzq40idXvncfwgaPZxMPOkzEZaw73F6uSNvnE0BOmc2/d+n4okAw0K9K6agb/qxfzzURKPGaTsKyOAIc/G6rpPBPeyJ4Rgk4ASYdNy/EEvn6NK0OFcp0AqtKMEx7STmCMj+6HszAYPj6Mg+qJI/SNSly55fM7mVpdcCeu71N9wA9S8ocjEpUGx7rJwuV1RPoEbw/3WFvpordOF5hmsDSQB4T2uj2If4CCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhHcTdiMHpzZ0ZJNlRzY0RXQmVPWFlGb1RwRUJTSlpNeE1zUDV4endFZXNR?=
 =?utf-8?B?aGZkcWc0OFpzR09QVE9pV291M1pHV3RyZnU5by8zMXNMVUZJUGdiOHE3Vm90?=
 =?utf-8?B?WXp3Wjc1K0xkRTZURjEvQTI5MUs2MkNvVGh5SU1vb1JPRnNEMHMzOU1nWWMx?=
 =?utf-8?B?WTJ3b1NmT2xlTmZYeUl3OEV0bk0za21LQ1VXMnRwTHNVTjVocTNzNlQvR2Np?=
 =?utf-8?B?REF6OFZoREdubUdxWGduZmFCazhTWTVoY2YxRXNZMHdaUDFPbk8yTzgzV1Zt?=
 =?utf-8?B?ZHlTdllPbjc2NWkva2lzMkZvUmh6dTdxSG5XM1ozc0hxN08xQjRGQUhlQWta?=
 =?utf-8?B?QXpPTDQraGJMUXV1T3A2VDArdzNtemR2QkxjeGZzM3l3Y0NNM1NsdkRvZ2F2?=
 =?utf-8?B?ODVNS2lUbUlUd1krRlFxMHpyTzNOeG91ZVRvanFUSllGd2NFdzFtT3RjcnF3?=
 =?utf-8?B?Vy9wTTFkdkJqMTRDN1QxYWdzZm0rVnlUS1paMDZTaFVBVDkzMmthSTFPRnla?=
 =?utf-8?B?aXB2OHVRL2ZhUWsvUExQS2FtU1ZlblVPbW80cm5vNTF5bHdDU2htMHB5azZm?=
 =?utf-8?B?TElhUnFoWkxCYmdYUHQxdmR5c3o0N0RoSHFnZVozVGNIWDRZcXJLbStUSUtE?=
 =?utf-8?B?ajlTend4UmdCSzdxNDJ1YU15b29HZkNIUFNySnd0WjFlWGhTMi9ZYkNacWVS?=
 =?utf-8?B?d1FOWWQ5SklndmlQTTI2c2hjSlpUQUZTMGtZNTNBSm1CQjZMUDNJNXpWNWxU?=
 =?utf-8?B?TmtIeUxkQUhwKzQ3dGN3dk9vVDJldkxOTzFvUWphbmZucFcxQUpxekVocFVo?=
 =?utf-8?B?SUVsaHYzK0lTYlhWRUlJMmlMOGhXZ3JNbkhzWGRuWGFiUjRNNUh6SW9Jbmgy?=
 =?utf-8?B?RlR1R2ZrdFA1d1FWK2hyUWlCRVJ3bGhGK3pTeVlUanNBMjIvTlNjTlgrVnJv?=
 =?utf-8?B?WlFISk9nQytuTGs2WmxSSGRhdDBNR0V2RVJ3OExXUlluMnRIS2dzUlZLYUsv?=
 =?utf-8?B?Nm40Mmx1NWp4MENhWlBhck5DZWtTWVJLeDVvUGVERGRDTUlwS1pLZERpTUdw?=
 =?utf-8?B?b2xQTUsyNnFzclpDM1orQmJvM0R2aXdkQmQ1L1BsTTIwQVlMS2NVTDhVbkJj?=
 =?utf-8?B?NUlpZ1dhbFAvMk9RUWtyQklKUElJeFlKU2FCQkxJMkNNZGtkWmRIQlBqeFZz?=
 =?utf-8?B?dnFhZEtKVFJTRWRuekV0czdOWlloTjM5NW9oUk1qY3RpejNEZ0dOZWxvME5L?=
 =?utf-8?B?RStzcVpPMXduTVJsRVJxTi93MmdmeDh4ZDh2ZXNFNHQrbzhiRTVTMjJ1b0Yw?=
 =?utf-8?B?VFhMQUNXSGQxazBieFY2UWtnZFBtajh1UVRXSTZWVXpReWVYYW16NlAyalJN?=
 =?utf-8?B?b1dSM1JwWjNidjlUcnhpc21mVUxaTnpOVWUrcjlTR2dyZFh1Yjc5RXBIdHVr?=
 =?utf-8?B?eENFZUJieExnalVNdlZnMWZHMDJIWEE0cTltQytncGxvMllpaU1OWmdWdEo2?=
 =?utf-8?B?eEFLWnlwaEw4cmdjSUVWZFB3QkxFUlR3WFV0cXNPdFdQOWpBRUNCUVg1UDJN?=
 =?utf-8?B?MHk1ZWNpaytMaGg3VDg3MmtwSG5vL0dDdVplTVovditMVXBiZk9lak55cnNW?=
 =?utf-8?B?SFZFdlNiSkw0bkhKQ0JSK2JSNzZpNmlqbFVCcWFJbmd5NmhVb2FUbnNmejJK?=
 =?utf-8?B?Z1pvMjZnOVo4OUc2Y3lydlJRaS8wQ2VpMjI4RVpWcFBJRDB4K2V3M1RmR01I?=
 =?utf-8?B?WFJGT0dsMityRWdlMFRTYU9aRnZpMEZHemJSUEV0cXoreU1XaDFMYkNib1hy?=
 =?utf-8?B?YU9SWXRTL3ovVUtObCtSTVAxSnNkSFBnSmEvQ1pwTkEwMm8yeU55Skpxc3Fl?=
 =?utf-8?B?a1VsTXVRZnUzamppbDNuWm5zR3BOSkZqUEJkTS9EeTB6cmcwRGhwYlNVL1gv?=
 =?utf-8?B?bU8zTjkxRkYveHpiMDVRTEhjTG5ycDBGUTd2dUowTlVjVjBkYW4ySkMzZ05R?=
 =?utf-8?B?NytXTjZaT2JNUjZzRHdqM3VxVUI4QVFYZzJiakpqaTl1Tnh4NDhmNTRtR0ZD?=
 =?utf-8?B?MHNSMStGYlBVcEl3VUNxRXR6VGkvdEhRTDhxL1Y5ZjdidTdia1lFTnh4MjVY?=
 =?utf-8?B?dVk2dElramtHdXBrcHhtNGovS0xBUkdYL3F2SWFIOW5DQmZlTDNKY1lNakcr?=
 =?utf-8?B?dVdXYU9oY2ljcldPeVdWUXJhVUV3Slk1NDdXQjgxcnVEV3pFVnBjejRRYUpq?=
 =?utf-8?B?VGdySURvaThQR3hsWU0rRGlRNjV2ZEZTa2FqbEt2TjFDRDZkclVkb0xUWnRN?=
 =?utf-8?B?VitYVHNpN1VkQkxiWStSbjNkenBEZW8zN0dhR0NCUk1EWU1iVURPUXZubXdk?=
 =?utf-8?Q?lec1KIDjnZB8doW0=3D?=
X-Exchange-RoutingPolicyChecked: RC4E9vwVmv26jssLD8uK6znwSNNqVDLcOYoRCfUS+sae/qyMBk79ekJtje9qBORnwRmZU2oyhu20dZCPT1e7TLyE7y4Q/kP3QJK3Hknn+u/kbRc8sLwXBdAB5NQaw/UlBXLJvuyRG93oVK84o+IeItb3XeOfbyCjBBA/I5lSA9kQ8bFgD4WwQoivehre15AWB3V9qXO/BQyRFJfiiK5aUYk6mMR/f5yYi4XOjYgk2MDxJ91WJy5qO1TtJSlDGvqPCAppkTLmZzwSrcysAMAOZDIP8m6at0vg2T375C3c8r1b1gNtybIuLNpBgGZ2jzahjdJ1TuDvOCZwRxgtvX3cBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8cd4dd-8e0f-49a6-735d-08dec1ceb1be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 00:17:42.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5rmuoTDA3p5nA9NTmNPR6pVqwzv/RCPdD6bp+Nj+CYuiGF+pC6SvsOLymKvP8IxweGut3sDfWAuBf7CDVHBPnmitPXUKG1lTFOhHFAQsl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294984-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79A0563C0A3

On 6/3/2026 4:35 PM, Jakub Kicinski wrote:
> On Wed, 3 Jun 2026 15:08:46 -0700 Jacob Keller wrote:
>> Hmm. I was a bit confused at first by the switch from safe_load to
>> load.. but we're passing Loader as _yaml_loader which will either be
>> CSafeLoader *or* the default SafeLoader, so we'll get the appropriate
>> loader equivalent to what safe_load would have done, so there's no
>> change. Ok
> 
> Maybe I should have mentioned this in the commit msg. I was also super
> confused by these APIs but IDK how much is this me not knowing Python
> and how much it's special. AFAIU basically:
> 

This is a pyyaml issue not a generic python one I think.

> somewhere in pyyaml...
> 
> 	def safe_load(file):
> 		return load(file, Loader=SafeLoader)
> 
> so safe_load() is just a "shorthand" for using SafeLoader, which unlike
> load()s default loader doesn't allow constructing real/binary Python
> objects ?

load() by default uses the generic Loader that supports the full spec
and because of that is "unsafe":

https://github.com/yaml/pyyaml/wiki/PyYAML-yaml.load(input)-Deprecation

Basically, loading the full YAML spec on untrusted input is unsafe since
it allows arbitrary execution.
> 
> Why it doesn't default to the C one is beyond my understanding.

Right. I'm not super familiar here as to how it ends up not defaulting
to CSafeLoader, but probably its because its not always available.

