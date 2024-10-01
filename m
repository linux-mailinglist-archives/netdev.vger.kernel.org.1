Return-Path: <netdev+bounces-130791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211798B8EF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC73B2284A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB121A0723;
	Tue,  1 Oct 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="VFIRabbC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EF19F49F;
	Tue,  1 Oct 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777125; cv=fail; b=aILHXS7WzNt8Yymc5F1L3a7SosP65dGiXDboVEjIeQ7VcAMcIkXt2qzOWyMrrm8rItVuCxAWD7wZZKbxCnduWg5c68oYtRtkrroYbwONcy33dezZaQGy+MBQXhxb/neS33V0J+/XcTTOgvDkOh0BhB/HD9Q4+Jg3vo3tAeyl/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777125; c=relaxed/simple;
	bh=3QAfdvLJqZuNpp2He41jF5wvCGJ/fMrU+L93Y+GygHI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a8JCCkfIlZ9zsH7PDb/lDp2XtivNmQiBiGa81Msi32xDAVbe0A8UgewuU4q+qdUSe9qNZmMlgnOJcceuidFFHPpgJA37W2VFiRc3uIdHvqjSVS4Lptp/pCCIKDSjhBLpLEH2Fe7kyJQgYu3zaJbJNLkqMZdyHYKGnrb/dphWGNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=VFIRabbC; arc=fail smtp.client-ip=40.107.241.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX7s5V4Ts3404JOZ4Ayh4sFoxNr8hv1Ox/Jwp0rEcWnzVrPpO7z3I8p7e04XYCl7rvQBrAyHM1OvEsSeIW3Dmbr6URhRNf7siMR9U/tIYJxi0GCOmDjNZuEf/EfrkSk5zIB4H7k2LoCGSBZd5nXb8k5nDxQFd6GFBuHHEBttQgRD2Ls8Lf5V+vUMtJI8VQqPqv5+ZluiURjMItcU8+e/0O1OqB2yh90cLJMPjgXZl5nDGk/iSLEZXtVUv53gQkDnY8a5jqVivnio8/uzzbHJYlGKmq0BpjbG0wHWkEf+GTctFLtEJOsmCJABBadVMjZZFRxQu9hs8ga0rXFjFm683A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+0YnUyXD3uaP40IEQEP44W8IttkZs3zpDWgKM76jAc=;
 b=lBCMn7TTYk8NBBI/a4jGYjcAF27hLSUTRBE8NGTY8Yg/X9tNve8XR3c6Hg5sMdzR0gBZlME3lDIL28+Sb81RxmdmvRZG38ANEyrnMOdsT3OhK/lpqPjmjt/3BpbmFq0TZ2h6frlxHLR1AZ27X+ZpoU1uglC7NuYqjv432fOCQ3RBnuNp3cfrPL8GX8EJEiBOEJNY+TPwznGBbnxJCdTyE+ERBi5YKGecG291aKuJ4rtR0UcKT8mn7Z9/SoNGv2fM3MHQzBnOmI+eaJfxhblQ3cth1Nlc6snPDgjnK751PsdZ/nv8ykb9SN435s9EIY75wwUmbgEf+b9WLDR6g0DN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+0YnUyXD3uaP40IEQEP44W8IttkZs3zpDWgKM76jAc=;
 b=VFIRabbCjTg3BbE5ljwM1g7amJUNzflv6Hau17yXbp9RDi7IOHj1VFA5N7uH90vzVpiXoNifuQ7D5bgX1cptEh0n4hTc6am2v58Q8a3+1BBj3ot8G6PG+buXtEGfuZP3HwiELUPWIBcDJ9ZTgFk8xxGenqjUKis2iHzCQR9zBFtu5y34tsHUKLVC+TRiLj9cpU0e0EVyMD2JT2tLrbrefS/Qr2jjeMOHvpsxOzUQp9L5YS5N6pfkwMvo6Qw+vqPE0t2kdHaUufnPsKc0pk1Ns1sTG7tAIFo/wh7Wj8v/vV5u/rbprE6EqlTzljl3FPVEo/B9mWZD5AuYBHUP0kruVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB9265.eurprd07.prod.outlook.com (2603:10a6:10:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 10:05:19 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 10:05:19 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Petr Malat <oss@malat.biz>
Subject: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
Date: Tue,  1 Oct 2024 12:01:20 +0200
Message-ID: <20241001100119.230711-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d72098a-dae7-4981-27c8-08dce2008e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6DBtbBULLzPgTdCUjvlMOj/7VGlY7pB6xSc6auC6aEt1SdV6ioDDQrYYguQ?=
 =?us-ascii?Q?h3CXzwleD24X0xCWgkkvhu5qVV7rrVhOrIMRtKXO7cid9BzHD2tBAP/YwRUR?=
 =?us-ascii?Q?ZTNjc/Q76yWhJzN2ETc+GQJtIQ362Y/5bSp1wM9Ww1HDEPXZkpvc8JpdjPny?=
 =?us-ascii?Q?UmptyJhlpCetcFovUFl4Of0183izR4e07nKoYScVi7+Z7mWJtgujTK+vGI8F?=
 =?us-ascii?Q?Rx4u/LzVOfZgsOKiQW5dJndyaz8aJjJg0+fru03zFSCc26XUCnVpP2G2X5kw?=
 =?us-ascii?Q?VOncNTOfQISFt92oDQRRuUZfgpB4s430hMO1llAB7U3k+fpdw7/E0gz9L5+g?=
 =?us-ascii?Q?wwdel9MvWwNAs5Esnbli9oDFj0JJ828Vn+CNTGP/N5JTMrky7alO4mlmWsGt?=
 =?us-ascii?Q?uodzPhv40uYqvJAQ8qc3ZFbSDXYJIQ+ajJSVugg4oRalupRMnYQRdS9/+O/M?=
 =?us-ascii?Q?qCc1cf9L9iu2DbE6H1HSjCcH3aUoKOHrl261NQT+bqAvCo6J5axgqqWsSUCi?=
 =?us-ascii?Q?mxkw4mhvS6v6oHUA60vBPN1DAHXSADeBXyBgFJR38WpsdxE/XdS0wDXf0a6c?=
 =?us-ascii?Q?TWt6k/9bqYBvpe5/9fg1o5lag33k2SMSgL7YLAVCRksCNoefwIDZB7UfSBF4?=
 =?us-ascii?Q?WB8FHRycUo+eV5xLAXS+0rUSDoxlhKw0lnMTgMLlAMXb6lf1uoxa1FXo3Zvv?=
 =?us-ascii?Q?rPrO5JWOL1G5CLPPos/vivT36jmy7hJjmrBEmebck0Z6758DOHkabx1PDe7c?=
 =?us-ascii?Q?uOVlcXK5DwLCPuzbzKc2uXSQj7Un2YQHTk23dQP6pRhZVtkxaW3eAdXsyTPX?=
 =?us-ascii?Q?25ZyKiNR7JsWjq40vQ4VnfFZicMAH2VgZ89cArdw4ZSPJsAiq/NTupVTHSCE?=
 =?us-ascii?Q?9nqIZNNPIbRnk29JilHXxQYLnUYjfWFPwHPyNRfKFNGdMAeJ4I3Qj8L2kIzI?=
 =?us-ascii?Q?0Y95hfcfvcDQnPS3CcwRgPjSqaNwd1/t4uO1T8dYGnVpvbknCHEzIcHx7SvP?=
 =?us-ascii?Q?Jt5HdLIpppSjQwpTJlVPsO3hkO7REpPhbl4h3SFWOezL6Dzeakwi/Sl59uFm?=
 =?us-ascii?Q?9/8larXAesnVgwgQiMqeuqNxxWJ3eqx5KjNiAI/l90G+rud3H+miL/kXAxzX?=
 =?us-ascii?Q?dLiw7kBvzBZYKdCLZ/GJK1mKpH3QtxLngta8W9nITj+P4AHm8u2bXM5R0bzC?=
 =?us-ascii?Q?SwiVEhQ50p5i6yns4egR32Yzn1nJX0v0r3VTcvl/d7THv/Zq/3Vg9zHxEBpN?=
 =?us-ascii?Q?AJBxZJMc6ufYuy/itMNID1q4DJz1f9jwTMgwN/RiMjJpxMygA2YBwWJqDBdY?=
 =?us-ascii?Q?HgGWVpOM5DxdTF22zM/HQ/YPQt7bZiS+SR9IKNkbWj/0kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RicMUrgMDhgPu/SgnPSCR3yl6RF0l3o6ifDk47f6JurBXm3LU9HIFoz1IWu0?=
 =?us-ascii?Q?pj6KLSoj56WyIiJyy7mrdYjhwrjll83xWlNmJnetpankKigvCmCUToMBVVvB?=
 =?us-ascii?Q?msgdPCqgRsEclizVCibJdabW4f0Rw/2v66Ym1qdFTKTLVUDr8cqGOwWY1gg8?=
 =?us-ascii?Q?zi2uiS3er12YgmFK0Dpa3/5ay1DmVb2uI+q6ZdB1yrZU65r2Amkabndfh36b?=
 =?us-ascii?Q?VgrJG1C5a97BtN9S/zgD944n9N17x2D++zPVMdglqpu9MAtxFRzH+PZJi3pp?=
 =?us-ascii?Q?tqZr39Eo6iM6edgunqlq7cy+aOys5CcLwvTF+Fo6l+sFyUSDeIaOUF2Yy5tH?=
 =?us-ascii?Q?SGz4iitVt7Yb5RfNRiBzr7R37z6kS3tngD00gUPgx6PmG9UITHPGq8MghSIs?=
 =?us-ascii?Q?jTmUwbaf8IUel9wyzzYkeQKW140yBsApLtXiLNoaWXiYPGjOS27n2Lt9XJCe?=
 =?us-ascii?Q?WrAwkj+TF8Xaenie98FptNYHyVWfOJoafp7rrOZi58eDOlJ/P6TxOIT/rVYV?=
 =?us-ascii?Q?BEZ2PeVKl8yFgX2377vYZ1TVp4LoXOcPr6Xu6ITjMLz8mQoALbQ96f94lquL?=
 =?us-ascii?Q?xUvmVXC1psAls0GJUV3VDb+pxI3E+wl283zyFjokuzeP61MYseyOARxDNx8M?=
 =?us-ascii?Q?Nmx0wfVk+KyWUpqbgLxjqQBDJnvnj6tUd/ASKtfsg3pHvM+39S+ngTJmQHod?=
 =?us-ascii?Q?qFLqHA4NppuZB4fo0Yq3MdajjkpaS4977IVWhbkfYrkBvwfx+08c3FRW0Ihq?=
 =?us-ascii?Q?l8ONBZy0LflfYYoZOd5jsIwLjL19q+Qcp73vleNRfGFMhbWaltzpEIRw6LFp?=
 =?us-ascii?Q?Gc2eodi3BfdQPVwGlSzUqZeF4+1KGcCydzSQaEaZrb8I+jV0tSAEgiDtKgxW?=
 =?us-ascii?Q?FbOiGfgXdamVo0Wj/GEHkhE6ZYd+yN41jyk9TNdPhPp+lPKOPw2rawVnNS6U?=
 =?us-ascii?Q?PK/Ojq6qkiSDw7oLFfwhhJRjjLghN7grArwRF1ZC+btEVMnaYdEi0EH4e0L2?=
 =?us-ascii?Q?eVNDox9IJoKzhBpkGwwbX0GluGeGYb/Sgq3G50LG7AImKuqdNbI4RqOL11jw?=
 =?us-ascii?Q?VnJpcoZTEsE4X6MyJRswb6el40YgVbRHGJLMc1YeW2mpnuFiA0j1EvVF9EzP?=
 =?us-ascii?Q?58Cr0yCpBhEMXNAcRG+rPVptiMbpRIAdbwMTCX0+d3widN9BXhwOwUe0FThS?=
 =?us-ascii?Q?AP62Da/1yErjP1tlPWh9Mm1FKpSVFVTEJGn4s04QwTp5dRje5ru2FIF59Fyl?=
 =?us-ascii?Q?0TOH4SYbKbMxUNVTVERwkyROXEQeIESwxLmuuJEFNw2gppTnbH/tr5ahTfuA?=
 =?us-ascii?Q?wflsQxZzDw0fN4kesQDSKwVLx6IqLT2SfYVPXDHk5kotu9RnDWrYAciyDFG3?=
 =?us-ascii?Q?GgYSj/pALaSZLHG9BX8HuLcvev/QAFqk/+XFSuy17jGV8UiSOdjtnpMok+s6?=
 =?us-ascii?Q?DC42QNyiba+2bFebMn+mPRva4ReeKEmXZmLeOiJFzcL2gMEwPOD6lfGgCVCE?=
 =?us-ascii?Q?Nqv5qoO8atoKSrnseH+4FtYDvx2CkqfxKVqVM/qjEdX5qWGn3TQKdKGhth+/?=
 =?us-ascii?Q?+i5QVmvKRgzolsfaL/zhmNfz5QzK150cD2+GzmkQRDoA2eBDX+g1KpJc7uP8?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d72098a-dae7-4981-27c8-08dce2008e3f
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:05:19.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+qvXsj3olp/f9U5othpUGyBig80P+R4EJs6kHWULTtYBzy2+S6TDYL5qWcqBpxEKlakO/b3/LrltY0Pao/UJnjj4W/T538NOEPe5/lrzfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9265

ip6mr_vif_seq_start() must lock RCU even in a case of error, because
stop callback is called unconditionally.

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
should be done under RCU or RTNL lock. Lock RCU before the call unless
it's done already or RTNL lock is held.

Signed-off-by: Petr Malat <oss@malat.biz>
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
---
v2:
  - rebase on top of net tree
  - add Fixes tag
  - refactor out paths
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
---
 net/ipv6/ip6mr.c | 103 +++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 2ce4ae0d8dc3..9a72928861ac 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,13 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
@@ -1884,18 +1884,23 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
+	int err;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
-		if (vr->mifi >= mrt->maxvif)
-			return -EINVAL;
+		if (vr->mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
 		if (VIF_EXISTS(mrt, vr->mifi)) {
 			vr->icount = READ_ONCE(vif->pkt_in);
@@ -1905,12 +1910,11 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			rcu_read_unlock();
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
 
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
@@ -1920,11 +1924,16 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 			rcu_read_unlock();
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	default:
-		return -ENOIOCTLCMD;
+		err = -ENOIOCTLCMD;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1952,19 +1961,35 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct mfc6_cache *c;
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
-
-	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	int err;
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		if (copy_from_user(&vr, arg, sizeof(vr)))
 			return -EFAULT;
-		if (vr.mifi >= mrt->maxvif)
-			return -EINVAL;
+		break;
+	case SIOCGETSGCNT_IN6:
+		if (copy_from_user(&sr, arg, sizeof(sr)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	rcu_read_lock();
+	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	switch (cmd) {
+	case SIOCGETMIFCNT_IN6:
+		if (vr.mifi >= mrt->maxvif) {
+			err = -EINVAL;
+			goto out;
+		}
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
 		if (VIF_EXISTS(mrt, vr.mifi)) {
 			vr.icount = READ_ONCE(vif->pkt_in);
@@ -1977,13 +2002,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 				return -EFAULT;
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	case SIOCGETSGCNT_IN6:
-		if (copy_from_user(&sr, arg, sizeof(sr)))
-			return -EFAULT;
-
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
 			sr.pktcnt = c->_c.mfc_un.res.pkt;
@@ -1995,11 +2016,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 				return -EFAULT;
 			return 0;
 		}
-		rcu_read_unlock();
-		return -EADDRNOTAVAIL;
-	default:
-		return -ENOIOCTLCMD;
+		err = -EADDRNOTAVAIL;
+		goto out;
 	}
+
+out:
+	rcu_read_unlock();
+	return err;
 }
 #endif
 
@@ -2275,11 +2298,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
-		return -ENOENT;
+	if (!mrt) {
+		err = -ENOENT;
+		goto out;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2297,15 +2322,15 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 
 		dev = skb->dev;
 		if (!dev || (vif = ip6mr_find_vif(mrt, dev)) < 0) {
-			rcu_read_unlock();
-			return -ENODEV;
+			err = -ENODEV;
+			goto out;
 		}
 
 		/* really correct? */
 		skb2 = alloc_skb(sizeof(struct ipv6hdr), GFP_ATOMIC);
 		if (!skb2) {
-			rcu_read_unlock();
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
 
 		NETLINK_CB(skb2).portid = portid;
@@ -2327,12 +2352,12 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		iph->daddr = rt->rt6i_dst.addr;
 
 		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev);
-		rcu_read_unlock();
-
-		return err;
+		goto out;
 	}
 
 	err = mr_fill_mroute(mrt, skb, &cache->_c, rtm);
+
+out:
 	rcu_read_unlock();
 	return err;
 }
-- 
2.42.0


