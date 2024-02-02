Return-Path: <netdev+bounces-68592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68084753B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B183CB2761B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F41487C8;
	Fri,  2 Feb 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qwj9mfXV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF2148314
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892393; cv=fail; b=a+EDh5pbDMYQqL6P6tMihwIhFHTgvSpMw0/PSIYQDs97PX5Nd3yohyFaCY+f3YKWCZH/EeDjnVBUv5PUtJzVqF5ctxZAB3A6pl/lDcnoLzoCVrgyx84q/L41H/W62FsmyPDXIUuKzQAUfeKbxyGriKC9A6Wj2lqCj5mRjf4x2ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892393; c=relaxed/simple;
	bh=jOL+ShOkv+moD/pmhOmmGmIewyJgKwl4lqGLC+LD6XM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pdwsSTjhDmpM/Do5yL/JosL9nFXvAWw5kgT7RnuUuKA5PLWdhmmB8s08EMD0+comKERNj5sBf40qhMmKwzcET+iOqoCNznzB36gNeMsEzb1DiPm/jFl44c1jw47tlLR1WDVUWlP5YBX6wfITfBq7iouxBXD4uWwh+VuumyJz8Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qwj9mfXV; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH+sx+PWjESUrHKIMlpaLSNnnqEXCxjb/nX7KTUHz8VsCJyoDGc06bV76waChXe5FgtnAMoeFdwBDG057mNTc7sBKmdjrl8o7Q5GHJUy4bJA2DNh3OonXdTG62al5DlF8GBKFD28padJHf6Pn6ZurpfrDMLPPfwGGGRCnRXZEXwB1xIjhJMIzU4Rm7eObHbwZNBe+YnVsUlpc7hsvErUYG7VXi3Ifh9zjKrhC5MLbmTA3OoZm0ySXVNyASREZBsiILUbHERyo4s7WrUmxjyZNSEd6ZRXgGG+YVesFsY66Y4WANlRX5w2sSw1RZtwHT3L55DLF1AlKoFB6GErR+OAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOL+ShOkv+moD/pmhOmmGmIewyJgKwl4lqGLC+LD6XM=;
 b=QyTbWNvJhgSQyIDsaHur845Y6ok8hP7Xm0E4HSpaWS6Lq4329zAyEk/DxIQM74xtxuFVhMwjD0YlCGwmiDBzEm1erlhhYB780161e8Xy6cNsU6Able/rcgpgPXrd3PcncZbLaUe4GzeTO+enxSbtYSD4UvdMZpUn7/ZUK9v9LaGQAebFA1HsOrMZNKgdzUIn/ULaSMqRDfwLPevrU2jEzmfNg5k0itxT8LD10MTJW8u59KWFNfje1mbYE1wq4Lkdeqwot7srwyaLpCieWiZLwzTy5asGzOKVv3xbW/pxdjyVvMuKyGouIuL4dfBqHOwQmUAtO6wOFAcDf51fwFIh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOL+ShOkv+moD/pmhOmmGmIewyJgKwl4lqGLC+LD6XM=;
 b=Qwj9mfXVTxEaz+3Etrk17JePOe9AzdJyxHENFIkb6M1PQSe/8dcmUB6Q/q0bt7qwwepUo2wm9kRNmxIkSfcwZaPU4iv9BbtSbVdDEbUGe1ahBkhwnTWXWQHDGeIpTNCY6ND2a7Yu89DLH0ROwX9qNyyaQ3O4z+Cewu9HM+QehPv879SAkJiPyEEtEl+RFYBdmloX0nQWOUjVY+wsLGHc14JfYC9RtpsjnA8k93j430DVSaYpEbO4VCKSOieJVPcsh/NDnzFDXh1/qBl+gqxRPqdjsF1rZOVeDXTR0YuHERbjXC1lLN8SrZuxf1R2qPQfGc4RRtZ+K9vWsoJVKOfoFg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 2 Feb
 2024 16:46:28 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 16:46:28 +0000
From: Daniel Jurgens <danielj@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit
	<parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index:
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0IAAnRGAgAM82ACAACpvgIAAmT0AgAAG2fA=
Date: Fri, 2 Feb 2024 16:46:28 +0000
Message-ID:
 <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
	<20240130095645-mutt-send-email-mst@kernel.org>
	<CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130104107-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130105246-mutt-send-email-mst@kernel.org>
	<CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
	<20240201202106.25d6dc93@kernel.org>
	<CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
