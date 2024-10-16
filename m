Return-Path: <netdev+bounces-136289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2FF9A13AB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E01C21DB7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27A18BC33;
	Wed, 16 Oct 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtUyIIFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCF21E3C2;
	Wed, 16 Oct 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109851; cv=none; b=T9tluZgI1ZZgKiTFWj01tOlb7/orj9Jul8nU4Byqxp0JMu+rsUS+mijBRkPenMHl5gumKPqoCp66d+TY5LOJ8Xc7t7Fme+AxEP9ionOTE+xfWuzsHNia8SdG0Lw3CvSXZ5T94UAcpwucsD/Crohe7rirueuT44ODIycbeyHTUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109851; c=relaxed/simple;
	bh=7ZSavL1eTbrOwlaZ4LSkgBdHzgDhTau3TE/FHf5ZDzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOO4iM30ITQJ3bDLCLAebhLEnqxp5dd6XlaOviLoSHMxnIcmxjhdfI0OiA0SK3buVEC5M+9P0huZvdu2qVt40K8c5KGpN7FOi/gkIvfG3zF37kr/r04UGENQtjZuX44JWs1lrv7qV+DfZUYcBasHFi0J0JmOp/6Wd7ZJwffqadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtUyIIFu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so158899a91.0;
        Wed, 16 Oct 2024 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109849; x=1729714649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hB6pneLlgNQzre4Tw2gjYdHzpO9RAcsl0x9aZ2GOgvQ=;
        b=KtUyIIFuZRFVadhTxauVctBhWXc5lTYIxDfV+f8qJRuNVXk7yOSrSW7uq5/V8RhQVb
         k/uEvoz9uR2vNBWtx2IgAZnLVDLJmlsqGuQVPXqfo8qY6NbQB7jvgAkEH+1O4S3gEFeW
         8dT5p16N1UOmHAdQwM8tW7CAalabU8pHjdDAnDKJzH4ZFTwjh7zGCHLpAQwqP4lN5Z+7
         TbKPLr7aBXsQXnNvGXQ5INnPatBnIW6ohJh9d7B3Lbij0qCo8LTYe2Rliy1/MlyiEYbO
         IZ4vZkNburYZU4lMF2O+7YMJLZaHmNE8dy68EvV3MToGpUlCfq/RFSya/EQpA4L+p3Og
         2R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109849; x=1729714649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB6pneLlgNQzre4Tw2gjYdHzpO9RAcsl0x9aZ2GOgvQ=;
        b=WQgc+m3xDceTtaerBwJDJW7KmO44r/uNFjiVfhFlGc2ZOlmivQoKL3BdE33VhgkB+U
         u0OmiK+j49Ng5NHOhO6HcjpdY0tKDFqEWbC07aUA9sYH61nhSpRIpmoyqcOmihRTB1JT
         +D2eDWgANzD3wyw2SDSJk92u00xBxJDXGOlDLvfPjwivzhbIYwLajsFeel1FReD2muDD
         fcxo5w4HqThTnz/o67U5aQtLJbnG5SdtxGtPh5m/WcZV5RINPE3AgQDx11JlR/Z2jeOE
         uJsO4lTfaw0s1nV88CruPSjp2efcL/RhxLsx8m2mBglugVgbrQIgMl3dUADAy+ljUMZd
         GZZg==
X-Forwarded-Encrypted: i=1; AJvYcCU5q1v573hqHJ8Y9uJGy2IAHU4uumH+Nc8+vJxWb62qV4I31M+2/MTddEk11U2GojpSDOdCg0hv@vger.kernel.org, AJvYcCWChMtxlwEHaDwv/6PxzeaIqLmMsfWIMMortLpQu0JbipU25ZW7oAve58WSs8+upthOFSnz8Ho7m0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaF/BH/EWCoaqjYDWAq2IlkBsn0KZe38ro2jqr+GJsM8qmisCy
	23XCbLVrjYDmvYChTk9aiCARqMR1YfQ6qWaNrDSzF0OJnNRbJ08=
X-Google-Smtp-Source: AGHT+IED/LREZx07y8pqtU1+A2EgGHBRDYlp8650mlTIwjfsJE38xrBnvDfPTqfy0Rt4x/qwFDtGxA==
X-Received: by 2002:a17:90b:4b50:b0:2e2:e086:f5c0 with SMTP id 98e67ed59e1d1-2e3dc20b181mr1289711a91.5.1729109849316;
        Wed, 16 Oct 2024 13:17:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08c0484sm224646a91.13.2024.10.16.13.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:17:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:17:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
	michael.chan@broadcom.com, kory.maincent@bootlin.com,
	andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com, idosch@nvidia.com, asml.silence@gmail.com,
	kaiyuanz@google.com, willemb@google.com,
	aleksander.lobakin@intel.com, dw@davidwei.uk,
	sridhar.samudrala@intel.com, bcreeley@amd.com
