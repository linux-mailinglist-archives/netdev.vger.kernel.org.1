Return-Path: <netdev+bounces-267481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBOCBokktGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:51:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AD2854F2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBAB130668EF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401853A3E8C;
	Fri, 13 Mar 2026 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="Aem/rB1X"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023091.outbound.protection.outlook.com [40.107.162.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52637FF41;
	Fri, 13 Mar 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412317; cv=fail; b=f9PrkbDT+24a5KHVz8WH91u24iP7VSAXf0Z2d5R/Rn6ion8WTe1ias/rkRQoTVKBY1mKe8I3SEFqMtbVntZkLW62gfFKyoJAg8XdQKAWRzKQhfb34ZIOnVz0yP8jw7Iw+41jQUPNwc4XIqCTDULxbe0DhN8lGpBQQ9Hw5+E/kb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412317; c=relaxed/simple;
	bh=IEs9+Td8UUGCtR678uAJ/O+1iP8zO0gei17w2pt9sbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryd4uwJNW/wOpiT2MgEbYmO9nbcMAuF2jFShJiEPG+JlGXswxumJIebMiN7zqiigWKzifCxnVpsH4vLneOhl6jPyd9Py5nWQci8Rfg70z9nDtTL9MzlhvCEQx+kIzts9O1SKAljSEgzS/5a9+P6saqeV4SZ/uD8o/rssDgpFPAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=Aem/rB1X; arc=fail smtp.client-ip=40.107.162.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI3SSpMWDRp+irOQOO49flZxmQ4DVV+RVUJ+VaMuSN7yljfVzftezehrWK+uUw84/7NqMOSZX15zjPNC0LdqL31OPG/efNhtK70p4L4Lr76Tu3YxeJqLmQCdgMVDgtQ6PIVpCbERSUhR3RFec0XIZ2hRXz0TVE01e4FLOgqtv1QsYrvhpTlCTZL7Bi8wR6NaDSdy8Uutf8eD5+slJjNgw/r/YbFTAvNSFdZHzuGV+VMVio0psaow94bvNSELln8bYj5k1+OBTlS/Aj6FaHAlY/8ijJnHggeXVfrcauB20Z/ZsAdFqx5AwMSE7ZFnhde3r/vw5tKUSJvA+z6UZPKg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sV0CCA2uAj0neXhxLh75haTCedC9vGek+Y2Mr6Zrzs=;
 b=xKfusW+WN+YYdlydAqgY8iKuegVN0QeIr5HGqZ/yEBkS5lKaO1fZ//jg+OiTWBAqzDdJM3UhZhWve9gqfsUJHEZ08B2BY7M1ykhwzPOc3JvHd7zMIhcjRE56J1bD2j+Qq9VEjE7EvXhQ5PfcjddBOwiH4YlydWFLk9fVhl/r6q/P1Nxuc3qIiTngi0QwMy5Wq+V7UxB3pel+k9N0NRxl3pUA4yK1cZfGM3r/yCkW6TijA2bPXZUjVrLeELgnI/60eeQZvm6t8arYhid7V5J4aPoMMZYVYRQILYARM6+/PvS0iLB5/YNcsslhwElKIAg4EkmqauI8iINia1D9PbGoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sV0CCA2uAj0neXhxLh75haTCedC9vGek+Y2Mr6Zrzs=;
 b=Aem/rB1XsUOMQTfRG1zyGFn4+JbFggOQsb+yyizMLRdBz6VNZx4vF3a5dcGZ9lRTs2Mmf9RGlTtjsR/zhE3Ys1hgaNOqNzrqbp8vjrGoNi9kubLl/YOuj1gIrNmXdCsJtUU7mo7m5i4VxGsPzfwdY0UEAbm4spzlNRCQ/jWlF+A=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by DU0P194MB1949.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:413::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 14:31:49 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 14:31:49 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
	<jiri@resnulli.us>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions from
 fl_flow_key
Thread-Topic: [PATCH net-next v8 1/2] net/sched: cls_flower: remove unions
 from fl_flow_key
Thread-Index: AQHcsURPf2KnFKQg/kiSpJ4otRFJ/bWsd5GAgAASEPw=
Date: Fri, 13 Mar 2026 14:31:49 +0000
Message-ID:
 <PR3P194MB1505B777EC106B06B2850C57EA45A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
 <20260311-net-next-mv88e6xxx-tcam-v8-1-32dd5ba30002@luminex.be>
 <20260313132651.GX461701@kernel.org>
In-Reply-To: <20260313132651.GX461701@kernel.org>
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
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|DU0P194MB1949:EE_
x-ms-office365-filtering-correlation-id: bf9643ff-1352-461b-b21e-08de810d4324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 cteAF1Q899NS2AGmgKVG0oNDIKcqA6zueMNnLOzaq9T5sGb3+csY9qGGMevcvDAhHCIIWFTedg+pbecioo2gCMdTkpmwobNyOOCATV67mDxBT4qPxRHhMLnSA1Ln6yUw5ezajUL6nz9KXUM7bZ+UftANx3T0EiwpSbfhCkv+2YcPo25KCifxfsBb0q2mK+OiEfdV25fzJ9Cj4ggXnsaky3fHQkEaZ7f7T324aaqGFFGtFLXKruPuTBjH/sIAKqXsbFcgolMe+ldhcFk3/DYFrfY7k2tTrgk0yeW01XGI13w0X3m2RbWNXB1zXoyxj2+NEeUJ+Zzg3P7sEvo/LuBcTh/khYeqUrzJJ0sfdyEvtWKCm3kR9SZGF1JTAiT4GPJ5jXnsfhVyWVClPUfgX12U73ZxmI1y1nBGaSNLjet/wkROUttrnvNWWgrxTMwxTSR5EKVtQhSlEQ2QiU2Iey21nyKI4mrj2kjw9/qcF0F7vklvpipnsJb8QMMtpoGn4K5jyk62PSRsbpqKilqJpPIovhuta/CqzliWUDs5lSCByUkMTjH0mSbbGAEw1HX9vXaMNuoS9csSe8Ay+9f5tRIX7mjQVUdVil8RXxUVF/D2vTJ8LakVaP0/bMQTCpwBkwHQ8YU+0t2SFU0qAPym1P0bVsYr+viZsw/spTS4zFM/Qb2X9pWVET8JzglaIMd/fUP49lH/YcXKv2XnyTfFmSKSWmWJ6pE5WaKADMGcsTvId6xvCsJ71i7V/hzg3DnV4O/q7s3zTMApeZHmP9Z0qruC9hRn8QPQM/nr0+0zpZXGYAU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D9n6p7HLPY6f5jmIfCCQkqlthw/ESEAsr3bWIT/pTDQs7efoHE+8xLs2UL?=
 =?iso-8859-1?Q?l64GGAdDnLQI3G7vQ1T4JfzLYM3UJzubN8VFRRgOkCqDLsCbpkfk/H6qX8?=
 =?iso-8859-1?Q?f+i992zrQXdYcIs0sKYgeWwXQOMuUXLo5UvHGyWbTB8Vr5ZtiY52mwoQxI?=
 =?iso-8859-1?Q?9lXfzPWE6pWEnfaALNhBAbimHvISfcROBiLZbjdzfOOQ4+mRjuTPlGedxq?=
 =?iso-8859-1?Q?sm4K/f9M+BrcJpUWRIZmcbev/aYfNOQGob4uoiDnsj7wAQm6yV+3oDx6No?=
 =?iso-8859-1?Q?1lUXjkIsa5HZHjteoji+ZZRt4jgvRM0+7DSk0AyBFwV+gxvn7MHNXsnh28?=
 =?iso-8859-1?Q?8nOzAzrSQV4LvUzCsiH3BVao6I0GqIivsInXs1t2YaJOnVgXrnaO5OVnVs?=
 =?iso-8859-1?Q?E4QYUjFXYp3UVSn3yxJJdXd74IweLvDaMfD5Y1R0e9mUV0VSagMdt2pIWN?=
 =?iso-8859-1?Q?Y4WykbUiJOx9f+zKc/oQPZZxJfaJYUV9P1w3nA8SijUGGncy3SOxma7bS0?=
 =?iso-8859-1?Q?qAM07L9WpWe8uftb6a/8iE3IQuHJG0UrktCri2UUB2sDWPKU0VVEQDd0sY?=
 =?iso-8859-1?Q?qh4JrWThsraTyOrQa7w86CxXy6UNUfQ5xCJVsbSrpWd1h6Aotuw4+ktiGn?=
 =?iso-8859-1?Q?bzbef2NJ7UWTSCVEP9+abLK5xvBLGAqPBLt7M0uaTNOoPYP7IAIqL3mi7Z?=
 =?iso-8859-1?Q?HUaqHzKSPqCcZbi8qwCpLp2oiLZkYw7fqQKyItBe8NE3iig3cSeIBJyinj?=
 =?iso-8859-1?Q?lByfOI8GSLWHpxYAK5McBa/x3+H3gp39XbfJxTTZfUafWReXLfaQhn/V7A?=
 =?iso-8859-1?Q?nG4GrKRR5BTzguPqobeluylxq7ajfyz5zYrTscy7+R2IE7YYLP9jVQ5ISu?=
 =?iso-8859-1?Q?XDQOkXhRZUYhx3Fr1nwZ+FU2GCKGbBHYLCf83tzgUGeiBhzdjjPOukw+sa?=
 =?iso-8859-1?Q?ifa6JU0Wn0z7oTbrregJ58kR264c/2FHOFOi7AQvTtc4u/Sg+jphY5VSoX?=
 =?iso-8859-1?Q?i/C5tpzfHXRizod54XBHojXGQvzUJrcoHVEicqIn963h/OH+KLaqYAfNAC?=
 =?iso-8859-1?Q?VpITeGlyGzUcuzypqAODTnvCQwdEp02uhlxOJnUIAgC4wn5igL7A6gTfj8?=
 =?iso-8859-1?Q?Jr5C4ab6xq2rUyQhjDCk1S/qUV8aHtuElFBdKzABY7gPWXt+aH1ffi7ovp?=
 =?iso-8859-1?Q?ZR94309Khnmu82T7xr3sE6UD6UJbu290mDHpFpQlr9hHPQR69zRIuLpMV5?=
 =?iso-8859-1?Q?yRKCchskJZI6VE2E07AZCROv+iXTKj9RzFPgl2ek2564FF5wsrFY2PGtn7?=
 =?iso-8859-1?Q?ZbsC5665gGxqPIsSgZ4eWGBRAUTqHywSpgc2ocXLBVZge2f+kRWJsPX53n?=
 =?iso-8859-1?Q?CkL1hVnMLESYegkKwfC7g9H7ziJlXKpafc9uzmbOkw0OQmhJKn/Vj23au/?=
 =?iso-8859-1?Q?xGVArrnxYKqQ38Iv1iL5isrtE9Hw0fuu0NTDmmYoCkH3PZ5WWnnoiofGko?=
 =?iso-8859-1?Q?+f+VM5QB/6NvY4+FOGI/VxaFh/jqqGQeMymDZ1EbIIQl4PskbzrSHWg0P2?=
 =?iso-8859-1?Q?m0usLXx7+kSAhWIyGMQyOyD58BbF+CDCYyWWQipwyr0LvmY50AljcUC5ur?=
 =?iso-8859-1?Q?3rLGanjGB1wn5kAA5tSUA0FUrXJ73VLTkeBNzHH/oNqMY/ILIfNruzaJ9F?=
 =?iso-8859-1?Q?i6rUilf0RGB89jVVbbylOyq4roSHzloR2osQW5oGPUmI43hnBl44X/usyQ?=
 =?iso-8859-1?Q?fF5K34Q/tntCs6PfhPIpNX66X5DwhU8e/099MFt0fmGmZ7Tab4LlYF03OS?=
 =?iso-8859-1?Q?8JB2m40Tvw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9643ff-1352-461b-b21e-08de810d4324
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:31:49.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5VRwdzeG6UDburPOsKJzSnGeRgjw4nivSYk3etHGr+wc+/51Kd+27NGrsltku0K1gvg3Ru9RZaVbjNTSrblXhBK09TBzQQe0ewDoutpKxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P194MB1949
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267481-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,luminex.be:dkim,luminex.be:email,PR3P194MB1505.EURP194.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 219AD2854F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>On Wed, Mar 11, 2026 at 11:46:18AM +0100, Cedric Jehasse via B4 Relay wrot=
e:=0A=
>> From: Cedric Jehasse <cedric.jehasse@luminex.be>=0A=
>>=0A=
>> When creating a flower classifier with an ipv4 address the=0A=
>> flow_dissector has both FLOW_DISSECTOR_KEY_IPV4_ADDRS and=0A=
>> FLOW_DISSECTOR_KEY_IPV6_ADDRS bits set in used_keys.=0A=
>> This happens because ipv4/ipv6 fields are a union and=0A=
>> FL_KEY_SET_IF_MASKED() will interpret either being set as both.=0A=
>>=0A=
>> Removing the unions fixes this behavior without needing special handling=
=0A=
>> for union fields.=0A=
>>=0A=
>> Example of a command that caused FLOW_DISSECTOR_KEY_IPV4_ADDRS and=0A=
>> FLOW_DISSECTOR_KEY_IPV6_ADDRS to be set:=0A=
>> tc filter add dev p1 ingress protocol ip flower skip_sw \=0A=
>>     dst_ip 224.0.1.129 action trap=0A=
>>=0A=
>> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>=0A=
>=0A=
>Hi Cedric,=0A=
>=0A=
>This doesn't seem to be the right approach to me.=0A=
>=0A=
>It seems to me that the use of a union is intentional here, as either IPv4=
=0A=
>or IPv6 addresses can be present in each case - never both.  And that=0A=
>control.addr_type and enc_control.addr_type are intended to allow=0A=
>differentiation of the address type in use for each of these unions.=0A=
=0A=
I chose this approach because keeping the unions required special handling =
for=0A=
these union keys. Removing the union it keeps the code simpler.=0A=
I understand the union exists because IPv4 and IPv6 addresses are mutually=
=0A=
exclusive, but some other keys are also mutually exclusive (e.g. arp and ic=
mp=0A=
key wil never be present at the same time)=

