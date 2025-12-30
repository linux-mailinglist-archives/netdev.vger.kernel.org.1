Return-Path: <netdev+bounces-246311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF536CE9386
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9B7300A862
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF323EA9D;
	Tue, 30 Dec 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gTZu6DlY"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37D1FF7C8
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087121; cv=fail; b=mwY8IYniyh+TVJQ9LvMCW7P2t4Lr0WiZsPJ7H3Boe5bZgpK3GmGkiVGu/F2hEFd7U2TN+W3pY/06duPH6GTY0wY9shWegGyGooqOQTMCEDbtEjrESkboXrFm8WVn9cepYElFxVjBM5qxlMqkothXimzt4GynAFUo+iNmmDiA/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087121; c=relaxed/simple;
	bh=JYo3sCacqeeC3OPssjeNKvJiqoH1KypWCup6cG4RvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CuF0rB93K+KV8z0h6G38Vg57mzzKMiUbZYYgSOIiewUGMj4iDD87gYyQf2BKNHAGLO1wNYa2OzkDRgmtFFtBbqhtX8nx8aE/9GELki9p2acjWSnfcP0Z1wKrCQi/CluTjmm4VK1UnmEDt9u44l79bkqV1km1Kqq+l3zGcVvqqPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gTZu6DlY; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/GIMI3RZ3e2st2frcQPI6MTTqQTnU8teWJH4UgzqDKBqrnZ9SpvHZGuxIZ3yd6jlz8EL/KOemxCuEfUYvHAsj5Oycqpos7W/nB3vrQo9vhfwAQ6NdoNkrtkPRlFeBD3mpRmMsgyhxh379ToxtveEre5LtKjL1whaCqzaBimasv0gRPGCmvEZwP4pD0CXccXQRB8SIcHjbAxm+iwf0uEAQbg9m6jmu4ogwMVcssN5osKh4/eF1VsSYw8kg/S9/hd8m13+fbEzq9XgHnPh0JX/v6FA1ItY2Ng2G5Nh8hNMLqCwdCbwg7AFWSbkhhOOlQUEwkEC3lXe1XJuBn9ihfhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvOgOkFvwYck4bafVbD85hB2af7QT8O83z6v3+HM0Lo=;
 b=Hjv78Eg+B0MWKpAf6PPFhmTkkTZUij6gh53evZSpLup9fztrSvXEWOmxgdtBzfVXY/cqYUyRWmsqZTLDcDIiArKIT2dSHIPGsjdbZowwa/9vdGxFEe9cXdGVTiCuFtXqmLk+Wrys8bjOkLJ3+FcAqcDTyNSYcYaR9rR7AyrjgqRGJ6BERB3J/sqAv7+KSsNgU5qZK4aYKjNDenXEDBABD8KoYCWf2Ki6r6Sk/heV+ZMYj3VUQoPcNN9FYkb22Bc1TQKW607mK1P70jNTOJR4EXZ7OyyCICkvZD7B4MvmT0oVTQLTfPdgJTk8MJ/9TNk33ImsqhvZswwxrbkl+rkPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvOgOkFvwYck4bafVbD85hB2af7QT8O83z6v3+HM0Lo=;
 b=gTZu6DlYjOnqWJooGSAjM6LWZrkGX+jZJY4UZozQ1EwFlVCxk8alNVGqM9qGTl0/I56JXXo/81mKqPCwI700c4710t1ljipTHtZQsEp1osNifMgXryo35/JJg+epIHm4AxXytsHEL7c9tcmbv4t6d9ZprzUao+PUdhHKHw9TIbP1Zzoo7faPCawRI+Ri1QOWg/q++0FOMyzSH9opQze+xWg0697e4x5JaArsLcCWhQgh74avpckCQyBrNii1CMPQXK8ZH0qix2dRHQz0r6G76wRx3z0Rwq5I+7Qthhn4hYJnd9KIHOo2xXqPpY2wXfqgWB8JHM3PuMfci9aWMabdFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:31:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 09:31:55 +0000
