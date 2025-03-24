Return-Path: <netdev+bounces-177034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13EA6D6B5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5131892422
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9125DB14;
	Mon, 24 Mar 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="gp0lrz1s"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595025D91A;
	Mon, 24 Mar 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806557; cv=fail; b=spP289z390Gvzuc0xqknzi3Ajg+kWfgqvGcCYdvhRYEoYhbu2HbOT09IlxiMpEjVJjzC4UWnNyOc4129Wad8xi6CQAWGODX6uLQuuJ+9wuQS+RoqsKJtZyuUN4qnq7kmwIEZ9Wd8C/d/lPd5SzBpvJ3PEi/8RPxCeqziHZXh0Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806557; c=relaxed/simple;
	bh=0RqZPmLNr2neYlmRZMTgIU877fpKrY1/645dlA5ai04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTHgMqNpuSSpVDU3aQY4yy6icBilmN4N3En105OFb3kU039EFROy22SKRUKysoMiPL49YBAU9ULU9hiKfWGz8jVeiG1OOBAb8koSdSfMgt9T6s7MWMpyp6lICScEp/A6+nCXSTAjX3fJ2P/kw5HfjDtcWZ6LUpKRhC+qjKJorcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=gp0lrz1s; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiGF6utb862rmhwFZt+swnmO+yFJqzwCzjCsky0a+73Z6Wd1J3YukaPTX5bH01JNeoIkNsFdrfpFZvkUoCmb786PF5lfKdo8WJH8ZWj4u2svH7l1wBrnZtxT5N4PyM7ZoLVODfTBxkODJkPHsNbbzzwxZf2zMeRnvAtss2Kct9IFIr6nCePSNXSILPYkkdAw4JFxjrbdix2n2PF6kMVLJAviAt6UW5IpbTK6X1cfDW9qwejkCPBLYKXbRMdCVjyPOtN7auL5lWushqcOPYf1GHVDHtif6KYCK8EePFTH3T5ZIweKe58VIMGa/V3OFf1YAgskR14vnT/b4d/xIaHPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXNYvfnMBD2cn04f4BG+Dk1W8cMw6ixN2jJt1ynsJ+M=;
 b=Wyj/BMQhbu7JLMFfXxQnx7B3KtQ+omyZRtuKvREV3/mkF3w8qiBwyxTqvH6haSW9lwXhQKrxerrMPxmJzlXKG6hL81JLnZHJ6gdmvDKo7qLFlahQ0WLz3cxWkTLV5iCF+J+5KLAq8eCNKjq6JMnQ78OPdKvRPn7zH0x3x4NlkSZ4ma7SBv40l9MI9PD6t1a72mBXjH10s5xALi93QFgWN8IXSxAPr8693nsWwTij7CmqC7Y1oGYn9M1DL59yGgSQ/a4rYLJl+YISvPrYjgYCrh0qvelfo2mN7Ww99bpbZWfKpgb62ZfLL4hM2HNLarupv1Fh+owA/PGNmE5IfHdFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXNYvfnMBD2cn04f4BG+Dk1W8cMw6ixN2jJt1ynsJ+M=;
 b=gp0lrz1sfRZ9yjZRRv/lk/TC5SO+Xp8Q9dp/XUwm2PS00dRcDJjuVqRoXcTqfj+56ZGXwhI1nZ8aZPLn3udaktyz0cuiysb0NKJUu7A0PfOXH3TqRqhaRF8P9KIrNd+ctTKUR7UPp0E8XsqARefJZDYP8kKCmyLEbEVGuMVW5I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:55:48 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:55:47 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/2] Revert "dt-bindings: net: mscc,vsc7514-switch: Simplify DSA and switch references"
