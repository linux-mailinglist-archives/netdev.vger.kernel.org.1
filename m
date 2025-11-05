Return-Path: <netdev+bounces-235762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639DC350C0
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE60189AE07
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9E2FB997;
	Wed,  5 Nov 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tx6lqAze"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5272C324F;
	Wed,  5 Nov 2025 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337587; cv=fail; b=nDbaMNB8FgsosA4oCmcNPf2QLjfj4/UWz7qda3+yP/w4lOkf0PYMuDgY00kdyduYTmg3IcnD+/iGmiLYahqFiJn6sqFn2lfzlw1XNlui/j55Rd7MZ+k9GAqBrQK1peJwUXS8GGoqc3GnBIC/Vy8zk5gwJ4C5XKCfzvEhVVjFa/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337587; c=relaxed/simple;
	bh=WoF8BAhv03iXpBgqygmqnHbbuRMuls0ssDg8oYP4ozc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyiHY3j4+VRr+ve8hxKOju7AgjFz9x5VwAH7CiW9hdGoQuUsbx2QdfuYZ9WCmjr30DGJSti2KHT8zaqtkFnIoengu7UZ3G4RsmzvW2H5OwJq0sWlbLr7Ly7JZ3OeNqBAuR5QyJI/XVYtDur5bat/Zg8k1mo5QEAe3mZnVATMJkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tx6lqAze; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZnYs246K7nqSugLgHTIYqW/zBTBSY0KEQwTgCJR1/GfLLFR1nLEXWRK2lkF6MK610cVUZqnH6V+RF2asLhq/5LdPC7AboKweoy0A4ed1HR83Yp0XD/6V5BRUFn0hEYHSCiNuA7k34/nqmMEYy5qMOzUzTJtp+xVmFDGb+eQVLAreCLXGI0FkCJ6SFGtro4TRpgaRT2FKtU3FC+nMBXm8IS8PPhPr0JHmUHdHOcv4wyeJSVIRYOIAyu9aoi15vpv4ufg7rEWC2rtMDg7yucezgo0RIOGkeRt1zjEInaBrF8a/dFFH5Z8AyVAOHFIoLz3q9M+CeZ8S2G60Sns1PePiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5pzh9RXZgRc9oUpJlL1QV+70mQy1Afxq3bG/d3Ps6c=;
 b=TM2jv/DYgLdjRsTZ2cJ4MdAT3Mkvs2lWt4IUDMMsHPVrn6HO9VZXIGYKqp9yzGqgme/8zzlgHNVBySc2LQvAYJ1/LZB7lwqJOFdvwjQ7894KDZnVOATe4UQGZ7W5ET4cv088AGq5uc+WMeZrV32aZveE8oxMChJQn/qGFvz5oaTDt7w7MB46yT036wcv7FV7tSTzEu1NydpH5F0fX5gMYKwPkHsAxKLSgGB/aEoHonnHbLsAJHYOoYVqzoX+NsnOPJQ/QDvhGsbm/Deg/kYrj/7hHEvF3VZTUty7aVWAcWU+inpZ9I/6stPYpOQI4iy3/SaIbD6w7ZdJNwfJHcBhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5pzh9RXZgRc9oUpJlL1QV+70mQy1Afxq3bG/d3Ps6c=;
 b=Tx6lqAzecb0z0qIg7HqnTSbBs/VgYQNhUx6bhtf2xOANXm1BmJoRPRBSsmBM6J/J5jSo90xFicjZZf7DNV2JS3LTzBkoHwmpIPtJTn6apzwXBsBVyTmhMSNXEI3QWaPjA9GATW3hX49JeK1LKtvoX1lAY67PiAwYltxO1jbk0erL4yaKIvbjBuLaWrLet5PJ+agVClQqIUFxJqPtKBPsxHFRm/ZBxkMlOaa+XpAYynv2vRlnVnKMIBbwmQPqCI4iTjEWVeRLIYYrG56H8dmzH4ehar6aaQdh3tTi5J0LSrQUHHxt/UUJ+Wkc8xPOe473N4JyEMXNUxbAdr5ECQbcug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 10:13:02 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 10:13:02 +0000
