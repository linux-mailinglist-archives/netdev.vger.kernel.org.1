Return-Path: <netdev+bounces-110854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63F92E9D6
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345291F21DD2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235415F3E0;
	Thu, 11 Jul 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv8j9Nqn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796B15ECF9
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705694; cv=fail; b=h4mDKIIJ/pTAArjM95Eaf/Zjs49nRZFCcf/hF7R7Bmr2eOlgOf886HPyZeXKUZ5SCK6Em7IXHBf6551swrGBTKIP9miZGTFHHm3L53s2LmVIwBi3uvGrSuR/wr4uJQR6dD/7OmjTDJyLofLu4SFy1+3Kqlv3YU64eXMIteaThRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705694; c=relaxed/simple;
	bh=2CnLGt/5Py7MerKhTPvT8kUL9FCYMxnOic7JYL8Cing=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J7ej5QmpA/5R2rO5FWx88HjZD0iXKsnAa6KjWn1F+V0B9pGd1uOVgsEpMIR6Q35mFlutsPq+ezcTWd32plqXZTGp70CLV16ipuD4A8CbmQhLH+I3zWJx11cGfCKC0mqNodrprGETgbxpounpErH58DWv4FHLctzDt+K4E+LMKfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv8j9Nqn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720705693; x=1752241693;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2CnLGt/5Py7MerKhTPvT8kUL9FCYMxnOic7JYL8Cing=;
  b=bv8j9NqnXITRroJKy/2KpPU9e4IDIuEufBSkZJaeTSvwZqwU0XpshoIe
   xeW0/v36QYfQbT1ZbR3ZR30MTQQXgATLbIriTjjNYOPxXwOhcOw0tr/73
   U1z1xaVFM5QzYHLUA35/1o8td0ikZ33+kfFAW003ev2t9vXV+2BTqJQRI
   kbbwvAfnc6pmaY9iQu9DWkyAH05N1WzmD300sSIakrkNKQqBr5gjhOO2N
   moPT3guFncs6JhJbobiVkzhJT1S9/1z6pXchFe4r73UdyE3UQk+XNnJ2L
   JDzyLH4dI+mqcEvG1OUNut+/cHycm2poeVEQvzfg+SQT+Uy3b6IEAmtWP
   w==;
X-CSE-ConnectionGUID: SsOYF0JfRNyT1tg5pu4LVg==
X-CSE-MsgGUID: gefLFI7uQ3aT2JuVXRmVXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18228318"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18228318"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:48:12 -0700
X-CSE-ConnectionGUID: t0nh+Qr9T7iOEGMNFHD1QA==
X-CSE-MsgGUID: md4W+SqmSKeLnQTD/bd5NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="49205356"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 06:48:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 06:48:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 06:48:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 06:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHSecL6GuKUpVncZhYvd2mWX0waiEW4dID6d9MyshHCemecn9KKFbQu4aRyG2VgBIpmXPMt44rDfH44FIKoaeZpB51z3rKyjOmJ9ZEJQPwpa8yggaEhhvyBfakgHtsugbvlSBPqRPGsLBJr3TAd72gnMM0wHSgefs1TNte9DXOORAvFI9Hy3YHHndk4pBajuAZJVO8pOI8cFzgi9TPmA6eJPJkKPL0c9hpE3cLUbHL01spyeiasCshiU4iOc5Kp9c69GL5PvrQD5sZ/wwtJhHaSqPBZ3BHGNJwyqYz/2lQiuIrnyfLAFk8EgYMsSaoEfstuWlEjHESiLQF93rqVPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncyu1A59gE0/yCjIjDqGSxH3bNo8TicUF/FjUfoeuyo=;
 b=Z3FaWZJcvajHKT6NhjYp+KyONDXVFs2CdvqwI9IKaBOqw3gZeuzz2BvrkoqqLWuKZaV4y2JhhtEW1+VJ3K1oBBk0JyXcKKumCgNHH6QhARPvQWob/lRMB2ti2OgQI0fdk4XBuC1j0f5mv1z+zoIe6zSUgs/5zEkl/oeunaa3jzLkz6vsDbZACxfLpd61Y7a0YJPwS24b4ap5blh3rv0Xt7lB4lvGn4PkkWgqY/dW8OKoVcVaxB5FQEmEYMF4SH2h7TuQLOnbZJsbH3zM5BsCKZdib+lHz1+vjIGs85Vy4vccvp6uspxEc2ZqnVt6CrHDNPwY2yjPld9SJmbVh5Zddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 13:48:07 +0000
