Return-Path: <netdev+bounces-291551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKC7KGlCFWrJTwcAu9opvQ
	(envelope-from <netdev+bounces-291551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D15D1509
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51A6030072BC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049053BFAF7;
	Tue, 26 May 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O3ns/sBj"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75928368D78
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778146; cv=fail; b=Gso06R8qwhQRhtDRAkFRKO1ivveF0br7iTD7c/iI+Z4VI+ZBaNKjWaPB4Tycs2Yxz55exC5lmALbyBcSCLFovC6MXK3ln1FNUUJWD0qTDAlfaIUU2ebhndZFwkuPSKCbqbUmmeui9GnuYvkfNtNNL7J8PzNpBEoEhI8Weky35hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778146; c=relaxed/simple;
	bh=j6xr5kWQapOCKjEgMdR+pAY2oaurGTME35R4NfN73rU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qCsoMri5ldMbrNzosHgGxk4DybDlzzoibZpleNBTZB4tclEacWP9Od2Mn2pvUWYIjAhDuQiVpv8NYnV/34RyHcJBST7McDpcOtUG9a3cNHeGbNYQ6mlOD7YNu9Hlymq4Jo97/T8WIekKfLksgzMhjixTTNRfLftre1nFuxkHjRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O3ns/sBj; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKBQ3w0vpWZIgmzur20PNHH+lrQDRMvWCrdjHKhQ0iCj8RtNtD/bsSaCBV7Nkyh0PBxysQ6PPf3aYybOHi3QgoiBXj6S99xU33RpP4UMPBO+dNLcbdLSa/vjPXjezlWug7OmkEZqAHYyZV2WbF4hftDLrfa4ORcTZxfDzGXz6eh8fHv9+XOrnmr5EfPIgbDb707HcyXBawuYl7G5rd2+cZ/EnHStQsEvy8UUmhAxTT9ipXVEnegvaCVCXI7SL9N6lWdYPIRdz9NVt4V6AUB0HX50/HjMbH+M1XaOZszhX5WebcPvTIgv9AGA/1Z3sDHqcitQMwZihmqZPMJb9xG7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnL36JsjEZQW2Qii3ZrPrPnF3SHXm6NnRWdx0V0LjKw=;
 b=eX5f5m7m8w+aBCuQpErYGi2n4rXfxKRRxA7b2d8U9BLbwpv2XAuksLMeXYVG7EWPJhsLD/pE1Y2KJlF619U1k3q4Y8hP/2ZlPCNCq0ETVIy1m+bu+B4Ar+c8S24QhSzqjmH4NBCCooEbD/j98TDOM+5YaENiHsZgttY6ZAZs1k+m6d8XrQCE9ibaxNI7LLd3Oi0IpP4a2rVvfzcFmlZKtqa+KQrTA5oDQKqJLyp8axrBAIjii5Tf/YZVa402XByPA0QgD7q0o3Og2xmDFGuy9zV2z24IdLSHtWwj7nJJ/Ny4B5WSLH6/HRB17GEr3PuI/slUTxty9p+FeFsSU5oQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnL36JsjEZQW2Qii3ZrPrPnF3SHXm6NnRWdx0V0LjKw=;
 b=O3ns/sBjizN27M6Spvs27iDigyRTmc2zIXrmgLAaEqi9WNQTZTghqVNqOt1LzemVz5Ce/UlEG77cgdmoHB06R53qGMu8Gc6rUiRlyVqj1vsJ0kbK6l/OI2FRjydrB9kp74/x/+4SfQv4VPmXdY8ZWhCVu5iGbGcnG7jUFWxWI+st4QYmKxpl3jXTjG5EdDEnW05B9AdvByw1QTJVjW2xRcsWaX/yfb5CWV+TergBV/r+yRjgIKub6mBBS3jZVibfryzV2pdYu4PXsszP7Zh2eecIlLL7eh4veFoDCL8vS7lIJCVdztByQy1ibVFDXJawerKo1tx73cKy90MK6p6h+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 06:48:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:48:59 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/3] bridge: Fix sleep in atomic context
