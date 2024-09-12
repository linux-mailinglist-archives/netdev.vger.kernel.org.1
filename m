Return-Path: <netdev+bounces-127972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925DF9774AC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B79E1C23CDF
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96C1C2326;
	Thu, 12 Sep 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMj3nCq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48E18891D;
	Thu, 12 Sep 2024 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182358; cv=none; b=MIc0W7NqbHQ0VAapAAB438rnuvbFIAtGgsut/1iqq/K4MzUUoBZR4H4BK4NR2fVXNCZk8CGQbbC0nJvY1j1hfJuairf1lwLyGDs+MveUipbWcmJHl3Lrmeky6UpuM2sGBcX9/qAlEparL1WBYfJGcPXKRrl7g9sp8QC6PiizU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182358; c=relaxed/simple;
	bh=efAx2aTTySDk5VWnEt50L8ui2mTe7AkT6AseDeCQd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t49CnT3AnT9R+8VcouTLIAvLR+IrdblHUX95YtHH/0+M1rDauA9MrsWMNqo7bD3IpCU2EyHtS3VLk6wf6fYrm5zKtqFbtbpt+wlvv+4M7veL6eD6uQlaTY+/Bzin8kvCQk8lS+0LyaEijEs1SDijteeUwxMG1FE5AxQj7leEJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMj3nCq4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso403517276.1;
        Thu, 12 Sep 2024 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726182356; x=1726787156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytNTZ/l/035qb2aZcPOAkgUE1o+hf0sj4BV0CbX6Wws=;
        b=JMj3nCq4iXeFPccAuNCZa/HTD4OrCI26C+4wdPGP31Emb1AihJs0Ogr+DfVVZrm5xN
         lim3eKmUq88+hYulnW81PfzGCYGMRLTRtU2c4TtqKjOC2vX1cKBirADyjpj6m2DHK8Md
         MKex3+kwMqPqGWP+7gTRjWwGEcFqGWGBrfUiYnxcp5CptikWrlQrnPBUZH5suAOvjxgd
         ohSbHyvMnZMMXoTCWErI5uDQzry1x0vsnYf7BxR0TNcqinRHBlxUFjpDETSQLfAQM2ga
         bXgftrAuz3YC6OvdRPl7NyjrZ7lv7Of7uo3Zh9VWSXobUpTFcGY/ldGOgpPGFdhqT8Bt
         DMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182356; x=1726787156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytNTZ/l/035qb2aZcPOAkgUE1o+hf0sj4BV0CbX6Wws=;
        b=kVJpqfUadDtj8cztOh4HR8pjFmsbqpENb+eaGeZXhsGfsf51e2I/C17vxMRpYIzfg3
         jLH9ML5slFFXGLO55Lj6+/Y0wPY56GpIrLa7kRKJ+1eAbdCIaCiOBsB4oXwINmR5RBx7
         6X3YM9rKyqHDiuZJWqtAeuGQEIQGZD1Y3C7FQPWOAAqAyg0NLbqRbK7Plrnlklx2f3Pj
         +WNKwv4AwrXbRYqtVnCF1UmRvHVC1tZm9GdXMhIXvAAsTDsdfGRQ1HgRmeeJyPUhpKZm
         Dc7pQQcjwg14CT5R+DiAaTpIdIgIbt1KZ2vHqZl6RZHsoIXKkwOFLfRHC/1dCSb3DYfQ
         eRMA==
X-Forwarded-Encrypted: i=1; AJvYcCWphPhS1LoVQ8+G8YV7xGAgcecj2PThxMbrRI/MQg7zwMfIM7HcjiF0OULzfhJBO8A8owfb+y+8dhIPTz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0PoaDn5WlGnKsbPFkJrSrEwW8NibHNixDFIryj+ra9v0WM7v
	oaUqAKNSlp8iiTbBzLIsUxZoz63Cij0HQSFLO6q8et3Yxv/Gh3KU
X-Google-Smtp-Source: AGHT+IGDey+1wZBDSvml3qWvmvBpp2/zK+EbaxR0w54uSBd1VYIpjNltS9ERQSpriYCHNcHax43nkg==
X-Received: by 2002:a05:6902:843:b0:e13:e674:553c with SMTP id 3f1490d57ef6-e1db00a6af8mr797164276.7.1726182355610;
        Thu, 12 Sep 2024 16:05:55 -0700 (PDT)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d7ba04b65sm1215388276.22.2024.09.12.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:05:55 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ethtool: rss: fix rss key initialization warning
Date: Thu, 12 Sep 2024 16:05:30 -0700
Message-ID: <20240912230531.3116582-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning is emitted when a driver does not default populate an rss
key when one is not provided from userspace. Some devices do not
support individual rss keys per context. For these devices, it is ok
to leave the key zeroed out in ethtool_rxfh_context. Do not warn on
zeroed key when ethtool_ops.rxfh_per_ctx_key == 0.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/ethtool/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 65cfe76dafbe..8c4979b8f4f3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1504,7 +1504,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
 						       extack);
 			/* Make sure driver populates defaults */
-			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
+			WARN_ON_ONCE(!ret && !rxfh_dev.key && ops->rxfh_per_ctx_key &&
 				     !memchr_inv(ethtool_rxfh_context_key(ctx),
 						 0, ctx->key_size));
 		} else if (rxfh_dev.rss_delete) {
-- 
2.43.5