Date: Tue, 30 Dec 2025 11:31:44 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Alexandre Knecht <knecht.alexandre@gmail.com>, razor@blackwall.org
Cc: netdev@vger.kernel.org, roopa@nvidia.com
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel egress
Message-ID: <20251230093144.GA497224@shredder>
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ee7db2-9c25-4799-8d8c-08de4786456b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpZtOwhUR2SapNVTxOlhNfyFWAh4PTiYKXudkCm5gry631PLswMmWovvfcbS?=
 =?us-ascii?Q?7c259Tf6kwygYNi5IT3RfM5PKQCKXk7spFGBuXr+/5Gh5/CKeHqMbeJ98+P5?=
 =?us-ascii?Q?qDO0MzbFlOEKEUCJQCEyc39AOEYjGa2B57Z1kLwdUJMUjTMUU5Xc5jdk6Dqm?=
 =?us-ascii?Q?qegKFuZdxpaAKIbnnI3QNccd94Iodsz+QfF1rXrkfdOXVQPaHcQi6uEJxWyU?=
 =?us-ascii?Q?KB5CTbBYcS2Tex3J4hpAa2Xa/RVACupRZ+IcxShn2nZP5S3/nuSrqYD7ufRI?=
 =?us-ascii?Q?Bwk7wCmIEXddKg+gVy6VcXcTNJA+EMIqdZj6asbV60DgM4q6Swp8zaVy3KuK?=
 =?us-ascii?Q?3DzgHQxGmE9Ssqj5oeWCz+kyZIMIUGIguumkw+8W/oPO+3wmGHjJt7ElpbPk?=
 =?us-ascii?Q?etOCBtgqFmbLY7SD0lqkZu1bHLW8QFMntD5tYijjJ3lrDs31dqSW0gW6fEaH?=
 =?us-ascii?Q?dm0DRrIZknGtn54jXyI420U3MmL8dqvKTBsQE4ryd3PE9QvORgrD3syFBkMV?=
 =?us-ascii?Q?ge8/7Gu9AuQqo9NMN5ycWE8zPneZHQEv37U59YKl3P/FCb9OJvesd0B3278E?=
 =?us-ascii?Q?h77I5W6IbeIrpc4VoCEU4lTrw01XAVktTg8Oq4+XZDY7SgL9cxYNi/B8/JV0?=
 =?us-ascii?Q?DzeIjK5mUYJvqvvIKMENycsaSRiyRycYDokXnTRHt1TN7UYg3YqU5zVE+INH?=
 =?us-ascii?Q?24RtwhbqnQVPlzhT/wpRNMSC+oBYpm/eW/cUMnIIJC9FCg13zVwRC5Sh2yLq?=
 =?us-ascii?Q?TxTCEGAKwDIWLpVlGh86GW3W/huLcrgcmvYGFRfn6K0g21lyaBKe9X2Iu7J6?=
 =?us-ascii?Q?oVNITIUOWO3S1JC4a24L3lvgdk8pFDlGYK5U2nEQUYoOET2+4AqIcw5SPtHt?=
 =?us-ascii?Q?NFKL5i0BAMI0gzGVLi0FjVQz5UMZQywSypjeDjVVuoaRsyMD5Zl1EfZUqpBu?=
 =?us-ascii?Q?xviDU+uEWc9s+O6yAX8FsgiCUb0IISse63wKr654ipL0HSFESA6tq2ihcTw+?=
 =?us-ascii?Q?O/UoTeiFwdv/lpOgAtwACnab0hJLmif+K6QVN+QQnSJuBi9mXkVeT10hI/Hb?=
 =?us-ascii?Q?0xGWJlnnLPTbWeXE6nFaFPySlH2e5ZXNd/NeCQUFJrcvJlsRm5QXcswix2gZ?=
 =?us-ascii?Q?MTF7lghLiTvw+cXpolOa6eVrMfT8gQzO7tsGWWruB8lr0tF/MQwA0nwtn70z?=
 =?us-ascii?Q?Xygz1PiKqfP5MuoGx1yEXyZEKLL801ibUPgevQYkrsPjv75OouuqSzLzGQmW?=
 =?us-ascii?Q?n9nnOll/IwVJblWerNcKQkO8L6O9gFae7eCTekJEj6pB9V8o4Z6dQlT2LlOu?=
 =?us-ascii?Q?nz2oyr+hZm4FQtD834Ch59HSjqC1ctU1H7BdVU6FHlt16oEnIdXrgHaDgq56?=
 =?us-ascii?Q?1ikztayyqIwp6sECIVh7eo5QFjYQGGPNR33YljZ8TpAce5Jk3plRBCOaQZdN?=
 =?us-ascii?Q?PjFtri7WTV26HfdWr4SfHHTYehq8g9Io?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6giEhxXpXMfRTyG6g4F8uZLFGVAW+qqHkBHe+7gKkh+RHnrClBQqsPglC2k?=
 =?us-ascii?Q?ZkPngRB5iiJRNiDM34AyAhX43eOlBA5v/ny9SXOaT1G/cVd8rseI9bu5dENN?=
 =?us-ascii?Q?QAKkUohCLwy+Xt6HsP1uPX5SMEsbOCG9gXCSc9jtcf/oPZfJ3WtFMIBH55OR?=
 =?us-ascii?Q?A3RIyIzXREqZcBYLZ7atWQ0e6+HvSoWh+PEvQIOBaPJc1ydyJXeYJspuApCK?=
 =?us-ascii?Q?CfZmXvVyxtYUPVN8rXRYrJJUoBdfNI+prxEB6C02tVpGqy3SyhbgV24i29zl?=
 =?us-ascii?Q?jxUyn7BqxinF+e/9os+KKNbfRC627XzQz8K2X1oceUDBgLQ6mVvOplvvv23w?=
 =?us-ascii?Q?05TIWDlNRfkWu302P1YpyfVIwALIb6wOFYXcvZM7MoABpblCFVg03ZimzAW2?=
 =?us-ascii?Q?vEdspbV5oIv/vAl87OS9mWCb99MjhLHuvDhlptGxWhYquvsMfxeaaWWbX+GZ?=
 =?us-ascii?Q?MsMwKk3CyLEeLSwQ77KK9E5IUJUPBBvKbF5mivI/Kq+Ah6GP49j9I+VVFXPy?=
 =?us-ascii?Q?4na6b1/HLg1uJ3EjQbO7w+m+ojVDH/f/ziSx5gtFt33in8RyiTokQhBYlOZi?=
 =?us-ascii?Q?AB//uZc5NOpVmXakDRz3N+7H3UJzojMaOLsfx8ojtBHKMFYPvUyfd6DFoC1J?=
 =?us-ascii?Q?yY9bXErM//LnUQtqFWWYjfF1jq9t7uvhNenLrvoM80+5rXbV3CgtpYBGOnsw?=
 =?us-ascii?Q?niJn5uroCNf4TNmJWhiXLwaGca07bqjFZEiotq+8l4x3DVQSFdTy9oA9RJ5G?=
 =?us-ascii?Q?7F9oeU3ejg9d8GhJ5IQJBO0nVMJEOazz1IGjWKdU9CDx7GPJ2P8SZnZ1e8gR?=
 =?us-ascii?Q?w0O9oLkbjN9QpdNFpzdem1+NWgwsoRVfoHLK3Qai212E3rb3bR5GOk5na3Hl?=
 =?us-ascii?Q?YWWrzXJf/aNyJj45yiS0DEQQqrURsE0NiXSZkbma9Nn74btDvzaBh+S5kysx?=
 =?us-ascii?Q?ZtsM9cyVagdkm6aaw8eAkqDD56BUsV6W5QKWwBhZwdoseCZXwwSIoZyk97wI?=
 =?us-ascii?Q?ZCHq9JOlVa0fMYIZscut1x/0Rf4+Oi7Ra1VrkVYiuheOAmy3ZntpdOFfd2Fy?=
 =?us-ascii?Q?XfU9W2C/8BHSl0I8fSCi2x5btcDnzPkq2PTI3WXjDNk9LSb9exJu2Tmz7dX5?=
 =?us-ascii?Q?MArlLhNseLW4hLanSIqEtEutb/z7krYbn5W4KzT7LJzpBNR9AFVx+gq9cS4R?=
 =?us-ascii?Q?xWDFnv6dscQW1kOxGOx1bl0FyZmlLRc2p7ih9yd67dUJjNL5+zWrq0XhIgUR?=
 =?us-ascii?Q?7pas7Ca1tHw/tAI/lWmT3qce4gRcNqsDcnBBosjywvxwcVTA6/O0lSPkfoeW?=
 =?us-ascii?Q?2OlsH4ATXKK6SS8MiUwiEyvZVCsC2rokQ1B6gU+TsW6TCw13xAO+A7ME4br7?=
 =?us-ascii?Q?/BmEGPRlACGKngTM5D8wJLLdLj6Bl12ppJSCWjlneSs+MGPj6Uy8r2gIznn6?=
 =?us-ascii?Q?yvdWaE9hDdlngBm827JsY4gzIJn/d+B4OSclyXhz5afwvEKi9l8UKPU+aYYn?=
 =?us-ascii?Q?qdTnN//RPh7RqKeuuTC8T3JA3hjmszAhW0JbUK7/tSRGlZfPvbYDQtl4VElg?=
 =?us-ascii?Q?9aZ5PsCf2OS8AQ836+mCyMm9qjm98Qm3fab1WjDGPxK/ack14WKpy8v0fONd?=
 =?us-ascii?Q?p+wl5IhhtT5nUTimLnrKFTG9q8BU7hAHoAdPkwUUTJR9pEpvrqRqEmU7R8SE?=
 =?us-ascii?Q?o5CbXD7eY/QjTmOjuUEF6DvZm4pQp/2kGfZxo7cfBGol6PTB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ee7db2-9c25-4799-8d8c-08de4786456b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 09:31:55.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN5F2988RqIUKFI0tlUsGzBj00LZNvMdzeRcCPTENwNe3QR2ixRfLu8wkDSvFomSNPODYRAIqMtRt9mwecF1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

