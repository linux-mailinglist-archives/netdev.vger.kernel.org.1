Return-Path: <netdev+bounces-154407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D669FD8E4
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449217A1C9C
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1563224F6;
	Sat, 28 Dec 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6rhICzN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE31CA9C
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735356793; cv=fail; b=ryZy3+WY5EdwykbfQ5lr3scyZhZA63hgAYsV1iRcQVR7M6BOuoc7IQRkhsdcJzDpvHZk0Z76Bqv6bWcRuyheymA2I+cwSj38eJ18AMsZPtsoawBzw8lVRsvRHmEJIv3/HtSoR1ljOVbQOkZ0rQ5en2bcWn5M7xwMiPiTm/im4Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735356793; c=relaxed/simple;
	bh=0hci3ukOCvzD0SQVTuL/g3J22qxuNPTUj2PKKjT2og0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNLB0nGY8QVmi4osffC6U62Ql7efT1MddJaENIKb/gVKTEvvipK1jhHs2SGuIZUB3YMJf0p4fpwLdj0chLjfGNsc1cvAYyzqJxp8igtkuRdmB8PAqg3+ZoYxVADRTADPUWquSbLjCeVicrQJgJki9fHreidneI7Q9uG0CKZoVjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6rhICzN; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmlIvkwoW8p9MB3/WilPiwK0zh6GK2RGLAJwk1GMapSnukZD1RiQBpRI5upxE1k3ZfzEvWMhLzGYhIcRQiXTCyQh4hoRSDe+tmayKbWF8RiGHSKZ2CcNAZD4E1Alom2JBcQsT/QyZGxpeZVWf0lLke2MA8Uw+DqP6Mc3+Ze3885LMySxnzTjPrvtl0ms95lVsj5Ge54CJRKxKomgPFzj9Y3GOo4NxGh3E0hVxV3jvbXdYdwBiQamC8r3m0ymKQTzvJ8XMH75Svr6hwVSaPpQB+cvEyq/n369On0+6d/gKEORS45NHbmP7aGVgjWkBy8bHNURpT8/aAVx4AtaRikZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hci3ukOCvzD0SQVTuL/g3J22qxuNPTUj2PKKjT2og0=;
 b=uRLYFw0AjwOfqBYCCBmcOM3dwouSyMWCEXRYyZolkFdi0m1DEK4d9BSEcufyELkul8dyl/vEcUHWp03oLLN333ZTj9U8Mk6T/QPppKR6/gLfwGzbeKAl12M7D9uEoXUMg+kPcVkUIJd5FJWujQPvP6LEI8I8T/s/d/GtsXXovMNb+ny2OGOckMysXBSRtKAQ2QyLI1IuvA+xThJMwX9OQwDaz+nQY8JHQFUXHi//23mt9bB8e1E5851aLXCIiV2h25eej5i+5jB37qjYhkpjfXqBhaktCncjK6T6lHLTiHbLs7DEacOkBSdMmWBhCHXXkXw+qpqkJmzXoK7Kw+bADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hci3ukOCvzD0SQVTuL/g3J22qxuNPTUj2PKKjT2og0=;
 b=j6rhICzNk+sh7OIX1haGeO7UOJs2w5d56ICf681/ySXxdHOBo/9E7oScO/5mcm5LhXpI6QIP5LI57zEkw18eHuDo7nHjJ2s5sbAVjQByMlp6/jGHD/W9MHTXgTjtTZ9aWIUCw02nm1IYZMmuOyON+vQ/z/c8jTYweNv49PaMrq//o3qrieK2vkEaopY2tApMb3I9bvLCVjHn/gnKmLYDKhMKLcprZja9WD3t99nQndDLkv987pPYqeehbu3+w3ubMEKmClrzb8xJYAZq+gQ12UhGlVbK8YIxTBmIKy8/0bDVBdTWGDoOv8IM0ZT7bfpquy8vVzPODjmmpGEtytVmTA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Sat, 28 Dec
 2024 03:33:03 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%7]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 03:33:03 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Shay Drori
	<shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next] devlink: Improve the port attributes description
Thread-Topic: [PATCH net-next] devlink: Improve the port attributes
 description
