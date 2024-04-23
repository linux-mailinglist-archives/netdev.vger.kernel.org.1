Return-Path: <netdev+bounces-90517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7A8AE569
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC551C22EEF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5D212F36B;
	Tue, 23 Apr 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huAg2FX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42067EEE1
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873421; cv=fail; b=OPcLBBR01MJjwxAQD04J5wfc+gG/pWQw9euVsc4EALvxFJ+fLpm4CvRAOvq4XRiCeXTGXlWwBswVt1pdQN/mrgKAC5y4R4LVgwSQhAbe0et6dbIhrC+jlyYTa4PcCuRPwceo56ci8i4hUHmM5yFWNEElNhY3O3SECr+nl+yeB9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873421; c=relaxed/simple;
	bh=dPv2KOf70gL/8mgmuah4FOEmUr4py2NEAJfiy9VXD9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNmUdPQ/RK1vHhXcQDdmkBLItTYoDsNaoE0CHJBdyrz4b8Aj4FanqxfJDnSi4TX3+Z/uazzvSDs+Wjrpz/Dong85enlBtc3TZeORHTQSf7yjycMGOK5c5nscJoEFTCrKQDVfDl2ETard8btdjtxgIrDkCwKixYs8WEBnhMep93M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huAg2FX+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713873420; x=1745409420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPv2KOf70gL/8mgmuah4FOEmUr4py2NEAJfiy9VXD9E=;
  b=huAg2FX+WhaOU1RbuiKjrZMAPd0bo/jA9VenX5zT2mgGXBkR2PiDGFQf
   n3xXak/OyKDvAeblQJhDtf9FSUK+iyjSw/BSDxR0SSyJEdnHIWWABGHiC
   7cFLLiPCWeBseRwwtQWbM4dCon36KP9AGr8Vk7TC3AiTIyDK11I/CYte7
   MBN6UfQM9iv6xB3qAd/h+mOa3fgU7cqEC5wyrfaQcA99Ni3+LSEWZ927U
   fv6nfBCDaLMi+KyHLKho26/iAc1nOzU5n8hp/u6aEZJrofGouEQyVdC4s
   tt0MuakNlYNT7ATO0Qm8c2/Yi0OiNqYDeOw0OwGLOU08l6x+KrlqzSyhm
   Q==;
X-CSE-ConnectionGUID: g10sTAyiRnKnBHBhRUfopA==
X-CSE-MsgGUID: EfV2VzVBRUOSp48REvi0sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9282502"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9282502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:57:00 -0700
X-CSE-ConnectionGUID: VJM7GMYPRuSMKT41TD0hDw==
X-CSE-MsgGUID: AxJQxZJiQpiyxpdHEvy0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24950741"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 04:57:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:56:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 04:56:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 04:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0KFGP+7gfJTCr6ReUjj3xutOoS51Nq+8JaeMifbtDHS3yySFcV4siLcysiHY9G8G0nLZ2ClIIFEFHdbJYuW6s+BhDweqlsj15ay0McKQuT6Qf4HH4RqmAkwKW3GPzf1el9nYFe9jPwC2buq7EpUt3zb5oIBCfe8IkX8oFYO35gSy8mZrjnmaIA22odpmaNNogqWmHJVCEBnXGqz7lKiWaHuyoKPx+FQqFQby7B+9r+jvggG95Wd5bH3jODGVA/gKdtHRuwIktdbW0AgqEjn5zbQRQrIHE0Vu2JGi6ekLTeGwjSNUDs/LGZRQdzBfjHyCva+CU3rGquJ4/3sCzIx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7SqS56cSH3EpcE+2dRQJvxuismr19HmMpRX+fHTLsg=;
 b=Tdhv14pJ+/LYfqXgfJySMKYIizJgmvTrzlYzBIgWCHpCES5+Yhj5sZzWhebY7tX5RtQtlnfG788e2ssL9pqcpJ/YxrgmxSO7ZA+n75fQLCLryqDmuZeRKu63tlpYnZvYy8omkZdfWtSbXDwiD4AV10nGrfI/M+6vFl/nKP17K7o0iXdXCplsbyKm5TR2EMf/U3FR3ds8d/PBDs5Z0NcnpE621AMPBZ3mVQLMRWDZzdNFDZ+QE5YxXAhsH/ujinZZiwT2JI/0fTF4BwgTRqkGn5DQa2NYhDiKSasXj9VdN586Ku3dxJT+8jyeRsTqDJ2L6LzLCd7IKFaX3yhE/5Ku8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 by MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 11:56:56 +0000
