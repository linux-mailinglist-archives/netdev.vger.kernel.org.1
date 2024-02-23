Return-Path: <netdev+bounces-74634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7788620D4
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD531F24D08
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27A14DFC6;
	Fri, 23 Feb 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHgVEdhD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1D14A0BE
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732626; cv=fail; b=UqHOwggyinWCUVYO/0N1+cxRTRg4Yf+BVb5J8CIfeG++sPgb2VQxCnh/qSf5hNaGUShe/TYkWUeHxO2pLtozvTunGrgQpEz6gWytot12lpXWATjBJLwWjMPUXOxquY5EP/tlk1P6C3pSSU58G6BZbQnQhZTnBuWLSRyNsdkk8x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732626; c=relaxed/simple;
	bh=Acl09oHHpHYHn1C4gUxLdsuswD02y4TkiVn4pLg3HyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHOTupRyw/bX4P3VtERIHqsfTiCZcnxQVonkxVXMInwhP0bpwH6Tqk/GOFjz96o9RpDMM7F3MhwAnaB41FE2EYC/1x5nRpH43fA81CT6KeUqvbGUni0Ddtr7TZoP7MRi/5c/u6GfSOq4eTANy8goCXpDIKI+i/9SZKGLsX53f7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHgVEdhD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708732621; x=1740268621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Acl09oHHpHYHn1C4gUxLdsuswD02y4TkiVn4pLg3HyU=;
  b=gHgVEdhD4Ln7O2rOMqCK3PhiDmP9sTvbiOUF5DiDc3LDC+UQryrDuCYF
   pcoVzp05oKg9zj8er9+YxC2PrTHWw3aebPn2GiIQ5qQyM96KzY+/h5Uw5
   b1oXXfYM3KDODErubrtUy5yrKqKLowUtghZNxCufl6JQwqEeYQtXWhX6W
   aPmJL9a1SxacT0GxebupcHkhJg43sUwEra62uOD2svuN6nu4qS4mqLDcg
   GnOzbMWgPzL6J+1mBqETKEjCS28PH+b3dsxDC7PQXl2uJHydmNd2H3rkO
   +KmSFcNDNkt/1ZTQQztaBsG7AuRWTAiMRMittv0CiaSMwpdxkPGvb9X9p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3216603"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3216603"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6038833"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 15:57:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:56:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 15:56:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:56:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7zLm27ToE5z0kdYFi4BW/cGOP7wnxT+QNybh67Age0bEAoTnuUEpzGKP9lD8x8Lp2WAIFIWBEJbN+3brspJ9OBXLXENgaqD5roMRssp6706+gFCus1jkRsL7h4MtH34YC0kZHYMsRMqXAD8JDTuCopkHhuWtTUMz/gztZ/VhWulPq/xSwTvccBvDxRh+iWq8aWsL1WhaCtw2aekRJi3BWbQUIKJHMbweOxpDpR0AFU5tIlTEYpIXaSpJ8S8XfVf8TrSLTQxzSWV3mNp9BleTm4NNd3Kmb2Gga8Ie+MUWah1BDZft+4aCcQso9wk8r3e+62JeXddrv/9Yz3sSkoD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuIu3HdcaRWzFT3BMCymJeTWaKKi1l/MkESKD2gbvQ0=;
 b=LAA14CiyqUaByydAuzeJuA/jwnYVdVDnIUzyDLfW0acCg1pc5QBvGhoY4BSzQxx8gbM8wYvRhZMEHUqzEqlUKCthcUIyFPaxQBGkyYEkzdBk0Xn7MCjqeamylqkudg1+DLRYcewDgalawm6nefaoZdvvFQniOfoT08J6TZ9QuKm+6TexE1wLFlsLQZBptFfYYrsVtHOZL8v4OWnmGiFJsR4iPlBmmZgiuYJQDyFLgo+eEnT5UYBXXghbK35yM+bE12RQa0MHzxU+uzyh933a1n7oq0I0GLD+w334VPeEjncjsPsZiAjXlDqqO/VARHArP+rmNeZzAn6M1VJh6pvLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 23:56:56 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 23:56:56 +0000
