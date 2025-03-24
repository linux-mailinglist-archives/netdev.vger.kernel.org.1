Return-Path: <netdev+bounces-177035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D5A6D6BB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E20C16CF25
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DB25D904;
	Mon, 24 Mar 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="YWlCqrXL"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B725D8E0;
	Mon, 24 Mar 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806579; cv=fail; b=CzjhZC6/q3bAxpj+afjg1I7CN9LUW7lGr5PgWiSWeyPda5EfcOLLJdn0yD5/WXz1wUXqj20VyMc+0hmcfcJNWOuPO11ocCjEH+7OC3+sengSvWW5TQGgLqI8H3dWB69A1HC5NwxxKO4tft2np3JiNLYV8Yi7Pwnb/jK+kGJRMMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806579; c=relaxed/simple;
	bh=ZK8XvXQXx9mTUkWvcLrz1MWDtvXGRsFp9YwXjQFolik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sb7CNAG8UCaLZEVuGwF9U3NsCOsuz4MXIA0VCc2DnEcsmkEh5uds8cJX4J0vXG7VjMBzYGe0pbq8gG6dxYV4D5Yz0ijCtFak12UtO0oqgsWEWSWNE5k6kGZ3PlWP4fKrmI6qO5Vf/o7OapTaI4Qhq12iFzhwRnngB7V8sjXdhh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=YWlCqrXL; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x90ldR4aHu2xkk67FZFyu68uO5C21lRc9N/Q/sQXb5JHcNodgTdYrDqmy00IM+kLRRS1WaMSM8bQq+8F6ckj7MTKZ9KlUbEXTKgwDBnTYKnoguejAz0kXtHtWJ8/O8P8va1WCV+EKKsbq29EYBQZX0VpcCXz0ljJ7rcp/ZJxrzBWL2jN2/yKiQl1xYBJnVKh0vQ9QLDLdSk1IR3uAsjpo9q8eUs/yQVBqgCJwudxbR2HF0QGax0lFMSdwNyp+98ErMxXUnXL8GuH7HPCVExHJUokwzicDEMtiXhFLqBv0Z+2CPyLBjSESs+kvEQe+CHr5glPWDw4zN41DFavu2z+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knp8GqsIYfBHJMx70bFd5jN6MR5ObtaVT0AcdXcN+mE=;
 b=lVKSCnUcQxi5Fdnn4k1W0FPAPx1l7Q/qwfwN2LXo9wp8ovO1S0rI1Y8Cp7+mWJD9NBDaNxMgoGes3O6jfLMA7AHHgDgIx6Ro2MLjhhRhRHolOPtiqrFiN18iyPAO/TpjlkZgCcxJbQW1JsJEajM4if7VyappWXdNFm7tzSUupz+SR0hLIcK8x2GJYpCtmyTHH/MVtnJjtrtTphu64PbkE9qgJydUxVDq2PvZL7VuE/o3d56vyRojGQNnts2QLbzmVHE7VaURqT2TMJgo7CFilEe91S3KwKys04Dobc/1u1aMUNZVRiaNYRgiwaMNnxZSjr1wxS7uYqmdaUrIBVCxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knp8GqsIYfBHJMx70bFd5jN6MR5ObtaVT0AcdXcN+mE=;
 b=YWlCqrXLE60vQPMgS0KTDXSifVzJJkLonfA5q7oSreUZ2frGLEF2UP/b1SM2gLo98zQXjI0D/V2NIpAraF84CJQ8q7q9l2Abaa0ZynfzQx4w6aDoKoQNeWj/PqEtm2nQqBj1rdc9y4LINm8SB7iK3b+VN5swtWpjlt/gmk2yDsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:56:14 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:56:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/2] dt-bindings: net: mscc,vsc7514-switch: allow specifying 'phys' for switch ports
