Return-Path: <netdev+bounces-251408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CFD3C3B9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3865566913C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4493D669A;
	Tue, 20 Jan 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNhJhpq7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894833D667B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900976; cv=none; b=RMYnbtKE/9cT6KtgLY3vTAZHATZBYOdlkHVwXtv/virrpBN0ipUAvdJdSqyXl3N3LRt5Umer33+pYT3FZxJTi47/AWKu0tF6f9OQLo36tTkkKz7XDQKy593kLoqfJ2ODOZm1O8SyzLDsI0oW03IzmRw8FbB6LAftURCIHb2Nx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900976; c=relaxed/simple;
	bh=75S9BycuIxuSzaBu+FNNZEZiK2ibG6IN1JQgbts7XXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXjRdXQ6rrxK4vGAcAINrFXfi/cLapZTKUdohAHt6f9FLEX7Z/GHNCd2WxqybDCoKYC1KcCSM4GlHpms7B2cmnr1V7E68ob2K8hrrQgeoKRAYIJgFwnRQdsdG9zv9jsGWz8BErLKrlWtJT9wV6Cl1LgjUzGVZ89w3o+bRByilok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNhJhpq7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c4464dfeae8so3173811a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900974; x=1769505774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIajvYJtpjLxUNB+rknTUd6Yd1pBkxIf665PlB4VuA4=;
        b=iNhJhpq7+d6loRSPikO0dolz4Ud7Z1zCqpfh5YCz9obiKcrvStAod/9yJ37xoHSf4q
         VjdPwrvnCysy+uzqd7reDrCFOUtFTz7kkgV1WEH1DVDx5bfJByx8qKOva5iBXOZalXgm
         X0ckLwEYzJ5PIfScH9WhWNIfst/1harDR+6KENWpW5VXC0nmHsSgjlQ9YsTaNz5JjuOy
         dcZC+090RErBW2rRGbRC0FQpswtCVYHfkFKal6eTY0WM7aSa+jles9GDvHsWxSqTQD6s
         F6+TYR7CGAQ8XY8dqYQqzkY6G48K7BvrjV3Y7mEqzRzVEei63CGy2WD7Ixt1JJFsyJER
         UykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900974; x=1769505774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIajvYJtpjLxUNB+rknTUd6Yd1pBkxIf665PlB4VuA4=;
        b=OK5VZUTwcczLqoqNjqaY5CVoyGyVcq7iV3ptVeAeQraLKFJ44dwOIoNhPQ++e2hHjT
         MuN0XNlNxBrdFvuOrYvml5pdI/SomYi/qWBk3gjO8YUG9a5BVgC8dxzqCuawztO69LLh
         B0KAlZIPG/eJ8EhO0qJt3aUku/c2mVLP+9DKJNWbRZ0HwFyr0GoFtkC0d9UyKfjIaRYw
         CN5iVjcC6eIHHAPzQLO9temjFaYm9q3LBeMIuR+wUfRmPPjfB3vkJXdPex+Q1Ihmzmit
         d2dSE7FmsTz8p/5LHLG29TNg8TEMqLBgraFWjjrImyPvDSWdbWvRugjhkPJfS+uB9xGt
         BE1Q==
X-Gm-Message-State: AOJu0Yz//gLVw14ssSMLhJN+sSItu+bYaTIleP+CszHeI1B+Lgw5Dywt
	cGwShBnYd7Wn0tZZ51XB1o8RepFlBnIQahVGMxYJS1NUbd4Z1YioVIScdjWYEw==
X-Gm-Gg: AZuq6aLob78+8PSdvAw5Fvfm/ask3OiqVoqIJ7kXZMGf9WDMErcjP6gPi9SY906MtPF
	rIYNQWmcS6uihTDOyKQJI0DLqJ07qiLA/FMoyX6EXauYfcz4jvR8MNLB3WQoLvzEVb3guBHN6Uc
	eNTkjvY4R8UOOytfUr25vikQa7ATId1G6c3Qm/hJNIKJnn/PBamrh2J+H6p0+EzJg+FVm+BK64T
	c9vew6QQ86AKM+/5uSa//mopV4MTi49EmZxTysYWCzN539/kcHz/23v4OUfLadMJTVQdC5mm+vs
	BENFGbGzWHxRb9NY3p7Savv25CpXFoK1EWH53mfCi/KDfFkCWqf4tR/UsxcyMqpsxHcOwKDfI/+
	FFTqOKnaIOjEksh/s5zHVQT5sN4hgyssOv+9sjYLOcvhPU7oxiFGkDJPi/eojuiVq/7nxbxy8wb
	7tifXml08tIvL9YzNdZhEeNbSwC4bNsdz1cmVwavGYiVTawfJd7pgluA==
X-Received: by 2002:a17:903:b07:b0:295:9db1:ff32 with SMTP id d9443c01a7336-2a7175c4de4mr125725985ad.48.1768900974617;
        Tue, 20 Jan 2026 01:22:54 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:54 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] macsec: fix memcpy with u64_stats
Date: Tue, 20 Jan 2026 17:21:31 +0800
Message-ID: <20260120092137.2161162-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120092137.2161162-1-mmyangfl@gmail.com>
References: <20260120092137.2161162-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered atomic
against u64 values. Use u64_stats_copy() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/macsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 5200fd5a10e5..c2cb2d20976b 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2806,7 +2806,7 @@ static void get_rx_sc_stats(struct net_device *dev,
 		stats = per_cpu_ptr(rx_sc->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_copy(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->InOctetsValidated += tmp.InOctetsValidated;
@@ -2887,7 +2887,7 @@ static void get_tx_sc_stats(struct net_device *dev,
 		stats = per_cpu_ptr(macsec_priv(dev)->secy.tx_sc.stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_copy(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsProtected   += tmp.OutPktsProtected;
@@ -2943,7 +2943,7 @@ static void get_secy_stats(struct net_device *dev, struct macsec_dev_stats *sum)
 		stats = per_cpu_ptr(macsec_priv(dev)->stats, cpu);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			memcpy(&tmp, &stats->stats, sizeof(tmp));
+			u64_stats_copy(&tmp, &stats->stats, sizeof(tmp));
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
 
 		sum->OutPktsUntagged  += tmp.OutPktsUntagged;
-- 
2.51.0


