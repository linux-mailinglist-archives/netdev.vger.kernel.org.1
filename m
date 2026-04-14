Return-Path: <netdev+bounces-278420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OUTCQEo3mltoQkAu9opvQ
	(envelope-from <netdev+bounces-278420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777DE3F97D6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61558304482F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191E3DDDBC;
	Tue, 14 Apr 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/u35SL8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1135B658
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166900; cv=fail; b=uxEMC1yDIOwmWcPiaWUrvVohDL/ueFgRXBegn9trSyYE3khC7jDDCmZzkShV7yC5H0qr6jnbl2EwqtNYoRfyKLdxlM20YvMAoh3GKqJlCD+PNTn6KQiB4gbNGyqzIdXRihl6wCpi7E8h25Yq3qwhf62UqQ0X/HliPEaulvOTI1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166900; c=relaxed/simple;
	bh=PhHgHN+9pwLTZOBehIS8WZy6lWZIOJOq21alMX2ag7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhX0jr3W59O0fshbwOYQfRRPIdBNXQzbh2IYyxTbVbseJ2t+5Wq0LWHzMh1ISPB8ADaKX5tnihP/rnwMPBlbikx80jyq30Px0v2x41G9l4eYg2g1jwfRvHN6395s8fejrcsJ1hbJA/rmCmU+ypC3SjIfu/JpJdD8U3J0xhL+eVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/u35SL8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776166900; x=1807702900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PhHgHN+9pwLTZOBehIS8WZy6lWZIOJOq21alMX2ag7g=;
  b=R/u35SL8gWfOqR5UYbH82SZ2JNp2B2LxJyxIxHCNdsczoqbIDbUFS9iQ
   lmkPQrR1DaTIV0lMiOL2DJUpypNcQlDHB4+2Rc9Qc2eMRdd4y1mOol4UC
   64qSAfez9RTMgvajcHue/1fR6Fzh28L6jIAoZUDw4kfI+5COhGga4XGaH
   x5iMCljk8NfLOVAX9rgMZ5SiVnXH9IBaw8P36vLapukL2EbBrsC/VgfZM
   2+vuXyY2lYRlA14suUH6KlWxO9bOIh/qykN1cSM5J0N8m6LmS0ePBCukr
   0tgOzdLFIGhB2fu+4/yCjoGP63rHrVrcuktWkTok3xer3xeeD6fYe87Yl
   Q==;
X-CSE-ConnectionGUID: SRcc60TtTI6zxICuiWs3xQ==
X-CSE-MsgGUID: nQUfeo8dQ+G6q12yEyG1jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76828038"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76828038"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:41:39 -0700
X-CSE-ConnectionGUID: 1lX8jt8+Rf+L2ZYOSksNqA==
X-CSE-MsgGUID: fsQnqcm0SWSGLlwCtX1D9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225769234"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:41:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:41:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:41:38 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJsoZY5KpDvcRe5Cvxym1W0Q9UWUR3DasPM4piokE1CjGXXZYOybJGA//k56+VjBP+F70BjD/PEg4SRWcdkR0XEI0N1BixhELItMcfh/GZzY5AQ5xboKDrAMAKSKU7icU+y+EyA17g6DfGub8gj3lbwKVj+vBV35U4t81w2gB4pNN+jUxszFpV3m9yn9SR9JuaVfAbwktXrGhvN73itJN7sajlqGwcR2lrsJGVNza2RsHS6/02GN/RIwtwrYNLc7uGxr7pBKGsAzaOlr5JgfHgWjJWEAMovTFAARyg/hoB60sXMlZh+ZWIcVoodcczSToKWFpoqjE/kowNnMX8cEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXTSPtS2pmZPfP3wciN7DI3lYyXIkC+Tfw5pLf2na+c=;
 b=KeJaX2u1fqJlLTaeSvL8VgzqBCYyLaCkbblpzT6R7rxWji/tr4kXOLQAZwm+qd8gqNptoSAQhu8rP3MBaMEfKGDXu4hFLKTYQJ3lFMIIxRuC65WZleOm5jj7dWJGjhPzAIkGvaTggj/LODodSUOCmGYyU3Fqdw2GWHO607BMhOqq6+/TRok1TttWO4Iyu3JU9y06ev5EbC/Ts5Vzkq88N5upYJJMcgBpwyp4AVTICRMqRo5ZQlzp5hrhs51Rno/XCzH2VHBsOrVa3DqeqzUYl8JB304+cQCPoqI/6xvOpeJ92/yHnwNI2eETKG0m1Xw0zqxOFu1v5t+LOeRcD2S4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9874.namprd11.prod.outlook.com (2603:10b6:806:4d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 11:41:36 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 14 Apr 2026
 11:41:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v2 4/4] ice: skip unnecessary VF
 reset when setting trust
Thread-Topic: [Intel-wired-lan] [PATCH net v2 4/4] ice: skip unnecessary VF
 reset when setting trust
Thread-Index: AQHcxq8P0glZcdfPaEKTPrkGxvqzvLXeecbQ
Date: Tue, 14 Apr 2026 11:41:36 +0000
Message-ID: <IA3PR11MB89869517D064D3077DF2E7A2E5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260407165206.1121317-1-jtornosm@redhat.com>
 <20260407165206.1121317-5-jtornosm@redhat.com>
In-Reply-To: <20260407165206.1121317-5-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9874:EE_
x-ms-office365-filtering-correlation-id: f022de37-1474-442d-093c-08de9a1ac8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: DPt3GqTregKZvZbzxf4mkt2Nmj8kSC7GfyZK2vD7iAap0u+7CvbgP3fd/gyuNPTh/q2HvtU1ajpBLk5Qyl4IYKLjI4i2k1Qcj5kjALRyjCf5YxTzrwOGuOOekWaR2VMlR70HmVWAEuSdZ8zbiz2/msnvdYhZzpsCmhAtkLeSxpvlTdZ1RMffN9hSsALPpPwtKVTSu3Oze9wERkTsjnEH2yiCzP/WY1hqbM7vKNW++lLPe2UKUj8QiUWXtBJHtR429elBMi1JxkkzZEiHYO/QZEQfUItAqi57BukTxXO5Lg8dSY1t3aBmzM/0szklbYn1l+3u3UBzNKMb0L3TMQqBGrD58Hl0g5dNWNlvCGKw3VVi2um+LfzUpAC+ex6nzif24sK/NxVe8s3XPaq+Up9wk6aATSBz2jgZe9/QXGbDVKPv/Nx9C2pZCOwgNHGbrgCe/PBG6LjlJqCVd3zw3ZjpLzd43iPNKhgQ5szD6r9wNbpUhl4VX03uG5v01kkA11/N3uhf2+2Bp2kVaqmfPAbTnLJ5ejhpHQUXQoA1G3zbahlqdgxpP22uwWrl7ns0xmW9lTyS+0RanjWXwFw6WOwCtFugrMXCF/ImJ2Tk2x9+wwa/KItGgaXDbx+gp9qJwdzKEV84KZ3RES0r2nBYMQRX0nIKlJyG50F6RTa+tm/gjgX1fWD3ksLWE7LXBY0I1kSAWjkuY5QveGPRD91pKC0hzGbrRiUCfrJmCAG7PjqBNJwpFxmZ2pgc2ekz3UnM/1AGaBfYFmKvzQHWejGkJUJNOxS7Oz+mOyuRoIA5CDpUCeM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWxCQcJf/xYQOfkg8UaNA5DzptQzjkinniK2UsdFB1dZEMvlhKnVmtxrLG9u?=
 =?us-ascii?Q?rSyDsNDICPh6nAc9BPyaf0mB5DSrvuu7x9VLI9nd1AMVXieuSOyWr360rqNw?=
 =?us-ascii?Q?DxpLJ4mip1l7xfUd8XNQJTls2KeXzdXaiuGhaEOoBLNhelkmz1+gDg8K/lCc?=
 =?us-ascii?Q?uiQOMcd3d9t3FayvAFtPmoduvjyYPUf3eS5FZDWx5bmrAf0aCVH4/dZ8WdEJ?=
 =?us-ascii?Q?3AKAbEp+hJDfGhjeTVnR1+7pzI6kjjjoc8MlyMq2e1kfyPOnqXCqtPekX09J?=
 =?us-ascii?Q?qBhgMvgywwOXNf3Q/VHFaDdqHTKxp81iGOqacR3+TBIuGaKFFY/slCNPHqfr?=
 =?us-ascii?Q?3NcAaQm1WNnsg9lKI8Mv1VqyTTY92iHPvWJ0xWBAbuJ1LxEZzTbS6Bf1Ec8Z?=
 =?us-ascii?Q?WzmEa9y9B7tQRjDvwdDKZN6TuUxgsuzkx0DdBswAOCtR9uEQrYVb9JlLELAf?=
 =?us-ascii?Q?ROiiuC7kkM9H3JxEE47M7YD+WkMs29/2M+FhahBQGxIkD7semVcjfgnEcM88?=
 =?us-ascii?Q?5la/E+8tG5JaVjbkeQkDNlbcKar8yYp7QmNmBGL9iCvPCbD2GoIm2s8Ygecd?=
 =?us-ascii?Q?kIM1UWELKWWpWHRsflZoBIAw9+0LYEUAm7UraYESJ1H6mQNAStZiMfHbQAUw?=
 =?us-ascii?Q?xlfPP2E/vkRK7BQG1C5XlBut4m9L2GPTf7h81hFYPs9hHRP5AeQZMqFSlwkE?=
 =?us-ascii?Q?fTiJ9PUKe4rPGnRHA/8P05VLpJsa2FkxPbcCXKPyfXcGfZVUMCe9HiNUTBRa?=
 =?us-ascii?Q?PXb6XajlZZxFyTdnGPkEbig9uAM60Eh+0rf9oO4RvMyqO9QNOyBTzOPmQeik?=
 =?us-ascii?Q?7wQPY8ke5XpLZmq8mo7PqzD/Hm35u4oArFkU/Df02Ws/Ah+THiaA8Q0aubDN?=
 =?us-ascii?Q?KRoFM17exvcWDpWM6IY7I3y1VGVLTsuFuk1E80QxhfbMBHzYSOEJHa6LDF5N?=
 =?us-ascii?Q?7X9kqouC9e1Ml+pSSVnERSRFiCnfbOY5KK71tcA+kNiqu9L802ZLU+Vxv152?=
 =?us-ascii?Q?aLSjJwxrJv0GSuH/aH8x9JkXpahCI847GtAywIJaoA9ioj/FLIUTNmwsYYpe?=
 =?us-ascii?Q?C3hA4dvG7nA/Wuw0f2BP0Eb9ODwWytfapvqAQRKaLtWH1MnpIESBpjwAzPkN?=
 =?us-ascii?Q?Hta8Y5DhgXhSauNh4nWls0cUDJbt6XHgA5myKDcRSDAoaBu+zV7x0rojihZf?=
 =?us-ascii?Q?xIyTK5rstd12wiL5FiHp4FkYlbtYpcWvSQOtIj4CiMtF2pvpJCIfh5qXNSdr?=
 =?us-ascii?Q?cngPBkIhGWT4ZYVW+/96hw33Mm18rhLKg6KRaBGeXZSbI+lqSiK4yodYCcfm?=
 =?us-ascii?Q?PjbcQEJczd5kpM0wEYnV84yohL6H9Yr4VGDD43NFl3/hoHdqmqn9wcK2dOwZ?=
 =?us-ascii?Q?e401t78vmb0CHy7kboBHi2qwXaulBDxXmrGlqw7RTfuJyNUA6BDWecPt8UEF?=
 =?us-ascii?Q?bgchy7s4jxXxG4zjYFbPunpNQB/2i+PDPvwdTZDiI2Wgsa8IqCUOlBdru95T?=
 =?us-ascii?Q?GrL8cvyZED1hZylBzZOUGM5txdAnkPwWQ/FcKecPCbxJzJt1CZZ8aSfKjYTF?=
 =?us-ascii?Q?jR5mRlr+dWcJod7x/Nj+AcEaUPjlJL4IblJKtBATLBJ0BWCE2Arg+RY0njqP?=
 =?us-ascii?Q?oomo/v4BpeYdpKvgSyusWEHCwebBElQ5FkxEV9VS93NK/ZE8sCCJCgjHkJvV?=
 =?us-ascii?Q?xvuWAuyTOMn+Z4stL8cWkF46VHxWu2ZS8YpkgsbPMeI/JQ/2gBWF4el3JWcL?=
 =?us-ascii?Q?Q14lWvAOOUNvVQ58XASUAztfrSRjR6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h3yZ2uQCFKXSQtz36aXc3VP7kX/3atnrv2f1UUejYIx75jcL1GgU11kTXSV8lRPtcQ3K6BR6CY+6kLU5fpw5EfAhVqpZbpcYuI4oFAcuwQzg+XW8hJl6C8GO4v1rajaOdCO6jZhIRTs+SjVAKD7urvYceLetb4I5Lq5CUvkR8gLvvvn1HmXwq20gePchu6UateOsuiJtzX2NjiimWrY6hhmcwZWpwTgNCqvkwMYGlQM7FWoroG8rIKdXN1828FIyhPcqWT5Hw6Y6aLLi7ZMQJf8hkwfeuIz8LBFV6LxYBDTfttX8N3ZFoYkA4cTsDM+Qe2MxU/nOS0p9Vj4mBTLMEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f022de37-1474-442d-093c-08de9a1ac8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:41:36.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oM96CiXTMLqaxSR5OZiKidemyoeOx0ZKKEZiXp675s+mNL9lMTLCd1ywPeleRdW9muUmFAUStgtNCvxFRKTibDIxW16c21sdHNFa5C/El0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9874
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 777DE3F97D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jose Ignacio Tornos Martinez
> Sent: Tuesday, April 7, 2026 6:52 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; jesse.brandeburg@intel.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jose Ignacio
> Tornos Martinez <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v2 4/4] ice: skip unnecessary VF
> reset when setting trust
>=20
> Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
> ice_reset_vf() when the trust setting changes.
>=20
> The ice driver already has logic to clean up MAC LLDP filters when
> removing trust, which is the only operation that requires filter
> synchronization. After this cleanup, the VF reset is only necessary if
> there were actually filters to remove.
>=20
> For all other trust state changes (setting trust, or removing trust
> when no filters exist), the reset is unnecessary as filter
> synchronization happens naturally through normal VF operations.
>=20
> Fix by only triggering the VF reset when removing trust AND filters
> were actually cleaned up (num_mac_lldp was non-zero).
>=20
> This saves some time and eliminates unnecessary service disruption
> when changing VF trust settings if not necessary.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..23f692b1e86c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1399,14 +1399,19 @@ int ice_set_vf_trust(struct net_device
> *netdev, int vf_id, bool trusted)
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf),
> false);
> -
>  	vf->trusted =3D trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>=20
> +	/* Only reset VF if removing trust and there are MAC LLDP
> filters
> +	 * to clean up. Reset is needed to ensure filter removal
> completes.
> +	 */
> +	if (!trusted && vf->num_mac_lldp) {
> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf,
> ice_get_vf_vsi(vf), false);
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	}
> +
>  	mutex_unlock(&vf->cfg_lock);
>=20
>  out_put_vf:
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

