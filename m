Return-Path: <netdev+bounces-303365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ixYkIkwsRGoJqAoAu9opvQ
	(envelope-from <netdev+bounces-303365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B86E7EEA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:51:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T7HrGP7l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34F5301F19D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050747AF60;
	Tue, 30 Jun 2026 20:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E020472776
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 20:50:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852658; cv=none; b=Wp9SCidz7fckL879Y9qiCHnemJN4+iSYCRrSjbJx0KvFHzLy+nw5jnsWCRbjm2wNWbdhUt1uQKhbTJsSxhpwJFzW/EqwuPrPsIWDLYwLT9zM1rM1QBSQuTR7ot6Yhw3CLOBZ3c+QF/mLFSX74fSVFLw5Etfb/HL7a2c9N9jOjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852658; c=relaxed/simple;
	bh=fK/MWsPyhM/NRS8LN/G6f6zgJ3L/0Mw5pNSYTbRJMDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNoh0eay0Xmroarw7mHQ4fVdHBK+vE0hhbPuFIwoIFNBlDzmDAZLZ+NOyMOhFz8h8EFxVm8HBCahJ1KS+tAbVI0w0W+DX+QDJ3vHwlr8kleP02OK3t2eYbLzGUAzZ+GOAQ4g+7RHBrWGdjyX5QtLYlfJ1y93tiGZM7dgDdv2BCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7HrGP7l; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca265d6ca1so7627025ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852656; x=1783457456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bREOiO5mN7hLvS/DleneGMdLVSBD6LdzBp7bNvZIud4=;
        b=T7HrGP7l88Lf1REDsU3vyF3oRCp/Pkch1PeD4ax2pdQQwkIwEONhWil81pmpKg+8Ag
         rAoEgPzFMIlBHdH8bQVAlUP6DT9Hv3lkmxGGOxTMwa5nIb3V/Cg+dXfxkrBUFVBH8ZTA
         bnPxcGXUBS4htBKKIt3SYiz8x+AiWdAk4ICOzuwAHDKzF+dmAT/Ax0n0StzI6vRuUT1v
         iVhKD2JNRfZLzu2fOtnUw6gBXG5CoqT7JoeQ21IV666CD2uMW+g6RXk6ylt5PvnD5+v/
         43kOygdBxyCJzf29YkluGH4/hQ0NfcGYAH3DmmeVBln65uovZVShBQur4ipr8S+VGhpM
         3V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852656; x=1783457456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bREOiO5mN7hLvS/DleneGMdLVSBD6LdzBp7bNvZIud4=;
        b=ZMqFPlnMOQx0I299A5vJYMlcvaatXI7+P6xPMEhzjeWH4A8CgVtFx3o4cfHiiyVBv/
         zGMXdsaPHdyQ+yoJkx0MaYZ+mbQKZhcG/u+cBaketNbIX8jGwwk+iB9kus3JdYxi6LpI
         XeAMmpYwok2Ls+Wa8UABRoL2K3OMnl3IWFYYPKyTS4SBonht2CV8D1+XZ5PMGXukDmRS
         SBKSLB0dkMsWmT5a6o14JLmVtqMy3NtlbzxZblfsbJtZFmMpMsPcysPuo2C3DbzMgVwU
         lF7gIPZCgX45hkXXTYSjgftGlzhG/KaWeokkWDa1Tk4cFyG54Ac+XFyI77fWbZ88HKvV
         NUyw==
X-Forwarded-Encrypted: i=1; AHgh+Rojdw/97dUCFHzaGiLp7+2/Hn3wPeVWo8VyqoHbup2CesvCdt+uJteiYonpEbZVKPnBsrXLws4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqHwA4cSYvwUMSE0heo9zLlPAx33A9NG8NCOGLT2c1jk0qqwT
	nRWe204p/0TzatzTIC6MOqdeWZO7Np42GxmCNreIli3nKmgYVHl1WdW2
X-Gm-Gg: AfdE7ck5VMObEa3o8wz59hN+Kcn8cuAmTRi/s2eN7hXhwVHQx+TTnyCG3mgXlM4GofT
	Pf8Nl8dCtnJo/mHiihgz9VnvJFkRHivcnvm/gNxpun6hIc2IhbFUz8op/3GrLVjAs6ZyK56QBrv
	NJ8bVGQlqZHknYhqg/RKCB1khwWodUdWJQi0z71ykzGC7Y7wLh8HtrYNVatlDcX7BFK1JvB4Gvn
	durDbNG7ZvPVaLFXz4S39KdLGrmLDkED3BjmPIUZ7YloCXubozHJIx00YlTlWWj7x7w8IrYyD+M
	gL9Fv9/JTNuIPoornIC0V4HHeic2KN3KBwD4yH3E0RySOn0LnzP/TQ/HoEkgmGS8suwCB9l7yyr
	g9Jt5T9WftNtQGkbGJH6i3m/3CDblqbhLG/ZtyR92ItHEOtTAVmAg0uru7xFiGZFfgCrwR2zXUx
	BqDJCsT4XpvFjaLu5fwGS+mcRNAVy5BZhOP9MAuLikihwLHImqxEE=
X-Received: by 2002:a17:902:f54c:b0:2ca:d4f:adab with SMTP id d9443c01a7336-2ca44a060e1mr25125905ad.19.1782852656493;
        Tue, 30 Jun 2026 13:50:56 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:50:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf, sockmap: fix copied_seq left behind when a stream parser is removed
Date: Tue, 30 Jun 2026 20:50:33 +0000
Message-ID: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303365-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:shuah@kernel.org,m:kuniyu@google.com,m:horms@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:ihor.solodrai@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[google.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D47B86E7EEA

A stream-parser sockmap socket can be removed with SK_PASS data still
parked on its ingress_msg queue. The copied_seq rollback for that data is
never repaid, leaving copied_seq behind sk_receive_queue, so the native
tcp_recvmsg() warns. Patch 1 settles copied_seq on removal. Patch 2 adds a
selftest.

Sechang Lim (2):
  bpf, sockmap: settle copied_seq when a stream parser is removed
  selftests/bpf: test sockmap strparser recover with undelivered ingress

 net/ipv4/tcp_bpf.c                            |  9 +++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 59 +++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.43.0


