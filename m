Return-Path: <netdev+bounces-124080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B4C967E78
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 06:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB531F2111E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 04:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090E7DA79;
	Mon,  2 Sep 2024 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8kzDcUP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42707433CF
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725251120; cv=fail; b=mtxHGQK+0rErqOpkzcTi32CQWTwoSVXaD0A/DzR7M05bot3YtjmOZ9bPUHKeGaXXGYVz0Jz8Jd53Fzy59cUIjYhKywOGKmaI6/AHh1RyqjUb0a5aZ+Wuf6RN8BrD7gjCVBvpbk2oJtJCSp6YlnjGUHi3UC2EGFTQhnBpCOadTZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725251120; c=relaxed/simple;
	bh=xcXLyM/u6BMeOjcW2qfdsrXKR416CZ/OAFtdLnmxnQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D6kNu1/TsXvx3WzKRnrqEFC69gteOrdni4nvMgZ1RuQgYxjd9OkeMBwHN9fN6hQ93gRAYZpeD9cb89WazAMF3T/546/U+YWdd8JuRFwari6QXH5EeroCydgxs8Sqwr8dB8QWEKuqkp6NzDhZ1y5OGqfnHvZvH0tgzcnNNenM7K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8kzDcUP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725251119; x=1756787119;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xcXLyM/u6BMeOjcW2qfdsrXKR416CZ/OAFtdLnmxnQQ=;
  b=L8kzDcUPfHFhrvQIT2qHY/SmwARv49qdCC2dVQluqooEDCUaVzeYU2j5
   btin/IrX3JIRbuwhrsswZsMYFY+BKryDhN2epeiQ2iY5fnUQXU91lE9r6
   /vQRRvbGqSBnyBuiXrYgkgz3W94GnpixkDMU5+oSufIFI2rCnULmuutW5
   IKJJDQ2iVo9ArU/InxS0ODpbgdumEnfWCcYXaJyYtKLMfO/vNaVJbQDJM
   8hWK6+e7aG1hSMQtkg0NKYAL5DQwwIPel1H3KKCo8S6bPQadmuPV3tokt
   OYOfgco6O1ZQtUIEc7Ejx8Wd+2sBxjD8UgSgOSjUvLROlT2X/uyLFWKvp
   Q==;
X-CSE-ConnectionGUID: gxogUnWuTJK2pSm77GKiYA==
X-CSE-MsgGUID: 52w2vjtlQu6uSc7mNEVVZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34384373"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34384373"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 21:25:18 -0700
X-CSE-ConnectionGUID: brRzbOGRR6mjuSTj9sCSkg==
X-CSE-MsgGUID: dYwWYEoFQlqYjyL8hcQLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="101949085"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 21:25:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 21:25:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 21:25:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 21:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV0d6l4sgMpgKKgifvojlMFjx7Vm8tZMM/W2DzJyYBq6yQNa4DjiZqX0vB0WNfqO6ijr/4/d7nXOLlShdVs/17o4hFrUH9AwRLw2+WSYwWm0giWAlpPpwpOXDZ4DQ6VNI7lkMn7zwSx66eze2bw/yYRJJx53poYRVGsZDJM+ozLXO36tIFBN9O3LBYxg6H4gXOZINC5wt411SZtn/RJIhrk80C+sN+VcnDY/y9sNn/FGaqMUpP1SD7MKji+ji1Bxlp0fh7v3F0GyhuUWC+o/hQ+a3q21BquBszZ5CQLt0ECGs88tgOL3lSfdRsllhfdmJU6SqGf3TDKdfhKsIwWWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsB+jd7o/QY+hRich2Hrz9Z/N1PwkyAHHhnxiInHoMI=;
 b=ql1FC2OgqwSXNgr8/FYXkd/FzUTbpbQEgjjnfttV1Q+HuF5HMXSgaMivpp4iLSAAbvRHzEFip/3GWFqY2Jbu3BN7teGbYrKHl88Am7YeLzWIpF2DCaMLgbrwqHm3xuqnyhjGqII8EKkK/TfM/AjI5l3cWNI24JE5HGHYSzZFsY4VM3RegOl8n5Cisg4WsliEa0aiX7u0yMEgRnM4XhtiB2+c7cwyxdDbx8ofiBOr7x6BxmREjSXvwvBpZOzXcb6f4FgjPsvk+Ekr31zzivwqnHj1qliPecexk0YOgO2sJ2A/mA1bEV25Q8xxYaGGm08PBO+s968E64gBlPoiX0Puxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
 by SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 04:25:14 +0000
