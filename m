Return-Path: <netdev+bounces-200651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFDAE67E3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E358C7A3959
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4D2D29D5;
	Tue, 24 Jun 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwocyhSs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063922D29AA;
	Tue, 24 Jun 2025 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774229; cv=fail; b=QTkWbsqjHLhNMJ/f2VjpGpMt5L0URB00tRr/oyad3CG+myFjftzJ2Z1vJ56NyExKjfV+HItYfYjHx9sBLQzo49lshaYLp0qWejzd113YvIs8W2DRm/qxlGNSWT+O+YSn4vvXiX4RhmV3mDA0zfSOc7cACjlRVCoVV+s1z9eGhdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774229; c=relaxed/simple;
	bh=ZrBRckQp4OilZ6u1kuJ48t9N69OZFktxg6JqKFdPFWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WO5NM4PcmoW4XChkHs7CDVvoAN27ElGFgUR0UTcqFyawWAkpR/ySjMaUUm7BY5KC3ix/LCzL7lRFqAv2Z+5ytN3juZnjBm6z3TXTGGZZ8XxeTRCzY6aiZeJfrXSXDAXJy9XCmmb2WSWbTd2yAOrfd5qvESe6K7H/6xXuJ/jixCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwocyhSs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750774228; x=1782310228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZrBRckQp4OilZ6u1kuJ48t9N69OZFktxg6JqKFdPFWs=;
  b=AwocyhSsNsDpCoKOH6omx09gZUJSel9IO3wQRHPNFPrfhy2u63c5AuSq
   dseSTkZSa2VAF9+gURR9uqONdGSpzsTxL8Y/ema0s8r8QzKzl0NxMnd1n
   b9Czz8Izdvwdq2k7vaHyGrGSzBuksnmLIIhx82tuDsOSpd3aje0FWwWi7
   gUTMfsiPK4vC8iZreB0wXp0oEM4uyZT3c33koEGyHgJDDXH5VLKbLF2oq
   OkZxCu2XTgeg5xTqUQjx+Re6qSJ9pIHfTf/QkHeNGL9xvqd+0+TbYe8Lf
   qoGNDWnhZ51d6nQ8VSt5L7iDPjE313ToAJ+VoJOBJj1knfomqF0lUlASr
   A==;
X-CSE-ConnectionGUID: NF5tHz/6R9emKr6sSQ/Omg==
X-CSE-MsgGUID: rGvy4Ji5RCaAhMKylP9zxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52737834"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52737834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:10:27 -0700
X-CSE-ConnectionGUID: bzJRxrzIT7KPi9s3487nHw==
X-CSE-MsgGUID: sXH02gZTTayLODa2ScLgng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152629932"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 07:10:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:10:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 07:10:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj3Nka2Yd27E5jKqun9+83ycWtMFoTa1g/KIs9rjBysA1lZyQiT+TjhW66uL/fbD1oKeqqKiFIuQwmjWRWFkYFymyu7q7ke49rCEoVXAyFm1ZwaXydbAAZDfyYaqPwngmTfn41zN3Xv1cHI64pi8h1g7XlSUH4P7ma5AjqDQ+Lkh2bSDn5NLTuXlsPLdjwFjfwpa/oq1ZPFFpRj3rSbjLk6yzbxOrBQhLicQAFaNUo7FOMpnPVV7JtJzFLeHKmcX5LNtLU8zCO0UfHpof2HyClrIxJqcF5HUc1qvH8h5MX7m5YjbUbQUl7F3ycAvi6CM1nEy5g3R2DoktoTr4DIfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkUPG2bE52NCEKXLgCGw2Jr3D3q+AmHCoZx27B9BHiU=;
 b=urISh6qZXb5SNyeyjszCG356Ts5XFnirDIWWRpAhFsrBkOv1FMhB5ZRZSC5tRNBSQ6a1LPUlmAjPsPIMBSePeNRFzIgl8a6gCezBMTNw7HGbrUNdY31ONH9RXTUQQ9+YKE1TSYL5o7xYgX3KSa3PIXRFcaeGD9iF5k4p6tMTsS4akEI6lAIz4CLP4yD+IEkMT6tIZiiIgzRcY93QwXe/w4I06Vr1LoONkBstX5jyJNFVOn+Req+6lMqMRf9a7KlqLoETUD4HhTsRaN0qXQKqXPBwIJ4f0LaRHEVdKoEKLzsp3l7/dqxxAWw/9WKh25So7NBoQ0on5Z1FWEuqnSrUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:10:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 14:10:11 +0000
Message-ID: <dc2d8a33-644f-4f45-af59-04531e40a79a@intel.com>
Date: Tue, 24 Jun 2025 16:10:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] [v2] ethernet: intel: fix building with
 large NR_CPUS
