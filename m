Return-Path: <netdev+bounces-135240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B805E99D15E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C521C2365E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE51C304A;
	Mon, 14 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OVQwgOgs"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9691B4F2B;
	Mon, 14 Oct 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918802; cv=fail; b=L+6gqgW7pmSc8eEUWeC9y0vNUtmQbQyk/k1h9gr19ZHANlC+Wee9nshqZIcGLymmgkHgnekA8LBIryLCTP2EEmJyeT02kvvJuPMlUXXdwsS50jONiRbnaLh/EZDpjFWBM1OAn1wDAZ59oruqvvaRNcDjVyRVxj81Zh49E6YiZlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918802; c=relaxed/simple;
	bh=Dh6mB7dPxWk/NdWcY3Fw1HEL7eDKqBF+sgfJyG29Gx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ove3dPfEHR9c8F3NsONi87OYVySbVPtHPiU1I6bzCydTxL7YY+kfPWqG96p2G4hwGIvNK/wAAooJ1OHartsgG95EGGc0wOXqi9hC70IChTMdynigqic1MRDd+9qzOZWQVjMq/AZmAV9VaGdBPS/N541uAZaI2DIXcyms24GvfTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OVQwgOgs; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYpRBSq8msgJZsrGFwBpTp7kEPwZAmEziMTz6YIQ6ch+lq7z/c+Ov7deJFvMheGlnNjLbEZTnFQVUF2JYNHfaOEmBkxz97K9/KW5lCLu0IUr21WhLfcrxLLZiuW3avJcM8yl3ZkoAIzZENocsGzB1AoUB7HpE7rpvTvIES2Y0WXrPBcGvO25+A4l3KjB5Lx96Gglsd4VdXpUt/nUSnov7bTYR4NYL3GrQwOnS0rqxynBCzDyUwKUfjXZ4VaHQm65kfz7a1cQCUl8U2JrpYw2kP6w+VfqlT72Fb2NQ/e558QMDOaFWxxHz9Clb2RwnMwZIFSctrkBALfTeoKWLDAlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ/RYkwPtUg6ac8ofSc9ayOWp5PzT3N/N72IbCKbTcc=;
 b=CfJh4fRTLMuD0EhsrC1GuUvrAV3JHNZIsz3YuERG9spq/2FeHEp8drBG97aAP2cB4D5W6u86ODBK134IU3JLH5/lBS+ncx+y6PBx7s8Z8MmeT5I6puxISqPwecMeJUOJcNVOL6oH+agnWto5BoPW1+syVl+tOl/Sww+sJo/zGnNjpXCNiCr3I7g7nI07XzlJlco+g1k9RBgnJqYO2cC8YYTGGshcpW9JlV1JPdoIyVjr4WOFUw3ZT6i3tLjwR0aL+h+pjnWkuPC97gnPmAQpG8ob62ysKZNM6j364mKZT1jcf7rsprzkDkRLm3jDgqlB3NaZvew51hd/19DKlL1GXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ/RYkwPtUg6ac8ofSc9ayOWp5PzT3N/N72IbCKbTcc=;
 b=OVQwgOgs7AgtQD7WATbBAEYHquF8if6xXNkaHBQ2z2D8qjLiQflwYpQQ6aB5fqtE8Ppt0CjYQhpT7uehqeJYBz2DpZSoMTLBTXLQlMGlaK8k2AcmfBFf4yaK8dFI1Qdbo+zQneYS3l+vII9nWz2aE8GSIiCCZ0XOa0pak818Nek/NQtccJGN9uKxG37jLADpT/nNC0SEPjSLVl9hD/EuOlBJM9AeobB2mGWSn3Ee9lrMARJX9oQeLnU0/UpioaxcViQNcGi1rXWthsYvDTpQxIg5WHofuDZIAlSJsu2Ih9kv7HbmTSPkz5D6bu5k6UbJ9uTgJQw6ihtSDtPicYBHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB7964.eurprd07.prod.outlook.com (2603:10a6:10:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:13:16 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:13:16 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v5 10/10] Revert "ipv6: Fix suspicious RCU usage warning in ip6mr"
