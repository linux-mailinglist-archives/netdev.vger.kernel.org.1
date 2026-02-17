Return-Path: <netdev+bounces-259153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMKTMG/klGnhIgIAu9opvQ
	(envelope-from <netdev+bounces-259153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:58:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9EB15138D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48AD3302AE0B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF6307481;
	Tue, 17 Feb 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ckvX4a3X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wm3c52gZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249F3033F9;
	Tue, 17 Feb 2026 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365440; cv=fail; b=fqUbzpjk7nSAsl0r+UuEa7ig6KvHQK976fJz4i65ABqwSIq+q3nwuwxXcT/qWZO90HcFzbeFcb5pH1BOrbmnOC9pur9Dnq/56EVOymbbsTxeZZtZGzVFeRQjMFgqazRjwJHzcvBYJSxRiEUIrf6V+MB+/a0CwnRQU/Yq76OaOIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365440; c=relaxed/simple;
	bh=L0Efv/HOzvm3SdeVLae9KuP8crxBRVBwG7O+jjD2tHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR+G5+OorLONjuxvEaWk/oA+U//rW4mgVVqlPn07qQ+WMMNTzRbE5fg20Yp1jxxpD+i9F/m2C2x7zJ17LxrC1CpsLLNI3Vc0cKoUC8SFAqgJyLef4nD/JzsxbL5K+v2O3oTdGOzlO4aTUD0fUgkNsxya7M9ySHfb3YlE0pELqgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ckvX4a3X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wm3c52gZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNQWr3675640;
	Tue, 17 Feb 2026 21:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L0Efv/HOzvm3SdeVLae9KuP8crxBRVBwG7O+jjD2tHY=; b=
	ckvX4a3XddIh4pWpXBxnFm4vIwdXGA4AZ5UcI6IblNKmhnYTCUPLqCz0RiMTyWV9
	6KOHsrE8J0iDa+dAQwi1/EtEQKI+cBjepkDSz0XJl4rzJ0MuZPa7zA+0dHzFsKWx
	qWiZkwXYltayAqYBD8I/NCzkwCIk3wquVKPRk4MFyQVmC6ub5q+EkqnODeJh8pwK
	ngj74Z8Fv3r05AqwPJPiDvgRVvwgf0dv+1Tdt0wW2wrQa7eAsECyyiQMkmd9iN6L
	7kgqxgpJVPG9hzFbDU6QA32E8kbU065ZpK3RWXTIbbTqGcM1ZIFvAzUjV0qIyPJ0
	LP5HDv4ojZDOU+LyRR9gRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0avj17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 21:57:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61HKMHq9038886;
	Tue, 17 Feb 2026 21:57:03 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb232gbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 21:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBCvmGi7sdg1G/haUgrXF+px5KGln4Ys63TIefZdhV7PxEvQzEAAfSl7n9pYwrBn52UOJwWkw7aQSAJ+KKOYkvqNKmEigTnrwWekUKGFFJp9GNbcTFFKpm+XK5dNqWeqGcWV1DJnQM+FvRN9AREvXZX+8BLwk2RaXjTSUKXBEEtOtM6TScw1nrNDTZxHuS654Od90LHLCGVc9JTSW8XqUHaRRgg9TGLYGiph//HtGBzfDlUNjko8Js4XPDhqAUkcUCXWm6OXCvCOXidJ0wQJgXDVulqVqQiFNLHmfryMgLBF3U1uIrpFA1vkPOMErbniaJdxeUngf7rErlYbuAX55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Efv/HOzvm3SdeVLae9KuP8crxBRVBwG7O+jjD2tHY=;
 b=fpGzlpLYX7g8xo4t8L2+6Nxo7PduhakUSORKMCQtMNWiNG89kTbPs6jRgaGptprx/LnV209Qxr48eRgh3ZqJ0WyZ7eGlpaIyTcxxFMlXBCzF65/XPLhZ58YXFJCZ9TXnl/fNBMuqT10LCglRJB6RkEb++5gN6dqUgxfSg3xMokZTpG32oV00vgqUQsXWPwdx/i8SZlTwUEepU5O0y5IH2Q3ITBb7nTuJJRz6VgbGFXvt+1vlL27IhXJV+QrD6QfFG9jbFgLoVXTbOe7cFCgyZku8phntR7Ur9GRcOeWJsqZH7I7rp5/sHRB+w7/vKNm7Dfd1EtWQAUEakHFnNiSOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Efv/HOzvm3SdeVLae9KuP8crxBRVBwG7O+jjD2tHY=;
 b=wm3c52gZQPb6QzpdHNVzK1zFHs0pRECR9KDu4pshhK+hAsnxy2NpbXBS8DIyDPBaw4ypQ9S1eB4Rw9r0ltrRt44Kq5locKKeR1kkgAuS217qiam1qLk9sgo4Sg1prHqznKZWTzMun58t/YJhjnxNHDK3U4rhT0RlI9py3xp4Vdo=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 21:57:00 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 21:57:00 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "fmancera@suse.de" <fmancera@suse.de>,
        Gerd Rausch
	<gerd.rausch@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com"
	<syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
Thread-Topic: [syzbot] [net?] possible deadlock in inet6_getname
Thread-Index:
 AQHcnOKB+IathYuLikCrvvXqF2xRJbWA4hKAgAAXnoCAAYsKgIAEnxSAgAABI4CAAALEgIAAAb8AgAACZwCAABkhAIAAGKGAgAAZS4A=
Date: Tue, 17 Feb 2026 21:57:00 +0000
Message-ID: <404ef4c19f0262c6be11f885d55eeeadf8102621.camel@oracle.com>
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
	 <CANn89i+mVCLW2g1+tnbK8k9E0AkEuX7AZ+2LbO1_s2L=Gxaaeg@mail.gmail.com>
	 <50e88063-14fb-4912-a65d-172a85def1ee@oracle.com>
	 <c57f2565-a6b2-45dd-8307-871a02ae1a7a@suse.de>
	 <db06aa20-ca31-4b66-9a53-e4305974d1f5@oracle.com>
	 <1c5ce96c-3b01-44e0-8dc9-5c54e504cb95@suse.de>
	 <4cd4099b-328d-45eb-990d-793df79cd639@oracle.com>
	 <2677c7cb-efb7-4f19-8000-4ed127f33847@suse.de>
	 <4acdfdf8-a69c-4020-8a8c-2edccd482a6b@oracle.com>
	 <6d46a465-0f1f-48a3-8b4d-da063f6c45f3@oracle.com>
	 <da88f34d-8bfc-4517-aaf1-bfd0eca9c639@suse.de>
In-Reply-To: <da88f34d-8bfc-4517-aaf1-bfd0eca9c639@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SJ0PR10MB5891:EE_
x-ms-office365-filtering-correlation-id: 371ffe43-025d-4e68-8ba7-08de6e6f7a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3NvRkMwOW8zS2lzRVdidkZhb0JKVm1JMllQaGlXTVVZU0pLcmZlODczL2sw?=
 =?utf-8?B?S05MeTVDL3pjaFJrQkw1ckpKNXZlVWxQN1Vhakloc3RaaWxsandwRUtRdmFz?=
 =?utf-8?B?eFRGamlCd0NJZnBZTWpjUGFCdm5iQjBSTi9zT0d2MHlmdkQ2MEU5WnlQUkZX?=
 =?utf-8?B?ZERvZXlXay9WUlFGWFZKN2N2OXRHNnVqOWd6U0o0UFhuK05YYmxuYkZtNFRX?=
 =?utf-8?B?YUlBeEFEdkRUREZLZStvTlJ2ajNqMzNKVDJQdGpYRFhzdmJBZHNxbWNPdDBs?=
 =?utf-8?B?V1NkL3lEUDYzSVcyY3YwaFpqTUVzWEpsU0JKZmQ4WjhOWjIvS29hdzl1Nm41?=
 =?utf-8?B?WmhmL1pWT1VnN0xPSEtxMk9VRVJKS1VzVEppZkpJemdqMHU2cWljM1ZJOXBF?=
 =?utf-8?B?QVBMazk3cFNRUkQxazE3RjFldHl1UUlOVkh0cTlEYk5CZ2pMaU4rTVlqdnRB?=
 =?utf-8?B?UWpzZWpUZkJSZk16Q01LVmpWQnBoZGJnd1NhRmo0ODRKQzMySCt5dWtiaDNn?=
 =?utf-8?B?aUxydDR0ZWFZWm9aSEQ0Q1JSQ05nelRSUXhlWmRXNldZOG9MSXA1a3JYTTV3?=
 =?utf-8?B?MGV1Tkh5dWN3OW1HdVVMT01HbDJ2MzR2aisyVGZPdVBtMU5oaDZVN1pZLytR?=
 =?utf-8?B?b0FxRkhPMEJUQTNja2JJeG4xMWdZcnQyUHgzdWtFVzE0d05jQWdzbk5GN0xi?=
 =?utf-8?B?ZXZUajI2VTVadXlaSmlZWFo5RmJ1b3lyc1pJcXl6Skg1TUl0ZDVFSE5SOEVS?=
 =?utf-8?B?S0hyUmN0aEtqUlFNajVhejN0WmkwUjNkcCtMSVN2SzNoaTRPdHNIYnlNWFND?=
 =?utf-8?B?akRFZnRvTzVieVh5cjlmcUljRnFSM0hYSlRsalo5YTg1RUxySkpjeGJGb1Rp?=
 =?utf-8?B?NUVsQlZxT0kxMkZEWnNrcWYyR2lKM0J5ZU84cElpZkxiM1dzT3NnUm54Wllk?=
 =?utf-8?B?eloveGpMOHY5eEtRUHB3L1cxTFdMNFpmd1l4VlBlc2xnZkZISFpNK0N4eHh6?=
 =?utf-8?B?eDVrRmcwZlhiM1pnUEZCOFZiQnl2dmZSb1VsVld2UXdxemRzc0cvY2R4N3Nl?=
 =?utf-8?B?cHk4NCt3RVF6Uml4djloZndNZTBxUkk5YitwZVVOZGRGaVFVKzJPL1B5ZHZV?=
 =?utf-8?B?Qm5zMTJ5NThwTHFnU296NFlQR3hBb0VwWXNxZmRkYldzN01wenVZSFc5TG5X?=
 =?utf-8?B?R1V2MW8wZWpQMTdsMWp0OXZKbTlzTlVDWWd5TEFpNVFWUEFkaWUydW1rZHFU?=
 =?utf-8?B?S1lLU0o0WlJ6VTVNUmJRMUo4TTErN0IzQVR5eUQ0YkpnaExYYVZBNjFUV2Vo?=
 =?utf-8?B?TWVOVFVHVkxxcFhqVHJxK0kwcGlEeStUd2dZaFlLVnFCUitzMGJ3RGQrcDlP?=
 =?utf-8?B?N05EOGg4MGorNGNTSzYzdHEyNkxSbm9yZ1B3Y1NTZGJYVnM1QlBjMmlPa3Ez?=
 =?utf-8?B?K1g2MTByZHBhOXpuSlFLNElWNjFCWFZEajArQXVSd2NGUnJUUm5qQ2pNUnZL?=
 =?utf-8?B?ZnczMDdyTHhwODQwOFZPWG5CU1hlS3RnMk9HeERvRCtjTGw2MU5KeHhsUVho?=
 =?utf-8?B?Q3NxRzE5eTIyNkVmTzRxOFVodFN1cVliWVBLTTRkcTh3ZTZNb1EwN0c0ZFR5?=
 =?utf-8?B?N0ZLTmtlcGhTY0pzRWlZeGhUVWhmS0FnM1Zld04yaFJ0eTB4dWRsRTZING42?=
 =?utf-8?B?YnhNb2JSUGQ3OWc5aGRhdHVFMUljQ0RZZ05GLytsQmk2SFVpUkJENEYzYnBP?=
 =?utf-8?B?Umh4b29iV1lycGVPWERYcUsrZTE1VEVnaFRDK001M2hQN0h3WUFsTFBmM0Nw?=
 =?utf-8?B?Mmc4eUw1S0NvTkpaN3JoSDM5bER5UEs4eVp0cmw2Qi9uNTBWVWFtN3JMTGNI?=
 =?utf-8?B?VzJSYUJxMzZmK3pyc2pYSEZkd2taNjh3dXYySkx5QXB2djM4cjdNa2p4YVdh?=
 =?utf-8?B?NWRQb2hqWk5abnRBMWtmNkhMVkRnc2xWU1J0QXI1R1ZjOTBlOFdMSU8zRmdi?=
 =?utf-8?B?Tmt5cHR4YmVIR0swbGNWL3gvQ3hqSER2RHdYajBPWHQ3elVXL0s0TVdHakFm?=
 =?utf-8?B?Yk1MRWRlQW5WdG9XQlp6djRQdmdXSlJScllWSnowcnJzdTFuOGhzZkdhWkJC?=
 =?utf-8?B?YnBvQTN5RlU0RlEza3ROSTZoWjhobG5GWFlIOTFDd0RSRTZVcjM3ci9SQXVr?=
 =?utf-8?Q?0UxMcMyZxEeTZ4su7bcyxOzearIG9ww/3/9F84WHAOfV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0RYemJYdWdkODdDKzB0cC9zRUY4YXJQWldJbFJ3UExGY2UzRVluRC9Na2hB?=
 =?utf-8?B?VnNmbEdPTTgxZzMrYzY0N21DRWtQTjJDSTdxZzYrMGZnenNLdHhqV1BnVUxt?=
 =?utf-8?B?bS9BSlp3QVpXanpPTlhicDlhdnRjY0xaSUlmcjNVVzlaeVRCY0pmdndIYzlP?=
 =?utf-8?B?c3IxSnZYTktCL2RudWZOSFAvaVVqME1iUlIyaWpDYlRRblFrb05VbVY3TnNW?=
 =?utf-8?B?M0tHVUI4TndPQzNQc2Fzd1RrWGF2Y08yQ3lhTjhJMElMNlN6RlNVZlpSR3FC?=
 =?utf-8?B?cndpaWIxZFF4T01kdzlpMURaS2ZRQ1ExL3V4UmlMcURJY3hPYVFXWEFjeDNr?=
 =?utf-8?B?a3FuOTQvaTg2TXc4Rjd1ZXN5WTVJdkhnNU5lMlJHV1QzMmxoUzA2S2t2RUdD?=
 =?utf-8?B?ME5oaHl4SzdjRXR1VkgyVVNkRkJ3empTYTZNVHRUYUE4ZUNQcUpUWWtUd0pR?=
 =?utf-8?B?ZDVLRktBcmprRERNUk41TWZjN0MxWGVQMTMyQm9wejVCbnlVSEVoMVRZSUxz?=
 =?utf-8?B?NzBCd2U4cWVPajVsUnRjb2tIVzFPZ2pZUWZVd3RTQlcxZGFmcmgydE1MUTJh?=
 =?utf-8?B?OFZLK2ZKRkxiNktJNFMzYXBTWUNMSzRreVJzTnM2UjI4VnZVZDFjWWtKcHRL?=
 =?utf-8?B?L2tneFJTamhwNzVHNmZCNEJ6Ri8rM0ZwZzFOcVpWdWxhcGQ3alM3N2I3Q1dH?=
 =?utf-8?B?NnIyL0R6STN2MGdNZ2VsaUVPQTdwV3lBR3VmazQzWFYyQ3pPUGY0U1V4VzhK?=
 =?utf-8?B?OGY2UnBZSWd4OGt3UnNxeHZ5WlhVUDl4NytxV2lKSXhZTUYrMERxempWUDhu?=
 =?utf-8?B?Qm5Od2xHMHNOZkF5SjVPS2lmVWVNSlRBWmlvYlRsN0NUQldkYS9LM201QlBp?=
 =?utf-8?B?QVJlcDlZSUpTM2JZenhZdEd0bUJkcUdXMUd6UnBGTnd1UzFpT0Rha2g3RlND?=
 =?utf-8?B?ODMrRWhvd0N4NzhUWVJuVXBPVVYxZGRwQitkQzQrbm1CVVJPcnA2TzRlY3Nq?=
 =?utf-8?B?OUFCczdPYTRoZjhUS1pRWUJORG03WnVGUXFXTThJWE1jQWMzMFRtNGkvZmtL?=
 =?utf-8?B?YXRiRHpjcjJGc3F1bG9IdldMVnVNVUYwc2k4VVVPemtmaml1V2QrTUVlOUdX?=
 =?utf-8?B?MVliVmo3bmE1OUx4aDFNRkZxSnY1cWx3U2JROEIwSTRrOWQ3bVB5cWptR0dG?=
 =?utf-8?B?a3FEeGxYQi9jS21DMTNBbVNwdE9kOVRzZWVodUhzRUlWZ0pCRk5lb3p2MkxC?=
 =?utf-8?B?M1h5T2EzdjhaRHlMLzF0aXNFWmFYdTJjZEkzY1k4Z3pQd2p5R0FNcjBITTR3?=
 =?utf-8?B?RERqZnVlODYyRzZwYm1nc2dMRVRGb1grNDMwKzk0V2VyS280ZkhXcTYzU2FR?=
 =?utf-8?B?UWtJZ3QyenU0OHBCTDFRTWpwR3hsT1ZidldXbEU2dHBoT2dNaTJHZVhoMGV4?=
 =?utf-8?B?YTlMQVlOcmFOdGdHa3U0aXMvck9ZMlBSbFhKQnhkODZBZUFyVVNNUlg3YXlk?=
 =?utf-8?B?OU9JOHBneTgxZndCM25GS0s4dTlwd0YzY2tnekNpZ2dlWC9EZnIvZkR5VVhN?=
 =?utf-8?B?MG84RzFVcVcwMVN5Z2R6dGhPL1B1UVVBNHhlODEvejNHQVp6SnVyTmtMbDhS?=
 =?utf-8?B?dzRqbkNJajhDOXh5dWNDZkdIRHhmYXFsUXk1bWJVN2p1WEh2bzVMSDFLSVJF?=
 =?utf-8?B?TEZnTXdONFNkVXhHa3laYzRORDBORUkrZEpqWS9CT0FGSkh0R0drMG1tVXh5?=
 =?utf-8?B?Lzg0ZjdiM2VTSWl1aEd3aTc2OTZqUmpZSmlnSEovYkpHWHZCUm5Nazk0TDZh?=
 =?utf-8?B?Zk81bUM2VXVxZXpqVjNFSFBWOFVpc3BJZG56NTBKNkU2Z084bC8rYlpXUUFU?=
 =?utf-8?B?cC9hc00weUcvQkJtSDZPREd2QUxobWF1Q2lOc0ovL3JhN25Nc29WVGhhQllU?=
 =?utf-8?B?Skx2b1NISUZwREN4WXRLK1llQmZsN3NlMDlVMVNrVk9RMU5GQ01GSnBKQTVW?=
 =?utf-8?B?RDh6VVdrYko5MWtWZzRjV3p1dkc4WkVLOEVSWTYxWkgzd2trQWZpcWNFVGw5?=
 =?utf-8?B?R1FlaisyMlhxOWphbDF0TUN6dzJuRmQvTWQ2UER2N2w3TkhYSkh5bGVBdU85?=
 =?utf-8?B?bzF1RUxzdnY2dTZ2cUJodVRvNVQrbGNocGd2dEcydzZXNUpRaXBhMmxkL3NO?=
 =?utf-8?B?cW51K1dCL0UvWDV3RkQvM0U3aFFJNFVlYU0rVHlFMjhnT0RKTHgwUzRmZEJl?=
 =?utf-8?B?V05XbjRtTHVvMnFKd3B1RGlvbTZtc2REanhHUWR4VFJpUzRXcEcrcmRRNVIx?=
 =?utf-8?B?Zlh0THZsckZQTlpVWWFrQzZrTE1DTWJPalBSMHh0aFczSnh2YmhGRnZWWHdM?=
 =?utf-8?Q?PNFfR1caXdth22OE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <320705232FB3B74BA281816994F029D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B6Xp+o2HvLedE9dvLsrxBFFeJNq56rvpffQ7CtU05puF02ql6d3qhfA+S43LAHxcAQH/6ytIsNiXK9W/G2EIJDwMQ5Y3mr0v83QdYK0Wf7EaAr7s3uGO7vXqF+S1sBcjrGpLVCwN0i6jSeGq1r/IeD1X099Nb1vLrDI6mz/0tSQEm+heVa5mPdvLJ7qyzPE8GWxtMyRkckdf9HZW8lJnhxQ1eSr5SW5yC89eogcVwMZU/Esg2mHn1D90nfX8vRGsUhX4pNsl1ZiYAS2GV1B1mKb77yu2XLmzSZgYP3FFnFupOqe6imUxxIXp3YNVbUbxU6oqjo8YYhPc4amW0euCPYr2Ictr0zDl07qyJAriuxx4pSz45fYT9p5FQyz17AatBahNBKNSu6sxbGpqrK2Rj0XSGUcMWH5yYMZx2gF5bwjOJ7Ftq5DAnNro7JfUZ7n4iP4+Z1fI/LKfpnbTpRwRjlh8rljd1DvAFyVTBEBByMjM3RYJDNQuJIZZKwcUQ4Y8/TN9UgY8acOuDvxn+KtAOiu9JtG1YgApL+BTtkAcCprzt9GL9seQGQ8e/v6keZJUla/p6YJj1Kyivtqglc5qpeMuGXkFV0SUlGuy7fJPI04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371ffe43-025d-4e68-8ba7-08de6e6f7a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 21:57:00.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLTJp6LfC5A1ERReNsfaH4mMmupBUl2SwW7iKZHJa3pZBYSeudSUb12BWCMJMXtfTDDSYEUaoGUfEqUivmTNlgoex9wM/qalRX19ZG1RExA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602170180
X-Proofpoint-GUID: tbb6g43Zh78TUbr2OxIIvfxk9MQl3jlf
X-Proofpoint-ORIG-GUID: tbb6g43Zh78TUbr2OxIIvfxk9MQl3jlf
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6994e430 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=1i30NI4rPGFfo3ZbVvIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE4MCBTYWx0ZWRfX7ZBQ5goA157b
 YoCmxpVGGbhRCoVCiVBi6sG73aKnsPh8s6KbkKgqpz3Cpba+gissYYhtH/29TsV9WwRbcfk+7Jv
 h6WZUxazEq/1VzKFGmzez7zbxFhv+PTWDsIRkdH5Nept+CMyXiXsr5ti7iDHglHBrDvdccSJFI5
 /zzE3SFvPhtaTgzL9ZTiiw7l2Hk/buC4XIBrCSC9EbEdJTsg8PQykSQObZzhUxuM9NABH6h7PpV
 /CPMIQmGkOIceY64zwg1LBZnKL99Ay20GDXO8eSuLnEi0u4SRKIu7uB6QTJDjY5RIhtqvaEAXGl
 /iSgBsMqA9o+ZU4gizKeDabuM2iNnTxZD0frUCi6yrwEXmArmGWgQoBCZdQBhP2YND0L70FtVHp
 PKOG4ltNpf/jbMo+KzxrNDj6ZY9fqtznOk7N4TdGtXhrT2kNnKl+sS2D/VxNTpMmirxmTOs8sz6
 UzdU9nF91BhqhVMcYyw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259153-lists,netdev=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,urldefense.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1B9EB15138D
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTE3IGF0IDIxOjI2ICswMTAwLCBGZXJuYW5kbyBGZXJuYW5kZXogTWFu
Y2VyYSB3cm90ZToNCj4gT24gMi8xNy8yNiA3OjU4IFBNLCBHZXJkIFJhdXNjaCB3cm90ZToNCj4g
PiBIaSwNCj4gPiANCj4gPiArQWxsaXNvbg0KPiA+IA0KPiA+IE9uIDIwMjYtMDItMTcgMDk6Mjgs
IEdlcmQgUmF1c2NoIHdyb3RlOg0KPiA+ID4gT24gMjAyNi0wMi0xNyAwOToxOSwgRmVybmFuZG8g
RmVybmFuZGV6IE1hbmNlcmEgd3JvdGU6DQo+ID4gPiA+IE9uIDIvMTcvMjYgNjoxMyBQTSwgR2Vy
ZCBSYXVzY2ggd3JvdGU6DQo+ID4gPiA+ID4gSWYgc29tZW9uZSB3ZXJlIHRvIGNoYW5nZSB0aGUg
Y29kZSB0byBwYXNzIGluICJmYW5fb3V0ID09IHRydWUiDQo+ID4gPiA+ID4gZnJvbSBhIGNvbnRl
eHQgbm90IGFscmVhZHkgaG9sZGluZyBhIHNvY2tldCBsb2NrLA0KPiA+ID4gPiA+IHdvdWxkIHRo
ZXkgcmVtZW1iZXIgdG8gY2hhbmdlIHJkc190Y3BfY29ubl9zbG90c19hdmFpbGFibGUoKQ0KPiA+
ID4gPiA+IHRvIGFjcXVpcmUgdGhhdCBsb2NrPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gVXN1YWxseSBrZXJuZWwgcmVxdWlyZXMgdGhlIGRldmVsb3BlciB0byB1bmRlcnN0YW5kIHdo
ZW4gZG8gdGhleSBuZWVkIA0KPiA+ID4gPiB0byBhY3F1aXJlIGEgbG9jayBvciBub3QuDQo+ID4g
PiA+IEFueXdheSwgd2hhdCB3b3VsZCB5b3Ugc3VnZ2VzdD8gVG8gY2hlY2sgd2hldGhlciB3ZSBo
YXZlIGFjcXVpcmVkIHRoZSANCj4gPiA+ID4gbG9jayBvciBub3QgYW5kIGRvIGl0IGNvbmRpdGlv
bmFsbHk/PiANCj4gPiA+IA0KPiA+ID4gU29tZXRoaW5nIGFsb25nIHRob3NlIGxpbmVzLg0KPiA+
ID4gDQo+ID4gPiBFaXRoZXIgYSAiX2xvY2tlZCIgdmVyc2lvbiBvZiAiY29ubl9zbG90c19hdmFp
bGFibGUiIGZ1bmN0aW9uIHBvaW50ZXIsDQo+ID4gPiBhIHBhcmFtZXRlciwgb3IgYSBjaGVjay4N
Cj4gPiA+IA0KPiA+ID4gV2hhdCB5b3Ugc3VnZ2VzdGVkIGlzIGZpbmUgdGhvdWdoIGZvciB0aGUg
aW1tZWRpYXRlIHN5emJvdCBuZWVkLg0KPiA+ID4gDQo+ID4gDQo+ID4gRldJVywgaW4gVUVLICh0
aGUgbW9kaWZpZWQgTGludXgga2VybmVsIHRoYXQgT3JhY2xlIHVzZXMpLA0KPiA+IHRoaXMgaXNz
dWUgcmVwb3J0ZWQgYnkgc3l6Ym90IHdhcyBhZGRyZXNzZWQgZGlmZmVyZW50bHk6DQo+ID4gDQo+
ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9vcmFjbGUv
bGludXgtdWVrL2NvbW1pdC9hOTRhYmM0NDRjNDg3X187ISFBQ1dWNU45TTJSVjk5aFEhSXBPem5u
V3F3X3Ytd2k0TnM3T0VDM1NDakNvS0ItUWhJV1I1bFZQNHBFV3F6eThsajRUUXZlR0lUTG1EV1V3
VmVpSUxDUW9PNUNmRW44TlpMLUdFeDl3JCANCj4gPiANCj4gPiBUaGUgY29tbWl0IHVuZGVyIGRp
c2N1c3Npb24gaGVyZSBvcmlnaW5hbGx5IGNhbWUgZnJvbToNCj4gPiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL29yYWNsZS9saW51eC11ZWsvY29tbWl0L2Vi
ZjcxZjViNmMyOWNfXzshIUFDV1Y1TjlNMlJWOTloUSFJcE96bm5XcXdfdi13aTROczdPRUMzU0Nq
Q29LQi1RaElXUjVsVlA0cEVXcXp5OGxqNFRRdmVHSVRMbURXVXdWZWlJTENRb081Q2ZFbjhOWlho
TDFvd2skIA0KPiA+IA0KPiA+IGFuZCBwcmUtZGF0ZXM6DQo+ID4gOWRmYzY4NWUwMjYyICgiaW5l
dDogcmVtb3ZlIHJhY2VzIGluIGluZXR7Nn1fZ2V0bmFtZSgpIikNCj4gPiANCj4gPiB3aGljaCBp
cyB3aHkgVUVLIGRpZG4ndCBoYXZlIHRoaXMgZGVhZGxvY2sgaXNzdWUgcmVwb3J0ZWQgYnkgc3lz
emJvdC4NCj4gPiANCj4gPiBJZiB0aGUgb2JqZWN0aXZlIGlzIHRvIGtlZXAgZGl2ZXJnZW5jZSBv
ZiBVRUsgYW5kIFVwc3RyZWFtIHRvIGEgbWluaW11bSwNCj4gPiBpdCBtYXkgYmUgd29ydGh3aGls
ZSB0byBjb25zaWRlciBhZG9wdGluZyB0aGUgc2FtZSBmaXggd2UgY2FycnkgaW4gVUVLLg0KPiA+
IA0KPiANCj4gSSBzZWUsIEkgZG9uJ3QgcmVhbGx5IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBoZXJl
LiBBbHRob3VnaCwgdGhlIHNvbHV0aW9uIA0KPiBhdCBVRUsgc2VlbXMgYSBiaXQgb3ZlcmtpbGwg
dG8gbWUuIEFzIFJEUyBkbyBub3QgcmVhbGx5IG5lZWQgYWxsIHRoZSANCj4gaW5mb3JtYXRpb24g
dGhhdCBpbmV0X2dldG5hbWUoKSBwcm92aWRlcy4gSXQganVzdCBuZWVkcyB0aGUgc291cmNlIHBv
cnQgDQo+IGFuZCBpdCBjYW4gYmUgdXNlZCB3aXRob3V0IGFjcXVpcmluZyB0aGUgbG9jayAoYmVj
YXVzZSBpdCB3YXMgYWxyZWFkeSBkb25lKS4NCj4gDQo+IFRoZSBpZGVhbCBzb2x1dGlvbiB0byBt
ZSB3b3VsZCBiZSB0aGUgcGF0Y2ggcHJvcG9zZWQgaGVyZSBbMV0gKyBhIA0KPiBjb21tZW50IG9u
IHRoZSBzaHV0ZG93biBwYXRoIHRvIHJlbWVtYmVyIHRoZSBkZXZlbG9wZXIgdGhhdCBhY3F1aXJp
bmcgYSANCj4gbG9jayBpcyBuZWVkZWQgdG8gZW5hYmxlIGZhbi1vdXQuIEhhdmluZyBzYWlkIHRo
YXQsIEkgY2Fubm90IHRlbGwgaWYgaXQgDQo+IHdvdWxkIGJlIGJldHRlciB0byBrZWVwIGRpdmVy
Z2VuY2Ugb2YgVUVLIGFuZCBVcHN0cmVhbSBvciBiZSBtb3JlIA0KPiBlZmZpY2llbnQuIEkgYW0g
bGVhdmluZyB0aGlzIGRpbGVtbWEgdG8geW91IGFuZCBBbGxpc29uIGFuZCBhbnkgb3RoZXIgDQo+
IG1haW50YWluZXIgdGhhdCB3b3VsZCBsaWtlIHRvIGNoaW1lIGluLg0KPiANCj4gSnVzdCBsZXQg
bWUga25vdyBzbyBJIGNhbiBhIHNlbmQgYSB2MiBvZiBteSBwcm9wb3NlZCBwYXRjaCB3aXRoIGEg
bW9yZSANCj4gZGV0YWlsZWQgY29tbWl0IG1lc3NhZ2UgYW5kIGFsc28gYSBjb21tZW50IG9uIHRo
ZSBtZW50aW9uZWQgcGF0aC4NCj4gDQo+IFsxXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjYwMjE2MTIwODA0LjE0ODQwLTEtZm1h
bmNlcmFAc3VzZS5kZS9fXzshIUFDV1Y1TjlNMlJWOTloUSFJcE96bm5XcXdfdi13aTROczdPRUMz
U0NqQ29LQi1RaElXUjVsVlA0cEVXcXp5OGxqNFRRdmVHSVRMbURXVXdWZWlJTENRb081Q2ZFbjhO
WnBRc0psOUEkIA0KPiANCj4gVGhhbmtzLA0KPiBGZXJuYW5kby4NCg0KSGkgYWxsLA0KDQpMZXRz
IG1vdmUgZm9yd2FyZCB3aXRoIEZlcm5hbmRvcyBmaXggaGVyZS4gIEkgd2lsbCB3aXRoZHJhdyAi
bmV0L3JkczogVXNlIHByb3BlciBwZWVyIHBvcnQgbnVtYmVyIGV2ZW4gd2hlbiBub3QNCmNvbm5l
Y3RlZCIgZnJvbSB0aGUgZmFuIG91dCBpbXByb3ZlbWVudCBzZXJpZXMgc2luY2UgaXQgY29uZmxp
Y3RzLiAgSXQgbG9va3MgbGlrZSAiZml4IHJlY3Vyc2l2ZSBsb2NrIGluDQpyZHNfdGNwX2Nvbm5f
c2xvdHNfYXZhaWxhYmxlIiBlbGltaW5hdGVzIHRoZSByZWN1cnNpdmUgbG9jayBpc3N1ZSBlbnRp
cmVseSwgc28gdGhhdCB3aWxsIHRha2UgY2FyZSBvZiB0aGUgc3l6Ym90IGlzc3VlDQpmb3Igbm93
IGFuZCB0aGVuIEkgY2FuIG1vdmUgZm9yd2FyZCB3aXRoIHRoZSByZXN0IG9mIHRoZSBmYW4gb3V0
IHBhdGNoZXMgaW4gdGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KDQpGZXJuYW5kbywgcGxlYXNlIGdv
IGFoZWFkIGFuZCBzZW5kIHlvdXIgdjIgd2l0aCB0aGUgZXh0cmEgY29tbWVudCBkZXRhaWxzLg0K
DQpUaGFua3MgYWxsLA0KQWxsaXNvbg0KDQo+IA0KPiA+IFRoYW5rcywNCj4gPiANCj4gPiAgwqAg
R2VyZA0KPiA+IA0KPiA+IA0KPiANCg0K

