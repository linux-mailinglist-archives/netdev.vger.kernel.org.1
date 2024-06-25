Return-Path: <netdev+bounces-106561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AAD916D3F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AA41F21275
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC614A4D2;
	Tue, 25 Jun 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/+NRXut"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1D1CABB
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329878; cv=fail; b=XP8WIbnqZiy6qFNtXlP/EZZZtMFmIrdrdfdcp/mQKIM92/ri+mOLJuLWJ9s0Kd+JvSIBcigtyjqLfuibH4iQd9gvpNlArchKlFDETePK3O7NTVJ/Dp04MKI0lbiNiANRxR/hsS35zL/7FLXWxCXQQP7AYMkILTC7xCL9O59GePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329878; c=relaxed/simple;
	bh=OqJ0FYer9Ig1mC4k5MnKR2xRelFbbF+olKmeedu0DTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rtrl6CmXjzhgtLoYtus+pWwzmdvOr94PAK6C3K7cTrF+cnFDBTVm/B4yCC/YkCHVO2052GaRYCwziI6iv17wUGxYJnSbh1ZK8DqpJnIwn0R0eE3UciHKTlkLrtyJcSkGv2mFULMH2K/QWE7pyGdzg0wXOBp56UmEp8pPYIOLNYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/+NRXut; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCky575z92n3oOZRRFuiq7iCnnXueQJrwHaDMhi+EczUZbgzEMeO4z3gb6WGA/pNWuq1fzJTBi8AMjkveOykuCqX8aI5XY7F3zqY+2+GL2bAQflXrTf73bXnA8MLtmFtPvO4q+RvoKSH7k9m8E9zacdJI3pz04kHglhu92AV4RcUenhWmdBsNULMqmFuLr6MLRGxD8BRorEu5/3/aMQ8/N62binDb0xJvh1FlLPNMExOPymBP6B6XjuOHTJEkEArIDSGDZgOGth4DE3Fwurq+KLDeGEgzK9ymRYiq53/E4VzA4W1HF7OW5oEccaXPQauAB+gPRo2DkSDJ2YZXHNRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqJ0FYer9Ig1mC4k5MnKR2xRelFbbF+olKmeedu0DTc=;
 b=M0JfSGhx9+8bG9gAYzMYDit9pLwl1Z8X5EJCW2aVI077zKvnmj75ODHPknplNRTvI2uR2ju+zNx7DIAY2pbcSMugSKwPenxfVHoNP/CrZ8CTMkJJYVs3ZrqaMlG1idM4tD5IxtIwIZKIb3qEosQBpC00cFq1R7JDe7ihXp53uUGJ9EY2OhThyJLpMsLGy4abmTe3UzGdOJMdBtVUFpEMlfPBa+tNPUJh2K21j9xdWVZvD02zboy8sCIWjx1Fz2cUj+W0HsnbxpOnJwZDKSrSKV65vim3jgRg4UGTq0tY0C7ZC//OW7VvxMqwXSrdsh2TULAfQtbKlRHoLQkn0+DAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqJ0FYer9Ig1mC4k5MnKR2xRelFbbF+olKmeedu0DTc=;
 b=h/+NRXutvoUPvRFuvvY4yTzQsp+oPwNpXCsQ95RjQ/PV7+QXtBJeF4IFnyGtsaO0PSOVlj7ofSE7gZJqHNtRsFBBuontgStYLfOPPdVvU+oDbwuPBXX+S6wJlInn8XmdrD8jin/AitHfTSgokIIWmZgS4PMm7M08RBlMcm8Rna5ev96PbMDsku3hZj/19kJtU2X7UcUduRbZObIRaS/QC0iR3tKN8YztoVMqc/PVuSgUsSd3+WOQ6WKWSL892hLJ2zj1QsEyZcckO7mCT0RmMwTktJiXrL3TqGJYJgZcH3wyw2Lwizr+psBHpo2h4YmLu6Jz+znrH83nrwUnkUxpxw==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:37:53 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:37:53 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"hawk@kernel.org" <hawk@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, mlxsw <mlxsw@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 0/4] Adjust page pool netlink filling to non
 common case
