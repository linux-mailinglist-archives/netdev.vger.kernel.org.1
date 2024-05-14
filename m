Return-Path: <netdev+bounces-96289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1668C4D25
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C01A1C209D9
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F2125A9;
	Tue, 14 May 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EK1NFxEa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22D171D2
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672239; cv=fail; b=Apyz4mlBe+7nYEZ90HoshCkwycvGzoegSuXJrsQDNMYMfZgd0uz/+4iLatwoRm5gDAr8N92edriOYoxpoRcC/zcJ+o+wTd3v7IFCdkttdKPrg1VXFhsqW4bEq7j+S8wTcf+RiwKNJTT9inXsjhYyUQJRB6UVYYWjVhE/oy4BrwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672239; c=relaxed/simple;
	bh=0BHoQr5GmhlCBMiJlUTwdY+Aj65++f2Fk/VTrZj/Ksw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5gTfc29p9jl1eahzk/QWN4rYeuUO3GVdlRsqiI0JBkd+24oXVEeVJBSCn6lag8aY0F7BPM7YPmetMlwuhvWX/IqKmXx5SKUW6tafcFmoNXnxPErIRN06SU7H+TDWtuOdoxLAqiMZKySIH7C1tF9ju9s6O0/92LKAzS8IkLoCTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EK1NFxEa; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph3V+WIL4ST0vzjziv2YvwpaTB51TDfPczNwNqxRZ2IvlJbpOkhH7gdRdy4hBj4qQCEQd3ADB05dj4y5PX8WK15MYIWsI07FOJzVSdLXFPzQWAw/DL0+KR0IyrwpNq9TnYdzwBiardN/z828S4tVdv8+MP3iJB0NrNpZVynnFiedh0sSJkI0HVKfOmIcmTuPsu6A7tj2cfhHqel4rII8awfxhJFu3hudkAKNzdOxPjXZ+imCJdaxoN44sgp2Etp+t+5wHgpwEsk7IsWwuoGAe4MvMGILPHbLOjxc0/Z0a4veGmi09qX6rIFx335AxHiIT8tABGG2qJ+Gvj86tdaaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BHoQr5GmhlCBMiJlUTwdY+Aj65++f2Fk/VTrZj/Ksw=;
 b=aB+mz7+kBM8Fi3vF23URxbrD3bsGQUX6Y7wIMzDzwGHBkedfH2flcEAbVADWnvI53pG7HA3STYk7rIm/8s9FuoR44RCqfqtmsT+T/xZk9c5emC+YI1qiV1S6pDm+jB8J9hrOYCASoWLy9CpD6YIlw5Bwh4KFkWabu/5tRJaoSVD96YGoIFW0FIsoa0lQrbyv1BYe/euOQOw3CfmNHgRqeM7t+l50oP17OH8nVR3Z2BgzOT7xGDuKErhykeBODf042dVeIZPuoEvdcrJFW33CSLzRglV+awhxBvLEIOzicLtSf0FR4DV2ZdkMTpliYKLrs+xDBw3do+V3t1rGqlP7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHoQr5GmhlCBMiJlUTwdY+Aj65++f2Fk/VTrZj/Ksw=;
 b=EK1NFxEaMfHIfY6xDoT+InFo4UY0AXZPQp8IoczfuW8tM3HbKFiuWfYLwFTqfKRhvNR1oRiSbZYSN3JGzyRu9oeXdDfRAAQit4rEUKbV3r9bngryizAR4macEKu4Rvp9gpzKpj/fdpwWgVhaP5CcctSdN+OO/5kJ2obocwWq0+dUYCeoXONZuNByKxzXqtLLNOwaa3kx16hyA6yOBjHRVrucKw5xtt9zUEHdhCVDf3D1mwnauF+2+y9oDYxmkXgWiqVOwDvfMkB6wISC+lxS5p+OhCFy/MjOPEXeKfVCrs01XI5XYQB81S+xCFRS6p+vU8kWiNhrVahPKYC2kpUcuQ==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 07:37:12 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:37:12 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "edumazet@google.com" <edumazet@google.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index: AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhIA=
