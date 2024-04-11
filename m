Return-Path: <netdev+bounces-87071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9AC8A189C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E28B1F26E8C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A16F13AE2;
	Thu, 11 Apr 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TyIh/3dz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BDDDDC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849042; cv=fail; b=Tzrg6YWeqsKaY6/+35afkca7+nj+kUlmJkOJznePBjHEAPT8kGB4kUJJVV8j11wuqMq0Rz2Vih7xrlggHDhxt+mqx6SJ2Z+pvA2uOAuRIeTFgZQ8GMvFJh10C31qdpQtBWhy0WSgPHVoBRv36XWHsFBD6Owa6EAYv9Y07p23JHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849042; c=relaxed/simple;
	bh=s70t8z1c2qqRTIqVCiCYJ1psngheAJEMTMUdUlUJuu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qO2IVQDfC9SPnNWgAVC/FDQscOnJT2fgxx0XGh30f5SaA2oGYyyRx4fIpWhf+JNDO/VOhlNC/gccHslLSiFR7T4da0gcx5a5SRV4IUCOHNoQRM/4lu13PkYqq7s3CCRnDVI5adfn6aWRGoFYBIgdBhbPbjZ+E/4Y8sveFVNhdSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TyIh/3dz; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8Klfn+tuMSiOSXLd4vYtmTCsEIvnTR0Vuqmfpc+ezU8EaifAxKqcEc8Ksi7Mp8ndFF5FKUC7VrMI2x0S5hELHvRqcAuQ2Ay3GBvE4QE8VQG2xW9153mHufyVnBsN0Nc1Yt7B2vcfcoHj3qFrUV0Aznu6VnWhJqEuVlIiWxxNdJe5GVebAlMSUqKMKPAApSE1LFiAi4Dt0+MaPEz64odMdvsBj4eE59QSpTid5u1VuJg3k7RgI8rVia8rItqrxzPg0I2cbXypNwVAASreF2codpT9cYwok4nGjWsdicVCFawwTYUAX9eWWl8AhFSsNSSoZ+q1Aw//Zorj4lLc4ufhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbIEa7k+Vz56YaUjRQBu3x7yt91tT7/chKfkP+iH7s0=;
 b=WltSYnWlhu7sfmN4a3GZP0sTePfVXG/NMZrgy56KxZExAAYmeBz7v5B3BpOsC+wirZo7E+DGUE8m6f1fspPXqzkQrkfHJBxUWSKCuISf6WG/MlsVog7+kVJOXZjlv065kYIeL93SbiwooHOqApW28kEiRgSHJdm/GFZfqs+/kyoFVmstlvl93j81WOfhVUi4J6Zp4rXQxAYetleds8/HJToUMWS5NF4Ti5iW0IuEzcmyox3M+pWZKB6evRiWDBtJju3J9r+SjhV+asyY5XeCClep7snTwPEDOZXBJUmUv0+L+ycRviHABlK+nCFAoEWd9gywbKUk5WLmXlpGbxUG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbIEa7k+Vz56YaUjRQBu3x7yt91tT7/chKfkP+iH7s0=;
 b=TyIh/3dzpUPdxX6ikgeLym0NW6QV5Tb6sl0n/RxsYzpn10a8HJLDHmzE8xwItkXHTtITpbqFdEta8Ir3+7i97rtr/xmnYhUaD9giyxik3GzQTUGUY3JwBog7xTUhVh/Ssk99ov3XoBrNcW6zhltz4FsnZwFzOEU07w+io1f5r4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 15:23:53 +0000
