Return-Path: <netdev+bounces-146550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A489D42CB
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 20:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C1281380
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB94B1BC068;
	Wed, 20 Nov 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc33BdWv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16FC13AD20;
	Wed, 20 Nov 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132656; cv=fail; b=cxJN+2wbmVYSv6MyXDCj0C1hMObRIrEKaXV6qdZifov09vwbVbEMEP17eQ/SRFan3118DLXUAH4VTZluk/uvjpow/6zOskCUu6F6IxzY+JoKC/pjdEzloNnnrUE8ny59Ostnqp9bbNV/TBGjNXxOI9Wu9AS6rXQ7BiIJfSv9tGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132656; c=relaxed/simple;
	bh=x1pI1fuXvRyO4ymJaddGtpXqyxrGZzPRRpc9pM3o+58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YfGKczdwS1e5GkybGdZooS/ZeZJrAA+ECQumZLDEKd+FJ0/t7zkvwa4gxhEIh+1SCKFGR+5rvUTrNbnbikW846Jjsv/TyFrOnY+3zUM4qdoFtht4i4E2NOauLBpcGmqbr3dJTAV79rBLfvWrOXu2tGcHfYY9lCktb+gwRwbIYVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc33BdWv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132655; x=1763668655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1pI1fuXvRyO4ymJaddGtpXqyxrGZzPRRpc9pM3o+58=;
  b=Bc33BdWvtK/pRB1H3NYVKMataMUxUyFRYhwmltTLCNPFZvp52A8rnuY8
   1bU8Pyr1p4RWqIHoYGrRVOTbpCoJcdExU75tG39XpM6cY8QFOm0E8VcKt
   kG/xSXuutsvboTrt/bAoQjq6bNbmvfruqNUrP5QSbTodOf4IsPmkxsqWY
   ehQyZITQujjqRkJZteGqvZeAVxtH7Fxc14Ev7qBjoRF5iS7umMEtfDLLu
   LOsL7qYjgjDxiVXHwEEpxG4e7j2rUipe+7+spllaLTSIX4SdcmiVu8akc
   sh9tHsW7sDwRS9WKtyE/2HNXEP49z79ck0KVThEBfCdLQJzVWZnFRBj5B
   A==;
X-CSE-ConnectionGUID: 73kfTTBiQmeoS/MMcF7mGA==
X-CSE-MsgGUID: QTxccZ43Tt2kTdqMfc6URA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="54714295"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="54714295"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:57:34 -0800
X-CSE-ConnectionGUID: 0uvQuqCjRFCYIXjBal33gw==
X-CSE-MsgGUID: SAxva1e3RLWh80PkMDPmmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="95090031"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 11:57:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 11:57:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 11:57:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:57:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu02IAGbQIv3arFFMhMKYq7BWbH25Kz0U6cNGv22y451uoz27MeOliVdCEhBD4h84dKBif/45DUV4xb763eNLpf6LnYJ6IrPW1FNnuxyl7keFZD+zY6AeJkOSSxvtgwdasofaNyboYq6WN36Oq29L7JNGcR4O3aZWW5ZkV+wnBTweY/8tsz7sccS6HrgXZWZ1T8Yk/y+9ywVec0aLH46Em0nQcIy69OakH8VNVx4+sVg5Sf1lKhy2+xigX5lny9+M6ViavlGp0rBYgVsvpcv6oLxM2MmQNplZDjR6xYheG6d/wRA8aLVIWdps/mmIstMzT3/rj806sjf/ehNw12g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLg4IKma0AFedfiEtxkXXjMVSg2c4rGc4uGAwjSS04M=;
 b=Zkj4CIouNWf8/mKLbidLblD/fZ0szP01YV3iNMnwGT22sJJw1rXskKaRDB8WavdBcpRvFJIme10xVLbc5KUHkXlwWOoFxEzUzhk3lfI9hrqBg/pCzIZ3ydhJTPfjSqw/Zn+FBWDiAUMK1GOeS28DUB8YnEtNwiX4rHzOcHcBj4/vNithqaOdvYj9oAinbhvTvADuJZUchMnOgzzZuBwK2foRiferQ+m5vgre4LWHrY4kbNvdWI4nwFApbiTqQOxMyNeaPRv/sddJZG+wdatC1fnWoSN/mKLgHY0c+XN+gE7mJzIvUUGvJDjCgBn1TRtxtPNL+1UNcTtifVcqgFI2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 19:57:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:57:30 +0000
