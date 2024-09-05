Return-Path: <netdev+bounces-125356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D496CD8F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6B31F27399
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 04:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EA154439;
	Thu,  5 Sep 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CR4iKlhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3C153BF6
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508998; cv=none; b=dbEtjLNYrx4iTkhYWcU7+DkICdgT54c6YGeVxkTNS8VUTgYgw3I3nO5jaNvuRAfwkixHxCe+jhpLMSLBmXb7f76nBjJo61U9OQHEmG4kNFH0Z8Ns7t0OOgLvs1hlkPTYR35+jAMQfo5EdJ0YKHcKgDD1+4GYCBkYzVp/esMbAyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508998; c=relaxed/simple;
	bh=auD9fhWsTEWpHoikhl3Mbme+CG3+FT6ZDcgCV2Rw/Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mdxHaTHenqohY2/gsOwNkCQasow6iw9qUDPMX1zxsdnBnRKRygWgtT0Yv5BIGTaz2nBD4VUV66t8o9Igy6XjDmiU6xagPdKG6vS7+T8t0byBRWWjJOI7/xEOzWgYP/EgjJBdyfzKuIyseriRKasyTz5YFnrnecwsWXT3IIQM40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CR4iKlhQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374d29ad870so141802f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725508994; x=1726113794; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TlfktilC6RVUfIeO6c7ZN8OcJL66O83BhaU1aaD3tgI=;
        b=CR4iKlhQkzF0cvJNJqPV4PcItnOnUE2Y8BupYw+GbrlPL0ySbxXaU7Tb3qqtzboas7
         p+OV/EDINe0kmbBg38e4klNctZxx3aueIHUXK7qeN6HGoJvzbO9IdOa5PEM1T40F4wCi
         4dZvu7hcwpLIM7VGad1XSZqXB/Js87LzL5klInXC5KhsehR4YbrQMdv9HetWBTpGymxD
         D+MjrP3xo3Q6L+lMqYZswAa7wDRQEAeeWRMAPgxOHpip3hU4t/T+WUfmZYLf+HErQrKg
         Jj6TT2Zeq3MGS30F0ZvrxWjKpRjVDV1E+ACITcMkzpc3KwCx0qc6dPYYRwaps2nZVxd4
         Kfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725508994; x=1726113794;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlfktilC6RVUfIeO6c7ZN8OcJL66O83BhaU1aaD3tgI=;
        b=qsAhmJk8U6qWIqe+Dz0QsCK3pOVOTWvI1IDqI6oIiwy+WJd+Tv6yilyNtBRE1rmBoD
         oiZ7mQPnZs8Zb3MT59x4tUzif9C1G9c01AzkEJY0Xbm58bKVSfFbTbCnS7M/CtnTDX3d
         qir+CwpDejJ7uO6tGwM8SVxjkV9JY+pQOXlpqvICppJQ3KDBzQy8c10NwyhF7nsJpFti
         PFpAIR5xCgVRF9dDFfIWG/LWPxlfpGRQqtIjX80vwR1bMQaxQN1L+hlpTaTkQFCpdsML
         FLp8B64udlZ6LXI+4OKb+yl9BwVjHXkOfToBTNFC4rlHKNfSTFADyh02yRSYy8XOkRe8
         rEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrgXqYqpLvUzi95xgn7EBmIdUjXk/vEAi0r5+NFNFsZiJkVNim5omRzDP6eF4byH0poYqUrEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3C09ca/koMDWNsdmgeshSqDReuztKaUcTF912pQ2rUeVUrFug
	uL/6Syxw/Nxabz8lh/216jjPaPddFutSxUGLZo2Yf4yXILuC7RTuuivc3SOAOqE=
X-Google-Smtp-Source: AGHT+IFo8+Yg/BiKvI1snoHFNdpPrCm69H0ef0GJQLA/Kjx60/Gv1y9q1gHs8XTAQ03ZcfaLKfUVOQ==
X-Received: by 2002:a5d:4109:0:b0:374:bad2:6a5e with SMTP id ffacd0b85a97d-374bf168f0emr9713019f8f.28.1725508994209;
        Wed, 04 Sep 2024 21:03:14 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8a61fbb093sm74170266b.11.2024.09.04.21.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:03:13 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Moshe Shemesh <moshe@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shay Drori <shayd@nvidia.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] net/mlx5: Added cond_resched() to crdump collection
Date: Wed,  4 Sep 2024 22:02:48 -0600
Message-Id: <20240905040249.91241-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240905040249.91241-1-mkhalfella@purestorage.com>
References: <20240905040249.91241-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Collecting crdump involves reading vsc registers from pci config space
of mlx device, which can take long time to complete. This might result
in starving other threads waiting to run on the cpu.

Numbers I got from testing ConnectX-5 Ex MCX516A-CDAT in the lab:

- mlx5_vsc_gw_read_block_fast() was called with length = 1310716.
- mlx5_vsc_gw_read_fast() reads 4 bytes at a time. It was not used to
  read the entire 1310716 bytes. It was called 53813 times because
  there are jumps in read_addr.
- On average mlx5_vsc_gw_read_fast() took 35284.4ns.
- In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times.
  The average time for each call was 17548.3ns. In some instances
  vsc_read() was called more than one time when the flag was not set.
  As expected the thread released the cpu after 16 iterations in
  mlx5_vsc_wait_on_flag().
- Total time to read crdump was 35284.4ns * 53813 ~= 1.898s.

It was seen in the field that crdump can take more than 5 seconds to
complete. During that time mlx5_vsc_wait_on_flag() did not release the
cpu because it did not complete 16 iterations. It is believed that pci
config reads were slow. Adding cond_resched() every 128 register read
improves the situation. In the common case the, crdump takes ~1.8989s,
the thread yields the cpu every ~4.51ms. If crdump takes ~5s, the thread
yields the cpu every ~18.0ms.

Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 6b774e0c2766..c14f9529c25f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -24,6 +24,11 @@
 	pci_write_config_dword((dev)->pdev, (dev)->vsc_addr + (offset), (val))
 #define VSC_MAX_RETRIES 2048
 
+/* Reading VSC registers can take relatively long time.
+ * Yield the cpu every 128 registers read.
+ */
+#define VSC_GW_READ_BLOCK_COUNT 128
+
 enum {
 	VSC_CTRL_OFFSET = 0x4,
 	VSC_COUNTER_OFFSET = 0x8,
@@ -269,6 +274,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 {
 	unsigned int next_read_addr = 0;
 	unsigned int read_addr = 0;
+	unsigned int count = 0;
 
 	while (read_addr < length) {
 		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
@@ -276,6 +282,10 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		if (++count == VSC_GW_READ_BLOCK_COUNT) {
+			cond_resched();
+			count = 0;
+		}
 	}
 	return length;
 }
-- 
2.45.2


