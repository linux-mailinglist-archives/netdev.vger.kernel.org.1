Return-Path: <netdev+bounces-297236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qfgFG/ZdKGo2CwMAu9opvQ
	(envelope-from <netdev+bounces-297236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:39:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D458D6635EC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gfNDjV5J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297236-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297236-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18745303F445
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE284BC00E;
	Tue,  9 Jun 2026 18:39:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAD47ECC9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030383; cv=none; b=qmBHW8MNUR9HD0fxNjEiPlUP3EwiIaOSer5pmOgHS3MzwVIYqzRfJItEeRdUPtEI/2UwT17Q/rItBHH893an1GY2Hzr01tWs4U7OO0aPaY1/vV2Ijp6KovoMNySg6pDXBvaeocZAAvBaPBBuNEJpXTi7NGDJJ4FPYyFSOFjGaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030383; c=relaxed/simple;
	bh=T35csNRp44bHur/yLsWKZYVmWYj1MSMEmQcrTkBCMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7I7CmXCyVeDswOmcb/65wZBcF8HGbehjPHnL532TZGbzJGGnA93z16q96XPblrA0ffVNeIM0w8ZR6ql0q8OjFp7CXF8aLv59A040B9njJid4YlNBfoZTewcHzWbmilR9kMsrCB7OnvXzz5TTzBHHpKHMPTgUge7nY4uThqei6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfNDjV5J; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8d414666so3374013a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781030381; x=1781635181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgBJaGA+2PRCOgDDMrQ8yVdOjKxw4/VzWOqWrrWZF+g=;
        b=gfNDjV5JXZviWYwxsEV54l/jbQECYy5PAWTgR7JsSxxwGIdrt43h4MJjAX3xoVP1KY
         +OMI776kL5zrbd1NDxoJCYTVvUvBYFdJ1d/ahYlyQKBi1aYDkBSLvVs09S6cpybUaD42
         8LtuBhfvTygtxk4ToigBa9gcuCQmpbjxWzKu31vHcTV1SPCkKjSAn+byO1GBmOw8EEih
         XB4IrWANiq/sRR7WSXacgW7NrlqvzXzwVU2HwzoHOPloRTjUdx38IkR+caaGqNaj+TFi
         O6P90SmfOJOaLeP25EZS5Q48yO3BLlHyTrSRuEMHqbfvC3pgR7oTrTLezQmLwRxrg4t2
         01mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030381; x=1781635181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgBJaGA+2PRCOgDDMrQ8yVdOjKxw4/VzWOqWrrWZF+g=;
        b=PGY69i/1HNJqqVFx5bn6c04TupJyLq/bYZImqdb1BzU8JBaIpdYde9+bEgmKdRI7mS
         8nmXuiZysXTdjXhpJDjscl1wqmfF2Q3kejaSIzP51Y9B2Oldp7CYOW1nyE5lF//ghSOU
         j6Mx2A3w8wel+YNO9U7RAl2Gt9XLvqrloOIzAVjehHf4SYtMS3q4tl1lFI6m1Hnx7S17
         5AzpZYuuoIpvr27zQiembLql17PvCfAmEJdz+x15e41DQlnYavE7t50azKxi6zNfis41
         0sG1NO6uwhyzgxe9LRqenAIy0pQttJnGeyFSBjUz/fQ4xEuW8I+Ck86P0gCBkxiPSwl/
         1tMw==
X-Forwarded-Encrypted: i=1; AFNElJ8l5CmBhps0E4RDwB9t15mLEyXZ6azCKjrLTnwqaGpud1/pd1Md1RPNEtHSVek/o35P/VbhbNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyluKJd4ewP8ml4a2poAQgdNmAi6jKaAKGIjwO2Yf2s30k6dTV+
	iEKs5n41LhMHPADPMuiNqAlNgda0h0UCTYitw+VJw4dARR8hqDvkZpbg
X-Gm-Gg: Acq92OFRH5vwgNVCeT0HRuTj2O5DyRs/KxFI86KsgA1a3ihaBc9mUm1NpaYBGCH+TwY
	AWkzZEDB8W2ZsJKnbu+MYdFNIj+rtTieZMiCklrpzvl2QQ1GiyosAqbT6vRWp7xBydpz6uWlGPb
	eNVnRzJ5gF7hP2fwCawhJQw+M7EhIQ8rOIj/k2dpH97hq/oHP90m9Wsp+lP9RIEiQvz+B+Jd51M
	fuCYtP0EaxquiH0sRfREMuVN5M8oBMpiW6yW3/QurjWbDPGhlq7j+zh/+hzL08Bc1p2JEs0iIUF
	N028M2UHs7Qp/AXH/oivVGFJ8xJxcoGp0CT81j8Z3WJ8uoZq09RrBObAVKSOzXukqhv/tuA7gDW
	HvETTnZUCYlH1E6W3kDr2m4ClTbOdgr0gD7reXjev9+/ZIKqhCFYd3GYIfq5FRG1CEQ2XJPd95t
	ok5ZYJYZtPZGR+t5pfPWgdJE8uqWFTzCCip4pxGYiTC5s4UMrfkmS9Dmyx46ywsxTOT6ZF6hDyu
	lghBU6yFUQ=
X-Received: by 2002:a17:90b:570d:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-375211ae4c4mr4508510a91.17.1781030381081;
        Tue, 09 Jun 2026 11:39:41 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm20486626a91.12.2026.06.09.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:39:40 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Zijian Zhang <zijianzhang@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
Date: Tue,  9 Jun 2026 18:39:26 +0000
Message-ID: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297236-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:zijianzhang@bytedance.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,bytedance.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D458D6635EC

start and len are u32, so

	u64 last = start + len;

evaluates start + len in 32-bit and wraps before storing it in last.
The bounds check

	if (start >= offset + l || last > msg->sg.size)
		return -EINVAL;

can then be passed with an out-of-range start/len, after which the pop
loop runs off the end of the scatterlist and sk_msg_shift_left() calls
put_page() on the empty msg->sg.end slot:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
  RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
  RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
  Call Trace:
   <TASK>
   bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
   bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
   sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
   tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
   tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
   __sock_sendmsg+0x153/0x1c0 net/socket.c:802
   __sys_sendto+0x326/0x430 net/socket.c:2265
   __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..d6d2fc589218 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2974,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	u32 i = 0, l = 0, space, offset = 0;
-	u64 last = start + len;
+	u64 last = (u64)start + len;
 	int pop;
 
 	if (unlikely(flags))
-- 
2.43.0


