Return-Path: <netdev+bounces-262467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO8LIDDkpGnFuwUAu9opvQ
	(envelope-from <netdev+bounces-262467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E21D242D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9F1B30293CE
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B00260565;
	Mon,  2 Mar 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7RMC7xX"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC91255F5E;
	Mon,  2 Mar 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772413932; cv=fail; b=Cdh5nMTYnchHsw1tt3qBK6RGoKgS+H6PkTQ7K09xJ5MnMkDmzarh+lcmyBqA2g7CTRbUa8A92RM4juPFZvxGLo14RQRU1X7v1ycV9ZQHZ2lEIpqIE75jU0tksOqQAEukMFytGni/GyuaUTJ+NReerYQ0lUUyZPZS+NyX56sfHG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772413932; c=relaxed/simple;
	bh=KjWL/rCJ3/9clsnFyCkIZmv5kLcFLenVqtTiBme/GSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2OYJ1O7KruQJRKfaOwfo5225jxEBj737ZyDqNg99G7lu1blrYV56rjRWOeT3cAKwTPgYCG/x+rAhG63ein89924V9jwsDCDvqxtVwB6/ONzcscvtR5DeDqLrtDNh8tQwrTZzD/SFvOhvUPXYOyDwVgiqoJCQtDW3E6OdP9WAmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7RMC7xX; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roudC/1BQuK1C3A1rAlNYXlD6EhYU2y39xYX1QCZ6wRyzx7b3N9oQ4MxHKqJZhxiBQpyhiBkorC5cM9/AuPeSQfPbkHsGDBFh3HwaLEQxWPCHu6Vylyki90rqjGVrruEcyiFLFnduzgrXa3jfBo5vi5rnyO2BEF5feFOSupw8vksltG6jtd4RPZ1vxyvE2I8r2oZmi7RmtDA+764dp6HmunBv2UFZBClBAcPyhnxXQha+IAOHxtZq6mjNnXiM0+TAEaEJBGpcOlkBs7u7b4Kn4zco2zYXfgGOB8WXr8r1TmndvOUqTUeWaLBy6YRAYti2iUkR2dih/jNVllSceqvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY+R4ZyLpghZEdOurVT/ikZx5Q9R2gakO/uzR2dTv4U=;
 b=ta8yleaiP6pGund6vxwwN3laBGSPyTA4ASrVYHlZWV7blpDf8f9sefWwy+QLtryQTkDQVK4Vow828wVjazB8Opy21KM1s935ANpVKqQw02d2ADT63T+AHcqw+qfFoJcOsOviLjkCfnJZgUHzXjmHm3YBM1WXDs+fg+54I4AHdpN5nSv/fYOBoCGGh+iW4CHi/1KsGjUDzUE2rEaEqkI+n0XhBjfLhdXNyKeUZA/7hMstvNljTtHTItQz21s1htp6PBtszy+wQqPESzVqEOfzYurF+LbKrVI8vHNgSpR2qaLPRtA0Vkhr00y+dvCMdcV7vdU6qF3RwkS3CGoI9LRZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY+R4ZyLpghZEdOurVT/ikZx5Q9R2gakO/uzR2dTv4U=;
 b=D7RMC7xXWmyK3UERoxC7xPrzKi/EMv/YdkWc7NmTpMgllEb/mLjEi+5SzDgcic+fZAkSvkWeXjjCW83fVULN2UZdopC75fr5ppwIg/jgHSEWsaUDBm9iAXaA3eYy+o3qLDw1yDYn1HfQrXGjQBbqh0h+iPwnz9c1NqdWDna0lg2N9u5iD9SNm8eA8G8L/vqhRL9jKsflZLZy4owiCc6zZz0P51HgPWYdM0REanM3jxITkjb5dpv6+z1GPGcEoauvABG0YAz9sWk57np/21lossR1/ZFkYkZ5UPL7XCMXe2+ZNUIXypYZ0p0Aeo6aPjH9cfv0A8T52VRVssNiTGq6sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Mon, 2 Mar
 2026 01:12:07 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 01:12:07 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 2/4] ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