Thread-Topic: [PATCH RFC net-next 0/4] Adjust page pool netlink filling to non
 common case
Thread-Index: AQHaxvhwwSzN4sa9qUGW2sNo1fdEc7HYi+SAgAAPzHA=
Date: Tue, 25 Jun 2024 15:37:53 +0000
Message-ID:
 <BL1PR12MB5922812514E3484191A929CBCBD52@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <20240625120807.1165581-1-amcohen@nvidia.com>
 <20240625073525.5b1b30a1@kernel.org>
In-Reply-To: <20240625073525.5b1b30a1@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|SA0PR12MB4399:EE_
x-ms-office365-filtering-correlation-id: dc229403-48d8-4761-9f9b-08dc952cc737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2ZzMzJrVkFYeEJZQlB0NVVOZlB4eDNqeVZ3SnVMY0NXRFByakZSSzlZSllo?=
 =?utf-8?B?dk8zSkFrWEJpQm5KdngydzY4UFBmQWRpQVFwQWtuckYzWXo1VWVFVnpzeEdt?=
 =?utf-8?B?b0FOSzVMUmhjNy9XN3pTSzM2STVwdlUxL2lrT1ZQYUtGTDQxNFNjNTFlUDZN?=
 =?utf-8?B?ajY0UTB5SHROUFh5RkRzUzlWbmVPeVZiRVZyWGZUZDdlTWlycm1xZGNOMUN5?=
 =?utf-8?B?RURobHhVbnUvNnlIZGlObkE1Q2c4QmR4c1YyeTJKOW9la2crL2Ywb1VMOGY1?=
 =?utf-8?B?d0FGYUttU2hLTU1VVDMwTkVhTjJnVm1ycU9vTUt2NFZGd1dZamJyUmp0Q2Fy?=
 =?utf-8?B?SjZWQ2dpdXZQU0ZtQ0ZDRWNGWmc2RngyZDRqTkgrQnVqcTQxMjh5SFl4enEw?=
 =?utf-8?B?MSsvRTN2Vm1xanhWZnUxWnNwZXduT2RkTDFxcmluTjNUZXI5NlI4eWhvdldv?=
 =?utf-8?B?ZjRMWEpwenlvL3hTUFhmUXhaeUs3VWtnMlRtam9NZ3FVUURWZExsbno0U25K?=
 =?utf-8?B?bUZpT0MxejZOR24zcGNEM255c28rNnQ4T3lkQkRUbklxTFk3eS9MMlBEcEZS?=
 =?utf-8?B?djcvVkdnWmJaaTYvZ0hTcEtzQ2oxZ3ZvKzBlM0xBNzZBc0dndEhHM3Q5V0hF?=
 =?utf-8?B?eXc2cHYxaFFtVGpVZTlQd2NzTU1yTVgwMzVicUdpdE5KaFlLKzNYZFBTRmt1?=
 =?utf-8?B?YndENnhxaEs1MXE5Qk14ZXIxc2FVZ0NROHRpMHRFT2hkbzR2UlMxOHpnQUxJ?=
 =?utf-8?B?ZU9SY3VObFIzeVFaWDlLdzNxQno4QzIyQktFRnd4ZkhkS1Y3SFl1RFRwT3Bj?=
 =?utf-8?B?ckczMlRmMXhUZmd6aXJRY0gzKzB4OHVOOXpCOWh5bzZQMHY0RW5rUlBVUHJD?=
 =?utf-8?B?ZVhiQkJvOUc5ejFUeWFNb09KK1RoN1p1S2hzYjlBd2ZVZXFwUjRDVFdKZ1BQ?=
 =?utf-8?B?a0ZYVDhoTDVwVnZ4Mk1KOHdFWUM1bk5jUTJoMHN1WXgrM2wzSWIxeDVqcEs4?=
 =?utf-8?B?SnNoS2N3RlhsTWltYUt1OTZWNmNnZkM0STlrQU9rUkd2clRFY2hoamZOUEts?=
 =?utf-8?B?UGdhM1VsVzdBUU91R2tMa3NTWUlxc0hYUUpOZGZYdXBpeUwzUUdvU1p0VmZU?=
 =?utf-8?B?aVlpUFdWczR2VFJodHFCL0d2bkpHWVlNb21mNEMvS1o0dVFQNGFFRmRZbGs1?=
 =?utf-8?B?OGdyM2EyYndzZzh0K1M2aFdMOXAzNWJaU3ZiZkd5alFVTWg2UHRuQWJMWUtv?=
 =?utf-8?B?QXJZRkJ0Y1dUN1B6MEVlY3hEcEpNVFgzZmJxZkdscW1oaGVIdlhqYnE0bnRZ?=
 =?utf-8?B?VC9JN2hoRnV1eU52K2hDVVBmNS9nS1BuWVZ0M01ieUlwZGlkOTBFazg1d09W?=
 =?utf-8?B?UW5ubzI3Z3dYS0NobjE4V1JkZit6VVcxUVVyVlh1MUQ1aVdrTXMzOFBMd0Zx?=
 =?utf-8?B?TW1nV0tNVElQWE9udGZmZmFoODM1aDVxdDVBaEdKS01IcFV2ajBPdzQrc1c1?=
 =?utf-8?B?aEFBR3FwRXR2L3A5ejA4L0VLUnJZM0pXbVcvQzNEdmtXMDE3QWYyMkcwbG5H?=
 =?utf-8?B?MlBobEFlaXJqRHF3RXJpTDFsVlZ0MU5LRzM0UzVUbVIyc0VaM3FyQWVUa2Zu?=
 =?utf-8?B?YWN1eStkZFdpZnpFUWJXYUFoQnp1cmhLbFNBeXNCdWNrMmtrRFBBRzFGNnpH?=
 =?utf-8?B?WWdxeW5KL2lNWUtPMkJuc1NSRXVodGJlYkMrdWErS01iUUg3eHN1WWNWY25v?=
 =?utf-8?B?UGxUNW9Hb2pzQU1oNGp2eU1hSXd0UlJFNjVpUXFjckZ3ZDUwbkNLbzFrZ2du?=
 =?utf-8?Q?NT3cFKD+GArUpaVg2bHlDhHvBKBjeB3IHdSFw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0twQVFSdklnNjVmTXJEUUJZWndGUTNGSFlFdmY1VmdhcmY3V2VaeWR2NHZH?=
 =?utf-8?B?akZQQmRRd0xnOERJcDFXdjdwRUNFYUFSRWZPUFAwVi8vR2ZJZTREYWlvUm40?=
 =?utf-8?B?Y0dKNXFKeGMvcHpBTjBuS2FVYmc0dzhCdDJCdVJQek1WZnpjQlNZR3dMZHd4?=
 =?utf-8?B?MUpFaWptOUVDZzdRMU5KOU5SVWFQa0trRlVHZ3ZpcElFTmZvbUt2cFk0UEJJ?=
 =?utf-8?B?VGhlbzBtdFZNMHpqN0RIWHRncjVCcDB3MEovbnVXMUxEck9OMDdOM3N3Vlhk?=
 =?utf-8?B?SE1pdDNKS1lLa0Fwb3ZhVW5ueXUxbTNvN1F3SWExYjNuellrSllVYnRIaWJY?=
 =?utf-8?B?amVPb1F4MEkvRnVydmRucWduTnNaajQ0cTFocG1JSUh1Y2NjTTZYQlJkZnNm?=
 =?utf-8?B?cmsyWmlSOC9KRU9KRGErUjkvbmJSL09QS201cUx5c0tLOTNDcFY4VW55TXY3?=
 =?utf-8?B?MzVyaml0ZkYwdmY1bzZacFZlenA1dkZqRTkxK2hLVFY3T0QvM3g3c0E5NW1v?=
 =?utf-8?B?djdDV3krVE5ZYklPck1FamIvWElTQkNNUkdFOHVpOXB0WjFkYmZSYWJ4eXIw?=
 =?utf-8?B?RytpKzRDUXdYV1JUL1pQYlF1eHh1K3ptM3luVVk3MjR6eCtUeHB5RytzNnVX?=
 =?utf-8?B?WEdXWVFCMXdwT0NOdTZlS2xZZSsrR09EQldmOUh3VTNBQ3NqWmJUcXhKSFhW?=
 =?utf-8?B?RXB0WHlMQ0VlUnJLSG1ucE9zQ2lYS0RhNUtwQmV1c2tMbUFRSmNTa05UUkN4?=
 =?utf-8?B?TXExTEMvRkl4bzZBSVZTNnd1MDZDeHlDT0c4azZPNG4xTXZYOTRZL01RZ20y?=
 =?utf-8?B?clVqY1JLL2dSMDk3R1h2Sm9EL0EvQzV0azJZRW93b3F4ajNPa3FHNmViQzgy?=
 =?utf-8?B?ZmQvb1U1V0RnY1pjcUN4VHRaem42a0p3Z0wxVk5jb25rOE0yekNySFVITWdW?=
 =?utf-8?B?VkM2ckJENEJtamdWUTd0ZUxKOHlMYUMreklIK24rUVQyM1BHZTB4WDlsTHNs?=
 =?utf-8?B?a3JBckZsLzFPR2I2OWRJcnc1Tm1HTndiVGkwWGg0a2FVd1Z4TUlDUE1tTUZu?=
 =?utf-8?B?cmVzeHZUdVdCRXkrNGc5WWpQZ2lnRkpFQWV0VTEwallyb2dEd2w1c2ErUEU3?=
 =?utf-8?B?eVN3UmZhRFcrblo3YlU2OEZpMTVsTmVSRzR6b2lDQUEyK2VON0dyMi96ejFX?=
 =?utf-8?B?SFVrbkJ2WjZmaWs1WDRPN3BHbFJOdnRmRUpuR3hXODlUNE51QzgvenZJT01Z?=
 =?utf-8?B?cWtOWDZmK1UySjkvZjl4V0N1ME51QnJiMGdUQ2VLMzlabUVzNnd1Wnk1NzRo?=
 =?utf-8?B?ZlRSZXJlUVp4QW40cFRYRDRCd3F0TEJVcWV6TEtQNEFWVFJUZmVOYVhiV0xl?=
 =?utf-8?B?NWZYZU11cnBrWEhha09CQXZlS2JxYTB4UmNWTS90VERQbzVEUVc1UWN6UXJP?=
 =?utf-8?B?Z0t4ZTRJOUZRejJGODZoenVNRUR0SFEvRVYzSi9RMWlSakRFbGFqWjhFbld3?=
 =?utf-8?B?VXBSbG9IbU9Rd0ZiQytCZWlLaytObkhVSUNRSkNQa2RQWnJueFZpV1dGbVlm?=
 =?utf-8?B?UXlLK0l4VkFVWWtHclIzaHhFbFVWTjhrQzFGU0dManMxdmNFRGswRGplYjl1?=
 =?utf-8?B?TndTMExnTHArMitIaEptcG5oOEFZV1ZmNnNkNzRuclJUcUN5VjJqT2FFb3Iz?=
 =?utf-8?B?cW0rQkcyU2JVMDZNZzZtM2lpZ3JXN3VYZUZ4QnlJRkJUbU5DZ05TK05zVk8x?=
 =?utf-8?B?ZWFUczBEV2ovaUpRR2MwcTZDMUZWU2lDVE9EbFJIckhMMzk4WlgwclJTb1dG?=
 =?utf-8?B?OExjQURzRzVsaVVEeUhnTEc4aW85cUlmMStCSDQ1bUFGZjFDaE41cExPOWhs?=
 =?utf-8?B?cHZtbmI5TStzbW1HK2w5Rk8ya0Z0cWVhRU5OR2JKdVVoQk56WUNnZkpJVHNT?=
 =?utf-8?B?UkxRRUZCLzIrdFZxK1d4alBGbml4S0hndmZGYzZ0TFhHVmgvTWxIVkpNR0FU?=
 =?utf-8?B?em5DNTVrcHZrL2dvMjlCdS9qQWFPVnJNR0xFMmpucDczTFpZcTlZY2JqRG1X?=
 =?utf-8?B?YitxM3VXdnZwNU9lVlgzaENNZW5jeEJyS1dxanRZYllDQksyWVhRTHVCakR2?=
 =?utf-8?Q?YgJi3ECL4mfoFm1uMEmNVsByv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc229403-48d8-4761-9f9b-08dc952cc737
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 15:37:53.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXkgV0ZUfE1LlQAlA2fceJA4P6Ji/CctggOw2rqJLU8oMpprrfQdkuYHAr9DwexabCfi7aQEH6Bq4UQUhDtMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgMjUgSnVuZSAyMDI0IDE3OjM1DQo+
IFRvOiBBbWl0IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsgaGF3a0BrZXJu
ZWwub3JnOyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPjsgUGV0cg0KPiBNYWNoYXRh
IDxwZXRybUBudmlkaWEuY29tPjsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIG5ldC1uZXh0IDAvNF0gQWRq
dXN0IHBhZ2UgcG9vbCBuZXRsaW5rIGZpbGxpbmcgdG8gbm9uIGNvbW1vbiBjYXNlDQo+IA0KPiBP
biBUdWUsIDI1IEp1biAyMDI0IDE1OjA4OjAzICswMzAwIEFtaXQgQ29oZW4gd3JvdGU6DQo+ID4g
TW9zdCBuZXR3b3JrIGRyaXZlcnMgaGFzIDE6MSBtYXBwaW5nIGJldHdlZW4gbmV0ZGV2aWNlIGFu
ZCBldmVudCBxdWV1ZXMsDQo+ID4gc28gdGhlbiBlYWNoIHBhZ2UgcG9vbCBpcyB1c2VkIGJ5IG9u
bHkgb25lIG5ldGRldmljZS4gVGhpcyBpcyBub3QgdGhlIGNhc2UNCj4gPiBpbiBtbHhzdyBkcml2
ZXIuDQo+ID4NCj4gPiBDdXJyZW50bHksIHRoZSBuZXRsaW5rIG1lc3NhZ2UgaXMgZmlsbGVkIHdp
dGggJ3Bvb2wtPnNsb3cubmV0ZGV2LT5pZmluZGV4JywNCj4gPiB3aGljaCBzaG91bGQgYmUgTlVM
TCBpbiBjYXNlIHRoYXQgc2V2ZXJhbCBuZXRkZXZpY2VzIHVzZSB0aGUgc2FtZSBwb29sLg0KPiA+
IEFkanVzdCBwYWdlIHBvb2wgbmV0bGluayBmaWxsaW5nIHRvIHVzZSB0aGUgbmV0ZGV2aWNlIHdo
aWNoIHRoZSBwb29sIGlzDQo+ID4gc3RvcmVkIGluIGl0cyBsaXN0LiBTZWUgbW9yZSBpbmZvIGlu
IGNvbW1pdCBtZXNzYWdlcy4NCj4gPg0KPiA+IFdpdGhvdXQgdGhpcyBzZXQsIG1seHN3IGRyaXZl
ciBjYW5ub3QgZHVtcCBhbGwgcGFnZSBwb29sczoNCj4gPiAkIC4vdG9vbHMvbmV0L3lubC9jbGku
cHkgLS1zcGVjIERvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFtbCBcDQo+ID4g
CS0tZHVtcCBwYWdlLXBvb2wtc3RhdHMtZ2V0IC0tb3V0cHV0LWpzb24gfCBqcQ0KPiA+IFtdDQo+
ID4NCj4gPiBXaXRoIHRoaXMgc2V0LCAiZHVtcCIgY29tbWFuZCBwcmludHMgYWxsIHRoZSBwYWdl
IHBvb2xzIGZvciBhbGwgdGhlDQo+ID4gbmV0ZGV2aWNlczoNCj4gPiAkIC4vdG9vbHMvbmV0L3lu
bC9jbGkucHkgLS1zcGVjIERvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFtbCBc
DQo+ID4gCS0tZHVtcCBwYWdlLXBvb2wtZ2V0IC0tb3V0cHV0LWpzb24gfCBcDQo+ID4gCWpxIC1l
ICIuW10gfCBzZWxlY3QoLmlmaW5kZXggPT0gNjQpIiB8IGdyZXAgIm5hcGktaWQiIHwgd2MgLWwN
Cj4gPiA1Ng0KPiA+DQo+ID4gRnJvbSBkcml2ZXIgUE9WLCBzdWNoIHF1ZXJpZXMgYXJlIHN1cHBv
cnRlZCBieSBhc3NvY2lhdGluZyB0aGUgcG9vbHMgd2l0aA0KPiA+IGFuIHVucmVnaXN0ZXJlZCBu
ZXRkZXZpY2UgKGR1bW15IG5ldGRldmljZSkuIFRoZSBmb2xsb3dpbmcgbGltaXRhdGlvbnMNCj4g
PiBhcmUgY2F1c2VkIGJ5IHN1Y2ggaW1wbGVtZW50YXRpb246DQo+ID4gMS4gVGhlIGdldCBjb21t
YW5kIG91dHB1dCBzcGVjaWZpZXMgdGhlICdpZmluZGV4JyBhcyAwLCB3aGljaCBpcw0KPiA+IG1l
YW5pbmdsZXNzLiBgaXByb3V0ZTJgIHdpbGwgcHJpbnQgdGhpcyBhcyAiKiIsIGJ1dCB0aGVyZSBt
aWdodCBiZSBvdGhlcg0KPiA+IHRvb2xzIHdoaWNoIGZhaWwgaW4gc3VjaCBjYXNlLg0KPiA+IDIu
IGdldCBjb21tYW5kIGRvZXMgbm90IHdvcmsgd2hlbiBkZXZsaW5rIGluc3RhbmNlIGlzIHJlbG9h
ZGVkIHRvIG5hbWVzcGFjZQ0KPiA+IHdoaWNoIGlzIG5vdCB0aGUgaW5pdGlhbCBvbmUsIGFzIHRo
ZSBkdW1teSBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBwb29scw0KPiA+IGJlbG9uZ3MgdG8g
dGhlIGluaXRpYWwgbmFtZXNwYWNlLg0KPiA+IFNlZSBleGFtcGxlcyBpbiBjb21taXQgbWVzc2Fn
ZXMuDQo+ID4NCj4gPiBXZSB3b3VsZCBsaWtlIHRvIGV4cG9zZSBwYWdlIHBvb2wgc3RhdHMgYW5k
IGluZm8gdmlhIHRoZSBzdGFuZGFyZA0KPiA+IGludGVyZmFjZSwgYnV0IHN1Y2ggaW1wbGVtZW50
YXRpb24gaXMgbm90IHBlcmZlY3QuIEFuIGFkZGl0aW9uYWwgb3B0aW9uDQo+ID4gaXMgdG8gdXNl
IGRlYnVnZnMsIGJ1dCB3ZSBwcmVmZXIgdG8gYXZvaWQgaXQsIGlmIGl0IGlzIHBvc3NpYmxlLiBB
bnkNCj4gPiBzdWdnZXN0aW9ucyBmb3IgYmV0dGVyIGltcGxlbWVudGF0aW9uIGluIGNhc2Ugb2Yg
cG9vbCBmb3Igc2V2ZXJhbA0KPiA+IG5ldGRldmljZXMgd2lsbCBiZSB3ZWxjb21lZC4NCj4gDQo+
IElmIEkgcmVhZCB0aGUgY29kZSBjb3JyZWN0bHkgeW91IGR1bXAgYWxsIHBhZ2UgcG9vbHMgZm9y
IGFsbCBwb3J0DQo+IG5ldGRldnM/DQoNClllcy4NCg0KIFByaW1hcnkgdXNlIGZvciBwYWdlIHBv
b2wgc3RhdHMgcmlnaHQgbm93IGlzIHRvIG1lYXN1cmUNCj4gaG93IG11Y2ggbWVtb3J5IGhhdmUg
bmV0ZGV2cyBnb2JibGVkIHVwLiBZb3UgY2FuJ3QgZHVwbGljYXRlIGVudHJpZXMsDQo+IGJlY2F1
c2UgdXNlciBzcGFjZSBtYXkgZG91YmxlIGNvdW50IHRoZSBtZW1vcnkuLi4NCj4gDQo+IEhvdyBh
Ym91dCB3ZSBpbnN0ZWFkIGFkZCBhIG5ldCBwb2ludGVyIGFuZCBoYXZlIHRoZSBwYWdlIHBvb2xz
IGxpc3RlZA0KPiB1bmRlciBsb29wYmFjayBmcm9tIHRoZSBzdGFydD8gVGhhdCdzIHRoZSBiZXN0
IHdlIGNhbiBkbyBJIHJlY2tvbi4NCj4gT3IganVzdCBnbyB3aXRoIGRlYnVnZnMgLyBldGh0b29s
IC1TLCB0aGUgc3RhbmRhcmQgaW50ZXJmYWNlIGlzIGZvcg0KPiB0aGluZ3Mgd2hpY2ggYXJlIHN0
YW5kYXJkLiBJZiB0aGUgZGV2aWNlIGRvZXNuJ3Qgd29yayBpbiBhIHN0YW5kYXJkIHdheQ0KPiB0
aGVyZSdzIG5vIG5lZWQgdG8gc2hvZWhvcm4gaXQgaW4uIFRoaXMgc2VyaWVzIGZlZWxzIGEgYml0
IGxpa2UgY2hlY2tib3gNCj4gZW5naW5lZXJpbmcgdG8gbWUsIGlmIEknbSBjb21wbGV0ZWx5IGhv
bmVzdC4uDQoNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLCBJIHNlbnQgaXQgdG8gY29uc3Vs
dCBpZiB5b3UgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbnMgZm9yIHRoaXMgY2FzZS4NCkkgYWdyZWUg
dGhhdCBpZiB0aGUgZGV2aWNlIGlzIG5vdCBzdGFuZGFyZCwgd2Ugc2hvdWxkIG5vdCB1c2UgdGhl
IHN0YW5kYXJkIGludGVyZmFjZSB3aGVuIHRoZSBzb2x1dGlvbiBpcyBub3QgcGVyZmVjdC4NCkkg
dGhpbmsgdGhhdCBmb3Igbm93IHdlIHdvbid0IGV4cG9zZSBzdGF0aXN0aWNzLCBpZiB3ZSB3aWxs
IGZpbmQgaXQgbmVjZXNzYXJ5LCB3ZSB3aWxsIHByb2JhYmx5IHVzZSBkZWJ1Z2ZzIGZvciB0aGF0
Lg0KVGhhbmtzIQ0K

