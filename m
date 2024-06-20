Return-Path: <netdev+bounces-105467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26F9114B0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422B51F27926
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53774BF0;
	Thu, 20 Jun 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gu3mAz7F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3859148
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919140; cv=fail; b=gk1bZNxRUBixQ4HMSZd84S2r6ZRFIN6lflHgTwhfKUCT9wVEbgc51CbBvrkXFs3Q6q8brxY/XHEc1SaBOLeS+8CQsJMHrPFWfvJ+SqIcTyK+6IqMdovlEfQ04yeo/tk+FJPxKVJJH3RQqNE+pKojtOT8V2jkCxpP8M2L+zSTUOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919140; c=relaxed/simple;
	bh=aI4cMs2AvesYh/ION3Kct4SzPJbR7lkuf3eHcqzVRnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGjGDoSFaKRrzaoFMemnPnGp7cKuus/UDv+ul/L2/GrMGz8IkfykAyzpTGlv9MWOBy9UIlzbEWlG5eDY8oMVXZtIU8MgGIyp4enZtg3FtcCJ2CNVqXrdE2jsE6Gdbypj9meJeNxA+Aq9QoR8p87d/EO91ZkTmBTBrwoPr+WdlK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gu3mAz7F; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718919139; x=1750455139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aI4cMs2AvesYh/ION3Kct4SzPJbR7lkuf3eHcqzVRnM=;
  b=Gu3mAz7Fb9NXJMnIZCOEIsTlpDnxavY65kH2/q4OvATjhuTAloGyOcV8
   K8BLT7Q3oV7lHHoTKVx9nkfGetwNphtq3aAEKRiud+4FfXHvdpYEiVtXO
   kjEnupcMgPqaANOsTzRVYy/wYrjxrae9EEEqbDwMKT7F4R5aYVBnZVQE0
   AwowrFH7fIdUo5iN1Ry+a16JqpuU4B+m+mPp0GkwCDY4Hh/O9oCRlHO7y
   zJ/YV8AILm4R/Hd9ksRtqjLlnnmkqwbOnUO3dHENoXbeFMHB8T8+XnPnU
   9kcv93KCWtaohrJXwRiH8COhRZgk8UnL5AXeKa7rbxlhmEefzPwaVyEfv
   g==;
X-CSE-ConnectionGUID: TDqA425WQduYUBV4K0cNiQ==
X-CSE-MsgGUID: tWqWdMtJT3OZgPc623eslw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="18843375"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="18843375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 14:32:18 -0700
X-CSE-ConnectionGUID: 8oTaE3LtTmehWjVwMZX8+A==
X-CSE-MsgGUID: IrR7FlghRvqeUW0xF8Z4cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42838278"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 14:32:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 14:32:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 14:32:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 14:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYXefVBE2oMahRM3zfDWGmONoG+dWmCSB9x+9BH3qxuDbiRMByJ5j3Jt25QlBN8i3/T44Jw8WxBPX0LoXYHMkUbrQVHSREdxajjSFYTEJOlrIQ2gx63gPTSGqIJL3eiiYGgazSb553fU20b/mlrfcluCZIrkqIpm+hxwjliK08LDE733uBicsz0D7SUi2DxaZIjdwX7QTVnVlFG6Lpqp/l3+I+gY/uroXtoL7DapYwUjsNOzPv8qCgWqjySFKiHGsm8AYkXzqav31d7iAPKsGJViDr5d5F85v4QgwxJq4YSO9zOFcfymA1IaAnP6KzpMAGUsa13LjrH/jFm3cTv3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI4cMs2AvesYh/ION3Kct4SzPJbR7lkuf3eHcqzVRnM=;
 b=kssHoTdlIu+6CwUIr/+rAs9n/vHBaNbgyy5KAE5f0PdHNL3TJE17ML/9wMvyKoPvqX4VE3s4u7anVhhEgcogErywYIkrYmRgn3BsMKgD0Eyys3GmgGTq23Lk9zfDZM0Sa/doSumUxYXCgIcdjCe0zbK76rR3JDi94skYpl5pdYoHsV7Xh8XkidCV+/OuCpGsfHH5Z9L+ddTV9DDPEV36t45xdvm4ecZ213BbM5jD02doQsCjG3rmRhPEZB9BbnteUQsh3COjanOp8vHRMzxaQ89CK4SQoqVUqVdXoV0GNFHvOHrIUQz9lXDi5D3XyX+RerUyk3raCHkxXstPvM5mYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 21:32:15 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be%6]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 21:32:14 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Boris Pismenny <borisp@nvidia.com>,
	"gal@nvidia.com" <gal@nvidia.com>, "cratiu@nvidia.com" <cratiu@nvidia.com>,
	"rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Acharya, Arun Kumar"
	<arun.kumar.acharya@intel.com>
