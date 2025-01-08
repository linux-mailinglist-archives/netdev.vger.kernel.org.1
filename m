Return-Path: <netdev+bounces-156452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763CCA0679C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAA4166D60
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE161F5437;
	Wed,  8 Jan 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="JUk6LTLP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84D1A08CA
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373310; cv=fail; b=g9MvAKCd1i+cmbFNx2vvLIVj8cHqCNoAm+e8B82240jV5IvVISEjnRsA431LwRKYSUtJUo5FWlRJ6cH6WP4dcShYBI5cT30jbUlIft9vCT0xwwZHD9q47VR+RMO0qPpWd7ZT+l2ZW400VGIYLA53kaHnJ4KiTgodOyVsyRzv8ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373310; c=relaxed/simple;
	bh=ML1QrRI2mZG8KaPG15UPOn8ttRUYU174jfw+YkBwEWc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b83u6rTRKVX7lBc9/4xNh+rdoqh30B/18x3QznApXpS3vDKfrSvDfJqpynidIq/OCBmsx5x35Bfeu6QN5/Ic7ifM9l7BTmfieg2hyc5+1Ia9wuQFZ2Rb6ifubuQ1N1D2JSmghfiSeVyDmUzeHIzmYUz0Qt4GRY50xBIULPoDXqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=JUk6LTLP; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1736373308; x=1767909308;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ML1QrRI2mZG8KaPG15UPOn8ttRUYU174jfw+YkBwEWc=;
  b=JUk6LTLPg+O5i95f+zKUxe7SfVRZFByhE0/AUoh/EOex3nRM7m9vS9g+
   XLdxBQ6ljpssKwvi3E1ps0fxI8+/cA2u0EfmBpJC58jL6ET3il8XrxQqM
   AQ9NhcljtyUulGe44mKMLFymjsZMgzhv3mfHGI3KdH3+yIoaLBp7jrZSX
   E=;
X-CSE-ConnectionGUID: x6f0CXz5Qt+cnK8eG4+O9A==
X-CSE-MsgGUID: Y8D63JeKSaqmrPDM7O847w==
X-Talos-CUID: 9a23:4svGMG0uZgjK+T8H7AjR0bxfCp4rKlbt3irpPwyzD0U5RZLJCnjB0fYx
X-Talos-MUID: 9a23:baH9+wZIRrxuVuBThm/A2mpAOeRT6r2rEnghtMoh65XbKnkl
Received: from mail-canadacentralazlp17011052.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.93.18.52])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 16:53:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZtRH/OsjFHHui8CGy2rhNMo7Kzid/pZS0E9ST25f3hta6Bs3oUEwbCmRJJdFedazdD4lVLeDzUJAgTMg4Bfbcar+0cH6Nr67R6nwIL8VLBHrqcuMykdwvl6ats72pXcMsbS0P7k9b05pI5Gyol9UqP4/zcb1Lcve9dNGTo6Llc7f/7vX2KVXod5oGjox0nTpqXVLfWrxyfjXgoMYt8QI7WDTKdIRdyaHAh6kHQUir2ZRV0Lwd+HuSPQZDyh0fmSazOqhJd2K2Sc0qeJIaAlzkCwCv4b2LAHB7Do4UasZFs9dqNZJ1Kg9ovwUrdxk7zl4IO62DdeVkHswG72DY23Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV+se2Tq6LNV0ryLaT4Sf2cIvbdBZ5JZvDoCiwKuw5k=;
 b=sEIGv2Ux/u0mRPJttzN6gK913AjSxdjpqzbUyqOK5L/NLwK26UqFWiGqRHqxF3y+ABIwpEL9Im7wQ+wKvs7aNA2Dzc735s4/kOf0XH+kOioPS58VSfnE+EUxGNUTPgZgiYTKwD2GdqfMYbtf7TGuzBfYRzXdSZX1UxnMTy1Dy3/FrCcW+7kvDLrHAj96X9eFJyW1+eQUGucVs4aUKgKhB209aJHjJ/vjO0VDCM25vKaQNlwG5grSWEUJWLIQqsBC1LwqOEUyygzktLvweUQgOq5h8YVeKh7nrqjcP0PtaUn+8xVO7kO+YDJi3opBdDetsYGcr5FOL6E8zfRlxd2vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT6PR01MB11329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:124::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 8 Jan
 2025 21:53:58 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%3]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 21:53:57 +0000