Message-ID: <ef0270c5-3128-40d8-933e-f9dbeddf5961@intel.com>
Date: Fri, 23 Feb 2024 17:56:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
To: Jiri Pirko <jiri@resnulli.us>
CC: Jay Vosburgh <jay.vosburgh@canonical.com>, Jakub Kicinski
	<kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Tariq
 Toukan" <ttoukan.linux@gmail.com>, Saeed Mahameed <saeed@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com> <16217.1708653901@famine>
 <b7b89300-8065-4421-9935-3adf70ac47bc@intel.com>
 <ZdhoBOKc40DeVCfG@nanopsycho>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <ZdhoBOKc40DeVCfG@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1275e8-5be9-4f0b-4a70-08dc34cb1db5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdsiesjWIVnx3rStys/AO8meAG8RmHsXl7gbc+tiRviUtjIzOJrkWnL7fy3F2iUjKQpu2GkpdyXWu2y98Hc7PcA0KOPOQH60mOn4YciNuhugxQcukX4MLPct/UtyLeQIrLSHetkKICbdV3QLsi7ludW3sZCkv3P1Md1WH7tjDi+8S7Y1GDAKnika+g4C/BeH7slLTh9WFQzMv5EL+uD6sQ9NWte5niksoeVCAuSuRLmSr7UXKFtimJi8uA8RumH3qXkbpKcXUp0Y0IhMqkltxUbOOVfO6fxCoXN8wFld2owXTpUjJ+PzxfTDNKkdkunAEaOVPp/dV8FkrnDyPTNESV0zc7P8Q8+AfopH685j3NnLD9jwMZnz1ujEH7dbvBpnr6sBHjbKumW1t0hB2dMvoekHADymyhDIV6odoUSZteeIfC1pKz3qZIgGDPCekzbRAeIAZ7a5nvBzWbkOWC7dXITxV7/lT4qpwhazwKHOeO2p4C83iMqLBLXAYPn5NF1KdIhKlsyxCPZ+FJ4yzbjRxePfCXPO70hBJQFw/gOQ3GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZ6Wm42L0IvdlFtb2N6a1p3ZTRYVjVUWmFLeEh1Vkc4K3I0emc4RE5tV21R?=
 =?utf-8?B?cTVlcTIvMTlpamlZQ1RuRmRyMjFhYURnckdpT1orNEVYNE9UK2JtVncvNVZp?=
 =?utf-8?B?VnY3ZHpidDQ5Y3M3OU1tRVQ3QVVTbjh3dzNGZUR6OGlkVFZDaXRHYUFobW56?=
 =?utf-8?B?WGU5NGpaQlVxeDIwbGdJMXh3S21NQjl0WlFObnNBWEU3K3grNHNQUEo2QnVu?=
 =?utf-8?B?SkV6L3VZV3dDUzRUSlJhaGhBRFJBNWQ3bHZXTjEvMkJpQ2NoQ0d1bGs1WHgv?=
 =?utf-8?B?ZzE4U3YwejNhZEhxMngxcVZsQWYyMkp6dEJZazEyek9IUDZ1VDd0VkIrNlA1?=
 =?utf-8?B?MVZhRWdRS1E5VU1WWUJ0WEdnUGt5Zk9MdTJ4OWk0R1c3ZnZncmJMeldTZTRi?=
 =?utf-8?B?NlhSemlKNSsxa2VxSG0vN0E3Rk5LSjVRWEN2bjFhRGgyYlEzekVZcWpGN0pl?=
 =?utf-8?B?N285Q3YvMjFSZXc5MmlrRVRGOXR1VWhwbHJtWDlDZ2xzWkNKV2NEeGsvb0ta?=
 =?utf-8?B?UEtaL0g3U3JYR2NMQVZMai9vVTgxUkFzbnpCclVuVFIzaGtBKys0dE9qT0ZY?=
 =?utf-8?B?WnAvK0xid2x4TVlXWDZuSWZVbnJGQlorVnJMVEtqU3RsVmYzczQ2dmMybTdQ?=
 =?utf-8?B?bmJPVGdiaG5TditxMFBiK1EvdXRUdW5vNUVORFR2bER3a21pYU95RlgxbkhC?=
 =?utf-8?B?Uis5UWFKRjhJZEZjekJiSE1BdGNvKzlLZzRoR0JzN1FkUFpwczlxR3B1SkNs?=
 =?utf-8?B?Z1FqNXZCWXMzTVAzNm9ZQ2lMZUFoSFlhRkJhd0ZrWFNSV2tQTkdrYWhDUmE3?=
 =?utf-8?B?MHZIN1RDQTBpTE5oaHFmRm4zSnhZdTlTUFFXY0xkUCtIWmp0b3g5Vk1GcmFk?=
 =?utf-8?B?TDdPSmI2VUFNTlYwd00vTHB2OWZFKy9TclJiRm9pWnY5RzJNZFN0aFEwbGgr?=
 =?utf-8?B?QVZ0M0VXK01HUHFsWUxhem5vU1RVc3FrU0hjTDZFS2FmSUtranZJdHV0ZXhy?=
 =?utf-8?B?WEJCUlhzcmlZZE5hRWJ6WEd1ZlJVam91YVlGUFZCS09vWHR2NlJ5cEczbFc4?=
 =?utf-8?B?QmJBbVRSMnE3YS9KTGpmRDhPRlRNYWFQTTAzNnc5eFR6TXA4blZ6WC9icDlw?=
 =?utf-8?B?NDJWOWp5SmRxQXlzc1FoM0lDTytpbW9KdTN1YUxLMmYzeEVBMWg1L3ZLalVy?=
 =?utf-8?B?QXdmK1g4MjREdEI0d3lUZ3VlcmNxMUV1NnpUcXlQTlRLRTZONWxwUm13clVx?=
 =?utf-8?B?cG9lTTdKalRpTUhKaFhtbGJ4WEtZalhCMElnY1lWdUlPMUlVak9DM21WQitW?=
 =?utf-8?B?bEtYOUM0VGtDMy9HSFEyRytCMTVWL2pBcXkwVjl4WVBxaFhGRGhlamVudUp2?=
 =?utf-8?B?T09NRWtVU2JZY1lMNlZIZ1UrZGpsaWgvWkd2VzlzaHR0MDJJcmNuR3lxdlRj?=
 =?utf-8?B?L3BheHN1RTZZdHFKZmJEU3lvZzB6dFZCT3ZBbjgrcjN0S2E1a0JHS2VROHFR?=
 =?utf-8?B?L3k1eUt1bHRmZTRMQ3NJUHhnY1EzeFVIMVJVdi85czZmM2I1SmpHaUJ3amc0?=
 =?utf-8?B?TXdOMEJ4YnVjcjlFSDZGTjgyczh1ZnRYNDY3RE9yMjFsRTl4cnkyRU5NME5t?=
 =?utf-8?B?RzlteFVPY1ZlVk8rSjRMQmtFZXJBd1Fhb0wzRGNRMUpFVzdDMkVaZmdIQ0x0?=
 =?utf-8?B?ZFZRekJRUTNzbDN4NVdBTXN6anRkelJmS1pSZG42aURTYTNTWG5Bd0hlbnJC?=
 =?utf-8?B?OXEzM2M5dzk0Vmw4cFB5YktBKzhiNVpSR0pIZHliMktpbTdWUXdHR0pXeEJj?=
 =?utf-8?B?eHlGbXNHVndOTGlMVWRLK2xwL25XRnlqZ3AzelhmUXB4UnlCMmhLenBnZUw2?=
 =?utf-8?B?N2JzT3FiajRWRmp2UnY5NTdkak9zbWs5WWRUM05Oc2xieHlLa3NTTnFmM1VD?=
 =?utf-8?B?SHY3ZXZrZWtMa3BZOXhTT2JFU3RWWGNQZk9ua3lvV1l0ald1eHkrWHBtUFVT?=
 =?utf-8?B?QnVIVHN6VDZWQllNTVAzT1V2T1U4QlR3WkJYQi93R202cmQ3U0lTUkI2TjB5?=
 =?utf-8?B?dm95Q1l5U3VtcVFnRDZGZzliK3pKaGNLZHA1QmdTbTZpN3MveFBMdkxFOVpT?=
 =?utf-8?B?SFQ2cS9JU01Cc2M4bkdqRXJnU24yejBUbHdERzVkYnFvaGZ1ZFVLdzRRYWVt?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1275e8-5be9-4f0b-4a70-08dc34cb1db5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:56:56.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPx10MZKt4fMDhVR9p4b8fUgKAF/t2uDNmfEsnvYq1TOt6LipAgiND/g2WDrHJZzhuzm0s0feoPVdSrOp5DOcGKQL7/j0QkfA40qEMRn6AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com



