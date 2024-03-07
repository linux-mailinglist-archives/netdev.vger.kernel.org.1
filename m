Return-Path: <netdev+bounces-78539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEA8759C5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898A11F2109F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FFD13B787;
	Thu,  7 Mar 2024 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdsVH9t/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C001CA8A
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848169; cv=fail; b=aanvHKz0BXu0rBgC4q92if6hPFC+ICXNbawGo+f0sRmEeUjnFzD8BlQSZ3CfSYKmVPI6wlINr+lzQ72WBn6I4w9Jziipeywlrs8L9zSaCfw8KC9vK5zb2R0cNzryj1egd/P0sBzG/TSoAmk3ThKqcn98j4PToAhunMlFnHIZomk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848169; c=relaxed/simple;
	bh=aFXH/fqXmH/OofIbgq15tJK6NIu6EgdJ888p/nfwBGY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=MqgqubPcw9TDWapco8l2DyY58yQl0L1QJB3aqHI8m6x6yXl6Od3H0EDxKznL3OU/nSpWjh6Z0zPagmBnPp6FFssJ/532IzPkkmNzbD63xXuMZUKEgDYjRbDNxcar+3/JFj21fuN3NE0tFHupp06cMAvvdtvmDv9VnY20KEcyzEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdsVH9t/; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NECT0ziftpXdw3U+S9mVNB97af3bC5K++s2vFKmt6MSmLQSqumWT2B2TQlUzBpav1vOtPh79L1JQt2Ovf1i68YWS9Z9t+GDIy8t7XxYjFhTxoWIh8yPlqLlW5gORT45NE8M1kTF55AyaRiaWLe66XFyeyuBJnJk8uYlcjWZEC1BmNpqGVU7Yp1dd2ceUp8NFikWA7c+se17bTxBlgtwtZZSIne0qow9qiWKjyvphn1Ge9CbsDWD08KIBEUYWViTuD58vEDsZfI6/cyO5C5Vl5EnLQHk/GmV9gYTufDAr6OzW7pxnnte9tD8MuUwMdl4JbA/GgTqfRi7234cPRul8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DLctD3egNw+HcCnwstGTAVUfkedW1JTgdFByysvClc=;
 b=H+mv4H/3FeH25jSH+I7DNHguZ+LTuKN16CQEz61JDoHwrsWJ4TuMqqVMAF6PcznPLZLkXBM+qNlY1E4SnnKl78xzrO0jmsZrlaNMhr9bJO/e1t1RE0JWgHi4pZiX5uDiDJawnvyq67S546P4Br96JwzWalCo5K1yIQEWcQcILaUJy+wpNlDRnWMGjs/M+jQ+1XKYZ4A5wHgub8iag7MraXj6IGL9JF4iQlzkVUxIyHwWTRqxJKceAARFWzmSH/60TghBKVcj1gy+NRxiX2kZgQh+YE/Xbdnej9YWSHSoxhDtFYKhner/ddSGmLSvTVEz02Q0C2TuRPopr9Vqe7QQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DLctD3egNw+HcCnwstGTAVUfkedW1JTgdFByysvClc=;
 b=FdsVH9t/FWkJTxLJLFxzfSjYMsnYOHmnEE3HpS2frXDR/t04Q2GWf2UZO0+EN5bRu3lrot9yNWAqLnnEoxRnZcDn+VuJrz9aZ/wUzicMWf6Mva4BgER1085xz+OgQ04Qk7tRTL7Qn9aiMqZFlH8hdz5LdbN5NP+chbmfstnaCqbqCiJAArOqyrZpXsdEB7Eq7H70epUWNg2y0OOVYMlWk8IiHnIANNYMFdZnWcMqWN4TBL8R8FtIpBjga6l9K+gnePkK1i6Eusp2HuJNmmx67GR5KfVaxz9lolqLlkFR5b77uPSwunkk7mPTvYTCipAOwKSKje1a1Z52TWrMS1SoHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 21:49:21 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 21:49:21 +0000
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
 <20240306230439.647123-6-rrameshbabu@nvidia.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, "Nabil S .
 Alramli" <dev@nalramli.com>, Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH RFC 5/6] net/mlx5e: Support updating coalescing
 configuration without resetting channels
