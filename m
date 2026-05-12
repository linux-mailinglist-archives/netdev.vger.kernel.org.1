Return-Path: <netdev+bounces-287253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIE+MWhiA2oq5gEAu9opvQ
	(envelope-from <netdev+bounces-287253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:24:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33A525C72
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCC1D301485D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307B385D85;
	Tue, 12 May 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="le3ntdjp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F389385D74;
	Tue, 12 May 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605945; cv=fail; b=NwpEdHO4FN+bdwsYseBpgICu6pilEvktJVpwDisdPU4j1x7IAqGh4tB4Ppf0v8eXDHuD1n3UNXsAoUT0g1lKWgMDL2OV5cvnJGJCK5CpuXHMPuF7wAyCbzzVXnyalyLuTf7xkKchuVUNxj3RGHNEurPTfOzoFbW8W+UlBOy7aIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605945; c=relaxed/simple;
	bh=lI70M/11mpvA97HKCIxSLWd5YOFSk3zkTQzvE/gNyq0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SljR1FuYbZYyP1s3hmpXsNdGmfezpus4UZUTa71JRu6wwd1kGHT6bGiKElu2wo0gaPelomTRBZs+Bs3xKFdMJ9xGEeQC6Etj2ug18d6vTkmPCIGkZGCIFRvkSI9FPas+LJQ4vVkS4cc0tbQtBahHJPjFBiFHEkTkXnDEhai/Wlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=le3ntdjp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778605944; x=1810141944;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lI70M/11mpvA97HKCIxSLWd5YOFSk3zkTQzvE/gNyq0=;
  b=le3ntdjp60Ds9Q/qb4516q+nluTXF8TyQFntqWV6lg3LBUFXWUrDA4cJ
   YaDswoE0FHI5M8CQv8QWelX41gHgYocOKTpIjzhucbUkWQQxs8W5XS5H7
   Pt34tiVIMIJ0UBlA4SS1dPnOlhgF1vKb9n9QKFCo4jAj7qENM9mH3eLmi
   a07SlyKqL221AJJ9rNn4rhZlldFFJwjkDMEL3nk5AC0V6zIX1Qd8F9DzX
   Udn1pJjZLruhv5yEY7iiNo46ZdK7Nc7tbXbD0CPujt21gfB80n//v9suQ
   MDDmsZtdZV5+wJK3HwtnsJTAmmx4hmSPa939CSE1ZIjGj4T9iDuoAbPdJ
   g==;
X-CSE-ConnectionGUID: fzqy/bzrQ+6bhHlgN+Cc7g==
X-CSE-MsgGUID: 9bgMf17SQKiS7mF/cQTrig==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79378316"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79378316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:12:23 -0700
X-CSE-ConnectionGUID: w5gSLbXrTVK8WMN2xf7oGQ==
X-CSE-MsgGUID: bUk6I6PeQsyWkrb9Ewr6qg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:12:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:12:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 10:12:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 10:12:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8JLcOLqKHS8SFXAbyM1hdiHCtso6XP8MB17jdXX35qnfSIWOwrnN8IiU9koLrb9mhhWE0ZnrLAFe6eBqX2b7Afab3F1O7gNiCUFg7w5RGUMCCuFp+UlPp71h3qLexNQCwSv90xoam5m3C7RDXxKvuKs/hOo0zM49im3KY5v20xwLMFiB2VSFumD2ueooqogbbXVdMPR4nORPJfO9nr/QkDcyjfGb8NtWFzdx+pl2vh56NHlrrpadQwmWkZsh10+myBfP3gbjLRK0HS56rtroCwnBf3Gvsw70swjyIq27eYz/+sZohglXNaJaakv4SDIod/vqeXk9AaQtUwjMJoT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwm+Szihl38LRM5yT6fMYsxt/voLMHFRjmRnOOoQyaQ=;
 b=BSAvidfVPJlFdDTNyYMXlGgtRhgIQ51PPYwZ1rbo9jwnTVSQ8nrcsKQ2xJzCXIC3JmwPa4+d70iPIVtBLP1rcLYV7xSeK/eBNoyFR1UEEwVs/i84gUF4FHSbpNXMi34Ze8bFOj3GoLa+rKaGtLSgAv4kAm+15gm1v3mPs5dql759Tczew0oEsIMdSX07ePZ/q9ku0yU4YuBfB3jpJb0KG9/REwAMvIj6xIuv25j9ooM5Ym1cA0lq450b9F8SEEtWPYNmgx+iqClVr/crX8RFIULsojZ5Ui8IkhQNZan0FmFDSCoOHG/G3hPkf9hKMW2oJmoxaofDnocNwkDgmNFssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 17:12:20 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:12:20 +0000
Date: Tue, 12 May 2026 19:12:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <lorenzo@kernel.org>,
	<hawk@kernel.org>, <toke@redhat.com>
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling for
 veth
Message-ID: <agNfa6o9X5OYKH05@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <87ecjgkcs1.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecjgkcs1.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3c48c8-1f10-4cd5-baf0-08deb049a01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NWWiJrwS8VXo3QxUVgjq90ofpjfYgyjJVZhN091V3JC90eljYd1DTbcsMkmt50w5OmQe3jJICiuNRe6cGniujQoSHhW91YZNMAXFo0Kh/drQkTmA1TX+ZhR6w7HK0v44swvAxqXJzQJ4cXeTUZI2gD42wJ6Rq6jJnDaVVuogqjY9N6UGRZ9WEtXJgymk3RhThLp/YRubr6yulZ8jNhoTReT1qqkB7yJ9dai9EMX0Y5FMP95hrY2Yb+hD/wuFCq0emgBBXC8HV5sib9D/gefPTZ9vadDd8rxgr/4wx0OWwT+lBilNHt9FbdjJBfokfUteBv/dGKRGsjv/wcEw+xKuhY2wR7JxCgkqBVryZA3MEEbg8lo8it3Qg7ykdb5tbhfDT4DSt5ZzqMSIjJnuaDY1X1j2GCz+tvNIbzZG3d5U71JicnckssMxQejaDxRvUUiuVcxmtXQa+BZCe3eJrcY/Up+cZBnY6bs0sz12oBZDxz3LGv+NSJSC0mycWGCMmZLdqOINKe8ZejIcWFGKk0FJsUTzLGStvQV+qdqwnSlZ+dIXhWr0FC01CY8OR68JEVRx1djB5xMeVs70VwQS4p2HKTtUkSv/4Y/eqymG0ZvVCoc7nFK2ZA1Q5OrND0DZtCc2Qww5PeSLJXx+q+Y0vv48My2wUQXG/PfwdYeDBjq1mt9t+ObpE+Y1EXPtgrQmvGk8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zG9Oi1Rn9sRvBdXnzJ0IoLwT9516E5CLb4NfhCOvOyBhc5EJ2n5t93FxUR?=
 =?iso-8859-1?Q?LXBqRFit93wUqJWiyRAAQ4PsLncwAEVFEYZq7vpHJKBaUP5D+MOe1U0cCT?=
 =?iso-8859-1?Q?PxTbbt7wVrIySYsoFGRw3u6/MmMLvl558FlkwEOxFrQeKiughAMeGbMaIf?=
 =?iso-8859-1?Q?YR/80uYsoXS7lcTqLuPkWQLbbjpWfWksxLVjOIv3ztkQGe6nicX5zb/HOR?=
 =?iso-8859-1?Q?Ga202nKpGz3rqL6Uy1FyHTvATEAhWFFtUgk8wFuQSPTuqkN4sWeG8fPSWZ?=
 =?iso-8859-1?Q?r8RQWNd/0KuXd1Lw8qxVNQ4jyl5azisNsaofoVScYmUZqqPAOVen/M6ZT5?=
 =?iso-8859-1?Q?IMvFWVx9Pu/V63uQpN/n6ib6BjTYvOd7cLAdD8/Noz9vvbCe5Uo/6ybVqq?=
 =?iso-8859-1?Q?WylBPDURHvVWq0mzgKyKl6opoj3bkZlQBs7pAI3Zt5ts07ssha3o7y0b52?=
 =?iso-8859-1?Q?xJ5IFOpc3WqFzjY62P/Jlb0P5rZCSd5fdMFGPXqjMS+YEbl/ikmkSd+B8U?=
 =?iso-8859-1?Q?u7N1xWVzbi0hBTx+m57Pbfk/e1KUVRLqlRt6TZx32giSWgpTdLzfngwSQ2?=
 =?iso-8859-1?Q?9E1lMylF08Ldk8ooM9/32Jw7BDYV0q1rImInSyrEegWzD1uDwRPt/+Q6sX?=
 =?iso-8859-1?Q?+pJwsGDvgWftoejB0jalZg8vLjr1oEFSyeQXvy1obd1gFdjdowKapUaVBo?=
 =?iso-8859-1?Q?BvOLDauXl26ANgvXk+iclfiHpX5c2f6ifXUgXlHwtgLGtH6dnTZr0WZUH6?=
 =?iso-8859-1?Q?04QO21flKygADELf625Ph2mXTa7yoq4KZG5eeRsq88ayYL+4CjuSk1R2bk?=
 =?iso-8859-1?Q?EwwnTFYU3o6Zc7IbDCW3b3L3dl7NTnLEGjhXT88IyQ1GFv2toJka4pmhT9?=
 =?iso-8859-1?Q?1EtDxhMWIGqBoZDpEO/H/DpR0CrcWzEinYHOT8TA8ofj6Cn4z7A1d3az9h?=
 =?iso-8859-1?Q?pvLgq4PSD9Snh1l3qmrR7bQxhhfCxE+nIOaO1QN9jiuDeiFllcmosWm11Q?=
 =?iso-8859-1?Q?HaLyrSidyEfBcHFP95WJPI2bBh/A1BamUwjTo0oD9i/xLx1DYZk0ewGdf0?=
 =?iso-8859-1?Q?9mRyj93o0TdGJ29o+0u325ZrMBRqmQ0ZpnCzJDI7rVHKHuHnAcuVwCODnT?=
 =?iso-8859-1?Q?INgvgenlSmw1Fgh/Rh2UzcB1N2CIFJupZimKSjiMm1U48SdqNItLYCQi05?=
 =?iso-8859-1?Q?pTUthMOdcgkdYOCjZXne72Tw3GhdxIi4mzFp2Cq8+GHogpMpboiSM82TQ4?=
 =?iso-8859-1?Q?VEL4GZP0BRtJ8OMYZnigonLT3NCPuMF80U6luJFHIV5WYsGuBbiSYSeIBO?=
 =?iso-8859-1?Q?+Ql/BSPaDtlKYPtdcWFb1O5dUBg1kmew3M/VO1ReOtj3nr2M/2FdO6CkhK?=
 =?iso-8859-1?Q?lA+l/z8V6osm17c26EUKorbJ0hfmSYJj73dQQoXuWZozHZpmQbcArKIX98?=
 =?iso-8859-1?Q?SfwOuYiOUPIlUBoB7s03KY0Bu27eSJ+3dxBtxVxaQdOJ4s3rbLZ3kvg1kE?=
 =?iso-8859-1?Q?wmnDXPG2ymmfEwYNGp74a5gdIwHiyZZf77m7RHf6o2ifqppDO6gshhS/go?=
 =?iso-8859-1?Q?XQAjobv9yyYmd3PCG9aQL2MEjrK0YmVcOEItOw/nYQPQZaXQH2hvS6iU9I?=
 =?iso-8859-1?Q?LmBNKP1BhabZsY4EvZSDQQ99PUFQ0zSRKgRel3Z7Kw2WhJzC/+lQigOZnU?=
 =?iso-8859-1?Q?UbYEQJe0RE82dxHprbOnRRY0hkNLEmJrD7iFoRJsLg9cZrWweKFTDR7/TR?=
 =?iso-8859-1?Q?VWKhCEUNgiU9TJMkzEXZUpzlenRnvah8RpaBQncERTrR8sqdTrIhRSZwRU?=
 =?iso-8859-1?Q?0pfIbiwPti6Z9olP9HujAO74z/rni9s=3D?=
X-Exchange-RoutingPolicyChecked: e5C40dHk2CLP2pDv0Rh6HVQBizMKF3WzavKjIlsaEaB9FkZ1VQ7Hes9IQGFIi7lujX9jzw4pKc3euVSAL+VScxLiWZQR4yX7Tj0sH9elOCEvhX/7yE+z4+rEm89v56N0Q6CFZnp8nF8cHGUOTtuwsna6D9TI3tLmH8CMgFKizXATIrGgQh3xaELHcTvPM6wrfR4+8FRDMPcWP6zZd8zJgnG/1YULPYp4Oh6TGDNRld6SDcYM5BEQ0ZLuAdC3COb8/GyEaQiS/Dwaql1f69YXF8nZASfS5SopvDpeP4mCUzgvM661EeFsD9CF23lgX09cONEJzv7T9xl60T4ee89yXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c48c8-1f10-4cd5-baf0-08deb049a01e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:12:19.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaOW8GEPKehTL5JjGrHEiwbl4ydyehqYF3ku5jBv+Ibx6Zzf6cksypWSIPjFe+EmZKWDcSdv6166p3R1JyuIiyF0c329MRUzkf9Felksizo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1B33A525C72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287253-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 02:55:42PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> (veth XDP makes me dizzy...)
> 
> > In particular, let's discuss:
> >
> >   - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
> >     skb-backed generic XDP memory that may be page_pool-backed after COW
> >     or ordinary page-shared memory otherwise;
> 
> Let's start with naming! I'd prefer making it more explicit:
> 
>     MEM_TYPE_GENERIC_SKB?
>     MEM_TYPE_SKB_XDP?
>     ...?

Mine variant was ugly but self-explanatory...however I can change it, no
problem. Other idea would be MEM_TYPE_MIXED ?


> 
> 
> Björn
> 

