Return-Path: <netdev+bounces-224852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F5B8AEBD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F437C3CBE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5DD205AB6;
	Fri, 19 Sep 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZUlZP1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096C2AEE1
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306714; cv=none; b=Rz9/fxt/91626oSXwdH3og57vJH2bCWDb6q8D77bvYsP221ipUfgIPh1rrTITjSj0N9spV423apRRcb9mpTVpPvkwNFwkDMZ/Cwb6c3dpIJRCLZ3B2mwWY1LbdFcUFt8E34nNIsy+0xKAnhKLRkdDKYD0O9QGNcCQoPXF06SsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306714; c=relaxed/simple;
	bh=NtQC/MmlK7h+ZKGq10SDYcJ+Z2kx1r11RyDe42/+ZMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jT/u2YrSlatWO2OGtZEs4XCRX3ZNtnogDXChLrs1jHtBYUMcgalPX34A7InK1vujxuQO9Cn9kMAzOynlrQNv+fIyLYk4TBCoGI/aPL0QGwsTrUwxXcg7TmwWCnFrl4hi029EkHx27PLOd8zMv37NHT2nf/v03ot6cVQwpMSIaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZUlZP1Z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2404355b3a.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306712; x=1758911512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=HZUlZP1ZTH4/iPzuQuz87wPuBVcMxuKzbq56sKhe3nQPAu8Pn1Bd6EVDt1aPg22yw1
         eSR+aKT8vrMs0IFCGIFnoSXqorcm0JAk54Ezegc4162KfoHgk3P/rsg4u4lLbQS3T+bk
         DQT6xfNzQmngeUgdXSilWW2pycwoykhIqxWlDHEVvPfyg6d3baudbGafx2E+RmpxkWFU
         IIQAkEMyX2TFOK+6NSMt4PCJnugX900lerFnWg265aVeSiCdDyTHocJ890OHUb8RWtLQ
         Nz5T4c+6/1syO8VevSaRgAEDo3rwKQo13g/N4jWfLBNh0z6wew7H4Ln5ez5O8d190Kay
         ddxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306712; x=1758911512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=E/3ZgIloa6t1q3Ve9NMyh6e0WziiczfU4ChKBcqHtnWwxVFstORNOGo8XVfQTAAApu
         WclWlARm5TJ8H8svNb3eDz3T0oEd28Ek2oPBYKYacFCjW/50bP1WxeHRT77+Le7ME8K3
         hmuURWSTyfGkTkbTn7z4W3Tmr4dBUFzNFpGNrAIxXTd92gHWSmbg9KOQFdtv4nrdrhIv
         rNwPmgXnFfmih/aHTzq5wykneiJ3ICK8oL9QA8pQbLVo8iXapnvJgTfBpr/i42QmxUaD
         s0I0GHDtxnVQA/9zYQpbwz+CC79C3DFtXbL67vTokatm0SpAwOu6Pl3mDiuvLfQtQ3kS
         0B/g==
X-Gm-Message-State: AOJu0YyRemkLmSUuY0+LyjQYtFhMZ2rkVbNfGvQa+E8MOtOygjxdDYur
	F5EOniXg0XeOOpKwcnJNDxBx1omBhJg8qHtVj6X+aK2QqtIGALSaxzw5
X-Gm-Gg: ASbGncvchhuQd3m5c9HwACG5Enk2EZS46AT6WP1fHZDLIevM6rF08qJ1m0k5VrdbZ04
	OeiNoq6nI1IS934ZyhRmkIFzLViamyzs3rFKlGA4kB/77G84HuLBG0a65RrfIT2SDr1dNCiYgg9
	4cRco6bweHGrU/0NgoXVdRdu59ED18ifOw2iThi2nnc0oFt1MBiT0xgntldIW24LDiPeOU1qlkc
	f1c5muytlNCcyjqkEw8ckTNNpD3JpQt5u+LJpkpiOSnRMPdXjfoMiEeVPVbR2qJuvC+SxnUEetY
	vat7qmqt/cM9oNGr8gjzCS/YE6DncjiXGQItZ4DHsnqW6HFSkLlo4/7X8MjzeqtSpg1VnwvcCtO
	gg+lQRB9iusG/LFdR7qaROfOoV2s=
X-Google-Smtp-Source: AGHT+IHKk1C6demLZSfQaSYDHM7x+46+mgzS0jEkowBppkgliAtg1CGYcuMNU68VKc1FYbdwa1S6tA==
X-Received: by 2002:a05:6a20:7d8b:b0:243:b089:9fbe with SMTP id adf61e73a8af0-284681cabeemr14558643637.31.1758306712226;
        Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
Received: from gmail.com ([157.50.36.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552fa85110sm538758a12.45.2025.09.19.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:31:51 -0700 (PDT)
From: hariconscious@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv
Date: Sat, 20 Sep 2025 00:01:46 +0530
Message-ID: <20250919183146.4933-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Syzbot reported an uninit-value bug on at kmalloc_reserve for
commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'

Syzbot KMSAN reported use of uninitialized memory originating from functions
"kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()" or
"kmalloc_node_track_caller()" was not explicitly initialized.
This can lead to undefined behavior when the allocated buffer
is later accessed.

Fix this by requesting the initialized memory using the gfp flag
appended with the option "__GFP_ZERO".

Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
Fixes: 915d975b2ffa ("net: deal with integer overflows in
kmalloc_reserve()")
Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # 6.16

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

RESEND:
	- added Cc stable as suggested from kernel test robot

 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..2308ebf99bbd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
+	flags |= __GFP_ZERO;
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
-- 
2.43.0


