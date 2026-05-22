Return-Path: <netdev+bounces-290912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAFECqahEGpuawYAu9opvQ
	(envelope-from <netdev+bounces-290912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:34:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D307C5B919D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5FD93006500
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472E37207D;
	Fri, 22 May 2026 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Enj8OgWB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4F255F2C;
	Fri, 22 May 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474850; cv=fail; b=sztk9KWpIQk3X0pBhbPwjsgHU+GS9hjGgd6YFkmFj9TeBnYBogHG4Kx7AfSCwfNnzuWIMQn345QnS+Lp8WgWWJA8+94d9nprub3JrtBRpHBepI/RuR1cfQpxG8bTW4ebDNhq8b/z+oQAbIrorMiSsnlIVoTFuWds5PqO9PMQRZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474850; c=relaxed/simple;
	bh=CV3g67IM4P7WWRAtkth+vPnwfSahKLgyAAB47L09Elc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=THS5+sVoBv31Q5DHkKqQJkUk1e4wL2AQhZDtwgd6jhYwuA/VH49zNxotB7MgK9pQ4WUvGc61sfmspqt2O9cj8vllMlOPkeTw3m1eb+OMmQGQ0bkxuzqs9HPtwcf4/FNMCd6JTts1j/fhyWYJvmKKUX60h9f++Parl7evLtMHnV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Enj8OgWB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779474848; x=1811010848;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CV3g67IM4P7WWRAtkth+vPnwfSahKLgyAAB47L09Elc=;
  b=Enj8OgWBiWf6J+e57FvxJ8gTcQyKmD87rd6R8B1YhZtrobqBvpBU5ooW
   IAe4cT32KS7hPXtEQwmIjRHbTuzYobKtFHfy70eYa/FuptiT0PRgiPa9z
   Iz9PtlTl9d+bzC2jwpzI/asRu3l3kMT3JrWZPHBExRbicLGljhSLqzSrw
   odQoHBh6/GIhlUoIIS5xktuVAj4/dSmuLEmIJiOO0giHM0xZWMG9wS6Dc
   jkuYr1oxOLiqA8ug1yNkQ4dYa4K9JXa5xbXtZuVLegQDm06xnIiuLd+S7
   aHfCSFLULZ6DUXYtUnUDxc++EigPJrbK/uFNkWtUcgwLNH5MCmRHXFvMF
   w==;
X-CSE-ConnectionGUID: jpIGof+EQBusROwzYyl1xg==
X-CSE-MsgGUID: drL/bAZ3T1CtQAqtEBdVSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="103085676"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="103085676"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:34:07 -0700
X-CSE-ConnectionGUID: j6fWvPdxRbCnUuSLoFOEiw==
X-CSE-MsgGUID: cBCzzUFmS2KMVCwazdI68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="239957305"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:34:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 11:34:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 11:34:06 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 11:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb37ciAf9fmfPGXzHhJ98aXY4nmQ5ZwVMNKX8yu6Z8VNpkVyQLS+KEon7Ze9KLp98yDFjwJ1gKzIfBkeihVjv+0cWXXztX1j1RGBvSmndu+oU4q0hVgsTphGC+39XQrggnXvWs04RuHuyThL9837yevbOSz+BtiKsfbkIW97NmmqYi9+EzGDEoLqlNbkS/X/F45MEn7uxa7CMXlr7Thcju6eSOOj9GVLjkXc0iwFErUwod85gqo+7Dnmcj+vvvIzxoAuf++WkUTuyF+GgEhkLWd2r3MZAfa/DQ/nXwo/ap8XDDgcO4IUoU0WfrktA4hEgv8HlryJH/1IKB9M7HjDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0kt/Dw8XRVpulM14IETOXtFYbH55sE68YWKvvm1tdE=;
 b=C5Gq4cs4lFfs7k88P+NSSoE32EoEoz29Ny38ZAsxhWpMUMIo/DTrW4cHa1IM/VWAnYY0BiBD9994aC1AJ1c4bS1ZkF875FOLxcmA9RfCXHlTYhk/fVtqFSaBQ98hdc3lQArVMSN/TA70/bCGP5LsB4Uh1ekb+tAo3GppPlu2TSrTlla5X0zuZ9tWbGjWQ6/3xhzj8KyN/kq98Uegj7SpNjpfs6EfUkQn/ZkCWPoFu35nCmcsVBwd45DKOZ5KFQZBaZwSCIThSVjeUKIB+ne3mUBKoymLH0tCoNkKfhJcTi5H+5ig8AbJDXI1IxgiVxpLOSkb0nlV2r7BxHHg4H42yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV0PR11MB9814.namprd11.prod.outlook.com (2603:10b6:408:382::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 18:34:03 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 18:34:03 +0000
Date: Fri, 22 May 2026 20:33:49 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<horms@kernel.org>, <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
Message-ID: <ahChjcRmM+wEx2uq@boxer>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer>
 <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer>
 <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer>
 <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
 <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com>
X-ClientProxiedBy: VI1P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV0PR11MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: bd246cbc-d573-462b-0402-08deb830b296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|4143699003|5023799004|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: kgZx5ftil+YELTnAPax+Mxw13jhVrHd27qzx60QF4MxpTupwdnyFI+xlJJ2PFagayeQcHOxGQgx64lrEjPLzSu3uT8pkrNJO6nCEOB/BEbmBW4yY9YFBfItb06D2kvNZPEbwc7Qlk4STd0qvOph1K8ueWe7IX+yqMpS6mwJa/sVvqmXJIVMXA8OyU2o8qdm/ZjIZaofkPTVzc/WJLQxsFQD3aJI4JC3g+vbJt6uzPvBXtgLNbdMowUQIdG9xLITES6jlCGo/gbqBMRIabz0ws4/JKWv9FwYeIp/x3WSygBHNeObyLmKiCcfoymN+aE++LGmjcc2fsyZjJdJzU3wPWJwU7/c/22PhSyGupybI4c309Y+WtZ0NP/NkBR4s38uUVx6vNDvCo/QFoTmdLKR5b/YqJBHZdLoZgYBEW5oXIlZNC+EIq22T/CX7IGFIro+QycIe373cDK6eLVZ310etZyGuD7ieGdWulo9dbsLnNPy/3mthhYGIEQVajvgSS3Uj3p1/YNFOq7ygN8bar3GuHDwdRRQjca+Mjo9n74L+1W3x7SBknbr5PTmlpEvPLlVSPqePZvCDrYQ98e7nYs9K70S0qwgJmfN3MMEvFB/HTgAuGueZDIpfzN3oFij91tx2U0vSWbwBV9ccqLz5shvluau1I0pJ1CvAG+HC0z+VI8pEzFt+ORU82tvnZxnyNek0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(4143699003)(5023799004)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1dhbFB5UlVrQm5ZSkxPWVpBMUdnOG50ZjBKb051VXJ0b2RUejcwSXBIVHhx?=
 =?utf-8?B?amE2NHFqVkJhTWduNGN6R3hhcXd1anJvWm9KZ0xpbUJobS9INE1jbzllYkpj?=
 =?utf-8?B?VDViV3pPbSsyMll1eDluRkFDb0RBNWJOUDJDNDVzNFRUTm42WVQvbWpqeXl5?=
 =?utf-8?B?NGxLZFk5emlXeC8vbHFpbU9BSFVlRStoMTdhSFRlOUY4WWszNGllbmxCSEFm?=
 =?utf-8?B?b0pMZFV0aXQ2NjNtUCtTV1FuZmxhQnpSV2hMc2hvTllLek5IZVM4VWVqTzVa?=
 =?utf-8?B?TUJwVzg1OUZwZDdJR29aeHY3bHdJcUxCbWNHeWtmNlJNZEZkbU1QTzF6YllI?=
 =?utf-8?B?bXJ4UEZFNTVqMFI1bnduTWN5Vm1JcmQ1OFhEMGwwUnEwcFprYXVCSCtQK3I1?=
 =?utf-8?B?Qk1FdEpvY0E0U2tMODNSM1JHMGZXV1p3MllwWXhWMVAwVG1uZFdrak1tV0Vk?=
 =?utf-8?B?cjg2OEdmdVJINnBpZ21pcGtSRlJuSCtUckIwSE5TR3pTQ0lNTVlRakZyVFlF?=
 =?utf-8?B?ZHNuMFVFZE8wekJCcFhvcGtGRllONG0vcGNoY1RsaXptYUx3R3M4OGhWdWta?=
 =?utf-8?B?TURZSXl6a3FVRjd5MGlGOUlNOHE5RTFsbkhISDFDWVIrZU5WTjVtby9VVjRP?=
 =?utf-8?B?YzhKNVVIclVXbFRTM0dZamZDdTlFL0FIeFg5dUd1dzBZVGxEdytleUxOcEI3?=
 =?utf-8?B?N1FvVFZtNlZTdkFBeG5qSHo4VEdqbDdNZk1qY2pFSlJCOVorbW9qeEJBNUdh?=
 =?utf-8?B?RWdmZHJNUkhEaFdJeXkvZWF3MUJpcFE5NkQrUjVMN3hsWjBHZnprQVFFcUhj?=
 =?utf-8?B?K2ZjWmt5Q1lDc0pGdHcvYnVxMDV5Ymg1U25nV2h3cy9zbm4vZWZhZHRFVUR3?=
 =?utf-8?B?U0ZwZW9yK1ZwQW5PbmlKbmVVczNDNTY3UG0rYWRSandRb1VUcTlSS3d6a24y?=
 =?utf-8?B?OWlJUWdINEN3M2JST2o4TVhHZUR1cXk2VU9GUUNpcmQvUzZKNWdQbUJpVEVF?=
 =?utf-8?B?YmxJY0ljSGo2aEJldzYrN1hoSU5QVEhYZWs0VkZpdWVyenRzeUU4WkZEV1l6?=
 =?utf-8?B?bmZBYzBnWDJGQmkveXI1ZHc5SFdWSWlpYlBLOER6RW5pYTl2MW9OelFnamxE?=
 =?utf-8?B?WWZRRk4wVDJ2RGFiQ09oY0hUSFg2cysxa0RiMXUxeVBNaHVtTUlPSmpRVHhL?=
 =?utf-8?B?V3NJVmFLeW1LeWg4NllmcVdoRjhpTTh4Y2I4czB1bjBydHhMSWt5SjFYdDZU?=
 =?utf-8?B?NHYrS2ppcnRoNDBKeUg0c1hlbGYzb3Q0MFlNOCsrcGsyUi9xK2ljbFIrMEtE?=
 =?utf-8?B?WEhXQWtwV0hMb2tOZnNzT0tYUTdxQ3NGcG9VOXVoYlpLQjhKQ2pCczJTVFdQ?=
 =?utf-8?B?dC9QTS9VbzVZbkd6K2pnVjVpdmwwSmdzUDJHbEl3b284Q0tqMlM1WWh2a1Jw?=
 =?utf-8?B?eFdlTFpUWUUzbEdaS3l4NUVUeVRZOVN4UUtqUnNZVkJoUWphLzB5c3czazJS?=
 =?utf-8?B?U3RUc0lnelpZLzlzQ05SVThKWlltUW1lTTZmcjZLOVFsTkYvMUN6WlJUOG9l?=
 =?utf-8?B?d1FpQ2FTR3NuRFFWNlh2MzBiT2NsczhiV2d3UnROVnNXamZoQVA4WjB1NDR1?=
 =?utf-8?B?Z29abEtTRkt6R1lqK0JqOWdFSHMyaHR6Q0grVzltMmRqRlV5OHZVOVR5OTBD?=
 =?utf-8?B?R0xSZ1huRjhXR0tGMWREMmgxMVE3eXRLYmFSSUpIRlhyZXdFdUMzaHlIMzkv?=
 =?utf-8?B?ZWI3V1lqVWJhNC9VMDlOWXE4OE92d0p0QW9hNVRjQ2o5aUU0Q1lBQXozVG1U?=
 =?utf-8?B?OW9MNTN5TitrbGVmMWxjaU1QSEJGQWUrNjN2NnhkelI3bVczOXg4RnV0WE1l?=
 =?utf-8?B?dzdBSzNNeW00R1IwRjVBViswdWZDZE5nSVYrb05sSzE4YVFUZkNMdG8rOWdS?=
 =?utf-8?B?bUdKWnZQL1UwR1pVZkNLcFFpWFFNWkpCSWdXS0RtaG5QZ0ZpNGkxUUZMMmU2?=
 =?utf-8?B?ZE5SNjVCbmdET3hxdFVZcXdWRTVsYjI1RndUS3l5Q2FVWW9SOTN2M291N0VB?=
 =?utf-8?B?dW1vN2xOcm11Qng1N1N6NU1JVGFJNys0aEx2NkNBbCtpNzZ2Y2NoZS8yQ0p1?=
 =?utf-8?B?aGY1SXVEcTlkTWlPWVNwZVNJeFZFdmZsVmlyaUdlK0xsWFIxSWpHNWRGRXNp?=
 =?utf-8?B?YUlCRHRqMmZuSEs0OUVIZUtOQ2w3bWdrZlVzYjdiWkxMVEkrWWF3K0duKzhV?=
 =?utf-8?B?NFV6VHJob2VaYXg5NDJsU2hhK25XNWNUUWZEdlVteU96U3Q4ZVdMQ1JURWpy?=
 =?utf-8?B?aFZ4YnNKTUhPbWxuZVlvcUVVUWIrVVptT0hRckUyL2xkTloxRU40VUZ6Yy9M?=
 =?utf-8?Q?0ZEFzkqeVx3oryEU=3D?=
X-Exchange-RoutingPolicyChecked: GvyjOc+1+coC2qXDi8FpHkHzcqtcx2vEVxBkctnN1fanstLhQm3Tz8V3AFQxSrsocXzSC2v6GKKzh7tDry0vapwxWUFIWGU4i4v31ULoW3NYWl96dcYxjwoP2Dl+QjSQ67uLxs1I+K4A80+24tfDH+gkuwWPMekcRu1Od0m2IQ5YGQAnmP2m2mfrOIT+Ot/kW075DotcwssMPIxMVK1/IjZh6UWCIrdkflTdKkxQEbVQmQWBs0OcshBGQFV7DJbRz93uuvfUdOdz0wCujIs+2+KvfVc7jKkwcAlemccbd8TRsoTVjeqvLlVpRmy9xikfx020+HeoNrM/cHU/R51DqQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd246cbc-d573-462b-0402-08deb830b296
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 18:34:02.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlA6HEearDHuvkK3mlLSMoaUsqRl5ziHokUl3JmFkmJexQHIdDv41nuXuxHhasesA09gXnlDuKBtgupKXEt7P1vwTaMSm4ehCIwqvOhX/MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9814
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290912-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D307C5B919D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 09:48:39PM +0800, Jason Xing wrote:
> On Fri, May 22, 2026 at 4:55 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Thu, May 21, 2026 at 10:24 PM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > > On Thu, May 21, 2026 at 9:00 PM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > > On Thu, May 21, 2026 at 8:24 PM Maciej Fijalkowski
> > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > The series is the product of previous review from sashiko[1].
> > > > > > > >
> > > > > > > > 1) META
> > > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > > >
> > > > > > > > 2) PUBLISH of CQ
> > > > > > > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > > > > > > >          overflow occurs.
> > > > > > > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > > > > > > >          publish its address when overflow occurs.
> > > > > > > > patch 4: like patch 3, but only handles the invalid descs cases.
> > > > > > > >
> > > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/
> > > > > > > >
> > > > > > > > ---
> > > > > > > > V4
> > > > > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxing@gmail.com/
> > > > > > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > > >
> > > > > > > > V3
> > > > > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
> > > > > > > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > > > > > > overflow case (Stan, sashiko)
> > > > > > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > > > > > 3. adjust the selftest to make sure it passes in either virutal or
> > > > > > > > physical machines, which includes add usleep to support physical machine.
> > > > > > > >
> > > > > > > > V2
> > > > > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
> > > > > > > > 1. adjust selftests (Jakub)
> > > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > > >
> > > > > > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> > > > > >
> > > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > > >
> > > > > > I noticed there are some flaky tests which have nothing to do with the
> > > > > > series. Can you confirm that it's not caused because of the series?
> > > > >
> > > > > That explains the different results as i am using i40e/ice which have
> > > > > multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> > > > > Broken tests are from mbuf cases.
> > > >
> > > > That's weird. I never expected the failed tests to be about multi-buffer.
> > > >
> > > > Are they the same as the output you attached last time? Or something
> > > > new? Could you please share it so that I can investigate the root
> > > > cause?
> > >
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > ---------------------------------------
> > > not ok 94 FAIL: ZC TOO_MANY_FRAGS
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
> > >
> > > # 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> > > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > > 1..108
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > ---------------------------------------
> > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > ---------------------------------------
> > > not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > >
> > > # 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> > > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
> > >
> > > Summary:
> > > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
> >
> > Sorry, Maciej. I managed to get one server with i40e nic but still
> > couldn't reproduce it. Can you try the attachment (that is the
> > replacement for v4-0005) instead? I removed those nasty CONT test
> > cases...
> 
> Ah, I think I eventually figured out a solution. Maciej, could you
> please test the 2nd patch instead?
> 
> This patch reworks the CONTD test cases. Cross finger.