Received: from MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::5dcc:85da:cd5c:6445]) by MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::5dcc:85da:cd5c:6445%7]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 11:56:55 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next v2] ice: Extend auxbus device naming
Thread-Topic: [PATCH iwl-next v2] ice: Extend auxbus device naming
Thread-Index: AQHalV7bwR0XBuVkH0OJ5JtjbfmnDrF1uiGAgAAAYzA=
Date: Tue, 23 Apr 2024 11:56:55 +0000
Message-ID: <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
 <ZiedKc5wE2-3LlaM@nanopsycho>
In-Reply-To: <ZiedKc5wE2-3LlaM@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4681:EE_|MW5PR11MB5764:EE_
x-ms-office365-filtering-correlation-id: 92c8b723-7e51-4278-bacc-08dc638c7915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?jq/RWCSSiKdklMZxrSLd4xYA9iDnm6RYclaWyBDVPeuzaAudvTwBbmWyPJrK?=
 =?us-ascii?Q?WoGSx47HaICJq0Mbl+Or6EafTY7o+29RMZwGLdy5oKAKQ2wMi1b+OcV/K3lm?=
 =?us-ascii?Q?VZtqmUZ3uR3psaz03WGyIvVz9odFQNZEVLWt996MrjxgOCP1l/Pf3TN409La?=
 =?us-ascii?Q?1JVnuLk+mZCELRhFZ0T1F8PLrVXXBaFTxRNCXUjyMtxdj1LudfsDotb4uHeH?=
 =?us-ascii?Q?jF7+tyXk+ZJnDd2RCDwqKHJRMKQlOl7sF0CvC01tqYyMa9xJOnXPSAVynkf/?=
 =?us-ascii?Q?PQ+w767hcwOPQ+dAaVKdKAEVBbDKCQ8DBC2cPtKMeD+Zerp3BIU3WExq/Vlz?=
 =?us-ascii?Q?FHMI0m7iEpfh0m+DwSasTz5PYv1Eh7MRZO315SF5QH3ZZq/sRJ8bd+Ix9QdG?=
 =?us-ascii?Q?paVHOYuNek2tbrNBSeS6htTnDwynjy9MGrplL5hr/NIr7ohfQgVCDFwIdcnU?=
 =?us-ascii?Q?KbE9dvsc1aBH/+F8kVaEZfCGXyjbRLIccS8mcXNikdBWQpuZFwkz/fIx20Ro?=
 =?us-ascii?Q?l7/dqEnhcewmtxy5Ja9biptXWcJ5GDNFFr41Kk25JSYo64vUj745/2ah+PqC?=
 =?us-ascii?Q?Of1dFwtWue6dkeNIhV6fgAymhh8z2O8EURGSmOszWglD2KIlsgXD7CKIWL+A?=
 =?us-ascii?Q?BClTxjyVk4hf10VMxXYllalXV6FgcLaIs6pJJxqBaTunYzHGmewuFeOR5Ift?=
 =?us-ascii?Q?ssMrAKH0jxajYVEA7mUZb648CWI3n+zpybExXYsNQIbJmeMu5egtNq1V9ByY?=
 =?us-ascii?Q?7CAo9aiEcN22i9Il8WUhjONVYFBbmDOlFvqqERNiJSh4YfNgPMnLmV3I66ZJ?=
 =?us-ascii?Q?1HHBSPLokKKVDCmem79jiSwB+1t/bZ5gw47t+/z0pfcfUNRih1cKRWLNeoIC?=
 =?us-ascii?Q?PnARP/X7IsKzmJ3VWJU/E3Ko3zfbSRj9xSI0C45ZztpPA5b6iw7KOSIM2bzY?=
 =?us-ascii?Q?OeVZGXDb3xopBuH7GRyjqSzv4uihCr+ILB9QTRd7xn8UMOBhUZhcXF2CFKI6?=
 =?us-ascii?Q?OQTOoogJzYr8VHzcN9QME9VRq0wNxn+oD2XGK39vYcOubsmDaACVeQWBQGvS?=
 =?us-ascii?Q?JrI1Gk6vK8HSbMc6ULnZkLCY5nylLoctq56b979Ge1BVYFilCM9WHXL3NDvt?=
 =?us-ascii?Q?6WeNJpvyEgTKCFcg6aiyvxL8oy0y00VwBrbv5vNSKL7wD8T99U7WJPtT6P/l?=
 =?us-ascii?Q?BQgJOT1WTsDwsjCvSxE9lt5U662M4pGFswPR7uqN3PU5xPSdyAjbMYwqju8Z?=
 =?us-ascii?Q?ZTzZ+gyuoS9cBjbQ3rv1cR28ZGCr52ODytkuWZQndHE8XJb6/3yzWcA4p7gE?=
 =?us-ascii?Q?zMWZoOEODBrFMXcij0d2+xjy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4681.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YitZvTylNrT0zUot82heY8/9XOeJ+PViPI3u1LK/hBFfjJ+4pAFNTpfJo+pO?=
 =?us-ascii?Q?FSuIbt1YQ/qikqL5C8uJZIXMUJXuXgys2apc7smwVJJ3ZcXpc7FARdcaQIfl?=
 =?us-ascii?Q?f3asS0LFhUnHbmioA0kEkdC9FgHNMOI+52ehgmmtp85I2dUGjC/0ynuV+23v?=
 =?us-ascii?Q?LYVftrbJynbpmMa4ozOwMzeblwL1NivbR2cSHxqwLVxMsWdkumyOTbWGbcwi?=
 =?us-ascii?Q?9S6BkBUc/2qd9WHelqRsCPLPq3WtGwXs6ksAhagTVIPV3gh6j7ND/qnduqSY?=
 =?us-ascii?Q?bZsHQdCb7Wrgu7a//XK3R5Pc6SDW3IFaXC1VNaqNymwWjbShlXVGUm+gSz4p?=
 =?us-ascii?Q?Cs9Z6/UZ3p2nYmucpqWcXz5vq/noXaYqAdrCy+qM1NtbLkNi/ed46DIBshaR?=
 =?us-ascii?Q?6NHEnSJCh4RPbqt+2cnhV0sQXF4IfPno01VdYMw+5Gw1FbjMVKdrmqxf7sQB?=
 =?us-ascii?Q?oovCVuRMt7FEAbNkpboztxsTpY9HP6YdFrKxRKpLwxcw4EjjZCc6XTkrJy1D?=
 =?us-ascii?Q?hvAqG7hpCKW/wdYtu3K/uIjXbaZQv/RDr9s7rcWEwkRaeX77PCzN0hNBDRCY?=
 =?us-ascii?Q?9cbRbOeIXerOz9F9gGj9dhZEjfWsBU8YYZkmsmQr3Ol0zEmxgukUA98nHQE1?=
 =?us-ascii?Q?/boe2EBdaA+MvtmqMcLDFwp4RLpV6ETONATunLmG2mnfBJjEo6K0cH9rSQBu?=
 =?us-ascii?Q?XxCRW0ht40HaOjpBxy9P5v//l0o2gQGSAIlLJNkiov5l4p2kSjsPwGdxJ4N7?=
 =?us-ascii?Q?RwpNjkt+OCI5a2ouPUohbfzWgXBKjPylfrKFzQSKpMjJy7ZWf9q92sosqMcv?=
 =?us-ascii?Q?lfosTfDcSf6Nx9aPBScR2dtm+fP8OsbzJ2gFwBDtoPRLnOUgPvML81eU6yK0?=
 =?us-ascii?Q?szdeUp7vR9+y17cdRlcMgtg3L0tKbk18WtBM9ibswfBpUdpNonY6Jl9DYyKL?=
 =?us-ascii?Q?ao/qvkQK95N8YEcH93yQEJnyVt02IfZZcuZPMrjHFPsO53DMh3hy7SH3l5d1?=
 =?us-ascii?Q?qaJg3TYPeoTKbaPxRq6ttkDaddo6xhbl9YH6J5gGXOmfwIE+qqnG8J5cDXTf?=
 =?us-ascii?Q?9Ibnp05DiGO5zfktIaxW+GEv2Ruq8U6zwHpehpDbwKISdnl0qsTFRuNKXUbL?=
 =?us-ascii?Q?s66autYrD5+sla/4HdwEd2VoAxjU1PmurXp6bNOu1h+NwrWeZ+x83PTHJNuV?=
 =?us-ascii?Q?41MHPkXV7/755TW8LoYt6XOgOULOdLa/8qZ3pUOVl6Zk08BqnmY6YWOH2vP/?=
 =?us-ascii?Q?23KgkZkZY6kCogQAn0oJ+wr+oLDmZBTtiQ8xn9RLR0MVteIOJyG5/oTrUd9c?=
 =?us-ascii?Q?zLchiEsmgfajRCUy0rxJlGFIXCYXb1RPq0u+TjN3AswB5fsIzPI3wDRYljTi?=
 =?us-ascii?Q?DuBoh4NYBVYAzvReBvzKgaVHfggZns+JhDifpTcoIvTpxd3o9QTJojulPrUd?=
 =?us-ascii?Q?GUDg9hqrSLI1qeAsuFLJv4rNEBeG5qvZnLwTcTFPGOK6vFZ26a3XXGEEY/h/?=
 =?us-ascii?Q?awEdNJA4D7QNX7MWsMeYhHiV23Kh8wxh9RPZLRdOfF2VRdQ6qq3OFoxAtvcN?=
 =?us-ascii?Q?P7jIuWJ4za6HzPKRdyZC2Q0eiQTf3iYJHr1Vi3lnZiUX3I0EKkFc4nLQT51g?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4681.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c8b723-7e51-4278-bacc-08dc638c7915
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:56:55.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmZ2q7RZORpTtLnGJf/7Aho0EEZa3qDCOU/1BV+3mEwYtPaDlEaJCtk0c/wvKSq1wy3dxJAnJGQ+4Sdk1m40A4inNP2EHspw3AEsoNU44iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5764
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 23, 2024 1:36 PM
> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>=20
> Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
> wrote:
> >Include segment/domain number in the device name to distinguish
> between
> >PCI devices located on different root complexes in multi-segment
> >configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
> >ptp_<domain>_<bus>_<slot>_clk<clock>
>=20
> I don't understand why you need to encode pci properties of a parent devi=
ce
> into the auxiliary bus name. Could you please explain the motivation? Why
> you need a bus instance per PF?
>=20
> The rest of the auxbus registrators don't do this. Could you please align=
? Just
> have one bus for ice driver and that's it.

