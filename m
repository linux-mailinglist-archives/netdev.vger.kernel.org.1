Return-Path: <netdev+bounces-307332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDp8KFebVWp1qwAAu9opvQ
	(envelope-from <netdev+bounces-307332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7D7504F8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=hG5wuLZM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307332-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E2730078E3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFEF37DEBC;
	Tue, 14 Jul 2026 02:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3530C161;
	Tue, 14 Jul 2026 02:13:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995191; cv=fail; b=Fvf9YU9pVneViEuptmlpuXJjzE5t9nr8FhcV0kxq51FjIDskki44j/DTrbRcSuDCP792hmrZ4QBNOkPAuntDca65j8iVbTLcz7OfBPo8n1gp8P0V2muSvNLGkCFS24T6UMY3sdfkg9dsAjcuMy0+0TUUmS1XaW6h6bwPtLzFwkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995191; c=relaxed/simple;
	bh=TdEGd5f+lmoUUY7ebe8CbGL78yLd5/+kitlqc/FqyIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oin8huurWMsgGYoMWqGrBR1egH9U7bTq6zKkxdzFIHRtpiE9ZF35V3/7G/pG31nzx31DtR6XWOMpWBmiq2r5dbOtSi3KM3MS0UJClHCa+fycsCAASwM/EunYih96wVLaOWHLrw5MSzMKIrVagyY+MtVJBh9Qqsw05eIfQ6TzHJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hG5wuLZM; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFFAk2ibOiSiPaqOe656i305QfeaJpewllmKR0cInax1IA6rG96EaLhi7k9NG0PYIxZkdQ4KerB/oVbAun/k5xYXNrt6C4SaQa0GszCKbQQuO854j6lB3386ikHrtlStjYigw2qAQ4GHGiuPI3MRvo92sy9ebqeeNcKxbyMYkQyZ4BG5olVKC0JCQd96SWiYLkPk33HlwaI/162IUIOz2OZqbR//73LFV/VQeW1Ei2ip/h7giWnObZtH4ktF/OVSJncNDxH6OFZ20ZlKDV8KL0TvhonDXt5BlR/K4s4T516PfmLFafs7TM3ClXQoweU0Sp9f95GmFp0nuMyee9+Uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwy8TmhS2W3rQFf7Woi0Q29KBeUArQbasGbepDlbTHY=;
 b=qL9NC5Soy/HNU9I4khuiKZRJCNcXYKY8xTlICjumoBKxo5au4RD54GjlbepLyW02z49/dAi5Y9UuVF9e2AG7V0d8pLrLgU7NqsuNx7tCoQGE6fY47VVFjJFT7no0/3SmRlFZnM+KAkRL8fNV5RuNW2PmUR/ZzX/KQuBkQXNNT0CoCIy9CfE2xqggN8w3OsMWMGPdXYCe4AiOsDb0kC97L+F/bDIXuYz/s9PiHN47y8iT1hhjAZ9IU/mKqNyJATp84upIZBfNPe1Pxxp5N6SJP20PEH/RS+seZtNCHXwoVnIKxdGlqLmAOR67G3NozFJtcBQqbEUPjyMXDx2aP6r9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwy8TmhS2W3rQFf7Woi0Q29KBeUArQbasGbepDlbTHY=;
 b=hG5wuLZMAsK7VDNl35gqqFYVxIcmBIkkWJLRSmuIr9Dtd92PKKngN7I6lJhlYbbFHkYh+BfC6sV+vhObyqPiN1Y78HY6+y+NbkSQlhq97AYFwnTQn/QULNHmOsmu1xVnRjTMVC+8+En0SetGOR2kEe0gLMQCAYMCc8KWZP0WphsYz9IKi0yYsWUwxvKQ+SAT0HMt6sQ+yzWC78J9f/FQuRoFyGeo2kUvIDYDI/NTxEVnnnSe9IUQE8HyVknfPmIebFdeWTyExxK/8oSXZzuO9tDjm3fZec2rTcirXLSyhaYztu6BlTXVd0svYsuHAP8ItkG0o6IQqSFSNWGUaOsHtA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:13:05 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:13:05 +0000
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
Subject: [PATCH v3 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN Config2 board
Date: Mon, 13 Jul 2026 19:13:00 -0700
Message-ID: <20260714021303.30042-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714021303.30042-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: a175f419-4fe1-4401-0027-08dee14d70ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aJEZg6lt+nOeinsM7mQuEEaB2PwIvnSuf7fBLVa/ehj7eKAMPYjoh0mDwf5rlPFOQ3pkwxMLH4d1a0DMupr27ODhX3LsnJnixXh2D/ZQzId8C1xCOxkpswDVPYlW2FrSni0cIFnYwLs6qLD1ltDRqHqJh60ibamcDiPGDToMtY1j9gTgO6RYVVkjnp8asg8IADlXy8cnfP5z16mQ2YCPUF2qTOx1nk0RSNoP209jAT6odaHA5LehX1TF33j460EHEujZb2c7/sxTc69CDcQpagG3ocl4bf0SfjWXdJlzk9KJh+opK4DQLhNTgqFoPvbQ8IVOThj+oTCXHtRmM/zJxcE1DJU1kgGsYplgpG21+YhsMSTq1OaWPUV4ykOfiC5EWhPvcM5lW/zCbxc5OkGtn5cDcuBx3vBzxW09hH4dZQa9+UZziOv/KrCN+OX+QKd/PeIO+gN7SHYL4MRgrEX6ivLARW5Lw1KQwFzfIYwwanX3CrXzfsPkgDZYOkk6wseCYPAaTr6z5VaybsOmFa0XuUH0dc0grf4GQwyPZg4RWpQgY4KylLduxRRo5H7fHV5ADktJH5wnKG4XPaJaWClsFZFEPgTD0nbGT78YP6pwEfYidrkwF0COs65tDeq0Icrq6svqZxvj6Kchk+4N4edls+gf7OcHVdh9XxVkQZHpeoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xhZK3dddB6HFprAbCjJShwXAsrT+FOyykNfp1BxEAI7zz27tjUjvAL8RmIB3?=
 =?us-ascii?Q?BMK8leHmjScH1807DppEBgPV3aIdxo3hbpleDIZljM9+Pl+SSQQVY/wlrhjL?=
 =?us-ascii?Q?CBs1r2B6Jy7aEdr1jmOXTM6UyBgdcbQFhKATTEb6Xtp0AjLzY/V+ZGmCWy4y?=
 =?us-ascii?Q?S4OxDdPjZDyTCOvYjCmrNZAGeCqpejkeKIhDJweXXtK99CvnnX8vDkhoW3E6?=
 =?us-ascii?Q?gnHnLL5dMWJvlfDk3asHYcIIXX9hzH7Q6XAoTF1ms6fMNXSSzGHP1ZX5vUqv?=
 =?us-ascii?Q?CfLrjrXus61535SQZpwCb75XxX4f9dOK9WDx8AYlKefuunV8sq/sQsklCfxX?=
 =?us-ascii?Q?UcfwaudpQOFUTvCi6z/PJpm1hRkhO0bYW+aPDg+FFm7OEbOk5OwnmKlA4kY0?=
 =?us-ascii?Q?d5yNiJYUUY5aKnodZHUgvq7w8NvkPBSq2h0RnuXcNJqq7qiY1fIRAFqgKy+H?=
 =?us-ascii?Q?HlrijvIYuQSkDlR5r5tKSDxwXyBpIGDvbAZpA4DUn3L46qa9qE5yvFhIhMXS?=
 =?us-ascii?Q?kmfYJ26WynxdpGaiSbGumdC7fDRVCL0WjZdkFSqzzaMWnqwGQDNB7zzl8vlv?=
 =?us-ascii?Q?l5plZpnp4k7SL66zMI9tBl+m4AyxAcj3Zjnwu95myJI5WsIeJlLfhMxKlZw5?=
 =?us-ascii?Q?FB/6unK1YeCoUv1zTfTBhI10hC1VxuakYY5aurEpRytQhXqRU22oQLK294vg?=
 =?us-ascii?Q?pR/dBsgzgRfoeMxs/QaqZdWzrJVY/646y68VoOKX7qg1NLe6nK0HMkISiEYX?=
 =?us-ascii?Q?b69CmIyMNV85iyIUTv6Gk27739Sa+QDqU3NTqTxmaIFJ9l+qRsUfT+w93dep?=
 =?us-ascii?Q?8JTpjhC/bJ6Xzs1zsWNRhaOYm8HkwWLPwJCBQ09oqgOMe811Dh+RGMA5KXTI?=
 =?us-ascii?Q?VRWeoG3B/zHYZOIPPlVB7GMm5yfRhowdfTPbflW0W4/GAkYRtIXKCJel/mfD?=
 =?us-ascii?Q?2FX7zPfjPsqgNl8L8npZnAVX3IAnIG0vndELaNjMGC8rauMd/GmW2WLfql7U?=
 =?us-ascii?Q?VOk2kV8L8MUqVSJjMPSXEfYTlpGl8SBWtrxKReRAwbd9BKh7iVcaHD09iQgV?=
 =?us-ascii?Q?QIYwk/M5uH94ZcfCjJotRrqhkgcTF3G1jIBf7YNS181qqSuE7+kdM71OHUP8?=
 =?us-ascii?Q?Z1tBeH1RguQ1FzCGX6uSLbjeaNcC9FbrcKNpt1SIxAYdxh5FzJK+Pu7PKg9K?=
 =?us-ascii?Q?N3hlDWMOXxE+kp3BwjKTp/Sv5kutdDvMfI/UBK9vfhE8JQoU3n7v3p73CquA?=
 =?us-ascii?Q?Kx0jxktzra/3cP6rM0aSpLilU3oL63LVdIAYJnNLkqIQDgGnIDy8VbcfQmdX?=
 =?us-ascii?Q?g3UnANsy5WP9WTTuKXQSc9rp7uBZ04lxWH2rtfaaNjIaJH+tfmctDANUOcTW?=
 =?us-ascii?Q?EBOCBh67BgVsGB2Yn2cumHXS7OTxY0C11TtZ/y2zZ0Gaskjq5+PdfG4OP6Fn?=
 =?us-ascii?Q?fB/WFxaE65ivgUGxyT8UJQF9E3wy9TPX0SaQvJEr6BPgD0H5PxeISn4AAuwF?=
 =?us-ascii?Q?QYAxIkr7Uam6y0yG54My0QwBrcbFGIvJ54mD3f6Co0DZDVYtB5cEhrFFIssf?=
 =?us-ascii?Q?sB+4uR00BO5foFPCRsN8iEwID++Up+5oQvKn7dOWnHII6X3j5SHxgpcjajg4?=
 =?us-ascii?Q?rx16YvXKC/DdUtpSWwX5ztIkDVUaEKrYTHtgtVNsvKjsaUhVoS2rx0HXAhTN?=
 =?us-ascii?Q?amUQWfrBPyB85MfXv9NY5yR7V7HOlPPxsScvJx30FUk70CzPt5dsmoeAUdlL?=
 =?us-ascii?Q?eOfoEtEVfWfq7Tvkyb1TTLU7mNptyiyt/IA8TgCRZOl9UoQSrAyR+L3GFfVE?=
X-MS-Exchange-AntiSpam-MessageData-1: XlLM2C9q9QsxpQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a175f419-4fe1-4401-0027-08dee14d70ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:13:05.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqL3iXJwYZ5fV1111/rJAPyMwtVIq9va27OaKXpUrN67+YvmklITpOX1Slo0pneFPXObr4hLcJpaLYNhiKB/Sm/pG0FeGfBXSvPm7W16B6hHreoTfSFEBFhCViOTXlQDCVqVnPSHTfef0FyylJ6anQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307332-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:from_mime,altera.com:mid,altera.com:email,altera.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BA7D7504F8

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Add compatible string for the Intel SoCFPGA Agilex5 SoCDK TSN Config2
board variant. This board enables gmac1 as a TSN port with an FPGA
GMII-to-RGMII converter providing the RGMII clock delays.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Acked-by: Krzysztof Kozlowski <krzk+dt@kernel.org>
---
v3: Add missing Acked-by from Krzysztof Kozlowski inadvertently dropped in v2.
v2: Replace mac-mode DT property with compatible string detection.
    Use phy-mode = "rgmii-id" to reflect MAC-side delay handling.
    Fix Makefile indentation.

 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 3030cf46fe74..e431469a7175 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -114,6 +114,7 @@ properties:
               - intel,socfpga-agilex5-socdk-debug
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
+              - intel,socfpga-agilex5-socdk-tsn-cfg2
           - const: intel,socfpga-agilex5
 
       - description: Agilex72 boards
-- 
2.43.7


