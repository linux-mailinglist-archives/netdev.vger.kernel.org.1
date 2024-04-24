Return-Path: <netdev+bounces-90928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7E8B0B5D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086D82895C2
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591515DBB6;
	Wed, 24 Apr 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OU+6vYiS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BE15B996;
	Wed, 24 Apr 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966124; cv=none; b=A1ZTY/cGlUQUm/wGAJz3ao13AZ7EYMbITOqhbwG35U+IfVXLecRspW+fetRVfERVTSkvYaTzbHnWhiSUCUm5LBh247aICNkgs1OXDkHf0Ga8pmjHQVpMlKZ6rWG6C3NTG/6n/F4KgBt/aOiTwxsLz8FkeiRa2PuSNjkwO+N/aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966124; c=relaxed/simple;
	bh=rrZsnurN2lp28BVC8byqxuCrybg8sBrrD3JJzUbAlSY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cKMWQhkBxdImkHaYyVdjsaHVe6opK7nE3EnyGKAZ30NWJRrhRjwg4vcfmZGoFabkJBn5BD7GnFHsTG6mamjgUiUTc38Yk73JI6vNOHbylo8zO8Ygh0NG/dwbw0xncD8t2cDPCY/xCSctS1rFfIHWnvVIx+hdCz/cYACbJYlUm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OU+6vYiS; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713966119; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=qgtM1XNFzGdNqCgGmrJVVlgJuWiBxEzztMH+49GuydI=;
	b=OU+6vYiSlI6eHnRTMsyjrwmdrqAy3qVdsSzfjhkb8smvQirnqG89QVSgoG9IzwURy7eXX5MHD9iPwTwPy6ZXkGP1koWdrK1zDeN8XefFQxC3/ItEh+9MirLczYFgPQMmonLrW0lOoN5vbQPZDMLPgH2kY+0s8SByyqHOoBeDKhU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W5COIx6_1713966116;
Received: from 30.221.148.255(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5COIx6_1713966116)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 21:41:57 +0800
Message-ID: <640292b7-5fcd-44c2-bdd1-03702b7e60a1@linux.alibaba.com>
Date: Wed, 24 Apr 2024 21:41:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
 <20240418174843.492078d5@kernel.org>
 <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
In-Reply-To: <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>> +++ b/include/linux/ethtool.h
>>> @@ -284,7 +284,11 @@ bool 
>>> ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
>>>   #define ETHTOOL_COALESCE_TX_AGGR_MAX_BYTES    BIT(24)
>>>   #define ETHTOOL_COALESCE_TX_AGGR_MAX_FRAMES    BIT(25)
>>>   #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS    BIT(26)
>>> -#define ETHTOOL_COALESCE_ALL_PARAMS        GENMASK(26, 0)
>>> +#define ETHTOOL_COALESCE_RX_EQE_PROFILE         BIT(27)
>>> +#define ETHTOOL_COALESCE_RX_CQE_PROFILE         BIT(28)
>>> +#define ETHTOOL_COALESCE_TX_EQE_PROFILE         BIT(29)
>>> +#define ETHTOOL_COALESCE_TX_CQE_PROFILE         BIT(30)
>>> +#define ETHTOOL_COALESCE_ALL_PARAMS        GENMASK(30, 0)
>> I think it's better to add these to netdev_ops, see below.


When modified according to v9's advice, I have the following structure, 
functions and ops:

