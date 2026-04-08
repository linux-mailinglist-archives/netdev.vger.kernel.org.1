Return-Path: <netdev+bounces-276363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HQvEukW1mkWBAgAu9opvQ
	(envelope-from <netdev+bounces-276363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05A3B9535
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 725C4300613D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525313A782E;
	Wed,  8 Apr 2026 08:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDC36EAA4;
	Wed,  8 Apr 2026 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637882; cv=fail; b=F3CQR9LsIRU6Mj92q1vKP/u/jYVOdbmMuKk7nPZi2Mol/0LwluxBIi7JV52CImi4bdbzUV63RDJRAxxnClXlE029290z7AQeBBXRdpW58X5GMCINChkGxTSaJm6poDW0jP4hTGpfalGWLDgUebptrRurzYrEutoDNlwLOhsTLsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637882; c=relaxed/simple;
	bh=qCqAHzJ2SvPqvZC9dwivlyZen575iACj1YQ8p6uG9SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTWKUru9Dgu02CuE8kSDAI4Rae/6T8fJStmpazJ4FNuFsRI0tjUi1GTaAKxapcVMu/hhE8Dcv+6LmDWQTbbTxEWf06IuLr9susEmLmXNYhyTkfZNZeVU5nfEpwD9WZVurVuacU//jrmVn5gG5KDnurfPpsSeJsWBfH7mxRUFfXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/brzEhUAKADELg0/kCKhmjqqDuNzX/1W+9pGl72oWRDOJj1ZZtZrARo4hd96uuW81AUOAT0I3iT2teCy+OJclbE47TiY+rAhi3Vc7thOXNmNVhQkf+h2IDznFG6X8BV4SuuBIvNTbm/4ejW1YoylNVo9e17Ciu6zAcVKib7LdGVr90lD2AgY7NAQTEKlHPdMMEAbaAr8pzntEBENW79BoShV9ORTXQyOPaPAjbBMtKTCaDt9GN2qhorP9basusiywwPhr6HTGmgVt6hejosgzmqgeqmz5oKccSqK1paWUA6rEEiI+IgHQbCeOzcG6/ZrvNHhH0rXp2sdG8Z9dImGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i71hVdTp7nIZDfEEoJFGmsCjX4mTAqZdjdMemIA5FDg=;
 b=PYrUKppwOGBQKc0T7/0XFXEcBDT/tWhJtREhPW4EagJypwMm/OS1R6YUfBrp9Ll92KHZtO+lINi63iBsE7kJ5ffpu43H5dtWN9ih0U25OmBmCDfmfGGXGERaqKMWQ60GlGZnIKrcnIy0q6OfXPpj7IJTvl7zynoi/h6aJuW0AZZFBsAM4lP2o7tEJskSlakQDhRz5iq0z/bF2haBYf04hC92H0A6txHdyBMpywviXUaqRD/wK+ktomXV1xikhUSOUPUCAb5pbJ2GzwGtoUi4Vd0sNDZsnafB0v933IRZZnpKsaTruLmQNdRw4I3wyzxsphJPNYaz96kK0f5dkwa4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:26 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:26 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 1/5] dt-bindings: net: starfive,jh7110-dwmac: Remove JH8100
