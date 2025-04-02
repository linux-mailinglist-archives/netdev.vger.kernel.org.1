Return-Path: <netdev+bounces-178880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F724A79542
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EF73A5A07
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140419E826;
	Wed,  2 Apr 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwFo+Ztg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21613D8B2
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743619307; cv=fail; b=RI7A+vzaBIdOjKljRr0KQV70Ead/MHKITsuSsF06ycQ2scuedNDI5MTZMLKgt9F2vlR2IbKiqqMzVIBgcnnXzwWsQG1pI/YvUtivCu0FQ5w/SPllxxURu/Dhmhqr9/7u3CTHvFedBw1DnJclFbSF2RPAsPelgNtF6HaIPghHk7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743619307; c=relaxed/simple;
	bh=tKMQXvMZaCzu12dS1PNhoqClUnt4o1sdwvHy5KwPtzg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YloiCaXNCrgwg50uRVLk4OG7aaqPFYMU8uyCENB4ZqKPZg66zSzWz+/y12W+qZJQpfis0XP9bxsRlbyQaLqJFt8+mlgns6XM2o3xWAfXjtxfbiZR21NgoVlMOU7SFDclminhhBOQmiO01WAvrscoFbK0iiDehlYRPD0GcfGEc4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwFo+Ztg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743619305; x=1775155305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKMQXvMZaCzu12dS1PNhoqClUnt4o1sdwvHy5KwPtzg=;
  b=nwFo+Ztg9ViyypWRyvs+qrnE9MOPe/6YIYY1mk1NvNtv/pYBEpo0z3R7
   YNFX7qNxCKQ+JJf2+yNRE7xNVkPyF0PI2ofbvhOcNnKsx/9K/zodc6AL3
   g4xNufKlxtoALBsMoSyn/+kRd5TE2PfS1z31QCPNjbZNsr6W7K5Pl+8Ea
   9LsB0dj/0g1S7cRP7zZxuP6YEpZz5sGW+WbJtTPcpQQ/BOpNxP535Asn0
   pX+4JIT5OcjY50v9HQp1S4wCoOjA8G2zZsySIa00NGINV1/dKKgU7XZNx
   OW4kw185tJsEPjseJMlShq07/Anuh9nQB+FkBKhtoA0OAZGM4HQWt9QA4
   A==;
