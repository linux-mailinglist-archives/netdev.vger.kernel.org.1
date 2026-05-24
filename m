Return-Path: <netdev+bounces-291152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ0bK+epEmr92QYAu9opvQ
	(envelope-from <netdev+bounces-291152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2C5C19C6
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA420300EF66
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879435A38C;
	Sun, 24 May 2026 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBnHYaxV"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6522E3E9
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607997; cv=fail; b=CzEpj16/BBw1WwYCZ3HKbZrxuQjYlyhqqNYz5PktSLTjcgiRI9ZyFvwkb/74jxDz+CQ65VihqlX6qWtZRoZHwxUKRBTWVih9wvduX/0MRulduS9Mbov2h4Ub+OIaOFr6EZ75dXSwFeWZHtoKKxZQNMRJKDiZY+5DL3AIUWAfiRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607997; c=relaxed/simple;
	bh=SZYCsDLekMkQUu0Fj/+VnDQ9dhv5dqSK0Kfg6BAWLHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=atBz/hpi+AI2gPI8tmpHEJwxDwEyvlZgsnWJcOzu1ybpkB6O85rS+wPeYdg2vtOyAXdopXzIyOM+931ofOJIn7KA8hBsry9Xrm5QEOAFoVZ6Ig6JFctuJeSZKYMGsAAQdvwx+U6x2FEA1qWPoa2cQft+Er5CrJa4jqM9K0dZp3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBnHYaxV; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak64sEww4eIVgcUc1ujZV0wf9wO5L/xhzXhFtmotbkfUnWMvFwdKTwbkNfZccTKrhbmxrUjvWUrvRMjWZscaXXVfT7VmAM/iBGAXFcju5a9Q/d5qHvF8fn3+1ylmIQZa2e8044EzmG8ay3ETTLkTPQo9zrX/cm+wiapA4FIb1ovnjJcC2VIiD+N/1l6kPfNI9QqBXaVg1+ufIV/2WW5GZVkWyYZz4GDia+Sl1u5c8ayV2BtRn4N5I3KfT4oz7sov+wlaeOwprrx1Xvvmjr0TYwwdaDLxO9GScKjHiy6lhN+mRE/5SUCdyV+1VDBo98uBCNg/QQeAc9bgITd8IXbjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZYCsDLekMkQUu0Fj/+VnDQ9dhv5dqSK0Kfg6BAWLHw=;
 b=hlPCJnkwM9CWK6Nu0llVyPTydsfEsi9m4nOUkq25LYfHxNWGwSOxM4+VtBGICrHlLg9SNmry4njGfubhJT7fq+gHNqkKK0j1l7fYRD71fV/GHtrieK7e4rwLn2nUCq6oTdTjulX6GMDiG/hw+oVrOlBk7aGYEvf2uQ1otE8peRaoAV4OUtquygtWGQCcRF5ozy0+fhwH0aqCIgUXD13of21GA5oMibqJ44d2fVDkoqBl5+lSofKVehSZv3HqA+z14wY1iVjmcQ3sNT8C7ERvtCs9VFxEY2bSrXLomC2yhWxfxNh9gtpH+ZxblMKpNc7dtDFL3h87UlNSJEONzfjg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZYCsDLekMkQUu0Fj/+VnDQ9dhv5dqSK0Kfg6BAWLHw=;
 b=LBnHYaxVROBGXJX+/c0byEJ6IFgyqeK2Kea2WWUZhsmNPBvVwGlxMmnUJ64BbYeS8oBZdlilaqNQZuaUDTWjVXS4pwUdjTbEnn60ECPvu+vmkUH95uK3kdiKkoy6Q2etOeakP2er9giYA3iRo1ylMY3Qh6Bvi8hfXW0O6gK0y9k5hIIBzEtL7PLe9DfBDs9TMcg5CG9/GLfy/u7U+JjMSkQq2Y/akJ9qRYk8cjFonAgw3K8yki7tAWRw+HrVIaw7VkQ57MYpuHXJ19+FE6tHZt+s5nzS0byU/3ERDB3D000J8estOVfcCvHU8hTMbltSBuyMKlqSL/cFMHVlxHY77A==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 07:33:11 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%3]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 07:33:11 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH net 4/9] ethtool: module: check fw_flash_in_progress under
 rtnl_lock