Message-ID: <c8498820-e794-49a2-9724-f4d2e1ca8082@intel.com>
Date: Wed, 20 Nov 2024 11:57:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ethernet: oa_tc6: fix tx skb race condition
 between reference pointers
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <masahiroy@kernel.org>, <alexanderduyck@fb.com>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <rdunlap@infradead.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <linux@bigler.io>,
	<markku.vorne@kempower.com>
References: <20241120135142.586845-1-parthiban.veerasooran@microchip.com>
 <20241120135142.586845-3-parthiban.veerasooran@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241120135142.586845-3-parthiban.veerasooran@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BY1PR11MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cd0052-82d8-4ac6-b75e-08dd099d90e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnNOL3hxSFkwYlhJUXZPM2haZmQvYkFxekJPaTNzUkNEdVVYSGxBS21XSU0r?=
 =?utf-8?B?Mno2dWtRRFFqVGZuVDRrTHpRSUlXMTZYNXZnc1RvbDhBZ1JCZ1JFZjJxVDhK?=
 =?utf-8?B?V2N2azdLYlpzbHRLcjZGelIrVS8wWTVwaVl4dkJHUS9GK1pZTzJJUktpZ2gw?=
 =?utf-8?B?T0hEZHk0TXlycWhzT1hUbWtmZzNod012dDlOaXFjTVRlSE9ZZXV6WUliMnlL?=
 =?utf-8?B?eUhHQWdPYmZuOEQvbVBzVURjY2VvTHpQU0xRTXZpNTc2QS9zZ1hFUkp4SHdZ?=
 =?utf-8?B?UkFIQXpNdktXR2txSzlGbTFIdkx1ZmJGWUxMNEx3enY1eVNuZ0R4SnNNM0dD?=
 =?utf-8?B?UnJwTzZhdzdqcit3eHFJb0ZjOG0yS0R4eUhoaWJyN0l0S01ldktDZXJiS1pV?=
 =?utf-8?B?bnZkdzY3bmdkRVh4YU9DR2VwbFpIcWZIZk5IMjcwVDFDTDFnVHQ5NmZwQ0pp?=
 =?utf-8?B?bFVnVlBrMnVQb1I2SE1vc1hFaVp5YUdjK0FkVCs5NkZ5MGlyNGJ2WHMydk90?=
 =?utf-8?B?bFRzMTVLN1FlK1lFbjd1RHNacEQ3UUZQZFF1azB2blA2RFFBTnVoZjhuZThz?=
 =?utf-8?B?VWVCWTRkYXYwb1daaXNDNXRwVk9lMEF3VTdUQVUwRExQa3Q2aVdnQmErTXVR?=
 =?utf-8?B?ZFZIbjByb0FCZ1VKUXcrM0hORXcxcTFNSVlXNGFHOFVQR2VEcUNDSUt3a1dK?=
 =?utf-8?B?YUZwckpwS2FlN2xwY3RuR2xXYURlMlFCeG9NczJBQUNld1FoME8yL1dRS2ts?=
 =?utf-8?B?elBIcGhoTG9kRHh4MzFuQ1BSS21PTEh4YU8yZHkvMHFzSFpHL2tKWjh4a2VG?=
 =?utf-8?B?WHdLbmRyTVNxRFBrMmVCUFlYQTlVRGVJdXkrT0RzcldSWUtRMDAzTVR4cllG?=
 =?utf-8?B?dmVwZkRyTEMxMFMvWE44L0ZJQnJrQzFwZms4V2g4S0FSQXM2amZQMWJjNWc0?=
 =?utf-8?B?NGFvSVdCajE4Q3dZNnBiaWlnTGdSbEM2NG9NSGtWV0dMQlkxVDVxOUF2c29q?=
 =?utf-8?B?WHhFVUFpSUsyWVU2bi91WFNEKzNibnBPWnBBekkvSnVhY3dKYjZ3cWt5SVZs?=
 =?utf-8?B?cU5ibjU1OWgwM0xjbmsxNFdkTEphVTZPdVczaHNIcFBWYXl0MlZKeUoxQ2hh?=
 =?utf-8?B?VWdraHNVajlBS1FFWURTbCtCWldwNERwOE16Yks5cTZzcGFIdkllTjlHZS9S?=
 =?utf-8?B?Qkg4WVBUc3NLMjBld01iUTZmbUEzeVNjZXdNaklzak5wOXU4R3ZLclVPOXV4?=
 =?utf-8?B?NHRaSlplNXc0MFhNU0xWQUNTcWVEQ1VYMktmN3llTFVwSEc2V2d6OGZMRDhx?=
 =?utf-8?B?UllKMUxKOW9US0JlN3hNR2FFTktOTnJLN05UWnBzSHFzckpUakhQQy80RkhY?=
 =?utf-8?B?Mnl2TFo2QUo3K0MyOTJETUI4cDdlWlVDS2ZlVkZJb2xWQ0tBSzU5eW4wT3pV?=
 =?utf-8?B?M1RwSllUdC80YjJJVHllQnFCNVdXdzJ4M2VRbmRMZ3NaVDlMWStyL3M4djY3?=
 =?utf-8?B?TW9SR3dKRW9HVXN4MGd3R3B0T1luYTExVmJCRkhNaG1udGMyeWxjZVNuT2Q1?=
 =?utf-8?B?V2dNZTNLRkoxMS9DaWJNZ09DT21hR3E1bXliYlRoYTBoRk0xc2dsakJRY09o?=
 =?utf-8?B?NUp4dllmL0lFbGhnaWxOWkRrNGxTV0lmL2UyR0M5RENhMWF6Z1l0bWpENDRF?=
 =?utf-8?B?Q05zdW9DUm40WC9ybzZUOHliUnlpNVoyekdTZ2c4NEwyS3VjMmRsV0IzaFdv?=
 =?utf-8?B?bzFZUEE4SE1kN0E2NWZVS0paOE5WUnVURjJaa0VWZ0p3WUZxejJpVWltNWRX?=
 =?utf-8?Q?HunKXWBXQhfvLPPk0oeYlQm+lz7MH/SlbEL/A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9tN0xiN2x2bnBCeE1uV1ltajZNc2YxVXJDK0hLUlBESkJDVExVc0d5R3J5?=
 =?utf-8?B?MmJsdzNJdmhXM2U1Znp0Ujhrbm1rb2pPRm9mRFhQV0RVak9xdldLL2dNa1JR?=
 =?utf-8?B?T3VyQXBLRU5xWkpMSEdxZXlGd2JNdlhtM3NwMTBPMnhTU2s4NENJdnByekho?=
 =?utf-8?B?NS9lNkZXNk1GZ0dKVlVNaGQ2anF0UTkwOFB3RDl2TitvUU9tdEtIUXJOUWl0?=
 =?utf-8?B?djNWOU9nY09reHpFQkdOS3BrbWlyQjZaYUxmVmVMOXRGVFJ3Y3hkTmg2djFt?=
 =?utf-8?B?RnEzaEovbkZheU9jazR3Y2JZVUFBL3UyWDB6NDluSVBRNWVpN09OVndPd0hG?=
 =?utf-8?B?OUlOQjdKYjAwaXdzQ2xKRm04NnJlMUp3ak9MU01vZE5NK2dYZWd3TUtrZWdp?=
 =?utf-8?B?OFRkSUNLWkZ6TlNmWElFRS9zZ0hKNTJleVRlVlQxYnFCZDlLUnRVRE95WFdI?=
 =?utf-8?B?RDMvZWVvZ2t5R3dtSWppTzdHdFNYc1BXR25tNC9WN3BwOWdUQjZycnRrUEo3?=
 =?utf-8?B?QllrVEpGN25NbHpPa3A5NmRrU3VJQzhrbXkzTVVaRmF5c0pFMXlsYjlLNmNZ?=
 =?utf-8?B?Vm5TWndpSzk1REV4QldHdXFRTm1lYWZWQllyU0JCTzQ3b044VHpYODIyVTc0?=
 =?utf-8?B?dUVoaUxMd2Z0N3oyRlp3TzYzWjhWSnRmNE5ncTZobFcvUXRFbTljNTIxdHBu?=
 =?utf-8?B?OWxnQjNySmlqbU5MSE1SK0hBRjdJTG5yaUxIL2xDL1c0TFFucUxTcmRreGNN?=
 =?utf-8?B?Ti9Qb2dGaktIdjZNSnphTUVTVFl1T2g1RjZqL2ppeUF3MTdnYVVvaWdkK0pv?=
 =?utf-8?B?RlVKMEk3amI2ZnNrK2VmN0xqeXE5dENtNEZYZWhxaGQ3ekFxS0hRdGg4aHcv?=
 =?utf-8?B?OHowcERFSE82aVBqM0kzS0twcnBYUGZWeUdJU1ZXNkZPN00vdWVOaDV1ck8v?=
 =?utf-8?B?M1B4NFdlVXpYQjRNK1RKaUpXZWhzdEtMNm5sT0ZpU2p1L0pGV2M3UWFmb05x?=
 =?utf-8?B?a1p2TlhPNE1LSUxLVlpkekZmT2FGQTR1NHZIcFE5aVRiTUxBM1A5SnEzTnNq?=
 =?utf-8?B?M3M4NTdFeVVHeE53MHFpd2Z0Q1lyNVhUV2tGbDdEOWhtaG9jUmhYMXEveE9x?=
 =?utf-8?B?MjFCZ3VVcXV4OGNrVXZhMVoxTDJXQTV6NWNQTUE2Mm5ROGlhZlBranQ0VGR0?=
 =?utf-8?B?SkZSK2s2SzhWb0hKY3dCdS85MUlHalZETUtJM0VqS0dGWk9EOGRXTzVDU0Qw?=
 =?utf-8?B?c0VEVGdRclJFR0h5RnB6Tkt0VlRkT2lab0sxTFQwUUdoSG1nUmhxRkZZWnA0?=
 =?utf-8?B?K20vRlZhU0dFa3Q2aG1SVS9mNHQvb1o0V3NkUVJLUm1WOXhvKzV2S3E4L214?=
 =?utf-8?B?bnlZa0tYaW96YnBRMk9DRFZpNmQ1NEFFOVRTajh1bVo0TXZKWjZHL1RCd1BM?=
 =?utf-8?B?ak5UMWpTMTBFT3FXUndMMFFtcXFFWlB3WjVMbW9veFRKNEltNzFuYS8rbEt5?=
 =?utf-8?B?bmpCY3c2bHBqZ3ExZWliY3g1cE9HOUxCTU5MOE1mM1BHVTRLZVNwQW84VndI?=
 =?utf-8?B?dFJTNlR0NmFqeGppSnFqOS9PSmdQNUxoL0ZOTVlwSGx1aXBDa3czV3V4eDBl?=
 =?utf-8?B?QThVRGlGS3M3V1cyVkd5K24zMjdjTE9HaC9WUEdza2J2T1RhRlV5QXcxbG9Z?=
 =?utf-8?B?RnkxUUM0WXFLS2RRL3RLdjVDNm5zbXRodGYyS1MwWSt4SWJNTnF0RWNMSVpu?=
 =?utf-8?B?U0gwL2ZNcDcrQWtLMC9jNXV2Szk5QWxEbTN2YUd3c0d0YSszUmcwZ1UzTXlF?=
 =?utf-8?B?a0Nad010bGlyVE5VYUo2WHJ6WDRPN3Rkcmo4K2cxNTVYbDNCT1p5SDFpeXdL?=
 =?utf-8?B?L2hHekQwbkF2aWl0cnBUZmZLRllqMFNUSkZGbk9XS3BXK0VHVGJuRWUrQkxJ?=
 =?utf-8?B?ZTZOVDE0YkI4eEdpYU1yTlVra2hMNnJZVGJqcUV0cVpnRWVNZ3R4OU5XL2lh?=
 =?utf-8?B?cHZmWEZkbjJLU21ETmNwNkE2R3RIRThrUm5BSHBkOXFST1JoRVZvdTd2ejRN?=
 =?utf-8?B?WkdMNjhsUlYxWHhIZmE2emJJVk8wUFFBY1orUm0zK0ZBdkhGbTdaZ1hRK0xT?=
 =?utf-8?B?ZklDSkloRTNnWGtBZWV3K1JLcG1PcEI5MUlYZHI2ejhEYmMzL3F4eVBEQmht?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd0052-82d8-4ac6-b75e-08dd099d90e8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:57:30.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB2eM7xAS//uXzeKRZRrIfZN94OnKZqUelZm4u44iGFKIxPMPIcfVscBE9GXytYSIEjli+i6vcFETgBhYotB2G2mqPQ+U2SgNvmjrzEMx1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
