Return-Path: <netdev+bounces-234772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B33C271F3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79E1E351724
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD432ABEF;
	Fri, 31 Oct 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eCBQhnuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAF2E889C
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949670; cv=none; b=SYKDYKQVF98qA/0bwvPZ3rrCW+PIY4ylXTwf3rwYsh8eqsHanuiGRqbQ7n8OyDeO+9APKf/XIPVVvh1AA8Kg3JIDJyiJcphSEuANgG4zMq925EG7SCqhHt8O3R52QBajSBn20MGflmxwsBqvLFRWn7kvSb4/4QbVgWeZApgX2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949670; c=relaxed/simple;
	bh=P8BdOeLeLkziClh4TYcx9Dks+BtMVmaR8E0yMh0gg48=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ktHO3QakoVYIODlqIdKTjW8unnERWtYbBBYQNewCqVw1s1mRWIkEIA2I5bhxk6iKYSggpV/5p4eVK+CW58JwRJNJakPLqEdam/DasmwwIkAPxFq80mfeM/kybAhkltzVmzoj3blwUZQ74jSYMLkGOYN+mrWtNngN/i6PdE2KJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eCBQhnuG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ecae310df8so42084741cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761949666; x=1762554466; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhH+adm3hPLIxGUF9gXdn1TePvtzXQPFSGMvNJTNtTc=;
        b=eCBQhnuG6dEgyTNHhL1kkOJXzVkP+j7xxCCln3AHqu8Lpp1Cw1sOWriAq3sfk7O8fA
         fkaG6e51R4YO5UsZZCHCHyOmW52SggWCzaDGOq58rcczw+tq8CkC4UcaSskH4qBwl3Fw
         lI1clF69hMDP2XcCbc+jTkQjSEtwVoBlST7fx5n4N2sRsEEvj9/1j+CykM8MrnnUBPhP
         JCtse5hDLu3/SIjIkVePOukIdsWdR98uva0H3velS3nqb/b0jh/qN/Zuy6U4rWPtW82v
         cEqXOypPB9OxDfzHzzaYiUH1R1L3R5pdKWUKSWmN2FZCLg6P+lL4WJpXK9BDVVGkLQbg
         Cw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761949666; x=1762554466;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IhH+adm3hPLIxGUF9gXdn1TePvtzXQPFSGMvNJTNtTc=;
        b=Wq8vgdwEMdp1V2qFG15LD6S2Z+JRTgE/Hed1dRd5rvTwa/RD6+zeNTfkenPLbBO/Kp
         gWP+gQs2HZwn1J833IM4hyuZ0yKOFFVNUhqVDQpX6exgukVUJK6F/bNlxfgNHdBXCeGQ
         rD/ieVvkkc9WhIbbgcWDnXaeAzzYFWKb+B4U6I/7ors+q82aBT92yFYQDMeTEliJLg7/
         sY7XtxG7MdnC9VRPN1Dgpboix87HGb9i7FpQTRLB+M9mrRIAsb+eONMFoR6Fueabr/yt
         zJqqVk725xDA5oFH0AUOHcM1AzFGCajw5Sc3NtT0CUiq5w9S1fQScRsNn3qij1jqYF8f
         fYFA==
X-Gm-Message-State: AOJu0YzE7q//Vj9DbTSy33vWwxh0Kbkkk33KX7VXzGrWpJXQU19mc3M2
	XuwC+60jxz2e3aT5xeqDP2jqQuuO8xJQytC143vQfHG7DXO99sKEAHaJuG4F+KQ47uFa+ZTj7It
	VvxT7