+ Nik (Please use scripts/get_maintainer.pl next time)

On Sun, Dec 28, 2025 at 03:00:57AM +0100, Alexandre Knecht wrote:
> When using an 802.1ad bridge with vlan_tunnel, the C-VLAN tag is
> incorrectly stripped from frames during egress processing.
> 
> br_handle_egress_vlan_tunnel() uses skb_vlan_pop() to remove the S-VLAN
> from hwaccel before VXLAN encapsulation. However, skb_vlan_pop() also
> moves any "next" VLAN from the payload into hwaccel:
> 
>     /* move next vlan tag to hw accel tag */
>     __skb_vlan_pop(skb, &vlan_tci);
>     __vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
> 
> For QinQ frames where the C-VLAN sits in the payload, this moves it to
> hwaccel where it gets lost during VXLAN encapsulation.
> 
> Fix by calling __vlan_hwaccel_clear_tag() directly, which clears only
> the hwaccel S-VLAN and leaves the payload untouched.
> 
> This path is only taken when vlan_tunnel is enabled and tunnel_info
> is configured, so 802.1Q bridges are unaffected.

It's not clear from the commit message why 802.1Q bridges are
unaffected. I think you mean that in 802.1Q bridges the C-VLAN is never
in the payload and always in hwaccel (even when Tx VLAN offload is
disabled, thanks to commit 12464bb8de021).

