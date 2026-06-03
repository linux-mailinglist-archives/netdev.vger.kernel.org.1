Return-Path: <netdev+bounces-294857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZsLLM9lIGrM2gAAu9opvQ
	(envelope-from <netdev+bounces-294857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:35:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7663A320
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=jlds3AAE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294857-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294857-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18C4300AC12
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F34374E79;
	Wed,  3 Jun 2026 17:33:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60C339719
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:33:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507994; cv=fail; b=BxV3d3mrJYY8q8eamKFh92XUrFPhuOU0olaEsA9LwnAtszO3703H36ja0QQoTu/ghoO6IqqjwJ9caaqStMyoCxTpNutQwSKr5PWCrL2W4PMXW7kb0aDR+q72P9CDCNZSxG+Xk5XTgxLo7Ot80+8wHdnOTOZSSsuZj7J8ajLz62o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507994; c=relaxed/simple;
	bh=gWneBVKY7HFXKYto+/VqQ3mLCjW3zhLpS4JM5JgNbos=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r8cfYxeAVTkHgjJj058wZOX/cOyRY2L27LhBtnp5HvKxwUCEvbhzWK4bo9DArUeou/SRIuobRakTO3VyvX0RLqGyev7AfRitxx1Pk1adyzCgPT7m/iovVj1YjQ1HBUl+vs0OD4KKpXQRCbqDBNszAvqawsP7oJwJEV03daAuY9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlds3AAE; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssKmtV/XvvOuPs5HNzZJvDpq53qSt/WNtdq135+uQOFcEcwHdJQmMmlI/hstyavRMmO61mRUcEdXKFAn5JgOSb+MD0GxU04I3Sb48jMTbEWhtkdUJaHUvod3RFknDH3pPHZ8/Rg39LuyNfXEcgxq833/JcBOb17tN/03SUooRWYE00UHmYVNSCn8yeH15Q7+hQSU6sGv8DkPCkBayPboOWHDfYvdjOlojlWwCd1wjOG0M4jGUfmKCWA3KqKjj0YbldePndE7+BADpRd5sQ3ze+YZyzg/rX0+EfClyWpUfm6mfPPSy5Uyx7MZ5+Kf8YSA65JWtsk8KX8YYY7raAcatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOQH3jMUDg5N72W3EteGTLw78VjpxEY/lnQovSsqFPE=;
 b=J5+8+RIZxbheAQMk9PUbeowSctTPEPkM+j2xRlhB0qPjr2r7RNi0ViEnCL4Bvb8FhFixevlkGN5aK6SuIR2MeP+zSS6tlPqjQLHvLWE9J7R9QWvBMxjlOmUeKKMBsRa4ffop5UKOBHnApcfeI+6roWxqjHtyY9VKZP7GBUE0hHUjICEUkMrS/rNJiHlJpNcttbmEbA1QDDTzP/NFQlSFph2TUZRX9rruEKfIL44O9HEjbmeckyQscRlCli+F7tH0xioptrsaJEZ8kXWskA3u6A0P7onNcgb4UauNhD34yuhlhPGXM6reVucp8fcPZmyqEXi3aavgTVKA2123y8vWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOQH3jMUDg5N72W3EteGTLw78VjpxEY/lnQovSsqFPE=;
 b=jlds3AAERADG80uG2vVHaJ1vMCOgz+RVXPWz6AfPxwD1A5/fgsYq6aYeo6VQKpJQHf5huY3bKr3NDvSEga8w1x/5ux/xHLweP+SqUaDHsdJm9i6AP/B6e2bxixJ20JcJ2Ueffc5j1IJSjG28QaXWyhE3bGzFMhAFOQ9atuLzv74NmyP3+2xpoUVJuOhaGnJv/MBULzBUaFpmraGkU1z260PejU4Q/694AGD2BdgqIAwQ0KJSlOF471fJDHo1fdWP0ALsPAI5Dpa6PQdDCEUG6p9G9FLpkd0o8jqPrQbZ1TYpTvP8W+E5LBZywfzSjLUWHGuXlcGnEdueTk4j0sEZ0w==
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 17:33:05 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:33:05 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	bridge@lists.linux.dev,
	razor@blackwall.org,
	nikolay@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	danieller@nvidia.com,
	dsahern@kernel.org
Subject: [PATCH iproute2-next v2] iplink: bridge: add stp_mode support
Date: Wed,  3 Jun 2026 10:33:04 -0700
Message-ID: <20260603173304.564055-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e55c15f-14bc-4f7f-e440-08dec1962b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18092099006|18002099003|3023799007|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	pVxlIoofsmwnsTN6vKLYKZ9FQkAK2j6xbjwvPRLD8F67R7DoND4GvZsGyY/LZaYJqA6od4Z81LuyGWlbQaohQ6Nt+gQI+80O5sYoWk20NRKqXnNQOKqyvFpWO6Xj4ItTHndfZwVIoiFMbIEu3ZhT+MrjP2tVFZBkVGz+EekLjp37bKrxKwdE+hMQNp79MCmFWnH6UdwfdUiORQMXp2+Y35OXg3vQJ1SJyOn/tvY0Ii4jJbHss4bCCP0lNR8tj0vacHSvIAGKX0tgHAMjbhtDsGkkN8eudF8T5+Hs8r1G6lDRQ95UnTrOSXCPzqpBz147k9lY9F6wuk9eGVzl7rlKAY+Y+MXgb1mZwbZoxAyLcUjGcxzjdejFrDSYQ9DsBT7MnxPkj3LdMr4CgoM1srdeFrIXRDZhddiIlgIniQ4Izq3e/wm8ktadC9VFK1pg97d4ODrI/cmW86fcBvu8WIEJ/30XucK7X4ZclP38ai2nHVTIx0KrQzKdu5HZCNZdwRcjXsW6474IiGoIy78hhVw2peLN+Nh2vg8skuBuQEg89ws139mrZJwKqSvZH9ExtNM7CeWEVHRD8yyJOZ2KLrNJimBtEn5ouN5JbkjP5Wgg80Mz8/1kjQB2mSme1auxvdphGLZFrOH4088UYVunpZ1wDuLkR36JuvyL00TTqOU05sVpj3NDnT/99ANXZ6Am/roi4IOtlhQJXYVoTTUFBRY9Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18092099006)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8gSI73DGZvstJZZBo/Jbf6QkMguRdvPP+k0byt9c8tr3n+0Y+927GAh4KDO?=
 =?us-ascii?Q?bluupOb7PPGqYo3N14XsDXTngxauj5ZKn6XcU3VWCrjO67UHQAtkG/02QcZU?=
 =?us-ascii?Q?TWzKV0Q+83nEr4HaA5125Pih77g4aZOtVi4ZyuMGENKzLkvdb4xNPD4x4LRM?=
 =?us-ascii?Q?esu/ee5E5YUOjNUc4LNVmzVhHMLOeFcrmum+9N7YqGxkvNq0tyMt8bZX6kcH?=
 =?us-ascii?Q?vUkCMsZWfdAUZW6G5QnBpkWiiy/W7hH64BH0PiNNWCIoxbw/RMnWxjWQrkDw?=
 =?us-ascii?Q?OZgVv7L47+zs8+IlKmb0YOWM/UnMIQVHmxwpMEwfGqtZxfezC1S/tLj/6NJN?=
 =?us-ascii?Q?Nn0zMV6pO0a8zwN66nLFCOCO1I9TGDwO9bJmdKr6hJgLiPIodAPaq4MsCiAx?=
 =?us-ascii?Q?C9pxQ9ekAfNb7ho7JaFGmbcuULXzOH1V/Qmx/EOcgfh7HuWjAnSNZ963eGQo?=
 =?us-ascii?Q?AfzCmBjaanJx2oiBEltdiAJq/kh1QdBO0cZycFuE5p/bI1LCmI2yNG9DjMA1?=
 =?us-ascii?Q?tb8EPoiYAQIKuwpwZ1GUOWFLLBY1O7S4dNg7I0AeUcrPZuh1fBG822M83cGb?=
 =?us-ascii?Q?Yx4Qi/uxsk93XICNn/cVFSdfbVu+ypTIJH+ku8nE6UCjt0waBgWAr6v1enKp?=
 =?us-ascii?Q?4hE5+0qjiRfRmeqUac9QJOw9rtgDy7PJdLnVGOvzrsW3TjA+ocwL3PAeT03j?=
 =?us-ascii?Q?wZ+QV58XuPuTndSx+cYsQU/eI4rvLtTzT2ltPeB6CNXXenjme3buu1qGi2v1?=
 =?us-ascii?Q?JLnRGog5UQ8TBonr0XBTVzQHklUFzZIYvnJZjxcFbf1KL72lSTKBYwsD5C9j?=
 =?us-ascii?Q?KblPaNfFKGUwFXpCquy0gx0tk1kaKQSnEh6gmswJRy8HNBEgHDFo2eCD3cL6?=
 =?us-ascii?Q?kCezZTzGBm6g8SvVmQqpj7HZjULk48RL7ZxoE7YkzQ/12ZtUIM8r4Ty2z6Ge?=
 =?us-ascii?Q?Y+5PouakLMUu0QdvZ/GG97D2pjcBxulHWEIgIWHNOcXEVmPpNxIZE+7TF+vo?=
 =?us-ascii?Q?b2qKB9jWQXljrnSCyjQvohTJTxUApxAQDOVFX+ytoO3QO5VT8S3s4pu6H9lv?=
 =?us-ascii?Q?kRRy5WKjGIwUVv9laPGMnRteGO9Asl/cJWyR/tWCESv/HrML/Ijsf7Hng1WV?=
 =?us-ascii?Q?4c+/ZUw6qC8MM++dN28fyF6UrBakxge/jzpKQhBV0+RkpJvYw2wDJi4rq78a?=
 =?us-ascii?Q?KtPnGOGJPc3wFmqqh4E8lqoeZZnOn0RRrq9iGxOSRZlExmaUgL85pgWsGn9v?=
 =?us-ascii?Q?o9gSaHBwYAiv6B0Bz/Cv2IpsAXGQsZ8oS+ZMPSi2lGxQVhBNPkiAV/NZyerp?=
 =?us-ascii?Q?fWOoMGNuf6i1IiqrW+OZl2hnfmC7sG93g7FM7TWZ5R+lxu5SJSd6jrE7NBQB?=
 =?us-ascii?Q?GnRufivxtLMwP+vWDPRwwVgsBD2btuXh8qp8Q7hfggE2syq7PANdUc3Q2d9X?=
 =?us-ascii?Q?rPVK4YX1dm8beg+9ID8DT7XkIUsxKK25WjMNJUD0DTJi743bU+fm7CH2RAwE?=
 =?us-ascii?Q?mQCgQd8hMjWaVpcs+UItpVif9mvuhdzLDAAXCTmBaEsCL0v/Z/8ZSNnQBOSG?=
 =?us-ascii?Q?6NZYm/TUJ60MbOGdpm51cZSJjc52hXg6yceYFKcrUhVQCbQxHegb8ASVHjCx?=
 =?us-ascii?Q?Vhze2+KhRx2OIrQ6Z9XRQguqssVb4jFlF5imrIjOfRVzrntYsDSzGGYdj9G/?=
 =?us-ascii?Q?svfKi6xJX6UhUQozHyN/gSrCJZHdBogdXnZj7bmHu+5mB9vCREoAwdVTyb5g?=
 =?us-ascii?Q?iNpvesjb3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e55c15f-14bc-4f7f-e440-08dec1962b5b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:33:05.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVpgQxnJmTlC/eG8pPpxG7g5Qyf44p15GYIkAcpJ50Z5vTcKCjUHO1cis19jBD1mYR7Z8J5BHC4iK6MciC05Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294857-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:nikolay@nvidia.com,m:idosch@nvidia.com,m:petrm@nvidia.com,m:danieller@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22D7663A320

