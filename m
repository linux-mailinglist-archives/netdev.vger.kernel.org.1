Return-Path: <netdev+bounces-182491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C021CA88DCC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D953B3686
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E21EE007;
	Mon, 14 Apr 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHRCE0o7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42211D63E4
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744666130; cv=fail; b=FkCRkGIsDilkuWvU9YMdwq+ajAqsOBrmNSsFRjQ6NtNJmLM/0PwjZmj5zbnfCO77BGNjray74gCHvDxj9nUBsK9ShW40qQCI8wI8L1sDf34nTj7Ldd4WreZ8tzID5Ekha5dqCwzYQbI4HQzEYWRZcIBEYxZK4/Iw3fBU9Mweh8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744666130; c=relaxed/simple;
	bh=DMX8LgXPxbaGIbHFPTHdbGSYRJ+iO3+Jt8FR2NNVkuE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G07jIJwPlyX19ENzcW/HQzy311TFAiiSTB3e5QjsHJyX+rVo2+0ScYLUT62jEkAQumGlTDrUYzDw60cfwZ0wC7sDsuErFaMgCG7mwM4Buoi1AB87aDNo5t9vkRTvSwL20NFZEY3L3/p/ZijEuXhPbcWeAIRr/UsoHmQD3nLbrhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHRCE0o7; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XysZ8W8d6UkSswBmeCYObiA95YPSTGeRFyjpfYzVRFuYVzlgolrSTDIfZ8ghrip3rTu5bdD7DwHE7V5IwS05DV9ceffgCvkyHI+g/HpOyVAm7YmI5GzNtagGMWH3Qm/n7dt7E6NfU/pyznRrvnx/JgHb9qKwaRW78Qh3S5ZRBHGZrH0C0FWAxDchT8dAxRP+cMu/DdSEWdXVPtHO9U5GcaPVhS8BhKUYv+AnfMfGxbSUqFMhFGE1advNenUiKCLPuTKMC7oBi7UT6NZliX9e/uLtrD7HBVHY1veJ+TWGb+iSeyqZdUVRCPsrYCV+yH+EJEdSoMHEAnr1mBGZvCYg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn4I5M44pcjtE6+w90jP6KvS+SMEuSuHx5fq4ePNO0k=;
 b=Yz98KvgQxeATSydu6uFTOF7iq5waFwkKOTOA+zcL14W/jgJbqrZ2cd+uitBX6CtS6VmH+CvQiaXiNEaccIu8p9PSxiY87C4YUY50tWgnxNS0ZDIvt2fyf9m7F0e95tWLXscC/jDyOqpy1G2VsvPoR5KMjRXq6eNpSVNjzD+HHP6lRN2JedfLR8PfEVNNo3oyiTR4rMWXOS75onpjh1I6Yo/fQ6+iIeqSjmNWyNlqSLVTLbG/Gm+YLyHiYj3OLiwTFolv2ME8MNvkKpuxEGg+B5inrullcRbTY3jAkj/f2hJwesqGIt6Jujva078QDfmr+zagj6JuLakr0q2WOLIYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn4I5M44pcjtE6+w90jP6KvS+SMEuSuHx5fq4ePNO0k=;
 b=NHRCE0o7TPAQnL6jjXK0RIhe/yPNxaEDNmFTOoOcipwr1Lya/KMMNcJ8ENNRfc8xvyT0ccWNnO9w6Dc7vLDmI3BldwFEEPtvMCaqvIQln18loUULCRmybdotkKq1iFGwp5PGzrmXiUTtN0zmF/A/ehjW1jZ3qMWyjxpkih8ibB0bRjuONQicGyGEA9vQcFxxzv3KvQe9PMRpi5Z5lxhHkNB0qZ17+UKWsct+h68m/Fwqlg49yKfWHEpRIIUoefSOmCHci7oZEgM0AqfMIBm5nxmLrOUyLC8Ro+A8YWHd64UiCJy1Ut9MatUOtAQqjgoqFSKxHQYwiuZJ5mXj2FdCuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 21:28:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 21:28:45 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vivien Didelot <vivien.didelot@gmail.com>
