Return-Path: <netdev+bounces-106913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9ED9180E4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C0E1C2155D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBAF17F39D;
	Wed, 26 Jun 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvazUMLL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7413D89B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404517; cv=fail; b=asjrOLfrCTIFKqnoELKkg/6h3yvh1sueL5bIhQtnNGYIWQXCm7A8OYdIoHGD/s4DT4Ok/L6CAQu1kumXzfTQ8aav7MsTmU8nZQSVDiWL4v7rAgNEVuLOV4XHgwjr+Voj77e8W2YyEgEPs8mokKLPE593k5GUbpsdit5DS56BSAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404517; c=relaxed/simple;
	bh=lr8u32m6YcWsEjPLABJ6+0h1OXI8hJOvTp3a5fNZ7c4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDSaVmN7qRj1Nu+BB+KQIUFaJYaGZvIhd7lm7a3ijdM1X1UhcYa5mW3tYce4rq059OYppRI1qMDXdWrHh26CNISuGKse1qD1Ev8QSfLveup/tQ2rGzyFUpPB/iWh1ycDgF+lrYwhpZBRzFJaCsmjkbh0vR7YNZmZ4FV8NO0PtPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvazUMLL; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719404516; x=1750940516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lr8u32m6YcWsEjPLABJ6+0h1OXI8hJOvTp3a5fNZ7c4=;
  b=lvazUMLLWQfGHi4FBA4dsIN7bGtNQqJm5jEQBRI3hT4FA8tBlNdPnE//
   kYFAft9clmRjmcqQS1QYvl/4a6XrTcl2Ab9tnkaVgF4tnzUI9A3y40SBj
   3ns9yBHY9Jkz+f9xnbXKTj1wIurlvxGCJH/fHMbGKYKIKqNLuGawZrffv
   +yD/WZhg2LV+pwkQyuvnxFPCkyWrphrrS4H4ilaU08cw6N7R76/9GeElc
   q8htf5+7GTa/TlKwat4T0QKjnIjTuP+hLOrUw+aOxE/z3iISP+nxXn8O1
   KjCYgNo1KT9znZrE61cPbWAi7f+mwmX8Quuzob+OD61DsnSbS6pJ69bgT
   Q==;
X-CSE-ConnectionGUID: HG2p9XdSR6qI7pEu/ZgVkQ==
X-CSE-MsgGUID: F983u+uWRNSFqnlsdwfZQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="12257601"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="12257601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:21:55 -0700
X-CSE-ConnectionGUID: G9bG0mWYRmGwpZXBJTdXAg==
X-CSE-MsgGUID: oRg4Sor/TW6yWkPSeGFoXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48359844"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 05:21:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 05:21:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 05:21:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 05:21:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZigBpJQMNKCFNklxVNJCWfK01/roe/9I0vMKx4EA8cS3878hcTGaIzq0f4MdET2g5NN4wj/bhWjM1hishBSQvoH8hl9sOs3tLA//kGl7rkhrcWo7rnrJbUOskK6kAgA+nhuXaJGRA/W+RzY5dBqrRZmk752Ibiel5YlW5G2mQ+9lJPiDNYihOMemcVjlf1iAJkEB7EQt4X2PUYVoq23VeyJ5/arDzH9EAC/8PS/wRWqMDIbclbGH1Qc90IKZHcsD/jENMvfGPGEEUQ/gzNVHu/7U4E8plUBE0YpD1EWRirVDbVuyuwo7U9Nabk7NpAl7w/raS32Z1+SDSQFMefKBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7ls4blw458KUfx80vALbHRu/MhXX1LVVmpeZPGWbJY=;
 b=dvso/Ng1apEc9Qt9SSZqpMaMntZdVWv2pLX9EgYhhO3vgZyNFL+VwUiL9rVL5zMeNKuGEvoRofyBkEdkCDzyC0z8qENIHiHImjrOA8U/jLvO1jBttFuytNiwOeAchxMU4odXi3nQSmKrVx2MC1EOzRmjjsuMh9r+K/ygi1SiVMURvRhVzfE2PjsCnwhqFlykP1M/Z/Wnyb8a1J/Yrev0dPjpLansgkpzgW6QFqSRyozz49tcxPnriX20xIP9hiPOcJLjqmEYqaWb0WvxxBRvnQZRmQnVkayliMW+LDczOc1j/7S68wQGmUkoXfv6VBa/iIg4tFUVktw6ZoKXfGr8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Wed, 26 Jun
 2024 12:21:52 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.033; Wed, 26 Jun 2024
 12:21:52 +0000
Date: Wed, 26 Jun 2024 14:21:39 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <magnus.karlsson@intel.com>,
	<larysa.zaremba@intel.com>, <jacob.e.keller@intel.com>, Shannon Nelson
	<shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH v3 iwl-net 5/8] ice: toggle netif_carrier when setting up
 XSK pool
