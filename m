Return-Path: <netdev+bounces-158144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CCA10951
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DAC3A1EF2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71E14C59C;
	Tue, 14 Jan 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG4fm7EG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3113AA53;
	Tue, 14 Jan 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865010; cv=none; b=XWmndXorKRvqNpQxlyttZ0u8OAo1tOOpXFLRAz9H7Xqdzza1f7VinOrxhfzxFD1/25z5sQ3HibyB/VWv9Ow7e4C0gMkG0kCel0/tbtMnsGuLNk94XGYfO/W1kLFqwbmoAAoYGT7AWjj4YaxhLWVPmp12xHdmdaN6uFuQFqS9Y9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865010; c=relaxed/simple;
	bh=etDMffPKXB2glXkPg6kaiPrNyPH+kKXRtQDcidGYoHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gv6DuRKAtAEkT9Oz2kg4PhSuT/v8WMNvn9+t88nHeUnXEOhl1+YyBmnfKKJ8CkaSH6xRZk7fwQ8yYUo9kohrxMVIzrkIIXgOxZgDxAq3JwuKfXEMMQb9BiTJHle9fh+5gf3pnmadBjMuydPzfhmCOpAwVr+UCvAvpx99WUZnPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG4fm7EG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b662090so95486745ad.1;
        Tue, 14 Jan 2025 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865008; x=1737469808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEQZt8Mhh9qaOtS6y84xnmH6m7isUX454+5HDJAKGe8=;
        b=WG4fm7EG8r59b+jjRCBsTFWZOY/CAcCTezoTlxuL7oxpEsvyg+e8XOxi7bFMn6kkqT
         NCHeo2HSQufalyIDmDODhnh5QoW8x24uhwm7IzzjTlKkePhDvQywi8dfF16qpBVD3T3K
         /IeMYumn4hI75O5BnDCPxhiy0NcBKs37dqcUBN7FZp3e033aKu38ibqgumXevdXhNehS
         tivmWcqZLJ41TlkNLrYuQi1NYCGEPhd9cESX2wxBt3KTLUvRLbLfAnairsLVK5Cw7Mn/
         KMWep78gAvfTlzOTkpPhjZcaFdjBwBFKqnIsktDMalXwPgb+nerXNl6MLHkkhovKJ9jl
         vGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865008; x=1737469808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEQZt8Mhh9qaOtS6y84xnmH6m7isUX454+5HDJAKGe8=;
        b=aSY6uHy9uvLbx3o9CJWBI9cN20J+xAz12d9gODLM7uL+QE2KpyQ6vyOdMDATWqjHF6
         q1q3U4IKug8w1e0TlGDT5v5VdBNBvmflQkuHlKOBpcd4aBYja6/hoxgvAbuiNp8wvmKO
         4mNprMd9c7kKF+Ad/7roz8kLNpAVnFajiGIUDtXvEmf9SL0e9/t/WLKo3FNCAXurkGVN
         /uXRIX62oLOcnX9MK9VQPL9KLzREObhZ2kbUpOfM49NVDRmdqP5FNvjD3IHL1bEmIzga
         b2//WFUmQTy8eOR2TSicjzDD/Pq4e8uRoUpwQG+bxWOG9yg0oBRwf9K5gIxwbNy0ifcY
         WyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtvdl5ooEGdO/eIwEa5uPKm4GYitvcLCGGzBm1KH/wslRR4c5K15Yi2emcsC10paX0rKgM1fdF@vger.kernel.org, AJvYcCXqozT04mFrTaZF2nuFXchy3TBu0W9F9xV07JuX+S55inBvJyxJ0X5RR1EG6PwcLyb27wLtZdbSXmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IW7JrWmhfVyysSme9bNw9MhCHWl2BFM0xO0G/jTh3EIk2tmC
	Ih5LzHJlVYD9CKGcaPjasqFGh1tF26DIQPmtGSpVHIqvajAFIHGg
X-Gm-Gg: ASbGncuTA1nNXuEBuik574jyRDEz41rzl6U/SbGnMGZRHiDBUMT3F4EW3kZ5o/JWsbl
	x80S1uAK6Ip4BEQoHy1kGQCEmF6tZn7euj2rkoaw9xtZ/il7JOb7W8PWszxqrNMnDujoK8V3jHQ
	Kofh6SSmvHX6k9qj+xbRWcbOnl8GqXc6W7zY1pXgfjbdPMNenQ8ijilCQU44Oy9p8k6uZGYPjJO
	4RS1TAy3GeuARjv5yO56iNVMy+NNPHPZxJGvOj+d4n9OA==
X-Google-Smtp-Source: AGHT+IFUumWrMVGU3d36eLjoWFeVK21N0UJ2nEQAuigo/Q8P2AYxFs/9SmIcqqGoGx9LSnjTBpe2pQ==
X-Received: by 2002:a05:6a00:4f88:b0:729:a31:892d with SMTP id d2e1a72fcca58-72d21fa5cecmr39526499b3a.8.1736865008266;
        Tue, 14 Jan 2025 06:30:08 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:30:07 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v9 05/10] net: disallow setup single buffer XDP when tcp-data-split is enabled.
Date: Tue, 14 Jan 2025 14:28:47 +0000
Message-Id: <20250114142852.3364986-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a single buffer XDP is attached, NIC should guarantee only single
page packets will be received.
tcp-data-split feature splits packets into header and payload. single
buffer XDP can't handle it properly.
So attaching single buffer XDP should be disallowed when tcp-data-split
is enabled.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v9:
 - No changes.

v8:
 - Add Ack tag from Jakub.

v7:
 - Do not check XDP_SETUP_PROG_HW.

v6:
 - Patch added.

 net/core/dev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5ef817d656ef..47e6b0f73cfc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -92,6 +92,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/skbuff.h>
 #include <linux/kthread.h>
 #include <linux/bpf.h>
@@ -9567,6 +9568,14 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
+	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    bpf->command == XDP_SETUP_PROG &&
+	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
 	if (dev_get_min_mp_channel_count(dev)) {
 		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
 		return -EBUSY;
@@ -9604,6 +9613,12 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	if (dev->ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    prog && !prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
 	if (dev_get_min_mp_channel_count(dev)) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
-- 
2.34.1


