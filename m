Return-Path: <netdev+bounces-262657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCPKCEKUpWnXEAYAu9opvQ
	(envelope-from <netdev+bounces-262657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:44:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D61DA039
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A514F302515F
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96A3FB046;
	Mon,  2 Mar 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="XmaKOx/p"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023124.outbound.protection.outlook.com [40.107.159.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D8377021;
	Mon,  2 Mar 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458627; cv=fail; b=SsWSn0hmqoOKOCHPREqlRqDdceHP2BNJFSM9ry6JsnSS1BWBnLjrsD7Ist2cXPXLUMrLO7UoBJAIVUWaerrl4uqO+T/y51QoIjBPfbk6HM8zS8oUI6+0KNWjuyGGDROkw9UG52K/tFVXHQX2tNlUdJXyssgOSDw1PqHhfiuvUqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458627; c=relaxed/simple;
	bh=oKWBiXa14KH+wDa8k+2MEt/8/is50aGAj49yAkfDSSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hv+C+je3fFlo4IiVZXn5ignSmRdRxzkaUnOHvtZANGHWwSQO4kDGZ1mggOC8jF231QqjXUro+jeqV5246TQ/5nz9Ye4XHUOpJ2quI2+joeIVIJhXnDz5DwYWX0Sk8m95Uu8sb5p/O3ZsjmXWHcjsrsDzQ/e1NgKHr/H4EBv11Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=XmaKOx/p; arc=fail smtp.client-ip=40.107.159.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqeC+JGTBRPAPRn4/RUTbKaPT+iwjpK83yNWtUvMJ6E64EWQusoqXwl4xSjNHChb0sXAhaT5Rz4KMb5Cp6fPAJPnH/sveHs90+jLRfz8y1qKB5w4YhMaql45M7y3pR7hk+WeRMxRa7rtTBoblHciBjQYIdhRwydvFVGAEAMUjItTKWYuZzYH4WHWgLgDaWnaz0pYVhksyfksydMedCJStgeEdfvCGPEiN8hU3HPdQtFxF0t6cKPygWCximV3bxo6auFzYr1N3JTHLmF2pA6UlgQTFBLqSUDHBf0y1RK0ll7DyX2P1aAiJwj1nJissOjdzpsX3cr/2FAOqxLYkct0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76SVGe+qsmD5qB/1vHlAGt2rgbdEQs3d4nCdan3+2RI=;
 b=Fms/KMfN57nwBD2cwyxrNW7QekjrUyFutk8iE6+jLYtIKZaPuSSOF3TRI69MvAnAI/c6QJsKqm3FNsC+k7GY8P7vldZaJ4qwU/DIujLL5YRH7aPuS2A0j55uc1m1YAGM/90Pzx3EaS1jG9+mdJDsXmi3jSE9DPs04g9iz347f1ZdGkgC6oDMqsA5WF5rrSfE45CszvkVuLz61bbjFledOvBlt/fouSe2wxtbwOZnLbhWuihTPR+k5tthOGhqCtc95e07YZj+ZINmmrgN2AIXLUFoX0JPxPvDmV3i3ftZf+quSUyrF4OQoOErS/C49zC+otYXVBcQhQvlcEeWSufYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76SVGe+qsmD5qB/1vHlAGt2rgbdEQs3d4nCdan3+2RI=;
 b=XmaKOx/pvuo7vpQfS8E5z3VygoNukrOn++TbmJlTzJMH2b704QbLy9DcTSw3WpQtdrcwrm/eDZo8tymeN3w4PFfMM2EqYODUkJTTAzdCnX+F+wCn6xSnyqo/+L2CbD1fAJZLgShDW27Ac2rZJMF5nyyFkw4MDd/DIs5QeqoehRo=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by VI6PPF4E6E68A2D.EURP194.PROD.OUTLOOK.COM (2603:10a6:808:1::1d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.11; Mon, 2 Mar
 2026 13:36:59 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9678.014; Mon, 2 Mar 2026
 13:36:59 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Topic: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Index: AQHcp5zyx+4GfmuhREGBPWCwSSMc37WWS6UVgAEIOYCAA+ZSXw==
Date: Mon, 2 Mar 2026 13:36:59 +0000
Message-ID:
 <PR3P194MB1505B5C902049D53057A41E8EA7EA@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
	<20260227035537.2630823-1-kuba@kernel.org>
	<PR3P194MB15055DDD60A57C6D9023A277EA73A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <20260227172831.5ac5d09c@kernel.org>
In-Reply-To: <20260227172831.5ac5d09c@kernel.org>
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
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|VI6PPF4E6E68A2D:EE_
x-ms-office365-filtering-correlation-id: 6fc7f120-c7ef-4246-db4b-08de7860c7a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 G98FjylrQr0ZhFnyIU0jXPS0/rSPf4jNAgrQL9bYk8dlyDX6xTfqn/Z0f12tuN0OOWW/o1yM7j74kyz+aJak7zaIRD1xJFbYFD4s6u3HEHkFxrazImTOyjpSqMZNzy+uz9p8YZZh0ekgWXOaivQll6UEqE1fKXukhTBPvDvYUP0oVFpXBgHoPrjT1xAqTNKo2x0zsgChCJYJX8VP0nPQo9GKyLfxP2CF0dMhSl22P1NufbUDCDt9SS1qV74KV2QDF5TOHMadpTeXAYB3MUpEEgbx7/TJyqjFzRZMFVp0qNjFGC3+gsUF3A1/DJLHGfMggD3EZQB1rovNhqMaiJQ1Dz7qE/tOg0OkNFcCzfOz1tNq4E7i4i7dVx6dqI8PGkrRIUOcgBkrJ+rfo2lfZXot7YfLIvH+kEKpXzYkRb5XzoP0OTdXqZmeHdbNzrFGS4NKbFYfb///g0QRKTleHhKh9PgnV/rHRvLNhaoR8km4kwKsTLLsr70OILDFmBYr/+pz0YjY9KpGADVkTxp/58FuTn6X1sDX2pIW+dDQqV2Tm/iN/zu6DImg4qiBjb+kBYtHu6ozDSTyMVD368W/Q69Apuj7BwodSYSCDe2h013VfykFVVaFHzsJTEQ0WXR6LiTL/KaWCf8r8YdWmffJyBjZtC4VUwSRN+hRwH5xxrVPTcmxTgyppxT0e0+pN3FBKBg2k8r9MEUDhgx4xhByX65i6AE/2mJcLjLAL8qr0OHwLxDuI/bDpYMwtMbgFMM5xaZd7gPJ3r8N4lSyYndqKr9f7ZebqStykjMrfnJ9QPKzzr4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6YkVvbtW+dFttRmyzlFNRBQ6/ljB+x+5vcOc9mMAKDtJwqt+1g4fNY039p?=
 =?iso-8859-1?Q?M72aqpFSHHLWbrPlEMUg6PKEyRQdAqTEADDRKQUxFJ0Tgbdw1Du9GzBvjq?=
 =?iso-8859-1?Q?ICCqSiqDABvCVM1kAH8qcvD8mmKi+9ai9lJejTpOgf0QZ5/PTwwYBf7QRR?=
 =?iso-8859-1?Q?QTwp0jemNO2Y5v4x22VHxwsBY/RkZ+0B+MtQ5bbXWX/cG56J7qoU66Ydvy?=
 =?iso-8859-1?Q?I+00p7I1lQh3mj6ivuVlFz2r+xn9RSYvX8rlqTptjhEk2C0L/aCcmgjdQ9?=
 =?iso-8859-1?Q?lvHVWBr83XjeJgSOVKJqaQ9rvDT6XCTvsV8dMJdA3YFsRy0cc/JAy6UMo3?=
 =?iso-8859-1?Q?0KVxmc/SfePvxBWUy8BPDQQQZu8FjMqj5ZUvRNHcIbCGCCCplymMBjMOaa?=
 =?iso-8859-1?Q?YqHxM7JRPz6nccFOjzskMcpqR+nUH06qwC4Uz06dyQ3F+EGUwaCjItB4yR?=
 =?iso-8859-1?Q?tdLYxFlj3+jZhW4xQT5l/Igp9WwBdC2FvzlRN/oKZEMdjsMdr3sXFhEFtT?=
 =?iso-8859-1?Q?FQ1+bDVE7fIivdbOy2RwzcCS5MKGb89+I3+6CRtn5kzVQE4Ox1Xd3wV2Ju?=
 =?iso-8859-1?Q?fyQiTReSZjtD5nPW+OA/rHVgqapaqrHP0jU1kImoFjsI6/z1cAV/Rxe4f9?=
 =?iso-8859-1?Q?FT7HLy4o0UfGqWEQnbzuW0g/OGwnewb3MpKIr6iHZnvjgbPGEcnMfZB7bH?=
 =?iso-8859-1?Q?/JyI/eADUeuBVv/QzJEv7u7pIYS4FyoqQ2O762gRp373nQge+qo8tcfOBw?=
 =?iso-8859-1?Q?cZKvUvH82Xa7mSxfP+INRtDpKfsV+oHD4RW5XhCcHOAh7jKRvIMBUDzB7h?=
 =?iso-8859-1?Q?8R4BmwzZT4M9ktLqfLlhZj7sajuwxbLXVTB419aEepVWFfWxHYvtLHqb0g?=
 =?iso-8859-1?Q?Q2Uewzdi/cmcmQ2Smr8wx4Faam93tavVdtHbE9WNX6tcgHlexiRqt7UuTx?=
 =?iso-8859-1?Q?z4hfl5YrWtCFh+3u/boCM5OXMsCOntCJXaPSmhhmAXuSneNqQ8yYbcrIzF?=
 =?iso-8859-1?Q?l9GhV9KEOwBcDIeScrX2YHoRiE/dlOEewgsMxX4ArtWujKya6A3hgo9Ob1?=
 =?iso-8859-1?Q?YTIveqTh49oZU61w/IXflt0vGnc4nBsegkTXnFEwDzeVUMdOWA2XtmlDj+?=
 =?iso-8859-1?Q?+R/YdpMBxCV7KCWcXzlBzaA485KxSqVjihhHdw207mhA+GwQfzSZzck53R?=
 =?iso-8859-1?Q?RK9GWTUMoQMvuomo8DSvewq5OxgQw9C+fldkv4HOgmNRwt6l8NdRvIxgpd?=
 =?iso-8859-1?Q?q9VvlzaXj2vySN2zoOMwNv/ZlmlFL1MZZFyQVE/2s+0GW/J4tVkBo3PidJ?=
 =?iso-8859-1?Q?KqmsyY3XsNMr7bPrnp00MH8g8NqHnwM/Cs2eNmiuSO90j7B1jLJS1/aid5?=
 =?iso-8859-1?Q?38RfQD+wdd8rx9aujseeGLoLn53wAMFAAI97Gnc7a9Th3IbVqqmSgHTvXx?=
 =?iso-8859-1?Q?R7KSRsaXhxW98dtQdq4YzZaTCXLoGz0pGKmaqo3ZtOGpcA2SeIwecKynQ0?=
 =?iso-8859-1?Q?HpmsWtDaCma6SUonqPmHANrpjuG0TbnrTvLliKu26tbwbmX2xKV37PZAvu?=
 =?iso-8859-1?Q?YP8wxB2gaVyZfehinM9GJUw94Wy8X4DzCLwnMtJszThpaTJjzKjTFa319X?=
 =?iso-8859-1?Q?C7XNKZGd0gPDJSRaL+dmAHbs2+yUPDfqgpxAlO12p6rFZniXZOyQy5Zvue?=
 =?iso-8859-1?Q?YZVuxynoIWfXXUCFUY1JNowtN7jIMldC2AlC+u6+FPlw4UrU93X4FmreGn?=
 =?iso-8859-1?Q?0655St9PhsnvzX3/RkKLjZAp20PxJhFTc6eptgds9TthEvoFuasAmN0BRh?=
 =?iso-8859-1?Q?r/nnHLIiFg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc7f120-c7ef-4246-db4b-08de7860c7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 13:36:59.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMlqcr+HPKIhgdLLv7y9N1osFn1vQ/fzTELaL8ybArrOICmGEvIA9a6JF3VzH7E/k0oIQVu3m2KmpaHWVIBwQylJSwWB6brPtoXZy27Xbm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF4E6E68A2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-262657-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,luminex.be:dkim]
X-Rspamd-Queue-Id: 8D9D61DA039
X-Rspamd-Action: no action

>> >> +     if (dissector->used_keys &=0A=
>> >> +         ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |=0A=
>> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |=0A=
>> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |=0A=
>> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS))) {=0A=
>> >> +             NL_SET_ERR_MSG_MOD(extack,=0A=
>> >> +                                "Unsupported keys used");=0A=
>> >> +             return -EOPNOTSUPP;=0A=
>> >> +     }=0A=
>> >=0A=
>> >FLOW_DISSECTOR_KEY_IPV6_ADDRS is included in the allowed keys bitmask,=
=0A=
>> >but there is no code below to parse IPv6 addresses into the TCAM key.=
=0A=
>> >=0A=
>> >If a user creates a tc flower rule with IPv6 addresses, the rule passes=
=0A=
>> >this validation check but the addresses are never programmed into the=
=0A=
>> >TCAM. This would cause the hardware entry to match broader traffic than=
=0A=
>> >intended.=0A=
>> >=0A=
>> >Looking at the code further down:=0A=
>> >=0A=
>> >> +     if (addr_type =3D=3D FLOW_DISSECTOR_KEY_IPV4_ADDRS) {=0A=
>> >> +             struct flow_match_ipv4_addrs match;=0A=
>> >> +=0A=
>> >> +             flow_rule_match_ipv4_addrs(cls->rule, &match);=0A=
>> >> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_SRC_OFFSET=
,=0A=
>> >> +                                      match.key->src,=0A=
>> >> +                                      match.mask->src);=0A=
>> >> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_DST_OFFSET=
,=0A=
>> >> +                                      match.key->dst,=0A=
>> >> +                                      match.mask->dst);=0A=
>> >> +     } else {=0A=
>> >> +             NL_SET_ERR_MSG_MOD(extack,=0A=
>> >> +                                "Unsupported address type");=0A=
>> >> +             return -EOPNOTSUPP;=0A=
>> >> +     }=0A=
>> >=0A=
>> >The check at line 68-72 rejects non-IPv4 address types, but the IPv6 ke=
y=0A=
>> >is still in the allowed keys bitmask at line 30. This creates a confusi=
ng=0A=
>> >situation where IPv6 is both 'allowed' and 'unsupported'.=0A=
>> >=0A=
>> >Should FLOW_DISSECTOR_KEY_IPV6_ADDRS be removed from the allowed keys=
=0A=
>> >until IPv6 parsing is implemented?=0A=
>>=0A=
>> At first FLOW_DISSECTOR_KEY_IPV6_ADDRS wasn't in the allowed keys bitmas=
k, but=0A=
>> creating ipv4 filter entries failed with -EOPNOTSUPP.=0A=
>> Eg. when using the following tc command, the FLOW_DISSECTOR_KEY_IPV6_ADD=
RS bit=0A=
>> is set in dissector->used_keys:=0A=
>> tc filter add dev p1 ingress protocol ip flower skip_sw dst_ip 224.0.1.1=
00 \=0A=
>>     action trap=0A=
>>=0A=
>> To make ipv4 filter entries work i had to add FLOW_DISSECTOR_KEY_IPV6_AD=
DRS to=0A=
>> the allowed keys bitmask and check the addr_type instead.=0A=
>=0A=
>I see. But that sounds like a bug / silliness in the core that should=0A=
>be fixed. AFAICT it's due to the fact that the fields are a union and=0A=
>FL_KEY_SET_IF_MASKED() ends up interpreting either being set as both :/=0A=
=0A=
Changes to the core would have to be done in a different patch submission? =
What=0A=
should be done with this patch, wait untill the core has been patched?=0A=
=0A=
There could be drivers unknowingly depend on the current implementation of=
=0A=
having both bits always set.=0A=
=0A=
thanks,=0A=
Cedric=