Date: Tue, 14 May 2024 07:37:12 +0000
Message-ID: <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
In-Reply-To:
 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|SA1PR12MB6971:EE_
x-ms-office365-filtering-correlation-id: 4888adab-82af-4428-e6af-08dc73e8ab71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmFMVVRQeFZPUDVWa3VmSlUzTUU2bTlaanR6V21JVDhtNUZnTzdDb1o2Zitx?=
 =?utf-8?B?UUhIbE5BMHdJRHAxYU9wUVV0WUhuOUJpb29YdGRVU0pSY2FPRVFJZU1LN25L?=
 =?utf-8?B?Mzg5MmM5a2pKZVRIRnlaZjg2USsvTUtqSW1hcS9Hdm91WmUvNGhkZWorRzFz?=
 =?utf-8?B?YTRvRFp0YkZhOFEvclJLa2g5Q0hXZ0VWK0NvTWJYRXNQcTBuZHlyd2JMQ01B?=
 =?utf-8?B?aHFwZkJ1S2VocGIzejFHbVR1Z2Rzdm5zMzUvakZpbC82NmVRSHdGdkkzOGdw?=
 =?utf-8?B?anpEZnpBa0ZBNXc2dmd3YVFGZHc2bytqMFdGSDBUbVJJMEpzZDlHUGp3d2ln?=
 =?utf-8?B?cWtSeDlnZ3hPZkdsQ3l3REhqQXJRdGYzd2ZNTkFyZ0FST2poT1NkR2NMSmZP?=
 =?utf-8?B?ZHlqOVppRExWU0k1OExNSGVvTThGakt5cFg0Q1lXbGRtaEwxU1BvcWJPVyti?=
 =?utf-8?B?U0wwVHU1Rkx3QWd3WmhnWWdXQ3E5RWJIazN3ZnV3Nk43cVdLM1hONzZadjU4?=
 =?utf-8?B?OWp0WmliR29xMXNjeUlabDA2V3VGUzJuZFdieEV5SEtER092a09KY1d4aHZn?=
 =?utf-8?B?RGU5a3AyRUdpS1BMZlZqbjFrcTJmTC9GTFF1OXU3Wkwxd0Q3UVBQcHhqNGtI?=
 =?utf-8?B?dlVLSVNZbTEwYjF0RWhUanJHVGxyQ2c4cjZXbXVDODJGa3BOa0pUNTA5Ujk5?=
 =?utf-8?B?S3V4WlhOcUFreFA0K1FHMUJTZm9nSUxvelVpNzZSZEwvZ1hjeWFZNWR5dmdj?=
 =?utf-8?B?SDJmZ0ZJNjNmUjhPcGw5NFhqeHI4VlRxRTNxRUlBQ3F4ZnBTYnU4TTR2c1RV?=
 =?utf-8?B?VzduZHV2RFkzbXB2LzRlZXloMksrNlptWDFGd2J5NTRWclgwRjRDM0xGS2NQ?=
 =?utf-8?B?cERKOG51RDdBamRJcTF0M1VRR2RYOVFnN21SZE92NDFmbUR4YzJrWDBnTnNz?=
 =?utf-8?B?Nnp6cFQvaHFac2FLZUlLK24zaHV3YkMxSWEzQWRKM1A0V3FPK2FHU05IcFpM?=
 =?utf-8?B?ZjZpdEIwM1QybXllYjN1ZWJKUEhpMGg1OHhTZHVBSEpta2ZBRTZLdkdDanhn?=
 =?utf-8?B?dVR1dVdaYmdDQ25TQjJTcXl6Vk15UjRsMTVMdGFpMVZnL1hiWlNoMFkxNmZq?=
 =?utf-8?B?ZlF0QW13eGU5TGF3akxoWWZpbUVKdHByekxGOCtkQldxZmFsWmRuZmtqdFlJ?=
 =?utf-8?B?RmJibVJDU1NrMHpOdnVqb0VNSkVmOW5qd0Z4M2NQdTVYZnNyUzZmaitBclpN?=
 =?utf-8?B?NmZKQlJleC83QXNGdjVkTm9XYk9yNExrL1Zkb3dVakQ3ZDJmUW9rSk90K01B?=
 =?utf-8?B?eXlmcnhmVy9ERjRQeUE0ZFdOMnAyMXRvR1VNUWl5dkJadUpSVmNLa2hqdUp5?=
 =?utf-8?B?VXhJZUxyU3d5bEhQZ1lSbFZydk83UHNjMVRubUpPamVST3d5ZkNIMzVVQ2xa?=
 =?utf-8?B?c1dzTkhSZGRVWFFKb0pNZjN1T0h1TWppMkd6eXNoNlVWNDdSZjVTeFlyTHBJ?=
 =?utf-8?B?SUVtNHcrOUFyTnpwWE9DblE4TTExalZMeEx4alljTlJMSFpUZlVYNEtaODdB?=
 =?utf-8?B?cWhNVjhTQjVSdENweFkxWU55SmlWdmt0Wisvc3dBOXBoYVdPY09jUmhKcnNp?=
 =?utf-8?B?RW1HZTkvaWd6NklGM2RsN2NSSzM5L1V3K0VTdit3WmV5RXM2YlVuTldxZXBY?=
 =?utf-8?B?WWVhaUtkYm1FcVBGM0drd3N6YUJRSDlySzRNdTVzN21mVERoVS9Id1gxbmhN?=
 =?utf-8?B?cldjY0I0VGg0QVMwT09kSGdIQmhGVHgzeFRUTi84QW1DVnJTQm9JSC9uRmpB?=
 =?utf-8?B?aktycStRbVl4VXZsaDMyQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anEvekNMTm1pazNaT0s1b244cGViUytSalJsVGFLQXJRcmUycUhORVhsVXZI?=
 =?utf-8?B?LzRROFg2YmVLajJadXBORHNlWkc3QW1jalQ5bXNkYXBjZndIQS9uQXJNMnFk?=
 =?utf-8?B?VUNpSUNKbkZsTjM4blpBQ2Z6ZWxZYXRYaDhtanh0Rm5WSkZKRUswaHhta3lm?=
 =?utf-8?B?eHRzTzB4M1VxWXRCcTlzYm5GazFiRWJWcWx4Y2tWWVVlWmoyNDhYdlhnVUJW?=
 =?utf-8?B?V3cwVytJNDBUY1BPMWRpMHRLbXZtbTVGTVNuYlEyUTh0TkQ5UDQ0WklDOGpy?=
 =?utf-8?B?NDNZSWxSaStsbjVRL2xQQjlMc0xOSnZhN0xJQnA1a3h1NHhqNHJxUjV0akRp?=
 =?utf-8?B?amZPcVI4SC8wZnFId3RuVTNlSWJwNFc0M29ia2RoY25mMEpXUHUzRVNnL3I1?=
 =?utf-8?B?cFRnMzhkczF3enhpNXlIQWNLWE43czJKNUtSOTVRbmpETzRwbmtLc0x1akw1?=
 =?utf-8?B?cjRGU0ptUU5QZkNyNDdRRG5FcTVzNmp1V2xXb2JMUDZnNm9wZmRSVWpTTXo3?=
 =?utf-8?B?YTRoOHdEaG9DVVZ3YmhueXZHa2ZodE52aHhoZXBsbkxvaCtxVjQrUzhuV2dS?=
 =?utf-8?B?cDAvYkVWa2t1OUc2UDBJb2dDRjJNeUM0Unh3OXM5N1B0b0MxcVRtZkg0a3Za?=
 =?utf-8?B?TElsMW9VWHphNzZpZTIxenlKejBDSUdXTitnWU1zS2lhMW5GY2tkWnBTWDNO?=
 =?utf-8?B?TnM3K0hmcVl6OTBMZmVrdlYwdXFIODY4ZEprc2JJSVJReW1SNXhLd2RiOW1v?=
 =?utf-8?B?eEZHOG9wUldFSHFuT0hkVjgzcjluSFlYNDlIY3hKRDZabXZTY2hzQW0vS3V1?=
 =?utf-8?B?VzAxTUx5NEpBTmtOMm1WKzZDUGJSNmovVW1NdkxYQk14cTkvVTUvTE9JV1J2?=
 =?utf-8?B?djNFc2FoUy9ydFZ3QVRIL2x0YURoWEdPVGVVRzEwRWFNeERMRklRQWxHd3Rk?=
 =?utf-8?B?MXdtbFpzdUtmN1RwZDNUZ0V1WjNoQWZtdkFEOGFUeWZjMmtjZUVaYXViK1FF?=
 =?utf-8?B?VTdaZlNuUkJqb0xJSHdBM2ZyVE0wdjRPdi93M1R2aDJ1MmtxWWFHNlJ4VU9v?=
 =?utf-8?B?NVd4YVJ5WU5ZdloyOU5IWC9tVTJOY2IvcFYzKzFWQ3U4WVFDanc1UmpJRkJP?=
 =?utf-8?B?V2xzOUdPSHJTOTR1MkN6Yzl1ajREMUlFakFnbko1OUNjN09sMThLdFJRakJW?=
 =?utf-8?B?RFFhQTExNEdTVExLNUhHNENLMVVJSjhFTklFSnNtcjBYV3hjeW8zNmtrTzE2?=
 =?utf-8?B?dmFXSTJvU0d5Q0c4ajZUcFh4L0R5bUlEa0c0dXZmbVVESStpTWlZRUlKdVVq?=
 =?utf-8?B?ZHZEbWwzT05ZRXdiTFR4YTJlRHZrOFUxK1VxN0hUT1FYQllMS1BsS2diTGxB?=
 =?utf-8?B?NlQzRUFPTFBZM3loT1dsSEsyV0pabGNnS2NMTmZZK0FnMm4vQnZVc1ZBRmRH?=
 =?utf-8?B?dkkvZ1JWL0J3dVJPeHF6eGplcWU3dDZSWnkxNG40UFczQVVZTXBiRXJxRjRn?=
 =?utf-8?B?dS9pOU1ZdDJKQ0FXdG1wUWpuZVVvK1kvdUxWMUdnS1Jla0VBRDB3Y1lzWE52?=
 =?utf-8?B?RURDaVU5YVZBckhSZXpyTXdEOHA2RUVsempyV0syWTdTNFBqTHQ4VDVVTERN?=
 =?utf-8?B?TGFtQkoyQXluZnZCc0d3amJrcXhlMGxyUHg0NC84c1YzN0VoRzZsVjFaN1dH?=
 =?utf-8?B?SStEc1IrVEVKbGhsSUozZzlwRlh3OXNtSEg5VnZGK1FUQUZxb2xxMDZGTUVS?=
 =?utf-8?B?MFlZeHpaSldyZDhlYzU3Tk9oeUxRemJjMVlsMmxIbVNJU3cyT2JDcndDVkpS?=
 =?utf-8?B?dWozajdsL095WHY4T1Q2QTBOODF5R3lXREdUMVNNM0Vzb09IamtFTHZOQ3BU?=
 =?utf-8?B?Rm8zRHk1V2Q1enpTT2k2V3VBRUtUc2F2eFdGUkVQeXl3WW9kTDFDcDBPMnhr?=
 =?utf-8?B?TkF4Y2hXTFozdENsOE9VR2MwTHJzTEZvQ0w0RFFKd243N1VBNkFtU2RnZjh1?=
 =?utf-8?B?aENveHJNdlRJbGlQVkRkV3I4ZXVUbU9JL0ZlYTZQSWxWMEZibVlPQjdXYy8y?=
 =?utf-8?B?RngzN3h1Sk42QWQ2clVlOHltd1p5RUEvWEEveUFDeFJFUTMrbHp1eW1hcldh?=
 =?utf-8?Q?jx/Vz8vmCfqfXDOZBJMiRkH+6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <645497375D473A44B98452830ADBDA59@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4888adab-82af-4428-e6af-08dc73e8ab71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:37:12.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+hhf6nj8/dCKlxoqIO2HtfGcq0lpgLem+zyx6EpcI2lBjGj4KwfwWeTzVNWzpnFCibaJUOXoWnUi5cLsMMSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDEyOjI5ICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IE9uIE1vbiwgTWF5IDEzLCAyMDI0IGF0IDEyOjA04oCvUE0gSmlhbmJvIExpdSA8amlhbmJvbEBu
dmlkaWEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBJbiBjb21taXQgNjg4MjJiZGY3NmYxICgibmV0
OiBnZW5lcmFsaXplIHNrYiBmcmVlaW5nIGRlZmVycmFsIHRvDQo+ID4gcGVyLWNwdSBsaXN0cyIp
LCBza2IgY2FuIGJlIHF1ZXVlZCBvbiByZW1vdGUgY3B1IGxpc3QgZm9yIGRlZmVycmFsDQo+ID4g
ZnJlZS4NCj4gPiANCj4gPiBUaGUgcmVtb3RlIGNwdSBpcyBraWNrZWQgaWYgdGhlIHF1ZXVlIHJl
YWNoZXMgaGFsZiBjYXBhY2l0eS4gQXMNCj4gPiBtZW50aW9uZWQgaW4gdGhlIHBhdGNoLCB0aGlz
IHNlZW1zIHZlcnkgdW5saWtlbHkgdG8gdHJpZ2dlcg0KPiA+IE5FVF9SWF9TT0ZUSVJRIG9uIHRo
ZSByZW1vdGUgQ1BVIGluIHRoaXMgd2F5LiBCdXQgdGhhdCBzZWVtcyBub3QNCj4gPiB0cnVlLA0K
PiA+IHdlIGFjdHVhbGx5IHNhdyBzb21ldGhpbmcgdGhhdCBpbmRpY2F0ZXMgdGhpczogc2tiIGlz
IG5vdCBmcmVlZA0KPiA+IGltbWVkaWF0ZWx5LCBvciBldmVuIGtlcHQgZm9yIGEgbG9uZyB0aW1l
LiBBbmQgdGhlIHBvc3NpYmlsaXR5IGlzDQo+ID4gaW5jcmVhc2VkIGlmIHRoZXJlIGFyZSBtb3Jl
IGNwdSBjb3Jlcy4NCj4gPiANCj4gPiBBcyBza2IgaXMgbm90IGZyZWVkLCBpdHMgZXh0ZW5zaW9u
IGlzIG5vdCBmcmVlZCBhcyB3ZWxsLiBBbiBlcnJvcg0KPiA+IG9jY3VycmVkIHdoaWxlIHVubG9h
ZGluZyB0aGUgZHJpdmVyIGFmdGVyIHJ1bm5pbmcgVENQIHRyYWZmaWMgd2l0aA0KPiA+IElQc2Vj
LCB3aGVyZSBib3RoIGNyeXB0byBhbmQgcGFja2V0IHdlcmUgb2ZmbG9hZGVkLiBIb3dldmVyLCBp
biB0aGUNCj4gPiBjYXNlIG9mIGNyeXB0byBvZmZsb2FkLCB0aGlzIGZhaWx1cmUgd2FzIHJhcmUg
YW5kIHNpZ25pZmljYW50bHkgbW9yZQ0KPiA+IGNoYWxsZW5naW5nIHRvIHJlcGxpY2F0ZS4NCj4g
PiANCj4gPiDCoHVucmVnaXN0ZXJfbmV0ZGV2aWNlOiB3YWl0aW5nIGZvciBldGgyIHRvIGJlY29t
ZSBmcmVlLiBVc2FnZSBjb3VudCA9DQo+ID4gMg0KPiA+IMKgcmVmX3RyYWNrZXI6IGV0aCVkQDAw
MDAwMDAwNzQyMTQyNGIgaGFzIDEvMSB1c2VycyBhdA0KPiA+IMKgwqDCoMKgwqAgeGZybV9kZXZf
c3RhdGVfYWRkKzB4ZTUvMHg0ZDANCj4gPiDCoMKgwqDCoMKgIHhmcm1fYWRkX3NhKzB4YzVjLzB4
MTFlMA0KPiA+IMKgwqDCoMKgwqAgeGZybV91c2VyX3Jjdl9tc2crMHhmYS8weDI0MA0KPiA+IMKg
wqDCoMKgwqAgbmV0bGlua19yY3Zfc2tiKzB4NTQvMHgxMDANCj4gPiDCoMKgwqDCoMKgIHhmcm1f
bmV0bGlua19yY3YrMHgzMS8weDQwDQo+ID4gwqDCoMKgwqDCoCBuZXRsaW5rX3VuaWNhc3QrMHgx
ZmMvMHgyYzANCj4gPiDCoMKgwqDCoMKgIG5ldGxpbmtfc2VuZG1zZysweDIzMi8weDRhMA0KPiA+
IMKgwqDCoMKgwqAgX19zb2NrX3NlbmRtc2crMHgzOC8weDYwDQo+ID4gwqDCoMKgwqDCoCBfX19f
c3lzX3NlbmRtc2crMHgxZTMvMHgyMDANCj4gPiDCoMKgwqDCoMKgIF9fX3N5c19zZW5kbXNnKzB4
ODAvMHhjMA0KPiA+IMKgwqDCoMKgwqAgX19zeXNfc2VuZG1zZysweDUxLzB4OTANCj4gPiDCoMKg
wqDCoMKgIGRvX3N5c2NhbGxfNjQrMHg0MC8weGUwDQo+ID4gwqDCoMKgwqDCoCBlbnRyeV9TWVND
QUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0Ni8weDRlDQo+ID4gDQo+ID4gVGhlIHJlZl90cmFja2Vy
IHNob3dzIHRoZSBuZXRkZXYgaXMgaG9sZCB3aGVuIHRoZSBvZmZsb2FkaW5nIHhmcm0NCj4gPiBz
dGF0ZSBpcyBmaXJzdCBhZGRlZCB0byBoYXJkd2FyZS4gV2hlbiByZWNlaXZpbmcgcGFja2V0LCB0
aGUgc2VjcGF0aA0KPiA+IGV4dGVuc2lvbiwgd2hpY2ggc2F2ZXMgeGZybSBzdGF0ZSwgaXMgYWRk
ZWQgdG8gc2tiIGJ5IGlwc2VjIG9mZmxvYWQsDQo+ID4gYW5kIHRoZSB4ZnJtIHN0YXRlIGlzIGhl
bmNlIGhvbGQgYnkgdGhlIHJlY2VpdmVkIHNrYi4gSXQgY2FuJ3QgYmUNCj4gPiBmbHVzaGVkIHRp
bGwgc2tiIGlzIGRlcXVldWVkIGZyb20gdGhlIGRlZmVyIGxpc3QsIHRoZW4gc2tiIGFuZCBpdHMN
Cj4gPiBleHRlbnNpb24gYXJlIHJlYWxseSBmcmVlZC4gQWxzbywgdGhlIG5ldGRldiBjYW4ndCBi
ZSB1bnJlZ2lzdGVyZWQNCj4gPiBiZWNhdXNlIGl0IHN0aWxsIHJlZmVycmVkIGJ5IHhmcm0gc3Rh
dGUuDQo+ID4gDQo+ID4gVG8gZml4IHRoaXMgaXNzdWUsIGRyb3AgdGhpcyBleHRlbnNpb24gYmVm
b3JlIHNrYiBpcyBxdWV1ZWQgdG8gdGhlDQo+ID4gZGVmZXIgbGlzdCwgc28geGZybSBzdGF0ZSBk
ZXN0cnVjdGlvbiBpcyBub3QgYmxvY2tlZC4NCj4gPiANCj4gPiBGaXhlczogNjg4MjJiZGY3NmYx
ICgibmV0OiBnZW5lcmFsaXplIHNrYiBmcmVlaW5nIGRlZmVycmFsIHRvIHBlci1jcHUNCj4gPiBs
aXN0cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmJvIExpdSA8amlhbmJvbEBudmlkaWEuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPg0K
PiA+IC0tLQ0KPiANCj4gDQo+IFRoaXMgYXR0cmlidXRpb24gYW5kIHBhdGNoIHNlZW0gd3Jvbmcu
IEFsc28geW91IHNob3VsZCBDQyBYRlJNDQo+IG1haW50YWluZXJzLg0KPiANCj4gQmVmb3JlIGJl
aW5nIGZyZWVkIGZyb20gdGNwX3JlY3Ztc2coKSBwYXRoLCBwYWNrZXRzIGNhbiBzaXQgaW4gVENQ
DQo+IHJlY2VpdmUgcXVldWVzIGZvciBhcmJpdHJhcnkgYW1vdW50cyBvZiB0aW1lLg0KPiANCj4g
c2VjcGF0aF9yZXNldCgpIHNob3VsZCBiZSBjYWxsZWQgbXVjaCBlYXJsaWVyIHRoYW4gaW4gdGhl
IGNvZGUgeW91DQo+IHRyaWVkIHRvIGNoYW5nZS4NCg0KWWVzLCB0aGlzIGFsc28gZml4ZWQgdGhl
IGlzc3VlIGlmIEkgbW92ZWQgc2VjcGF0Y2hfcmVzZXQoKSBiZWZvcmUNCnRjcF92NF9kb19yY3Yo
KS4NCiANCi0tLSBhL25ldC9pcHY0L3RjcF9pcHY0LmMNCisrKyBiL25ldC9pcHY0L3RjcF9pcHY0
LmMNCkBAIC0yMzE0LDYgKzIzMTQsNyBAQCBpbnQgdGNwX3Y0X3JjdihzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KIAl0Y3BfdjRfZmlsbF9jYihza2IsIGlwaCwgdGgpOw0KIA0KIAlza2ItPmRldiA9IE5V
TEw7DQorCXNlY3BhdGhfcmVzZXQoc2tiKTsNCiANCiAJaWYgKHNrLT5za19zdGF0ZSA9PSBUQ1Bf
TElTVEVOKSB7DQogCQlyZXQgPSB0Y3BfdjRfZG9fcmN2KHNrLCBza2IpOw0KDQpEbyB5b3Ugd2Fu
dCBtZSB0byBzZW5kIHYyLCBvciBwdXNoIGEgbmV3IG9uZSBpZiB5b3UgYWdyZWUgd2l0aCB0aGlz
DQpjaGFuZ2U/DQoNClRoYW5rcyENCkppYW5ibw0KDQo+IA0KPiBJZiBYRlJNIHN0YXRlIGNhbiBz
dGljayB0byBwYWNrZXRzIHN0b3JlZCBpbiBwcm90b2NvbCBxdWV1ZXMsIHdlIGhhdmUNCj4gYSBt
dWNoIGJpZ2dlciBwcm9ibGVtLg0KPiANCj4gSSBzdXNwZWN0IGFsbCBjYWxsZXJzIG9mIG5mX3Jl
c2V0X2N0KCkgbmVlZCBhIGZpeCBvZiBzb21lIGtpbmQuDQoNCg==

