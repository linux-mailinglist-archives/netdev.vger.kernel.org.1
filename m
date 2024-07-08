Return-Path: <netdev+bounces-110052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0D92ABEB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BA1C220B4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E8146D40;
	Mon,  8 Jul 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="iKBQoVY0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBB2D058;
	Mon,  8 Jul 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476980; cv=fail; b=dloBsgxO/WaApb3aC5JatuyXp524/ViLnJm1+yze+hHDPoQ139b5qf0T7gCSMc49H53rMhDsl1CmeIal7y8gjF2yfHvJ31IrW+WSZYW/PoDP5+Tp2Iwjp/hyyxB9ohA3kSRbrcc0mBx5BrngSQUMCNK+SmXR/G/s3TRhXqPjQIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476980; c=relaxed/simple;
	bh=6H0vqgsRlnmd8lBVWBa2xLwIbIdHmUhkCE/MwH5oWYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXOsUQ3vHtLIFVHoEsxlxAjneRreF2vfxhJriOuO267WckLSSJ2krHwDlj69PT2jXd3e9gqB3jA+Q4yN32GUSM7xfEv8oBvPn5gd9TR2eHKY64yZbKfEZXdoVdaa7YwXdnWFq28S/m5l6XRm6ukaUXpsI9IQWh4ohDACNfytt3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=iKBQoVY0 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPdTbX69a5/f2FDxDLu9LEVvKA/yOE1qc0YZ4YwdqvZquLdEulPYk/aa6EXk3rMoBWZIHutHLqWTvBBQESf/TH/nJ+ZVzSIeK1qvliAymdLCXeArkG6xZBd/Y59Fn+kWwgENirseLDUoftTpLSiKzRp69GzLI3xqqx6YqwrxuttSzK1hy5vPojyBS+daEo/l840OAozkcQODagm55IUvha96N5Gc3KU8PSoJ/DFdKVjJfXv9pVYGoR9hBEEEpIFebYrUA4RbQIawd43hslmyo7OSkl8g5DGLUt69ZTmRN6u+fNB6cylk6WQParF+Rx3eGiQjT6GMzLdzXRzXmPlEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owfusKncPl07b1Be0jRbLlKbq1iZqEGydwbTv2JKdEw=;
 b=X84ukhyKNYYqa5CyGb3Briq1wYVTAM2Jw3CNmI8nkx6GWXr3JJlcARL/Yx0dtAB0JNwdYV/aMAlm+6ryTNVX71MN9Trh3UnO+L/f5poODNP3ks1UhbLF6LDI/PwwRLnBqcw3bBM98mLmBV+l1F9FIUb1wX1zGUjSHsCkasOFMpxz4fvbuyT7lLP4GN3iFvw45Rog5yf4M7j6NMX5RLRmEKoIHALUPtQE60P8EctEMJ6ZFiqRZNEtN3zRD8P1SZr2Zau+lbvvjQL0OLPy4dG+gAS0gLXYJJfsbUkYle5GFzH+UIkPEnn7m9r/jqvXcBfE48m/4Gk48BvDgv+kVb8k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owfusKncPl07b1Be0jRbLlKbq1iZqEGydwbTv2JKdEw=;
 b=iKBQoVY0oZx7QoA5a4MSqPO+naT2V2lSjYNq4N3rPHPkKKbkFV/ah9DzAdY4qT+yigM/oVQhEoWm1iQNFZA4puz10yLGkRyFTeEjfYKkTDM/+l7b49+LGKhq4BWVW8Q+yVePsSkrM462YyxZ6aD3J8yO0uz7Xk14jI4Tsr9KsxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA1PR01MB6704.prod.exchangelabs.com (2603:10b6:806:18b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Mon, 8 Jul 2024 22:16:11 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 22:16:11 +0000
Message-ID: <8e85648d-fc88-45dc-a07f-b80f9c2a5fd8@amperemail.onmicrosoft.com>
Date: Mon, 8 Jul 2024 18:16:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20240702225845.322234-1-admiyo@os.amperecomputing.com>
 <20240702225845.322234-4-admiyo@os.amperecomputing.com>
 <35d8f28ef8d7de30733da7d8b1b16da39545879e.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <35d8f28ef8d7de30733da7d8b1b16da39545879e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA1PR01MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaf7bd6-fd4b-4116-0ed4-08dc9f9b92ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHpHVTRVRmxOWnpTZ3ZhYlIzRlE0WE42SWZHRWtKa3NBU1lveWtsRVhJYlMx?=
 =?utf-8?B?djQ5THJrQW9xTHRvbHFRRFZ2Tyt3MkthbFUxVEFnL0tsTmdiOUk5Z05wQk5j?=
 =?utf-8?B?bXNiWnpZMlBJZzU3S0J0NW54TmhnbkZ6V012aGtzZ3NmeERwcGtkVzlSb0FT?=
 =?utf-8?B?QTBOY0lSZFArMU9OYUVKTHYzSWlPR1R3OGxpOS9RNGhPVlZ1c0xEMGlJeEVx?=
 =?utf-8?B?dG1TU3UyMzlTajNZSzZkazFRY2h5eStnU05RZlU0ZEdWU2dmaE1lRmsxUHF1?=
 =?utf-8?B?dUVYbzQ0c0FFR09FaHFKdjdXazVzVXFPSkdCOEZ6TVVBRnpobHY4Y0wzRWNE?=
 =?utf-8?B?azFDUlFiRVRuUWwwRTdNY1BmTDBINzhma3VXRXBOQlZOUGJ4a2tlVlc3ZW9x?=
 =?utf-8?B?T00vSEs5UkUxVWovR1hYSkpEaDYrSjVJTGhZTG56dFVRNU9TU1VOa0h3R0Ft?=
 =?utf-8?B?M0ZOUGlDV1hpMkxLeEh4bkkwMXVGWHVHRHE0VWZMcjF5dlFaUVRBbTRHcnp0?=
 =?utf-8?B?SEZxWUo0SkxoVlNHdHRmaTExOUJxNGR5K0RyY1Y1TkpIMTBrU0xmTzEzRHJ6?=
 =?utf-8?B?dWlkY0VyUE5FRlZDMmZyRGwrc2dkTzVXZy9lMGwvaDVtUjZoQ1Bhd3dSTm1a?=
 =?utf-8?B?Qm52YlFMOWJkUTFUQjBwVFpFZXNRZlNjclZzOTF3N1Y3RzErU3hIbHFySnA2?=
 =?utf-8?B?aG9TbkhtSEphUmQ1YXdOdE5VbUpDQUJxWE51aVc3T05odVF5K2JUR3dKc0gw?=
 =?utf-8?B?RTFmY1R5V0RwdEFjTTVqMmpmb2FvNFNEVk0rczRCZHgvVElmaEZOK1pHamVr?=
 =?utf-8?B?eHY1d3M2TkVuYXJPMEVvTGJXSExkbGxkTzl5Slhzc2hrRmIzSmhOSXlmRDd2?=
 =?utf-8?B?b3ozSWxFRXdVcUtwNzJXMGthZUZmaWhTN1krM01kcWlqemg4dGlBREZRY25w?=
 =?utf-8?B?Sm9zYlBJM3NPRlh4VGdCNXZUUGdaVjBLbEsvdTdiNzh0WVdJTTZWOG5ZNVVK?=
 =?utf-8?B?anJFK3RPWnRHUnBGaUZWT1E4cDF0ZHRXWVk5dWN6ekZldXNrLzZDQ2pPQXpD?=
 =?utf-8?B?TElQMEdpMmlTMnIwaTdQN2NVT0t0L2JvTVpJdHp4UFlpMEpUeThDU2xVZ0pQ?=
 =?utf-8?B?a0UvdExDamhvMkw3YlJrVkllVGdETUV3TE1PWDRKWVNILzRuK2xNSUZPS0Fl?=
 =?utf-8?B?R3A2UmtzWk9ydUVycE5Vd2g3NW5xdkNaSS8wRDROS3pXeWhPOU5WWFZkSk9H?=
 =?utf-8?B?cFpkVFdxYTBpVE5TK3ErU1p2aHg3V3BzOTJzZU9sOUxFMHpaMWM0NUUxb3FE?=
 =?utf-8?B?MXFsUGFQUmRWYnRFRGQ1MlloSi9VVG96Nnp0Q2xGQTZZOXlXcFN6V1ZKOG42?=
 =?utf-8?B?L2Q4UzcxTHVLME1RME9yWFloYllBcnF6a0FyTnlTVWpQVThiUlViK0MzakhK?=
 =?utf-8?B?REMwL3krZHliSTRmN1BHRGl1K1FrekNVQjU3THhnT29UeFE2cGxYZlhPV2Jk?=
 =?utf-8?B?YWJZZUliM3MrN0Jab3UzcDZMOExkcUozM1FWTVFVZ215R1Zqd2dNK3pxUVl0?=
 =?utf-8?B?eWl1aEU3WERXcUtkekZ2NDEzanhIM1hsU3ZnV0lIUmtRWk81VUhFdXEzOWVp?=
 =?utf-8?B?cGl1aGtlUkl3SUVIMlJpNFBGVWVrclVxUGhqOVNlSklGUjhOcHBCY3VZbHRD?=
 =?utf-8?B?MjJMZTJaWHZob0E2L0tDYnlLa2tCdXdKR25rckgxbDMwSTlka2oycU5iK1la?=
 =?utf-8?B?dTQrYnIzNU9zNVZldlNhNDZOQ210TUhYZXBGV1Bud2dzZHBSd1ltbUh1SVoz?=
 =?utf-8?B?RFArKzVzdDFzY0JiVTZJZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0dnMWlaSndlQjE2cXFGR0lJd091SDBBVm83bWVTSmwzaXdBNSt2LzhxV2tC?=
 =?utf-8?B?TTZvRll0SHNjL1M0OFhLTTFFRlh3Ylo4Ry8ydFMyQTdOczhIbGp0MWx6UmUv?=
 =?utf-8?B?OHJHMGUrMTBuL0JkdHZDWlhKRzJTZWV1MjNrbkVlRlY3ZW53d3hWcEhGWDh3?=
 =?utf-8?B?WmEzaFBZcFlFYUxBbGVBV3NPcUtJZVJERXpuSVdZSzJMUmxHUzU4MW5CaVBR?=
 =?utf-8?B?MnJoKzZTTVRFdnpYS25sK2tQdjVtRm16czl3Ynh1eWFLSFg4M2lTazUrZVp2?=
 =?utf-8?B?dFN1U1JvMUFHM2t2eGN1MEl4S24wR0NkRXlwaFRqYmtCREhReThtNkJJcEFu?=
 =?utf-8?B?bzdNMGFUUHRSdzd2enRlTUx2SnczRFYyZ1R0M2VINk8rUUp2MEl1dVBHVEls?=
 =?utf-8?B?K0Mwa2pCcmVZY1VHdzhZbVlHNklWR1RJdmpFUE80eFVPRGxDTVRsb253ektC?=
 =?utf-8?B?ZHdXYzNpRGE4cmtBRWJHbkxOQ05WaFJvM3A0M1JGVjc0ODdXMjhKVUtuYTV5?=
 =?utf-8?B?VlZRTTdadXFNaUE4YlFkUXV4Y2tOZkhQWEtHS0s2TG45ZDhhR2FXV256L1hU?=
 =?utf-8?B?cUVWTDFHVHErQU9WUmFKdmhTd1FSRGt0QWJQb2grRE1CdUo1TloxdkNHVk9Q?=
 =?utf-8?B?WC8zQkVSNUd0YjJTQS9BTmhtY3BDa1Z5RVFlb3EvUlZlMWRCb1Nvd0RRUXhl?=
 =?utf-8?B?aytXRDVQaSt5a1BvUldJZnhYZ2FiVkZ0akZNcFFpNUs2dDVTZWt3ZkV0Mi9J?=
 =?utf-8?B?NzZqSWZDdXJKcUFjaVcyaTVtZEE1S3E0bzgvZ1drTyttRDVzRG92T3h5MEZ2?=
 =?utf-8?B?R1ZHUEhha2UvOWZMQlprbGM1T3pvT0lkL0xkbEIwdUVDaHg0dklnZ3RKUUov?=
 =?utf-8?B?d2h2b1JpTWk1VDNTYW05dnRLeE5jUXBxdmNPRFYydUlsYlhTT1RaVEo4cDZh?=
 =?utf-8?B?MUFkQ3pncTBtN3NFNlNxRk1BejVaRklaS0FrbGRJbXF2OVZrWUUxSDBXV2FO?=
 =?utf-8?B?TjZhcjB4Tm5TRVFLZEp2a3JJeHdab0wrSDgwazdBQzJ0RUI1Zm9HSGFDbkN6?=
 =?utf-8?B?WjRhY3lPQmdiZm5vNVBvK0U4cWl2WmZiN2VuYURDSVMzNVE5STlDc1d5cjlJ?=
 =?utf-8?B?NkxLNmJZS3pad2lheTAyVGFXdUxmQW9id1p3UnZVSFVMbW5NQ1BRaGpBdGdl?=
 =?utf-8?B?dXo3Mk1ncG5SL2svdXVsa2xSdnZrVmN2L0xtM3orM2VmbFo3Q1V1b0RJSHNu?=
 =?utf-8?B?OVpZRGd1VEZ3dVMrT3lEbTdvUDNCSnZIWlQxZ3ZYUW9TWkJLUE5xajRTQldD?=
 =?utf-8?B?TTdUN0JFdXplOXNJK3lnL0x0WlJHSWpoeVpBL2UyV2hLMUpmcUVqMkthbnJC?=
 =?utf-8?B?MVcvaFZ3SlYxVWpXMklpYTl4OVFJc0Rma1NlelJUSkF0Z3A1cHFsZDVGMkFC?=
 =?utf-8?B?UGtKZFlVc0xsNUVNb2xsSUZwN0RoTjNubmVRc01QajI4NWJJQnlBdXdwQ085?=
 =?utf-8?B?d2hIWFIxbUIyOHVha1ViTnpSNzcxRjBrL2U2MTZmS1NUMnRCN2hCQTdmRzNq?=
 =?utf-8?B?a2tEbzJXNmh6a3VNS1U5NFFkcjI2R1hTUFNVVVRTQXZVeStCZXZSdXdabmRl?=
 =?utf-8?B?YVRRWlNQWjdKdDFXNExkRXNUbGkvdCtnWmdGMzFuQXZ4ZW9HK0t6MFlPNzdF?=
 =?utf-8?B?d0pXMDUycVgwcG9mRkwxMGxXam9zK2diMlM1QXozRlRudWlMRWNrWlZuSVJa?=
 =?utf-8?B?bTRuUWZ3Z3J0NU00ejFFRXdTTUh0ZGxJYUd2M1JzOSt0b1lycUpRZHUwRDZG?=
 =?utf-8?B?clFsTTFpbldFTGVVMDFwNURIaEVsYlFzb2laU3BYb0F5T01INWFvVHFYejdm?=
 =?utf-8?B?RTl2U3h5NGNYZGpYQUk0NGtmTzdIRGZqWW1lTzVLdmR5ZlRSMG55SVQvOVJC?=
 =?utf-8?B?YVNHOXdkaEdTR0J2Z1B5WHZIb243Tkc4VTREZmlsbFVIMlgvVnU2ZG10WWpx?=
 =?utf-8?B?Z3ZuNFFFaUgxQnVaN3BhVWkwTzdqdTk1Qzl6Z3l5UzdMT1EwbllRR2sxZ0ZG?=
 =?utf-8?B?TmhyZUJma1pzQTM2ZVNTa1ZCM2dSR0d0cDRaamh1ZzJHNG96V1FMWjBOcUVY?=
 =?utf-8?B?WHltdzZIVWcwbTRmeHc4ckZoWWVkZWc5WVdBOXBUWUhZVzRUSmI5RTBES1Ri?=
 =?utf-8?B?U3hxSW9ETTNJOGhrMHRCUjU1dnZCL3RicGNuTEZnMWpOUUVjODhxZ3R1THVV?=
 =?utf-8?Q?8qpelMdKA57njxt1uP6GYEJg8vhGifay4hu0He7lrw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf7bd6-fd4b-4116-0ed4-08dc9f9b92ec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 22:16:11.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTBFSOG+OKp1xJtD/O1hUwhbDn+oU7wZ2VDd19dGSunAz2tkLwKPiZ3cS2+TJnRFXpH6EXeBB0CNiHZewviTnzjQUMx+EnxTDriFQaX4iDrVscHihVeLaVfBNw/xkESV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6704


On 7/4/24 06:23, Jeremy Kerr wrote:
>> +struct mctp_pcc_hdr {
>> +       u32 signature;
>> +       u32 flags;
>> +       u32 length;
>> +       char mctp_signature[4];
>> +};
> I see you've added the __le annotations that I mentioned, but to a
> different patch in the series. Was that intentional?


Yes.  Since the header is used by the Mailbox implementation now, in 
order to check the ACK flag.

It made sense to move the structure to a common location, but the change 
was based on your last review.


