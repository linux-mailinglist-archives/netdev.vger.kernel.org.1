Return-Path: <netdev+bounces-161812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE732A2428F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253CE166E44
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C311F03ED;
	Fri, 31 Jan 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZIp9Rxo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFF1386C9
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348170; cv=fail; b=DDNhqMl58/QR56eBgCJG5vCOduGlhoDyHm6R6P5uow/TQzrSgbiJPSl/RLM38gdIib1DVUndPDcBNG2VRJkxXqHuNYEStCItOT4w2hmbdBFqb/pH9Im/zFYQWXFW0HBkVoM4k+SDJKZ0G8PqyshXztb1FRV8BBDmwjz0SV8pG44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348170; c=relaxed/simple;
	bh=CDbpm0z3MYWtBdP8DBh6nKbfszNKW5cl2fgd+g2dPPc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T1hnn7nYFcisreq5UGb7I3Qc2RKvOTbRc+uqGIQQ1LpKBr2bUowRAMvRsq6W6RMUPHXpsoRXBnyhOj92OWAY0TaAqNttoGMnLq6zVfnqa93QQL6WiFLgTknKcn8FaMdUGFFJ0gIBvczuShi9YksPnJpQW+WsAlF8JQhlLp+6UoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZIp9Rxo; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poXjXY2IQ613HgrpBXQE8lZnA33hUNW9hGVOrbAKrcos0tgYCxAlzPGHD3DDDaq96Wdm1gIu6zdvc5FkdleBXWy0sA+8fJlvccs+Xiw00qE8zXZc+VGjAplDwEGON7o1yNjQDgnZeg2Dd/hqMhr7sTd1+yg0DfG5LNnoPBM99d/uEPusYx8vnQyJQhTwwKPVUJvevLWtFalgDa/RTSkCymsQbvDzIYE7HQFtNz+IGIZdKEQobZ2uqFTtaEv3NtNEwoGiSkgKDCQXz/Q/P+nP/PlQv+ZpYIs1xVcqONZXPoEd4ymmq1g4BWK3Te7lOuuuZ9hxsfOPg66g7WZQnVivTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LVfJmjyQO9p538HwodPCLWiqJNrgL9ZlZCMew9Y6pw=;
 b=jmbQJSbD1T0Vul/7sbpZ/9J/1NJ8ZcwsdbImHAfCCWLvePf6MDolfCwzF4LFlWa8eqsfHF0xfSASTatJ7GwLqEsfJcTO6JjWZrXL0WonkHK8MywYLg82oQo7xfaDO1l74KGQhBXUg8oZMJpEfREICPvpLJkcB2kfvPUhcoAhXvq3rMdKQq9zChz34cz4ixDds/G6IOZnTZBiGL9UwlLOdK9kez6GIGNZXIALOoz36TLi685fpNheyYpTfRt4VYB5OWS4if4jePQra6Sn0JRzD7DHja7ISJ8bfvTBSA22vOIFhh59kn5uRH9c4EGvZGFaVhNGW+iu2ALrCqm2JCo0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LVfJmjyQO9p538HwodPCLWiqJNrgL9ZlZCMew9Y6pw=;
 b=aZIp9Rxo+nD8QbSQVS5HQWZdkuNzoNJEuHCWrAh4Kv6xXoilSwBkEofAkLkWc52wr6eQPrWztF92wTbnHXBw5d12DKlwb3BepDj4bK/SzWEC8VbCkPYnd6VW2IajmzFkysuTahYJ6yPEG5U0zY6fiHDdngjqLKk7bXdHhRIXzuSBZarntg+Mq9H3ur8nx9NKXbVTdWXfzCH8u57WetjEBbd3+hwSaW7ZfzznB/0Zw09ZNnaXwcMr4azvsUHcTFAwzKTmQ2/Xjr+OIcq0cRT4/j5m94zghJ690peVpVmXQoCrmN12vybt0hnjTNRYSM0n9hYAcjyv28mgAG3ooeqWYg==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 18:29:25 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8398.021; Fri, 31 Jan 2025
 18:29:23 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>
Subject: [PATCH RFC net-next] ptp: Add file permission checks on PHC chardevs
Thread-Topic: [PATCH RFC net-next] ptp: Add file permission checks on PHC
 chardevs
Thread-Index: AQHbdA1EJuE/lRTNsEilRWCfCR7oiw==
Date: Fri, 31 Jan 2025 18:29:23 +0000
Message-ID:
 <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|IA1PR12MB7493:EE_
