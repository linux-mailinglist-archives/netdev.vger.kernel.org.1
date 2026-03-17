Return-Path: <netdev+bounces-268561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAOmD0g2uWmcvAEAu9opvQ
	(envelope-from <netdev+bounces-268561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:08:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63762A87BC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31D72302141C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045473A9625;
	Tue, 17 Mar 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoKF4uPT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F20345CA1;
	Tue, 17 Mar 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745732; cv=fail; b=pkrmObpRfsw+N6tKbw6yO4nKlDwfyvKg2OpvP6zpV17YbN4QhV8DhUJnRTqY5hajOnuwppocmEwFO8aj5hEnu23van6i9y1LLryeLGoRlODv2RUf9uajya03LP9uK1JlmsIYG8iZI7Do4M4OnylEd3EpJ4xSbUGBc/barX55NI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745732; c=relaxed/simple;
	bh=NHqxSzQDfXZUjMxd+oRBHSKbKMasWwJl/rmtJqMm+HA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZ/NR4vNZtzDsoBnuXnfE1E1D6+BB+ki+LEcmkAtXsXcQo5Lxc4gRcgRQU6JtaUmFcxaqBr//L3m4pvyVHpk/vsHOs/NmEPhX053PUI9QFY0+ABj2qp7Z5mZWzokOYUUTG+MMLtLLrL0RX55l6KPufst8sAOhYIiRP+ry7u+Dl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoKF4uPT; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773745732; x=1805281732;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NHqxSzQDfXZUjMxd+oRBHSKbKMasWwJl/rmtJqMm+HA=;
  b=MoKF4uPT82iLQHmZeexl9JjIS/Dh5Z2qVA3q9zU8F/2qujcJdSlbtBr2
   DNKos6uccOHYCVzPNXdloeumISEE/ZuCXZ3iX7n1ljUr6ZyM5Xa2mtKrS
   56oYS08dLQHI8bQKfhuuE/ZbRG/nCxHAnPIbLqBv8RTBg1mIC75U/LWp2
   2Gd1ZOVrVAagDpkEJnkSix4FjskLv2coTUPtJx4/sFkTDfjZW4yKVpBy0
   lfW1j588eT40/vgTWpY6dU+tl4AJzk5QVPEMqWGh0Ly1a6enFn7A+8oE9
   9tt4x3ogNKdE5K0MekWaRCxMKSzHu5vz6dYGEr/PVDIOoYSvsYTXiqVef
   w==;
X-CSE-ConnectionGUID: QsTX9Ak+Q2y6ltndO65P3Q==
X-CSE-MsgGUID: Wyttif38QMG6nPK7Exw52g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73952884"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73952884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:08:51 -0700
X-CSE-ConnectionGUID: 14rJqbb/TcGiRZyv+PZXFg==
X-CSE-MsgGUID: Fzg8z5UnTOiu9nAu3V5xIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="224407784"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:08:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:08:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:08:50 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrOXYIu903W1c9Cb03BCZbJFJPzK5TE1z3vCIlDElewKC2a01F2G0QKkJzpfnDTiCJYv7H/Ve0l4f/w6gCxKDcfnjm01WVpUvnv9XjAlLm5b5b0Jc+sVZZ4j4Myq+K5UYl7c+nU4TzAdOjZhtOLQSPJhkvjDBOH2WS8jfiXSzmypBMCcdT7CrLnCkHYBGSb/0tzbTc4WJtXKRFxEHCmQL5Fk6kY68x1Jld1YI7M3/iU7M2FhwS34SFA6iMpznNFgNHBIWfFBafygMlkkGfJIuNFLE9d8hj6lE3teSJliD4e7FMy7x6kg8rnpSTdnCmoTcZWWnATUsYZPWvQ9NPGnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztcnk9nhFDjSuvykiDC93LN/p9gnsJi0oSNy9EwG8+A=;
 b=eggCWmhWJoqtQRUyWuNhr+gxfzQhu0EFd8MZafAGSs40viP9Wpt19OQoV8G1Uv09g/q8l4MMO5sunt5N71+cpq5f8QGPROtF4lp2friiWbjcU5DHtddj+SvGZjg0nua4QqShv4+hjMliiIVFQbXhTU8CXi+lTeZIAitvZjBbPs+mFwhO22DSdwxR99weYRMcPyPWeEP/WahjFrfNXC0WZ24SqyPCJS+MjCMo6vnf2pQ57uZGjXUdTPYf7LxKk5rHNSp7iBY1+7R4sily4o21bFBoG4t0D/zyd9OdO3HAtzuQnPETpqrYVeGbBPSNolu9YGuhGS3fU9ScaAZkz2wGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS3PR11MB9669.namprd11.prod.outlook.com (2603:10b6:8:38c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Tue, 17 Mar 2026 11:08:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:08:47 +0000
Date: Tue, 17 Mar 2026 12:08:36 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <larysa.zaremba@intel.com>,
	<aleksander.lobakin@intel.com>
Subject: Re: [PATCH net 1/6] xsk: respect tailroom for ZC setups
Message-ID: <abk2NBesEnygstnP@boxer>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-2-maciej.fijalkowski@intel.com>
 <abiJ2C_q62bn7EC3@mini-arch>
 <878qbqrexu.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qbqrexu.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: BE1P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS3PR11MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2b94cd-0e8f-457e-5bfd-08de84158ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: q01l4P2i8pspqTpylfZBitjXiyPMi9r+SbvdocSDZb8uiETJoI6Cyb7K2cQKeB8dZkgmQSQACWGdqCX1T0jqaAKRC9X6prnsTzCeJnvW3EZB1GImrnkYHUOavgxuU9XsXXfbsY9rxPG2XyuR6w/gl230RZS+70l/HxH2cup8ASDfJxFdbjtM3G3RX8h5uCVMtyrxH0u5528c3KnOEQC6Z6elDupe+afbbnG21ia4NrxTb0nsjDyIlvkO72UGiEsCTFFYg0fWPW7rLrNnidwF8ac269blfbPDfvMzWMFSNDrs07/oILfKXnBN1VDdNQSc062oG7TKp+8HkfDPC0wWCkhnVzHDXlTX1Gozi7Ood66MgeZFO3Uep74jPxx8265C5S+qOSJqMmmHPgHBdR1dBcmGZGcsIAaY8B0+Hn24xjI3noXGquh+6ytSk3L9/tvSoZXnUBDqUqYkXfDSn4yOTJ6fkh2wjen34VXr6VvP+r982kO4o33C8YfCXuhxIuvqQVt4UAupHL1ZohWRKXtLn8iYQXTp2bSq5Lz6Yar2Idi8bNp+UahRErQlH/nPDxmDAIPwEafMKpWBwI3lwTVjr4Q+AQ4+utZwgXypfVv5qECV2u6AnDLA2yPkLoKPU9SRxEaPBsdzdNkzNkDVqxxpzN+/Al2+nY1OtwJHfO3tDDj1+qzeuaO58UJ4MPeLUtIWaFaVkkwLC21zMbpP8IjzUsgDmprm0y7eqZf+MINwtqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7w+wvVIrfdZXEYTi+xkrLjjQeHaSB4uJ1phSK0YFhgRNblkSE/ZSYCcDGa?=
 =?iso-8859-1?Q?CshQv+kHCtLFdWsvj4DNXFlOLL6GkdFmS4+F0nROzhDzjdDyzBdkSmKlE6?=
 =?iso-8859-1?Q?1aNVGFrG5jWI+tfAoUKzCbdJLv9BEnkipV/dna1HeYfwSEzPu0R8yt36Ez?=
 =?iso-8859-1?Q?rFcgxbuCjGIP+hb8A9Sjx9TFnHY2o8ImmL/2uUPPCHrmqCwTKEcfhXXIkk?=
 =?iso-8859-1?Q?D4AUEdVLRbQecS1wUDwCdoKW9NzXJt4uvp7cRIU4ZquSqbBenQgZ3DvQAa?=
 =?iso-8859-1?Q?rXOoxxufizhyi/+UrCNI6WtnwxXlOIwlU9pwXnkLI+uuju+LtspLcN5oLU?=
 =?iso-8859-1?Q?bjgBpMUA5ydTAs/eUw73EaHPhvKiS2YLM1Fzhf8YeBuuh/G8tr07J/zYhn?=
 =?iso-8859-1?Q?v8NfjzZR7qdPWDK+yVhLCSbFl/Ofv2yzOHddduZNuOLq9HAH0tYOTKKXkl?=
 =?iso-8859-1?Q?Pk/gJ9NYp206xqqL2WtsFPQcB2e6X7PF+rSkIJnnkuSJ3XiqWTebjixZnM?=
 =?iso-8859-1?Q?YbQk89Eg/0+Q72gwRnQkjj6wJqQl96/ZgWb/6zbxtmySL7Wj50VrwxPagw?=
 =?iso-8859-1?Q?IBf2zAkWP9u8U/qLeiPdGNg1xJjdsF1nLaSIA9+3lahMdRGRgHPzMkurUi?=
 =?iso-8859-1?Q?Gx4svGnrnNotlrroUBiSf0KO0JX6sXF7Wpq2p7j2zKcIW2Ae7DQR/ri78I?=
 =?iso-8859-1?Q?+4Op+SoL65HzQ0a2OSocC26NbQ8cUjNqP1KKqruc6sj0gH62SO3phhdz5A?=
 =?iso-8859-1?Q?Su+9+pFAuxs1OgQrGDItwdmwSdDgQw48D72Or0nfss38VWj89jF+kUc0yL?=
 =?iso-8859-1?Q?crAyWEZGW8BKY65o0r+BAkvleg6oq55QV5NwYMl/JieCrrs/WLjH0/S4N7?=
 =?iso-8859-1?Q?zYaM0LuHRToIrEe8nIhyJr8fAqBFfOBF4XllTgIwq3aQ/73ox5sC2Iniqt?=
 =?iso-8859-1?Q?tnlNtCSrNpYLdjNrPvD0vrohWSaiRzuSXGvXnYvO8WztfsUEamotRw07cd?=
 =?iso-8859-1?Q?kDKfPln5TJwZLBFnPKkkQ3e8AuGO6nbwyBClYG1GXaUoC32qNRPolhnMrE?=
 =?iso-8859-1?Q?DYnOoa5XVX0jp9lJgSolu7n5m3+LWtqKBX+Dhh+5uE9YdaMA48Ac6RQ+6U?=
 =?iso-8859-1?Q?UInXkHg6U3w1w2IB9E7tUR4mOGI+Ut0yWwWfvO2qoGYfe58Ut/qJsY3seH?=
 =?iso-8859-1?Q?HLbIYCGB+Zd30H7bVkqp4Pf0Yd/Wv88VXfOjJEIWUdpHXh4tJhixLRjcfy?=
 =?iso-8859-1?Q?Q2Dr/mQIr5Rg2nXDpJopT5C5NgfrMhMPQMlK15sh4+vZ2Qkft7jE2oI7Cj?=
 =?iso-8859-1?Q?tELWKmtwTrt6Yx+zYx0G6owkjH0gm2gn8eUOHI8XlNQgwq6ns5WokxF66L?=
 =?iso-8859-1?Q?GUDMrVGi71wDYNtdM1rCwIQuHGt4t1BpyUlP9ai1Wq9s4AdxtvkHtVL5ZR?=
 =?iso-8859-1?Q?z/2xLy4uMRL+JEbVIOSFlY6mK8Xh6j3IMdnlJZ5nrUl/fnGTkXPSdH/rje?=
 =?iso-8859-1?Q?8U2GD7IsJ8hGLBpFBZYSLAXDQVn4KNOODFXCBIQHW6Zx5K6OLjAhbfkhAG?=
 =?iso-8859-1?Q?6SWv6Q4ng3kXmx0eDrW+2aZuB/5xvDNtgmtNMgNq+oQbDRYTM26QccjrGW?=
 =?iso-8859-1?Q?pH7e/V0mbwWbzeAj89d05lSFWLI3GVKdqKClC6bh+Tle2RWLvzMCsSjiU2?=
 =?iso-8859-1?Q?RH9iuWOjufw1Op+wOwZqDjdl36DLuEsYi29SAHMVFzneEF/fhjHmhlT2es?=
 =?iso-8859-1?Q?XM8VJ50/CbhcPnfa8uHYbhvJQeIeo8gTp8zaLwAtRhRQelTVC1oKUG48/x?=
 =?iso-8859-1?Q?KnS+YaK/EwjUzO54B8iL0aQrW8xRTrY=3D?=
X-Exchange-RoutingPolicyChecked: kcDOxrdcs1Oemq0rKYnN0BD2Sk8qud1HzTjJr3HSyNGeq1cfOSgoE5s1NRZon24MIXhKRaVIB0ibCyaGd5kQaZwUpaAqt6FZ+BRedgwjIzoRzoAaN8AOLX5WMxoONJzmMZbAUdOlEA3o34o2eFxBcFmK4HOtTs41bxB5f3IQnwueWi1F3mJNCahxRj0ujjSEJ+cWtjHs16BvS1FCmk6llAhrCLE76Hmujcywfwnfw5hPXN49y92fbEMc46ApKjqbOozjzL/Ea5+GzKNDztXC0dDlh8Sjb2e/WwpbTUJgT+c07Xq9MVukIb/WBZMmG4GfQPANC11tdSQ20XbyM1RGgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2b94cd-0e8f-457e-5bfd-08de84158ff0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:08:47.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb9lsNG6ZE1+kKQpeC1NdGPNx2qYhVzzsvPAUWrBkCkpKSF4V3vc6LKvGJ87HtKAf4iFx3j1g5wQxB5vHSO1+LHtSsyHUc36Ld24JbcMYYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9669
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-268561-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D63762A87BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:19:25AM +0100, Björn Töpel wrote:
> Stanislav Fomichev <stfomichev@gmail.com> writes:
> 
> > On 03/16, Maciej Fijalkowski wrote:
> >> Multi-buffer XDP stores information about frags in skb_shared_info that
> >> sits at the tailroom of a packet. The storage space is reserved via
> >> xdp_data_hard_end():
> >> 
> >> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> >> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> >> 
> >> and then we refer to it via macro below:
> >> 
> >> static inline struct skb_shared_info *
> >> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> >> {
> >>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> >> }
> >> 
> >> Currently we do not respect this tailroom space in multi-buffer AF_XDP
> >> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
> >> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
> >> configure length of HW Rx buffer.
> >> 
> >> xsk_pool_get_tailroom() is only reserving necessary space when pool is
> >> zc and underlying netdev supports zc multi-buffer. Since this function
> >> relies on pool->umem->zc setting, set it before ndo_bpf during zc
> >> configuration, so that driver that actually calls
> >> xsk_pool_get_rx_frame_size() inside ndo_bpf will get correct tailroom
> >> value.
> >> 
> >> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> >> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >> ---
> >>  include/net/xdp_sock_drv.h | 21 ++++++++++++++++++++-
> >>  net/xdp/xsk_buff_pool.c    |  3 ++-
> >>  2 files changed, 22 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> >> index 6b9ebae2dc95..13b2aae00737 100644
> >> --- a/include/net/xdp_sock_drv.h
> >> +++ b/include/net/xdp_sock_drv.h
> >> @@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
> >>  	return XDP_PACKET_HEADROOM + pool->headroom;
> >>  }
> >>  
> >> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
> >> +{
> >> +	struct xdp_umem *umem = pool->umem;
> >> +
> >> +	/* Reserve tailroom only for zero-copy pools that opted into
> >> +	 * multi-buffer. The reserved area is used for skb_shared_info,
> >> +	 * matching the XDP core's xdp_data_hard_end() layout.
> >> +	 */
> >> +	if (umem->zc && (umem->flags & XDP_UMEM_SG_FLAG))
> >> +		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >> +	return 0;
> >> +}
> >> +
> >>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
> >>  {
> >>  	return pool->chunk_size;
> >> @@ -48,7 +61,8 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
> >>  
> >>  static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
> >>  {
> >> -	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
> >> +	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool) -
> >> +	       xsk_pool_get_tailroom(pool);
> >>  }
> >>  
> >>  static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
> >> @@ -332,6 +346,11 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
> >>  	return 0;
> >>  }
> >
> > [..]
> >  
> >> +static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
> >> +{
> >> +	return 0;
> >> +}
> >
> > Not sure it's needed? xsk_pool_get_tailroom is only used by
> > CONFIG_XDP_SOCKETS' version of xsk_pool_get_rx_frame_size.