Date: Mon, 14 Oct 2024 17:05:56 +0200
Message-ID: <20241014151247.1902637-11-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
References: <20241014151247.1902637-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 467542dd-23a3-4c3e-f283-08dcec62baab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBH90/tQ05HOoU5JtzSUGgayFI57lK2KI71voFmGVwiLEG26IwkDfnPGdmUz?=
 =?us-ascii?Q?cn2LMWpC0pBVV7ZR31bCTK6Q8NRPlYcXKtiPyaRg2irQNmxgW6ik2jPXX2L7?=
 =?us-ascii?Q?4bdD4sM8UaqWiryi+kNnatMsNv7QLlqjzVhwY73KbHPibollFY2e+a7LDvS9?=
 =?us-ascii?Q?1AwR8ZBpAhpbBclkArx9IhaFTzsBJM34E82Raut0SPxPxjy8dAQ955pjpHsb?=
 =?us-ascii?Q?H53FniukVAvMsAnO921yxGHUvdUjLpTmbt8sGTkrSxQNIm6e/vmW0DtiEmZB?=
 =?us-ascii?Q?QBpbCNz6ETldce+LmBnIvTDe6Iy0BeXLRK3dmpLjpDGQ6F21T8c8Ei5BONA7?=
 =?us-ascii?Q?GgacAj7rBweQ8VnuKxioTfdJR+ZHBburTLkNqA030EJfSpOBvasL4Eod5ILl?=
 =?us-ascii?Q?HVs4fwtD5/jUv6oFxvDoy5TfIG36NtezdCjzzIH9RB8z8PSepcz8NrbdMZRd?=
 =?us-ascii?Q?JkQJ9ji5uhRu7chPFRe4bsANk0Qho5lB06AOqWk8jS+a1R0dKxAcWyqKBV67?=
 =?us-ascii?Q?j/crtTHOmolRL5ShT0Kg/DfQWSWg/ghiv00oUnXuOmznTI/rN+tzCOVMLg0t?=
 =?us-ascii?Q?VPS3bAUd5e/9qm7wNeGMQr49IRuGv92ZsSM0bctV7+B/IyPDUS2d5sZuzyJg?=
 =?us-ascii?Q?xjrh5AFz0JL9TQ+eV2+clPRaDPbPVk4vYWfABDSxnID1LF5ZdVKhtei4nSXX?=
 =?us-ascii?Q?sHCJts9fe/pnGN3aMKf4la5AnsyJYejmbKgTWtegO8EmHraNTQ/nb7+sIg0X?=
 =?us-ascii?Q?BsiqzsjfYk1MMhpspPn0jCb3PUEZ9qiYH5G8c61cvzPS6bhz0d+QHdKSL13X?=
 =?us-ascii?Q?6Fm57YkfBgsrcPcCBbOTVD/P5eMWbw88moLtZQ65UXMntJATcZ/3hD7ZTBLa?=
 =?us-ascii?Q?jFpa5iigDCP7n7Xuskp30c5H/By2qJFbCmE7X0hw7itMg0BC18Q661pSE+1O?=
 =?us-ascii?Q?ADOoxiyA+aLFjFZqacCJrkB0eRhRkKRZdY2eKlT1fQ4B0r0vNtfjCiU8IDyx?=
 =?us-ascii?Q?AWAD0v3lGJE/Zxn5WAgYbZFOBqc4BXgqdqmlwNxPDwrkVaVBGJYM4NU9fwca?=
 =?us-ascii?Q?xPxbukDTclrZp2PGwQpjzttH7Drbe8UMEGMBm/jXS2Z/Ds7ia46JInH8wRYn?=
 =?us-ascii?Q?Lj9k0QCJCs60pP+WGUUVp5uwHdHo4JoxYa4Td3UMt1ByjnDGU3wHMTOAonBg?=
 =?us-ascii?Q?BL6MgHvrqS1zFilSgegtL00w1a7zaB4ZPSMbyCMxCK5B8ByjuwUIjaubDUym?=
 =?us-ascii?Q?fFhu93TzKTqOqvuBVtYgCQkHKzStSdL05ygPzMUUJVxmKDRFddA1hbSVvO45?=
 =?us-ascii?Q?7d39Z5agHELyOoP1+9RiEYBtRvwT1lFA98quJC/9fzwZUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txRKHygqz4AyTTeH8bF+p2qtfNT2vmB3kvpZ1fui0KFrD5buFW8WuNbzHpY5?=
 =?us-ascii?Q?TJVoTXMqSxJLLLw8I/Dq1EG5RIm37pZdVjUeC6caAqiF6DYvaLgxeVem8tf0?=
 =?us-ascii?Q?hi+HPiMD2lMH8JI1XAb4a4KyezTXidqK8FCdWEEeKKO2lZtcOkfmahU1KNaZ?=
 =?us-ascii?Q?Xxv+sXH0fDcAGscDpjBCiq68waGpdI8+ZwHNMa31EOYrx9U93CusU8LX+wJO?=
 =?us-ascii?Q?5djMACRGKJuSbRygPGnrl4nOCJTIsBq2qsPaTP8oS1j5h8iLXcn1uJozYXO/?=
 =?us-ascii?Q?4RAEGslhVSsMuGmovLG8wVGNlaH99gTziqb/N7OSzM7uO1SQszhWoIvtmB1o?=
 =?us-ascii?Q?Lxwnezl2G5TaZQY3YebqCodlR4qfPZ/e1Fm7vpp2uFfutRYb5jsMoAcT6W09?=
 =?us-ascii?Q?AGn599CkZ5wVQiAED+ScpCTpd7dNJ+UzZLAELqxKLfRNwhjaLUvrbBhA/u2U?=
 =?us-ascii?Q?cZqWdQYUNJq1u6hWPjE8wPGsuppJ7xa66cEBQekivC0b7tcgGHhka2LNn51n?=
 =?us-ascii?Q?79oYnjsi8KjLOCW9YgjIGdGi7bsJujMGX/TvsglVNkidqkG7VQmdm8wymh2M?=
 =?us-ascii?Q?2Otkmac2Tj8UP7kEu8VpnBN05IOBAtCt64kLENOeJKW7do4djXMyv8+Wppgo?=
 =?us-ascii?Q?e8i0Iv69V+H2S8uxisTtATrIHaREQqqC89B6/zJjnmPrti48UmJNPChwcSss?=
 =?us-ascii?Q?neQDqiKPMDRTPDF0xNvC9RLeZ0OWIjqC+tknWuukJ2GYPrlBk4+m1vY1hbN0?=
 =?us-ascii?Q?dEZt3OsqGueUCPJsphW8PejSbqWQBF39Z63KjkeDN9jTdjwOVnsLIgsPVwQy?=
 =?us-ascii?Q?pnytpcEdOjSlXvvkVQn/1JYfxmC8v5UOiSFQsMJeTjwEF39XUYp0yxSFvTBR?=
 =?us-ascii?Q?oY8UikpHZhjQK1lTk5Xk+ASQLgTgLvin9Onp/tdbkCSUlLREHFXjPbT79OWw?=
 =?us-ascii?Q?OqZ+Der6KDYRnhV+Mf49r/SV6udAnvDBn0uUUVMHLrvxhyKzGmZnzm6Hik9E?=
 =?us-ascii?Q?zcYlFsMaxZtad5ghD+glcTJBeVvllMfCjQOhl6aqCbX1GLII4ehk6z7FGg06?=
 =?us-ascii?Q?PhYU+lkkNoKIqaG0aMuvA8McmJvYZXiNN6CCcbFvI/JWmMZ6UhE3K7b36hgx?=
 =?us-ascii?Q?QJXne+VLw0hRL772Q7YC8fIKChf7tgZq6jOpHk0F6Z/V3vYQz37NmJtNUt1s?=
 =?us-ascii?Q?Om+1deREAQwQQh7LnZd0XGRBtmqRaB99aDmYDenQjWVKEvD5G5tLhqGUE2vH?=
 =?us-ascii?Q?e3FesrW6eP9xk6zswHQd75WiEdLeE3tKw5iqiJUKvnjcOoho38xDjz8RWsg7?=
 =?us-ascii?Q?Uiysid6/2L1rg5989iPxiZ1c2w/Cfrt6joV5DfCV/8P7/dJ9zBXW6H2Q/apD?=
 =?us-ascii?Q?grimCI4IMZzZhLlMaczAFrAVF8seE8MNsCfSE3GRC1gHLbshyn9U8g/Xq3id?=
 =?us-ascii?Q?6m81Rn2/Os1Wvkv1EOAuWutecKhBh9m1cJD6COIMZ26Fhv/ltyughMPgzKxF?=
 =?us-ascii?Q?miwwnHK4tygIKiBkYoBI952qOWQ9ws+0LZ0zrfQ09dLc1odhhpi2lXePr/9p?=
 =?us-ascii?Q?m5itmAp0b+zC88sQMEH6q53+W7yUI+mzgjO5841iB3UugpXWetU50MoTDXk4?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467542dd-23a3-4c3e-f283-08dcec62baab
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:13:16.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HM4B3ZWqeKQJZ2SSWgCeCgiw2HqyGFPKjEXpMCE1HrjS/kBZghqFmSro25aSk3ScBTYaWaZDq5iN9rz4oeRhrQ22fR9m+D1q/3jmmqFd5ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7964

This reverts commit b6dd5acde3f165e364881c36de942c5b252e2a27.

We should not suppress Lockdep-RCU splats when calling ip6mr_get_table()
without RCU or RTNL lock.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 01b58156e06a..e52abedafc9e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -105,8 +105,7 @@ static void ipmr_expire_process(struct timer_list *t);
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 #define ip6mr_for_each_table(mrt, net) \
 	list_for_each_entry_rcu(mrt, &net->ipv6.mr6_tables, list, \
-				lockdep_rtnl_is_held() || \
-				list_empty(&net->ipv6.mr6_tables))
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
-- 
2.42.0