X-OriginatorOrg: intel.com



On 11/20/2024 5:51 AM, Parthiban Veerasooran wrote:
> There are two skb pointers to manage tx skb's enqueued from n/w stack.
> waiting_tx_skb pointer points to the tx skb which needs to be processed
> and ongoing_tx_skb pointer points to the tx skb which is being processed.
> 
> SPI thread prepares the tx data chunks from the tx skb pointed by the
> ongoing_tx_skb pointer. When the tx skb pointed by the ongoing_tx_skb is
> processed, the tx skb pointed by the waiting_tx_skb is assigned to
> ongoing_tx_skb and the waiting_tx_skb pointer is assigned with NULL.
> Whenever there is a new tx skb from n/w stack, it will be assigned to
> waiting_tx_skb pointer if it is NULL. Enqueuing and processing of a tx skb
> handled in two different threads.
> 
> Consider a scenario where the SPI thread processed an ongoing_tx_skb and
> it assigns next tx skb from waiting_tx_skb pointer to ongoing_tx_skb
> pointer without doing any NULL check. At this time, if the waiting_tx_skb
> pointer is NULL then ongoing_tx_skb pointer is also assigned with NULL.
> After that, if a new tx skb is assigned to waiting_tx_skb pointer by the
> n/w stack and there is a chance to overwrite the tx skb pointer with NULL
> in the SPI thread. Finally one of the tx skb will be left as unhandled,
> resulting packet missing and memory leak.
> 
> To overcome the above issue, check waiting_tx_skb pointer is not NULL
> along with ongoing_tx_skb pointer's NULL check before proceeding to assign
> the tx skb from waiting_tx_skb pointer to ongoing_tx_skb pointer.
> 
> Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> ---
>  drivers/net/ethernet/oa_tc6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 4c8b0ca922b7..e1e7c6e07966 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c
> @@ -1003,7 +1003,7 @@ static u16 oa_tc6_prepare_spi_tx_buf_for_tx_skbs(struct oa_tc6 *tc6)
>  	 */
>  	for (used_tx_credits = 0; used_tx_credits < tc6->tx_credits;
>  	     used_tx_credits++) {
> -		if (!tc6->ongoing_tx_skb) {
> +		if (!tc6->ongoing_tx_skb && tc6->waiting_tx_skb) {
>  			tc6->ongoing_tx_skb = tc6->waiting_tx_skb;
>  			tc6->waiting_tx_skb = NULL;

It is unclear to me how this additional check completely resolves race
conditions? Is there some other locking or synchronization such the
second thread cannot have updated waiting_tx_skb either prior or after
this check?

This feels like you want some sort of atomic exchange operation...

>  		}