x-ms-office365-filtering-correlation-id: 8a3b59b5-4293-4bfc-a03c-08dd42252f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?d5vGehDC+iU7Yjiho4swUS+oB9xrjRxA5XxB/mkEoxM5QllWtF52pjHdbp?=
 =?iso-8859-1?Q?rDdEbGmFEjAYHS08MmiYJel9dJA6NQkQYjkcLEaEsE1uxkaKLj6gVcPJpa?=
 =?iso-8859-1?Q?of8aufdm5r2H9GfKAh3IrNEC4OesY/sWmXZiAr69w0ICCdHmFSYZ3oE0P5?=
 =?iso-8859-1?Q?H0zBN7zHv+j4gjfjBaDKGJKSchZqErNf6xyqYRR1tz0LDzbOaucg+sU5IJ?=
 =?iso-8859-1?Q?qR/8T89IXrOcdpU7B+FBRJvgc5MLWJxaDv4rsFpyoa4u3s2sZpPln0/hq/?=
 =?iso-8859-1?Q?LTtUpCF0BgsupWsSrfu2VJhTSzLXA4HaFyEiMC3IgQMhHXtL7D+iVspfSk?=
 =?iso-8859-1?Q?VCMTpD0+5gbMZ0ZRJ8JlIdYAmdfJghleKDZLCBeDw08MtMWm4OoyKrvoPG?=
 =?iso-8859-1?Q?CXsfnYul6hpiecQ6Gr0IasaOM05mrwNzBHjR3bsjmaRLm92JG/7TXOxlg0?=
 =?iso-8859-1?Q?Hx8pzankksqP/xTUtgPqBMYFVxadWjFc6IhxnvI94RwT5tUJmBPReGy5a+?=
 =?iso-8859-1?Q?6BwAns6Y6Wi/ZjwZroLqnmx6xbCFqN3W2AddGfBYoiM2Ej9ZodWBSZGG9G?=
 =?iso-8859-1?Q?vFEJPf2erygZ6WG1DrYlUaERPPEVBHkFMyXGJbwUJzM8L8lfvMX6QnQ91W?=
 =?iso-8859-1?Q?08LLHReA55M39OhkOfJuJRkX+w0IIB4o5kTpnYGrJkcI28OCQKlqnNT6KM?=
 =?iso-8859-1?Q?1C9TAxKK3a7o88mkq+FYL9/MaFEf/J53hTDVxB5AFcA+jTZg4lHBmIesUj?=
 =?iso-8859-1?Q?q46CKTSWntt/9/LmBoGFJb/YE74NFGbstw//qomBTlbbb52QpE9hcoBR4m?=
 =?iso-8859-1?Q?AP/JKhhMPuFb8uaGrYJ0Y64nD+3U3q22qUbH4WxQV8zdJLRkZF7quFqTrV?=
 =?iso-8859-1?Q?x1FhFsArwYXqW1IrFHEyZteVW+DbZDudAhRu2BLRY3TPOPwjzcVd0f5erY?=
 =?iso-8859-1?Q?//VMKCD32xIAKnZ28CbA4Pa8XzbaEx7tMhE+el+DK7Bc1lfJme2IKL/ZDV?=
 =?iso-8859-1?Q?VonNHYgIKgr7MY+CIkBAXz9YBCA2+6eve7mvz4OaxrXaGivhP+L0TDPbbO?=
 =?iso-8859-1?Q?1BMvXcLHn7JL9YbOtdY2E9I0Q3h/EXKn2ZaQ/XIjWJhtygjREj/6IebI0R?=
 =?iso-8859-1?Q?C2sASAa9JVvnZgNm2HUGqnaaFWqqPOLqNJMylXthtk2N31SZAYgXe0jfve?=
 =?iso-8859-1?Q?+VZoQUOhITdit/zSJ3G+O5ddnbfG9u1x+dWO/uPhWJ6gTMe0Iat8hHDdhm?=
 =?iso-8859-1?Q?+mGXSQWx3Sh4HWImwkvqLnXrqk/EvzjDHZ935UMH+IWDLOCarVmzAVSDrB?=
 =?iso-8859-1?Q?oUHlDep4YRmaFkXB9vY9UdACFzzm659pxx4eUamElL1iHD3nS5M8WtfPsq?=
 =?iso-8859-1?Q?638KiW9Ec1ruk5uuICwSff2yXkaAbPO3VJCO5nIXUSDdJiOWiGwpIvCe2C?=
 =?iso-8859-1?Q?Z9VRBVxWrBNR2F5QMpFpmrbc/NsdNYdC7g6/McJqdkiYDBUHLcAKmq676i?=
 =?iso-8859-1?Q?pOXELiQm1xiVWzXcmlJewm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sobLv4Ad4e9egTMIPwS5KGiHMZyUcJZV9voSlcx0KcVpo5PlhCp9nYAPq+?=
 =?iso-8859-1?Q?pZ2vq4CZESgB8nmsQLEj9X2WoJO8gRmzFlB4NkK2mOOxQQyDD5VTxmPG0Q?=
 =?iso-8859-1?Q?43XTRNXeW3lXldggSf5AndF6kuRl808Uim39v0lT3kemvzKMWg5lcy3YG5?=
 =?iso-8859-1?Q?28GhvlMJyPN7FRJ/+0LoQ9WNJegoKefeUs9cr5Hu1AWsD8UtcqBFlc9c0U?=
 =?iso-8859-1?Q?bmuq8dm/ffwiv7up6QZnKXN4cpOEm+nhiSQQUabXy1bbeYWk/vh4o7VOPu?=
 =?iso-8859-1?Q?+FfkNPlBpRG7g1PTfD5Quh7pFz6idMTgkezjay3ZRTjxxyR2iO82WiNHci?=
 =?iso-8859-1?Q?VjdCuY3npLFOfvZtq0rMg6QHu4YBiwpIJ61Y4Ja7e8g9elS0ZxXGm1h6H7?=
 =?iso-8859-1?Q?NE+t32U+qzCta2rT+BdeTu2THryiOVvWA1cok5BQO/aNm5iqKNnya67vP4?=
 =?iso-8859-1?Q?hCcOiriygxJZbsWhsi2Kfi+bDrmCsva1BrXovVzerP1OwY2sDXflp/amhR?=
 =?iso-8859-1?Q?9Q60TOPXX7z8vMnXXTO06J445y+moHb1b7Rd3luQRCDNg1l4m3ck7dhzYw?=
 =?iso-8859-1?Q?xRjm/VLQBsXtn7F8xEsZrkGPTSjTHF6cYChfGm2cIM6rgt2q2LqNwaH/aH?=
 =?iso-8859-1?Q?84ORsHu2+J3k5LCNmfd+s08l5+dStZ6h6iOZoILbXwPeOl28koKaqHUV9L?=
 =?iso-8859-1?Q?9LvbZaOXQ7OEmmNwwUhg849Z8tIred9b2roTdvOWAREILgi6McNIlve9+A?=
 =?iso-8859-1?Q?rLFjiz1v1l7KGDVY4vDvhTjVd+8zZ880J2sPklbccZcmqYk96unzR/8Vvk?=
 =?iso-8859-1?Q?8FEAa+uzgwVc8t3S5/VJFxgQRWTRd7Bv0bZYgmbvq6R3kOLTkJPXpdiIje?=
 =?iso-8859-1?Q?f+GxQSOSsLnzew0U2zu5G1BYG104endjmywY7+4cjTOvPT7Ck5oG2+dIf6?=
 =?iso-8859-1?Q?BBxdT2bBVguzQUp4XEiv+9r+siO8IxD328BglasbBpcFJWELzo/J8fgWOo?=
 =?iso-8859-1?Q?bK47jSoaaOsTQuSgW4j2Zu/fvr1eIItxiAmDKu6jGrO5eg2xy20M006iBy?=
 =?iso-8859-1?Q?mU0PhS5stf/rNd1mosc4Sh9sWJ9uiJA/zDMB/1MuGxM9jKM7eQPMIY+rg0?=
 =?iso-8859-1?Q?XvYt2bFEk83u7mtU9g6caFtlSVrTT3RT5v0dlEbhgLsQY8+QOvi8k/fbz3?=
 =?iso-8859-1?Q?nwuty4Tq6o0RyRVGe0R5CwdS64HMy4UcD+t/3M1/8ocVjCgvMWW45uluV6?=
 =?iso-8859-1?Q?ff+8/pjSZH2SlADMT6WAzVrSSy6zMfV5G/Ywpg0e0kli15UCPfDdSblBt4?=
 =?iso-8859-1?Q?VKr1uE/ZySuj94tMwajPB1GnRYJMZbRm3an2mFdl1JBJbyvFWVjzN3TxxL?=
 =?iso-8859-1?Q?GuSOUCPJ76xlldDpRgvCpHNX4gnBq9qLS3yG1/aExyVMBOyW3nTl7MLnqE?=
 =?iso-8859-1?Q?ixtFHwULj4uRr7XcM0FtzmNnbJrqk8jj8J3PlgEE43stqiOWl5zuR8U7fB?=
 =?iso-8859-1?Q?yJMeURaOVh8UnkMP7qT3uc73hwBKQQ3AfOqixF2iJeqsirJPWSKTZz0lhm?=
 =?iso-8859-1?Q?aoo1ZKrCc7uqSqZEwxjenXqNWeOmDeakcsA+NzloPLfyv/EDJuJnO6TO1i?=
 =?iso-8859-1?Q?1Lq55t3SN7ygw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b59b5-4293-4bfc-a03c-08dd42252f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 18:29:23.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6jwrBZinBn4auWYbN2xNvMT/hS7/Vc7W3D2YzqK8I/vWwB/BvVSqpQB7ACXcAacIFB9rYuWq8ynCt8STr7dhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

