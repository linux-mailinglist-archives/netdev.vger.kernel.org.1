Return-Path: <netdev+bounces-169716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A442A45575
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2A217511D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5D269896;
	Wed, 26 Feb 2025 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUHiTbUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F552690CF
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550740; cv=none; b=Fd9aQHLYmbiKEYGMq+qYbpRP+xzAKmpZuBu5puzJXDub5Q0hreYCGljHKSg0t10Fn68iX9ldg0TLob7UyO0mDgfdf3czmcpurUwL/q4ujW8eUOdrvkrM78nmBY4Rx6oGROoRz37E6+uAxERvpViZSPrE6g0ihxjWqR8QhJBp6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550740; c=relaxed/simple;
	bh=LU0wqilXmhCzuGib5N/5Kem/0w7j66Obcrktgr93seY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/RX7Wpo8MJUkajm3le5jYO2flSOGYJ++2cpxYth/ZW3cvAEhOxRhyYt7VjDs2OYnvZw8smZiWQrtqmwQ5uJ+AmD5qun1JHuiJAfRCvPz+NKs3tfEI6h+1Cs9fiK56+Ud4ACv+pyhSJQ4ktLxt6VVhaHrtDNsIHK8p1htxZkZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUHiTbUX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22328dca22fso4783685ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740550738; x=1741155538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUc/yOWXrzI03tdTzWuj8GH1wY3TkzvxdiesQKyGOV8=;
        b=aUHiTbUX+cCZASOxWZB+DEG0fArhmVs9yV+aXAeqHUX9pfpZslFrKTGU6re4aKySyk
         kVZZIKv8WxDtxVJDSpwmwT2uHzLVzX87dAN29UpKOXxqyJ2Uhss/08NVMqK5HYq/qtNk
         CalmfmhXc1GG38OaO/A7yE5LFPNHEmRgbyLihholePJYrWGVYyt6vvM+QHjpdxn0HMYy
         WDQgc01TB3CRhEA8rLi62MWOxlFrawxdU0/n7+41BAJAqBdGZk1tRpM5HM1pP8x7hBkm
         AT2e+6bvI5y3EC4KcBHjq3e4MAB21JyPfUAHwGSaa0Csfikc51VXfgL1WY5HR75tyx2/
         +xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550738; x=1741155538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUc/yOWXrzI03tdTzWuj8GH1wY3TkzvxdiesQKyGOV8=;
        b=DXZpUiTlRzK+SSeW7k4yPbxI5kyjwqQmB9QPmFzwfeufyieGsbbQYvWMwDBPO00Skc
         XpkfTB5msbHzuC7Zx2VZX1kJrn2XPYB6knYJg3LcWdSjcvlDP9jjzPclYYXAEzFYnlmg
         t5MkhzTLAdMbW6g6HZ1v4zX8IHbwba/lU7TvV+DMq8LIacFVH9liDesSWFeagr/eenVc
         dj5w0lX6puS+bxVt3bjw6epBmeKuAz4ZwwTx/AaFjOZWcXaSnD4xSYj1aRNUXNC6RrvS
         RTes0YhrxYcuNGm7R+lccm1bt0pHA4on42H++CeDV6kFBmB/F7XGWCSzlOvtqupQv1cC
         ZL7w==
X-Forwarded-Encrypted: i=1; AJvYcCWcQsgfZ/4iF6eqxxPlo5DDfsUMXh2kRIBhfM9g4oB97nZbzXVdmzIob8T6Q8QAaCGv2y+a3h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLtCyu/ZVNHu/MyMyMTWhBWQ6lnADCYYwS78WPbnsd+KcQV1J
	hWkMSmYrLL8yRr6XOM/jqiwonKu0ZoicOGTvkDHf/kktqbAf/F5O
