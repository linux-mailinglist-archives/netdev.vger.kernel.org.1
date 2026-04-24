Return-Path: <netdev+bounces-281053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGpoKijD62msRAAAu9opvQ
	(envelope-from <netdev+bounces-281053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:23:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A329462D58
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CF0300B9C8
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595034DCE3;
	Fri, 24 Apr 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZqyNv6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA993659FD
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058321; cv=none; b=OdcxeIIuZxA2FqulawzhyOmDzBUEo72EPv3iaoTovvjrnkN5pBGldr1s8sfdZ7/xLTtSewmdUOmReV2taG+9t9W/3MeFPZQgPYSL4NEbxLpGZId/EPEkZ84tjs0C6uwtJa55r4RCVGpjzyFu/hP5Xf9vEYnLYnD2qlX1trbVsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058321; c=relaxed/simple;
	bh=bVTg7g/DgY21o4JRsmGKmk0kP2qQqkrlnZU2sa3maDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzTXiTdfVyOSl9ET9WZzNoFcK+/8JspPp1n4Rs9gK608gjXVnub2WVEjHMpNgJGrZ7oO/NluPPr139zfQbebjffQOl2uQ61iVlVkKqoj3eepAVxQI11dzKto4aszUecolIOT0tLJoIucseV6+oaVHEvNp1ED+YLZKAlhc/eCLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZqyNv6S; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso1259235c88.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058319; x=1777663119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsjhhZdX0yxy3kgINItwDji3KGNUTwxF928253yyINA=;
        b=oZqyNv6Saw2P8WkXhAfhkkQEvJvRtnFuOod/+TNOshIqn1tGk+hu6mMVVVrEvZcH3E
         QqGEgw7xgmcRcg4CGAkPFI4PN7qk8tvvOCU8xI7mHthQP6fBBBt3k15Qy6lKn+sETuhE
         48XElsXsmqI12UYFVZnYgVR15RDkSSCJsCO6ThGBFW69W7G8IV9n7a/OkYDzWr9IzhaN
         yxpgeFOPlwGlhgY6QCochBfXehLUwGvkHkeboObqqok+8IFePCEGAwJMDqFcrSQj2Z+9
         JaenZPofulJDn7ry1tolLf212LTKO5PXmq5WM4itCS5GX/y8suJgzw/O+JVwz3Oredwi
         joMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058319; x=1777663119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsjhhZdX0yxy3kgINItwDji3KGNUTwxF928253yyINA=;
        b=JOuz4nera2ridhKh2DbY7egKo5Dg4223pSQ2fLbKobi/Llz8QOOWZOEhpk7hzAw3cL
         OcY1FCcTgVQEW0siO9pIpzh+7CgIR9cAjj8Hkkeb0b1cys1dL3iZ/duEkN5zSKnQfs1G
         AfhYoXX1WKhBSdgMGg81NPMXDiGZCSifqzRI8oyWE2Gf0R5Cazx3pf+1LdPUKI+JK8e1
         PPwG1/086GZgWxHMKxzcSzebOyxyIF1fLBb9BiEyj96z4cpb1Fdz+pJjS06uJ/KOTbMX
         8T2QtOAuts/rIXxt2OEPM8aanz5qRN7k+HkzEla779gcosB9SR1Ki9khXaZKj18oG8Tg
         +ljg==
X-Forwarded-Encrypted: i=1; AFNElJ+lj9jeinzw6UuatA7XqS/5MurIzwv/llPm1G4hjppMJyDVLKYubjmkdHev+O+D3F3PK4Ecy3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEL+hdo4Yh7qvQ8s7r7Ez/djiQTTe30I54G+q0c9Snu2lNTfN
	Pi280ayqIIcVGithszx+rz4gZw71uDhS4BgOvpXr519T5mhHjjV+siO1
X-Gm-Gg: AeBDiesj0Vs353cjYQnPUt/smt7SMuxGqcWyx5mpVivqXjgIzYCDIoxpcylJp3gL74k
	jzYCikZMddytS6ufMDd+iFE/n/UaCDiBscxWI9Hnw+bYVA4kDHsKgPwbBPaVHq8Mx0EhbBkwTUd
	LPvF9Fl6G0/uat+pfPF5SM2QSH1QSzfVnac7dMUjgZTrO1fDCpJeizrGu+niRN3+gYjmW7c88Tx
	vBSGtdCGELq2ZkWEHQIu63/1q41EYU6yHqBd591Ix1Sg5+bhuxNYKLIhW1u+Oieed3Ba60rqMw4
	rj6of7ZHY5/ly7hKkF6YAQgqQd2zSl62nGS7QKtlwz+koCcOHluBKL9xYkfg48vp9rx+JO+4tPa
	XNXIB7El/A5i4rJwo0/BAeHYwGA4J/uOwVZARTyA2SqbEyZUEZdVVVo/gDoFrwMscBodCiKVY48
	qAFahmp2Ng02tsu1MNT5ViisCVkVPugn0dnCkL2SlOOkLUqcJPQme6X4vIsAdwNW9Qc8aOhwWaI
	Mc1Nbeueeu64b5WDDmd
X-Received: by 2002:a05:7022:383:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-12c73fa739fmr19364941c88.31.1777058318879;
        Fri, 24 Apr 2026 12:18:38 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm15312204c88.13.2026.04.24.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:18:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Xinyu Ma <mmmxny@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
Date: Fri, 24 Apr 2026 12:16:04 -0700
Message-ID: <20260424191602.1522411-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A329462D58
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281053-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,vger.kernel.org,asu.edu];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.646];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Spam: Yes

When the scatterlist ring is full or nearly full, bpf_msg_push_data()
enters a copy fallback path and computes copy + len for the page
allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
and both are u32, a crafted len can wrap the sum to a small value,
causing an undersized allocation followed by an out-of-bounds memcpy.

 BUG: unable to handle page fault for address: ffffed104089a402
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
  bpf_prog_9ed8b5711920a7d7+0x2e/0x36
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
  __sys_sendto (net/socket.c:2206)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Add an overflow check before the allocation.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..4f5a00ade2d3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2820,6 +2820,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (!space || (space == 1 && start != offset))
 		copy = msg->sg.data[i].length;
 
+	if (unlikely(copy + len < copy))
+		return -EINVAL;
+
 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
 			   get_order(copy + len));
 	if (unlikely(!page))
-- 
2.43.0