Udev sets strict 600 permissions on /dev/ptp* devices, preventing=0A=
unprivileged users from accessing the time [1]. This patch enables=0A=
more granular permissions and allows readonly access to the PTP clocks.=0A=
=0A=
Add permission checking for ioctls which modify the state of device.=0A=
Notably, require WRITE for polling as it is only used for later reading=0A=
timestamps from the queue (there is no peek support). POSIX clock=0A=
operations (settime, adjtime) are checked in the POSIX layer.=0A=
=0A=
[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html=
=0A=
=0A=
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>=0A=
---=0A=
 drivers/ptp/ptp_chardev.c | 66 +++++++++++++++++++++++++++++++++++----=0A=
 drivers/ptp/ptp_private.h |  5 +++=0A=
 2 files changed, 65 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c=0A=
index bf6468c56419..5e6f404b9282 100644=0A=
--- a/drivers/ptp/ptp_chardev.c=0A=
+++ b/drivers/ptp/ptp_chardev.c=0A=
@@ -108,15 +108,22 @@ int ptp_open(struct posix_clock_context *pccontext, f=
mode_t fmode)=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *queue;=0A=
 	char debugfsname[32];=0A=
 	unsigned long flags;=0A=
 =0A=
+	ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);=0A=
+	if (!ctxdata)=0A=
+		return -EINVAL;=0A=
 	queue =3D kzalloc(sizeof(*queue), GFP_KERNEL);=0A=