Date: Mon, 24 Mar 2025 09:55:05 +0100
Message-ID: <20250324085506.55916-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324085506.55916-1-ravi@prevas.dk>
References: <20250324085506.55916-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::13) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: ac58603c-a254-48c5-1e8e-08dd6ab1ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6rrJA6MlvZEVURSuBMvUUy/9QK7I0N2Bv4eJ4T01nKCVKYLvfglr7YsK0E9/?=
 =?us-ascii?Q?gjiDftEqQWJqalLS/Pq9cXK/bUcRVLRkmz9HIvZMy1gwq9W0Yes/tT+2FmLO?=
 =?us-ascii?Q?PJABMOvIzL8RYHxBoqKKOiirE48/vU/PXhHD5d+liCl9WTLYML87uTMOVMGJ?=
 =?us-ascii?Q?/nnf5/G8MXiRivVAeSPorogcXPOJh6BRCx/eP56nUG8CcnSwBsC5dGdLZHNO?=
 =?us-ascii?Q?fpZC7TmGe2rZY0Ho/qGnkAdCGsZZh+FM6jNgaTyRMg+JTUt2za2MohwyYS7o?=
 =?us-ascii?Q?oZKmdvxR+dtXSrlK4NgalRg4mlUPQKDw035kDn2YlqioLJUDVnkWFN1yLp6M?=
 =?us-ascii?Q?Mw6PHhDpLrCEtfl3vjydnF9kVWuaaRsaBpKbEFTC316cwCyYNEbv9dw7v3yB?=
 =?us-ascii?Q?MyIfb+NOFfClBG7HloVdW8Yw/1N4OCq+Erq1axmcEaEOU9D0abBzuq7mXyqo?=
 =?us-ascii?Q?531Rei6B/nB93uxfJl/qnGp0U2Ji9yP0ElVWJo9W4+KyTOrfqxCWhKU9QHqD?=
 =?us-ascii?Q?LH8vLC71USxK4A8F4xV9Y/BnBlPuQyld2eBFlD3amcKSzy+bGy2we/Dtiocg?=
 =?us-ascii?Q?IKNIxa/KNfN4ALweTzsfo38SQ39+CRYWADooscWvdbRILnV129fRXIg0zp24?=
 =?us-ascii?Q?6HdFlIU0WZabLeI2jk2IsJdxdV12dR8SgaHpi4F3jjOw7L8o1WBjn6qw4Cj5?=
 =?us-ascii?Q?UleI2jIANf9oNuxw51BMetY3+macf1RuLFgnkCZoZQntmYcYup3qSu/qkszc?=
 =?us-ascii?Q?bQV9nq+P7jtwkOJSQdcL8tctQIBFm7eB3DYYIC2eFgTEbFuqSLiKYYf6nsC7?=
 =?us-ascii?Q?q0KOqCTTYmmfDI6IhzL8OR6/GUKqpI4nIWseVcZo7PLxDg1FOzbUOekm29U6?=
 =?us-ascii?Q?iIQVZ2pfuI5JgfTGcR31jwn2PG+oBmg/GJmv646dz62WXk5LZmBj4OS8BIKV?=
 =?us-ascii?Q?K/t5rTvsduH5k2B0zkpbvnrpCQloMOmoKGzqZLzdYVUJJMneGMTPwkvFR0bz?=
 =?us-ascii?Q?mrmoAOPISmMW3q64T6tizRUVoypedXIrbZR12C7Ky/aK/sHmCoCdmu5JgJTP?=
 =?us-ascii?Q?XCsE3MWQ07vCfmPfKsDpobFYjLtjSoESgrwwl6JThTvcYHMnnHjrZAmKD/H4?=
 =?us-ascii?Q?viaI3FIz3UuwrFoarYiIfsWqwdoo+dWeEX8MQOFxAxRTXI4f9EJwnRGwgPrP?=
 =?us-ascii?Q?Bss/lATrASADXz/+CP/PkU3AFNbf47UrrSz5Qx8n50JkuSbYrsSHzCPOh5gd?=
 =?us-ascii?Q?vXBYIVsHdZ6P7v16c+EGg63635fPxmd08QMSna/vtYzQ3BUAzvL6Ox35YQgM?=
 =?us-ascii?Q?Pwwv0R1AKkmd31CWx7xKf+bwXBqwe9SrkK0ambNEu7h53h+uMI2LX0N6T5rY?=
 =?us-ascii?Q?lAdyWDYAW+MjQyX+d+nELCxsFUDnXO2t1uOB9soiiWCW4PmRmTv2j6jU7dOs?=
 =?us-ascii?Q?+jHJENcemROSWeL1b0ef5dDz48uiXMgd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0MHv/n1LXmR2APyE//3i47uF0ZALWKOMvS5Lo/XyjmXvaTbB2iPP3ogmxbn?=
 =?us-ascii?Q?8Wx68vVaAk77mGs67MmlkZbcGlzYpkSty7z8slTqUndvO+NkoaU1Bty6I88u?=
 =?us-ascii?Q?0cTS2+wbUzh6TKLMCvqhZBJ/FA4bpdXKRNAxlPeTjlLhYv9+FPh6qYIkiRUT?=
 =?us-ascii?Q?2lpeUsYRdyZuoV9yCPwcwJB6da+sWMQyhGWnuArtPC2zxJrYDRU3w/AoSQQT?=
 =?us-ascii?Q?wIHCSQQnIfCKq5AxSj1NIr+6BmG4em4hBDJFunuUs8R349/XMrr8NBSQ6ihJ?=
 =?us-ascii?Q?vdMH7UBQT12Wu+09M3fT6kvyQoNpm93ooVDz8fJp0BcHyxoyN76z9ll6o+ih?=
 =?us-ascii?Q?/QGXrJ9ABg2IAbRfhqlYLagTZBAcZnDwVTTsCZ65a6s6E1Yni0F5JKx58gbi?=
 =?us-ascii?Q?CHs7CpH3Zmr0QmL3kT7J/b0gecISBZC9ho66VcCOBPx5HKAlnHFlC1VibOhV?=
 =?us-ascii?Q?HnyRu2iXRrV9xwLa6zg57PmKQ09qBR6jdVmwNSahoX6UiAitR0pjt1oieYkG?=
 =?us-ascii?Q?KPKtEq6OVcP4b9HgCWIbcjk3Ob6E8fxTDQH3RKsDvm0WB5/tf/IApO8Ye+T7?=
 =?us-ascii?Q?EiwNZ6mCKCXGg0RbC+SiV0ZeAcGemtgGynp1Fq5I+V+P2+XwEjQGnY0qtNmg?=
 =?us-ascii?Q?Gu9azchUtrgMy7CqAJbEtChX/HXZme1ciKpDafVaE69aX2qVqsMGvLNpK3MK?=
 =?us-ascii?Q?FJG9XeEmKhys17P25NnsHmPyS9KtJePh17RQHSC3nai6XHe0tc/3BzcfKTGV?=
 =?us-ascii?Q?5ipt2XpZOg21cTYtK1OjDs3fWdssrNfwgjOwMNrwCwqiS1yntqk3qfergLRY?=
 =?us-ascii?Q?9C4jmdzAwSGvSz1slOs5n8iZxuS1uled8INbwuWbOJXHTS/r3uOsSprbhnwb?=
 =?us-ascii?Q?H97sVw1bUAI0CQg5ZptJfWgqNTCk3zsYipiDCKtpKti61JEZGHkhN+melB7i?=
 =?us-ascii?Q?+0ngu7ek2/1FUWS1kz+gnTPmwupagicOTCtU22G4/to3hH1uiq8GXtIuEV+g?=
 =?us-ascii?Q?PHwI6YgNjP5pEiQMG446U5bkuP39OXRgPMDhYKa5dO/j+3QJYAtA36rIMkPL?=
 =?us-ascii?Q?3BlA6ghIEKbnKAVCflrP54QXEtlVXwRRba5nj+HqHU/DOvqag3dIToRF0g73?=
 =?us-ascii?Q?mABcgSfh5IWhatGxum7ZUezAOqxeltSPMKZEqk+Wjd+8Gcm5nQOV+SYP8F0G?=
 =?us-ascii?Q?AdUUGAW9aoS7MAKw0TJNQFEd/Zr5aiU/U+oWdbstIL0+xIKNSpwwGCT5091f?=
 =?us-ascii?Q?UUZeYD/u2OrkoOYkiIgjYzyUUIHmDYJv6bDmzBIg9FkRUV0vpHndnBPRaGpO?=
 =?us-ascii?Q?fCCibGTLSh2ehORZWMbLwYAMgbx6LV5Wf2bsjCbQKITz7U23oPW8Q53XBr8U?=
 =?us-ascii?Q?gWr/w9bypRmiqnRehb3oi5gRZnZ520rd4MTFx+d6w40bxFFajfoszqKxBXKm?=
 =?us-ascii?Q?5AUUZrJZhBZcDPMpsGAKSDUqJATzjxGes/cGQ4zpaGavX5dMYlXQl+QbrwfK?=
 =?us-ascii?Q?EWu1EmoPzs6Q4+a5MKFYwDEeEctjVVsrE4iiYEj+QHCaZuPXuyzxcsWkMvUG?=
 =?us-ascii?Q?gXXO7ABtVzC5SDcJ4LxKXlf6s5FaABf/y6dx4XXkDpZxDbaeEr9SQfndKMYz?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ac58603c-a254-48c5-1e8e-08dd6ab1ab89
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:55:47.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7aQjE2iB7pgw4X0SSrdM47hJx9B1q1EIP07/dWqrzFhhvdCvujHZm+twQuIwq66d2iFdgrilOpakmUzwflY2POY1r+G4AQhhY6WrFvJ41M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708

