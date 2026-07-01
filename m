Return-Path: <netdev+bounces-303452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3URZC+iGRGo7wQoAu9opvQ
	(envelope-from <netdev+bounces-303452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF86E9690
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:17:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=hqgovt8y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C2533012C48
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD91891A9;
	Wed,  1 Jul 2026 03:17:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DB2628D;
	Wed,  1 Jul 2026 03:17:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875873; cv=fail; b=PnLz8zAmS5/wej/bqTRVc2F+bisQLQEkORGU6jq32Su0q79kjAMLV19wjHe1UCd/TR7X5H3LxBC3FyXyWU766VedLSy9laifmS5vm5DPlgV3y1bd3AcPnPTiTn2J5CKQH9+t1Sf5xT5qrbkwMyhdNpHzSsvgerLSJJjCKFZ1l0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875873; c=relaxed/simple;
	bh=cRg6YwgP0IBjafluwQefWP9gqiDfA57ZcytAt/7DpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vFxr5mXc0tCwFyHyr6ceE9J0o22j6u3mGjrPC6D08LUs6HZ5ncktDNmHNWyy71oUcupgv99SK/VVo2y/qV+3dtwu2WIBNTKBy9RdhYXTaaMspvleykcWbmWMNU4bOmBO/SFEZSHyyWzHImkfyOKJ1lKQSZjmcumJ5Y2cF/Dq8ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hqgovt8y; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prbRkQr3ayulSY/LkQpmdN7sr/0YQNYwOHGG+EBjFlu9S24LWTyF6ncIHWUcE8C1VHUXDeH6HHBJ1u0mH6xbBnlRwLAZcrFI02KM9QHk0pKHexRDtoad3b37CxdvupLDE6n6mv/5PlK3JQ/+nRnNLRD3ZQQHiCApRHar8IdqvV9H3aaX7zd3Snl5mQR9qqhJT52ngEGUQ3F0yN3tHQiNwzvvQtKyg4H4zyh1RT7yWRQwgXtubDYccZWQXGj/+3IHUmnW+660maJIRrOnf8fcYZFwEXQ9j4XJWl8wDGTbcWyAcwxGLCfTrbiYYpCIYW8oPAwS8AaY1axGRBNQSCh/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNDd+3crtArV4qJ9hQ45PWQJWDET7BQkIelN49qwE8s=;
 b=p4O4OHdUURWp4j+UeaqgPY4v2aRaWHWFZo5vKeDK5/YmU+MI9vs19rgIDttCNva1j6/IABL3breB5prR6dy7rkZ0fWFGgeW2TAsKMTjhjzjEABUI98Z5mq6R3CMg4SHdBLw6TsPUv0jwa6yPCBC1heMQsAb2cbWBz0YJSdn5H954lQ8O459/+T2k6wvPmUXc6cSDakoqIXURFJeoHsxogQ/diyx67sjn7jBLaOcjSU58Wx3QDaz+U9wYyk4c95cvB+ALyo/RBiYABoBYc1Svr6kOZ2tinVdAaNMZeDNrBo5+s4dPcdY/ZRwtV/fqld6jf2Tf+lHdMlBBDIiWHV0J4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNDd+3crtArV4qJ9hQ45PWQJWDET7BQkIelN49qwE8s=;
 b=hqgovt8yzWq00crx+d8/2ygTkKy1Egv+a/8KIIb2Be+DepsdrblBQONYBNRFIPZ96TGgcLMPDZdBQs9ojsnxJszHAvQZKKG+uDEXVk4mHu+PhQnlS87NXwUkmEBg1btYhFf3o10R+RF0LR0YNR10Enm/BZ7h7MzT5p0QjnqtLLelyMBwYZgykW1MYEJskgtxH2mgkDUkLnY4vEC20DJS5wEN4QynCXz5CE1R5eRkW7bphCD704F42mX9e+/oTlnztp2XVr+ZR0YSMNUnM2Rvtr4Ya7TsraoCG0N5s3HH+ZFEe/wLnejJ7OcFPrgWsJQZb1OgrYvHyUk8R/Wn40p4mQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH8PR03MB989112.namprd03.prod.outlook.com (2603:10b6:510:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 1 Jul
 2026 03:17:49 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:17:49 +0000
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
Subject: [PATCH] net: phylink: reject unsupported speed/duplex in ksettings_set() with PHY
Date: Tue, 30 Jun 2026 20:17:46 -0700
Message-ID: <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH8PR03MB989112:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b25b2c2-0e98-4e13-e447-08ded71f5400
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|55112099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pa0ASjw9NDdN3dX9aAYM7G1glZp3Jdkd/bBMP2mLObhggaPLWE86vIi+r4NhYoQej1fVJEqYWFyWaNFtsun94Km21PkKsHD/FKSj1MjWLlEq+uHbEizURIq5gDW6oEfYI0G5QnOSQqbQzI076fgliGZ7ErGVE8SgRQOMkNfWC6cp84v/lHTslnnzFYEAYeMV8iB38kPfKDXIQoMSA7241jp1uLa60P32hJCtT/mftbeSYqyiAtTTRayrkU+dEik5jO6dGpWfCOsbhpiZMxtXVc6lij/EdL7jfXd9m8jAarqqXkIwNKq+YmkeYpxOU2lZckxFw4t+hfubn1juJ6hF7J1bc0l9mZ53xZnlocixEzhIwtiOXYzlf04UiMXntVpREt243aSzcjHJ6/aLgyWG9D2Z2p+5Iqb6zbqlWYGBneiuUz097iB/HsBwqcfzeLeBbw3IkZst5EC5uHAyvYNLVMbLZol1+pX+habzUfo0OHm7XFcGtcwyQGm7Ht6w4gKkG/kPCoKkASAI1avQBkFzYpQXUF+jSOFxDXpdFPpn+6rx60f0r/pi0sjjLjegqK3W3+Y61Z/r+jero0T18JcdBFTR6AcnjOryJbImHK2/z2l7IMkGUIcr9kqHfxFmVJdgnFmF1byuB3hlptNQhCOSXwGrrLIWQtd+zuLcyR7ikRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9gn6Wgih/cL7OdPvBnbOWSZEW/2bvpiieaf1l/XH/jgWvJ5PMKQtyQeHmIpX?=
 =?us-ascii?Q?E+PxZTfD4vqMBH6mz2McIdDNO8ccbFOHpImnhlQjJvJuMKP05YbGEdwSNKi2?=
 =?us-ascii?Q?QHcupLzAw41JsH9gUsmJMGArH0DKMiGkttRrGm5lhZIGCwHYuiDqW6LOPRHS?=
 =?us-ascii?Q?YiH3csnYumAAJqtOIbnh/EEb9c7a3J4ipq2E2fmZLM96pG/VP9L7S5JuomDZ?=
 =?us-ascii?Q?JViocrrJQGapVTud4Wp7sP/oqGaR1MNBkxd5guUqY00prId2Hi1v5PkehGmm?=
 =?us-ascii?Q?t90pcC5htzjnjqz03E87ad49mCn26ymMk5BXsnPS1Q8ukbmN3mn1NLsKUkRw?=
 =?us-ascii?Q?Yqx0ujnuECGAXIcVbq1UVefmc3lsOhLWiNQ/uQyWc/iCOPjm0VVaS8oxchh1?=
 =?us-ascii?Q?bdczKSx9CYMvlTrb0zvUFlLoQPUT5d2ojmOAZKEjRwPXkBl36U65pSrF9myz?=
 =?us-ascii?Q?om6U/uPNdfwasi9zSNRsQtgMqkh8J5uJxt0K+OZhQY2T0B159SQ6CkvdRwk9?=
 =?us-ascii?Q?dSstSi5u4ScK+MW/yYMjRFqsjC5Ct8Ox0Mu3KeOwhodiJQOjsCF4U+AR99I2?=
 =?us-ascii?Q?ixZIStbbK7iKtpH7cdaDR9Vvn1taTlckli7Cd3TBsTrPF+zXpLKhV4M0K+Py?=
 =?us-ascii?Q?Ls2WIwaF2HppHomkC0T0J6hd3ivvORsSvIZILlV9zn+8ys3kcVEGRw5xIMTz?=
 =?us-ascii?Q?9b5qjWNQspFXxaHkKez6b5ytbcQN0Xjc8Lpb6lMY/yxkIVi3RZN7IqqILi5V?=
 =?us-ascii?Q?68ijgSuy91TrdB65GSL7bxRt3I1oz/8zukk5+g6HuP4GtI4RglKvcTlgUnLQ?=
 =?us-ascii?Q?H/kAoO9qZ251vExeKhMlIGaCkOFB1IrwC+acs3wM9qp0bTU762H0tLhFhkhr?=
 =?us-ascii?Q?zd0spECWn0h2Emf0MMXgbniKisNBxWo+9XaHPgs5NAtX+Iom9UcdQnK2Fnko?=
 =?us-ascii?Q?+TfUwTwpNauHL+sglVZeiArOJcA+Rsu8Y4E1GmjfC+CrUJU0KKcUriSjOcVK?=
 =?us-ascii?Q?7B2JoFNC4VWIVuL8UBo+3xIDnZluoEIB4eYhX766lKAOU7wenHpRc+lWx54z?=
 =?us-ascii?Q?NYY6ma71fXXoR3xLgtreYTa8Q+T/iHYdG/BHCiCP715IRhMmsBUDXCWF1iYs?=
 =?us-ascii?Q?pXGqFPjpp66svvv8whCb7SRRsgCC+X+A9wQahONvkzxPixCgH+zwY3KSIE65?=
 =?us-ascii?Q?8HDG56Ar6mh0igMZC+4vPSClXHYn7az/EC84YwTIlyHP0V0iwMIBu8qLq1fp?=
 =?us-ascii?Q?Wi1XrnE6ll9TZkD0HFaggBVw47tTZhpNjb4DaYFplHLJNHJ9t7S81hzBp37x?=
 =?us-ascii?Q?+27sulxUjB4B9G9jmvG6HsOxRVxBWiVKIg3cA6GlqDpE8shH/Mkf6YAQdCU2?=
 =?us-ascii?Q?e3KhCaJQ5TnJ2HEyQtT3R98oZ5SnH/HRRPC7Qzt304ZB8avgE1gAi3e/SWp+?=
 =?us-ascii?Q?uRjmyZVYGSSCUUhDz7pqyIZgcU26wgKFOwvZrU1yxyI/dbcZaWKRKTkO0js/?=
 =?us-ascii?Q?//A8gHWnZRLHDLSPfoxVGFwlzjqLmq0i4PeoC94uXSlunNc2Moj+mc0rGcWx?=
 =?us-ascii?Q?gD9GExobaJUczB49Qu50ckLfP8KNZmuqYTwDHS/vNUZqZSYwcb+dYArbZB3O?=
 =?us-ascii?Q?SIIPHlUkjbnZnBkfzLBqFR/HRSZz7SMKYjrD1v6iqQFdMc+otLCvjg2StB6e?=
 =?us-ascii?Q?wZwbCPllmmOKmaRN8mQ2S5QB4G3eAV9HBGsA4dTSgwgIbYJOla4uGSUX57La?=
 =?us-ascii?Q?i46Wp5Q4mbnDJLUYtzS4B5neTMwQyiKJ529edYIKsT+Qal4m0VZNYVfFpYEb?=
X-MS-Exchange-AntiSpam-MessageData-1: 9ljlM+fLezetFQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b25b2c2-0e98-4e13-e447-08ded71f5400
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:17:49.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YH9pBklWbf7csDzjBVjuY0LFCYmOgUbbMFEWp+v75WohkgZXIlk40GGPlbDO+7KwnjfqrxBYW9rSmf9g1sY1xdZsD7GYiCjcGeuU9a0EdUaLUWsIkYTB3gXnERpKJm7nIR5vgpOz+mh1EiipCLrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989112
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303452-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33FF86E9690

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