Subject: RE: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Thread-Topic: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Thread-Index: AdrB1/ByhY5vhdaNSxq8hQ6vCeqC9QATE02AAEx36mA=
Date: Thu, 20 Jun 2024 21:32:14 +0000
Message-ID: <CO1PR11MB49939F947A63E4A5F8C5246A93C82@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <CO1PR11MB49939CBC31BC13472404094793CE2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <66729953651ba_2751bc294fa@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: 309fbfb3-25b2-4410-0faf-08dc91707411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?S3lTYmh4b3l1MHZJOFh2NlZTcjhDeWNDQzhlMG40S3l2NGlMUlB1ZWt4bm9q?=
 =?utf-8?B?blprTW92cWc5eGlDSnZQTXFuMzM2czlMODJBdjMyUEM4a1NBSnAyV0lXSHBn?=
 =?utf-8?B?VUpFc1JmKzFzQmtldDd6TGl4MHpsUmltMGozaDgrM1Fhc0ZJM3plVmw5dStK?=
 =?utf-8?B?cTdSZC96ZFVoRk5PVjVhNlREdHI2TDhjUDVBWS96YStvNGlyWlJYVXpuOEQ5?=
 =?utf-8?B?d1BmZmpvM0VQUUlTdXh6bGNUYnNDMFpZanMrTFFuRmo1bzFoK1VyaHZlbHRu?=
 =?utf-8?B?VEVSS0RPWXU1MEVnSHZLbGRVUzI5VG1tZmZtL2ZxaTlDeGZCUXV5bm9qZE83?=
 =?utf-8?B?SEk1SFhVNVhsWjhTVHFxblRiU3VNNFhXa3lnZGdOY3FMOXh0Sk5JZDd5NTFh?=
 =?utf-8?B?NWYrU1h0QTBXQjRwcUpNVExLeXdHRG1FWjBSUDBPOUJ6eTNCUURGVlMwQnpJ?=
 =?utf-8?B?dG0zQ2o4c2d2VnJObGEvYmo2Y2FZRGxFdXFRRHdKV0xjRGc0M2V6aUtic3Bj?=
 =?utf-8?B?cGRKSDFRMHdhQ1VSU0N0UzU1bUg0MHNyZjdnK01ZYlJJRUdGYytHdTYvcElJ?=
 =?utf-8?B?TU1oRnFabDVzaVBLc2lwbU0wZERQdnFwY1F2ai8rUUFqblRzQjlQMzQxV29i?=
 =?utf-8?B?aWxITGMzQ09xSlBkWDYranF1Qm0xcW15OHhtZHhxTlRyMm1laHhyaTd1amlC?=
 =?utf-8?B?VWYydmZSdE5abWJmRDA4OU1rSDB0dDU4V3Y0YXZvUTlDYjhpMU5tRHVxNmlL?=
 =?utf-8?B?U0hveGU3SXhyODhiVFhMUE0yeHhVSnBYTlJKNDFKU3ZoNUREQkswU1JRUlQv?=
 =?utf-8?B?MGdjNURwd3BDVlVLalkxbHNBQ0IzSzlrYzE1azNta3FxeGUwUkhpRklHMCtE?=
 =?utf-8?B?OFQxSjZzdnh3dlNUZWhaOHdmc2RydWZkS0RSb2x6ZW5VRTV1YkZEU29WcnQw?=
 =?utf-8?B?S3dQZ1V1RHIrUDN1bDBjNDNSNVhoZzVtTkxBeVg4Z3dxVkk3QUg5NnhEM1J2?=
 =?utf-8?B?NkdiK2JXUWpxWHhWT205cUk3WHpJVmJHRThseXhya2hpQnFOQ2hPQVZvc25V?=
 =?utf-8?B?cWF3bVZhbEpKNGZxbk9TZkxYQVMzazVlemFyQTZBVjUyZ2NwcnJqd0hnRW1s?=
 =?utf-8?B?bzZpSnZrS3pCQ2grSE5mWHpyMXRaS0FPVUFOQU1QajBBbFJudms2T2VOdGNW?=
 =?utf-8?B?ZlFsTmltM2VreE9Td09FWHN2UTNFOGxmRFlZR0tIRVREdUVNeHhBRGVqNk5J?=
 =?utf-8?B?T2xtTGNZZEV2V1FlQ0hyOXNQRk9NUG85SkNvNUYyajlFUEJkekljMkgwYXU3?=
 =?utf-8?B?OVpwS1J1TUV6RzhVMFZIQjN1RVZRQWZuY0tjV0JCRVFHM2VRMFpLRENpQWtU?=
 =?utf-8?B?ejM1YmIrS0JieWoyN1FSNk4yU25aWWltcWFveTFEUkFUamIwaVVQZnhxK1dm?=
 =?utf-8?B?dXM1UEJEWkQybWVOeHNvUkx6ZmszenJaU3ZiaHUzM2Q5MjZDdE9tUzcyWHUy?=
 =?utf-8?B?T1VwSGdoaFhJZGc4MEpPVXVyYXlPck9FTWRmenlNOG9UMnZZbjh5M0poWFo2?=
 =?utf-8?B?RTFuUkRHVUhJOHpsSVN4aU45cEhwTFc0VFlJdUthTnRNcVhEYTJseTJJNTdZ?=
 =?utf-8?B?K2lOSHhmbTNTUERNWHd4dXN5SDZMeFE4dyt2b1Q0SHZtaFRvUmQ1NXNIaVZt?=
 =?utf-8?B?b05PRmxOQWlSZ1VHUVJzeVNBdWc5cjF5Mjg5LzMvMDlRa2JQQUNhalRyNEZY?=
 =?utf-8?Q?ZvEwi99y5qC1yXI7242Et0CKXCgIot0odhT2h2m?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVdTcWlyUUxrVS91YnkvM2NyWjJpVm50bmVqc1o2MTFWelpnYlJKVE1ETnVE?=
 =?utf-8?B?dzVrQkhJTmlCQ2gzSnhkUUhhc2J5bllIZ2N6ZFlzZjZLSFhXaVN5MnNoR29N?=
 =?utf-8?B?a0lnbVFSSzdQN1dsb2tIN1lpS0UxY3FXc0VSRUFMbTFIS294Mmx0Mi83QWlO?=
 =?utf-8?B?R1huUjg2NkthMi9KWjg0b2lJUUYva282eGd6Z1lwNi9Nc0E2MWpXanpxSndQ?=
 =?utf-8?B?ZlZ6L2ZjanhVTFZnUE4xZk5LNDM4V1Ava0tqQXFQS2dCL1BSV2R2Nk80cWFO?=
 =?utf-8?B?YzJMc0RnVk5QcnRnNFdpbSt3ejZjNG9CV0hYREx0QmRzK3k1R2U1MmpJUEtj?=
 =?utf-8?B?NHJ2dGRRK2ZKSXhZY2t1NWlWL3FoekFaZHI0cEdwQ3FCL3czcTV1WStWNTJD?=
 =?utf-8?B?bGU3cWpnNHpKRk9ZbzIxU282VmdWN3JGeFlGNEx3RGw3ZVIxOTFhdjVycjBx?=
 =?utf-8?B?eXZhQXF0RnBJSHh5YWk0Nk4wUnlNQ3VzUzExdVdyYlNCcjRpS1huTTlVQ3dB?=
 =?utf-8?B?M2x5UFF1V1hwa2QrdURjTWVYdmxBaUFBSGRRSUFJVVpESVVTZFV0T29HRUVH?=
 =?utf-8?B?cUZEd2h3THRjNG1VcEh4RGFmWWFsa05ZZTRGQjR3M1NjNXo2RUxoNFFQb1hB?=
 =?utf-8?B?SzVMNVlxQzFRRzcwcWt6cHBQUlNXdXI0dlR4VmJ3ME9kbnRWd01MUTd5VllT?=
 =?utf-8?B?SG9tN2pPaHlZalRPSXNpQTlMS1I5Vkt3WllOMTVjZDMza0hkNERnTExCLzlG?=
 =?utf-8?B?T0FWVHR1bzhlWTgvT3UwdjNqS0lDTElMYnNwcW9uL3NaM0hla3pTUHFuN0pZ?=
 =?utf-8?B?NDhDQ3NCcit2QzBlYW15S3pnV3pXZnlXeGNvZjZWZjZ2K21YWkRZdkx4L1pt?=
 =?utf-8?B?Z3ZJcVR2UmRwck45UWFDeDJaYTVuZU1qOFM2Q1R2Q2Zla3QyOE5PQ3JxMDFB?=
 =?utf-8?B?c2E3bHdiSXh6YlV6WTZaSko4eDFZZ2dMV0F0ZHRseDl3S2IwbTh5OTMxQkhH?=
 =?utf-8?B?M2NIV2ZQN2NsRWdaRUhtUzFadHhJNmRybzJtTjlrQ1pkUzNXMHdBQ2ZXWmFr?=
 =?utf-8?B?bmp4c2txZU9rc2t3ZXh4US9GSjRMMkQ5V3J5bzJqWnNNM080MEdzWU9kM213?=
 =?utf-8?B?cFRtTytTa0EzRFFnZ3pnYXZUNCtybGFTMGd6UVlxaE9HMUpOUU1VTGt0TlFj?=
 =?utf-8?B?N21OODRlYU80clcwY0hKTnhDazBsRFBoSU9pR3hiZjU0Ri8yd0lHRVB2RDF0?=
 =?utf-8?B?RTlHNmwxRjBSM3VOR0J5ZkNzTmpHSHJCMUU0RGtzVHVMZDk3Rnh1OHV0R2tL?=
 =?utf-8?B?Y2RiVVlRUFppKzVzWlJ6TmZJTTdjVVY1cC9sblV2VEdwOU5qWmNObWtyU1ZK?=
 =?utf-8?B?SHNYcllMWlpWQmF0eXpYQzJYTUdaRnJwak5UYk16ZTIvZFhkZUNSVUtKYmJB?=
 =?utf-8?B?TXJOVVZMWlgxYjcxSHBIdTVxeWdJT2xBR28wVkFQSHExeEw2K3pLcUhJdVk3?=
 =?utf-8?B?R3lpeUY0ZzFVZmxGY0tBelNEY3hsTkUvWUpzTGc2aFR2NUxNSDBWc3JTaU1l?=
 =?utf-8?B?ZjBlNlNxS2xlOG1jWGgwNWtJWmk3dFlHcUJqMG41ZnBJOG82ay9oUmpuRjBT?=
 =?utf-8?B?WXkxOW5MSEZWM2hKUndzMm51Sm9UWjJ4bzF6bWtqRkVpWnVMT0UreG9BNXV4?=
 =?utf-8?B?UkR0RlNDU2pLWUI4RFpYTzZ6Mlc3SWVpQkxURTFuVjdlcUpPa2I1aUE4dmxo?=
 =?utf-8?B?NHNpalNUeFdORzRvbkpGTE5Qd2szQWl1bjhYaWFoWUlyRHJSWWpOeE1SZkFI?=
 =?utf-8?B?V0IwNUZhYStZTktWdjlJZmlkT2I2ZWJqTm0xZ2Myc0ZYTk1NQ1NIcVpPWWtI?=
 =?utf-8?B?TzcwSk9hVktoRWk5ejdmaEhwc3NEWFRmWmlJREN0bmV4dGZJRDJTMkpRY1FC?=
 =?utf-8?B?cGFMSklHZUQzamtRRkk2QkZzUDcybWdKZ1NjVDAvZXkzRTloNWxoVktIVmlC?=
 =?utf-8?B?d081ZVQ5S2ZDbHF1ZXdvOWtjR2p5VmNHVVB0NWpFenNxTG8zYi9jV3lKL2th?=
 =?utf-8?B?NVc3WlJTQVRVZERoTzRkRjRZbUw2SmgvZXdLdWQ3a2hvUnk4dk81TW1qV1dI?=
 =?utf-8?Q?ztpUVTR6Qw5X5ISnNyxKVQrjv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309fbfb3-25b2-4410-0faf-08dc91707411
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 21:32:14.9393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5J60KG9/l4kkb3nDgFeczVm9LBMHbWJAu1N324c701OVTM+Kv1qIjJPF+64+5x/O6zjaUHCK/Mb4wjADgwuiz6lHQdpnf9NKEEl/6ouE70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com

