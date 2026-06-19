Return-Path: <netdev+bounces-300609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +1hpEBriNGoBjQYAu9opvQ
	(envelope-from <netdev+bounces-300609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E66A41C1
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:30:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ca/8b/f3";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300609-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300609-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BB2B3021CD3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 06:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCCB346E4E;
	Fri, 19 Jun 2026 06:30:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9991D9663
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:30:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850645; cv=none; b=cgKERukiGYvNIQjwu1bOEhNhlkpsWyWU/MFfF+VKdEQLWiz1uGd1wcF/2wEzxiKQPQkdDFzXX9+wXlT4Zl8YeJaVOOObb3CMwHnou/Gmj/5i5G4v2ZgOhKoHdC1Cyv1xmybRqpPdVHq45QVoADmnX4YcVnPg6uIEuwTZhE37e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850645; c=relaxed/simple;
	bh=TqQB867N86wSav4oIi3xoeqdmuIgWtWi0oXKIdYe2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oj057NV1pysrtQrxGpDx6u7kxQjHGr/LAXh1KNLRN84qePMp42u9nVMhfjJxUF7c/wViGCSN/z9D+KUF5svaL/1OfjfNlN4QXLqWyLmo9J89/lbBWXV5c1UUx9vJb1aFsfnf+xZADRqPQz6/jnuyJ3V0GcrNe6af+W91HSptzzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca/8b/f3; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842848fd613so1634172b3a.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850644; x=1782455444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1/ArZBR8AclmPo2AgBuJ0LqA7c+rabIabH9ua++1ms=;
        b=ca/8b/f3/E8ohvuXtS3L5Hrv1r+ikHr72uMY3Q9DGv/viCyjrs78XSNaBRyFs+4/NM
         EHBLWEuEWP31lHXzMMDljO8fEeQ/fntQHRjhlfDMMloNL+51qLRKjwicGqtizAPx7lsu
         UxKCxxW9RFWoY3bZOfRs5eBD9AvHn7Cn0eZg75aGYKoEzNs9+xF/p/5Pwl0Im4HRz08O
         xWakTuJdEoEdcbtbiiBFAfInz/q4xXW7F4DMywZBllwhgSvDM6eDC2xWX5mITRMEg067
         SP3p5LzxljLCVigXuVY69XFtLkjqFtQiHtsQe24ggVJBDqE/lwQ6giilFr1nUnQ38doG
         s4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850644; x=1782455444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1/ArZBR8AclmPo2AgBuJ0LqA7c+rabIabH9ua++1ms=;
        b=CXCwpbkYJ1tbxXx9ozmWr/w2Ru+Xi1yQOuVO6DhZieE5Y/fMkqCylXO58Qcb/NoZLN
         ZNt00nYp8d1oKUxsLMqh9hvpD5bBlmSiZcqcllh7fcateTBgp8kJb2qslrZlUelqSu+p
         SpUhVvieIDTlK8G2lNqXReeTMd3NFjQ9t34nCCMoTWVkxqd54I9KjKy2wq5HMt8HzDo1
         7nokeO7L0NzBhV+bqTFV9s8qPR4fH7E9VSEb9FFBaUxKPvgjjYXxz8DwsgzJU+2xtCXZ
         bS5LMmw0m9bIQ5lBJBJL9CuamJqZOTF4gdFWU+0WgaX7ou+oljXYJQF3rQK/IG2ODzqT
         32BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tcpX8BNFGtElbdGcVLW+M7NZ/9UU2DGAsu7ZujZ/lVfpdwG+8N3oVcWWDEk3bxWu9loFYUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzNY+v+RC29HEL9SvxnItXrHh7QajA9s+NfAD8dvC8xfbH3BM
	13qINnjM/qDSyFd2KuxtpDs0Lwrhcew8OxRNgAEZzG6Td3H+mu2aWcR0
X-Gm-Gg: AfdE7cml0C8Y8A0Z4DhcmcbjxbuL8drHTjbI1R0LwQPXcEMwX5KWiwzjy+pgUHiDsGV
	UfO695S0c3sdiRwICbDUNJGERCaDqLEG7G0xk0n+n+q5fZXW64E5MGn6mhWYS6cp7c0S6hc9YKV
	Y/51Xpph8wSakp8N+9UGTeRtXNfvrJSszINJjo8VsHYZlMB7Wr+CckaKmYNfFzEdf9dVRAxHMxl
	94NLPuJx/pFRd143FNhBbH25IaY6NTrOhc+iA4qFYxAsDTOQG0IQvlVND8hkZaeUwbKO6HEevoY
	NhX4JQdmGPACcOf9CZYlvzKoryybYB+OfilOLsV3pfkxLdXx/n3q6hwpp0/3QxeAABDSL57HKJS
	obFD0ryU4t6YlEmJ5ezuKEGsIUBXuwX1zxjvrW+7LDUdKTC26ybD41kXrG7QQxiiO16mGO1xKQJ
	qtGtjS/iLyenAyVnCSFryWCz7Wqu6kQs6aAynIGCJWmdkKgjbBWqM=
X-Received: by 2002:a05:6a00:1a8f:b0:845:3ffb:ac2c with SMTP id d2e1a72fcca58-845508d71bcmr2333443b3a.46.1781850643354;
        Thu, 18 Jun 2026 23:30:43 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:30:42 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 0/3] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Fri, 19 Jun 2026 06:29:49 +0000
Message-ID: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300609-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,cloudflare.com,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F21E66A41C1

A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
which can chain skbs through frag_list. A parser that resizes the skb
frees the frag_list segments that strparser still tracks through
skb_nextp, leading to a use-after-free.

A stream parser is only meant to measure the next message, not to modify
the packet, so reject a packet-modifying parser at attach time.

v4:
 - drop the Fixes tag (Jiayuan Chen)
 - drop the unsafe skb modification from the test prog (John Fastabend)

v3:
 - https://lore.kernel.org/all/20260618102718.2331468-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

Sechang Lim (3):
  selftests/bpf: don't modify the skb in the strparser parser prog
  bpf, sockmap: reject a packet-modifying SK_SKB stream parser
  selftests/bpf: test rejection of a packet-modifying SK_SKB stream
    parser

 net/core/sock_map.c                           | 20 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/sockmap_parse_prog.c  | 22 -------------
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 4 files changed, 58 insertions(+), 22 deletions(-)

-- 
2.43.0