Date: Wed, 5 Nov 2025 10:12:52 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, jasowang@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in
 mlx5_vdpa_set_attr()
Message-ID: <qfswutrrnmk6cksyamjx4ywv4kkxcb76vfqqszodzo7ltze5r6@c2dsseiez4ik>
References: <20251105080151.1115698-1-lulu@redhat.com>
 <20251105080151.1115698-2-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105080151.1115698-2-lulu@redhat.com>
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 808ae50a-1c06-4a1d-29cd-08de1c53e786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+KTrpJVG0jkUFjA2Wuu2iCWVWQsPO+5lwedKFP5WiGhopkLknKhiSl659Kg?=
 =?us-ascii?Q?6nOT+ik/lhUwuQmv794SonrT7XV/VLqTmeOYN1hslE5bIuVPOLHqSoJaz6wF?=
 =?us-ascii?Q?I2PoPyIMFeR8DFBFZVGAP1iFZ1nYCJdUczc4s+1ZPxzWNO29TTGUzymrLmDk?=
 =?us-ascii?Q?6zKsNTQ5/AW33EKKZcF/Q+7B/Oielbp2IeLXlxMSsZgO7krIsUhnkqGf4Oah?=
 =?us-ascii?Q?Rze8bOLCyvuOCZOx4ep+A3qjFEfey1bHQQTk75t5DaMWwISJ1RtTgo1sk/mZ?=
 =?us-ascii?Q?2JPpT/CQsh4bykYzf4cNIknt5GetyE/a2MfLX/eTzdbs6bmDyCSAOmkdCWgo?=
 =?us-ascii?Q?VsxfdmGwDamQBf5mLiDb+F/BvwOxXrdm53eBLGx5L3GpFXz9D2kEbPyJwrhH?=
 =?us-ascii?Q?RKHBMFKudj9IU3BuNEHA0HVC1GRY+sCvSQ2M2knOJFUKOflI6r1tdCT/XWIP?=
 =?us-ascii?Q?XTpvxqV3wh8W20JxQFCGsuo5ascSSQAIPy4GmgTn7yolOV2iOf87RBUADEPN?=
 =?us-ascii?Q?Rw/UDaMBuILufa2CP8WuKjW8b9mjqmzC6Ohd9grnQk+f7vncTSpxyuFp6alh?=
 =?us-ascii?Q?7oRdN48XIQLGgF8zLVi0ga2oQpRfDCAfLn/8OoeY6euTtaYCgCze9X7UqoJM?=
 =?us-ascii?Q?FLvR449b5Rhyhbp7PpOXfUiwln16BJ6wooqRp0TSEklUaKcZ+M6/QX0m+pWA?=
 =?us-ascii?Q?pf39bQki/cmAid8zNaB7ldQ8vnweamsrenYtkrE12w469Tz5ZD38CGSCaX/h?=
 =?us-ascii?Q?QC20VmpxZQMKUbmLBNJ6fZkAcGeN+3S5LZtLZadVAFVvPDHuGkZ/g1D+zJJM?=
 =?us-ascii?Q?i2x2ke25jN0Y9b8Cr+nRtzRdfVJsfgvBfQpIjGZkCxWqSuns5GwoGPWkK2z2?=
 =?us-ascii?Q?IGzBbQ7XGdLBLCY6ZIRCjjghyfLvJRJtxGh+raqpQbK6ubVCWBCoU8x2p3g+?=
 =?us-ascii?Q?zbRhx9zbdBS1af9WjBteOOeqkzl5bCbbsPwbSTyr/1qoEUY74AQYsrrx4LW0?=
 =?us-ascii?Q?ArbR0m2x53+oiPUcHisUbWITriJUMhpMzXFJ54vuw7GB4FxgqnN+IwbJ0zPQ?=
 =?us-ascii?Q?Jg0U1p/6vmbxZkwL/BtmEzzf5FHbmp+/Iv1hSfGDrzEC2leg6JaEmEZQX2C9?=
 =?us-ascii?Q?XK5skmTRHcyx902R2dH7HcONqeK7LpQfiniyHY+w1VNqB0HSU93qQoWdi+PN?=
 =?us-ascii?Q?yqOBHJPto1R85vJPYeJPipPY8xwNMf5J4+ul0cfhI21qlsxREwR+HI8tzOnr?=
 =?us-ascii?Q?RAgIRRihCWghXnKKKtlwgg+LguP7pNTPWNQ3JvIK7ruleNdb/tKkyhnZn5Fk?=
 =?us-ascii?Q?o2fbjaNI9AbgE3yHL3GG1W+5oZ8YtaDvICOiLQHvTcyyOnecNOdMaLV7uzf2?=
 =?us-ascii?Q?LXgROKR61WrQpV+jQAc4ezYNR9onFB7cR47wkiJOCY0C88jm7EuzKjAXD6pu?=
 =?us-ascii?Q?bMEiDu/7kKfwXj+NXsMhwJwlRxH/EJ0Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eKbPjxeAO+W61Ls3yXF5RMhmBJTEeMosefqeEM6+WhMJ1caZNHtrrWt5X3k?=
 =?us-ascii?Q?9E2wrfI3S9viqDZGbiYuRwfbaqsEIFvG48lQbn32jZY0qDUFCrZ1A07oF5Hq?=
 =?us-ascii?Q?DYaJ4xVNiM6PaqfCUjZ/qLnNQ66EzoY/v4zzXRa4NhAM3oGnSU4n4f0OMRr9?=
 =?us-ascii?Q?pQjWoB4iH1EzwftENoYdsGecDXP64QUkQblWDM7tECARsrpkMq4osWq5gK6t?=
 =?us-ascii?Q?T8TETuL82vgH+hr8GQu8JqcCOvsdjnW11JR5psxdaWMk2b7r+G/oEvFVs414?=
 =?us-ascii?Q?PhGmbyKOV4Cnuwj1VTD8Kxw9Sslz++M9uiLFHy27VGsJqeiu1X9ML0aVFk51?=
 =?us-ascii?Q?TdzhMMHlnPmgJKM//YXPuDs66+1zdUTREDFG9KVYhSt6In0zX9fQE9DFbwiD?=
 =?us-ascii?Q?db1A7P8J+pJBmAXzoMQKAQ/nCwWTQvwmY/Iv7SUh7qRCoYwjNHraWNXetoZd?=
 =?us-ascii?Q?0sUk//JxQQzHvEv9Zj0JlKDvW3XJGFPEMzGlBeABO4QXFhaBpMCgy1+x0N9W?=
 =?us-ascii?Q?/534esW3Rmcjhlr+y6tM65JROLQU3nRHpWzOwWEzSXnfOU8+Ow9syqGVKozI?=
 =?us-ascii?Q?xHcQqFpMdPNQIJESB7qMSLfR1xoS470vEC6lAsUEawXT7LSN9yyHuoZb7DlQ?=
 =?us-ascii?Q?i9zrXcIpOxTZEoG+ZTBrOyJk/9ORqt3+Wa4lJdYepdkDwH33V4uV7JUlVaSf?=
 =?us-ascii?Q?OPuQ94gBlMqgiThsqQiuB8L8vItTd9QnsVJNym+jUOqDDYZPP/DWH+UGuhe1?=
 =?us-ascii?Q?1QeKE/0yjJXwGBJNNcy+eatoxvfR33T7/QPZ1OtCw9/MlyDLRqTa0i4C/o8u?=
 =?us-ascii?Q?zjdoPd7nXe+L2MFuZTYWcKyB/d1A4Cpn/mzUit+ZwekscbvsNzLt9Ypj76Xf?=
 =?us-ascii?Q?gsLfAXKbExT+NzOZXCzuTGQr+cHilpSERQqfGbZZbqnj1/ppxFg9lCmxrIE/?=
 =?us-ascii?Q?JR03UEwOEcWS3VYWaUSYWzoC4U1utmaTpBgJdgiWdNC09szW9G4i/K+jA+PZ?=
 =?us-ascii?Q?t3QFkH4Y2nIBCWtzmAt5KDvLbzDi3Nsv8wc5cnBW9h4q7qRINGL1cwQyWABi?=
 =?us-ascii?Q?ZXP8JMcL20XYDC26m22dBeqZ/OEX1dlLXXfrnncKXfSgVWLrmPPidU3WXk00?=
 =?us-ascii?Q?2/xWGr2MqY2UfxnE0G+STYi2XkYBD0yzPDhZ891xgnldsJ3f8gBOeYp3T42Q?=
 =?us-ascii?Q?AEOkece/Eo27xl772zgsaAhCYe+wK/3MOfajImm8JJAeXSS3oUf7k6C8+KtG?=
 =?us-ascii?Q?8mum2MIdbBwOyRm5xIE4w67Pucycxkuiy+VVpmDPktuEOUAnWx3aT2q3ZRhR?=
 =?us-ascii?Q?T8XB8SM6z2/uQe2NMymxr02qgccwHI/AMJw0S6lxJLzV/afri2SEhYy6CKhl?=
 =?us-ascii?Q?SuyCeP96lTd6k/1bMzIrHPCeXz65KdhuioXTkpwH6PCfR9JECnaq6BhW/gR4?=
 =?us-ascii?Q?8CH0LEk9jHCyu36vBHKUsUjV3LZ0HKuq0vUdFv4xjzV7nJuV+O22sJRa7JkP?=
 =?us-ascii?Q?qWvs/qaQsCLFgXjTPKxpNLQw1pBlmVMTnTVR+VT0EpnxUcJ0t2adUVo8gYNr?=
 =?us-ascii?Q?/bKldYNjCUVsUtJjDMR4j1q5OFm2WpVzy7munPlD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808ae50a-1c06-4a1d-29cd-08de1c53e786
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:13:02.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndVeyaw8faoj/0qhLMHtrZGzqQakrEvBwq/9OFQcbCLjc5q6X0aKamM5t8OwScFTlcvIJqMPQNNNUcDEyq+NHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

