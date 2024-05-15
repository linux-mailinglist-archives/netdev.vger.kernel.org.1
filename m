Return-Path: <netdev+bounces-96566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E91F8C6758
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B8C1C214E1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425C85959;
	Wed, 15 May 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+9uPTrV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8A3BB4D
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779671; cv=fail; b=Cqf7dyNFNzLs6JG6bXKYE/DtgghMNG9v5bd9GD515OUnXiYAsNMKsuPNnKu2GIGiIefiVN4RDo98jPlwuy+Iwe8MrODr1RsEcWe6o1JjtXc0YA85feh57nBDhxtTD67kqTk0a2HcKj3e079923X+5tYWWAYJ6GDGZLUw+20+QXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779671; c=relaxed/simple;
	bh=RB77izVygw1gTaXSY3TNCJtimqP+CpS06PblnXIzLA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxKAW9hunsOOCoiTnn3fakkOM0ap9Z/PqQTU3ICH16YJhBOW40mG/kUb5jU4tAldkPAxYHR8Qik6DT13ZL7IVdUCCZOQxwWWaKB0V5ge936Hp+K+gLlT6aAMlabKLNl5rvBTkoCaETPFBUUmsGuFHCD0fWavxn/dALAAttVHpcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+9uPTrV; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/eyfD0dKcaNZLxzQt37LzpLEFWX2fCzrGR5hM8zo7juccow53ZBjS7xQoYkkeEgNtr8fU0fQVM/hvIa+tjY9RKKPW+MYMZaTCpiwqhTYqogCbh7zYKSh5v/mqCTVP76InPgURNgXN8s2z9eipP//ZRJehf8RbDiQHt6yoCh3qO84Yp62lBbY5a8DqPKVj+yjVMudPO9KYmpYC2PvC16cXpCngzlqcbmsv8UKnNKpsO7Ucrtm1MMmMrBLo03fxUUHcQVG9rKPZahOInVp6qwJeNgffLt4o+h4L14FkWUd1ZiLlVBie3zsGCX2xIKoqo3SJjGbpcdo1TFj8EFJ3dU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB77izVygw1gTaXSY3TNCJtimqP+CpS06PblnXIzLA0=;
 b=WFtbYnSg5DIouyBJU2o7WqPRMuT3RiQKk0CY0aSMyIkz5wl/IldkzDBXKQe14xEesh+kBJfW+RLtcDOpoIuC+db8nHZ+wdgiSmOJL8EIwUYBdr+bA+Is2GXwVPpuH18n2xgLPH7HFoJiKs6MIB38x4vcLXrU5PyyN5faqKjlLSCX//PuN8HdQD5JMHmYFEvaAte+orr8/nh3vdUc/VhsGWXtRuakSOEj5oW1PIE8zqMquWiziLGr5MY8Vda+tMmF83qS8MXjhocNRnN6NAt7SYotPRSyLF0KFby1N/PVvOsQPtdOFoGJqOTjAyMKzzgT3Q/3xvqoPT3gq9uxFbr9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB77izVygw1gTaXSY3TNCJtimqP+CpS06PblnXIzLA0=;
 b=t+9uPTrV93gGcusZ13NTGTyw89ALOcVGoYdah+GmvI1majd+RaR/OiPbS0Q//pFBIB0r1RZm6srlJX6QwbiBtboPL4fWwmNmV1nydZy4FnEGhmCWimOKF8wlHzBN2cg6LGG7Ao6eyucv/Wv/KgtFSHwBwg/lPvXEF7LNsdudAtfhpJm4YtbRW3Lo+g2x+kUW0FibjaN0t7cOvAUxfHg0au5cs56i0RTAMiNw4ZtK7gkmfGpldz0GFVKOfbmwPLkMv12wyaRl9dsyBjmy8N6ea71FeUAIQqc9C3MdsYGKKXEfplYtFinnf3XYgrdZZFWf5ga9ulJYA5dGDCN9/r4IVA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Wed, 15 May 2024 13:27:43 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 13:27:43 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next v6 2/6] virtio_net: Remove command data from
 control_buf
Thread-Topic: [PATCH net-next v6 2/6] virtio_net: Remove command data from
 control_buf
