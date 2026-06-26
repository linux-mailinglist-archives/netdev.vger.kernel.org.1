Return-Path: <netdev+bounces-302183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ii7OAH6DPmpzHQkAu9opvQ
	(envelope-from <netdev+bounces-302183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E256CDB57
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Uz1Zkxrl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302183-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302183-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 143AF3044ECE
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0F3F7A8C;
	Fri, 26 Jun 2026 13:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044C3F7867;
	Fri, 26 Jun 2026 13:43:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481396; cv=fail; b=Z867R7jmFrbBiie9rXah4J2paq95qVCl6d+FXN+MHGYZmgfVhQarsciKemzt4jLQDqkYRKuAGBqMmnHNMYdVPwhClhDmKCKYsMwvhLxeoet4TQYO95KJT0fh2ow38CuyI+9Q/NErpxUCHEpqb5BdeNuXmnAmmOgpr1r3xTtc3d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481396; c=relaxed/simple;
	bh=ms3rQN2xSleCI86t3dp0P7JEmTfiD/+XY40wR++ePCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sL2MAY7Yx7pBEInvSAI2V0ou9/EFkTEeORLfTRBOdKThD+nFBWIm1hxde/uelFy3i47Qrt2DDqxVQ4I2uNby1W0wFoqx985/6qPk+ZL/UvflpI4p9AZjQQ/cs+ENcLhxhoFgeXP5WEwZ0hOygnwnqyV5rGNxSsDY6lc6KED5vy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz1Zkxrl; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782481394; x=1814017394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ms3rQN2xSleCI86t3dp0P7JEmTfiD/+XY40wR++ePCE=;
  b=Uz1Zkxrl5Xmgar0zbitZszZQekmVAxarybgZTfqm/ptT/p0ae7Q5D6dC
   kXSUQebCcXX0ReyDdX4X5ZLtb0e1G1LdcPA9RdUb9cGj5FElVmhbomq95
   mFMKMeBWnMLHwlqVpcSqhCKVIHP/5m3FmrIXzeDAg52Qr22MhvrwQc4k4
   A2xiHHGrQvpUhcybPPiZ6t4MbK0igbxaJLOoeoo8OqnaUikhV03t+rz6H
   hjDdtwaUqAVMDEr+8ACV2x0xwPsibJY3Wf0fPV932TGkpIZBCeaaiZ/og
   +loO/1/UhRtR/bHhKrFrLspPop8MaOl4eteE+Y4Mw11PPtl9rAumDvkVK
   w==;
X-CSE-ConnectionGUID: JNZ7SSSBTNqEb9B0gUEbMA==
X-CSE-MsgGUID: WgXEPxQgT76nLi9lrIsDog==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="93860775"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="93860775"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 06:43:14 -0700
X-CSE-ConnectionGUID: cwtDbVLlR+ulSe0L8GoT9g==
X-CSE-MsgGUID: ZRWm6wNORz2yd0MUMd84Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251984110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 06:43:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 06:43:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 06:43:12 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 06:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqNZD5McHM7hjjpzzOtCBYpU5218Q38oEpfMs9YIhbsF4HwcICxXjdZCyH+K0WHgriF6kV1BSJm+2DlA+FL+lhjNEREI2pf9/3G6fV7nHH9pUfLX26JVWJ45UVFR/QWVgUhmss00NItf+x1f+9JfW5jMFGjDHdpbkCc2oeBY8EDGlW4x2I2jPtug0RuSSVcazz6tS9rfKFfkOcBrj56fCK7mY81EpwvSyV5w37GMIA1lN/Q/I14GpDVuwZk39K+1zyg88BFbY/hPBfXs/9YrHO5nmVv6lP0JkLApsH+wfXf7k9Pqzqf+fGPoTIK0U5a5iruoSxOC5h15eC5QOJ1tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms3rQN2xSleCI86t3dp0P7JEmTfiD/+XY40wR++ePCE=;
 b=hcV0tU2evHraU2gmTAM82Lj0jBbGbg1duGJmiXX3sfECIX08M6Jd+fJrZEI9yXlq64eWsLKpByPfg1xSiv2VSsKGeRXfohNGsURC+Xs0OShL89dO47HsUu+qeLc7IK/zFbQj4EVt3nOwisvVflNJdbYx3IAtS1h7vPIxDadaqiXqbeRfmEz7BKib276oYGLNnXf/m/oEJun3yZwhwYU97XQJ4KCp10Z0QCgFD503kbv+N73SY/eRPsSuotxeRcytzSQs5pswDux9stepSF5D8HX95HgQ77zQC8081r7CWpwj/db3u1UJjfNEpn6677FGhiV0FDMqK9ZlJNIvM1lHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA7PR11MB9595.namprd11.prod.outlook.com (2603:10b6:806:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 13:43:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 13:43:09 +0000
From: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
	"stfomichev@gmail.com" <stfomichev@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	Jason Xing <kernelxing@tencent.com>
Subject: RE: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
 multi-buffer Tx
Thread-Topic: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Thread-Index: AQHdAxUDK2up9r/p3keMRr0bloj8oLZQsw6AgAAUYgCAABCW4A==
Date: Fri, 26 Jun 2026 13:43:09 +0000
Message-ID: <IA1PR11MB60978AF3799FD895C53A860882EB2@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com>
 <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
 <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com>
In-Reply-To: <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SA7PR11MB9595:EE_
x-ms-office365-filtering-correlation-id: 91dc128b-f6f4-4c5f-b153-08ded388dbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|6133799003|4143699003|5023799004|22082099003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: YPS3Dx9CxCXE4dq243eIghihI7kDPPf1e0G4yzUXhTV0lntBmRaSisOPzz5SD6J+5zFik5TMo4Yau4DzFY8v4uDrc3SIuwIlnUVVj3P3PhWFb0GmE6Ue+xJQmmJ6md74dVTmj5Q0NlgzhTNgSrrIjHtqb1mW6zu/0qzvNkz7IU62/9IMwY23YpVMDXlMx6efaKzAJOPsX+4mW4x+SFF+CTvu2LBS0b6pB9oalHJOVMVMnK8d+vxxLjrcf+P1TEWooeVzQRs+fMBW0G1hnLpYg9RdWhpZ7ClIDw0+eqd9IMxz+oheSYFgazviIGT/QbS8hhgt2pvAeHJ7U/DTJ05DikMEM0+znfW94Te1FW1abF5DUvvmT0rqMmMtbnD+lZi8eMZoJnJxucezbNk54+pME+lDl3JYRFxt+AoO0dChr2TZVxPYsAom42hyGaNO9pGZRQpRFk0bWOUyPLrYIQd6eXUqs2AGTxaQsZsXCVBURzSTxXgi+E4/2QADB/x7RHDpdmTr6m2COtis4ZytjUkVz4CJlYY14pq6hDhQ7ycrpW9hEqbecMWidzCo5OmBP94s4lTwEQpty7xVSDBU7C66hRzDdPiX65zci07gMzJa1DiaxPT8bB7aCyesRJXKeWQ7oe7jBKq8ojj8M6/iml1dl8oRwQZX+soUBE58KUGb7KDF6tOI+CkdmVbULfXOrLrvSEvudrn1kZXAr+i0RybDmSteG8T/WOlnMxzMHfXboAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(6133799003)(4143699003)(5023799004)(22082099003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEVPeFp0MUdBWDV6VysvVHdPQ3RhdTVLS1VRNE8xN3V4NjU0VHNCT2RUcmhT?=
 =?utf-8?B?NWx1aUttWDVMWnFHbklUMUcvYkszN2w0UHZaMDAvVnNXRzh6czgxMEwxTFp5?=
 =?utf-8?B?T2lQSlNWclVEamx3RXM0b21TdjZMWWJCR1ZtRG91VUh4YjVNek41L0M4cEtJ?=
 =?utf-8?B?N0N6czNRZGpmOFRLQks2MDQrT0lXS3NkRjNmNlJRZ3NlWGVHZEZoSWJSS0VH?=
 =?utf-8?B?ZlFaUjh6MDBEV0x5RXVmSytaTXF0cUZQT21Va2UvUGZBVWRVK29MMUh6SStn?=
 =?utf-8?B?QlYxalpYLzdKeVBmb1QwNjFGc3p6M0p1eXhGNUtuVkd4S1NjZm5NUGErR2JH?=
 =?utf-8?B?MDVkbHFyUkoxaUtQT3FIK2FVd0h5Z1ZEUkI0RmlIZHFjMXNTNENKWUZGMTAx?=
 =?utf-8?B?QUZocmVqREtrbDZyN0w0a1piSUsvalRRdDM4RmZWNmVLVXllaGQ0bHhXWDdR?=
 =?utf-8?B?TTJVU0F1dm9YMm9GcmZDT09GNFpTZGVjUmNmU0NuNlhVL2JRemc0b3dLdUFp?=
 =?utf-8?B?YnJ2R2swd1lIZTZRTU0yWENLYmhRWUdXeEpBdGJLUzh3KzBjaGp2NWFEMk5E?=
 =?utf-8?B?ZHhIOFNnQjdtZTFnTXZuSysvYmtVRysrdWlYZFNDblZSb0FYclJqNHh4TWM2?=
 =?utf-8?B?NzBTeWtiR1dGVWZJajk3cWZMaVJKSDUwUHJWMnZPWFFEVDRCRW5JbGVWNWw1?=
 =?utf-8?B?ckpwY1RQSXNJQTMzY3oybC95YjZENkZYTjRYNHY2Wno1ZUxJeUhPQndxZFVF?=
 =?utf-8?B?NmF5SXdZTVlOdzNuVS9mMUJDSDhqTW5leFJlZHFhaVZPdW03U08rTVVsNjAy?=
 =?utf-8?B?N2l4RE5wbklwUGcraFNkUVQvNld0SXFKeERHbjZya2RTSnMzWXVUT3MrZWdj?=
 =?utf-8?B?aVBacEQwK1NNNElCTlNKWHBlQnR0UERkc21CRGJUV2VoVnFmVkNyVEprRlI3?=
 =?utf-8?B?QUxUYnptTm1ic1dqd05CS1FoQW9vWVRQM25LZllISDhUT1dpY3JyR2oxakxw?=
 =?utf-8?B?ZVdUSDAzeWUxNVNUR1VaRjVReGZoa2x2Sithc1RoQkRIVlRhaW9jbHYyeFdV?=
 =?utf-8?B?UE0yMGZsb0MzbDhlMHA5RUtjYStybEhLUTUweGxxMEZ1bFluS3lCWFBPUGFF?=
 =?utf-8?B?Z29OTnBzQkRrL21wYkJjL1VNem5KSDVsd2I2N3UrdnR1QWFsQlFDOUk5OHZR?=
 =?utf-8?B?dkxwRGprNEtGbVVJTmkxWGFrYVh1WC9ocUtzM1d1UGNYUHVOdjlZZGh0MWw5?=
 =?utf-8?B?TEZoQ1h6WlRycDB5b0RPL3ExMUZxeWNNK0xxOVM0SWp2SHE4UmNYaE01dnpy?=
 =?utf-8?B?SXhMU3JuenFKMHh5WlA4ejdiYmRPTGNPcUppSVMzTDRGbDROV0lKOHJLZFNX?=
 =?utf-8?B?SCtFY3dtWmZCRkg0V2FnRlpuVWhLa1dWa3FFb01LY0FVTHFDQTBEbGZKOVVV?=
 =?utf-8?B?WUFsczVqZy95eDBNUytCbnpPb1lUWFRqd2VJZnNwUmthb0Y3U2w1a3ZMdFRi?=
 =?utf-8?B?NG53Si9XdjNZcjRLRSs5UVJPYmlNdHdrNVp0ZVpmbnNES0FiQ1VxQ1dvU2p2?=
 =?utf-8?B?cjhvb0kwa3V3cVdmZ3cxZXAwbmh6TTJKWEx4cFZsQi9xWkw0M1owM0NOL2dR?=
 =?utf-8?B?ZHBIc0xPc21hSGh6TnZ5TmJ2b0tJZzU3Y3JBdWRrYXV0MlFjRWZzeXdlbjdx?=
 =?utf-8?B?cUFHaysvMVpTRWt5RHdKbG4xQ3JoeUR5TkwwNXRyaUxBUDRwclNHWmdYblhp?=
 =?utf-8?B?cGRPeS9YVFk4ZVNjVkdVUlNQTnFUYWtlVG9JclQwMVJJSE04NlV3ZUNTbGlJ?=
 =?utf-8?B?NU16Y2pCb2pBejN6d25VVzJGK2dnR2V3VUV2a3BmdEhMTGdNMVBBOVQrRHQ3?=
 =?utf-8?B?ZHJLWnBJUm9pOWFwbVYvQjVVaGs2TGJLK0VnU3FMS0lFM3kxZHdHUjF1UVE2?=
 =?utf-8?B?RjJRRTFHQUp5V1JDZm0yWDFhd1h3OGxEd04rQjFOcUxRTnlMVGdyT05WeU1E?=
 =?utf-8?B?ZXFZY3ZHU2MrUXUyQnNtcFlCNlNJV0d1ZFNjUlB2Z0k1SkpyQTFTaHNxbU95?=
 =?utf-8?B?emNrSktPN3lybnd4VWVkS0dyNDQwZkJ0YlJSbUNVRHNjVlBlbVNKbXZWSEM2?=
 =?utf-8?B?ek44SHlTY1REKzVyR0g5V2p5REJ2SmdxV29VMDNOczJQYjJUaVVSWHA0di9V?=
 =?utf-8?B?T0RRNmVkSmJrUlF6Sk1zZFgvS05pU2xUUndJVDRFMnhkWHR2TXVmU09NdXdM?=
 =?utf-8?B?R005TU5zR2V3QitWNGJtcm1SbmZCQVhybXp2NGpBWGZPWXZCK1pDZmpUOXZ3?=
 =?utf-8?B?N2ZTNVBwNHBCNS9XTGZFQ0gyemsxSzVTUFl2YXVZR2EyWFpoNXE5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P4k6aurxcFabNqyi15y14TUYRZJKefu1pH2LQtSB1EOEJqApF5aK7wYCO/evNpTqDURuR2dlaOKxlUQETlNUIKNoqAwamn3r7bLOzEJDTChkrw2oz8zkpBgWqD3rxZ7zQALHk94vE+RSJvfGrZtYv4D6L0HIoYnTFBbISwXeQZ6g9vem+g48sKhOG6AiPBHsLMFuV9EMBQAk3AnD03tgvjCrvcjcTChORwE4zt+vRuQFRUrzO86vKkaAZuBGZfBpTNTSWHFuc91jZp/wskd1MJf5OgBd9bRfByhCIGwQSpcHWbYzco98QN/jr7zRDnimp8X6WkG0tbv4oM6bxirPWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc128b-f6f4-4c5f-b153-08ded388dbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 13:43:09.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3Ll5l0LuiVDc1OfJEJrgxR2VYei2gv0BQHCTELiwIFUDfwW6e8mNUp8NTgvShiDCR1BnM3Ro7np6GW81WjGChoBSrjR/SwH5Crg/+p7Y8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9595
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302183-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kerneljasonxing@gmail.com,m:larysa.zaremba@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kernelxing@tencent.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,tencent.com:email,IA1PR11MB6097.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,tencent.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E256CDB57

PiANCj4gT24gRnJpLCBKdW4gMjYsIDIwMjYgYXQgNzoxMuKAr1BNIExhcnlzYSBaYXJlbWJhIDxs
YXJ5c2EuemFyZW1iYUBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBKdW4g
MjMsIDIwMjYgYXQgMDM6MzI6MzRQTSArMDIwMCwgTWFjaWVqIEZpamFsa293c2tpIHdyb3RlOg0K
PiA+ID4gRnJvbTogSmFzb24gWGluZyA8a2VybmVseGluZ0B0ZW5jZW50LmNvbT4NCj4gPiA+DQo+
ID4gPiBUaGlzIHBhdGNoIGlzIGluc3BpcmVkIGJ5IHRoZSBjaGVja1sxXSBmcm9tIHNhc2hpa28u
IEl0IHNheXMgd2hlbg0KPiA+ID4gb3ZlcmZsb3cgaGFwcGVucywgdGhlIGFkZHJlc3Mgb2YgY3Eg
dG8gYmUgcHVibGlzaGVkIGlzIGludmFsaWQuDQo+ID4gPiBBY3R1YWxseSB0aGUgc2V2ZXJlciB0
aGluZyBpcyB0aGUgd2hvbGUgcHJvY2VzcyBvZiBwdWJsaXNoaW5nIHRoZQ0KPiA+ID4gYWRkcmVz
cyBvZiBjcSBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBpcyBub3QgcmlnaHQ6IGl0IHNob3VsZCB0
cnVlbHkNCj4gPiA+IHB1Ymxpc2ggdGhlIGFkZHJlc3MgYW5kIGFkdmFuY2UgdGhlIGNhY2hlZF9w
cm9kIGluIGNxIGFzIGxvbmcgYXMgaXQNCj4gPiA+IHJlYWRzIGRlc2NyaXB0b3JzIGZyb20gdHhx
Lg0KPiA+ID4NCj4gPiA+IFRoZSBmb2xsb3dpbmcgaXMgdGhlIGZ1bGwgYW5hbHlzaXMuDQo+ID4g
PiB4c2tfZHJvcF9za2IoKSBpcyBjYWxsZWQgaW4gdGhyZWUgcGxhY2VzLCB3aGljaCBhbGwgZGlz
Y2FyZCBhIHBhcnRpYWxseQ0KPiA+ID4gYnVpbHQgbXVsdGktYnVmZmVyIHNrYjoNCj4gPiA+IDEp
IHhza19idWlsZF9za2IoKSAtRU9WRVJGTE9XIGVycm9yIHBhdGg6IHBhY2tldCBleGNlZWRzDQo+
IE1BWF9TS0JfRlJBR1MNCj4gPiA+IDIpIF9feHNrX2dlbmVyaWNfeG1pdCgpIHBvc3QtbG9vcCBj
bGVhbnVwOiBhbiBpbnZhbGlkIGRlc2NyaXB0b3IgaW4NCj4gPiA+ICAgIHRoZSBUWCByaW5nIHBy
ZXZlbnRzIHRoZSBwYXJ0aWFsIHBhY2tldCBmcm9tIGNvbXBsZXRpbmcNCj4gPiA+IDMpIHhza19y
ZWxlYXNlKCk6IHNvY2tldCBjbG9zZSB3aGlsZSB4cy0+c2tiIGhvbGRzIGFuIGluY29tcGxldGUg
cGFja2V0DQo+ID4gPg0KPiA+ID4gSW4gYWxsIHRocmVlIGNhc2VzLCB0aGUgVFggZGVzY3JpcHRv
cnMgZm9yIHRoZSBhbHJlYWR5LXByb2Nlc3NlZCBmcmFncw0KPiA+ID4gaGF2ZSBiZWVuIGNvbnN1
bWVkIGZyb20gdGhlIFRYIHJpbmcgKHhza3FfY29uc19yZWxlYXNlKSwgYW5kIENRIHNsb3RzDQo+
ID4gPiBoYXZlIGJlZW4gcmVzZXJ2ZWQuIEhvd2V2ZXIsIHhza19kcm9wX3NrYigpIGNhbGxzIHhz
a19jb25zdW1lX3NrYigpDQo+ID4gPiB3aGljaCBjYW5jZWxzIHRoZSBDUSByZXNlcnZhdGlvbnMg
dmlhIHhza19jcV9jYW5jZWxfbG9ja2VkKCkuIFNpbmNlDQo+ID4gPiB0aGUgYnVmZmVyIGFkZHJl
c3NlcyBuZXZlciBhcHBlYXIgaW4gdGhlIGNvbXBsZXRpb24gcXVldWUsIHVzZXJzcGFjZQ0KPiA+
ID4gcGVybWFuZW50bHkgbG9zZXMgdHJhY2sgb2YgdGhlc2UgYnVmZmVycy4NCj4gPiA+DQo+ID4g
PiBGaXggdGhpcyBieSBsZXR0aW5nIGNvbnN1bWVfc2tiKCkgdHJpZ2dlciB0aGUgZXhpc3Rpbmcg
eHNrX2Rlc3RydWN0X3NrYg0KPiA+ID4gZGVzdHJ1Y3Rvciwgd2hpY2ggYWxyZWFkeSBzdWJtaXRz
IGJ1ZmZlciBhZGRyZXNzZXMgdG8gdGhlIENRIHZpYQ0KPiA+ID4geHNrX2NxX3N1Ym1pdF9hZGRy
X2xvY2tlZCgpLg0KPiA+ID4NCj4gPiA+IE5vdGUgdGhhdCBjYW5jZWxsaW5nIHRoZSBkZXNjcmlw
dG9ycyBiYWNrIHRvIHRoZSBUWCByaW5nICh2aWENCj4gPiA+IHhza3FfY29uc19jYW5jZWxfbikg
aXMgbm90IGEgYXBwcm9wcmlhdGUgb3B0aW9uIGJlY2F1c2UgYW4gb3ZlcnNpemVkDQo+ID4gPiBw
YWNrZXQgdGhhdCBhbHdheXMgZXhjZWVkcyBNQVhfU0tCX0ZSQUdTIHdvdWxkIGJlIHJldHJpZWQg
aW5kZWZpbml0ZWx5LA0KPiA+ID4gd2hpY2ggaXMgYW4gb2J2aW91c2x5IGRlYWRsb2NrIGJ1ZyBp
biB0aGUgVFggcGF0aC4NCj4gPiA+DQo+ID4gPiBBbHNvIG1vdmUgdGhlIGRlc2MtPmFkZHIgYXNz
aWdubWVudCBpbiB4c2tfYnVpbGRfc2tiKCkgYWJvdmUgdGhlDQo+ID4gPiBvdmVyZmxvdyBjaGVj
ayBzbyB0aGF0IHRoZSBjdXJyZW50IGRlc2NyaXB0b3IncyBhZGRyZXNzIGlzIHJlY29yZGVkDQo+
ID4gPiBiZWZvcmUgYSBwb3RlbnRpYWwgLUVPVkVSRkxPVyBqdW1wIHRvIGZyZWVfZXJyLCBjb25z
aXN0ZW50IHdpdGggdGhlDQo+ID4gPiB6ZXJvY29weSBwYXRoIGluIHhza19idWlsZF9za2JfemVy
b2NvcHkoKS4NCj4gPiA+DQo+ID4gPiBbMV06DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI2MDQyNTA0MTcyNi44NUZCM0MyQkNCMkBzbXRwLmtlcm5lbC5vcmcvDQo+ID4NCj4gPiBU
aGlzIGNoYW5nZSBsb29rcyBnb29kLCBidXQgb3ZlcmZsb3cgY2FzZSB3aXRoIG9ubHkgMSBkZXNj
cmlwdG9yIHdvcnJpZXMNCj4gbWUuDQo+IA0KPiBJIHByZXN1bWUgeW91IHJlZmVycmVkIHRvIHhz
a19idWlsZF9za2JfemVyb2NvcHkoKT8NCj4gDQo+ID4gSW4gc3VjaCBjYXNlcywgb25jZSB3ZSBn
ZXQgdG8gZm9sbG93aW5nIGNvZGUsIGtmcmVlX3NrYigpIGhhcyBhbHJlYWR5DQo+IGhhcHBlbmVk
Og0KPiA+DQo+ID4gICAgICAgICBpZiAoZXJyID09IC1FT1ZFUkZMT1cpIHsNCj4gPiAgICAgICAg
ICAgICAgICAgaWYgKHhzLT5za2IpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBE
cm9wIHRoZSBwYWNrZXQgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB4c2tfaW5jX251
bV9kZXNjKHhzLT5za2IpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHhza19kcm9wX3Nr
Yih4cy0+c2tiKTsNCj4gPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB4c2tfY3FfY2FuY2VsX2xvY2tlZCh4cy0+cG9vbCwgMSk7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgeHMtPnR4LT5pbnZhbGlkX2Rlc2NzKys7DQo+ID4gICAgICAg
ICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgeHNrcV9jb25zX3JlbGVhc2UoeHMtPnR4
KTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IGtmcmVlX3NrYigpIHNob3VsZCBoYXZlIHJlc3Vs
dGVkIGluIHN1Ym1pc3Npb24gb2YgdGhlIHNpbmdsZSBmYXQgZGVzY3JpcHRvciB0bw0KPiA+IHhz
a19jcV9zdWJtaXRfYWRkcl9sb2NrZWQoKSB2aWEgeHNrX2Rlc3RydWN0X3NrYigpLCBzbyBmYXIg
Y29uc2lzdGVudCB3aXRoDQo+IHRoZQ0KPiANCj4gQXQgbGVhc3QsIGluIHRoZSBOT19MSU5FQVIg
Y2FzZSwgeHNrX3NrYl9pbml0X21pc2MoKSBpcyBub3QgY2FsbGVkDQo+IHNpbmNlIHRoZSBPVkVS
RkxPVyBza2lwcyB0aGlzIGZ1bmN0aW9uLCB3aGljaCBtZWFucyBrZnJlZV9za2IoKQ0KPiBkb2Vz
bid0IGludm9rZSB4c2tfZGVzdHJ1Y3Rfc2tiKCkgdG8gcHVibGlzaCBpdCBpbiB0aGUgQ1EuIFNv
IGl0J3MNCj4gc2FmZSB0byBjYW5jZWwgdGhlIGNxIHJlc2VydmF0aW9uIChpbiB4c2tfY3FfY2Fu
Y2VsX2xvY2tlZCh4cy0+cG9vbCwNCj4gMSkpLg0KDQoocmVzcG9uZGluZyBmcm9tIG91dGxvb2sg
c28gYXBvbG9naWVzIGZvciBhbnkgYnJva2VuIGZvcm1hdHRpbmcpDQoNClllcywgSSBoYXZlIHRo
ZSBzYW1lIHVuZGVyc3RhbmRpbmcgaGVyZS4gSG93ZXZlciwgaG93IHRlY2huaWNhbGx5DQpwb3Nz
aWJsZSB3b3VsZCBpdCBiZSB0byBwcm9kdWNlID4gTUFYX1NLQl9GUkFHUyBmcm9tIGEgc2luZ2xl
DQpBRl9YRFAgZGVzY3JpcHRvcj8NCg0KSSBrbm93IFNhc2hpa28gaGFzIHBvaW50ZWQgdGhpcyBv
dXQgYW5kIHlvdSBjYW1lIHVwIHdpdGggcHJldmlvdXMNCmZpeCwgYnV0IGZvciB2YWxpZCBkZXNj
cmlwdG9yIGl0IGlzIHNpbXBseSBub3QgcG9zc2libGUuIEFuZCBpbnZhbGlkDQpkZXNjcyB3b3Vs
ZG4ndCByZWFjaCB0aGlzIGZ1bmN0aW9uLg0KDQpJIHdvdWxkbid0IGxpa2UgdG8gc3RpciB1cCB0
aGUgcG90IHRvbyBtdWNoIHNvIGxldCB1cyBrZWVwIHRoaXMNCmNvZGUsIGJ1dCBpcyB0aGVyZSBh
bnkgd2F5IHRvIGdpdmUgU2FzaGlrbyBhZGRpdGlvbmFsIGNvbnRleHQ/DQpJIG1lYW4sIGZvciBj
YXNlIHdoZXJlIHdlIHdvdWxkIHNheSAqdGhpcyBjYW4ndCBoYXBwZW4qLCB3aWxsDQpJdCBiZSBh
YmxlIHRvIGNhcnJ5IHRoaXMgaW5mb3JtYXRpb24gb253YXJkcz8NCg0KPiANCj4gVGhhbmtzLA0K
PiBKYXNvbg0KPiANCj4gPiBtdWx0aS1kZXNjcmlwdG9yIGJldmFpb3IgeW91IGFyZSBwcm9wb3Np
bmcgaGVyZS4NCj4gPg0KPiA+IEJ1dCB3aGF0IGhhcHBlbnMgd2hlbiB3ZSBjYW5jZWwgYSBzdWJt
aXR0ZWQgQ1Egc2xvdCB2aWENCj4gPiB4c2tfY3FfY2FuY2VsX2xvY2tlZCh4cy0+cG9vbCwgMSkg
aW4gdGhlIGFib3ZlIGNvZGU/DQo+ID4NCj4gPiA+DQo+ID4gPiBGaXhlczogY2YyNGY1YTVmZWVh
ICgieHNrOiBhZGQgc3VwcG9ydCBmb3IgQUZfWERQIG11bHRpLWJ1ZmZlciBvbiBUeA0KPiBwYXRo
IikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFhpbmcgPGtlcm5lbHhpbmdAdGVuY2VudC5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICBuZXQveGRwL3hzay5jIHwgMTMgKysrKysrKystLS0tLQ0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC94ZHAveHNrLmMgYi9uZXQveGRwL3hzay5jDQo+
ID4gPiBpbmRleCBiOTcwZjMwZWE5YjkuLmE3YTgzZGM0NTQ2YSAxMDA2NDQNCj4gPiA+IC0tLSBh
L25ldC94ZHAveHNrLmMNCj4gPiA+ICsrKyBiL25ldC94ZHAveHNrLmMNCj4gPiA+IEBAIC03OTQs
OCArNzk0LDExIEBAIHN0YXRpYyB2b2lkIHhza19jb25zdW1lX3NrYihzdHJ1Y3Qgc2tfYnVmZg0K
PiAqc2tiKQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgdm9pZCB4c2tfZHJvcF9za2Ioc3RydWN0IHNr
X2J1ZmYgKnNrYikNCj4gPiA+ICB7DQo+ID4gPiAtICAgICB4ZHBfc2soc2tiLT5zayktPnR4LT5p
bnZhbGlkX2Rlc2NzICs9IHhza19nZXRfbnVtX2Rlc2Moc2tiKTsNCj4gPiA+IC0gICAgIHhza19j
b25zdW1lX3NrYihza2IpOw0KPiA+ID4gKyAgICAgc3RydWN0IHhkcF9zb2NrICp4cyA9IHhkcF9z
ayhza2ItPnNrKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHhzLT50eC0+aW52YWxpZF9kZXNjcyAr
PSB4c2tfZ2V0X251bV9kZXNjKHNrYik7DQo+ID4gPiArICAgICBjb25zdW1lX3NrYihza2IpOw0K
PiA+ID4gKyAgICAgeHMtPnNrYiA9IE5VTEw7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICBzdGF0
aWMgaW50IHhza19za2JfbWV0YWRhdGEoc3RydWN0IHNrX2J1ZmYgKnNrYiwgdm9pZCAqYnVmZmVy
LA0KPiA+ID4gQEAgLTg3Nyw3ICs4ODAsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYNCj4gKnhz
a19idWlsZF9za2JfemVyb2NvcHkoc3RydWN0IHhkcF9zb2NrICp4cywNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiA+DQo+ID4gPiAgICAg
ICAgICAgICAgIC8qIGluIGNhc2Ugb2YgLUVPVkVSRkxPVyB0aGF0IGNvdWxkIGhhcHBlbiBiZWxv
dywNCj4gPiA+IC0gICAgICAgICAgICAgICogeHNrX2NvbnN1bWVfc2tiKCkgd2lsbCByZWxlYXNl
IHRoaXMgbm9kZSBhcyB3aG9sZSBza2INCj4gPiA+ICsgICAgICAgICAgICAgICogeHNrX2Ryb3Bf
c2tiKCkgd2lsbCByZWxlYXNlIHRoaXMgbm9kZSBhcyB3aG9sZSBza2INCj4gPiA+ICAgICAgICAg
ICAgICAgICogd291bGQgYmUgZHJvcHBlZCwgd2hpY2ggaW1wbGllcyBmcmVlaW5nIGFsbCBsaXN0
IGVsZW1lbnRzDQo+ID4gPiAgICAgICAgICAgICAgICAqLw0KPiA+ID4gICAgICAgICAgICAgICB4
c2tfYWRkci0+YWRkcnNbeHNrX2FkZHItPm51bV9kZXNjc10gPSBkZXNjLT5hZGRyOw0KPiA+ID4g
QEAgLTk2OSw2ICs5NzIsOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnhza19idWlsZF9za2Io
c3RydWN0DQo+IHhkcF9zb2NrICp4cywNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZnJlZV9lcnI7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+ID4N
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICB4c2tfYWRkci0+YWRkcnNbeHNrX2FkZHItPm51
bV9kZXNjc10gPSBkZXNjLT5hZGRyOw0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGlmICh1bmxpa2VseShucl9mcmFncyA9PSAoTUFYX1NLQl9GUkFHUyAtIDEpICYmDQo+IHhw
X21iX2Rlc2MoZGVzYykpKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cnIgPSAtRU9WRVJGTE9XOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byBmcmVlX2VycjsNCj4gPiA+IEBAIC05ODYsOCArOTkxLDYgQEAgc3RhdGljIHN0cnVjdCBza19i
dWZmICp4c2tfYnVpbGRfc2tiKHN0cnVjdA0KPiB4ZHBfc29jayAqeHMsDQo+ID4gPg0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgIHNrYl9hZGRfcnhfZnJhZyhza2IsIG5yX2ZyYWdzLCBwYWdl
LCAwLCBsZW4sIFBBR0VfU0laRSk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgcmVmY291
bnRfYWRkKFBBR0VfU0laRSwgJnhzLT5zay5za193bWVtX2FsbG9jKTsNCj4gPiA+IC0NCj4gPiA+
IC0gICAgICAgICAgICAgICAgICAgICB4c2tfYWRkci0+YWRkcnNbeHNrX2FkZHItPm51bV9kZXNj
c10gPSBkZXNjLT5hZGRyOw0KPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPiAgICAgICB9DQo+
ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuNDMuMA0KPiA+ID4NCj4gPiA+DQo=

