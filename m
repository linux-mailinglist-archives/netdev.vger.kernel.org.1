Return-Path: <netdev+bounces-212198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFBB1EAC6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6671B18876BB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E5283FF0;
	Fri,  8 Aug 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdnBrMlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8B283CAF;
	Fri,  8 Aug 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664821; cv=none; b=cgAQWutX6EvYpJLIvW4Ui1zLt757k6l/JjtHVQNA8/aBtQjKmw250QSsZ73QguOOt1xRyqgcNZdSsYwjoq5U4/laWvkOeSrDqo4LmmGmQlQgCjT8hsbjD1bpatmJbu2jFSyy+hLOlsQNdZOmh95TqH9aMbbr0n304weFed0jNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664821; c=relaxed/simple;
	bh=gYb8YBi9GClyBnpN+21boWlLrjiO7+W2cPrK+FgitMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT6v8Go9LNj0/BPNltB5OU8MSsLRIdcZfOVJ01v17by/p17X1vOdlH4uqYP48edk5Hgf8b5SBR4WRmSdcJZDDk+57v9O5xPtmhNKSoKcxiK54vuQCOVAOzOY3TF+MnLLxMnKDy/oABdjD+dolLL36m7sjevPcksgm5uBzViHSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdnBrMlb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so18191795e9.3;
        Fri, 08 Aug 2025 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664818; x=1755269618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfQud3JQW5FBjJboy5AodeO9y125Lb1Qj1exFzfx7Sg=;
        b=GdnBrMlb/mrcOqfhvA3kwhndlj8bEs6sfP8X46sJnJtYQlN6hoZTebkCHV2FK0Y5jH
         PwJ05BY6sv0/JW4AVvro79sC4TZKMxD/TEtDtGIchSK0WDOQRxX2ptc1avnPO+Swnf+A
         Iwr73+CZRMSpqIQILjBGQEgagUCm2sLil3hmC/Q4YoCZNBMJsms6MA11JIek9lU/Akyf
         kyN46X0CM1NkqrEs/mgQAhhsIS0tt6JtfNH+UUoJwgYvGwe/vNFYthzbc5IWT8HzDtl/
         I6dSqHwAcZ+hVLTzPdgOLTkgbXrjRRUJB1oQMx1XBTt+iD2ZKucFjimi87ngeDKVRj7t
         cW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664818; x=1755269618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfQud3JQW5FBjJboy5AodeO9y125Lb1Qj1exFzfx7Sg=;
        b=MKtS6mD/jrGAZAPlzkOvMJBDloaZ9PJqv57FdXPKPaF8qy6yaAI2aJGGqGT0StDDBo
         Dpvk1YT7Fq0f8h0y1KIRWcMxVMdUTgIlh+E8AOIzLpdF/j4rK/zKZS2g8M+v6Us76RRr
         wxTSXg3rps7YDuwqiiu8hicNirnrtG1s9xQ5GajKcKwU3D7VvOs//33My/qTW1LFQlBt
         wxBmgzOG0DQVpsJxPUj4U528HQ1hErEw0fsUZal1FBKC9hDVEskPrqrkjoJhDlih15Di
         eBYMw97PIjoy8LwzV0OyB2VkvEAR9ZOyVTay1gtRLWywCqVK4ZeX0iq6pZE0GCDURV4V
         9CBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM1C/q8BNqpMbJoa/AZhStbZ+l0Fot0TnFqYb5w3M9HpWKE8lWVVAPkDJPYuXP5axu9dm/VExh@vger.kernel.org, AJvYcCWwsbc4ciwPPn+8P/XhbHv4kkQjNMJLNokNyC533NLJF8DCbhl7oPX/OK5NjbX95TkQfcoUkyNlK4e+XOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/S1dPR9lela1BtKeipct/kojcVGyk5WiuWcKkhO14BKv0bsv
	T5PWg7SZT70mm8zrNxIDCUCaFiQxbX0jVhvgDCfF/KoN4wNKATjOmp5p