On Wed, Nov 05, 2025 at 04:01:42PM +0800, Cindy Lu wrote:
> Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
> that old MAC entries are properly removed from the MPFS table
> before adding a new one. The new MAC address is then added to
> both the MPFS and VLAN tables.
> 
> Warnings are issued if deleting or adding a MAC entry fails, but
> the function continues to execute in order to keep the configuration
> as consistent as possible with the hardware state.
> 
> This change fixes an issue where the updated MAC address would not
> take effect until the qemu was rebooted
>
Can you remind me how you provision the MAC address throug .set_attr()
instead ofa the CVQ route?

> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e38aa3a335fc..4bc39cb76268 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	down_write(&ndev->reslock);
>  	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>  		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
> -		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
> -		if (!err)
> +		if (!is_zero_ether_addr(ndev->config.mac)) {
> +			if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) {
> +				mlx5_vdpa_warn(mvdev,"failed to delete old MAC %pM from MPFS table\n",
> +					ndev->config.mac);
> +			}
> +		}
> +		err = mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.mac);
> +		if (!err) {
> +			mac_vlan_del(ndev, config->mac, 0, false);
>  			ether_addr_copy(config->mac, add_config->net.mac);
> +		} else {
> +			mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to MPFS table\n",
> +				(u8 *)add_config->net.mac);
> +			up_write(&ndev->reslock);
> +			return err;
> +		}
Code reorg suggestion for this block:
err = mlx5_mpfs_add_mac();
if (err) {
	warn();
	return err;
}

mac_vlan_del();
ether_addr_copy();

>  	}
> +	if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> +		mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan table\n",
> +			       (u8 *)add_config->net.mac);
>
Have you considered factoring out the MAC changing code from
hanle_ctrl_mac() into a function and using it here? Most of the
operations are the same.


Thanks,
Dragos