-	if (!queue)=0A=
+	if (!queue) {=0A=
+		kfree(ctxdata);=0A=
 		return -EINVAL;=0A=
+	}=0A=
 	queue->mask =3D bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);=0A=
 	if (!queue->mask) {=0A=
+		kfree(ctxdata);=0A=
 		kfree(queue);=0A=
 		return -EINVAL;=0A=
 	}=0A=
@@ -125,7 +132,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmo=
de_t fmode)=0A=
 	spin_lock_irqsave(&ptp->tsevqs_lock, flags);=0A=
 	list_add_tail(&queue->qlist, &ptp->tsevqs);=0A=
 	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);=0A=
-	pccontext->private_clkdata =3D queue;=0A=
+	ctxdata->queue =3D queue;=0A=
+	ctxdata->fmode =3D fmode;=0A=
+	pccontext->private_clkdata =3D ctxdata;=0A=
 =0A=
 	/* Debugfs contents */=0A=
 	sprintf(debugfsname, "0x%p", queue);=0A=
@@ -142,7 +151,8 @@ int ptp_open(struct posix_clock_context *pccontext, fmo=
de_t fmode)=0A=
 =0A=
 int ptp_release(struct posix_clock_context *pccontext)=0A=
 {=0A=
-	struct timestamp_event_queue *queue =3D pccontext->private_clkdata;=0A=
+	struct ptp_private_ctxdata *ctxdata =3D pccontext->private_clkdata;=0A=
+	struct timestamp_event_queue *queue =3D ctxdata->queue;=0A=
 	unsigned long flags;=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
@@ -154,6 +164,7 @@ int ptp_release(struct posix_clock_context *pccontext)=
=0A=
 	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);=0A=
 	bitmap_free(queue->mask);=0A=
 	kfree(queue);=0A=
+	kfree(ctxdata);=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -167,6 +178,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, u=
nsigned int cmd,=0A=
 	struct system_device_crosststamp xtstamp;=0A=
 	struct ptp_clock_info *ops =3D ptp->info;=0A=
 	struct ptp_sys_offset *sysoff =3D NULL;=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *tsevq;=0A=
 	struct ptp_system_timestamp sts;=0A=
 	struct ptp_clock_request req;=0A=