In-Reply-To: <20240202080126.72598eef@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CH2PR12MB4134:EE_
x-ms-office365-filtering-correlation-id: 9b44a4aa-9cf5-4dba-b069-08dc240e8081
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K91WuVZaCMB3TK8dld34aV3ZfRwagZkFt7A7COPoxkoPdkqX9Hv32B8dbzsmAqwon51Uf3/eYl9jyyl/LTPWcEmaMgIGAX3oqQkz73EUcZ99YCncPEQoxLP+LXDcCAMUOJuU5Igobf3ny4KdcM9Kpmzoo1GHAN5RQC3GbqNUXiz+QJ7So8CvVwJDqlL1Q50Emqa/h63C9VpbElXKftUfk7/EY5iXYCnF0fmcuP2IJc3en+688PhOT5+043/YdP8+a/5Gcuw6IjfD1zpRHwkYBfyWnYCD7V2qltEN9iz4u7YO3hLyOej1K6WIRmYA5MnFPukqjPRFTVgES/ZJQUtmJCBDt8+GjtoudTTctmrPNoVjJk6CPXMFD4GqLm5ILOkMb06KjPf0Vdy2DCsfqYLnvr5mxP/7MeYmes8idZDC3RnUmaI5lDKyN0/+GRlFTMWwcokYxBViJoGStlHVgACkAx5E3lbyK6g5kghRneQ1kyYXU6PgnOw84dM95KLBnQASXpjOHsFU1VnUF42wpPg8I+Y6Elkkz7h8dwxd2bI3MiSOPWwR8Z39nNBMmTu8c98Qz3oNgROVkPM5z7EDyo/SJrU6oqNXWDDr0jONzTBd3/HtjY54l7fXq+Xk1pnPRKh3ZEdjHHeKrtfWlh5sqp/rc2c+3P/AXMGXlxU/mIGZ7jg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(7696005)(6506007)(83380400001)(122000001)(55016003)(4326008)(9686003)(7416002)(2906002)(54906003)(33656002)(38070700009)(86362001)(5660300002)(316002)(8676002)(8936002)(52536014)(71200400001)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(107886003)(966005)(53546011)(26005)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fUtyIz4yhCJp3V91dYHM+uRAwYxuEOZX7s218Fs+LyZ8mSxGAcIDev7VjuHH?=
 =?us-ascii?Q?DEDbYbS6WmdeP/Tq4PGZk37rnQmv7VhzdRl1ROR73SyaDEtRMGmvsXHZdsZs?=
 =?us-ascii?Q?7c8ZOTavaqnmpMnFcu6AZod6Hfxh2Rno0HpW97pRL8iPkbfWcKmmQR+PuQ2L?=
 =?us-ascii?Q?vf17+X9lutqYe0Shxt5sHygSaNrBOEMSTG31kuAwzJzYQetApFHLlRBQV93t?=
 =?us-ascii?Q?cEWxo0h/5mAHib/lV9Rb4GNfX5Ukkcj0toehzBcMwsyIQV+UekXEaQKcClm9?=
 =?us-ascii?Q?aaP2s/N9L0JHrnMo2VvQfPP7DVvWM/KPJOusx/9T6JbA58tAbONbKbOUZ8ab?=
 =?us-ascii?Q?IMTDjQ3EX7AIEkGNlDGHqU7uwnSiYh33aUCMcxqDdt93Xpg4eGeJ/JupwQn+?=
 =?us-ascii?Q?6OxrD8RPuh5Pa7TLFCVRUss4B4wbJE8NvkU1XJ63A3iLOsHVavfEn5mKtnG5?=
 =?us-ascii?Q?HaiZX/BTuEkyr1Su2cAaiLLeNg7295oum7J36w0NwJdHueBMJSEZwdjCjyBR?=
 =?us-ascii?Q?WruLhz8JNLOec/cFWJSUlvw1LaHYhxB3LO+R1SokCDH+8pg2EetOa0vBlfmE?=
 =?us-ascii?Q?vUWH9OJwRFfkBqr1oGZF9VbHOtsKByVc+D/wPxjB8GGW5CMwWFaW1MeEZj0S?=
 =?us-ascii?Q?BzeuH0usvLrL81XYAeYIiHxTUjS26jAslHGpUikuNUw9c6ozAkUTfeqzIA01?=
 =?us-ascii?Q?gR0PJHclYjm2XOYqd9Lf4CSy/kDU+u+rbqBRmGw1D5DoUKVShbuux4bvQhnO?=
 =?us-ascii?Q?W24gCGWtjPDy4kJOuPDYxLNhsqG0th3Z92KdIaesvrtbZrG5Xuqf3Qp4NB2i?=
 =?us-ascii?Q?2jto77bLEfhXv4baoA/awsqcd9St1sEOR3bdxe2AhBGHbdVvqbvX7zIEZBb2?=
 =?us-ascii?Q?tkF33LvMucjhRmCadSFrjHxncr7tLr2KYo6drn2U3Aypm17Ot5Cz0fEAwrvj?=
 =?us-ascii?Q?mfeEN7gsn05j5VPWFED7y+Xp91dVn2NTQA8ZeYh3VRUdvQ8DHSvKhgMuvTGf?=
 =?us-ascii?Q?+jH3iUdSZkxWKnVEFxOagSh6VWzPoVZbTs2LD8V9AJCUmFtFP3mza+qPrkBD?=
 =?us-ascii?Q?44kSwvSoMLvP4IKRHluhRcSGvqwWCdfAmVkXPZU35oz9Oips5sO7nPz2NVQs?=
 =?us-ascii?Q?oZ0J5A10jC260ISXPrdG+YkLLQsi2C6uDJqWP3WJ8787H8JW5pSzoqlRJiF8?=
 =?us-ascii?Q?nSZp3MeucYj+Cf/UcREQh0mD7TNdCw1y+prFJcqFzxmCt5vq5W8psqOieun9?=
 =?us-ascii?Q?ROMrGy4T/mfvKHzVUR6NnFAqdV9wEwUNhL/Ns49holYViPMYicl2o41kmxXz?=
 =?us-ascii?Q?1OEa5DVTczeQAlQcHPFn/BcA2rwv6ZzzDHsv6HXSivPY5tgxqGPWKaPC2BXF?=
 =?us-ascii?Q?FEXhPwUiWMNu3oJWbuujSHnotzJv3+t9chky2H56RZsHIEniU7phA1aQ+Q5u?=
 =?us-ascii?Q?VJSQaxRzvD2hzR2jR6hLhczPZ9zB+b80ZH+VrGT4pGMCPH04thw1AiA6Cd7h?=
 =?us-ascii?Q?XfoPngUj0GX4gq9tiHr/gAyJqg+liQhiGMXEWSrb5HnzZSrVuYEGm3xmYrHu?=
 =?us-ascii?Q?FtD4h3P+Pt/NYqK1CGw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b44a4aa-9cf5-4dba-b069-08dc240e8081
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 16:46:28.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: greqeg7VII2M6DIl/hPYWzI+nJE5SrSlKG884uTVbjpmuqzqz1dKVsleU5J8zRV58oHAx/5weIvKeJABJ7mhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, February 2, 2024 10:01 AM
> Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
>=20
> On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > Can you say more? I'm curious what's your use case.
> >
> > I'm not working at Nvidia, so my point of view may differ from theirs.
> > From what I can tell is that those two counters help me narrow down
> > the range if I have to diagnose/debug some issues.
>=20
> right, i'm asking to collect useful debugging tricks, nothing against the=
 patch
> itself :)
>=20
> > 1) I sometimes notice that if some irq is held too long (say, one
> > simple case: output of printk printed to the console), those two
> > counters can reflect the issue.
> > 2) Similarly in virtio net, recently I traced such counters the
> > current kernel does not have and it turned out that one of the output
> > queues in the backend behaves badly.
> > ...
> >
> > Stop/wake queue counters may not show directly the root cause of the
> > issue, but help us 'guess' to some extent.
>=20
> I'm surprised you say you can detect stall-related issues with this.
> I guess virtio doesn't have BQL support, which makes it special.
> Normal HW drivers with BQL almost never stop the queue by themselves.
> I mean - if they do, and BQL is active, then the system is probably
> misconfigured (queue is too short). This is what we use at Meta to detect
> stalls in drivers with BQL:
>=20
> https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
>=20
> Daniel, I think this may be a good enough excuse to add per-queue stats t=
o
> the netdev genl family, if you're up for that. LMK if you want more info,
> otherwise I guess ethtool -S is fine for now.

For now, I would like to go with ethtool -S. But I can take on the netdev l=
evel as a background task. Are you suggesting adding them to rtnl_link_stat=
s64?




