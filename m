Return-Path: <netdev+bounces-213012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48EB22D58
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBCA1628CC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5C2ED153;
	Tue, 12 Aug 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIlB4RNJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B12F83A7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015615; cv=fail; b=lfT4eYU1eya0Xof/2aRztWS5qoO6G3JJW/VVtp5Ni4+7ldLBe0yeTA23th5YXRbiarZCuI4j2NOBEM0wc3OYwKFz7I3mwsccMwSLrYK9rtSDutgSuabR0/k6ePCPIngDuB58QyC8eXdE2Ddz2Gv4W2b5u5FkhHiJJE3qaUpU8TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015615; c=relaxed/simple;
	bh=vo2g9xUb8jNa/oifbS/OOhr78eVVxKe5KMVvZgW+56c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwiDNiAhPPm6MfPS3alFoFPamQniz/qlKHB1N14Q4QBmEPeDk+FjXsdK2cobVG4lXSGE+E9Ka6zY80GEt0EDq+PpV/fYy0u6DQXYqMECNyPELaDfWcNOOsMWEw4LVTG3kK5KXDiL3L7ihCtIY7a8FnbEhf9rfv6AGuyKO1KMLrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIlB4RNJ; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ya/Xwz+bg5KfwpfeHGLXRkvLBszXZfwIyCmMbrt8dHPWYbjTfanf/OdR0kzPVwNJtsE+KuGWpmSx+kNQAKgFN38PoGMs2tFXGwZN8tQJu9IzApTp1+GViQsyq7BccSiNn2QIg8OrUBnElfd4XmB6qOuqEgPGuDVefbBRQ8jVAleH1F2Rl/OfTQB1+NyruCw7iVEcbuETF8VfdLoe8xtNzGoQJm9pDeDMMgktPZQp/Aos7V/SIIiuSnbp1Su5GwfZGBH9Wwa+O9NKnbDslCE1dtYmRDzhb9hZjvN89OviOH3jPHBcPhEzI3qA6qK31SE2qoSR/EoFU0ewngpbQdarog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LowP9LSuUSWoMK1nHDEpa3UlTgaE8YqxsHvAAtUQy8E=;
 b=boJYDpRtbroOm5LYE8o/03BnnXUML1SIZf2hdod6U5+21yxgJxR4/wBG63rqPn+jD2ud7MKq5pV4mK+O2OZwX0ENFXDjXmkpwtBE7PinU2Bzj/puesNDfbABatoJ8Q5XdLOX+Ar8+SDt+KQH0awf5fahwgYJCTQjkJLejg41BMV4zkMeNxVQd/7/BX7+/su0q4qCXC43eNR3ueRiFlTYH0J9VWJMyFv/KZck3c638hGq9bMxmiEopY+hBDybhI5fFMa719he+UlSG61EAFL2XYoIX8njfqGNyTES4bGChpB29+kBSvowhZsDHgY32I+CS8vVUqNF/PFHYWJ3S2KIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LowP9LSuUSWoMK1nHDEpa3UlTgaE8YqxsHvAAtUQy8E=;
 b=YIlB4RNJytT/pRJWkrjPja/ARQNNc7weB9ooJUg5bsymm7sHmkA2kkGNuqd4Rf65N7xuWcc6dxRLK7UCt4QALHlVTB6WmJg+G2+np5WS5zbPfHY/dUOVf6JiH9z99pevWGQBS0bOJHDA1B9oYprweLZIvjqEQUb8ahD45AggJQ153itDDdf+VPE2pZv0xtRx02ZR6tvDn6i9BaO109IYKqtVgwg2apUqs8l1E9x0NQIGr2IvR4lfd+c7qYTaH/p3YCcJGksG6Yq6RlpGEjnjeeO7bhAsA0zP642+ZN5kCx8h6EBY96pO7VFMOD2rMg7xQTJUauK0JX+b5cTLEZghgw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 16:20:09 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 16:20:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next 1/2] devlink/port: Check attributes early and
 constify
Thread-Topic: [PATCH net-next 1/2] devlink/port: Check attributes early and
 constify
Thread-Index: AQHcCzyNSYRM7nVLJE6jUyFrVYNInrRfGW6AgAAZ7lA=
Date: Tue, 12 Aug 2025 16:20:08 +0000
Message-ID:
 <CY8PR12MB7195D5CCF640C5F85EFC199EDC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250812035106.134529-1-parav@nvidia.com>
	<20250812035106.134529-2-parav@nvidia.com>
 <20250812074657.368dc780@kernel.org>
