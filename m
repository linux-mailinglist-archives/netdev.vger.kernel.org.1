Return-Path: <netdev+bounces-234815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C63C275F8
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 03:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A3C3BF312
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 02:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898E2580CF;
	Sat,  1 Nov 2025 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JeErkIUo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738D255F5E
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963894; cv=none; b=Thcwvy0foRpI1eTl/ciP0rWh6gkl2zT74SEiEftPR+EPllGdJ9P+Yrr8lYY03BRVS8Vwg5fTq99H2g3T+3pQ8OxySLi1xGwQnXwEfKglpTnN+jlKZrOQq9pdp2SoGLaDjRnv2V1nrO52gxFoV0D7KXk9FleymI4YHZNm+Sv8koY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963894; c=relaxed/simple;
	bh=xkWb51wZhdI6JeTasbmp1AYz/2oYTUJNL1sr6HgNKYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5GvOBT2t+bALWkFQ4UDowz7/fdAYgeDYsdWXcbAeAhPMBaAjDjyVrqDACXtu1KjZC2gBYZt9y2vHxcTkAZFXK2pp/5HszWRjNytwco8uIbUbqpm41CVHrobB6Db1KmPkkr14lKNTERbb7bj2yAMWnCbxtxWPVETuimTMWXzGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JeErkIUo; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-654eb78f721so1408526eaf.1
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761963892; x=1762568692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY7QaowISP25l5b8w9Vhc566fdS0rn2/ms8LvGaxMMw=;
        b=JeErkIUouTRVdaI7aeSMf5arDNjzwS7o18/em/NdpLwe3B1eOEfXubB3w2rBvyvclP
         9SbQ3VVbVCfSvhPNCpB0hvoXpUVi+70jyZx8243V8Cgc6HvxCzAligUcyN+S9uIkIezp
         Er4RJWXyv9tfXJxR07Pth7RdiVBrhrGLim/GaV9CTTNX2A05h2oZT3R6J8L4j33O7Wxf
         WqI+917vrTRRLe8dEZFbnL255b2odXf2bmmR8V43ePk9Dfy5WQHFxU8PeeNthlah+F6V
         aQbjAuAnd2OcVawGITBwFxBXow1GH+J5+57hGzS+GANdTFQiEwNiMDGkQj8pdMxfGBCS
         JaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963892; x=1762568692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY7QaowISP25l5b8w9Vhc566fdS0rn2/ms8LvGaxMMw=;
        b=PXy59G7t3iC9gjhlbJkeV9cFrmoHbMybll+gSdfkjRSjGOVnnRop04zdJtW0S6Xv3T
         e5Uo68XSOtQQzabd4BmiKyiYQpfdY2PjUg0hTXu66wM+nJOB6ENmV2EvcyA1pOW1sjd9
         ckvNRQJHyPlMUiQZNX19rp44ZAOJRAuX7OJ8IvwpE51QXId+Ig54Y/wAfPtxCEgkl+Gd
         y8cQEMMfza80vHesr6DfMCq+4+K3neETRGmLFVkZyMc6zu6Rb1gAWZfj3awz4fv71d6u
         8Kol/c8aGf5dpsqmcWuyzsGM65BO5lf/C+MZ5IdVVAAPpObt0atRWTElnypOaWidjWIZ
         vntQ==
X-Forwarded-Encrypted: i=1; AJvYcCV69XPdkqaA7o7iwk/wEvf6SsO4vc991izTUB6PK5XJLCGyfK1wLJeSRYHrdykqaKMUjB4CFM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRYIoItIzstXpDWcnXbrUCwyjncXuzVCDTvxLz7GS3cA3SR4u
	t5qIKEPgRflvHAsPOtNfjSj5X38xGsjXFIo59zBAeHesfx1fsQXETNDZ9/NerbfAelc=
X-Gm-Gg: ASbGncs4eneK4avvUBJVcs95Bx8sNBYD9w1q9+X2qW9Xt5Wv85H013HFXyDeB1HQQg+
	b/1jhE+mII92cpqbwny5PbW3ZgiMfQQPdCq4uUfgPWBZeMAQzMjvhkr/JqFbvcb5BkEXJ0GkoyT
	rmhHx+q9uM4V2cvb3qUvZy0eiLe/1SrOnjmbU8Ay2W50cd9uWPrqzGmS8A/rgLLxtVhf7e1TFYi
	wwsDcii5FsQ6ZMKzfEN9GRGrn65wFM42rY5MQCKMi2xvooukpjJz7Mbr2E1iAFmk+0krK+NFaEP
	M6g97gkMAzNytKtK4Opp2oYMVMuv/A4o2aX41xBm2H+a1yfRzFFEaVC6ThCM1fAy4T0wRm5AuAc
	2AbvKdpLGmFt+dz/BZeWnmxUQfhytDVRVWcXf4vMHqZ8wWidRe+ubVW0xG6hOez8mWukQtT/kUN
	pmQhQoBmmUHa1v6NTUaBQ=
X-Google-Smtp-Source: AGHT+IGlKWC6ftwE7m8rkAsyefLb4U8rEQufxKZE+McP1J5SjpdT8G5RP6YHw63K3xteAHPXJuAW7Q==
X-Received: by 2002:a05:6820:2918:b0:654:ea04:53ff with SMTP id 006d021491bc7-6568a3ee8ddmr2515711eaf.2.1761963892406;
        Fri, 31 Oct 2025 19:24:52 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6568cfb4913sm898840eaf.12.2025.10.31.19.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 19:24:52 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v3 1/2] net: export netdev_get_by_index_lock()
Date: Fri, 31 Oct 2025 19:24:48 -0700
Message-ID: <20251101022449.1112313-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101022449.1112313-1-dw@davidwei.uk>
References: <20251101022449.1112313-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need to call netdev_get_by_index_lock() from io_uring/zcrx.c, but it is
currently private to net. Export the function in linux/netdevice.h.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/netdevice.h | 1 +
 net/core/dev.h            | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..77c46a2823ec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3401,6 +3401,7 @@ struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 				       netdevice_tracker *tracker, gfp_t gfp);
+struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
diff --git a/net/core/dev.h b/net/core/dev.h
index 900880e8b5b4..df8a90fe89f8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -29,7 +29,6 @@ struct napi_struct *
 netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
-struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
-- 
2.47.3


