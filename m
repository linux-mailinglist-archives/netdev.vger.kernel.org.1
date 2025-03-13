Return-Path: <netdev+bounces-174737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEFDA60173
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D85A3BE540
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE371F30BB;
	Thu, 13 Mar 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiGp1dL2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6B1F2BAD;
	Thu, 13 Mar 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894936; cv=fail; b=hJrUxuSwlCX8FpMpEUVU2tbi3SRlUOnInD3oFH4SzdwhPBT0oq04EkzlwnCIq0TyG0iOVoBoHx23BQQtL5TZfeuKnoqWYL3Ow9WB+eCO7VXxHB36nx5gMenCDJdCNUnb5mDPeR06rmmDFSXzWVpbNusunoLINeoo2zGDwjNHrYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894936; c=relaxed/simple;
	bh=8YXwIblioDcyz0pQoNmaJ9lZk0qZNkNZD2A+zj3qgRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9sc0eIRT8id+z4/Bg0B6TRi9OvQyh5hgjJyipziQzBBf+G7T3q+GIO1q4l0ZjrabnC0g72llQv19tHOF4tzPG4JpsT/QwJiCk49ay/Ce/ELFxkQd1GCSptVros5L6+EQvjxiX3EYxYoVtcGUK1xZpGxqjVGap+v/ehGlBxEZS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiGp1dL2; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUJsdG7R/nbzt8MTjMByQr3P4Dpb9xJ3YaU8cr0OPOCAT21r1iEufYtr6CuAE2friXoSOLE02GLY/5cIPmmaTP/Lg55G2o1Mu2bMlDgrw49T8SiiUK7glpj2pUX+rXdeIST356kx2l+aq+C6+mWDk2OxI3HDKXkkf0evxJuLGGc5dX/MwqTfaywpIHHSUDpUbggLcyPQa3TEl+8Z45Cyvkz7Tm3yjusdNfJ+tD4p93mW5FEfYvCVQvSd5IJORXtzsQZVg5ZWHkJl6At6864BUNyLqoEMphETVggPiBttSRnnVQax8QRBha+51EDF2BGMVR1qMCNgElVV60AMMxtaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tuN1UCCe6yex95yZh8aJW5ZLDJ6olgu1n3aHES3Vnk=;
 b=RfKNhthOiz1PxFakYR3YNfSAqmiG+O263FMa4mBLNRwP/tOYpw183beq1AkOo3gTN+02C8QkfMIAeiRBWFSYJHbRm/+hafPeYV96X9MbdqQrTRN5oMu4vLu7IAKV4dNQ0fbsPBXyNtn51+pUN6i+2W9WHOONcPwvCGzk4qCeBziWccYJlVgNd+Tup9Mtdk8J/Ppni1WzsAt2/vm1jGJW9J12UxOPFPwrKHwsm7w9hIdLIAAUK/1BHZXYMV2BuRhgNqGAK3A8iwKW7LVHm0KUimYZlURc5J11RSWRIiF1C4luocpW1y1w8qKFctsp+YDDXI91zQvcmor11iHcOQFf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tuN1UCCe6yex95yZh8aJW5ZLDJ6olgu1n3aHES3Vnk=;
 b=SiGp1dL2glepxhuTN+v4I4wjrf/0IIOQPhh01zwytcKHm7+iaAHMzWW88cTEXxHVhU+ogCNW7bF237xLd3VIfIn6LrCtvHCNr4ySdR3cvv4drCrnZD+H0GBvmoedKWoH0frQUuHpl6uWasEDcQPd3zNQtEpb94DE7RtW0F2GnLTOiChuqaQnrLPvsdlZq/x+Oe4f5pzXBU6PWtC/MDh7YDcRwK92Mr/UAHfql7DryhUy6Ssw6z+uFUqitTeb9RlfMyhqYfDZ2MCfI8+Ee00bPOsY3Vr6WYXhBE/OjAIu1mPJTvCrJGBPnSZhhQMW/FDMhf1HlMI9m8EHPxVBXphWgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 19:42:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 19:42:06 +0000
