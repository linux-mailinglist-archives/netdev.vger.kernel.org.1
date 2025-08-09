Return-Path: <netdev+bounces-212337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88EBB1F62F
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67081C20117
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 20:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03711D54FA;
	Sat,  9 Aug 2025 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tt39Wdxg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915635959;
	Sat,  9 Aug 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754771506; cv=fail; b=MZvcXVw7qcrK7iU9giA/Vb1HegPOZfLRyfqS0OWXPKOXWYu3beJPKtP9xGCjFnVD7Dg2NbfKKgrKcPtpa1bZtPBiWU8m5YhRGQ5q6n45hCKZkxc7roz8TAk1wmYVPft1hYh547lwV/ZNqfTUicZrotuo0PDDyouE1KlpfU4ZIeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754771506; c=relaxed/simple;
	bh=C3f+MmCOgssSNh6iXfkM5Jjd2AL2ou1cv9452z5DvuY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnM0APSeyGsT3EJAKjh61vtlbPI7Psx1PQ/wJaLLD5+EN911hsGR8IIvrS6qPZY30yrxRXdIh0JeX6JcLl5kdYXMfrLOhNPiraP9Yx87o7r76f89RF2RvpLPpgqqOba3MduODdjHRNSEN/jTNfSETJk0TQLn63Z/OvHTlMIaXMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tt39Wdxg; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuEvBVZDsJNSI9GvklbhiEoI4z/CBuBq3ogoI1tLdrfxMxCK+ET3y7SIqLYjMemROyo50fzcz2DXrO/N5mzJx2DWBbKwu3OEJB9+I8dfieutIvvcXB4qnuacxcHU4BiZhIrpuBh153Sbd/i2AwKCkDmncAJvs2Qfgt9kv2BfeCE5ZR5IhWYK9nvra18Cb4kcL/OUNQHSAWhZ6QjreaUMds2EY7xH/yODZmZhhajgellyl91siJccThLeHg1KfFWKA+obBU0IYRBwJvjnBzyxTfDMqOPgPuFnfc63rAIbFDxzkLvKrlGOVGEq+83GOUap13r447A9ze/b1DrKiqN++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIxfEgOXjek6ZvwjX3ZZAEORqOIBFXx7q7IgDCTg3G0=;
 b=pfJ6Gp32zm+3Vj5ndigrBNLlK23Emw+wN5/yu+nnMDzAFyERZeFF/EgaUGPGbd/3aVzKCBxwGrAYhQqOFJS35MkrAUY3PEnepeb/sLk0pZyim8sOUkVLi5yUs0zXli9a4AYeKzXPw5m9G188HolVs1cZag875SOZn1hLGVypGlW8EN3qAKaVO0u7GQD1tYW5cT00w2sw8yjgJIbwn7YMw+zMrCcMn1EmdXA7pwb6fyxFN7fwvok907SN36d/2apWCJper7ci2fgxwzPLQvqQSOTPTspjZYC9uvJU0QrbcNTBok/Lj7AJDvx4gGwIVo5wYw9zPqBAk5cHK5wcO4rn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIxfEgOXjek6ZvwjX3ZZAEORqOIBFXx7q7IgDCTg3G0=;
 b=tt39WdxgoiZgmsqrVB9v/jXtkpldg4Q0rxwA2TRYKWvpw7ENvAwsn5ThSG0OMzXrPtmW3Y1HkO2e1KAbGMZKblUUP2FFhoM05mrhhDTl32CwVgJB+btXsEWw4oJzGSrvkkjNiMdlBr5m7QHpbpw6BSc5NYHViDtasxaWbeeumyk=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 20:31:40 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.9009.013; Sat, 9 Aug 2025
 20:31:40 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Topic: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Thread-Index: AQHcBj3ufqq2Yvzk4kWpSUUhUrH6hbRZIlkAgAGeWkA=
Date: Sat, 9 Aug 2025 20:31:40 +0000
Message-ID:
 <BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
 <20250808120534.0414ffd0@kernel.org>