X-Gm-Gg: ASbGncsGzkozhymCi7fFmgJi/i5BsbDWSFBNrKx1JEnhiOev0uDqi50UQ7863JZrps9
	SK/VG30seZ0mE58M2ZAHOS1fJSwQgRKmlEio23KF5dzo78DxsgVBwnMKUJJQlhIFYST319K8oQh
	KBcaBZY3wGTm0sH3h2z2hITioSSPh3U32jP1V3O/Dctvv5WM8Lgj/Yvj+jphJ2EHP9LbYHJc12t
	/+eD4ypdbplSbNzOj8rLpUCD6CgRF+NZLPJBqgMxkj003MS7Dx6dS+osgJ7qcp6PtmD+ryLt+qP
	rtvM5p2qqcUzJH30J/QzRPmzAycA9w0RHKh9glBSMlaCTO2527Mym14Q1782puJQNiKmnN8RctO
	ojR7wwqsH3CyR0GjveCVkUhlNkP2Y/RXOWWxcUgeiA7Cc0+4O//h/IJMq9c4Kg14xo/WRjOpo9l
	7u4ThNNfeui6JsTyg5T7TIXJs/pzWjCHDbIXM=
X-Google-Smtp-Source: AGHT+IHKSV6S/+Xj1L6SEx+w42HEjS6DpurLR9Drxnkgd3+sKS/MbstOINZac3XO8SfbgPRFbHVAvQ==
X-Received: by 2002:a05:622a:2285:b0:4ec:462f:4416 with SMTP id d75a77b69052e-4ed30df83a9mr64384861cf.30.1761949666178;
        Fri, 31 Oct 2025 15:27:46 -0700 (PDT)
Received: from [10.73.214.168] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed4062133dsm6888951cf.9.2025.10.31.15.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:27:44 -0700 (PDT)
Message-ID: <3bb18dc2-a61f-4ecc-b1a6-c45e5c12fa51@bytedance.com>
Date: Fri, 31 Oct 2025 15:27:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com, hkelam@marvell.com
From: Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: Zijian Zhang <zijianzhang@bytedance.com>

When performing XDP_REDIRECT from one mlnx device to another, using
smp_processor_id() to select the queue may go out-of-range.

Assume eth0 is redirecting a packet to eth1, eth1 is configured
with only 8 channels, while eth0 has its RX queues pinned to
higher-numbered CPUs (e.g. CPU 12). When a packet is received on
such a CPU and redirected to eth1, the driver uses smp_processor_id()
as the SQ index. Since the CPU ID is larger than the number of queues
on eth1, the lookup (priv->channels.c[sq_num]) goes out of range and
the redirect fails.

This patch fixes the issue by mapping the CPU ID to a valid channel
index using modulo arithmetic.

     sq_num = smp_processor_id() % priv->channels.num;

With this change, XDP_REDIRECT works correctly even when the source
device uses high CPU affinities and the target device has fewer TX
queues.

v2:
Suggested by Jakub Kicinski, I add a lock to synchronize TX when
xdp redirects packets on the same queue.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 3 +++
  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c  | 8 +++-----
  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
  3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..2281154442d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -516,6 +516,9 @@ struct mlx5e_xdpsq {
  	/* control path */
  	struct mlx5_wq_ctrl        wq_ctrl;
  	struct mlx5e_channel      *channel;
+
+	/* synchronize simultaneous xdp_xmit on the same ring */
+	spinlock_t                 xdp_tx_lock;
  } ____cacheline_aligned_in_smp;
  
  struct mlx5e_xdp_buff {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5d51600935a6..6225734b256a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -855,13 +855,10 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
  		return -EINVAL;
  
-	sq_num = smp_processor_id();
-
-	if (unlikely(sq_num >= priv->channels.num))
-		return -ENXIO;
-
+	sq_num = smp_processor_id() % priv->channels.num;
  	sq = priv->channels.c[sq_num]->xdpsq;
  
+	spin_lock(&sq->xdp_tx_lock);
  	for (i = 0; i < n; i++) {
  		struct mlx5e_xmit_data_frags xdptxdf = {};
  		struct xdp_frame *xdpf = frames[i];
@@ -942,6 +939,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
  	if (flags & XDP_XMIT_FLUSH)
  		mlx5e_xmit_xdp_doorbell(sq);
  
+	spin_unlock(&sq->xdp_tx_lock);
  	return nxmit;
  }
  
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..ced9eefe38aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1559,6 +1559,8 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
  	if (err)
  		goto err_sq_wq_destroy;
  
+	spin_lock_init(&sq->xdp_tx_lock);
+
  	return 0;
  
  err_sq_wq_destroy:
-- 
2.37.1 (Apple Git-137.1)


