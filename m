Return-Path: <netdev+bounces-122946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65E9633FC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA751C217E3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E71AC896;
	Wed, 28 Aug 2024 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihzwF2fB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F81ABEC3;
	Wed, 28 Aug 2024 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881032; cv=fail; b=RiAK5k4JrGfXuaXfr7hY4V0pvY8qg+XJ2m3sNv9OdIkDg7ccCaFKSnm5dcezCn1VTaX3F71KEI6BGn2W/BijKxE41X6rZxD2T1HWVWyTg6oPRpA61/H5jyEWNKG0ncGzgIVC1Vpt1sKs/bOWafhtm4xZlBVJQVpgzsDK9KIkR24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881032; c=relaxed/simple;
	bh=XPLhh3KKGa2skdRwdJ5CjP6jnfDaiPLptpOYRerRtpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urEK1DivouLyyi6FJ6GMp5W8bt1pemKnQz25s5kE7FQm2Tm1vSmvNnG/E/VjYXlKYEBHjWfjIUIRQ8Ud6M13q66aNYS/VxBD5LNC5ePwmrwTAaiLVNj9VXQHMZZvP3RMDlEv2UmwcTJs6k6PW6rAVDRBd7EMWOxmr/7E5pIi/bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ihzwF2fB; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqsApEDuP+XdxsKoxhgpsiZUOBH9OLXCxl2doFmEtiC9xsxFZtfqopyA4Khb39hY+ZNfzmpORxAbhUi0JNiNDp7tNXZJO6uHr2Bg1FWScAUe6r+/MoBnyU7RhntnJFlEG3jEHnUoPnbgE+hD0ET5rDWuDALFk4tuDlzVXay9l9B5P/BVj5QqhouzkbRyQrUoXzWG45ajwH/0eCj59BMQQoW3PWpIjRuxY07qN4pUVN96hauX7Ltj1ZQVXuxj2s3AcCGUsPmHv2M+m2VE/mI7DG7M9kFc5imI7kc5U94KH6gD+BKqMvUIL6C8kq+7+ApBG07n10p/9YwEJGJNMcTfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMBFFB0cm5yJdxH0J7kQ/90g8MznbxtJcYZPte9VmHc=;
 b=lXLHVsKJaylEUdEEAyMuoon+LjCSneCppErDvuhyVYNDtchr32WdeZJgXsJ98E5Q4g5sRnBj5zdVQxpxzu/ue0rvrzeIftEUkcOjdW+Xrdyd68NDqR4YarvqLtkU3aoR0B2ZzYGZdsC1ZJlK9jT4cgREUNZokrA2gVUEcsY0dOAIYboav22Z8OnmEN3erI74dFw/WQ9fEK7guJWYEFeU7JllsZKiRdgFTvC622Umb77E4P9mb5yzQg6hs2wTc8BqJBhHVRyUhtoqbclGR1rz1Y3PwOa9lOibZLig5YfdUHQL5fJp2063aDvPfCZHIVvAnOsUHynToHQPodQsIHvCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMBFFB0cm5yJdxH0J7kQ/90g8MznbxtJcYZPte9VmHc=;
 b=ihzwF2fBiWl4Jda5Ftt1DUglKVZHY/HwT5emNA+2YULAxMuAmFKvWo8P8QZgm8hUlEUB9tgHAea5U8nRDM5IrkX9p+hUpi+ecC9Onk2bdOlCgUzRr2CgLo2gXwzpg4/Oeeaf1jhqb0zK1TpD0IWerfxvIw73+vqlFCtIvJEkCDo/3nqZtJCfWRqbCY+YlqUFnw4wWGzV0f0gi4p8urYYLnUfc7RCqCZABucNYHPjSKrtCwo+GR9M6xw7GF61d6GooossFu1A+jeL2jrztEMgK1Jytl2uv3GINiJA7GL23F77PR5BactyPIgHn8BPEBe2chbZmVOggOcr6w1wxIJ1Rg==