Subject: Re: [PATCH net-next v3 0/7] bnxt_en: implement device memory TCP for
 bnxt
Message-ID: <ZxAfWHk3aRWl-F31@mini-arch>
References: <20241003160620.1521626-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>

On 10/03, Taehee Yoo wrote:
> This series implements device memory TCP for bnxt_en driver and
> necessary ethtool command implementations.
> 
> NICs that use the bnxt_en driver support tcp-data-split feature named
> HDS(header-data-split).
> But there is no implementation for the HDS to enable/disable by ethtool.
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
> tcp-data-split-thresh(hds_threshold) configurable independently.
> 
> But the default configuration is the same.
> The default value of rx-copybreak is 256 and default
> tcp-data-split-thresh is also 256.
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
> When TPA is enabled and HDS is disabled, the first packet contains
> header and payload too.
> and the following packets contain payload only.
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
> be set to the tcp-data-split-thresh value by user-space, but the
> default value is still 256.
> 
> If the protocol is TCP or UDP and the HDS is disabled and Aggregation
> ring is enabled, a packet will be split into several pieces due to
> jumbo_thresh.
> 
> When XDP is attached, tcp-data-split is automatically disabled.
> 
> LRO, GRO, and JUMBO are tested with BCM57414, BCM57504 and the firmware
> version is 230.0.157.0.
> I couldn't find any specification about minimum and maximum value
> of hds_threshold, but from my test result, it was about 0 ~ 1023.
> It means, over 1023 sized packets will be split into header and data if
> tcp-data-split is enabled regardless of hds_treshold value.
> When hds_threshold is 1500 and received packet size is 1400, HDS should
> not be activated, but it is activated.
> The maximum value of hds_threshold(tcp-data-split-thresh)
> value is 256 because it has been working.
> It was decided very conservatively.
> 
> I checked out the tcp-data-split(HDS) works independently of GRO, LRO,
> JUMBO. Tested GRO/LRO, JUMBO with enabled HDS and disabled HDS.
> Also, I checked out tcp-data-split should be disabled automatically
> when XDP is attached and disallowed to enable it again while XDP is
> attached. I tested ranged values from min to max for
> tcp-data-split-thresh and rx-copybreak, and it works.
> tcp-data-split-thresh from 0 to 256, and rx-copybreak 65 to 256.
> When testing this patchset, I checked skb->data, skb->data_len, and
> nr_frags values.
> 
> The first patch implements .{set, get}_tunable() in the bnxt_en.
> The bnxt_en driver has been supporting the rx-copybreak feature but is
> not configurable, Only the default rx-copybreak value has been working.
> So, it changes the bnxt_en driver to be able to configure
> the rx-copybreak value.
> 
> The second patch adds an implementation of tcp-data-split ethtool
> command.
> The HDS relies on the Aggregation ring, which is automatically enabled
> when either LRO, GRO, or large mtu is configured.
> So, if the Aggregation ring is enabled, HDS is automatically enabled by
> it.
> 
> The third patch adds tcp-data-split-thresh command in the ethtool.
> This threshold value indicates if a received packet size is larger
> than this threshold, the packet's header and payload will be split.
> Example:
>    # ethtool -G <interface name> tcp-data-split-thresh <value>
> This option can not be used when tcp-data-split is disabled or not
> supported.
>    # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    Current hardware settings:
>    ...
>    TCP data split:         on
>    TCP data split thresh:  256
> 
>    # ethtool -G enp14s0f0np0 tcp-data-split off
>    # ethtool -g enp14s0f0np0
>    Ring parameters for enp14s0f0np0:
>    Pre-set maximums:
>    ...
>    Current hardware settings:
>    ...
>    TCP data split:         off
>    TCP data split thresh:  n/a
> 
> The fourth patch adds the implementation of tcp-data-split-thresh logic
> in the bnxt_en driver.
> The default value is 256, which used to be the default rx-copybreak
> value.
> 
> The fifth and sixth adds condition check for devmem and ethtool.
> If tcp-data-split is disabled or threshold value is not zero, setup of
> devmem will be failed.
> Also, tcp-data-split and tcp-data-split-thresh will not be changed
> while devmem is running.
> 
> The last patch implements device memory TCP for bnxt_en driver.
> It usually converts generic page_pool api to netmem page_pool api.
> 
> No dependencies exist between device memory TCP and GRO/LRO/MTU.
> Only tcp-data-split and tcp-data-split-thresh should be enabled when the
> device memory TCP.
> While devmem TCP is set, tcp-data-split and tcp-data-split-thresh can't
> be updated because core API disallows change.
> 
> I tested the interface up/down while devmem TCP running. It works well.
> Also, channel count change, and rx/tx ringsize change tests work well too.
> 
> The devmem TCP test NIC is BCM57504

