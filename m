Return-Path: <netdev+bounces-218003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36EB3ACE2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 23:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4725567AE1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B402264C0;
	Thu, 28 Aug 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="j3oobop7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF320E715;
	Thu, 28 Aug 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417512; cv=fail; b=hqtDCaGRiTMniCA/NTEdJNqv9u4reviU/db5dVA4TOBc6jlVZtq7mxTzKYCUTjlN6b12qSOg++Qf1kPp364UthVJVChk37xqPm1zO7h2kZqkimSH5drOOLY0NTb4j7jv0zV/EUnnDf1c5cPH3YYEWaOwRrOAthJgnPkd1RwNM18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417512; c=relaxed/simple;
	bh=Y85K9HXnM5bqY6rA9SLjW0w6vukL81Sj4WyU6yUhJnM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uapvKlW5xyAyj2DTio1/iWFt88OFBLpwRutNPXtfclLBSBuaKD4cV1i2pMzZOq92LG5EAib1eIKOx0IeLXriLuko4MHMr2MW8G3ucBvPwh2yNDnlhW1eOzb+O9HF2X9ihZeX6qTjBPdLik4Jv5sQ6jozwe98ErjqtoypeQkGM9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=j3oobop7; arc=fail smtp.client-ip=40.107.223.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3c7ZutH8RFjOVTJyen/e8i1gYqBcODDTRgpKCm5u1874Zo88LsNA7MeQFkRpQ+1vdFTXq4g+uMfx/r/ndj0EaI/p/66qQRj1/S2K7PMVfMQecBB9VkAbIHbQqSvi26NMo1lvsLQw/5IfAH6FbWTwpGvkTRtFyU1uh2Q0WIFtRD5z/Af85Jj7kwE67G1BfACsYaAgV6EEYyZSl24qsA0obWjbj1r8mxfq9UwWXf4nDxnOpD7rszGULD2gdWhCTQGF9XANtgkOQXuhwf1RBhT63nfkA9PX1sg1cFohOHpreAqJ4yyfIaPLnAyXfeIP/tupvGI3I4yzH3R7EtXtYq6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClmGw5uul0VVUeOyHKJeSGYVGw/pFU2GBSTpQX6y3GU=;
 b=khPVIe5LxPo0/6DNWeAeHGPvmHeDnVbFuWxIn++kBJ8MMcoOOY1uQmjcGTY1Z+8FA0+YdpmO/BJtjio7fOCQyc107oUwbpGS1p8qow1pR7Uqa+HRXARMYDV2OhBYK7ZaD+y+tloCeFO1SvE7xdXDzrjcSmGjjHDjq7cHr93Y5zKV9DYVWfdaU6iTKXTHAcATCkj5My2UM9MI+JfXInGxd1YG+UVFHOSERIhG+vSOsLyhfLxazHJyESsctDYZo8Cvjb+uIw7RY8mloRUGehk1KE5RlcsDDEmcjtkRm9N90EIa51jnNyn99xYiHdVO1jSk5hpl5eHZwNcb5YekHSC2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClmGw5uul0VVUeOyHKJeSGYVGw/pFU2GBSTpQX6y3GU=;
 b=j3oobop76lMSy8YihbmOR80nGMJFcqDmW6/gurWwRoy1U1E+sK94FPS9HS2weEF6kO01rX3r1UAPFduPK68BtpAOiC/mFQUmZyp2bVkNlIPuu28g7KQ2ubtASmOuZTcUJgTfxzJmuc8rRYeEUGbvv/MONJCjzrxLDb7cj/of9M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15) by SJ5PPF842B33876.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 21:45:04 +0000
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710]) by DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710%5]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 21:45:03 +0000
From: Colin Foster <colin.foster@in-advantage.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>
Subject: [PATCH v1] smsc911x: add second read of EEPROM mac when possible corruption seen
Date: Thu, 28 Aug 2025 16:44:52 -0500
Message-ID: <20250828214452.11683-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF3984739DB:EE_|SJ5PPF842B33876:EE_
X-MS-Office365-Filtering-Correlation-Id: 247d3c61-b431-4871-73f0-08dde67c2598
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGYSd18kMf/guq1eYVXGXdlnsIy3rN5OHCaj/Kmlq1pt+KTuh/DfobZObcX2?=
 =?us-ascii?Q?M51vOzU2YpBXZe7TNSZksxUR56y5AsY/OQBXcUUk099wCYL6y1dZ9EqlcHud?=
 =?us-ascii?Q?TOe/aCvXt0dZykF0X6ggOd1xdrI2PG0dGVGb9j7Vn2lX8mWGEpem2owpRX/8?=
 =?us-ascii?Q?cQy9vX2AwRS5Ujh9948gvZ9RMS2JfUsi49WR2KkiEjaSeWU5WKe5Fwb6mlBB?=
 =?us-ascii?Q?Gv1xg+1q7LK+sm0Fwdlogc8OXbij9vNiPFv1zbDYd6gG7euuZfqq8HYzn9Rc?=
 =?us-ascii?Q?I9kJenodiWvrCdwaMaDOC4bZxWFNTW+2Us9AHXjP504oAK2x7QnKPjAHtU5V?=
 =?us-ascii?Q?pf+09azPsnIrvVrZ18iv6iat6KDo4W2I7oUEOW+kNBhbVLJTLuRHHKD+0WVe?=
 =?us-ascii?Q?5zZn6/RmWGgqcrFJUs1H4dt6XoPsAwOtfhL84k27b/Tsp6YAUL5FzoMQ+3eP?=
 =?us-ascii?Q?3DSb0glkLmaZMRI68Dw+9MhD8JLcJisQiA3bAXLmWFVPCnx85p+ssSHqxAB/?=
 =?us-ascii?Q?WaeYQYmC9kMZtdXHZHwvavGUzYreoO0fg45B4ArM/tpbfwoX/edHhvlKURGr?=
 =?us-ascii?Q?86MowTxRXCMw7rJ7BH8sHwdBJ6Klj+JlpdH7e+zO0hkqV2C8JliNpuYVM8l2?=
 =?us-ascii?Q?+JG1O5/+Jvo8F/yO2WWlgP0/j5pBbG6w0i/0TwwZJCBhbhXWVdjogiPrAyGr?=
 =?us-ascii?Q?q7Sau6CWsOumXUCuBqgqdM46XZ3ubQIq0Z/A5mPvL/50Ckia7+lNhMbaqWVI?=
 =?us-ascii?Q?iQxKjrXaQJ9ETsszAsv+hevbV3tD4mYcIMOSw4iCqMhxQ61DwnrmRckg45K2?=
 =?us-ascii?Q?DUk22XSlwCVGwjethUd3Zf1U/XXKvi8RfX6FdcZhBF0O1r2myCzeK7/Lyi3E?=
 =?us-ascii?Q?b+P11DU/D27zQ9evFZWNQX/kkQDa7VN/2dUMemaT9Tp9kgNf0l7J0oOs5zoV?=
 =?us-ascii?Q?D98AsyuLOe3YC7IDTFpGVMNPPXSyfyufwVbMZtghBxyl1Y4lpVS2t+kPHAEn?=
 =?us-ascii?Q?0K5cN6G7vqman2K5mRHlaMBhnjp1w01xKj3k3NBtQHdFOQ3FjENhjYK/U9af?=
 =?us-ascii?Q?EPyo2NOubGK9ewp0ljCqSI27y9eIfw0UMYLmK4lKKdvHKeCG3L1lvfL7NuCD?=
 =?us-ascii?Q?HPJzbnuEzogZF5JoIdimqQm7UwXOEiMcopQiD5+v65kMkHH3/UNgo+YSYOKn?=
 =?us-ascii?Q?k+KY85/fs1Wjw+BdjMIOR2/AQ+3zRbDQ5r6/D1HJpkj2KfiWzE29DGGmrn0J?=
 =?us-ascii?Q?OCSOxM0NzpA34SmG+TwzTgGSHWOO2ALJ1Eyw4vBwue7iA9N22ZpKiMb6Iyn6?=
 =?us-ascii?Q?2INjPtkOF4GcyQ2LYP0VoIOkmaqhC3Wj6EB9afDsWSxGXbfGslwyUs4LW0Mj?=
 =?us-ascii?Q?vetVCiSw6OCddlcNU+HKxyJ2G6BDGKpGZ8KiTdh1XrZcKQKygY8IwBGzHBa/?=
 =?us-ascii?Q?1x1IdnZ1+Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF3984739DB.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3R6vEzRbj2O4PK9XradjuOLnGP++Fy45Ebb2Y222hjeCKOPOS2WpfUfKxXP7?=
 =?us-ascii?Q?OP6Dzn+b4294BBAIoVadMW+c728zb2aTLgpXDk4KlClZ0o34RGM2CDMDD73x?=
 =?us-ascii?Q?z6KXOr1vRYFxqpHypnoL2QcF4ZQH2Rhd3Qo+1AKkcWmt9TyCTqxaKak7c32L?=
 =?us-ascii?Q?GuZj7Szrer9sAlNoH47l2gQCosGTonIVVanW5kc77tnTWBE5fU/0p/r7aOvu?=
 =?us-ascii?Q?oQHPahwO+GAuP0R+NWunCbKPWl3fv4WAtE9b7yYo9KE3PuaKx/4BrLVWSXvO?=
 =?us-ascii?Q?Tp7urqU7gxZmbSgXSeA1T5y2v1IkEA1Q+HXPoIO/OpbRcVhX4foeIoAepND7?=
 =?us-ascii?Q?h9zV4gn4sODs14BxWjXwKUIq9/C7yCFX/1Blzd2eh3PD1/hRYPEj4nXL4tNY?=
 =?us-ascii?Q?qxdIOn/WALA4uVoR6igfN7iWirgDDhg5w1ILNNUxT96QQDE7s0Qnjndes2Bt?=
 =?us-ascii?Q?1B5q3MH9L4nD3QsrKDuP3xZiKODe7/kZscG6oamqRcCqTs1V6ONlvkM0SiF4?=
 =?us-ascii?Q?G2MNNsIrbYhpbOiILamBKExngYQ+NB7pYwnD2fIpEnVUEit4wIt1qlIu4Pkp?=
 =?us-ascii?Q?mgB2WFTEEnPRRIUJy/hdI3C16ifFK+XiSiHTFKSjDLcNlIR6V/WD74UDKl3x?=
 =?us-ascii?Q?tXMsNJerymBuq19VUl/mr58a7IDdjYfBpSeR4IxV1vieHpi4ZC1o4yMphJWC?=
 =?us-ascii?Q?+CoeBO0eg+EfbnuWCrUYMDB85UyqPN21hPyePTaOd0hZV78RauQCjD2zjCW4?=
 =?us-ascii?Q?6VhhFtmjSLt1GW84S+91fP4YqV1O3kydzqXTmyeBQX7Kuotmc7QjVPN9T0i3?=
 =?us-ascii?Q?4tE84REpdvRh5q3RuveD0sY/5FiMVAuQz6UytFAO9zqxnjBn5Xuwrose+rz5?=
 =?us-ascii?Q?lC0OvXbo25YkQPk5ZQEhw0Ep2biL5sAAFqAf1ftQGyg7JUMi39fPyrC3rUw5?=
 =?us-ascii?Q?JfAVyWL80lNDjUUf0KAebKuTAjJp2SRB4nhy3Kx9EaG+oLBS7CiBQlrF6X+Y?=
 =?us-ascii?Q?hizTnpgzk+5kmhx43q0laPc8Zk/IyU2Qx99PMEZdXfpW/W0YEK/oV4ONZfl6?=
 =?us-ascii?Q?FbJGbeFBnHtwY+dTcM/BdDrcWVHNsxRFc37W7H3JApzzZyJoS7xxcYmW1DJJ?=
 =?us-ascii?Q?PJ9e2ps/I5LDYN1VfIte7pdA6F4TKlZPrNdGhEQfkS61O7XfEzIbL1q9Yx3Q?=
 =?us-ascii?Q?XDmiUR/1h6xromEzoEk8OhwZeHY1TD/xJBPRZEsi8lcArpoSwzSRECO3sJUA?=
 =?us-ascii?Q?118Z/b8YHsueTNq3DNK/VMQzV2nOTlYPU1YXC343DmlIuVyjdV5Pb1HCkLJg?=
 =?us-ascii?Q?QQaAi+H+TzqoixjZ+0R3aOfXfwgqrjll4a1Q1yNhK8II06IrbdepswPtz/xY?=
 =?us-ascii?Q?UG23ZK1JT1HgwlkrTcGY4cruKWV2GmiNQR8ZowQmUZMQ/aqXyGlaCqky8gJ7?=
 =?us-ascii?Q?pjmEiR9psxG73jkPU+jHN+RMyGAtcInanByxHAoWwllDOrRBVkFAaaJinssf?=
 =?us-ascii?Q?67JVaiiJm0gWtUwHE8QvVkcML6xPM7fstY8t84rVeUP3vbm7BQBMRidt2ySl?=
 =?us-ascii?Q?TpEfG7bHbPbQC6w3gwl/3Txx7DNnrcEcf2yphnGmnStgmzxxtjhfl2esTufn?=
 =?us-ascii?Q?iE079DJeMm4wNSiq67H7/v4=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247d3c61-b431-4871-73f0-08dde67c2598
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF3984739DB.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:45:03.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewpYW7UbVUFuGrMT5wz5M/6es1VXT55fCqpoyg5j4qqanTz7kcVtXwNSNQdaq2gWF9I2zP8B2Z8ebU3uNIgjpqIHlsN8jluSwgclKfoF3Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF842B33876

When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
first time. Subsequent reads succeed.

Re-read the ADDRH when this behaviour is observed, in an attempt to
correctly apply the EEPROM MAC address.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index a2e511912e6a9..63ed221edc00a 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2162,8 +2162,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
 static void smsc911x_read_mac_address(struct net_device *dev)
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
-	u32 mac_high16 = smsc911x_mac_read(pdata, ADDRH);
-	u32 mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+	u32 mac_high16, mac_low32;
+
+	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+
+	/*
+	 * The first mac_read always returns 0. Re-read it to get the
+	 * full MAC
+	 */
+	if (mac_high16 == 0) {
+		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
+		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	}
+
 	u8 addr[ETH_ALEN];
 
 	addr[0] = (u8)(mac_low32);
-- 
2.43.0


