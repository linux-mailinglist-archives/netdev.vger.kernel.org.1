Return-Path: <netdev+bounces-234531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BBC22CF4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF231A205AC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54381EBA19;
	Fri, 31 Oct 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D3nEJglw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDF288D0
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871377; cv=none; b=atG1xnwafSmiVCXNlXLwOF6nj9H2GrqsX99YGq4fVpjk5cZMcB7gYl5T2hKjjllBHitxL+mimWLdfrs4dl/0KMAR1gK+dDjA33AJgR5CT5+RbhrbdC2HtsDNcPpdwcd7lNnYM5uVkqp4yj9z9wgFEs4s243tDXiYERachGPpfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871377; c=relaxed/simple;
	bh=rSxFHkZmPgWQoZ7won3MlelbPJirEj1hGm28ZuyoWSA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Woy9CIVSFOYtzFVRF5J+mYBKYkk92R1rFEkwbG0x50XFemWaure1y8jMMqnUmwdIG10PQKAmeKjdhGuzzVzyQxE5uwg0ObI6l6R+yVKkaH2mWbbNcCR8S8DcTN9mVgxiP1icwxNPXxIOwSq05TDLeKvjwojjCXFrWzcUCLHZQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D3nEJglw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88033f09ffeso1851576d6.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761871374; x=1762476174; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm8/Czgf2rsoqnvO84EJe6VKSESDEey9Y9C/B8Bf+lg=;
        b=D3nEJglwyR07RQHOAehDFqRiVTkIrHXqHn/NUvmXzQ2g8IE9h114UMtj7CmQy69vU5
         VumRLE47hBU+h6Pryd6fVllBIh4QL+X60bWBcoHXm3lVOgNtpHKB2eE/QviPu61shvvb
         yjekiDFkhYuBNYKgz54RQ0X2+B2IauP8kRlu7sd4y17zn3Kom334us3QJJHuPczYD/qY
         ZNcFC9i+kWIVyjd32odsf9Ni4u2IK9fHnWNQS1xWjlmRqMuMX2rPMWDD8e19WT5HCx6Y
         KMVbdGBwwasp34bXyGsO9AoY0WYIBa9b7KE4Yg5U+SlbpXanuknWBHW98QJE3Pnq8SuI
         53xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761871374; x=1762476174;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mm8/Czgf2rsoqnvO84EJe6VKSESDEey9Y9C/B8Bf+lg=;
        b=RhN8RkLHM9sYBhVKBpgZcUD2ZLgHXzTGQyxQp3S1yOa4IrsNvtVFLxfJExX8FXZaRQ
         lEfYXe8FZS9hRpgd+w5tlwQnbhh2IB8nQXy99u2hlHjMQ+Z/GfTeop6T0WnIcAYEYea3
         zmFYgABPU8oVFi4sjKzHc4La/8rKet9sIgqAtHL9jx4XLfboB9sOvYvMMoPGPXu045vl
         psGfijnTMz7JeSHL7JZQ2G9N5nksMGZL2hY1hc7BdXp/0oJXc/JAkr/MHXWEAZfwV+ON
         nL6vXJeErqa22o+sDwaXjAeO2RUyqGkCtOv849S96I0M3QQ7kWBOHfN74Btgut+rYIST
         FFKg==
X-Gm-Message-State: AOJu0YyOHL/KI4ZVsfqBMoasm289gaz/FnWkUtNFCphnIJf3hivbM1BK
	J/fpyCSL61K4BxXuuycUBMycDDkAqmorBxj4tLRzRB0taWk+mwB9fRQduSt/rb6C3puh1p0QggG
	zrFtk
X-Gm-Gg: ASbGncsp+5rQQCkOhjGyooZETN8/oNTV5wpCplN3piLizDZ3W3Y6CPDTygTaTQJ9znZ
	CZTZQ2qGnNomWZwFNOkwaJV4QNZbP8ijTk3ZITQfnf8xQNvYlrJgMJPOUc2qg3Ia1/FRFU0TBbR
	UQB+w+XjzvIh2IFRkrlJ4XJp+VbwZasDGXnD+ODWGVnYak8b6CFd5pKz/sdDToDb+dcNgVn53Xg
	xiWQKCrtsP0oJcweY5xzggV/bb06KxfylzCtfVOi7P74+c+PJFgo7gFdQpUvVR8ilaxITwt5sNK
	s5npksn6rQPAt2Rl8b4NJitSWOT+163r/Crb0TNPnYOjqF9Ly+rZONf7R6AOSsjzP/TaqrS6WnI
	2xLrH5uQPRJuSiqDGlw5bltsA7Hks7GEBBiHHlBZRW+pF+II/klw6R6mfr+oa6ZXNinNQvr1ylQ
	AX0RHhA64OZchDWYnQbVZnbFMTh5U8hFtl
X-Google-Smtp-Source: AGHT+IH22X+673BG3kC+m0RrfvfVBuB6TIMHcwVcFpuDLjKPoInidbys+e5WZ3TTVEDaJysos1xCTA==
X-Received: by 2002:a05:6214:5004:b0:87f:9e72:4722 with SMTP id 6a1803df08f44-8802f49cec7mr19010996d6.46.1761871374202;
        Thu, 30 Oct 2025 17:42:54 -0700 (PDT)
Received: from [10.73.214.168] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88036359265sm1624856d6.54.2025.10.30.17.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 17:42:53 -0700 (PDT)
Message-ID: <e25c6c0c-1e2a-48c2-9606-5f51f36afbf0@bytedance.com>
Date: Thu, 30 Oct 2025 17:42:50 -0700
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
 tariqt@nvidia.com
From: Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
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
index using modulo arithmetic:

     sq_num = smp_processor_id() % priv->channels.num;

With this change, XDP_REDIRECT works correctly even when the source
device uses high CPU affinities and the target device has fewer TX
queues.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 6 +-----
  1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c 
b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 5d51600935a6..61394257c65f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -855,11 +855,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, 
struct xdp_frame **frames,
  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
  		return -EINVAL;

-	sq_num = smp_processor_id();
-
-	if (unlikely(sq_num >= priv->channels.num))
-		return -ENXIO;
-
+	sq_num = smp_processor_id() % priv->channels.num;
  	sq = priv->channels.c[sq_num]->xdpsq;

  	for (i = 0; i < n; i++) {
-- 
2.20.1