[..]

> All necessary configuration validations exist at the core API level.
> 
> Note that by this patch, the setup of device memory TCP would fail.
> Because tcp-data-split-thresh command is not supported by ethtool yet.
> The tcp-data-split-thresh should be 0 for setup device memory TCP and
> the default of bnxt is 256.
> So, for the bnxt, it always fails until ethtool supports
> tcp-data-split-thresh command.
> 
> The ncdevmem.c will be updated after ethtool supports
> tcp-data-split-thresh option.

FYI, I've tested your series with BCM57504 on top of [1] and [2] with
a couple of patches to make ncdevmem.c and TX work (see below). [1]
decouples ncdevmem from ethtool so we can flip header split settings
without requiring recent ethtool. Both RX and TX work perfectly.
Feel free to carry:

Tested-by: Stanislav Fomichev <sdf@fomichev.me>

Also feel free to take over the ncdevmem patch if my ncdevmem changes
get pulled before your series.

1: https://lore.kernel.org/netdev/20241009171252.2328284-1-sdf@fomichev.me/
2: https://lore.kernel.org/netdev/20240913150913.1280238-1-sdf@fomichev.me/

commit 69bc0e247eb4132ef5fd0b118719427d35d462fc
Author:     Stanislav Fomichev <sdf@fomichev.me>
AuthorDate: Tue Oct 15 15:56:43 2024 -0700
Commit:     Stanislav Fomichev <sdf@fomichev.me>
CommitDate: Wed Oct 16 13:13:42 2024 -0700

    selftests: ncdevmem: Set header split threshold to 0
    
    Needs to happen on BRCM to allow devmem to be attached.
    
    Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 903dac3e61d5..6a94d52a6c43 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -322,6 +322,8 @@ static int configure_headersplit(bool on)
 	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
 	/* 0 - off, 1 - auto, 2 - on */
 	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	if (enable)
+		ethtool_rings_set_req_set_tcp_data_split_thresh(req, 0);
 	ret = ethtool_rings_set(ys, req);
 	if (ret < 0)
 		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);


commit ef5ba647bc94a19153c2c5cfc64ebe4cb86ac58d
Author:     Stanislav Fomichev <sdf@fomichev.me>
AuthorDate: Fri Oct 11 13:52:03 2024 -0700
Commit:     Stanislav Fomichev <sdf@fomichev.me>
CommitDate: Wed Oct 16 13:13:42 2024 -0700

    bnxt_en: support tx device memory
    
    The only change is to not unmap the frags on completions.
    
    Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..cb22707a35aa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -692,7 +692,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto tx_dma_error;
 
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_addr_set(tx_buf, mapping, mapping);
+		if (netmem_is_net_iov(frag->netmem))
+			dma_unmap_addr_set(tx_buf, mapping, 0);
+		else
+			dma_unmap_addr_set(tx_buf, mapping, mapping);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -749,9 +752,10 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < last_frag; i++) {
 		prod = NEXT_TX(prod);
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
-		dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
-			       DMA_TO_DEVICE);
+		if (dma_unmap_addr(tx_buf, mapping))
+			dma_unmap_page(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
+				       skb_frag_size(&skb_shinfo(skb)->frags[i]),
+				       DMA_TO_DEVICE);
 	}
 
 tx_free:
@@ -821,11 +825,12 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		for (j = 0; j < last; j++) {
 			cons = NEXT_TX(cons);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-			dma_unmap_page(
-				&pdev->dev,
-				dma_unmap_addr(tx_buf, mapping),
-				skb_frag_size(&skb_shinfo(skb)->frags[j]),
-				DMA_TO_DEVICE);
+			if (dma_unmap_addr(tx_buf, mapping))
+				dma_unmap_page(
+					&pdev->dev,
+					dma_unmap_addr(tx_buf, mapping),
+					skb_frag_size(&skb_shinfo(skb)->frags[j]),
+					DMA_TO_DEVICE);
 		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
@@ -3296,10 +3301,11 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 				skb_frag_t *frag = &skb_shinfo(skb)->frags[k];
 
 				tx_buf = &txr->tx_buf_ring[ring_idx];
-				dma_unmap_page(
-					&pdev->dev,
-					dma_unmap_addr(tx_buf, mapping),
-					skb_frag_size(frag), DMA_TO_DEVICE);
+				if (dma_unmap_addr(tx_buf, mapping))
+					dma_unmap_page(
+						&pdev->dev,
+						dma_unmap_addr(tx_buf, mapping),
+						skb_frag_size(frag), DMA_TO_DEVICE);
 			}
 			dev_kfree_skb(skb);
 		}