Date: Tue, 26 May 2026 09:48:15 +0300
Message-ID: <20260526064818.272516-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 77492528-da83-4f67-836b-08debaf2dd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	usXmLdisQqIZtlI2yyLNWtHZixrKFTSeWE3UyRa6LkBv2EeJ8q7NLGOoJ4403UJz5u4U+OmHPEaJDfGe3jymSpbYOerPkh0W90pQLpEXbwi30L4jP/iIVzu9sCqUUsFa/Y7FVD679ntj67Dy7LGr6iBGRi0yEMwMSJmimEBSWwQHI6kHB7jPHzEJi0q4ILMHVt8mAPk0WF/Np7RTS1ll5HX7wTeLWgZQZr11u9Z2IHFGdIMLAraxD6FfNiy/PmFqX5sMb9Iwh3h7mENew5zritVAAf+xmKKum4tZr3JR1x4AwdmLc59ousW68BWv//Pk2dPVh9gmI2+m1/csjxsmfUdMd/0tppUTEonVwuWkGKag9IYGOrIva0L2DJa2z7pvlflhu4cBumrUNx5NCp7wwuom1kgcXorKNEG/oPAw04Oqpcb/JflgdoM993VAgtDP4yq2izh3FX0zi2Bvbsiut7+oNzlKZrizgBtLBbXA2CjWsg02G2aowYwiecQcQdL+C5zihGDK+ClZd6PoYi6pOH1YvYzNAl1vuQd5WJ6Guk6Pj4G5K3X7GH9BxCqw46WsbeFjLUergB+Yvsasg9VItzq9jWQF2KeqrHWmFwy6xdvo75GMKaiZYoDdqgi9MxTI4kajuzv3HXCg+T8WAp0fwimWHdTKvXhzwk/VkBCptOJ+JlqVm5cVHTr60SC+TLhb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXSmjz2fNgLuhQ9nfeSDh5pTQjxcdqDeg6DVumyRz7fvlZc3LErOaUGBTJN6?=
 =?us-ascii?Q?TC1U2nSDCVWEPCXfnub5n253Md78n+6S6DsS22b0RlfrTfOi+W5orrV26uhp?=
 =?us-ascii?Q?bJ8HdnE597gWhg7EquVXsWbovKFlpcFddQezWcEQvJkk7Gn94xKaNeD3Fgl7?=
 =?us-ascii?Q?fdnUbf+tA5jTXtuDkP6z4Xy2HzfnvZ9pZUb+GxnAJhYEU6QcSImkII/x8tXe?=
 =?us-ascii?Q?amtZnMH/uiYq1LfybNThaJ2Kza8mZPBNC92aULy+/lwpSxhSFrNmJFVa6hu+?=
 =?us-ascii?Q?3dMvzLagUBL5ljN3C6sw24IiNCz2B9aIN/XrMtj9yEt6FVkw+jba375UTB91?=
 =?us-ascii?Q?xkd16JBADTBzJKlAtPX3XX1EuO88S0PlTTwDSAUip83hANNHEeRhqnNFMFed?=
 =?us-ascii?Q?Kistud33LLfhrd+Cun43tg+WxZyHpaWdIYm5LM7ynWEjdeyrwU/r8wOuAfJ5?=
 =?us-ascii?Q?D1HHoPawXq9ue9O8UGt5hOeHQXSL5683B/9bLW42fFrXZKZwKxFAxxzrRcja?=
 =?us-ascii?Q?JUMG0GodlP8bmsQ4AjDiVnX8lIRgMbjDUq29+2pw4PAuOYsMWdCozDCZ5c9R?=
 =?us-ascii?Q?mOx0kJpgTGg7TUVuqBxy+yNqr5mE74V1SBdA+iUVOo7f7JIIJLQCYAC1OuxS?=
 =?us-ascii?Q?KzM8jI1YPNXrjjfd4dwsbYBjHYcOFUzjSBDJuBe44Xoxq5fo6DPxI3fFJSDO?=
 =?us-ascii?Q?8tshDp/03b3ZnQdJmi3+1hma5RoxdHn5AEfUoof6vkW/ImyE6fDC13+kz5hN?=
 =?us-ascii?Q?Sm66U2YnAWB7ThDPGBG7jFCOVpXu3uAHL7b6Xnsapze4eag2+VA8GyW5EMeu?=
 =?us-ascii?Q?hnj+LUcmtsSAgs4vHfPFEgFA37NDoIfulUo+k9BFKQVJb8kCqfYSE5298L9k?=
 =?us-ascii?Q?b0h3vFj+jrJq7HPCI9OQZuythwysael8HGozfB5vtw2qAoyPikWSwtRTLCl/?=
 =?us-ascii?Q?+QpYQaYtBX5O9CHHrFNjjzJW96ssx76t4RmOQq87nX4H7dGphPl5tDgacHXn?=
 =?us-ascii?Q?91ViFyCeefSnaFVeZVNMHDp13X16OuuKmLllq0nDB6mdl65emSgnv87fmMeO?=
 =?us-ascii?Q?LzqfrQI+tquGixFmgfQ8+5E/CY0oBHEQ1047GTdEvbBN1A5IGdJa026A44b4?=
 =?us-ascii?Q?xw6KO9sp2nL+rlScCEY1PDxCBepZ0cYk7JQjnM3TDAOUL58NyD9cYJg7jcUM?=
 =?us-ascii?Q?eFKCQbVMBOdYAkSpbUvClNPHuiqKs5ZNQhGo2NHPOXpEeCv7NDFu8UjQ9F24?=
 =?us-ascii?Q?4dU8YanniM/CtYe2FtSMxFNmDIpPimeSKm7/EMdiGOTXxPPUp7zVT1rjotLx?=
 =?us-ascii?Q?z5G6DHaJo/KS2qVzrbJXt5RG6T8gahoctok3ubZwkGxmuMxcUlrjgOqgxwQ5?=
 =?us-ascii?Q?AhVpRp5dR9Kr30W1wtu3VnOHgh0wc8UjmpMmoG0gS8DZBXIsYjm4wS4HBqw4?=
 =?us-ascii?Q?430/eVIsy5m6kZ1EW36jDpCIEW83ai+jmJy8UNR4dYFdZkXFASjoIoCGtvKS?=
 =?us-ascii?Q?eS4ZW7PQawYiieYlQXXkCxRM2EPm66xyjDkT9PxKo4l4qKesi2D9uFM+Kjp8?=
 =?us-ascii?Q?d/P8D4BEKNUBi2La2vo2TtFZDWTVp+4cmm2UuB6OE2RgKo4pw+OBbmoNoDJR?=
 =?us-ascii?Q?2dQNkeUktCHNhqys9s8SNYc0jAm5Is/eLUv0s/JmRjcMc18pLs/jZBt4Il6v?=
 =?us-ascii?Q?c+WyC/x8v4wQpnu5QgCTViSwTpTeM6lnrHPaO7rJlTSTfq02?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77492528-da83-4f67-836b-08debaf2dd5f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:48:59.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVKbtWZxCSnaU41gqLjjoAFfnazhS3C78axrV6Z+gq/vY+tbKR+3CdcsutoCPRFGNY8JWBMEnz0rd0srZmHtZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291551-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rtnetlink.sh:url]
X-Rspamd-Queue-Id: 806D15D1509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Under certain circumstances the bridge driver can call
dev_set_promiscuity() while holding the bridge spin lock. This is a
problem as dev_set_promiscuity() might sleep.

Patches #1-#2 fix the problem in the netlink and sysfs configuration
paths by only taking the lock where it is actually needed, thereby
avoiding calling dev_set_promiscuity() from an atomic context.

Patch #3 adds test cases for both configuration paths in rtnetlink.sh
which already includes test cases for similar issues.

Note that dev_set_promiscuity() can sleep either when it takes the net
device mutex or when calling netif_rx_mode_sync(). I encountered the
problem with the latter, but blamed the former since it came earlier.

Ido Schimmel (3):
  bridge: Fix sleep in atomic context in netlink path
  bridge: Fix sleep in atomic context in sysfs path
  selftests: rtnetlink: Add bridge promiscuity tests

 net/bridge/br_netlink.c                  | 17 +++----
 net/bridge/br_switchdev.c                |  1 -
 net/bridge/br_sysfs_if.c                 | 30 ++++++++---
 tools/testing/selftests/net/rtnetlink.sh | 63 ++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 19 deletions(-)

-- 
2.54.0


