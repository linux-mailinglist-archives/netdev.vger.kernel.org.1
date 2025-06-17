Return-Path: <netdev+bounces-198361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F6ADBE4E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC418908F6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBA91465A5;
	Tue, 17 Jun 2025 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lG2GtJjP"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A926281;
	Tue, 17 Jun 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121826; cv=fail; b=ozgdTVgXfdRxmPqTfDsmGniGRH8jFCU5zCicZOp0g0N2NznSL6b5sQn+2U0dkf434aK/kDxqlg6jjOhWL93D926EvvSwejnax8DnM4/FxYROqdEKWv97jsdbJqi+vaoNMT+uV1wqQ0GaElhezDV9R1WxjlfJNqm5U+v0Qb2i8L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121826; c=relaxed/simple;
	bh=X5dZwdDj+yWH7iPToC2WUDOJhkobMQ/8Vx9nvXTEV6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvDk+RPEWjnaIotI3vaob37R2TGefQpWHwW9xXNVo5sFkanRbMvDKqGSiR+88JPkSaD1IhBkh1JOu4CwvbBJmwu9W4fplfU5CN+i8c02QLCelpIT1nYCVrFV0M34nmixQzssB0GIxfYLYQS1okDrlglgJtnYy7nMQnUyy58GnzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lG2GtJjP; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqdrWdq0w0LJ9Gw18Bw4AR4U17195rJYqoUyouqEQClwfgQgSfJdJA3Vea4/5z0u0nNeSZ4E66G1Jhz7VjQHUQQzRy0I4Hg09Cvv+sHby/mCM8m6ScbhdCukcn0E5ZtcLCMzF+f/AvqT4mPn7Pji0748eN/UWTBNRv2s1GMoHqTjQvlHC8b3o/+gzSZz/qyZnIm3vkDum0Mkl3oH/wBm6bdekaOvWfCEwjBV9OpqF1YQ8uFzLrmt+D5PWRBLC3pdWvZS4Zs6sSF7MWtQcrQE/exttacLyRfQIkEyBlsHTY5k1sLjd6gZxnlMqOlgzGvu79gx0+J8DLgYv1WVQFsCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5dZwdDj+yWH7iPToC2WUDOJhkobMQ/8Vx9nvXTEV6I=;
 b=Svaqslehi7e4lvsVsupXthJt1RfYjutfFGtgbk+ftoDQR9VGXXZ6DX5pCxikQHP2uZb7S9a2hiVvv68n9zy8wv/0dtJNuMKaXB0kSmJSnZ4sB6c0p6RfYtQtGAZGOLnuWtMfGkwDxYMuc4e0Xvji2hKeKoBg1f5lg6uaG/CCV0TgOj3b1U8SrYZBD3WCe1hNWlPbpSpPtkGOWZTXOYE+nVScHUp3F8oHPV/goR7ugEMCxNgubHce6ypiNENpz/P0UkxDeyOrCZ7cveBEvkhqu3YcjWsLhJN8L+WmxYKGYrGPM0rjcGb82NTjkpRll6yPGC3vCKdhMpbZxfhp0BuXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5dZwdDj+yWH7iPToC2WUDOJhkobMQ/8Vx9nvXTEV6I=;
 b=lG2GtJjPfyGlJJA0g6MuuTodNb+Ss8bdINmY4BIdr0aTSuMH269oDFpztzTyQyEIQbmcMmGNBCX17NsaoK5IWzhkdpzksgpSTf8CE0KnZjVykk7R9T9h3f+sAnf0PsMrrGv3VZgc7J2A4DxmzG2bJaZGC8+NOgc+TEWSs+hlc48d2HXJRMTXEWEfQ9P5BX8yq1WJGigBIDfDbKdr/aC1ZBQqyoGunl+D8wJiN9moxjT5VbeWOLCj0EpEU47cDmsxRnvSN/7E7+x4szbvsmiHsOl+PdB9oNX9vm3yYCn1N4c+1d9tzN1DNH9dMOIpITPmUz1PBL2G8g57WqmUfhH7Uw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV2P189MB2164.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:7f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Tue, 17 Jun 2025 00:57:00 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 00:57:00 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Haixia Qu <hxqu@hillstonenet.com>, Jon Maloy <jmaloy@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: fix panic in tipc_udp_nl_dump_remoteip() using
 bearer as udp without check
