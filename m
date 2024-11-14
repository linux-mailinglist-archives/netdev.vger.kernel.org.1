Return-Path: <netdev+bounces-145092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137E9C9578
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791941F21933
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9371AF0C2;
	Thu, 14 Nov 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DVcyRitx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428D19CC02
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624951; cv=none; b=RZpKl5kRs0CAEnWZ8pvbxn76kZLnai3Hfas7fkZAgQwqpfOvqFsZlZAyGu6tqEnd4PIhXr2XMEcnpg0PGrHldkB+mUZ6YrXXaqiypRgbnE4nXdSc2CqWIN2PBw4ebd1Hlw3t0Pi0/me1tb1mlaRopwQCIZue5oREBIUUh84dPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624951; c=relaxed/simple;
	bh=pQi0NfvT4rTsLRZv7GLZjpLohvM6f+7UhHs2FSuUqxI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsC6hJEacKNDADVthOoJZZLQ7v1ulIRIlsqNosWA+lQAQG0FwIGMSAtBtCQwQa518Rnj8FoEr6BP+433m/zPGvWO43gHNEAau4WFXYDNK6SNBj1MdkLmvGrTcMsFfKXkXZJmJt8H9XUTcPHApeyn5zFhQc3qm7wc1s6Jh2J3BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DVcyRitx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c767a9c50so13183225ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731624949; x=1732229749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwkbVNry/MkJaYGXY+KIOLUVk4ZrEaa+PmXpQAWprhA=;
        b=DVcyRitxasQRDaD65gSIciNqHKjkxXLRl9iKJhnH6w4Tmz+dmeqUmGSI3eVqyW+E87
         OCW9PlKUg/+o9kX/AIAXhusI9nDnMtzFuUZmBFswwW71ZLBOb3YhxJ0JmCIrAFrUjURX
         bBq+hkacdlCou5GlbzaVKUi9Hy7NFPSv2r040=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624949; x=1732229749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwkbVNry/MkJaYGXY+KIOLUVk4ZrEaa+PmXpQAWprhA=;
        b=N3y0sZzUfPrDLYP0+CrCJXP1ZdVlrqt1hGmb2c4K74+cPgmMt+7l5CT60C8LfnjFpz
         uehlQ/Ifd1isWDU/GusTZ6/axcmUfGz6IP52W/1KDuJ4vFTRrynr9Q1tOBPsvhT11ZbV
         OiPneOnujACkHLge0Q7VhHmuJuL/ySfW9gfAzXiD8KMVdJrl5CmX4uOvwD5tpAxHmtNR
         k+zFD/pnivU3OTpXM7t/tNagEl0GlkcKpKALLRxqWR0XIsg0iy2BJc6XC4/RxxBi2SMN
         o72icCQgyYppAtVkjKSD7Qz6oTA69rsM85MPM9xCNQm73lmsVULBuDwESIvkOkCRrdx9
         cquw==
X-Forwarded-Encrypted: i=1; AJvYcCWjrDUCEjtc/gIrlBBYjQnoFPvSxaRZWuDWDZa6ay3jmTsknI3mvWxtWJbSmDP4CID8C11oahU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywhn9lxgxmmmuTjR7UZAXJqDnkI9T7LA1dilh2O8b9kZHL8fUh
	gbibHUo9XiirTBrreao/XrPZ1qJile+FaSyf2Ih3mxQEZGMYUjkDZO/LdngeiQ==
X-Google-Smtp-Source: AGHT+IFXooU6VTLyV8MjoZJwDKo/XnnK1hZmojUPGrQWhz+4A05j4nRmgPKdwgS5zB7lk/VcxuYoSg==
X-Received: by 2002:a17:902:e74b:b0:20c:a175:1942 with SMTP id d9443c01a7336-211d0d72ab5mr9192525ad.24.1731624948568;
        Thu, 14 Nov 2024 14:55:48 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc2bf0sm1550495ad.41.2024.11.14.14.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:55:48 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 14 Nov 2024 17:55:41 -0500
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com,
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
	brett.creeley@amd.com, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org,
	jdamato@fastly.com, aleksander.lobakin@intel.com,
	kaiyuanz@google.com, willemb@google.com, daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 0/7] bnxt_en: implement tcp-data-split and
 thresh option
Message-ID: <ZzZ_7SMsVnC5Wc2y@JRM7P7Q02P>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>