Received: from BN9PR11MB5420.namprd11.prod.outlook.com
 ([fe80::7a2d:5b5d:f9ce:594f]) by BN9PR11MB5420.namprd11.prod.outlook.com
 ([fe80::7a2d:5b5d:f9ce:594f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 04:25:14 +0000
Date: Mon, 2 Sep 2024 12:25:03 +0800
From: Philip Li <philip.li@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: kernel test robot <lkp@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <willemb@google.com>, <oe-kbuild-all@lists.linux.dev>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for
 SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
Message-ID: <ZtU+H5md7d/Svo0u@rli9-mobl>
References: <20240830153751.86895-3-kerneljasonxing@gmail.com>
 <ZtUZpPISIpChbcRq@rli9-mobl>
 <CAL+tcoDg5rEQpx7mAvOxFg71iOT9gWBy0+NzjWV4r6JfhnOG0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDg5rEQpx7mAvOxFg71iOT9gWBy0+NzjWV4r6JfhnOG0g@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5420:EE_|SJ1PR11MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: c834f48b-4651-4779-288a-08dccb073db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVJUM2dNTmRQWStBMTVuWHZwdXlDNnBxc2tkdWo4SjVGM0doZGJTNDI1cGpl?=
 =?utf-8?B?SElheFNBN1ljR2pKeWQrZElYUEhTd0hlVGVja25NaEJBM2U3NUE0a2tGaEdB?=
 =?utf-8?B?aEd0akRoQktPUWN0bkxFckR5YWg4ejZnUVRhVktDUTdCVkpIby9RN3d6ZmI0?=
 =?utf-8?B?MXFPOER5RVViMTk5NXpDNVUxblRaa1NTYng2V2E1eTR1UlFvU1lHMTd6ZFRo?=
 =?utf-8?B?YVFCUmlpQTQxYlRxMkxxN0hxcjB6L3JaMGhQZnZYSUlkaThwRk93cEw5Ym9j?=
 =?utf-8?B?bWJmYys4ODY2a0ZDbUNpaWN4TDgvYlZWcFRTNWtjdzE1bzdtdFI4aEY5aE1u?=
 =?utf-8?B?UGlpMkhVOTd1K1JZZlh6ZmRCcW9KeTM4NVprcmJMc1VGZGRFbmw4R29nZzhO?=
 =?utf-8?B?QXkwdkQ1K3JoUllQcDRqV3hITDczc0R6UU01Mjk2WkJsVkhCVkFSSE5iMHhQ?=
 =?utf-8?B?K3NOSS9ZQ0hvVkhBeDdoeVRxcDUxMExibG0yODlVK3RUOERteDJSRnAvd25q?=
 =?utf-8?B?M09ibC9PL05Bd2FtcTdhUElDaVdqNmRzcGZ6cEo3dmUyeU4yazBFZldCS0l2?=
 =?utf-8?B?dkVYZUxNSWlZdDA0RFlZSVBoVTlZMiszdFAzMVVOZi9BRlg5SHlIY09sL3dG?=
 =?utf-8?B?czZZNlBISG85S3hsaFkzSGhudmhZSU9VMVF0RTBQWjVFbkwrTW9KTHFHdVlL?=
 =?utf-8?B?ZEc3OXFrWjBsQkFOWFdpYjE2Z1AxMktoY0Fxdk81VUVjWUJvcXlrNDc2UkhV?=
 =?utf-8?B?bHVOMEZvaDV6OHBpYVdmb3cyb3ZORE44ZFFFdzNjeDFFRkkyQWd4ZHllekQ4?=
 =?utf-8?B?OS84bEtjK3czcUhNdGhmNnFReXI3VWptaG1YZVFOOS9LZ0lkL0FHK2IxTzdW?=
 =?utf-8?B?WUlmQ3g2YVJEVzNtejRsei9PQUwyMFI2Q2dDbWVpWi96QkMyVUVOWkZvUnlh?=
 =?utf-8?B?L3lEYzhaOUZXNXpsV1FQWmc1QjBuTXZHZDJhdUE3ZVMzSDQyMjFnOGQzdUdH?=
 =?utf-8?B?L2NpakNhcy9udjVvRlQzTDBnc1I3WWUzZjRXclI2RkVCbnZGUkhBY2x4TUhw?=
 =?utf-8?B?eGRuOE9sUVNzbjR4ZkxMUnFzWFl6ajUyRE1QZkRlekNmVHBDRC9LWk9YenFW?=
 =?utf-8?B?UDBvNzNFbzZtdmpVTDBiTFA2WW5xQmJSRkFNa1BldWo5dnJGa3M5SGlqMHY1?=
 =?utf-8?B?SW5FK08rSVltVlVWOFBvMlA0a1RraXg4dzM3blBWYWR5TitodGpDZlF5OXlx?=
 =?utf-8?B?YXErZmdQQmZDYW5Rd09wTVl6UisyUHFSYnM1YldDVXNIK0lUTGJQNS9mRy9E?=
 =?utf-8?B?eFJmVytzaVhnMVgyclF5RWZRL2dodlZmUlVPTGU0OUhFVndKa3ovZWNpQklN?=
 =?utf-8?B?RjR5dGhRYzh0NjFjQnNGczRWekk5ZkxuelBwcmNSWXIrMUlSQnQ1MnFyNHdD?=
 =?utf-8?B?Ri8rbGVEaWpibHVLY3dmSGlsZk1IMWE2QnpZak9ULzExaHhZZDk5NjA5QWp0?=
 =?utf-8?B?Sk1pWFk2ZEphdkx4OEhMK05aWmU4amp2Wis5QnBZV28zUlRiUm10djdkbUND?=
 =?utf-8?B?ZDlWemo1U0pQQW5nY2FlUG43dENPcE5KVng3Nk9OYkpWODVuTDVObzZCdUMy?=
 =?utf-8?B?SXYxeFgrNmVjOXlRcWJXQTBjSlprbnhFMnNsN0plcG9uT3MvTmxyaW1CbjZr?=
 =?utf-8?B?ZUpQRGQwMXoyS1UzYkJXU1Z2d0xmcnpRVHhpS2lzUmh1c1hDb3Z3b01PWEFz?=
 =?utf-8?Q?HuiMO7vQKwQGBnhROSgq/PdQLKW5/dYr7fb6wEn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndjRlFUeTZlWUdZZldzRmJ1ZU9jNDczaUJJTXAxQ2lDRVBFUXUzQmNnT1Bu?=
 =?utf-8?B?NjZBb0lKOFhOQTRzUm9oOUUvaHJCNWJJbXFYdGJzc3BQd2oweHlqNUFJbXZ4?=
 =?utf-8?B?M1NpdnZiTmhlUEZ4VU5oUWlOOTZwU0gwS3I3dVNGQThJcjVqRStVS3ZiK1Fj?=
 =?utf-8?B?TExuditFODd2d2hWYlhaaEp5WCtKYlZlTzhYK0lFR1NkSFB2eUpQRGtaVTFN?=
 =?utf-8?B?TTJ4Q2hEbjVVM1Urbm4xS1dXWTdXVm5lemNJM2Vkdk1YYy9ENkNGVE80NnQw?=
 =?utf-8?B?QWhiWGs2aXpUVEZWZzJ6VlpIT2tFVnpneUg4NEVJUTlVdjB1ZVAvMmU4SG1v?=
 =?utf-8?B?NE1hV0JacXM0WEhsMEJ5ZFFORThQNlI5eHdMVWdhdnBuVDM2TG95WS9qVUlo?=
 =?utf-8?B?S2t3cTZxc0lXYzZFbTN3OHZaeUlzYUZqa0ZFMWxzK3lHeWVaakVYSFEyd2hv?=
 =?utf-8?B?UnIwVG5INjVXSzBrUUtVNjhaZkpRLzdhMGVDSGhYS3NzN0ZWdm9hRXdWL3d6?=
 =?utf-8?B?OG1IZm1RdnFLTXJreHNNL3RpUTlxV2xYWkloMUJtNS9jbXRIVDNadUthY3Qy?=
 =?utf-8?B?a0tFOHVVaFg2SSs2N0pxRHRxUENFM3U1U3FLTWtxT0hienM3SWJ3NENHd0FQ?=
 =?utf-8?B?djVXTGRyQzZlcFpWaitTemlwS2ZOMUUvOE5iOC9tQ0hXV0JsZnNIOVhwZEpa?=
 =?utf-8?B?LzNzQjl6aVhGbmdMQlkwZEFPM1dOTHZxd1RoQ2MxL1VFc24rdjdhSGRXZmFn?=
 =?utf-8?B?OVEyZUg1R3JzZWdaU0tEdlp3SFNjVVJoWHBGU05QWGhpdUkyZHI2ZXE1bjg0?=
 =?utf-8?B?MmI2Rk13Yi9oZVZNVFhBWC9oZ29UQVdwSlQ5cDVLRkRHNUNzdzhLbmpKcUx2?=
 =?utf-8?B?Z0VUUU4yOWx3UXFJTnFpd3ZBU0FFZkJyRGwwU1JHTjEvNGtUd2lCR0l1M0Vp?=
 =?utf-8?B?OVZST0R0dkxZVGpEY2dpY2Z2NUNxZEpuTlhJRnBoTGVHM1RrUFJxREJON2dN?=
 =?utf-8?B?MGdFcFRVUGVNa1orejYyWmRJOHd2WEVBZGYrdk5uR2tMK25NRzRHaWNIdnpO?=
 =?utf-8?B?TExyUEFIRm85MlZkT0l1M0hPTm8zUnFvS01nMFh6aTQ2b05OYU9hY1Fqbmdq?=
 =?utf-8?B?aUo0WEJySTA5VUNqTEdPLzM2WVIzN3I1QmJ5eGlEZTExcW1teC9Xd01CMW1n?=
 =?utf-8?B?Mmp2RC8yZjZYMGRHanFBUUdCeXJlT0c3ZlBjSmx1YVlXVk5SZnhRcGt3T1Mx?=
 =?utf-8?B?cVg5VlpXVmw3QmdiV0d1ZmhjLzIvR1l1ZjdONlk2dllYZHFJQWRnTm1ZSm9k?=
 =?utf-8?B?TXNlWkc2dGgxWU40Q0JhWVN6VVhQYUFFVHZVMGJORDlQYlJ2UVpOS0wzY2Yv?=
 =?utf-8?B?QnUycW9HOFRRdXBIdHRDOE5KK3kwanhUdDFDZkh6bmNBWmFiTWFwTmsrbjR0?=
 =?utf-8?B?R1NPT2xieFpyeHBjYW5Hb0NuejdxTlFPUTRMeHhmVzhMRG1jN1hSKy91bks2?=
 =?utf-8?B?RHRuazdrZWlweWVOSzEvd3FUdzJVNEc3WCtYWVlNdmtLSG5GSEp5U2VJMkpZ?=
 =?utf-8?B?cVZrSUM2Z293bVVKTlJwUzFCSDFUYzNLaGpGQ29uOWFjOG9aeXl1QnpXTHRV?=
 =?utf-8?B?VmM1RkpYZm10S2ZZaU9CT3ZjQklaMUxpeG5XTEN5QUZHMjBFTWZmOXpLbHBU?=
 =?utf-8?B?L0pMOU9sVEIvbkZncXQySTRjMk5pWVBNc1VKS1ZsTzJWVGt1VXlBbDBBVGZM?=
 =?utf-8?B?dXhubW9keDVYcDRwKzBFVlBieE4rdlFIOFVvQlpUYThVYUJpUG1RR0pTT3BU?=
 =?utf-8?B?UFJjUDZmWHAvQVFrK04rZlZSOHhsUXFibmVhdFlCNTFic3ZrNGo3QVJoMVBQ?=
 =?utf-8?B?TEVZN3piQjkvZzFzb0txbExkd1p4aCsrM2tDTjhnV0tTM2QxOUdJT080elBR?=
 =?utf-8?B?dEFLdDVpZUVRODhkc1pwcGNjWXg0V2JVSkpGMmJpM3FtbCt4ZEpLSUVLYjlh?=
 =?utf-8?B?Sm15Sk1VQWJFWTM2bE9TaWk2bkFZZkVjQWdZbndLb0FBL1g3eHdXdlRPNkJ4?=
 =?utf-8?B?VjlpcTJwczFNWlVQemIwMy93eWU5TjdNOWhKYm1hcm5SaHV3OEo0dUZYTVpC?=
 =?utf-8?Q?YrKouooQksUsWtDW/k6VvsG1y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c834f48b-4651-4779-288a-08dccb073db9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 04:25:14.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzOaSoBh+SBim1HUyiDWsDl2Nu85gcU3K2AmDMVR+Igov/Eelk0RDa5FF9QimchclSFOLzk+7DckWxLmlt3SOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6252
X-OriginatorOrg: intel.com

On Mon, Sep 02, 2024 at 10:41:28AM +0800, Jason Xing wrote:
> On Mon, Sep 2, 2024 at 9:49 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Jason,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-timestamp-filter-out-report-when-setting-SOF_TIMESTAMPING_SOFTWARE/20240830-234014
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240830153751.86895-3-kerneljasonxing%40gmail.com
> > patch subject: [PATCH net-next v3 2/2] rxtimestamp.c: add the test for SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
> > :::::: branch date: 2 days ago
> > :::::: commit date: 2 days ago
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409020124.YybQQDrP-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/r/202409020124.YybQQDrP-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> rxtimestamp.c:102:6: error: use of undeclared identifier 'SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER'
> >      102 |                         | SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER },
> >          |                           ^
> > >> rxtimestamp.c:373:20: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
> >      373 |                         for (t = 0; t < ARRAY_SIZE(test_cases); t++) {
> >          |                                         ^~~~~~~~~~~~~~~~~~~~~~
> >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> >          |                                ^~~~~
> >    rxtimestamp.c:380:13: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
> >      380 |                         if (t >= ARRAY_SIZE(test_cases))
> >          |                                  ^~~~~~~~~~~~~~~~~~~~~~
> >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> >          |                                ^~~~~
> >    rxtimestamp.c:419:19: error: invalid application of 'sizeof' to an incomplete type 'struct test_case[]'
> >      419 |                 for (t = 0; t < ARRAY_SIZE(test_cases); t++) {
> >          |                                 ^~~~~~~~~~~~~~~~~~~~~~
> >    ./../kselftest.h:61:32: note: expanded from macro 'ARRAY_SIZE'
> >       61 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> >          |                                ^~~~~
> >    4 errors generated.
> 
> I didn't get how it happened? I've already test it locally.
> 
> Is it because the test environment didn't update the header files by
> using the command like "make headers_install && cp -r
> usr/include/linux /usr/include/"?

Sorry about the false report, kindly ignore this. And thanks for the hint,
we will check to understand the root cause of this wrong report and fix the
bot asap.

> 
> If the applications or some userspace tools try to use the new flag,
> it should update the header file to sync the uapi file first.
> 
> Thanks,
> Jason
> 