Date: Sun,  1 Mar 2026 20:11:56 -0500
Message-ID: <20260302011159.61778-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302011159.61778-1-ynorov@nvidia.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:408:e2::15) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: d3612d95-def7-4612-5dc8-08de77f8b8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	607+Ror4XzLIexJW/GCqSRSfa381ig3Ej11LRAicKiEmTmGa2k+G1ZndqYUE19zMLQSZ1BYPJFhMG13tGcWWb9qBghsUnc1NbrhKSZiuuVBf5QkVMcZJo5HMkPuQnqOEeN/co3RWstksFDerel2Im5yuSLnlhHL55t8ciq2jASKdpR5uWrx1mUL1xeGEuhxuPVodczV+lYn4+gOMdSp+yO7a68H/E7YPEyazsabweZtokrHVeHVT2kiEk1qllA13oAvLBq9fyORHzSlFS0nZUvb9SdyaEiu/eNinmKVR2SuawfmDa+SdFB9V5OzhhxOPTuKw8ZHRKgrfEPrVvMjf8BgmiMDqz+Ctv9m52JpM7jPrTTsgp1DXg9W8Gq4BDUZ/YTSzPkwHHIhaAg771zjj6NOapqFmjKjB92uf0TuaqnpUMTl9VAOFMjFr7IF+32vql/lXagWd8j3HMDLXpg0/LCYhz6mpotbhlk2HnCWIAYWh8VXnB76gWYOFrTb7HGzZQaAT7LyvKvSsw2ALOBSyI8v8bqhfVglrdTHZP72SvD1NbyB5KCbcsvZbsyZ3bx/a9FEJqNN5U5XOifYvAFEmsP5WSotOnj3PWqj9FAubD00lNX3hCHYacipP50tlbBlDk02X4MWpLS/09MCaOV01l+NZKnK9eFnyFKtaTppjVH/AczPTqXrMZMKrcsKYAv0oXqHoTnw4UqcrRosIcpku/AwweohLgaSv+3pi3rAE+nsO9Q0Hbq54VCn0lcyNRIByA/WzXkfXa1zw3nS1RxTpow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2I0q9Zo5Mm/U4e9LKETbTGnE0ev56il60+O0qLI95BST6uRilg/0v1jqrC0?=
 =?us-ascii?Q?FEd60qsAShMJt2wIFfy67CMc6A3hxdSg1jqkfDAaSw8ExrkaHg3p1N64dqey?=
 =?us-ascii?Q?vTU1N5OtJ5piBemeGmLOPTAAusfoi4S6cEosByztpx9QO4CR9A+eXzRASF/2?=
 =?us-ascii?Q?vVHqjuI5NZV39mSBREcfxoSgwbXd+x1EDTZp52uCixMRU/xpNT5Rs9dElF39?=
 =?us-ascii?Q?0bf/6Uz36slrHk4Qs6jSXMSPVHwwwVBH+d3AOjJ7fiYnIBezdtgaeY/nT6h5?=
 =?us-ascii?Q?fce7i9XEvpmD1+jUEmhpkzWT0U32c6wtHWflXBDSQVUUk+0/hOX/BkZQS6TC?=
 =?us-ascii?Q?DKLNpIDS7N3RWfBsA9Mr8WpImiPcTV02mGliod8/PB9ktS62g5tQ73+yNe2e?=
 =?us-ascii?Q?T6fbct4BnAEKL4u86vTaS+vWJR98eq9oxlPkZylBzOdixUSJmEwCCJeWOLdT?=
 =?us-ascii?Q?Ihx5aNHyhV44KT6Sqlaet73esolFHquczGO8tYGtJo8x7u40IbPas2PWXCQH?=
 =?us-ascii?Q?VHoYdzlxAihTXMXQiviUirIdiaXFduQgeamHvz6kJxq2YmAt2gQNTWbcIH5f?=
 =?us-ascii?Q?vWW//ixcpwKNMBMD68tX+9mX7T7/VY5dKdzk0Rb5/Cxbk1qfHPfKfLbJFy8x?=
 =?us-ascii?Q?h6x0TZvdPKr1c+KiogTGtwXPpLoySY54K4HQMs+PocDC1lqZZzOY9NNGHa5R?=
 =?us-ascii?Q?OVVItdTlKt1uaJBO342qzVzAIBddahoyfAv0lur13A99biqSZqUVhe74eOfw?=
 =?us-ascii?Q?KhyBnxwH53nQARcTPE3pn/qaaQd2RohoqqcCAUm9PXHPtgaVhwef6Xd983b2?=
 =?us-ascii?Q?pGmFr/2D2ps/bzaLyqfpsSudN4+JQNamfxiQz+4a93y/D56hs1s4QJvEEIFU?=
 =?us-ascii?Q?3rilkdqHkSXoZ+gDbHjTx0I0JjnwT/90sYen/ajQSPlMFC1ifb7Q6gGl5Xng?=
 =?us-ascii?Q?TivCdhfZrLcIPnAh2kztcGBvczVuulqSYdBw8rMdo30GCQ++rljkQ1aWFHz+?=
 =?us-ascii?Q?OcLQgsbBMCS7/Gmiv7rJXhKC/xh/Qt4txwPVXSFl51+DJXY9uaz6/S3JGxba?=
 =?us-ascii?Q?B9er8U16jK6T3z6tmMqkTz2xs9SsJMgjzaIn71q7npFfCuRqIXPvglWb60Mp?=
 =?us-ascii?Q?CZekqjrGvMYAzjgNNERuDpeIDftf+VvtXV45jLOZb7GYJDKu6i3EfK+7chK8?=
 =?us-ascii?Q?y7MAcZNMTd1S6+EdcATbLig7+79VskSn5IPg3R5kBhkI1A8tPtq5mythHBD8?=
 =?us-ascii?Q?VXrJjwi+XkdA34T1e40sBpUJEhM696fcNio0Arm94Y+bgokI9Axt2rJW2Jyd?=
 =?us-ascii?Q?+7vTi9rtisRI4/lTRrXpqUSdtFULHkw1ZtlSWx/0hgz2hqFHDtZxAdrXSCFN?=
 =?us-ascii?Q?+KBnlpIyXMntTwQHwA4fsPiiuIewS5ixglRnsvYyQhxCoGPeya86hqxA54iS?=
 =?us-ascii?Q?/CbKjj8/lXaYDU5G/9Zlb1CW1J4oYiRBiuAXh8LdtPj+NQYn5bZBbxN9IRcE?=
 =?us-ascii?Q?HC9PXxcrcljSG3XpDF03RrCvixJMd47t1r5PUotqaDroRHt4TIHGQBdgCneV?=
 =?us-ascii?Q?FBR+r3EQ3n1D1PP3MWCxRH0EWNHrfLE8MXY9jxwXOOWwBJMpZp+ETatEEKQB?=
 =?us-ascii?Q?UyRhVygVExMjoC//iUO3hoawcVpTKo8vlmKGwoXryRUVpnBoCCBaWxAFX2Cq?=
 =?us-ascii?Q?Ocl2IpHA+7a3ku6c83ablZOcEUTGoClWzYAqhxrYCk2GPyMUYik2NH4+KNR7?=
 =?us-ascii?Q?nHKkocshWpWHWZzmkfchGtfSPWLA03QLOtecAEFPqxvPN5gJs8p7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3612d95-def7-4612-5dc8-08de77f8b8ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 01:12:07.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKoDSC4tJ9XNj+Utn5mW2IWNpyij3A7+Vvso2+dLSColi9vIecPKKUXALwCh9GAlLGqmPNQAI0pOkRqN4+EOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: DA3E21D242D
X-Rspamd-Action: no action

Use the right helper and save one bitmaps traverse.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index bb0f990fa2c6..6a5875bd9c6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 			  hw->switch_info->recp_list[bit].res_idxs,
 			  ICE_MAX_FV_WORDS);
 
-	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
-
 	/* return number of free indexes */
-	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
+	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
 }
 
 /**
-- 
2.43.0