To: Arnd Bergmann <arnd@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Simon Horman <horms@kernel.org>, "Dr. David Alan Gilbert"
	<linux@treblig.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>, Slawomir Mrozowicz
	<slawomirx.mrozowicz@intel.com>, Martyna Szapar-Mudlaw
	<martyna.szapar-mudlaw@linux.intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250620173158.794034-1-arnd@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250620173158.794034-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e597251-4eeb-41e5-f18a-08ddb328d4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmFWcWthQzdPdTdNcEhndUFrR1JYKzIrcmE5c2ttVDJCak9pSWdEcWIrb2ph?=
 =?utf-8?B?MVdXR2wvZWZOVHptVUpaS0tpQ0dreXlxaDlqb1VJUkVibWtTZlJuWWxjSjhL?=
 =?utf-8?B?T1VMZ0daU0RCZHhzcUQ3Y1ErU1lLc3o4cnJnOU9lbWRRaXh2cW43RHlOL3pn?=
 =?utf-8?B?QzZ6ZXpIdFJERFQwL0NHdmQ4UGRSU1RoU0Z0dnpYZm8ySk9uK1JFSEZrRlAr?=
 =?utf-8?B?Kzk5RlF1YjRyOEJITXozWFNacmtpZ3Nkc3hmTU9GZWQ5bGM1VXZJcCtYTDRJ?=
 =?utf-8?B?UUV5UTBUSEhRWFZjbktLR2N1QWJiOENLeGxWSkVuWlQ2SXRHWEtnczdmb3Jv?=
 =?utf-8?B?K0E1Mm5SeHFnSC9MU25nMnIvSVV0c3FEcDVWZ0EwcVBScENFcFJDMzVhRFM1?=
 =?utf-8?B?b1JWUWZjZ3laOXZLSzE1eUsyNmxYTzNFbEI3YUZoenpUQ1ZzRUhMdXY3Tndi?=
 =?utf-8?B?cm85NSt6RGhTcDYya0NUaldBdzVTeTZHdmE5cUJ2YkRBaXF4dGxjL0JIb2Nl?=
 =?utf-8?B?L21aMHFyQTl0ZDZNS1BDaVFPclpwYkZkQW1yWnpEQ3l2U3piT2tkOEswcGFn?=
 =?utf-8?B?VlRJZzE1OGFodTBZb2RoZlY5Ti81bm4zV3h6bUZ2THVtaHpEei9Gc1FPZEJw?=
 =?utf-8?B?bjJWUTRhK2dzUjg3VkluZDFxWkRaTFhOU2Nzcm56S2diZTZEMjhiZU9rOTFP?=
 =?utf-8?B?S2dOdVZZUjNHdW9pQ1JLUUpjSlE2VGI3Q3NPQ3NVMUFkZkVnclNHNm02d05p?=
 =?utf-8?B?dS90WmRHc0J1aHFnQkZTUG9Ya0R4bGpFUm85dXQwUnZNRGk3VXFwREw4RHVW?=
 =?utf-8?B?dGRvYjBuZGhhMjVHWnRGUHEzQmQvOCtTNjY2VGNabGRFeVJXdHdCcWFIdTMv?=
 =?utf-8?B?djdxOXBITDc5WUNwWXA1b0owV1NJWWRZN2dKRzVIdm9TUlMwN1NRejZoUlEx?=
 =?utf-8?B?cHNPNzhxeHhMM3ErVk5wTmlnYzRuTHVFMXZtN1hIajRIdFFHeXE3WlN0WE5M?=
 =?utf-8?B?RVRBWC9meExMcXNMS05Pek9la2NBWlg4VlM3cytyOE9CTTFUQXllVkdiQ1RX?=
 =?utf-8?B?YWNwWmZ4cUxlclNSZXZMYXM0SVBBMDc2aFROM0FaNFpBOVdBZ000Y1BvcHNp?=
 =?utf-8?B?MmlGODlhT3UyQXFDQUFLUVJNclkrRXpuZGFhVElQakRzUjF1VTI1VDV5UjNP?=
 =?utf-8?B?cDFHSU1jUHl1QzRTbXZRSm93M3RpL2w5YkduNmd2ZTJIVDRSQ1daZmh0VVU3?=
 =?utf-8?B?UzV6VjJTVEtJdnVzY3FHTTJVOFFnSm5odGpZeWVPRTBrY2R3ZWVPOUpSRHZJ?=
 =?utf-8?B?aC82S00rcThkVzVHeFEwT3hpTHdmdGlxcnJ1N2Nwd0wyempSS1lqUlIzbFlD?=
 =?utf-8?B?ZXpkbGs5YkorT042VFpLS0Uzb29tTGdYRVpFZitxa1haQVh3Yk5GZ0MyQ0Y2?=
 =?utf-8?B?SmpZd3k0bFBoQ2hkelRLOWdVMmFVSXVJNStRTWZzR2JHRkQySGw2OVZVSitQ?=
 =?utf-8?B?ZnJVajUxRHI4TFhDWjlGSTdvRFdzdWJyZlpIRzdOZHhYN0J3Ty9tUnZIUXZo?=
 =?utf-8?B?bmhGdFpmUzJRNmdKdFVGZENZTWVRVC9DWXZxemFXVThWb1A2VHcrWlRLbmdZ?=
 =?utf-8?B?SkdxdDdJSmp1eDkydVRPRElyOXdiVDJ3cVM0akpKZnZIbDVvMmhiM3lZNVVQ?=
 =?utf-8?B?K0gwalZpUk1HZVE0V0c4Q3lUMWJRdDZ4NEROdm16YW5KUEU3Tk84ZVNkMXRS?=
 =?utf-8?B?KzVmT0JkNWdrdXVtditkK3VTYlp3MTJJVW9sL05IMW02Zzd2YkwvQmRuRGE0?=
 =?utf-8?B?dTdCS2UyN0VrTlh4bEdkdFhJUmd0NHdBTUJXbnJlakF5cTFXMEozcnJDMXFz?=
 =?utf-8?B?MVVSUnMvazMzSS9mL0pCT2FZUFhVeEN3MzllbUs0QlhiczN5ckk0emh0aVFn?=
 =?utf-8?Q?M5d5Wd+liuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmUzUTVlZERhRkVoRCtvYTVoanFROStKaGdtaUk1bW9MK1kxcGFLUU4wUXU0?=
 =?utf-8?B?NXdqaXk5Mmd3N09nY2JZVkcvWlgxSmtCUzVwN1RuaFVqUXZ5NHpwaGlUaUhP?=
 =?utf-8?B?K3ZiOUlTUjl3clhERm1VUHM0eno1c1o5SyttTnJoYTUxVm5mMnBYQzlkenAz?=
 =?utf-8?B?MkRoK3B3ak43UCt3T051djlkQzNwWEdidTlLZzY4YlhyZkMwM0RkbWZPQVdo?=
 =?utf-8?B?Q2FLQ01lV0lva0Y1aVZPY1J6dDNOZm11UlY0SFg0S3VnZHp4QUUxVnFlK3dw?=
 =?utf-8?B?TlhGMytkL1RhTTh2ZTF2VThNR3dDV1U5TVFHNmhjNXQvYmw2c2lyWXRxdFVG?=
 =?utf-8?B?VzdPeUpKM1dIbEJEaEd1ZU9HbXpnYTJ3ZkM3ZU80RFFTNTZ1OW9EQWZmelFi?=
 =?utf-8?B?b2lUUHdnQmF2ZUhQNkYwTkVzTkROL2UzTmZHU1BrM1FTelo3RENyR0FVNE5t?=
 =?utf-8?B?SkFiZC92UDFHTVVwbm51eU1RR2F6Wm9KT3pIZktqNkNCMlJmTWRPWVI3OWhl?=
 =?utf-8?B?R0gwUjROc0UyTk5OcGtLTGpmYW11SmRkRHFvTlVnaENoZUNISUlFUnlkQzQ3?=
 =?utf-8?B?aUVRVDFjdS9mZTFHRmNaUFNpcytRQUx0cm5hWWhYZkYvd29iVlBTM29IZWRn?=
 =?utf-8?B?YnZUU0cyby9OVTcvVzMvUzF6VGF5K3VWWGRBTDFMb2ZMYlFXbTR4UUs3dEln?=
 =?utf-8?B?TnI4bGNseXlicVJ6SzZsRmtMWnJWSUZWS0F3eVk5eGhwQThqdGtMVHRNL2s5?=
 =?utf-8?B?SFNjeUZ1cUwzZUhjdTc3N0FENTVuSXJzT3NHY0t2TGowREtpeE1HWVU1Zllp?=
 =?utf-8?B?aVpQbkZ5Qm1qMlZBeFMvdjY4RjJxQjYxd2FBWnBRTlRpTm9tK2UyOXp5TXRh?=
 =?utf-8?B?b3BNZEQ4Wi9JM2dnRisrczM0b2Urdy9ZSmVBNWdKbVlqSnhuU0gxOE5kdWg5?=
 =?utf-8?B?dExMSEkvck50SmhrYk9BS1ZCWG15WllFdTFyZFNLdHlKMTU2cTN6N1VzU3Na?=
 =?utf-8?B?Y0pjYmJNcW01MzFFYVdwdHFFMk5aZldmQU5tM1l3dm1MYVlYdFNocDY1ZFpO?=
 =?utf-8?B?R2dacmVoaDBUandKUGxpcW04R053aG1PUW5BRzRrVEZScFR4VlVOYlo2Y2dI?=
 =?utf-8?B?OW4vNmVqMXpaeTQ1bXo0eVBubVp3SWdySWo2TGU4R0E5aFRhUFEyMmt1RjVJ?=
 =?utf-8?B?S2ZqZmk1ek13VVNtR20vTHA2b28yMnA2Wk1NZE9OYXpGV25CSEV1eVV0RkpO?=
 =?utf-8?B?aE4ybENkdHIwWEk4MHZGeTBpQUgzakFkTno2RjFZbG9zUEVJQTBmd0xRSkJU?=
 =?utf-8?B?RTRwUHNUK05MM1UwL3RGRTdIbWxld2YrcG4zU1lreEg1VFBMZS9YZ0YvL2RT?=
 =?utf-8?B?N3ZERHNHV3pFVm1FU2JZcUdsY1Y2OFpFK21OQ1Jsazh3czIxQUEwTC9ZeGY2?=
 =?utf-8?B?SGpvemdjSjBDa0ZrZHg1dWxIY3M3K09xR0M0OEdCY2x0clFZWko1U3A3dWE0?=
 =?utf-8?B?UkVBa1VyTnY1dGo4dzRNSTRvZ0lVSHRrdk5YazBKVjF5K0M4ZEorc3Zrd1Vy?=
 =?utf-8?B?SzN6T2VyUlYyOWhHYnh0TENlRDF5d3VKSHpDbmlqVGlUUmZOMGRNeEsyTm1q?=
 =?utf-8?B?U1Uyb1FQOUF1ZzlxOXl5Mm5LR0NaY2phMENUd09zM2U3eVZwbzFxUzVNT3lr?=
 =?utf-8?B?amV5VW52S2NwZHZTMTV5M2d3SmpjREJ3d082REU3b1R2OWZxdkF5MzhrYStz?=
 =?utf-8?B?SUVUeFIrMFUzQ3QvYkFRNS96Uis0NnpOT2V6bE9RL1poZ2ZQUFE0N05PRGgw?=
 =?utf-8?B?anphb2dsdVJlN05jZkR2Vm9YUTJ6RzJ0WEowWGFzWmVQS05VRkVYNk5rYW9R?=
 =?utf-8?B?ZzJleFFqSVpTa1JtbU1ieEdIMXZldDloN2RBemJCV3d5TmtIdzNDUmRYQ0ZT?=
 =?utf-8?B?WjZ1ZjIzSDVkRVBZamhZOG1MTHdWeHlpYm1sUkExSlZ6cXp5MStTZzlMaWhE?=
 =?utf-8?B?Z0xQZlJXb3lRM3RvdjZzQUpuY3BmR2wwNHZ3ZEtpbElYemlXOHVuck0zbXAy?=
 =?utf-8?B?d2NkVDF6VHFaY1pUcW52b0dLUk1pYm5KcVY2c3JEdjIyRzdoQnYvaEJ1TVF5?=
 =?utf-8?B?MEp2VEI1Q3ZXVG9ZQ040RXE0MHRPZUJMQXdtRmJnUFgxc01jL1k1Q0dpMmN4?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e597251-4eeb-41e5-f18a-08ddb328d4ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:10:11.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1PVfQlmRe+VskPsCbsW9YvtZg2biYeZGt0FWpTmSqNyrSn2kFhhL9B9MKHKy5iRTVYya1CAIFRqirWZmdT8B5BEnxhqzuFZOz61vPd/5KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 20 Jun 2025 19:31:24 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With large values of CONFIG_NR_CPUS, three Intel ethernet drivers fail to
> compile like:
> 
> In function ‘i40e_free_q_vector’,
>     inlined from ‘i40e_vsi_alloc_q_vectors’ at drivers/net/ethernet/intel/i40e/i40e_main.c:12112:3:
>   571 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> include/linux/rcupdate.h:1084:17: note: in expansion of macro ‘BUILD_BUG_ON’
>  1084 |                 BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);    \
> drivers/net/ethernet/intel/i40e/i40e_main.c:5113:9: note: in expansion of macro ‘kfree_rcu’
>  5113 |         kfree_rcu(q_vector, rcu);
>       |         ^~~~~~~~~
> 
> The problem is that the 'rcu' member in 'q_vector' is too far from the start
> of the structure. Move this member before the CPU mask instead, in all three
> drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> v2: move rcu to just after the napi_struct [Alexander Lobakin]

Thanks!
Olek

