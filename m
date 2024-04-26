Return-Path: <netdev+bounces-91707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFE8B381A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF0F281726
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC889146D43;
	Fri, 26 Apr 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSowynVF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60B14534D
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137288; cv=fail; b=KRCKXZv+mDTx74wkBpGtaMStsIZp0vdH/L+1DWmbvr85hNUo6LfN4g89SjwLELEoGmlQs7v4negW6AwMGv4Sks3fSYgqJhQ7Dw4T2wv0Nx3W93vjUdqVVC4QK6IhRnkDrniWCuiarJDDsTaT20ODqJVlk0Rhmof0bLc87LdTEoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137288; c=relaxed/simple;
	bh=/reDNE38SQCDt97dv+oKclAVML++8kdgaRKDxPq/DTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HoA+vJ6PL9FpHjeVq7ZW0qjmUeXx2DgVwrLSd7bgXCXzDWrcwDtpwTjCa+KxBs8m1UIKyDiX95yU5t+4GsZIs6hXxBVrR8KIoTEWIgUDnJC1K+cvr7lAxNFYDqdlZ0miR9Q4hrmCyM+33rKxMpdGl3dY7GivImKFp372giRrMVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSowynVF; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWJPrVcf7mnBcYe4Ir7jIafBsy7337/YW9eg95DU3RnpCZlhXz6YP+6L5hBps4TBjgUipDe9nQp0ipb/qE3WFMnOmxbdoOE6Upu0KAmEsBK/duEXVgu9Xh/lW/IM8tlG+WuvI1yLvVQRSpcZkD7Uf3p0G7lBRIiXDSU8rqwyH5G0Nii7Tw55vHLKyCfnoUPDMxRwIVz3t2bZBlcdmzN5We7Nc2mco60wq0EZQppX2e4FVR3pMTlfJQxTwF1tTvuRMwl05/vN9q7G5EROESX9XDgnMRQ6GJit8DMD4pWbsA1gU92j+hXgcUalubL5jNfxYvNV1rs1scjNHx6DRaoPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/reDNE38SQCDt97dv+oKclAVML++8kdgaRKDxPq/DTw=;
 b=LVsj5xhSalrZtcYROIDNXomT5/itXfvOF3Xw8WYWYR6pINpFKY7FR6707q590m4lhgYvux/KOFuLiPz9N+zEftGBAm8pCjrPlJQrGyRg3A9YdGShzydxGtc1Z5pr5SadLWLu0kJh6hAVfgyEzGeYBDvq7HiDs+n2xtijhxb9rrDw7k7hs8eYEGU94kIMhHg33wj1f7JCij5KaN18tZN5EFRAjL/JDiaqVIm0LyfIOSczqrcTvqXNvKZN/w5lH58LqApHBFn6pei4Qwe7rU6yvqsf/kk97DC13ScA9R7jfZ61OhoCkVLE439kab4jsQLVL1BSGNRIwn2hicDQERtwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/reDNE38SQCDt97dv+oKclAVML++8kdgaRKDxPq/DTw=;
 b=KSowynVFW5qIOs94uHd8NE7WPqVppDEbc6eMz6wLecDcZx77btjrg44YyAIDfwsc2sE8srsBoElKKOZz5C04l1KeCSEfrGIxzL69OyzgYDVcGj0jf1dCYfoLvikAEJM0PpLevk31ktVup+J1o+1WCjL/tjBFiSIoyo2swVetP/1RnHY8GeMvOMQqFOkQ4/ie+mrzdu079FDd6inRy1qaJHK0iLLnVpQScz8tY+5/1P2BfvoeKycGpTIJrPsNb9YsKB0K6E7g3j8sjXr8rR+5218aFAwgcb2Mdh5ZJCZxCP1I6Zueq+lJ+hrLYleWChgbVteB78LFwnod9CdNwLrmlg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 13:14:43 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 13:14:43 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next v5 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Topic: [PATCH net-next v5 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Index: AQHalTJ2dnhCfeTPQUSixEtJQ/7xR7F6Ux0AgAA5eyA=
Date: Fri, 26 Apr 2024 13:14:43 +0000
Message-ID:
 <CH0PR12MB858074BA1C6639EACB2E411BC9162@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
	 <20240423035746.699466-6-danielj@nvidia.com>
 <65aa390533d0529bc2e9ce4e459af1f5a4a04fde.camel@redhat.com>
In-Reply-To: <65aa390533d0529bc2e9ce4e459af1f5a4a04fde.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: 6da3e471-33d0-40fe-fb60-08dc65f2d643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1JPMlExK2N3WlpPZjlGZkJ5YkJRMVJHN0lvNmlFTmFXbWdCM1FJajJIaTRG?=
 =?utf-8?B?a0FVRklvcFYrL0VyVFVpQjhLbUxOT0tkbVk1TUlNN0h5SGFvTmlqbmkzYWcw?=
 =?utf-8?B?dHV5TnMrOUpzclpvOWFFWGY5Y3g4dTNUUTR2b3RuaERGL05uMkdJTUtWcENw?=
 =?utf-8?B?NTJrK250Vk0xSjh3dUFuRXZCb0tMSGNJWVNZWnpPREZ0UnZ1L3ZTLzkycWp1?=
 =?utf-8?B?K09uY2RBT3BpNE5RUmdralQ0SDZKYzJrUHNJMnNGdTE5M1pDalYxSzQzVjN1?=
 =?utf-8?B?eGVvWk5ZQUthZlR0R01ZaFRnOHdFTGt5QTYxK3VrMldTcXJWdU83YkllTmtW?=
 =?utf-8?B?SGRhN3BBaC8xc3Mya3N1MXVrejRuU1hsbGJIT0lDU0dZVkdGN1I5bm1zVzdQ?=
 =?utf-8?B?NENqdmNSUll6WGdlV3VFajFoY25jTEY1bUFabHFkNnFqNjF3SWxDSkdRY3JF?=
 =?utf-8?B?Umd3aSt1bng0UkxDUDBaZm1XRGFIUCtNaW9PRUFrMDRSdU5SOStlcTBUdHZa?=
 =?utf-8?B?ZWpRM0FmL1hJejJsVng3NHBITjlkYzhnbFhPR1RXYnZBNFo1R1Q3SGxacXZI?=
 =?utf-8?B?WWMxVHF0cUJudTRrb3lYakJKNmxjcWhXMThRQXBWVGdXUk5hVmxkMEl5Rk96?=
 =?utf-8?B?NmtVdmFhVTNXcUxiWEkvSDcrUWx3SDZrQ1ZaQWVMaGYxME5ESHlDL0tVNmtD?=
 =?utf-8?B?MkgyTDVub0s0WjE1SDJYWE83K1pTUWIzWTl2RmthcnNjQTVYOWxyditzellk?=
 =?utf-8?B?M080QXFxY0UycGsyRXg1NUdOazczQ1hZT0wwMTh4alQ1TFBKOHBDV3dkdmhT?=
 =?utf-8?B?Q1hRUnk3VTlpbEozOENCWjBrT0pTOU1sSHRpOHUvQWRPUHRwQU9QQmNERlVZ?=
 =?utf-8?B?eVdJNnVzU05tbGVvK3FHSjQ2UTN5M0lENGJOWE4vZW5wWVlBVUlxeXd1TmEz?=
 =?utf-8?B?dTZCL2xlOU95SVBIVjdKazZjMkJUM2tzN1phTVlRajhUc0tOU1J3L2JZZ0NY?=
 =?utf-8?B?ZHBoZ3VrZUxGVERxMW5qakgzRTZVcFQ2U1BWd3JVN093TkJ1WkVNc2dWMEhs?=
 =?utf-8?B?UWxZUjNkZC9ISEYxTlY0OElEdkkyMk5nbHRQT2pBbENxbUNSTHVQeXUvT0xh?=
 =?utf-8?B?ZERFRDBoWk5kWkw3S1NTaG1kSytFREVlYUdjOVIzZjQxVWFpTkl4bTdqMXVK?=
 =?utf-8?B?MEtpcWxKVWNLRnJnWGFSVUhjUHg5M0dTcTg4QyszNlhPbWFtcytYQ1Jta3Bk?=
 =?utf-8?B?TUJXZVRidzhPMDBLUjQ2L0tXMDhrZEQ5dUVaZWhOWjYzZkxtSXFCcFNuVlR1?=
 =?utf-8?B?K2xRZW1MSEExdUJUbzdsRjZaYUh1ODdRZXlsTXBoaXBYc1J1dU9FeU9pTEx5?=
 =?utf-8?B?OHJNbTA5VXQwRTd3YlFEYm1ZNDFXdlhucS9XeU9rbjJiU1VwQjNjNzBwbkhC?=
 =?utf-8?B?d0FoazJpSm51eU1WSjhDdEZCSjFvQmVucmxvbWNCRlpQbGxLc085T1JGTFpw?=
 =?utf-8?B?VlhYU0ViUjNWTnJGM2RBSmIwNkNxQ1dqWlU5cGZnditBTG80N0doZ1FUMk01?=
 =?utf-8?B?aFpITWNteDl1QUIyVk9jblpXbWVOdzNlTXliUlR1c3YzNTk2d0Q2TlpWZHpX?=
 =?utf-8?B?amJXbCtmUmhxTUNHVWhpNjBHYk9yWUZjT3JkK3N6QzQxS0ZhZUx2WW9pUmNs?=
 =?utf-8?B?dHhXSThZdDZadFZTZm4ra0hLQlJBL2dWN1FXZGF5SUFTRmErSHNCUzh3RWFV?=
 =?utf-8?B?bFU4M3FBVDhxRFJvSWFyUlRNMlJhb3k0QzR4TnY4YllQdFY2RVNDS3Z5N3VX?=
 =?utf-8?B?S1RjVHlMMVlPb1NodHFmQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YS9yM0VkUHVQUXNlVGpSOTVKWGhjN2hnZnZhQ0RxMVg3Z1ZoekpoU1p2d0ds?=
 =?utf-8?B?QW8wanhabENEVUZ4TGJ2WEpmZml4SFJmY2RyWU1SdEFRMzNHUVROZWh5Sm5v?=
 =?utf-8?B?dm85dVZjOFhVQk9iY2pPMHFKYlAwdVBDWUx2NmErYmszbnpiVzQvUDFrMWNU?=
 =?utf-8?B?djlhOWg3VFpnbi9BOGdtV1FSSHMyTk5YT3JwWXJBZTlOSkhlNmZBVFdkeDdp?=
 =?utf-8?B?T2dnN3BaUittMHFEZ1Boc1I2aGhCaU9nUXZSVlJmamtzY1pNd1FNMExBQlA5?=
 =?utf-8?B?eldibUJFMjFrYnFBU0VERFJZeG8rQXBBQm9FTll5cFNPQTNhZ1pFVUMraEhy?=
 =?utf-8?B?OTliS1dhbmRTNFNGazI2eFlaT3A2Y1c5Y29IOS9nUFphUUVvUDdQZjJxMk5E?=
 =?utf-8?B?d09TeGY1MHp3MVdzRzc0cTlxWktCQUJzVGh1V1dlMnRhWG1tcWU5TDV5VUV3?=
 =?utf-8?B?dE1DV3dQdkZyYytUOG1jUWxtb3pBTjlYeGNhSi9VR2xsYWxZcmt4aU8yWWhF?=
 =?utf-8?B?WWtmLzIwT1NNcENGcjEvTHVtUjZOUkpjZGxpbU9aL3BkVUw0L2pidkp6Wklx?=
 =?utf-8?B?dFpXOGxtdkpKTDJaeWwyTkk4c3F3S25Qdi9FbGsyUHloaS9oSE1EazBMNE85?=
 =?utf-8?B?SnJWNkhKUUVhOXBUckN5bE1rQjRaa0lTY0pUUVJQRFh5a000VHZ6akZtdzFp?=
 =?utf-8?B?Zk1tZnBFejFiN2xYa0lzT3EwT1JLVkR1TjFyRXpWVVAvNkdpME5GYzFDOWJF?=
 =?utf-8?B?d3Q4Rzltb210bXBBRlZqcjNrZWcwbEQxQnVrdmRoejJmejB5N0sxTHlMM1hS?=
 =?utf-8?B?SVZ4RW1JclVWQ1pMWTFIank2TWxPM0ZlR1FaY1FGRUo1RkNuZnZHZjROK3Ju?=
 =?utf-8?B?ZDA3eUgzbkZta0M0bzBQejBRZmZCZzl2dm44Z3ZpZmdGcTZ3eEtOZWNhT0FB?=
 =?utf-8?B?dUJHTjdvR2lEd0VDY0xBNTZTakJBVmI1RVNhK0hlVEsvQ3hTaW52R1RYZVpP?=
 =?utf-8?B?YWFDZ0Q5d08rS0xqVUt1MmdBZEptakp0YmFEMDE1TS9HdytYb2ZlWW9EQlJ6?=
 =?utf-8?B?eHoreGtNdUZrbjIzQy9VQ1NZOFRqWURoNUxSQ2QySEZQdDJOb1ZEK1hoTFJj?=
 =?utf-8?B?SmNyWHg2WWd2cHhsMmdVOGpGQWxDbjZBVjU2YjlBZ1BJeE9sdlRoakptSE5P?=
 =?utf-8?B?NGJsR1gwUzNCN0FBSGxZSDFqSGwrN3VwVGJ2b3Blak1nRlNFN0tCYmR0blU3?=
 =?utf-8?B?L3ZkdkgwbVJQSTNlaGpmeGVFTHZtdFg1eFhCZFJ3ZXNTTVJPbTlhZ0RnZjBZ?=
 =?utf-8?B?aUN1b1BBMENSNnFsZGsyN3R5N3R0NVZEYWY4NXF4WGJGdm5ZT04wMVlIKzlM?=
 =?utf-8?B?ZS9VTjlPS0M4UHFqd3BRUjJyRHpIdXlabnQzQUJDeVkrSVBFNmlYRm1KS3l4?=
 =?utf-8?B?aXBMaHExYnJxVnNiVnc4WnZyRmdsQ0YzcnZuSjNCVFZ4cWtYWmQxVS9sQ2NX?=
 =?utf-8?B?Z3JNemFoRjVOMmFmM1drWHhWK08zT3crcDVaUDR2eTdwSytOc1UwZXFzclBS?=
 =?utf-8?B?K3ZUL0pQaHRXV2VHcDUxWXRUenhwRzZXeXVybGNneUJDUVlQYk8xM2Nvd2xD?=
 =?utf-8?B?c3M1UkhHZFpHZUpYQ0Vod0pCZEtUOE82THNHVVdLcW94KzIzVlJxd3dNajNq?=
 =?utf-8?B?ZFEvWDMyQUFlbTJsVnlSSWl4K21Ra1NvcWhqK2crMmpoaFFaNjVQQ01XN2hj?=
 =?utf-8?B?K3lLWTN5VUs2TzRHNHYrQ3JZb0RpMUJNd2NPY2Naak9YOEtUMFAxU3Nva1Y0?=
 =?utf-8?B?OWtPMDlaMU5ZcHltSnVsU2tyU1lZT0RUa1NNNzNVWTJmWjB2ZHJOdGx1ODFW?=
 =?utf-8?B?ZXFWS0ZMc3BISGZmUXhHQTJmcTFvZzB3Zm5kdjFjY3ZPa2FLWSt0L2RyN3VE?=
 =?utf-8?B?MWZMWDVUZzNsdGtlVDlIZmg2RTZPY2RFY1V1UmlhdTl6UUJURnEzSlhNNlBx?=
 =?utf-8?B?bFpLb0ZndGc4dEFSZlp4K045TWJMNXRocURuVzdMWFVOZmFuN1VKTS9hR2hC?=
 =?utf-8?B?dGtkUkZ2clpjaWtsQmhHVld3MmlQU3BqYmJLTkNsbEJtVjI5NFRaQjJvT2k0?=
 =?utf-8?Q?jXi5rb4aR9U2yf02kBq0/CQqP?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da3e471-33d0-40fe-fb60-08dc65f2d643
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 13:14:43.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOSJ9KRkD3mNAAfS8+FZeTOyPlSaiUS9BSZ+JdbnS3a3OmrI80chaItO+jjVmK8RyWOEXKCURD9r8oi3r8XKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

PiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwg
QXByaWwgMjYsIDIwMjQgNDo0OCBBTQ0KPiBUbzogRGFuIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlh
LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBqYXNv
d2FuZ0ByZWRoYXQuY29tOyB4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXguZGV2OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpldEBn
b29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NSA1LzZdIHZpcnRpb19uZXQ6IEFkZCBh
IGxvY2sgZm9yIHBlciBxdWV1ZSBSWA0KPiBjb2FsZXNjZQ0KPiANCj4gT24gVHVlLCAyMDI0LTA0
LTIzIGF0IDA2OjU3ICswMzAwLCBEYW5pZWwgSnVyZ2VucyB3cm90ZToNCj4gPiBPbmNlIHRoZSBS
VE5MIGxvY2tpbmcgYXJvdW5kIHRoZSBjb250cm9sIGJ1ZmZlciBpcyByZW1vdmVkIHRoZXJlIGNh
bg0KPiA+IGJlIGNvbnRlbnRpb24gb24gdGhlIHBlciBxdWV1ZSBSWCBpbnRlcnJ1cHQgY29hbGVz
Y2luZyBkYXRhLiBVc2UgYQ0KPiA+IG11dGV4IHBlciBxdWV1ZS4gQSBtdXRleCBpcyByZXF1aXJl
ZCBiZWNhdXNlIHZpcnRuZXRfc2VuZF9jb21tYW5kDQo+IGNhbiBzbGVlcC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBKdXJnZW5zIDxkYW5pZWxqQG52aWRpYS5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUzDQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGluZGV4DQo+ID4gYWY5
MDQ4ZGRjM2MxLi4wMzNlMWQ2ZWEzMWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gQEAgLTE4
NCw2ICsxODQsOSBAQCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSB7DQo+ID4gIAkvKiBJcyBkeW5hbWlj
IGludGVycnVwdCBtb2RlcmF0aW9uIGVuYWJsZWQ/ICovDQo+ID4gIAlib29sIGRpbV9lbmFibGVk
Ow0KPiA+DQo+ID4gKwkvKiBVc2VkIHRvIHByb3RlY3QgZGltX2VuYWJsZWQgYW5kIGludGVyX2Nv
YWwgKi8NCj4gPiArCXN0cnVjdCBtdXRleCBkaW1fbG9jazsNCj4gPiArDQo+ID4gIAkvKiBEeW5h
bWljIEludGVycnVwdCBNb2RlcmF0aW9uICovDQo+ID4gIAlzdHJ1Y3QgZGltIGRpbTsNCj4gPg0K
PiA+IEBAIC0yMjE4LDYgKzIyMjEsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGwoc3RydWN0
IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQNCj4gYnVkZ2V0KQ0KPiA+ICAJLyogT3V0IG9mIHBhY2tl
dHM/ICovDQo+ID4gIAlpZiAocmVjZWl2ZWQgPCBidWRnZXQpIHsNCj4gPiAgCQluYXBpX2NvbXBs
ZXRlID0gdmlydHF1ZXVlX25hcGlfY29tcGxldGUobmFwaSwgcnEtPnZxLA0KPiByZWNlaXZlZCk7
DQo+ID4gKwkJLyogSW50ZW50aW9uYWxseSBub3QgdGFraW5nIGRpbV9sb2NrIGhlcmUuIFRoaXMg
Y291bGQgcmVzdWx0DQo+ID4gKwkJICogaW4gYSBuZXRfZGltIGNhbGwgd2l0aCBkaW0gbm93IGRp
c2FibGVkLiBCdXQNCj4gdmlydG5ldF9yeF9kaW1fd29yaw0KPiA+ICsJCSAqIHdpbGwgdGFrZSB0
aGUgbG9jayBub3QgdXBkYXRlIHNldHRpbmdzIGlmIGRpbSBpcyBub3cgZGlzYWJsZWQuDQo+IA0K
PiBNaW5vciBuaXQ6IHRoZSBhYm92ZSBjb21tZW50IGxvb2tzIGNvbmZ1c2luZy9tYW5nbGVkIHRv
IG1lID8hPw0KDQpJIHdhbnRlZCB0byBub3RlIHRoYXQgZGltX2xvY2sgaXMgYmVpbmcgYWNjZXNz
ZWQgaGVyZSwgd2l0aG91dCB0aGUgbG9jay4gQnV0IGl0J3MgaW50ZW50aW9uYWwuIElmIHRoZXJl
IGlzIHJhY2luZyBhIHNwdXJpb3VzIG5ldCBkaW0gY2FsbCBjYW4gaGFwcGVuLiBCdXQgdGhlIGRp
bV93b3JrIGhhbmRsZXIgd2lsbCB0YWtlIHRoZSBsb2NrLCBzZWUgdGhlIGNvcnJlY3QgdmFsdWUs
IGFuZCBkbyBub3RoaW5nIGlmIGRpbSBpcyBub3cgZGlzYWJsZWQuDQo+IA0KPiAJCSAgIHdpbGwg
dGFrZSB0aGUgbG9jayBhbmQgd2lsbCBub3QgdXBkYXRlIHNldHRpbmdzLi4uDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBQYW9sbw0KDQo=

