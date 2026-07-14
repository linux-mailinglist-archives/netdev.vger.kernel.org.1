Return-Path: <netdev+bounces-307368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ETqaOqjbVWq1uQAAu9opvQ
	(envelope-from <netdev+bounces-307368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DA7519E6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=gpp+8Dcy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307368-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9353095F5A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B503E1CE8;
	Tue, 14 Jul 2026 06:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010020.outbound.protection.outlook.com [52.103.7.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7463DB338;
	Tue, 14 Jul 2026 06:46:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011597; cv=fail; b=uyMENLPPhMvmZ+myv6TEqSuT59zBHUKhLFk4z+9tIEfeMAeKyQbCcTosaXkZPqoNouajCkhoN9JdvRGRPJihM1PSRuOCCFs3pF42cBEqrUow8Wi0UzFpkS9LK3T5vw4/0BQbom0cGq7rVq4HKhFDrkUDo23oIIE0KAXtzPB9IWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011597; c=relaxed/simple;
	bh=tUrJ8q+nCwt7OWehTNB2plutp8jZN9x/sL6dXyw3rTA=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:
	 Content-Type:MIME-Version; b=TlS/fyobtpQweY+cBxrRDFYy1cFMhyU7YbErUgXFxT2mwVXD4pvSIe+5wYv7oR47DU5fAiWiVyeUc/n1HhtCmqZiHgVKYIW77UMe9xm5glG7AaZ4dmFFDpiYlBMjZudK+xdwIv3oS9j7e5J6U3hUe/YeqrxRYeLF3yvYgCLGsRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gpp+8Dcy; arc=fail smtp.client-ip=52.103.7.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJOzZMjJA8Yo8gAWT8wCOBwncae4HwwJ+GuCk8dW0BhQ2CMu/EXAHuPIn+ExoVni9SD7TECkxH1WA0/bGhYBUzeS804+7r1OOmPKP+d7rQbxgdL3EKqUw7pRgwL2vsKdQcEnQd7b8umnxF5XBut1WBurUx2VNKOxGZ+jRfbD2cc+Wcf4duPyaOPne+mPWvv19GJbsbGV8oPtKvdpwAOlOE9iTyoSQlOyl83GdVhYTVXWm26nBW5pS8+DHhrNroa98R8EG3lhrPxSN5B/zmxWdf12F3MtDTbNA/nTcAm89KIEa1LA2Qu5uQXZgWRF1v/aYUmYaAXOJ2ahI9QU/lfA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M7hE281RoYoZkydXFs/VQVpqyRGsXenD7HXKARv10w=;
 b=K3lmOZi+Bkm+wCE2MK+Eqh7GnkMGLHSLm5Cs85IAReYj6hF61XdTHL/TjcXx1U9bz572yuRfd7F4pY/JNfWWWLzdN9A5X+8o8mKU93vH2d+VbcLkcEj80iMHiCNjJmJJQCNmHdzQoZkFX24U6O+XB4lFzH3EIftODHhPSxIgeGkjpPfP/ZKciIHiZiaXvWpu6ut37gb2ZAbjs+CE1d93IM6K/+fqhwMJvMnQ3jx+nSHy/CdBSJIO4xtzM18+tn5ge1KcCXscmK04arJy+6eG/avZwJ71NN/NMWooYrghBxdRUosVa4HleLu3yLZLM+6H0tvKfnKFqpv7W2cCJrvHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M7hE281RoYoZkydXFs/VQVpqyRGsXenD7HXKARv10w=;
 b=gpp+8DcypdUBEScH5oaSKRXQBfDWPZunIfVAOx9dUmSDhX7yV3l2ANDidHHY/TzVPhNNIy7Jw9Xi/RiuDHt5y65MurdyncNgpaPXPXbJqsn2QFTZO7VrZBQnNN4rGPYk+Aq5/SlZNLSgrOJxnuI2TJgrBTJTP/I8UExu0yGJFMj9t6E33eASOSJGq95RrCFVABtwNJU+qlSBzgEt2duJH67UFeT3qkPvm2juCozG5axIwYQEdSm+m2R7mBA0zWtoGFzmuom9yhsIXowE7BZBHvlV+XEvqVbZvn6U5YY4rGiphre44m6f8lLHhgNYO7E9Gc+hqw0JSxZMNRPZiuHcgQ==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by CO1PR19MB4901.namprd19.prod.outlook.com (2603:10b6:303:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 06:46:33 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 06:46:33 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Tue, 14 Jul 2026 14:46:20 +0800
Message-ID:
 <MN0PR19MB6091ABAD3F4E6AC5FFD44E34ACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
In-Reply-To: <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
References: <03b781d223194234bcf6e53df12880b4.1784011580644350.tspi3m-maxio-v1-cover@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: Add Maxio MAE0621A PHY
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <775ff42b2baf410dafc3e2fe28eaf106.1784011580644361.tspi3m-maxio-v1-1@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|CO1PR19MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 470a000e-0574-4ade-2be5-08dee173a4be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|15080799012|5040399003|37011999003|24021099003|23021999003|41001999006|19110799012|8060799015|26104999009|440099028|3412199025|10035399007|40105399003|3430499035;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLppJc/q1r+jDgCFRvIVXIMUGmQe5YRKXO3UozvTU0sNN+MZf33ZshB8WoBw?=
 =?us-ascii?Q?3mCzDDRTk+o8QYAK7T+v/nE41AGKlfsR/tgkQQMu7w6xrBSiFsSSPWLZM6uH?=
 =?us-ascii?Q?EcegIVpFDhAKwM6MB4q4b5VHijtCG46leWsl8Nz12eO+vkU/C/TWdDH7FeHm?=
 =?us-ascii?Q?jiINs9jOcC4/Q6QSZXoOdaHZxfdgiylxg7Rs1S6xdlyT+L1yoq0Ih7x0wXVr?=
 =?us-ascii?Q?P2Pm4+Xnc/v79uvOz+WV9vsNBibP0k/pUDXh89195yEgw/iYAPMxyNukNvbC?=
 =?us-ascii?Q?0kYPC6eEzVPro9EOEEGMwMXsXr5fDC5Trorexub3lsP4JDRsCxY/vumL+nej?=
 =?us-ascii?Q?fr8B76zqAtxY3DPzDkU0gxU3APMzCyjG9CdBz7n2WjIYCD/7iLfLXRGMoFuE?=
 =?us-ascii?Q?ncpcuewl947rX8ShxvxLHL53oUhsT64lVmDPL1zitT6kVeKIqSdCRfUi5g3R?=
 =?us-ascii?Q?f9wytq2CzXuRVM4YLhEgqwjuWysDFufP2Ll5e00kupw3Qsa5Z9FihqhtN5j4?=
 =?us-ascii?Q?1NHyg1rta9NNWS1wYU37f721JwIbgwdv6WRp62dNk/UjYWNx42jEUArR+et5?=
 =?us-ascii?Q?nsDi9CKzcGh9IsbwNin6A7nReN2E30F2oPUlgN2jwQYIvJd1j83n2kPNoRbF?=
 =?us-ascii?Q?gueWf4WzRka7W63cIwebMId+LeSYLhj2p8VO2tSrcOC/N41ElzrrSJK80jHn?=
 =?us-ascii?Q?TzjQkLFuqzVKmYC4B7ftRKUE+IJmCSdLTSGqMTlF1KQHFIgae9kKnGEReyC1?=
 =?us-ascii?Q?vcRkrANr+Pu8wriNUGyr9wNasfzzXpfbW3axljQdo71UaYPGt9kMcPQLJogk?=
 =?us-ascii?Q?xQoRWNJ/r2IAs9ZXBmSYidmPWD/SAuywA56Oy8K7FYCUqMszPrzwyFoyYDPN?=
 =?us-ascii?Q?mh0nXDzqlS6eD5gR/3loywaw3O2tVDWY+2YfavXzSuMt2RzD2HnJ1xzg5GFw?=
 =?us-ascii?Q?RfHx3azWJgMF56TT7iktVKiyrIM99r9YVw5HW+f1N/o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LaVfXrOH667/qp8u8np8LYIl6sCSz8XMogaXz08R2aZyGs/D9W25coNmdAr9?=
 =?us-ascii?Q?5lPrG/caSMoIjE2SXMv75kpAyzOzVVClLFgqnKiHTLsTaEZ9qhtJLOmLj40t?=
 =?us-ascii?Q?vmF8XIHwRsnlzGFUEFw6snwudEflMTg5+qORN78kYnPWPdN+DoHy1MeiaIf7?=
 =?us-ascii?Q?sE0HyJLZtcZaM3tZRyTNEKZ3bUENGv/4JJIqrqj5mTirUcyHeeGiNS3zU+O5?=
 =?us-ascii?Q?48eRqBMvrIIpKkH9v4wJet17FyRq7SHUtZPBp9lJ+NKZym/fnquGjwHL7Rli?=
 =?us-ascii?Q?Ki+e1pMbOh1BVv8fs4eC94S5ipScqreZ2VckJKlCVVTakovvETKz19ldzCl+?=
 =?us-ascii?Q?h9x54V9sZYn9pg2ejmysT3JI4pXKMAP4cZG59xeB4hZDypi3dnFgJ0S73In0?=
 =?us-ascii?Q?UyKoNLLUNYKa0WsB7NsOBbru3F02n4REu4i3cRRREGzefE0i3lAY82ISNgcm?=
 =?us-ascii?Q?Gm65m8ODt+FUbvpnz2oDeeEQ2TTh9cnCJjrVueT17uujG5nWe/i/JBAZyLWF?=
 =?us-ascii?Q?xPAi8PHT7boixo89Ttba/ekwbWTHHHlPuSe/5+89hYrwfzY6BIcaUMCd8uot?=
 =?us-ascii?Q?xxRi6Qlc28kJ91eNPA6veq1gT7ldR44bR2NESm306r7Bsw0h52CInjhR2B4j?=
 =?us-ascii?Q?B4+XSj8pRQD9nlO3sTKt+BheuLy28SRtRPjGE/2ZakzmrOtJ2uAmY+TDbj+j?=
 =?us-ascii?Q?eGP4vH6pt697knUQyotvaLPRY4tMOcDB/53MpvdHWeG1Evl16R+Qqsm2P2mR?=
 =?us-ascii?Q?neUEvOw6cCdhoUjHFWp/gmVpeNfDeeI5K0yqpm9wVMLZy3ZzoInuoWPM5rz7?=
 =?us-ascii?Q?BqCvapTr0YJ3p6+pPQl6rN3teUTep7OBVw6R+G7krgWiT42veujMoSYpbXmo?=
 =?us-ascii?Q?T7b18DlvE4mGpE50MugBEEeeFh/LhEfVy+0VmFbF2o/gLZgJrQOGV4WJ4VaB?=
 =?us-ascii?Q?5Xfa9h9Z3NzaCeySwWYXbVUxJ+kNlzw3KAdJ/GBXPOjHyXZRlhBqcvjUudj+?=
 =?us-ascii?Q?Vw1De0qNaPxxp7+3AS9Q/Co8rAH+ghe9pyAfMazJJ46CI1yqm53wHEEVTyBH?=
 =?us-ascii?Q?jSjtxrefGzz8kbOWgp0vYRIvV1gCYOoT1l6ZrqC+0/EFzT88hdYyv5rlbqo8?=
 =?us-ascii?Q?tH+XxQDSQ+EyIbNs7eJH1UdT1E1YnXNyINo9+A7QU6bTaUnKqt6/VrNTYysP?=
 =?us-ascii?Q?H3RO6FPqvwAb1JYRxRGKBwfRJbpLMmP/D9O7exV9m3XVlmUJ3WrGDvoS4Je7?=
 =?us-ascii?Q?Uw+F9YVIB0/ctkwCdUrfKo4H7H86Vnl7uSA6NmVu13/XGSBNRJUzpywatWXL?=
 =?us-ascii?Q?Lzo/D8StFh27nAxdyihXhBI3nCWK2gikPCqFOP7HQG69L6xk5rJ5mjnFCdSx?=
 =?us-ascii?Q?R0Q5WvDtzKE9NaI8tmhYbbI0a6lzf6E4b9fWEDPr6lnoPPzYAg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a000e-0574-4ade-2be5-08dee173a4be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:46:33.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4901
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307368-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liucj1228@outlook.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,MN0PR19MB6091.namprd19.prod.outlook.com:mid,outlook.com:from_mime,outlook.com:email,outlook.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 832DA7519E6

Document the MAE0621A PHY ID and its optional 125 MHz CLKOUT
setting. Boards which do not provide the property retain the hardware
strap or bootloader configuration.

Only the 125 MHz setting is exposed because it is the only setting
exercised on hardware.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
---
 .../bindings/net/maxio,mae0621a.yaml          | 38 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml

diff --git a/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
new file mode 100644
index 000000000..f1ea54583
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/maxio,mae0621a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxio MAE0621A Ethernet PHY
+
+maintainers:
+  - Liu Changjie <liucj1228@outlook.com>
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    const: ethernet-phy-id7b74.4412
+
+  maxio,clk-out-frequency-hz:
+    description:
+      Selects a 125 MHz clock on the CLKOUT pin. If the property is absent,
+      the hardware strap or bootloader configuration is preserved.
+    const: 125000000
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id7b74.4412";
+            reg = <1>;
+            maxio,clk-out-frequency-hz = <125000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f36..eeaf0b7a1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1013,6 +1013,8 @@ patternProperties:
     description: MaxBotix Inc.
   "^maxim,.*":
     description: Maxim Integrated Products
+  "^maxio,.*":
+    description: Maxio Technology (Hangzhou) Co., Ltd.
   "^maxlinear,.*":
     description: MaxLinear Inc.
   "^maxtor,.*":

