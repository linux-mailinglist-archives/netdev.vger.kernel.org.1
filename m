Return-Path: <netdev+bounces-147954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347B9DF63D
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F66B21496
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B51CEAC0;
	Sun,  1 Dec 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+gBr7Th"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7252AF12
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733066873; cv=none; b=II6GwR+Kp+p4K8ZjxJ4zRTsRb859iAZyB8/ke3GB5/Nx+zViVS15slNkK5wq4xXXbBmg+5vTCJ3eemWdrjQm2oFBjQsa7tBDd+JdxrQTUY+m5jawm3hMUs6evgs821VWujjISg6WuodvZUjPIjwlRdG34uSTFNNcJUQCp1WSfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733066873; c=relaxed/simple;
	bh=6fxTzoJc3Y99/0hpVgtuy6LFCnnyAcslax14xACw2lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tiz0iJhTXloCuZ092DIfbzL2g5+QH9scJx87xkRg2nzapmsoBHSJdZwUJHpmtgvTEZI8IHOpiMkJR+sJkIqhO2uSIFWuOrN/H1CfILDl0k6+Ve+YpR5DjX1A73rr7TK1Xjy4GC6QYynNnX4uiJaqJKx1gY/9fPyJDNU8ZTT5hGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+gBr7Th; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733066870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aR5us1W0Gn65QtQ/cPL2gnl8br+TunRBxT3qGj01h1Y=;
	b=T+gBr7Th9srd9IXgJLuQxdIw+yoe+e/bkypKTeBBKYbtYMz0x0Y23b6Wz9eJXFImVUYUYu
	I/xfhBkZoctc/U08C0nKFfsAIBcYAvpMbRmWfnz8bYzBep1qENeQaHnurlLZDUGXUtOq+l
	+eI3KeTr6Jl+aahJRQrxWYgATPsL9D4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-IiY4G3NmMF6MAdS7NOM3fQ-1; Sun, 01 Dec 2024 10:27:49 -0500
X-MC-Unique: IiY4G3NmMF6MAdS7NOM3fQ-1
X-Mimecast-MFC-AGG-ID: IiY4G3NmMF6MAdS7NOM3fQ
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-724e4183211so3185141b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 07:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733066868; x=1733671668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR5us1W0Gn65QtQ/cPL2gnl8br+TunRBxT3qGj01h1Y=;
        b=Xn38kNd2Ql2CWvadi7OjvFwK5ruShlVsRDa0sefu+we87BysgacJvddYYMJ5wMCnzo
         15N7kW/F0gVGpeYsBQoFC/EVZlcXScufWTIF/vLRwNMB+Y9Jov1A9VsfUB7Uer7bq3Dh
         RYlbIs9OGinIYUpuK+VYBbo+LLepd552tc/voKkbFCazsfF7JX6eP5f7ryAD2M9Ngn7h
         AwOH4mzbwwOJeYA44AkDHgkVUzjDzooY2h5yJS5d9X+J5erFtYjZ+q3uG89BcNbiwDm6
         /6uhtPQyygxd1OHQhZIGG2ru3HdyiGxBBNbbU28BViKiE+hxwHH4AXHInJKgsq+3gl2N
         /6vg==
X-Forwarded-Encrypted: i=1; AJvYcCXIVCQuoD043dm5rGm5Fvo1ByuKwa18YHtqbiiJWOJ6D7xZeHKlwO9stYtFktM7Yr0f/u9NJf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1GYZhVVeQTWHRSb/u/EzNnXlRDmUo/4HPXHbNyBQoi1k61Sdo
	EU1E8sJnE8374AW4WGB36wyRRBKyeIAI8jTKNTaXKWiJ8cdIm61UegSFS3RJeAoRtQBp5/i6IcP
	4PBFKb1EizfnRH9gAHxKPcbPJJkGz4oJxI52puhg9oy0aJBuokl1q5Q==
X-Gm-Gg: ASbGncuMBnZ8/AF7YgLigqSduI2JE/lQW9YhMJ835fViU7EjKq3RVDTdo/ANF0Bo2H+
	AtiyEIU9FKGwml+zHRU1UCt+GGjzAhR2FhH/DQX644JDT7ebaHkwI5wESHicITy+AWCjIi4amja
	YxH7sHGNVmuXFYH8aHU7KTaKF75yTS5CKPjZEyEEwzzSl7ApqAYCnysprQ30Zdb7JDsR6AotPuy
	6y5sV9PQi7QsDVsyNk6EVVvXURiYy3xUj+owc9xRE7TBr7j/X/2//VY+ZHrMvN6FKNdA/4ZZhsz
	tjsncMI8/HgM7Yo=
X-Received: by 2002:a05:6a00:1a8b:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-72530074279mr24407107b3a.11.1733066868146;
        Sun, 01 Dec 2024 07:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW6MWlVfLoHpajZ/LFzE0lA9yOz+rG4Bd2MPD94OOZEk1R1Joia7M7IqxEthR7RYSJzoRuqQ==
X-Received: by 2002:a05:6a00:1a8b:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-72530074279mr24407065b3a.11.1733066867811;
        Sun, 01 Dec 2024 07:27:47 -0800 (PST)
Received: from kernel-devel.local (fp6fd8f7a1.knge301.ap.nuro.jp. [111.216.247.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762411sm6975447b3a.20.2024.12.01.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 07:27:47 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	lorenzo@kernel.org,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH bpf] bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
Date: Mon,  2 Dec 2024 00:27:35 +0900
Message-ID: <20241201152735.106681-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
cause of the issue was that eth_skb_pkt_type() accessed skb's data
that didn't contain an Ethernet header. This occurs when
bpf_prog_test_run_xdp() passes an invalid value as the user_data
argument to bpf_test_init().

Fix this by returning an error when user_data is less than ETH_HLEN in
bpf_test_init().

[1]
BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
 eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
 eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
 __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
 xdp_recv_frames net/bpf/test_run.c:272 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
 bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
 __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
 __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
 x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1056 [inline]
 free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
 __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
 bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
 ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
 bpf_map_free kernel/bpf/syscall.c:838 [inline]
 bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
 worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
 kthread+0x535/0x6b0 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014

Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/bpf/test_run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..756250aa890f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -663,7 +663,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
-	if (user_size > size)
+	if (user_size < ETH_HLEN || user_size > size)
 		return ERR_PTR(-EMSGSIZE);
 
 	size = SKB_DATA_ALIGN(size);
-- 
2.47.0


