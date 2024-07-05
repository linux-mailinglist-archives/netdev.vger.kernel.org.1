Return-Path: <netdev+bounces-109520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BD928ADA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A541F22B79
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A314D420;
	Fri,  5 Jul 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFa6Adum"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230816A921
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190704; cv=fail; b=SUTjmNdTME/5YvT+PCmPDqnBH8NPrxHgsGhYUZbaxFW4Uwe7qhMid74AX/jhRpTyUrfNm/sZYOn/Ci3Tx5CET5b7IQkccTOkYWz7LxDgAKSLLnhGMSv4A3XlTJXqgp5uzlavMVTbHKwi6IWzDBInk/dmeh+/3Al5JQDc53/aAYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190704; c=relaxed/simple;
	bh=C5PPxVC/haSo/75tdkjl/6yF+mEKUlIg4AEPE2LYR20=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=keSs6OuRQirN/D5A722vlO7VoWDsPc57imSQyeI6Tmj5eF8reuuXQ2ZZe4xyhcyttKLhoII3voAz+FPay8LeZfIu3zYEvZNwDokcmaYFVkmRgYxc7jI6kWjkE/HqmMyP79lowf9U521W8b352fZYDI5Z2OM8RE1mjlDqVzWYRcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFa6Adum; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720190703; x=1751726703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C5PPxVC/haSo/75tdkjl/6yF+mEKUlIg4AEPE2LYR20=;
  b=TFa6AdumkvkZgwfx0qkmfuZs0x3GRhHpshtzmb0/jRDfyNmpDQ7Kir55
   G0EeR7YAe1EBrUkJ6pKNDmdu4jaMqpN/d1YlpAJ/M3jqacH8ORLpXCvpK
   AVLvqrX2JxJbiiKh07ixlpXtnE8P+si4ZgIwkH9PkYUD3qnJtgC1y5bAp
   STVOxbYbk9dLQpnoxXCeoM1iA3W1+RC8y6A3PhasB+b6tsxStzu/azh+s
   Tt0KpTP1C0p47CLPWWHV4DCwfXt0o9O5DVA8OVyx4LDzIR4v2LxeOTtEc
   +Sa1xPOsOd7Ih0Ue5EZEzkPlCgzH1UPwdOg0UOX9sbxnyiVgA776BdD88
   g==;
X-CSE-ConnectionGUID: rhjBh91USDW7xPnc9j/CqA==
X-CSE-MsgGUID: BJjAbf+ISHCdEHfLh3+Wew==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17619219"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17619219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 07:45:02 -0700
X-CSE-ConnectionGUID: ZmcCDt3CRH2zKwkkkYWOdQ==
X-CSE-MsgGUID: kW2Pw9JbRhGAGk7K0oQSAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="46894299"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 07:45:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 07:45:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 07:45:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 07:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5QbblhSnQ4kzpn06VR9pvN7nZufj5erzSLp9EEq77EilC42H8qRoGN2OSGY3sj6KjpXyHeFMJ1czH0C+t5muIEC2ddLVn/ExxVHWFVhG8EjNShslI2jIvLnRdvQyN0BXeXAZXx1JQYf1TxAhAkpjUrNvyKqL0fMUiijZbXFILR7dzsJov7CKc6iaNQYNcAZi5dZNCXQTiP4wSDu+xm0/XR2tlM+HZrcnSR031Gr77Z8B6BFN06pPw3eRlE4cFgnx0Cf3GijSSH0GlRJcmEAiv7NUVw9uqwGcXO8Ak5Ga9/Rg/rXNMgyJqVUeHgdePZtJ587cC3ORiDDPIuM4clAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHpjPTXQJ3mqpu7yXI7NS42eKbIM3e7jG634pl9aC7Y=;
 b=NOvNRWBd8pl+Js8ekcWSKW0atoHEPfw6IhwcaZlVl+k+dh7GT0WxUNBflCeQk/Qkd0Gnb5t7CliplhPrP+LKpd+v1xrWs1IiJ4GJtbz1A4acztrMelNfN56OVqWRVaL9FLuBt/HeUg80xvWA/NxOWCbh4zEhSWR9dzj+T3Xdfn7bRGWR5ojG4kZBin09AmiTQnt6KKZxEDfvMDWladbQlLFRj9nzOg3k4Hj+/1AeNA2JiQw0dJZ0TCWWBlcilFRGJv81fsHf2fplDQJPLOlktQuPg81yPVqPzmqjv5saN2flriipmFLb4Q2a1i4vEwKLSI/AYhiElBIoW8sM2QePgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 14:44:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 14:44:59 +0000
