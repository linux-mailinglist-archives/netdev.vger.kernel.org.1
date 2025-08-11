Return-Path: <netdev+bounces-212413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25DEB200FB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FEC189D6AE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085D2D9EE6;
	Mon, 11 Aug 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKMCliRd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6D2D8793
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899044; cv=fail; b=qLs+MrUzuVqeyxT7msyOeTWjOe5GJbflBui+LUTeWPZQH5q6ynsy8hE1GR2un2usF7WHyoZJ6/UwLmdVvYLZCYW9lvUxJ+/flEeNTMOwxDu5r4SK3QyPTaNxte514H1BRFuMVffWQ6h5oeetnvmeQhqcs2662g7ssQyuQ1lZ4Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899044; c=relaxed/simple;
	bh=7PBSROXZIxEzAI4iaLHhLr4Vvlg6HCYmlDP2vtfcihQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BxvFhDTOG36+ktJSOqfNUiMZv9ZR0KVmNI66zW8UPL4MKBdEVYnYhR45+Std/XsYBxX0NYXd2D/SE8FpHnWzhpfFqjj2odI5eVG2bLE4iqCCq0oSTBrEyK3MZ25hhxGD/BHfc3jQVfHvQNL25hY/mtGLZKKJPmKHtsTV4P7kiaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKMCliRd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754899042; x=1786435042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7PBSROXZIxEzAI4iaLHhLr4Vvlg6HCYmlDP2vtfcihQ=;
  b=JKMCliRdMfR980BlDenTsAwmIVy7husvvMYEORec52eNWaqMclyYXLLU
   gzIv5sgcfNJrjKjBe5P0QW161Qf38BwhbnYOGe4tvZCz/DdFZThUZPBvU
   UbKSTg0E+uXpJlPAt9/4fYoad706+O3AyuRgq+w0ETm2g1/I2mezqkr8x
   3h5lOFPnUSPB87d9HVUFpt/EORjqAmAjcReylg1OT2F2r5SoVbEm1yP6S
   8soXu5+t84PqVJB5UHxZt9khXvE/1TKS5QNGMdwI1806rKHMTjpeq31hI
   KW6r3RboyK6Gn6qYotZEEwJR0x83QzpVd4NXXCb3VJSk2pbf68O9tyLhR
   w==;
X-CSE-ConnectionGUID: 97w0t4/AQgGQKhTgRnp7yQ==
X-CSE-MsgGUID: hOORg5MZTq+4wy2Qno0OLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57211135"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57211135"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 00:57:21 -0700
X-CSE-ConnectionGUID: 6jV8okIiTfqO7ua71AeT4A==
X-CSE-MsgGUID: W4BOOXeKQTC0Jpy5xaejYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170077996"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 00:57:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 00:57:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 00:57:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.88)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 00:57:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1X6H9nFjE6hV/eQU9XWanSJgum7+naG57s1sB8AM6fyNaKQsLPVOenlbrunK4lR1z5zN6zdtWsJXOQ4vSEgqHrPt/hQTrEnX5xqgoeliXMJVea2ukdsVNFksV8nJZSgHGHM7xeuEoCxpwU8/v+Os4tD6e+5KC4T7z3xIntkLkY9OxxEBbhS/Rejfg94fE8cfwm/W5VZDZ2019o06VmhnQkKWe/BqPwzHuKYrEBvNfvBTXqLVmj42thSggLi3hF72OBDFtMjyPrL5TX2abNQTDBkR/0GHvG+7nm6NoDI0kmGYSK+gbi9ahDfImyUjLFTNYu+mAJZDczCo1HYDfMIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G/FXHsE6tBHorFKi51BM8y9YZBIVcOvQOHk1Z9EQXs=;
 b=COsybCc5hd+bt59tSuIH621lDPKoIcHoFOXiRiF+2T7etsIGHfljfJxzLkSNYBvElq5+rUWxEFbG20Z4EJZX5BlkBa0rLDXL6NQbXnwi7hZg57OadpAzqfzAKxRtsCYTPA+BbmdwS2QGnij4mMJ/xX61nIWwuJtncAuBBgILyEWzj963g418e8emQt+us1uH8Zx3MIwuWZtyFgVusWls30vbEEMGzzd6/r9zf6FTXc9p8QPDCSCxNt5J9RjTZh81P+JTEFc0aAfXEQlyXnV2kSAhLmhc1Z936eJLM1H/1Oy9PnSwWSlKgQUPt25NxYirtTu43UhSZhcSC2dclIv5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 07:57:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 07:57:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ixgbe: fix incorrect map used in
 eee linkmode
