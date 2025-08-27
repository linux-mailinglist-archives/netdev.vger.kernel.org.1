Return-Path: <netdev+bounces-217270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCD5B3820D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1841F3A4D68
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799492F83B1;
	Wed, 27 Aug 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ThOyqj16"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96EC285061;
	Wed, 27 Aug 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296972; cv=fail; b=cy+dXLDynAQf74WsRTowfq6ahfwjwpfX9uj9U3Nnxu5QlHEZvKf3VBmf6ZXCFJyWD9yznovW0XJjv+8TRKt4EyjGhRfR8Sn9Nl7VQ7xiMjV5XZvqQwCgH18oi8MmpvQ21fx9qyq2zLN4s6MBw/K22W4KQQZI0ay8hTsu7163H0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296972; c=relaxed/simple;
	bh=7N7JuGBlXIvY/akBQeh2xYnteJ09lQoFaD8YQ0lD/uo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HrORyBqSadp6VnT2R+lfpKzyrm7R7rI6SCc8sx583I+kAOjBH6hfP7F90YSpFJ3TGnFKhc7VFtqam6bl3IASDL8ow+LuHB/c3iYodCBrIZPk+c6Qtm3k9qBP88P8CV294DUh9CObAu7cCx97i8zJpRzQ4TORfKLq0btsgRGBxAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ThOyqj16; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfh5B82WAaQUaiSTPENC51soh/HJn2sIxh7oqtb7vWY2BfavXqpuSrtNzrWYDxLeRvKvhPzaSvp4lyrv29rdquYXiXd3FQcbiDRFCI4qltViBcABmIDuJoD+eImHNEqOffPWzZGyVzulirDtTf/OeyX2ud5lNWCjxHchDHHyIa73JvBJ5O8UQihaP8BRn+vmE5nX4NgwMOIQli+hBMKHVEdhMaFFDuRE3Or0Bc/ON5C5bbTmfVOGI4zJFpJwO8hoo6UsltAWZlHcMv0fPBOpZVPT93HwmVrBIMcDjUOzckwjSvnVNNK+KOppRdwPqXEFaTroQV7j5ylyOXHr2WABrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUeyn2FKrREJcNNGHEQM3gnYpRSix4Dzh8wunkHq2RI=;
 b=wvVQjjX5xZA7UWldgsxV1jMLqvSQuiAEqz3uzmJkLdEZGkt+2ke0VvEugPPYYuAPArJtha4MFIvWX2cNVx93k4u6Jgo0WIV/64vSJY+VNbTxY/3rETuyToM4AI5iDG2m37GonOSfzY4LKIjyz6UI+w7/WXFZ7zXliSGA0WyO7s0uXUPD4ojrS842XFXvDcR1w48NReQE77EfvPECJnuwspQgIoagNuqTwoBSrs5n5ywJNFSbmcarOeN6SPAf6zzCFoAYcSG7orBvBp0kxO5CGxuoCzDTJ2gwC/TaMapaiYSlhzXAS9BW/VII+l1gJMVAFmu5raIzZoQYeYJ9wCdmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUeyn2FKrREJcNNGHEQM3gnYpRSix4Dzh8wunkHq2RI=;
 b=ThOyqj16q5gGNIYo0XRHeaBEuraF87ZnIFjt4gwrv0CpHLksJ30+YJroALuZhmZ1CZaJUKvvBIGUCTrrBs/GLDGOuE7UXHcYI8dILVXhWZmcBr8WEkR4Y1hmGzXb3qxszYmQ0zDwhrMuGMIrswczvCnEA39OcoPULxErR5efDks2YIXAu3KElVPZ/L0YzIE59UCTnMLytI7XviOTAyZXmfmkm9nuTx9QlqWKbkgcwAFWoG+tOw/K3mgRYsS2Vd5HDs9JY/RN6Xq9baqFN5HxpTP7UaXEUFpwWcQ+xV5b849qlYKv2GbF9neIyzMVKvUX+a2QyUg5tKT5i80NZkfOrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 12:16:06 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 12:16:06 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH net-next] octeontx2-af: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 20:15:52 +0800