To Stan - we probably could live without this, right.

> >
> >>  static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
> >>  {
> >>  	return 0;
> >> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> >> index 37b7a68b89b3..2cfc19e363e3 100644
> >> --- a/net/xdp/xsk_buff_pool.c
> >> +++ b/net/xdp/xsk_buff_pool.c
> >> @@ -213,6 +213,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >>  	bpf.command = XDP_SETUP_XSK_POOL;
> >>  	bpf.xsk.pool = pool;
> >>  	bpf.xsk.queue_id = queue_id;
> >> +	pool->umem->zc = true;
> >>  
> >>  	netdev_ops_assert_locked(netdev);
> >>  	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
> >> @@ -224,13 +225,13 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >>  		err = -EINVAL;
> >>  		goto err_unreg_xsk;
> >>  	}
> >> -	pool->umem->zc = true;
> >>  	pool->xdp_zc_max_segs = netdev->xdp_zc_max_segs;
> >>  	return 0;
> >>  
> >>  err_unreg_xsk:
> >>  	xp_disable_drv_zc(pool);
> >>  err_unreg_pool:
> >> +	pool->umem->zc = false;
> >>  	if (!force_zc)
> >>  		err = 0; /* fallback to copy mode */
> >>  	if (err) {
> >
> > I'm not super familiar with the shared umem patch, but is it safe to
> > unconditionally undo pool->umem->zc = false here? xp_assign_dev_shared
> > looks at this umem->zc flag.. Presumably other places do as well on
> > teardown?
> 
> Good catch!
> 
> I can elaborate a bit; the zero-copy property of umem is shared between
> all users (sockets) of that umem. IOW, all sockets sharing an umem,
> inherits whatever the first socket negotiated.
> 
> So, we could get into something like:
> 
> 1. Socket A binds queue 0, ndo_bpf OK (umem->zc = true)
> 2. Socket B binds queue 1 via xp_assign_dev_shared()
>    reads umem->zc == true, so flags = XDP_ZEROCOPY
>    xp_assign_dev() sets umem->zc = true
>    ndo_bpf() NOK for queue 1 -> error path: umem->zc = false (oops)
> 3. Socket A is still active on queue 0 in ZC mode, but umem->zc is now
>    false
> 
> ...and we'll have a bunch of checks on umem->zc that now has incorrect
> state.
> 
> From this follows that the zc flag shouldn't be toggled on a shared
> resource without checking if other consumers exist. I think a per-pool
> zc flag is needed here or smth. :-(

Larysa suggested to use pool->dev ptr instead of touching umem->zc, let me
see if that will be sufficient. Besides that is currently broken as you
guys are saying!

> 
> 
> Björn

