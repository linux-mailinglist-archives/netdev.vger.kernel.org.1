Return-Path: <netdev+bounces-196572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D812AD568D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D85E3A1F63
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E725BF10;
	Wed, 11 Jun 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+vXbF9r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7651E485;
	Wed, 11 Jun 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647441; cv=fail; b=kHawXialGlIWhMfhekwspKGXjTg3XA3yKDxNAWAECP933OoJhRVfdgMThklx5R4WUwuq4ve0kFz3zliQCvAfsc2t+J5KLzUXhl4qVg4gL/mzftauMIrYVVmld2Ds9FxsJ/NgWnjMFDeMVvwsywROibZSH9MQK1t6Ri+grRT6z1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647441; c=relaxed/simple;
	bh=ujr776F64vU49cNJ+6Wt/jbbZffVl42vnf6ThHQ24Ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hz86cq7gmFkQkdi3g8k5Nd4Y6sDt95eif38Fa8i9RT5pjs+fisN1UPJrgYXl8lRQOoxw6ymfqd3sABKxC9/dzzsLKQnPBb8XO9Blwgb69cH/GjM5CxtVcbwV0OhRmUssoaGLZFdF02oZb7D1KyK7UigSi7EM5SCulkNsiwh9Qes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+vXbF9r; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749647440; x=1781183440;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ujr776F64vU49cNJ+6Wt/jbbZffVl42vnf6ThHQ24Ao=;
  b=Q+vXbF9r913tin5XY8VfrQdKaiBSj/ujb5/y0aCLGlX3KsAuSFl3O2vS
   SEu39+NU9AcUcCzeQQ8KsVbf9B7vKzmyYi3bsiiUQrItXdh+T6u+VTlit
   HoWA8QRJswBPZ7OYucqkKb/SY/kLoBk5j/TeK7WfEc0eoUG10E0k87cVX
   ig8K4zpQsByTQsrQA2kfcAwXuG9FdeV5u5Tyg+EThZNG5Z1P9M/1AK+Zz
   fzzdKENykfjg+jmyhdAwMP/qIx8hHxbZv/FpPVEAch9mt730y31BuDFfu
   yeWo+3Ww5oWuCBt7xlTYmBqvq1E0ZNTaurkWCG/2lwmSqON8B6CkFc6af
   A==;
X-CSE-ConnectionGUID: vfN5HHrLRLeBB4yRTEDWmQ==
X-CSE-MsgGUID: 7PHGXDyxTzSPezSR4eUEnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62069392"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62069392"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:10:40 -0700
X-CSE-ConnectionGUID: F8LZMZnrRfyv9SOm+jmjCw==
X-CSE-MsgGUID: +8NRJXJRQ6+L7ia3xinTGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="148104582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 06:10:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 06:10:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 06:10:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 06:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV/PdTBD4/DZTE0VqH9XPnCh9mUAlObce3JZBSnx9oqCYtSsRbRRksIKEbB8bVgdHK7yF5DCC/zqH3TiCzJ/fIlcwRZ3LAg/3TqsiOW3wfXNP23l88VKWA1lSr5fzRt+g46AM1MMaPvjyph/7+oajNf5OL6yBQh0+8VGyp0bSkoM1ii+5w+fKwz7NNVUptP3tUO+mLb63zBaZgaavZb/Z1u/1fk6JGp93v3TPsrGcd58ndOIAsfNui4NLy3VHfyYj6+SmZihB0KqSM7g2w2MuUoihGk/5kvEyOt6NUQHN3Bb/Rwj9/dATytDd+PDyR7xKCveRPA3N692V59IYIrFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHPne2X3zYxxQKNxtxBArsLlgq+ctGVbkm0peWfUbJ8=;
 b=lpcVoeyHwkJmfz2UX9r5iujyCNFgLK05dIrzF39dG4lOFeihT0soiE5UWBnfHdsWpiTV2+ShOX6xrHwV2/TcVqPVmzNwx9wJDXQMy0y77DFrXrE+jbVzDy/Lfh362XIu6MkkCRH0we0gZtSrqnH7vFhtqaTyCPB2PABM1Kk4YMM3/xJKStUDTpO0rfNudPmb0UmRkgscsbeK8Mg376Ba6MZ9mB5E5PIMNRyQUuqW2vzvwZPLV1CwU3ATnoH/PfT/uvJ70HCvXpsOwE1k/P8ZD3Z0bxJ7TMOGKqRBAbBvEKWFda5+TpC69CPocRWTRCVu4AVTJuIPrXzzNsM+vQ5Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.30; Wed, 11 Jun 2025 13:10:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 13:10:21 +0000
