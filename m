Return-Path: <netdev+bounces-215909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B91B30D90
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C5B189342A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6E28D830;
	Fri, 22 Aug 2025 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FqAJJnIV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840EE28CF49;
	Fri, 22 Aug 2025 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836682; cv=fail; b=cHs9U4vMRqi6MdykKnWJgIIG/dgMdWScHY8lU6gryre/MfJ9aId84OBki8QAkakntvXGf/9NHiXwInyBaRTBFhev94hKuZ7fB2yBjoNKd3AK8153t7r07MchHGBa1s+EJcxfT62y2m77rtPHa4Leiq5gURQXA+LaPWGOf7dkkVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836682; c=relaxed/simple;
	bh=d22V3BNBq95G9xuSaQkeTmuTMSUJ4w1Ee+Nd8eZWGZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nx9e9HBWSxat+K47IaWgw7EgXwWYMGII+n2frbqSzvm4KQxnt2Reo127LdUD9xpNqMnYen3SYiXEJMXgdoR2T+llGjki+Conu0MuTs88UfyiqvTv4en09RdbycUt9zlA0cTzJrlyQGVOammwDsWRKrPbAT9mnkayq7eFulyXpTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FqAJJnIV; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhnN57PhII5xHSccrNrjyPtWkJJ8eMTiJcOWqXWk0AG4ntnSwRETCkote9NuU3i+7y8VRnHXyExICdRkVJc9d9D3HOjMbocIwlFjVl6KWUyDt/v4eU/8FjOHaV09AvVxBfMNM3nkmuqayCki13hOwBOdxcSXF3XvG2D/7XhNaoIO8Ao5NOLXXHbBemtV5AaFaQsuwB82FWM70+L9Rxnh8szsXhV3Exo3LBqORwDUywSRn+9R/HaieDu/J7Reh3J6hQy5HvIa0NXHZsk/UXBnUG5CH/eyiU32ew49vV9yXXua8BXW3t4HKI/Qj71rmh3kSzZFsF0lHK8zY9Q0K8b6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d22V3BNBq95G9xuSaQkeTmuTMSUJ4w1Ee+Nd8eZWGZ8=;
 b=YpDclRClaHiS3Ue9e4hVG44Calz8vVCKTOoMTfFwFWQYp56NwOXHRyjj2Nt/tV4jfqCeaQivfUgpRpDPahkj8j6t6r1JCTWqcKlxJwg4KzCYL4I5lOapGkeOr8Q/kRPnd6wcy5nk2RLKX3w3sLVATk3ugIpdxNTNprr15z8b3f50I6hJKfRyWaYhJJ96aRGwDWaXutc+Ag36e3KoeVX+833LAhWYNTPsR0Tj7it8nreTVOL4hekJkhMnXZiuqO0mpSOnpJd5mJGybrFpoC41TtIkHaHUXY9UM4Lrd2620jlsW6E97ozwiwt2ewWaxsyGKenxd4yYr8rNh3ccZ6vM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d22V3BNBq95G9xuSaQkeTmuTMSUJ4w1Ee+Nd8eZWGZ8=;
 b=FqAJJnIV3ohO833fLpx+HUdrrY//C6A/EwhG8Wrby4G9YgrahloSEeYbH1PR4ZAC3Z8bjZX9roeANabVT10sPgIupfgYb/7qgpnE6d1F1dXFr5eqXdD+OwOQqk/G/Pfdv4PsAwf5X9B1AlWx6rD4QzoWW01TEo4HhEM3sd1jynPdv8jJqyWPVKRJQD2K8UzssN+TGtPBoJPW8hoIcuibjA7UsCBDslPPYwN/m+REnccVRQanj0d85CHASV9EIxQ/2910OgwkZPm9+Q6xfa1GmXJzyaLRjuI4Z9N6FOSYlX4wDnYfiiahBoNJBPbQopV5OWVNswz3tQPV+NuKB5eUWA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 04:24:36 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%7]) with mapi id 15.20.8989.011; Fri, 22 Aug 2025
 04:24:36 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl handler
 to support PHY ioctl
Thread-Topic: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl
 handler to support PHY ioctl
