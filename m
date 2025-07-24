Return-Path: <netdev+bounces-209664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817CCB10360
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177D3AE0490
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379EC2749F0;
	Thu, 24 Jul 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPX2r0mF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B1223DD5
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345211; cv=fail; b=Bud8hnx/o1MBq3S/ljwR2bUS/lPkyw1sh7vrN964L7vf02ARG7fV9f8ZeJV3zyq7qnbzMM4a+JzuNXc9YCMyZKth7OQNId+9AvA8AeE3JPoEhB1Y3btNksNSH6UAnSQclwGXNbp9VkAxBHqJShfVK5aCxwoksx/VDtU4Gh/55h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345211; c=relaxed/simple;
	bh=wnFh9warM7OkEo0l2gtS6iozUhYUnSobuiK8g4WhnYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBT+5R3C2pkIZpyJGhIOX9tcoDcWFzuDad6H953/lMGpkMguq1tl3PqnmvhqyZyI87EKjKJ7S4bzc70mgXorTA/1g+5ucGRnh16VCN8ubHUghp/rx9s9GspucvaHxezPEMLRQ8kavMvF3mavJikfTTv9xYijzMgPyxwF2Dx4kyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPX2r0mF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753345209; x=1784881209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wnFh9warM7OkEo0l2gtS6iozUhYUnSobuiK8g4WhnYI=;
  b=FPX2r0mFOzqM3ciU/mDRWjsdwOC31tWhekfbGcu7aWmDI10kSp7qy3NE
   srdUfP4u5dUTuMuFazXscE+n5UvXaYdwZqOhvFNDD3GSjV9Z5isoqLpCf
   zKQx2UrhjOlDHQg+AVxWc1uqlr4JLrMD6QtHxzCF0LQC7cDmxG42l2cau
   wqPESEW1pzGw1BHneieiom3Hy0UOFpgu9DzRhyfFdkAmdlqRQyg72NY5/
   rk+Dwqr/fTwSC02vxZJWiy3ZviXVrGiIaQ4Ph2t1j5Bpl7ufuLqoMY/f+
   l/aarCzBPECUZmR6UVOAhCos5P/LyhFEQgXjpbVaRG5G7kcFlaQIYmlMY
   A==;
X-CSE-ConnectionGUID: 4LJ0q6uBRWqpfGbaDt3zCw==
X-CSE-MsgGUID: 4qXwli6JRTCoH6zEmZC/9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73106604"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="73106604"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 01:20:09 -0700
X-CSE-ConnectionGUID: x1qiL+ALSAi4lDostOuldg==
X-CSE-MsgGUID: kMZxpp6GTfe/CXSxZxGeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164148396"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 01:20:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 01:20:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 01:20:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Jul 2025 01:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSyK3Xncorwiyfuhe/TYrb7WYLXk/AzzFl1ycZRa4B6nynhuEkGwMOkJETvH9kG+rde+XiV7Bv5vlAyUY0nZx0G1F2KXL2ULUZj0N8xudGQMn8XkyQ5l9gooEocXyyOztdvqDVjLy432ooLtgyftPbSp7KOaHPq+WXDLK82C6Q6m/wVyexoLwUu+aTs9EqJ0wxrBo62L55n/QhTOakrqkFVqkhdQBgqyhvsM8ssimrBIRktEBeHXqcxJMduDCFfADEqLi96TAb2SwhW5lIC6QSoUO8fup5kDFn/OHiWgJ8T9Hek87HTpVDhaZY9oNFFNBlgjiNKYNjKCXNC67ku41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZYcVrQTFFJUltwA2usYRNKRaRHbyjGw/awcEtDhgvw=;
 b=bZ2s8eRsi/2JeKiR0U4Xmii3/ShtNVpsl4CxzVU/yCu9lO2nMYY9aB/+CvV2sTp7V3lZehs6pa2rORpbOoxuPbfZ3YoRQ+FMcOruQtK9zp6wGGCd3S0c7E64xNNjKtDT+Rod39tOzES9H6VBafP8rAhHOy8JJpqMvcBcNtxWf4RFvflHaCA7EKyqku+SlalZqwjsiLZkvNEky7OU9QMrbSlHOyajkEXjQTrkxle3YdlGbD2iXqE0OazUh0FOHpiPda85HflDaktruMMC6vSeBkCYWxnEbH7xG9HP250Whr2Kp1/6F52orNrC+6xEQDiOx9xidZoqdR4JYxTciFGesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 08:20:05 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.037; Thu, 24 Jul 2025
 08:20:05 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Romanowski, Rafal" <rafal.romanowski@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
