Return-Path: <netdev+bounces-193368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF0AC3A25
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A03A1891BD5
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B113D8A4;
	Mon, 26 May 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PUfSEheL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEE25569
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242015; cv=none; b=QHN9TQnjMeD1VuRl/EVLfm5DpSnd0DtbEy53ysCIBOWUadq3Xg72H0b4RodCZu95qIpeAf1VR/JpJIA9l4oC2+LbcEsQ1sjWfxoJYKY+Kmt8+v1Z9ib3FtlW4Ep4X//HysQ8J15ySuGZ5iu1XwesIQFSG5qhU3wJRGS2XYIt20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242015; c=relaxed/simple;
	bh=zF5a6CbWQaQ1v8nXdGyp0eEQDySwSivavhf1guhcNnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zmh3AhNalLHvcj3QdHlMJDdjufcjUkJdWdsrvcZjLEQyWHS7VyeZiDbwLfSSd9bRbSlIWPwUZjeykbGvL37vpKLPKaWtUjvpB/kgT9Bddo5qle/CDhse+AyeyyKpO1LN1SXQgm60C/YEyMvNbzndVi9iL3RgyHunwiZpnnpWxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PUfSEheL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so11479105ad.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748242013; x=1748846813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+feYia0z4AbJzGUj7Ynki7IIualikheA0eQ0iNGi48=;
        b=PUfSEheLhhKTPjLRimMWG0xFtWIGnBmxvz9+h/3tq647jFETx9UEQPtvnk3uXwRzM1
         WZV1Jw4NshEp77P/0xyShxEXFDwbayzJd+YwhTHLHYAjFNFDRZxhRjR2ZlpssTWN7Nd8
         uHm+19yDa5BOtfh8bvOkuOlKxCF9Hu+BKviHmlFe9NW5WDiuwOS7vaYugyueSd0T2oCp
         +tcg/42hsvCFc7/CJ42iEz96lYyomNQan4uQYy197En5U0X8DL8WNPX+MUHbfEL8z8jA
         DwbB87SEJGPrAQdH5ShHOCYmjF6rQaFi6DOSAMWIC3kKkbREbSnrq7e2OHd3DWYPbIj0
         7+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242013; x=1748846813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+feYia0z4AbJzGUj7Ynki7IIualikheA0eQ0iNGi48=;
        b=TfKviLE6EOQhvG+kUftEk6TMirVIY58yEVWpP+bOV+s/LCkjVyG4PbE+0kjEPd5bYu
         1EPCWqDBxsGa386xdnSUoAgg7WEHWEVyJyo5qS+iR/pPo5gq6tc7ZfHX3M2ga2CKdRd1
         X52W6BLz9wcGQxrRKk9Glh+hGtxTv699bqFE3/CHvgUD41js/Q139tD72ABj+Q1gah7l
         eHBz+1/dxU9SSkv39wBOk6LU4cGSE698wqw+DTLwXECN3SamP87Hvoe4oGacQxud4Rk0
         y7mf4mp+rmttoYKNS1fotleH8MTC27WJkeUAMzC5a2QJ/1c56BKdwJXM3hR5th47tMm2
         Lamg==
X-Gm-Message-State: AOJu0YytDX4GTpoAJpQb34CAiGJKOgqa4K5z2OJX95hBZ/WVbeAZmII2
	yAgUkSPDr/9h/o0wriRzdMpuodSN52bpJPxtd4/T8Dr+VS1m+j8COzk9c0gmvNgMAaw=
X-Gm-Gg: ASbGncsbyzjOTX0JPrzYydufleMZjvn/YIsFzEm3R8jBviZJOPXyy4hYlfI7sN9zAuO
	Lp8IL61Hv9aMj5wDcnEmxpDshIs0v53VnJyYOP7F0s/lN0oVRobw5adqEBoj31sDtJSuabVlp4E
	XpxT7qfc1M023sr4OSCPuN+iUHYoh0GLGnEVLffCnMvKg0pgji1cHYQadaBwEzcapSK4ckKjfak
	5Se09lEfQsmG5rKSRhd7QQJ8dVLvTzy96a9iwAl8xHb+fS+OThB0QJ87IoCDpr+YnLRHRyz4ndu
	Sm/3pn4cx/bpcX76QnJN7ej8QgggAg7rgPvNSVqOTIqoscFVWuChjm4PgvxstFEv0bwkGbg6lgT
	whU8W038q+iKU5A==
X-Google-Smtp-Source: AGHT+IHnoO5tLCbaoBLiTXZayzEX2KB9z6ecdf5HOv6WlNKWWxkB7PzMeH306LsSOdDaUJvdAxKi2w==
X-Received: by 2002:a17:903:32c3:b0:234:18a:d8ce with SMTP id d9443c01a7336-23414fce6a1mr113266005ad.46.1748242012779;
        Sun, 25 May 2025 23:46:52 -0700 (PDT)
Received: from G9X75MXGL4.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2345948c2acsm13570755ad.34.2025.05.25.23.46.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 May 2025 23:46:52 -0700 (PDT)
From: <yangtengteng@bytedance.com>
To: edumazet@google.com,
	kuniyu@amazon.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	wuyun.abel@bytedance.com,
	shakeel.butt@linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhangrui.rod@bytedance.com,
	yangzhenze@bytedance.com,
	yangtengteng@bytedance.com
Subject: [PATCH net-next] Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated
Date: Mon, 26 May 2025 14:46:19 +0800
Message-Id: <20250526064619.5412-1-yangtengteng@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tengteng Yang <yangtengteng@bytedance.com>

When a process under memory pressure is not part of any cgroup and
the charged flag is false, trace_sock_exceed_buf_limit was not called
as expected.

This regression was introduced by commit 2def8ff3fdb6 ("sock:
Code cleanup on __sk_mem_raise_allocated()"). The fix changes the
default value of charged to true while preserving existing logic.

Fixes: 2def8ff3fdb6 ("sock: Code cleanup on __sk_mem_raise_allocated()")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Tengteng Yang <yangtengteng@bytedance.com>
---
 net/core/sock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 347ce75482f5..b817ac711bc9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3235,16 +3235,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = false;
+	bool charged = true;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
 	if (memcg) {
-		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge();
+		if (!charged)
 			goto suppress_allocation;
-		charged = true;
 	}
 
 	/* Under limit. */
@@ -3329,7 +3329,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (charged)
+	if (memcg && charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.20.1


