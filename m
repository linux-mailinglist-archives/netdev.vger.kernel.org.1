Return-Path: <netdev+bounces-185398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3162A9A16D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDC4447D0E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33618149E17;
	Thu, 24 Apr 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXnw4JZ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3D2701B8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475470; cv=fail; b=Zr0vkzMT9Di7yl8lm1o/VVE6j9iieiSkQyuyIQ5EreCtTmVT8LUnTOfeYOJSbe8chTLM3cUM4KfOaYLextLIF2X4sacQaXE+1NSLLGimIoiuJMLYP5+JPZ1Yh+89Z3t9ZUxUQQR5aWRveTsaFV0ych5QRYvZGlRo3d0rk7wQsGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475470; c=relaxed/simple;
	bh=AMF1FdjnlL9l5xcTTL4WLzerv1vkBSeUfpSCunUzPyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YpeopE3hpChjstoqY3TKrh0wTcCkbP+2j+NBqELwpiv0xoITXtdA79LYC7TbyPz6Bff/XxSWyMUYSNzBkc5Sz7PZRtJB/BVkUN89yQmN+zf5A2FxduE737ZlbqWOtbvV/t43qeK7YjxLPM+AeGASyV3bvdQ2ugr/QbJTf8PLOng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXnw4JZ8; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7xT4dTgQBifVruk2TwQesKAVlRh6yvyu6ewMQZOeIU8PwHtUq8yBsDqiZ2jJCSyvD1XgaVMi3edKyez31xOYBoCbdwfPvbFoy0BZD065D6vSTeAkriclmiy+s7Ou5PMZjeHOPKkpj5YMLW+AYuTTUA7nY6T9Oqze5V6/H8qLqmt1iQ9y5BVm+ELQzoPc790ykqXhAbSpPTgOjFlLO1T5faDaaoOs9oH5KMHHH+N8j7gJV2TShhWyuZNt0qsjO9bthubyw4UxiodXclLFGM8WCOFaCquB+AmrHc+cjUUqn66T0GcQbrpnC1xNm/QfLDl6zUPrIvAWD5A3XDBxeojAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04pzaeVjZV/lpbbn4Bz3LvYl6KgmZa5cdrmFYr4/12o=;
 b=aZ9VBkSOtL8jumaZQMfh7w2w/M302foEJqe5MY6qHUqLajWMdBCtkMD2t+jwG0qUwqRftcGLm9ZePdMlk1EDU9f1CK7/toXPMluDBRHSlbD3pg7Ou6q6HLw6iLpw2PoqB6zRp3yDnCLsc6s3TBjGvPJqK911QmCPILPvNRa+RCpGLmx0k/Zj5ooF6r3lskgZl3r3Xy+79bAyr4X/8DBxB//w2Tk761bX77eoF7uv7EMsKNNHbL8CfAOV4CQ31DHbiMQvKjQF4yp90liyHC/QIuMKEkDzE356KBP2AL0d20AUQBRzIo3XKWXE0r2R69vX5odAbCXxKTQw8VpjQ66v4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04pzaeVjZV/lpbbn4Bz3LvYl6KgmZa5cdrmFYr4/12o=;
 b=SXnw4JZ8Q+WiVckjzMQuUhYdA5aaJBwQlhiLUIqrmK4/6uAINPtREH5nG1ubV4iWgwurogJRvyrqtbPceBbdBHKmdjkejUvGTfcNRta9o6eYIeEdJhRDaEX2rPIsWpzHrxplKS1LiDvwgKXdOt9y8XYY0ydxX6um7GXsCVyMrZ7w/2f5913UanHGmyY7cVwzb7/8VZ7pA0NSiFkwH6DbAo2rv14JPZR0/84uCE7AJlI+hP1/k8o6EMfJGog+huJDzzCFeD9EjF+a+95qtdUMLRwSZhQ+5xq0CpoP9j9c7QXGbIJG9wA0b1NN7Lz3LZLCAcieQsv/zcQl8xeqie6vDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:17:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 06:17:44 +0000
Date: Thu, 24 Apr 2025 09:17:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, razor@blackwall.org,
	petrm@nvidia.com, roopa@nvidia.com
Subject: Re: [PATCH net] vxlan: vnifilter: Fix unlocked deletion of default
 FDB entry