Message-ID: <5971d10c-c8a3-43e7-88e3-674808ae39a3@uwaterloo.ca>
Date: Wed, 8 Jan 2025 16:53:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Joe Damato <jdamato@fastly.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102164714.0d849aaf@kernel.org> <Z37RFvD03cctrtTO@LQ3V64L9R2>
 <CAAywjhTAvT+LPT8_saw41vV6SE+EWd-2gzCH1iP_0HOvdi=yEg@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhTAvT+LPT8_saw41vV6SE+EWd-2gzCH1iP_0HOvdi=yEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT6PR01MB11329:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ded8ba-8304-4a6e-f181-08dd302ef3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm9OT3pWaFFBNDc1eStzSGlzeFpjRjhsdytGbG5pWThsdTljbVBYTEo3VGdC?=
 =?utf-8?B?bFhUUUV0TGFNd0ZOcXhVVi9idmp2UU5meWFrVnJBQ0NrL3M5WTZHMkRGZGJP?=
 =?utf-8?B?TzRxN3FxWjloZkttUDJWR0JQVFY1SU5CeG81UWNQWXNaYUJlYnZKbUsxMUls?=
 =?utf-8?B?Y1VBbjBEL2p2TStiSjdTSGtWTXVTdUdUMEdhN2tmOERXdHVDam1MZ2xpMlkr?=
 =?utf-8?B?VHpMSXRDeUFqUDdRelFrbkZaQjcrU2Izc2ZoeVJTZktrRjJJRC8xL09iVVNV?=
 =?utf-8?B?QjQ2VEluc1hZL0lLRVdibjI5T0hVcEViWkpyQWJjSlYweVlIcmh6WEJCTStZ?=
 =?utf-8?B?bzFXcDNJUXhnNzZxSXFaRHpqdTMxNDBrS3dhMUtObWJOQUppMzNYa0JhZURv?=
 =?utf-8?B?Tkw1a01yWm9McVExSXc1eWpIWEhQK0VNaVVtaHdCV3RSU3B2TzdSR3BMaGF4?=
 =?utf-8?B?bzFoYXhMYm85cVd4aEVyYU1ZNHVUNWJnekJGSDUwZzVpZ0hJZ2J5WVVSUitN?=
 =?utf-8?B?MGFUQVVDcjJCV1plV0MraTJBNjgvTGJ6SU5kWG5WWkRmWi8vZTBoNi9jQUtV?=
 =?utf-8?B?dzFVUTQ4amZHeksrMVhQWTU1UW4zclRBVHFGTUg5ZDIyMFRvc0RvZVlqTVY0?=
 =?utf-8?B?eWQ2QUY3cDkrL1V2UWF2bEorMHExbWVYaTRaaGc0TzZITHZuSnltT0N5WUZx?=
 =?utf-8?B?V2h0b2VHZCtPWStwZnpUWUh1dm1mcUk5YmVYblR2ZTZUdkZ2WDBSZWgyVjRH?=
 =?utf-8?B?NllSTzdKNlR5d1V1NW8rajkySVI3MlROeXg2enFadHZ5YjNibVZKZmsrT25p?=
 =?utf-8?B?cFhXcWNKWHNmYkRJa0lPbE9Hd2NhU01XejlGYVpFeiszQUpRYlNEMVRNcDF4?=
 =?utf-8?B?cFRlUnBGYmRWcFVIckk2TGxpVFlmT2JGcWtOTm9XbDg5RVU1Y0huYjl3S05h?=
 =?utf-8?B?b3JLRlUzbXk1Y3d6dURXK3hQdmFlbWZ0bXIydmpWQjhvUFNZWEJNRFZOb1Bu?=
 =?utf-8?B?OFpab0t6d2lKQkR6TE9BSHdaVGZuNTNpVjlsdUREdlU1Q0plRDVsbTY0TkRa?=
 =?utf-8?B?c2xZakZ4dmc0U29peklHNjFWa3VmVk9iNkpidVJHMEwxVktVQ3hpSnhyK1JU?=
 =?utf-8?B?ZEdIb3ZYTlhSWW4zVUFSMzNraWMrbzBUbkJUWmc0aUlkOXRGOTV5QjlIWTVI?=
 =?utf-8?B?ZUFISzJQQURQVm1lWDllb1lpU1NyVHBqbks4OVUyTy9PK0Z5ZDRwMmhtdkMv?=
 =?utf-8?B?WnFOLzVSZnVWTzhrdFJNQUNKbTl2S3J0Z3BPWE1mNGU2WVRnVXVYbXNTeGl3?=
 =?utf-8?B?M2hTbEoyRVlhS2xkNWVscDlPMTdvOTB2ZGxObjlSclZidndYN1hmY2xGVFhF?=
 =?utf-8?B?WW9nWENmdnZyQUw1ckNXS3FIUVlMclhRTkMrUnRINzNMckFaSG5jU2VFRHpM?=
 =?utf-8?B?L3BrZjhIS29lM25MV0crTEhCUWxFWHdjTmQ0T3B4YlF1VmR1S0Q3TDYzOGY1?=
 =?utf-8?B?dTkxbWVldy91NHUxN01seTNONXAvbitxUEhjbE5GRXZta3RMK1NxMk5YZ3Bv?=
 =?utf-8?B?ZlRjWFVLWVJRUUxTNzB1V3BFUFcvRjNsN1hnQnl5ckVSQ1N5V2dWYlZUb2FD?=
 =?utf-8?B?M0g0VkRRdDNCWm80T2RjaE10VnMvZlRYb01rQVRwSVZnRTNrWjBRRktHWW9l?=
 =?utf-8?B?Wi90UFZzMVVTbWRpNDFsc0R1clZaQUlaSE5xR2hPTXV0b0pCVW5WRWdQaWxJ?=
 =?utf-8?B?UFoxa3k3RmNFaFlGKzlSV2xWbjVHUGlvc0tJbWdXTWJwcnJoZlZQbS9pM0Rr?=
 =?utf-8?B?RXMxcm5JVDZwbmtXSE8rcy9qbE80enJPaUR2bm51QnRnM3B1b1lVdFYvaFZQ?=
 =?utf-8?Q?F24xnzFPVwByu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUU2cVMxdG5CdWVNenhjSDdjSjI0R2xER3lobnlOa3dOdXViZVc1ZDA4dXQx?=
 =?utf-8?B?RGtWMGlxSDVMY21uRFBOQTIyd0ZZbEl0cVNCK3hCZWgyYnpMdVk1K3Bxa1Qw?=
 =?utf-8?B?V0pBV05tUzNjRjhtNGdZb1pIWnBIcWY3akhOR0VMa0FEa2JSTmZsVEdFaU05?=
 =?utf-8?B?YzdxcFhXTFpuNERmVVdLN3BKbzJ1cERhcExwNCtIMGRFK3pMM2dzc0RXUlc3?=
 =?utf-8?B?SzZqK2twQkFrbmpiNEhTaWRMMDkvSFR6S1dOWVJSM1lkSHlOWXhYMmRNTElQ?=
 =?utf-8?B?TWEyYk1icmxqblMrdG9YSElBVHFXM212UXMvSmNKMVltSTArL1orRDRkTUxD?=
 =?utf-8?B?N0xmK3RkR0lETXlBYXFQZDkrdEoyU0FKeUhSQVVHSlZ6M0dDUmNONmNZLzFw?=
 =?utf-8?B?a0RvbGhFZTdHcHdsY0dFaWQvV3VCbkpXdTkxTmtXbjVwTmNBZUdvVnJjRmpJ?=
 =?utf-8?B?M1g0ZWZrcE42c0NyMElnVjBPSExEbnFYdTBZWHBtdEJreDNFdTRrajE5SHd3?=
 =?utf-8?B?cnhhMUVIcXM1eENJSjYwYUpXSE54RFp2R0NvRXgxRjNrRHo4TXhyb1A4TVVn?=
 =?utf-8?B?T0RSVFlQbkhyVktDNTVjTFpVM0FTSEhwOVdEeUx0TGwvUFlPazRNd2sxcC96?=
 =?utf-8?B?OGxVMmMxMlpuMy9waTFESnc3MlMvWU54bmJOWmo0aE1FVTFoRVZiMWZ3N00v?=
 =?utf-8?B?azRYRGpVVXlIQXNSS2ZQeHBpblo1em9HeTFZenE1WnFyczBIbWg5V0s2cmdP?=
 =?utf-8?B?RndlZmo2VHVnVFFsVUlNUDFXSVNIVXdzQ1lGZFRoRmpiN0xkSlJTaWZsRnU5?=
 =?utf-8?B?QldzYW16VnJMTDVXYmlBODg4bXRhUnJNNFJSUmFqaTFQS0R6UEZXc2hKOUtl?=
 =?utf-8?B?eFFYQnhabnFSazBUcmFQY0xHNUJvOGxhM1pjQ09HNFhYMkovY1haSGxlOStF?=
 =?utf-8?B?cUhIaDdpcGE2bklJcGtsQmVPajNtb1JLOXRJVXYvNDQ3NDJVTnlVQ1JaeUR6?=
 =?utf-8?B?c2dQbTUyTy90TXhjQWxzQmRtd3JZMm9tOUIvZ3hkbGFFRGw3STBJaUErRnI4?=
 =?utf-8?B?Y0tVbW1BWkFNRFErUGdJaDlVRzZpWU44M002TWkrOGEwNWZJMzUrejh6cnpq?=
 =?utf-8?B?aUQ1QmZ0azcrdWVwNTdQMHM0QnM4VHVrSzg3eWZPU0ZXTlN5MEJZZlQwa25W?=
 =?utf-8?B?Y2VSRUZack90SzJtV084MHM0Y2NwcG5xeHR4U2U5M0tPKzBUOE0xRlBuNnp1?=
 =?utf-8?B?cWc4VW1LcnVESkNxUmxxWXkzeU16a1Q1Sks0Y2cybVB0aGlNRG1aVUM4cDhi?=
 =?utf-8?B?QlErZ1daVjlGN08yYVhmNGhtMFVYcDlIK3M3dWF3dHh5UU4xZzQybkhCRGt2?=
 =?utf-8?B?azZ1ZXlQaGpyRkpzOVNvMi83OE9xRzZFbkZsajJYNy8zdzhQMzZHakhhMjZ6?=
 =?utf-8?B?OU10Y01Cb0lTY2FOM1NQWjk4MFluTHRkTzd2LzZSczFkTUNxMjRkUUwzT21M?=
 =?utf-8?B?S1I4dFJpdlJmaDNuZ3VXNEZSemtXVWpXT3BPaHNSMXNxUDJUNnJDTE9Eemkv?=
 =?utf-8?B?L1dGWWwweUNEdG12QVJDUnRSVExrOXlpUmxZNGorYlh6TjA3Y0E3THVVZU5C?=
 =?utf-8?B?R2ZBaE51c2dNYzJzRDBxT2tjR3lBbzNCbVphN201N0RWKzVrZlBFVEdFa1Jr?=
 =?utf-8?B?bGVOMUZ6Z3E3RldoTXNUaEVvWUJobGs1STU4Tkt6MElIUUNBamNTM1ZjbGNB?=
 =?utf-8?B?Z2owMzYrY1dqNGs2L0VRU0N5TkZDbzVEWHlXdkhIOWdaVUdtRWsxU3RXb2o3?=
 =?utf-8?B?YVY2N3FQZThxTWNzajlJV0JyVmNPZ29QNXdBMkRqUFBibWJiTjBmVVBzMk9Q?=
 =?utf-8?B?WjVSalN2VGtWY0tXRmQybndqa1lIUVlMNEhQZ2NEZGtQZit0RlRoTHd0Zm1i?=
 =?utf-8?B?VWtNQTlMWmNoOGpTUE9TWEFxYi94Y2NiZ2NzRUZhaTRvN0dTSTFDb3h5bGFM?=
 =?utf-8?B?OE9BVUdsdmMyNHl0aFlVcG1QL0tuVGVFNGMvbldBRkFKRHRLWXRRWXRRc3gz?=
 =?utf-8?B?Ky91QTZRTjJkY1hTZ1J0UytaeFVpbGEyR2ZjSEJ4U1Z4QVEyNitud01jQlU1?=
 =?utf-8?Q?VD+8bTTdGUpx/Dd4VaN1inKwL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w4XPfK1LJ3KKrUci6gA845AE09UE5+BCU1x8a+sdzcR/Pw1jXcrnEZOy2Jkny7x0jeYmAadzWctHvt5mTotqpXeERxX+SrQ2veUYRQI5nZ+nGcRmpEjQtGnyn1ZWezm/9BBKr74iL8NOJbZwyWpAP++4GC+Wh4Jnc1CWNNVg4KHrU1UqIa4JcdVLzjGnjvMgXhfNtu7/pTZM3hb/U6v2ql7PwHgHffNTJSzdHMBCvZKajA4NmIeNsD89Al4AXOHqZmLlBY4u7zH9Jpy36wJUSii4rzd7/FOIKikKkRQ403QoojUDRGTeUHxU1P9FzD3FpRAqIN+1y1AssDjjaYPpnJb924fsrQxtlOnOx2W82vnpKe8jicNySB0rxYkQQ36J6kXRFyQqvBB35w+zoaGNHudVKcO6NKuw9O3hV9KNfKHd49hFXYuvakzyMxSFvy2sELHlfxVXSZ1R/htH68LEXGOeo/M2bF2ijgDvDUpk3HLGB2rnWz1ndSAfno/V+Cy0W8Ze+Pz8CDCO1RVI/RFJc5JUSSavWoDb6y7sPAC6rgc3pLXObeU72IKiJZjWyU0FZF7Qy+O92v9ZO6tZg69kdHwQ+yo+A0GiUy4UROftQd5PMx11h43zFfiOa5OJS1fk
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ded8ba-8304-4a6e-f181-08dd302ef3f4
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:53:57.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvH5ue8kfoouwjUPQfLQa4zRPZaMHeDCscs4M4TqDAHttMIQKMENOaKdbPvytUhSIdP+GwaXx0O5tXEljTCCrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11329

