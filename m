Return-Path: <netdev+bounces-303182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HAMvFaLFQ2p2hQoAu9opvQ
	(envelope-from <netdev+bounces-303182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:33:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C506E4E32
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=YXQSIt2h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303182-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303182-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19B2D3009992
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333027FD6D;
	Tue, 30 Jun 2026 13:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9783264A86;
	Tue, 30 Jun 2026 13:31:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826274; cv=fail; b=Xd+ei2qc9y8V4qFyJOdH2N2W/6NVJKVs+rxghP52vzk+JzdLd6KD2jkGr4AKeSYC/UgWk7U9tjiSF122prRWSk68gaFx22KSvbKk+mQPKeg/cSD1JpoV5t4Ld6y+4xgTiS+2dm+sDE9UVC0puosJvdTq9rkFNZ3g/ZBMoUVpxCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826274; c=relaxed/simple;
	bh=lTi8RwDSf/cVwjN+hoI9Z1q12hBrGhcLXT0cwjelrcw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3c5UfyEQUYw6yqQrSMtfR+wXpz4M5CCOPmxyFdb+a/sZpi3sUDOohSd6uTN9Nv+k/WZKcGZpjiVXahPk9ZF62pDBqhXKsXpfSKeLnXTxxoQZYLv01ONi/L7vcJUlvOojSehPXaKElEKY5o9myUZKUrJmCNMnjVQTdCWS1aWPKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YXQSIt2h; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFcY7DZF4GU8V5Uwv7K+QZVaRPzRKB9HG592V0ifXxHUCiRxuWnQ6I+HB+pkdg61YenSeMmKb6bKiwF5VGixO+2yJSW0vPDCvHZhnj9qa+z1+CO6e6urip+xq77kPMyt3n3RcQyfFhKLv0JGmmBK2OV8pZ+OboRlghFT7uSsFwoRT2jYH9fXFiR6fWSglopZiQyN1PjfCFprq9t5rXr25+RqeWUZn4cNduV8oHxge/DUJDLggU1yTrKWb61ODssNSVev/O8MX46KQJtt7itFRfRnMAUtFuuoGk6Gb3aAv5Bm5upzcU5KGMtuoj5mjdVjRZXPW4kBIHpMlyRcB7ZTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egb+qkBBsK0jKpGGkevqNSZWERHgAMVA1ALsW8FN87o=;
 b=AI8DAdWEK9EP6Yd5l9dXrHs+5IykrnGfAxTwUbFYC9QCkZxv/mPCYw0Gb+cawXncYLWeSoEM8O0me48ONCr2aEVgEDUZvcqHtIjvaLLuXQ4kU+m+YrRhCPuFjwjrmt2BvjR19krUIOM1wdJfvp5fJGjnbw33TeW2H2yIjn/y0v8WTML6LiQvAASgn+7p+qMlZvzkCgxa9oBiFftz6jajWCXWdQSX1V3DjJAlttiIb3F2hlGS0uSJk+n70WPLD+Hc0IIJZIbE1Og9iDaFcLbBTRCKOl5z81pk/qGEKbbwa1c75/EjpAfOPHXLx7TQmykHuo1MhdPcMFYM1PNH3nE3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egb+qkBBsK0jKpGGkevqNSZWERHgAMVA1ALsW8FN87o=;
 b=YXQSIt2hED7yxoR521SImMUTO/yqDpmn2KwsE3JLPFLrkky9VehidqwowlSPyDc2CGm+CwRZUEhgfOO+yIx0n1JX+zPUT/VV/x+CxvlZaJaOnnM/HUmCiUUGG12DznS1gmLqciBScQTzieGD0b2UIYMx8vrmM1zzHjUTlgWhnMGI3eFM9i2GTl/booYqhITF84okR5biAUD1z3/C0zI9cgRXLIYX8FOQbIXIqPPGDk0pJeW/R2NLh57fYIDcjpH0mAC2GFVCboUmSlZ06N8UrCiVFLMOVrLVuZKVn39EKqxqerYVYZIgmsG4+OBtynH3Sy2xILAZMkJQu0o94f2new==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA1PR03MB8216.namprd03.prod.outlook.com (2603:10b6:208:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:31:10 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:31:10 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts/net: stmmac: Add Agilex5 SoCDK TSN Config2 board support
Date: Tue, 30 Jun 2026 06:31:05 -0700
Message-ID: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|IA1PR03MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2a124f-dc12-4dfc-5130-08ded6abd8be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	N+M5xnRsbr+O+iXpLh2cAlZcGVszQqR29xrXewvVMaNOzU/yh7uC3PQ9zNl/K7I0Yn/AyOSBgJd3XG1llhJxPji4/l6hhaPlMyYCtFvFOkt1Rbq9UTDIR6P/tOaWEOvOzSNg2BY+CmiUwOlVuhTcvhGbKw2bFGGFuUwbt807/TxDR7/W6M2m0+zk/kV9ZrJ0+KyLxzeuOsAAML+Fg5n9F/dGnH3ReFkAt2/xuWzPAadSLDh0EdDZzeb1qRkLJ0haP+0QMd8SlYXBN7u6ZnvgiN2BIWPipaydpLIun1ywJK+NB98lOWfk2rz7fsEouo57hOIMfNi43yKrMoeLB1bIlE+Q2JkmeE9weKR+yJx1vrrfMAYAG91Tvdg6z2oXzbpnMuq6RjbK1tXeFAS+bfN722UsNgXszGi/Ym+z+C6ULeEjoYzg0BIzpyBH+tljKk0BFINqnd11nQBpRQrSBO4RAfcv8PGyEjUEj6QSdCl/SjqP+f7PyuYOaiu8kroSXb/b3OaJvReaqS/9wvpS9PFlXYimRuoJLDAYk631QLxCSafzOufvALBExCXrIVg16i9HqTZwR93OFhHStMtHfRXYc0ROuguglRuggCOA7Ez8y2w4Ef3S4dmgTu7YEE+dZGsDLLRHKVSmT8MGz42Kw06QpfePC3olnSYFgsZwPU8hL9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvIC0kiNBhwYdzqM89PesF1aeDM1bxX1NenpOM66tKvyAl5p4MIgOUUG8VUJ?=
 =?us-ascii?Q?kiJ/sXz15Jc4DqkE2A3iz4YRcU18xPBrK60bcFBgt65huHoG/mMEyfFHVuS4?=
 =?us-ascii?Q?Vl6czIkuAhkN5xY6LHTj/iHEEwV7dguDasiH96AsRJf0QXftrysEXiunI3Il?=
 =?us-ascii?Q?+ypVVmQ6MWoSeQv85jwBqeo5RuVqLikAH167hDb5yaLhmhPI5vuDJ8v581PJ?=
 =?us-ascii?Q?kltYbA5lpchcP98efRgsPnFJ9PyfLQYD+4a7wbnleos+V1Nvxz/RkykPWvGt?=
 =?us-ascii?Q?Y7rDMKl47iG5ZRliEz+CyxXILUGSppokxTNtHq0otZPO0WQRsdrVjNideLHb?=
 =?us-ascii?Q?DTlNiR6vvo1dmRVXB6qse7SY99s4LHdXrzKBaMlcgguC7uaNOJkQk9xC9fSB?=
 =?us-ascii?Q?R+GeaPTdD13+CEtp7ioRm7g9BROMvkp+yNJwHI2h7rRrtKuWapVLl40avQkf?=
 =?us-ascii?Q?zXBrez5lnwq4WCp/X7goQfaNNCn+g4MFt0ymFNa4IH3B3eeehkIO/KQOrYXF?=
 =?us-ascii?Q?mq9mkeuOrQ6PyVApiFKDTKEh71fCMsP1P44ZbbpKGxvWw9b7cxa4p6BuVo17?=
 =?us-ascii?Q?p6iv2tjqYDjhpLUIWYgMazeI6EhjkGxkELQIsP++j4FuTzek9T/aOSzo0Ly3?=
 =?us-ascii?Q?9L2ZFWhp0W8zuHuh9PNCx/2zTPboyMwx9zeNQpw0QI4IOJuysyih//xm5Y33?=
 =?us-ascii?Q?SFJ6InujoQKAcR40c2XA+A1fRxyml9gWtg6pVFvTZiMGweNfuKKrHau/InrD?=
 =?us-ascii?Q?qWBA39IMJSC0+9B5P1cMsnTCWIOWuW++UizHs/ZP8KNFfBhWpLZqQqA27ijv?=
 =?us-ascii?Q?pP7fQXkAMSrzfUqkYSFq1Km/Hu0eUIUkjtN6gr0waJPgCaWbK9TxfxBW6hit?=
 =?us-ascii?Q?MlCXmnElqLepdJFZcNGigkYq+LuymSV1GNjb9BCAur8KzdTqNvdkkLUq9LDF?=
 =?us-ascii?Q?UISLMb56C7k32zpvXZL8b2wx4OnwpP+kfps26UaQVrHyQ3hHZVY9bHRMdySw?=
 =?us-ascii?Q?8R6rgdEDhalu2HXR4g3BRDsZjwoiAIrDLZAJbGn1wVNi9Nv/PhB5bN2BP2qB?=
 =?us-ascii?Q?c6NxpxfjAcaqGMiwuHEXGP/ZQceRWll70vK9nVe7qxRkoPpYmCa/eiQ725z6?=
 =?us-ascii?Q?37uYRk0QS/Nudj+pnynAvMEjR/c572ZWvfOwb3v69sVR3L5S5f7VFfTM3TX5?=
 =?us-ascii?Q?ziejNfNt3K0UB/SuNoUIMInXhAuiQAb6Wiih+vAQxTbAS+6PS2W8S1FmfMKA?=
 =?us-ascii?Q?kMU0O3TFJHLY6mrpy0WaDuNymDHHoCHVqt1qd3Xb+yO9HFySGNYzgbdeEg4e?=
 =?us-ascii?Q?gojz8H73tEqfceMue+y51H6pC2TPZwOvUhqE3Tsu6b1RLN7b4XfK0GBrvcs0?=
 =?us-ascii?Q?5+ttlQs6C8GZK3pCXdMt73ziO8aqJJPjDmrCz00nzW1j36UArHochF0JkPMK?=
 =?us-ascii?Q?BZX5NN3twsH0NwcI6AqBt3TzrmfXOGF7WaqkKPVkrN/BU8aGBKl/fWQh0y0z?=
 =?us-ascii?Q?lSE4QWma5gToulIpEeeYx0mJtPZKu8O0nh6UTqsKF7E4khBVWv6SR/2nQhJR?=
 =?us-ascii?Q?f8nHeCZA7Jy8ZLrucCiiGj5VMKjkPGAexeBOIB6AaVowmWBCu+D7FjKClgmb?=
 =?us-ascii?Q?KBt9giWgsAJUn8cBb4raWq5AmHEakqNCnujiJVMK0gWpHN0Rp9NfdVbiLIcN?=
 =?us-ascii?Q?onjoIkQ7L2fKDV8ViAZgNOGzozWl8NhVS80+DNj3xqyULgX0EbpqyuCsqIKY?=
 =?us-ascii?Q?rhAtu19G7LR6zdj97C0WnU+sCth69kZYpnKZ6A+VuvqSqRbkF2zjxTg6rZK3?=
X-MS-Exchange-AntiSpam-MessageData-1: nV6J1qFhv3Apzg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a124f-dc12-4dfc-5130-08ded6abd8be
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:31:09.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hwJq2eY1WvZAPDvo9jwvzlyPaWwzKdrQi7wzdyZTzvsl9KMlWnDj1YOFlv8F3gkHExYWOktxViQWQ7iUpsFFhMqN0MVQS8VC3fqF5U16GN6n1mMVWoKfp21r0AOxfQIUtMadnYYE1B/YW+9E5Tfyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8216
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303182-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10C506E4E32

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The Intel SoCFPGA Agilex5 SoCDK TSN Config2 board uses a dual-port
Ethernet setup where gmac1 (TSN port) operates with different MAC-side
and PHY-side interface modes: GMII internally in the MAC, and RGMII
towards the PHY.

Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
use phy_interface") replaced mac_interface with phy_interface in
socfpga_get_plat_phymode(), correctly noting that no upstream DTS files
set the "mac-mode" property at the time. However, the Agilex5 SoCDK
TSN Config2 board requires mac-mode and phy-mode to differ, causing
ping failures when the MAC is configured with RGMII instead of GMII.

This series fixes the issue in three steps:

  Patch 1 (dt-bindings): Add the compatible string for the new board
  variant to Documentation/devicetree/bindings/arm/altera.yaml.

  Patch 2 (dts): Add the device tree source for the Agilex5 SoCDK
  TSN Config2 board, enabling gmac1 with mac-mode = "gmii" alongside
  the standard gmac2 port.

  Patch 3 (driver): Restore mac_interface support in dwmac-socfpga by
  reading the optional "mac-mode" DT property. When absent, it falls
  back to phy_interface, preserving existing behaviour for all other
  boards.

Note: Patches 1 and 2 target Dinh Nguyen's SoCFPGA tree
(git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git).
Patch 3 targets net-next.

Nazim Amirul (3):
  dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
  arm64: dts: socfpga: agilex5: Add SoCDK TSN Config2 board
  net: stmmac: dwmac-socfpga: Add mac-mode DT property support

 Documentation/devicetree/bindings/arm/altera.yaml            |   1 +
 arch/arm64/boot/dts/intel/Makefile                           |   9 +-
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts | 133 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c          |  23 ++-
 4 files changed, 162 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_tsn_cfg2.dts

-- 
2.43.7