On 2/23/2024 3:40 AM, Jiri Pirko wrote:
> Fri, Feb 23, 2024 at 06:00:40AM CET, sridhar.samudrala@intel.com wrote:
>>
>>
>> On 2/22/2024 8:05 PM, Jay Vosburgh wrote:
>>> Samudrala, Sridhar <sridhar.samudrala@intel.com> wrote:
>>>> On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
>>>>> On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>>>>>> On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>>>>>>> Greg, we have a feature here where a single device of class net has
>>>>>>> multiple "bus parents". We used to have one attr under class net
>>>>>>> (device) which is a link to the bus parent. Now we either need to add
>>>>>>> more or not bother with the linking of the whole device. Is there any
>>>>>>> precedent / preference for solving this from the device model
>>>>>>> perspective?
>>>>>>
>>>>>> How, logically, can a netdevice be controlled properly from 2 parent
>>>>>> devices on two different busses?  How is that even possible from a
>>>>>> physical point-of-view?  What exact bus types are involved here?
>>>>> Two PCIe buses, two endpoints, two networking ports. It's one piece
>>>>
>>>> Isn't it only 1 networking port with multiple PFs?
>>>>
>>>>> of silicon, tho, so the "slices" can talk to each other internally.
>>>>> The NVRAM configuration tells both endpoints that the user wants
>>>>> them "bonded", when the PCI drivers probe they "find each other"
>>>>> using some cookie or DSN or whatnot. And once they did, they spawn
>>>>> a single netdev.
>>>>>
>>>>>> This "shouldn't" be possible as in the end, it's usually a PCI device
>>>>>> handling this all, right?
>>>>> It's really a special type of bonding of two netdevs. Like you'd bond
>>>>> two ports to get twice the bandwidth. With the twist that the balancing
>>>>> is done on NUMA proximity, rather than traffic hash.
>>>>> Well, plus, the major twist that it's all done magically "for you"
>>>>> in the vendor driver, and the two "lower" devices are not visible.
>>>>> You only see the resulting bond.
>>>>> I personally think that the magic hides as many problems as it
>>>>> introduces and we'd be better off creating two separate netdevs.
>>>>> And then a new type of "device bond" on top. Small win that
>>>>> the "new device bond on top" can be shared code across vendors.
>>>>
>>>> Yes. We have been exploring a small extension to bonding driver to enable
>>>> a single numa-aware multi-threaded application to efficiently utilize
>>>> multiple NICs across numa nodes.
>>>
>>> 	Is this referring to something like the multi-pf under
>>> discussion, or just generically with two arbitrary network devices
>>> installed one each per NUMA node?
>>
>> Normal network devices one per NUMA node
>>
>>>
>>>> Here is an early version of a patch we have been trying and seems to be
>>>> working well.
>>>>
>>>> =========================================================================
>>>> bonding: select tx device based on rx device of a flow
>>>>
>>>> If napi_id is cached in the sk associated with skb, use the
>>>> device associated with napi_id as the transmit device.
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>
>>>> diff --git a/drivers/net/bonding/bond_main.c
>>>> b/drivers/net/bonding/bond_main.c
>>>> index 7a7d584f378a..77e3bf6c4502 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -5146,6 +5146,30 @@ static struct slave
>>>> *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>>>>          unsigned int count;
>>>>          u32 hash;
>>>>
>>>> +       if (skb->sk) {
>>>> +               int napi_id = skb->sk->sk_napi_id;
>>>> +               struct net_device *dev;
>>>> +               int idx;
>>>> +
>>>> +               rcu_read_lock();
>>>> +               dev = dev_get_by_napi_id(napi_id);
>>>> +               rcu_read_unlock();
>>>> +
>>>> +               if (!dev)
>>>> +                       goto hash;
>>>> +
>>>> +               count = slaves ? READ_ONCE(slaves->count) : 0;
>>>> +               if (unlikely(!count))
>>>> +                       return NULL;
>>>> +
>>>> +               for (idx = 0; idx < count; idx++) {
>>>> +                       slave = slaves->arr[idx];
>>>> +                       if (slave->dev->ifindex == dev->ifindex)
>>>> +                               return slave;
>>>> +               }
>>>> +       }
>>>> +
>>>> +hash:
>>>>          hash = bond_xmit_hash(bond, skb);
>>>>          count = slaves ? READ_ONCE(slaves->count) : 0;
>>>>          if (unlikely(!count))
>>>> =========================================================================
>>>>
>>>> If we make this as a configurable bonding option, would this be an
>>>> acceptable solution to accelerate numa-aware apps?
>>>
>>> 	Assuming for the moment this is for "regular" network devices
>>> installed one per NUMA node, why do this in bonding instead of at a
>>> higher layer (multiple subnets or ECMP, for example)?
>>>
>>> 	Is the intent here that the bond would aggregate its interfaces
>>> via LACP with the peer being some kind of cross-chassis link aggregation
>>> (MLAG, et al)?
> 
> No.
> 
>>
>> Yes. basic LACP bonding setup. There could be multiple peers connecting to
>> the server via switch providing LACP based link aggregation. No cross-chassis
>> MLAG.
> 
> LACP does not make any sense, when you have only a single physical port.
> That applies to ECMP mentioned above too I believe.

I meant for the 2 regular NICs on 2 numa node setup, not for multi-PF 1 
port setup.