Thread-Topic: [PATCH net] tipc: fix panic in tipc_udp_nl_dump_remoteip() using
 bearer as udp without check
Thread-Index: AQHb3szc4UVhLA7ufUy3zqqcDQwpO7QGhDJA
Date: Tue, 17 Jun 2025 00:56:59 +0000
Message-ID:
 <GV1P189MB1988732E99991AE664F2439AC673A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20250616042901.12978-1-hxqu@hillstonenet.com>
In-Reply-To: <20250616042901.12978-1-hxqu@hillstonenet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV2P189MB2164:EE_
x-ms-office365-filtering-correlation-id: 882ee917-6bae-4441-8a68-08ddad39dda9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rDSy3QygwMTn3SECHw1WJkyZbgux9MSm08kWe+Znyk/X9/zkj1dBEo8flKT2?=
 =?us-ascii?Q?w48NDKcTTvizfEbYCtfb6kGo9Na5R70AXbC0sZ0lyn4ZyoOcXwRrztsrIVlD?=
 =?us-ascii?Q?SqHHFBktD6GVTsn3NnhWuwUhlJH7JJ/Geh0lm7RTWBEgKuiqveMVN8TPXaKj?=
 =?us-ascii?Q?gUdFFhJnpMhvbSFsS1rEgAyeLmihZOqrX3rSs3J5l+K22mALXySGFYeBlzid?=
 =?us-ascii?Q?zt+k7U/QvmqGP6kDtM3Dz0RK0g6kQQXbEoL9hox9nIi/8G1yINr4MMikVAWf?=
 =?us-ascii?Q?b5sCwqX4pvfTmFjpxbX8H8izA6apI/FacbicKgVGXaPo5h8P3E+RrmGMf8IN?=
 =?us-ascii?Q?zyHmTiG0bqHhWWkHJreDp90Yw2CVrOQDsESi6w+zBpSY2VyIZhl9FSkV/xvu?=
 =?us-ascii?Q?dVC9nQIyHYe3l462WpTUJtYI0tT5MvEPeBz+UVKKblJllolanJcSXTfHqUQJ?=
 =?us-ascii?Q?jmRdc8zyLxCD+zeWEuDGArT075XeA0A9ugzrqCR4RRPIihhBvAqOMQLFYt0j?=
 =?us-ascii?Q?bMO5Nk7jk14vCUp2ng8vpXR8cF52rQCNToV8mt5jNYDKkt77MF+ag93RTCpV?=
 =?us-ascii?Q?9w31aXiRj08yFMh/yCgCzIjm9MDa61ckI5wGgiL6M6schB9XhMjzK+8p+7aj?=
 =?us-ascii?Q?v/sWVn6Q/A8c2WqAtza3T2Y4POJP+wzJA3sWnyKxZhawLQVEr9qIq6y2u7TN?=
 =?us-ascii?Q?H/qTTukjq9Spv5gxKM2jor5nnIzxSXQD27JeEsfBndGoKRCWBXRzZIP1guGL?=
 =?us-ascii?Q?GrYEuLbgGCl9lE4bn8xsI526O4eOq7U3u2cWgLkl9KB7CrXItNuwNjA3KChc?=
 =?us-ascii?Q?KnXXXZySf06mXtU7X2BlF3FLwODMBATXK8LZ4lgLGkNnhni6wfhvX7/KI7w0?=
 =?us-ascii?Q?0s1ZTtGi2PA4l0bkXkTixZt9/7Tqiy8xNbRhyQ/PVPA3J1EQt18a+rr4kHhl?=
 =?us-ascii?Q?oXJpBRrI3yX1E8mTViSD094S/Sxt+NcDD9NTxZc4Cyp0pnu8oZL43gRmEvxK?=
 =?us-ascii?Q?oHx7qCrTI4p+2eq6XEcGwGixawbH6CNWvVou9H5U4fs+N3DqfC90NSxV4oSh?=
 =?us-ascii?Q?9hJmPVlB7pIaZ+6+lLMUx9I5VTjbkGzHPpu0IcxuWTb9W+7/zo3smG9hDqck?=
 =?us-ascii?Q?lDnZflvuBET+DzoV7rt7c+XEdzVCiVrZfhOKq3kdNiiT+qloJM6oIUFMFlJd?=
 =?us-ascii?Q?08FvtjDw0Q2xiWisD04etBxdiMSoFh8N9KQs/fLMu6wiKSmoC0G4Ua+S2e02?=
 =?us-ascii?Q?7Ty98cG3RYkhRbyxIIPEdOz2wnwilO3WHtWWugD8nWpuKBQEy81fBy7Yl6HE?=
 =?us-ascii?Q?vrF2xIcRFdwbuhoJblNaNLE6KvcFoP6awEwIjMr36rqUv2M9H4YG4V/jGcFW?=
 =?us-ascii?Q?WmPb4vMmppsK9uFEKTTFqKD6BZOeFsCkNV0XkjMG4FLNSudXoxUnBo/iE4O4?=
 =?us-ascii?Q?n2UaJTpX/NCjS1ZDsaDqeIygAUPLg5CdmB/9hErb9Rr6BdgwvBTtyQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DmWxOWRfFAuoJM2ZpaDXfkp4jWq2bsok74/D0JZq4rsdK+QPmMpeX5FbNez8?=
 =?us-ascii?Q?3VpkJIpQ1m0G5UpnKF4f4Zof8xi2bwxZUjQNsY0dfQKXlz9/KGhL9XXHRPMU?=
 =?us-ascii?Q?XezxBKHb/h9bq8cJrbWlIbnPih3KWEE1OusMhlSP3RF6tkzY66h2OHv4AzPw?=
 =?us-ascii?Q?y+W0PilJKO3YIeAtbSobBmGTILEJpvpP2IB32/p6saIu3yltr2ME0mPja8ug?=
 =?us-ascii?Q?lKWAXYbn12dq+Yl05yJuHHoad5jFDjawkk3uL8d1NN2vzc2QV1MWS0VGW9X9?=
 =?us-ascii?Q?/Yscf7St26EB3VlplQZHlJGr51Jgj+cKCc5lIn+Wk6cxn+gPPEVDCJregU+2?=
 =?us-ascii?Q?FGWT0D1kSics89GUHM+BE2VY8mW6Gr7Q/3SZ5RPyXRdVXJXPF1HW6dlcRbV1?=
 =?us-ascii?Q?ZpzM3jWVTlY55JuVLkL7FJL6XXdFDyBypdU29qX+nEI8D6H2XaH/jVfzJlal?=
 =?us-ascii?Q?DD8noIe0nAqqQk016laDvrax1JVR9IoSuf4ho1jbn/7ELowqPwDhzPEvQPpW?=
 =?us-ascii?Q?J8MQZVJZ1ncAg5oQiT29sH6cZTgO8wRrE8hJ7mNlRklSkRlXIlCoL+jz/AuC?=
 =?us-ascii?Q?AD12DtT99bQXXJF7Jv0Oyp4pEUkZAWEp73sPWXLTiyIDikRO6pkvUeIyP586?=
 =?us-ascii?Q?eN2ULQk7oymO2mIg1j6+1oNVZVvLUJuEieTO9QvjDcnqG/3+hK/gOFQotPM+?=
 =?us-ascii?Q?wRjUfYu8jfvkuNb9fP1aoD8PWcp7yL/lm7PJssnECjJX4yciob7bQuVJHTbC?=
 =?us-ascii?Q?MOFjDLZ6dpWFziazAJlsH9PPc6JPLf/MDezQ1co12r/63+uP8HQw53afpQ5H?=
 =?us-ascii?Q?Jyc++21SDp5rnGXaDzHcRNe6xD2s2LJ5qU705zh3NyVWQIYDO4o5R1FT0oZT?=
 =?us-ascii?Q?sNi54gKd291cS5v+H2tX+hllsGbiHXi36tWqyuybtKu56CwWhVkN4oPKAI+D?=
 =?us-ascii?Q?MsdCSRq3qh7ho9XgU0Xv06hg4dWhd2bLmRGb9X1xYmcjDlyY9IPgRLe4YHtA?=
 =?us-ascii?Q?1LNNmbT98+lg/6UR4mNxBPi6FQsdAT78vSn6qpOldTyhf9aa6pdaSlsjPCsc?=
 =?us-ascii?Q?fR1ZgS/zsxWxNMlQei34yxGAlwX/W+UgdLLtPeoCcDg7RvIQFqh/Li7+WXm0?=
 =?us-ascii?Q?hgGak2O78cmiYQkr1clEdIPt6q9eTuFnf9N/cpHYcR5bmLuS9+f14f1spqV2?=
 =?us-ascii?Q?zrAtIZpE442MblQIlRicRZSqzASAXDciS24RMbdfWxMwoe04SJgmZgMhcpOe?=
 =?us-ascii?Q?D8tXBh8XAV1YetvhFnNnozKxte0wP8J2G8yeIKWpkqqLHAzg0UTfEz2KXX4a?=
 =?us-ascii?Q?zaUXLw2RkOQcuSuUW/aOzUhb/uSKBzMXNvjxymDNbTUJicrpZSwvCEkaIshk?=
 =?us-ascii?Q?0akqGw9uB2ee1dcVxkH6FBtaGhf0KviOHh1yfagIDfhsonUJ9Av7qfQnnuh1?=
 =?us-ascii?Q?bWMfjKmruVuWW/q/otLfFcO1/m3UYMmbqttCtHEl94kKQGjJ3Nnxekg0sxYh?=
 =?us-ascii?Q?AvDuyYTbYKeL6O2zzSRALtlt5euGMYErybn6srLPLVYPXhxZgMLkLv9iCbr5?=
 =?us-ascii?Q?MZilqKVBtZeWHtNQF7lhD4+fwsXb2FxNPmFPzT/w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 882ee917-6bae-4441-8a68-08ddad39dda9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 00:56:59.9738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daLF63bLdx1uFWmAexddCjx3Ku/Y+D++N+zpt9BwTxg957K/QiGybkhU7eE6NzL54SrQhyJFg11M7n+8eDeJBcUfeyLaediHsm4OEfenu4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2164