Date: Thu, 07 Mar 2024 13:44:17 -0800
In-reply-to: <20240306230439.647123-6-rrameshbabu@nvidia.com>
Message-ID: <87h6hhvhjz.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cef9f1-eb34-4d34-f1a6-08dc3ef0727a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+O1wbsPna24fdipNrSYEq93OL6/iAbkYAHfXjPOnbofHUvVfi8M/X0nrEGEwNqWjCfWG9vKP+0kQTk1fTGlr4edPH+LsZE1Er+JD5uN5P2vSHN/pIGKCL3m6EYoCkcNdX25FQt6EbtBTuZRO7SeSweHOaUBOuEgMljsjJENN9qLPhsEQ/ECJRA94dYuFd7uw4WlOmjEHo+oJYq2LAjdgM6rs7YTzb2byk7uUjeJnIdh+wutIz/FTA9FDmhWyDalO/vA4g2WjKbs3GtJqXmWtiTGcQyiBzNDda5eywYXTTOTZiBft5PCanOttqckf94CIB091AZtPgwmCNf1fy3hC6lOm499wauo1r9SDusSBN9Ny6QUu4MZTxPyDyA0Ihd3FTfqgImxRkwU/dARZ6wvDhYhmgAILFMQqxqfHXsqZeoIdJfxl3ly4dclXJ2G3qRBbaUlFTnlbw7217fdspiwmM6WcM2lQoFXLRAgBxm4qQiZSglFmsCgvNl5k0fjzZWjKLdjSQnwrrZvCMJVjc/N4BHbI3EhcXQNyOJlLLW7fPwaGMZW0S0IlLblZEeD9upqx6Q236J/6gJqypeBlTPXTGUNY9htcGvTXwYVDXk6NfYldheXgqC4LzbnIMMfxKIObT9lJ5CJVVIv+mCm0AWMbdqrPDU/vQq5DcZnvRqQZGcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fmdGVkh0YTe2pyB+kcd6haCtb7zb9TsZtnjyL1mqK1pnmVY2l1saHkS9L3lW?=
 =?us-ascii?Q?ZYSX7BvOBH8JNZMf6B5wP7ZE4q8O5TPMZvT6XrPNhuyhpJVINukjfspdYDSE?=
 =?us-ascii?Q?tkPo6S7AjkTIeX7Tx0tXXoQ6kItb2QOW8bJ7DCwQozWaU3j4DmDU/DPwUOX/?=
 =?us-ascii?Q?1o+0Tg3+EpLG5fUQpvlWDo06iHM7WYZgTnsqDV5hGzI8LIZmNveDrAD1QDq1?=
 =?us-ascii?Q?/0oFMwQTS2zEs8oeho+QD2FWdEK7VmZJr4ApG7MHa7XJ31AUQJRFUufEnMi0?=
 =?us-ascii?Q?QFHHgrqdC/oyBCwZMn1Ji3lRqz4H+au3km1y3SUBsTawgo+JIsUuTgcq6cXj?=
 =?us-ascii?Q?gYJFmKcQ28GvtRd57kqmZCK3r4DUWUgUpZimiSjUcmW4xP9zgU3wI1QVyA/j?=
 =?us-ascii?Q?lJVvDJw78WiRS1b5B9f7e4a2Dq01f9rNiVueMyjwVOUzCSrhCSuaBQNN+Uz1?=
 =?us-ascii?Q?cHJFh5Kw9tlO7wS64saLfByiu5VKdDyeRPBIv0ZbMW9otvKexRyDCtZ2Oe5v?=
 =?us-ascii?Q?SV83HJkQrbK2pX7zdErxO0gvK2TAIjtLIJbNVP44nmwiqRyWQUd/dVzk9BvM?=
 =?us-ascii?Q?hRgv25zIpzfSdDbH6gGt+XJz2/7Kj+RSaNfiym5mMcueBakzwyKsntFKBCjb?=
 =?us-ascii?Q?ESJQYVno0xoHlF2IsZD9lrBN9jpmXXsp652XxoTdqM9eQsT0f3+P/BrGhJbW?=
 =?us-ascii?Q?2jFenjfS7esbluR7XmWzkgK8Xm9NkruHqdGitiSj4kuH/D01+GLLSOFjnAiu?=
 =?us-ascii?Q?Yxm02KKYLrSn4iwAMWhDXJNup1k2kF6PNSo/I6T5W8t0E+g9zP+g8QcFsCRw?=
 =?us-ascii?Q?oH5X8MEFmfX4+blH/V4RybMMnvLJDvGZVZIy8VeA/ctAHTc7NtVggSUaNu7A?=
 =?us-ascii?Q?GLc2UERSCqwn4TXYPBwP7GaXwatMV554aYDfwe7N4WcL/jN//x6kMR11+VTe?=
 =?us-ascii?Q?F09JJf519baVsILCAKg9bWkmRo0bYRgFGOhW+9njQ8AzFVVVDA79RSQDYa9J?=
 =?us-ascii?Q?fW0jIor1msv5pKMECItUlCVmcEYotR4BUR1lfS0Vdf1Y8pveFw5cn2ZAOItP?=
 =?us-ascii?Q?I413v8f76Ugwj9Sk9YgXPG48AjelHh0IxKrpkrLb4BdEW7Lgcl1Aess8BLj/?=
 =?us-ascii?Q?nIUrp2TSH1uSUBvK3DV+i8jbeY4XKDPj00HJObHN2TZOheTZALAx18mkL+/O?=
 =?us-ascii?Q?xgs1DQXEB6AMw9oUCRiAfbS2qNvOyPN7kShhouGsYldWo0RbOQRMaYMPrnhw?=
 =?us-ascii?Q?niHCISXKfC14eQC/LhZ73kCGq1jruyRXRkf8QKQIc0mQ1FzlencWl8U7MYuP?=
 =?us-ascii?Q?Rcsty9RITG/OwyetD1QCO0I83zeJirW9DJQp0Kjj3HvKZCuZbPGRBEObOzZD?=
 =?us-ascii?Q?L0yuHw5K+qgxYZrW+uimlo90WjTibrVoKFul0qJXW3bZMf4LMkLZAYCIndQH?=
 =?us-ascii?Q?mIqPQ8tfrTkcmshYXTkQJ9gQgyl4Dohd2WwRUTx7SVK5a7Q9qbED14LO7JF2?=
 =?us-ascii?Q?p0Xc//yHTci3HRa9WuXDNZmACvkGsOimTG5jsohkxdlt0Wd4o9TCQOx6RFR7?=
 =?us-ascii?Q?yCS/UUOA7/it9Og+Bqne4vlkP522/ophh9SddZpotJ/AcGc4PTYm42QUnpaB?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cef9f1-eb34-4d34-f1a6-08dc3ef0727a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 21:49:21.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5nDVHXBRxNzXiv9ospGCLBvhs2oaZq9RKWHq2Qd0HC8RpZ55Uye/S9UjsUBA3SivlPEQAkT3AiIuO1NGsPH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

On Wed, 06 Mar, 2024 15:04:21 -0800 Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> When CQE mode or DIM state is changed, gracefully reconfigure channels to
> handle new configuration. Previously, would create new channels that would
> reflect the changes rather than update the original channels.
>
> Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---

There are a number of issues in this patch that we have resolved
internally for our next revision.

