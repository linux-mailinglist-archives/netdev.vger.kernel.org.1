Return-Path: <netdev+bounces-140174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF179B569C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E891C20B3C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4E2076DE;
	Tue, 29 Oct 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="lHJZmlku";
	dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b="p4O2D9KI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000e8d01.pphosted.com (mx0b-000e8d01.pphosted.com [148.163.143.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE6201007;
	Tue, 29 Oct 2024 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243710; cv=fail; b=ZXsSZc5fWc1ieBOzFVaIx6zWYh+OVYZvV2xpffbqpbGstI0f17jvT/z3FFM+UEhsxXz9EZv0qTZXghP2dtZ9tlXXbSNLNRgez3czMnzNHDQRS0rD6n5ynt5YUhGj+cxLxk+3Nas6aBlT46x7avuBshH4p3tMvzKHjdnmYm5i434=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243710; c=relaxed/simple;
	bh=L3pb9CKMjgcdVZFdA3i9uQh6yfiR/h9KIdko3d3RnH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A+t/IHKTFBq6ofkqAxhteuyMMFpe/BYF1mDt0t6Xx0tdzla8C5INvK1LKq0Yc8mR66+NmkHMgIT/PpeD4kP8zJ/c8wTs1wnZxkSHdQ/tvB93GKZlk3v0hg3kX3M2GFvrayhCNsvKV6N5120n4Lw3hrWdWeTr51KN9u58yYPvgh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com; spf=pass smtp.mailfrom=selinc.com; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=lHJZmlku; dkim=pass (2048-bit key) header.d=selinc.com header.i=@selinc.com header.b=p4O2D9KI; arc=fail smtp.client-ip=148.163.143.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=selinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=selinc.com
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
	by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TKTCqw005595;
	Tue, 29 Oct 2024 15:51:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=sel1; bh=rFOe0
	Lv8+IZQa6vXuIsWlcN5gefln7bB2bY1XdkRpVM=; b=lHJZmlkueA7qxAyRbyfvR
	0APkkFD0Tqu7ykD6aPcHgr3jAOhjq+5md8hQF0PA5F9bt2/CBinoHQ3DKs9fxzvA
	DGXSS8KrzIm2m4plUYXaZYisDuZ5u7g877iASUn7mAYHOPYpPCFxp49pj9v+kSZs
	+u++mMfcYwcRDPKULOfiJ/rufZYqUy8Lc2Y+Sygrr/RH8Rcu2hcCsDDzj1QoOrXM
	YhhWNHh7F0TbUhn6vKq9CHGFx6X7jYunhxZq6hRXESMxCY95SwIaeQOeTxxnmtke
	DVK5sj79qNu6j6PD2x6VAeZvQ1rTFDZ1ZU24ZqwBrgZgoorl05r0T1xKQZL1XclT
	w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 42jxpy0gh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSG6nZTrZ2KU8+qkZTDlHFB5wnwie8xJPXBsRvi1HLqYjkG1E7aLMHTtyDAAD5B0EF2YEuXRktapkzzWU/RF/ntUqcNv7tlUfxn8HH5VL8L4ZuMKD3IfXEhsyHqFVgwaqXJOLQP9gTdT2m7+w11og/A05KYlG52J5qqpEkUgwc9/P0zPBfzhXTnDL02EpAWgvnxPmkFXFwAr3NHx8cOtTYgCExgAU2dDHJeVw/7U/RPbIQGWRIAuOLprqE7+2Bz9ZEnJqfUhZFee4/S69DYTN/98BiR19iAWpLWAXnn9iRqglXfe9wHadKHqKU4YKIZcQpB1uMFuhcX7n9IhOQS0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFOe0Lv8+IZQa6vXuIsWlcN5gefln7bB2bY1XdkRpVM=;
 b=xj+MjGNImQ7b1v6fq++yJGwRBwobXvfvf9P4BPLq+gLQeKBjH0gXg3arYC+8sw/c6SmCYawLk6rMT3AUBnxtV45MyBxOYgTTl+G1nKhj3JTMivqBbTndF5OXr/l9hhubOptZ2nwUjDwcymaSnkd2+RVN+BUuSD7Oih43lvxZeUIyviMToZMcrdChXiz+QHggGok+5i722T/SbDqbkx/7gaU4Qnrc3zmieZC9PRqClQHjD7Vjfd78tKGJxlmabNddqCdmS3dCI6EC6QxEkN0ITg8eV2bIkisdtZuP6ZsXQ7WEbN5NHySh4m0SudyMZDgZsDdGRfgvNnjcRNi53OE0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFOe0Lv8+IZQa6vXuIsWlcN5gefln7bB2bY1XdkRpVM=;
 b=p4O2D9KIZ8KmB8UgO0x2i1v/d0bdWPgifyOtDbqj3xsPwiYkC5XlHX6WzS20XS+R7BM5At4Hf8xEEpvj7dcPd3m/F7J2WAJem4g0MAt49gdMuE9cD5jct4wcxibiOV75/LX0EKbxeKhOi8xpQb01/vqOCL8gnLaR2xQb3UwuVxpuMRSgeUgyS86C6kLfliHg2n4em+MK/yEMDKW4thotEupvrYnb8cpD+lR76251rctkJANVLRbQA2Jl0fJWWif2w5jitY1rEuu5Vl8GM+evCy5rsUfy+3LPRZWWTtS1L4Qgjr60/d3P3ngatunmA2sxPtsajZ+nYb5JAjvVd3ujNg==