Received: from SA3PR12MB7975.namprd12.prod.outlook.com
 ([fe80::9291:f4ca:ef21:c217]) by SA3PR12MB7975.namprd12.prod.outlook.com
 ([fe80::9291:f4ca:ef21:c217%5]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 15:23:53 +0000
Message-ID: <8bdcdf49-25fb-46d4-926c-6b0275164d97@amd.com>
Date: Thu, 11 Apr 2024 08:23:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/4] virtio-net: support dim profile
 fine-tuning
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
 <1712844751-53514-5-git-send-email-hengqi@linux.alibaba.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <1712844751-53514-5-git-send-email-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To SA3PR12MB7975.namprd12.prod.outlook.com
 (2603:10b6:806:320::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7975:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d808fc-df07-4582-1a2e-08dc5a3b6562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P4pvzUq/KphqTwUXWM1ebDnmQ6Lvn1MkKPfCcWf3yG1e6U5PA9gteyOst2aJnZt+qrqiKi41LS8o6Cz2UMq119J9Hy1tkaMDvGjij7SUFMDx7DJ8dMiOsew7ldp2pGpP1Uh3W5lSgfcpcjs7uJlwQefgTHMRd2tbURSYoMHMJIzXUlIRNMpMpp4I+hZZDyn4wrl9NpqWWbjDDh9MlGGfVyftOiukHAhgBf+tSZlCV2Y9gPRRdlqZJpFhxxZ18dZdBhVyW339SgRueS+iFZPuFU7wOgwGPXRBgoCXmWWPA47jIB6KveUWPVMHgLf/YgXvXcu/VsM6/dszMukAgW9PKVVhFG4EJZ+bWMwd50Ref58Htb5UrdeVLWfC90ZisLPebPF1PPs8uWRi0VA5LuUBW/3+wXI2JYAIutldkz5seCln2BLIV7F50bgsefkYnaY80RkxQh9Y51Rs9jv4xteTCyO5Fi+vOgIFypX/goPWsG/GR/9j5esvwJIddBeNhXQaDLVYlONqH5WKyvsxChwRXgQK6xBhkT+kJmYCzoFFQqfXZZLE3/PLFgb5TxTExEj1atJ1ir5y3bdOcDqj3ZERILKH8ZRvJCymfqrACmPOGGLij965q+/IBTmxpzE0zVaxXq7eeHBwQyqh2vb4vlKcyYYdaXGcXv15BQc79ZgVwqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7975.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlNHMG9QSW40Vk9zdmk5d2VqMCtJSVlYWVZqdUpKMUVaYU5IQ0hkNzVsOFQv?=
 =?utf-8?B?QTlCT0dtQ2tzcGJKbWI3K25LZHd3UnZiYzdwbFZMSUNaOFZyT2M1djFUbTBu?=
 =?utf-8?B?OWR2a2gxc1Qzd05aQldoeXlpNENqTFdqeHpYb2VEbzg4UVhkN1JKWVFTVWNR?=
 =?utf-8?B?WjJtZFpwcVhJYVNjT0dmVzUrdzJPNkQ5QzVQbSswQnVWZnNwSVRGRk9ySXB0?=
 =?utf-8?B?OHIrNU9ZNTdCQ0w4RVhwUmhSZW04dGhReGliSi9xQlc3ZEcxaS8yaU9kQmsz?=
 =?utf-8?B?T3VaM3dmNGZWUCtqZFN5WTVHVUlKYnhFUzZaKzBoTkFyVkcrUTdsMVBXOFBQ?=
 =?utf-8?B?eERjblh4UUl5L3pNc2RmSEpvRU1aWW95K3l1a3pMaVY5dW9iM0FMcWxNK3h1?=
 =?utf-8?B?aE9FVmJQU0V1K3cvTldQL2xkUzlFR0tONFF2c0ExTEFoeE1UTFZWalRnZTNO?=
 =?utf-8?B?aWJDbjFydnViTzM1VHBraURXZTRxUWZPOTFEMFIzZ21TSXMzUTRpV05ta0lQ?=
 =?utf-8?B?V052YlN4ZWRPTUhsTXBUTEhYWXRkZXltU1gzVVQ4V0dYdi85ZG4wSGRqSXAw?=
 =?utf-8?B?YnlxUnBnZzBYVXhBYk1jNy93OE1ScFVwUWJ5RjhmOERmRXgrZnprNUNmc3gw?=
 =?utf-8?B?Skt2d21qM1dQVUFlMUJrSS9nLzJKM3YyM0dZdldKdzFBMHVLVnNWR29QYzJQ?=
 =?utf-8?B?VU9ORm41UnVrckMxK1RGa2cxRk1sT29jY3JnZ1UvR3laY3Z3ZkNaQitvVk5r?=
 =?utf-8?B?aW9GUnhrbnRCVFlmV3ZDMHhzWkxaMjBjd2VTOW0vNEFGTXIyS2t3cUF0KzBW?=
 =?utf-8?B?d09yaGduVmhzUFNpMnBOdnhxcFNTWFpJNUhWQ1lIaGxPRVBCUVB2NjUwQ0hx?=
 =?utf-8?B?L3A1dUJCa1AvcGsrM2x5K0haVmgxYTZFNnZHT0F1eWw3UTFDRTFsUmRKTWpk?=
 =?utf-8?B?bHZ0NXJUNWM4bE53d1J1Y3cxb1I4T0RQZytmTFZvYURZWjNCVi9lcnNsOXoy?=
 =?utf-8?B?VVhURUpxK01Hb05kb3F1TCtuN2lPQVNhSklyc3dlN2htTmt6YW16M2JQNnM1?=
 =?utf-8?B?dDZLTkpyL0c1eExvLzRpNWhOZjMzQTZETWpzZUNvSUUveW1GRjlaeitHMzBM?=
 =?utf-8?B?WjBBQ1ZNR3o5RHZLbW1qcEM2Q2R0MWl4SHVDZFcwMDRZRDRTRXR6alhHR3hV?=
 =?utf-8?B?MlhsSUJ6TzVtUXhNRUhQUis3K0Z6ZmdFM2RJTmQrOFZiODhPaXhTVXVQeGVP?=
 =?utf-8?B?V3NZUVVhMjlBeHRuaE4xellmc25qWTJweGNjdXowOS9lN0lKWjBkWFh1amU0?=
 =?utf-8?B?L3VuMUFEWjdKS3NQTjIwZTgxYVhrK1ZPRVZHVUtUTkl5aFFGSEIxK05IRyth?=
 =?utf-8?B?bXZJMW1HdXVkQ2NCVmpnSDFoM1R3VmhHV2NZdzMzYTFRMHRTUG5zYkM4MWps?=
 =?utf-8?B?MStiN1N1VzlHRFY0M0xFMG9vd2ZrbGZQT0pja0sva0VHRGVDek5aVFB0ZW00?=
 =?utf-8?B?RXBpM2RsSERORGpQaUx4NjJpZHlPT1JoRm1Kb0gwczJCclcrQkowTTJHaGpL?=
 =?utf-8?B?N0NTcDUvV2hiYmV5UnZPdEU0Mm94ZjJOSVdzUytnTTlFeTVtNEF2TnRocVNG?=
 =?utf-8?B?ZHJCWTZOS3JHQXN0MnlSdkpvSm53N2QzdDQ3cGhsZDBMUkltbjFvZkF0bHNH?=
 =?utf-8?B?M0k3cHlMTXRpMTF5cUh4Z20vWk1MVzF5WWE0aUJWbDU4Y3M3cVVzS2JYUG5H?=
 =?utf-8?B?bS96a3lsK3ozU09zSnpTNFlGUHlRR0QxMkwzNm9wTjBjOVZQR1NPU01HQWFn?=
 =?utf-8?B?OHJBaVRlRmxuRGJnOGdoY25QUS9QalMxWGlzMzFLU0R6dnRad0Y2UGVyaVVF?=
 =?utf-8?B?M3c4UzNRNnY3akY0MGhISTYvUDhYNTI2ZEhjSVp0c3UzVitQVmV3cDNLbHRo?=
 =?utf-8?B?dG43M1YzbFlva1ZxMFB3c1VySk8wZkdJMDkzZmRva3R1akRaVFFKYWpEcFNO?=
 =?utf-8?B?SWFwVWFBRU5pQ3FzbE05Q09GZUVRLy9yc2pLQmxVM3FnYlhUSDdpUUhFQlBL?=
 =?utf-8?B?V3BZQnNoMjQ4Nk9oYVV2cjdZMmxia2dIa3Fpd2VRK0dSMWh0SGlBZ01vNGVv?=
 =?utf-8?Q?QlFDE8/WXoC4jwsEd9Ey0/DXw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d808fc-df07-4582-1a2e-08dc5a3b6562
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7975.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 15:23:53.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RTSJJsJz5TLbFDIgDwP8JEH149PAbdsbWWBsGY/gKJcmyhnbKqWj2cdJfU3IEmM9HfBbncu8QXHb58sFbme+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166



On 4/11/2024 7:12 AM, Heng Qi wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Virtio-net has different types of back-end device
> implementations. In order to effectively optimize
> the dim library's gains for different device
> implementations, let's use the new interface params
> to fine-tune the profile list.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a64656e..813d9ed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3584,7 +3584,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>                  if (!rq->dim_enabled)
>                          continue;
> 
> -               update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> +               update_moder = dev->rx_eqe_profile[dim->profile_ix];

Looking at this it seems like the driver has to be aware of the active 
profile type, i.e. eqe or cqe. Why not continue to use the dim->mode and 
also the net_dim_get_rx_moderation() helper?

Does the dim->mode not get updated based on the ethtool command(s) 
setting up the new and active profile?

Thanks,

Brett

>                  if (update_moder.usec != rq->intr_coal.max_usecs ||
>                      update_moder.pkts != rq->intr_coal.max_packets) {
>                          err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> @@ -3868,7 +3868,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
> 
>   static const struct ethtool_ops virtnet_ethtool_ops = {
>          .supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
> -               ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> +               ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> +               ETHTOOL_COALESCE_RX_EQE_PROFILE,
>          .get_drvinfo = virtnet_get_drvinfo,
>          .get_link = ethtool_op_get_link,
>          .get_ringparam = virtnet_get_ringparam,
> @@ -4424,6 +4425,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> 
>   static void virtnet_dim_init(struct virtnet_info *vi)
>   {
> +       struct net_device *dev = vi->dev;
>          int i;
> 
>          if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -4433,6 +4435,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
>                  INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
>                  vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>          }
> +
> +       dev->priv_flags |= IFF_PROFILE_USEC | IFF_PROFILE_PKTS;
>   }
> 
>   static int virtnet_alloc_queues(struct virtnet_info *vi)
> --
> 1.8.3.1
> 
> 

