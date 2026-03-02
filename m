Return-Path: <netdev+bounces-262762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL2PDTzLpWl3GwAAu9opvQ
	(envelope-from <netdev+bounces-262762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:39:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD461DDEE4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7F8A301BF93
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A0425CD8;
	Mon,  2 Mar 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE9K6cQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B93E9F8F;
	Mon,  2 Mar 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473071; cv=fail; b=nnHJmNw5d6Y7EgypvPgXYE/PBzMSG9DchlF1PMLraIAca/XbktSB+VXfEAZs25dKb4pizTUCIJM1nGFFp0mGF5aFTDNYeXQLy4nYwIAS2Es2tcn/4csW2xlM+tpgKQjVusVK6HSU2tGYz5dd3wuJec3I5bj8GTYOhowX4x0dXuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473071; c=relaxed/simple;
	bh=B/uUZNPky5coOoqJIWzBlR72A0373v4Yj+eDO7o5+/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ui7wZ4W4z3ONR/E7YyPklJZjPEvVC8p8dUII6hF3vkfzRY4piBvLPFq2ko2hv9Fmx74xkcm8mz8svbySsf8qdEt0TBm9oPPrQ/yvDHV5oad2KT86zUYPPHIaXjZEbQtCy/imcGPy+r2aWQmWqNcCW87FQbuL0DdSg/GC0hp1mCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE9K6cQ+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772473070; x=1804009070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B/uUZNPky5coOoqJIWzBlR72A0373v4Yj+eDO7o5+/U=;
  b=cE9K6cQ+aqxUi7sNy61RluT13yzFwcytsBiysLLiRzqgfqmTfT9G+nym
   g953XH2iJYdMIAzYdfAZVExvGtRTrZMGXGt8ULgHWJcEHfPwpBaAzcw32
   FGkVLeKgFswcXWme3Roehcy04GimZci9xjz18GbK3QulS/Oyec+d7tb17
   Z2vCexIao2HZlAnc4XVq/GLvtQv8KortsyMaflPfaOxm0ejaSoo6n1fHp
   2P1yPPqvUevR4iTupwCxGGYFRTZ9xoLwHpGqQ0LIMyP3RND1nDzQMPffJ
   P6yztfGMjwREr3AHICNLJV3n/letIpcm3caY943fdeOwBUyThpO1qts2k
   Q==;
X-CSE-ConnectionGUID: XuhwRWzATjymsc2q80W9wQ==
X-CSE-MsgGUID: V+pSIfCLQnqpuWUz1dJfLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="61060713"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="61060713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:37:49 -0800
X-CSE-ConnectionGUID: cKX1KBufThm+GlMyiWzd7A==
X-CSE-MsgGUID: z9qqdX+AR6mmjVFHg/K3dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217641754"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:37:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:37:48 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 09:37:48 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY8UAdsQSjhIVEJASSQME+qIZxAs9hC6FERrhBd35aqWlhSPuLiNHHpoFx3bvyfb+ulawVu8X2J+FpKnkT+PfLl0+tghxKEqtl7MNXOAIpe5ABWprpW/B+tHxVG9PfalwiS0DBKOY+hMcdmB+LhXt2s57rUhocVdKzO8qexLnLouLBSQ+P61C8YwMb7pLRYh3xRXNHOmokUqPv+bZxChIeZlU5NLJZfAGU0vE3ZDFTiLS7E+Z52HZ0dwZzO1clzoAqiaOdSMSm8zaJqJ1nv+AaX5f5J/X+yWijgQZBAVBPi3BdLQawjgcUeaNi25nJPULBBZnktHsNsO4s/PjTUIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/uUZNPky5coOoqJIWzBlR72A0373v4Yj+eDO7o5+/U=;
 b=rhnPAyqa1qVec9LosguofQU7UtdkY88fGXBbk2EKCrTUgEsxnUU9N0EAPHtxt3aL2DFfWYqFQBnJ3nbh1hxtPlluLNG1X5Yz9tpCVNBZ4IUXfiVGMQ+a+JltEEJrF+tj7Kr7ovnB5kv3CXNFjg9azg1N8o+JG1c9WVCzU4qEBAOIALdD4QPAD8SAwBGavBdNvRBCqdkTB4hoKEW65mqPUdCEY1qpOh1V8ee/AU7G+gpzmh+9qtjYw1AeDskxoTXJZY9h4ih5LtIc5EHj+b9OPdC77P7I3NSRR8h6EfbghPYo47gE6prnmCKgwWi5KL2FiIMwM3kCFLQRT6hgm5m2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::831) by BL3PR11MB6458.namprd11.prod.outlook.com
 (2603:10b6:208:3bd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 17:37:43 +0000
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d]) by SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d%4]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 17:37:43 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Slepecki, Jakub"
	<jakub.slepecki@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 3/7] ice: allow overriding
 lan_en, lb_en in switch
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 3/7] ice: allow overriding
 lan_en, lb_en in switch
