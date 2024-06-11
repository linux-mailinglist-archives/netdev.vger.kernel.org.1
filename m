Return-Path: <netdev+bounces-102712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724359045A2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2392B25FC2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0E1514E2;
	Tue, 11 Jun 2024 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABUICaBE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AC59167
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136798; cv=fail; b=hMLFPSKabnHOxvfp7VlbQKj4xqt5kwTZPdjtUjZXi7tyv8Wf1qKOta6gg3v7ZOeBdcQny8fKxMFT4Un29p4C6GVaa4PXfc7R6VBI7A+0vgT6sChcclLRajY4ELqwxmeowu9HpIvVdAzb5s/nt0XxQDSUUGa+TmAiFaYmMQbuj8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136798; c=relaxed/simple;
	bh=M7AWKdXexowPQiBQOfJHjtWxJO/1/BILqcgoOCBEBco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ejVwNRfJ7PDtLxK0AJf0ySngeTBw5lFUrnv30uqqs0lCP8Bnr2JRIdWm7V1kzpZkd1tkQzfeVheDB68hvkSLvHdixO4T0XPVP7Xhp44qEp7UF/b0sHaoAFHKpFz9boplOofdNXP7aAZTmZbeAOr+Vt/5kPnu/RZyd1IwXfU+yrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABUICaBE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718136796; x=1749672796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7AWKdXexowPQiBQOfJHjtWxJO/1/BILqcgoOCBEBco=;
  b=ABUICaBEH98DieocjmVFQ7/Uu1FnhN3euxGr7LHNZsiTUayb/NT9xMyX
   j3a9Fk9wnvE3WEf0sIGSBg2kbvDk1311SIRqlh8uoKNi+5G1jRRm1seIu
   mLspT4af2F/Of5M+TtGvjpnsQvgnbn5FnrTooTEQiAVFhYF1914T/wVP0
   CM6fTsJT/yBrBFruuigC1ZvBQirLLMm8iWOMAk0c9dAot0RAGFlT5yZjm
   cDdZJMrT4qj8WOw99/tQqPMaEZ22v+8HvZBYyiuzfkUX/gMPCVJzuF5Ae
   2iKRueJgqlQRA0gUCfGx3y5y8cRcmhlxmCCG38QBSJAsb/D98IVwsen20
   A==;
X-CSE-ConnectionGUID: fqpede8vTMytBPiG779miw==
X-CSE-MsgGUID: n00VRy09Rw+B0uyyTwR05A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26277494"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="26277494"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 13:13:16 -0700
X-CSE-ConnectionGUID: 280wgr7rSuapG0pxkv/B1g==
X-CSE-MsgGUID: cYYS2S5eT5OZKm4T0kqPkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44502268"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 13:13:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 13:13:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 13:13:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 13:13:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 13:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anXZZL1y8nOZVdM+ESqPMJ848hFOSjg+akBgpbrPH0MAz1Lu1tfxVl2d+k6bPyKPA5g8gIqdPDPN+863lHseIIHRHYhPnSn7O9FFvVQEH6t/4HaGixOmmet4yH8HlRAqnqzG0WdoH0FxEBi67rFjbpwopXUmMSsnIszGN0xqHDzfz3S/c2qFQPq+g2y2WgoqfL87pSX1PuJlCCgDq4SuJVAYpbDF1cSX7MHmCUuBkrW+10cvkYYfWLc+22qxKZrNIuQtBAXfRV4RV2TbOf7GdBOQ0jZpZW6jvOKfbDHmwZwKzI8//1HtOH2eYvEkUhRd3WdFicywywJaD1EeQq3WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7UQmNB1VKgYTtKLN5Az7WaRTv9XU5KlFlGhwm0IOIo=;
 b=apKl+BqevrxFGWF5FZQW0FOJQsegXBhrEJ07uEWSc5q0qTo1pkIEFkN/lIuBzgXB5ZbxtKnbti50oWKTv49Mq7WJdiNB/oUHI/BTCfiYqNDib1RaCLK3wwVvqzW8nTOEIWWJlCSzTJJjWeGUXRaKvyZzH1g3++gVeh/vCnme9/0vZLNLZYVfJQHRPG6WBExOo8L+hgeN2sZ3bckCgkCH/AoyN4PL9BC0G6Vnd0Q9DFWc9kYGoQUNhPLolYWXEhGKvTquA2M7bXv2IyTe7LNTGEV5HrZrnL/1BEXW95bWmkQ3kgZGpoBa07cycGkecTSxBPnHebhCeYd8bpGqsXeS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Tue, 11 Jun 2024 20:13:12 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 20:13:12 +0000