DQo+ID4gMS4gV2h5IGRvIHdlIG5lZWQgwqBuZG9fb3Agc2V0X2NvbmZpZygpIGF0IGRldmljZSBs
ZXZlbCB3aGljaCBpcyBzZXR0aW5nIG9ubHkgb25lIHZlcnNpb24sIGluc3RlYWQgdGhlIGRlc2Ny
aXB0aW9uIGFib3ZlIHRoZSBwc3BfZGV2IHN0cnVjdCB3aGljaCBoYWQgYSBtYXNrIGZvciBlbmFi
bGVkIHZlcnNpb25zIGF0IGHCoCBkZXZpY2UgbGV2ZWwgaXMgYmV0dGVyIGFuZCBkZXZpY2UgbGV0
cyB0aGUgc3RhY2sga25vdyBhdCBwc3BfZGV2IGNyZWF0ZSB0aW1lIHdoYXQgYWxsIHZlcnNpb25z
IGl0IGlzIGNhcGFibGUgb2YuICBMYXRlciBvbiwgdmVyc2lvbiBpcyBuZWdvdGlhdGVkIHdpdGgg
dGhlIHBlZXIgYW5kIHNldCBwZXIgc2Vzc2lvbi4NCj4gPiBFdmVuIHRoZSBNZWxsYW5veCBkcml2
ZXIgZG9lcyBub3QgaW1wbGVtZW50IHRoaXMgc2V0X2NvbmZpZyBuZG9fb3AuIA0KPiDCoD4NCkNh
biB5b3Ugb3IgS3ViYSBjb21tZW50IG9uIHRoaXM/DQoNCj4gPiAyLiBXaGVyZSBpcyB0aGUgYXNz
b2NpYXRpb25faW5kZXgvaGFuZGxlIHJldHVybmVkIHRvIHRoZSBzdGFjayB0byBiZSB1c2VkIHdp
dGggdGhlIHBhY2tldCBvbiBUWCBieSB0aGUgZHJpdmVyIGFuZCBkZXZpY2U/ICggaWYgYW4gU0FE
QiBpcyBpbiB1c2Ugb24gVHggc2lkZSBpbiB0aGUgZGV2aWNlKSwgd2hhdCB3ZSB1bmRlcnN0YW5k
IGZyb20gTWVsbGFub3ggZHJpdmVyIGlzLCBpdHMgbm90IGRvaW5nIGFuIFNBREIgaW4gVFggaW4g
SFcsIGJ1dCBwYXNzaW5nIHRoZSBrZXkgZGlyZWN0bHkgaW50byB0aGUgVHggZGVzY3JpcHRvcj8g
SXMgdGhhdCByaWdodCwgYnV0IG90aGVyIGRldmljZXMgbWF5IG5vdCBzdXBwb3J0IHRoaXMgYW5k
IHdpbGwgaGF2ZSBhbiBTQURCIG9uIFRYIGFuZCB0aGlzIGFsbG93ZWQgYXMgcGVyIFBTUCBwcm90
b2NvbC4gT2YgY291cnNlIG9uIFJYIHRoZXJlIGlzIG5vIFNBREIgZm9yIGFueSBkZXZpY2UuDQo+
ID4gSW4gb3VyIGRldmljZSB3ZSBoYXZlIDIgb3B0aW9ucywgDQo+ID4gICAgICAgICAgICAgMS4g
VXNpbmcgU0FEQiBvbiBUWCBhbmQganVzdCBwYXNzaW5nIFNBX0luZGV4IGluIHRoZSBkZXNjcmlw
dG9yICh0cmFkZSBvZmYgYmV0d2VlbiBwZXJmb3JtYW5jZSBhbmQgbWVtb3J5LiANCj4gPiAgICAg
ICAgICAgICBBcyAgcGFzc2luZyBrZXkgaW4gZGVzY3JpcHRvciBtYWtlcyBmb3IgYSBtdWNoIGxh
cmdlciBUWCBkZXNjcmlwdG9yIHdoaWNoIHdpbGwgaGF2ZSBwZXJmIHBlbmFsdHkuKQ0KPiA+ICAg
ICAgICAgICAgMi4gUGFzc2luZyBrZXkgaW4gdGhlIGRlc2NyaXB0b3IuDQo+ID4gICAgICAgICAg
ICAgRm9yIHVzIHdlIG5lZWQgYm90aCB0aGVzZSBvcHRpb25zLCBzbyBwbGVhc2UgYWxsb3cgZm9y
IGVuaGFuY2VtZW50cy4NCj4gPg0KQ2FuIHlvdSBvciBLdWJhIGNvbW1lbnQgb24gdGhpcz8gVGhp
cyBpcyBjcml0aWNhbCwgYWxzbyBpbiB0aGUgZmFzdCBwYXRoLCBza2IgbmVlZHMgdG8gY2Fycnkg
dGhlIFNBX2luZGV4L2hhbmRsZSAobGlrZSB0aGUgdGxzIGNhc2UpIGluc3RlYWQgb2YgdGhlIGtl
eSBvciBib3RoIHNvIHRoYXQgZWl0aGVyIG1ldGhvZCBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNl
IGRyaXZlci9kZXZpY2UuDQoNCj4gPiAzLiBBYm91dCB0aGUgUFNQIGFuZCBVRFAgaGVhZGVyIGFk
ZGl0aW9uLCB3aHkgaXMgdGhlIGRyaXZlciBkb2luZyBpdD8gSSBndWVzcyBpdCdzIGJlY2F1c2Ug
dGhlIFNXIGVxdWl2YWxlbnQgZm9yIFBTUCBzdXBwb3J0IGluIHRoZSBrZXJuZWwgZG9lcyBub3Qg
ZXhpc3QgYW5kIGp1c3QgYW4gb2ZmbG9hZCBmb3IgdGhlIGRldmljZS4gQWdhaW4gaW4gdGhpcyBj
YXNlIHRoZSBhc3N1bXB0aW9uIGlzIGVpdGhlciB0aGUgZHJpdmVyIGRvZXMgaXQgb3IgdGhlIGRl
dmljZSB3aWxsIGRvIGl0Lg0KPiA+IEhvcGUgdGhhdCBpcyBpcnJlbGV2YW50IGZvciB0aGUgc3Rh
Y2suIEluIG91ciBjYXNlIG1vc3QgbGlrZWx5IGl0IHdpbGwgYmUgdGhlIGRldmljZSBkb2luZyBp
dC4NCj4gPiANCg0KPiBUaGlzIGRvZXMgbm90IGFkaGVyZSB0byB0aGUgc3BlYzoNCg0KPiAiQW4g
b3B0aW9uIG11c3QgYmUgcHJvdmlkZWQgdGhhdCBlbmFibGVzIHVwcGVyLWxldmVsIHNvZnR3YXJl
IHRvIHNlbmQgcGFja2V0cyB0aGF0IGFyZSBwcmUtZm9ybWF0dGVkIHRvIGluY2x1ZGUgdGhlIGhl
YWRlcnMgcmVxdWlyZWQgZm9yIFBTUCBlbmNhcHN1bGF0aW9uLiBJbiB0aGlzIGNhc2UsIHRoZSBO
SUMgd2lsbCBtb2RpZnkgdGhlIGNvbnRlbnRzIG9mIHRoZSBoZWFkZXJzIGFwcHJvcHJpYXRlbHks
IGFwcGx5IGVuY3J5cHRpb24vYXV0aGVudGljYXRpb24sIGFuZCBhZGQgdGhlIFBTUCB0cmFpbGVy
IHRvIHRoZSBwYWNrZXQuIg0KDQo+IGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9n
b29nbGUvcHNwL21haW4vZG9jL1BTUF9BcmNoX1NwZWMucGRmDQoNClllcyBJIGd1ZXNzIHRoaXMg
aXMganVzdCB0cmFuc3BvcnQgbW9kZSBhbmQgbm90IHR1bm5lbCBtb2RlIGluIHdoaWNoIHRoZSBk
ZXZpY2UgYWRkcyB0aGUgaGVhZGVyLiBTbyBhZ3JlZWQsIGl0IHNob3VsZCBiZSB1cHBlci1sZXZl
bCBzb2Z0d2FyZSB0aGF0IHNob3VsZCBhZGQgdGhpcywgYnV0IGFnYWluIG5vdCB0aGUgZHJpdmVy
IGFzIHRoaXMgaXMgcHJvdG9jb2wgc3BlY2lmaWMgYW5kIG5vdCBkZXZpY2Ugc3BlY2lmaWMgYW5k
IGFsbCBkZXZpY2VzIHVzaW5nIGEgIGNvbW1vbiBjb2RlIHdvdWxkIGJlIHRoZSByaWdodCB0aGlu
Zy4NCg0KPiA+IDQuIFdoeSBpcyB0aGUgZHJpdmVyIGFkZGluZyB0aGUgUFNQIHRyYWlsZXI/IEhv
cGluZyB0aGlzIGlzIGJldHdlZW4gdGhlIGRyaXZlciBhbmQgdGhlIGRldmljZSwgaW4gb3VyIGNh
c2UgaXQncyB0aGUgZGV2aWNlIHRoYXQgd2lsbCBhZGQgdGhlIHRyYWlsZXIuDQoNClRoaXMgZm9y
IHN1cmUgaXMgYnkgZGV2aWNlIG9yIGRyaXZlciwgaWRlYWxseSB0aGUgZGV2aWNlLiBQbGVhc2Ug
Y29tbWVudC4NCg0KQSBmZXcgbW9yZSBvcGVucyB0aGF0IHdlIG5vdGljZWQgbGF0ZXINCg0KMS4g
S2V5IHJvdGF0aW9uIHNob3VsZCBiZSB0cmlnZ2VyZWQgZnJvbSB0aGUgZGV2aWNlIGFzIGEgbWFz
dGVyIGtleSBpbiB0aGUgZGV2aWNlIGNhbiBiZSBzaGFyZWQgaW4gYSB2aXJ0dWFsaXplZCBlbnZp
cm9ubWVudCBieSBtYW55IGludGVyZmFjZXMgd2hpY2ggd291bGQgbWVhbiBvbmx5IHRoZSBkZXZp
Y2UgY2FuIGRlY2lkZSBiYXNlZCBvbiB0aGUgZm9sbG93aW5nIHdoZW4gdG8gdHJpZ2dlciB0aGUg
a2V5IHJvdGF0aW9uIA0KCTEuIFRpbWUgb3V0IGNhbm5vdCBiZSBpbmRlcGVuZGVudCBmb3IgZWFj
aCBJS0UgYnV0IGF0IGEgZGV2aWNlIGxldmVsIGNvbmZpZ3VyYXRpb24uDQoJMi4gIFNQSSByb2xs
IG92ZXIsIHRoZSBTUEkgZG9tYWluIGlzIGFnYWluIHNoYXJlZCB3aXRoIG11bHRpcGxlIEludGVy
ZmFjZXMgdGhhdCBzaGFyZSB0aGUgbWFzdGVyIGtleSBhbmQgb25seSB0aGUgZGV2aWNlIGNhbiB0
cmlnZ2VyIHRoZSByb3RhdGlvbiB3aGVuIHRoaXMgaGFwcGVucy4NCg0KQXBhcnQgZnJvbSB0aGlz
LCBpbiBhIHZpcnR1YWxpemVkIGVudmlyb25tZW50LCBhIHRyaWdnZXIgZnJvbSB0b3AgKElLRSBk
b3duIHRvIGRldmljZSkgdG8gcm90YXRlIHRoZSBtYXN0ZXIga2V5IGNhbiBjYXVzZSB1bm5lY2Vz
c2FyeSBzaWRlIGVmZmVjdHMgdG8gb3RoZXIgaW50ZXJmYWNlcyB0aGF0IGNhbiBiZSBjb25zaWRl
cmVkIG1hbGljaW91cy4NCg0KQW5qYWxpICAJDQrCoA0KDQoNCg==