Date: Mon, 24 Mar 2025 09:55:06 +0100
Message-ID: <20250324085506.55916-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324085506.55916-1-ravi@prevas.dk>
References: <20250324085506.55916-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aebaee2-62ea-41d4-e584-08dd6ab1aedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aNTCFiOb1N6bDWm5m3jiNymy2RdvaGBbrVyYDzdjEaWzWvkLqKj/h5bGnW8N?=
 =?us-ascii?Q?xsd1om+sdsKvt/0+HExloqNOc3eVB8KSjYPvSV85lHE5SSom2GZTiajarC/y?=
 =?us-ascii?Q?tczs5F0t8fpDV/Yxxa76UiNrRWqiTTIA877FSP/7ihs7cJtnl3CksJdow6WN?=
 =?us-ascii?Q?oDZa3V2alHCh4Uo7pWqp8tX5PMT/ou74oyIFHN6/AaA6EFvSyRA5q/6Hbk8y?=
 =?us-ascii?Q?UZiTQ4TIOBQPWvMQF0nGlUgTYKv3xnWgeqItv5wlbBAJ/haBBP2Ju4GwY05v?=
 =?us-ascii?Q?jIv/11xklcpKMN2dIaieHcvZ28OnCGy7PUtse0yTG6jHJs8odBcEythyiM6T?=
 =?us-ascii?Q?eCjyJR8/OBuuUSvbcOZAbjmBaDz82JsEl8A6Z0E8HQ/LU1NkKu1h8sUw0y+t?=
 =?us-ascii?Q?qroLylEPHQSXvRTu1uAEbyobQoy38UedRsttn+Yq3T1Ziqgv0FJ9AOkEIPLJ?=
 =?us-ascii?Q?kcfwDgHfj60eiiyncReN8w7AwizenEoI8KS08MW/UB+I3kGCasUJXJUTavYU?=
 =?us-ascii?Q?m1qA+HA8UBuC0HtSeUhRjvyvLZCgNmMKlIUdwy0OZtsBxd+2NGY7a50saqg3?=
 =?us-ascii?Q?rvtHIxBm0rOVSrBXqdU8UJRiYrAdGEFJ/wSM5sXc6fDxrlHhtXmDzv7swoUr?=
 =?us-ascii?Q?cdnp6tl8lIcbSg7dm2ImLwcI3/KyP3chHI2/jumAGCjGheudVk3fa/ofAV+a?=
 =?us-ascii?Q?2PjIpBwZ5PzNaf4NYNjBsOvbxCtYn1FAq5id1tEo3aYrPr8HY/JYWL8fDB0d?=
 =?us-ascii?Q?CT3dEIAIZaTq9QsnH5CSEumvCd7CAmkwSX39zJ12lgmztB0ODuxTHlaC3xrk?=
 =?us-ascii?Q?8CaHXCrAftag8/FgSAMusv7eCvhMbHotD1n3ZJonzhPQqLYE57XPZZ83ld2q?=
 =?us-ascii?Q?JVYp2h8S04DuMR8cxgbBs7mLSpZa1cXxoVvVGCw8RxhnT6xlkTAmob0L2y0M?=
 =?us-ascii?Q?JTS/HDz2Zq+19aHTSUci6rvxPP/t3KwrqnLNmsO1N76rFHbA+JcgzgL4bjTX?=
 =?us-ascii?Q?g8OnyjQLl1NxhYHTvpMYCPyslq5SdfoaAP8EELqR2FeJk0jkjJDHctdjPlXz?=
 =?us-ascii?Q?lF9XOZy5J+VK1N6ZSVgOSWWpfbB4u8Qi5cI7sYJGizyeO84QLtrYr4rcQ+ZW?=
 =?us-ascii?Q?VqNolrofrIulvTCZpc2PYaDn5veecbnUZXB1hdqQy/upEeNSSmmO2S/u5G6+?=
 =?us-ascii?Q?XTFDRS8S7Yj2XPzrc6uaJgsbRrTYwNNWbaQA9oNFYdxhrt6u0ugiAyIiDJ6r?=
 =?us-ascii?Q?PkzbuhrXfvMiNanO3+3d+A7VO8IIXvLXyUcNoNI4j/58CGwSgFUVYNl/Gav7?=
 =?us-ascii?Q?T4/yCUy1BArsfZMFxqb8wimadOw0UCypBn9XjCFbRUdqBA0bZn69T3SVdvi5?=
 =?us-ascii?Q?OjbdYSRhxXU6gVfVgjiyKvlO14Z5pNAfvPvX6Ed8WnxEDGj/0xXsI9QyvzQT?=
 =?us-ascii?Q?0fSYVsF6qR6eEM/1bMosvNt0DvmYqaJK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+mbJ0tsKErWr/wLUXnM8d7yASZgDj/RDMrAECw3HxenVqBC7UbBAHg6q/mb?=
 =?us-ascii?Q?driZwH/hnIXJ9ok94iid0dJqp2+q+pq4wAJS1zsFx0xJyt3rcF3iI9Fym3LW?=
 =?us-ascii?Q?QBLoYNr4B7Sjv8DVhIXy49butcOia71ZQxpIoklQ0J5MnUvXHRdzGKYMx4/5?=
 =?us-ascii?Q?vYlkZCnlrYH4iIHBCE/WYMDyoOUxPM9of+xwEvOatHpeUPi4aO57XFtdb7+p?=
 =?us-ascii?Q?Wzw2utkg3KyOPwbQnmqOnzs/Owt1+oSz/Qr26Cwan9zLD1ljZkW8s15Y6dQ7?=
 =?us-ascii?Q?w+fwfWRfxBMdfZrUxZ0Lr+CF8EMUU91vYC08epXCdg1k/pBAZFKzlHOeqvxH?=
 =?us-ascii?Q?RNEHUdmsbrQrqHRNZDMG66C7z8DanEUZsitsnuJY+2GNLENPT3E1KECe/xJt?=
 =?us-ascii?Q?xwJRAqc4wi1b5IcSbmP4z7PsZ5Q7aC5D5hNF00TIdgSmru8+u7flkMIhDX70?=
 =?us-ascii?Q?HMCxigVPpd9x86m6AwGRIQOspvy6FaO1xgAeIck1QY2d4wUEpPTepsyPJWfI?=
 =?us-ascii?Q?RP4z6AZ8xMSW3phpZDpi43GVurSq7F2UY3rRMzXGuMCOZYIvMi9/qYEldjEK?=
 =?us-ascii?Q?yteChpqV8JDXgczodO8gI5LV/I+VM+2EdlocZGjhqfl01nplm0Q15lzO9H0v?=
 =?us-ascii?Q?TryDi3sIlFptZ7iT39KghArOZuRYq2Gb0aq8YED3jkv9QCDCJ6AtDYDEcaln?=
 =?us-ascii?Q?8wD63leiJpA4hemE/JGMh2ChpzY3lq89lyLd2Ec3tLtN81rkv6dmllb/CdyY?=
 =?us-ascii?Q?QXaDMm0NrVjoeDPR0nDHcU9gzRaoVJAWFNmu+d3Hi07ElwpJho8gE1fkAVNq?=
 =?us-ascii?Q?1Rt8V57SkJp7tlYT+uc6HvCavCjDySCyKMtlyDa/QygIK62pKWmEaGQnD+ez?=
 =?us-ascii?Q?BvhzTAY9gQeAHXgx3aIOVmdYKMZ7y4N5SgjIcVkhXM5QxJP2XAPXrd+vdS3R?=
 =?us-ascii?Q?4J7mAc5B6pMJ4IZSsfwmS9Qya6rBR1TZwmjPxw3sSqFi6HjPfBUW8j2MHMzs?=
 =?us-ascii?Q?WAOzL4rv7T6m8/I+keK+afNDxL+95aqrPOQBX3gwA/v/pGc73azrNF0R0QIu?=
 =?us-ascii?Q?tkHdzjIso3UmaMbx5vQqyDZrhjwQ4s4LfBt9CDAWPrMDC4TaCphPg32KODcr?=
 =?us-ascii?Q?T5/d0z6G7hj1ZoyP+K/3O+nAuk0Nv5m1Sn7kXY5C1yzKGJwQwYoyC8pthzBT?=
 =?us-ascii?Q?paEU8/lvpx3K/w8951KDcBIPakLsQHpbHvraiPU8RNk1u1+BQam2B/3iW54u?=
 =?us-ascii?Q?fa3zJrSvQW30NeLLPlLeR3hXcymY8DfKwFkaGylFEYZA0w04mxgvDIrLojVF?=
 =?us-ascii?Q?w1hIM78KP1Md+0Z/ubKOb/TwOa1hOA4tb45WsAxuNwTJP+4r/sG4Gtjo6sLW?=
 =?us-ascii?Q?xqeTHIb8DF7J4cXT9eXVLWZl9phFi6Laz829SzK2n3SNU7BW5on0RHlXI3Mk?=
 =?us-ascii?Q?iZOUojkT3meirsIzEpfiRTeLouT1EAEeZaVOWMTSWerJMdrl09rGC1tdtn8J?=
 =?us-ascii?Q?6Zye/9gq3vzzseREPh5eY0Ypf4g8S7hT/1MDBxQBimBbnxC10ez8AfIztS3J?=
 =?us-ascii?Q?rvXNda/zfTHiC8SPmi0xAo/hXkXxTf/iKLhHqrL7nIMdzhC7tjeVJs9vodJD?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aebaee2-62ea-41d4-e584-08dd6ab1aedb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:56:13.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJkLwR+Nms4w1CDTEV9k7EZDr5f/ttqTTK/9sPQERHyz8ZOI56SyAAjaS87F60XzXR7oriQfdu8LculIjO/of7nj8QAivA3s7rHYXMpBeDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708

Ports that use SGMII / QSGMII to interface to external phys (or as
fixed-link to a cpu mac) need to configure the internal SerDes
interface appropriately. Allow an optional 'phys' property to describe
those relationships.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 .../devicetree/bindings/net/mscc,vsc7514-switch.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
index 07de52a3a2951..ea741be8edd74 100644
--- a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
@@ -37,6 +37,10 @@ allOf:
           patternProperties:
             "^port@[0-9a-f]+$":
               $ref: ethernet-switch-port.yaml#
+	      phys:
+	        maxitems: 1
+		description:
+		  Reference to SerDes lane.
               unevaluatedProperties: false
 
   - if:
@@ -54,6 +58,10 @@ allOf:
           patternProperties:
             "^port@[0-9a-f]+$":
               $ref: /schemas/net/dsa/dsa-port.yaml#
+	      phys:
+	        maxitems: 1
+		description:
+		  Reference to SerDes lane.
               unevaluatedProperties: false
 
 properties:
-- 
2.49.0


