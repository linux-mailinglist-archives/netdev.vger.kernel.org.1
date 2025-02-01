Return-Path: <netdev+bounces-161886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B4EA24634
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C5616792C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB415AF6;
	Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8WwjESR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CEC2FD
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373459; cv=none; b=eofoCqZNT98P6FWxaquOeQMJb/ckf2dWxG5WDb/jyDPo4MR5LSLYzlkgmbZ0W+zxmPSNHRmvZYATlU8WxYNBlEU4HL1kpu0gnDBA4SiCBbVahcLFDmHFgLvFgkNBI+SFd0XqX5NScrAv3kqdibCM/V5p1badw4/THu/YenHsldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373459; c=relaxed/simple;
	bh=U0dIwxs0IYLwGc4Nc8uxPPTYD82BiMPMrkGSaSyTKcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYzC42XHhj0P0pUAmevuI2+NpgLzb9I/rW2N5IyrIfXlbU8peF0TtJojxYhp9WYqFx3sbub/GaBfwsWBi67JS6JsuHObIUq/dsBRDK6WU0HKI+7Y22iJ7z0XqVWl+Tri+mXDY7VJu9TDYCEg3D65AOEigBKzFq7MmJIFiPHfKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8WwjESR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B098C4CEE4;
	Sat,  1 Feb 2025 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738373458;
	bh=U0dIwxs0IYLwGc4Nc8uxPPTYD82BiMPMrkGSaSyTKcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8WwjESRkLC4H4to96UyAY0tyHQi9vsgQK/KxNkVJleZtASGoceqrU8spGFlB/MEA
	 LJQlcQ2KoLQ1jOsXi7dTElyNHHiMmGaZVswdFmkxr54zdwb7Zo372wM2s6Q1qJyQ4m
	 /CXO2oiItm9k9eK9br72uRQbw6G41EwlZJxsLt6URnCzqAhPRQolzzxPxzp74oMtHo
	 42109ravoqVARlLwu2TBMpBmmFNYQaLVrlAgmUoAUvdsC/ksuya4obmK4gYt+yms5a
	 893ZIpxWdXXcOfnVW8QoxHKzsiUivPnTyhsjyrL7qUfUDWK17Qbsy/0IIcNnlUAp7v
	 dd8BXx1lFcxIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/4] ethtool: rss: fix hiding unsupported fields in dumps
Date: Fri, 31 Jan 2025 17:30:37 -0800
Message-ID: <20250201013040.725123-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201013040.725123-1-kuba@kernel.org>
References: <20250201013040.725123-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ec6e57beaf8b ("ethtool: rss: don't report key if device
doesn't support it") intended to stop reporting key fields for
additional rss contexts if device has a global hashing key.

Later we added dump support and the filtering wasn't properly
added there. So we end up reporting the key fields in dumps
but not in dos:

  # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --do rss-get \
		--json '{"header": {"dev-index":2}, "context": 1 }'
  {
     "header": { ... },
     "context": 1,
     "indir": [0, 1, 2, 3, ...]]
  }

  # ./pyynl/cli.py --spec netlink/specs/ethtool.yaml --dump rss-get
  [
     ... snip context 0 ...
     { "header": { ... },
       "context": 1,
       "indir": [0, 1, 2, 3, ...],
 ->    "input_xfrm": 255,
 ->    "hfunc": 1,
 ->    "hkey": "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
     }
  ]

Hide these fields correctly.

The drivers/net/hw/rss_ctx.py selftest catches this when run on
a device with single key, already:

  # Check| At /root/./ksft-net-drv/drivers/net/hw/rss_ctx.py, line 381, in test_rss_context_dump:
  # Check|     ksft_ne(set(data.get('hkey', [1])), {0}, "key is all zero")
  # Check failed {0} == {0} key is all zero
  not ok 8 rss_ctx.test_rss_context_dump

Fixes: f6122900f4e2 ("ethtool: rss: support dumping RSS contexts")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 7cb106b590ab..58df9ad02ce8 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -107,6 +107,8 @@ rss_prepare_ctx(const struct rss_req_info *request, struct net_device *dev,
 	u32 total_size, indir_bytes;
 	u8 *rss_config;
 
+	data->no_key_fields = !dev->ethtool_ops->rxfh_per_ctx_key;
+
 	ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
 	if (!ctx)
 		return -ENOENT;
@@ -153,7 +155,6 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
 			return -EOPNOTSUPP;
 
-		data->no_key_fields = !ops->rxfh_per_ctx_key;
 		return rss_prepare_ctx(request, dev, data, info);
 	}
 
-- 
2.48.1


