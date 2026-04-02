Return-Path: <netdev+bounces-274659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMU/EQa4zmmTpgYAu9opvQ
	(envelope-from <netdev+bounces-274659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:40:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C538D456
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D85030A111B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C336C0DC;
	Thu,  2 Apr 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmNxGTKr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FE6A001;
	Thu,  2 Apr 2026 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154779; cv=fail; b=Hz793OfXExLTkGL3t9mGbTsNFBF42+ox6v4jCp0gQ4c1oMv848q3DUHdU6H7YNlhe1Zt1ZtLoPD+fiBy/6Hzk2753NP49UhWQi476/H4yYTE0nrlaw5sCXr16xOlGOGfahlvqb8zdB61qnkEOOP6bxJfiGtLxFbataYINp5HH0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154779; c=relaxed/simple;
	bh=etC9ZWMZXvj9DjvVRcU0jnpSH3070MGsH7LFE60NuQE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ImSBAzTWH1TSrQO35aomMkscJea5F1Y0q+HqEvrwVkNzCVsS7zfL8u7eFDRTCH0ZSn7RSLtqUDB/XvTMUf53YHBIbVwKXFk6BXEUYNT9GFEIhocFcvywSkWVDqSpEeyuPzwGJmlrsamerEULFRSqL0DdQiG8rO4gUuJ+f4j9Cvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmNxGTKr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775154778; x=1806690778;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=etC9ZWMZXvj9DjvVRcU0jnpSH3070MGsH7LFE60NuQE=;
  b=KmNxGTKr47/YZKEofbLzu/Fe9jR0olsNFnUmPIklGlanXb1H5E/4w12b
   8xJ2VeVkxVmTZMXqttGRT8DBHBGKjEnNssLmrdOkCq1o+cKNWlQmDdBdn
   ddeKYAniUm+Wunl2PKvM6Av3aKH7lSlPIEzSGEV+LipT8UURlZqttL6m6
   wmMqWY5UFWvTgw03ZfCgON2mgK1y/DZuRTJZ8tTYXogXs4RQIvQHVGOh4
   bpfJIMnG+7PkV0FdbSB9pjQHt40mk3XybRPPtr7uzhFu9EN67d2sjY6pm
   wvp6BAVl6RtM6Wq3oOhpxMwJ8BB7uvzpFX1IpdGoIPBsiseuSis8SVQyV
   w==;
X-CSE-ConnectionGUID: 8+1RZAQXSbWfWPaw+je42Q==
X-CSE-MsgGUID: wnGy2oaGR02stZdVkNTzqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76104259"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76104259"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 11:32:58 -0700
X-CSE-ConnectionGUID: VlLsRv7gQpmqjFmT0XQElw==
X-CSE-MsgGUID: Qp2KXyPES1uHU+QP+hhYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="220404082"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 11:32:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 11:32:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 11:32:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 11:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxR2p34zYBTtm+SjS33cwxhuWRtld2d01v8a5EtFJZaCvMn5dcXeFpG0feD0D3eRboU3U0RC9gbBs3v4+1pOsdby6MZg3U809j9DzgsoAbiYT0gTkmEUI8KEKSBiv8eU8ghyIBOS2nU+E7lzAD2ZLr/UbEDmeQv33QAE93m4ioyKmSqAqMyThIW3rrFLmVrCOL/4gxbhkG1I19wWng9WnEwEQXDid/VFEVcAqGfhctR52vx5ntmi8hVMmgnch+i3Av/7dkN5GUaladNU0ZTytATQmsBbqzQE8WMupL+tvogZn+i1T+osvvfJHNGiDFND8oIUV/v9rbSdTLEirb1KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hErmxXLgUHJRKGhnpvHdtnZwt0eM+xqgzG22OwkqAjo=;
 b=N/zm0ImKW8WclGIZzbKsgoq1SmSc8EFkeToYzz3LnvkN107sGtL/nH6bx2sb6bbgEFfP+vjMBoTfR3+Cy643hRHk7W8trCblZWQTike9sB0mwNv4KXLaIYgeUK/UD5/Lxzcgh3V6W2G53rp3QQWrqh61TQe5d38H9cwAaxcXOL9Egw5zCpkgk4+YxTqJuW47dqLfuElrusge2ksGvyBu9dwjc/hYKV0/L+a1W9dLSJKLxBVDng1WVELHoVVGZ9WbuYmyLvINl/NDWgp/VIRoVoXBGanK+PNg056nO49vO4FR9m0R4fRGNXwwMRBK3TidjzPpdBkrJfvfWQQ5pvB+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:32:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 18:32:49 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Apr 2026 11:32:47 -0700
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <69ceb64fbdea6_1b0cc61009c@dwillia2-mobl4.notmuch>
In-Reply-To: <1d9abc6a-9032-4e0f-b7d8-1bdbdfa0d615@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
 <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
 <f0f5a510-4073-444c-9f05-7153d0b2087b@amd.com>
 <69cd93e334c11_1b0cc6100fc@dwillia2-mobl4.notmuch>
 <1d9abc6a-9032-4e0f-b7d8-1bdbdfa0d615@amd.com>
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:303:dc::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 903e8e1e-edb5-4add-2919-08de90e63e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5oAD1Ykuh2TbBoh2itJRomH3UUFDk5rIaeYvzVeXzAb3Pk4spHPEuHkga1A9kMhY6rbTL4WmfAoCLGQNPnc3isHKlpp55FtlgUh8sZXnUw1joglrNgkYeyOiSjcx6nf1kK6Fnz6w8zHQok8EO4QAjYxpAwT/A5N/7N8BjS3YBzWGOmNql1OHlAXqY4TGmJUp4Xv67OCkkF46igAqBiLL9iKVzV0vrXJifCUWCyeUDPNGN71JapHsOmQCgKY1fwXFSHn8JWrLtVPLnzETlb6BJVOcDmjAR1Brqd46kmdb6+VszqiaSgH+/aTUFjPz5Nyb02O7zvWgbj3GNeTaQxgATtOQJEx+xKVcSqipCAIqqDjUo9AIkofAqov4jy8D3TeyArIYE0IutsBCWRFb6GdOE0nHeuSTUUInGK2xnRI49JDhjo0zkzst+qtLPo5LuPlcavLjvCOg28Je7tE4XsAR3orEQYtQBDZZ1l+UnSK8yStXjP7D1kPwD4OhzqilA5+Xlm91t9zs+BV+Yq3ypSMa+E2fiE69hFWd86JAU/rk5qXjOj+I96xJGMOyfP81lR2Qvq+DxFdiD+NOwRy0RGC0j3BdRYqP48sh9Bv1GanVE7wl6pC3XSOElcK+AgYowZaC0hYSTVupXORncdshmckTK41gxD7DO4qaJ5FgvvdydKd41IRNLYUJhVi/WugxYwVfXds8JG1X2HZJ5PB8AWJYxAOVBl7hpfQwYCMdQM97CezBdaGhVmRro7OUwql4VGc+VOuxSvYArw7IL4lA7640AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2l0TUVKK05mc2dBWFlFWWpZZnVNY2hCMllZTWFvUi9JVDhweVpCenVDVHp6?=
 =?utf-8?B?cGtQOW8vd0JJQi9oWW04azJBeU1wNU5ldThSeGdNVmhrYlA0bG5waC9QYkdI?=
 =?utf-8?B?SkgwSitDMnYxWDNlWkpNZis0a3k4UnFKYTluMEkvUkJ0TEhuYlQyUDRVcFVO?=
 =?utf-8?B?MzF5SHp6d3FJVXQ1SDA1eTRjSWNlK3RxRW8rK0M5Q1g5TTRkdVU4cUFQeEtt?=
 =?utf-8?B?TjdvTXVXUzNnSG55QUR5ZEFTODcwRDlmSEV5K0N4cDk2dnJUM2JwekNTMk90?=
 =?utf-8?B?K2pQVy9iYjQzS0tmaml4blp4OUFydTY1dzZhNE5pMmNsbWJsZExYTGJvTWxP?=
 =?utf-8?B?eWI2SkFnSDZOWHJhbEYyNU8yT0tNdmlOaU1RWHJpczNwN2pJWm5TYXZ6SkNZ?=
 =?utf-8?B?b2ZuREFkdjJxbjRYUXAwZWphcllPMUtQNksvOG5nV3dlUDc1TFN2dmdyV1ly?=
 =?utf-8?B?aDFQRlpDRnBGYUo1K0xnRlRIQThqdXNXaXk4RzNQZE1KYjFDYXBpb0VLSSto?=
 =?utf-8?B?R2pNL0x4RkhZSTB3OVNMYVg4aFJjZCtTTkpFRWRrWWpRaExzcTNCZ0VUVlo2?=
 =?utf-8?B?ZUhRdTJRYTZvN1ZBVVhmZjA1VFhCUGFCOGZncUJCRnY4VUc3V01JMzRsWTZ2?=
 =?utf-8?B?STJEWlRYNmRBU1o1WlpwbXVOZURmY2REcDc2ZXRjdzUyUlJmS0ZsODhRYm1R?=
 =?utf-8?B?MFpERFlRWHdtQ2Jnam1JZEc5UGFZS2tvcThFaHlGRGdxemdoU01TTmorM2tL?=
 =?utf-8?B?bk9jcXRsWkVEUUJDRVhlUC9YQU5zbThHZ2ptSkZuU0hjK1pKNHY1R1FqN3hL?=
 =?utf-8?B?bjM4SHpPVHNTdXRpcWNnR1lVTlBUYW51R2lsYjZMbituNUdKRUMvRGJzcXNL?=
 =?utf-8?B?c3IreDNETDJtWTR0TjZuT2d6Ty9UUG5EbW5Wb01wTGxSQkJMSE8zeGljUmdy?=
 =?utf-8?B?RVRhcHo2RWU2aEZBVUhYOFkxVmg5dlkzZVJzUG5aaUphVGIwa3RNaXZrOERn?=
 =?utf-8?B?ZkpaWEM5NjJYT3lyZnFsMHRXQUMwdmFEZnp6bkRqSUd2dExWTkFhKzA0alhC?=
 =?utf-8?B?cXlDbXZLMkp2enZyKy9vbkkvQldyOWpITDJkcUkzMnh1alpWcThBNDlWVWJi?=
 =?utf-8?B?L01UWERjeFA5aTlwRmdGSWlSTUQxb1RHVXhSSUhycDBTKzcrdmVHS1dpMWFZ?=
 =?utf-8?B?QjZ1TnFuM2RqdDU2cTVYRHM1SEgxZk9hMWMveEZ3MmJ6K3RNQTF3ckRhT0s4?=
 =?utf-8?B?bG56Q3YwYjk3WS9xUmxXangzRmJhQUZKZFN3Sjh4L2tFTkNIaG05SW1HRmF5?=
 =?utf-8?B?WU5kK08xUFFFVWt2TjdMMjhSSmFiem84aDhBaHd1cEI2NG5jdExicTN1aXpl?=
 =?utf-8?B?dFp3WWExVWRLWUkrS2I0N0lWTU5JeFFyUi9ac3R3OEV0SDE5RGJGYytYbEtj?=
 =?utf-8?B?ZHlMUXMxWjlvZFJKRC9rWEVGUnNUalg0RnVYaGZlOGluYnRTd3dMZ1hVSVVt?=
 =?utf-8?B?WUptL0VoSld4REt2UXJLV0FHaU5rRndJOGNxMzgzYlR4QVRaKzEvbWpFejh6?=
 =?utf-8?B?dDY1MERrbHZLNG9OaTVqVUo3S2dGTkk2ZUhCRmZwK0ZrYlIwMkowd1RZYURk?=
 =?utf-8?B?Y2pHenRDOU02NlpKWE91dVI1WjlSSjB5TFVHMjNCd1RZL1pmeDFwNVY5dDYz?=
 =?utf-8?B?N1JWNkRWVkJMdmZWVDhCVDFOYkxreFE5UU5EU1k1OWU5UVNwWHFPOVRDMGtl?=
 =?utf-8?B?c0Q2RWJQMEcwd3dSb2RaTlNMc1RZT2taMVBYNG9BSTBnbjVIT1J4Z2NUb3dU?=
 =?utf-8?B?OVFkM21LK0RnNm95cU9LY3ZUcmEwclBqRVA2UWxLeEQ2SCtabzFKenFOWCtF?=
 =?utf-8?B?WCt1TVRjRHNzdXRWV050ajVrRWllVlIvTUppUHhiQ2hTNHcyWTRpcnFEVk9i?=
 =?utf-8?B?Y1Q1VlR4elFSK1FsaTZlbmpOSzQ2LzNGMlo1dzFXVDhmOXlpMThJeU5icUN2?=
 =?utf-8?B?TEJzQ2h2b2FBSW8yY2p4ajBhUTF2Y0FwMkIzcWFzWWcvSDRBem9yTDZRU0ZL?=
 =?utf-8?B?ZElUUm5CUHFVUFQ4QWFiSnhtY3RFYk1tOWVwaHk0M0MrZE96YlFRdzNPRE0w?=
 =?utf-8?B?WDFRL1ZuVWNmQ2tVcDdPaVRENHNnV2hmc25kK0cwRWVCeGpYSVcrdEpYVnBO?=
 =?utf-8?B?MjBOaUZySURRN0hHZHhZSDUvMnJUaFdKSkpXbm9XeFB3dE9qZFNHcXNlQ2FP?=
 =?utf-8?B?d3YzREk2TGJCa3ZkbWVwL0l4Vy9HYVJpdE1RVTgvM3dIallKSGtLUm5XelJS?=
 =?utf-8?B?blRWVUdMNjZ1dnJvZlpHY3lzcFZMVEFTeWRvTTRHVEZpbXJEU0JJWFBqdjJJ?=
 =?utf-8?Q?BwMjbNUnfPT4rpAA=3D?=
X-Exchange-RoutingPolicyChecked: GZXmWumDU4ZV+kdCwB1WalxuBx4IVKGz1dQiATcv9cKfguJKf0QI4ilB7hC+S+MJuL3rH74a8pwhqihKHaV4OjJUtCcGwV6hlWq/OmlcsEozm6YU90r5mGcLjoH1SdJWUPdbJb4vPR/A7Mq8uvsyZhhgE5BZGoR9vY8WIuPdA3mowzc286ydaKMXYEaW5fsl62wVQvDkaUAVk8LaxwGtzmJOd5BSiR+5KfoN5T7YrIfcqMdCKHzQj+JZI/V2BpqT7hT3PyyV+6gNyaX2ZRu1Yy+sgIUKsJxS6x90UQDn9xR0IIROJxoSh2TgA/jjpUOBh4tVC2xizLkToRrsSFEU8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 903e8e1e-edb5-4add-2919-08de90e63e69
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:32:49.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtkRbHTY+mV6ZaeLtvEa1WjTohSdpjE7cmZE3gWwly9lpqF9IsbnALOzpcO8P6RW+DPwM89Augj15xxGfMVib0RtfEjnal1jrTuKrzWlMlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-274659-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 989C538D456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alejandro Lucero Palau wrote:
[..]
> > ...but it *is* possible to remove cxl_acpi, it *is* possible to invoke
> > 'cxl disable-port'. The fact that it is possible contributes to
> > complexity, but it also supports flexibility and is a building block for
> > error handling / recovery.
> 
> 
> It is possible but, should it? When should it be allowed with drivers 
> relying on its functionality?

That is a good question, but not for this set. The immediate goal is
acquire a region safely, and that means complying with current locking
and lifetime rules. We can always evolve the core over time, but for the
present "just give me a region and call me back if something invalidates
it" is the status quo.