Date: Wed,  8 Apr 2026 16:44:12 +0800
Message-Id: <20260408084416.29753-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260408084416.29753-1-minda.chen@starfivetech.com>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa485cb-82f7-45ed-db02-08de954b0a60
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	8/a4X5seQ2TnUqOvOpQKIt2iFVp3qAPju+h+NyZO/qFIGrFpPb6ujeeVtMHDBCqvRoBKd1bodFrSjnYWOw1NUSIumLvvKAK7F0kend4JKCLqYW4zUS50VIaWqGiD1PKirqEdvtgHZzjfxVBK6Cg41YD7kwVRi95ovVKXInzxNbdx33ycIRpnB4F6BrLBhu9qC3hXgTIR/jPCTlBv8GXqTwJkmxmf1VaB56x86eLtGdUDENVrnz9Lww6Oy9J7cY1ssb5NPvUI+oPn7sza3TEPX6e3lkaEAQZl++qOoxUV8QijuZ1r7AMuhBIsoIb9vtQZoipFHTRr7KZFdLuNJu1baMzr6oXL6oGJo/6AexnCZuje+UvVgDd85bezxBJ4V7PTQR152f6nw/cgQ9PZfKhVEeB/Jg4GgQy7lDMVWN73sfy1y/738iPQYHjbW47mEjoH9n+8+CfcgWs+tUSxcNeqazcDd5ijNx44deGcYV/etTDTo+OH3ylZ9n/oQASjctIZZQKp7K7r1LhzT1Ca89CB8lZ1LoG0iIgJUnwx+fgxYKWDCroM653VeFS2tVyK23mc7QpcjjBlLyL9vPCQe9hEVKaWi4MshRMTtxUWOFjXTbQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YHU6VU5JQJzi+GGjayDsayxHSmrYfpAX70Pizq3qSrzGmg1bqqbf8RivXATP?=
 =?us-ascii?Q?J1weQ1+lxFUmm3IsshXl12SR+5lIh7LdIRYlD9wMQaK0luk9JMVdUsUF8ETB?=
 =?us-ascii?Q?vzEsm5mExSC/So4jENhPnDgxActbMYwPOUMi5SUMZvlrlpuVABtJdVK+nQIG?=
 =?us-ascii?Q?/SIMPxbk7PSC4htrYDu7ymYi1TpNE98bFgDm5IkEmKEnE53h+Gs49w6PxDkF?=
 =?us-ascii?Q?Kk9M1qtm7zzy9e5Jv/HoBo0ZVq1X52WYpa7cqJPCOhbT65EK5HdnwFY0Ruor?=
 =?us-ascii?Q?NuZtvoGVAAUx0GboYEiWpfDVGTpvbWt8OG0OGZW5saa4x0dmX1fAL0JqENGc?=
 =?us-ascii?Q?Xr6wfI1DsUeY3VRs2ZeXMOMAbUTYUa4QkLo15iZxOnQKRR5i/LzEO1QI+sXf?=
 =?us-ascii?Q?ulv3qxWJuZr/n+etg6gkrXkymR716UD66aE6CajmUf3P9j2wLVdEw5AQGyB2?=
 =?us-ascii?Q?OqPtR4Vy2p326VWRvhLBmaj0sefywJGQrH5h0fMyGKtEJZYfnMNyhAdzJlU6?=
 =?us-ascii?Q?BrdHiH5tcy93u+27HZjf7DAmQrkpYoU+5zxXj8iUP1jcl32DukUwb3DUhgeQ?=
 =?us-ascii?Q?5a8Vw4oiCWSbchzYFuwm3FUqi+4o+3voN5HzKKWwDz3sQm/WQvoQ1t32Zkg+?=
 =?us-ascii?Q?CDC9wbJnKBvnHPgYiyCf/bRfx8FbOl1rIzhTcUv+BYoRcLTEPNpvco7lE4VQ?=
 =?us-ascii?Q?TVY3V8Aj9dV7534zAkvY/VSgkOqkdJQsWdwcQuN8SpJxPtxLL5WcJ+PvXjyB?=
 =?us-ascii?Q?osAHMBP8qT4h4nll95kB8/70mroKpsjBqdGrvfUgI+pLa0jnYFYn2bOf8hnN?=
 =?us-ascii?Q?mbQTml8ppBBBxzvz1PEibV9QB1ovOCvCiqgGk23ANKIod+kIMjloW0//m8mX?=
 =?us-ascii?Q?P/fdeAWrgLflbZV1wYeXM3vyCOkupSDsiXO+rbgVUag4iJdjfdW/BhXNQuq/?=
 =?us-ascii?Q?uYrXxkNJHmEuR+imKVI2PGPgaq14DD2sV7Dixn/2J7tzA27Y05wuN9ZtcReO?=
 =?us-ascii?Q?Qp6Bx4XcH2RkQraf0gaRZzkoZDirGy+hOsyq4lV+vwh2qz9IxrvKm3fSnnDE?=
 =?us-ascii?Q?eZ6rkNrPK1z9QKpLW/QVUZAEXG3SoyOTMs8IRcSe8spWwQisdKGUjYZ7MbCw?=
 =?us-ascii?Q?mlI8yr9vum/LNg7x3teRklj/Gni/l+ciso/8VPfZalwyAPBV0wc5KYt4rRLM?=
 =?us-ascii?Q?pcXUSK3lYwPHSTUovICeaPwgMoJ5mUUXIeXEvrH6JmpyoE1LcS00veZ914dS?=
 =?us-ascii?Q?n17QkBuC/8FN/LpOPQfnixTFc+siI+gipM+2Jh/Ujl9P/yk/A3ZlEwgJer7i?=
 =?us-ascii?Q?tf2ov4/l27q58a5ImUoH1EqWN1Vs32wuaYkgRHpY+tWA034/YKJr1Q++Crxy?=
 =?us-ascii?Q?gn69u5HSe4jN7EK0JQNCAAqRO1EW+1dR3elvMaAi5oOmIpD08g72rPUgHTgO?=
 =?us-ascii?Q?37+B+M68qOmZy6A47o+GGPwVb69F6voOq8cgxavznTelo8Jo/4cUzMLkhD/5?=
 =?us-ascii?Q?F/cahhB0Z66X/ZG5G98P7Tm8Kg5S1DSMFtMCn363fN+Nm1dbSOrj02CV75CE?=
 =?us-ascii?Q?TmvNgBebaxKXvj/3xxuyA/rH2us5C5vbMMlbS4ENmw0Ural/pCtfrwV/OBOD?=
 =?us-ascii?Q?mg3ALCR85NWjCKjp3twCQjt+UKEVMr7Tw0Y8KhbJCcWpcFJ4UPOi0PBMvbhY?=
 =?us-ascii?Q?FKAsyg9hJV2uM03hjWyW1c5fFAFdJJgqqoLsjRDNv252tUkkICHXQmWtD+q4?=
 =?us-ascii?Q?IMcRgy42yToZmhmRt9p+c88t4+6Lcis=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa485cb-82f7-45ed-db02-08de954b0a60
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:26.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q50ksj1Be7H0X0p3Nmnaf16EOPaYbVgv/9/+BYbumUMQArk0FXJdrGjg+C2vNG9Qv2FgXrIzs5OG1lUpjBvZSLr8C9a6a5ThKRujlru+Vyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276363-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.547];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB05A3B9535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove JH8100 dt-bindings because do not support it now.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 313a15331661..0d1962980f57 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,10 +30,6 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
-      - items:
-          - const: starfive,jh8100-dwmac
-          - const: starfive,jh7110-dwmac
-          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -120,25 +116,11 @@ allOf:
           minItems: 3
           maxItems: 3
 
-      if:
-        properties:
-          compatible:
-            contains:
-              const: starfive,jh8100-dwmac
-      then:
-        properties:
-          resets:
-            maxItems: 1
-
-          reset-names:
-            const: stmmaceth
-      else:
-        properties:
-          resets:
-            minItems: 2
-
-          reset-names:
-            minItems: 2
+        resets:
+          minItems: 2
+
+        reset-names:
+          minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.17.1


