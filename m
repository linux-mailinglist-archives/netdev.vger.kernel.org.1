Return-Path: <netdev+bounces-256763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKfBLVJ0g2mFmwMAu9opvQ
	(envelope-from <netdev+bounces-256763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:31:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A4EA443
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8665230175E5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61AC428822;
	Wed,  4 Feb 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgNgijp0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95E428498
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222593; cv=fail; b=eQp+Heq+DtzQIX90hfTKrpSX43CmXUswi/MnyBWplqE2lF7f6RHTUkJ8VRsbyxewlS2VDo1PeCH8dKv+UtGf42neMEKB2jrV2D60ho0Y5rpqTQwUwV2qmpG0/gHtp1zY3bX77vbHTGvxhBaLQ9e4vTpQKRTnhp2JxJFFjzUXhjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222593; c=relaxed/simple;
	bh=M/jfj6Xqh+sNfVLyNv34ps8pxTK+kV6ldZE5d3LtWL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBbd1tk5Qh3RAFf3OLVPpDcoRnRTBmhzx4aMxAcxzmM7OjLnZnwNWU2IfmaE6sQxsQnG/dhYpcosprsWpVtW+9pmMK/crrbm00dCxz+5i7niVMMQll4QUiiz3/BiJL6j7DrXdbiWINbZ9YMtqAU9DD68S9Rj/3RjbqC8xyUHH+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cgNgijp0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770222593; x=1801758593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M/jfj6Xqh+sNfVLyNv34ps8pxTK+kV6ldZE5d3LtWL8=;
  b=cgNgijp0SmYYqASkdhv4fDrGhPWiJFheB342s3enQ3LavlGjieC8B1VV
   ZPyRKwfGt6Igg/3dzdQo1bkFbMNn3I1ovqEFHYhSEqyBKOABGwU2+cMfX
   M4PnJOo/Ks/LWeQP7DbyhhHg0l+grF1rzVal74xSfH5+ULGqOS+o41Z15
   c1n2TGTsXlad+NSMHES9n4vrnTqOxbCn2deRrkVPNlxuNe8L0XayyEX35
   wJaxTDHVdCrRaMC+/8C+/5dgv3efg59XyWg4FSg7xQUt98u8Mv9vIZZ/S
   Bji4jGZCJdXO/ROza3dVzxD1eKAZytf3ltQy2OZx7yvXAcd6/kXC5dAJs
   g==;
X-CSE-ConnectionGUID: g0UNUgYhSbmRapd2d6sgvQ==
X-CSE-MsgGUID: Jgbt0cVOSYuD88q7RL31kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96866652"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96866652"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:29:52 -0800
X-CSE-ConnectionGUID: pMuRoqosRyCE1loRDUCsjA==
X-CSE-MsgGUID: dlI6m6U8R6quIOtbpSITfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="247803883"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 08:29:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 08:29:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 08:29:51 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 08:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je3Rs3npGOReUQqCYqTgkC4JcNtNHA4J7v4mc7u+gqWBMm1yZtEdhMhfec5PNHJ4UoxRRqNfNZPvCuzx5TACxOMkW+2ZNaYmWCZItzAyJT9u2PfEWuBH37pSgJLkIpoYWB41av2jKFsgQrRpb+mf+zeWF1tkiE2Mu2MvqCXtK1SCleTZgtSPuKo1QdCH6EM+n6SIgaR9+tULh72FngU5QSZXKL53cQpY5bDXE+03KDQ31Ypbj94n2qfiNjWJXBPEgACe621/UwEEMDIWYqcWjtYRIE9Gqmpj2jxLL16fxhSPRUJtPbmA1zlN7zjXFwJIQJyXF9vdbTLKXFzVBbQb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0V85kHCwHI63ccazC8MjAkOFJBZsbI7OVy2hSInMVE=;
 b=Mn4vYnO7sbj7klOkdEept/QdSVWs7qox8jedKmSkQRTYSQKyH+TFM04rF65Lm19HywHdmVez+RdxzQ/p650fjxMY3+SWzp7oJ043CAQcO5DHf9ry0d6VwPp6LF4+p3pV8cV1qBiIY4y+Ydp1vBpW5qvw5q+MmHnMXWlWUxQRsokNZTODZspiIv1lz7kNrTwRVXMe5+NOIZ92F2BAClsjKTCKbs4x9oDWJUK6vadtOdUfalMk7teeZBMudKCrbyc8tpjllIhUxsy1xhN4ME3myaw9CdSMMbtNjeDoKAv4jGdw+v4lM4ul6t3AVYr6/syqSVXNVeOV7+UeYxghGJ1T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4926.namprd11.prod.outlook.com (2603:10b6:a03:2d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 16:29:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 16:29:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Keita Morisaki <kmta1236@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH] ice: fix race condition in TX timestamp
 ring cleanup
Thread-Topic: [Intel-wired-lan] [PATCH] ice: fix race condition in TX
 timestamp ring cleanup
Thread-Index: AQHclfKAfzlDJjBHpEWVtFZcC575a7VyutwQ
Date: Wed, 4 Feb 2026 16:29:47 +0000
Message-ID: <IA3PR11MB8986EB459D2FD1697644CF98E598A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260204044822.2754803-1-kmta1236@gmail.com>
In-Reply-To: <20260204044822.2754803-1-kmta1236@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4926:EE_
x-ms-office365-filtering-correlation-id: 12536228-e806-473c-f138-08de640a9ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NG8Dg6QS3zEKLeiok3mJoSVvdvn53X9B0MgbuVwvfN5puXqedST/o5oeuOz5?=
 =?us-ascii?Q?+qXiQ6eKIKw/gxmMXzoTFlKgoD9Kc5rbgWOMk0Y8CCUagkTaX/SG7sJawgX8?=
 =?us-ascii?Q?rrJwBKE9FV/GFMgs2tjF+x9/TNvqMouw9oLkidX2T86zv1NBW1yx9WNC4BUQ?=
 =?us-ascii?Q?uaOChQFtLYW+nua3vCNX5Vreir6XY44MlbUbtCEVuWpWe/ILBxyrmZn4oWGr?=
 =?us-ascii?Q?MdKs0qDRm3bRZy5waMKEAV7PI+3gi6QHDuCDqIF61eZknumH9uIAvqsWQqH5?=
 =?us-ascii?Q?UpLuR0llSVERoXujEO4AX72Lw1E0tnXxXtvzZ8sEtDqM3EHl6i8cPwunNINH?=
 =?us-ascii?Q?zmHVd0On3KlmRTqbpsTtMd+XT4TN73XfeFijXQ85xZjTZ3vEkL64Og2e1pop?=
 =?us-ascii?Q?V0HWeVkGB6ABaajSl4HO8cHLo0+RMFRXHvXJN2MWxkX0uFQiUCdgi9nm2nUQ?=
 =?us-ascii?Q?tC86hUI7Z6PbRuWT4ajEGybg34gDhYqBxBITbv++yJQZAD1mx9pt7Jer8MNG?=
 =?us-ascii?Q?7dJKLcpdKgbPUI9OGZdNWkxn8f9Cwf0ZwhCk+ip1RVBKTJootv+8QhRdHkv4?=
 =?us-ascii?Q?cY78iRLMxQ1k4waxiP1GT2HSKm1mikckNhmR4IS2fL9JG228k52f8LX0OSuI?=
 =?us-ascii?Q?+Ig65oiAVSr8+32+fFYOlzqv3MCLMlYPVC/efPz75znig+nUjOeyz6a4B4WO?=
 =?us-ascii?Q?y/2FR/otICqkVfINXu4gGeSub/oqGd+3BJRhLYY6i1tKb5FbUMl+bXDKveB9?=
 =?us-ascii?Q?Vdp2uVyFmeD69xN8ZJJAHv4ITIQCTlVWreYaseVt21TZPcye9dm1h4xzUExm?=
 =?us-ascii?Q?JwZdRxuDtAn5iiE4jB7Q3jCsq7OhQb1Gq1uu1enPk/0REkv1G0mJiSYFjkJY?=
 =?us-ascii?Q?HKnS8fBkCOhTqpHS1BDRfYlGyzkkrzuGjopTsCtevwGOUPdAxwVmf7EsuVk6?=
 =?us-ascii?Q?SnpHpgbnAPFvqHuugPTRy00vmMqQnKfNo7e6VTjGsgwg1Vc0GULKFnxFsnFj?=
 =?us-ascii?Q?NZenhRH9jDQvy2y1Rd8u8eB971Wt01U5bshgHv11EItZObecXLsHp7qgiYRH?=
 =?us-ascii?Q?QYvuJ2SwII3l1ndZp2DBcXBkKR7WbdZeB+51U51uXEi9shlT6U9LOGxKj5lY?=
 =?us-ascii?Q?hUkq/GRcgXsi7t4nSIEQwXQhcMBIT2xL+L6Y0CjzbYmK1aryoEYiMMu8rLBn?=
 =?us-ascii?Q?RsSvQFAmJrKdOkXcdC/S/9oNZN8nHi8IOWWEEA4Gre5wtgiSNruscl7KPqKw?=
 =?us-ascii?Q?XPrWPEtEwwVVSBlt7MXvGGOENkQtLEfNnhQhVw/Rrsx3vwjxEgMXO9BZB7IG?=
 =?us-ascii?Q?IbYIoYPqgbfLFJqI6o2687U1/+GQubePkvBSpM50jokshg88l3n5g5FF/9eb?=
 =?us-ascii?Q?6zwRHRZF//2xK5kkDok4b7bCJysuMx7/QZpJsLit+FPpNUpsXndEqBLnFZV+?=
 =?us-ascii?Q?H1/zk1qYY9AmxJoRBqbzYyrruxMQm5MflTGx01QN1yCuK/IpGtYAqQNlglLa?=
 =?us-ascii?Q?93y7H0KdQeN27mWLWxa4zuqfkL5BrPIuFhqGWhix49cKRLHaeyAbeCtlKLIa?=
 =?us-ascii?Q?I7dH16Scdpocqag4pMdp0fK1zmFrzGG/W1Hzsri/DlxYfTqyOg+ZGOKR12kD?=
 =?us-ascii?Q?qPLWhdHzhW48JidEaNYNgfg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fjt5avQKPGYLJCYZMh6ledbV2TjE1b62ZXRL5iplKLDf9hmnnrE9/ftIpg+5?=
 =?us-ascii?Q?Vfgehp5+lOmHmwmgXfooRmfRVW2AvYjwWloFHmNOpoYmi2iVj9c1D8qyWor0?=
 =?us-ascii?Q?OfD+aQ+8QANnOnyNL7SbJweLILpN7b+TYfXXjgFi2mYFAQcQiDgnnXHY65Hh?=
 =?us-ascii?Q?uOi8Nlp2kkCO1FBB9r8MSY6YPKwcyVYz+zYPYkooFXZkFN6RYlvo2EL8cmyJ?=
 =?us-ascii?Q?xWp/eQ3kWTnnO8DU03sMt/WwPVLJ7P8eI0ZX0x4JuGAbf1C9yLRP45tm+t6M?=
 =?us-ascii?Q?Wg3CqEJIqSDpB/aC88vhLMoNOb4BW6Odmab2fCDL03CTbxVA3fopF4WIxmR6?=
 =?us-ascii?Q?dUYmKxRsGc2WpDgZv16TBqNsAFbGhHj3jRqCjXio2HfcYUCo2EKT0nwpvEaW?=
 =?us-ascii?Q?awqPlQhQf1DuKFx5oi4XZxdwlHamYAvBGRvk46b4mCLdriJcbGlWsETtASdY?=
 =?us-ascii?Q?qa49k+FRLrl31hh3bHhNhEF6CSSiNsNQnj0pQysCb1tzZPNdshPS2Rq9Fg4v?=
 =?us-ascii?Q?L5ofxAc8lTg9eZIhM1U3kOG5dxxqnE3mMkrwzHT82nR2ozQnmOF1Dd798ROh?=
 =?us-ascii?Q?FxB1+shU4eMJ2/xvR/EkRmnSQJWXLdQGX7pmxrllVtmuxP2l/XsJ8+P7OzwD?=
 =?us-ascii?Q?6Ahes9ddsCHcMIPUr/FPumQKfSJoDV3uWWgn0Phrh/dv5TM7JiZZDZ+pTnp/?=
 =?us-ascii?Q?0oenoI+f03STs6G/WH2Ru8k265j1noVpO+wYYJY97mwqqua7sUvNNEnDtQ/r?=
 =?us-ascii?Q?QgW9CfUUW6AnTRsSme3kpxGKJFpvQfDbOR1dYSQf4Rw0WW0spQLueP/jqmew?=
 =?us-ascii?Q?mKN9Q3JBMICilPM5fp4F/uiqjpB4vHX5j5XhSZHS7ToZCRblhFMkSgRd5/Ne?=
 =?us-ascii?Q?zq946M8Z0xBZ6aVYBZoMm07aj2aCC9vXdgT/grBTfUEDbP1adYNbjgFNQSgY?=
 =?us-ascii?Q?xIA6jtSEDnY4M+Mc30fG/+Hqq7yClGVfcCuL4KAOPFA9lXfSCAMPi7nX69Bx?=
 =?us-ascii?Q?DFqLfSvzCMjCJfOkuOI2mwFagePh6fLYewRhMsgYe5fKFMp51KfpHm+LHvkA?=
 =?us-ascii?Q?TktdQV5obMGno71okK5fa6UBHU7oFKfQfuosvw2HtYId4S64kcrTNMdx4Zgv?=
 =?us-ascii?Q?FfnJ+w6w1sXv0X8vSB0u1BCLyi+8uZUQwDgk1+VQV80A9n8VUDn/Kc17mLzX?=
 =?us-ascii?Q?kjtanDuVT3KACkmJgV4ijWpDR2JCdPEaTDyBUFXXlvIzhS0rY4dg9JDPM+l7?=
 =?us-ascii?Q?Js1ZNYoeXd2erHE694JnLeBedgSNEUOSUU6V9OcM3BBM/1K70OVPRgs+GFOr?=
 =?us-ascii?Q?NmacwRQhHvMi0J8CctycB4OkOeqpcZ908C6PgmoHyEzAB70/GUxH65vYPLeb?=
 =?us-ascii?Q?wspqvMo0xeHpdwE8HGufZhGnQxVqVg0ixIS15iL/YgzUfhw3UJO345HHhbMk?=
 =?us-ascii?Q?BsYF+ME/Zeot+bqR7aieHU9SSRD58Q4EKgJqM3pcaWmvpTrrIs7869XeF4vP?=
 =?us-ascii?Q?XLJEfqXO4SAqjwCHa1aTKopMaB6zpImbYxqxQTjN3CfwHInGmJ6VkZKIiKVZ?=
 =?us-ascii?Q?XlUyKNtQ4Y4n7Seyd4SZqak+XUbyqvtGvnOv2zvm45oxUMd7RHcNjKRuyUT4?=
 =?us-ascii?Q?3uD8GSyITSWnxUKQW5TzfsvTXJevo6qawn3O+0bAy6ntx5N9UtMqomgu6/L+?=
 =?us-ascii?Q?rXOX6DDb1GmYIB42OPEmHDc1iBtNNeoBwVJGDzHb3mkwTUx63fXBcuVajhd6?=
 =?us-ascii?Q?UWPI+x2U6g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12536228-e806-473c-f138-08de640a9ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 16:29:47.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKmK3NDs75xU/jxdQgdxSCWsCW1QzyY5QoJ6uI+GgeNEoCcFrzhJkluOrikTNoz2WfnIJeJgz55T9C9+q2CMwkk5ooUTvqpHt/Mz6oUYczU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4926
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256763-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 745A4EA443
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Keita Morisaki
> Sent: Wednesday, February 4, 2026 5:48 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org; Keita
> Morisaki <kmta1236@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ice: fix race condition in TX
> timestamp ring cleanup
>=20
> Fix a race condition between ice_free_tx_tstamp_ring() and
> ice_tx_map() that can cause a NULL pointer dereference.
>=20
> ice_free_tx_tstamp_ring currently clears the ICE_TX_FLAGS_TXTIME flag
> after NULLing the tstamp_ring. This could allow a concurrent
> ice_tx_map call on another CPU to dereference the tstamp_ring, which
> could lead to a NULL pointer dereference.
>=20
>   CPU A:ice_free_tx_tstamp_ring() | CPU B:ice_tx_map()
>   --------------------------------|---------------------------------
>   tx_ring->tstamp_ring =3D NULL     |
>                                   | ice_is_txtime_cfg() -> true
>                                   | tstamp_ring =3D tx_ring->tstamp_ring
>                                   | tstamp_ring->count  // NULL deref!
>   flags &=3D ~ICE_TX_FLAGS_TXTIME   |
>=20
> Fix by
> 1. ice_free_tx_tstamp_ring: Clear the flag before NULLing the pointer.
>    Use WRITE_ONCE() to prevent store tearing, and smp_wmb() to
>    prevent re-ordering.
> 2. ice_tx_map: Add smp_rmb() after the flag check to order the flag
>    read before the pointer read, use READ_ONCE() for the pointer, and
>    add a NULL check. If tstamp_ring is NULL, fall through to the
>    regular TX ring kick to avoid leaving packets stuck in the ring.
>=20
> Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload
> support")
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index ad76768a42323..d48740f2b626a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -190,9 +190,10 @@ void ice_free_tstamp_ring(struct ice_tx_ring
> *tx_ring)  void ice_free_tx_tstamp_ring(struct ice_tx_ring *tx_ring)
> {
>  	ice_free_tstamp_ring(tx_ring);
> +	WRITE_ONCE(tx_ring->flags, tx_ring->flags &
> ~ICE_TX_FLAGS_TXTIME);
> +	smp_wmb();	/* order flag clear before pointer NULL; pairs
> with ice_tx_map() */
>  	kfree_rcu(tx_ring->tstamp_ring, rcu);
> -	tx_ring->tstamp_ring =3D NULL;
> -	tx_ring->flags &=3D ~ICE_TX_FLAGS_TXTIME;
> +	WRITE_ONCE(tx_ring->tstamp_ring, NULL);
>  }
>=20
>  /**
> @@ -1519,13 +1520,20 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct
> ice_tx_buf *first,
>  		return;
>=20
>  	if (ice_is_txtime_cfg(tx_ring)) {
> -		struct ice_tstamp_ring *tstamp_ring =3D tx_ring-
> >tstamp_ring;
> -		u32 tstamp_count =3D tstamp_ring->count;
> -		u32 j =3D tstamp_ring->next_to_use;
> +		struct ice_tstamp_ring *tstamp_ring;
> +		u32 tstamp_count, j;
>  		struct ice_ts_desc *ts_desc;
>  		struct timespec64 ts;
>  		u32 tstamp;
>=20
> +		smp_rmb();	/* order flag read before pointer read */
> +		tstamp_ring =3D READ_ONCE(tx_ring->tstamp_ring);
> +		if (unlikely(!tstamp_ring))
> +			goto ring_kick;
> +
> +		tstamp_count =3D tstamp_ring->count;
> +		j =3D tstamp_ring->next_to_use;
> +
>  		ts =3D ktime_to_timespec64(first->skb->tstamp);
>  		tstamp =3D ts.tv_nsec >> ICE_TXTIME_CTX_RESOLUTION_128NS;
>=20
> @@ -1553,6 +1561,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct
> ice_tx_buf *first,
>  		tstamp_ring->next_to_use =3D j;
>  		writel_relaxed(j, tstamp_ring->tail);
>  	} else {
> +ring_kick:
>  		writel_relaxed(i, tx_ring->tail);
>  	}
>  	return;
>=20
> base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62
> --
> 2.34.1

Please use proper bitops for concurrent flag updates (e.g., clear_bit()),
or show that tx_ring->flags is not modified concurrently.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

