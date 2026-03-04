Return-Path: <netdev+bounces-263713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHYRNqAEqGkRnQAAu9opvQ
	(envelope-from <netdev+bounces-263713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:08:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A801FE1DD
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A1F8305467B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65D372691;
	Wed,  4 Mar 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+mtOZ2n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F739F199;
	Wed,  4 Mar 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618851; cv=fail; b=FQlOhkUDdpEGqwBQ2l+iHZcG25QO2HwOz51uwH5OPfaz5EzK5hW+25DgvLTZ0hjJIAiYixIWTzfGwq7f2cVpAt7ujg4PV0w4bFlioqAZBorw5rrAhcWkWXvKnWZy3CDboDBmicZRHRCLL/wt94FCt0u+DI/1YvpTUFKo3ruX5xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618851; c=relaxed/simple;
	bh=0fWo3OrOhf0NMvp/sO55cN0BqHRVhn8Ec9EvtgkxGBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VDh/ZFig20QfPifRSMkPwThlnerbvry/qoN1X/0Rs5Y6mCAjygyBRvyw3EP+8CRukGmXNdQCMAAbaTlnuG9OOULDGJKG0hjyNLT0zJnv2m4qteyH4nCbEVShTIU3LcCNqEqjr6BJOfZ23Xney3qhVl9T3DIOyz5cllSV4ljfE3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+mtOZ2n; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772618846; x=1804154846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fWo3OrOhf0NMvp/sO55cN0BqHRVhn8Ec9EvtgkxGBE=;
  b=V+mtOZ2nNJiWvjh+a6IfZ3uHiIdurdaFkKAQgOwZfmbBJ5JgSNurFf+k
   xGSHwUu+N5PVBtUQghZIsTEoh07gK8n7fX+2FVKUs6Zgl2GvXnYfPuq17
   H1jNZgIg+WiSJ6Evpd/ghfL+XEUULPdcXcWq/T5AMAUG3pEGBlVPkQ+xB
   euy/Fg5HskTpm/2rKKsyREws7LvtbhwcjtZ2m1PthckdxqtGXq3VNUtaM
   lfOB/RhL3jVBRR2oSEcKW8C8LIU22UqVrIF6DfPkI7BsQ/INwIG//pxQS
   kCgj8gH0inHIKzqx6lcM6CCjTjLxw7PiuPpE+6WOBVQ2RUOZ+FIjrycIw
   Q==;
X-CSE-ConnectionGUID: qXBihBL+TF6wD6V/Mj1NKg==
X-CSE-MsgGUID: dWSm8Lo+TCefFD9l3daSiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="61250079"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="61250079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:07:25 -0800
X-CSE-ConnectionGUID: TmDlv2NYQ1WbDLUTw/xHlw==
X-CSE-MsgGUID: 5R2Pmh04QZyFAoWqrFVTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="218401526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:07:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:07:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 02:07:24 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:07:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7cdIBCfMYulqyRpYNk7S99s7g7LZ4AqTxWj63dtQCeqJ7QPg4ODwDTf7GQTITDoLL1mMAcBqyBn4obgL0iovc1WV+0yecvGbeim2p2SjtITDagctayOYvoY+ubQJD/YTdatZqk1Ao4CTGGmlIb66POMDvh+393XeSZbYidyz0L/2ROVpz7/T+qpLUZ3f/eY+6soIW6PzIEy2zXOWYxKZ6JhshGLM3QR1FTNE+f9DffoOdmU9L99IIYtRReFoHUGElSvvuB1AxqYkaiWJukRCFJhJ1yXQV7bpSjb1CfC+9TlIvNAA+oLtlAUNvuI12Z/3kWOF8kHuzuRkxsXBhLVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fWo3OrOhf0NMvp/sO55cN0BqHRVhn8Ec9EvtgkxGBE=;
 b=uYsTOpwP2PMyuLIH6/3eaLZUp/p5d4uTpXZcv12HSMhnz4tc8+Hn/9nQ7aU1YfRnZbStkiMk56lKypjmZtxebfc0kx6pqbFFrigC64RcWKUa5ybJNNX86EuinqFXvGkQLhH9fh99PbSeFIYHEhw1c+H0Z2Jz+AD+7YT971vLpsIxDZ++OBEV5X2SIH+70tYpYtod/YWvnU6uydhNGmIKB8W78NxiD2GT80O1cue1Qi5RbmMTzQqK9fUaFaZ16aNgu0UEftacMFBluyX6veSBCoMmJxNPw3ai7HHj+FH4nxsWmc2UNAcui7o2cpkqtxu26RUpveVLmTD7QhtviLtCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:07:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 10:07:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "maximilianpezzullo@gmail.com" <maximilianpezzullo@gmail.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joe Damato
	<joe@dama.to>
Subject: RE: [Intel-wired-lan] [PATCH v2 2/2] igc: fix typos in comments
Thread-Topic: [Intel-wired-lan] [PATCH v2 2/2] igc: fix typos in comments
Thread-Index: AQHcq6enqhUq/9VQKEaEqjeDhreIxrWeJf0A
Date: Wed, 4 Mar 2026 10:07:17 +0000
Message-ID: <IA3PR11MB8986683BEF81BD5A9361649CE57CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-0-b6a9f1d336ff@gmail.com>
 <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
In-Reply-To: <20260304-fix-typos-in-comments-in-intel-ethernet-drivers-igb-igc-v2-2-b6a9f1d336ff@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: 33e9c265-f144-4736-01fa-08de79d5d0e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: VynM/3wmB+2cywVB0luu9xyIkgJ0JtuESwpNUEMxUB2FXx/JgHD3L1hZlEPmvYq5d9BzkV5J0KZE7F1nDJOwMw5ALcvRZNah/QRO/Een2YnpGLEHwINJ7Z5OGbBA5Q76MdsVuX3FHm3IcpVfVDfB91R/U+KOMMr2oEY/tN+KTqVdEY6uTq7hTqr4JcGtVEq65OjWLlDYjk2hWVxCcpLkenBUGU7NizrZdBm+eFlS3Mv/BUMhDdm058G1IKe40x9GgWXDk0IDV43kLjC2U+LMIP4qI4ApwdnHBnH1ozZnvoe8b9zqzmJ4dTk4DNXzCoLblX8bJs9AD1raRGfor94WynzFfr5wgOEIa7q9rMgz0ZHrzhX8JwK7jg+X56Rr9fxJSrJCwDcdspoiu+Or7C1lgraTttSPhkUeizYIk02sZYPNp3jnraXR3S8upnkzqmicroQABdBw1BSZV3bvwzNrDclYzVknGrNxGpmkXUBzpfhauYw4mOiM0jclBJejc9EhsLFiEc5IOUIV2dCguWCsy3kGjk15QTw2yRG4M5Tp6x0kvStwll+C7FZ/hyazGTbUIcqwPFHdNv+bW1DARR2zBCIvi1ElngxH/GEZAkC5MOQ0Woxqg/6Tm8VXTv8rg2v5IuYKPXrkmLyP7xoMIU6cVgen0fik1KZFb8v0nX9DpKGir6lDBNmFONgrQageFtjBTWvYCKRMx2YT7eVE8CthzXLR2ApMYFlM+6voDmAtTk6OG6U03f1z7RF3/6JBmMxZwwMIcZz3wW8tCxXwymy0zX+J6bRqdOKud1nq65nAiGaig0RG0IRQviXf5zsYIIv2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9neGc4RXNiOXBjMjJVaFhCdVYzQmJySmlvYWhWTXlDSDZ1V21OOGY4aWF1?=
 =?utf-8?B?ellXWEMwU3NURkdwY0xCb045djFBVDV3TWR0U3llWFBCNGlHVkk5bUR4eFpU?=
 =?utf-8?B?T3Bkb2NIeS9PSHVZcCtYREc0Nk5MNU83YzhTWUluNVE2c2VQc1NYUVFrVUtQ?=
 =?utf-8?B?aTBBcGNqeHZiQXpoRmVlczhwdXVxQU80RVJNRHBvb251SlpoclVIOEVya2Jv?=
 =?utf-8?B?VlhRQ3NoUFl2V1BnOVo3VkVOeVBkQnNGT1JlcG5IVDlhb3llWkM2MHE4T3Fn?=
 =?utf-8?B?Mkc5Qnl1OHNNOE9LenAzaGl5MGV4dlhZZ3gyOFRWRlo0bnhZeTNyMmdsbkhS?=
 =?utf-8?B?bmRWTEtEZnFUeS9IbWQyZmZQcmFITnk4a2JlZitIZHBEQTk4N2lXK0o2UElY?=
 =?utf-8?B?SkFpcG5WcXlUcHpTSnNZSWEraUVyb2ZFNUNLZU40aHJ5dHNLeFQvbHFOaGNV?=
 =?utf-8?B?SnJ6SHhYeWFibDMxVDJnM1A2Z3k0Qk1Ha3p1SWtaS2t3V1pnWUlEbDZac3Bt?=
 =?utf-8?B?S3NocE1aT2hkYThNQzB1UjRoNWlGb0hFcm85c1RFWXJVS3ZsT2J1ZFp1Q2Uv?=
 =?utf-8?B?dXNSWW9nY1dUTEFhT0ZkQXcyU1VQSG5uZVB5Y25pRm5mSHNhdWx0cEZSc2ZL?=
 =?utf-8?B?NGU2WE4yTC9rV0NVN3NnVzk4WTcxRFgzY3RrVVFkU0NVcFBhRHhYYkJjRDJS?=
 =?utf-8?B?dWNMZmZsZktaV0MxRWF4V3BlbFZHYmJCY0hGNEdjK2E3NEdRSmlaWUpBZGdM?=
 =?utf-8?B?WEIxY1RORDg5QWdxT0lLTnVsTW5OVHBvYTRNaE9NY0dQSzBSUFZFQ3AwUEF5?=
 =?utf-8?B?cnJQR01rN3FYeGE3RVl2NDFFSzh0M016MkxWYVBCbGF2K3duQ2FaUUZmcVh4?=
 =?utf-8?B?eksySGhpN3VHZzF3NWdoTmNrM3RFaG5wQTRmbFgvVGxWNEZJRU1zRmczVmxW?=
 =?utf-8?B?aXU0VnptTU43YUNpTytHWjg0TnMzdkYrSmhsOWVIc0hYVlFmODNrMFNLOENB?=
 =?utf-8?B?MHpBRVVxcHpUeTVaa2RqTW5OeWRxNE1tclVhc2ZPSlZ5RlFUek5vR00rM09E?=
 =?utf-8?B?N1NGTXljclZvQlNPTHpGTE1uVDhYVXJGV0xBQTBDR1lLdzhjQTJlQXdJYVUz?=
 =?utf-8?B?YmNDejAySmlaUlMySWEvYnNjeS9nUDdIb3RTTU1XTlpUeUdpQ3B4MWdXK2RY?=
 =?utf-8?B?UjJzVEVSUkg2VTRGOHFFSlFIQ2N2SlB0eWNldU9oQS9FTzltM1N5dUxEdXRr?=
 =?utf-8?B?L0xPZFVCRytDaWNpV0xPU0ZZSkpra3NVcFFiaFF1TFd5aTJWUXJQd0hiZjlV?=
 =?utf-8?B?YkxEditLNXdqRGpzSDFsR1VyeGNBUDJSQ3FQU1NYTHFVbHVQMllTZHFFZGFP?=
 =?utf-8?B?N2dLanpvL2JybDBPdGF0Z0lYOGR6STdCbllKSVMvZDl3YlRWZ2g5QndCNGdt?=
 =?utf-8?B?YXZFU29ZQUNlL1NQZjByY281YlVzYXQreTd3cGVVUmd6cm9OU3kvdFV4ZjIz?=
 =?utf-8?B?dkY5QjZlRWFJWEZXMnNaMlJYRW0xV0cvRG4rSVc4UzBhUzFRR0lvTXVTdTBG?=
 =?utf-8?B?aHMwZzRaRVpKdEp6VXpyc2Z2TzF6T3JZWmFOdmpSalh3ei9IS2t0dFFyQXFq?=
 =?utf-8?B?cjlKOVREK2tSUmVhQXl2Z1oranIzem1ZVzI3MUx6Q2pIcHpaZjhQZ1gyMXJk?=
 =?utf-8?B?L2JYOFl3VkN3aVhRTXB6c3FSeWR4QnNPNmw0NEp6c24wQ1F4WGFNZnRMZllI?=
 =?utf-8?B?NzJBRTB5WTNIY3lTNUkyNGxGTVN3d2RUN1dLNjFING4xMmZtQUp5LzN3aXNU?=
 =?utf-8?B?eEk0RG4xVHpYUDE5emhXZEU2RklKWTlheERyTTVyZ25qN1RjbVF1OGxZTEk5?=
 =?utf-8?B?a1JTNGY1SWRNd3E4NWlURkZYaHZ5eWtuL3p2ejFlY29WUGZMZnRPUU9FQzJr?=
 =?utf-8?B?eXRSSHpFQXNJYmt3S0ZVR3RaREZxQnlwZC9mT1NPeHA0NFZra3B5dkkzVU5Q?=
 =?utf-8?B?SHM4NTZraFpZU1ZZMW5zeFdMTDBjN2xObXg3NXZLU1lRT1pIN3RrVTNZZ0Fs?=
 =?utf-8?B?UEUxaHQ5eEhoNFozTUdYN084ZUQ5OUwvZ1BWQUczTDR0aUdSUVNHb21WN0Rr?=
 =?utf-8?B?VDVZbG9BVGFmYURhdVQzenpLdG02aVp1cFh6SDJQNDFOREoyRDFEQzdMY05S?=
 =?utf-8?B?SC9YYUp1S1F3MldoZEwydkRSY3JvdUxIcllVdm5hWEVtSlNGdEV6TkVRZHo1?=
 =?utf-8?B?ZGlOOEgxdCtzLzdZWjZScUFidmV2VG9HRHBIenZMZW5URGZoUDgyeWFOYWFS?=
 =?utf-8?B?UDk3QmgvMW4vaE5XL1ZUTkpNRDM2OEZSc2lGTnE2MjBidTU3WVZtRXJpU1Q0?=
 =?utf-8?Q?8Pt0JZfE+HpKe5iU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tuyAYBLYs7x+yS8UmfeVDhdgpvdDXZrw3/tFOdAZjNTMw+K8S4xtswhSkfoWVQ/PUlzc+cfOhpLQmlQ0U6GYOx/hk7Cn92WGMvJu95EqEk5Njmj/0K1xOXtLDX14gkt5m0FNtG25xxcLWGZD806f7/KUoU8unHX60j1lRjSaCsaJqCudYwYgkUQvOyQeUabg3Us2ZMtFmPFVx96cNg9h/PkyywB+11k5H94CfcquY0f8447f8IFxQYYmx5oxYuZvUG6RKNls3LjagtZjmq7ndqizhJ1qY/WkSjKTDelrMb8Bzbl8YVqIfxQDhr6flVBxs6f/O5U4tqK64oXOyE9e8w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e9c265-f144-4736-01fa-08de79d5d0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 10:07:17.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zt/OqicdUuc3/tDqqQ4lsJ0DF6cdudCvPXjRIyia4KL36r3rMkQdtbCAlR82LF1rnwSzkHtt9i/zRE/5uIIeG17OrOrBSeC0SVjGezDJkWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 51A801FE1DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-263713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF4
aW1pbGlhbiBQZXp6dWxsbyB2aWEgQjQgUmVsYXkNCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA0
LCAyMDI2IDg6MjEgQU0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVu
QGludGVsLmNvbT47IEtpdHN6ZWwsDQo+IFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBp
bnRlbC5jb20+OyBBbmRyZXcgTHVubg0KPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQg
Uy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvDQo+
IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgSm9lIERhbWF0byA8am9lQGRhbWEudG8+OyBNYXhpbWlsaWFuIFBlenp1bGxv
DQo+IDxtYXhpbWlsaWFucGV6enVsbG9AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2ly
ZWQtbGFuXSBbUEFUQ0ggdjIgMi8yXSBpZ2M6IGZpeCB0eXBvcyBpbiBjb21tZW50cw0KPiANCj4g
RnJvbTogTWF4aW1pbGlhbiBQZXp6dWxsbyA8bWF4aW1pbGlhbnBlenp1bGxvQGdtYWlsLmNvbT4N
Cj4gDQo+IEZpeCBzcGVsbGluZyBlcnJvcnMgaW4gY29kZSBjb21tZW50czoNCj4gIC0gaWdjX2Rp
YWcuYzogJ2F1dG9uZWdvdGlvYXRpb24nIC0+ICdhdXRvbmVnb3RpYXRpb24nDQo+ICAtIGlnY19t
YWluLmM6ICdyZXZpc29ucycgLT4gJ3JldmlzaW9ucycgKHR3byBvY2N1cnJlbmNlcykNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1heGltaWxpYW4gUGV6enVsbG8gPG1heGltaWxpYW5wZXp6dWxsb0Bn
bWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19k
aWFnLmMgfCAyICstDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5j
IHwgNCArKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2Mv
aWdjX2RpYWcuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZGlhZy5j
DQo+IGluZGV4IGE0M2Q3MjQ0ZWU3MC4uMDMxNTYxZmRjZTQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2RpYWcuYw0KPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2RpYWcuYw0KPiBAQCAtMTcyLDcgKzE3Miw3IEBAIGJv
b2wgaWdjX2xpbmtfdGVzdChzdHJ1Y3QgaWdjX2FkYXB0ZXIgKmFkYXB0ZXIsDQo+IHU2NCAqZGF0
YSkNCj4gDQo+ICAJKmRhdGEgPSAwOw0KPiANCj4gLQkvKiBhZGQgZGVsYXkgdG8gZ2l2ZSBlbm91
Z2ggdGltZSBmb3IgYXV0b25lZ290aW9hdGlvbiB0byBmaW5pc2gNCj4gKi8NCj4gKwkvKiBhZGQg
ZGVsYXkgdG8gZ2l2ZSBlbm91Z2ggdGltZSBmb3IgYXV0b25lZ290aWF0aW9uIHRvIGZpbmlzaA0K
PiAqLw0KPiAgCXNzbGVlcCg1KTsNCj4gDQo+ICAJbGlua191cCA9IGlnY19oYXNfbGluayhhZGFw
dGVyKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2Nf
bWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4g
aW5kZXggMjdlNWMyMTA5MTM4Li5kZTNmM2Q5NWRlMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+IEBAIC0xNzkzLDcgKzE3OTMsNyBAQCBzdGF0
aWMgY29uc3QgZW51bSBwa3RfaGFzaF90eXBlcw0KPiBpZ2NfcnNzX3R5cGVfdGFibGVbSUdDX1JT
U19UWVBFX01BWF9UQUJMRV0gPSB7DQo+ICAJW0lHQ19SU1NfVFlQRV9IQVNIX1VEUF9JUFY2X0VY
XSA9IFBLVF9IQVNIX1RZUEVfTDQsDQo+ICAJWzEwXSA9IFBLVF9IQVNIX1RZUEVfTk9ORSwgLyog
UlNTIFR5cGUgYWJvdmUgOSAiUmVzZXJ2ZWQiIGJ5IEhXDQo+ICovDQo+ICAJWzExXSA9IFBLVF9I
QVNIX1RZUEVfTk9ORSwgLyoga2VlcCBhcnJheSBzaXplZCBmb3IgU1cgYml0LW1hc2sNCj4gKi8N
Cj4gLQlbMTJdID0gUEtUX0hBU0hfVFlQRV9OT05FLCAvKiB0byBoYW5kbGUgZnV0dXJlIEhXIHJl
dmlzb25zDQo+ICovDQo+ICsJWzEyXSA9IFBLVF9IQVNIX1RZUEVfTk9ORSwgLyogdG8gaGFuZGxl
IGZ1dHVyZSBIVyByZXZpc2lvbnMNCj4gKi8NCj4gIAlbMTNdID0gUEtUX0hBU0hfVFlQRV9OT05F
LA0KPiAgCVsxNF0gPSBQS1RfSEFTSF9UWVBFX05PTkUsDQo+ICAJWzE1XSA9IFBLVF9IQVNIX1RZ
UEVfTk9ORSwNCj4gQEAgLTcwMjEsNyArNzAyMSw3IEBAIHN0YXRpYyBlbnVtIHhkcF9yc3NfaGFz
aF90eXBlDQo+IGlnY194ZHBfcnNzX3R5cGVbSUdDX1JTU19UWVBFX01BWF9UQUJMRV0gPSB7DQo+
ICAJW0lHQ19SU1NfVFlQRV9IQVNIX1VEUF9JUFY2X0VYXSA9IFhEUF9SU1NfVFlQRV9MNF9JUFY2
X1VEUF9FWCwNCj4gIAlbMTBdID0gWERQX1JTU19UWVBFX05PTkUsIC8qIFJTUyBUeXBlIGFib3Zl
IDkgIlJlc2VydmVkIiBieSBIVw0KPiAqLw0KPiAgCVsxMV0gPSBYRFBfUlNTX1RZUEVfTk9ORSwg
Lyoga2VlcCBhcnJheSBzaXplZCBmb3IgU1cgYml0LW1hc2sNCj4gKi8NCj4gLQlbMTJdID0gWERQ
X1JTU19UWVBFX05PTkUsIC8qIHRvIGhhbmRsZSBmdXR1cmUgSFcgcmV2aXNvbnMNCj4gKi8NCj4g
KwlbMTJdID0gWERQX1JTU19UWVBFX05PTkUsIC8qIHRvIGhhbmRsZSBmdXR1cmUgSFcgcmV2aXNp
b25zDQo+ICovDQo+ICAJWzEzXSA9IFhEUF9SU1NfVFlQRV9OT05FLA0KPiAgCVsxNF0gPSBYRFBf
UlNTX1RZUEVfTk9ORSwNCj4gIAlbMTVdID0gWERQX1JTU19UWVBFX05PTkUsDQo+IA0KPiAtLQ0K
PiBHaXQtMTU1KQ0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