In-Reply-To: <20250808120534.0414ffd0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-09T19:48:46.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|BY5PR12MB4321:EE_
x-ms-office365-filtering-correlation-id: 984c8f8b-c96b-41a5-130c-08ddd783befb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?romOseIgHpOfGCwDFbx7SOdI/ncyRfM8uHbQapp0Ex40nqJuHPhD+W+GlgAZ?=
 =?us-ascii?Q?sU7OgWf4AcecPShWvINQtkPGy+7O2vhoL3e1xA8hYZCOHXOqQ8vkdITHJDoq?=
 =?us-ascii?Q?GUnLerbpqEfHXOfoFrV/7kDuPHU6gz3HrRqkV7g10ZeflOu5ylkXx0Bl5dLx?=
 =?us-ascii?Q?VbQCk4FBw8CfKybmZ286TzLn+t9M+8d1YyYTakOrsHJX2HRZiI3V9CqPowa0?=
 =?us-ascii?Q?swEdB+WieMma7scX2r8umpC/Xh5OwhXbhxDL2KtvEo8GSsLnm/lGrGNXVund?=
 =?us-ascii?Q?5qOyiIq5H+RRs86eRqmB6hDSn+BalJdEkH3BtVnkELxXAlyrO5EU451k97dZ?=
 =?us-ascii?Q?t1e/+RuJI66wMpecQk1FuN7G7PdsBihXZGxrAy1P7Wqprxn362anls7eyY/+?=
 =?us-ascii?Q?JGleEnEe84XzdabV35El4Rx8rImLQVr57cOdLzRJiq1JBSjMMUih9hI7GBuq?=
 =?us-ascii?Q?MJIaNnRB2QLUlGcg8szlYqMlY3n34OkBSKzcTHud/nzLYzTA9of7mIs6zoYF?=
 =?us-ascii?Q?N9qnsg8QKvpCyd8XO/E19x/fNEstQ61QxZYtbS925e7zZCNR2tJVY75deb9W?=
 =?us-ascii?Q?lUYJ65nB2IMV9zIr5KOYZ6OEi/L3bTlBKQV9SwyxPqFyee5UFoCXeeJv149T?=
 =?us-ascii?Q?XkLodk6VvbSOnbJ3xeOinfuakbyubmbOdWsCrdLNGd585q8nGi6nFY4724mX?=
 =?us-ascii?Q?WhF/lX0C8z0vP/UiddlcB77rN+9jSEO0oqRH16NDCA/9lS2cmLk7uVTz052V?=
 =?us-ascii?Q?0YQ9MGGkT0Hp2cR+LUKfqVEcX6reN90wCA2iBQQ3vilSmKBKzV6IxYpYBmmk?=
 =?us-ascii?Q?Yji0QiyeZqd7skZbV6rJo4IQc6E6RNaa3ZEBBJ0fwnkSyYijSj/ejHlE0j1v?=
 =?us-ascii?Q?nTILiMka3k0+v8XHAhK2qa7ZwdO1xJyRDLWRTUTjSSjTQ2eOH7ndu88esKnU?=
 =?us-ascii?Q?sJx1OBsuCvnRxVo0RvsgaU3lfK19fmiQ7qfpGZg1ocC4yiV3ePcgQjN0/zhM?=
 =?us-ascii?Q?1do9cUas8RfF5hz+g+4vz8vGK6muyuIWwBR3/O4xdGXKT5i9wcuWWsCGtdMK?=
 =?us-ascii?Q?nIDpzCSTIYDKoxQxVIOpIjwzegt2nsCLZgnKxJN9ECvoGRLBolb/w/EPkTS7?=
 =?us-ascii?Q?b1o1WCdwhUJw1Llj/KVc+5OZdX/5dGT30W/V54V7sr27poFgqrrxpyS+GGoZ?=
 =?us-ascii?Q?w9IAJXupUoVe07vxX8q7LdxCMpI1MUzjpmjo8zaOJ+1BFY9T1rQlctKEgnd+?=
 =?us-ascii?Q?OiGXL349QJ0Amfzflr03wBMmt5v6BwI/+mVY5rY3RtvOXFvjbxzAIqhe4f4f?=
 =?us-ascii?Q?NnWCmDQ/KiIOoQh1TR0+8nJX/fnMiLXtLfEd0zRzfAOYaEbKwJt7vQyMeP4U?=
 =?us-ascii?Q?K0s2oBxayLRNIzet5KC4t+TQ9QFY+6rRdb7XwRbH2AKKMUIWDSjf1d43sQjG?=
 =?us-ascii?Q?VV/uE2gmLqZYaltOAWC4foRInal5TsFWw2V5XU7wFcHAHlpRjjmt2Gz8+Wy5?=
 =?us-ascii?Q?hlJOOjJ/VyYsBnk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z7PW3OogLw+W54iw3k1USFZDBeBZq+KjLuxeBjm+3N9G88un3Y+4NrCXrYM4?=
 =?us-ascii?Q?TE8w2GIIaSLxf7vlyx3LkJRTHb2+lsgHH5trD+7NiQUG8yG/yaXAvPZlEbfV?=
 =?us-ascii?Q?EI/21xTqmEpOgGkKpcpgbDgJC2s8wsQZJOcNUHWI4SkciHLHiliqt9CyBokA?=
 =?us-ascii?Q?yBMXg0m7wVNNI2q6chX4iQi1CVi+/A3I1P5kW4uRecxy8CvBWCsICs23cJOO?=
 =?us-ascii?Q?k/LUq9r1NDxNmB4pnTCahrnGnZK/sWB7+l1W8AKEh7j1vY2FvF+1pc74QTL9?=
 =?us-ascii?Q?+HJOs2z6pyzW+zOrGQ07S11MZA2HCshkahVSpUiidgfG5+5aP06ozdXBaOux?=
 =?us-ascii?Q?L0Vb7srxvT0xfEvqizGTmD7qSPZ82oSQ4SeN9b6BDbu5P/4rWGldo5Ih0o/l?=
 =?us-ascii?Q?lj0UNMVA6TmiN4NZ1Gmqyli7MfoFo+Jgbn60RWNxZ3wL24FShNwPAM3Bx9cP?=
 =?us-ascii?Q?kUyOVjJ/lgIJpywtjtsm2CmR138PSMKNqFAX37GKovUCsoEVDZtZFh4oOvV0?=
 =?us-ascii?Q?1+oal8tErW4r2b+HHNKzlIgI4j3/oe0V3gyXB9BlITFqw8axKxfGVtVh0dAo?=
 =?us-ascii?Q?k/l+RXqgE6a6ALYKT2nGwmsoln40IAKRvoZnylSMJfdeCjmqTAHdnFZ5Xdh8?=
 =?us-ascii?Q?J+M4OxEiTf7tEQv/ZsBui8IdYycsRhu6ENAo8EwjLXjxL9xLYUAFj3i/D5XS?=
 =?us-ascii?Q?JqJMzSIOWhKpRP8bnpCLzksMlTQwkijeLYaPnEvvltgUgU9HhMs6m4tQ8L3x?=
 =?us-ascii?Q?GRq13xOTWdpkGq6bGuDtDsN0rwm5Aj85vO3+afrA1vbgeJXe+pdxiimV0guB?=
 =?us-ascii?Q?4RiSSVvtgJfvs7n7vetzYA60flXTleuBukyFkiYppe49OPYYw2GcULaQ32BF?=
 =?us-ascii?Q?R9qSMchSEGWtUicW+Dpt7NiK01zkWY9q9G3dgOBGN+RQOmMSOzaYUqyf9MS/?=
 =?us-ascii?Q?zcoS6HMk9pCvrAhmWfRGzQ5r6Xq/pzdJ4oxWds5cr5UvFrvIGHV5lhX/F/FS?=
 =?us-ascii?Q?aoiCZIKs5FjllAqbeFVAptQ1/ZMKD6F4yeOyWX7YKaDxMujUJoLxlJ7iVlKq?=
 =?us-ascii?Q?0mUnfwrTwxHVfl3PZJaPVLUsuZwsc7fZEFJQ2wydp1VuigLYf30ueI8XmJg2?=
 =?us-ascii?Q?TpivXOeRHL5eHfxYBVmSFnYBXdXrnv2VQ74ETfa+42v0tiAXJTSPaH1aJYm+?=
 =?us-ascii?Q?afgNKEQ5wGIIrcHJ1m3bLsFSnwqBVk4IkBqsv7nD08CRqx0bFUH13ftGI2ZJ?=
 =?us-ascii?Q?x4y4uOBhtFslmgK8BzR6PqZx6rM+eh9Mee7xIGNx1OsGSvuXFHPQkzmPlG61?=
 =?us-ascii?Q?mR8ZLnJCHmkkIe/F+GBQIxNHZqmKZ8E/hOf5Sy3IyMOxCY3cvdzyrx21sIia?=
 =?us-ascii?Q?QaZUZ6vBgEqm6lnCxe/KpezKU1sJiSJjaGDwIf3bWANA8pQsNz6ADicixSd9?=
 =?us-ascii?Q?01dA4wikKPmxNY7F2fvLN9KLhPV292bB5gdPyPAx47KZ0pbe7uMuXYCyhEga?=
 =?us-ascii?Q?KYCEfcBJLOSiliz8J4DdI5A0jAiiNdCNgnIHMft+sTWppLkGYT5wBqC1QDFX?=
 =?us-ascii?Q?UOxPg6o1Kzs6CW79+CQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984c8f8b-c96b-41a5-130c-08ddd783befb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2025 20:31:40.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wevRx6tLE2GqO7LFyk8uNdJjU7TTpkuTleBgRUedYx8euqxeU89qsYLSVyLN5HeqS6GUVSQCvs6ad39SNELeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