Thread-Index: AQHbUicFtrfeWJBVv0aJBtIyWfxfobL0J26AgACd7NCABa4OAIAAlu3Q
Date: Sat, 28 Dec 2024 03:33:03 +0000
Message-ID:
 <CY8PR12MB7195F16541A67545B4315533DC0F2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241219150158.906064-1-parav@nvidia.com>
	<20241223100955.54ceca21@kernel.org>
	<PH8PR12MB72088C3633116EA320A55B5FDC032@PH8PR12MB7208.namprd12.prod.outlook.com>
 <20241227101924.48a12733@kernel.org>
In-Reply-To: <20241227101924.48a12733@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH8PR12MB7328:EE_
x-ms-office365-filtering-correlation-id: 8ac24812-8425-4064-db13-08dd26f0560e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7oct4TWwQnrUnWZVPDlkjWq6n9YO7h5B61u19LYXCQOe1/36m6E7hWMhcTpB?=
 =?us-ascii?Q?VzPq80INozqNFyNYXQesT9B7IR0VQ12/NKPwhmN5BDl+xXKsHep2lx2QsSSw?=
 =?us-ascii?Q?JhNesNy9clzuxzhHbr1QvnIiEKlzezT9mkKmeY8+uFRRuMcCzX30bptBZd9Y?=
 =?us-ascii?Q?PjigArrOjP4eUh7DzApjcPVC5UtfeR/wOgj23QlaxFClNU605o40+sl9cxgj?=
 =?us-ascii?Q?iNPQaagBpFD+W75jQ0aNAZDHaBcw6IhhkP+AwY+KNiktFwRhADPREJrynqEj?=
 =?us-ascii?Q?bnrU9kupmM/rNQZmDMUQ/JoDNdeB0uLLIFQX0yQxUYN4j73TGp4kBjyfeKb/?=
 =?us-ascii?Q?TstPTVXmpc6rfChwsbSGXA1JpOXCPQVJwvCB1iOyLwYDN5jnEzjyzF6D/Hha?=
 =?us-ascii?Q?xHk4qm138ySCf9bpO47PLOP9k/YGeqjthc0VVmVmd1KdIoFfmgTusKt3Ek5D?=
 =?us-ascii?Q?dV52/YMw8nb1csim2Yut2HOvBSE4baqRse8q+xoGpse1Sop/6j1iHhqKSkvc?=
 =?us-ascii?Q?5cchdBPoIHwjb4kbKamYoeS+UPTi6WK2RZP8It1VUK48ZbFH73eVSWTbK0Q6?=
 =?us-ascii?Q?QLvIXamnbLSBLnjHROPyAhpqxGvqFYWLqxBZiLeDbFngscDWzC4TqmP0Sgjv?=
 =?us-ascii?Q?HhhcKGb8/1xV+WYiE6C52AhT9rWitqmOx5cYn4kzvzumdPg/I/oXB+WCArbg?=
 =?us-ascii?Q?REEMLjIQF8PizaEOPIW9lxHjfeP1DcfGyzAqGx5WAken5PhmdVUKpk5DPyl/?=
 =?us-ascii?Q?oCJ110D1IZN0xaT0raZUOQmbQLIRkqXzQd0PSNTcd0k8R5o6/JBNWjtpLPUu?=
 =?us-ascii?Q?i7nDp5k/Ej6T7QbC7lbFiZBKv/eN0cgBolY+A54jOP5m6ZrZCQoi8ih6fmwo?=
 =?us-ascii?Q?NQW2duiRri1LenjSz9veInYlmOmyw5gEtx5R+9B0HEcLYznik7on6dVPrrQP?=
 =?us-ascii?Q?6do8P92wskFf7zej30zhTpP8sSkd3Z9OHCbORvxS5NB4jvbR4j3UV4PKmYE+?=
 =?us-ascii?Q?6tGveiYYXRqkTpMkaJPp4C0gOKu7n6CIGZLCSxsS4GJGWo5ZW1F2uP+BuSv0?=
 =?us-ascii?Q?T9SLRXUX6a9uC6vbHW5nxa7E8Tgy3gGGf6qn8O5AZ0Gxg/sVkjqjlCnQSZHQ?=
 =?us-ascii?Q?dleRwo2j/ydCjVRJmpoHosUjRhrf+RLAtFXjtgBWzkK520a13kqF0Hssk2Yt?=
 =?us-ascii?Q?gpGRuFxVs7iIvH4gJfBgf/JaGVd2H84edp+U0uHxb14GdG9agF8KY7dD8St5?=
 =?us-ascii?Q?ZI1YR/+SofjrG/vTzvv00mRNl39UANY3I/tsb7CnC+ZExri1DbaPoLInS0zF?=
 =?us-ascii?Q?TUE+tJHDsUz3Dqn0k2vplelGI0LZaKBiMdB27gJLkwuVc+UUQDZMbnCO98yq?=
 =?us-ascii?Q?6By3BVyukRetfpvko8PPr5dVnnvgZk9GeMP7+6G/bc2AeThvrdz/Y9qn1ROj?=
 =?us-ascii?Q?4k3YAWN8k+h8KnBzEYHWV11KaXI5L+CE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SzGTZEe4jxl4ujN1pNd4EFt2KKORu9YGS1yFYlhHjOkg9pEAdb6XJRPCqHVM?=
 =?us-ascii?Q?TLXE3vRuPcPvkGGmAf6Ig7u2vjls99dv44gezS6lvGBwDuBwwN597l2OHhb7?=
 =?us-ascii?Q?uDcJSD+tlbwYyzJKrl1R2RuvDQnYKQfRMmAyDckTGnkWeGrIJFbipmN3Y94G?=
 =?us-ascii?Q?4A/B38NSmwIoOhqLyxvS59Yt6ByR9NKkNHMmtZqSwnYaCHqgtoQGxetIscUb?=
 =?us-ascii?Q?Emd0HtRIblrLr2ir83RIlFeuIrpDqfLkf1DHToxOP3VG5hvDZJvDv8x7zVow?=
 =?us-ascii?Q?OEnBMfwccEvRnt+0PU68R/s3h6ZVIZuq5FrC1oA1nfA74IUseEo3mRQO9SCQ?=
 =?us-ascii?Q?rOU+OklIH6SQN1PuJXV7WF/peMuFA1/56uSgTsLzRFAvi1ljvzgSqwXrh0kl?=
 =?us-ascii?Q?1VP85Ey0WlVnrYNwI5h+yKy4tmMVkFgsMfRwcvKYWB0EajRcJZV4tg9FqaCE?=
 =?us-ascii?Q?W/4MTdF5aBChlARs2nx6BfeYL6BcX1sC4PaZn++nMtQozsRChBR2vysCMFFV?=
 =?us-ascii?Q?nlIhh2FULe5GdxQrI3nykzN8b+C5ZchLajKip30BLj6FPGnDQJ0Pwqx5u/11?=
 =?us-ascii?Q?yX2u24hc3nmiCcwBPN6pllVs+UwKI3H8Ep7WzVgg+SVMfjmniPMofDSzf8Yz?=
 =?us-ascii?Q?OaAmsLlS4xaEqN0EGDz5nVMKMwETsjKU8nsdrE+dowR4slB7lePkbIoOlB7w?=
 =?us-ascii?Q?3Yjr0MD9lh5fwqZQxch8+lzaboWGd/8RWBJ9c/kA6fHIAdiakq7i31krHaxn?=
 =?us-ascii?Q?kgH2sGYUPixVMPNW5hN6wtVhT6BVFEgco3YM1RYE1VtIcJ6jRRgxwfjbVJe0?=
 =?us-ascii?Q?e4Hq6+sZbD28Jz+CObpAJ/w334hSXbBL3nn88vinF4vjVyxTvUwQB3D/Uq/x?=
 =?us-ascii?Q?HnTGMrQ0EdiP7+dpDAuYDyDl0+5R+HsthPdoMcbweNDwN5sfVXtltjgWNstC?=
 =?us-ascii?Q?UewkpJOViRz40HQJ5BupEHLlLvoFuKxRetOnn8TfuhPOf2zBXkmUrfni+orw?=
 =?us-ascii?Q?vX4/e2Xs1Na3bhRJEpSVtkPipxQ+qNcAfa3mnwIURWazwWv18vZBxxaozufo?=
 =?us-ascii?Q?97MqRwqRakHyJ+IeOHn/l5Rn8pWv4KzJ2Wz/9UPeykiWgI1nh6BpwZ6O6dRG?=
 =?us-ascii?Q?pSIiEvle+LIUlxvLUDt05IQSOS+gy8rl9578uz2tv5iY/vHJDyrQvFX753p/?=
 =?us-ascii?Q?AvbaluC9xlYZnz1iqo85k5O+pQASLyrzJvUp9PumtdpbsS+dgYTFDjDkTNMJ?=
 =?us-ascii?Q?CqssSfyezyKoiWZf+a1Q1PeoymMlc2pPRCYIVjqp6tH6U/1mTDkbfDpkMxM5?=
 =?us-ascii?Q?Q4ywH5bdqiek/99HIAVU/8utzxknQudbbjYcVJllxLmkV4Z2OZc8VjF7Rw/J?=
 =?us-ascii?Q?fXaqM5rm6NAq9lHdq9A6nJKJUWu3uAb+9sPgdox9OdAVRZ1qe9a5ky2EfmfC?=
 =?us-ascii?Q?BtF0/H2mEm8l5kr1J69t1gm52tqDvMZu/Hd4a5pG7AosUnV55NZEWma+emOv?=
 =?us-ascii?Q?fcXIpKTO4CaPmKtKe9JHSyolYGBpFamqB0IaguF4+VBaDL+T+cSXjCnK4pAQ?=
 =?us-ascii?Q?2Mu+ufOkZjr+5F3Ty2M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac24812-8425-4064-db13-08dd26f0560e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2024 03:33:03.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smug70a0dqz3G+XtXhAAkYenjmbGz0N/3bIJzBMfzNifm7VpBUkzkwI1M5PFr/fhN+gKw1KrHRE2Pxx04IPHFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328


> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, December 27, 2024 11:49 PM
>=20
> On Tue, 24 Dec 2024 03:40:34 +0000 Parav Pandit wrote:
> > > On Thu, 19 Dec 2024 17:01:58 +0200 Parav Pandit wrote:
> > > > Improve the description of devlink port attributes PF, VF and SF
> > > > numbers.
> > >
> > > Please provide more context. It's not obvious why you remove PF from
> > > descriptions but not VF or SF.
> >
> > 'PF number' was vague and source of confusion. Some started thinking th=
at
> it is some kind of index like how VF number is an index.
> > So 'PF number' is rewritten to bring the clarity that it's the function=
 number
> of the PCI device which is very will described in the PCI spec.
>=20
> Just to make sure I understand - you're trying to emphasize that the PF
> number is just an arbitrary ID of the PCIe PF within the chip, not necess=
arily
> related to any BDF numbering sequence?
Right. The proposed kdoc update clearly defines the pf as the 'F' of the BD=
F
that matches the PCIe spec, reflecting the existing implementation of
multiple drivers.

Also, the patch is clarifying the VF number (that is slightly deviated from
the pci spec).

>=20
> If that's the case I think the motivation makes sense. But IMHO the execu=
tion
> is not ideal, I offer the fact we're having this exchange as a proof of t=
he point
> not getting across :(
>=20
> May be better to explain this in a couple of sentences somewhere (actuall=
y I
> get the feeling we already have such an explanation but I can't find it.
> Perhaps it was just talked about on the list) and then just point to that=
 longer
> explanation in the attr kdocs?
What part of the 'longer explanation' would you like to have in the attr kd=
ocs?
Do you mean to tell that it is the 'F' of the BDF?
'PCI function number' as wrote in v1 is a string that one can grep very eas=
ily
in the PCI spec; hence I didn't write it as 'F' of the BDF..

Can you please check v1 commit log - is the motivation explained enough?

>=20
> > For VF number, the description is added describing it's an index starti=
ng
> from 0 (unlike pci spec where vf number starts from 1).
> > SF number is user supplied number so nothing to remove there.
>=20
> nit: -EOUTLOOK.. please wrap the lines in your replies at 80 chars.
Ack.