Thread-Topic: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
Thread-Index: AQHbtah91ouO9MR9kkmoC8G1DByeebRBaS+AgAAS6yA=
Date: Thu, 24 Jul 2025 08:20:05 +0000
Message-ID: <IA3PR11MB8986139F4B98A2A4D2D40017E55EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
 <20250425060809.3966772-8-michal.swiatkowski@linux.intel.com>
 <IA3PR11MB89851784EC3EE882EB1FF6668F5EA@IA3PR11MB8985.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89851784EC3EE882EB1FF6668F5EA@IA3PR11MB8985.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8194:EE_
x-ms-office365-filtering-correlation-id: 820c8b14-1644-44a3-b9dc-08ddca8ae507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1YmIGteSe7V265t6VLlNAhX2f9mR1vSTa0GZWrOPEW+Nm4n36at/ZPrbVyfd?=
 =?us-ascii?Q?AlpgDPeUgFBsnsjMh+F4kk4TH6qmlONAUulZI/kp6Dos4ja+qHKM3Z8pCM0s?=
 =?us-ascii?Q?7y1c2kemWgfBcoQ4FBl3j8Gkor8+4nOoSw3KXgbSDjDPwAOxGZOHP0R3LBlK?=
 =?us-ascii?Q?KE4R4vQIEuRck+gU+Rcw//pq8WSfl6ivLnzNQM9bQ5RGZUISj02un7op2chE?=
 =?us-ascii?Q?wJtt0/DYmuS+ulTrqeuMW+heMLsf2fvskLQOUOgd4UYQQTG+4OGKuD4Y8Nsa?=
 =?us-ascii?Q?eklnxVrv8KqNqwtq25dRz/qyLcyyFrJkRQWf8XRSVQ6WuBBCKXtzQFTiPFN2?=
 =?us-ascii?Q?l5OAd7etyRwhKOwAABlmMgv8C9GNE2+BSu+XER5g3OQgtAhS6q+2Z/8S1t2e?=
 =?us-ascii?Q?PXMN1XiBghiz86NMC17afQJE0Vz7CXVaEKFL6HhsujWigTTi1uflKLCS3IvN?=
 =?us-ascii?Q?xUlVaEOcxKbJBkFjAOdR6ojncmieKd+T6O4BwB9N0LiiS/6F+aB+Zp/bOMvF?=
 =?us-ascii?Q?zjdtTt+uVCckjhGbPXHoES9+EfPYFTHdLcOg4mxwxT0Esz93ah0qmhfFiYRV?=
 =?us-ascii?Q?mY+ILp26aO3fWRuthXilK9hwabvISQxAIaFa2+M9SbWZWSds/zsNLgwYGdE0?=
 =?us-ascii?Q?FU21zgXIruzQIoPfx5EhsFwvkbPmj+9UH62xJYn7+OhbIK33uubfPmoP6buf?=
 =?us-ascii?Q?UvgwZ2mmzs9I5uRlVyqG3kKn4zP+1XWmKHMoLFE+cwJbRwVc/7e3VffMVR4T?=
 =?us-ascii?Q?qnL1wc50bkCn4KglNDNm5nCfTCr+iuhpNVP4Lp0r9+piPvdF6bgJ2LCTdbUQ?=
 =?us-ascii?Q?XTHVziL2rfcozvEatDToJ51w0FCllsHkVkPJF3LY5POPYMl5KzvbOz1BtpAk?=
 =?us-ascii?Q?4SwNKZLAlnR0IYHetVt8qMrdUji1gkjUZ+5qq/pAwfbcvPC7szGx4KpZmm7r?=
 =?us-ascii?Q?tjZ99UFOfOgMQXmHa0gDDFbNvWIOSILo7N1EsNK65c0mwyhyZLJnmHTbNsMn?=
 =?us-ascii?Q?G7ASizeAIGzrYu7GsZ3ayKDY0WFRisTkUfoYBEaOb/Ud7PDnJ/LpVxy7XLPp?=
 =?us-ascii?Q?APo4n5eOHlzYY7NFsyUyXybkbd4NJOeglrc56oyvMJ5FSfNqdinDszqAkNP7?=
 =?us-ascii?Q?myRBoP0FzVUTjfKbPIcbbKPR9s/pWU+Stk/qLQw/gD1SaQqvICb2mxlEHhAc?=
 =?us-ascii?Q?MkJ2nody5BkAEyT3Rw2DvIUyVFyIKCl6UjxUGKwTlLdi3PpAZ+95n7XTzCdV?=
 =?us-ascii?Q?chtgFQ3i9H2tY65i3YxBPfXDK4xE12EtVm5k/e1+X/G6liEmTxGNxL+tBYun?=
 =?us-ascii?Q?0fIlb4eGMzSD4L+Yrh9QAT35JCzrXz2JeJxi7/kDyszzDutk2xocpcQAesIq?=
 =?us-ascii?Q?4hmUadO+fzC/zCTRJz6E/458V7KsmcLBzwdhVjQcx3SIdX/zf18RHLqWfInZ?=
 =?us-ascii?Q?k6HpF6WOTLNW2Jxo5DeQ1ulHLJDzP2eMoJKXTrl2KqeQdmovUVLhzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iY3dM0cCD7a0UzhP+wdq8I3EA6WfU0uC8EoklJXlqVJSxlc4fJ64F4CEOUS0?=
 =?us-ascii?Q?eWeyFCBh806JvrYD+3ubThyOaFG9RY2WBLIuFu+Zo9CXdDGttIlxhyfjqiVn?=
 =?us-ascii?Q?QKQbxUrZ/Rs24nUGSqGWARs/Y/X7XzyPD2FD+fV2/VQ/46MltVvCj/q+nczw?=
 =?us-ascii?Q?mtdVtKdAey7dnDmVGIvK+vj3zVDmNJnES+yPAHHY2ndfqS8kOnnn8SmgJX30?=
 =?us-ascii?Q?pGEBjgyhGpzbNXPAf80qt/H+DOP1yktph5KQmtYvQTAzUbNPKIJKh0r1+X9t?=
 =?us-ascii?Q?BpdZIOuuFDW64o+/HpziztbaGzp99juRj8RYt39nxwtTssn+YjxLI1iTqleq?=
 =?us-ascii?Q?Xw9tLE69xX7Z4s8wGfx2SMxvjVMlBD5PyVzmKebm1lzxvwa15/bv/q83PfnX?=
 =?us-ascii?Q?NAg6wYqa8j6qFAc5hLUyMiD/FfalUyJ3xl1Gy25haOdP9an6kzv0BAgmhsDB?=
 =?us-ascii?Q?yTSK0J4GC+WIabQ+7KK0DqrGUJnw4Y66OynedADRs3EPB/Lyg2hewwccbOpK?=
 =?us-ascii?Q?OVIl3PTVJ8jzbhgEW5Ol31j9Sq3VhBxF1VGemmA4fWDRAhZq8bLQQQJEScy5?=
 =?us-ascii?Q?ZTQgO9+aaIwYCVsH04n20unBsYlsMxVDrAnYxGGwuIibpDcXE19ging5vxHH?=
 =?us-ascii?Q?6rI1xPDLcGjeUFcvIG3tHzBC9xPmdeJEANdFeSEsZjmqf0Tf7yuZWW9ZJX2M?=
 =?us-ascii?Q?FGuMWMyPQSrxMctK9KM3yrbchZsZEIViyM7cybuvaqI5pMuHco59M5BDwii3?=
 =?us-ascii?Q?YiDzCQIYIXi56eivOGXP0iVtCygG3YTJJH31Nx/dxnFRecH8fW9T2sd9fVqB?=
 =?us-ascii?Q?krOw0Zo+x0+k2FN0olYpOkAX2GLChYLODDKKJs1r0U21n2BRYohxvOtxzbpp?=
 =?us-ascii?Q?jqUBah6ew7BxWH6fgpthLgGxMiZwmkKwVRUvhvEqVrRAxqJicepSkd7hYnyH?=
 =?us-ascii?Q?zRX1Vle5+5YIWAoNBzhzKmlEDzUpnl1bYSE/cJGUp21dkW78uSeCPBX/pdXv?=
 =?us-ascii?Q?O2h7jKy/vUfbYDG0E4DCWkfF1/hcBrXxfQEG6CeJPCfKz6ixmWs09Xrr+NAt?=
 =?us-ascii?Q?KMag4lRVHola5iy3JJFUS2QMZ4n/EQKJaBiV3S8SIkcpqw2pI9NadeiBN/g7?=
 =?us-ascii?Q?SP7ElUXMdEd/CIxreFalZRuC5tHHILKZmcISKrLl/4toz3t9nfFxf6qEhZ6C?=
 =?us-ascii?Q?VYXCT3fdL7fN2rHQWt0seSMsLyNMogp+m63phRfvH6WouVWXzldGFedogxru?=
 =?us-ascii?Q?W7drc2B5Llq+g6/l1E+RZwJjOfLmKBvmVR4NhCAiGkmXIHjozXSVqPj4zGDW?=
 =?us-ascii?Q?63IDxyhSsjC0Qd7JWloG0wOFtG6Ap/oGhWWT85DsrokjmByumvaZEKptsT5m?=
 =?us-ascii?Q?lYP5ZpuR2YihNPO96VmOL7FxP37zhsuouqBpEsDqV7milJUQdTCJT2IZWubR?=
 =?us-ascii?Q?O5jyCa/6yXK2BIwon7Zt9GEi5rWQeJKI2xRJVSvrfl1r/XvZ+Q/oyOuo9Ycr?=
 =?us-ascii?Q?ymKhMN5VIeewldI6nTkxiDjOe4x7MHldiD+JhNOVvYyJ7GpD/7PQVBf7GkMZ?=
 =?us-ascii?Q?vhNimFP/CQcRAG5p86R9K8MdNyE44JgmnSA3dqj7eN1zDxCtbDxNMEJXVMcL?=
 =?us-ascii?Q?bA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 820c8b14-1644-44a3-b9dc-08ddca8ae507
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 08:20:05.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUi4aaGOi0Y5FqsQLGtnSWrexwPPs2QdGwKZNKEzZJzNyZg5uujOXDuqyTU/iLDN3gTZQ/J8fE2HHPOgMohQP+5Hby+5HxiKNnGkVR18tUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Romanowski, Rafal <rafal.romanowski@intel.com>
> Sent: Thursday, July 24, 2025 9:12 AM
> To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; intel-
> wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: RE: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use
> libie_aq_str
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Michal Swiatkowski
> > Sent: Friday, April 25, 2025 8:08 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Kwapulinski, Piotr
> > <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej
> > <jedrzej.jagielski@intel.com>; Zaremba, Larysa
> > <larysa.zaremba@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>
> > Subject: [Intel-wired-lan] [iwl-next v3 7/8] iavf: use libie_aq_str
> >
> > There is no need to store the err string in hw->err_str. Simplify it
> > and use common helper. hw->err_str is still used for other purpouse.
> >
> > It should be marked that previously for unknown error the numeric
> > value was passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used
> for such cases.
> >
> > Add libie_aminq module in iavf Kconfig.
> >
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/Kconfig            |  1 +
> >  .../net/ethernet/intel/iavf/iavf_prototype.h  |  1 -
> > drivers/net/ethernet/intel/iavf/iavf_common.c | 52 -----------------
> --
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 +-
> >  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
> >  5 files changed, 5 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/Kconfig
> > b/drivers/net/ethernet/intel/Kconfig
> > index d5de9bc8b1b6..29c03a9ce145 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -260,6 +260,7 @@ config I40E_DCB
>=20
>=20
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>=20
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

