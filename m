Return-Path: <netdev+bounces-272219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHh8LcGNxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:49:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8933B214
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528C6303FDCE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6233F8BE;
	Thu, 26 Mar 2026 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zAF1M69C"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DE344D8D;
	Thu, 26 Mar 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554373; cv=fail; b=bw6y6T18e3GEPn0PnVJLbiDhDk1AQlx3lXcE/4N2cKzAR6U4Tj346Zk+77D5TLw+HCcuKWpwF31rJJhMpselydjUPVc1Ic/6iH/79ZLiR+pWJOC3+Rb9il2R0j4ga8uc6PyBwUHjipRg6S82M2Fq69O1XyN3xi+igPbcMAv8+Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554373; c=relaxed/simple;
	bh=EqIuup1iqNQQnEneMV9XKquJ3U5pvZDMdD3p1FfO25U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7oc0kook1wK1GdN8x15ZpMl/evEO1e7RNytpL92yb0GTorTZDJBQ8wPF+I+czrDn1ZFEIgsNsFWG/PdQu/1VI9wtHkxR5Yvls9E8eG2QYAnrUvm57tYcDVYbhpsksyczMIcADmM3LZ0Lh/9tUAh4N0pV3DWRewbsYkZ/xjD28c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zAF1M69C; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd2OUisb+oSRn0V+PMwM8Cumu1yw+TzyT7ULix26F/a/yG7aFFK7zR84f41s5P/0yIQjLRvqqjlE0wU4lBswklZrRXA60mSb8/1WuYd80TukOj1VBG6Dnf74b1uygHn7osIzeIQAJi0DtCdZRvLIsH6Q9cXbU0FgtE/2zTp022Wm790/ldJIZv1CmfAVRC50ckqUNEyYh8FKjG5/s0qAKycgchfWqo0X6N6Dr8IygApz2KzuZE3z4JVOg9RllSSuqIgYRLt/xLS+gnm+zYhaBnDPMG+CJmlurOs9dUvlPFrb6ypGqw+vgcEQxn3oZ+Nmqma2wxc1HCJdKW/32nDs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ouHxqePAy6D+SfyqmR5ekt/SMEAh/HE8vuWfppZv84=;
 b=SgXcPfhlkect0hA5rQuGX/4JGpNEe33huMzxIKAAK1a+yTG+BEYvc/AUVdQ5gEQ1nQNB/XtESCzpdLQ5O0wtFwmcdep8VAqmpEGJ2eOIDZp+vNMErGrom4LL/15PaB/6xXFMdhIYa3Y0ZMg6m4avsKlEMy1o9srgVxAuW9SuM9gSjo6B41zo6A7k5El5wjKkN25IWrxyENbOfQz6jNOqr1e3KWOxrmjie4kzbTOLJfUXg90fwxZMu1tc6K85DC2xCZVVdsKilFfxvGYxuda36GdjT351iwTIODQVrO1t+mP38iRXySoEOEUqH78UU9JeC0nNiCLqlSyCsIv13phGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ouHxqePAy6D+SfyqmR5ekt/SMEAh/HE8vuWfppZv84=;
 b=zAF1M69CMqa/0C48NB/3PtKNm/tZ/gRB70JaBOfOtERICqLY6Xq18KoVyZzDjHDCMR5NHJa5tyg7lIt3MTTYvpg3UbKhG8q9a5VyU+UBF+0jnbbmYaIvnAmIUuJvhpRx4rug74LTrSH7HoguYBpJHj+Ow9hE3bHMpTR7adopocU=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Thu, 26 Mar
 2026 19:46:06 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 19:46:06 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "sean.anderson@linux.dev" <sean.anderson@linux.dev>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "horms@kernel.org"
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: WITHDRAWN -RE: [PATCH net V2 0/2] Correct BD length masks and BQL
 accounting for multi-BD TX packets
Thread-Topic: WITHDRAWN -RE: [PATCH net V2 0/2] Correct BD length masks and
 BQL accounting for multi-BD TX packets
Thread-Index: AQHcvVPF3ZVZoRIQMUqYa/tgxHECpbXBN7Qg
Date: Thu, 26 Mar 2026 19:46:06 +0000
Message-ID:
 <SA1PR12MB6798DD0E0C9EE42C5157E512C956A@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20260326185510.3840084-1-suraj.gupta2@amd.com>
