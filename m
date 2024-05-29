Return-Path: <netdev+bounces-98857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218378D2B5B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A31C22DDE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083915B0F8;
	Wed, 29 May 2024 03:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="COijAqrr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A158BE0
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952848; cv=none; b=uRcvtICwlEWTNVUieXcpuNect7uSqh2ycr2rO0Cam405NL9zU97tPSGLa+RclmlyO3OX2fT183RksQt/ECkYCSHI3h/7XxiNwTwE0KGXCALuIR+tvDXKSTVxMLpM9N2dn1+lgmLj2jwE8cZ71EAzduOfvLOVX3GH3EGIm9Az8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952848; c=relaxed/simple;
	bh=6VEjzVq5nrmfkHoJWASudCixHFmzlAa4gIuIxJ0VuRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKKlv+j+YRtmvAGdhaRP0EXR77XglAIrXO5m4pGoVJpXsjyMlmss33Ry3Pm2QKAZCXbYFKvrMzb5hY5V06oCl7p3NcXMFBJbhvEbL+Ad8M9LJbYhfIaAL4xfZ4EugRj1XdfJodXMRraNaihw90iRKdG85B4UjXsFZLph4XbCy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=COijAqrr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-681ad26f277so1213016a12.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716952846; x=1717557646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BS6iHbBIsatoVGzFhXDQJ9Pi9ja6uQG7muHBmiB17xY=;
        b=COijAqrrIcoNb4M1HsEvUJGvG/G3QCs7XHuVp2LCAzlcJcYSIUUwILLfonMZCMkTHr
         dTzdYJqkYoSuTRt/erXDzmuU8sKlXScMQzd4MyWaf39OAHY17umA2QvoB15/PTgNfyQ2
         9mZnILDjobV6PNW33GDACWZ9ExLFUrJKPNvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952846; x=1717557646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS6iHbBIsatoVGzFhXDQJ9Pi9ja6uQG7muHBmiB17xY=;
        b=pd/d4Cx+F4Fvp/HdStg6jt+H8j61d+nPnHbBVxPlYADjgZabXsMkj+dKroqf/cWBfd
         Ek1LskHJDJbkytPlOgn9egpXullDzuNPBNMZEEnRkMKc4F7S389IkGU/Msc54Hkuu52s
         xLy4v+bac+pLUIm2IltyWzJ4ZsCFIVYAi5kYIDxZjuSFjZfLbfRL3PnLh7P00x4WTZpk
         mWPhYTa41DdMN96ngyFZhycrVt/Th3FY5bmWRkoPaEKS36VhXu2brJJ1+Gw8LAWGEaEM
         pJIyysQe1P5WNEKX1g78P3AuUo00H5l9KibF8JkPHx8+CLBYQG7/e8jm6fw7IjbSHYxS
         jPAg==
X-Forwarded-Encrypted: i=1; AJvYcCXF7fmXLGWsY33sE7hvl5RR4IHdLTaVuanT0RBeo6a96OOpvMzv5R/tjNrddAzp1Nn4zt2kbzpMVxmcy7GaWteBnq54AuAg
X-Gm-Message-State: AOJu0YzneQVQCsPTu97aVJXbXAGaLSfQrLWw3XQL5I5Mwy+ckouCiqtf
	iruuXOy9daYvOBqxAKpG6Z4LPIlUNoU4qRA627lguhypA0nvVj3kCbGBLYQmkkk=
X-Google-Smtp-Source: AGHT+IHK0odMwl88fs80oLL00dG99YZ4irO3GqOx026WsTxm2kQRal9aBjH+zm0v6XLilUzBDoueLA==
X-Received: by 2002:a05:6a20:dd82:b0:1a7:5e8f:8707 with SMTP id adf61e73a8af0-1b212d46534mr13913852637.26.1716952846230;
        Tue, 28 May 2024 20:20:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7156766b3a.39.2024.05.28.20.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 20:20:45 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Date: Wed, 29 May 2024 03:16:25 +0000
Message-Id: <20240529031628.324117-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Switching to an RFC instead of a PATCH because even though Tariq
patiently explained the code to me, I'm sure I probably still missed
something ;)

If this turns out to be right and Tariq agrees, I can send a PATCH
net-next v4.

This change adds support for the per queue netdev-genl API to mlx5,
which seems to output stats:

./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
         --dump qstats-get --json '{"scope": "queue"}'

...snip
 {'ifindex': 7,
  'queue-id': 28,
  'queue-type': 'tx',
  'tx-bytes': 399462,
  'tx-packets': 3311},
...snip

I've used the suggested tooling to verify the per queue stats match
rtnl by doing this:

  NETIF=eth0 tools/testing/selftests/drivers/net/stats.py

I've tested the following scenarios:
  - The machine at boot (default queue configuration)
  - Adjusting the queue configuration to various amounts via ethtool
  - Add mqprio TCs
  - Removing the mqprio TCs

and in each scenario the stats script above reports that the stats match
rtnl.

Worth noting that Tariq suggested I also export HTB/QOS stats in
mlx5e_get_base_stats.

I am open to doing this, but I think if I were to do that, HTB/QOS queue
stats should also be exported by rtnl so that the script above will
continue to show that the output is correct.

I'd like to propose: adding HTB/QOS to both rtnl *and* the netdev-genl
code together at the same time, but a later time, separate from this
change.

Thanks,
Joe

v2 -> rfcv3:
 - Added patch 1/2 which creates some helpers for computing the txq_ix
   and ch_ix/tc_ix.

 - Patch 2/2 modified in several ways:
   - Fixed variable declarations in mlx5e_get_queue_stats_rx to be at
     the start of the function.
   - mlx5e_get_queue_stats_tx rewritten to access sq stats directly by
     using the helpers added in the previous patch.
   - mlx5e_get_base_stats modified in several ways:
     - Took the state_lock when accessing priv->channels.
     - For the base RX stats, code was simplified to call
       mlx5e_get_queue_stats_rx instead of repeating the same code.
     - For the base TX stats, I attempted to implement what I think
       Tariq suggested in the previous thread:
         - for available channels, only unavailable TC stats are summed
	 - for unavailable channels, all stats for TCs up to
	   max_opened_tc are summed.

v1 - > v2:
  - Essentially a full rewrite after comments from Jakub, Tariq, and
    Zhu.

Joe Damato (2):
  net/mlx5e: Add helpers to calculate txq and ch idx
  net/mlx5e: Add per queue netdev-genl stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 150 +++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

-- 
2.25.1