Date: Thu, 13 Mar 2025 21:41:55 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
	chenlinxuan@uniontech.com, czj2441@163.com, davem@davemloft.net,
	edumazet@google.com, guanwentao@uniontech.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	niecheng1@uniontech.com, petrm@nvidia.com, zhanjun@uniontech.com
Subject: Re: [PATCH net 1/2] mlxsw: spectrum_acl_bloom_filter: Expand
 chunk_key_offsets[chunk_index]
Message-ID: <Z9M1A8lOuXE4UkyR@shredder>
References: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
 <78951564F9FEA017+20250311141701.1626533-1-wangyuli@uniontech.com>
 <Z9GKE-mP3qbmK9cL@shredder>
 <70a2fa44-c0cf-4dd4-8c17-8cc7abf1fbce@redhat.com>
 <Z9L43xpibqHZ07vW@shredder>
 <8563032ED2B6B840+7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8563032ED2B6B840+7af17f62-992a-4275-80c7-ac7ef5276ae7@uniontech.com>
X-ClientProxiedBy: LO4P265CA0182.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 766c3df7-227d-48a8-b5d6-08dd62672311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7tgLZSQ/+Fv4bJzyZgSujkg6w3dV+HyWHkDfR+uEa6XgQeYeZKGcTKMSExT?=
 =?us-ascii?Q?kJXCBgCZBlikevwA34shui6CyiZBFKAeEtZlVG+bEP5YENYs2gFcsX/JP7q3?=
 =?us-ascii?Q?L4uqwGo8nQLTKI12pb+Lo0ONLJWC53uhZzq2hDpExb/HRRzkzfO48fDdidn+?=
 =?us-ascii?Q?iesByco2izeNuQS5rBjNXLjtSUAkZQl7EY3pL9r4L3rO/DSek8FZb5J1OvtL?=
 =?us-ascii?Q?vR0KAV+T2/3Z545nKHMaHG3jFkBwmK+saZpLo27ZoXjH4X7FIlWPNG0YPjo0?=
 =?us-ascii?Q?gCIlkjnfVLgSLpVwanalmFFhJy18KYaQfScIm/4fGrHe+11dF4DbCJYLr8KB?=
 =?us-ascii?Q?Nzqi5OvBhs0fGLUqKnorfj30kYgiYhF1ZmTeQax/xL91PJfEvEdmmI41kl4l?=
 =?us-ascii?Q?bxIRr7+1O7INnHxzN1HRbNuG4CR+LhodaCMsKNEL9SVqHrfWyPTXiquGfqY3?=
 =?us-ascii?Q?pz3btm6sUi/HLcU8Dx2/zpobw6SeSB7pk308Mb9n2rql4qePFLwFuoqNgznI?=
 =?us-ascii?Q?Z0TON7l/l7CAyK+L5HThsiEU3MaKYq885NY2H+j/0hf+s4g7YfLUhJxcqQ53?=
 =?us-ascii?Q?u1Aei0i0RSlxYInIFG6rx1300CAOPtAoPUWYnDagItKCdLiKaXW+dwuKhPWU?=
 =?us-ascii?Q?uWdAC+bZEbII+YBO4KHsWYAwO8udtMt4fBns3clNfQL5Z5zY59nFG99b+Ee9?=
 =?us-ascii?Q?s991LnwMXSSNOXyVsT9cVdZO5/m05YB5TnwA9KoeiKktpQ4GVoli4zLxPGou?=
 =?us-ascii?Q?SRR5Zs0sq6+7FqQId8yZ/bpw5drFx6vseUHZx0EvHQQkEhkrlYGpkL2XUSWK?=
 =?us-ascii?Q?I+xd2E+qOL2VqxCFCSt2pqi+9ohsjdqhKNeH8oaruLDfRo8RjR6uKxQnF9s7?=
 =?us-ascii?Q?aJLwMlU0AUOtYsbZuD0AgwF+eHxIVbGrIGgVNBKJlj3aK4BH6KGiAf4qvK8o?=
 =?us-ascii?Q?gaxNeb4/UifYavnFaAHUwhKCwrEiiceWGxK/wLZa1uFqlsn8O7IBVDvfPzaU?=
 =?us-ascii?Q?oh74HjWJLCgVKgLUKHgH96OSo+2atLlIbk8V6JY1wzx/19Qqivp12XKswXBr?=
 =?us-ascii?Q?Fz3lZl0ODv6YgGyk64wPtl/k3kjWKpOkq2xyZPIzs1wq9XHkv8dTQcD51ZA/?=
 =?us-ascii?Q?uOLPVZvTNVxdHIN8ctX0RMTx6KNO2RUeYfxaLXOhwRmsfsif9Hj4c4ABdW1r?=
 =?us-ascii?Q?Eu5GTFfHQpNQ305Ex7Kku9Gn+c7gpKZ7yO/vKWF7JqenWHAniS6hw5C1iQg5?=
 =?us-ascii?Q?DHu4ywSy9mboU0SIK6SQegvwnJ7DJ+L6HN5bbENFL/3NRAXU4umMZnoh8CF5?=
 =?us-ascii?Q?Xdbid7rWvRTFITZdyayJlXe22anxtRGgKFKXFZiJjjIkOoPSmmMiBGaE6MwR?=
 =?us-ascii?Q?O6aj/OAnwkdDoHNNKOXcQK8EsrDs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTDQTMHktyK7f4Ui57/AW6J1IV19KiXr1upKGIA0hDiZxwageyXTkYfLDDPK?=
 =?us-ascii?Q?z0wl9W2y9V4+oT837d4wAi4g3Uax1y2xInSFnXTqTIQDav+dtEnrYM0NwjLB?=
 =?us-ascii?Q?QydJ9ZN3S4foWl1HZgYExK7HWDwwIYQHSoi0/rzxD1YuGEz+2oIzXf/Yswiw?=
 =?us-ascii?Q?ttjCApX6ogzZk+HQFWATt6uDZrGW5geffUCa68Xn/LZpdXglW7jmnP+Lg4GH?=
 =?us-ascii?Q?Wol2KE5UCHxO3WuOLYT36V3Ka3M5DTdmZwuVR2fejpL3Pcb0KFBC0auXMCOb?=
 =?us-ascii?Q?ak3eKMcaa9pCxSbrshyYndDCj5eI7sF7kLB29vBk7Ztvmc57U3vSxR2IiJPr?=
 =?us-ascii?Q?sJaId+um7Aq7fUTyKQljQ/MiQY8LPyHGSbqqIJ3BDjPrQUDRfwbRUm8j3Y1f?=
 =?us-ascii?Q?oJCK/sIb8cWvNOyaeaZccb3PaEqXV8M2Am486F0aYckJzpkxB8TpKDac9QAa?=
 =?us-ascii?Q?6eE+eRDWbOXRWh4Fcsge/XX76EPrmYDU5cdyaQOLXvZ5pKRfswNuHRIQsvfp?=
 =?us-ascii?Q?+kgWhv5bz1lRiu+1vjqRlGPG958XUrCHDt8BiXxqpyJF0Dt7ITM9loTwZ4F/?=
 =?us-ascii?Q?UzkdfsdCDgYlvWITrUQMPpSiyP9oz/ZL8FHaJJDqb4SaOzLb9RHilWqiueaz?=
 =?us-ascii?Q?gpkaESVIBdG8UgvLmg8Y/dtIEmZZplIQ8WCJLqnS1dox6goqetmhIdx+EWrM?=
 =?us-ascii?Q?mQreCGS5j1013Pl7zX9L9/W/CzI1yyfaeaSFIUDB6w8qwGMfmCHNvIRz8s18?=
 =?us-ascii?Q?Y1Si1kEBsovhnX28PNNHO54TWabWWiEW2eAuKM0hk+ipeBicSt9TZAzHZHA+?=
 =?us-ascii?Q?4bvTLKNOwtx2BcoptD+K6ACdCTAGJ+BvLA+iIA6GBSBqzbACjp4ww2Yd3r7V?=
 =?us-ascii?Q?fiA3AU8c1XTWPJYl+AIb1vcg8T8eyQ2aulnR3gOeRllI4jJiViuX1vBF6DJd?=
 =?us-ascii?Q?eD6EY42GsMgxPdnR5Yz4rqma0AaOdYU6b8zFDj+kOKOadyY5uBKtGzOQLXTz?=
 =?us-ascii?Q?kxJF9oiR2kYeGMwW1KmvKwlB6tjQdFmvopvyGZ/zpIX8aDNYm+BA/JetyFH+?=
 =?us-ascii?Q?zgFBViDlBZbj/MV6K7K5hM6pD/yuN0uEBSpvpG2/LZkWo4DzuB5kKx7ly91s?=
 =?us-ascii?Q?fdBXWAXTDHM/XySPuGegLpxbeegYThfL14LZuNCT0D70QlHxEdhWX950UIRs?=
 =?us-ascii?Q?atW1oS5zNzwQDGqvGg6Gi1lmr4mNro7x+y+nP6lxft2/rUtxF41tGJa4Fhpq?=
 =?us-ascii?Q?bsLnkgr16JgRdbRbRak6XUSJ0LPVcnvZ+6BlAoFQO57G5cEdf6PM0b0ywfil?=
 =?us-ascii?Q?u/BuHBK/4MTKPuSD9EQDjv2d8A7AuuttcWrxSf8LsrwTE9JE4sv5nziICqc2?=
 =?us-ascii?Q?INv2Pn2T6aQRGsehAIHTfHefYHuEdtgYNEJcRgkXHO4ieTNPq9HpKBkTivRg?=
 =?us-ascii?Q?WA1XYT3dwTOWZ4qevqJQ3VJSNe/gtjplfqF2utB2AVMJ583yL8ItmivZuJvn?=
 =?us-ascii?Q?SUJXhS3OL9rKv1hD62LOI50kFqT5uhdRkdXU1OU37eiCA+I3185mqNYSpW3M?=
 =?us-ascii?Q?vBaK/mDalOC7GwAW/It2B8WSTHb4Kw7pSQSL4UPE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c3df7-227d-48a8-b5d6-08dd62672311
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:42:06.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZ+b0LYJlEHM4sGsvubt5Rbl3++ePv1fit3Nw7rGUecwTBXoS/AYL8acaSdkPRNynmf0qyLT+dsjMm75bMNzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