In-Reply-To: <20260326185510.3840084-1-suraj.gupta2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-26T19:35:47.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|DS3PR12MB999216:EE_
x-ms-office365-filtering-correlation-id: 60c2526c-7705-4a6b-8dbd-08de8b705230
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 nkodKCFEdxAzgPBBqyF4zIpaFkMq3/Vif10/9m1k8OhYHyr907GH/aPjUmCRJUSPizBx4Ehr5YX9Ql989molxalMQh9uFudqxGumE9nV2iYWXcGdc0l7f5EAm5C1AGs4tHbpCc5l0rbaLGOReu6lvxSb68x7dS8dFBxoCrr9f9DaLgWpzUNQu7wObgQczl8vFz+TUEvVvtIQrxbTtOg9i3EUOqLnw9yide+FQB46z87GS2tVDXkznTplWWBqmcXO8HVjgG9Unw53BwUvGbUpzQxSUDxOng7NNElaCVo4jDm6PmQtaaejCba//GH8tM8xTyWo9p0qboDet8Vy+ohoieGcFeDy6Lpu3xEw4Hk/hktUQtSNQ+gCDoQhOXs/ZrHsi3dV+bD4w9sgHREfz3wdxrHMk+AkPVN1wgMKZVy9guxaspNWIeK9juJyRHMzrAkDej4GvjfX1dKMeqvr8KTstKk5wbQ+RRReA24Di1gY9Qv9Dx6esbOw8TE8+uyAobdF0uR2Vhg45g+cIaCzcDyvp+QHfd8FVZk9BS4XnIDqIbxxn6sUc4/oU4q/Obq7nSggb/VajfwN5uOyhFsbafzFZlrEON2GTNdwu+HQ9f/9roLiKhT05WutW7l07TV1TzYKvtzyfHuuDHg34NM7E3Q/E708K6TaEDGR7ZBvLwuTq9QdJDD3y7HaG5zgkL1ADVUPF9sGYs7wQn8Nsf6El901DZCj3fqya5qsLyM3Ert3CXJOjD6zBj30ARzlU/62ib0vbhEp0GihJSR9Vaqx46kpKezu0/B0g/iYBttgfnuXcHSqu0JbwYwLaPt6wzCqX9A/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?40VFk+LNrCd1IvJ+yxXjRVu4oyVf/1Gmq8wDBxvxnOScAR5xEDdClo7IjuX6?=
 =?us-ascii?Q?BCHFpa3Z/V55CI9HBdRtGLSt/TLgXivmA4UyRgojQoJcNB8QWcdRx7GxRWu6?=
 =?us-ascii?Q?Upt13wY6sa7ikC00zOewUciLkLZCX4SL/h7i+Ef5JQZTOb3Ami4XoNZvDC8o?=
 =?us-ascii?Q?jNCygBSbEpsMWn0NHsV0t3UKJ/xgOtgS+cFY7bOpUZn/UfRcu8bvie2a9lPF?=
 =?us-ascii?Q?+Lw0O1Du51+utL95IEJ0CeeH0t7Ge+LR1dYkCJ5qn4KilxEnKKb/wT9bZ9hA?=
 =?us-ascii?Q?zCxUW7ARwZSf/5wOIwSFB42HYlhpaibIc3Mqks8h9DRmI6TMFdSWPHEXoKIn?=
 =?us-ascii?Q?RWXPHuyDN2p/Y23n5U2WqAUaFdqGP8encFYjcfbZmGhBvw/7MnWAZu3MjDdc?=
 =?us-ascii?Q?j+3mvCinJVzVI5ql4KA4cWgdbINdCP2kpBObJeJ9RhgoOkdsrtOd5nNeOTp4?=
 =?us-ascii?Q?CL6ehHVxIlqwctVfnG8rJjQJ0lCnnb/Re9EqITlVdvpR9lKC88vMtpykSnih?=
 =?us-ascii?Q?CuoKaGilKcPvlBcTQr1lJKpAfYdE++P9pZDSO4yqKo8ra3p2S//PlxVp7x25?=
 =?us-ascii?Q?a5SSejg9JOj2Fx+CnXFoXXtWX3/FIHzSI48PZP4fzT5SpZKcY1ygoD9Y1BWg?=
 =?us-ascii?Q?jEzR/bK/jXyFoUjMnSlFTpe9W5nbglOdJblihvmTp2XUcqIFDgr9OoXkjHXu?=
 =?us-ascii?Q?CfcHGZWpd36F/CYxbW0a2Tn5WoYSL8XW3o4gKzjoSLk1hBk37bHrJBVd2xtU?=
 =?us-ascii?Q?hf/Rb6i5xpryxenTazyvgDsGLgGQi0m3lqHWcBmPgD3IcEUcuiRROG16fqA4?=
 =?us-ascii?Q?BOgBOTSH7fC3uQe+97RPTFcKjK8mZ+s6wKvAS6NZkHVckEOOltAyFgx4hxBF?=
 =?us-ascii?Q?dnjEJiSpK6weyfmylKGy/cN1l8P8eUZYUcMCT05Gx83Kqmj5lP/pYvEZzsV0?=
 =?us-ascii?Q?9/DhxTKRy244hQIsIpa1Z5UJ470SSSYXbmSUcaJQe2TSoao/6+BWZ4giefXm?=
 =?us-ascii?Q?c3hKq30CtZSgITne5VhUcHGy345aJ1Rg/gwcYIoIscw5vOyzs9bV2qEyWlL6?=
 =?us-ascii?Q?j2NOTEnr3kf+vhIDiCA+KGZTasdxbAYPuCetRC1+EpY7Y32jMou4qGolYHkc?=
 =?us-ascii?Q?7qr7/e4aQkckUkY/dvAX4ECACStE7WBy6mCgQ3uHvSp7rRYgYoPVFt8OIpGP?=
 =?us-ascii?Q?dpeB9C5ZPRjpcrE419C7vx7zV4kwItrS/55He+2gRAop4Vq27ZzJ1f75KPsa?=
 =?us-ascii?Q?vzSscxn+JK5Epp+DhVZCsDAh+mmCOwnR+kTjKBHxxMWnPOS2yl3WjZcTUkMs?=
 =?us-ascii?Q?b41azwlxtXMaZTQnuf/2KpGoodjkUTxGvRZGDSBuQJ7aAWLSyynYXaB66ZEN?=
 =?us-ascii?Q?DhkWuo4O6FeoNkSQrIUwjy6yN0fVyEV2/kDaCPW6+hn/WQlvB7BOI567HbnJ?=
 =?us-ascii?Q?E1rBh5T8BnGT2YDWyd6gx1iZaDXCMM0OLo+R0UZyvMyhgN5E4apkolpWI60K?=
 =?us-ascii?Q?C38VN8L5LDV2faNGamp1zuKSUqjRMhdIGVyQoRXHSQw8Yk1/c3hMXzYBCuEQ?=
 =?us-ascii?Q?QjK9sKtN+8EdLKgbmNmsuBSMv4jTV49IGLKqIsKSSL1Cy2rMby6SfZxuvht7?=
 =?us-ascii?Q?J4iTCZSUe8jxHz3c4fHFBIHVcdjNaws1KUkIF5JFGvjCzJl6rFvsWd0Q9o8P?=
 =?us-ascii?Q?z0Vl1VCXSu7f0N1fNUPGK/tINKkHek7pzBzHC6HXfalwoMLr?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c2526c-7705-4a6b-8dbd-08de8b705230
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 19:46:06.4622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZl1TR+9YCY2Zi4IjDYz+SahbutFiOwpziyHTuBdHsdJYNYT1bwynE/KGnmtEcjOK/TH1WMuBMqTFyQlPV6uPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272219-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Suraj.Gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,davemloft.net:email,lunn.ch:email]
X-Rspamd-Queue-Id: 12E8933B214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Public]

> -----Original Message-----
> From: Suraj Gupta <suraj.gupta2@amd.com>
> Sent: Friday, March 27, 2026 12:25 AM
> To: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Simek, Michal
> <michal.simek@amd.com>; sean.anderson@linux.dev; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; horms@kernel.org
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Katakam, Harini <harini.katakam@amd.com>
> Subject: [PATCH net V2 0/2] Correct BD length masks and BQL accounting fo=
r
> multi-BD TX packets
>

Please ignore / withdraw this V2 series.

Due to a syncing issue in my outlook, I sent v2 prematurely. There is still=
 ongoing discussion on v1 that needs to be concluded first. I'll follow up =
after the v1 feedback is resolved.

Thanks,
Suraj

> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> This patch series fixes two issues in the Xilinx AXI Ethernet driver:
>  1. Corrects the BD length masks to match the AXIDMA IP spec.
>  2. Fixes BQL accounting for multi-BD TX packets.
>
> ---
> Changes in V2:
> Use GENMASK() to define the BD length masks.
> ---
> Suraj Gupta (2):
>   net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
>   net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets
>
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  7 +++++--
> .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++++++++----------
>  2 files changed, 15 insertions(+), 12 deletions(-)
>
> --
> 2.49.1
>