Add support for the IFLA_BR_STP_MODE bridge attribute that allows
userspace to explicitly select the STP mode:

  - auto (0): default, try /sbin/bridge-stp helper in init_net
  - user (1): directly enable userspace STP without the helper,
    works in any network namespace
  - kernel (2): directly enable kernel STP without the helper

A shared file-scope stp_modes[] table indexed by BR_STP_MODE_* drives
both directions: parsing uses parse_one_of(), printing goes through a
stp_mode_to_str() helper that returns "(unknown)" for modes not yet
known to iproute2, keeping the JSON type of stp_mode consistently a
string.

Example usage:
  ip link set br0 type bridge stp_mode user
  ip link set br0 type bridge stp_state 1

Link: https://lore.kernel.org/netdev/20260405205224.3163000-1-aroulin@nvidia.com/
Assisted-by: Claude:claude-opus-4-7
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
            * Use a single file-scope stp_modes[] table indexed by
              BR_STP_MODE_* for both parse and show, instead of an ad-hoc
              strcmp ladder in parse and a separate local table in show
              (David Ahern).
            * Switch parsing to the shared parse_one_of() helper. Drop the
              fallback that accepted numeric values on the parse side.
            * Print path always returns a string: keep the JSON type of
              stp_mode stable and fall back to "(unknown)" for unrecognized
              values via a stp_mode_to_str() helper matching the style of
              validate_to_str() in ip/ipmacsec.c (Ido Schimmel).
    
    v1: https://lore.kernel.org/netdev/20260518163647.1935156-1-aroulin@nvidia.com/

 ip/iplink_bridge.c    | 33 +++++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index df3264c3..1ae0501a 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -19,6 +19,20 @@
 #include "utils.h"
 #include "ip_common.h"
 