X-Gm-Gg: ASbGncvrplRzTk/4pwyvesLHerb1yc9icIGuTUJc+VwDSSjt3LNYcsBUPZCOYdWZZMr
	XDfm0iHUdMlyKc3HxE6E6AZQxThqB/ZNfGjer3W/cc4KY5cYEpxK5/Ia1KqHwKNFUV+/c/bGBSh
	M2uX/6mglThL9wm0m+Wg5NkbYCUA/yZxs6sohZ0Nvfy3k+mJ24tbBmDyKLgWyB1Vex0987/GDnV
	rYmTM4Gq38xtTw2X9fGnsQk1DsgWcZxMOlvoH1pNRZcS0EJZD4FfjPnTyoSuZtj+jy/3831yIAm
	z0dBkT9Yboi0a6o=
X-Google-Smtp-Source: AGHT+IERSKGVo00iSfek3HtP8/mA7AE0vx5qxg7g6FumNmNUY8sd0fBBusWdsh9WXjPUITdGo0eMEQ==
X-Received: by 2002:a17:902:d2c6:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22307b33043mr104510635ad.11.1740550738074;
        Tue, 25 Feb 2025 22:18:58 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0a61fcsm24575535ad.191.2025.02.25.22.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:18:57 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	horms@kernel.org,
	ap420073@gmail.com
Subject: [PATCH net 1/3] eth: bnxt: fix truesize for mb-xdp-pass case
Date: Wed, 26 Feb 2025 06:18:35 +0000
Message-Id: <20250226061837.1435731-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061837.1435731-1-ap420073@gmail.com>
References: <20250226061837.1435731-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mb-xdp is set and return is XDP_PASS, packet is converted from
xdp_buff to sk_buff with xdp_update_skb_shared_info() in
bnxt_xdp_build_skb().
bnxt_xdp_build_skb() passes incorrect truesize argument to
xdp_update_skb_shared_info().
truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
sinfo->nr_frags should not be used because sinfo->nr_frags is not yet
updated.
so it should use num_frags instead.

Splat looks like:
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 0 at net/core/skbuff.c:6072 skb_try_coalesce+0x504/0x590
 Modules linked in: xt_nat xt_tcpudp veth af_packet xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_coms
 CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.14.0-rc2+ #3
 RIP: 0010:skb_try_coalesce+0x504/0x590
 Code: 4b fd ff ff 49 8b 34 24 40 80 e6 40 0f 84 3d fd ff ff 49 8b 74 24 48 40 f6 c6 01 0f 84 2e fd ff ff 48 8d 4e ff e9 25 fd ff ff <0f> 0b e99
 RSP: 0018:ffffb62c4120caa8 EFLAGS: 00010287
 RAX: 0000000000000003 RBX: ffffb62c4120cb14 RCX: 0000000000000ec0
 RDX: 0000000000001000 RSI: ffffa06e5d7dc000 RDI: 0000000000000003
 RBP: ffffa06e5d7ddec0 R08: ffffa06e6120a800 R09: ffffa06e7a119900
 R10: 0000000000002310 R11: ffffa06e5d7dcec0 R12: ffffe4360575f740
 R13: ffffe43600000000 R14: 0000000000000002 R15: 0000000000000002
 FS:  0000000000000000(0000) GS:ffffa0755f700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f147b76b0f8 CR3: 00000001615d4000 CR4: 00000000007506f0
 PKRU: 55555554
 Call Trace:
  <IRQ>
  ? __warn+0x84/0x130
  ? skb_try_coalesce+0x504/0x590
  ? report_bug+0x18a/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x14/0x70
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_try_coalesce+0x504/0x590
  inet_frag_reasm_finish+0x11f/0x2e0
  ip_defrag+0x37a/0x900
  ip_local_deliver+0x51/0x120
  ip_sublist_rcv_finish+0x64/0x70
  ip_sublist_rcv+0x179/0x210
  ip_list_rcv+0xf9/0x130

How to reproduce:
<Node A>
ip link set $interface1 xdp obj xdp_pass.o
ip link set $interface1 mtu 9000 up
ip a a 10.0.0.1/24 dev $interface1
<Node B>
ip link set $interfac2 mtu 9000 up
ip a a 10.0.0.2/24 dev $interface2
ping 10.0.0.1 -s 65000

Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from multibuffer xdp_buff")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e6c64e4bd66c..e9b49cb5b735 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -476,7 +476,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	}
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
+				   BNXT_RX_PAGE_SIZE * num_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.34.1