Message-ID: <9228de90-7698-47c1-8d6f-1f19bc075385@intel.com>
Date: Fri, 5 Jul 2024 16:44:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Johannes Berg <johannes@sipsolutions.net>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
 <7eab05e6-4192-4888-9b6a-6427dc709623@lunn.ch>
 <09edde00d5d44505b7a41efdfb26cb16d0cbdc59.camel@sipsolutions.net>
 <98fe3c75-6916-4f93-ae7e-be80e60afebf@intel.com>
 <cf5e8cf7c06b805fe354a69b306155a7f517d1a2.camel@sipsolutions.net>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <cf5e8cf7c06b805fe354a69b306155a7f517d1a2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0191.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: de0b2a2f-0702-4b61-b023-08dc9d010b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUpwc0dJaVJySzFTMG9sdFhDMWJsalF0U2JwbjJsc3N5MTdReGFxbG1RV0VB?=
 =?utf-8?B?MFlMc1cyS0RYbW43Tk1ycS9RcVZEa29kR0c2SWVsTTFjQVJQVXhKY2tESmFJ?=
 =?utf-8?B?cVl4VGJiQytMelFrbzU1RW9ld2g3ekFTaVR0eFVpRU8yTTZCUVVjU0F4UURJ?=
 =?utf-8?B?Y3FsTjE2eW9TK0VCa0xGcDJvcXJHeXZDL1ZmSkoyVFN6NUI2SzRCbm44SGJW?=
 =?utf-8?B?SXMyQkZCblcxZkVUajJZT0hkRkRXM0NCTHg2ZitaNTJHVkhOWlRXWkVvWita?=
 =?utf-8?B?SFNPd29NNGsxNmdMN2xmQTVOY1htZ0lOOXQxQU04bDFGdjU3c01jVjlMajVQ?=
 =?utf-8?B?OG04RW16WDRDOU5pUzNRMUlVZlRjblpDZUtKbDFPMWNIeTl1Z28zWmdxdFRG?=
 =?utf-8?B?MEJqQVN5MzdIdDQ0VTRXRlFpc0ZObmhtZ01GMUNwRnFwam9sLzd0dU9Ldm5F?=
 =?utf-8?B?UDl1QS9LYkpTSXZqSXNSUnFhbE0xNG5UR2k3ZGVQNXRoc3lOaEM4dGR2dDdV?=
 =?utf-8?B?THN6cnQ3djNyL3V3cnlhRVUyVE5FVVV3dUtCQThwQTdLYmEwclJPVEd1YmFr?=
 =?utf-8?B?aHZwVGRzMXR3ZGV0YWp0YjdsMTJoRFlZMU1CKytGcTJRT3Nxa1RCcFRnZUFp?=
 =?utf-8?B?MTV2ZnVLdko2ejM3dUx1TTFPRHFlbVFldUY1RmtqdnFsOHhWbXBjSk1PbER6?=
 =?utf-8?B?ajhkMCtwQmZKWE9WS0FHV29xNHRGK0g5QmJlRjlpRFdMWVJEclhtK2JWMnhG?=
 =?utf-8?B?NVpiTjdzSUdnaW52T3Q4ZU9hMytEM3NuRUczYkdkOXpGVXJoQitYaFJsdGVP?=
 =?utf-8?B?RjJOa0NnQ1c0bDV1aEsyd3pIUm10L0ZRSWcvQTlXTGIrblBxY3Mvb0pDdG9N?=
 =?utf-8?B?dzdJNVdhSUh2T3JrYnVkOTdzZDdJR3Y2TUtWN0NiU0VkQ0x1TUVtZU1hQVJP?=
 =?utf-8?B?Rnh0ZnFOaDluZzNjVEJqeTMwQ1MyRDNGQm5BWk10QytPM296Tk5CbEFsUFQ4?=
 =?utf-8?B?SWExSGZiMWdwWVZwc0N0bEJGNmtCSzRkZmJyeDNWWVRVS3NVT2RvZVcxTlZG?=
 =?utf-8?B?WldiM2pob3djWHlhanNGMk5pbXJJMVY0cHRYdTJMdlNSRWhpWHlHQkRsakQv?=
 =?utf-8?B?OWRXT0FMUzdqZklPYXg3RUd4Yk9USTZUdmMxVTFxVVBST3laeTN5dE0wZXNP?=
 =?utf-8?B?bGV5aEpuMUQ4dUtQTjlyVnRQOXo0RUFXOHVBM0xwdit3QlYvUTl3T0FPREFY?=
 =?utf-8?B?TWZFZCtYbG9GZExWTFZtTVJFaXdGZm41OFlNOEtscDc4U3N2bFc2NjE0a1Nk?=
 =?utf-8?B?eDU2UFphck1VWm9pWVRYNjJ3ZksxQmRSNUlwLyszYnVoZnRLbnNOVEJobnZr?=
 =?utf-8?B?dG1pd0RPdDFkU24wRHFDVGljZ2JMSWkxcHZ4aEcvUHcyTTIvMUl6WUNqVWR6?=
 =?utf-8?B?TURCUGorSHNqSkhkaStmK3QyTjZsb3lkL1dSYmpwL1NKRm9mT3dBbFpLa05u?=
 =?utf-8?B?dC9Yd2YwWkx3aTRUek4rOUxtN0RVVWFMMUJkZjNJYy8zdkVtMDFkdEo5bk9R?=
 =?utf-8?B?UEQ5RVlmaWhQWTlMZzFrU2JCbG9zL1FJczRTQ3hSQ1VCVXk2Wkxjek15N0Zk?=
 =?utf-8?B?TlM1OUl3YXJwNlU1NDZWUCtzai9sQ3FReUw0RTBUK2dRc1gwVC92SEJjWFJB?=
 =?utf-8?B?L2I5R1VOVUVZVkxWZzNLbGZ6UDhaV29lWEJidGVYMkljejYxM0NiZ0dFbXhE?=
 =?utf-8?Q?fctThGc3z6IAAEbqvkhCAWiG/xyelRyvL4ef0LC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9yWnZSUUpwNjNPazhISi9VN3d3SGV0N2J1Mkxwekd3MU1NY1RkeUZCVEtE?=
 =?utf-8?B?Vy9maTJGK1EwemVoWnQ2M3d3aFljMGd4QlJNWVUycTF4UlM5TElKNVZ5aE5x?=
 =?utf-8?B?TlRlWDBjL3NoK2R3Z1A0Q21OV1ZUb1A2MDQ0aUp2OVg4ZVZ5UFBuNFVPN3Vp?=
 =?utf-8?B?U2lHb1NZSElGMHRRbkdPazZUYVNVdlJuL1JTdTNqci80bysyYUF4VjdMem4w?=
 =?utf-8?B?ald4eG5EMEYrM1RJMVJMSENYSEFPMmo3eEtDRm9mMzZVbDJJcG1sOWU4R0dT?=
 =?utf-8?B?QVI0dEVaSFV0Z1JlRWhPaXcyK3FBMllyY3AzcGRBWEtPTGE2UFk3dWR6N3l5?=
 =?utf-8?B?N0NvZmY5VXpTb3Juckl5REJPYk9CZWxFYzlIalo1MFQ5M0h5K1pMMUpVUDha?=
 =?utf-8?B?N09iQzUwK0lUbE1QWVNhQmZ6dGVONHZtQWpBU1hiMzQ3dGRJSzFDaXZvL1Rx?=
 =?utf-8?B?eUZjL3VERHVBMVhhZ1ZUTUhLMDh5QWhtcFFiaG83d0JjOHd3cW5xWHkzRlh5?=
 =?utf-8?B?cVBiQU5UQmIyUi9HZTBLRE9sYTkzeFZjeVFSbnUwMmxNMlZHZWR3aUR1UmRq?=
 =?utf-8?B?TzlwYUtTMWprSTlXMHRYeGh0cHVJZmRuQ3d1TTZkdjhCdEtBdnRWK1pRWkNY?=
 =?utf-8?B?MmR2Mmp3VlcrREtVN1pkZEd0MW1vSWVIdU1CMmQ1UWtaa25sV2VRMGlXWC9p?=
 =?utf-8?B?MUZlRmR5bU95MUFlV3JJdlZlcEt0VW4xM0h6SEJRWkJzZWZaOU9BUjM3ODUx?=
 =?utf-8?B?T0t6VnJIemhBSTlpd1VQTVI1eWpzZ241QUIyYmdFbFdSblpuT1YrNXVwN0hE?=
 =?utf-8?B?NDBsb3BwdnpmYWROYzlERGtDamV1cC9zY25rSHNucUZNVVYreUlHWEpkMWhx?=
 =?utf-8?B?VFhPK0lMNk1STW5HWG1zSVgrVFg4QXFjU0JOY1lUSDFWU0ZBRVhFRHh6K3NN?=
 =?utf-8?B?blE5M1I5Ukl1S0ZteUxhNEV5WjRCZlpHZ0NtZnlYUDd0TjVRamdxQmd0WmNu?=
 =?utf-8?B?cHl2ODhEZHNhK0ozQnVYMmU2eDV2T0JsNTdPaTRIUS94OFV1QklCaDlrdzBM?=
 =?utf-8?B?UVM0NkZJanR0bmxEUm53ekdKU0I3ZThCU3hSb1EyNFNnZ0szSzM2cCtNVmk3?=
 =?utf-8?B?UStZYkpuenhCcGg4YnhUeWtCRFFkQWdKczl3SVpDSHdpSTNocWRyWFcwRUFK?=
 =?utf-8?B?QVh2MllLVWsrS0paRTdxYzJ3Mm41K0pIQXQzaWdnU1FZVWQyeHpNQ3JSN0p5?=
 =?utf-8?B?dmdJNjFSZFBlazhpWVdKZUs1RnZycUw2WXIyb0phWXYyNzg5SjhzbWg1NzZD?=
 =?utf-8?B?WFFxODNyUmM3a2ZWTnVPcCtkRmdrQVlWWGZFTklackpSekpoMmRYNGtPaFZk?=
 =?utf-8?B?QXVEc3MvMmdjTDhGWFNFSXBRNzl2ZW1XUkVGWDQzVXJNR2V0WERObU80dUcv?=
 =?utf-8?B?d0QxTERmcVpFV0czM2g1WGtuemNMLzVDNDZ0M1FwTGNWQXRnd1E4VkZEN3VJ?=
 =?utf-8?B?VzdtVGZSeTdUNVRuWjdWLzcwVjhQZXNwWEhxcW1ndVJaSU8vTjRWRzNPYXVF?=
 =?utf-8?B?elpUbyt1N2I4bG9iVjl1dUpOdjQ3bUIzOHVwTFpGQnV6Ulk2NE9Mbll4NVpG?=
 =?utf-8?B?cFkzbjhNSFpvMTY5dEJiQnZkaHdqOHdHZUdpejJwWXpVdWlHdkJTSWNLbERk?=
 =?utf-8?B?K2lQVStsUHZYZldBVkt4S3c4bmIyNjN0cVdDSWVXTXRtWGRCYlQyKzdsOVEx?=
 =?utf-8?B?OCtCZnpoL3FlR1ViQ25FZGIyQ0FKdG9TY0VYeUVLdmFSeFVvVjczYS9ZYW9h?=
 =?utf-8?B?VzROb1lwQkpnaSt3OTl2N3RsaDh2Si8yTXp4MG5heElHd0dIbElmdnVwU1Q2?=
 =?utf-8?B?RGptcHk5cXc5WVpmTllCTXdnd1lpSFZnai9xTDRjTFRZS1JNaUhYS2ZnZ1Z4?=
 =?utf-8?B?KytzcTJ0NWNWRFZkV2lwUlNySVU1QWE5bEJUMXd4NFJrZGh0eGlNNkw2OXUv?=
 =?utf-8?B?bVdWTmF4NUgwVVdDV0ZUWUlqMHRjeHQxNzFPTzN6Y0FrMFN3Z2NxUnV2eCtF?=
 =?utf-8?B?ZEZPT2F6dFpSUXM4dGY3R2MrREZRWkQ1aUZBMkxLR3NTZFVuTDB2UmY4eWRu?=
 =?utf-8?B?clBQQjRwRTJCWXpzRkdYd2JOZlFOTTJFMWNqVndrdUVBT1NIS0xYRzN2SkFU?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de0b2a2f-0702-4b61-b023-08dc9d010b4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:44:59.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0u9HqDTmWkaymzt2qgPbUndD1q/a0gNVZE1dZ4XqqNJlJdLjoM+EcI93nxhagRGUPazDGB/MTejheKeCM8VdpvHZfDGpvyqvCbYCga+u3Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 05 Jul 2024 16:36:28 +0200

