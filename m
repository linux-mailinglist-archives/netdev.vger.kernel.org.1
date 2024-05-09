Return-Path: <netdev+bounces-95024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43778C141E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1368B1C21CE2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBD1C29C;
	Thu,  9 May 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FjhUzYnt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nmc+5sqp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75528F7A;
	Thu,  9 May 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275883; cv=fail; b=lAooU6FrkS3Hp2sKbv/SciKjRJ/2E0gGgf3Lbs87/v0W1MeNHWs2f3S0QncMgN9cQPIX+g7efyKtstAxPLlpg0pW+bZYiUcgc2bVpCKesw8+YoPu+EqaGgM4GP7PemG+/XQD210rf4A7uEqB123NriPMJ8jGH9SQI1bzTdW5Xao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275883; c=relaxed/simple;
	bh=QFkt4rwyPlveIgwLuqbLUBwErEbRUDbgTi0Q92rLysU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ni2JAgjt9eHQ5k7NmwVpBpEhVempm7WdbEuE6wMcz6vLvadJ6RZ5VobbGWusyX0CPafQnkiUfaU2HRT2jE5mcXXwxs0dpHcbkc1LOsQ+28qWdmw24NzTS9xWsYv+jUTqIwTJij01SgPcRSdKmfeIT2ccmWXlUSMAL32EgCwqyfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FjhUzYnt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nmc+5sqp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449HHdsB012182;
	Thu, 9 May 2024 17:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eBQ+KR4/jGBBXmmeJ7abrn1MaGEownTQNsGxaZzqGEM=;
 b=FjhUzYntmgZfDGwYQoazpVwYVxUz6It9uv9v3vSRWna+kADAaDdB1xbAYbyyyek0OkVI
 wzbxvyRhBrG5U+wx/pr6ODdEZF0hGItLxPqC70ssP6Bdd/Zf/Ar8p1E0rrwVtHD/0efa
 wieD0o/C/ujIXHosCQAqYW0IheBbg6xAbMKuF2OB8nl2Nhiw5JVK9EbpfIOLiQDTfOI2
 L/O1LibV6kHZ7mPCM3iUwzsc3lg2BWQAsp6CL6LSWbDOSfFwQQX8aetVBpRgHwSEKBzR
 42SwYUFzVXVYuwD3O+d6D3yqi09Cp1+8aqXN915Gq9OyZ5WdsH7PTSWbY3RE40HGixrW qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y12re01sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 17:31:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449H6qCl019732;
	Thu, 9 May 2024 17:31:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfng2ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 17:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMxbr0+ZwnMHQzjesuLx2iBNyrcwRRXwRhWZenC6NxGmFqyma6Wup2UDxs5014gg2CbVI99v7S6dF9/ihWctOyi3yW8L1GomzT46vmkMUya0gCD/otnM2i/oiy3t0gmpEwfaYHl2DJdn+RG/ZE7JowJx8Wk9NdtrtdxSEdz/+S73PrskOXShU2qy+ZWAzW11k1Kj64iZy7uqkrhNptTQC9l5Mp+UZ2vB0G0ZudtO8AlPQFjI8NWth4ysoI9x+qxCE70Ph5/AhrR+BPiSHpJF3bxF7IPZmRumVXqmfGj6YxR6L6r4RWjUZSqFGvpAmJCdoEXWRPu+EiIVl5GV3R3ocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBQ+KR4/jGBBXmmeJ7abrn1MaGEownTQNsGxaZzqGEM=;
 b=MoT6UD7AK3zQQo9bgoSAjjaguCxDnpLIUakCcvTIFbNdqKPV254gzlBEXzIctAYPDvm+G6eaP0ISsPnE9WQT1tzuZk96sFt56m3oY3FM8EXj3ssnYwTuQoW3XReKIHcdqUusDlhxny7j4tU7w+NooR92KSUCEkx17AWMXjK9kZidPshANzXybDWh9YDECnxG69wAFSmLJRBRK87d4eo9XE2xM4YI9JTxqr0msawDQb8nSwIRqzW5C+QzZjs9s94aziCWdvSjyGtZk+aQ3EVulSZE20mbQnPZY7qY5Vs+ocp6eFF118PEzzmVzr+K7oTaqHhG9MuuoOdZ5NSc4VYccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBQ+KR4/jGBBXmmeJ7abrn1MaGEownTQNsGxaZzqGEM=;
 b=Nmc+5sqp21OozQ9jlIoCSg9mGF1mbyZNGH/lWvwMIZrhdmY7kD6GrkJ5GfdGGxRXwdyhp5bOeMFB6W3ZGcp1byF0+1OiJ7lti2WyxSEwxP8UibZhV0XqHrQGZHGabJorxzCe7+Ktk6vI1erfxCraFFP+IGaZw7imsNak6blCPaI=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 SA1PR10MB6470.namprd10.prod.outlook.com (2603:10b6:806:29f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Thu, 9 May 2024 17:31:14 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::a504:4492:b606:77c2]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::a504:4492:b606:77c2%7]) with mapi id 15.20.7519.031; Thu, 9 May 2024
 17:31:14 +0000
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
To: Yuan Fang <yf768672249@gmail.com>,
        "edumazet@google.com"
	<edumazet@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [External] : [PATCH 2/2] tcp/ipv6: fix get_tcp6_sock() output
 error info