Thread-Index: AQHcle05tBuCbHZ2YECLxV5/XuygpbWbqp6Q
Date: Mon, 2 Mar 2026 17:37:43 +0000
Message-ID: <SJ5PPF6806D69E4095D2E91802B3FAAE3CF8F7EA@SJ5PPF6806D69E4.namprd11.prod.outlook.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
 <20260204154418.1285309-4-jakub.slepecki@intel.com>
In-Reply-To: <20260204154418.1285309-4-jakub.slepecki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6806D69E4:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: ef796f2e-7755-4e71-0cd0-08de78826913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: HLa1YKKw5yh4C73CUsQ5m+aONMurBNOsLNShtApCub29HF6z0146oBbeXAw0QCSAiGaYUpenEigIGufMbHBiFqdCtH6oQDqIPvI0riDlkgmb/yfCoIsH3lwnuzFWx3udSW1nONr8St4VHnTS7PkOVBEcf0cOgf3k/dBDrMEqmZrHOD6dTOwlnLetgEwM8g5rFVJz0Dx7pmPQyQsA9fjkLIYL+jwgw9QCn1X605y5/mnsqEJ5+r7LXfstAt+Qtlhh55xf76SOnlQHsnU2eSmBg2bKj6RmAVhSs45aZ3aytrkICbk1jf6hRcS4J+qoxFOqofWEW3w46sY+1obiEjJcpbvgCyNsUgIvoOU/wRSfUI9YiHjKeeWWa63pNpU2mZuBRXJN+WgzToBNvPRyP27KGZq8fptZr6ZcbPIVAUQvidOJ7Pmn35eMzIQ/uB+A/UH9MPiS4DLeFXPFbj8nyuzg78rMuOwFkOIoJyaawHp/JUcqJ7YA8GeR3TWmySaHudLDWTZd3jJLGhOlHkB1DugBtzficAHZiscK9oMFPokjlZ26v0IMNh4UyhNnXHGJPJWRCLiuFwoteiE/vmu97E4VWCf1k4yACfjhjh8/tqYSXshwa9lZyeDm7k+bhcbS9XQVefCrGuKfPcFM4BXh8pQmhAZkF83AIdNaa+dU80NkOGzgh+t+ylPlAZjwRgeMWKekf1yyT5HrJntCfv+afKGLJLgwo04fE0OElsYZjE9Wo94emnG+4BiYGQMZt5qhPo8w1yXcSCI2iwt+xf/ZjSiwDGsojl8BeBuX6aI7Ex98t0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF6806D69E4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTlZWTFpY3lCeDNRbFFjS2JXQTczT3FsWWYrNmgvRW8yVEtveHpKRDhOOGFZ?=
 =?utf-8?B?aFlzWDM4YVoxMHg3MHBBeVk5ZVliTFJqdjQwL2owKzlZSEkxR0xDVWIwa3VH?=
 =?utf-8?B?ZjJnRmFkYkhUTHR3MU1jYVlNMmxZK3ZiQWU1WWJGUVRqdDlIZ3N6Q0JiN1Bj?=
 =?utf-8?B?VkQvM0lWZTZGTktnS0pqMFRkOHBNajlmN25iR0NZMEJIMFZxcjh4K01uVml1?=
 =?utf-8?B?WEZEbktyUTMrand2SjNkNDdrVTdTM1FLVEZDS29HSlJKZjhNMzZISW9XUFdk?=
 =?utf-8?B?RERYMDZpdEpjaVhKRml5ckxsa2ZvQmVIdm1IOHJKNkNocVJCZVQwTVo1NkhW?=
 =?utf-8?B?dG1KT0xvQ1pJVm5yZ1BBaG9ENkRnazQ1NG5OUThEclp2c1Q5Z1lPU01hVVRZ?=
 =?utf-8?B?Vm9oT2RuL2dJK244bHljdnFoTXFISzRVcDRJYndwQjlVOVdFWnkzMWhPbGky?=
 =?utf-8?B?U1hpeXJJeDhwRG9QVHovWlYrdlA3U3lGTzlOZEMxaWYvSGpNZzFQY3lMUUFE?=
 =?utf-8?B?cnNuUTJrSktWNmdpa20xQzB4Zmc0a1QrcXdKY2srSnhKQVg3QzRKcnlZbUdm?=
 =?utf-8?B?VTRDZnhWZFBxUlgvTWs3Nnllejd0STBYYlA1b3lzK0gxd3o0eTJCckxZNlV3?=
 =?utf-8?B?M2lHeFdmV0ljcUtyZW8yZEdKVUZjazE4NDFLTVF4d0szbUxsNncrRlhOTWRV?=
 =?utf-8?B?SzMvMlRvbVJlUHB6cS9KblBEZ04yUTBYVTU2cGVTSXZJN1p4OXFjYlRleGRt?=
 =?utf-8?B?NHR0RmJBYnIxdzQrRjdST2NpOXhPT0RJLy9qNDR0VnFIUDk5bGNOdndIRHBp?=
 =?utf-8?B?WERTNFMvWjdRM1Vzaks3cGRCWGZDRnBWREtCR2cybzBUOGVpRHUzTnRBbGc0?=
 =?utf-8?B?NkNkR2p1SjlyV0FsRVBHNDVZd1k1TDZEeVVOa2kwb2luWGU2eEN6bG1palFJ?=
 =?utf-8?B?dnhqOE5FOGd0MXI3TU5MRzE2cVlwSnQ5eFFIV2hSUmp0aDRqcVVGTlZRNWlp?=
 =?utf-8?B?ei9EUk1STlo2b1o0eE1Bd0xRbXdCdkxCRk9NSkdEU1EydE1WMENHQnJ3Vi9L?=
 =?utf-8?B?RFFralhPdFprcXgzL2xpTU5WQ0UwNngxMHdMSmZJeEk2MXRDTHVlUGpsSWJn?=
 =?utf-8?B?TFp3YVlLcnU5L2lHaWovZFNkQ1lobzVWenIzbGlDWUh0eDI0WmJ4NkN2WDR0?=
 =?utf-8?B?dE9SQW1oQTBzM0h6VGRxQm9wM3ZZc2V6eVNQWTBVWXQzZDE5d0NVdm9xa2FH?=
 =?utf-8?B?WUQ3L0hCWmxqczUrSEVvVG8ydy9VNjhYclhYODNtS0FKV3R5MFJYVytxbjdS?=
 =?utf-8?B?bzgvVlh5UmJ2WHVFQWt2S01veFhHL2JCOTNJd0QwZXgySWZ6NnArQ1ljVTY0?=
 =?utf-8?B?Mno1OXFpTHJ0enFpR2tXK3h4cU9MeERPMFluNEdSWlg1TEkzdEZBM282M0U3?=
 =?utf-8?B?QkVhWDN5NDNucm05czdLVENLVDQ1U0pacWdQTGZqQnJ4a3hCWmJXcnhJSElx?=
 =?utf-8?B?c3dUWGRSckc1cThWUDZkbW1ZNHZHWFlrWEJDelFEbFBpTHhuWFVjM1VJNWV0?=
 =?utf-8?B?Z2YrNWh6eGRiZURHM2VLa0dMSkphN2krT3VYci85b1FlbHZwdkdOazVSS3R0?=
 =?utf-8?B?SFM2R051RGwxTGhCY1BmZm5HcktLWU5JSmtrUUdqa2d5NWxsSC9CVmRxdlQz?=
 =?utf-8?B?SktaYXQ5bWRJQlpJS1NZOVdXM05PdFhGUVhyeS93YnpyR21CcFpObi9KWXIx?=
 =?utf-8?B?Uk0xQm56K3NqemgwWGhzNVRLYUsxUzVCU1cxK0VadFZ1elhlZjZYb0NXS3c4?=
 =?utf-8?B?bFk4V2ZiLzRtZ2VZd3FNR3ZFWG9rMlR1cDg1ZmJVU1NTSldmS0E4Z2pIdllw?=
 =?utf-8?B?S2MvTlRVeGlKNWRrdTIzM1lPcWd4SllXYS9kYUNzd1FOek4vWW1SRWJZWDNB?=
 =?utf-8?B?eVVqMnUyQWwxMjBqTGNyWENMeFduVjRSRkNUNnVBc25GTFFJVDdpWlVXTEtk?=
 =?utf-8?B?L3hRc0E4WGt2eSttY240ZEdZTUNWTUpua3Y1ZnpuQWhBM1BtYkhZUnd3Unhz?=
 =?utf-8?B?cys1Qy9jVnR1bXJ3NDBzM21ISlgrRE1NV3c4TXZaem1QSlp4dzQwZHZUaUF4?=
 =?utf-8?B?WnJiNGtqQjh5S0RCb0tRT0c0WEVwc3FmTm9MZW9ramVPa3ljVHJZeGRxSExK?=
 =?utf-8?B?L1NlQnN6VEZPVlJxcldCN2hPWHllcGcwblF1bW1pZWk1SHE5YitlRUFJN1hK?=
 =?utf-8?B?TEFkOHI3djhGQ3V0bDlieU5NNmwzVVd4U1c5ZGFmSkxqRHRoQXdMQVh2czVk?=
 =?utf-8?B?aHhxUklmOU9LSGhkSHdzd0h0QjRGKzh2cGY3K2lWTzhGTHRwM0J2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6806D69E4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef796f2e-7755-4e71-0cd0-08de78826913
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 17:37:43.7039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slf9zai8+u3s8myNzBN+jWtfQd8XQoSmjtJiONMAVkNvug3v8mwKeEsEau9hvgawxHUOjssDEM3XsjOS9NjIk2jBRsTjlLsKkOY9bNi5gZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 2FD461DDEE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,SJ5PPF6806D69E4.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBKYWt1Yg0KPiBT
bGVwZWNraQ0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDQsIDIwMjYgNDo0NCBQTQ0KPiBU
bzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEtpdHN6ZWwsIFByemVteXNs
YXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTA0K
PiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBtaWNoYWwuc3dpYXRrb3dza2lAbGludXgu
aW50ZWwuY29tOyBTbGVwZWNraSwNCj4gSmFrdWIgPGpha3ViLnNsZXBlY2tpQGludGVsLmNvbT47
IExva3Rpb25vdiwgQWxla3NhbmRyDQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0IHY0IDMvN10gaWNl
OiBhbGxvdyBvdmVycmlkaW5nIGxhbl9lbiwNCj4gbGJfZW4gaW4gc3dpdGNoDQo+IA0KPiBDdXJy
ZW50bHksIGxhbl9lbiBhbmQgbGJfZW4gYXJlIGRldGVybWluZWQgYmFzZWQgb24gc3dpdGNoaW5n
IG1vZGUsIGRlc3RpbmF0aW9uDQo+IE1BQywgYW5kIHRoZSBsb29rdXAgdHlwZSwgYWN0aW9uIHR5
cGUgYW5kIGZsYWdzIG9mIHRoZSBydWxlIGluIHF1ZXN0aW9uLiAgVGhpcyBnaXZlcw0KPiBsaXR0
bGUgdG8gbm8gb3B0aW9ucyBmb3IgdGhlIHVzZXIgKHN1Y2ggYXMNCj4gaWNlX2ZsdHIuYykgdG8g
ZW5mb3JjZSBydWxlcyB0byBiZWhhdmUgaW4gYSBzcGVjaWZpYyB3YXkuDQo+IA0KPiBTdWNoIGZ1
bmN0aW9uYWxpdHkgaXMgbmVlZGVkIHRvIHdvcmsgd2l0aCBwYWlycyBvZiBydWxlcywgZm9yIGV4
YW1wbGUsIHdoZW4NCj4gaGFuZGxpbmcgTUFDIGZvcndhcmQgdG8gTEFOIHRvZ2V0aGVyIHdpdGgg
TUFDLFZMQU4gZm9yd2FyZCB0byBsb29wYmFjayBydWxlcw0KPiBwYWlyLiAgVGhpcyBjYXNlIGNv
dWxkIG5vdCBiZSBlYXNpbHkgZGVkdWNlZCBpbiBhIGNvbnRleHQgb2YgYSBzaW5nbGUgZmlsdGVy
IHdpdGhvdXQNCj4gYWRkaW5nIHNvbWUgZ3Vlc3NpbmcgbG9naWMgb3IgYSBzcGVjaWFsaXplZCBm
bGFnLg0KPiANCj4gQWRkIGEgc2xpZ2h0bHkgbW9yZSBnZW5lcmljIGZsYWcgdG8gdGhlIGxhbl9l
biBhbmQgbGJfZW4gdGhlbXNlbHZlcyBmb3IgdGhlDQo+IGljZV9mbHRyLmMgdG8gcmVxdWVzdCBz
cGVjaWZpYyBkZXN0aW5hdGlvbiBmbGFncyBsYXRlciBvbiwgZm9yIGV4YW1wbGUsIHRvIG92ZXJy
aWRlDQo+IGJvdGggdmFsdWVzOg0KPiANCj4gICAgIHN0cnVjdCBpY2VfZmx0cl9pbmZvIGZpOw0K
PiAgICAgZmkubGJfZW4gPSBJQ0VfRkxUUl9JTkZPX0xCX0xBTl9GT1JDRV9FTkFCTEVEOw0KPiAg
ICAgZmkubGFuX2VuID0gSUNFX0ZMVFJfSU5GT19MQl9MQU5fRk9SQ0VfRElTQUJMRUQ7DQo+IA0K
PiBSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBp
bnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFNsZXBlY2tpIDxqYWt1Yi5zbGVwZWNr
aUBpbnRlbC5jb20+DQo+IC0tLQ0KPiBBZGRlZCBSLUIgZnJvbSBBbGVrc2FuZHIgYXMgd2UgdGFs
a2VkIGxpdmUgYW5kIGhlIHJldmlld2VkIHRoZSBjaGFuZ2VzLg0KPiANCj4gTm8gY2hhbmdlcyBp
biB2NC4NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+ICAgLSBMQl9MQU4gbWFza3MgYW5kIHZhbHVl
cyBubyBsb25nZXIgcmVseSBvbiBib29sZWFuIHByb21vdGlvbi4NCj4gICAtIGljZV9maWxsX3N3
X2luZm8oKSBkZWFscyB3aXRoIHU4IHRoZSBlbnRpcmUgdGltZSBpbnN0ZWFkIG9mIGJ1aWxkaW5n
DQo+ICAgICBidWlsZGluZyBsYl9lbiBhbmQgbGFuX2VuIHZhbHVlcyBhdCB0aGUgZW5kIGZyb20g
Ym9vbGVhbnMuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gVXNlIEZJRUxEX0dFVCBldCBh
bC4gd2hlbiBoYW5kbGluZyBmaS5sYl9lbiBhbmQgZmkubGFuX2VuLg0KPiAgIC0gUmVuYW1lIC9M
Ql9MQU4vcy9fTUFTSy9fTS8gYmVjYXVzZSBvbmUgb2YgdXNlcyB3b3VsZCBuZWVkIHRvIGJyZWFr
DQo+ICAgICBsaW5lDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2lj
ZV9zd2l0Y2guYyB8IDI1ICsrKysrKysrKysrKystLS0tLS0tLQ0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX3N3aXRjaC5oIHwgMTkgKysrKysrKysrKysrKy0tLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3N3aXRjaC5jDQo+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zd2l0Y2guYw0KPiBpbmRleCAw
NGU1ZDY1M2VmY2UuLjNjYWNjZDc5ODIyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2ljZV9zd2l0Y2guYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX3N3aXRjaC5jDQo+IEBAIC0yNTM0LDEyICsyNTM0LDE0IEBAIGludCBp
Y2VfZ2V0X2luaXRpYWxfc3dfY2ZnKHN0cnVjdCBpY2VfaHcgKmh3KQ0KDQoNClRlc3RlZC1ieTog
UmFmYWwgUm9tYW5vd3NraSA8cmFmYWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==