Thread-Index: AQHcEnWbR+tCBESmtUqmTIms15S55LRtz2IAgABFB4A=
Date: Fri, 22 Aug 2025 04:24:36 +0000
Message-ID: <4a2e6ca1-7ae9-4959-a394-c84aab4b4c02@microchip.com>
References: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>
 <204b8b3d-e981-41fa-b65c-46b012742bfe@lunn.ch>
In-Reply-To: <204b8b3d-e981-41fa-b65c-46b012742bfe@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SJ2PR11MB7453:EE_
x-ms-office365-filtering-correlation-id: baae5d5d-3b55-4057-5c1c-08dde133cd5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHpRSkk2N3JmdUJBRmpBdFp4cU15UUtsRnNlUXVud0FObVEwWVRiRENtYkRC?=
 =?utf-8?B?ZVE2V09NV0pkVjR5R2ZVRU5GMk95NThOeUlod1lvSW9EVHdaM2ZTL1RYT2pO?=
 =?utf-8?B?N1krd0xBTkVQTmY0YkRhd1dmMGI4NmVubXdVNE5YbEovNExMU2traUxaOUo5?=
 =?utf-8?B?QWsrNUFtVUl0blNCSVhDbDM1TDBid1dpMDd0S09ic1Y1bmZTSXJSVXJRT2dC?=
 =?utf-8?B?ZmNWWnlROXJRdjQ1Q21ZMkJWZUd3K2kxS2JibE5DOFZsUjFGb1pCTHZReTdV?=
 =?utf-8?B?Y2JvTjN6cHJZSHRNOS9UNHo5Z0lwYk9UTFJkbHJabEJUUTVjQnN5b1VTTzVl?=
 =?utf-8?B?Uk1WNytFQWFoSFkvL09yemF3a0NRRW9rMlNra21sMzZlYzI3OFNSeW1RYWdE?=
 =?utf-8?B?WkJYUlY4cTFXL3FXS2hENDJoczVxbk5LcmU2a3JsSi92RFZuWHdia0xwN010?=
 =?utf-8?B?NkFQU2VVbFFmaGlOVGtjWHRDaUVLbDhwaEg5dzlrN3F1MVpGek4rcjM3dGVx?=
 =?utf-8?B?c0JGcnA3OUd6UldaWFc5ZmZ5VHl6Q0hsTTM0Qy91Q3BHZ2dOZFlCOGNmZDRU?=
 =?utf-8?B?ZVMyK1JBZERBb1AzbEFhaG84ZGM3UzBVV1JJbmRHcW9zUzNOTnJNd1dtbkEw?=
 =?utf-8?B?bEhDV1g2Ti9XaThnUE90ZUpEcFJuOVNBTWtZNkl5ZVVHTUhTQUovc2d6aVpP?=
 =?utf-8?B?aGtOSVhIV080d2RkWmNCbkxxMlNOK0d3ZTI5Mi9yS0g4YjJpblE4SXRJd2I1?=
 =?utf-8?B?Wm1GbCtnbnJuSUZBczk0REJGSWVaNk9QTW9kM0g3TS9Ea3lJUHNqeGs2eFpr?=
 =?utf-8?B?Qnp0czMzNEdFYjl5Q1FLRzhCbE9EeUpqcUZnVUZNazQ5OGkxQ2lzcjlSeStv?=
 =?utf-8?B?THRtYWFmREE3cDZ4UjUrREZIbzU2dDg4dkJBaGhvQXZsLzVkcHB1UU5sUzRu?=
 =?utf-8?B?WW8xeStORVdRRFJhTi95RHYxYkJrY2o2bGo0SGVxbm9tUFNTV1BGc0JZSlJq?=
 =?utf-8?B?dHAwWStsNGtqSVB1RE5KOTVxeUQ3UGpwT2FBTnhPTnpKQ0d3RWJYck9yV2tk?=
 =?utf-8?B?R29WWGtxaHYrc0J2QzU3QVZZdXFDV0hwcGVXL1hkL3htV3U3aFRMaTBrMldB?=
 =?utf-8?B?cG5wKytLWmdvaE5hOEk3bVB5NHZmdExlOUtZM1F4ZmhwZkRueHVaR2FvdUJU?=
 =?utf-8?B?dGVrY1ZpM3NUTmpwQ1l6citySDZXTXFVRTVmdGpVU0Q0a1lrODlXTzNDejhT?=
 =?utf-8?B?RTZJWHllYnFxUnBLWEJJMXN2N0NaNUF1enZURFljVWFiL3ZNQzdmSVErQUxS?=
 =?utf-8?B?d3hjZUpzMDg2bW1OQnY0L0lVY1hsSjQ2b2dDTW1IQ21CeTE5WjhzU0l0cGRU?=
 =?utf-8?B?amtpVkdSSW83VkxVSlJHcDlNbi8rL1FGWHl2UU1JOU5mSU1MUk1Ta1ZNUHBk?=
 =?utf-8?B?N2FzanloeXNmSFJ3bzRLWFFmdHBscTBianU0Y21NdXVzUWlzbEJtV1E2WUVs?=
 =?utf-8?B?OXFYWDRzaVB2cDBLenVUWnVZQ0wvRko2Q2RCZno3Z1YvS1paTDlMUWdHVy8y?=
 =?utf-8?B?N09TRFdoUHlCVTBaVlhwR25ZNkdZcGFubDBOYnU1NVREb01FZGZnT2hpcDZJ?=
 =?utf-8?B?ZFRRTHZwd0gyOVRkMy81ZXAvNGhsTmh2dk5USE13SHZTNE1YdUlCYWNFUTJW?=
 =?utf-8?B?eUNWSjhTdmpmNCtqSnVmemxVVTk1SHpWZlNnbElLdk15V2I5dC9Ebk4wb2RH?=
 =?utf-8?B?a1FQVEFkeGp4ejZ1eXVEb2g3YVBWc2EzQ3NYaWZ2QSthcHN0a2pqam9TQldQ?=
 =?utf-8?B?OUhsQ2NZTFFTMkhKYXkrTFVEbjVXNTRNKzBpajV4aDdHYWtPZkQvSWF1RWwy?=
 =?utf-8?B?bnpRRU05M1BSNnE5SnQ4TFVLTTZNMjRFTSsrcHhQMzczb3pYQ0U3dUppcjlC?=
 =?utf-8?B?blpxVE81NXh2QUx2R0Q0QlJTc0lUcEpUSjhjVGtFT1FlZU1rS2dWTGhUcjBi?=
 =?utf-8?B?bHVFYzFjMGdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODZJdFJlbkhSZ2QyYkJhTVZyMXVtVkpzaFlsMlM2bWhZVEFTdGw2citZQUM4?=
 =?utf-8?B?ZEh1d3ZuSEYvTWR4UEdqSE9nZnRyWDZBN3ZxTzB2T0hMLzkrUlVPVllxamo5?=
 =?utf-8?B?aWtDeTYrYUlUNUpNMGdnVXU1Zkc4NFRURURTRFVsd3BQZ1RicUhhT1pleUtU?=
 =?utf-8?B?dHRRUFhKdWp1ZTJlTEF1V09qODZCS21tSnZEWWhrNnAyQ2pYYTlwbmpvOW1B?=
 =?utf-8?B?eUw2UzlKOThwdG1wSHpYSzlSZWs4KzVSY1RnazBidkd0c1FwaG0yck43bkNh?=
 =?utf-8?B?dmZya0gxd0kzYkRnZ1J3TzkrV050aDhxNkkzZ3JlVi83Mk8zdTVRYWlVbnNi?=
 =?utf-8?B?WjMvZ3EyeUdJWUNYUFR4bFpuNTVYaTRtUUJUbXBGaW5EZmh4cVpjejJraWta?=
 =?utf-8?B?KzdPd0NURUJ6Vis4WEFPV3M1SWU4cXFqRERxeUtKTUZkR0lES2FGVW5JQytw?=
 =?utf-8?B?K095aXRnb3RWTEZqWDdhTG5TYWdoSnZFUmovRnRPOXVXRDNlbGZ6ZnhxWml1?=
 =?utf-8?B?UStTcTJnQkN6dmt2UWtUdVdsOUNJK3F6MmVmSmRCVzJTeW8rOHM1ZUJpS0FP?=
 =?utf-8?B?R0FiQnFzUVZWR29pa2lTc3g1QjNrTFpPQnRyTlR4bThTUDNyK0RBY3NVRUVO?=
 =?utf-8?B?N29kcGhHeUlSb0d2S0NkYTI0dGsxWDkwcnBSRG1IUHkxMlZyaSt4bHRlM3FB?=
 =?utf-8?B?U3JEVDAzdmlyOHBJSWlaTDZ0YWFleVVldlRIeVVIRHFCM0plWDJ1YzZhRDlQ?=
 =?utf-8?B?aW0wcG1YQnpFUHFhSmp5MTB6cTFqTm85bVR4cE9zM0w2OW5sNUlJNXM3UzRq?=
 =?utf-8?B?dGc5SU9PN3U4MGlNcS90NjJSZzFuUEVwdUVpenBhVlI1Mlo0TzdLcWtVZ25C?=
 =?utf-8?B?TERESi96eVdRTmRIa2czdFBBbXgwVkkwU2ZLK0NSc3hpbG55Q29NTTZiNU9j?=
 =?utf-8?B?UXd1NmdaVEdYYVFXbEZBTDQzMlNVY3l1TzV4bUlqSWVMY0hwaTVtMDBpc2k4?=
 =?utf-8?B?RzBzYnJ2N2crN1dsdkhCLzluNEhPUjBPZXJZYXpMWTlsYjcvTHNocVpEcVE2?=
 =?utf-8?B?VVBES0JpN2NsQ1BqRXN3RHZyaTNSQUxqNStZUzFjZng0bUZuUHRobzFPYXpE?=
 =?utf-8?B?enBWdE5CU21XTFV0NGtwQlI3Q1FKMnVqYkg0ODUrTWlZWndva2tjSnovY3Rm?=
 =?utf-8?B?bGdLcG5uM05ESzFlSStqV29uZG82SExkTWU3enZiQjVuNFNZcWFKUm1INEkz?=
 =?utf-8?B?aE5XZzZaSEhIRkhYN0VFb2hkbG9lclhvSUtLcFV0UWJlbndKdXVPVTJPdUdt?=
 =?utf-8?B?YlhHYWZ4RzkrSTBYTVkrYjZXU0tBZ2lIUDZmc2ZmT2VXaGQ0MlNqTitvcHM2?=
 =?utf-8?B?VXRlU0xuazdTQ0FwZUplYXdOalJiUXB3OVZaZ2xHSG1YSzFlNkUwUzIzMjd6?=
 =?utf-8?B?NmRVcG9kVUM4a2h3VnhDMUZ1cytMYmVsamNPWkpUMlBsdWRDVG9OcnZhVEcz?=
 =?utf-8?B?L0hlNkhHWXhsSXVKaFd2dVREQ1ZQamFtUlI4ektJOTkya1dWREVmUUlndzAw?=
 =?utf-8?B?WVNxNGpRYUpYbmd2Z3RjMW14UEtsWXBEckVIWWpDakpxWDNpTzJDZk1IUkhy?=
 =?utf-8?B?dWk5b0JNR2ljMUdCbmxYVjc4T0JVUU9PQysvTDdSL0ZDV1RGWmpqODVTQy9H?=
 =?utf-8?B?U0laU01DN1R0UjZNeDM3LzlKaWFZOFF5T2Q2TW9HMzhiSHZQZGhWdUdVL0FR?=
 =?utf-8?B?b2tVcDhKcTAvMFNXN1R2c0hZcmI4L0xEYjZnSFZQcDVlN3oyRml4VVYwUUw3?=
 =?utf-8?B?SGlIYStGSFEwK1lmOHlOUUpJL0RqQTVQMmcrSHBhVklZYXJBUEhDZmhldnpu?=
 =?utf-8?B?VWp0aTRTdEtzWmZPOUM2M1RnRzFvSlVkTWJPWnJJSzdEMDdlT2c3dG9EK3Ji?=
 =?utf-8?B?REp1Mm43dUpsanN4d3p4NjUwbXpaaGZKQXJIVDR3M0E3Q2E4RC95ak91YktD?=
 =?utf-8?B?VUxTUVFHVnVFZDBTSTcwSGZEblZnRGlqTk1wLzRZNFlmWGl6N3RwRHpmT0FZ?=
 =?utf-8?B?K0J5RFVlUEVFQkE3MVFlVGFYdEgrU1FvYXZXYzhEQ3dsMTNlblV0dEZBMkJZ?=
 =?utf-8?B?eC9RVGo4WnZhSlRrNHBZM1JYQmUyRm83dmZZSWhhUUU3cVhHdHVyNWFpUThD?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C8E5E43C4DDE4EB4A255B1682F0CC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baae5d5d-3b55-4057-5c1c-08dde133cd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 04:24:36.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMO5RQTXKSSE/OjcjCsslMfGqidCnTOYIsIooAoBcUdeWD/8VqzNOl2cMBrIF7blNIqQyBA8S8SSUcyQJrAmLS51UtplWb1O2zWGovv9wHIxpOTWe1h8i+2jd8MyGUEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7453

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGlzIHBhdGNoLg0KDQpPbiAy
Mi8wOC8yNSA1OjQ3IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIEF1ZyAyMSwgMjAyNSBhdCAwMTo1ODozMlBN
ICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBUaGUgTEFOODY1eCBFdGhl
cm5ldCBkcml2ZXIgaXMgbWlzc2luZyBhbiAubmRvX2V0aF9pb2N0bCBpbXBsZW1lbnRhdGlvbiwN
Cj4+IHdoaWNoIGlzIHJlcXVpcmVkIHRvIGhhbmRsZSBzdGFuZGFyZCBNSUkgaW9jdGwgY29tbWFu
ZHMgc3VjaCBhcw0KPj4gU0lPQ0dNSUlSRUcgYW5kIFNJT0NTTUlJUkVHLiBUaGVzZSBjb21tYW5k
cyBhcmUgdXNlZCBieSB1c2Vyc3BhY2UgdG9vbHMNCj4+IChlLmcuLCBldGh0b29sLCBtaWktdG9v
bCkgdG8gYWNjZXNzIGFuZCBjb25maWd1cmUgUEhZIHJlZ2lzdGVycy4NCj4+DQo+PiBUaGlzIHBh
dGNoIGFkZHMgdGhlIGxhbjg2NXhfZXRoX2lvY3RsKCkgZnVuY3Rpb24gdG8gcGFzcyBpb2N0bCBj
YWxscyB0bw0KPj4gdGhlIFBIWSBsYXllciB2aWEgcGh5X21paV9pb2N0bCgpIHdoZW4gdGhlIGlu
dGVyZmFjZSBpcyB1cC4NCj4+DQo+PiBXaXRob3V0IHRoaXMgaGFuZGxlciwgTUlJIGlvY3RsIG9w
ZXJhdGlvbnMgcmV0dXJuIC1FSU5WQUwsIGJyZWFraW5nIFBIWQ0KPj4gZGlhZ25vc3RpY3MgYW5k
IGNvbmZpZ3VyYXRpb24gZnJvbSB1c2Vyc3BhY2UuDQo+IA0KPiBJJ20gbm90IHN1cmUgdGhpcyBj
bGFzc2VzIGFzIGEgZml4LiBUaGlzIElPQ1RMIGlzIG9wdGlvbmFsLCBub3QNCj4gbWFuZGF0b3J5
LiBSZXR1cm5pbmcgRUlOVkFMIGlzIHZhbGlkIGJlaGF2aW91ci4gU28gZm9yIG1lLCB0aGlzIGlz
DQo+IGp1c3Qgb25nb2luZyBkZXZlbG9wbWVudCB3b3JrLCBhZGRpbmcgbW9yZSBmZWF0dXJlcyB0
byB0aGUgZHJpdmVyLg0KPiANCj4gUGxlYXNlIHN1Ym1pdCB0byBuZXQtbmV4dC4NClN1cmUgSSB3
aWxsIHN1Ym1pdCBpdCB0byBuZXQtbmV4dCBhcyBpdCBpcyBhIGZlYXR1cmUuDQoNCkJ5IHRoZSB3
YXksIGlzIHRoZXJlIGEgcG9zc2liaWxpdHkgdG8gc3VibWl0IG9yIGFwcGx5IHRoaXMgcGF0Y2gg
dG8gdGhlIA0Kb2xkZXIgc3RhYmxlIGtlcm5lbHMgYXMgd2VsbCwgc28gdGhhdCB1c2VycyBvbiB0
aG9zZSB2ZXJzaW9ucyBjYW4gYWxzbyANCmJlbmVmaXQgZnJvbSB0aGlzIGZlYXR1cmU/DQoNCkJl
c3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgIEFuZHJldw0KPiANCj4gLS0tDQo+
IHB3LWJvdDogY3INCg0K