Thread-Topic: [External] : [PATCH 2/2] tcp/ipv6: fix get_tcp6_sock() output
 error info
Thread-Index: AQHaocuNArB2XHtmZ0qxLxhD80x5UbGPKZQA
Date: Thu, 9 May 2024 17:31:14 +0000
Message-ID: 
 <DS0PR10MB60561686BF54FB94E98AFCC38FE62@DS0PR10MB6056.namprd10.prod.outlook.com>
References: <20240509044323.247606-1-yf768672249@gmail.com>
 <20240509044323.247606-2-yf768672249@gmail.com>
In-Reply-To: <20240509044323.247606-2-yf768672249@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR10MB6056:EE_|SA1PR10MB6470:EE_
x-ms-office365-filtering-correlation-id: f2828e20-46be-4ee8-1f08-08dc704dd36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?CzBCL3eexnc65so79mLdhLa/7TY5S60Fb5V63vSRI3xaF86SHBt9rxZ89e7W?=
 =?us-ascii?Q?hnEAJZgk0dL0BD9wfzFdFM0WvLpem/b/TDE3eQdBwIVpaYm9bwCRji30Do1g?=
 =?us-ascii?Q?O+mEzyZ5mUN/Dp80MYI5fA0kBLdXpGXDl4jgNkMDm5w6SH47+bi1jI5S/ykm?=
 =?us-ascii?Q?h72GPJ9yMPwRYjg+NiyE4354mVBMDMu/x1ty/pSucK8ncJBXISWfxLCeUQ+i?=
 =?us-ascii?Q?1vo/YFg8coB2J6BZTXOqZUCAxfaf5gVS8lbLSeGw40RhbdloO8mEdsbIe5GY?=
 =?us-ascii?Q?ydB+DIHEOxSkLeXilOE3P8VZzDzc+xCL0FPGvYy9BCZLBqbQW3oCGADyaVpZ?=
 =?us-ascii?Q?kyzVzjAdU9tCNyagBTE3qB0XmYzZIoEznKDdp8WsqPDl4UiKILKpFFxV67/3?=
 =?us-ascii?Q?A9KxzykslN3eztlPLJCGM5mZkV9fNJyPSr1qHfMtWn4gH6qoPNiB0DXFG2Rg?=
 =?us-ascii?Q?tl7nYxKaX5FWfzz2pqjS8y5fBJNSAea+SSNnFDnoxdN4C1WXZIMAor9120xt?=
 =?us-ascii?Q?vKTW9+BiCx7pxLKiVeM27UEO35n0eaiykJro7+cf6SvXfFnp3TQp46ZBFZNC?=
 =?us-ascii?Q?ey9pBwuzK4HH/jGw7LJs5XpoR0n/i4ktqrKaVJb4FgeWmSByDcWT9xyBgnmt?=
 =?us-ascii?Q?O1ioihlulgnB/KN8mANPuSjX+cFBrQgZZ0UOKX4+EFc7Vp2kdZYj7oQvTQWB?=
 =?us-ascii?Q?IR40lBW263MwTytOQYxz1mbwTnQpljzjB5xm1qOvTqvuPiPnFTmlqezbQvwv?=
 =?us-ascii?Q?3zX5qAI/RRW7Xgu0/Sflj86R7lTbQQ6mA2r4bsLXFprLulZ4mzYKh6NWoAIe?=
 =?us-ascii?Q?aGPTXyDl6E7h1I/3rc/G42+yhgzSKv+J0/vD3iDI9ElLkiG7AJXt2aaS9POn?=
 =?us-ascii?Q?4IZKROy3c7l4E4C1/v84yOufh70+7vacSloN3jhWXdqseyApCEr8vBQmrGvO?=
 =?us-ascii?Q?7towEWHl7kDb3MwMBnL6e5WYMaS9p8sUzD/S4T//QsqNwoG3VC0s2K0/Jhpj?=
 =?us-ascii?Q?Px3AFVpShyCYNSgNTRkiLH3Q25Y6GBl/bF0tIto7gUX2Wl8904btyfaULgLQ?=
 =?us-ascii?Q?kWTnaTeetSnpb+BzBxATE4EIsOlhx3NHZAWXjGwxvUsRc5yXUXZ3qRIeMMY3?=
 =?us-ascii?Q?9m0RuGZhra7l1T52ChdRGA2MoEwiW8x8ZVvM9ybu5VN6J7kCbKacBKy+/TNd?=
 =?us-ascii?Q?Ql7gLaqX/cwBHjM5qZU/BxehnZso0+qatI7DoZhHrpDfJwYTWOowGclt5+VV?=
 =?us-ascii?Q?lQ4h3FgQhMoNLQHH6zLnp9opEQ5Io/EZo+2PTYZjpkHzkS+knvENs7bQsF1J?=
 =?us-ascii?Q?EBGZhxSGmbAFUoX9IKEuNeXUDsx1n8H6/j6MWoK8fDnxaQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?uN+5Gvlj+EPqrcYFxc235IAwg8ibX95Ts/G3xxNXcipjZxnr+f9YqxA1Zt3D?=
 =?us-ascii?Q?DKsQ91Z3jOLegEpicr6fST7fPq3m7ifZL38T1sDTikqPyxMHVC4Bcz1+Rlj6?=
 =?us-ascii?Q?1ruLIhuHwDTH6yqwLIC7UwMjdiYz6dE7HBWqfXnF0MDH+SqCIKttA1F+Wp4a?=
 =?us-ascii?Q?C/j5WrwRIfeQiCiSWwZRo8yAn3z2eeFLZQN40hVam2h9T6ovNtsyHSEFEt4r?=
 =?us-ascii?Q?+Z3L8gXmUbXrMFDQNMb7D8OETDOa0veb/+46+L63XID3U0DS83kQxHlu9J6h?=
 =?us-ascii?Q?rLGtkh4Z73ypys8S/8dUbljD+PMf0NKLuV2BfjGJs7iLFzQs8JiVA8BlKXZh?=
 =?us-ascii?Q?1XvsnEzLSPoWlV/0s2PYC9jETLOb63e1S/6/Jc3JI5t1Aaj0sBfAhJaP+dTU?=
 =?us-ascii?Q?HSXqFad6PrCL01NaV8dBgFSoKERZx8LVzE/yokYLavaEwauLY29k8PL4JTQR?=
 =?us-ascii?Q?jees/1rva31CrKjZIFIJRaLa5FkBUc08axgaxf76IUEC+PFGRSzZPMgUgBH0?=
 =?us-ascii?Q?NvQ8CeVzetWiVBetVg4ycbpC1XYKAp0gfTAru29k2Nd0AWRfDY54p5xLCjRY?=
 =?us-ascii?Q?KpTRM5b+xTkTIYRqwRLKbWviZqJy3mauHQUZ0e4uEVOVG44Mg5xw/gcsx/9y?=
 =?us-ascii?Q?wsHez1kZ+chF7Dm9FsJ0GDIb1SBWbtg0Cnf/pv9AU9zii2RlCBMKcl3d6WRF?=
 =?us-ascii?Q?EYTtAUYb95XZNOR/cim1pPwb1BvdruXZwBbM9DRUkR4dhPspMkt3jvzSWCjL?=
 =?us-ascii?Q?AVznSbtqQJk3FihsPVKyyD/uTM0Zw7OEfnrs2Td8/4p3m10cf7RfP3xCth3y?=
 =?us-ascii?Q?dZzD2VpZkRZ8hBjiX58LAogQLzxYEje8o4YGAQacu85km9a3Y6nWuK49fvfx?=
 =?us-ascii?Q?IJe/pVdX1sEm1geOUq8nrxxT28pfkcbx4z+Hs6xalvzOsMefw6dPRz0t6ldI?=
 =?us-ascii?Q?zgPkMDZZeiJk/eXsW96YhUZgGf3c831njo1a0GyURMaAJ01z1RdXQsEp2H2e?=
 =?us-ascii?Q?FfyZaKBt2pzpmrrif5ceaVtP5os5Rg5vbpjlsuAKC5USsM/MtePr548HBvvx?=
 =?us-ascii?Q?8Y13UHgCuRIAIlyEfrgNm0JnnEBZtUTJSraZZqQ6Q7N3n1K/HkAcQJk+uAs/?=
 =?us-ascii?Q?Lj/WUifDWAkScTpGJiSUuclfE3zZKj4GusT7LUPbPJGUDoAvSsbdn+hxn9rq?=
 =?us-ascii?Q?jaeDmICWtdJ4/+ICEthnCgAlOQ4eLN+sArOCXgrLDkfBF73nvZHb/M8i/6ER?=
 =?us-ascii?Q?glpIa4ETNpt6Rvu0LH5I+hOujl41adcaPhfQFvp4Fll0p/QoF8gAXknpmtUe?=
 =?us-ascii?Q?urlkcB4NxMTAD9otDMRkMNaORzmyzeMHTwTwCbv68Gwg9G/4nWWg2o/QrPmC?=
 =?us-ascii?Q?geoBfm15hmjKyb3hphY8Rhm8uPEW5VUJaU/MYX7H9J/+aWk7e8l1Snppq8Xq?=
 =?us-ascii?Q?D4kb6ZKRSfM4GQ7RpV5dz3ST15waHPPfsJSjQj1O0tQHkmIwOAyDq6jbDMO0?=
 =?us-ascii?Q?GEEzFJOKdW3bs1A7PYixwfRuUE2ZgyS//CqE2sW5jy3NB7qQD8yCSWtUz86k?=
 =?us-ascii?Q?uLtf65cJgRcIJ4Rq9LLWFlpo+izTCkyw4a5pD9OULhMEnD57imR3wx6NO9VE?=
 =?us-ascii?Q?Ic7cvtSO8Anw3DQLGnioSH0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jbCMqbwM/UC9mfGnsT+N413Bcd/tC9St5b+gPJN/0BEReMO/qzfPNiZmz8k05BDbWC6pIMUACJJ+V4JeJpd2jU4SRBCyL8p3r5EkRZ8yq23vRO4491cjGut15zYZxVSaxsPB5A089FHotDqKGAJxPtAOSeNJOT1L/FyHBXWCvFCagYyfD7Q4R5ybEl8mdiY1hgVfQC2YjHzLxxsMCN+Fdo/0BzdX85BfsxGR59J68FYmWwsmhsruQ0SSCfu1gb8bIUErMb8SWq6bC5EbSrAmxMYHAnxOA3QbATf8YNTOLHbL9yhZAmEIV4KM2b15+6koH08YbT7xN4DWNi4rve98AcV1ihvCrdVpzQAS/LQQaWwYpJSumizsLBeI/rbQ/BSL9trU25t742jLIU74nIjBC+psEJBWnZfDl7AbMMU5izkceo1N4dQcqtIiMb7sbF3gj0YNUeej9H4sS4dU9VD2P/v6DYVFKatzVcGRlquJ9wuQa/seoZTgPLi/MKPObKpKkog47WRWaxNHOQAtxjX7Nsi8KIP7xJv7F+SiGB22G0dmrhxX9yETGF7cwsUyzgWZaLWi0p++llaT/eAr0YMbNO0KocWBF+ytz/4A7egfPIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2828e20-46be-4ee8-1f08-08dc704dd36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 17:31:14.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOx/rkyOVzaWyfMXxQJ8OyXaN6hp92+aYNNUtMJWuCCHTYtLAuTlfC5nQYXEYf3Oel/LjHVUwlp11DPEmLFET7+n7VsnlGLUpiqesBcP1+sGvDUg48bA7NbC5ux+bOMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_09,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090120