Received: from CY5PR11MB6186.namprd11.prod.outlook.com
 ([fe80::a160:7779:5bfe:52a9]) by CY5PR11MB6186.namprd11.prod.outlook.com
 ([fe80::a160:7779:5bfe:52a9%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 13:48:07 +0000
From: "Szpetkowski, Grzegorz" <grzegorz.szpetkowski@intel.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net] net: core: sock: add AF_PACKET unsupported binding error
Thread-Topic: [PATCH net] net: core: sock: add AF_PACKET unsupported binding
 error
Thread-Index: AdrTmOy3j2HXYBmKTiOYlXlncLPlLg==
Date: Thu, 11 Jul 2024 13:48:07 +0000
Message-ID: <CY5PR11MB6186C896926FDA33E99BD82081A52@CY5PR11MB6186.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6186:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: 00538dda-8d53-4990-ace2-08dca1b0188b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lGhbxyAxfuqe+h9rnLZ+PVqrU9rbbS7znmcSEm3yTH7XgHFzdbokVlHniP6r?=
 =?us-ascii?Q?EijkwU3QpRWho77lFVppTQ7mlgARaxJ0FxW9Eq0zfpcGesnG20/sNFrWmz8W?=
 =?us-ascii?Q?5PPuK+4iBdOU8c6Wn93LhxvO+MUuWC4XZL8oK+yjSY97SHObKMX4gFKm2AVr?=
 =?us-ascii?Q?GU34Z9jB5YhB+RdBHWEwywCoF+2HxAnvs9VNB1mzshOL6wUZFA6DdTVIwciJ?=
 =?us-ascii?Q?Xqhbv7LztaWIGIbLMFOc5zwKGW0Qfx/uVMDmKiW9GoSuGrRwdQaRwAzUA6uh?=
 =?us-ascii?Q?VitessWGXRlr3vdVxf4kQCuOV1nTZpS0BoiqPAzwykDeiFO9ZN76lJ/2RXe/?=
 =?us-ascii?Q?SUMG2g4g5WLr7MWRtR5pRKdi71Fd7It9wpAAHT1u3nz2hf59445bwHA2zgS0?=
 =?us-ascii?Q?N/vKwI9LpRLsTOlEssIsbbT9uWuFMpzFJxmfYEenrsfV0DhtzCqbF6iHw3YV?=
 =?us-ascii?Q?uB/Y8FeNW+vyAjebpYW9/XkFgpokFdxGe9DxiNBTnMHJ0JeXNQVgIyrDHekS?=
 =?us-ascii?Q?fkhqsGMPDQQCXsH0i7DltHxBodKavS0TRO7eJb/yuVzGwM6y7xXKbEfZMd71?=
 =?us-ascii?Q?sf2netBS9wtJKBGqUv/azaJqqbGvWlICe7p6e5kTIwxSGJgsI2YwUOQLHet1?=
 =?us-ascii?Q?5qz9EixrsFuNPCtMDGb6a1bZUwuPxr9CTsge0PcJkTrhGVa60Wnj7rDKvGg+?=
 =?us-ascii?Q?yDupkutbguyOkLd8jvzlO8C3Hko2ssue6DYDF5bFIcMujqSoDSnoJK40sMsS?=
 =?us-ascii?Q?2CDTO5XUirzyjqmTSAxmuM9ajoUKHLusma6+p4ldAFe8PPQZzwfa8zoV+6a2?=
 =?us-ascii?Q?GrzjDpM85pBgJG71f5dno0Vea1hDd+z1u4/84T1ZN+HsUFKjnleJLCHf427X?=
 =?us-ascii?Q?s5kGdltK4NVeoGUkgQ4RW8DqvBL3jn4PJc0RKAGUnQIDdDwgbSUBwqdBLPqQ?=
 =?us-ascii?Q?TOUwhPU9AnvzTeKLX4TBRPnPi2zjyok1wHddC/TxjAg37BWAE9YurQMwZ4go?=
 =?us-ascii?Q?SG3W+s8KwSPChR4GCOpBTgS7iQ1QDbLR/LySIRQ4C/eRzry7OFgMT8L8FY3J?=
 =?us-ascii?Q?q4P3AyXI1G0OQSUgqn5coAfMaY0yIyYL2UAg4XxkqaiNZam+TNPlbpf/1Q6V?=
 =?us-ascii?Q?zGOeJIA9s86cnZkZwqgkxYJm/YTTFoLvGnX6RwDNBELsx3BRosdNAGD/c9Qt?=
 =?us-ascii?Q?iHWh2hI/v1jP7G3hPu639Smzd+dRyx/VhynZ/tZTEsFJPc+UyhbMjdqbijZv?=
 =?us-ascii?Q?nijYu6XU2+wCAcPN4t7RVXqZaKrhRPKPPMXD/bufmF7/fCnX9I1vBWJrN6F9?=
 =?us-ascii?Q?mCci22PgrbLKQMgIk8JrZ3ucKc32t7uZ/C59FsyWBX4yukkyoV31/pk8aZi4?=
 =?us-ascii?Q?YYAo1uspBgxPK3E7NrIL/0f3wMMnl7Zle0ZzJULBlr8fsIB/kg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/WAwD+AMaH9fCSCnrqbjurFQzYJSvEd+Y1Ao6QKJk8VOXsV/qlKKmtxoUKmY?=
 =?us-ascii?Q?edpqOcaxAszdwRv7rOOSQ34m6HrtCI4xMqb+UXk1fc80iQmwcRrRakzv7uF8?=
 =?us-ascii?Q?UDw/z5nYpJ3Y5toCWyQuxpfYT+VmLlBURSZAnvfBfZLrR0kgaBzw+FFiScHR?=
 =?us-ascii?Q?PBSXrjUwJh0M9ekXiZuNbESCDXZGUNu8AbGE0jk6InwlhrPiaRI3Q2m9mduD?=
 =?us-ascii?Q?7+CZoBlCwOXPa+q//97jIFqAIeOsy5DSTPfJFSqTcnT0OcLJ+Np0Lp8rOCSv?=
 =?us-ascii?Q?kUbkajeyWTtxThHBmD0+0z+18O73kXxiwF8xU2iD6UwQfhIcmqCyD4J80jud?=
 =?us-ascii?Q?PeWxuRZnXQTGTsQWz01AaP8EpsMr++NvHq6DSFeLmdWmok3aHP82tB0rlpXm?=
 =?us-ascii?Q?w2g3FGQOEPH7jXsLnCWgSUY/7tjbpa6fo4z/6atcNh7WkS/JQaULdBEE34G8?=
 =?us-ascii?Q?9kzlvKhTAzXPUmWmtTbeaBF3usB1AyBgoR7cHyxj7uEA+g1v5CoTKkRnnXMs?=
 =?us-ascii?Q?f2SQ2XgxAVsOe/kcznZ5RzVh1HYC4lSht0mcNi/mIH577GW6a9hYZlWZdQ/i?=
 =?us-ascii?Q?ox6X+GkvpoQXhy4scxUqN1rOQxisV5hH8ceh7EekC8iaIVhBcXp8B/UMPul4?=
 =?us-ascii?Q?u4Pm8Iq3zLarusTECgRgN/GVhfR5t1kQplNQY+27bSvyzOgC+UgtQA38K5A0?=
 =?us-ascii?Q?p+Q9lj858GiM11xMku/SZCTavZVgdp0AvffkoMZnQV1xG3W1ppzpnPBrilQj?=
 =?us-ascii?Q?B7F1tY6Cgjr6rKBhfk1sbwUdz4Cp1OfuJBvrBzS5iLdAebx95J+i4Ns+kH/6?=
 =?us-ascii?Q?b6fr/HAZr4Uy4bprLlcPfTroQvyCwrYdkVXP09cuNtzUeLadGmXMvvuQdl+9?=
 =?us-ascii?Q?e8tpS6SeqnSl5ppX+n8MJocyb/hneiS5kFcux7ZxDpK5tuWe75Cgk8c3Vgrr?=
 =?us-ascii?Q?rXT0neAbbI+CvHNJ4m/JEW56KpvUUNurRBuAeFqQBChVkfHGWzZOR9mC9x8W?=
 =?us-ascii?Q?uRLFY/QWH1Az1e6Ipy+Q5top5pTcxFm4oU1/30IJ8B62lVrR3UBg0oFZFlOb?=
 =?us-ascii?Q?uqfO7FZ7Pva6YhfaB7A+eAgqWnt1FyhKCaGgDMC0x9r2phdhwOngUSdD4b4t?=
 =?us-ascii?Q?1cKPvYJdSOoKap4dzLewz/xMU38+BRP6/P9H79exKCDNVa7mFOkpV04/0i1f?=
 =?us-ascii?Q?dhhLiACqUg6hS5p4rFG0Ak0yqUCTMOTafyUQhZDiKqu+MoeqV1uRbfnzWCxC?=
 =?us-ascii?Q?8+F48olLriJyADfnkT7BgjOuEFBcqX4pw1Npdo+5U62s0r+y95YfhOaPNwzQ?=
 =?us-ascii?Q?ywsdQwAVISfclV6FkyM3xfaC+6ZLeEfFK8wNqOkiYN5qbHaH8l10eQLmyHyY?=
 =?us-ascii?Q?BSRRg0WvJ4LZedrTggDKJInwTsrN3DugxG1nb6KURAcK6laA6ahu3QA8EcSI?=
 =?us-ascii?Q?qQhbZuatLoFOSn2Unz8G5QRakfo0w4xbVpP8zNWiIXL862DYGZQZLXMBxxUF?=
 =?us-ascii?Q?6M8DSIoA0HSQLzy9QTnYRUOCA7xH0jPtXTz7S/Dph8nOghcRy/C4xow9LBTX?=
 =?us-ascii?Q?QNKXQgbhlHiTCJx2Z/4RXYqPX5ZofSjR9tkOlwc4GXpkpKeysJevCOmYUPtD?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00538dda-8d53-4990-ace2-08dca1b0188b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 13:48:07.7278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nte7p3WOEU7kjfcibJ+DMYWzeV6l560+MJmrel8hnTqGO/XrbG8lxUkVhG+2JKUmCTFYUHtSl8+vWjsKaIbBsWQ05IfudK9W6qFPueWoc80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable

Hi All,

Currently, when setsockopt() API with SO_BINDTODEVICE option is
called over a raw packet socket, then although the function doesn't
return an error, the socket is not bound to a specific interface.

The limitation itself is explicitly stated in man 7 socket, particularly
that SO_BINDTODEVICE is "not supported for packet sockets".

The patch below is to align the API, so that it does return failure in
case of a packet socket.

Signed-off-by: Grzegorz Szpetkowski grzegorz.szpetkowski@intel.com
---
 net/core/sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 100e975073ca..1b77241ac1f7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -639,6 +639,11 @@ static int sock_bindtoindex_locked(struct sock *sk, in=
t ifindex)
 	if (ifindex < 0)
 		goto out;
 =

+	/* Not supported for packet sockets, use bind() instead */
+	ret =3D -EOPNOTSUPP;
+	if (sk->sk_family =3D=3D PF_PACKET)
+		goto out;
+
 	/* Paired with all READ_ONCE() done locklessly. */
 	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
 =

-- =

2.39.2
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.