Message-ID: <ZnwH07F44QBSdQ1Z@localhost.localdomain>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
 <20240604132155.3573752-6-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604132155.3573752-6-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: VI1PR08CA0249.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::22) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 798b07bb-9366-49dc-444b-08dc95da8f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ouTU3EjbNv4Dv1/fc/J3BZwKfXNQltQa6g5NsiS0262MI2vcbWxcUEmbUvc?=
 =?us-ascii?Q?ZUHiomuKJs9uc6VoOAeVY512gvsIoIuCuAjyg8wG6McW6YIJODu8JLDmr6SW?=
 =?us-ascii?Q?dhpBy/vA/y6dsJitdB8u9VhK0StdoB52HCId18TFK3tgh0hp5J/ZYoDcOEa3?=
 =?us-ascii?Q?AFsGVdOXUfrZde7vDlLegEEI3OUrZGIy5RPS8c/ZHQAKjs0VoeQJhpj88x3X?=
 =?us-ascii?Q?1pJnKF3rnmfRJBZj3jbA2oaICul9RUFEVXGgMqQDQX1qZBpzcQKLPF2T4+7S?=
 =?us-ascii?Q?z+p4JQUMWSr8apsvW0076rdAQDnDUn8R2WcDTCmBIucLSVinZQ3hCQEh3vxw?=
 =?us-ascii?Q?fvM5Gosll9OovpndvpMEmFsCba4cltJaZzhrzN5bd6nr0wgEI6ySQ+37emlR?=
 =?us-ascii?Q?t6erFysLM6hfntNNzEHIIn7FOH0C8sbAeXeSy8A9C3tXTS5G+ivX7FfFxtm6?=
 =?us-ascii?Q?38k0ebmqifuczpRHYwW18qtXPm5MgJKAv44DZfW6uIgKMeY/NHepseXRx6nG?=
 =?us-ascii?Q?wg3ByhO7vEHW5g69p1ijk3k4PdBUI46ewRUhvIeilfmkfZ3Awf0Vl4k6Xuz3?=
 =?us-ascii?Q?3Ql9WbSf3VWvxdcF7dgCnjs/Kl6ttMPBpaePhfr7d2O+3GI3W+nvaqqXXz/n?=
 =?us-ascii?Q?3n+Hoakrh8UAN+Plw0m1Xb2zXl63Hpq7x2q5IXomFhC8VmUEJHYRTTwKEwSD?=
 =?us-ascii?Q?GF4lIQIDtQ7ImXrOW3US8OPchMNL+sK6zLUvuVHgSDmOLEAzQpIL1V5Vfdj/?=
 =?us-ascii?Q?hUJgLMlaut9DRObqbKdpHAVnQk03xn+IiMePdZz58h+8LVMjXSTxTcS+GA9M?=
 =?us-ascii?Q?rwco/458NtNns4Pf8b4GLH77s8Q91xqt1gtWuhZRJ9tNpIyPnfl+a9Onxxd0?=
 =?us-ascii?Q?MqutZht4RPjQZvUHKKRygCJCNH9ZGoY67+Q0/zahUPYtLGnsR0jcikaRCnV8?=
 =?us-ascii?Q?rpawu++AGk2vtq8lNv/ZOtSvJZZUjysSYkluTovVzEmD4orOkogJD16il63j?=
 =?us-ascii?Q?6yZvph5Tl8pwxuhZT+XHqLVAexVNBIT+nUXKab2GUN+hED7S8We3EihCW1HW?=
 =?us-ascii?Q?I1iIr9VHYxv5OUugxbhjpjh7KwG1ImeYaQHS/Kj3F34yHJzb0UGCQ3ap1CJC?=
 =?us-ascii?Q?6gelBvGHRkUq+c/moUaFZr+uC7wbQMFdtzOA1Cf3CrJ+3fzjHsii71rVuqXR?=
 =?us-ascii?Q?rXFZzs7ZxmMOQhGO81c0mMt99WGLq6z71GQhG0aZ4QLaJsvpI2HX78QVIGkX?=
 =?us-ascii?Q?i3QB0uamPDEaSC8ldzPRHTVtjBV+tZ4L5XABte91FpoUCnfMWgrty8Gv1R8K?=
 =?us-ascii?Q?qrjAD9ezVNESSwZPKt3Sbwcj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JsSWOCKadmfcaKTEfVdBCod4BK3+josVrKVsxAM/WY220ZBoAdmBBljCMUyq?=
 =?us-ascii?Q?78US1J+5Aj6hWnXkFHZjZmQBpGvwhucmoSev/ZmAOiqBtYC/qbb2X6kiVE5j?=
 =?us-ascii?Q?6mEEf7850Z10jqKJACVADTwM5WIXZeF4eUO+MPfCyNM/BpCgK1spOc8AJVDX?=
 =?us-ascii?Q?QgK/0T63/zFYoksTO5hB4bHg23pw2/r2thHU044EIU6qZ46Ah7EKkv0X7XgC?=
 =?us-ascii?Q?s8uD0Pwwdjz1ReTCvbYmMjskg+8Ghyo0j+8EEVEyLvJCIAfchlWiMAut2Lp/?=
 =?us-ascii?Q?WuMaem4sZbumDdPzyfpHSuOnSUKudgZQuuikYdzrsKCD2TbodlsRKE5yZR8m?=
 =?us-ascii?Q?t3pmbf4faTE8rPKAJkhlfYnMKQPbyWHvSwbU04zsBqCDT8kXdsu5xFW+riyI?=
 =?us-ascii?Q?hdILAKILi2qc92HusKMucJa6VyP3X3uHspQ5wUfr26Y9DNqdi4qqehisaDI1?=
 =?us-ascii?Q?xZ2CObW67mNp48CzRIJwWUC+G+EgU3GiEYEBc/z1aBQXjjZXfKtdcyi2P3Gi?=
 =?us-ascii?Q?vHIw3lzKxODCFpcinHPBUvO5XQbO47RAf8xEGX9Ow6ybB4dy3QeGvICYbBOF?=
 =?us-ascii?Q?uwIyxZKe+C7uW0SXl52/UN8epKGXLfdXKdw7gqtFvDIMtiTHtn4Biy56JII5?=
 =?us-ascii?Q?l6IDdDPkIubNRtNz26Tu74AT7X7LShRIIIfNjTEtEgQHGgailiQbSZtqzYX4?=
 =?us-ascii?Q?6ckiLlPv/sfXjKL15iT7pygcGs8+JrJYYjzTx9Rwyt34tx665L6s73Qe3o79?=
 =?us-ascii?Q?wpQ7H52QsLMhkYN89UEqcU89qfzB2Vm0L7eBfNl1q6qFo7fu2LQ8UoC3TXhe?=
 =?us-ascii?Q?kgz5UsZ1DdAAPMiVjNOx23ZlVE+oqskVkThlPO5y302dM+a0nbSy8gLOQ+iO?=
 =?us-ascii?Q?9PddAQl6PjmMK3ur6BlRFtDP39tbyzDIgXe1uNV151yCRHieW41y/OaeQ51m?=
 =?us-ascii?Q?/fHtRkFjddI7um1WS+674zW9A4SqcML6jPh6OL35w2vKkz0Pf6asgo9Al0Fy?=
 =?us-ascii?Q?w0moJUG1iTkDpoifjBpsMC0jLRku9H1nrb8BCvuf2aeaCVc8pPQxUAQqjkaw?=
 =?us-ascii?Q?4ttYalIjkJAecjK1q/4FNwmv3Ww3u6Gxjjaq8F9i/m9ZPC3jYor13LoNO/m7?=
 =?us-ascii?Q?1pEPQ2lnqX26E2rCpFgoFSlqKtvTxDOTFrvu0CS81jf1qiVk2AQGSCTKQKcf?=
 =?us-ascii?Q?oUsYT8yal/K8gyWfQtIB39nw+lIot5zAiiJVncZwpyXMowOZ0b8AKzwYjlw9?=
 =?us-ascii?Q?qOdnS5aJNFLf3ZNzETbrYDIEATdrhV8JaNnXVN/EA/DwjVzYO9pBlgTYMtNB?=
 =?us-ascii?Q?X/1TkRDDZDmfqKDXVkuXb5EXzxGRX4YeQ4tOQZmgcxAHN3fTUuIMNUA+XkQ/?=
 =?us-ascii?Q?U9K2oZMiZBdiylBNmAofp+FJPn44eRGCjV3uYQMHABkjaVzrCF6sfUduBv80?=
 =?us-ascii?Q?cDcAorigNeWqQrek+ME8133WCK5ydXu8yBlu43nqHFWbwH9JzbdeIz4FZ71g?=
 =?us-ascii?Q?kJwBo6gUgX9kNelBuF3ZYAMlq1TeuuAxPtq1k0dUTUyHzdjvQPLNUnHS4ceh?=
 =?us-ascii?Q?8XQv4cWaM5QBC3YvD6/s0HT+Q2fYVO2exyH9jmQEMlSKBy16zSn4I5jkJ/9k?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 798b07bb-9366-49dc-444b-08dc95da8f95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:21:52.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx0E7JyGOUr74sewUsEwD/FpuIwwT8GAMeVxrdX9JUtncSfL86Rlvl4YvqhDtpE5z5YOq5rGpev14QUx5fr39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com

On Tue, Jun 04, 2024 at 03:21:52PM +0200, Maciej Fijalkowski wrote:
> This so we prevent Tx timeout issues. One of conditions checked on
> running in the background dev_watchdog() is netif_carrier_ok(), so let
> us turn it off when we disable the queues that belong to a q_vector
> where XSK pool is being configured.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 8ca7ff1a7e7f..21df6888961b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -180,6 +180,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	}
>  
>  	synchronize_net();
> +	netif_carrier_off(vsi->netdev);
>  	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
>  
>  	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
> @@ -249,6 +250,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  	ice_qvec_ena_irq(vsi, q_vector);
>  
>  	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
> +	netif_carrier_on(vsi->netdev);

I would add checking the physical link state before calling
'netif_carrier_on()'. Please consider the scenario that the link is
going physically *down* during the XSk pool configuration.
In such a case we can wrongly set "carrier_on" uncoditionally.
Please take a look at the followng suggestion:

	ice_get_link_status(vsi->port_info, &link_up);
	if (link_up)
 		netif_carrier_on(vsi->netdev);

Thanks,
Michal