+#define DIM_PROFILE_RX         BIT(0)  /* support rx dim profile 
modification */
+#define DIM_PROFILE_TX         BIT(1)  /* support tx dim profile 
modification */
+
+#define DIM_COALESCE_USEC      BIT(0)  /* support usec field 
modification */
+#define DIM_COALESCE_PKTS      BIT(1)  /* support pkts field 
modification */
+#define DIM_COALESCE_COMPS     BIT(2)  /* support comps field 
modification */
+
+struct dim_irq_moder {
+       /* See DIM_PROFILE_* */
+       u8 profile_flags;
+
+       /* See DIM_COALESCE_* for Rx and Tx */
+       u8 coal_flags;
+
+       /* Rx DIM period count mode: CQE or EQE */
+       u8 dim_rx_mode;
+
+       /* Tx DIM period count mode: CQE or EQE */
+       u8 dim_tx_mode;
+
+       /* DIM profile list for Rx */
+       struct dim_cq_moder *rx_profile;
+
+       /* DIM profile list for Tx */
+       struct dim_cq_moder *tx_profile;
+
+       /* Rx DIM worker function scheduled by net_dim() */
+       void (*rx_dim_work)(struct work_struct *work);
+
+       /* Tx DIM worker function scheduled by net_dim() */
+       void (*tx_dim_work)(struct work_struct *work);
+};
+

.....


+       .ndo_init_irq_moder     = virtnet_init_irq_moder,

....


+static int virtnet_init_irq_moder(struct net_device *dev)
+{
+        struct virtnet_info *vi = netdev_priv(dev);
+        struct dim_irq_moder *moder;
+        int len;
+
+        if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+                return 0;
+
+        dev->irq_moder = kzalloc(sizeof(*dev->irq_moder), GFP_KERNEL);
+        if (!dev->irq_moder)
+                goto err_moder;
+
+        moder = dev->irq_moder;
+        len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*moder->rx_profile);
+
+        moder->profile_flags |= DIM_PROFILE_RX;
+        moder->coal_flags |= DIM_COALESCE_USEC | DIM_COALESCE_PKTS;
+        moder->dim_rx_mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
+        moder->rx_dim_work = virtnet_rx_dim_work;
+
+        moder->rx_profile = kmemdup(dim_rx_profile[moder->dim_rx_mode],
+                                   len, GFP_KERNEL);
+        if (!moder->rx_profile)
+                goto err_profile;
+
+        return 0;
+
+err_profile:
+        kfree(moder);
+err_moder:
+        return -ENOMEM;
+}
+

......

+void net_dim_setting(struct net_device *dev, struct dim *dim, bool is_tx)
+{
+       struct dim_irq_moder *irq_moder = dev->irq_moder;
+
+       if (!irq_moder)
+               return;
+
+       if (is_tx) {
+               INIT_WORK(&dim->work, irq_moder->tx_dim_work);
+               dim->mode = irq_moder->dim_tx_mode;
+               return;
+       }
+
+       INIT_WORK(&dim->work, irq_moder->rx_dim_work);
+       dim->mode = irq_moder->dim_rx_mode;
+}

.....

+       for (i = 0; i < vi->max_queue_pairs; i++)
+               net_dim_setting(vi->dev, &vi->rq[i].dim, false);

.....

     ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,          /* u32 */

     ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,           /* u32 */

+ /* nest - _A_PROFILE_IRQ_MODERATION */

+  ETHTOOL_A_COALESCE_RX_PROFILE,

+   /* nest - _A_PROFILE_IRQ_MODERATION */
+  ETHTOOL_A_COALESCE_TX_PROFILE,

......


Almost clear implementation, but the only problem is when I want to

reuse "ethtool -C" and append ETHTOOL_A_COALESCE_RX_PROFILE

and ETHTOOL_A_COALESCE_TX_PROFILE, *ethnl_set_coalesce_validate()

will report an error because there are no ETHTOOL_COALESCE_RX_PROFILE

and ETHTOOL_COALESCE_TX_PROFILE, because they are replaced by

DIM_PROFILE_RX and DIM_PROFILE_TX in the field profile_flags.*


Should I reuse ETHTOOL_COALESCE_RX_PROFILE and

ETHTOOL_A_COALESCE_TX_PROFILE in ethtool_ops->.supported_coalesce_params

and remove the field profile_flags from struct dim_irq_moder?

Or let ethnl_set_coalesce_validate not verify these two flags?

Is there a better solution?


Thanks!



