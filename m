Return-Path: <netdev+bounces-305436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VGqhNxnyTGqusQEAu9opvQ
	(envelope-from <netdev+bounces-305436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EAF71B646
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:33:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kbcHleys;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305436-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305436-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF62D304C376
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943D40A943;
	Tue,  7 Jul 2026 12:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123983FFF8C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 12:33:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427586; cv=fail; b=ou6fe4KI5/JFC6RvR5PQFQINS4wKpLl7dtrt1IvOCziKk/wX54wVbpfhCXAo+c8PuRJsfHo9JHZnml57pnP63Bg+meokBpSwa85/L0b8HVshSpe2g7Kog4b9AmKztVfMymGA5pI0A9udYHEPTOj4pNghc6oW/ZfBwo5s0usPjAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427586; c=relaxed/simple;
	bh=ltAzVpUbFnKmqBmsiD+qb9D3Hz79JkFk9tqA91am0C8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ouFRQdJpb41rlcemfKWrvcf6WnB9iNRxSXfEP4/100QiV7vaEAMIcx/MFode2npqTB5Sscs8s3Zsu8/x78V70pU+fdmvY7p1MziGidCtnYMog/mG4CkaokHSSqCzKJszYVMvbkGIW+UncYbj2mZ/65tGVLRo1PiRXjqqXgQih5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbcHleys; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNbxuEDi719kgOE1Z3xjPuMXToTc/3LweuziRbxhzoWfk9KHQzlM8iO97t/q2eY+KtLSf9ARrgPA87EeEClvy4+13vmYfE1rwam4T1jXuw7m7oRi9Em4GIbOlvLccPURLwnggYwcQTFGVlIEQ/f8Si9/6ljFoB5rbNZBV93wJMzb188i79k2JU0KJ1nQfXsBipLq0VcjXDJB8TEyhp4CHDko5/sqEOBnFmh8+pT3S1kQstJ8mevohM/OpbQ+TQuYHAS8XBIp2GVMejZCv29YWPxNfgNlAQxYU111gQ53nSUbB+Lv3RIIyGJqLy/C/xVkXdhWEoFf1Ep8kBfUWiX5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltAzVpUbFnKmqBmsiD+qb9D3Hz79JkFk9tqA91am0C8=;
 b=jK/Fcz+xf/kJ9XUyHX3TPY7PwiKgZ6adg4jsr7eqBJWYoBhZYNg1JQL8mBTIkr/licuWuEGwwC3sHCUhmvA/c4gPJyRG4GC3yP5GXsuEPP8zhxetZKSzlWxKYHC2CJUUpUt0Lf79vZ2EGGbEUm49IF/e3OIK/Rx7vP+q+MQ7ltNPjBf/JWcDD4v2wj6sTKYKE1Iu9jmJA+z3JKuUTN9DXIjoA8/cd1AdVPH+lS2LOLeiLzW7XmkhIJLMUgfs0hbm6mG6Hr3gAAarF2iVusn1SU1w4CqZctB7TO1YbFcjqlsKqiz3MkW5FlS2K8Sb/8quVVAwSMCwJqqr1C6l/FGyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltAzVpUbFnKmqBmsiD+qb9D3Hz79JkFk9tqA91am0C8=;
 b=kbcHleysAcF0SeHjoGHdNeJr3+WwvwiTHciJf3dohXF0rn+BqexOOfHWxDKaF4HUmgb/S6Hh4dWfkieAIgcYzWcIrVWzz7U2q43bOLBU+R7tszBZyjIdPhNKPk28XRoHNX/P30xpUAmqT7IvGHOeVSaLqT7cxBtVHIFxBccq0mSkCgLz4V/Y4U49cGgtj4Ww6V5BeDNZOCx8piEo1fY//GVEbC6u5ArtGdyHmqOxCKBIW9Jg3BOZ+A54CZ5MBxLjWCIIR6vCx4R3fJKFYkCygaZrp+OjmSqaMmw3SndVmrER+H37fETo+1zknp7ic0jjEmTpbB2bIykcG4VIOgzs3w==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 12:33:01 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 12:33:01 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "andrew@lunn.ch" <andrew@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH ethtool-next 1/2] sfpid: print all implemented options
Thread-Topic: [PATCH ethtool-next 1/2] sfpid: print all implemented options
Thread-Index: AQHdDLnRMXR1I6kM90Wjkfv9Mm4r5LZh8BGg
Date: Tue, 7 Jul 2026 12:33:01 +0000
Message-ID:
 <SJ2PR12MB9008B6C8F85B02A819610279D8F02@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260705200637.2092534-1-olek2@wp.pl>
In-Reply-To: <20260705200637.2092534-1-olek2@wp.pl>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|SJ2PR12MB8158:EE_
x-ms-office365-filtering-correlation-id: 47265126-446a-47fb-d277-08dedc23e279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|38070700021|22082099003|18002099003|11063799006|3023799007|56012099006|6133799003;
x-microsoft-antispam-message-info:
 /0KEHiutTUUyO8isV0tRI6FSS6WmCPS8wRSCz1tb4fdAWj3BknFYGQO4Qqa5kd6DbpTjbZ9cTfAZgqFZhgqHnXogS/0LT5oeBiVarkunVOsdPL9TVRxBtHrFAO3fT3ZBtTBfoPIHmafeWE3PVQYk8zlNrLjn4dX/2EnjPrtayv+CoPkpFwcjd/XDGv5/rD1tY7Rs/Sacdeqr8H6lYuO10l97MYaM2z5r33QpXjO1h+On2UKHBeLrhiIRIfE2TIwBym6sMXQuucd+agCsf1d5b+RDh/rSo43fm1qYfEAFdkY4BfGu004pJWnGr4G7lD6R+vGpzDqRKwpNHv7//uamMHvI0y+chl1p9Ss36/arQiiRcH4AIm2i6iVMueglNK9MW8QJnM2Ulo9MXPj0FWLb1TxHivb8fe+GSh17bgbwmvl0Zon8RFJjG0nVBPbMUlGTCeSxmz7W3SY8JDZYaZ8zidaq1+rvZB5X6+g4GmOl8qw198hV+15ldUBsCo0xulmMI6dEbYcYGSpt9gWXSAeQESx2Y4j9k0VBYOahUjCNYMo8hJpKwTP+n/Jk97NLkdfhjw35Mhc0YNIDfWX/Wq8p6+lyShLhSj7ZTo68AuiLkLQkTvoyPwhiag7nLOTTzxsTnoZP0xEudoxhnv2ULtdpKxpnWDn57w2khghWuWeITKuTnJF7Q7anjygTuq6vWHkFr8CDxRozC9YzsHWfd2xzpw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTBIT1pGY2RTMC9BZFZHTVY2OUdNTXRtMFFWcExnVEhtRHVwVjVvd1oxTXhv?=
 =?utf-8?B?K3liWWtQYkZxUnFPRzdpOERpSW4zM3BNTXZ6WEg2NGE0OWJQTmtPN0ZVd2J3?=
 =?utf-8?B?NEpXU3dZWDQzSTVQNjJSbzNtRkRhdFZEbXRBYWNibk4yemF6TkhLSkYxTmxu?=
 =?utf-8?B?RWV5RGkxWXVRT2RocFJEK3NsV1Fyb05zREE5Q0RBM1dxWm1HV05GNnduR2lL?=
 =?utf-8?B?MFpvM2wwWXg5RmttK1A4MW5LeHoremo1NDRVM01tbzJ3ZG1wc3Zrc3g2SUpN?=
 =?utf-8?B?Wk83VFNCRDNnc3Q2N0ttMmo4d2xhVTg2VzZPMHd4UXpQd0hkRGcxaHI1a2xT?=
 =?utf-8?B?QU8yTitoRlg0M29PVDZwVUtSTmxTa2x6Q0NnT2UwN3BDWFZoRG9RUjZNWTlB?=
 =?utf-8?B?UWVoMlpUcytlWlcxb25NNFNHQThkQUFwR3VKOHI3UkMrUCt1b0dnZCs3cEgz?=
 =?utf-8?B?eDJLMllsRmNMMlladDlJcThhOVUxNm15Uld3Vm5MWmVxQ0Q3N3NrZXBxVU9j?=
 =?utf-8?B?TjJoak1CN1dOMkxDT2ZndFFMNWdKRmsxYnJFZGFvU2NYQ0xxbnVYdmxzazFV?=
 =?utf-8?B?dFdWLzROS05ndXhxTzgzMjdvU25tY2VZdE1IdGNUbjBLcXIra0d2YzZSTjBE?=
 =?utf-8?B?YU93MUVSQllXNjlzQmc4TWloMUNjOGpyMU1Tb29LbUU1SXhpalMzYklaU3BM?=
 =?utf-8?B?SVdMRUJGQjJBaHdjV0tpWS9pSEQwOElobDQ2S0VDTXdHazVGS014d2R0K0Y4?=
 =?utf-8?B?Zk93TENwQUpQWGNIekN2YnQyRWZKNnVmVkszUENRK05aSnhtanBqTmZmMEpF?=
 =?utf-8?B?a3AyalVvYjVUWGNIcXNkKzNkem5ocU9nanhsVC9ETXRsMXpoMERNaGhva21i?=
 =?utf-8?B?akQzOW4xOHl4clBWTlFKTWxWbFpmcGlyTHVuN21jSndRK25ZSkNBN1EzNjJ4?=
 =?utf-8?B?VzNBWnNJaWtqZ2ZtaThoeUpuNEhuN2V3dGVGMXF4WDZsVHV4eDg4WlNMQ0xG?=
 =?utf-8?B?SlE3RThidHdtbmJHK0VTbkhTWWx1SzZDcnlaK1RNMXNzZm42OXFDdlBGOFdB?=
 =?utf-8?B?OUZkeUt4d0NGTGZLYUJ2TkFjWHhpN2tHVzRZYTFlRGlSUERtT2p6MU1UdHRj?=
 =?utf-8?B?L0lzS2hKYVZuMHYydDU0OFNGWFI5RlR1Sks5ckFCMzI0c2JQcHRPR0VKdFdF?=
 =?utf-8?B?Y1dzSjdJcXRBR0g2T1hlNTR5TFRoYmtxNEJVaW1NNktLS3g0aU96YTlPMmQx?=
 =?utf-8?B?bklTeXNMd2xxRHlvVnI0cUZ1dE5BUHA4TSttYTcvVGVGOXNTWHhNczJpSFFt?=
 =?utf-8?B?ZEQ2akN6VUdQdkEyR0Iybm9QS1grdHpYN1dkeVVjNWtMbVpaSE04YXFNL25D?=
 =?utf-8?B?b3ZzdEo5NUwzKzNYZGFVMFNJTElkM3dZR3BWUERLSUQ4RW5pMDExQTFPSVhs?=
 =?utf-8?B?WWNvL0JzUk5qSGFralBYODFyWUlLVmFYeG9sVmd3REZacnlpNVRsQVZRaXZF?=
 =?utf-8?B?bElzejVGUzdJZmJyallTcno3WVFjVmtMN0crOEhVQUZZdE8yVVoyM3lnZFhR?=
 =?utf-8?B?OW9JZ3ZWZTd5SHNRODkxd2pKSFNtNlNrbFpNOGlEN1VHL1J4akk1b0U5K3Ey?=
 =?utf-8?B?MGtIQkpmWVZ2Z0hBb21QMm1wZ2RNZ1BWTmNtbnBSY1lnU3VtVG9XNGZBa3lI?=
 =?utf-8?B?dEs1b1ZFTWs1NEExZlhTbXNFWnNLdE1rZ0lmRm1hNE94RnV0UEUyVEZIblNk?=
 =?utf-8?B?UnFTT1NMVDA3cDdpVWh4MjdNeWJUdi9XUzBha2NHbXR1ckFBR0RvdFNrTGFG?=
 =?utf-8?B?R1Q1NmtqMEM3ZDltaTAzUVl4RGJQb0hEWnNCaDlKSjVWQjBtSzRIa1B2eVBr?=
 =?utf-8?B?aSt2V3B2N0lDVzJCT1VMZW43MEZQQVUrQVlFTmdlVXdKaVBiTXFNSjhUS0c0?=
 =?utf-8?B?aWlVRm5oMzNzOUNaWkFUNGVRVnFlUUtOeXpURlB5Zi9CRDFMQzhSdGlGUHgr?=
 =?utf-8?B?WGFsMzI1V3psUlNiOWFpSEt4aTNpYzBzQnJ4MUYxNzMzc1N3SG1xRzhrQmdH?=
 =?utf-8?B?d3h3T1RQR25jUm1WNlhFdlUrUE5pNXQ3WldIcXV5bGNRays4eDhiSkE0NUFo?=
 =?utf-8?B?VUwvcS9pZlBtTHVWMEpqWGFJeFBJMzZJNkVwYmhGdGVpOU1CUHE0Zk5lU2JX?=
 =?utf-8?B?U1dNTDZWSWRZc0h0dmZqbFc5Z0ludmF6UlY3TUxQbXk5NUlIV01RUFdERTJF?=
 =?utf-8?B?bVhiSUc0L3N0aGVLYnAwVnpWbEV6aVR0bFZCMnVqRXFmNWI1bHVkV2tMbDc2?=
 =?utf-8?B?WHR6VUVCQ0FhT1BqZXpETXdyNnZGWi9FNktKNEJBRnpCL214QjhIaWc1WEdu?=
 =?utf-8?Q?CpTZgO6T+PCgBgE+qd17e0E4VsBW839VtyGTj?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47265126-446a-47fb-d277-08dedc23e279
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 12:33:01.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bz6V050NXO3b95SeCGRLTEPLckZZ5CwLgCU4iyVTTouFnEoiG5GiN7SGIPhT4lsTR2xw3WnWlb2E1J9bFA1bqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:mkubecek@suse.cz,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl,suse.cz,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0EAF71B646

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGVrc2FuZGVyIEphbiBCYWpr
b3dza2kgPG9sZWsyQHdwLnBsPg0KPiBTZW50OiBTdW5kYXksIDUgSnVseSAyMDI2IDIzOjA2DQo+
IFRvOiBta3ViZWNla0BzdXNlLmN6OyBhbmRyZXdAbHVubi5jaDsgRGFuaWVsbGUgUmF0c29uDQo+
IDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IGt1YmFAa2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFsZWtzYW5kZXIgSmFuIEJhamtvd3NraSA8b2xlazJAd3Au
cGw+DQo+IFN1YmplY3Q6IFtQQVRDSCBldGh0b29sLW5leHQgMS8yXSBzZnBpZDogcHJpbnQgYWxs
IGltcGxlbWVudGVkIG9wdGlvbnMNCj4gDQo+IFNGUCBtb2R1bGVzIGltcGxlbWVudCBtdWx0aXBs
ZSBvcHRpb25zLiBCZWZvcmUgdGhlIOKAnGpzb27igJ0gb3B0aW9uIHdhcw0KPiBpbnN0cm9kdWNl
ZCwgYWxsIG9wdGlvbnMgd2VyZSBsaXN0ZWQuIEN1cnJlbnRseSwgb25seSB0aGUgbGFzdCBvcHRp
b24gaXMgbGlzdGVkLg0KDQpzL2ludHJvZHVjZWQvaW50cm9kdWNlZA0KDQo+IFRoaXMgY29tbWl0
IGZpeGVzIHRoaXMgYnVnLiBPcHRpb25zIGFyZSByZXByZXNlbnRlZCBhcyBhcnJheS4NCj4gDQo+
IEJlZm9yZToNCj4gJCBldGh0b29sIC1tIHNmcC13YW4NCj4gLi4uDQo+IAlPcHRpb24gdmFsdWVz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IDB4MDAgMHgzMg0KPiAJT3B0aW9uICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBSQVRFX1NFTEVDVCBpbXBsZW1lbnRlZA0K
PiAuLi4NCj4gJCBldGh0b29sIC0tanNvbiAtbSBzZnAtd2FuDQo+ICAgICBbIHsNCj4gICAgIC4u
Lg0KPiAgICAgICAgICAgICAib3B0aW9uX3ZhbHVlcyI6IFsgMCw1MCBdLA0KPiAgICAgICAgICAg
ICAib3B0aW9uIjogIlJBVEVfU0VMRUNUIGltcGxlbWVudGVkIiwNCj4gICAgIC4uLg0KPiAgICAg
ICAgIH0gXQ0KPiANCj4gQWZ0ZXI6DQo+ICQgZXRodG9vbCAtbSBzZnAtbGFuDQo+IC4uLg0KPiAJ
T3B0aW9uIHZhbHVlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiAweDAwIDB4MzINCj4g
CU9wdGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogUlhfTE9TIGltcGxl
bWVudGVkDQo+IAlPcHRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IFRY
X0RJU0FCTEUgaW1wbGVtZW50ZWQNCj4gCU9wdGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDogUkFURV9TRUxFQ1QgaW1wbGVtZW50ZWQNCj4gLi4uDQo+ICQgZXRodG9vbCAt
LWpzb24gLW0gc2ZwLWxhbg0KPiBbIHsNCj4gLi4NCj4gICAgICAgICAib3B0aW9uX3ZhbHVlcyI6
IFsgMCw1MCBdLA0KPiAgICAgICAgICJvcHRpb24iOiBbICJSWF9MT1MgaW1wbGVtZW50ZWQiLCJU
WF9ESVNBQkxFDQo+IGltcGxlbWVudGVkIiwiUkFURV9TRUxFQ1QgaW1wbGVtZW50ZWQiIF0sDQo+
ICAgICB9IF0NCj4gLi4NCj4gDQo+IEZpeGVzOiA0MDcxODYyZjU4ZDggKCJzZnBpZDogQWRkIEpT
T04gb3V0cHV0IGhhbmRsaW5nIHRvIC0tbW9kdWxlLWluZm8gaW4NCj4gU0ZGODA3OSBtb2R1bGVz
IikNCj4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRlciBKYW4gQmFqa293c2tpIDxvbGVrMkB3cC5w
bD4NCj4gLS0tDQo+ICBtb2R1bGUtY29tbW9uLmMgfCAgOCArKysrKysrKw0KPiAgbW9kdWxlLWNv
bW1vbi5oIHwgIDEgKw0KPiAgc2ZwaWQuYyAgICAgICAgIHwgMzkgKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21vZHVsZS1jb21tb24uYyBi
L21vZHVsZS1jb21tb24uYyBpbmRleCA0MmZjY2Y2Li5kNzM2YzdjDQo+IDEwMDY0NA0KPiAtLS0g
YS9tb2R1bGUtY29tbW9uLmMNCj4gKysrIGIvbW9kdWxlLWNvbW1vbi5jDQo+IEBAIC0yNTgsNiAr
MjU4LDE0IEBAIHZvaWQgbW9kdWxlX3ByaW50X2FueV9ib29sKGNvbnN0IGNoYXIgKmZuLCBjaGFy
DQo+ICpnaXZlbl9qc29uX2ZuLCBib29sIHZhbHVlLA0KPiAgCQlwcmludGYoIlx0JS00MXMgOiAl
c1xuIiwgZm4sIHN0cl92YWx1ZSk7ICB9DQo+IA0KPiArdm9pZCBtb2R1bGVfcHJpbnRfYXJyYXlf
c3RyaW5nKGNvbnN0IGNoYXIgKmZuLCBjb25zdCBjaGFyICp2YWx1ZSkgew0KPiArCWlmIChpc19q
c29uX2NvbnRleHQoKSkNCj4gKwkJcHJpbnRfc3RyaW5nKFBSSU5UX0pTT04sIE5VTEwsICIlcyIs
IHZhbHVlKTsNCj4gKwllbHNlDQo+ICsJCXByaW50ZigiXHQlLTQxcyA6ICVzXG4iLCBmbiwgdmFs
dWUpOw0KPiArfQ0KPiArDQoNClRoZSBmdW5jdGlvbiBuYW1lIGlzIGEgYml0IG1pc2xlYWRpbmcs
IGFzIG5vIGFycmF5IGlzIGFjdHVhbGx5IHByaW50ZWQgdXNpbmcgdGhpcyBmdW5jdGlvbiBvbmx5
LiBNYXliZSAibW9kdWxlX3ByaW50X2FueV9hcnJheV9zdHJpbmdfZW50cnkiPw0KSXQgaXMgYSBi
aXQgbG9uZyBidXQgYWxzbyBhbGlnbiB0byB0aGUgb3RoZXIgZnVuY3Rpb25zIGFuZCByZWZlcnMg
dG8gdGhlIGZhY3QgdGhhdCB0aGUgZnVuY3Rpb24gaXMgaGFuZGxpbmcgYm90aCBqc29uIGFuZCBm
cCBjb250ZXh0cy4NCg0KPiAgdm9pZCBtb2R1bGVfc2hvd192YWx1ZV93aXRoX3VuaXQoY29uc3Qg
X191OCAqaWQsIHVuc2lnbmVkIGludCByZWcsDQo+ICAJCQkJIGNvbnN0IGNoYXIgKm5hbWUsIHVu
c2lnbmVkIGludCBtdWx0LA0KPiAgCQkJCSBjb25zdCBjaGFyICp1bml0KQ0KPiBkaWZmIC0tZ2l0
IGEvbW9kdWxlLWNvbW1vbi5oIGIvbW9kdWxlLWNvbW1vbi5oIGluZGV4IDQwNjM0NDguLjZmOWRh
NWYNCj4gMTAwNjQ0DQo+IC0tLSBhL21vZHVsZS1jb21tb24uaA0KPiArKysgYi9tb2R1bGUtY29t
bW9uLmgNCj4gQEAgLTI4MSw2ICsyODEsNyBAQCB2b2lkIG1vZHVsZV9wcmludF9hbnlfc3RyaW5n
KGNvbnN0IGNoYXIgKmZuLCBjb25zdA0KPiBjaGFyICp2YWx1ZSk7ICB2b2lkIG1vZHVsZV9wcmlu
dF9hbnlfZmxvYXQoY29uc3QgY2hhciAqZm4sIGZsb2F0IHZhbHVlLCBjb25zdA0KPiBjaGFyICp1
bml0KTsgIHZvaWQgbW9kdWxlX3ByaW50X2FueV9ib29sKGNvbnN0IGNoYXIgKmZuLCBjaGFyDQo+
ICpnaXZlbl9qc29uX2ZuLCBib29sIHZhbHVlLA0KPiAgCQkJICAgY29uc3QgY2hhciAqc3RyX3Zh
bHVlKTsNCj4gK3ZvaWQgbW9kdWxlX3ByaW50X2FycmF5X3N0cmluZyhjb25zdCBjaGFyICpmbiwg
Y29uc3QgY2hhciAqdmFsdWUpOw0KPiAgdm9pZCBtb2R1bGVfc2hvd192YWx1ZV93aXRoX3VuaXQo
Y29uc3QgX191OCAqaWQsIHVuc2lnbmVkIGludCByZWcsDQo+ICAJCQkJIGNvbnN0IGNoYXIgKm5h
bWUsIHVuc2lnbmVkIGludCBtdWx0LA0KPiAgCQkJCSBjb25zdCBjaGFyICp1bml0KTsNCj4gZGlm
ZiAtLWdpdCBhL3NmcGlkLmMgYi9zZnBpZC5jDQo+IGluZGV4IDc0YTZmNTEuLmQ2NjM2YmEgMTAw
NjQ0DQo+IC0tLSBhL3NmcGlkLmMNCj4gKysrIGIvc2ZwaWQuYw0KPiBAQCAtMzk2LDcgKzM5Niw2
IEBAIHN0YXRpYyB2b2lkDQo+IHNmZjgwNzlfc2hvd193YXZlbGVuZ3RoX29yX2NvcHBlcl9jb21w
bGlhbmNlKGNvbnN0IF9fdTggKmlkKSAgc3RhdGljDQo+IHZvaWQgc2ZmODA3OV9zaG93X29wdGlv
bnMoY29uc3QgX191OCAqaWQpICB7DQo+ICAJc3RhdGljIGNvbnN0IGNoYXIgKnBmeCA9ICJPcHRp
b24iOw0KPiAtCWNoYXIgdmFsdWVbNjRdID0gIiI7DQo+IA0KPiAgCWlmIChpc19qc29uX2NvbnRl
eHQoKSkgew0KPiAgCQlvcGVuX2pzb25fYXJyYXkoIm9wdGlvbl92YWx1ZXMiLCAiIik7IEBAIC00
MDcsMzUgKzQwNiw0Mw0KPiBAQCBzdGF0aWMgdm9pZCBzZmY4MDc5X3Nob3dfb3B0aW9ucyhjb25z
dCBfX3U4ICppZCkNCj4gIAkJcHJpbnRmKCJcdCUtNDFzIDogMHglMDJ4IDB4JTAyeFxuIiwgIk9w
dGlvbiB2YWx1ZXMiLCBpZFs2NF0sDQo+ICAJCSAgICAgICBpZFs2NV0pOw0KPiAgCX0NCj4gKw0K
PiArCWlmIChpc19qc29uX2NvbnRleHQoKSkNCj4gKwkJb3Blbl9qc29uX2FycmF5KCJvcHRpb24i
LCAiIik7DQo+ICsNCj4gIAlpZiAoaWRbNjVdICYgKDEgPDwgMSkpDQo+IC0JCXNwcmludGYodmFs
dWUsICIlcyIsICJSWF9MT1MgaW1wbGVtZW50ZWQiKTsNCj4gKwkJbW9kdWxlX3ByaW50X2FycmF5
X3N0cmluZyhwZngsICJSWF9MT1MgaW1wbGVtZW50ZWQiKTsNCj4gIAlpZiAoaWRbNjVdICYgKDEg
PDwgMikpDQo+IC0JCXNwcmludGYodmFsdWUsICIlcyIsICJSWF9MT1MgaW1wbGVtZW50ZWQsIGlu
dmVydGVkIik7DQo+ICsJCW1vZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LCAiUlhfTE9TIGlt
cGxlbWVudGVkLA0KPiBpbnZlcnRlZCIpOw0KPiAgCWlmIChpZFs2NV0gJiAoMSA8PCAzKSkNCj4g
LQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlRYX0ZBVUxUIGltcGxlbWVudGVkIik7DQo+ICsJCW1v
ZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LCAiVFhfRkFVTFQgaW1wbGVtZW50ZWQiKTsNCj4g
IAlpZiAoaWRbNjVdICYgKDEgPDwgNCkpDQo+IC0JCXNwcmludGYodmFsdWUsICIlcyIsICJUWF9E
SVNBQkxFIGltcGxlbWVudGVkIik7DQo+ICsJCW1vZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4
LCAiVFhfRElTQUJMRSBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NV0gJiAoMSA8PCA1KSkN
Cj4gLQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlJBVEVfU0VMRUNUIGltcGxlbWVudGVkIik7DQo+
ICsJCW1vZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LCAiUkFURV9TRUxFQ1QNCj4gaW1wbGVt
ZW50ZWQiKTsNCj4gIAlpZiAoaWRbNjVdICYgKDEgPDwgNikpDQo+IC0JCXNwcmludGYodmFsdWUs
ICIlcyIsICJUdW5hYmxlIHRyYW5zbWl0dGVyIHRlY2hub2xvZ3kiKTsNCj4gKwkJbW9kdWxlX3By
aW50X2FycmF5X3N0cmluZyhwZngsDQo+ICsJCQkiVHVuYWJsZSB0cmFuc21pdHRlciB0ZWNobm9s
b2d5Iik7DQo+ICAJaWYgKGlkWzY1XSAmICgxIDw8IDcpKQ0KPiAtCQlzcHJpbnRmKHZhbHVlLCAi
JXMiLCAiUmVjZWl2ZXIgZGVjaXNpb24gdGhyZXNob2xkDQo+IGltcGxlbWVudGVkIik7DQo+ICsJ
CW1vZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LA0KPiArCQkJIlJlY2VpdmVyIGRlY2lzaW9u
IHRocmVzaG9sZCBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCAwKSkNCj4g
LQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIkxpbmVhciByZWNlaXZlciBvdXRwdXQgaW1wbGVtZW50
ZWQiKTsNCj4gKwkJbW9kdWxlX3ByaW50X2FycmF5X3N0cmluZyhwZngsDQo+ICsJCQkiTGluZWFy
IHJlY2VpdmVyIG91dHB1dCBpbXBsZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCAx
KSkNCj4gLQkJc3ByaW50Zih2YWx1ZSwgIiVzIiwgIlBvd2VyIGxldmVsIDIgcmVxdWlyZW1lbnQi
KTsNCj4gKwkJbW9kdWxlX3ByaW50X2FycmF5X3N0cmluZyhwZngsICJQb3dlciBsZXZlbCAyIHJl
cXVpcmVtZW50Iik7DQo+ICAJaWYgKGlkWzY0XSAmICgxIDw8IDIpKQ0KPiAtCQlzcHJpbnRmKHZh
bHVlLCAiJXMiLCAiQ29vbGVkIHRyYW5zY2VpdmVyIGltcGxlbWVudGVkIik7DQo+ICsJCW1vZHVs
ZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LA0KPiArCQkJIkNvb2xlZCB0cmFuc2NlaXZlciBpbXBs
ZW1lbnRlZCIpOw0KPiAgCWlmIChpZFs2NF0gJiAoMSA8PCAzKSkNCj4gLQkJc3ByaW50Zih2YWx1
ZSwgIiVzIiwgIlJldGltZXIgb3IgQ0RSIGltcGxlbWVudGVkIik7DQo+ICsJCW1vZHVsZV9wcmlu
dF9hcnJheV9zdHJpbmcocGZ4LCAiUmV0aW1lciBvciBDRFINCj4gaW1wbGVtZW50ZWQiKTsNCj4g
IAlpZiAoaWRbNjRdICYgKDEgPDwgNCkpDQo+IC0JCXNwcmludGYodmFsdWUsICIlcyIsICJQYWdp
bmcgaW1wbGVtZW50ZWQiKTsNCj4gKwkJbW9kdWxlX3ByaW50X2FycmF5X3N0cmluZyhwZngsICJQ
YWdpbmcgaW1wbGVtZW50ZWQiKTsNCj4gIAlpZiAoaWRbNjRdICYgKDEgPDwgNSkpDQo+IC0JCXNw
cmludGYodmFsdWUsICIlcyIsICJQb3dlciBsZXZlbCAzIHJlcXVpcmVtZW50Iik7DQo+ICsJCW1v
ZHVsZV9wcmludF9hcnJheV9zdHJpbmcocGZ4LCAiUG93ZXIgbGV2ZWwgMyByZXF1aXJlbWVudCIp
Ow0KPiANCj4gLQlpZiAodmFsdWVbMF0gIT0gJ1wwJykNCj4gLQkJbW9kdWxlX3ByaW50X2FueV9z
dHJpbmcocGZ4LCB2YWx1ZSk7DQo+ICsJaWYgKGlzX2pzb25fY29udGV4dCgpKQ0KPiArCQljbG9z
ZV9qc29uX2FycmF5KCIiKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBzZmY4MDc5X3Nob3df
YWxsX2NvbW1vbihjb25zdCBfX3U4ICppZCkNCj4gLS0NCj4gMi41My4wDQoNCg==