>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  16 ++
>  .../ethernet/mellanox/mlx5/core/en/channels.c |  83 +++++++
>  .../ethernet/mellanox/mlx5/core/en/channels.h |   4 +
>  .../net/ethernet/mellanox/mlx5/core/en/dim.h  |   4 +
>  .../ethernet/mellanox/mlx5/core/en/params.c   |  58 -----
>  .../ethernet/mellanox/mlx5/core/en/params.h   |   5 -
>  .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  89 +++++++-
>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 157 +++++++------
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 213 ++++++++++++++----
>  .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   5 +-
>  include/linux/mlx5/cq.h                       |   7 +-
>  include/linux/mlx5/mlx5_ifc.h                 |   3 +-
>  12 files changed, 470 insertions(+), 174 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 1ae0d4635d8a..be40b65b5eb5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -319,6 +319,8 @@ struct mlx5e_params {
>  	bool scatter_fcs_en;
>  	bool rx_dim_enabled;
>  	bool tx_dim_enabled;
> +	bool rx_moder_use_cqe_mode;
> +	bool tx_moder_use_cqe_mode;
>  	u32 pflags;
>  	struct bpf_prog *xdp_prog;
>  	struct mlx5e_xsk *xsk;
> @@ -1047,6 +1049,11 @@ void mlx5e_close_rq(struct mlx5e_rq *rq);
>  int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param);
>  void mlx5e_destroy_rq(struct mlx5e_rq *rq);
>  
> +bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
> +			       bool dim_enabled);
> +bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
> +					bool dim_enabled, bool keep_dim_state);
> +
>  struct mlx5e_sq_param;
>  int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
>  		     struct mlx5e_sq_param *param, struct xsk_buff_pool *xsk_pool,
> @@ -1067,6 +1074,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
>  		  struct mlx5e_cq_param *param, struct mlx5e_create_cq_param *ccp,
>  		  struct mlx5e_cq *cq);
>  void mlx5e_close_cq(struct mlx5e_cq *cq);
> +int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> +				u8 cq_period_mode);
> +int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> +			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode);
>  
>  int mlx5e_open_locked(struct net_device *netdev);
>  int mlx5e_close_locked(struct net_device *netdev);
> @@ -1125,6 +1136,11 @@ int mlx5e_create_sq_rdy(struct mlx5_core_dev *mdev,
>  void mlx5e_tx_err_cqe_work(struct work_struct *recover_work);
>  void mlx5e_close_txqsq(struct mlx5e_txqsq *sq);
>  
> +bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
> +			       bool dim_enabled);
> +bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
> +					bool dim_enabled, bool keep_dim_state);
> +
>  static inline bool mlx5_tx_swp_supported(struct mlx5_core_dev *mdev)
>  {
>  	return MLX5_CAP_ETH(mdev, swp) &&
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
> index 48581ea3adcb..3ef1fd614d75 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
> @@ -3,6 +3,7 @@
>  
>  #include "channels.h"
>  #include "en.h"
> +#include "en/dim.h"
>  #include "en/ptp.h"
>  
>  unsigned int mlx5e_channels_get_num(struct mlx5e_channels *chs)
> @@ -49,3 +50,85 @@ bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn)
>  	*rqn = c->rq.rqn;
>  	return true;
>  }
> +
> +int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enable)
> +{
> +	int i;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		int err = mlx5e_dim_rx_change(&chs->c[i]->rq, enable);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enable)
> +{
> +	int i, tc;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
> +			int err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], enable);
> +
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs)
> +{
> +	int i;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		/* If dim is enabled for the channel, reset the dim state so the
> +		 * collected statistics will be reset. This is useful for
> +		 * supporting legacy interfaces that allow things like changing
> +		 * the CQ period mode for all channels without disturbing
> +		 * individual channel configurations.
> +		 */
> +		if (chs->c[i]->rq.dim) {
> +			int err;
> +
> +			mlx5e_dim_rx_change(&chs->c[i]->rq, false);
> +			err = mlx5e_dim_rx_change(&chs->c[i]->rq, true);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs)
> +{
> +	int i, tc;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
> +			int err;
> +
> +			/* If dim is enabled for the channel, reset the dim
> +			 * state so the collected statistics will be reset. This
> +			 * is useful for supporting legacy interfaces that allow
> +			 * things like changing the CQ period mode for all
> +			 * channels without disturbing individual channel
> +			 * configurations.
> +			 */
> +			if (!chs->c[i]->sq[tc].dim)
> +				continue;
> +
> +			mlx5e_dim_tx_change(&chs->c[i]->sq[tc], false);
> +			err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], true);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
> index 637ca90daaa8..3a5dc49099f5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
> @@ -13,5 +13,9 @@ bool mlx5e_channels_is_xsk(struct mlx5e_channels *chs, unsigned int ix);
>  void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
>  void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
>  bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn);
> +int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enabled);
> +int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enabled);
> +int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs);
> +int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs);
>  
>  #endif /* __MLX5_EN_CHANNELS_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
> index 6411ae4c6b94..110e2c6b7e51 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
> @@ -9,6 +9,8 @@
>  #include <linux/mlx5/mlx5_ifc.h>
>  
>  /* Forward declarations */
> +struct mlx5e_rq;
> +struct mlx5e_txqsq;
>  struct work_struct;
>  
>  /* convert a boolean value for cqe mode to appropriate dim constant
> @@ -37,5 +39,7 @@ mlx5e_cq_period_mode(enum dim_cq_period_mode cq_period_mode)
>  
>  void mlx5e_rx_dim_work(struct work_struct *work);
>  void mlx5e_tx_dim_work(struct work_struct *work);
> +int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enabled);
> +int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enabled);
>  
>  #endif /* __MLX5_EN_DIM_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 35ad76e486b9..330b4b01623c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -514,64 +514,6 @@ int mlx5e_validate_params(struct mlx5_core_dev *mdev, struct mlx5e_params *param
>  	return 0;
>  }
>  
> -static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
> -{
> -	struct dim_cq_moder moder = {};
> -
> -	moder.cq_period_mode = cq_period_mode;
> -	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
> -	moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC;
> -	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
> -		moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE;
> -
> -	return moder;
> -}
> -
> -static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
> -{
> -	struct dim_cq_moder moder = {};
> -
> -	moder.cq_period_mode = cq_period_mode;
> -	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
> -	moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC;
> -	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
> -		moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE;
> -
> -	return moder;
> -}
> -
> -void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
> -{
> -	if (params->tx_dim_enabled)
> -		params->tx_cq_moderation = net_dim_get_def_tx_moderation(cq_period_mode);
> -	else
> -		params->tx_cq_moderation = mlx5e_get_def_tx_moderation(cq_period_mode);
> -}
> -
> -void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
> -{
> -	if (params->rx_dim_enabled)
> -		params->rx_cq_moderation = net_dim_get_def_rx_moderation(cq_period_mode);
> -	else
> -		params->rx_cq_moderation = mlx5e_get_def_rx_moderation(cq_period_mode);
> -}
> -
> -void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
> -{
> -	mlx5e_reset_tx_moderation(params, cq_period_mode);
> -	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
> -			params->tx_cq_moderation.cq_period_mode ==
> -				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
> -}
> -
> -void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
> -{
> -	mlx5e_reset_rx_moderation(params, cq_period_mode);
> -	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
> -			params->rx_cq_moderation.cq_period_mode ==
> -				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
> -}
> -
>  bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
>  {
>  	u32 link_speed = 0;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> index 6800949dafbc..d392355be598 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
> @@ -77,11 +77,6 @@ u8 mlx5e_mpwrq_max_log_rq_pkts(struct mlx5_core_dev *mdev, u8 page_shift,
>  
>  /* Parameter calculations */
>  
> -void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
> -void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
> -void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
> -void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
> -
>  bool slow_pci_heuristic(struct mlx5_core_dev *mdev);
>  int mlx5e_mpwrq_validate_regular(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
>  int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
> index 106a1f70dd9a..4cfda843a78e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
> @@ -37,7 +37,8 @@ static void
>  mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
>  			struct mlx5_core_dev *mdev, struct mlx5_core_cq *mcq)
>  {
> -	mlx5_core_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts);
> +	mlx5e_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts,
> +				   mlx5e_cq_period_mode(moder.cq_period_mode));
>  	dim->state = DIM_START_MEASURE;
>  }
>  
> @@ -60,3 +61,89 @@ void mlx5e_tx_dim_work(struct work_struct *work)
>  
>  	mlx5e_complete_dim_work(dim, cur_moder, sq->cq.mdev, &sq->cq.mcq);
>  }
> +
> +static struct dim *mlx5e_dim_enable(struct mlx5_core_dev *mdev,
> +				    void (*work_fun)(struct work_struct *), int cpu,
> +				    u8 cq_period_mode, struct mlx5_core_cq *mcq,
> +				    void *queue)
> +{
> +	struct dim *dim;
> +	int err;
> +
> +	dim = kvzalloc_node(sizeof(*dim), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!dim)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_WORK(&dim->work, work_fun);
> +
> +	dim->mode = cq_period_mode;
> +	dim->priv = queue;
> +
> +	err = mlx5e_modify_cq_period_mode(mdev, mcq, dim->mode);
> +	if (err) {
> +		kvfree(dim);
> +		return ERR_PTR(err);
> +	}
> +
> +	return dim;
> +}
> +
> +static void mlx5e_dim_disable(struct dim *dim)
> +{
> +	cancel_work_sync(&dim->work);
> +	kvfree(dim);
> +}
> +
> +int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enable)
> +{
> +	if (enable == !!rq->dim)
> +		return 0;
> +
> +	if (enable) {
> +		struct mlx5e_channel *c = rq->channel;
> +		struct dim *dim;
> +
> +		dim = mlx5e_dim_enable(rq->mdev, mlx5e_rx_dim_work, c->cpu,
> +				       c->rx_moder.dim.cq_period_mode, &rq->cq.mcq, rq);
> +		if (IS_ERR(dim))
> +			return PTR_ERR(dim);
> +
> +		rq->dim = dim;
> +
> +		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
> +	} else {
> +		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
> +
> +		mlx5e_dim_disable(rq->dim);
> +		rq->dim = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enable)
> +{
> +	if (enable == !!sq->dim)
> +		return 0;
> +
> +	if (enable) {
> +		struct mlx5e_channel *c = sq->channel;
> +		struct dim *dim;
> +
> +		dim = mlx5e_dim_enable(sq->mdev, mlx5e_tx_dim_work, c->cpu,
> +				       c->tx_moder.dim.cq_period_mode, &sq->cq.mcq, sq);
> +		if (IS_ERR(dim))
> +			return PTR_ERR(dim);
> +
> +		sq->dim = dim;
> +
> +		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
> +	} else {
> +		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
> +
> +		mlx5e_dim_disable(sq->dim);
> +		sq->dim = NULL;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index b601a7db9672..422fb0f16af4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -34,6 +34,7 @@
>  #include <linux/ethtool_netlink.h>
>  
>  #include "en.h"
> +#include "en/channels.h"
>  #include "en/dim.h"
>  #include "en/port.h"
>  #include "en/params.h"
> @@ -533,16 +534,13 @@ int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
>  	coal->rx_coalesce_usecs		= rx_moder->usec;
>  	coal->rx_max_coalesced_frames	= rx_moder->pkts;
>  	coal->use_adaptive_rx_coalesce	= priv->channels.params.rx_dim_enabled;
> +	kernel_coal->use_cqe_mode_rx    = priv->channels.params.rx_moder_use_cqe_mode;
>  
>  	tx_moder = &priv->channels.params.tx_cq_moderation;
>  	coal->tx_coalesce_usecs		= tx_moder->usec;
>  	coal->tx_max_coalesced_frames	= tx_moder->pkts;
>  	coal->use_adaptive_tx_coalesce	= priv->channels.params.tx_dim_enabled;
> -
> -	kernel_coal->use_cqe_mode_rx =
> -		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODER);
> -	kernel_coal->use_cqe_mode_tx =
> -		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODER);
> +	kernel_coal->use_cqe_mode_tx    = priv->channels.params.tx_moder_use_cqe_mode;
>  
>  	return 0;
>  }
> @@ -561,7 +559,7 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
>  #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
>  
>  static void
> -mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
> +mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
>  {
>  	struct mlx5_core_dev *mdev = priv->mdev;
>  	int tc;
> @@ -569,30 +567,38 @@ mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
>  
>  	for (i = 0; i < priv->channels.num; ++i) {
>  		struct mlx5e_channel *c = priv->channels.c[i];
> +		enum mlx5_cq_period_mode mode;
> +
> +		mode = mlx5e_cq_period_mode(c->tx_moder.dim.cq_period_mode);
> +
> +		c->tx_moder.coal_params.tx_coalesce_usecs = moder->usec;
> +		c->tx_moder.coal_params.tx_max_coalesced_frames = moder->pkts;
>  
> -		c->tx_moder.coal_params = *coal;
>  		for (tc = 0; tc < c->num_tc; tc++) {
> -			mlx5_core_modify_cq_moderation(mdev,
> -						&c->sq[tc].cq.mcq,
> -						coal->tx_coalesce_usecs,
> -						coal->tx_max_coalesced_frames);
> +			mlx5e_modify_cq_moderation(mdev, &c->sq[tc].cq.mcq,
> +						   moder->usec, moder->pkts,
> +						   mode);
>  		}
>  	}
>  }
>  
>  static void
> -mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
> +mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
>  {
>  	struct mlx5_core_dev *mdev = priv->mdev;
>  	int i;
>  
>  	for (i = 0; i < priv->channels.num; ++i) {
>  		struct mlx5e_channel *c = priv->channels.c[i];
> +		enum mlx5_cq_period_mode mode;
>  
> -		c->rx_moder.coal_params = *coal;
> -		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
> -					       coal->rx_coalesce_usecs,
> -					       coal->rx_max_coalesced_frames);
> +		mode = mlx5e_cq_period_mode(c->rx_moder.dim.cq_period_mode);
> +
> +		c->rx_moder.coal_params.rx_coalesce_usecs = moder->usec;
> +		c->rx_moder.coal_params.rx_max_coalesced_frames = moder->pkts;
> +
> +		mlx5e_modify_cq_moderation(mdev, &c->rq.cq.mcq, moder->usec, moder->pkts,
> +					   mode);
>  	}
>  }
>  
> @@ -601,15 +607,16 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
>  			       struct kernel_ethtool_coalesce *kernel_coal,
>  			       struct netlink_ext_ack *extack)
>  {
> +	bool reset_rx_dim_mode, reset_tx_dim_mode;
>  	struct dim_cq_moder *rx_moder, *tx_moder;
>  	struct mlx5_core_dev *mdev = priv->mdev;
> +	bool rx_dim_enabled, tx_dim_enabled;
>  	struct mlx5e_params new_params;
> -	bool reset_rx, reset_tx;
> -	bool reset = true;
>  	u8 cq_period_mode;
>  	int err = 0;
>  
> -	if (!MLX5_CAP_GEN(mdev, cq_moderation))
> +	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
> +	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify))
>  		return -EOPNOTSUPP;
>  
>  	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
> @@ -632,60 +639,74 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
> +	tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
> +
>  	mutex_lock(&priv->state_lock);
>  	new_params = priv->channels.params;
>  
> -	rx_moder          = &new_params.rx_cq_moderation;
> -	rx_moder->usec    = coal->rx_coalesce_usecs;
> -	rx_moder->pkts    = coal->rx_max_coalesced_frames;
> -	new_params.rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
> +	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
> +	reset_rx_dim_mode = mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
> +							       rx_dim_enabled, false);
> +	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER, cq_period_mode);
>  
> -	tx_moder          = &new_params.tx_cq_moderation;
> -	tx_moder->usec    = coal->tx_coalesce_usecs;
> -	tx_moder->pkts    = coal->tx_max_coalesced_frames;
> -	new_params.tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
> +	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
> +	reset_tx_dim_mode = mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
> +							       tx_dim_enabled, false);
> +	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER, cq_period_mode);
>  
> -	reset_rx = !!coal->use_adaptive_rx_coalesce != priv->channels.params.rx_dim_enabled;
> -	reset_tx = !!coal->use_adaptive_tx_coalesce != priv->channels.params.tx_dim_enabled;
> +	if (reset_rx_dim_mode)
> +		mlx5e_channels_rx_change_dim(&priv->channels, false);
> +	if (reset_tx_dim_mode)
> +		mlx5e_channels_tx_change_dim(&priv->channels, false);
>  
> -	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
> -	if (cq_period_mode != rx_moder->cq_period_mode) {
> -		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
> -		reset_rx = true;
> -	}
> +	/* DIM enable/disable Rx and Tx channels */
> +	err = mlx5e_channels_rx_change_dim(&priv->channels, rx_dim_enabled);
> +	if (err)
> +		goto state_unlock;
> +	err = mlx5e_channels_tx_change_dim(&priv->channels, tx_dim_enabled);
> +	if (err)
> +		goto state_unlock;

