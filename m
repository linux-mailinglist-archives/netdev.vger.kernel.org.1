Return-Path: <netdev+bounces-290467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFQSG0YXD2oDFgYAu9opvQ
	(envelope-from <netdev+bounces-290467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124BA5A74ED
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33E4E3060ABE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4B3D811E;
	Thu, 21 May 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2YmLf3G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925A23392D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371587; cv=none; b=claYKG1fNlJ4ncgx4762e0luaBk5yF203WYCtLzCFXpKvQJmZNsfWIfQ3QdYKXnWRhQzwRce+reJpeLCTybOSFbjqwMwHEoBHuAN/mhIX/5DKoHEnDdfcwZB83b7H+JI5KulAVc34q81tX/O4ZlXYvLrOzYwbJN4unPuTx/a9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371587; c=relaxed/simple;
	bh=flOQwo6EthhGJKrTIzWxVqgufMZk42XG9Rnl/m4cozM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yrc+/k2ywshnWTkabBo+5tKNLIVb1izSshATb0x0RWRqx7pzbfEGNFbzEKg/c6dQKVjopHDxj6PYuq7fY4bGXOwuf+W2WNBgMjgnlMWgB+G929Xmb1WvcJfWY+6R7MkVnVFJCvFuEYJqnYYzWlzTFsL/qUKxE5kG1n1YnBKKsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2YmLf3G; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365eecc5885so5588212a91.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371585; x=1779976385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9scMsI1aLsfr1bm8JnebjnjIPyM0AlPvA53k1dCeHGc=;
        b=D2YmLf3GfWcJQDPXAPg9dQWYIa++kCoqha2XzdsXMU18T7PskUB5FWIfEWZNYW3srk
         YjWL8LQT0lTYgGnfejh0XUCB5MUtA3LDB2IAspr2veLtriq4b9eq+MtzCN6v2q2rvQcS
         3Vk3CpMpR7+A0f9qWclyJYduxbAF8yUfRCSlRa5ngweAhnTQDZgXlKZU/16Jomb6+o3W
         9jucCTwKxxoUPbXkdrQqUn4fqyWh0QsvAOzTYsAIJ2bLlJUd06CsQ4gO1HSlfMmyk+f0
         k/QIOJpv8MdGdMYeYlzHPZuHrDVgMxypMCXXbGn8L1ILj8xONBAZEWpxNb9QZjizDn+U
         q3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371585; x=1779976385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9scMsI1aLsfr1bm8JnebjnjIPyM0AlPvA53k1dCeHGc=;
        b=d9Pxc2Z9TOsj6AkqkTxdCuqFRxoZFRnQ28c2fy2u+EONUQm2oDu8WJ93cJ4hCFZCnh
         3qUxe6CWv9/NrKGssMVG5dGsMGWUtDTWUNC+X7BJ4wSIFpoRxgaVErsEuxP5RU1bJ5IU
         O80ljIVqZc8Yil6FIu0NxWPzzwRBo3Y8cW8ogFNhqP4QNAvYfZ+p5hFOuzc5huPLs6HV
         dvk6E/oH+ZhKqaz9FGwUmY6O5bWkr2rTDko6s26ZHxurkkq4eIIMuwDvbVZFcQ7udVJe
         LWYwrU9Crv29GloGAGkviVpCLd/wIGsMA+gWp9TKqUEyn1z7NOcbjYUY69S9AEOXSNEi
         OTmA==
X-Gm-Message-State: AOJu0Yycn643gZJByl0BDnyfPRgsENfXDrO8hzkXwcqMlp1xDPND1wdJ
	lXLQyOV5EkJkTPs9SLPB9pfmQixQgNxmmTsmG6I7kAJoBY9w2GaSBtjR
X-Gm-Gg: Acq92OGqKCJfHS7ctXfMEwHDkJLgkiipv/aDOFVnkpEmFJpduyuqhfYvLuXBc2nkVea
	OrW1Z3MMf2uiV/s1l50gZ7X6Cbmp1ENbj1n0JNKxQZDVZ9r3fibJL1eeguIZALn2v5ZhT/WCx43
	/6lO6U1xQYNojfkQnHvow0Ez+ybpmzSglPMGfeXIn8tIFJ3bA07rQ1pmAEInE60hHKyFR7JgNsf
	g9Hoz9Sy5R/Tji3PJDc5ooxmY5G3QGwSxpEWjm3JlSKFBmC49ugyuN1uM4FLIze+1RvAWrGH0K0
	b8x4iHqMNfxjBA38hpcrLnqXAHl8rriWV6XtN5ksfDTGbF5z3JbUbBUTJuDPwwiIzdKO8lw8ghp
	LFRyoRoHNrsbAdLzImGlq3iBfqaOpS91FxtO3xrGq5UqqhICzOMzIQzvCKaGnU+69ngVLV6jo1a
	5+xcPgPGr1kUmhV0vfXld6J2+5bVndDTrjFrIoblGxju0K9qwfCN4/Rsh/0Kl4p3cOYEc3UUd78
	03hnAjUMtuUMRoYsjNSPzOeEqYsOjg=
X-Received: by 2002:a17:902:f70a:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2bea3385eaemr31636605ad.29.1779371585209;
        Thu, 21 May 2026 06:53:05 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/6] bpf-timestamp: support rx side
Date: Thu, 21 May 2026 21:52:38 +0800
Message-Id: <20260521135244.40869-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 124BA5A74ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Previously the series[1] has already supported tx side for BPF
timestamping, now it's time to support rx side.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=68b92ac494eb

---
v2
Link: https://lore.kernel.org/all/20260518082344.96647-1-kerneljasonxing@gmail.com/
1. support tcp rx zc case (Stan)
2. add if-statements for ASSERT_TRUE (sashiko)


Jason Xing (6):
  bpf: Add bpf_ktime_get_real_ns() kfunc
  net: export sock_disable_timestamp() declaration
  bpf: support bpf_setsockopt for bpf timestamping rx feature
  bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
  bpf: enable bpf timestamping rx in TCP layer
  selftests/bpf: Add RX latency tests for bpf timestamping

 include/net/sock.h                            | 12 +++-
 include/uapi/linux/bpf.h                      | 10 ++-
 kernel/bpf/helpers.c                          |  6 ++
 net/core/filter.c                             |  8 +++
 net/core/sock.c                               | 20 +++++-
 net/ipv4/tcp.c                                | 10 +++
 tools/include/uapi/linux/bpf.h                |  5 ++
 .../bpf/prog_tests/net_timestamping.c         | 71 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 +++++++++
 9 files changed, 172 insertions(+), 5 deletions(-)

-- 
2.43.7


