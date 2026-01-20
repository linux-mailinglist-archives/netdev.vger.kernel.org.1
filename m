Return-Path: <netdev+bounces-251407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D673D3C3A5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97C61524719
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462E3D647C;
	Tue, 20 Jan 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiZe1j/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E43BC4F8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900973; cv=none; b=hfyJ46zxfLW0jlvlSWnHOucsl2J1fQvPNg+uQQ69W4c3oG+lNj5q9EJRazifwnhNgcxFiXRHhhGwtmn6RHXbNAcA+hYdaN8UB/damkF2djbjTl2mYRfFRJ1RiQd9UsnS1jff/OCBs0+w09658Z0BwOuaALpRgbGESwP+Roz5Zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900973; c=relaxed/simple;
	bh=LFXvvsnSHomS3qAx5n0cKtlDgaxDB0LHfzSintTiwXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqm1yaLHLg+LiJnH5EJvlhEayRUNY5gPqknzbbBNYqs4dxWxOMFOIw1ngQuG3h+VGjBQhMU6VxCTFERdGnI2WJW7SFS5XiQ1cY5DG2BxIIjLjztl0NqfL59sDk6IEBYnIymS2BJNxoJFE+iVZI6rXZXDXOelJE1uGxNl5j8THSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiZe1j/B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0f3f74587so32464205ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768900971; x=1769505771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a8I7+iCrEMhwpiceFoy5kG8jHorqo1UmmUWGOAZBtw=;
        b=fiZe1j/BXr1FrRzwSLfhD1ADVYsuQtfaokw/bq4udTp3QyS4GU914y2+kKVUq2X43m
         HakVM2oqcXyRHiJjHn/GIN7xemP0chYox2G6aiU4y8PFdOhPtseo8GUqQKjrylOItg5k
         8eBhbfVaBp/cVp7wJ1/08rYxObD4hAnMXhIG7dNo0SV93LSCTx5u9hZC7D7nLJq861Ew
         xXdrfYlPYtiMt3MHOaVhMQ4gjWsNua3J6yB6CehA3ibqdSvCVLYk7vo5BMwcfvXDpQJ5
         ZTCUILcBFira8rMpECLmi8tL0u9+8/8B88XnCInDiXiJ6pDOIj7ENjXK14IJgvKMH3SU
         WzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900971; x=1769505771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7a8I7+iCrEMhwpiceFoy5kG8jHorqo1UmmUWGOAZBtw=;
        b=e7li+DDPjTP8rrD6efAIyB6f+0k9hsYt8jNgXPiX0dnzRUXapLZQKGf+/I0stye/r0
         xSldSVrL56P+dcjPll61yXh8xiNEq1ul8VQGxlb/zfCF9G+BdPtUcDf7Xn79Hm8mj1eE
         khlepO2fFh4TwaEf2KvnNdHG99z8YcRNIxs10EwRiayj4SWh6xV0n+pJ/QgD5e+B5fXJ
         GoJpMgNxd33E6RZpc08F1jdVe5ggMl/wgrw/C9+cKr6h+jnCB4wBZtSHLOd4NxfjGU/E
         fTe9zK/SoQ+E9eabaZOWn+3/wt80OzSkfnvObSESQ82jBLhRf+GzA7jLj4C81DzWBqbu
         cGtQ==
X-Gm-Message-State: AOJu0Yw5LpZ7dliFTVzw6rlfKn4D0PKjI+jXc7Hfyiy4IGLfZCBSf8K1
	lF8vSTuViPUH93YsyKnpNviPFVTJde4+YgRonHSvQznyoiTkOBbljn0KmMNVog==
X-Gm-Gg: AZuq6aJ5n+QdHQTJ6MW5R3j4gSTzlNPV7KbZQmbhAV2FjWYUL700UJKmCKnEhAyLc/w
	nDfQUy+B3oPHoqF6EECgVPvFKzcy67ZHvavtV8Ohbsdy3J4tkM0R76XAY+V6eHuKwOfLiuJopq8
	MQ7IGRj5W5LXrzDyBJACZVRmKHqD5uiMtXCmu5DD6bqOtHdMAgkaNuF7MgKjz4w1RSTaKnWnGY9
	pAfKhhS1Nh81hRRmL3v0HgQmMptbg5aLS2Q/Wf0WU6YoV5drXl1JOd1z0p8oxgvVrorn1H+0nae
	rnfl1KsM+CmCnkuJKiyom0TiYf99NkWo92d0rO7ATUInWkMRXq/DdZ8XImNPno/A4Yr317825rk
	JHGFNYSwRDPR5l6wB6Q3eb6zdG9v3s2x6DE1e+W6PFokmbnYTbdhZLJ/Q4foZTnRmsP2YkqAkVk
	3Pk8DkgSxIa8RGEvNKnXRUAFzgd6gX9GLxtbl3ttyiRLmVywZeyWajLg==
X-Received: by 2002:a17:903:948:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a717551dd1mr133844815ad.26.1768900970966;
        Tue, 20 Jan 2026 01:22:50 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm107330435ad.87.2026.01.20.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:22:50 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: bridge: mcast: fix memcpy with u64_stats
Date: Tue, 20 Jan 2026 17:21:30 +0800
Message-ID: <20260120092137.2161162-3-mmyangfl@gmail.com>
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
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..dccae08b4f4c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -5201,7 +5201,7 @@ void br_multicast_get_stats(const struct net_bridge *br,
 
 		do {
 			start = u64_stats_fetch_begin(&cpu_stats->syncp);
-			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
+			u64_stats_copy(&temp, &cpu_stats->mstats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
-- 
2.51.0