This patch adds support for multi-segment PCIe configurations.
An auxdev is created for each adapter, which has a clock, in the system. Th=
ere can be
more than one adapter present, so there exists a possibility of device nami=
ng conflict.
To avoid it, auxdevs are named according to the PCI geographical addresses =
of the adapters.

Some systems may have adapters connected to different RCs which represent s=
eparate
PCI segments/domains. In such cases, BDF numbers  for these adapters can ma=
tch, triggering
the naming conflict again. To avoid that, auxdev names are further extended=
 to include the
segment/domain number.
 =20
>=20
>=20
> >
> >v1->v2
> >Rebase on top of the latest changes
> >
> >Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >---
> > drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++------
> > 1 file changed, 12 insertions(+), 6 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> >b/drivers/net/ethernet/intel/ice/ice_ptp.c
> >index 402436b72322..744b102f7636 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> >@@ -2993,8 +2993,9 @@ ice_ptp_auxbus_create_id_table(struct ice_pf
> *pf,
> >const char *name)  static int ice_ptp_register_auxbus_driver(struct
> >ice_pf *pf)  {
> > 	struct auxiliary_driver *aux_driver;
> >+	struct pci_dev *pdev =3D pf->pdev;
> > 	struct ice_ptp *ptp;
> >-	char busdev[8] =3D {};
> >+	char busdev[16] =3D {};
> > 	struct device *dev;
> > 	char *name;
> > 	int err;
> >@@ -3005,8 +3006,10 @@ static int ice_ptp_register_auxbus_driver(struct
> ice_pf *pf)
> > 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
> > 	mutex_init(&ptp->ports_owner.lock);
> > 	if (ice_is_e810(&pf->hw))
> >-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
> >-			PCI_SLOT(pf->pdev->devfn));
> >+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
> >+			 pci_domain_nr(pdev->bus),
> >+			 pdev->bus->number,
> >+			 PCI_SLOT(pdev->devfn));
> > 	name =3D devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
> > 			      ice_get_ptp_src_clock_index(&pf->hw));
> > 	if (!name)
> >@@ -3210,8 +3213,9 @@ static void ice_ptp_release_auxbus_device(struct
> >device *dev)  static int ice_ptp_create_auxbus_device(struct ice_pf
> >*pf)  {
> > 	struct auxiliary_device *aux_dev;
> >+	struct pci_dev *pdev =3D pf->pdev;
> > 	struct ice_ptp *ptp;
> >-	char busdev[8] =3D {};
> >+	char busdev[16] =3D {};
> > 	struct device *dev;
> > 	char *name;
> > 	int err;
> >@@ -3224,8 +3228,10 @@ static int ice_ptp_create_auxbus_device(struct
> ice_pf *pf)
> > 	aux_dev =3D &ptp->port.aux_dev;
> >
> > 	if (ice_is_e810(&pf->hw))
> >-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
> >-			PCI_SLOT(pf->pdev->devfn));
> >+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
> >+			 pci_domain_nr(pdev->bus),
> >+			 pdev->bus->number,
> >+			 PCI_SLOT(pdev->devfn));
> >
> > 	name =3D devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
> > 			      ice_get_ptp_src_clock_index(&pf->hw));
> >--
> >2.35.3
> >
> >

