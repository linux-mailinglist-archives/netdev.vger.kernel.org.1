Return-Path: <netdev+bounces-69508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8317084B827
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83EB1C226B2
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D4131757;
	Tue,  6 Feb 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fb9TcBtr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CE131E44
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230603; cv=none; b=qCYR9iAZFPvQyy5ye/9vi6BkKNAWPujHrJepwl/CgQ+Inb66m5FH/T4dWSAwKfMQzdz+cZWdV2hkHBlzFnh0QKWqZo0qFuvBRUc9xFedO4ZsyXD+Nc+p547iE9eJk6lY9VOmdhnsbPdxktjPDQRP45dBrW/SqBKtK6a7PqIbWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230603; c=relaxed/simple;
	bh=hWDQKfCierfVw0IFF01H86l0lO4G/Ft3WzcjCP7bPcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tJhI+0bfxuaX0Vt9YExzXTOc0+W+EwFR0ia6e8+nt9lud5QK2U2WLbaIqNpjzRVoKsUjz/r214GI7peRVlbDr4U5fEnwi6Le9aL1E8NeYYWfGCCqcstoZoxDSMV1aZ+NEBRod6uXbiaT/jKMIIKnelJXjOyF2tszCuJCcE+ioDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fb9TcBtr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so10348769276.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230600; x=1707835400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LpfOb7WMRuYannTjs/TFY/ECBdbI0SfdGhGuwju9Xc=;
        b=fb9TcBtropZyPrcprCib25OFjhNgGcWFCjCZQcTIBqXGPgXQXL/NnVrZLkUjKK0vdK
         QSUTORuC7A/ylVFHk56ykRuRGe13ugGIdkWAumj/TI67jBZPYWFOmsr80BS4mfcsm0Z8
         U5ZYYFy+DGUjic6kHNd63fsxdqRc3Rh4p1HiU47hxT4p5Vj/mO59NT9NCiy4wx/muR0P
         kkzKOvZmYF0NRlZDq+IwtnFF1q8vTFMvbM4U4MD8tQjmpWAR49XhmhDUjTcx/Yn/zsUi
         peBe6Ae5GaMv5miTpTH64NN0uWNIPo1Aubc5/1YEZHmK/eHv6m7zPvO7tt6FKbZTel6w
         YYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230600; x=1707835400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LpfOb7WMRuYannTjs/TFY/ECBdbI0SfdGhGuwju9Xc=;
        b=X+ZX40Bq1bq32mOOfNmv+7LLVZzqUOO2dRktSTVjYKku62gite5TpgW6iLaQmprRMl
         JMCoQ/A9RyfrL9412oX4/dVc8I0yRi087LkqF2kR4Eu70ItKaLYJNRtjuYk07BaSDOqF
         wQ/8F+Bb78PjXhBdMxcl9dZD72vpe71d+rbSY/rdktGDJPLhOfhi8plKCPPxuiNNFedy
         RPAxS8+YEraLLmd3QWSFKuE1aK/pccEGmhDYcFK3uLnH/NnlHWMTT8rUBc3H7BEczP8d
         mFjgHBB9Pnf17ztYh/P7RnmlXWGUJFaoEBCXfav8Bo7oGG6mfRzTL/BRmHJ8Sjj2odDY
         KFrw==
X-Gm-Message-State: AOJu0Ywl36x05Xez0YYeQcGF+MImVp+F5D0TF8rtshmmSRmmpPdamH2f
	AsZWd6igOa4lTc+bLjby9zWZs2MIfiMnd6ldO+Clhmi4EoZyeh3FZ7G/lBCQ/EMkgRY37Fcrorf
	S9+7K3y7dqA==
X-Google-Smtp-Source: AGHT+IGTXqWm0MXaZny/m/Z7DPisxTDzR4ehNNxeFQhhb5VFy7rln4QbFOSqGi+MvdWog+hETqsM79UxDaETUQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:220f:b0:dc6:e8a7:fdba with SMTP
 id dm15-20020a056902220f00b00dc6e8a7fdbamr444380ybb.4.1707230600797; Tue, 06
 Feb 2024 06:43:20 -0800 (PST)
Date: Tue,  6 Feb 2024 14:42:58 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-3-edumazet@google.com>
Subject: [PATCH net] ppp_async: limit MRU to 64K
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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