> On Fri, 2024-07-05 at 16:33 +0200, Alexander Lobakin wrote:
>> From: Johannes Berg <johannes@sipsolutions.net>
>> Date: Fri, 05 Jul 2024 16:23:43 +0200
>>
>>> On Fri, 2024-07-05 at 16:19 +0200, Andrew Lunn wrote:
>>>> On Fri, Jul 05, 2024 at 02:33:31PM +0200, Johannes Berg wrote:
>>>>> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>>>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>>>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>>>>>
>>>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>>>
>>>>>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>>>>>> be intended, so fix that.
>>>>>>>
>>>>>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>>>>
>>>>>> "Fixes:" tag?
>>>>>
>>>>> There keep being discussions around this so I have no idea what's the
>>>>> guideline-du-jour ... It changes the code but it's not really an issue?
>>>>
>>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>> And ... by referring to that you just made a guideline(-du-jour!) that
>>> "Fixes" tag must be accompanied by "Cc: stable@" (because Fixes
>>> _doesn't_ imply stable backport!), and then you apply the stable rules
>>
>> The netdev ML is an exception, IIRC we never add "Cc: stable@" and then
>> after hitting Linus' tree at least some commits with "Fixes:" appears
>> magically in the stable trees :D
> 
> See, all the policy changes are confusing people, but not adding Cc:
> stable@ for netdev is not true! :)
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#stable-tree

Aaaah, this was changed recently, right. Sorry for confusion :z

> 
> johannes

Thanks,
Olek

