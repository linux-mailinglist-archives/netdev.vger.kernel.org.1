Return-Path: <netdev+bounces-69190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8DA84A043
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C561F22C61
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7216C4120F;
	Mon,  5 Feb 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJGwjaNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE9405FF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153008; cv=none; b=CLymeYHCf8vdD/gchZxfxA64Juyg/MXqgwSpXlqB6+2qW8AEc3UJWc0Y3Ru0wyCv/eVNRTWzg5ogXoiwOuJXVJ8BZMu88je8l2SsLjxMD8V8UdFjJS6txocFnEvQzqRcGgFOj76f5nt4kIEHyg9Ce9unXMP7hGNwhi4M0foRrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153008; c=relaxed/simple;
	bh=hWDQKfCierfVw0IFF01H86l0lO4G/Ft3WzcjCP7bPcQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WFbFFLu+1THL3ITX2YkPemDe5b1bdSc3350TzAJyT55n0gLsdJZxtR7Ykn5hMNDC/gJg8/Xy/bftPO1xMjhL4QkFGwrTOAPAmYHTB6t5u6+NiJ0i5v8EBP3jm3pQxTc8Co1hph1bBL5BLb+6HyeNLOd4810rG7Ji5wYRTGwB64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJGwjaNH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso5404656276.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707153005; x=1707757805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LpfOb7WMRuYannTjs/TFY/ECBdbI0SfdGhGuwju9Xc=;
        b=YJGwjaNHUAafAJtxOXX/GKIUTbkACdUdrrK0G2e7gLcre79rwNwcWq9hYzb5+ktx6J
         C4RTftEfpVAbxsrCy2b2Q7iTkEFjznSeqjMA3bloSLpqqXhWYNuS1VeiJO2P/WJ71/Ov
         YibG3BclSfgi6iybKReSIgh9U1r80fwXpKHaiF0BNs10Df5Ip4hOQM30dkqE243HQL0f
         qaUCS5q2JRv69SBklCCK5SU7ubThC2MTwrWOIoxWmAK8sYr98n7mK6nTC+wwS1G1J3x/
         dkM6D6MHFt89YrmuaDq6v+B69IaLKjvPKCnh72WcVoc1/iECRHjZ8oQZE2Bk1WSBPX1Y
         c7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153005; x=1707757805;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LpfOb7WMRuYannTjs/TFY/ECBdbI0SfdGhGuwju9Xc=;
        b=lKZS70UCu7q9bhS0hWjCtXmxTold8B0uOrVgHL1bXzGIj7zw0U4Kzwm67g4q5ZaQKv
         F7DfBQbg8kVnOHBhhaK6lm6OwNLXqDUQWBqiyRad16jlyzfivBf5/sf3ZItYD25oUnHy
         uc68wqbjUYnO8TCSchVG1Fp02Mvy2dbTznh4f5Ol/eK8PSnlAKE9ry5fQ5UU1/YLXYkT
         phtsw2LNJjFzJrc8P+W6/2W5Rk7h38aHD0e3+DgGkGpXIhVYXBoN6TZcbOTy12M/2IUZ
         JWpVtYKe4oZ2+lu4/X42UfLWI+mljeNYY7PFcmnuUmXCyx8Bz1iYcteoY8vWNdR3/vDe
         yWFA==
X-Gm-Message-State: AOJu0YyjkJvHNfWk1z6SOhAToH+5c1qEUPtNMDRDlkaZ1r9kT5hVEnEJ
	lmtfErW/5gxg78wNI4LGzKfw0vOFXHEBms+RhrmDqT01L5k2Knqwat1sEjIIuMXXICWP+3QpjL1
	M5B90kycq1A==
X-Google-Smtp-Source: AGHT+IGSmaJnQvl/W7srHpVNLJSrL//T6vCnTzTXsn81UhyYdsjJidTNqXjbJi6RWy9KHAFy4NL4CafVBUmoXw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2506:b0:dc2:3268:e9e7 with SMTP
 id dt6-20020a056902250600b00dc23268e9e7mr83ybb.10.1707153005691; Mon, 05 Feb
 2024 09:10:05 -0800 (PST)
Date: Mon,  5 Feb 2024 17:10:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205171004.1059724-1-edumazet@google.com>
Subject: [PATCH net] ppp_async: limit MRU to 64K
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot triggered a warning [1] in __alloc_pages():

WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)

Willem fixed a similar issue in commit c0a2a1b0d631 ("ppp: limit MRU to 64K")

Adopt the same sanity check for ppp_async_ioctl(PPPIOCSMRU)

[1]:

 WARNING: CPU: 1 PID: 11 at mm/page_alloc.c:4543 __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound flush_to_ldisc
pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
 lr : __alloc_pages+0xc8/0x698 mm/page_alloc.c:4537
sp : ffff800093967580
x29: ffff800093967660 x28: ffff8000939675a0 x27: dfff800000000000
x26: ffff70001272ceb4 x25: 0000000000000000 x24: ffff8000939675c0
x23: 0000000000000000 x22: 0000000000060820 x21: 1ffff0001272ceb8
x20: ffff8000939675e0 x19: 0000000000000010 x18: ffff800093967120
x17: ffff800083bded5c x16: ffff80008ac97500 x15: 0000000000000005
x14: 1ffff0001272cebc x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001272cec1 x10: 1ffff0001272cec0 x9 : 0000000000000001
x8 : ffff800091c91000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 00000000ffffffff x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000008 x1 : 0000000000000000 x0 : ffff8000939675e0
Call trace:
  __alloc_pages+0x308/0x698 mm/page_alloc.c:4543
  __alloc_pages_node include/linux/gfp.h:238 [inline]
  alloc_pages_node include/linux/gfp.h:261 [inline]
  __kmalloc_large_node+0xbc/0x1fc mm/slub.c:3926
  __do_kmalloc_node mm/slub.c:3969 [inline]
  __kmalloc_node_track_caller+0x418/0x620 mm/slub.c:4001
  kmalloc_reserve+0x17c/0x23c net/core/skbuff.c:590
  __alloc_skb+0x1c8/0x3d8 net/core/skbuff.c:651
  __netdev_alloc_skb+0xb8/0x3e8 net/core/skbuff.c:715
  netdev_alloc_skb include/linux/skbuff.h:3235 [inline]
  dev_alloc_skb include/linux/skbuff.h:3248 [inline]
  ppp_async_input drivers/net/ppp/ppp_async.c:863 [inline]
  ppp_asynctty_receive+0x588/0x186c drivers/net/ppp/ppp_async.c:341
  tty_ldisc_receive_buf+0x12c/0x15c drivers/tty/tty_buffer.c:390
  tty_port_default_receive_buf+0x74/0xac drivers/tty/tty_port.c:37
  receive_buf drivers/tty/tty_buffer.c:444 [inline]
  flush_to_ldisc+0x284/0x6e4 drivers/tty/tty_buffer.c:494
  process_one_work+0x694/0x1204 kernel/workqueue.c:2633
  process_scheduled_works kernel/workqueue.c:2706 [inline]
  worker_thread+0x938/0xef4 kernel/workqueue.c:2787
  kthread+0x288/0x310 kernel/kthread.c:388
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ppp/ppp_async.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 840da924708b393b16a82ab4e07746538214c0f9..125793d8aefa77fd961a708f9f7c689d5644e5c0 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -460,6 +460,10 @@ ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
-- 
2.43.0.594.gd9cf4e227d-goog