Thread-Index: AQHanZf9cVGptp/vaECNO2XWW1B7cLGYUC4AgAALy8A=
Date: Wed, 15 May 2024 13:27:43 +0000
Message-ID:
 <CH0PR12MB858041D6E8A46B12E4E795F9C9EC2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240503202445.1415560-1-danielj@nvidia.com>
 <20240503202445.1415560-3-danielj@nvidia.com>
 <CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com>
In-Reply-To:
 <CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB6559:EE_
x-ms-office365-filtering-correlation-id: c47900a1-ffb9-4a6f-80b7-08dc74e2cd3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjNXQmJBUG1SMzl4VkFOMzFSSjVTWHZYM2FPNTNEWnJIV0ZEYkZpalZ5UmpF?=
 =?utf-8?B?QkFJYmE1REZBQ3hIR2YyVTZIeDhpYVZFcmk3aVBERHN3SVM3SUQ2UXJEREJr?=
 =?utf-8?B?V2swVDhrY2JtUGdCWFJXaXFseGJTbllzL0VaSXdlY1B2QWtjOW1IbHAwZnl1?=
 =?utf-8?B?LzQ3dmQxU3V1cjJZRHU1dHRiL1I3Tmw3TXRpWHZHQ0R0aGNKcXF2SWpoSWpX?=
 =?utf-8?B?bWVmOTFXMVpRaGpZQjFkU0wyVVk0cHVFOEhSakVad3A5SlRBUVhmdWg5cC9O?=
 =?utf-8?B?Y0wzSHFJQTVHaFlVZGl0dVoxTEYya25ORUlSdEx0bmVTaEhuRlBaRnY4RjJR?=
 =?utf-8?B?QlpkNHdFbjhObExIK3RyN2x6bWJGdzlkNGdIM3RBRks2MVNiNHVTUlRzNitn?=
 =?utf-8?B?bmE0eXhESmkxd1R1N2duL1N5RlJyT2R3MlcxajNGTHhSN3hrTi92M1Y1Rm01?=
 =?utf-8?B?L0l4K3VKSFhnOGNtMkw5STN6cGFJVmVqU0ZpbTJrL2p5Mnprems1WHNSanZ5?=
 =?utf-8?B?cUEyUzRCZW9UQ1ZlYjJOZHpTK0R5L3BZQTN5WlBwQ0V2TjlUSDlIbm9NNjNZ?=
 =?utf-8?B?eVV1RFRnVUVCSXdVclEyaFh1aHpTaXJNNDk4UW40anRHQjdPVkI2L21TQTVR?=
 =?utf-8?B?dkFyNCtNT29waDIrVFJ3VUpZVkppeGJWNnBHY2ZBb3E3VmpkdnlpbC9SQzdv?=
 =?utf-8?B?ZWRSWWtTcDIya2Z0azRvblh6b2Fpa2s5YTVhb2k2QVlQSXJ1Y25MV01DQ3cr?=
 =?utf-8?B?MTgvNkFicXhJVnd5ZGxRZC9FY3hKNU5QYlE3OHNCSGlNb3dIRVpHTmxLZ0F2?=
 =?utf-8?B?YW9YM0hnSjkvMUtodWZlT2JOdytPSmt2RGF2Ymdnb2FPUFlDb3QrcERWWEcx?=
 =?utf-8?B?Wm9iUU84eW5qUGh1bmg4RkhSUHZVYkxYdEJISmthUUNlakttMFFWaXVUa3J3?=
 =?utf-8?B?ZFFqOER0NDZkREV5V3d6TGpwSUpBZUpvVm92TXE5WEdMN0prTFRxaDR1Uk5I?=
 =?utf-8?B?N2JHeHRPM1JWWDVtZGlBU25EOUFHTWhuZ1ZiMERIZGFDeE02WnBiMEYrNnNK?=
 =?utf-8?B?RTRWT3lZQndneXJ3ZWYyOTliSjhmZ2NTUVBhcnpKNTNlNTdkL00zMkk1ekh3?=
 =?utf-8?B?RnlpMHhWRXI5V1VrU1hLWlJNRVNya0FLM3pWOHpjQ2d1L2R4djRGOGtCa1hy?=
 =?utf-8?B?amhITnRCL3EvQnpxRmNwK0REQjZMYU93SmpMUzMzVDdTVWZQeE9jRmlGZ1pp?=
 =?utf-8?B?YXlwcmFsUkdGYSthaVBpWnlLdnZZSjdXVXJVK05Rc0FYdnhNRXh2dU9uaW1G?=
 =?utf-8?B?S2x3UURmZlZoM09NRkFWUUVqMjF6eFdVMy9DclFvQ2MxMVV6aEpLOFhvMXpw?=
 =?utf-8?B?OFB5dW5tSU8zSEs2eU1iRExpWUNVZXMrTHRqdFJpSHhqd2xpQ2k0WndLOFRr?=
 =?utf-8?B?ck5NUXIxa3BUZHRqc2ZMcmJCZy9BaEdTME5qYlEzMDRpZ2p0dkFsT3JhNGw1?=
 =?utf-8?B?UnpHakJNT1hNZ3dEdXlqYjFFSURhSmhNTkdyNVlBWHBRcXk5dW9XTkdrRFJR?=
 =?utf-8?B?UUpQWnMraXN4NXBXc2tpc3gycE9BM21VbVNPSFlEYnlNNng5V3BlSkxaalQ1?=
 =?utf-8?B?RUxoS0wxYlZkUVNVSW53TkhUNzFTUG53djNSZVpEZFE3VWRBbFBCYk54ZFgx?=
 =?utf-8?B?dUpWTlAweTB6YU8rbTJ4TDhleEFDK0x4WXlGeGJPZjB2d2lITTlLbWpwL052?=
 =?utf-8?B?NEc0bFBCeVFTSENCRVFXcS9VYzFwNlVzNE5ncWdEVDU2WmV5WjFDQjhHdGc4?=
 =?utf-8?B?ODZUSy9MZXlVSmNMdjFlUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjhoajBXS0NoNWJPaDgvSlB2Rm9yTmNrd2V4ekRld0RmNWo5Q08yWEJWTlhO?=
 =?utf-8?B?VGYwTysza3hIdWN0MmErUnppY29xQWdwZWJKZU5USkFDOFdSQnJ1ckMxMkNk?=
 =?utf-8?B?VDZZVGJMQ1A3YlliZzBMS08yaitoYjAxUTU4RXdibktIL2R3Tk5qVm9xaU1o?=
 =?utf-8?B?TitLcThraTJ5Rklqa1VPKzZsYnU5VjlxYzQwK1I5UzQ1TE4vKzlQcHBuZzNv?=
 =?utf-8?B?MFlJYnhKNVlrMzEwVzd0bUE0QXBaUFJ6ZlJkeFYwemdJcjNzR1hjYXFxQjRw?=
 =?utf-8?B?SGFLL0xvTThUK1YyRTNuSjF2YVFDZk1aMUxJL2hoUVp3dStDRngrVWd6dlBW?=
 =?utf-8?B?WGNyYWpybElTcStyTG45T1ZCZ21DQmIydjljbDFuQUh0TjNWZ2FQZGRDNkRK?=
 =?utf-8?B?cGIzQXBIQjNQenBiQmdhQVhQM0p0bmhSVStmOHEzNHd4aTN4RnNPZHRDcUZi?=
 =?utf-8?B?Ry9FV2VXL0wxRkU0dTZOQWpoVTg3TFd4NlAvUTVMaFBpenExaCtYRmRFZHQz?=
 =?utf-8?B?U25rNUg4T21sdEZBWUk4b25aeml5eTVLaCs5QVFiRXNGTUJuSFA0RWpqM3NK?=
 =?utf-8?B?c3YwTVhWaXFMaFV2WjFoNnl2T21qWFRNejU4RDRHMitmL0F6TndUbkxUOG8x?=
 =?utf-8?B?NWFIMVpobnhnRXRDV2wxQVR4ZzlNZmpySWNqMzh3a3pkYWd0dGUvMTViV3lR?=
 =?utf-8?B?SkhMdnpUT3pnTWZ0RzZVNTQ4WTArQjZ5endVb1Qwd2ttSFJSdURVVkU0TWhZ?=
 =?utf-8?B?K3E2ODVGYkNQbUs2MktvcjhoYllsRFQvbUZ2UDNid0wxYjBPQTdWM3MxcnBF?=
 =?utf-8?B?WWpaOVRoWVFHUHNvdkpiS3YwNXZJMGF1ckFhcVhlaVRsd3FEWHZhZy9FRGRZ?=
 =?utf-8?B?TElDZjIrQVFpRUcrMXlkMG5qbE1lTUg0UnBQR2NkalMva2VDeU4vS3VwUklh?=
 =?utf-8?B?ZmtrS2NUTzR4UTVUVGV0QUcvSlA2NGViNkx0emRRYTg1cDZBVmdGTmpUU0Y3?=
 =?utf-8?B?M05VcE0yajhsKzFqdGlXNVI5WCt4eVk0dGN5OWZuVHlKU3dBWTJBU1A2bmh5?=
 =?utf-8?B?NVBWWmNZd2JJRkN6eDRHNEMveHQwOUttM2p3bGorZGQ3bWFzNk0vNWlJaTlM?=
 =?utf-8?B?d2VPbDNTN3p0bDAzMzJtUTZGYWhLYlo2UUJwMk04YUtWeDh2OXIvSkE2NXB4?=
 =?utf-8?B?WXdjc20zemswLzFiZ1k2WWNXUkxHejMrWk10SkQ3L212bUREYVJidVJuVDRm?=
 =?utf-8?B?RG5BNTdvelJpcDdxZjFKSFpOSHlBdFEvbm5GUUs2bkJBZGh1UUlLcEJseGFR?=
 =?utf-8?B?K3NkSnp4aDYrVUxNYWRsWXZSVXo3UEs1Z2xvVkNNY1RnelFhakpzbll4RVdG?=
 =?utf-8?B?Nks3Wnl4bkQwSnlwbm5yNnIycm9rZWx4ME80S25IVDIzVzdYQjZyVllzUWRp?=
 =?utf-8?B?bjdpOWQ0TytzeGQ2QWpEU0NJU2RXWmJnaFVla1J5ZlFzaGRrK2xJSjA5RlE1?=
 =?utf-8?B?Z1BzcnBqZUYzaWZ0QlUweDdCaTlBVTQrRXNLY3RaTHNWcVVoRWFUTWJWNlBz?=
 =?utf-8?B?Q1hDN3ZUWlNkN0kySkdCblZwTGN1SFM2aGVMZFFOb2NGVDkzMEVnaUs1OStY?=
 =?utf-8?B?cVRMVjZPV1puMXFkaWpiOHpSME5jYkQrQm1oZ2t1TjRnUUdLWC9VNDA4ZTF0?=
 =?utf-8?B?RTExa1ZJYzUvT0xlR1VmSElzTXE5ODVTU3ZKbVBNZ2tDS3czNU1rRlpWZXRJ?=
 =?utf-8?B?VHdOOFFrRk05dEI0bUF2Y1Z0cXk5STd5LzJ2Wm44Lzl0RDd3OW1SYlJwd08y?=
 =?utf-8?B?Uk9WZ3VrSlRLS292Q09Ea083SjlYZUIvZHM5WmF1ZkNUM0syRXFPSG1qYURu?=
 =?utf-8?B?Ykx3S0RKQ2FYZmZPVjBiQU5CTWNvUVZCUFNuRSsvMVllUWg3MnMwbExIQmpl?=
 =?utf-8?B?RjVKZmFSVFdVbVNOTnFvNVltOWdmZDFMc3BpZXFzcGRCRXNLWlJma0VQbW83?=
 =?utf-8?B?bUlBcWRTd1M3WUhJV2FCVUZpcmxqWmtuL0FKVmFNR3R3a2VzejlXeTBKN2pC?=
 =?utf-8?B?RzJaLzdiVlQ3WktaMFJnWThGdW5kQWdjVUh0OStQYTZSS0llTm1hN0RWU0t3?=
 =?utf-8?Q?kIS08dmi9pYN1ieN4QiBERq8B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c47900a1-ffb9-4a6f-80b7-08dc74e2cd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:27:43.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnX2jHZuMHJnXMp5ZjqJm7nmxRJ2lUJxj7nzC8Bgas7m/sjrCFcfLQNScMOu4SbUWOyt123ysX09YYnsIRIYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

PiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDE1LCAyMDI0IDc6NDUgQU0NCj4gVG86IERhbiBKdXJnZW5zIDxkYW5pZWxqQG52
aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBtc3RAcmVkaGF0LmNvbTsg
amFzb3dhbmdAcmVkaGF0LmNvbTsNCj4geHVhbnpodW9AbGludXguYWxpYmFiYS5jb207IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3ViYUBr
ZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgSmlyaSBQaXJrbw0KPiA8amlyaUBudmlkaWEu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHY2IDIvNl0gdmlydGlvX25ldDog
UmVtb3ZlIGNvbW1hbmQgZGF0YQ0KPiBmcm9tIGNvbnRyb2xfYnVmDQo+IA0KPiBPbiBGcmksIE1h
eSAzLCAyMDI0IGF0IDEwOjI14oCvUE0gRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlhLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBBbGxvY2F0ZSBtZW1vcnkgZm9yIHRoZSBkYXRhIHdoZW4gaXQn
cyB1c2VkLiBJZGVhbGx5IHRoZSBzdHJ1Y3QgY291bGQNCj4gPiBiZSBvbiB0aGUgc3RhY2ssIGJ1
dCB3ZSBjYW4ndCBETUEgc3RhY2sgbWVtb3J5LiBXaXRoIHRoaXMgY2hhbmdlIG9ubHkNCj4gPiB0
aGUgaGVhZGVyIGFuZCBzdGF0dXMgbWVtb3J5IGFyZSBzaGFyZWQgYmV0d2VlbiBjb21tYW5kcywg
d2hpY2ggd2lsbA0KPiA+IGFsbG93IHVzaW5nIGEgdGlnaHRlciBsb2NrIHRoYW4gUlROTC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBKdXJnZW5zIDxkYW5pZWxqQG52aWRpYS5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMTI0DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NSBpbnNlcnRp
b25zKCspLCAzOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgaW5kZXgNCj4gPiA5Y2Y5
M2E4YTQ0NDYuLjQ1MTg3OWQ1NzBhOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiBAQCAtMzY4
LDE1ICszNjgsNiBAQCBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX3JzcyB7ICBzdHJ1Y3QgY29udHJv
bF9idWYNCj4gPiB7DQo+ID4gICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX2hkciBoZHI7
DQo+ID4gICAgICAgICB2aXJ0aW9fbmV0X2N0cmxfYWNrIHN0YXR1czsNCj4gPiAtICAgICAgIHN0
cnVjdCB2aXJ0aW9fbmV0X2N0cmxfbXEgbXE7DQo+ID4gLSAgICAgICB1OCBwcm9taXNjOw0KPiA+
IC0gICAgICAgdTggYWxsbXVsdGk7DQo+ID4gLSAgICAgICBfX3ZpcnRpbzE2IHZpZDsNCj4gPiAt
ICAgICAgIF9fdmlydGlvNjQgb2ZmbG9hZHM7DQo+ID4gLSAgICAgICBzdHJ1Y3QgdmlydGlvX25l
dF9jdHJsX2NvYWxfdHggY29hbF90eDsNCj4gPiAtICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2N0
cmxfY29hbF9yeCBjb2FsX3J4Ow0KPiA+IC0gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9j
b2FsX3ZxIGNvYWxfdnE7DQo+ID4gLSAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9zdGF0c19jYXBh
YmlsaXRpZXMgc3RhdHNfY2FwOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gew0KPiA+IEBAIC0yODI4LDE0ICsyODE5LDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfYWNr
X2xpbmtfYW5ub3VuY2Uoc3RydWN0DQo+ID4gdmlydG5ldF9pbmZvICp2aSkNCj4gPg0KPiA+ICBz
dGF0aWMgaW50IF92aXJ0bmV0X3NldF9xdWV1ZXMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHUx
Ng0KPiA+IHF1ZXVlX3BhaXJzKSAgew0KPiA+ICsgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3Ry
bF9tcSAqbXEgX19mcmVlKGtmcmVlKSA9IE5VTEw7DQo+ID4gICAgICAgICBzdHJ1Y3Qgc2NhdHRl
cmxpc3Qgc2c7DQo+ID4gICAgICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsN
Cj4gPg0KPiA+ICAgICAgICAgaWYgKCF2aS0+aGFzX2N2cSB8fCAhdmlydGlvX2hhc19mZWF0dXJl
KHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfTVEpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPg0KPiA+IC0gICAgICAgdmktPmN0cmwtPm1xLnZpcnRxdWV1ZV9wYWlycyA9IGNwdV90
b192aXJ0aW8xNih2aS0+dmRldiwNCj4gcXVldWVfcGFpcnMpOw0KPiA+IC0gICAgICAgc2dfaW5p
dF9vbmUoJnNnLCAmdmktPmN0cmwtPm1xLCBzaXplb2YodmktPmN0cmwtPm1xKSk7DQo+ID4gKyAg
ICAgICBtcSA9IGt6YWxsb2Moc2l6ZW9mKCptcSksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAg
aWYgKCFtcSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+
ICsgICAgICAgbXEtPnZpcnRxdWV1ZV9wYWlycyA9IGNwdV90b192aXJ0aW8xNih2aS0+dmRldiwg
cXVldWVfcGFpcnMpOw0KPiA+ICsgICAgICAgc2dfaW5pdF9vbmUoJnNnLCBtcSwgc2l6ZW9mKCpt
cSkpOw0KPiA+DQo+ID4gICAgICAgICBpZiAoIXZpcnRuZXRfc2VuZF9jb21tYW5kKHZpLCBWSVJU
SU9fTkVUX0NUUkxfTVEsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJ
UlRJT19ORVRfQ1RSTF9NUV9WUV9QQUlSU19TRVQsDQo+ID4gJnNnKSkgeyBAQCAtMjg2NCw2ICsy
ODYwLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NldF9xdWV1ZXMoc3RydWN0DQo+ID4gdmlydG5l
dF9pbmZvICp2aSwgdTE2IHF1ZXVlX3BhaXJzKQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgdmlydG5l
dF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KSAgew0KPiA+ICsgICAgICAgdTggKnByb21p
c2NfYWxsbXVsdGkgIF9fZnJlZShrZnJlZSkgPSBOVUxMOw0KPiA+ICAgICAgICAgc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiA+ICAgICAgICAgaW50IGk7DQo+
ID4NCj4gPiBAQCAtMjg4OCw2ICsyODg1LDcgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2Rl
X3dvcmsoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAgICAgICAgc3RydWN0IHNj
YXR0ZXJsaXN0IHNnWzJdOw0KPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9tYWMg
Km1hY19kYXRhOw0KPiA+ICAgICAgICAgc3RydWN0IG5ldGRldl9od19hZGRyICpoYTsNCj4gPiAr
ICAgICAgIHU4ICpwcm9taXNjX2FsbG11bHRpOw0KPiA+ICAgICAgICAgaW50IHVjX2NvdW50Ow0K
PiA+ICAgICAgICAgaW50IG1jX2NvdW50Ow0KPiA+ICAgICAgICAgdm9pZCAqYnVmOw0KPiA+IEBA
IC0yODk5LDIyICsyODk3LDI3IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcnhfbW9kZV93b3JrKHN0
cnVjdA0KPiA+IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+DQo+ID4gICAgICAgICBydG5sX2xvY2so
KTsNCj4gPg0KPiA+IC0gICAgICAgdmktPmN0cmwtPnByb21pc2MgPSAoKGRldi0+ZmxhZ3MgJiBJ
RkZfUFJPTUlTQykgIT0gMCk7DQo+ID4gLSAgICAgICB2aS0+Y3RybC0+YWxsbXVsdGkgPSAoKGRl
di0+ZmxhZ3MgJiBJRkZfQUxMTVVMVEkpICE9IDApOw0KPiA+ICsgICAgICAgcHJvbWlzY19hbGxt
dWx0aSA9IGt6YWxsb2Moc2l6ZW9mKCpwcm9taXNjX2FsbG11bHRpKSwgR0ZQX0FUT01JQyk7DQo+
ID4gKyAgICAgICBpZiAoIXByb21pc2NfYWxsbXVsdGkpIHsNCj4gDQo+IFRoZXJlIGlzIGEgbWlz
c2luZyBydG5sX3VubG9jaygpIGhlcmUgPw0KDQpZZXMsIHlvdSdyZSByaWdodC4gV2lsbCBzZW5k
IGEgcGF0Y2ggc29vbi4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGRldl93YXJuKCZkZXYtPmRl
diwgIkZhaWxlZCB0byBzZXQgUlggbW9kZSwgbm8gbWVtb3J5LlxuIik7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+DQo=

