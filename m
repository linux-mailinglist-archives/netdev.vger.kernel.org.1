Return-Path: <netdev+bounces-306439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LzshLoiDUGrQ0QIAu9opvQ
	(envelope-from <netdev+bounces-306439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500E73757C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hotmail.com header.s=selector1 header.b=hCgY31MW;
	dmarc=pass (policy=none) header.from=hotmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306439-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306439-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9070301053E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227D373C1A;
	Fri, 10 Jul 2026 05:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011038.outbound.protection.outlook.com [52.103.13.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FC1A9FA8
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 05:30:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661445; cv=fail; b=TFFcsTD94To2AextZNqWzYQNNUgtmfaM1C1LAsD5Xx2SFK/lv4ASTWtz7DMUA5cri/WPT6jyEyk0d5EZtIXiDY7P7d8zcqaSGmjcuVLw/Xi3lycaBoAVO4Eu8Qt6HWnCj7ieIuUMyfoLbInkC+v7MXRzqnYJGP/+p0omQdmwVGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661445; c=relaxed/simple;
	bh=8iwvcZ9epVHRfHRXSRjS8oBKWoR2CpPQ/BuKI0ALUMI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hohj4vGj4etzzmdRzz8L3eTSLiITiOMw3JIYg4S1Xiu1HOEW2pJgL79c/SKsZgDvLQrWPnq/fq9+zT2/KoDn2jljjIBN2PX4mLHhb4QyqmlznewEDUlJoS+jzFleExtkwCvJPO3DaGlWaaYsWAvzgf2FX54HYpOF4O2uYWIkmfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=hCgY31MW; arc=fail smtp.client-ip=52.103.13.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwoj7glvz0Y9O0NvgrVQj/ztKPmos4Kvf3GHcEY63z8iv4CdW8pzFROpmH756+VsFOlINi07LDfAZKJ7mGc6ezfu4pflQ+zfDG7WPkiV+2TUrS11xTFet8L2wkGRSNZwG1a2qb1+u9YI5f7kCI2sWifVasNhq2ZCLw9aCO/ySTji8GdEIstnyKsEB2y0g+pEocm9clkmqZV0g2lY7fJiL3ZfbiTsCHlFxJ9Dm5afiFWxlRl5Hvkbe5u7fB8itEDkgfIF+Ax0vegGsUW/4x/GXfY8lKFAwkN9AVQJZI8IBt5KTqn3PdIzKWt7I++MORyDnio++tAdAnr8bI3ZSH7I+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iwvcZ9epVHRfHRXSRjS8oBKWoR2CpPQ/BuKI0ALUMI=;
 b=ChcEKCyrccNcNIjWjSiYaxKsU9CgiLFrZcr1eIeiLMasc9clLA9X7zndaSuX6dSfz9+/DxwMIkQH4vcsFHdcIwXVLW6P11tpgz6uemX9XnZKVZ1cFHdsVEKrRztl2xYrJzmZla4cy4dlrBTa5w+u8LZ2RD554FGrAsNimgPaPqnYVHmklP5dlBeWEoiiifMWKUwMx/8fYtIVJ53qjOAwZbmWJHi9IBKbq9TXgudVlifAnrMJt99+0JOPqTcG6IUizjG828NBPQDfsgbLlqJFHn6k3RgfGjQ21SnNTlVm5q33znSPgRtnrjuA78WyEKGAF+BQW8OW1WfzkKsozFISug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iwvcZ9epVHRfHRXSRjS8oBKWoR2CpPQ/BuKI0ALUMI=;
 b=hCgY31MWhi1zk+mAyzxJzF6GjAiYItCfopWaAopeI9MggvxC/MZ0aWUEd3CHjrlBl3q4fDBCg/rvEvv02Bfan1sgHIXSOWLTgN8PD4pIbRSdoBgBS3TV5oOXxr8t3gjPOa5C74244dolbdU+hYojMEzyWJCe4HgUYgD0Xn4z3lYiOv2otG1No9kXjEnvRpvpsxfDnFv81Ed5GJAHSbM6J1CGDc9FdMho6Fn3QnJNmFyxv9ZHP/K+2iZZyiFEN8gLc5kSC0imSiO94ORRSmku46+RigusWHBtqJVd3QZZiAqPtQgkYl9gX8SXjD1J81Zqgt7aK6sre8lp8BR8pIOsdA==
Received: from BL3PR17MB6067.namprd17.prod.outlook.com (2603:10b6:208:3b6::20)
 by SA1PR17MB4691.namprd17.prod.outlook.com (2603:10b6:806:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 05:30:41 +0000
Received: from BL3PR17MB6067.namprd17.prod.outlook.com
 ([fe80::dac:354f:6da2:b3f7]) by BL3PR17MB6067.namprd17.prod.outlook.com
 ([fe80::dac:354f:6da2:b3f7%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 05:30:41 +0000
From: Jack Ma <jack4it@hotmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Roopa
 Prabhu <roopa@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>
Subject: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI feasibility
Thread-Topic: VXLAN FDB nexthop groups: per-nexthop UDP dst port / VNI
 feasibility
Thread-Index: AQHdECzKntl94UH4t06XCxWyGsMDVg==
Date: Fri, 10 Jul 2026 05:30:40 +0000
Message-ID:
 <BL3PR17MB6067BF1D5802A6B1822452EEE5FD2@BL3PR17MB6067.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR17MB6067:EE_|SA1PR17MB4691:EE_
x-ms-office365-filtering-correlation-id: 6443df09-0389-4a5e-b92c-08dede44619e
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|51005399006|24021099003|8062599012|31061999003|37011999003|25031999004|25010399006|15030799006|15080799012|40105399003|12091999003|102099032|3412199025|440099028|26104999009;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?ewMXhT2nLp5OD1Ri5t1LW4Tvcl0A/qMp+0tR6K03vZuFH0L61wvJHRrm?=
 =?Windows-1252?Q?N0AJeTsP2VA+hcc/2VHvUGTvl7ZPygnezuLRqaRi5n1xln+iA5ssjdOM?=
 =?Windows-1252?Q?ETw1g5TFAmXSuF8/YVz1o3L3RT7yuTuSGuN9pe8cIl3HPw+8/28LM8J9?=
 =?Windows-1252?Q?B7JUpFDvDDYqKl8NgDluRCzAmnws0WiCrD5in7D7DjCHJjmAO9dWEjLq?=
 =?Windows-1252?Q?lb+MO0kS1SoEnS8EhFO0SE6XaJqtHZ1+lq3TOClZYbNUykGhWf2X1i5r?=
 =?Windows-1252?Q?LPZqvPIb7CfyOm7T5MvwVCclsDmWkzTOYUEkSEjNKrKQIQSwELlLAmGP?=
 =?Windows-1252?Q?gjOGIAD8ycMqanrC3fjZG9rVpdJTY5Yn1CgtB2Wlg5Bj3qOxlHXJuIzc?=
 =?Windows-1252?Q?gjOD/6nRStF56J46P2z0orCFt74qQg8+wdLYGGex0R+amFW23t2QGEsp?=
 =?Windows-1252?Q?E4XiooLQ8HqIN+qzlOdKtSRU0gFtMq52CPRd8olk8Knfka6hKCcxBL4s?=
 =?Windows-1252?Q?5PBn1LsPmOrqc6/DHg6mjkcGiXMV8z0ih3He6Fveb2SSvKOIKNBiy+jT?=
 =?Windows-1252?Q?EwOzXkvnSNpRLDMa2smKNoSO8Zll5t+gvkEEcGnq8mljzfe5M6GCHlT6?=
 =?Windows-1252?Q?3SEyypmWYWQlIDg9lHSQMGkf45jNjRxaGENEznddosH16EtR5XptSrxr?=
 =?Windows-1252?Q?aRVXqUH7Wser7Ff/hBqU2hkNPS4y983p36i11PxGBGeG7wqLalCWhdX9?=
 =?Windows-1252?Q?ZjiomhnnjACWFFDJppnmeqNBa6C36l3VlXoXO33XVVhRPEl2pkEVuhQc?=
 =?Windows-1252?Q?M8K/OZWQq1FjXGVFqACwFAuEWXQfmapB2EuqNO+tPvk1Z9awfOlVjO+p?=
 =?Windows-1252?Q?aPTK/0/lHhw4ADvf/OooNwsunjwiWHbB26gHsDjLufkWg9YoiNz7IOEu?=
 =?Windows-1252?Q?KzRKa7Ok8jQmi6j5bmjyEyJmaiozNj4zTqGs/TxdrEWKjG/r4A06t6hI?=
 =?Windows-1252?Q?AFeulU31HHB/XsvE1e3umBxceAbLMyeA1yZB60g5GkTPhoIngdqWJ5P8?=
 =?Windows-1252?Q?2acTZu2bGjnfD9mNmsZ0D2FrqGsmHiJWpZLlv/QN+oWFSIszX+0eWOPQ?=
 =?Windows-1252?Q?EbFniAAIrxmdLiZn3et/mJIi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?qo/0TI0U/4HLPr/eOhdrImSi2ZiP4fxTCH06ghMYHX+m//VJi7wy0KtI?=
 =?Windows-1252?Q?3NbNkzCISR5H6NvT3yjirQZ1wkFrAe4LmzICWrV+QpBFDzHHf90hNIAG?=
 =?Windows-1252?Q?0mDHKBSWGSWCLa9mm4uwEhddypv4fVVf/oSE2PvmqoRZL6I6FuIDmXUw?=
 =?Windows-1252?Q?6mmwyLmSaEDE0gpt/N+DjvYdnZ8ZWmYCDJZf9aeX/9o9PlG06pwnMLT4?=
 =?Windows-1252?Q?CMyM7TdQEwdFs9fUdu19VU4rs6ltXPG8zotTvAerEG6UYB1aJTKQjzl1?=
 =?Windows-1252?Q?w9GTpz7/dVViPJkw1ADSJu3mozjxbOiin//GHvTdT/AUt7IcwD/Eb/bJ?=
 =?Windows-1252?Q?HQc9kIXlHtajrjerOMIUbpRu2+QDNmGP6XH08E5P3eVqhjn9+eMWCgzg?=
 =?Windows-1252?Q?NiM3WJRNb8FoO0bKDM3VRBsTo/6vBAmWSoI4AWFHBCY8s1xh1Zuv/iUH?=
 =?Windows-1252?Q?JQQOD2/2c2MR09RohS4WpGIHeZBhEbL24ExVwHR5Kfqwo0tp8o3L2I3G?=
 =?Windows-1252?Q?F3hVsoiMMvcC1xxWqjc+mgTqzjolGDv4BrlFvCxcLXPTFhFkKDeeuJEd?=
 =?Windows-1252?Q?2HSb/qkGniejKvjzA88zgLbwUwKl0F38ANPh4j7th0QmpkFNlIYm2PhP?=
 =?Windows-1252?Q?X8n8Qo7n8uekeoHnHW1q30GwICmq0X/pjYoSaQn7bhP/gQE8oa6q1i0w?=
 =?Windows-1252?Q?IC7627cVnJRSBhL4kjYyEtv/Q9RB+iAxnE7qLLoORuTcyxbSgfjA8TNI?=
 =?Windows-1252?Q?daFERI5uUxHqMCodu4R4xIFOcAV62oU7lmVDeoaikkUzTcrU6iFV4kUH?=
 =?Windows-1252?Q?Q7PpCZeRC/b9oTqtiZ/X9/j+6NWywrq+YDAw/EbiRuyxpycewVZwx4Nn?=
 =?Windows-1252?Q?5vDM8k4KgWu4wOj5noRpMpNS0EZqQgbEcWe7k40oSY70Kse7SyW1B1Wq?=
 =?Windows-1252?Q?fAOCQjpllcvMjBTqPQ8P+w980G02U1du8ILo5rwbw8AgTrLOzJpSt0Ly?=
 =?Windows-1252?Q?lyO7QXhwH8ZdLu3ylyWg+I2B9cq9GbTorXwDlUctZiWUa40Mmrto7ZuO?=
 =?Windows-1252?Q?9R4bHIGHwxoGehBQMidPZu7ynREbESAUNC+OUw5chGaULOf7lB5g8qzE?=
 =?Windows-1252?Q?fcVESUY3IFhZ7bGcssMfaGL5KpPLrM1HI3rZZMKTjK6ZlZEGIrLacY3n?=
 =?Windows-1252?Q?prvxwdmc5HhFwPp6xG5aSmlaS9jpZWJh24JQ48vBYe7qfHb+GPjVfxkY?=
 =?Windows-1252?Q?K85dGU60FUzzaQe1ifI00WCkq0/W/wnPzLl03E8nya2Wc7Ak9kx2DAFd?=
 =?Windows-1252?Q?vlKGemy1u0yMyHyi3T0rqT4ZBN1gNRM1uPLWVKqwKfHjzIz1Hp08LeSZ?=
 =?Windows-1252?Q?7Xp9aPnYT4Rs2DuhDPVfFeFPAA18f8fP5KRrYm3XPfGSRcBYVquFkc6r?=
 =?Windows-1252?Q?xipF5di7pstIVsMcgjbKc6kmojMilBMDaYiaWS+Kuyk=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-e4558.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR17MB6067.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6443df09-0389-4a5e-b92c-08dede44619e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 05:30:40.9895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4691
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:roopa@nvidia.com,m:netdev@vger.kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306439-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[hotmail.com];
	FORGED_SENDER(0.00)[jack4it@hotmail.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hotmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack4it@hotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1500E73757C

Hi David, Ido, Roopa,=0A=
=0A=
I am using VXLAN FDB nexthop groups (=A0ip nexthop add ... fdb=A0,=0A=
followed by =A0bridge fdb add ... nhid=A0) to implement L2 ECMP across=0A=
a set of HA endpoints.=0A=
=0A=
In my design, each leg is a distinct (VTEP IP, UDP destination port)=0A=
pair. Several endpoints live behind the same node IP and are=0A=
disambiguated by the VXLAN UDP destination port.=0A=
=0A=
Reading the current code (v6.12), it looks like an FDB nexthop can=0A=
carry only a gateway IP, so a per-leg port cannot be expressed:=0A=
=0A=
=95 =A0vxlan_fdb_nh_path_select()=A0 copies only =A0nhc_gw=A0 into the synt=
hetic=0A=
=A0rdst=A0; =A0remote_port=A0 and =A0remote_vni=A0 remain zero=0A=
(=A0include/net/vxlan.h=A0).=0A=
=95 =A0vxlan_xmit_one()=A0 then falls back to the device-wide port:=0A=
=A0dst_port =3D rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port=
=A0=0A=
(=A0drivers/net/vxlan/vxlan_core.c=A0).=0A=
=95 =A0rtm_to_nh_config()=A0 rejects =A0NHA_ENCAP=A0 and =A0NHA_OIF=A0 on F=
DB=0A=
nexthops:=0A=
=A0Fdb attribute can not be used with encap, oif or blackhole=A0=0A=
(=A0net/ipv4/nexthop.c=A0).=0A=
=95 =A0vxlan_fdb_parse()=A0 rejects =A0NDA_PORT=A0, =A0NDA_VNI=A0, and =A0N=
DA_IFINDEX=A0=0A=
when =A0NDA_NH_ID=A0 is present:=0A=
=A0DST, VNI, ifindex and port are mutually exclusive with NH_ID=A0=0A=
=0A=
The original commits, 38428d68719c ("nexthop: support for fdb ecmp=0A=
nexthops") and 1274e1cc4226 ("vxlan: ecmp support for mac fdb=0A=
entries"), say "these nexthops only have ip." This matches the EVPN=0A=
multihoming use case, where every VTEP in the segment shares one UDP=0A=
destination port.=0A=
=0A=
My questions:=0A=
=0A=
1. Was IP-only a deliberate scoping decision for the EVPN-MH use=0A=
case, or is there a deeper reason why a per-nexthop UDP destination=0A=
port and VNI could not be carried on an FDB nexthop, for example=0A=
through =A0NHA_ENCAP=A0 or lwtunnel, which route nexthops already=0A=
accept?=0A=
2. If legs genuinely need distinct UDP destination ports, is the=0A=
per-remote =A0rdst=A0 path (=A0bridge fdb ... dst ... port ...=A0) the=0A=
intended mechanism, with the understanding that it provides=0A=
head-end replication semantics rather than nexthop-object ECMP?=0A=
3. Would you be open in principle to a patch that lets an FDB=0A=
nexthop carry a per-nexthop destination port and VNI? If so, I=0A=
would be happy to prototype it as an RFC.=0A=
=0A=
Thanks very much for any pointers.=0A=
=0A=
Best regards,=0A=
-Jack=