X-Gm-Gg: ASbGncuxs882LpcPDskdxzKQQkAlZrKmzmDnes1gg1MVeqtkIhroFeGVdGrA8nKa2jm
	qfhwftMEqP8pN6IhPhi6KpOsyY/PGcrtS4D66nAtA14NVaelo0JLjFIUNi8MXAqGufXl9a84l7I
	Gn86aItgueM8Mx4Mssfi70ntH/Ufk0Ywk0AcFmXDWQLToEYBsVRh20aOvM4nNO5LeO+04nuCI4k
	ea9irj61wkhyitYTk6rqgNOqDBXuJBLcXlYzmyyhcUCzCNDIg20AdiXnxRJdu8jdJFXms9ysl3j
	Pzp3yzd/YcJR6E7k4UtIxPFFyP+Hr+j4Hw+5spSaEyapwd1UNZHpEmr0wyr5SMkehtLq2icbEOt
	H1tvpIA==
X-Google-Smtp-Source: AGHT+IGQjwfN16gVY9Mf1H2mvjT+KJXUdU0w+SvlhvmL6NT1hrJH0Dqvg9HvX7b6+VmSUc22Gj2hbg==
X-Received: by 2002:a05:600c:45cd:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-459f4eb4004mr32289145e9.10.1754664817723;
        Fri, 08 Aug 2025 07:53:37 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:36 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 05/24] net: clarify the meaning of netdev_config members
Date: Fri,  8 Aug 2025 15:54:28 +0100
Message-ID: <66b588eaea1a542e1929dd72671ae16fc6334c49.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

hds_thresh and hds_config are both inside struct netdev_config
but have quite different semantics. hds_config is the user config
with ternary semantics (on/off/unset). hds_thresh is a straight
up value, populated by the driver at init and only modified by
user space. We don't expect the drivers to have to pick a special
hds_thresh value based on other configuration.

The two approaches have different advantages and downsides.
hds_thresh ("direct value") gives core easy access to current
device settings, but there's no way to express whether the value
comes from the user. It also requires the initialization by
the driver.

hds_config ("user config values") tells us what user wanted, but
doesn't give us the current value in the core.

Try to explain this a bit in the comments, so at we make a conscious
choice for new values which semantics we expect.

Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics.
Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
returns a hds_thresh value always as 0.") added the setting for the
benefit of netdevsim which doesn't touch the value at all on get.
Again, this is just to clarify the intention, shouldn't cause any
functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: applied clarification on relationship b/w HDS thresh and config]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 20 ++++++++++++++++++--
 net/ethtool/common.c        |  3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 6e835972abd1..c8ce23e7c812 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -6,11 +6,27 @@
 
 /**
  * struct netdev_config - queue-related configuration for a netdev
- * @hds_thresh:		HDS Threshold value.
- * @hds_config:		HDS value from userspace.
  */
 struct netdev_config {
+	/* Direct value
+	 *
+	 * Driver default is expected to be fixed, and set in this struct
+	 * at init. From that point on user may change the value. There is
+	 * no explicit way to "unset" / restore driver default. Used only
+	 * when @hds_config is set.
+	 */
+	/** @hds_thresh: HDS Threshold value (ETHTOOL_A_RINGS_HDS_THRESH).
+	 */
 	u32	hds_thresh;
+
+	/* User config values
+	 *
+	 * Contain user configuration. If "set" driver must obey.
+	 * If "unset" driver is free to decide, and may change its choice
+	 * as other parameters change.
+	 */
+	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
+	 */
 	u8	hds_config;
 };
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4f58648a27ad..faa95f91efad 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -882,12 +882,13 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 	memset(param, 0, sizeof(*param));
 	memset(kparam, 0, sizeof(*kparam));
 
+	kparam->hds_thresh = dev->cfg->hds_thresh;
+
 	param->cmd = ETHTOOL_GRINGPARAM;
 	dev->ethtool_ops->get_ringparam(dev, param, kparam, extack);
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
-	kparam->hds_thresh = dev->cfg->hds_thresh;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
-- 
2.49.0