[Public]

Hi Jakub,
> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, August 9, 2025 12:36 AM
> To: Gupta, Suraj <Suraj.Gupta2@amd.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; Simek, Michal
> <michal.simek@amd.com>; sean.anderson@linux.dev; Pandey, Radhey
> Shyam <radhey.shyam.pandey@amd.com>; horms@kernel.org;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
> pointer after BD is successfully allocated in dmaengine flow
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Wed, 6 Aug 2025 00:49:58 +0530 Suraj Gupta wrote:
> > In DMAengine flow, AXI DMA driver invokes callback before freeing BD
> > in irq handling path.
> > In Rx callback (axienet_dma_rx_cb()), axienet driver tries to allocate
> > new BD after processing skb.
> > This will be problematic if both AXI-DMA and AXI ethernet have same BD
> > count as all Rx BDs will be allocated initially and it won't be able
> > to allocate new one after Rx irq. Incrementing head pointer w/o
> > checking for BD allocation will result in garbage values in skb BD and
> > cause the below kernel crash:
> >
> > Unable to handle kernel paging request at virtual address
> > fffffffffffffffa <snip> Internal error: Oops: 0000000096000006 [#1]
> > SMP pc : axienet_dma_rx_cb+0x78/0x150 lr :
> > axienet_dma_rx_cb+0x78/0x150  Call trace:
> >   axienet_dma_rx_cb+0x78/0x150 (P)
> >   xilinx_dma_do_tasklet+0xdc/0x290
> >   tasklet_action_common+0x12c/0x178
> >   tasklet_action+0x30/0x3c
> >   handle_softirqs+0xf8/0x230
> > <snip>
>
> Do you mean that we're incrementing lp->rx_ring_head before we know that
> the submission will succeed? Potentially leaving an uninitialized entry (=
say at
> index n), next attempt will try to use the next entry (n + 1) but the com=
pletion
> will not know about the skip so it will try to complete entry n ?
>
> This is really not coming thru in your explanation.
>
You're right, I only explained the issue I faced while running perf test wi=
th same BD count in axienet and AXI DMA. Above is more generic explanation =
of the situation here. I'll modify the description.

> The fix itself seems incomplete. Even if we correctly skip the increment =
we
> will never try to catch up with the allocations, the ring will have fewer
> outstanding Rx skbs until reset, right? Worst case we drop all the skbs a=
nd the
> ring will be empty, no Rx will happen until reset.
> The shutdown path seems to be checking for skb =3D NULL so I guess it's c=
orrect
> but good to double check..
> --
> pw-bot: cr

I agree that Rx ring will have fewer outstanding skbs. But I think that dif=
ference won't exceed one anytime as descriptors submission will fail only o=
nce due to insufficient space in AXIDMA BD ring. Rest of the time we alread=
y will have an extra entry in AXIDMA BD ring. Also, invoking callback (wher=
e Rx skb ring hp is filled in axienet)and freeing AXIDMA BD are part of sam=
e tasklet in AXIDMA driver so next callback will only be called after freei=
ng a BD.
I tested running stress tests (Both UPD and TCP netperf).
Please let me know your thoughts if I'm missing something.

Thanks,
Suraj