+static const char * const stp_modes[] = {
+	[BR_STP_MODE_AUTO]	= "auto",
+	[BR_STP_MODE_USER]	= "user",
+	[BR_STP_MODE_KERNEL]	= "kernel",
+};
+
+static const char *stp_mode_to_str(__u32 mode)
+{
+	if (mode >= ARRAY_SIZE(stp_modes) || !stp_modes[mode])
+		return "(unknown)";
+
+	return stp_modes[mode];
+}
+
 static unsigned int xstats_print_attr;
 static int filter_index;
 
@@ -31,6 +45,7 @@ static void print_explain(FILE *f)
 		"		  [ max_age MAX_AGE ]\n"
 		"		  [ ageing_time AGEING_TIME ]\n"
 		"		  [ stp_state STP_STATE ]\n"
+		"		  [ stp_mode STP_MODE ]\n"
 		"		  [ mst_enabled MST_ENABLED ]\n"
 		"		  [ priority PRIORITY ]\n"
 		"		  [ group_fwd_mask MASK ]\n"
@@ -67,6 +82,7 @@ static void print_explain(FILE *f)
 		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
+		"       STP_MODE := { auto | user | kernel }\n"
 	);
 }
 
@@ -120,6 +136,16 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid stp_state", *argv);
 
 			addattr32(n, 1024, IFLA_BR_STP_STATE, val);