@@ -180,7 +192,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, u=
nsigned int cmd,=0A=
 	if (in_compat_syscall() && cmd !=3D PTP_ENABLE_PPS && cmd !=3D PTP_ENABLE=
_PPS2)=0A=
 		arg =3D (unsigned long)compat_ptr(arg);=0A=
 =0A=
-	tsevq =3D pccontext->private_clkdata;=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	tsevq =3D ctxdata->queue;=0A=
 =0A=
 	switch (cmd) {=0A=
 =0A=
@@ -205,6 +218,11 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_EXTTS_REQUEST:=0A=
 	case PTP_EXTTS_REQUEST2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
+=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (copy_from_user(&req.extts, (void __user *)arg,=0A=
@@ -246,6 +264,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_PEROUT_REQUEST:=0A=
 	case PTP_PEROUT_REQUEST2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (copy_from_user(&req.perout, (void __user *)arg,=0A=
@@ -314,6 +336,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_ENABLE_PPS:=0A=
 	case PTP_ENABLE_PPS2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		memset(&req, 0, sizeof(req));=0A=
 =0A=
 		if (!capable(CAP_SYS_TIME))=0A=
@@ -456,6 +482,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, =
unsigned int cmd,=0A=
 =0A=
 	case PTP_PIN_SETFUNC:=0A=
 	case PTP_PIN_SETFUNC2:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {=0A=
 			err =3D -EFAULT;=0A=
 			break;=0A=
@@ -485,10 +515,18 @@ long ptp_ioctl(struct posix_clock_context *pccontext,=
 unsigned int cmd,=0A=
 		break;=0A=
 =0A=
 	case PTP_MASK_CLEAR_ALL:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);=0A=
 		break;=0A=
 =0A=
 	case PTP_MASK_EN_SINGLE:=0A=
+		if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+			err =3D -EACCES;=0A=
+			break;=0A=
+		}=0A=
 		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {=0A=
 			err =3D -EFAULT;=0A=
 			break;=0A=
@@ -516,9 +554,15 @@ __poll_t ptp_poll(struct posix_clock_context *pccontex=
t, struct file *fp,=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *queue;=0A=
 =0A=
-	queue =3D pccontext->private_clkdata;=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	if (!ctxdata)=0A=
+		return EPOLLERR;=0A=
+	if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0)=0A=
+		return EACCES;=0A=
+	queue =3D ctxdata->queue;=0A=
 	if (!queue)=0A=
 		return EPOLLERR;=0A=
 =0A=
@@ -534,13 +578,23 @@ ssize_t ptp_read(struct posix_clock_context *pccontex=
t, uint rdflags,=0A=
 {=0A=
 	struct ptp_clock *ptp =3D=0A=
 		container_of(pccontext->clk, struct ptp_clock, clock);=0A=
+	struct ptp_private_ctxdata *ctxdata;=0A=
 	struct timestamp_event_queue *queue;=0A=
 	struct ptp_extts_event *event;=0A=
 	unsigned long flags;=0A=
 	size_t qcnt, i;=0A=
 	int result;=0A=
 =0A=
-	queue =3D pccontext->private_clkdata;=0A=
+	ctxdata =3D pccontext->private_clkdata;=0A=
+	if (!ctxdata) {=0A=
+		result =3D -EINVAL;=0A=
+		goto exit;=0A=
+	}=0A=
+	if ((ctxdata->fmode & FMODE_WRITE) =3D=3D 0) {=0A=
+		result =3D -EACCES;=0A=
+		goto exit;=0A=
+	}=0A=
+	queue =3D ctxdata->queue;=0A=
 	if (!queue) {=0A=
 		result =3D -EINVAL;=0A=
 		goto exit;=0A=
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h=0A=
index 18934e28469e..fb4fa5c8c1c7 100644=0A=
--- a/drivers/ptp/ptp_private.h=0A=
+++ b/drivers/ptp/ptp_private.h=0A=
@@ -64,6 +64,11 @@ struct ptp_clock {=0A=
 	struct dentry *debugfs_root;=0A=
 };=0A=
 =0A=
+struct ptp_private_ctxdata {=0A=
+	struct timestamp_event_queue *queue;=0A=
+	fmode_t fmode;=0A=
+};=0A=
+=0A=
 #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)=0A=
 #define cc_to_vclock(d) container_of((d), struct ptp_vclock, cc)=0A=
 #define dw_to_vclock(d) container_of((d), struct ptp_vclock, refresh_work)=
=0A=
-- =0A=
2.43.0=0A=
=0A=