Please don't rush things here, I believe we need to think a bit more here.
I have second thoughts about overall approach.

My understanding wrt CQ was that it is a container that holds descriptors
which have been successfully transmitted. Now we want to add also leftover
descriptors from broken packets, which might confuse user space sides in
case they were relying on behavior described above.

The intent is right of course as we don't want to lose UMEM descs, but I
feel like we need a separate mechanism for that rather than putting
invalid descs to CQ.

Does it make sense?

Besides, even though we would stay with proposed changes, behavior between
modes should be aligned. Right now ZC seems to be broken in touched
regions here - when we hit the limit of frags via pool->xdp_zc_max_segs,
we break the loop and discard the packet, never post it to CQ and these
descs are lost from user space POV. Then we would continue on next call
and interpret the rest of too big packet as a separate one (clamped) and
therefore submit corrupted packet to HW.

I'll be looking at ZC API but i do think we need a common approach,
mode-agnostic.

Thanks,
Maciej

> 
> Thanks,
> Jason
> 
> >
> > Really I don't think I have much time to spend on these tests which
> > makes me feel extremely annoyed... It's not easy to analyze the code
> > without a reproducer. The good news is that now I highly suspect that
> > this kind of CONT test cases pollute the whole cq which affects other
> > tests. Before I give up on the 0003/0004 patches, I'd like to hear
> > some advice from you. Thank you.
> >
> > My original intention was to push batch xmit forward but at that time
> > sashiko pointed out some unrelated bugs accidentally.
> >
> > Thanks,
> > Jason
> >
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Jason
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Jason Xing (5):
> > > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> > > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > > > > > > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > > > > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > > > > >     __xsk_generic_xmit()
> > > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > > >
> > > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > > >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> > > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> > > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.43.7
> > > > > > > >



