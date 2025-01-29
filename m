Return-Path: <netdev+bounces-161490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA05A21D69
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A91626DC
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7DEEC5;
	Wed, 29 Jan 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+9EzOr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4413FFC
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155612; cv=none; b=WIt2eqSUpuR6UgX1FMoSa+N/QCGbb+viNMD6x7cZW5V1pVs01rzO2qf/Jf/c/bC9pOKtAg3JrB7zE3JYTtdxWHJYIAxuNfCV74RM3WfnFeeNhT+VpEBVxvfeXVpIo2twwyjonS/gXjbWP5ykkDMhGnEStuuwCorbZAcXYv9SCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155612; c=relaxed/simple;
	bh=+j5PMJShL0lfRdnO8XjJXQAb2rEwNAVELfSQSgD9Weg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OzWtwUx617/IJC2dKZnkSVEMHqMe+T98Nw5mRv/wcNXFUybwwQZ9SKst8QaWrzD79jd+M6xFU7JJXQDcuxRhBOhuIcuhIQwTxZWnxQtYlriWX2tb3K63WFQRgg3sy6kUYt9G097WMGmwkUKEB07aoAt03Rv2Sm5SArPVjOFrLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+9EzOr3; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b7477f005eso1513044885a.0
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 05:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738155609; x=1738760409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tr5/gkkULDrBQfJioiEpApCPSDsPP+Goa6+/08waBq8=;
        b=Q+9EzOr3leYJyWhx0l0qf1EdoVHP0wyM41u5HxskZ2ZlfN19TvHp9FP1Nsirv9XeEw
         r79BmiCl3IVhTkipEUzKQhnKxg8NnbwnJl7fi5jcT0pw6a84OE00xPkb6T5QcRBEp/Z/
         uBPklBGH1M0fmAtLICb/Sf8IkKFagzseu0TwF9FaoPa8cFT6PhJA6+PhCFuvWtiM/Lpw
         aW3faddRuEp+YQe/Kvq8/L0167d7vszq86d5MlrZIzBUuib6Mdc4j488xE4VnxJETbmE
         B7AZ6c7STCeRF7FQA8jn71yQMukHk1F0PmfjqFCOEldYVMkBAPiGv3FZEli1ba2AXSSo
         +Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738155609; x=1738760409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tr5/gkkULDrBQfJioiEpApCPSDsPP+Goa6+/08waBq8=;
        b=pE0Sa2O066aXHE2v/UkEvOn0f5DfWEvMAU8j6JIrwUjm4JL4AMy2yTHvlxTZvE7ESO
         CKka3illAoavOLMxz8QgIx3bgLgHVr74d/UbhZLgyhQqrldf1WVIE01OH/j8YldQbxK9
         vrMZpCn3hNr9kuu4ml+HBOsn0FzIHVRzEsa7CouKDUoH301pAwXCWjjB1QRWZ7gfS+29
         6SqyXfnyl0xsrnZqhJr78htK/Os0AWMVIlED0R/5zyUkqzJb9yjWc8IZE8Wav+aF7G4W
         dIvkH1CZUAJmD8FBeg0PE/fSwwZOJyrniLSWQWPHzVq/VRFhs7oS8BvmQN3cmWLA7A35
         /MDA==
X-Gm-Message-State: AOJu0YxvXE7xj3A6puxVvw6+AmULQyZqkMXRPspKsoDzqdfSNi3Xd11p
	asX0QBm0UNcmApKlGE8cdgERZ5cBY2C2Ki04UdQD3wAQ/Kcj1UoHHGna2fdtLYzun98L4K0Ls8l
	XY4QZxrWhzQ==
X-Google-Smtp-Source: AGHT+IEL+a13mxynke2QoQ+0CgBzt6eAhMoScNn/8xs7hu1Er8JE8pZMWlKr1O1n8Vxjtn9reyItCycFthXwjg==
X-Received: from qkpf15.prod.google.com ([2002:a05:620a:280f:b0:7b6:742e:a33e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:44d1:b0:7b7:7d6:dfe2 with SMTP id af79cd13be357-7bffccc9f63mr300318885a.10.1738155609477;
 Wed, 29 Jan 2025 05:00:09 -0800 (PST)
Date: Wed, 29 Jan 2025 13:00:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129130007.644084-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: fix fill_frame_info() regression vs VLAN packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stephan Wurm <stephan.wurm@a-eberle.de>
Content-Type: text/plain; charset="UTF-8"

Stephan Wurm reported that my recent patch broke VLAN support.

Apparently skb->mac_len is not correct for VLAN traffic as
shown by debug traces [1].

Use instead pskb_may_pull() to make sure the expected header
is present in skb->head.

Many thanks to Stephan for his help.

[1]
kernel: skb len=170 headroom=2 headlen=170 tailroom=20
        mac=(2,14) mac_len=14 net=(16,-1) trans=-1
        shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
        csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
        hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
        priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
        encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
kernel: dev name=prp0 feat=0x0000000000007000
kernel: sk family=17 type=3 proto=0
kernel: skb headroom: 00000000: 74 00
kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00 80 00
kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80 16 52
kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24 47 4f
kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44 4e 43
kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f 73 65
kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5 93 7e
kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01 01 89
kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03 03 00
kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00 a2 1a
kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91 08 67
kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd 5e d1
kernel: skb tailroom: 00000010: 4f fd 5e cd

Fixes: b9653d19e556 ("net: hsr: avoid potential out-of-bound access in fill_frame_info()")
Reported-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Tested-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Closes: https://lore.kernel.org/netdev/Z4o_UC0HweBHJ_cw@PC-LX-SteWu/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/hsr/hsr_forward.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87bb3a91598ee96b825f7aaff53aafb32ffe4f9..c80575db8b91d9bcce376e1a8c3fda76aa91c17 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,9 +700,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;
 
 	if (frame->is_vlan) {
-		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+		/* Note: skb->mac_len might be wrong here. */
+		if (!pskb_may_pull(skb,
+				   skb_mac_offset(skb) +
+				   offsetofend(struct hsr_vlan_ethhdr, vlanhdr)))
 			return -EINVAL;
-		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
+		vlan_hdr = (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 	}
 
-- 
2.48.1.262.g85cc9f2d1e-goog