X-CSE-ConnectionGUID: f8x4o5yZQzKZwSFrkszAKQ==
X-CSE-MsgGUID: 2DzVZMUjSVGt/8Pkfba1VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45013115"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="45013115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:41:45 -0700
X-CSE-ConnectionGUID: neGPQYoDQ2O+7/PnYgEpHg==
X-CSE-MsgGUID: Ua0ByIgCTa2gHpxnuO/N1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="131650279"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:41:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 11:41:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 11:41:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 11:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGxUYxhL/UdRTPlbdFlc6zYsfAMvB5wkEXorZbrOh1RzDzQdjJlyr4a4hU2heBP4ygLZfBprQLkVesz5kK1iCtmvHqmmz90LAweYvH5D0tz1AMVTqJnv1/eAbmQVwORpjndLjs5PJTG92pbQIsrgMtzOgjvM8TYuOgRXbwt2DXbLd7IpMabv+XilCpIgBjy/kZLRrzCUiNRmQSy/9GN2udZjIWNsnOE2FgqllkMrC8vPENvQhiTxYLxc2Be3ixtkbLg6WGAPktUDMBJUV+gkEPdHQtLNeNat9HtUUaxWBeMVnVcmLMoCGHjDdz0M5gJ3T4UNGE4vg09Umv9bY6obPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFgM2PctN++GAEiSYZrTlpg9DqSASFqY3JttAUfM7KQ=;
 b=ELuATvpZS+wSlVYcSHhdKUlN6Pe8HmZfGia06KTL15qDGRWbJ568+KyO0AHSl42gxTmOz20BRls89H0OykKmaWm1pXqwaGuxKudhozbVtJYBFlKSUzGW/Fo20stjiiUoJwRjwrRSdbYuHPBzb3lvjxPSHyObyk8JGarVw5w1vkwBBDUlgwNVdLVbO3JSN9IJUkexBUA9tNhVdfEFU0m9l6ONZjdXcO7xCKUQnMfYsOpHQDRJoYyfUFl3WOUr0G1+AJv4eB9f25tGXiwaIsU6ngJz1zhW+hVAcg1IIDdcARR6RIPG2+LXFpRpXKzJ42/Z2SZsDAUBGXpcri1i++Luvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8759.namprd11.prod.outlook.com (2603:10b6:8:1ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Wed, 2 Apr
 2025 18:41:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 18:41:40 +0000
Message-ID: <7d354118-4a1a-4935-849b-8b8e5a3bf42c@intel.com>
Date: Wed, 2 Apr 2025 11:41:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] netlink: specs: rt_addr: fix the spec format /
 schema failures
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>
References: <20250402010300.2399363-1-kuba@kernel.org>
 <20250402010300.2399363-2-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250402010300.2399363-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2205c0-e2f0-4dab-6504-08dd721601d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXZPd2J6WHdERGhKcnkvRmVtNWc4UjJZdlVqNTdmRmllWnJsMmp6eTkvU0w2?=
 =?utf-8?B?S3NlNGdVeUVpRDFMUFNHOUlUZUhpd1JtbnVKSXh1eC8vYU53ZjVBZXE1cFJL?=
 =?utf-8?B?VW5IeEVjdDVnZmFFSjhaZmZHWndCZzVKYXlsY3NibUxiQitCY0lIamhENDEw?=
 =?utf-8?B?OHg2UUVDTGlSVVhteUVwRzZVOW1YN1p2elVOTmVrVm1ZUXdScUtwbnhURVNO?=
 =?utf-8?B?cWRPQ2hqQjNobk9yWkVWSlNNMnFlbTNZK0lpR3JZV1hENmE1LzUzWk5KOVJL?=
 =?utf-8?B?Vm1YaU5lcjVkQWN4Lzhha3lPNVRERGhGMTIwSTVFYmVGalgydS8xaWFQK0xa?=
 =?utf-8?B?V01nSUhDdmpzSVdzWTRXU2xadm1PTzlpb1Qwa1cwVksvejlYZFlyUEU1VlZG?=
 =?utf-8?B?d2wvTjNHY3VYV0NmRzJpVTVHQitKdUlHYjZnT0N4d3dlb0RVS3c2RElNblVz?=
 =?utf-8?B?QzR1dEJuNXZoMS9JemRaSDVNYUcwNExaaWdGNnN0QlBCc0lrMnRoWDNPK1VI?=
 =?utf-8?B?b2ZhRHZrVVV5U3BFUTlRMDJYVms4WkJlNldsTzNsNHlDeGxBcHNjRTZKZ3U0?=
 =?utf-8?B?TmEvbDhOS1I3V1c2Z0ZDeEY5eEpsY3ZLTG4rRkp5TTNIUEVnaVhaaWYxWFI0?=
 =?utf-8?B?dXZvdkZjQ1VDU3NTWmJpWHNsNEV0eW5MMWFPcEtMcmJLc2FEWFRaazFuakdW?=
 =?utf-8?B?VndGT2h4RGwzUDc2VEtYQnJWZmNibkZlMGhYNUhueGU3VGRYaFprdEo3bWhV?=
 =?utf-8?B?STh4cW00cnFjcXVCSU9uNHdrb3RhMnZkaGJPeXN4bm9zNnh1cXZidFFKN2x0?=
 =?utf-8?B?MGFENi92emphUXNoWStaMUFKRGk2aE1hYk52Mm4xV0V2UlU3N010UGVUeGl4?=
 =?utf-8?B?RXdFOEZZY3ZNOUg0OWdZWWhqN3dVL2NJQkVpMXBDeUxXN3JIQ2szYzVaOUJF?=
 =?utf-8?B?Tk10MW1QRVlxM3ljVVBKV3ZjZ0ljUVlQWWxXZ0luSXd5Y2U0d3BzQ0kvYmxJ?=
 =?utf-8?B?NG9NRFgyNzB3VmVBN0cwQmdsWGxiUldHQnpwL0pkVFJkbG95RmEzVnFpUHNi?=
 =?utf-8?B?c2hOaVc2bzhMdUFpbHYxVWtNYzA4WEo0QnBhUHk5TktZY2R5a2RxNHhROXcx?=
 =?utf-8?B?MGFLRjBqSFgzYVdDUHdRcUx0c3BROWpHclBwU21nVURMNWI0RlZCVHp0SDNX?=
 =?utf-8?B?RzNOc3dTYzc3UjVSZ0MzWkpxYXROYlRpUWhGbSt3djdpUlNPMThXNWZqV012?=
 =?utf-8?B?YUdxZEtsUmRzQW83Y0xMQXhNUFNnOW5KQWFSWVJKSVJ0UU1QaTFHdlUvR3NS?=
 =?utf-8?B?dUVqcUNIMHc3RFVTbVZFTVdqSDNrWWtCb1dDSEV2elZzdHBwVUJZRDN2U1Z4?=
 =?utf-8?B?RVRiamV6eWhqbjVScjBCQXF6aGxZdlhBR0NIZDhHZU9tdDRsdjJaMW84Qm5R?=
 =?utf-8?B?ZGVkb0RkTFhtOXhka2xzcm42bkVnUEVabHd2dUluQU9RVUx6OWdveW1YYk1x?=
 =?utf-8?B?UzY5aktTVURoR2k0U3Q2YWN2bDVRMzM3WlUvajNUcHJwSXk3L1k5Z1RsdUlj?=
 =?utf-8?B?eW9TSWF3MnNPU2YzSlcxMzBGUU5BcDJHbnJod0ZHbnZONVU1QjBVbDdCM3pG?=
 =?utf-8?B?SkVlSmp0bW9paVU5L2VXSmY2aGJ1N3hua2JnZUdBOVFuME55b1lBVDR4dlRi?=
 =?utf-8?B?YktBYzNwbjZkVEUzMFJGOTNOOEo2UjhMeWFuank4QjBjcVNLdk1mbWVXak1T?=
 =?utf-8?B?T3V0bDNBTGN3OXpxVzhZVnBhOVNjTEViVUwreGM4WGJ6NUZaRHhVd2g1L2JN?=
 =?utf-8?B?dnk2VmZWV1hQcWhKRFFvMDhaZHdwUjFuUnAwNVA5TFNtaisyN0pJbi80TTZ6?=
 =?utf-8?B?ZkNUL0kxM3NMaHgyOENucXRzZmt0ZHJjWnhRc1dveWZrcHB0RTNqSFpwUGlr?=
 =?utf-8?Q?p8XjN7gS2E8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmphOGpHRlhtQlZHNFNQRFFqQ2h3Z1Jqa2pyTytyQjNxdzlMWEhidFZtTWZK?=
 =?utf-8?B?MU0xbkp3OC81bEdxemE1MjM4SDdKUXBjVDc5cG9UeU1CMHRHdlRkdW1TdldB?=
 =?utf-8?B?NVFiaVd3ZFZMcnp3bWNqLzlYV2VRaWdYQ1I4VHlsUUNnY3U2WUE5d3ZtVmJH?=
 =?utf-8?B?dHM2ekdqSWJWRTNyWWIvVHA3U216VDZWK2x3cFY3MWxYbW44bS8yK2NZNFlL?=
 =?utf-8?B?R0l2YjE0eFN5TE1YSDEzdHViSXlFRUhYT3FPNERaZXJBM0R3QUFQMHVUUzFZ?=
 =?utf-8?B?dWU4ZGtpNERWM0pZcW1xY3l5dVBQTHVQVEJYUDVPNmFMMGJCQ2JtQnlSeEpB?=
 =?utf-8?B?TkNBWmRCa0FwWURiKzBGMmhBQ25jRU0yQ01sYWFsVnJGTE16cDdVTXRFUEN5?=
 =?utf-8?B?NnlWOTFGb1RsSGkvM1gyNjZBanBoQXRKOEJRYnl0Y0xtQWE3U3hlcXBsR2ls?=
 =?utf-8?B?YldiWUJNV1lUUFY3TXR4NkdoeFdXamVhZzh6VEo4aUxyd2N6TzJCOTV1K2du?=
 =?utf-8?B?NTh0c0xqWHVjbHRrL2p5VFBkazMvR1FnOEJIb052V28rdUR1WnVjWTF2T1Ry?=
 =?utf-8?B?cVE5WmdtRksrTVlEYUVSRnh3dHhDa0xiZWNTaGg2Z3FTRkcwYy9oSTVSTWVR?=
 =?utf-8?B?a21La3ZFUE9yWWpZOGJvVERkcXI2OW42c2lmdFFlU1RXUlJNMllwSTBTeExB?=
 =?utf-8?B?RzcrZUtTTGF0MUpoTmY1aWkrK2Uzam1ac1p0cUpaY0M3MTVJRTl2L0dQcVBr?=
 =?utf-8?B?OVgzZ2g3UEQzTEtoYWh2ZzUwQW1MUFhsbEs0YTB2c3pzOUdmMG1ZaXl2ajRw?=
 =?utf-8?B?OXUwangwN201UGZDdmphRXVCamduam9JK0dGMnpHNmh4MUszc2F5SEY0ODdS?=
 =?utf-8?B?cFRXa09MVzJGZ0RjVDFza3lrc2ZCdHNXMTM2TlBNQUNoeE9FaHB1dDNpbmMy?=
 =?utf-8?B?Q2xTQUZqWTdzZmpLcXhOS1BSSkpoN0YvWXVOaXBobjNodURRWFBKR0V0dEx2?=
 =?utf-8?B?U29SNkJHOGNQaktIdFhKYXBIRDhKY29STWx2KzNtenNpMWJBTTZQQmMyaGl1?=
 =?utf-8?B?NllyKzdpYXU3dmxrc2plbkcwcGNnRklzVVVaNFpESVJITks2STVDSWtUTlZP?=
 =?utf-8?B?QmcwTk9YaEJudWFaeFp2Q0VBamVqa1dJOCtvN0NsM0NBVE9RN3JXRnlFK0NH?=
 =?utf-8?B?NkpqYVEyeUZJNjRLWmNycjM0dnlvOHRCSXhxSS9TcTNPR253MHJZSWFzOTJY?=
 =?utf-8?B?MGtZcnh2Wkl6NUFyaUw2dE8wZzFnRmRSUDEzdnBPeXZVZEVmZitrbDFuWlM1?=
 =?utf-8?B?UlNaVDN1ZWxXOEVrNVB0WEI2cnV3QkYyOTNDcjIvYVJ5WFVadXBJbTI5YTU4?=
 =?utf-8?B?YUpIbU1UZ2JzcXV1dFRQNUc1RklMakpPRXdqZW94dmlTTkE2ZEZTVEJ5Nnp6?=
 =?utf-8?B?ZHN1SnIrVzV5VFJzZ3JwQnNzckYyYy9uMXJ0a0pOck5PVXc4RHJ1S3BZbHIr?=
 =?utf-8?B?TXRqZ1pmd2IxMDNOdGd2SG5iemw5RFVYbjFqUFJCb1g1T1lLRyt1UVBnRGs0?=
 =?utf-8?B?QmRuaUJYVCt4ZDFlRjQzbjU5YTdBbnQwSnhRR0FTQmVTUnN6SFdHSGk0Qiti?=
 =?utf-8?B?R3hOYWN3eVpCUWhlZEZVL1NXYjhKakdUNTI2eThiU254ZXRBZ29YaDdicHZr?=
 =?utf-8?B?WVM1cklhZEpGTUJQYmZiakZ0MnAxWWdlRDZLRXVQemxFSmRVMzcvenFFZ01a?=
 =?utf-8?B?d2NzYXlJUjE3VEpLM29RSTFKbUZSbmtaaU03M3kzV0EraFQrZUQzazV4MWYr?=
 =?utf-8?B?eVpvdUpKOGFaSjBsUmNOM2ZKNm5oNkV2TUZmT1UwRjluVmxFRXY4Qlduci9v?=
 =?utf-8?B?eGZiWFBFZnVLQzk3b0J1UW11TGFNc3RNSGtaOU1IQ3FrRzYyYlNNMUEvNXpQ?=
 =?utf-8?B?WnNSdlQ0U1dLK2F3V1JSbWNFRWF4cE5IWGlxbVJHMlRuUzFaTXJtVFVybkEz?=
 =?utf-8?B?b2FEL01sTGZBMEQ0T3o0UkJqL0QyaUluQXJFS0RCVFhobE9pYlg1ZXRXN2VW?=
 =?utf-8?B?a2pOa012b2R2N2lYbVZkNWVMUUN4N2pUQ1JqVEE5RlJpOCtGR3VkcU5McWd4?=
 =?utf-8?B?anVlSysxRUc2YjdHbkZsTzVzOEFMUFN0MTZQbVZDSnF0VDVqM04wWlhRVWFG?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2205c0-e2f0-4dab-6504-08dd721601d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 18:41:40.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obAl26qN84Wavyhi1iG76WqpcUXqSmmKchGU106LQRtCaB7PEyQ4i6GUTKDJLsnd1fP0+2npukjWQG0fviDfc+m0Vi1D6VidpJ8ljcfpdAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8759
X-OriginatorOrg: intel.com



On 4/1/2025 6:02 PM, Jakub Kicinski wrote:
> The spec is mis-formatted, schema validation says:
> 
>   Failed validating 'type' in schema['properties']['operations']['properties']['list']['items']['properties']['dump']['properties']['request']['properties']['value']:
>     {'minimum': 0, 'type': 'integer'}
> 
>   On instance['operations']['list'][3]['dump']['request']['value']:
>     '58 - ifa-family'
> 
> The ifa-family clearly wants to be part of an attribute list.
> 
> Reviewed-by: Yuyang Huang <yuyanghuang@google.com>
> Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: yuyanghuang@google.com
> CC: jacob.e.keller@intel.com
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 5dd5469044c7..3bc9b6f9087e 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -187,6 +187,7 @@ protonum: 0
>        dump:
>          request:
>            value: 58
> +          attributes:
>              - ifa-family
>          reply:
>            value: 58

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