Message-ID: <aAnXfryT1sYcE7-m@shredder>
References: <20250423145131.513029-1-idosch@nvidia.com>
 <20250423142921.089e58cf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423142921.089e58cf@kernel.org>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: a74c8697-64d7-4244-ec2b-08dd82f7ba08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rH4pLPJvV57RmLPwpomxmhuEyactvNFFRyrRikJcYn3Gv7i9l1oEqNpnf/Ij?=
 =?us-ascii?Q?hJNI9krzVV8ICjUuKGoOnJzjV4Lv3pP0jY24e7u1G0vOlotkRPCP9IdomcRh?=
 =?us-ascii?Q?Jjz0oeIakezY/Ua90h3m8wEOgD5slmLEJJV0p7AGmzLFQUjCzjbZt4FeeEhD?=
 =?us-ascii?Q?5JYuDHmvtNpOwbexws3Hv+H0yqHWLsneCASezunBoHtQsXz0O7k4m8U3OCEo?=
 =?us-ascii?Q?3nTKWuRwJAmlPdsWkoTNRuIY44IL4uqd/8YmOaVysX77YpjethEEffGlmkrC?=
 =?us-ascii?Q?JJV11uiM4rlVSRzzwkF2C/PcN/hYP+T9CMf5SV+Pg0Wc8hNj5Ibf1bVPTMG/?=
 =?us-ascii?Q?qXKlCLrf5myVPYCMByc24L5cgMYo+Zo8hW3pJ941EJ6N89YpMX4cFNBa9Qw6?=
 =?us-ascii?Q?yzUUVVutWdEOgLE27YxEJnOKfDzWYeXMttBGJ//Ovm3n9puHzjXBDfN0aidv?=
 =?us-ascii?Q?WP1TpffTMs8TlnwThkNFxAf1bhMjUAVFq5Q7BmAMbV7E5bpfhAdV216xkBl3?=
 =?us-ascii?Q?QWxBApL4bXV9xHPEMDAkcN5hCnwMm24V4tTY6nTDh7cyz3k1TcKhlR7eKp/X?=
 =?us-ascii?Q?KN5EEsq9adiDfA1qQmfzK7BjrIUAC+KY3jm0ovEAdPoYsanzDR2h8Fnxu34i?=
 =?us-ascii?Q?v1QP0+ZnZ97C2SIKnZIcx7DxFOU98+RL+sDpHCM7v9U1/UublKsFRYdYly3B?=
 =?us-ascii?Q?o3cwavlo9RMGHpsUM4U01aZghGu6S2s8dtHv7N1lds/9Io2nRxo8qjbK8sg2?=
 =?us-ascii?Q?4+qH7L9csjtFAFDeMbBmfpzPSNlcbkgmkVJyzHD2Fxl+AIZEj0uqBOYL+Qet?=
 =?us-ascii?Q?/FIG4g01rRSIxR0z2Cz+1ahLCgNRE5JVPcZn8rJYdQmS6kO3BkiENMveWhKg?=
 =?us-ascii?Q?rwpCDRzt+oXz39R7pHMzzHssmJoGvHAZsvtF5eRLD4HKiCMPTF1Zg1HSUhp3?=
 =?us-ascii?Q?YYSqqSXV2pouq8j2jocLorAqFh4H0yfRRGtQA3ETLxVZM7y/EOnQlC3aKYZb?=
 =?us-ascii?Q?yOtTqc1ImBOD2DrDwgu3t3PVu7dsU0wK3b8I9a5jIxz16y6te1DfRpdiA2a5?=
 =?us-ascii?Q?1eOEJvtqiSaSBb9rlgvk++S41wRADh9r8By4+m+EI3BbQTcCICJfaQ/NzNGV?=
 =?us-ascii?Q?zUtev1iw5Srkc0IzqIMh5w/wIoGLoO5/YYHXVjMmQuwjbFq0BF4UUcpcS3k5?=
 =?us-ascii?Q?qgj0vIupkQFbgebfCzQ8kio5mfBicB1XRB/hqUyuwu4eO+26xMMgEJh47yUq?=
 =?us-ascii?Q?tf+HrxMsc0EltMEv9Wan6BxUZ6e1b+RQkl0ur+TPmdenin+t7cdClf7kWc9r?=
 =?us-ascii?Q?C1EOZBDi4/uoJKnN0a9jYXSUqWTvKN9zUuKMyXELu1aAhXECBkX2/on4KP6T?=
 =?us-ascii?Q?Prob3cDIO+hAoJIwWjR9bOPgWVkMEON64zXrtyAvQdVluWKAZDZyQ829Ek1W?=
 =?us-ascii?Q?ynm6kL1vQss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3m9HdQ8QccwVqCDgUVh2MndQnjNg7meB7XWsqn1EibUrH/Z4MGdSObvQ5IxL?=
 =?us-ascii?Q?AuudNICOB560Y4wwdsM97+z7q/gGpLjQakknyr8Fm5nI46aMK9oJ1ru9DV2L?=
 =?us-ascii?Q?CfjT/ldTfLvyTiKk7eCHvofTiwAioulTqIdzUi46tQWWiWKJRd7LWgloKF5t?=
 =?us-ascii?Q?zgXsfRaDbfo9hQyd9toutocivRLu5MAuZv6El1FrohxD/3+OuWWi4F9Y7/+v?=
 =?us-ascii?Q?pptxwc2siVZ+Lk1bjW2qYJdZmQ+kVjPIZoMtUoA66jSTZ64D509bas1k1dsw?=
 =?us-ascii?Q?xZB6x2AUxUxKhQ578u7/VEtNJFp4xAAufyZ/rZtDpGwceTQ0dthxy9Y+AD1M?=
 =?us-ascii?Q?PvYo2h/wR+grYUJzKVc07arUFTee1bhJvk6oUWPOS7k2FKiwbSeDuEHuI64h?=
 =?us-ascii?Q?IVTrHYcbKhnz+sMhSmA6D+Si7Lk2idO8/IBWJjmsIQf6pGz08Q87l4VufM+1?=
 =?us-ascii?Q?PI99B7D6CIMUwxlgSX97SW+XnhpPPw3N3eER9FpzJyq8GppEmoM0C+jh5cOU?=
 =?us-ascii?Q?sg+cYorxasYRSbINB5Tm40oy6DU+e03zhFqlGhZ5IFz26WqfE32zvK1mstaN?=
 =?us-ascii?Q?PzT6ZVxLFpZRxRGNk70lKmzkplIhXuUBofErJ023h/ELgFmdT5JY7Oji4yWa?=
 =?us-ascii?Q?r2PDS57LmIzhIcvHUdTWtDG8nW/JBYyvnFhzY25IFsLVB4RVAjwefywpwk3F?=
 =?us-ascii?Q?+EZrj5ZVYIXlRexKtVMzARdbyOMuiqxNhg5+mP3jGzt/vf91QROXiA1+FvtA?=
 =?us-ascii?Q?lWRATdCTNbgaUhFm/LQ0mK8Uvasjjku7mhF+d6jHllIuFar9cPNrxcfg/MnZ?=
 =?us-ascii?Q?C9KLoLuLfWEhmgnUQ/lrquamawSKSkEaeDKT90krsLSiL11JH1KbhOf7miFf?=
 =?us-ascii?Q?FJZoFn8BVSMmpgHWmuSu5JiVdtr7NYIbDE4UDP+IcVQikPZCygw1BuDKhmvb?=
 =?us-ascii?Q?a5Bbf87FTzjs9sF3Mav7mn/15Yqz8iK/4E+RGMBG0cwP63NFTDktVRzSuEz+?=
 =?us-ascii?Q?VbJinh8VAYW/s3B90R6D18mNYIO3Ji5LLki+xtZbtnhMnLsTRtYFrL7gnVU/?=
 =?us-ascii?Q?iFSQP2c+NpvWSZ4AhvoRWXI/VQvKw3A7hpVAEwBsrlYl3lXIV7Khvy3jKMXh?=
 =?us-ascii?Q?/rir8VO9nlfFtNKArBtDT7GKufwcjoykJsEmvEKcxS6TlE+vxAmkYpKiQrnL?=
 =?us-ascii?Q?eagbjpQfj9zHoyjt0ubzqfKsFPmc6OoL+8JOlaMZXuwJEOkKg8fdxhFMMmUA?=
 =?us-ascii?Q?zhi0Q6fkrHOw3hsNHfd5DbOfC1yQPvuzV86hU4e/Z+ckaz3NyjNu60fWAUDK?=
 =?us-ascii?Q?OX9FA0hff0ZYMa+UkmtiMvnMWqkpBNroisTOgwYSyP7j2MaX35WPiiO6rkvp?=
 =?us-ascii?Q?u/sio75yB5tqFtuLD3UoNoGYZWYRA5G/YLxa5jAxLXjIOW0mBX5MMS1RgfbO?=
 =?us-ascii?Q?qYv6i//valDvDxNhPx/sCtjadj1QIrX3v1RCF7K/J7g1NxUCqs3UvfDDPt+6?=
 =?us-ascii?Q?ImjWcIbzrOKkg6G/xmpWJVLUYOYOhyea9w6wHmNXAgWeEZ7n8bAfKluntTGK?=
 =?us-ascii?Q?caPz7vFzBjdnNvSNWMTbK4qJnlW7xeYHLrzLeGiT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74c8697-64d7-4244-ec2b-08dd82f7ba08
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:17:44.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm5j/VDajteN+dwlquJGdD0L7HcKmlzynLCu/ubDHN1CiPAqxK5EDYCpAgIoQkBWHCH6RBfJyLwDiNM55uQVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

On Wed, Apr 23, 2025 at 02:29:21PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 17:51:31 +0300 Ido Schimmel wrote:
> > I'm sorry, but I only noticed this issue after the recent VXLAN patches
> > were applied to net-next. There will be a conflict when merging net into
> > net-next, but resolution is trivial. Reference:
> > https://github.com/idosch/linux/commit/ed95370ec89cccbf784d5ef5ea4b6fb6fa0daf47.patch
> 
> Thanks! I guess this shouldn't happen often but FWIW for conflict-less
> build breakage a patch on top of the merge would be more convenient
> than the net-next version of the patch. Like this:

No problem, but note that "hash_index" needs to be removed as well, so
this would be the diff:

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 81d088c2f8dc..186d0660669a 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -625,10 +625,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 	 */
 	if (!vxlan_addr_any(&vninode->remote_ip) ||
 	    !vxlan_addr_any(&dst->remote_ip)) {
-		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
-						vninode->vni);
-
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		spin_lock_bh(&vxlan->hash_lock);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
@@ -636,7 +633,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+		spin_unlock_bh(&vxlan->hash_lock);
 	}
 
 	if (vxlan->dev->flags & IFF_UP) {