Please use plain text emails.

On Fri, Mar 14, 2025 at 12:10:42AM +0800, WangYuli wrote:
> My tests still show the same compilation failing.

It passed with clang 18 on Fedora 40, but now I tested with clang 19 on
Fedora 41 and it's indeed failing.

How about [1]? It's similar to yours and passes with both clang
versions.

Thanks

[1]
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index a54eedb69a3f..9c54dba5ad12 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -212,7 +212,22 @@ static const u8 mlxsw_sp4_acl_bf_crc6_tab[256] = {
  * This array defines key offsets for easy access when copying key blocks from
  * entry key to Bloom filter chunk.
  */
-static const u8 chunk_key_offsets[MLXSW_BLOOM_KEY_CHUNKS] = {2, 20, 38};
+static char *
+mlxsw_sp_acl_bf_enc_key_get(struct mlxsw_sp_acl_atcam_entry *aentry,
+                           u8 chunk_index)
+{
+       switch (chunk_index) {
+       case 0:
+               return &aentry->ht_key.enc_key[2];
+       case 1:
+               return &aentry->ht_key.enc_key[20];
+       case 2:
+               return &aentry->ht_key.enc_key[38];
+       default:
+               WARN_ON_ONCE(1);
+               return &aentry->ht_key.enc_key[0];
+       }
+}
 
 static u16 mlxsw_sp2_acl_bf_crc16_byte(u16 crc, u8 c)
 {
@@ -245,12 +260,13 @@ __mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
                                   (aregion->region->id << 4));
        for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
             chunk_index++) {
+               char *enc_key;
+
                memset(chunk, 0, pad_bytes);
                memcpy(chunk + pad_bytes, &erp_region_id,
                       sizeof(erp_region_id));
-               memcpy(chunk + key_offset,
-                      &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
-                      chunk_key_len);
+               enc_key = mlxsw_sp_acl_bf_enc_key_get(aentry, chunk_index);
+               memcpy(chunk + key_offset, enc_key, chunk_key_len);
                chunk += chunk_len;
        }
        *len = chunk_count * chunk_len;

