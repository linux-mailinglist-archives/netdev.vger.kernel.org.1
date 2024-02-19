Return-Path: <netdev+bounces-72823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8FC859BCB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 07:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AE51C208F2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96DA1F951;
	Mon, 19 Feb 2024 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRzxJhTq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6E200A8
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322508; cv=fail; b=sO1zH8KLaNEvFSd2/QqRdxLv1d6ReISyzaa0Xr79lxW0huAc5FJ2Pyf2gUg+8vdW8ou8bYqOu203ow8hhKnhGAjqXvBrop929oeSTttLupTTwQcEHFGnBskDG+q8A2qlWE5eKm1RUqR1DgJrfIJ7/dYUnc8zwyaCXtKj3KAyriw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322508; c=relaxed/simple;
	bh=eah3cd3ifO+WoExWvKkZfY18s7lfXWqVOHxAVh9fgrU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lj6B2dpaUbcEAjLxU1nGJKgkZ+aHdmGFEKE2Y189azBb2yy8zob4x5/hyDZTrzHvO038FGmtS7L0QCGaZOF0zpxFTna0SQO37dSUcNCLMm/wrPSp4krjEJPAo836OmMIXG5aTaDcRTj4VZCD5w+Gu6nVSVXO7bbiah0sYUZdl+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRzxJhTq; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708322507; x=1739858507;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=eah3cd3ifO+WoExWvKkZfY18s7lfXWqVOHxAVh9fgrU=;
  b=TRzxJhTq5KmJeOBKPhAvXtj6lVJFW9o9g9D0H0mptd7gDJSEWegbWAG7
   eQmPRJBSGmufIHYQ88YgOXAjdnF5pZ45OM/XBnKJn0qBQsEMfhuv88KYx
   8Y3iJM0N5xl/SgbCSAzjay85W5eb+YRHk9fMluG3jPPtMClixAGO33AcX
   IANjSwrhYoTBhZLf38ivWH1HeX8feO8lRXrOUmkhwGtLAGhHNoSeGRxr2
   byetsQ56JtdreDVx8SSSa+x41NNjaSXSDPHL0Q17A1GxK7ET9/z2f2hXA
   ySIhiiAsIEQJb4I2LMiODnsUxwadb6o/1v4uFBK9TvmV6nFZW1Mzpq3vN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2260031"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2260031"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 22:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="27561591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 22:01:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 22:01:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 22:01:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 22:01:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g715HLGTp5Mv1eqHAyME2yrPhM8XtMh9WVnwdCBX0ofdYkPcGb6kzl4HyihSJ9hjlCHweC7i7lAahd/a7STc5TsWa7pSiIoVe9MDTkwUaExWrY4I56nw2FR7wTEsWou0J+YdvZBPPMnWALzsojC32deaTG42JQz75YxMj/dSX6cKCeWKZtNH8Cqg2fmUtcU9ANZq6HRQnXRmbMiKp/Cvt7l6d1hg2Y0BncM/EtgRAIl/pqvzsEh+RUogrQyxMjNOdVZtd8YvS5hoMh7AeFv7JXgNt8w2vcvfQOnc9r8gEl7/zgvFuEioWDqcWnlFs9VOiOOV4EhgkitcBD993nT9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meAXM/ZQY+KWnrMIKqPuG7SCtsRmI90CRafF+RKMi+E=;
 b=KnzGwazlzQ3SlfR2R5DM5VeXzpirg3/CgQT6SMvBBlm9zAvs6nfT/si4ZJp07rKPLXV0hNaSyfKz/JZt44ERK4nGd7S2nNnOrKGsTS5mux+Nwz8OEdApZi1H08V7IdWFWIGcZJjB/bTEJl/+Nka9cpooSKW39+adUV1l7mKRcUuMvQb66gjxzvwFfWBTmYjB+8ZixKjF/3XjKEz1a+AllmFl2ZiA5PcDCi40UuWAqNA1sJtcz6mVC7b7EGLZl/dBElw77gomrz7HUdooJG7bc7C4GUG32UHfZN2qGVEtq8JT2iqfsgiJ+mp9kV4vto+BwNYzar22Iev4UmmZLNSQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 06:01:29 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 06:01:28 +0000
Date: Mon, 19 Feb 2024 13:54:32 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Ido Schimmel <idosch@nvidia.com>, <netdev@vger.kernel.org>,
	<bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <lkp@intel.com>
Subject: Re: [PATCH net-next 9/9] selftests: vxlan_mdb: Add MDB bulk deletion
 test