X-Proofpoint-ORIG-GUID: TOvrMdE26jv32j8cAMkGw5zEgHr8H4V5
X-Proofpoint-GUID: TOvrMdE26jv32j8cAMkGw5zEgHr8H4V5

LGTM.

Reviewed-by : Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com=
>

-----Original Message-----
From: Yuan Fang <yf768672249@gmail.com>=20
Sent: 09 May 2024 10:13
To: edumazet@google.com
Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Yuan Fang <yf768672249@gmail.com>
Subject: [External] : [PATCH 2/2] tcp/ipv6: fix get_tcp6_sock() output erro=
r info

Using the netstat command, the Send-Q is always 0 in TCP_LISTEN.
Modify tx_queue to the value of sk->sk_max_ack_backlog.

Signed-off-by: Yuan Fang <yf768672249@gmail.com>
---
 net/ipv6/tcp_ipv6.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c index 3f4cba49e9ee..=
07ea1be13151 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2177,7 +2177,7 @@ static void get_tcp6_sock(struct seq_file *seq, struc=
t sock *sp, int i)
 	const struct tcp_sock *tp =3D tcp_sk(sp);
 	const struct inet_connection_sock *icsk =3D inet_csk(sp);
 	const struct fastopen_queue *fastopenq =3D &icsk->icsk_accept_queue.fasto=
