Return-Path: <netdev+bounces-202331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88AFAED5F6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833321886545
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057B211A27;
	Mon, 30 Jun 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mG3T3wvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6041E502
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269315; cv=fail; b=D2a95hOp4HO3JJg3lGdqx9mSYWPgsBIYdC8joioOwCtwhohzCGbS3U/JSF77uERdytzteIOE3nHlRX5MZUfXss85Syj4xAOCKRUUsWz9I4S7296sBqbWuf8fldiCIEZKY8knl0hjJVgAbQhlqesobo8hhnCCPGyH2HRsKqNsyU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269315; c=relaxed/simple;
	bh=GX4Sbr/yMsealRE75seWAzpQj0rgnKp0WZa4kkEn4Yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/WcrzAPmg6/3MrABn7ImxYxt/kmB2IKlPY65zByVIpg1nsBbJ8kyZ5ulrCmzeGB2xNLmZwn2Ke5BBUpUt5pJtVUE6vXptBWsMyR5P+RG4bWPmDAQrx3/vHIpgDQhOFTTgCFW5gQMF6Ac8+CI9lOqIA4viktxsimgq/a6YdyklU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mG3T3wvQ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U5wLPI030760;
	Mon, 30 Jun 2025 00:41:30 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2119.outbound.protection.outlook.com [40.107.100.119])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47kmwcr6ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 00:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THhM9BS8EwIRe0av/dvdxwWB012i3lt6PR6odV7rW9u6MPDPhXBwDMponXedbCHe/y9cUR9jhPKrW2PIfFMv4+OfA6nDZJ3oAuydQ2FGuVYpLwGxorYngrufJ49IhsLMV6vbxSVGCDzPRoM9urTKbrOOW711JuAjX0uznvXg5E+jV3nOkvYpQYwiro/ApKsr6eVQ0lPBFXuCmCh5y2TXDbZ0k18gQOTiPiQxbUKTQ/zgyOKgsMto7/T36H+Jituj4oyF48cJZa3c398dFhFQP3FeRMjXysAzY9Q+oEipKtax1cGF0gvL4IJUMCDy1b8/zAHQXzvmO36gcHGw1nvgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX4Sbr/yMsealRE75seWAzpQj0rgnKp0WZa4kkEn4Yc=;
 b=ezFa0TZ6IeyS2SMItvvDAYVMvhY0UF+/3JMnwXKN4z/19339S3MW1Dr2P9b2zp4cpAyyWlms95vFufXmJkbSYgFzkfQ1KFrRXfl9b6ZxslhfpAVl8UqfL6wq7LLKKfOKe8/gHwBLMPlJQ7TxWtmO3k0uFszmbGJYvzArKBq4/CPLc8jahrFhD8aijKuxkC3lCyn6k0gOf8VFhuQuUED1qlGEnjIdCFr3WCtF/VaRXHi8JHNlsklbeslB4Quj+BaPvWFzG1r0BQeVHxMD6DQ5UCITuVhKqZ1v+AZJh3M0YX70LxLWGFXtA2oGGLYo6mqaOEomY3FaasbUe0Hi0tX2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX4Sbr/yMsealRE75seWAzpQj0rgnKp0WZa4kkEn4Yc=;
 b=mG3T3wvQR5ByaIMHy2+SJOUqNlfXDQIRSlokoe5d2H57VPXVXi+mbXyiijFq7EhBRZxxC7CSmHOXvqDTVDnUsQ7oknne9Y5YCfEx6jESExrWaS+a+TYtSoPq/X9KnC+Fgmas6VwT6T+slD6i3nQR0K6vTEha2MjH/bsYEyoe8zQ=