In-Reply-To: <20250812074657.368dc780@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|LV8PR12MB9207:EE_
x-ms-office365-filtering-correlation-id: 9e0ccbba-15fa-4796-a087-08ddd9bc1ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7c0jqlHHTgy1xXVtMQDUhdcFHQnf7nQ+VNQ2EcbQIF6FSehF7kf57C+dToY8?=
 =?us-ascii?Q?4CiDYm6zIjkRkKLMWZ83AT1EMwlE9+I3kV2D7WWeSdf9KqUf8PM+LCvkyjBF?=
 =?us-ascii?Q?tibsXQ6nwn0lI5mRu6b8ljgoYwfhGyHRn+CNOt0n5bEJy+l/5BrBhR4KiWvK?=
 =?us-ascii?Q?GxbwMqr1JcuRkTm/fefU7ii9ECD6Y9IgDELoVbFt4B4P1nDmKjqUpIchFMff?=
 =?us-ascii?Q?EmyTiljjm6MhuAqiz8iZP9C4BJBDuFtB57QjNcV3FJ1U4uAT3Vr/yR8pqZSD?=
 =?us-ascii?Q?cSZ7vkvofwX4lMDuA0wr7Z/mWNC0vhXZfXEPAvZxmxupjYC1V7yglPD579TC?=
 =?us-ascii?Q?05H3q/mRtOMPuUrtSe9Rx95ea1/GBntIqtruNezw78yQ8k16ahXcIOPz99Ct?=
 =?us-ascii?Q?gM02aAztwNOlKXgSafB+P7kKhdq+8L5sVHnH4Ea07yPQxOJhKhtn5wZvlQki?=
 =?us-ascii?Q?PpdEEI2vdP4JadMuFIJZFWuisGFG5VUZSwdz1ElAB5GXcVztDAcNXQxo/GN5?=
 =?us-ascii?Q?4Y1IUumTw+5uXOz27uche/KOVq8xYh4WqbOFBhBTkS5fdxUqEY1+XPJtNom/?=
 =?us-ascii?Q?7/ioapgHYf6Q99/rJnKQ16kA/gPm6eMYfuteTz0Kd0WbaRm6nA+Rscu7qTo/?=
 =?us-ascii?Q?ZoFDtUj6GP5zJ/1rs0+XP8byeNQh3LdR0lF3EjYyUT6dVe4OLZ7lv4ts6ZNf?=
 =?us-ascii?Q?1rZo5opaAhYaEiua/cYePd/Qkfeb3R6X0Oxa3Okg60Dw8HCz0vPMxRJBelvO?=
 =?us-ascii?Q?qt5KKwahk8Si1w8r3RouvIKPPNoXQ8Hnurox37PEsDiarzrn6ge4WtlI/wd/?=
 =?us-ascii?Q?eTaCifkgkUB50SGrg6rZMfrtwK2/od9siWYuk8vVerYwqc8HaH5wJCJXc1/I?=
 =?us-ascii?Q?vJt0FrnR3wYl0hJUaZ7j69dTR7mVOCbJ2kPdfoQnNs3hp91eJTQ1WygWyjMK?=
 =?us-ascii?Q?0kTcMzdncuXdMxxVa2zPerasrmepNGdaJBiLptYFtfOt9rVKEt4R0vjOFDjk?=
 =?us-ascii?Q?aLq3t6ThiPQZMIy78BexaSuCLUs8b3GiCwmTrgeIwGlVEPVz7qwfMIFhA7Gv?=
 =?us-ascii?Q?ul4s9SsyvfTicwkpXvDeyHzdmWHwwJWN2IsIsK3dY/ZZA0Uz+ZR4/iFAX5ra?=
 =?us-ascii?Q?D3JIoCLhaY7TFY0/HTbciRi5y/B7o4D7iVsXXVja3Gux0RunsvZUNK0Xc+rf?=
 =?us-ascii?Q?fkBNJiXUW6WG9bNq+6UkjoMMp7dwfXR/ahOoERrAxrJDMYCXzLe3BudW5Cdc?=
 =?us-ascii?Q?LwfFPQtF4kM5IngDPYhPhK1JdMgF3LEIa6BUwjjDUqnEk5BsAHdgu59X4zE/?=
 =?us-ascii?Q?Wi5FW5GE4l5nVc+rx2CYfW/hL4q2EOMfqAYY4YF1n6IgJnVX4rk03QVvTneg?=
 =?us-ascii?Q?2piA2+fzwvaP8QbiUFz8ZxaAWJOpOf+6bnUT+/kIZt/pooETeJn1uBuvdyfB?=
 =?us-ascii?Q?rSxw/D4lGWFzytUJMoqHPX7l5vPKZUrK/qw8azkFcjqcUl8nW3ZsHI4y8eDW?=
 =?us-ascii?Q?dDECGL3SON8Txxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lw71Zq/oNhsk8AkAqQowZwxhzex95SLCb/0q+trJQMkivgjHVbNxgjW6ZwCQ?=
 =?us-ascii?Q?+F8ROa8EqmxO7+pM1xYwYK9aBoqWdHKblfStzk6uX5LT2HSM9pD5G9ztMG+6?=
 =?us-ascii?Q?Pm8cYpjn3XZeH8qnhj53MXB5Qi3Gso2L0lTD+8DMiSXs6pKBgzMe0GGONX9p?=
 =?us-ascii?Q?fRvHQtAfbqUI0YZ8qLBQTMH4XNo16jvJUJWbYTRA8gm4rAbO6Z9bqoacpnJh?=
 =?us-ascii?Q?z7wAdupldWqpvht+44TMlLB+aO/6Mnvtt8KPVBVOTwA58wgzwV8SulHWPPSi?=
 =?us-ascii?Q?D+FQY6gl69CMCHDIuiWT/QFK7QdY4HpCCQw1fegSh1e61tc1/kVh/5F8MkL9?=
 =?us-ascii?Q?iVrhlz/QNzpoUhCS20U5njiBDKuZZi46ym6sertIamMtXWtcZEyq2ze2em7U?=
 =?us-ascii?Q?qO5tR2urvMAqK6y7T286zu6pNvdy9G+1/riiflD8xc7UuhShv3E8P/HoMWDD?=
 =?us-ascii?Q?DFU92B+sVNf5f1DDk8qxswQmfsWeZuGgQxCxBPHgOmXZdf1x4w9LMCZZRbQ6?=
 =?us-ascii?Q?091tIwIRkQfMkBuezVtYz0MdTBw/gqzcDrmCUBczefRfyp4x1KFyBv1nsNKJ?=
 =?us-ascii?Q?i5DApYaCzPiFZ65JYOSMo5pP6wRmM2JcTARNEGer5W2JqPg0TL9DIedtil4E?=
 =?us-ascii?Q?+/IGXh7TZV5395sBp9Je0oBwp5CQ9SU8XATiLNj1M+QB8mWxYLEsZ16RmrD7?=
 =?us-ascii?Q?SRr5ysJcuQBcFyslt7yQyI1RDBsSGByeNt/Fz5giJWuAJMy8oKPnVVPtOTry?=
 =?us-ascii?Q?VOgEqqFcbAMq3RD79nvIxOAPtU6kHj6+UAgGnBfdEKFY8nUVI73uVSndk6vj?=
 =?us-ascii?Q?IQC/boZEH2LAWAnZkLTYnFR8d3fqeX8Knw/s2gAKXTDSqCNi5dBU5WL5uccM?=
 =?us-ascii?Q?TAHjVvhGHyMmiaR903KtY3VxTQCRN97JxvbIme6XapgLXaimMDPO6GIWjAfp?=
 =?us-ascii?Q?436R/5OVM4GX0D5oqGQq0H4t6B6iaTpenSDJTy3Otg2cLv/nDmHYVKVuuccx?=
 =?us-ascii?Q?ne26Dnpj+hXojOtSQ9QM6BWSBG/MTHsXe4lAe3SDwqaSK2Ye6B+jY5sxpnHA?=
 =?us-ascii?Q?6jT7VMEqBfqzQiQ12UGkpqADrdE9GiPOy4kzwSeA4doKeCP9LKgD6VIfWEsp?=
 =?us-ascii?Q?5jFYGITztvlqmSIGqXHn0nyEokXZgfnCfuSxD4d3zXXyMTv7DQXLF7eXQH6Q?=
 =?us-ascii?Q?fN15AdnK6MxF9WBBsqpjoh+k3kT2qBjjY+Iea4EilGeFOf7R5O6wTPAiQbto?=
 =?us-ascii?Q?FQGZP2KNZCHlvmKYoJRUer+wosK4/lUPFEFPpa3H+KZx+SMuQgZpGLoMMhaT?=
 =?us-ascii?Q?sQxHU+zjqT8dZPJr/e4gaErnAcJq369g9QO/K8Ou2HyVsj1TOu9Kp7EPJgFu?=
 =?us-ascii?Q?T88RFaK1Qv39ft3b87q7QRe7Hm1B/aU8/TjBR8DZKYqpv1LyL7IioFL2+LJ6?=
 =?us-ascii?Q?7jRTjII0yX8+vkI50Q2FZgaEwPYcfCZE8ixDbhOp31XtDPnndmqjbduHGFWA?=
 =?us-ascii?Q?1DEqQ9rKpV3qcc7CCWP7bYFMnMZg3Le+lyccONXllYveqNIgw3zBwK+uAVtY?=
 =?us-ascii?Q?RyS8r2UkoFBkOs2MmDc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ccbba-15fa-4796-a087-08ddd9bc1ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 16:20:08.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lN9YudPw6jwWP62NdwjNtmpkAT/rDFpYsvqGrYVZ3nMJHIjP3yzoS9pyitSqWwJjo3mjpYdJcNW8Rxjd1y2faQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 12 August 2025 08:17 PM
>=20
> On Tue, 12 Aug 2025 06:51:05 +0300 Parav Pandit wrote:
> >  void devlink_port_attrs_set(struct devlink_port *devlink_port,
> > -			    struct devlink_port_attrs *devlink_port_attrs);
> > +			    const struct devlink_port_attrs *dl_port_attrs);
>=20
> Why not rename to attr, which is what the implementation uses?
>
Make sense. Will change in v2.
=20
> >  void devlink_port_attrs_set(struct devlink_port *devlink_port,
> > -			    struct devlink_port_attrs *attrs)
> > +			    const struct devlink_port_attrs *attrs)