With a on-the-fly model, DIM enablement has to occur after any
moderation resets. Before, the ordering was less strict due to the need
to reset the channels (tear down and recreate).

>  
> -	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
> -	if (cq_period_mode != tx_moder->cq_period_mode) {
> -		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
> -		reset_tx = true;
> -	}
> +	/* Solely used for global ethtool get coalesce */
> +	rx_moder = &new_params.rx_cq_moderation;
> +	new_params.rx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_rx;
>  
> -	if (reset_rx) {
> -		u8 mode = MLX5E_GET_PFLAG(&new_params,
> -					  MLX5E_PFLAG_RX_CQE_BASED_MODER);
> +	tx_moder = &new_params.tx_cq_moderation;
> +	new_params.tx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_tx;
>  
> -		mlx5e_reset_rx_moderation(&new_params, mode);
> -	}
> -	if (reset_tx) {
> -		u8 mode = MLX5E_GET_PFLAG(&new_params,
> -					  MLX5E_PFLAG_TX_CQE_BASED_MODER);
> +	/* Only set coalesce parameters if DIM has been previously disabled */
> +	if (!rx_dim_enabled && !new_params.rx_dim_enabled) {
> +		rx_moder->usec = coal->rx_coalesce_usecs;
> +		rx_moder->pkts = coal->rx_max_coalesced_frames;
> +
> +		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
> +	} else if (!rx_dim_enabled || !new_params.rx_dim_enabled ||
> +		   reset_rx_dim_mode) {
> +		mlx5e_reset_rx_moderation(rx_moder, new_params.rx_moder_use_cqe_mode,
> +					  rx_dim_enabled);
>  
> -		mlx5e_reset_tx_moderation(&new_params, mode);
> +		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
>  	}

The conditional logic here can be greatly simplified for both the tx and
rx cases. We have done this for our next revision.

>  
> -	/* If DIM state hasn't changed, it's possible to modify interrupt
> -	 * moderation parameters on the fly, even if the channels are open.
> -	 */
> -	if (!reset_rx && !reset_tx && test_bit(MLX5E_STATE_OPENED, &priv->state)) {
> -		if (!coal->use_adaptive_rx_coalesce)
> -			mlx5e_set_priv_channels_rx_coalesce(priv, coal);
> -		if (!coal->use_adaptive_tx_coalesce)
> -			mlx5e_set_priv_channels_tx_coalesce(priv, coal);
> -		reset = false;
> +	if (!tx_dim_enabled && !new_params.tx_dim_enabled) {
> +		tx_moder->usec = coal->tx_coalesce_usecs;
> +		tx_moder->pkts = coal->tx_max_coalesced_frames;
> +
> +		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
> +	} else if (!tx_dim_enabled || !new_params.tx_dim_enabled ||
> +		   reset_tx_dim_mode) {
> +		mlx5e_reset_tx_moderation(tx_moder, new_params.tx_moder_use_cqe_mode,
> +					  tx_dim_enabled);
> +
> +		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
>  	}
>  
> -	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
> +	new_params.rx_dim_enabled = rx_dim_enabled;
> +	new_params.tx_dim_enabled = tx_dim_enabled;
>  
> +	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
> +state_unlock:
>  	mutex_unlock(&priv->state_lock);
>  	return err;
>  }
> @@ -1872,12 +1893,22 @@ static int set_pflag_cqe_based_moder(struct net_device *netdev, bool enable,
>  		return 0;
>  
>  	new_params = priv->channels.params;
> -	if (is_rx_cq)
> -		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
> -	else
> -		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
> +	if (is_rx_cq) {
> +		mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
> +						   false, true);
> +		mlx5e_channels_rx_toggle_dim(&priv->channels);
> +		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
> +				cq_period_mode);
> +	} else {
> +		mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
> +						   false, true);
> +		mlx5e_channels_tx_toggle_dim(&priv->channels);
> +		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
> +				cq_period_mode);
> +	}
>  
> -	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
> +	/* Update pflags of existing channels without resetting them */
> +	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
>  }
>  
>  static int set_pflag_tx_cqe_based_moder(struct net_device *netdev, bool enable)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 2ce87f918d3b..a24d58a2cf06 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -961,20 +961,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>  		}
>  	}
>  
> -	rq->dim = kvzalloc_node(sizeof(*rq->dim), GFP_KERNEL, node);
> -	if (!rq->dim) {
> -		err = -ENOMEM;
> -		goto err_unreg_xdp_rxq_info;
> -	}
> -
> -	rq->dim->priv = rq;
> -	INIT_WORK(&rq->dim->work, mlx5e_rx_dim_work);
> -	rq->dim->mode = params->rx_cq_moderation.cq_period_mode;
> -
>  	return 0;
>  
> -err_unreg_xdp_rxq_info:
> -	xdp_rxq_info_unreg(&rq->xdp_rxq);
>  err_destroy_page_pool:
>  	page_pool_destroy(rq->page_pool);
>  err_free_by_rq_type:
> @@ -1302,8 +1290,16 @@ int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
>  	if (MLX5_CAP_ETH(mdev, cqe_checksum_full))
>  		__set_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state);
>  
> -	if (params->rx_dim_enabled)
> -		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
> +	if (params->rx_dim_enabled) {
> +		u8 cq_period = params->tx_moder_use_cqe_mode ?

This needs to be rx_moder_use_cqe_mode.....

> +				       DIM_CQ_PERIOD_MODE_START_FROM_CQE :
> +				       DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> +
> +		mlx5e_reset_rx_moderation(&rq->channel->rx_moder.dim, cq_period, true);

The moderation reset need to occur independent of whether dim was
enabled or not.

> +		err = mlx5e_dim_rx_change(rq, true);
> +		if (err)
> +			goto err_destroy_rq;
> +	}
>  
>  	/* We disable csum_complete when XDP is enabled since
>  	 * XDP programs might manipulate packets which will render
> @@ -1349,7 +1345,8 @@ void mlx5e_deactivate_rq(struct mlx5e_rq *rq)
>  
>  void mlx5e_close_rq(struct mlx5e_rq *rq)
>  {
> -	cancel_work_sync(&rq->dim->work);
> +	if (rq->dim)
> +		cancel_work_sync(&rq->dim->work);
>  	cancel_work_sync(&rq->recover_work);
>  	mlx5e_destroy_rq(rq);
>  	mlx5e_free_rx_descs(rq);
> @@ -1624,20 +1621,9 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
>  	err = mlx5e_alloc_txqsq_db(sq, cpu_to_node(c->cpu));
>  	if (err)
>  		goto err_sq_wq_destroy;
> -	sq->dim = kvzalloc_node(sizeof(*sq->dim), GFP_KERNEL, cpu_to_node(c->cpu));
> -	if (!sq->dim) {
> -		err = -ENOMEM;
> -		goto err_free_txqsq_db;
> -	}
> -
> -	sq->dim->priv = sq;
> -	INIT_WORK(&sq->dim->work, mlx5e_tx_dim_work);
> -	sq->dim->mode = params->tx_cq_moderation.cq_period_mode;
>  
>  	return 0;
>  
> -err_free_txqsq_db:
> -	mlx5e_free_txqsq_db(sq);
>  err_sq_wq_destroy:
>  	mlx5_wq_destroy(&sq->wq_ctrl);
>  
> @@ -1802,11 +1788,21 @@ int mlx5e_open_txqsq(struct mlx5e_channel *c, u32 tisn, int txq_ix,
>  	if (tx_rate)
>  		mlx5e_set_sq_maxrate(c->netdev, sq, tx_rate);
>  
> -	if (params->tx_dim_enabled)
> -		sq->state |= BIT(MLX5E_SQ_STATE_DIM);
> +	if (params->tx_dim_enabled) {
> +		u8 cq_period = params->tx_moder_use_cqe_mode ?
> +				       DIM_CQ_PERIOD_MODE_START_FROM_CQE :
> +				       DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> +
> +		mlx5e_reset_tx_moderation(&sq->channel->tx_moder.dim, cq_period, true);

Same as Rx side comment.

> +		err = mlx5e_dim_tx_change(sq, true);
> +		if (err)
> +			goto err_destroy_sq;
> +	}
>  
>  	return 0;
>  
> +err_destroy_sq:
> +	mlx5e_destroy_sq(c->mdev, sq->sqn);
>  err_free_txqsq:
>  	mlx5e_free_txqsq(sq);
>  
> @@ -1858,7 +1854,8 @@ void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
>  	struct mlx5_core_dev *mdev = sq->mdev;
>  	struct mlx5_rate_limit rl = {0};
>  
> -	cancel_work_sync(&sq->dim->work);
> +	if (sq->dim)
> +		cancel_work_sync(&sq->dim->work);
>  	cancel_work_sync(&sq->recover_work);
>  	mlx5e_destroy_sq(mdev, sq->sqn);
>  	if (sq->rate_limit) {
> @@ -1877,6 +1874,58 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
>  	mlx5e_reporter_tx_err_cqe(sq);
>  }
>  
> +static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
> +{
> +	return (struct dim_cq_moder) {
> +		.cq_period_mode = cq_period_mode,
> +		.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS,
> +		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
> +				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE :
> +				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC,
> +	};
> +}
> +
> +bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
> +			       bool dim_enabled)
> +{
> +	bool reset_needed = dim_enabled && cq_moder->cq_period_mode != cq_period_mode;
> +
> +	if (dim_enabled)
> +		*cq_moder = net_dim_get_def_tx_moderation(cq_period_mode);
> +	else
> +		*cq_moder = mlx5e_get_def_tx_moderation(cq_period_mode);
> +
> +	return reset_needed;
> +}
> +
> +bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
> +					bool dim_enabled, bool keep_dim_state)
> +{
> +	bool reset = false;
> +	int i, tc;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
> +			if (keep_dim_state)
> +				dim_enabled = !!chs->c[i]->sq[tc].dim;
> +
> +			reset |= mlx5e_reset_tx_moderation(&chs->c[i]->tx_moder.dim,
> +							   cq_period_mode, dim_enabled);
> +		}
> +	}
> +
> +	if (chs->ptp) {
> +		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
> +			struct mlx5e_txqsq *txqsq = &chs->ptp->ptpsq[tc].txqsq;
> +
> +			mlx5e_reset_tx_moderation(&txqsq->channel->tx_moder.dim,
> +						  cq_period_mode, false);
> +		}
> +	}
> +
> +	return reset;
> +}
> +
>  static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params,
>  			    struct mlx5e_sq_param *param, struct mlx5e_icosq *sq,
>  			    work_func_t recover_work_func)
> @@ -2100,7 +2149,8 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
>  	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
>  				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
>  
> -	MLX5_SET(cqc,   cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
> +	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
> +
>  	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
>  	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
> @@ -2138,8 +2188,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
>  	if (err)
>  		goto err_free_cq;
>  
> -	if (MLX5_CAP_GEN(mdev, cq_moderation))
> -		mlx5_core_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts);
> +	if (MLX5_CAP_GEN(mdev, cq_moderation) &&
> +	    MLX5_CAP_GEN(mdev, cq_period_mode_modify))
> +		mlx5e_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts,
> +					   mlx5e_cq_period_mode(moder.cq_period_mode));
>  	return 0;
>  
>  err_free_cq:
> @@ -2154,6 +2206,40 @@ void mlx5e_close_cq(struct mlx5e_cq *cq)
>  	mlx5e_free_cq(cq);
>  }
>  
> +int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> +				u8 cq_period_mode)
> +{
> +	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
> +	void *cqc;
> +
> +	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
> +	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
> +	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(cq_period_mode));
> +	MLX5_SET(modify_cq_in, in,
> +		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
> +		 MLX5_CQ_MODIFY_PERIOD_MODE);
> +
> +	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
> +}
> +
> +int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
> +			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode)
> +{
> +	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
> +	void *cqc;
> +
> +	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
> +	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
> +	MLX5_SET(cqc, cqc, cq_period, cq_period);
> +	MLX5_SET(cqc, cqc, cq_max_count, cq_max_count);
> +	MLX5_SET(cqc, cqc, cq_period_mode, cq_period_mode);
> +	MLX5_SET(modify_cq_in, in,
> +		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
> +		 MLX5_CQ_MODIFY_PERIOD | MLX5_CQ_MODIFY_COUNT | MLX5_CQ_MODIFY_PERIOD_MODE);
> +
> +	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
> +}
> +
>  static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
>  			     struct mlx5e_params *params,
>  			     struct mlx5e_create_cq_param *ccp,
> @@ -3959,6 +4045,52 @@ static int set_feature_rx_all(struct net_device *netdev, bool enable)
>  	return mlx5_set_port_fcs(mdev, !enable);
>  }
>  
> +static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
> +{
> +	return (struct dim_cq_moder) {
> +		.cq_period_mode = cq_period_mode,
> +		.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS,
> +		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
> +				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE :
> +				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC,
> +	};
> +}
> +
> +bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
> +			       bool dim_enabled)
> +{
> +	bool reset_needed = dim_enabled &&
> +			    cq_moder->cq_period_mode != cq_period_mode;
> +
> +	if (dim_enabled)
> +		*cq_moder = net_dim_get_def_rx_moderation(cq_period_mode);
> +	else
> +		*cq_moder = mlx5e_get_def_rx_moderation(cq_period_mode);
> +
> +	return reset_needed;
> +}
> +
> +bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
> +					bool dim_enabled, bool keep_dim_state)
> +{
> +	bool reset = false;
> +	int i;
> +
> +	for (i = 0; i < chs->num; i++) {
> +		if (keep_dim_state)
> +			dim_enabled = !!chs->c[i]->rq.dim;
> +
> +		reset |= mlx5e_reset_rx_moderation(&chs->c[i]->rx_moder.dim,
> +						   cq_period_mode, dim_enabled);
> +	}
> +
> +	if (chs->ptp)
> +		mlx5e_reset_rx_moderation(&chs->ptp->rq.channel->rx_moder.dim,
> +					  cq_period_mode, false);
> +
> +	return reset;
> +}
> +
>  static int mlx5e_set_rx_port_ts(struct mlx5_core_dev *mdev, bool enable)
>  {
>  	u32 in[MLX5_ST_SZ_DW(pcmr_reg)] = {};
> @@ -5026,7 +5158,6 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
>  {
>  	struct mlx5e_params *params = &priv->channels.params;
>  	struct mlx5_core_dev *mdev = priv->mdev;
> -	u8 rx_cq_period_mode;
>  
>  	params->sw_mtu = mtu;
>  	params->hard_mtu = MLX5E_ETH_HARD_MTU;
> @@ -5060,12 +5191,16 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
>  	params->packet_merge.timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
>  
>  	/* CQ moderation params */
> -	rx_cq_period_mode =
> -		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
> -	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
> -	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
> -	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
> -	mlx5e_set_tx_cq_mode_params(params, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
> +	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
> +				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
> +	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
> +				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
> +	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
> +	params->tx_moder_use_cqe_mode = false;
> +	mlx5e_reset_rx_moderation(&params->rx_cq_moderation, params->rx_moder_use_cqe_mode,
> +				  params->rx_dim_enabled);
> +	mlx5e_reset_tx_moderation(&params->tx_cq_moderation, params->tx_moder_use_cqe_mode,
> +				  params->tx_dim_enabled);
>  
>  	/* TX inline */
>  	mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> index d38ae33440fc..92595ada1f70 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -806,9 +806,6 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
>  	struct mlx5_core_dev *mdev = priv->mdev;
>  	struct mlx5e_params *params;
>  
> -	u8 cq_period_mode =
> -		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
> -
>  	params = &priv->channels.params;
>  
>  	params->num_channels = MLX5E_REP_PARAMS_DEF_NUM_CHANNELS;
> @@ -836,7 +833,7 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
>  
>  	/* CQ moderation params */
>  	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
> -	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
> +	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
>  
>  	params->mqprio.num_tc       = 1;
>  	if (rep->vport != MLX5_VPORT_UPLINK)
> diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
> index cb15308b5cb0..991526039ccb 100644
> --- a/include/linux/mlx5/cq.h
> +++ b/include/linux/mlx5/cq.h
> @@ -95,9 +95,10 @@ enum {
>  };
>  
>  enum {
> -	MLX5_CQ_MODIFY_PERIOD	= 1 << 0,
> -	MLX5_CQ_MODIFY_COUNT	= 1 << 1,
> -	MLX5_CQ_MODIFY_OVERRUN	= 1 << 2,
> +	MLX5_CQ_MODIFY_PERIOD		= BIT(0),
> +	MLX5_CQ_MODIFY_COUNT		= BIT(1),
> +	MLX5_CQ_MODIFY_OVERRUN		= BIT(2),
> +	MLX5_CQ_MODIFY_PERIOD_MODE	= BIT(4),
>  };
>  
>  enum {
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index f7f1f058491f..ccb668303b03 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1668,7 +1668,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
>  	u8         cq_oi[0x1];
>  	u8         cq_resize[0x1];
>  	u8         cq_moderation[0x1];
> -	u8         reserved_at_223[0x3];
> +	u8         cq_period_mode_modify[0x1];
> +	u8         reserved_at_224[0x2];
>  	u8         cq_eq_remap[0x1];
>  	u8         pg[0x1];
>  	u8         block_lb_mc[0x1];

--
Thanks,

Rahul Rameshbabu

