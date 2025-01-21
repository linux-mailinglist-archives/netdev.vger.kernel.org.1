Return-Path: <netdev+bounces-160117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DFA184FE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC56818837DC
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97E1F543D;
	Tue, 21 Jan 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLHEiXli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA51F5404
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483168; cv=none; b=uM6GFLSw7seXjX3jcV/idPSIuk65m/19Rr96HUX3Q4oMvtRQH6LIDpGOddLbwwQcZeTcwcfq/xSdzA5KD0gsHtC2wz6cyTsi/pMv62h7LonqOTYQwIo7cca9nq+S8Ju0cIUiGIlT0CC7v3AUk+Tj088iaTgNuCpBgTeAjoTW6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483168; c=relaxed/simple;
	bh=NqU9Nhcw8jS4n3k1py032pPQRaIUf8lT5Wu1wM+wx5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MM+B14OCMxNf+lHZIfGeygnzzISStVoLOl9fGitSYzXSsfS85a/wr+6RjST+rUBB4CiedGDZ1WEAyuel1JfZCkmmOEnh2JntewrICyk2v5DmM54SP9jPCZ7BW4zGl5N3Lm0opKdC8pdQ4cSJfplkuNiFA+4aZWusZQIaSVId5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLHEiXli; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46792701b64so112395481cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737483165; x=1738087965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F49SqiWB2hQ+hvzw5uaumco24KHl8oTyIiEtXh5e7wI=;
        b=pLHEiXliOBFL9WSQB1RA/8741fFDxNzDBbvWIYs6KJKoMdF+5E63BpJ48UWgGt7D6o
         lrw4CzLJ/eHZ8MwieW2D0yYSEa05x0f09jc29EC++NwmeqGvpWVBF4YzqDlscKbtbI8V
         w6Z7cfmnFN9ozLl+Vm/U2FwCdjk1du5/JbLdd7Q84LEL4MzaXGg7f4lYhslFIFvhY0A3
         S1iBTIVsCeulETUQsbGkgzr9AzQjHS4lQRXmkycKiH7s8mm/XsYLqCUF7EOFsdTzsf61
         Z+4E/agewSsxgkXFW46c3UGKe7/zdcEuhDXWA6DKpfq4PAhcrIjYnfLfxrsXgmGteuP/
         BR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737483165; x=1738087965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F49SqiWB2hQ+hvzw5uaumco24KHl8oTyIiEtXh5e7wI=;
        b=CARq5C9+32CRrw2Sep0n8gdSoDVcpacNDgXztoovoY4VTimiRAk8nOD7jtPuTg0zpi
         mkKAW5aOYzEP6oQjmRBMCB2iTmLbE/ZDE6BsnYWWXFe0hAcdpGuC1rjV9yXAV0dPLtBA
         2afeB2TftMnBxPL7CGFYnyuWkucIFnVDpMWjL8dDwykgiOnHVzxbUPTPePqUzBHt+bbY
         cjjMtVBZRKp2meyeSB/HSBGYg/ehCKcjhgPLfY2vu6t5Ayr+On6R12wpXKzEEyJzDtfU
         2CfpM1GNNGyLdacJhALLd4MpnAlrKrXyE7hGAT4KDQqtfH5IWT5Cv8XL5BDW1W0WhXk0
         wPfQ==
X-Gm-Message-State: AOJu0YwalxGMnb30cU5bhhNvZnRNGUbvo8r+fEXmWgTcQRnTHvWmTbM/
	BJehH4DxExcvFSXxaMjjVedeqYmtPW6gwo3sShQl5bG+M7C4CBFAiTSfs3Uu8isMA0al6Og1uuk
	RX8Jd2hp3sQ==
X-Google-Smtp-Source: AGHT+IFQ6ctZiB3LitdhtesWksjBmUWO2Tj6NcrF3CCDx445yxuqxZRrTsJ6MXbZD0sXKS4cEHKTEowb70zgVw==
X-Received: from qtbld12.prod.google.com ([2002:a05:622a:a30c:b0:467:975e:1ead])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1986:b0:467:706f:14b1 with SMTP id d75a77b69052e-46e12a253c6mr310225611cf.2.1737483165414;
 Tue, 21 Jan 2025 10:12:45 -0800 (PST)
Date: Tue, 21 Jan 2025 18:12:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121181241.841212-1-edumazet@google.com>
Subject: [PATCH net] ipmr: do not call mr_mfc_uses_dev() for unres entries
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found that calling mr_mfc_uses_dev() for unres entries
would crash [1], because c->mfc_un.res.minvif / c->mfc_un.res.maxvif
alias to "struct sk_buff_head unresolved", which contain two pointers.

This code never worked, lets remove it.

[1]
Unable to handle kernel paging request at virtual address ffff5fff2d536613
KASAN: maybe wild-memory-access in range [0xfffefff96a9b3098-0xfffefff96a9b309f]
Modules linked in:
CPU: 1 UID: 0 PID: 7321 Comm: syz.0.16 Not tainted 6.13.0-rc7-syzkaller-g1950a0af2d55 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline]
 pc : mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334
 lr : mr_mfc_uses_dev net/ipv4/ipmr_base.c:289 [inline]
 lr : mr_table_dump+0x694/0x8b0 net/ipv4/ipmr_base.c:334
Call trace:
  mr_mfc_uses_dev net/ipv4/ipmr_base.c:290 [inline] (P)
  mr_table_dump+0x5a4/0x8b0 net/ipv4/ipmr_base.c:334 (P)
  mr_rtm_dumproute+0x254/0x454 net/ipv4/ipmr_base.c:382
  ipmr_rtm_dumproute+0x248/0x4b4 net/ipv4/ipmr.c:2648
  rtnl_dump_all+0x2e4/0x4e8 net/core/rtnetlink.c:4327
  rtnl_dumpit+0x98/0x1d0 net/core/rtnetlink.c:6791
  netlink_dump+0x4f0/0xbc0 net/netlink/af_netlink.c:2317
  netlink_recvmsg+0x56c/0xe64 net/netlink/af_netlink.c:1973
  sock_recvmsg_nosec net/socket.c:1033 [inline]
  sock_recvmsg net/socket.c:1055 [inline]
  sock_read_iter+0x2d8/0x40c net/socket.c:1125
  new_sync_read fs/read_write.c:484 [inline]
  vfs_read+0x740/0x970 fs/read_write.c:565
  ksys_read+0x15c/0x26c fs/read_write.c:708

Fixes: cb167893f41e ("net: Plumb support for filtering ipv4 and ipv6 multicast route dumps")
Reported-by: syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/678fe2d1.050a0220.15cac.00b3.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index f0af12a2f70bcdf5ba54321bf7ebebe798318ab..de98ce66d38f39fd77650f5143aab8f91ced2fc 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -330,9 +330,6 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {
 		if (e < s_e)
 			goto next_entry2;
-		if (filter->dev &&
-		    !mr_mfc_uses_dev(mrt, mfc, filter->dev))
-			goto next_entry2;
 
 		err = fill(mrt, skb, NETLINK_CB(cb->skb).portid,
 			   cb->nlh->nlmsg_seq, mfc, RTM_NEWROUTE, flags);
-- 
2.48.0.rc2.279.g1de40edade-goog