The commit log for commit 7c93392d754e ("dt-bindings: net:
mscc,vsc7514-switch: Simplify DSA and switch references") says

  The mscc,vsc7514-switch schema doesn't add any custom port
  properties

In preparation for adding such a custom port property, revert that
commit.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 .../bindings/net/mscc,vsc7514-switch.yaml          | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
index 86a9c3fc76c89..07de52a3a2951 100644
--- a/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml
@@ -24,7 +24,7 @@ allOf:
         compatible:
           const: mscc,vsc7514-switch
     then:
-      $ref: ethernet-switch.yaml#/$defs/ethernet-ports
+      $ref: ethernet-switch.yaml#
       required:
         - interrupts
         - interrupt-names
@@ -33,18 +33,28 @@ allOf:
           minItems: 21
         reg-names:
           minItems: 21
+        ethernet-ports:
+          patternProperties:
+            "^port@[0-9a-f]+$":
+              $ref: ethernet-switch-port.yaml#
+              unevaluatedProperties: false
 
   - if:
       properties:
         compatible:
           const: mscc,vsc7512-switch
     then:
-      $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
+      $ref: /schemas/net/dsa/dsa.yaml#
       properties:
         reg:
           maxItems: 20
         reg-names:
           maxItems: 20
+        ethernet-ports:
+          patternProperties:
+            "^port@[0-9a-f]+$":
+              $ref: /schemas/net/dsa/dsa-port.yaml#
+              unevaluatedProperties: false
 
 properties:
   compatible:
-- 
2.49.0


