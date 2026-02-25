Return-Path: <netdev+bounces-260929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCLAKxj0nmmcYAQAu9opvQ
	(envelope-from <netdev+bounces-260929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A06197C66
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF96830B4D71
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548603B8D47;
	Wed, 25 Feb 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="YdeVd+HH"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021087.outbound.protection.outlook.com [40.107.130.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB163B52E3;
	Wed, 25 Feb 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024792; cv=fail; b=er0vuEnI18dZ/V9yY3bvlx6B9vaF+5WmW2yVWfM+dyzUGIHeHxQHgjFY99JLqj40iqx5VmY8nNUo5AKVIOp8XKFr6kV4QgpQ/RN10J7EntXIw4AUYgK3054VRMkJjvRibUSuJTdJG8JJoRyWB/pt/f6elFqrM1HkHyNEp123Pkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024792; c=relaxed/simple;
	bh=04JVquYBNkZ7ygE6EQiCD3B4ElZX1kA1LUgbpk/Ml3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHT68As4qwe1+hqYr0gXEkVhjO0oSJhKRHlI9PJiDmCOpyUBSkbaB6iV2b7bsybbcKhfaISCwzedQIQj3BIMxHSbIss1byombuK0DUecGqrQXb6/6KpN2b1atIyEjvdBFoTPSH6/9ibcc+88dK0sp4ZOKkMufourEpPtTLTXK4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=YdeVd+HH; arc=fail smtp.client-ip=40.107.130.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofVNQdfg49MOfKJMOSwSO6rqZuGN3QiRiLD/vUQ3lkO5IwxXAhI6nO5yjTN0TvyBLjqNSOqKDwLfoH2RcUzLs6szQq6jOpsnbRDbbUITAvu5uO/le2s/zOOfANoX1d7n12xPmwncfCNIca9SdCNDU1RFzC4T/gY4qjqcYejraTzTwMUkJPAyJHZYWL6cm9ByfDKNOMkjVBZSR0uNhSC5OZ0jh+Ak3Mkh+KeqLWxnRQ2t7JeJunmWUoXKI/QXmItyQf3LLErCIyhquahb1KmHaOrcol2iqplhpdgYbprlzqf23wux+hhFx5+wqCjCDQjL0EOVLLJxCx+KVxj+cBpVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OA4plB6epVaUbgfzNU0ObNJsDf2qB4Oi6on1Ts7/Fwk=;
 b=e6g/YkflIUJb1XRamWiR+unJJMwOxAXAdBE8tOGFT6IQiadGV9b2yqojkvGPh2T8HqsNvLw2J8HWZ2Mlm8yeWY1wbqFbI4zaY2fIU7KxQtDqDnBESwWadGIKdE9/mTzMOKmBz/T+VSsYW0L0oR4DsV+9WoLBhgHAsD/x594ajumzuJG10lvE5JPplYW+oOl7VnKStwDprxslMy72/gEx6TN3OwFAYilNF/spBhSyB4b1e9B4DgKLikjqG91k5A/bvJEMp4SgPQMr3XRnkvpAeroKDJm7WTsooVQlJ2LPae4XucV+ndtIba2e87pKaNE92EhESk6pxnVfcAUJQBjTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA4plB6epVaUbgfzNU0ObNJsDf2qB4Oi6on1Ts7/Fwk=;
 b=YdeVd+HH2zBPNI7tdGmj8CCcDS7apzfkEJffhw6tfnsUwLtUoiNGKGLx1wbaP7ThZAJGKdaSWe7jp90Xo/auWuzv1VpMhBFtLvvshlqUNaLVxpBgo0WlffX9XZxLrO3mWEAFu0u0Ho74Fh3bRqBQgXYQJYUVFXxB7f/lW4F3RaI=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by AM9P194MB1234.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 13:06:26 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 13:06:26 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Simon Horman <horms@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [net-next,v3] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Topic: [net-next,v3] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Index: AQHcpkGM69XnLH6qG0ifFNudt9qFx7WTWDy8
Date: Wed, 25 Feb 2026 13:06:26 +0000
Message-ID:
 <PR3P194MB1505D8407EC0DB476D6A1CD1EA75A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260224-net-next-mv88e6xxx-tcam-v3-1-dc18887d71f2@luminex.be>
 <20260225102528.177319-2-horms@kernel.org>
In-Reply-To: <20260225102528.177319-2-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|AM9P194MB1234:EE_
x-ms-office365-filtering-correlation-id: cb3bbec7-8a4d-475f-7d18-08de746eaf40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 ZIe2NnOv2G5Y6sm3aP7VGSKqkLcWW8+x35UhqTYFlz57JQxJCULjapkce7WiW0m1aLvcVHX21ul2TzsP5L0HC8MWjq+2q0Uwjwfnd4DJkdbkYaN2YTMzFU/uzcxj6wVgDO+oQilZdF2nPk/FjauRixs/xjVrP2cIEpqy8q4qJB8cRevQmx140P7VvCVvZRNXDkepy83e1vu6/9UVp+8/BQXi5kWX/hu5+tGNm4f50XuJzhcPgqbik//Lz+QV5eUQtsTgY8TVMuGofBzMAsXGT+cmGQZ0p9VDJa5388BHVLlMLGwEf7DS8OY+swMMG3sta+eU/nJ8S2bhf/Uyz/NgIUraQU75sylccd4hH0mptQowm3KpW1la80/On5bOKQ41tOw9zePHSM2PLLT84WmS/EbGa5/T1eT4q23S84eUIUPnewG66zKjakF61W3YOslTPBXneYd6fluZW5DPy878UBPk4rhXYZnUISahsU06sZjwZY4sUwKHGSJRmereBcL6QtK9QybT3Og9bCbwSt3Lyi5v2eibBznJxF40wbooVlnof65SMkA6/n9vCPKop2tYCCNNdyCyk0R3WO+EpN6b196h7ULBnqlnoMgj8J91EoHt7VDFwhDDTcrZTWYAPHdRX2oVaQYyOarUfzaG3SIbsuhMNU228h32n4AhHWqH+TGKzcpCoamsBbMTzQRLkeRrDqR0AEqGJC6v8qOItkUgz6NXMzQJB0mg1PefkHqYFR//mVwYF+dpW3xr8/JeyCObFEjmfOnBlzEIJNTzNlS2GrN3s8IgGzHTPMIgYJ/juzQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?R8wnMHRQTNfWSAjY3oiWAc2CXmcsDkblCkAr8IMSGFv4QpZgF5HEdAaFtE?=
 =?iso-8859-1?Q?lyGaaJy287uZ3ATVpRlESEE/VRr8WU/+OiMs8CiLhtk/aknXO1FPdoWWsq?=
 =?iso-8859-1?Q?PMa+iYrWvfo2MG6xndU7Z+Xer9jlAhnMqUU+wP+tXDfgHOwwijWOk4fxJl?=
 =?iso-8859-1?Q?tb69Zi6fDLyqTliahhYEDtoBodF1/WjkIh4FZDtIc0f5VxjUoJz8dt9JyZ?=
 =?iso-8859-1?Q?t41zgfY7b6vk6m/kca45ktlPMTtuvBvLGoVyEKT4+7ZfTFCr0oNDc2YrvK?=
 =?iso-8859-1?Q?ARDsvJmZky1+X3rdqUCgT15TeDf1h4CtPtsuw6qMFM645KLH8SvHsTCfCT?=
 =?iso-8859-1?Q?Sn7ExhyJ/lRuoLn0fIXH8WCxNH0k2Sx2Yt7iOn6JyNh/DWGJaiAtzx2PjY?=
 =?iso-8859-1?Q?LmqRDcFMBOjU/QAmHnMNOjQvk2Q0oi/kd/1gPjWAQ3HHjXAq3+Nf4zvTQk?=
 =?iso-8859-1?Q?l34UX60PjWxSRNkASg11z9xeK+PUDEunmTb7+sgSQYadBTuA5BRgo1suVd?=
 =?iso-8859-1?Q?JLpGQiQXk79MjzHyoK9Du9vO5QenPSTTSO6NBC5HMDl3BbLzqFi0Dfyu7H?=
 =?iso-8859-1?Q?uFBISK9q+YADYDKRW65RUQy/S+TO2Oo89q9ep44d70+J5TuEOyyPAzCHer?=
 =?iso-8859-1?Q?JG7ALsBqfoBnTqOXjFSru6oaUwfJcSQp+WdYrCwT/oW95cvxe9I+XSsSOv?=
 =?iso-8859-1?Q?0SEcrhIF+1Qy5V8tjkmZ+0n2doPY4iX7IHa2R3HmwJ24HcnFtltVNlbIiR?=
 =?iso-8859-1?Q?DXQKc81dOHUFZq3GARVNAgK+PV6Asy/iTwbNw0IxP9YY5iK6DSgyX0SRjW?=
 =?iso-8859-1?Q?Yae9nnMeo7NzibWLkcKkb2DfpK3pmh5k0Io3Zd/I3u2zdnH7+RFfvYj7sd?=
 =?iso-8859-1?Q?/7uAz5XrAr4e69dQc77N1QepyZd+BDpR7ohbzT/jCqCbqPp/eGzRYc+Fzl?=
 =?iso-8859-1?Q?4yuVMWBEpWaEWRJzRrc8h/+z45z4goWNDs7WtQpPHqQuVVqRhASaNDniMd?=
 =?iso-8859-1?Q?5wgTq9+BkTUHc93Tu9CZ0tJWtpxVeHFYYihjL31h3KDmyJWiKpFzG916TB?=
 =?iso-8859-1?Q?cg6FD6crVbyTKCsikU/vh/n6Abd1TC83gBIv1XtEX827vjrDqH80fGvhN5?=
 =?iso-8859-1?Q?poDJ0m0G+HyLk7eExUEzXZyb0QBJ9EtILZTs/W6oVCOunDqbYEuXVepDxP?=
 =?iso-8859-1?Q?XZe5e1KEhhOLiz2Nr7rk4rdzipLGIhqmLLYGiuatd4EhQ02816egtMcmCC?=
 =?iso-8859-1?Q?6hZY7B9LTHtaDS5ppkwW0bsaXJ/vRJ+uZLjpvYoCKBmk4BnuzuxlP22w33?=
 =?iso-8859-1?Q?0WyjzLssj5TS90OObAZf/MfaaR/K04aHJxvPjorII/2CpbtjMtpV9sot8U?=
 =?iso-8859-1?Q?qkGCnHlVUZISnf2yxVHU/Ddaocm+inzUq+AxiCNrvCkNBgWdTDAi5wMZRs?=
 =?iso-8859-1?Q?hDUPUDNitebp6RhZFv7Zxg/1g9KCPKbwAFBbmUT4Ndg1qziun8eEAT4UeG?=
 =?iso-8859-1?Q?ieyNDpk7bcNlLDCJSc+nS5CwqIouED2I2/0c/F7dWZIM4bFGpDf1IMsM3b?=
 =?iso-8859-1?Q?/aLUwsz4yrBuLF8klE/iGWj0oxSxDKeUtdJK/OC8RrL1Ghol5WIF5X3psO?=
 =?iso-8859-1?Q?+S0zymAtPM+E14kR/0J+v36i/Y4hRsJlYYbJFvU0m9DeZno/BqDdAjF5kO?=
 =?iso-8859-1?Q?YJNvOkwLhK+hT2aXDk2U5XvWpFClyEGAXVz1OnKCYiwKQO1/X8MQlM60tj?=
 =?iso-8859-1?Q?69Kma+L/z3rXYcxYqRFyJhIOcvFrxzoBcYqCmos+Zb1we/XbS/pkuq0TFD?=
 =?iso-8859-1?Q?1ShGmJqOYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3bbec7-8a4d-475f-7d18-08de746eaf40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 13:06:26.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrCuFx0zxU5o/KQd2Rn0hSMnukOWrdJ1kyJicH0bhYGjsPIjhRqcUmAnR+RV8pfcbgJsyAWznIscnD5Wi0/TuHR62qMCocEjtOeJ90oHPXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P194MB1234
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,vger.kernel.org,gmail.com,redhat.com,armlinux.org.uk,kernel.org,davemloft.net];
	TAGGED_FROM(0.00)[bounces-260929-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,luminex.be:dkim,PR3P194MB1505.EURP194.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 05A06197C66
X-Rspamd-Action: no action

Hi,=0A=
=0A=
>> diff --git a/drivers/net/dsa/mv88e6xxx/tcam.c b/drivers/net/dsa/mv88e6xx=
x/tcam.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..ed02c8798200=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/net/dsa/mv88e6xxx/tcam.c=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> +/* insert tcam entry in ordered list and move existing entries if neces=
sary */=0A=
>> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,=0A=
>> +                                    struct mv88e6xxx_tcam_entry *entry)=
=0A=
>> +{=0A=
>> +     struct mv88e6xxx_tcam_entry *elem;=0A=
>> +     struct list_head *hpos;=0A=
>> +     int err;=0A=
>> +=0A=
>> +     list_for_each_prev(hpos, &chip->tcam.entries) {=0A=
>> +             u8 move_idx;=0A=
>> +=0A=
>> +             elem =3D list_entry(hpos, struct mv88e6xxx_tcam_entry, lis=
t);=0A=
>> +             if (entry->prio >=3D elem->prio)=0A=
>> +                     break;=0A=
>> +=0A=
>> +             move_idx =3D elem->hw_idx + 1;=0A=
>> +=0A=
>> +             err =3D mv88e6xxx_tcam_flush_entry(chip, move_idx);=0A=
>> +             if (err)=0A=
>> +                     return err;=0A=
>> +=0A=
>> +             err =3D chip->info->ops->tcam_ops->entry_add(chip, elem,=
=0A=
>> +                                                        move_idx);=0A=
>> +             if (err)=0A=
>> +                     return err;=0A=
>> +=0A=
>> +             elem->hw_idx =3D move_idx;=0A=
>> +     }=0A=
>=0A=
>If entry_add() fails after some entries have already been moved to new=0A=
>hardware positions (with their hw_idx updated), doesn't the function=0A=
>return without rolling back those partial moves? The software list would=
=0A=
>then have some entries pointing to their new positions while the gap for=
=0A=
>the new entry is only partially created, leaving the TCAM in an=0A=
>inconsistent state for subsequent operations.=0A=
=0A=
I don't think this is an issue. For entries that are successfully moved the=
=0A=
hw_idx points to the new index. And for entries that haven't successfully=
=0A=
moved it's still pointing to the old index. Hence the hw_idx field for ever=
y=0A=
list entry should still point to the correct TCAM index. There will be a ga=
p=0A=
in the TCAM entries in the hardware, but that's not an issue.=0A=
If moving an existing entry returns an error. The rollback moving of entrie=
s=0A=
is as likely to return an error, and potentially leave the TCAM in an=0A=
inconsistent state.=0A=
=0A=
Thanks,=0A=
Cedric=0A=
=0A=
=0A=