Message-Id: <20250827121552.497268-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:405::19)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e98ab58-7fcf-4506-98b5-08dde5637fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azthTuk5Nb++kLHFZCa441yv6j2TF874m9CPhE2r1raC48N9403TXOXh6yqE?=
 =?us-ascii?Q?lBJBgcu2PeWNjqHvpeWfdzcO/pT9ZjJPgwK9bANRG/7exCft78H57WAP/Dmt?=
 =?us-ascii?Q?ObJoIv1JKtbWtckgcNk9qV8cVvGlaPH2sg4Kx+fXR8aXZtpMqnk6I+69n3jF?=
 =?us-ascii?Q?GIsGSgcFqhp52LQhr0tP4LPNBMzR2josPtvqqePpRO3TlPAlArG0pnUkqsNp?=
 =?us-ascii?Q?h+/1KjGs62V49N6VSgUK2qBml66EX6ZuKPhyurOkx+V75E8yM5qDReKaUJD5?=
 =?us-ascii?Q?tGNu6/qH/uf2/2stDRXOIqaaI8XMP+AG3bsPUD8MwJzKkqgf8T4LdJTNcOhu?=
 =?us-ascii?Q?q4rNb6/Ryw9qDpNtVaByNn/AVNuj46H/s1DT9Ze2QN+08w+ldsomo66iU/jj?=
 =?us-ascii?Q?TyIpM5gwSbgLjAMndtHV/9LKgmAbdEXQ/i68u9FKA8z5JPvBgkDVzrhr+mNH?=
 =?us-ascii?Q?noTr9V9JSP61cq2t4OlZZjkyIUERj9XjrzIQ9IB36ZIqkbKcc5ND2AuIZaiB?=
 =?us-ascii?Q?44mWmwqA0QZj4XqFzQMiCNIj7QDjMvk8h97LO5vlfbL0/023wMW+PbaGxRcy?=
 =?us-ascii?Q?yHr94ecdWMfybfqLWBQZpzuyzl7D0nIf/dBuKmeIhdlYHuie7J8miqBLtVUx?=
 =?us-ascii?Q?38s6N4ENy1/GIQ9FftxP8BB5fDofwQDZ0DAhoQI1NF4ecfXP4t3CZvYkC/GS?=
 =?us-ascii?Q?FXYJym1RU1gLBpusGhK6JpupTiUExudz49kvcE/rbZ4SuMur3cnwbQL+OGxc?=
 =?us-ascii?Q?PXkOHbbBFY5jCZab82czQbPqE+xFtTnm/dS/UgsfJccLFogSn0x2s6aoQGju?=
 =?us-ascii?Q?4OXmWjrV4JhXEVzpPIywvpvNojlWKzjgNx3xgH9nFmRpsQoQrmesEFt0HZs4?=
 =?us-ascii?Q?m0v8vZgo8MeUlq20zkhp+RJdend6t9nUx+KJi06kfyAVE+oAlpNo6hrOsiB1?=
 =?us-ascii?Q?Rx4V8pAWzGLYrhQUnGBM9Xgsu0fxBU3f8MFe3SlokGfHTkg4exibdvBfzOBl?=
 =?us-ascii?Q?nth7Jo/1RWUMdOK3EGxraXa4c6C0yZc+FMgSFHNRI8WjYYRTRj0Pp++O8rku?=
 =?us-ascii?Q?BYkNRlHWx5njMcjHzv739vT8NuRDrzTisX6nTeGIzgJ7VrYQZLyeQML80OmI?=
 =?us-ascii?Q?oVV4+JKeD7eTjpUJSg/I9LfJ6ZIZsY3HYodMk12fi1AV/Ru3InNBBAxwZDkd?=
 =?us-ascii?Q?58M6rFNjg6pqoQMdkiKPjVoyEVVpmzvfrJnndtR7mNE2T6yetWXcUYZdKi+M?=
 =?us-ascii?Q?vAZo72EC3dzcgtNm5pei+8UflMcG5gtmakqiRv3PKaPxg1pbi84pqi0mtg2c?=
 =?us-ascii?Q?9k2sG5oRrkWKhU8hbVcCVtqvb7lL08eSeWU6Ls2or3WX7RZgQrqI3OarludW?=
 =?us-ascii?Q?kga6dzE5rrAlu4BJTnpPSNiQJWPYMkx+Ju0WzXsPrjXv607Jz9cbeQWR02mn?=
 =?us-ascii?Q?byFLRD/C5PlOtrq8adeqjWPueuZmn+KdgryFetJs/H+yVYchjaRTlpdklZz/?=
 =?us-ascii?Q?Bjq5GafCYH9aTXk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NK1NyeVvBDk7AJ4wQqSq66Xg37YsQeiS0fUsugIPUZI28Eu2oh3aNPu1GNk?=
 =?us-ascii?Q?XsfQEYbmeS4qODJSrLSm/85N9nDiD7dGTKHof12X75jDVJSN3q6bd1NH8eyG?=
 =?us-ascii?Q?MLDq+BB4U4MgzzvZsARf3vuiAg7rYWic3mI9c+UpfkEhncp5E8s2+vDNqAVI?=
 =?us-ascii?Q?jOWEVfquDt/eQQYCnWDHzVBjq6uZkfQ970Pl4AoUQC656SqR8yUZgkLT/qMZ?=
 =?us-ascii?Q?055TiP8nF3WZpbyfeaNMYQApGTb/JWSgMfOyMWH6SsIKmPk9tRh48A2QbcMy?=
 =?us-ascii?Q?7Y141annLpME2jLcgLBq6DZyDEyI+tiXjUxcykwdQkL9ERgvN8ps0oL5YLGY?=
 =?us-ascii?Q?9gSFV9HiJd3kXsIS59xjry6NUqt2s2uoVNlKa2IrDohJTFtL4ViNMfvP5tcd?=
 =?us-ascii?Q?P8JqwdhwBfQwZIgfFFy3244lifmWL68zYGvjz2hO9m6sb17Jxr9+BVo0oR0h?=
 =?us-ascii?Q?Kss2l//RqKJHx8ME/IuBjLQx3/3u6zShDSfNaZhd7QH/1MBIZugIDZ50USeq?=
 =?us-ascii?Q?ZsNv317KHJUjuzFAhDBGuYUdLzbII1kjjUSwINr52VYi5eB1V9IpXKSfsuwI?=
 =?us-ascii?Q?spME1fL1Bu1iNl5VzDwK5TXWgPDRsgSM2CSujjD0IWEoWsevJvWeqEc9SYwV?=
 =?us-ascii?Q?Z/BGaZ2fE8aLa1eOBhS8yL8i5XrbGD2pJAUM2I0u714J5ELotgklPyEp4Idz?=
 =?us-ascii?Q?w0gKahlIAG/OciImFeV9cWnaMOy8RQjk8DOSK7spYE89GkBw36GquJC7aPHI?=
 =?us-ascii?Q?XpyQApz91281tuf1DmJSvE2EvD82TsS7wyp5zkBLavENcjM0D/t/Sigtb+Ee?=
 =?us-ascii?Q?dLWfJh2lYcuuXf/1AnzETX4OdZicMjc5LB2AMlgMmWtuMHv4Dww1F3f6wFYo?=
 =?us-ascii?Q?aqgrqk+0yJQ0PNYEeFysaRWVnQUrqpEknfAqXTfFIvSUs+Ngstab4XxarBtv?=
 =?us-ascii?Q?5TLxWZ/0KHqK6T1YX3qs0Rgsye0EGulWJ2L3UWBLc6axBa9AoSBj2wl5Tvu6?=
 =?us-ascii?Q?LYOgzD6U7p9DQeZ/xVViNVX44R2Qf3Ycj8DmEPEJi89b/Im1Y0qniq4qVkn1?=
 =?us-ascii?Q?4uXRYaTEcgpbxACIFbJJrtzkQhxA+M2LzPLjGVCpP9QIN2TjXe1u0hIVoDLb?=
 =?us-ascii?Q?NxByP921/pWrEy/LeHxFh2f3+fuhjJGGoc/OmD1i1LoLYYSwZS/R8cDx9gP+?=
 =?us-ascii?Q?kAYSK2PQNk3bs0DW2E4JnzlEFRldzAUrIswdWD+6w0cJ77KyEXAuoMIVC6XG?=
 =?us-ascii?Q?xR0u3uYhsPV2X2H4VgwbFcUGOXVUpcg0ehQCNc2mmgBeEl2aUM0mCMA/ikta?=
 =?us-ascii?Q?kdf4fu7mZ4O3CjRX+ySW/dhI3/28huK9gD3Qnbs1mCxmqyI4AGvVQxwtN/zL?=
 =?us-ascii?Q?fN4H0m6D5m0F2i4esqOS4D8R0RZ0w0dj8TOO4g+q1auNaBPrF0trqoxJmQIb?=
 =?us-ascii?Q?EHv+yKdT6aveUPEq72ZtayifaenGFNLZAg+35NE6xjkZx0LlQn8/asnUgqVr?=
 =?us-ascii?Q?5N0w3hZBj9Bs4PWwb8DG5K2kkA++9lAPdoIb/cXo+wo32Nl1XzHHlxZX3ofA?=
 =?us-ascii?Q?goawU3xcktD6p8vpQxhPkWsGruNuWD/i5o5cuivZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e98ab58-7fcf-4506-98b5-08dde5637fcc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:16:06.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGDIAuJidvhRRsiXyHrTtQMPnwz3oQ2TYeln/PY6f//nFAjOOxfEIf7BY9BiN6ra+EiAJzAONbRBUPitRpqQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6684

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 828316211b24..b4b0613a5be1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3258,7 +3258,7 @@ static int nix_update_ingress_mce_list_hw(struct rvu *rvu,
 		err = nix_blk_setup_mce(rvu, nix_hw, idx, NIX_AQ_INSTOP_WRITE,
 					mce->pcifunc, next_idx,
 					mce->rq_rss_index, mce->dest_type,
-					(next_idx > last_idx) ? true : false);
+					next_idx > last_idx);
 		if (err)
 			return err;
 
-- 
2.34.1