+		} else if (strcmp(*argv, "stp_mode") == 0) {
+			__u32 stp_mode;
+			int err;
+
+			NEXT_ARG();
+			stp_mode = parse_one_of("stp_mode", *argv, stp_modes,
+						ARRAY_SIZE(stp_modes), &err);
+			if (err)
+				return err;
+			addattr32(n, 1024, IFLA_BR_STP_MODE, stp_mode);
 		} else if (matches(*argv, "priority") == 0) {
 			__u16 prio;
 
@@ -512,6 +538,13 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "stp_state %u ",
 			   rta_getattr_u32(tb[IFLA_BR_STP_STATE]));
 
+	if (tb[IFLA_BR_STP_MODE]) {
+		__u32 mode = rta_getattr_u32(tb[IFLA_BR_STP_MODE]);
+
+		print_string(PRINT_ANY, "stp_mode", "stp_mode %s ",
+			     stp_mode_to_str(mode));
+	}
+
 	if (tb[IFLA_BR_PRIORITY])
 		print_uint(PRINT_ANY,
 			   "priority",
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e89b2db3..b2661bdc 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1719,6 +1719,8 @@ the following additional arguments are supported:
 ] [
 .BI stp_state " STP_STATE "
 ] [
+.BI stp_mode " STP_MODE "
+] [
 .BI mst_enabled " MST_ENABLED "
 ] [
 .BI priority " PRIORITY "
@@ -1828,6 +1830,36 @@ or off
 .RI ( STP_STATE " == 0). "
 for this bridge.
 
+.BI stp_mode " STP_MODE "
+- set the STP mode for this bridge. This controls how the bridge
+selects between userspace and kernel STP when STP is enabled via
+.BR stp_state .
+.I STP_MODE
+can be one of:
+.in +8
+.sp
+.B auto
+(default) - invoke the
+.B /sbin/bridge-stp
+helper to hand the bridge to a userspace STP daemon. Only attempted in
+the initial network namespace; in other namespaces this falls back to
+kernel STP.
+
+.B user
+- directly enable userspace STP without invoking the helper. Works in
+any network namespace. The caller is responsible for registering the
+bridge with the userspace STP daemon.
+
+.B kernel
+- directly enable kernel STP without invoking the helper.
+.in -8
+
+Can only be changed while STP is disabled. Both
+.B stp_mode
+and
+.B stp_state
+can be set in a single command.
+
 .BI mst_enabled " MST_ENABLED "
 - turn multiple spanning tree (MST) support on
 .RI ( MST_ENABLED " > 0) "
-- 
2.43.0