On 2025-01-08 16:18, Samiullah Khawaja wrote:
> On Wed, Jan 8, 2025 at 11:25 AM Joe Damato <jdamato@fastly.com> wrote:
>>
>> On Thu, Jan 02, 2025 at 04:47:14PM -0800, Jakub Kicinski wrote:
>>> On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
>>>> Extend the already existing support of threaded napi poll to do continuous
>>>> busypolling.
>>>>
>>>> This is used for doing continuous polling of napi to fetch descriptors from
>>>> backing RX/TX queues for low latency applications. Allow enabling of threaded
>>>> busypoll using netlink so this can be enabled on a set of dedicated napis for
>>>> low latency applications.
>>>
>>> This is lacking clear justification and experimental results
>>> vs doing the same thing from user space.
> Thanks for the response.
> 
> The major benefit is that this is a one common way to enable busy
> polling of descriptors on a particular napi. It is basically
> independent of the userspace API and allows for enabling busy polling
> on a subset, out of the complete list, of napi instances in a device
> that can be shared among multiple processes/applications that have low
> latency requirements. This allows for a dedicated subset of napi
> instances that are configured for busy polling on a machine and
> workload/jobs can target these napi instances.
> 
> Once enabled, the relevant kthread can be queried using netlink
> `get-napi` op. The thread priority, scheduler and any thread core
> affinity can also be set. Any userspace application using a variety of
> interfaces (AF_XDP, io_uring, xsk, epoll etc) can run on top of it
> without any further complexity. For userspace driven napi busy
> polling, one has to either use sysctls to setup busypolling that are
> done at device level or use different interfaces depending on the use
> cases,
> - epoll params (or a sysctl that is system wide) for epoll based interface
> - socket option (or sysctl that is system wide) for sk_recvmsg
> - io_uring (I believe SQPOLL can be configured with it)
> 
> Our application for this feature uses a userspace implementation of
> TCP (https://github.com/Xilinx-CNS/onload) that interfaces with AF_XDP
> to send/receive packets. We use neper (running with AF_XDP + userspace
> TCP library) to measure latency improvements with and without napi
> threaded busy poll. Our target application sends packets with a well
> defined frequency with a couple of 100 bytes of RPC style
> request/response.

Let me also apologize for being late to the party. I am not always 
paying close attention to the list and did not see this until Joe 
flagged it for me.

I have a couple of questions about your experiments. In general, I find 
this level of experiment description not sufficient for reproducibility. 
Ideally you point to complete scripts.

A canonical problem with using network benchmarks like neper to assess 
network stack processing is that it typically inflates the relative 
importance of network stack processing, because there is not application 
processing involved.

Were the experiments below run single-threaded?

> Test Environment:
> Google C3 VMs running netdev-net/main kernel with idpf driver
> 
> Without napi threaded busy poll (p50 at around 44us)
> num_transactions=47918
> latency_min=0.000018838
> latency_max=0.333912365
> latency_mean=0.000189570
> latency_stddev=0.005859874
> latency_p50=0.000043510
> latency_p90=0.000053750
> latency_p99=0.000058230
> latency_p99.9=0.000184310

What was the interrupt routing in the above base case?

> With napi threaded busy poll (p50 around 14us)
> latency_min=0.000012271
> latency_max=0.209365389
> latency_mean=0.000021611
> latency_stddev=0.001166541
> latency_p50=0.000013590
> latency_p90=0.000019990
> latency_p99=0.000023670
> latency_p99.9=0.000027830

How many cores are in play in this case?

I am wondering whether your baseline effectively uses only one core, but 
your "threaded busy poll" case uses two? Then I am wondering whether a 
similar effect could be achieved by suitable interrupt and thread affinity?

Thanks,
Martin

[snip]


