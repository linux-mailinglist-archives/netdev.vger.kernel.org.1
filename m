Return-Path: <netdev+bounces-172807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35438A561F8
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00B41895EC7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2221A841E;
	Fri,  7 Mar 2025 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwbx1LEr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD325191F98
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333388; cv=none; b=C+tl4FxcnBKpsbYW989ZaqXHOJYeAOo7fLCLED6qGiK1g+8EYUHBBfdLBI12LvwLU2Z1Y98eW9bovfIz4vsSO66S5OMIBrXmkSj761bbedfQQy/ly/ghGmI3gT878MeHn7SluXdBzOc1sbLIGkzZF5LaQneHO+prHyL80iWboNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333388; c=relaxed/simple;
	bh=9Nqc+tO1hM8MWwRmZi38eC3ZO7JmfObfCZegAhk0xZI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tcSfrKO7KWEATeLUfedJBe0CPw17AukrfJQXkE5+w/aoIPLLlM4UKsWiWK2uHN0rWLytZvCIjWBhI9Gb8413jXRgjYFG2lzZI9XXib6GTFD50OoF7fZWwE97qQuxWWICAY76nPNNlotQ2Kan29V3ESwcWsFhv9yu5r2zay4oYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwbx1LEr; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47506816e5aso32994131cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 23:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741333385; x=1741938185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdgpV3n4i5NtKHpcpjTiot278/Wco314XmGh3EMzly8=;
        b=kwbx1LErxtTIV9Kb2JvcnKt07rTss69+4FMjMrxwp1TadPJuciJQJJmE0NhzPnyLEG
         gqUggEmQqbrlqo1knaQi7CDoXxO6+V2wTNK/cv3VQNPDs/0N/yeL74W9wQzarjgzZEzp
         clByqy54lE10ghZT5aa0v5Dm/F6fom+uLg8qPPTN8//Zh8GZpWVcUW/o1aeZT7wSSxV7
         bBqmyPKaEBBl/m0+DRUQdr4oFyasnZ9D9Xs8w77VjCgBa50cEFD7f7Os9F8U6iwun/87
         9P6wuc3mf6ww4OcqSukyTjJ39n0dMTAtZZFy5/G/I/1m0mfYPIRKL1S97acbIOycBgnM
         cNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741333385; x=1741938185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdgpV3n4i5NtKHpcpjTiot278/Wco314XmGh3EMzly8=;
        b=mvom8AdmtPRxEyMkhkYZTtoZTHPVDolQpoZl9bTlYY0T6oaHyKtPnyhP+3bIDKc60h
         9YCnqxx9+hbMfxza3D7LojbbngudCwZ7ESg/OKspTOe5xH2EbnUGyS5E3RS/etIpQV/+
         /ptZcPehIWWDJ3kgQg+phqVwfOxD1t8ed65Wzehr+sX9+XdsrxUq2igRnYRaTYGB80jJ
         dARUCqAF23HToQMq3cHwgXSeINKZnQKZ1uw1/ZJxFaI7dSH8rTkD5bdsa9OX9xdEFqnc
         hKU9vMaMVaBEjLgNwYGCbhWkb4jrPL9u07XuB8IXMqTjnXvUsIxFjTnN3mW/wbA5nUHb
         9LyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqpAII5DALroQ7mmk9xC/KLCMcFHTBySfLhLQj3YoGbdpOoWjjepIdMOyyfWq6WYblmNgXEEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FvjrW+jqLjfwS8AEdKyJW7Dlds1R5r2LEGpB6BfrF7gO3Ncs
	FEtcWpc7n2Fmix4uzS5sRPtzcVe8V8qdCHKTmS6T6rTzjKuWz6XMGR85IpHwlbwvsBPS3dnRL4t
	HJSYAf1SKSw==
X-Google-Smtp-Source: AGHT+IHdum8nfr2287PhfCfEZKMi5n/cfhVEWtPqpcj5NDBu+CHolObym/0xL+XQGYH3q6+1JebVbPAD6ktLew==
X-Received: from qtbeo13.prod.google.com ([2002:a05:622a:544d:b0:474:e62f:76e9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a48:0:b0:475:6bf:ff59 with SMTP id d75a77b69052e-47618b3cf92mr24039601cf.51.1741333384736;
 Thu, 06 Mar 2025 23:43:04 -0800 (PST)
Date: Fri,  7 Mar 2025 07:43:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307074303.1497911-1-edumazet@google.com>
Subject: [PATCH net-next] bpf: fix a possible NULL deref in bpf_map_offload_map_alloc()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Call bpf_dev_offload_check() before netdev_lock_ops().

This is needed if attr->map_ifindex is not valid.

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
 RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
 RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
 RIP: 0010:bpf_map_offload_map_alloc+0x19a/0x910 kernel/bpf/offload.c:533
Call Trace:
 <TASK>
  map_create+0x946/0x11c0 kernel/bpf/syscall.c:1455
  __sys_bpf+0x6d3/0x820 kernel/bpf/syscall.c:5777
  __do_sys_bpf kernel/bpf/syscall.c:5902 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5900
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
Reported-by: syzbot+0c7bfd8cf3aecec92708@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67caa2b1.050a0220.15b4b9.0077.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/bpf/offload.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index a10153c3be2df675af49f0ad9c70b64b83593f45..4f707cfe7f103c8a480d534cddcc75e958f0bd57 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -530,11 +530,12 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	bpf_map_init_from_attr(&offmap->map, attr);
 	rtnl_lock();
 	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
-	netdev_lock_ops(offmap->netdev);
-	down_write(&bpf_devs_lock);
 	err = bpf_dev_offload_check(offmap->netdev);
 	if (err)
-		goto err_unlock;
+		goto err_unlock_rtnl;
+
+	netdev_lock_ops(offmap->netdev);
+	down_write(&bpf_devs_lock);
 
 	ondev = bpf_offload_find_netdev(offmap->netdev);
 	if (!ondev) {
@@ -556,6 +557,7 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 err_unlock:
 	up_write(&bpf_devs_lock);
 	netdev_unlock_ops(offmap->netdev);
+err_unlock_rtnl:
 	rtnl_unlock();
 	bpf_map_area_free(offmap);
 	return ERR_PTR(err);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


