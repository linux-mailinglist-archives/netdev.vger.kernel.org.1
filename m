Return-Path: <netdev+bounces-305291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d6ggDWucTGoenAEAu9opvQ
	(envelope-from <netdev+bounces-305291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:27:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16623717F14
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=gCTtJ8kg;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305291-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305291-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B4723001CE8
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597839E6F0;
	Tue,  7 Jul 2026 06:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7BA13A86C;
	Tue,  7 Jul 2026 06:27:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405668; cv=fail; b=FliiR8JFehxje/1kB4EcKwvr9by2+oPY8YvWgytLqunzfPQGpaWwyBOvMr7DfhnbPdnkKGOpaNViJTmJbPm1t+SS1OBsUVuA2zMxstwaFbtjytlpgPHTPs96WsxqkrMpLhZpEwOT0CtCHwuTBr1682ttS05BYc9Z/biMt5xvMys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405668; c=relaxed/simple;
	bh=cRg6YwgP0IBjafluwQefWP9gqiDfA57ZcytAt/7DpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QUxCLgPDEXHZ+W8pIPQDnX/EBcaWwffHU/spZco3547r69/3I9UKDZS18qEn+UsPg4OM+Jza2pdBpeSeSykykz74UNZ3WNPpOYdrnGqH3p/G9HjfKLqK21Egn2rxX1XsP3ImhYEHkbrZU/LZ7bFFc7j2qE5E4SDMkzldPkTT+qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gCTtJ8kg; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpMJ96VAH76/aVpo7EyA3r61KPQJB/OHDf3gBf4oe2mNhQatrw94357bY2HduUbCUMOMXzabZjwjrM0FR9eRkRqFQ7pRjkZ4t6e5fMoPQ0CJhqOVeJe2pEzJITDoL0SKiyk+IoTkl4/h3m6RJuyjPcqAU1cp3H0d7pm3GItyj27TMpnOEeZ+3XEU8JN963s2GGmueYSkoKhpWA750l1z66x2rJE+dh5hEA90/eamzz/HuWaB7lSHP9KJ//84jEePKGs6JuvNSag2A4qU9q65hFn41Caz9a95AL5xaEHhy3vL1/6zKb+KJVKr2ajH7PDyN20tqslspl8MbJ+kZvkQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNDd+3crtArV4qJ9hQ45PWQJWDET7BQkIelN49qwE8s=;
 b=NpZSPhICOq9f9fjXl/SYJ9JQnjXCpBxzwUpE/opHxfEAdpuKzeQ4Lf4hyHA9S/ORU4gOHwqJuJijoCdwXQERcMIyC9b2KmQwhua89XPX0otnVa8xOvLGEIWSwRvJCEZaKr3GhwClhTnD0PbFoDmelbRHNFEXNoBwNKFjmIPvouspnvya4dJ0Lyo/vH0y2KADr/4i5E2EPnKyWqUYFd8uvPl4n6lidMNPF6hjahnv4mhZhjm1jy0LEajfNHtESmwrGGraOWl85/PLQJLPVziwL8b94abhPDlGc0oerrDw6AJOBdMrjsxOw7oxToyS+vEGLi2aM51bcLKKIj1FIaggAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNDd+3crtArV4qJ9hQ45PWQJWDET7BQkIelN49qwE8s=;
 b=gCTtJ8kgtRzREIW6JROVhxP3bbgJJiRHC9VuJxAN+DS8FvXiClkrg7L0GBs4Z4C1YEOzIL20vTZh+PXJk3XM7baMhTKVTRg9P5zhMo4JoNQz3GEOnfMZ5Z7rd5hFIabBLyOYVRaB/ygK5XJ6VRKcntltmyVP/atV4XsqI8duZsgnMnwyNS7oV9Z7OgCkPjJqBiYPNMOhltFcSSFHD5IhTMdeD8+3jGk0FzEeSELbrlVrQaFkvpTDFypbF2Ng6md9N7kNHTHxX76QkiIZ31bJH9OFjOFOLahelEupoyJ3peaJVMgi69lNePaeo/nL2hTim5gCxVrr7vupKAOwj1Al+A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MW4PR03MB6572.namprd03.prod.outlook.com (2603:10b6:303:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 06:27:37 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 06:27:37 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phylink: reject unsupported speed/duplex in ksettings_set() with PHY
Date: Mon,  6 Jul 2026 23:27:35 -0700
Message-ID: <20260707062735.17776-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|MW4PR03MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 809fe0a5-05ac-41be-9e54-08dedbf0d60f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	GMD1GVBxtGw7z7C6AYiWvBD5I61dLVTqU9FaovVNTPzHvQZ06Nwflrl4PKEXEqwwmAhZ9Id9+EXyJHPV1phsmNt2G1kUbBL7RfIh2D7t/UG0Eorq/48+1vKsA8D3jlZ9LpFTYAnVEnqDt8GpYV/O/WRVX8s+jyXzEt9Llkbwzj7Nb9MFvrzv4D6XUGinM8NrADMt98y8D4YYy4uihJECeKjKajK6smqYyM9XCV/lijnRPFZTfr7OSIkIFsURsZM3dwg52Di0EI/SxDfD4gaKYYDYFB+tO0LtIX6NHOL/UgrTxbCXJpJ5gmNJSuonXe6bwIemAEixj5UbMvNHvJe3CPFklmj+PWFOToy1BGMcTEV2ueWxIAOeBzwoMq/SB+ROl1HzitGGA2Gi6OYn/u7XMw39OxLrXZ3xzdPMxdsa48272DNw3iCgH1SCk4kfqTvYYYug6qIFr4NPBUU5MsGZaKa9c6ckUPGAa7ePmh+LeFD2a5n8+ce89Cvd+UctbM/sUJ94nN9RG7AcWJThaK7tmxg1J9JCvDkYZnsYutW3vHfuCK82shPqgeK0+6dA6ZXQjEdxbVm5U5dk+UhSgkUUaDszD3fR3ndz5PjAC2c4jwQ873Z4GcB3qMhicJSYwZYv3HNAlCyW32zBPLFXsGN/4ZjJ7KgFUufN+oH/T3wAyDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yh3fAF66zEj3PMLv7e7pddP2v/U9Q5OPHfo/7X0EpxgEc0CtFXD6IYTmJd4b?=
 =?us-ascii?Q?zzN6nGCSrF2aO40Zo6D5rSvyCTjJ4gdVCcu3+l9SMp4v7SginQTEiyrfxYNE?=
 =?us-ascii?Q?Tw7MSoyMiCL1gid9kOHCtOHTIqNkb1F48q18esIt73j1uR9bd1Tmxfd+4XNB?=
 =?us-ascii?Q?/XAU9kNLyevZrzkbTM5hBTcptS1ycEdKOQ/dwRJTBCSDtJUZ1DvCSxKB83Y/?=
 =?us-ascii?Q?yjlfHqXef3OiDOsFqr8YYpQB/mRU9r+2tiWCdf3vJ/EAXTFWqQVWyYIpaHHJ?=
 =?us-ascii?Q?ywFcmYt0weM210auS8kZRW8k9q7Zsxu0qlg8Ytk3fu9hCToihoSnbNxqAUhh?=
 =?us-ascii?Q?g+wZU8f20pzVjtK2AJak3kONFbWO0OjFiD7XSj468V54cWAHIAb9/TXbPRnu?=
 =?us-ascii?Q?eXEGzcOf0g7Aun6ZF1784a0AEmbUHDVT9+ILgDYdmSis6vz+RuxKOLTit3pD?=
 =?us-ascii?Q?G5uw7LlDY8ZBPLmDqYiSqr4do0OqtZIeY3qLAcVCUbRfznk2ikdSNNtw7Dx8?=
 =?us-ascii?Q?CpXca3LQhQQ5QfvhOaCUbVjqy4xJ/2/kYroMR+gK3IMNDKUpEaDpSVaZA7X6?=
 =?us-ascii?Q?D/VmSmM7s3lLX1qSMqVmIUGyLYzXetytg6lOenB4guyqk5+47UmRdJwj4LMx?=
 =?us-ascii?Q?LZJCWl+M/GA1QHEZg5PABr7/Eb66gtDVP2WG8T0itL1bSGNvqdGX1gh9Tept?=
 =?us-ascii?Q?ajRlulZ0LZP+8BFItePMMyjuP9I38h8wrZy4tHFlhqVZ+GOE7/hQRN3Psyij?=
 =?us-ascii?Q?qStskcauZGcJwA8HOSABPdkVQD+coijforjj9WU7iyUOouIk+Xqb5Vwkis17?=
 =?us-ascii?Q?bo2u7kLBAJwk9K93vXSTOA0benmJBupsLqvVY/zYbEH8qJzqG5HkWFtqgpMH?=
 =?us-ascii?Q?uHQtyDqQTwj/bBLi9fk/hA6XUG3jM2fP0sbv61jEjCvMZ5DVGCkf7MIivPXm?=
 =?us-ascii?Q?c+1cyvY9tbPOokunxbjiU7TD0wzw5BcjtU0bmx8aEkBydMzDUyAsSmDwg8Q4?=
 =?us-ascii?Q?bzPESBdqKGpVM9jeYavGRQFn+L96eUcrGZ4YjhJlgv3/u9gGD6+b8YuSeEqZ?=
 =?us-ascii?Q?HhPHR1VoNijSa5JadRDd6qgjDnKyFSiTS9S0s0HzeoEP3rjC+0hJv6EyKiV4?=
 =?us-ascii?Q?PivtOHDamQkSs+JSp4+2JgZwtRXHLMo0VEdvOY7DYxA+dCYsWr20JxYAWniJ?=
 =?us-ascii?Q?a5ETdokFzYZBqMfhaWrp1zak8OoKlpIUsCll1bBy21jFOwFLqK3GV9rgalZ+?=
 =?us-ascii?Q?BH9+YB2uGOdH8d6r4ha1+SAJtqwqh7VqlkLwEkS3yyh1In5SG/XcKScMfmbY?=
 =?us-ascii?Q?SQoDpAK8GTZNQ21+m/LhYVnkjM/NQZ2VKFAikcaWtK7mJMopxHaMyCuToP7p?=
 =?us-ascii?Q?z/x8b7mcczwZLNYznul7m/zsziJy7cPwJvde4Wcb2ZWweg1kzi/qKKYWBOWK?=
 =?us-ascii?Q?KcHwUEzKv414VDXm8ERQe6O+5Bqpd8hZaYAQ5eWehxHF3cns51wykgSTXN3D?=
 =?us-ascii?Q?vpU2PE5eG17CKMOjJN4EnKwVFuWZ2veoLYUcUEA7BZPvWLoZ+BWQMMgM2euH?=
 =?us-ascii?Q?g87UbqotX7k0GXs/cxm8RCq7/gokOKNm8bpXijmA9+iwyiH9yzp8fwnmwJBC?=
 =?us-ascii?Q?Tf5armh1geCsOXb2vbRuXPt/kSMpvPJIH9eMwGFV14DtxBRxh3ZZrz/wEj9A?=
 =?us-ascii?Q?y0UPnkiqq/yylDe/Bmir23jM3NuRA2m8eioiJpBv2KhguSnq/5oeHtqztvh+?=
 =?us-ascii?Q?YAmIbUGG/2yUXm0neW1OScHFiGnPqljyYLHZH3P/BU2EKjuLgpmoIxHAieJs?=
X-MS-Exchange-AntiSpam-MessageData-1: V+d8hdmbr6RsGA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809fe0a5-05ac-41be-9e54-08dedbf0d60f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:27:37.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+xE3io5O5c4xZTKYA5OrvVnY4xk9asIvihVg4wJcB1dYxm928n1VEA9mozhRMQQZjOVmlmTIiGdBKaOdnmBr+um7w8Vu4P97LubOBgu8LxGqvSkAOa+LuR1Ra4PxbszkLpCHL1HQSVTWWqEQCDYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6572
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305291-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16623717F14

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When using ethtool to change speed and duplex on a phylink-managed
interface with a PHY attached, the requested speed/duplex combination
is not validated against the MAC's supported capabilities before being
passed down to the PHY layer.

commit df0acdc59b09 ("net: phylink: fix ksettings_set() ethtool call")
and commit 03c44a21d033 ("net: phylink: actually fix ksettings_set()
ethtool call") introduced masking of the PHY advertising modes against
pl->supported, but did not add an explicit check that the requested
speed/duplex itself is within the MAC's capability set.

The AUTONEG_DISABLE path in the non-PHY case already uses
phy_caps_lookup() to validate speed/duplex against pl->supported.
Extend the same validation to the pl->phydev path so that ethtool
requests for unsupported speed/duplex combinations are rejected with
-EINVAL before reaching the PHY layer.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/phy/phylink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..22f9bbd381bd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2989,6 +2989,10 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 	if (pl->phydev) {
 		struct ethtool_link_ksettings phy_kset = *kset;
 
+		if (!phy_caps_lookup(kset->base.speed, kset->base.duplex,
+				     pl->supported, true))
+			return -EINVAL;
+
 		linkmode_and(phy_kset.link_modes.advertising,
 			     phy_kset.link_modes.advertising,
 			     pl->supported);
-- 
2.43.7