Received: from CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:37:06 +0000
Received: from CY5PR12MB6646.namprd12.prod.outlook.com
 ([fe80::8880:c187:3bc8:e17a]) by CY5PR12MB6646.namprd12.prod.outlook.com
 ([fe80::8880:c187:3bc8:e17a%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:37:06 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Benjamin Poirier <benjamin.poirier@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, Asmaa Mnebhi <asmaa@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v1] mlxbf_gige: disable port during stop()
Thread-Topic: [PATCH net v1] mlxbf_gige: disable port during stop()
Thread-Index: AQHa8B2nDucgjCgWq0yT6j8AEPFHB7Iu8mgAgABiZQCADe0/oA==
Date: Wed, 28 Aug 2024 21:37:06 +0000
Message-ID:
 <CY5PR12MB6646FAC499454E380A87D829C7952@CY5PR12MB6646.namprd12.prod.outlook.com>
References: <20240816204808.30359-1-davthompson@nvidia.com>
	<ZsOVEMvzAXfaRiEY@f4> <20240819174722.7701fa3c@kernel.org>
In-Reply-To: <20240819174722.7701fa3c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6646:EE_|CY8PR12MB8363:EE_
x-ms-office365-filtering-correlation-id: 161e695b-6854-472c-96f2-08dcc7a99048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FRQmxeiVMZZ+jHJ+PTMVdkbq9M9m70qJLFBfCmROQMI4SLF2IdqvNR8rwNWw?=
 =?us-ascii?Q?5w8RZI+Eyry8MCmTQRd4J/CfbWHvjg1dB3Pn9u6ozVvhkTqFFMjMhznwDrIf?=
 =?us-ascii?Q?CtGfVEbqL8jKqIl1pMI/e58Wv2nt5nw5EBAhjFkyo6IEaC8XOHF7VHKHzTES?=
 =?us-ascii?Q?CObbBBJ8Mgtj8JX1f88eFGwtci90AiG3oTh06WNVSo4C4seUyEB61nhB25W/?=
 =?us-ascii?Q?a7qXJCg8sZM+tMmgL/zRTMR+i/5gaIKDlnzGhUjSWa+8UOoXEmiJgl74mlZx?=
 =?us-ascii?Q?n12+WAKGceIBCCrh/mUUipct/TMtSywdLjZ4GIQpkT1BxfzkRHiCjTyT8ZWX?=
 =?us-ascii?Q?LpdlmPTpxnhhco9iv2OqBRnE70IUlASnFfi2BHCBgQoZDJmFjDW6GiZDrLSS?=
 =?us-ascii?Q?QWNQQELNA/+DSgBH5S77jXCE7HFnRklF+ufRhGUqvdMM2bxZS4Luo9D6Z9XG?=
 =?us-ascii?Q?jbQ+P54ZFlYyfth3nUe+1a4ta3RhH9AOLNvvIv7MXoduoqgBwSYvi9CcecnU?=
 =?us-ascii?Q?5T8h+gh7XqeeWsvNtgfTfLru+iyNH9f27/DFmYxfbzW00OC/zEry4OBxsbFj?=
 =?us-ascii?Q?PHswJ0y3unHxfBo57pNlYS+ZCbWF8GEiyF5Lqro2z0GV3A1qRFqZkNzrdqb7?=
 =?us-ascii?Q?k6adktD9cMAclV05rOP0kp7NdTTOXD2H5FYTN4ZeARTkNe+Nikijap67wjtR?=
 =?us-ascii?Q?OSm+05VMlzBo5uMFXCeE6lypct/FVBFj21hpcXhN8fSlsmxCTq5zTfo3n6NU?=
 =?us-ascii?Q?lB4/S3pk/Es70UnfEcvtOdjNxgOxbdy6TSLblky6/aOe6l+oFjisDz+9VP4r?=
 =?us-ascii?Q?xfVcSzTmDhYF4IJVcr7yFXS8LKgHzFwLMkmnCx9NkiM3Oj0CnkKLhTnLN1Q7?=
 =?us-ascii?Q?YcGDA/Ideq3mLGkW0yEkQirCY5m8YvyLNiuWoiTL3Nucr/9pJsjafucCPKO0?=
 =?us-ascii?Q?/tKE/9W+vZ5uyGrB73Ost16RbKTgJdjUUuaoDFw0bRfaNryQE231mUFwaG7n?=
 =?us-ascii?Q?ME7uZKmgILUfkIgF/pjG4LHhMFk4utOfQcC9h7G3+BwpkCZIwh7KEp7W86X8?=
 =?us-ascii?Q?dOQNPe6Y0nIBP0/AzCWRq+QkoyimNjrDKV5ipex+xzeg4/5xHrPB9HDxD/Io?=
 =?us-ascii?Q?5W0EUis1mmjsjo9pfiRuk5YN3h5k4ZlwyOLjd0EyCkhmi9J2Ynl141bRACcP?=
 =?us-ascii?Q?CMFCaHzLMh4Av99+TOQ015+CwJEWlOu0hyS4owQ6pcyiROCUcbckt1Pi7oPt?=
 =?us-ascii?Q?UuWpGxqGrwcquBrYjNDoD/OjbrtHC7nNOQtNprV7pipdxELSyZ9293FI1DTM?=
 =?us-ascii?Q?wS60+AcSB6rxv0wO/oK5wYtunzHKeyensNWMNxkSNmJzIdrU/H4T2drc8KQq?=
 =?us-ascii?Q?O9PWu6xRnWwJlZmpevymjMhSXDMqqAQ8OwgLM8rA/kt0bpuoZg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6646.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?monAY20UkGxYKYFWPUlq66ggsMgDiIiivZJbpTjLjJ8s4jEtzbmHSbfci7Ut?=
 =?us-ascii?Q?rY6QXgLMETlPaNHwv0mJsuJt4yBzt+4An8bx/6LMoNGI69kb8ZNtTWRj32Hn?=
 =?us-ascii?Q?Brd7RUrP2sNV0T7gqbD05itCCZemsUTud7VRLDsP3dXyKf29v6j66BCMBr8I?=
 =?us-ascii?Q?h5ypqDpaAuVtMjlX8ETZ+3R2WO2XfDJTAR+BdPsIwxq5CGPHgKuXbUZWdXHN?=
 =?us-ascii?Q?sCRhSEG5VrHprhwNPbqweaWt3AqaerxwjvwTVqbDrgznnLHZXoU8yoBOGNlz?=
 =?us-ascii?Q?NBvgeFAcmI2dmGb3lCJVw56l/3oPNMvasuxQ3m1Z2drlagdzN/KbBmGmq7DZ?=
 =?us-ascii?Q?LLsmo33v0mc8I+qGCfIGWe/GtknyJ7a0BxmSUhSi6tySAwtA0S+5FPMrAAn7?=
 =?us-ascii?Q?ptxs2jcMm/FQdrqZlyhc+To44wriUGKxw8HUAn+F5AxYcPAAr6Tkj+Vjljqo?=
 =?us-ascii?Q?iOTltgcmMV+CAfwLXJ36s+sRkQBTVI9HiZouhZFYWqQrnaDxEuQaRaPssSe2?=
 =?us-ascii?Q?h+XfSNMbGWsYolVfl6Rs6qeLHyn4HfW2RPk7c3hMAmt52kgm0ZH5Wu2eQclb?=
 =?us-ascii?Q?/iKRUpmJekYWDqnalRETo4d1n31tgsN3rMsH2IKTRTSF9uGAsZfgYHsJmRwx?=
 =?us-ascii?Q?RABk7YEDEIHeW1f5rSXEpRjCdY8akPMmcKz8PzenZEDw0VlE5GT1zm/O5onJ?=
 =?us-ascii?Q?1/U7k+llYWSAAczmMllZv1qYfhWW+9LWIGrx8nUS3H1GHg4UuIpyiQmxNg6A?=
 =?us-ascii?Q?jUMMuAG1RMUE5F4UV+9SXkRnHK96yIjDmTb77IpXTIYhFjzdY+JZkALDwtuE?=
 =?us-ascii?Q?2cAP4WSCM6nGuU5jXGDhClbq4sn0ks14rS1gXF83ljBnkqQ1ZAUZ7+BEcDen?=
 =?us-ascii?Q?dSrfv7jm9a+sjfQlG6+9fSYJVB2TViiBxA1MCdNGhARZ2xahU1iQt2BFqWqt?=
 =?us-ascii?Q?/mMpUOivYBFpzad3QXACg799ueNzf8N12/+W1UQf3j+D9ardFhs6O0oyaUdu?=
 =?us-ascii?Q?9ZcCsHTFf4gHv7bDpJWdiyT0vEjMl5swmHHULa+O3uDeXGbxG5dDv1+T19Oi?=
 =?us-ascii?Q?ZC8sBhesE0ErPTV/2JXxKKtaV1A+vRYmJwMkwam34Y9V2RdwUJjYnaytaR9o?=
 =?us-ascii?Q?w+LrNMbcwg2B96X0SuyJ72T9psZGhL3SIjLQPTTmm1hXsAuVm+4VQNO4mukx?=
 =?us-ascii?Q?FhQhsBjeGazlWKW7PcOUwWAsqsA7fMLZTe5NwBbfqJ8x7IkqCq6o0h72JNMJ?=
 =?us-ascii?Q?DpPtSSdsjfaxD6+VoiHjm1EX0wSZpeSqRhHhUPdVDskv/GDI35+xMHC1Q7Ws?=
 =?us-ascii?Q?VioEAhMqu16anXscxGbyHaveEBeCpkdgce7OynUMMZ1euGvBP8f0BalCMAwC?=
 =?us-ascii?Q?U1cYYOCpGhQGapMbkzQa4Pv1roHQ0XUdOKc5Ecav3I+Mg5ye4DlMLezKAYPm?=
 =?us-ascii?Q?oi5j3Wdh0h9yY7ghFgnRjg6VPXOXIr0KXrE5UzHmgCdR3PmTxCW0+1rMGB08?=
 =?us-ascii?Q?g5WWUzm51GlR/Bjoukd7s+wY5MinIaGqYuYDSf/BzUq3No/bAyz3/D8918P7?=
 =?us-ascii?Q?Vlg3xA8nkKZ2uBmry1RFVMSmLYcbHNKJykQ0hFBE?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e695b-6854-472c-96f2-08dcc7a99048
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 21:37:06.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq3Sh8MadBx6/ZhyXMzJKuysT3dMNV+ix22M444nZcHolqiPdZkE9Wy04eh7YV9D3gf73/d5SY2ALiijGPJd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, August 19, 2024 8:47 PM
> To: David Thompson <davthompson@nvidia.com>
> Cc: Benjamin Poirier <benjamin.poirier@gmail.com>; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com;
> andriy.shevchenko@linux.intel.com; u.kleine-koenig@pengutronix.de; Asmaa
> Mnebhi <asmaa@nvidia.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net v1] mlxbf_gige: disable port during stop()
>=20
> On Mon, 19 Aug 2024 14:55:12 -0400 Benjamin Poirier wrote:
> > Is this memory barrier paired with another one?
>=20
> +1
> You probably want synchronize_irq() here?
> You should explain in the cover letter, the mb() seems to not be mentione=
d.
> --
> pw-bot: cr