Received: from DS0PR18MB5285.namprd18.prod.outlook.com (2603:10b6:8:123::20)
 by BL1PR18MB4231.namprd18.prod.outlook.com (2603:10b6:208:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Mon, 30 Jun
 2025 07:41:27 +0000
Received: from DS0PR18MB5285.namprd18.prod.outlook.com
 ([fe80::6de5:adca:97fa:c4b8]) by DS0PR18MB5285.namprd18.prod.outlook.com
 ([fe80::6de5:adca:97fa:c4b8%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 07:41:27 +0000
From: Igor Russkikh <irusskikh@marvell.com>
To: Eric Work <work.eric@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jackson Pooyappadam
	<jpooyappadam@marvell.com>
Subject: RE: [EXTERNAL] [PATCH net-next] net: atlantic: add set_power to
 fw_ops for atl2 to fix wol
Thread-Topic: [EXTERNAL] [PATCH net-next] net: atlantic: add set_power to
 fw_ops for atl2 to fix wol
Thread-Index: AQHb6LpTtQvlAvjUqEePosMGNNqzX7QbUoPA
Date: Mon, 30 Jun 2025 07:41:27 +0000
Message-ID:
 <DS0PR18MB52850EA08A8E0CD32248E372B746A@DS0PR18MB5285.namprd18.prod.outlook.com>
References: <20250629051535.5172-1-work.eric@gmail.com>
In-Reply-To: <20250629051535.5172-1-work.eric@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5285:EE_|BL1PR18MB4231:EE_
x-ms-office365-filtering-correlation-id: 078b784b-6c1c-4ea9-5191-08ddb7a9859b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?erXjiziMnoglZSh18qBBUS7tkZih0i8IeNVxBZXdSiubN3qzco8J6Rs81wq7?=
 =?us-ascii?Q?1wLzbbvmnv8yjokfccz8Ca96ymfw9LrvJYqB/1S6H89qCYcBzWB9djRCIBO8?=
 =?us-ascii?Q?KPLiM5flDkvDqlfDIISyQuTEefIXy9eMgbdEzFOhAUCTitBt/fh6V+DtRS8y?=
 =?us-ascii?Q?rfAaGBjlXYEzQPSf9D24gLItNX4JwCVKMzB2Knqrihy1u5fnG4sO77WrFwjM?=
 =?us-ascii?Q?UFNSRF5ApSdMHiluhjKrOC2Jd/poamsFSHvfAeTGCL7yLiVuO4LgRBu+/hfZ?=
 =?us-ascii?Q?RhanWxHrthhyV8gN0PovQTpX04urDP6pC917GW5Vt/ija9NptVn/qvipwHsT?=
 =?us-ascii?Q?rK+h0yKcjed45qkRLky4rxLRnbgEAOWqgWX67VqC/KjDUxH6uUzjMBQG1LcY?=
 =?us-ascii?Q?3M76oIsSfCB3/0B1R3EpDKAFcjmRRkQn87B85L65oui8lH3Fw5ynoESYLntu?=
 =?us-ascii?Q?dMuZ8bTCL24o9KxyNQByfqE2OY/sENM5/rRxeQs/co8v9+esEdPUW1H0QjQm?=
 =?us-ascii?Q?i06BJXCMW7P0pSJLZ0l0ZiJFM19AjYBgvOwvenjKofxmKkcMlDU/YOe3noF5?=
 =?us-ascii?Q?CFlr3abR/w8MjeGvYTcWF5eZdBmg1ey6530yXznb/bjSArTb3mfegBGA92WT?=
 =?us-ascii?Q?7EphWTyNPNH3okJSJ93Gi3ttxVxDy4SS4zpYJWX06hvPTIAI6yUQjLeuWurz?=
 =?us-ascii?Q?xNlsh4GRe25nz8DqMt0WuYzZ5A1WFXcz8BsPTa10woT1UO9btryvK1pjgQ6F?=
 =?us-ascii?Q?svzV95IZwY7arjKHXtooGQJA2ttjOlWYNHFEzZNwx60LOqfGC4Di4P8nueAu?=
 =?us-ascii?Q?OqRi8dvDrxDQPHBwxfoCJNKzlpq5GHnFZTZ8XdvtzqfcaTvj+TrTPtGOnPzD?=
 =?us-ascii?Q?o98KZnoW00RV4jEq2bGdom83luK64wvY6a/uezWr+WXrtdpQgwh/juz6JrGs?=
 =?us-ascii?Q?M4vOD2twQ6WRLfYpy59wyo5WnN/So8j6mJpLgXitWa3ML90wQIK4JZz7y/eu?=
 =?us-ascii?Q?Cf2cGgk3SyLTmQb77gBCOhd+tJc7h+tMtK6ueqFD5zRl3iLnzK+SCetCjZUS?=
 =?us-ascii?Q?1XPbI8TCZq8d73xaoKsKGEpqWrj+oJvWaltIZ8yhPidwyVsW9W+UW3CCiGe5?=
 =?us-ascii?Q?qSz8r/8uQM4SHqci5Nls0Qqen3E65Ds61vGepDleqPbQWmxx56SGdCnw+0Vx?=
 =?us-ascii?Q?8HvtiaJ5vKHQqtl9tq+NGIApq2jtSjgRZIrOfkn3pCYKZt8v7vCKDVJ4o/pU?=
 =?us-ascii?Q?JMx6iInZQF16qG7ADhyvTo0NkEO7KKNyS7Tr6Oywgj9mjNU8NiHVjaRlXYxx?=
 =?us-ascii?Q?c/WZBncDlsDD3OlMQyv/zrcFb4urYUo0FDq2MlXVDRRlSMzAXp4+GZP/mKk0?=
 =?us-ascii?Q?oJ/IjsEn7c0/MB9KxtElB2iXqVB6+yF+MFMtr/uehkJt0T4opp5ZkYbHqoZt?=
 =?us-ascii?Q?+5kjnaJDGksjqFlEhwJkLl0F7P+m6070zqrgMZBpmOJdTYPDGkiiwQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5285.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zKabyspfwGUdkwPgH6o2X0XYCHYrsDoBrZTs/aKBtmA0Y0hkYGrE5pOGrPBw?=
 =?us-ascii?Q?BSLSBp4tqPgnO0vnTk+CU7YeJ3A3kZh+dWeurknjOpJTkb1h5YEiNsgeRf0f?=
 =?us-ascii?Q?RFq50rmTUCpqmY4NASriFp9DSkWEguaRJAzl6qNcIyo4nXVFaj2O/hHkxlac?=
 =?us-ascii?Q?WtIt/gYjGLTbQ741g5GNb6ahPJBcgs7rOVAzOweMHysMvXPMj5Rfw+iDbANt?=
 =?us-ascii?Q?eXiQRmpbcv5jBn4IYIh1KwObI0S6p38JY9lWS5fN2gA/B2sahPR3HZCQYPhY?=
 =?us-ascii?Q?AT6O+1lOF0LcZVYq2kckF0P0CftXMHy5zzAl8n48v9LgUFvAqApTiffP6jl0?=
 =?us-ascii?Q?wHbucnlD62D/rjGmFvTU/nxxq0IbOVeuNVcTpKpPMFrnxhmyaXQHmC4sr3ak?=
 =?us-ascii?Q?Jl6BwvFLZDwT5zctFN5ypMolsfNmzfYqnP4Mg3AGf/BdFiLDDJ6Bqjc8JzNh?=
 =?us-ascii?Q?nkMX7ESzdFtumjk5QKvviqq7h0UbFAGXVTqS+hPQ/36/+fAoM1BOdNmk+I78?=
 =?us-ascii?Q?TRgDGVlsdHKyeUx0PIROHwU/KA0p5YlG720KwSW/H67HpN36ZQbFaCUVkiQY?=
 =?us-ascii?Q?HWkXqEN+jCM6Zy0jD9mvA8sRwGWVejvMpCtIDovyc/OJ68R7GOr4QaD/JSsF?=
 =?us-ascii?Q?qxaw/mi8jrwUNSg7g017GHg82xD6PhMButfsouWE4c0Uda+HLSDLZ6B0WnQJ?=
 =?us-ascii?Q?8U0Dv8wZeUulRrB6ovtlvDJ+uLDJBOFr0cF8k92h8cHbkUK4bSSZEQJPUoCC?=
 =?us-ascii?Q?ZC/nxVharsXX9V6F+SzYaDI8hzov4bS9uJApn91o0pME1sD0U+sncicoYi/P?=
 =?us-ascii?Q?VSr31Z4gCdBb4ubmPABUhyYveWbQd0eMh+QV+cZOtR7lro39GZ7PxwD5qtbS?=
 =?us-ascii?Q?ggmLyL5+Q79emMGA+n2JPMzBixENpehGaRzWfztNFCxUb59xvm4X8lqnb/QE?=
 =?us-ascii?Q?WQCmhw5ybxG3lwpk6snTuZhDdgWPoMjtQpcdQc3a9IIaHXgV2sbLwTZjWIHa?=
 =?us-ascii?Q?0KHehs3EM9DHyB6qVvn0HArJ3WssnEsY3gZY/DrHSRPF1evZ8DMvnpK0gNec?=
 =?us-ascii?Q?YrnD/JxJx/Hjf7B/4Dl6jqZQInyJMQ9HgNMbaGUmrX1Qy311x7oaniNmMEaX?=
 =?us-ascii?Q?JfiIF/9e8I54ZvOQWHhNV3ZC0QrRBwhaZFgU3PHvAbiUdFgLltQk8Usp/xxJ?=
 =?us-ascii?Q?KTrGTdtud6w1sTP/eRcgcY3s0RfOc9zoK8unePh56y7wEYMLb7s05HqnSFn1?=
 =?us-ascii?Q?Ob2WJuO3KmrkVboTKq/FdPxeogk1fEbnXckKvpSXURkx8dK62xMP6UxmNjbl?=
 =?us-ascii?Q?CSk2iZdKg2s1odI7Ei+mhqHlsebWbdQg4cEOrh2uc3koOMhLYHW1DoSylaW8?=
 =?us-ascii?Q?jXvCTq7b95R0MiydBEudwnYESFrQhVxit4AhW2asj36LoHIwPihYuqxlrJ7z?=
 =?us-ascii?Q?UpUaz7ma4CFerNcEKoKW4RIkUahzP8CZMO/fFz9y5IaWdrHVUdaZdCFhimCh?=
 =?us-ascii?Q?yw1i6TsBY0YjvXWerGaJ9GiIr9wEWJoIwp5EDcNEK80PdgekGweJ9HJipUCi?=
 =?us-ascii?Q?W6+gQnX9HF2ld3oybgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5285.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b784b-6c1c-4ea9-5191-08ddb7a9859b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 07:41:27.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lA+IRl4+BrVpA13u48cAX4PFrmCksA3gN4qaGEs2oCWwAxPp8PTnqO1Zp5XMmrIsQOisrfUX8xkaqCzVxoXk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4231
X-Authority-Analysis: v=2.4 cv=HIzDFptv c=1 sm=1 tr=0 ts=68623fa9 cx=c_pps a=pWXqNrLdDbpeoONtPtRvpA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Pmf1fwwsOS7JVESf3GQA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Ql-G1GVWcJtil-C0FlNOOJNsSenyONvJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2MyBTYWx0ZWRfX95xKAt6SCcdy r59l/Ibn5UipZXzhvwAS25j+ZEuW32PSLXYMem+TTtIk6hTMKPi+CM6fcoPwCkCHseO9eThVpht xuEKsCZIePqq376BNxY2p21Z+OybUcRsK6nzJmXaIR9zTmB2yL2QKyosAeogzERV/MlYHsJFjle
 O1Tv8Xb7uiC84UU+ItwlkDDXCOgatIs7x/p614g4AQQXpisQz9SyzALn+ZH/jgIE9nhBggZYsa5 l0KPxkKHgapwqL5JhlIJTEtG/eQOHMKx479JMIQfngMwQ38wBSynuL3egVxdcSTjx1f0SxVXHkg SNE2pWrT9W//AY23G7wm/YuOnKVK/2gBPZcOp8OTbC8tRYHJa8FzugKPZiOWKztD8PEiQ70lXqy
 2phlkh9Gh+jajZk4oKr6Y+mKHbJnupOS+G/e4j/9iavDV54EZqRjOcBmUaL5v1N0tlOKciW/
X-Proofpoint-GUID: Ql-G1GVWcJtil-C0FlNOOJNsSenyONvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01

> Aquantia AQC113(C) using ATL2FW doesn't properly prepare the NIC for enab=
ling wake-on-lan. The FW operation `set_power` was only implemented for `hw=
_atl` and not `hw_atl2`. Implement the `set_power` functionality for `hw_at=
l2`. Tested with both

Hi Eric,

Thanks for noticing this and working on this.

Reviewed-by: Igor Russkikh <irusskikh@marvell.com>=20

