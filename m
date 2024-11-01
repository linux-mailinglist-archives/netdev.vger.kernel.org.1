Return-Path: <netdev+bounces-141084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3D9B96C6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 18:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A00B219C8
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEED1D016A;
	Fri,  1 Nov 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0YCWgtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7A1CFECC
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483280; cv=none; b=CNeckFbeNsP2ZY76bx6yCKQZBLxOWypTNjkSecH4AeKQEBctF0OhZg92fMMy7Y1SuXwV0vPdVnYr7x+ELsNxO1ClepjZg8wv+is5JzW0BsL4ztNoRtUNmnLc5lQPvgnuTCHZrDxtSWVIhg71nTTWvYzrnc3cYhDjlp/GZAhM2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483280; c=relaxed/simple;
	bh=5xHVsHQ6fyrEmYUbTV19aIvyhwFKXboCyPGng56DiQg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r6mIUWSyzlxphjCPVVRuEmf86JPQP4yJh6ycckwDVPMWOTuJ0qZ4anJksk1e7MarRh+wxMG5aeTFLaGxExPjjRCS7lQ295Xsaxwj2j9arLJtT8wN4ud/QBm9cNDCgHUrV3O/Vu5JkiiS75s60B18kMYdtfj8G0LpNF/AzViep8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0YCWgtP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7fb84f999so37716967b3.2
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730483278; x=1731088078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+UyVokvZMbANQodYncX9IsAtjePK+wXNbymoNpX7T4=;
        b=l0YCWgtPAN3r3gOnUN3WnCiJ4mLZ4+Cw3NLcm2bb9+x/cfZTLc8TaIFWO2EqE2Wzzx
         83T3QYIRdsvVgO5gTnsBhho2OQvPG1TNB9Zrpw4d5ptQKIIZ+GC1bWL2sszFE/55r/yG
         GhtxMbUvgcl1AVDN1GsMHT5iS9KBcUDE1e7fRtmOjyIy2rEKhEBgtaf7wFjPxxMYaNdv
         SfoWUPbr5ZZfQyymdY5tgXi49aU7g83tUPnZLpFf90GIBesNpDFfDndOXqfgdXSSq8w7
         b1PEiXBdS+0Rn8imTDIBy3PgbqyUg7cpL45rjvhgjO3xsrbAtX3UzDjwMhJszDy7thY7
         hMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483278; x=1731088078;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+UyVokvZMbANQodYncX9IsAtjePK+wXNbymoNpX7T4=;
        b=tz15UylK+yqhzGwZnUkt0TFeNPgt5JGPrAAZPeHZFkfjT1/XURMtxNXzWkGVM+v6JJ
         sy+3tqOU8f7Mulrz6lbYsW+CiMeOEIxg3Be1oeWPxVPdzQJUFz5bNIBcOV1rbjZIMCNQ
         2M+oatNuw7tF1P0Gr8WFZO9KS/SESBpmqXjQiMtDku82+KWr6R2XsiDM8v0iaBwjTsTx
         5/ppMjnagFtY4rokAM2j10+E+wlaYCvGf1IRE9agZ4ncTEwtFlzCvcR0HNKz2kgPfbjv
         sMNiZ8tSlOwOXo4c7yx55SdbjP8gzQEYXmCJl9PMV+a5MhH9+9BqAwaNtxhoxZ7JzjXo
         7uAw==
X-Forwarded-Encrypted: i=1; AJvYcCUYy/o8rsc6hsiToxjSte7zXXUDtGYfjtoBigPEiZXvUzwKQc50KgV1rkh2SlnM40kX08zoMJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5mpk/Ok95Dojw230c64+aDkSnShrj+eL97Di+6qJcMRqiKWg
	96oP6wUaAAbhfrOJyYxHvOUIUWPwxeBn844HXHevJigJ/ZbzOqUuwX0Vho9AMFpLIi5ldMU+1Ju
	Uhz4EixMNFg==
X-Google-Smtp-Source: AGHT+IFE6jWkvJsXQZTs/bbvpuvGaM6CNSPtz/bEQhcaDHJ1xCJQb+CqyiHA0xXF3zhU6IfPnNqLP2tMn5i01g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:18d:0:b0:e30:bf92:7a64 with SMTP id
 3f1490d57ef6-e330253e637mr2620276.2.1730483277792; Fri, 01 Nov 2024 10:47:57
 -0700 (PDT)
Date: Fri,  1 Nov 2024 17:47:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101174755.1557172-1-edumazet@google.com>
Subject: [PATCH] iov-iter: do not return more bytes than requested in iov_iter_extract_bvec_pages()
From: Eric Dumazet <edumazet@google.com>
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot found a way to crash UDP sendpage.

Root cause is that iov_iter_extract_bvec_pages() is returning more bytes than
requested by ip_append_data().

Oops: general protection fault, probably for non-canonical address 0xed2e87ee8f0cadc6: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x69745f7478656e30-0x69745f7478656e37]
CPU: 1 UID: 0 PID: 5869 Comm: syz-executor171 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
 RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_page_unref include/linux/skbuff_ref.h:43 [inline]
  __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
  skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
  skb_release_all net/core/skbuff.c:1190 [inline]
  __kfree_skb net/core/skbuff.c:1204 [inline]
  sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
  kfree_skb_reason include/linux/skbuff.h:1262 [inline]
  kfree_skb include/linux/skbuff.h:1271 [inline]
  __ip_flush_pending_frames net/ipv4/ip_output.c:1538 [inline]
  ip_flush_pending_frames+0x12d/0x260 net/ipv4/ip_output.c:1545
  udp_flush_pending_frames net/ipv4/udp.c:829 [inline]
  udp_sendmsg+0x5d2/0x2a50 net/ipv4/udp.c:1302
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x1a6/0x270 net/socket.c:744
  sock_sendmsg+0x134/0x200 net/socket.c:767
  splice_to_socket+0xa10/0x10b0 fs/splice.c:889
  do_splice_from fs/splice.c:941 [inline]
  direct_splice_actor+0x11b/0x220 fs/splice.c:1164
  splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
  do_splice_direct_actor fs/splice.c:1207 [inline]
  do_splice_direct+0x289/0x3e0 fs/splice.c:1233
  do_sendfile+0x561/0xe10 fs/read_write.c:1388
  __do_sys_sendfile64 fs/read_write.c:1455 [inline]
  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17eb533ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeb190c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f17eb533ab9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f17eb5a65f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000020000023893 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 lib/iov_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65ec660c296065a22997a3727087dee8f3906aa5..8d4cdc295913fdcb4339b75575e3a72f0dbcaeae 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1728,6 +1728,10 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 		(*pages)[k++] = bv.bv_page;
 		size += bv.bv_len;
 
+		if (size >= maxsize) {
+			size = maxsize;
+			break;
+		}
 		if (k >= maxpages)
 			break;
 
-- 
2.47.0.163.g1226f6d8fa-goog