>Subject: [PATCH net] tipc: fix panic in tipc_udp_nl_dump_remoteip() using
>bearer as udp without check
Please rephrase the name of this patch and add version for each change.
Example for your next sending:
[PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip of etherne=
t bearer
>
>When TIPC_NL_UDP_GET_REMOTEIP cmd calls tipc_udp_nl_dump_remoteip()
>with media name set to a l2 name, kernel panics [1].
Remove above description because new patch name is descriptive enough.
>
>The reproduction steps:
>1. create a tun interface
>2. enable l2 bearer
>3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun
>
>the ub was in fact a struct dev.
>
>when bid !=3D 0 && skip_cnt !=3D 0, bearer_list[bid] may be NULL or other =
media
>when other thread changes it.
>
>fix this by checking media_id.
>
>[1]
>tipc: Started in network mode
>tipc: Node identity 8af312d38a21, cluster identity 4711
>tipc: Enabled bearer <eth:syz_tun>, priority 1
>Oops: general protection fault
>KASAN: null-ptr-deref in range
>CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
>Hardware name: QEMU Ubuntu 24.04 PC
>RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0
Please move this observation right after the reproduction steps.

>Fixes: 832629ca5c313 ("tipc: add UDP remoteip dump to netlink API")
>Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>
>---
Please add "v4: <the reason of version up>" here

Note: Please remove email domain ericsson.com of Jon and Richard because it=
 is not existing anymore.