Received: from PH0PR22MB3809.namprd22.prod.outlook.com (2603:10b6:510:297::9)
 by SJ0PR22MB3922.namprd22.prod.outlook.com (2603:10b6:a03:4e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:51:47 +0000
Received: from PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731]) by PH0PR22MB3809.namprd22.prod.outlook.com
 ([fe80::dc78:5b2b:2e12:8731%3]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 22:51:46 +0000
From: Robert Joslyn <Robert_Joslyn@selinc.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lee@kernel.org"
	<lee@kernel.org>
Subject: Re: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Topic: [RFC PATCH 2/2] net: selpcimac: Add driver for SEL PCIe network
 adapter
Thread-Index: AQHbKYm0/z4P1lQS/k6ewHCARnYgRLKd8gKAgABcA7w=
Date: Tue, 29 Oct 2024 22:51:46 +0000
Message-ID:
 <PH0PR22MB3809723DDAE5431A0723B911E54B2@PH0PR22MB3809.namprd22.prod.outlook.com>
References: <20241028223509.935-1-robert_joslyn@selinc.com>
	<20241028223509.935-3-robert_joslyn@selinc.com>
 <20241029174939.1f7306df@fedora.home>
In-Reply-To: <20241029174939.1f7306df@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3809:EE_|SJ0PR22MB3922:EE_
x-ms-office365-filtering-correlation-id: cfb8e591-65f5-4bee-9055-08dcf86c446c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7aL3DGMInduFyGpgVaSrs+l4Vd4wr784I5mUjqISxEZU/19M4RQj1YHRDE?=
 =?iso-8859-1?Q?l2hwWp4oXSDdvUmV6LNmD3b8UB8AYAyZ3AZoWE1ccstb1VPWfinX41rVCw?=
 =?iso-8859-1?Q?en18ZJmsuqaN/zYlqlbh9HRghzYoJnv8Vgnixxp567dxGawSGyi+6iF4Pw?=
 =?iso-8859-1?Q?5sfJsHuEg3SAd/BJPuvzaGcwbAygOWidHEhtpG5lxbM0BfiJP8j2O1Kzln?=
 =?iso-8859-1?Q?A9GhzuPCUPGIARBscOVLkOWKVGVVISs9tLtwLaCdT7Ba5je3Bx1RMnSGP1?=
 =?iso-8859-1?Q?tcbepOZs3FkvZxSyg3l8PcebfI53o5aodDNoH/8yDUGA7fSU4H9P/3i0fd?=
 =?iso-8859-1?Q?dOXNdK6ZFJMvU6BsP8IvJjaZpfNxL8aAzg9xwOPitGNYrawRuYEmSAmEQT?=
 =?iso-8859-1?Q?XsVsPMS8lBD7L7kIeO2fnrKWLAr7Lf+yod2NTK515/OYYBbxt8ABMLCACU?=
 =?iso-8859-1?Q?FLKIxaDmwBJg2CRW6YM1/wplWd7HK/4deHv7CcukZWEUFVgI2eY9r791uI?=
 =?iso-8859-1?Q?vo3oHIwiZA+/H0bi1qe+icREFNbvEvce6rKxm7YbdLZxE13FYkzrqXuuAG?=
 =?iso-8859-1?Q?jaUtyBVqoitNydqOj1BpB4T8/8WAZfJHQmW19vcHr7c8hFUR/uUkj/b1Lb?=
 =?iso-8859-1?Q?tDaCdF/3BNx3Ahn8aTimgjkQLhZapdezsvtrV3u/ry/6ircMZXjwC5fbp4?=
 =?iso-8859-1?Q?Nqz/oZB0kwsgylZSf3Z2xXdbDWQBf5eGOST3BLYoZwTPtEk511OnsmG4tT?=
 =?iso-8859-1?Q?0sDaIRCMgqSKaGadkqHNKm1Pz38PrHG4V1vkrQYoJ7xyJDtRbDJfx2aNTZ?=
 =?iso-8859-1?Q?c6T8tjbPqh2xPju5RvR+f7RljotKkOaM/nDK+jYIKBz04YPZOvox8snbYl?=
 =?iso-8859-1?Q?+ont02hHjRYgnkcFlUuQUfABU3tTAR+OGXuKt7cf6MWbcEeEbjL5VL8Xw4?=
 =?iso-8859-1?Q?lAeeLLemICQhT5Z4Yve0NRiJTwJWbqTB6eMe6p71QwyCfEmHxlfEKVxdU9?=
 =?iso-8859-1?Q?XgPVF01gMdcuGakDzxoMdSCBlnzbRmBPKDgno19bW6XoumqvzPiD3o2Skg?=
 =?iso-8859-1?Q?HSIfwFX0xbe+ixP/tmR+c30PiUNL5kFbHgQO2JfO8VAsn+fGY3jN3RAXn4?=
 =?iso-8859-1?Q?7ThasTRRL25BKi+PuruZoj/3ahhydzmXBoY+Y50IJY7ygQrDWhzlHrhqGu?=
 =?iso-8859-1?Q?DsB4471sCYlW77P0AHGFYQdl2rhj5Q5oGXPQ4au+kCVTr2UBj18xPcV+yE?=
 =?iso-8859-1?Q?kt5FAVI2jdNr+JS2Uf1wl/eijYzXv4esd+nMdAOQ4wXRSi4YpjRYKckQ2G?=
 =?iso-8859-1?Q?hxKqx10lz8rBM7H3PwyZ3IGaWP25qtAXzhFZW2+iTu1vXQ7rqcnt42A91r?=
 =?iso-8859-1?Q?sdwYieHxrep9ob0xENsWH+90pVimQUi5s7nlgZJ7nMB8okYf3u5oI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3809.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fiv0xKRyCDHltgSmy7rbTI9ItBYoAM+pvK1mnj5qOeJwPMvvB5eHp6ePet?=
 =?iso-8859-1?Q?9pJj2aGtgmPQTXRIpe95uJ2LGYP9XqeGF39nAo0+n/F13TAoZTYgNoep/W?=
 =?iso-8859-1?Q?fdTbAJXNjvM0neY2soj/inTzeXPgZOMnpxsxPbiQSx1J96FFiVlkUOHYaY?=
 =?iso-8859-1?Q?7HdKx0J8Efz1gGnSJX5y97hr3shbzN3K6zj2toxYRCpoCONGxCyNVFXDPx?=
 =?iso-8859-1?Q?cglRX2Hev5IqBBNSouywvU/ivHAYNSxWcIk9VPXlKb0knSz/71cL5lkJp8?=
 =?iso-8859-1?Q?6PENJo9YdPmYClroB93eXRA/YcV4MRUxLIDsAt6VVbdE9u8G1+Lr+siUk1?=
 =?iso-8859-1?Q?IpzGvKj3bFtbbnnDJY6J7NN0XkgDaRuRh6cqyuwWewX8m5iQ8sWqaZTBZ+?=
 =?iso-8859-1?Q?tAVHUURKpVPAVBjHBR2dq1qUoEKc4HIZC9koc0/qOO5g5xzL/Q6CjYmO5N?=
 =?iso-8859-1?Q?0VLqoedjfx777OqocMXpE4k/rsR9BTVj0m/7h50sNTQIFtDy/RFSN8w6JP?=
 =?iso-8859-1?Q?OSAKa16IuE6mkZkA/0XcUawOnliqJF/Oriuz1wlwvGdrWml+RSsx+h3l1T?=
 =?iso-8859-1?Q?upRfNoxnwv+A3yNJhU5yFJv28etTBUBx2yWC8XiJbrfDc7wI44lxy1c351?=
 =?iso-8859-1?Q?qWr6cbdsa027m5zwLGUCszwATrQGQygth8z50YGIOvO9iOeqTLMMcFHsjZ?=
 =?iso-8859-1?Q?jVthoBbtNDTwtoltQiOngkCJBhZZ7tw4xvlTNSCjvHn3BEGIKyCD1dBTPL?=
 =?iso-8859-1?Q?8ASB3POGYE/FC4nA/nsbrLiViRGQIzEiHj5AXnhvK8B+gslmZbvnetTsXP?=
 =?iso-8859-1?Q?i0Q6jhdXWOuLrRWrvqcyg7u+s/4kX+bcO1FL7r7p+Z+ksJ1mWppMAzBUQ7?=
 =?iso-8859-1?Q?Ci4J3wIosmBcMFhAYs13IScoXV8tXs9Ku753j9Ed+A5XmEONVed5n9UgrK?=
 =?iso-8859-1?Q?7iVVkTlSxglk7p6ygdGyBZjFpZEf4buqb2lCkGju/3aq7nzzsXNnRO2FBu?=
 =?iso-8859-1?Q?FrYvjdxJ3nB1rURQ9BCk3Vr7AynkTSFuXPsoVfsIpdW1odIIah0LFnpQKO?=
 =?iso-8859-1?Q?0Wrcjsw1Ip53Dfv6wV7F83u5Aiq6QR1Y71NL8GJEnOiUEWfmkkIb8Wvgyb?=
 =?iso-8859-1?Q?hvZ6jtnaP1XYVie7WVRRrem43yZ/48kfzO/l67vf7uLS9XKgrLHwoNtHog?=
 =?iso-8859-1?Q?0Ail7sO+5Eb04AJZwB+itfTjLppjwlN+ViU/CpT+PcUzfsqdynHwuHm1Gv?=
 =?iso-8859-1?Q?E/OrijOVyBhXm+8e1RilNXF4eiyEk4LeBUn1xRHEGw8sTfSzHGrNvKagrm?=
 =?iso-8859-1?Q?HQGddNB+P3hj78X/SI3mCCwnkLEnp0KqyndRQwXnqCA6Q2g5autXdCeSPn?=
 =?iso-8859-1?Q?tGcOl3nPVprpNapLFC8S6kmt9KAYokDetVUIH2vvY7PmTUGlyGhBjZOZay?=
 =?iso-8859-1?Q?d+oCd1p7Os5bCLCZvVUlj+TupihikWIW5EbDmvWgNAqBc9zSkX2D1OG7gi?=
 =?iso-8859-1?Q?NCdnWB4dJ2JbKjB2ZtStwwrg2GpKuJJ0c3iDyuhcQJ7LBJ6LCuC2APX8Ve?=
 =?iso-8859-1?Q?3JUQv43rQvXV75OrxU0747rsMoFiBOPlwNwB9PYw9iFDwK9wu/Wu8Sd3by?=
 =?iso-8859-1?Q?/eJaf+8KQLwxAYZzIomSrWW8N4Ok//fKbh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3809.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb8e591-65f5-4bee-9055-08dcf86c446c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 22:51:46.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrexQWL9G1o+KBV9VMEDioNueaQ23mzIann6SQQwi3MX5OFw2vOspnBTmD2gXRA2HJ/NKyWHY1wtQp9sKIMeEO5DPxuvZ7J3No2S/nLcO0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB3922
X-Proofpoint-ORIG-GUID: caGCztDvwS5VgHpzOxoEeX0HWIN8rG-6
X-Proofpoint-GUID: caGCztDvwS5VgHpzOxoEeX0HWIN8rG-6
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=443 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290173

> On Mon, 28 Oct 2024 15:35:08 -0700=0A=
> Robert Joslyn <robert_joslyn@selinc.com> wrote:=0A=
>=0A=
> > Add support for SEL FPGA based network adapters. The network device is=
=0A=
> > implemented as an FPGA IP core and enumerated by the selpvmf driver.=0A=
> > This is used on multiple devices, including:=0A=
> >  - SEL-3350 mainboard=0A=
> >  - SEL-3390E4 card=0A=
> >  - SEL-3390T card=0A=
>=0A=
> Make sure that you get the right people as recipients for this=0A=
> patchset. You would need at least the net maintainers, make sure to use=
=0A=
> the scripts/get_maintainers.pl tool to know who to send the patch to.=0A=
=0A=
Thanks for pointing out that script, I'll use it next time.=0A=
=0A=
> I haven't reviewed the code itself as this is a biiiiig patch, I=0A=
> suggest you try to split it into more digestable patches, focusing on=0A=
> individual aspects of the driver.=0A=
=0A=
I'll work on splitting the patch up.=0A=
=0A=
> One thing is the PHY support as you mention in the cover-letter, in the=
=0A=
> current state this driver re-implements PHY drivers from what I=0A=
> understand. You definitely need to use the kernel infra for PHY=0A=
> handling.=0A=
>=0A=
> As it seems this driver also re-implements SFP entirely, I suggest you=0A=
> look into phylink [1]. This will help you supporting the PHYs and SFPs.=
=0A=
> You can take a look at the mvneta.c and mvpp2 drivers for examples.=0A=
>=0A=
> Make sure you handle the mdio bus control using the dedicated framework=
=0A=
> (see mii_bus et al.).=0A=
=0A=
Yes, the driver does it's own internal PHY handling for the 4 different PHY=
s we use. SFPs are also all done within this driver.=0A=
=0A=
> I'd be happy to give you more reviews, but this would be a more=0A=
> manageable task with smaller patches :)=0A=
>=0A=
>Best regards,=0A=
>=0A=
>Maxime=0A=
=0A=
Any review you can provide would be appreciated, but probably more useful a=
fter I rework this to use phylib and phylink. Then hopefully it's easier to=
 review with smaller patches and using normal kernel frameworks rather than=
 our custom ones.=0A=
=0A=
Thanks for the help!=0A=
=0A=
Robert=0A=