Date: Wed, 11 Jun 2025 15:10:15 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Eryk Kubanski <e.kubanski@partner.samsung.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Subject: Re: Re: Re: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment
 free in __xsk_generic_xmit()
Message-ID: <aEmANxmvCLMXdQpi@boxer>
References: <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p3>
 <20250610091125eucms1p3b7b0b19a533caffddce07c75596f3714@eucms1p3>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610091125eucms1p3b7b0b19a533caffddce07c75596f3714@eucms1p3>
X-ClientProxiedBy: WA2P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: f745ad14-1e9f-41b7-5064-08dda8e95209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sTOa95SuYNVqYkfftYf4g95ymizfJr68kGXbapV1t6W9pjzlVyw9r2qg27?=
 =?iso-8859-1?Q?nmovY3ZjYa+mEDe8gfqRFYZSVFTiCv2rlorzP+XO0V54iuUJIEby5HY9Tn?=
 =?iso-8859-1?Q?KnfeowVHR/rbB6fSpM2+BAEYpJkIKgkjx2KKbSwJtjBfRrVWpoH/FpP1kE?=
 =?iso-8859-1?Q?NcqcjQGeyBym+D8ZPiYfhBP9W5Hea+5Rct+/kk5cfgv10gW+PlEqshR/cD?=
 =?iso-8859-1?Q?O8e6r8/mQtlocVSTRtm2gVcJN5GubhaZzMNX7VXw5wPX3eAGVxjTDJ4+dI?=
 =?iso-8859-1?Q?9fyDeFGP+tFmw4A4iWV9SJ45F11XdGzQY0L6PvZ9rzqftJbPaZH3oFHHSN?=
 =?iso-8859-1?Q?egKPNE9gWZuKnOo5azzYclUdWbg5DDCtk6gIT38m/wDu3JOkVP5L5E2JFW?=
 =?iso-8859-1?Q?x6For8TOn54oGA/lSEM39xHbifwP4gZl3/QWd9Zm7oAOuiN5OI/wBNvO+B?=
 =?iso-8859-1?Q?y4WKdi6xeGKGZwlR2OS9DCX8RXJJoQ55UVe+Wera9MuDJjlRY6aRG4suhR?=
 =?iso-8859-1?Q?FX2mi02+BMSJ2UPiZi/a//GbRa4akgA8/+oL/IVPP6p0V7/W0fAZfJaCKU?=
 =?iso-8859-1?Q?h67rTGZP34waG6L+WMfeBz9+JeETh+ISIJkPTurLeKUk1eM7/FH3T9W+iM?=
 =?iso-8859-1?Q?Nl6fTT4JmkKsrFRip9M69hj0ps/BfJ/5Ywb8z6bQ2Xci+r/uBQOb9b+RAN?=
 =?iso-8859-1?Q?5CuBlldQ7LNyTCeSZcQE2F41JWpDf9HhrH+8XAlcmuP4OHOLTq/bjV8gRS?=
 =?iso-8859-1?Q?WCoB68bKLCuX1h9KNcGa9wRc+t1t6fOSmhjmpZTpZOGcC4fBnvhBHGLgqs?=
 =?iso-8859-1?Q?ziCRV+kZ7LsRDdsQxsOd3qRpV2Yv5oZ+XLFt5iLcUy8mncjGeoWIgsuCOJ?=
 =?iso-8859-1?Q?cuqTgu3clDYQANHRuHDe/WCMRCKZewt8is8FibBhAz1cq6YImSet31o8Aa?=
 =?iso-8859-1?Q?DavlelvIideQ72+UlMrqztwDMVi/1EFtmWdLp8BRixgk7+dl1dT3V/E0Pi?=
 =?iso-8859-1?Q?FRC3fepR6uB4I43//uL+ecgTrW2Xh3kUhr/Nfpn2lDes4k6QDoSFH2mD0X?=
 =?iso-8859-1?Q?/dqqUbtacS3G2kctZLrJe6wbrK6WmcCTPE80Qs0/LoLrLmxxIAMrQDluig?=
 =?iso-8859-1?Q?DuZyW/N4dpm5z5FD09JgH7RtGs4qpzezcIuOMAbIlzpyxuPVmO7porXI+a?=
 =?iso-8859-1?Q?0L7SXgPbt73TG2aJEgUuEQy24tTIEHztsb5DLZWhlD1w3o36MsA64KRRhJ?=
 =?iso-8859-1?Q?BRihzkpIE3WcxxS8Z1z7DzB0jwdvDQPbfPnvLxgcJaw/7neYzQWKN3qs95?=
 =?iso-8859-1?Q?K6hBP/J8yumdQorHt7v974RV+Owx2exgOWU57bZIxlBBZWXZvbbkQWNQgO?=
 =?iso-8859-1?Q?bwrl5ghwVMlo8i7shTD8nqDFbhOYq6/UGq7vVh3en2/pfAyWvFDtW1j8TZ?=
 =?iso-8859-1?Q?sc5zsuPuctTLxs/DRhmd+cqMJnC2lEOSn1FSH3+phKQGK5zuFvxTxlDh6O?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qpqSxILcEZCS7sp0lWWVLc2hWI7xqbhlHVKw53j4mDuxOcMkkX7kQd/pZd?=
 =?iso-8859-1?Q?9RFbRLulfdgqeLYhJ4EhmNNrMhfv/pCzx/FwwMH6tQGQl5bMv11QCCIem1?=
 =?iso-8859-1?Q?SrG3zeVsgegbp1FA3mJABYJwebOsEYUEQQljpSxcS6gPCO3LhD/mpWP9/i?=
 =?iso-8859-1?Q?AZTHed4eZQgtaPzWfg8w91TugdJC4ev/Zwa2UHOeVMD0iDE03k+vh5rfKd?=
 =?iso-8859-1?Q?7TGtv8ZhttMNYqFXhDQ25ji/0Ai61dtlJsyHT3fREjCbtxllQfDCWukiG9?=
 =?iso-8859-1?Q?geCbnLm62Jhcaw8DRm1Bblhf2LFAIjs9T6UfEU9rDBAWR+SPpBISMia/py?=
 =?iso-8859-1?Q?Zh2CctR2NC0CW/WyuQUqGa7Oj6tH/rBh1ExnSSYTG44a3rCnBFvwEDmOn+?=
 =?iso-8859-1?Q?htOoJh2Ml13Z9jXudTF4w3oGgWbUpUb/kOFnzlqtd5ko5koDt0EVbzbO3A?=
 =?iso-8859-1?Q?pYS9ntuTsgaB4jQ9yGle7iuIhAg+SofIe3tmWNEnY2d4fQiTMruIHk77JS?=
 =?iso-8859-1?Q?QosOl9lXpdWH3LKGco+fj9IuXFNQcFUg5AmZubuWFVSNX46W9az8nK+Btl?=
 =?iso-8859-1?Q?3CdypmGIARu8UtBeW92Fcwyo9PZr+hSfZNfSxjUH4Zuy2j0EbM8RqvSLYL?=
 =?iso-8859-1?Q?Ehna4Ilt+mQyKQzeTKRTckHSRGCBGLEU0T4eUrpUKNIBTyG4PRwIjpAu7X?=
 =?iso-8859-1?Q?+2fR6lpnpXKMgt8dbeWZ40t/hCTP3/eZ8fGn4g+qgYCCdwmThF1yoV4WmN?=
 =?iso-8859-1?Q?iXcqbglweQb4bhOcHw+hA9rtPS8oDQ4/9zc7Q9v2mdjY9WvdqNxVweEPVh?=
 =?iso-8859-1?Q?r+UAt5UhwkcSJ8a0Mv4KMAnBxRoywEjhJvkFeMw5/Kg2tpxVWQRKy7lfdC?=
 =?iso-8859-1?Q?1sAuBFYx3hvDO6zfa1chXFw7Moo5Y6s9/8ok+fqIyDhc02eDkTVjaOP8uT?=
 =?iso-8859-1?Q?NoT4PBiSzWzGzgB9UZmpXM5EHo3cAAeRyt2SVaI7JKON/wXxfWnT/Rkvk0?=
 =?iso-8859-1?Q?2owKyQrD4xeMI34jMy2Qzzv5A4rCqxlT0LtkJEjz2MT44YA1zbbmOCCvsR?=
 =?iso-8859-1?Q?sgTFXYvjy7/DGc+jHHWC8nYggt63g3Xrd3yOFb9OJ89vMQpBixfc41Cuhy?=
 =?iso-8859-1?Q?YFpgUdjJ7ghqS+4qgKjTnvjEZ0UT+AQK59INXDE/2U6zWcRIPOOOaRSbpF?=
 =?iso-8859-1?Q?pfGJLlUsNcKOS5BvT5yDWcsYoy2LD9zCiV5GNlbvGyCovBCQGaAuDcYBqo?=
 =?iso-8859-1?Q?rWeZS94Wx9jcvzoJyY6qpWUuzGc5sXaIljslrQUe9/+K3Nkgtq5FM6w1Jq?=
 =?iso-8859-1?Q?osJIVWIVtK9TL3Mru7obDecvqnwM4pGA6z29dCevV0GUUpMVR23e7jGelU?=
 =?iso-8859-1?Q?aYMjt2VTNH37VO2/Gk++pXBzbjCnvssx603+cAFxQgisc7rog2HqdNorsK?=
 =?iso-8859-1?Q?+i9JVn9L/NDYGFGj6o6eyRABxrlb+HxTg+fMYjSxXSeBZ4NiO33uwE4AUy?=
 =?iso-8859-1?Q?HkAN7Nclq/kmca9Fe02hIjvBZpdmiGLOGQV+t3i9FerUJxt3Jq1mFzI5pZ?=
 =?iso-8859-1?Q?Chm6nHDsQ6FAx/Umm7M0kAiiby0A1U5E2YjlOBqptUkBBeImpCFMhRVzFJ?=
 =?iso-8859-1?Q?jdx+yFYln6lG4aRPRPm55qOvHz4yvTZ6ylfSKDiMMIGyvvm51lZj4xrw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f745ad14-1e9f-41b7-5064-08dda8e95209
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 13:10:21.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLJBgFWk1HdK9QLr8sTeMfehVtprgiWD/E9y07Gk5edDhzxNSomTY7YE7kjq6U4p639GFEpN5xESaBZyTc7SZe4LOPaR+t1J/k2TSqeAYD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