On Wed, Nov 13, 2024 at 05:32:14PM +0000, Taehee Yoo wrote:
> This series implements header-data-split-thresh ethtool command.
> This series also implements backend of tcp-data-split and
> header-data-split-thresh ethtool command for bnxt_en driver.
> These ethtool commands are mandatory options for device memory TCP.
> 
> NICs that use the bnxt_en driver support tcp-data-split feature named
> HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and the HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows the rx-copybreak value but it wasn't
> changeable.
> 
> Currently, bnxt_en driver enables tcp-data-split by default but not
> always work.
> There is hds_threshold value, which indicates that a packet size is
> larger than this value, a packet will be split into header and data.
> hds_threshold value has been 256, which is a default value of
> rx-copybreak value too.
> The rx-copybreak value hasn't been allowed to change so the
> hds_threshold too.
> 
> This patchset decouples hds_threshold and rx-copybreak first.
> and make tcp-data-split, rx-copybreak, and
> header-data-split-thresh configurable independently.
> 
> But the default configuration is the same.
> The default value of rx-copybreak is 256 and default
> header-data-split-thresh is also 256.
> 
> There are several related options.
> TPA(HW-GRO, LRO), JUMBO, jumbo_thresh(firmware command), and Aggregation
> Ring.
> 
> The aggregation ring is fundamental to these all features.
> When gro/lro/jumbo packets are received, NIC receives the first packet
> from the normal ring.
> follow packets come from the aggregation ring.
> 
> These features are working regardless of HDS.
> If HDS is enabled, the first packet contains the header only, and the
> following packets contain only payload.
> So, HW-GRO/LRO is working regardless of HDS.
> 
> There is another threshold value, which is jumbo_thresh.
> This is very similar to hds_thresh, but jumbo thresh doesn't split
> header and data.
> It just split the first and following data based on length.
> When NIC receives 1500 sized packet, and jumbo_thresh is 256(default, but
> follows rx-copybreak),
> the first data is 256 and the following packet size is 1500-256.
> 
> Before this patch, at least if one of GRO, LRO, and JUMBO flags is
> enabled, the Aggregation ring will be enabled.
> If the Aggregation ring is enabled, both hds_threshold and
> jumbo_thresh are set to the default value of rx-copybreak.
> 
> So, GRO, LRO, JUMBO frames, they larger than 256 bytes, they will
> be split into header and data if the protocol is TCP or UDP.
> for the other protocol, jumbo_thresh works instead of hds_thresh.
> 
> This means that tcp-data-split relies on the GRO, LRO, and JUMBO flags.
> But by this patch, tcp-data-split no longer relies on these flags.
> If the tcp-data-split is enabled, the Aggregation ring will be
> enabled.
> Also, hds_threshold no longer follows rx-copybreak value, it will
> be set to the header-data-split-thresh value by user-space, but the
> default value is still 256.
> 
> If the protocol is TCP or UDP and the HDS is disabled and Aggregation
> ring is enabled, a packet will be split into several pieces due to
> jumbo_thresh.
> 
> When single buffer XDP is attached, tcp-data-split is automatically
> disabled.
> 
> LRO, GRO, and JUMBO are tested with BCM57414, BCM57504 and the firmware
> version is 230.0.157.0.
> I couldn't find any specification about minimum and maximum value
> of hds_threshold, but from my test result, it was about 0 ~ 1023.
> It means, over 1023 sized packets will be split into header and data if
> tcp-data-split is enabled regardless of hds_treshold value.
> When hds_threshold is 1500 and received packet size is 1400, HDS should
> not be activated, but it is activated.
> The maximum value of header-data-split-thresh value is 256 because it
> has been working. It was decided very conservatively.
> 
> I checked out the tcp-data-split(HDS) works independently of GRO, LRO,
> JUMBO.
> Also, I checked out tcp-data-split should be disabled automatically
> when XDP is attached and disallowed to enable it again while XDP is
> attached. I tested ranged values from min to max for
> header-data-split-thresh and rx-copybreak, and it works.
> header-data-split-thresh from 0 to 256, and rx-copybreak 0 to 256.
> When testing this patchset, I checked skb->data, skb->data_len, and
> nr_frags values.
> 
> By this patchset, bnxt_en driver supports a force enable tcp-data-split,
> but it doesn't support for disable tcp-data-split.
> When tcp-data-split is explicitly enabled, HDS works always.
> When tcp-data-split is unknown, it depends on the current
> configuration of LRO/GRO/JUMBO.
> 
> 1/7 patch implements .{set, get}_tunable() in the bnxt_en.
> The bnxt_en driver has been supporting the rx-copybreak feature but is
> not configurable, Only the default rx-copybreak value has been working.
> So, it changes the bnxt_en driver to be able to configure
> the rx-copybreak value.
> 
> 2/7 patch adds a new tcp_data_split_mod member in the
> kernel_ethtool_ringparam
> It indicates that user is explicitly set the tcp-data-split.
> So the driver can distinguish a passed tcp-data-split value is
> came from user or driver itself.
> 
> 3/7 patch adds an implementation of tcp-data-split ethtool
> command.
> The HDS relies on the Aggregation ring, which is automatically enabled
> when either LRO, GRO, or large mtu is configured.
> So, if the Aggregation ring is enabled, HDS is automatically enabled by
> it.
> 
> 4/7 patch adds header-data-split-thresh command in the ethtool.
> This threshold value indicates if a received packet size is larger
> than this threshold, the packet's header and payload will be split.
> Example:
>    # ethtool -G <interface name> header-data-split-thresh <value>
> This option can not be used when tcp-data-split is disabled or not
> supported.
>    # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    Header data split thresh:  256
> 
> 5/7 patch adds the implementation of header-data-split-thresh logic
> in the bnxt_en driver.
> The default value is 256, which used to be the default rx-copybreak
> value.
> 
> 6/7, 7/7 add condition checks for devmem and ethtool.
> If tcp-data-split is disabled or threshold value is not zero, setup of
> devmem will be failed.
> Also, tcp-data-split and header-data-split-thresh will not be changed
> while devmem is running.
> 
> This series is tested with BCM57504.
> 
> All necessary configuration validations exist at the core API level.
> 
> v5:
>  - Drop implementation of device memory TCP for bnxt_en.
>  - Remove netdev_devmem_enabled() and use dev_get_min_mp_channel_count()
>    instead.
>  - change extack messages
>  - Add Review tags from Mina.
> 
> v4:
>  - Remove min rx-copybreak value.
>  - Do not support a disable of tcp-data-split by bnxt_en driver.
>  - Rename from tcp-data-split-thresh to header-data-split-thresh.
>  - Add ETHTOOL_RING_USE_HDS_THRS flag.
>  - Add dev_xdp_sb_prog_count() helper.
>  - Reduce hole in struct bnxt.
>  - Use ETHTOOL_RING_USE_HDS_THRS in bnxt_en driver.
>  - Improve condition check.
>  - Add netdev_devmem_enabled() helper.
>  - Add netmem_is_pfmemalloc() helper.
>  - Do not select NET_DEVMEM in Kconfig for bnxt_en driver.
>  - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
>  - Use gfp flag in __bnxt_alloc_rx_netmem() in the last patch.
>  - Do not add *offset in the __bnxt_alloc_rx_netmem() in the last patch.
>  - Do not pass queue_idx to bnxt_alloc_rx_page_pool() in the last patch.
>  - Add Test tag from Stanislav.
>  - Add Review tag from Brett.
>  - Add page_pool_recycle_direct_netmem() helper
> 
> v3:
>  - Change headline
>  - Add condition checks for ethtool and devmem
>  - Fix documentation
>  - Move validation of tcp-data-split and thresh from dirver to core API
>  - Add implementation of device memory TCP for bnxt_en driver
> 
> v2:
>  - Add tcp-data-split-thresh ethtool command
>  - Implement tcp-data-split-threh in the bnxt_en driver
>  - Define min/max rx-copybreak value
>  - Update commit message
> 
> Taehee Yoo (7):
>   bnxt_en: add support for rx-copybreak ethtool command
>   net: ethtool: add tcp_data_split_mod member in
>     kernel_ethtool_ringparam
>   bnxt_en: add support for tcp-data-split ethtool command
>   net: ethtool: add support for configuring header-data-split-thresh
>   bnxt_en: add support for header-data-split-thresh ethtool command
>   net: devmem: add ring parameter filtering
>   net: ethtool: add ring parameter filtering
> 
>  Documentation/netlink/specs/ethtool.yaml      |  8 ++
>  Documentation/networking/ethtool-netlink.rst  | 79 ++++++++++++-------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 31 +++++---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 12 ++-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 73 ++++++++++++++++-
>  include/linux/ethtool.h                       |  8 ++
>  include/linux/netdevice.h                     |  1 +
>  include/uapi/linux/ethtool_netlink.h          |  2 +
>  net/core/dev.c                                | 13 +++
>  net/core/devmem.c                             | 18 +++++
>  net/ethtool/netlink.h                         |  2 +-
>  net/ethtool/rings.c                           | 53 ++++++++++++-
>  12 files changed, 250 insertions(+), 50 deletions(-)
> 

Series looks good to me and testing also looks good.  Thanks for doing this!