Message-ID: <42137689-ad69-9bcb-76c5-7273a2590370@intel.com>
Date: Tue, 11 Jun 2024 16:13:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net 1/8] ice: respect netif
 readiness in AF_XDP ZC related ndo's
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <michal.kubiak@intel.com>,
	<jacob.e.keller@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>,
	<magnus.karlsson@intel.com>, Shannon Nelson <shannon.nelson@amd.com>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
 <20240604132155.3573752-2-maciej.fijalkowski@intel.com>
 <6f616608-7a56-43d6-9dc9-ea67c2b47030@intel.com> <ZmhdZwzIStFpghZK@boxer>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <ZmhdZwzIStFpghZK@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 9263d434-5593-4b1a-1220-08dc8a52eb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDlPQ1p2RDQzMWpaajBTMC8zYUNJUm51QXY0Y2F5OXhJdEZwTHYvVVR4dU9Z?=
 =?utf-8?B?MG5DOXlrYmpxSlljcnRQWkdVQ285Zk0wSlgwb0wxaEJTVkJObXBTd1l0TDdK?=
 =?utf-8?B?MitxMHFHODdQU3hmWnNqQVlkdkFmbUNzUEhUdzVpeU5kWFZTR25xeSsyZ2ZN?=
 =?utf-8?B?dm14NDZNMVhZM205dS9yYU9iaUQzMnY5eGFuN3N4b3dNOW5UNEJjano5WHJQ?=
 =?utf-8?B?L3NNQ3NXV0dyaEoxQXpWb0Yrdy9BRDhiRlg2YTBQMTlSOXpWRnNhODdqNWRN?=
 =?utf-8?B?VFg5bUNSMzNuak5jMEFSRVNMeTl2eVo3ay9rR1N0S0dTY28zZW1hQW9XT2d0?=
 =?utf-8?B?dkZsdlVMV2FXTEhxOHdwVysxRFYwZHhNelNmTzN4WU0vWWtOeUNsMU9YVm1D?=
 =?utf-8?B?RzFFdk52TVZPZWVlZVpSaE15TUhrOFFNcmtQbERCOHpzZGF4OWF2amg1amdV?=
 =?utf-8?B?TWp6M0hQclVVRlBPMU5jQTAvWXN1eTl2cmlpTXBWNjlDVnRYV0h3MDA1d0Ri?=
 =?utf-8?B?NWE0R2VJYXAzdm1LR2thYWN2VjZMSmxTandMS2RIYUE0OVJqVVBpTWtmY0dZ?=
 =?utf-8?B?ZGRsRlZPQXlFSnRSQlBlOTFLSVhRUzQycGcyQUUzSGV1QXdMNTFkbnRLUzBW?=
 =?utf-8?B?dmQ5dXhXdVdxSkxZclRlQ0YwZjBkR1VzWENJYXZzRi9zVlVVdWxtMnhFSEdj?=
 =?utf-8?B?MjR2eVJYcjlmaGlEMlBXejBuRlREMVd2SkcwUFBTcTU3a3FZM1JaNnhZWlQ4?=
 =?utf-8?B?MHZLS3dmcWJzRDJETmkxMlNBaG92REZTekU0VjZDUUJMZ3BuUCsraEdQOFQ5?=
 =?utf-8?B?NnRkTjJPcGZ6MFZZYXFza2Y0OUJIVXAvTmRuSUpWT2xCemVpZ3NDcXI5Q3Q4?=
 =?utf-8?B?U1RqU0hDUHhlZHMyYzRrNWh4ZjZmTHZ4SXdQYmIveTl6NnpPQWxhNWN6K1l4?=
 =?utf-8?B?YUNpdm9QUE41R05NWFBsTU1yVUN5a2todmJMQ2ErRm5tZ2x2eWhLOEE0Y3Q5?=
 =?utf-8?B?a3k0VlJqYjViNUVNeU1ta216aGxTT0pUWXArUnEyVkNnc0Zoc3pST3luN3JG?=
 =?utf-8?B?Z3JVaW1nbENpcjk4UWR5d3VJNVhrdnA4YkVLUU9mN0NyTW9RYytZRm8rK0hm?=
 =?utf-8?B?SjVWRlVLZU9Wc2FaaGhHUXYrK0dXc1JRMjZvbHlzNjZyWEhLbks5dHJiUzNv?=
 =?utf-8?B?RThxUFVjQlBFeFFvV2tnTkdNcnBxbXd4L0xyTUNwSnlXUmRPRVNYcElUamJI?=
 =?utf-8?B?Mlg1RGkwdmxpN3pWZ1I2anIrSXFiRmk3cUZxR0tsNWZaOFM1bVcwM1F5VW51?=
 =?utf-8?B?WHFkZmplWlhOcmEyUFBkaExaUlQ5cEtUK1lsQUtFTzBZN0NpdVVHSnRPMk1F?=
 =?utf-8?B?QmVERkExZ3NUVVpuQTJuUGlzaWY1d01JQTVBQitBMjdzOTRYMFp3WU1helVo?=
 =?utf-8?B?M2k4d1FhUkV1NzdYWkZZKzJleGZIamV3aWp3RjRxUmZWK3ZHQVd6ZndNNUlw?=
 =?utf-8?B?N1plNTRsTDQ3aFNnaVNWVFhrVXVvNGIwTWttS0dTQ1hXUWZrdHUzc1gxbXoy?=
 =?utf-8?B?YjhDSEc4em56MFVhMEFCNmtIaTlaOFk5anlRWGJ3S3lOajZIWkNqK3ZJT2VD?=
 =?utf-8?B?ZXRycldaYXpXRW1CUFlMUjJHS3NNelV0Qzh4RkZIT0EwVE5KNGZ6RnYwaE1N?=
 =?utf-8?B?WkFwL09kSnc1VVN0SW1aMU40cTI3Sy9qZ1VRMFhpcUVidSsvMVo1bE1TWjlM?=
 =?utf-8?Q?CNepJgeqMOoLyAK5xj/K/J9rM1hQPyi7QLfkZh+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHp1SzFNck1JbDJGaHQ2ZDlJZzJzWU1DZURyaFVtQVdrTlhITWZ1U0J1M3NL?=
 =?utf-8?B?aTFmdGcxNEcwMnlBb2wvTk1HQWN2SGUreFhqUnpqMGQ4ZHh2N0pydWhmV3Nj?=
 =?utf-8?B?UjR1dEtiV0NXV2ZEL1ZGRittVnd0L05UeTU3VGhKMm8zVXUyRTRlRlhGUVZY?=
 =?utf-8?B?TXdQQVpvV0ZrV3k5YUtlenlidGJLc25JTDBzb0E0b0xCaEx4bDZIa2c5Q3F0?=
 =?utf-8?B?enhOY3ZuU1ZHN2IzNksycmxVLzBjcG4xQkxBNURxb3VDdzVGVDlWblY3K0Z5?=
 =?utf-8?B?QmdaZUFzZEphSGJKZ0NvcnVnV2ZTT3lGNjV5ZkZYNkpyUmtud3lJMnBnY0JE?=
 =?utf-8?B?Rm1nOGxXYXI4WC9aQUQ1QVg4MzluU0RFc08yUUgyOTdtYnFoTkUrQUVOSm9X?=
 =?utf-8?B?b2tWbG9XZld5dmdDVENRVlMzNGlCWDVndXpHdzVnOHhDTWhJczQyTUFRTklt?=
 =?utf-8?B?SjYrTlJ6b2FLNVAyb0ZJVXdKeWNiMmNlVnJGVkNwVFdtZ0RDTEFyS21ycllr?=
 =?utf-8?B?TGJWYjNtclVDVi9VbkY4eDUzaTNEUVRMcC9DMnZ1TXZic0xnQzc1UWdqcEgy?=
 =?utf-8?B?NmVZWExqWW1VbklHaGJJOEQzMWYzUitaZjU1RGdKQ01zSE9kQWZzdi84TWhp?=
 =?utf-8?B?eUJxejhDWEtlTjRjQ2cySGZNc3BHeFkzS3MrYkRJMFk1OXF5ZXp5MWZ5TlhI?=
 =?utf-8?B?NEdwZnB2aXpqNjR6Qkl2SGFDYTg0dk9HMldLVDlaNzlEdGVrTEUydWc0Z05E?=
 =?utf-8?B?UG54dWlTL1cyRGpkU1hmZEQ2U3JjeFJaZ0c1TGYyZGpQdVZISTFVOU50cDZB?=
 =?utf-8?B?ZDk4cng0VGpCOVA4MjJMYzcxeTdBcFFWeDAyaXdDWnhIYlozUmpzYTNYanZE?=
 =?utf-8?B?ZzgvSUYwcU5hcnp6MjVvTWhaREhNQ3cyeHpDNXJ6Q1dtNTZYOEFEWHdXSkhJ?=
 =?utf-8?B?QmpKdWlDeDV5a29KYndpV1hRbEFvbzVXVUYyd000OGRBVVFLU0RtK0ozS2pm?=
 =?utf-8?B?OEJXeVFrUU1WSkw5VUNxT2dYdE5IRmo3eER3REdXc2srK1dPL0JEcUtnSWlk?=
 =?utf-8?B?ajN6eVNrc2VBK0Q3eC9HRkRWZURjMzFJUkJpVFBBTXZiaWFHaFM1Qklld3BZ?=
 =?utf-8?B?N25XWE5KUkxJenhTMSt4RHE1NUJxajNkWUI3a3pBelhEc1BMOWNKNEdBTUd6?=
 =?utf-8?B?dTZJQXFmQUpIcVhnaXhLQXZXQkdheFZNTHdGQVE2K0x6U25URUNKcTdycnox?=
 =?utf-8?B?ZXNGRVNUdlZFU2RXaWhubk5ZVWVSb3pHNDJ1MUlzdjROSExxMjZlSCtBeUZz?=
 =?utf-8?B?UEptSkNvS3h3aU9iVUFXTDVrY2t6d3NqNDlCcVVZeXkxR0VxQ1BlR2Fqc3F2?=
 =?utf-8?B?T3BQb3lMTGpKcnFyWmEyL0xRb2RZL1JtdjdLOUFmYkRRNkNGenpncmVTTGR5?=
 =?utf-8?B?b1prYTRMMU02VHhha0pxMlFJVjZyc1pSczVhQXZwQ3d3RHNqZjRQQXlaa1JO?=
 =?utf-8?B?Ulc0aHU3NXlxS0wxcmZwenlwMnRRa3ZhVlNzanB2RnYwWlBmQ3E0T09QYUF1?=
 =?utf-8?B?RG1MSlphL1JwUDVmeWp0UVFqb1BnYXQwcUpyUzg1SEkvTDgzeDRkR1dHRnRM?=
 =?utf-8?B?TlNSenhMLzErSENLKzhZKzVpWEdpOTkwdHRnNGc1UHR5NCtSaFRLbDB0MkM5?=
 =?utf-8?B?N1hiVzRQUUtaNTczWTFmbkpxSTdEM0hhS3UxL3kybytrRlh1WWVmc0VzSnd0?=
 =?utf-8?B?ZFpiNjBCUEtJNlo3OUFLVkQveVVuejJFRzErcHRNSSs4emhrNnBnVEpiSzNy?=
 =?utf-8?B?emNyRzNBRjdQTzl1N1ZWSlJQc21mVWFDR2VQSTJqSkR1NU1IYXp1eU5UcFRV?=
 =?utf-8?B?Z3ZHZlhDdEE3VWViQnY3SDJQaWRlK3dNNHBmRzBZV1pWWEpwQncveHBPWVU5?=
 =?utf-8?B?SklmaFVBSzJMWkhMbzk3RkhEMlowcDhDcHhFVC95a2lHY0NKdEhqdVFPNEVI?=
 =?utf-8?B?QW5DRlVQamhpU0RobUNpOHo2bWFVaHZwa3BOUlFOUTQvb29lTERFN2QwNlNT?=
 =?utf-8?B?bXg0MlA1bkhubXhRaUhZd0hDQWY5UkowUFBGdS90dkRVdUljcFZ2dzZEM09W?=
 =?utf-8?B?eGpFVm9QVmtEajU3ZXQ2MlVLUlFRL1J5OGgwYVZ6aDM5YUVhQThDejY4TWxn?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9263d434-5593-4b1a-1220-08dc8a52eb4a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 20:13:12.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbRDEK+hFbte4Lb4ZjQrwtmidVvH+fom7OOh0I57dah2CZnydf9VlwPU/wfUwXeONIfO8CJOstII5DLojLzYci7CymCWEKkiC/6ideKjYZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com



On 6/11/2024 10:21 AM, Maciej Fijalkowski wrote:
> On Tue, Jun 11, 2024 at 01:59:37PM +0200, Alexander Lobakin wrote:

>>>   	ice_clean_xdp_irq_zc(xdp_ring);
>>>   
>>> +	if (!netif_carrier_ok(xdp_ring->vsi->netdev) ||
>>> +	    !netif_running(xdp_ring->vsi->netdev))
>>> +		return true;

...

>> Also, unlikely()?
> 
> Thought about that as well but we played it safe first. I wouldn't like to
> resubmit whole series due to this so maybe Tony/Jake could address this
> when sending to netdev, or am I asking for too much?:)

I can adjust when sending it on to netdev.

Thanks,
Tony