Message-ID: <ZdLtGPglcpI55/J/@yujie-X299>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231217083244.4076193-10-idosch@nvidia.com>
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH0PR11MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: c331d314-a036-4444-40f5-08dc3110369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IK3vDjvM1oAdI/GJe2bWWmHNWePDm9rqNmWtEe7peU6gCU1SjXBR5vfsmK/v+iflN1iTHwDiryA+p0TK89NtVWX1xrNVROT7APNOpY8b1Gtpt2ZKCzlMeQrknhsHCP1X5TP4Nhg1qRvsfwXwAQem4IxZrB3lYwTfDB+yJAt+4d2Y9997uou3a4GTefrkS6XTjQa2/qe9TE6sRrteMxQFYboGRaE/Mzf/ZhLN1DU/8MOfvNx0vpOgzHu3xIAw2IUe1SVNEB1AOhzFnuHnWHNG+FnwM48SFrlXt3weZuar4SvW+p8rT94IUvDPrXSMwMhxTI+q8SiRl5YgGsZRhVUt5OhpW3xaf5Ymr3oBjoCsQ3LpNyksgv4qOFzajG3vRlbif5Jf+azg3tvOVh7Wx/Bd1J1ryggaKQcP7ry25ylIFxqZsAsRWOpHw2G1+8TooiwvLheGGo2AudiqG06YrPBR+vNyLWW2O6HAryZy/9EtKKMLToMKv0CmfKx4ryj75K4tdlcel4IdcFTVjFOEw4DilsYcUd+WNwds9o0up4grZrRWhfGHgZxmMSjyOjBf5At
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33716001)(41300700001)(4326008)(2906002)(7416002)(8676002)(8936002)(66476007)(66556008)(66946007)(38100700002)(5660300002)(86362001)(44832011)(6512007)(6666004)(6486002)(6506007)(316002)(9686003)(478600001)(26005)(107886003)(82960400001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvOg0fGFbyUKl8T/4Van+gMSzawjhSpvJYoFU4cONZ9VZxzwyWMMwzPKLCF0?=
 =?us-ascii?Q?A5ylYukndWMRriHPcFsvGnIBa7c9BmrtfYjLUUMQL7+yEw9Ngk/S9h4b2SKO?=
 =?us-ascii?Q?IDRZJOaBRcj33N6tPOh6c0mz0345FhcRjke+/S0qnYylxMs+y9lfAYv7xrgp?=
 =?us-ascii?Q?aBiCdNttb+2gg/YgT3JUPUHa8UCUcZRVGDaLlG5HhnTGbgi17OGOwrUBNFOP?=
 =?us-ascii?Q?NY/GjsBA8u9BV1qbIFaX5VUhZFPwbrLahIeurs3QS8I+th3zR+BpWsiw4jOh?=
 =?us-ascii?Q?TqhvKU9VKYMuhkxWxrdkist0042RJcl50gHp9fnl7uicsdBPIK0nFVKqUExY?=
 =?us-ascii?Q?2RfnctpW0PZqMXIfrTzu1xuHDyc+GIkuw0+GNGzqLf7NsivgaHGhTWtzpWvm?=
 =?us-ascii?Q?VswdeEOQuBRbkf9KXFu0vxyROPdeBZTDxsRHGdHmlo5W0+4QhSpVCMCNOBS4?=
 =?us-ascii?Q?vPJKaPc8uk/E0phwaAwdJZXU5its15PJ5oNF815/kBvZe1P7QKWwac1WRVtD?=
 =?us-ascii?Q?KuikjgTvyVeKUwcciTdKl3gO/gy9EWJujk7AVeDZv1Myw30LZ1uJa07g+c3z?=
 =?us-ascii?Q?NLkcYKK+0Hg3lEStbDvjB3N7f9WhnLgu4/kW77KNnOL071ljPMURnrAKAKQR?=
 =?us-ascii?Q?97B84x7LQCdIgNABfX0ptMLGxuWWEPk189EAVNq4pEijsrPtoEA83qzEy5Zx?=
 =?us-ascii?Q?c8tto2E2aT34Qfj4K2YqwfMAtwi1q5UKhnME3xZ0hs19VP0+zLSUr3lZPyw6?=
 =?us-ascii?Q?3Sjf0TLBv7tIKMjSSxpimrVIO6h6Y+bUG1teyTDd2QnzJzWt5mBqPdCk7+8r?=
 =?us-ascii?Q?jdriELIgh4ogmXlHUaTwztM2gy3BuS3UaSwT9RV0cXZgp23Taoottag7CxRp?=
 =?us-ascii?Q?GUksT366XmhvG/CqPSLjTQ7Uri4APy8sqEdBru9k8AteZMIaaoWK/98c3Atf?=
 =?us-ascii?Q?XEONjHwoPZSD2OsusOBdAoWeDeqRVEwdAGJ9Sngue1MTtQeoViIo+OAwy2Sc?=
 =?us-ascii?Q?fGIhWA+en7XzANdA4fqM8r+mozVR842fabzpA0u5J9gAHH1ebfVZqoBR1Sdh?=
 =?us-ascii?Q?Sv566E7ilsacdgOdUoRNhxCFMsBky9kMihTqoeTFdfIV7b5gfwx/CdVAl1oc?=
 =?us-ascii?Q?2bDBZWXFE08a2iuEtuZi3qHUxPWkkINn4ynB839eN9uvXn5AvwIhFoDhEZp6?=
 =?us-ascii?Q?p6nMTV0TCCkupCDkx5hBSSklxDekPDslERhFwXOWoNo//YNuHyYIwvdHSpvy?=
 =?us-ascii?Q?/cxSoauCSWLZXAduJlUAexw5ghZW1hyuOjtY3U4JAiRft9dtaN0LQgOuQ9tF?=
 =?us-ascii?Q?XAM8IBxI8QWy+5KadccK/HmSFFuqStG+5aRzdgmbFsHICII9LlB101/V4+Y0?=
 =?us-ascii?Q?1bpmXOOqTg3iJ15c/lNnJSnwYUVJ7FBDqQzOKu8/1gSM+lBH6L0fQUQUYXNF?=
 =?us-ascii?Q?GnWR4oQ2NOKccgKAsCyMAkx6nsVXktASkBb98+IWETPOmEGxM2HFHOepOgpi?=
 =?us-ascii?Q?QLW56h6m4fiL5aab3UUL+PTruPccdgYJWDCaDkkUGYVWAED3Wco3bFwIWIbD?=
 =?us-ascii?Q?+xuAI9scaM/6DkslTIl5cqjHV9Llm9MGgNSQwAoe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c331d314-a036-4444-40f5-08dc3110369b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 06:01:28.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Skagbxfpk8Cb7ld4jEJkHFO2Tliej9wyTtQ9LkngQTxXOyNHEKp2RKwj4MJtbJEHzc6j4Frde4k6i3GvZQ8M+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-OriginatorOrg: intel.com

Hi Ido,

I'm from the kernel test robot team. We noticed that this patch
introduced a new group of flush tests. The bot cannot parse the test
result correctly due to some duplicate output in the summary, such
as the following ones marked by arrows:

# Control path: Flush
# -------------------
# TEST: Flush all                                                     [ OK ]
# TEST: Flush by port                                                 [ OK ]
# TEST: Flush by wrong port                                           [ OK ]
# TEST: Flush by specified source VNI                                 [ OK ]
# TEST: Flush by unspecified source VNI                               [ OK ]
# TEST: Flush by "permanent" state                                    [ OK ]
# TEST: Flush by "nopermanent" state                                  [ OK ]
# TEST: Flush by specified routing protocol                           [ OK ]
# TEST: Flush by unspecified routing protocol                         [ OK ]
# TEST: Flush by specified destination IP - IPv4                      [ OK ]
# TEST: Flush by unspecified destination IP - IPv4                    [ OK ]
# TEST: Flush by specified destination IP - IPv6                      [ OK ]
# TEST: Flush by unspecified destination IP - IPv6                    [ OK ]
# TEST: Flush by specified UDP destination port                       [ OK ]
# TEST: Flush by unspecified UDP destination port                     [ OK ]  <-- [1]
# TEST: Flush by device's UDP destination port                        [ OK ]
# TEST: Flush by unspecified UDP destination port                     [ OK ]  <-- [1]
# TEST: Flush by specified destination VNI                            [ OK ]
# TEST: Flush by unspecified destination VNI                          [ OK ]  <-- [2]
# TEST: Flush by destination VNI equal to source VNI                  [ OK ]
# TEST: Flush by unspecified destination VNI                          [ OK ]  <-- [2]
# TEST: Flush by VLAN ID                                              [ OK ]

Refer to the code, looks like they are different tests but may print the
same discription:

[1]
	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"dst_port 22222\""
	log_test $? 0 "Flush by unspecified UDP destination port"

	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
	log_test $? 0 "Flush by unspecified UDP destination port"

[2]
	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \" vni 20011\""
	log_test $? 0 "Flush by unspecified destination VNI"

	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
	log_test $? 0 "Flush by unspecified destination VNI"

Althought we can walkaround this problem at the bot side, we would still
like to consult you about whether it is expected or by design to have the
duplicate test descriptions, and is it possible to give them different
descriptions to clearly tell them apart? Could you please give us
some guidance?

Thanks,
Yujie