Hello Jakub and Benjamin, thanks for your input.

I will post a v2 adding information about the "mb()" call.

Regarding the "synchronize_irq()" call, I did some research and noticed tha=
t
some already merged driver patches (see list below for a sample) state that=
=20
"synchronize_irq()" is unnecessary before "free_irq()":

3e0fcb782a9f i40e: Remove unnecessary synchronize_irq() before free_irq()
845517ed04ae RDMA/qedr: Remove unnecessary synchronize_irq() before free_ir=
q()
d1e7f009bfff net: qede: Remove unnecessary synchronize_irq() before free_ir=
q()
bd81bfb5a1d1 net: vxge: Remove unnecessary synchronize_irq() before free_ir=
q()
29fd3ca1779f qed: Remove unnecessary synchronize_irq() before free_irq()
411dccf9d271 dmaengine: idxd: Remove unnecessary synchronize_irq() before f=
ree_irq()
d887ae3247e0 octeontx2-pf: Remove unnecessary synchronize_irq() before free=
_irq()

Given the above information, does my mlxbf_gige driver patch still need to
invoke "synchronize_irq()" in the stop() method?  The "mlxbf_gige_free_irq(=
)"
call within the stop() method invokes "free_irq()" for each of the driver's=
 IRQs, so
sounds like this "synchronize_irq()" is implicitly being invoked?

Regards, Dave