> 
> Tested with 802.1ad bridge + VXLAN vlan_tunnel, verified C-VLAN
> preserved in VXLAN payload via tcpdump.
> 
> Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
> Signed-off-by: Alexandre Knecht <knecht.alexandre@gmail.com>

Looks correct to me:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  net/bridge/br_vlan_tunnel.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
> index 12de0d1df0bc..a1b62507e521 100644
> --- a/net/bridge/br_vlan_tunnel.c
> +++ b/net/bridge/br_vlan_tunnel.c
> @@ -189,7 +189,6 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
>  	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
>  	struct metadata_dst *tunnel_dst;
>  	__be64 tunnel_id;
> -	int err;
> 
>  	if (!vlan)
>  		return 0;
> @@ -199,9 +198,13 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
>  		return 0;
> 
>  	skb_dst_drop(skb);
> -	err = skb_vlan_pop(skb);
> -	if (err)
> -		return err;
> +	/* For 802.1ad (QinQ), skb_vlan_pop() incorrectly moves the C-VLAN
> +	 * from payload to hwaccel after clearing S-VLAN. We only need to
> +	 * clear the hwaccel S-VLAN; the C-VLAN must stay in payload for
> +	 * correct VXLAN encapsulation. This is also correct for 802.1Q
> +	 * where no C-VLAN exists in payload.
> +	 */
> +	__vlan_hwaccel_clear_tag(skb);
> 
>  	if (BR_INPUT_SKB_CB(skb)->backup_nhid) {
>  		__set_bit(IP_TUNNEL_KEY_BIT, flags);
> --
> 2.43.0