On Tue, Jun 10, 2025 at 11:11:25AM +0200, Eryk Kubanski wrote:
> > I've come with something as below. Idea is to embed addr at the end of
> > linear part of skb/at the end of page frag.
> 
> Are you sure that this is safe for other components?
> 
> So instead of storing entire array at the skb_shared_info (skb->end),
> we store It 8-bytes per PAGE fragment and 8-byte at skb->end.
> Technically noone should edit skb past-the-end, it
> looks good to me.
> 
> In xsk_cq_submit_locked() you use only xskq_prod_write_addr.
> I think that this may cause synchronization issues on reader side.
> You don't perform ATOMIC_RELEASE, so this producer incrementation
> is atomic (u32) but it doesn't synchronize address write.
> 
> I think that you should accumulate local producer and
> store it with ATOMIC_RELEASE after writing descriptors.
> In current situation someone may see producer incrementation,
> but address stored in this bank doesn't need to be synchronized yet.

Hi Eryk, yes I missed the smp_store_release that __xskq_prod_submit does -
magic of late night refactors :) but main point was to share the approach
in terms of addr storage.

As you also said IFF_TX_SKB_NO_LINEAR case needs to be addressed as well
as it uses the same skb destructor. Since these pages come directly from
umem we don't need this quirk, we should be able to get the addr from
page.