penq;
-	int rx_queue;
+	int rx_queue, tx_queue;
 	int state;
=20
 	dest  =3D &sp->sk_v6_daddr;
@@ -2202,14 +2202,17 @@ static void get_tcp6_sock(struct seq_file *seq, str=
uct sock *sp, int i)
 	}
=20
 	state =3D inet_sk_state_load(sp);
-	if (state =3D=3D TCP_LISTEN)
+	if (state =3D=3D TCP_LISTEN) {
 		rx_queue =3D READ_ONCE(sp->sk_ack_backlog);
-	else
+		tx_queue =3D READ_ONCE(sp->sk_max_ack_backlog);
+	} else {
 		/* Because we don't lock the socket,
 		 * we might find a transient negative value.
 		 */
 		rx_queue =3D max_t(int, READ_ONCE(tp->rcv_nxt) -
 				      READ_ONCE(tp->copied_seq), 0);
+		tx_queue =3D READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
=20
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
@@ -2220,7 +2223,7 @@ static void get_tcp6_sock(struct seq_file *seq, struc=
t sock *sp, int i)
 		   dest->s6_addr32[0], dest->s6_addr32[1],
 		   dest->s6_addr32[2], dest->s6_addr32[3], destp,
 		   state,
-		   READ_ONCE(tp->write_seq) - tp->snd_una,
+		   tx_queue,
 		   rx_queue,
 		   timer_active,
 		   jiffies_delta_to_clock_t(timer_expires - jiffies),
--
2.45.0