Thread-Topic: [PATCH net 4/9] ethtool: module: check fw_flash_in_progress
 under rtnl_lock
Thread-Index: AQHc6kCb1DqQYWNj1Em+IuTPr2EKurYcyerg
Date: Sun, 24 May 2026 07:33:11 +0000
Message-ID:
 <DM6PR12MB4516677FDCC64DDBCBB3D290D80D2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-5-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-5-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|CH3PR12MB7641:EE_
x-ms-office365-filtering-correlation-id: 143c20e4-f984-4250-49c6-08deb966b569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 YDcZfeFNycpApgD5izzBgxLA3DfZr0eLBW7pwwxiXoQsCwfKingRhX3bWT5w6x//xtEv9my5EfVA04//9eCbv/v899PERyN2pHGR5xAjQn0+bTD0uRhAY9fvXMFaF4nKgo/GqJHwylso+VqsjxKbBhhtrR6+h3QoWDrogp9RWXi1dPXuyToMw3lBtaCFSWBAJWYto69PBFgPOnosFhnl5w2vsLvZsdiLhQ85D+QNriKfgewLw0xc0yV1v0IRCmK0fbrx9spTanGTka7R0pYkOnV7kftFDv2Jl1qkzrPYarjh5zXumpK/fsvUgY+ZZckygYSlcHsqqiPJPp4vMdktXXXa6zdk/02Akku6anTSqm1bz7vSW3mZPOKM0NkOc+5tgvmbCfqp5JVAP5LfAhzllYuun4Rj9Gb97cJ6R1bkL0llZdnhc7rAl+3d4CoN/7+BmcklDioArNT6LJNkcKdB4JFB8dmg2Ni01aEI3AdRhdk/adQyidC5ZWwxBDLcTzNMHNiSzJjm7yE6076yQ1LKTNWpmErfoNy+jAxFeUz+rg6QStKGjUdTH9BEn93XcG5EBv5PL/d7OoDOQ7QghupTwuRrmv62bD3EMJOC2MSDJsh2luJpQu6myLwFZ4gzPvRv+FHFHXIsBHJ7YLCqb10GGG/4aHTeXUAqS/8JZy8KaAlK9jfXhfc1od0MZ4WCFkh2x6HoxQBqNfchrvSlWfFRdee89lIwIjcVv2s3mxu22t9QkOkBvMZDImNPUg4zZgLx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkZPZGM5RDFmR3RnWU8wRTBWK3REWEY3ZXZDYlhmSzU1bk5SZnJiczhLVUQv?=
 =?utf-8?B?bUE5V1JvdVhDcGwvRXhZb0hnQ3lmaWpyVzF0YXdTUzNJMFk0ZTVVR1BTR0h6?=
 =?utf-8?B?RmpOV1ZGY3dGUGtOeWZFS0NKeU84cC9URDNHam5GbGZ1eWljTW1OSkx2S1pI?=
 =?utf-8?B?cklnbDBtK3dVMEcyckgwS3h4RGl5cFVuQUdaeEE2bGQ2U0Y4Y0M4NytLM0s3?=
 =?utf-8?B?OGZUMFNTZURyUXJGdEc1MXZTSGVDUDRsVkpUUWcvejlvY2lsOWZtWjNQV2lp?=
 =?utf-8?B?VGtZZXU1YzV4SExNU200YWtqdEVXSkphQmR1KzM2QTdFSTFCUVdVVmp1M01W?=
 =?utf-8?B?M0w1dUpHbWFtVXAvY1pWWkdmMFBWbGlOa2FyWlFzR3p1M1ViZ0xpRHFoZ3ZH?=
 =?utf-8?B?TzI4Y2Y3RDdqemhFRHNSaVBPSGh4dXJ6UVQvTUx4bzVCdkpYM0MzL2JkZGxz?=
 =?utf-8?B?dnJkNlZubGE4SGdwMTB4cExwT3VRWGdHRG9RL2xnU0VDTStXT0czM3BkVXBD?=
 =?utf-8?B?YkxMRzhiZlIyL1dyak45Q0UzVHpyamFVYk1jL3UyMHRLSXdvMVdPOWo4c291?=
 =?utf-8?B?RFRMY1IxVk1maVR5YnpxRjVtZVV6Q0JtR1JHS3dZNTZBT1g5eDZsYWRSM01O?=
 =?utf-8?B?bU0ySFBNUUg2MU1Fc2NIbndRbXV4b3ZjS3ZhL09yZVM5L2M5UllwSEVxMW1E?=
 =?utf-8?B?QTRhanNiMGoxSUJ2K3plRnIvTDhWQzFtY0lEQUlxSjZJUXQvSHBjRnNwYy8x?=
 =?utf-8?B?akdIQmZuVEZoREdOR3dFc2ZYL1N0Ry9yRDdYMHIyaDN3WEVZWTRodTBqNFFG?=
 =?utf-8?B?TjU0VUY1eld4SEo0Zm8xOTFCb1ovNzljTXVZekNWSTZ3cDYrNTl3dFEwRlFC?=
 =?utf-8?B?Vk0weHR0MWI3TWN1N3dtR1NCTFEvQUhjRURaUW4rRU5lSGQrMFZzdGI4WWs5?=
 =?utf-8?B?WkN1TjFVQUZ3dUFTSmJiZ2RuQ2lNd1N5aE5WRW1QZlBFUXBja2xjcGJvVDRN?=
 =?utf-8?B?UWsvdFMvY3hpZzhNSnFpWjBUdkUzUnNxUVpTRXByUmRkTW1vMDFXWjhBZmtr?=
 =?utf-8?B?enB3SEZxeDVxdGc0ZWxzeFNoZVMzQnkxZDRjb3UwWU9SWVlIZ25xempFN3VL?=
 =?utf-8?B?Z3g2cng1QldCdHl4RmlFRDFJenN4aWFkVzM1bFI3L1dJSlFvSFBzcGJkc1Nr?=
 =?utf-8?B?N1hiU3FHM0tYNVRQV2dINmI5Uk9VZVdNcjBSS2hoZWNKenpYalpGVERDcTlU?=
 =?utf-8?B?Skp2U2s3eGYzRTJZVHo5RWswZVVnQzBRMmdpNDZhNllia2VzdGRGekhDM1pV?=
 =?utf-8?B?TTA5OGR2Wms2M3U4WkFKNm9JdmJrMUFsYXp6a1FXRUpTUXhpVEdxTFFtOWVp?=
 =?utf-8?B?NFZnOVVVWVNGWG00bUtSVTB4WitQSWdCQmt2ZUdVMFQ0ZE0wRllla2tVUVdC?=
 =?utf-8?B?bXZic0EybTQvcC9nVDhoQTNSeVo2VnRSNGJIb2J6V1ZDWUtkb1doQTg2ZEFE?=
 =?utf-8?B?VlNDdWRDbFNzWnZhdWZqRVc4SVY1VUN3d0tZUWR4aGFqdXl4QTk1WHptWG1z?=
 =?utf-8?B?SnF0M3EzWDFaR2tNaEhhUHM1TEJzTDQwRURXTWkrU1FKbGtzUEwxaVRTMXgx?=
 =?utf-8?B?c2lFNzlRQU9yTzBGc3BTSE9DcmFjWG1Ua1RjckFnVjdya1gwb2RVdStjZ3J1?=
 =?utf-8?B?cTlQSnpKMUlvYitiVFo3UTZNYzBJV2UzMi9ya01hWnhkSWkxZy9EOUwrTmhF?=
 =?utf-8?B?aU1SOFJhd2ZqWWQzQ0dZbEVjNzY0aVBJK210aHRBeGsreHRHODhwb0Q1VzJN?=
 =?utf-8?B?c1NzRjNhMUtGcy9OMG5OUlIyNkpJK0REZ2ErdUNDdG4xKys4ZERVQm1WY2VD?=
 =?utf-8?B?d3c5ZTFweDRNRkJwbUM5bU1qNmlaK1NlSXBOcGFmdGVYRzNFQ05qRDM5UmM3?=
 =?utf-8?B?T1dIdk1ndFlsQk1NcFlscU1MSldvdDdFckdWdUVFdDI1SzlYOFdFZ000ZWpH?=
 =?utf-8?B?djRhVDhzTXM0RmFVNDQwYTN2RUJkT1NSeWc0ckl5U2RXSkwvR0Q2dXVVRk9B?=
 =?utf-8?B?WXprZDBrQmIrem9kRUdCVmxNanZyZXlUMTFXZW9EM2xEOUZmViszL3FmWDUv?=
 =?utf-8?B?Ynh6dkQ3NXZkQ1VxZW5EZ0s0bnhHeVBLVFdiUGEvTW5HVUlvQVdZcGcwU0E3?=
 =?utf-8?B?MTlOZW1OQ3pyMzU1RytHS3ZTWmZNODViMnZ5MXpYT2oxTStaRVNjSUpNbWdl?=
 =?utf-8?B?L2ZmaFRYMXhSZU51NTNTZ3FwR0lIcnI0ZG1HaU1laEd6TE5WZk94YmxUOUE5?=
 =?utf-8?Q?J0htiGc4tW/kfdPHiT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c20e4-f984-4250-49c6-08deb966b569
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 07:33:11.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5+g3/oBWRKOondo0INjmFK3zPOq6ILAR+EUoq/w0rLKLf9dPfjesj54ouoMcWsA3Y2jLINxuNhEjMBZDwiK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291152-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.023];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM6PR12MB4516.namprd12.prod.outlook.com:mid,pengutronix.de:email,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 18A2C5C19C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMjMgTWF5IDIwMjYgMjoxMw0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgaG9ybXNAa2VybmVsLm9yZzsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+Ow0KPiBQZXRyIE1hY2hhdGEgPHBl
dHJtQG52aWRpYS5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsgSWRvIFNjaGltbWVsDQo+
IDxpZG9zY2hAbnZpZGlhLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBh
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDQvOV0gZXRodG9vbDogbW9kdWxl
OiBjaGVjayBmd19mbGFzaF9pbl9wcm9ncmVzcyB1bmRlcg0KPiBydG5sX2xvY2sNCj4gDQo+IGV0
aG5sX3NldF9tb2R1bGVfdmFsaWRhdGUoKSBpbnNwZWN0cyBtb2R1bGVfZndfZmxhc2hfaW5fcHJv
Z3Jlc3MgYnV0DQo+IHZhbGlkYXRlIGlzIG1lYW50IGZvciBfaW5wdXRfIHZhbGlkYXRpb24sIG5v
dCBzdGF0ZSB2YWxpZGF0aW9uLg0KPiBydG5sX2xvY2sgaXMgbm90IGhlbGQsIHlldC4gTW92ZSB0
aGUgY2hlY2sgaW50byBldGhubF9zZXRfbW9kdWxlKCkuDQo+IA0KPiBGaXhlczogMzJiNGM4YjUz
ZWU3ICgiZXRodG9vbDogQWRkIGFiaWxpdHkgdG8gZmxhc2ggdHJhbnNjZWl2ZXIgbW9kdWxlcycN
Cj4gZmlybXdhcmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gQ0M6IGFuZHJld0BsdW5uLmNoDQo+IENDOiBwZXRybUBudmlkaWEu
Y29tDQo+IENDOiBkYW5pZWxsZXJAbnZpZGlhLmNvbQ0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo=