Thread-Topic: [Intel-wired-lan] [PATCH net] ixgbe: fix incorrect map used in
 eee linkmode
Thread-Index: AQHcCjTvfaD/w76ynUWABb17LS8LhbRdFheA
Date: Mon, 11 Aug 2025 07:57:18 +0000
Message-ID: <IA3PR11MB89866A617FE93C0B2B4A6C73E528A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250810170118.1967090-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250810170118.1967090-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN0PR11MB6085:EE_
x-ms-office365-filtering-correlation-id: ac6c6135-681b-4ae0-99c4-08ddd8acb210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?SaYzmJR3FOUTxn8HA4aMO0SVpEvZ7DnoD3TB9apDXy5hdps27lPpMsV0Zf8R?=
 =?us-ascii?Q?VIv2yj0FXGN8AYzefGet4MhXMlkNPDHpLGsOSBRd6O3NvIe/mcORlUGtWdpx?=
 =?us-ascii?Q?ck0HEdZyF0cCWNhpmXPldw5vl3MK/RetNt25WFgJpSVREGKSM6XmeAF39IuM?=
 =?us-ascii?Q?W26IvDtS2WPvWO65I+IMN3t9o18x7TKRVwZGRYrB/Yf5H+tOSCIMQ01Yy7r4?=
 =?us-ascii?Q?TDxQmfqWTGyAPh/Gq+s+wHAsWgCMRxif0k+kx2drVvd2swqJwWaoKNznWopo?=
 =?us-ascii?Q?/Nq7ADgDrDb56JbDepcNlEELsN2yEo4jK6BevVyvsMf9bQvBS9XeT2KkWciG?=
 =?us-ascii?Q?vZb1rEW9wqtlv67wl4GPlpww8xt4LmFnNBsaR4qt1gb+El2ybf+9Cf0F7PbS?=
 =?us-ascii?Q?KXiPGPRCcRExEJYQH19qRvCLkBl7QUZENR+NeNlqChNIGX6r8lCsLAtvaqeh?=
 =?us-ascii?Q?QZMKLQyrkXGTz5bIf2gkejE0FwXb2k51qLvN+EkUDMA4YM8xThoW6Ox3et98?=
 =?us-ascii?Q?A9EYhDom4yUsmvl0yT5MAk/OqOJC2z7Vdm6YKaXTLmOOjxTNuBLtnOXAB7OR?=
 =?us-ascii?Q?QBPn7I9I+q7a2bf3hGhtCo6OPVJSGP8eAQuFP2FTRuxyBqRFCgLMhnU8VV3B?=
 =?us-ascii?Q?RBm2OdbMG+bNFvop0MHZeIxVJ8x4hLSwdYPqLRL2xNZxG1yh4DGtfuocHhIZ?=
 =?us-ascii?Q?DU6OB8lVrl6Z6X5L6S817voHdJ5XPMs5RnR1YGITL7/Lzsh0z7bemEjZl8mw?=
 =?us-ascii?Q?rUhul9AhIp9raO/qn7hRlkXm+64xSPOU8qJ9YfNSgnPQXuIG9Az1iqjrg0Ys?=
 =?us-ascii?Q?LzhbCEa75DGDbiOB0fpuSe5zDaXX3zx2Az+Q2zJ5S9olNY9LRUVrTAxUCWKL?=
 =?us-ascii?Q?PHvgeDsoeHOLypL+rseN6W1wuUtIbTWf02iK8hm4VTDCtrHkJHxd2AG1VE1g?=
 =?us-ascii?Q?UQLRmoqhwZ9NYecjKrVa0ofG8ip2R4pHZxdx1PfPhXyYrDE21Wr1qc6iw0qs?=
 =?us-ascii?Q?XkR/2GhvFpAgH1kI+srvLgwSW0TFp+DyWSyFsPFE+70/OEOV/1VpULp0mXPm?=
 =?us-ascii?Q?xF4zYgc/5zcr7LGH5SPU31doDHRPgecuRZ+QFf64jiD8tfTi/Wz+D5cLz4t2?=
 =?us-ascii?Q?bVu/NoHEm3ILV2ba8lYOxPV/QmdbVIpsYusSWOeaZIJSDYRu31X4YRodsoWp?=
 =?us-ascii?Q?AqOjGE27Pbpj+UNm5LFm3mvZTPqyGX5c+XH1NOEYEvb8P+Xm+8n7Vpa9r99e?=
 =?us-ascii?Q?j4PvE2ZkwpSdEtq5Q8OB1qTG5+yHaOwbq4ithw0CRqXmE6fb5S73o5a7FwCb?=
 =?us-ascii?Q?tTdMvl0zi5ZA19VEkZs830uXucPZxRHr4mJbN+OIWTNF/+Wlsdq7WHld8lHS?=
 =?us-ascii?Q?pB1cKbgMoK13vm8e94ioYlV/H8hzy+Homf8RrA/RbEjmaTJx+MmOtYadiCal?=
 =?us-ascii?Q?i9LQAlm9ZVIUwXHX+3b7kvYFwx6+RJsHGE8YTyYjD1ybvSAXHacKNuiw6wJU?=
 =?us-ascii?Q?O/kXZdwh06YEXt8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PlpTHhaXDevMH+Ut1Jor1QFu+fxuPdAzgkGqeqChhy198QAysZJIFxQ6XFBW?=
 =?us-ascii?Q?C1DPEsZWzbNA6I54iWKgpKlyscpYN5ha1qEMufyju27tZKwjX4DRY841K3MN?=
 =?us-ascii?Q?hA9ppQJlDSa6FhWiz9MWsX3HqbSVvZn+53CxOUkBkB7ywZxKM3fNS6xbs7ui?=
 =?us-ascii?Q?GHCQISNWVrTq1rO44viHIHuEXRpSoPtoTAwUNoNKUkI3Iic5G1+GPkAU+MZJ?=
 =?us-ascii?Q?NBBmsyX3Rd1I/JVi+g5nzwXcXQ9Hyy4SIUy7X5F1LBABcDohkAYXH5+Rasma?=
 =?us-ascii?Q?yObFF7E3V3mmMGfAyJ3jInOK7L8iIwiozbcVvKS2VzIKC2YA/wZaH30aOfY/?=
 =?us-ascii?Q?gMa46//FEjBNcSYVMR+wD2EKVh47qJ86mZk8AWpjR65OClnn5YL1s4dbd3+n?=
 =?us-ascii?Q?ezZ9c1xs3w+a/abAkBAoC+hZxarKKVHKE/3Ashq+VdzSfeTHBb5HpTBN80Ec?=
 =?us-ascii?Q?HPygbKxe7Pjv0s+NmidKeD28qhVtPAy6aMzSXOIaU85IkekPRZXZmhLVVyBB?=
 =?us-ascii?Q?+PkX7hC7qZJyPGogO7I1xSmC4PmFKeeYF4/9/VdvGwagcw7YeHW+iPhj2N2v?=
 =?us-ascii?Q?8UJA0Jodhk5R7nBqpSASOawWVEL6F/bb5YYHATQVHRXzofNs78nhinzXxsqf?=
 =?us-ascii?Q?NHT49GC/s9BQEZtNDFrNJXGrSd+N1cqD+Kop9Rq5+SYG7Ab51k6Cb5CJMSrV?=
 =?us-ascii?Q?X/fk/3eB75BTZCusbf6ssYjaW9/9PAgbNoCU4rR0WDtaECCP/hA3xMFxtrkL?=
 =?us-ascii?Q?87q/MhUBW4NGxIPwLTe5mXZiISIJsHSHqc4zg+hUo+ov4JvfBLFf9+R4PMKm?=
 =?us-ascii?Q?42tu4zNi6y0rD+axpAQdzl4AyV8YbqkwRdTKsHwgDrPlwmblXw8eawNtP33t?=
 =?us-ascii?Q?DJ6iPKkihb1ZGrA0FyDZKW4PiFFE5bW0a4YZw8hOmqFbP37CmNqfvJtY5xYC?=
 =?us-ascii?Q?c2TkmLAB/9Q4349P/XbTp7si/kJrKNE+bve/MFSiJwA3fGivPjoWVupI8WN+?=
 =?us-ascii?Q?SJaMnmDAs0cxSlUhzwRquVRL5Nejg6gBsbhqzKxu/FtT5IR1EvCzv01TcZlP?=
 =?us-ascii?Q?d4ALwjbf2DMK3cr7BXZpwN6Ibn8HqFI9OVF1uKQIh7ImFE+wHLLmRxusyEqz?=
 =?us-ascii?Q?jiuTNA33sOMz5VK7yZ9YcVeyOFeUanaA0pOpcHtHWyLkAmoUTN1ef1HIUP3z?=
 =?us-ascii?Q?xuDBKUja0ydwVigH6jqNbnZcYLKaY18udrOI1x8nY5HkGjtkv45PeRWBKIy1?=
 =?us-ascii?Q?eS3brgGXjLiFoIk6WY1M7n5joe7LfS1x05XYzx64bOvnNHvRsCrkoXQfRbLG?=
 =?us-ascii?Q?YTkbOCXczrMDlZslTIgomkTVQsrkkD5cGEJnknotw/0i8Z0RRhah5vEPnEgu?=
 =?us-ascii?Q?Kaw44oCkmMBACM1UJ1ie4RXSSFjqXC4W4fmMxeGinJEGYxNLPVifIllvhs3w?=
 =?us-ascii?Q?v2yRcNNeJq+OMYBMB9Jpg6wJf48R6OYtN3i8+7posGIHWVcpPsBKTaSjO/2k?=
 =?us-ascii?Q?Z5oR1rC09raYfHyS+aOeQ78jgOhAkirpIx/SyZqjigc/6Lakb6hJc3sIAZNW?=
 =?us-ascii?Q?A5KGQxUhdr1lWMi2OX0xFnCxLMoLOQyCAMihXy+k1MUNQAIAbASon6pcQnt+?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c6135-681b-4ae0-99c4-08ddd8acb210
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 07:57:18.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V45lwz/ExFjbH22S7tBlTbOVxAYS079aKabYJbAOKw9eCNSn52VjtpFOz3Nv7THh7ilrp0hytfkahqwi6joOMeDZNDXGyr00rhmcfsWSIEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Sunday, August 10, 2025 7:01 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; netdev@vger.kernel.org
> Cc: alok.a.tiwari@oracle.com; intel-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix incorrect map used
> in eee linkmode
>=20
> incorrectly used ixgbe_lp_map in loops intended to populate the
> supported and advertised EEE linkmode bitmaps based on ixgbe_ls_map.
> This results in incorrect bit setting and potential out-of-bounds
I think s/incorrect bit setting/incorrect bit settings/ (plural)
Everything else if fine.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> access, since ixgbe_lp_map and ixgbe_ls_map have different sizes
> and purposes.
>=20
> ixgbe_lp_map[i] -> ixgbe_ls_map[i]
>=20
> Use ixgbe_ls_map for supported and advertised linkmodes, and keep
> ixgbe_lp_map usage only for link partner (lp_advertised) mapping.
>=20
> Fixes: 9356b6db9d05 ("net: ethernet: ixgbe: Convert EEE to use
> linkmodes")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 25c3a09ad7f1..1a2f1bdb91aa 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3571,13 +3571,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter
> *adapter, struct ethtool_keee *edata)
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>  		if (hw->phy.eee_speeds_supported &
> ixgbe_ls_map[i].mac_speed)
> -			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
>  					 edata->supported);
>  	}
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>  		if (hw->phy.eee_speeds_advertised &
> ixgbe_ls_map[i].mac_speed)
> -			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
>  					 edata->advertised);
>  	}
>=20
> --
> 2.47.1