Subject: [PATCH net 0/5] Collection of DSA bug fixes
Date: Tue, 15 Apr 2025 00:27:08 +0300
Message-ID: <20250414212708.2948164-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:803:50::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a7c816-ddc6-44f9-8e7f-08dd7b9b561a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ofcFXsedtvdIx7+3QlK0eDxdA2mqgYxhpFoA/br0AABX+Cr8R5CAjHXUlG+?=
 =?us-ascii?Q?EJPIiT1nKU7zoQbxL/RLP94tXce+3qSZTMT+67RHd0iZF6UkReJ1s6gnXyPU?=
 =?us-ascii?Q?YUV9udRv1mLgVAxet0rrIGPNa3dom1KtUIakVKyIac+ncyxM9yJVrP//Jl37?=
 =?us-ascii?Q?1cfq09TvuYHuuDQVmUbDz1AbD8Ry8OIpFPAg1opFPJvm2yt+WxTEhvuhsbyH?=
 =?us-ascii?Q?lw8XxZKwZw2Juv0lCkmmVh2uMyfOik9EpnIz7rAAyAwAtTHVN69YXnRyI8/c?=
 =?us-ascii?Q?RDS0ovyvjBDLLLiHVVCrAaUftzlhImcrFkDEwzXvld+xE/c0xi/QMeJGbexB?=
 =?us-ascii?Q?8ILdR7wOzrjzpfdRchjQT7uYp9YGKAm0fGJD3Vo3F275Z/LKUAYtL/uV94OS?=
 =?us-ascii?Q?GzyYOjP2AvdBSCg8sTLm1JxlmHBR/73kbklBUtneF6JN4Zxik/rFSZTOKEWX?=
 =?us-ascii?Q?3DrvJFgxyCsqfq223zY6u4MNiW7iVYPd0xmyZzwncpkRf7kV7H/TfBWK6hnd?=
 =?us-ascii?Q?JiunUiw9yE4HpbcdusvVl5nUYpqhFI+QBz9UsXuol1pLw3jCiPDurUTiO3ZN?=
 =?us-ascii?Q?I2qXddZD2w3ZXr0/TZmW8gQS21OJB20qufxD+rHy3veNoETdWXkKwbpjifsB?=
 =?us-ascii?Q?e7Q6aFBbRzMN1gv3R3u6Y+7r6XuHpei7ZR8MQXVmuFYfTuycTHHBupwou73E?=
 =?us-ascii?Q?GnrINzPffvmHV1JO3WrXcW+16u/M0r2uxFmwhkHUpcP9L4DLSuvhYtBy7ltX?=
 =?us-ascii?Q?Fv8TNk0M50UE5kWZM9vYlxLuJ6thtWzBvOQn3om4nTDuaUPslLVr+3ypYuz1?=
 =?us-ascii?Q?iBlX9xc4huFv/WccPDbIXtWMZSNpJs/Grop1tYRqQa5L/U4RTzxSEp3gnwqc?=
 =?us-ascii?Q?SHklcK/349c0zGrjToOjJFOY355E7h7VP7bRMLuJxA9u20LMMYVC58OkyEVz?=
 =?us-ascii?Q?JqZjfPEjbYOwhF0hjff+V8EhflgxLFY0UvIQCPy9ObSxp9czM0i1TuXGcWUN?=
 =?us-ascii?Q?H3UHBihAoX33d1O25sv6Q+bJCVQgGiJqboNUqvJIuslGxj7/aCB9qF+v3VUF?=
 =?us-ascii?Q?uCC7ykx4tqVArnu7RQ7lVLztcUZiMJvhFNMYI3upCH3XKwgpIJ2i7tvbSSwx?=
 =?us-ascii?Q?1mHYO4ANLwpoHZjlpIeBt6sN/DQ6oC5hWXG5axDUngLvVx8DnW1FlSvbxsGE?=
 =?us-ascii?Q?vUXPvYJXnZi+oNmW17iyKU4SE0/jotYMmSVpqNnVHnVaNEPdC9AxeLJk6vzv?=
 =?us-ascii?Q?fiRp3K3kX72LIO3IHso2y7Fcb5NrJlgGqhBUnFUGk8C+EI79h+nbcEcFhHwV?=
 =?us-ascii?Q?FlcaxVqU96yNQNcL6eUzb1Gw1rCwJyNcY+HHDBRwyH7cXA6yKLkw9PEYM2ig?=
 =?us-ascii?Q?l92bYZEe0kBNHPUgrHD2egK8gOP+s/0xrgYse/tWLdDcZ+j13txxfcZrnwq0?=
 =?us-ascii?Q?wX3+i6u8qDX5HsoxkqTjpxAqUPpExLFJ8H+J37SS7v/e1hTUawQgPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0eF6oA29h0YB6ADGwO9KoVfgsvObHjPmotEIWBwprq0FdKVY8og4tFMiW3ba?=
 =?us-ascii?Q?XsZxEwTJ6nDwDCF5gdm8XYYrSazxva0vafqFf3V3gVdfkj1raAlNmD3RG086?=
 =?us-ascii?Q?GEwQAKDYYoRD1qQxY4qrpuiUE2zHcuggaR/BrvJkL2l/EKdJyOaR8fz1I8xN?=
 =?us-ascii?Q?qX5KhxVhq7xxoQCmGtoE3S8kGjqAZ5nbc7kiL1VgEfMbqCVgrcKHVoELYuQj?=
 =?us-ascii?Q?nVUWDrZAy7Ej5mCsuto+7Rz/Jj0evqfrtoUH0cvZxhy3Pr9j99Lfq2MIlJ9S?=
 =?us-ascii?Q?soU7yx5hVRcgXef/vKtyZiwW9EKTYlUtdLSsFoeebbamEyIyrZUg8ou7eAov?=
 =?us-ascii?Q?9x1i2pSllSwvhCtDSDfUlln3ipVHzlhBGbqCzTPl+K+3sncghBQeDAwXCFhh?=
 =?us-ascii?Q?UzaeGZuPrc5rUHj3i36l8Bqvhy8WvjBX6EbMSOL9kt9BSUCPaJWcFaqF4FQA?=
 =?us-ascii?Q?hYs7s2Xgu1eobRoVhEEL/xCAzSj7dQAe+u47fS8dkIG23g/uYC3mtwzowjpN?=
 =?us-ascii?Q?6RfBvTAFyrqdlUAE82I64FHSccR0Ui+T9iyDAtcv1BbmmazOllDcaFtRf5oL?=
 =?us-ascii?Q?jCviJLbVSywmZ8bAzQjnNBUzETfwgR3AC6mkqqvSemZCsD3xM9KLfgWIk/Ka?=
 =?us-ascii?Q?aw1cVDVUTs0FI4g/HSpwcH9h9DUiHuz5qxKthfalOtg9bog7ayM8t6efuIKM?=
 =?us-ascii?Q?Jb6f2LrHnKzioCF+EX5NUiDNzQy60vWJmtkjANQAHQ8dwCocWgGFP5CgYStg?=
 =?us-ascii?Q?z8ZmYs38h7WTM+UWPSuu/U9DLwW+d2VHtRB/uFHTqIyLc7e0FONo7EUCWygF?=
 =?us-ascii?Q?ZSDcmBOKPHvI2XWRaVqP9GPQXTkQR+9GyoNe4o4IITbhfIDtVm5reG0d8bhR?=
 =?us-ascii?Q?7x9CNzDtURpVyWlbOgkvo7iHFAuoGteGZM5wmrMmGANN0I733Jx5ygKfbrT4?=
 =?us-ascii?Q?R/0+P2yanehkRwtrS3oebbN3ztEPz0UEe1I+0o4sHQZv9TI7dErYCMipkbOU?=
 =?us-ascii?Q?9z9alhH20ytxDUSnvsmj9HYATNqotC7JII7r8g8AtRmcmMPLEUjgfe8J8XIJ?=
 =?us-ascii?Q?m5Qp7InOEtaDEM+6LRBnIbpZlHgdQF3EUjP38b3+hMxJYiMToDj4ogYx4UpN?=
 =?us-ascii?Q?dgnYkZkKxZvNgNDWS7pXdT2+d4f5OFzNGDX0Wo3QbRdE3dwuhRmAMAArHXFI?=
 =?us-ascii?Q?umzStnTM4IkwkCqkmAolMO/8p0WkA4lz+0YssozsK4ffG4NNrJ4fR8RHZiFZ?=
 =?us-ascii?Q?JTxmESx37ML0nXH9R/hSwzUjesOEn2+m+Uthz+/euzWLSTAfsLmnepSYQN+M?=
 =?us-ascii?Q?iN0wFKBD15hNJZBD6rOLgtVbdfB8VV4K5U3QwtORXyNc1McnVRfYu7evsfOc?=
 =?us-ascii?Q?LKUfmBO4g0psz1FfB2smHXKg53SChbUGIzVE41/3dHvDqkhWy9E7j9FGfszi?=
 =?us-ascii?Q?SM+UhCG2+aAcx0CxVCGtOuSuG/OQhIFW0kj8rv4oV8+1bRlByK3Yp1X7rK3B?=
 =?us-ascii?Q?S5AKPVbbYs1SQwlBzaR+g6ClbjhdgMqPl1ZBAc0TLeWuT4oG7SnuKCkxCImV?=
 =?us-ascii?Q?ohbcT0UZGkahR0OsU4MOix3Cr4yBIRAu3h8AcUB12aG/C3RqJZQOfe2rLs2A?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a7c816-ddc6-44f9-8e7f-08dd7b9b561a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 21:28:45.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9wi4wATISSWqTY68j0JSG699JZs3aTsOLRLYvJyZ02jfAGn92gR7ddlh+Ee2T0O4hDpyr6wDphMSutXYFiLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

Prompted by Russell King's 3 DSA bug reports from Friday (linked in
their respective patches: 1, 2 and 3), I am providing fixes to those, as
well as flushing the queue with 2 other bug fixes I had.

1: fix NULL pointer dereference during mv88e6xxx driver unbind, on old
   switch models which lack PVT and/or STU. Seen on the ZII dev board
   rev B.
2: fix failure to delete bridge port VLANs on old mv88e6xxx chips which
   lack STU. Seen on the same board.
3: fix WARN_ON() and resource leak in DSA core on driver unbind. Seen on
   the same board but is a much more widespread issue.
4: fix use-after-free during probing of DSA trees with >= 3 switches,
   if -EPROBE_DEFER exists. In principle issue also exists for the ZII
   board, I reproduced on Turris MOX.
5: fix incorrect use of refcount API in DSA core for those switches
   which use tag_8021q (felix, sja1105, vsc73xx). Returning an error
   when attempting to delete a tag_8021q VLAN prints a WARN_ON(), which
   is harmless but might be problematic with CONFIG_PANIC_ON_OOPS.

Vladimir Oltean (5):
  net: dsa: mv88e6xxx: avoid unregistering devlink regions which were
    never registered
  net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is
    unsupported
  net: dsa: clean up FDB, MDB, VLAN entries on unbind
  net: dsa: free routing table on probe failure
  net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del()
    fails

 drivers/net/dsa/mv88e6xxx/chip.c    | 13 ++++++-
 drivers/net/dsa/mv88e6xxx/devlink.c |  3 +-
 net/dsa/dsa.c                       | 59 ++++++++++++++++++++++++-----
 net/dsa/tag_8021q.c                 |  2 +-
 4 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.43.0


