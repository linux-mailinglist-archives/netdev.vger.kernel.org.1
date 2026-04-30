Return-Path: <netdev+bounces-282974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOI3BwGj82ly5QEAu9opvQ
	(envelope-from <netdev+bounces-282974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:44:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F00384A7187
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E73D33003353
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590E47B401;
	Thu, 30 Apr 2026 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U92MX/DK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AF45BD45
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574652; cv=none; b=dc1HDlI08roXiN+0lACB1qqCxGI+w2FiMRQNH5ZiV8GydECJifJR4zpzv9H6MmSL65JY9/YOiJRf4JM4IVNG4uhs6PbgHkmd2zhWJTvTna8dLZYAOGATIUBEDwVxJAVFqxHgLNdTrc5HmxP+f0kV5CcKiuAJt5FRkN8m3juAgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574652; c=relaxed/simple;
	bh=/PRIKgLfKPj4zMKorNmQ1wB3iJTK0C/w2vdDIs7PKVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OCQql1Nar8IXWkqIp0ail2Y6HI65K/UCTdK4OwMnifZthmx3RXq4A+oflxPnXr/AzVFAkhwF9QD9e65WJqVXaTsj8GITnaKVMb0FOqhLzafD3fHDoQcNRpCgUscoBBAlrzBXSstFzQUm8SjBAGhQAWO7c6j7ZPmgBns2O2sGn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U92MX/DK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so1529033a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574648; x=1778179448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YSFg1U9KtAY77SgXkcle8/Z1smWtplMzJzd6qV/sqH0=;
        b=U92MX/DKFZjA2U0RpyT4OPLiMTkZnNo6UpEezgKpey9pTj0Q6ivtJLxfqhduwFs3Ny
         zdlynOq/yrfN3Slp7bs7J9F3057oey3DXssKn7IGNYBKC0mH+esBQkJo0O2hSsmc0xcV
         31Q3zlAaNFrpDNzBH7KXlWIx4SmbIQ5FUBAF/1RckuG0AH5Y3XHINvc+243mCQTwerki
         /C6O+U642gbXOj/zjmFQPGQitgIhajw+S79pyTo4xJR3ZB2WZYa/PqvuzDCUt9RwqBYr
         Zt39kVRAmq+72WC2phGfNeAanb6UpAXDxBGBD2jo67as8eyiLnmeGVD5A7QBoz09OsrG
         0tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574648; x=1778179448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSFg1U9KtAY77SgXkcle8/Z1smWtplMzJzd6qV/sqH0=;
        b=gu5t8ovJDUIB3p6EolWl4m8XcV4apfva9V/PUuNA5JQS5lIyh4T+M499HsKHGGjayW
         cgC+rDDpRXIWLnVzYDZDVBJznCzFqA6IXT1iC1/NpkYuhzr3hQkn4ikGtHeybuPkbMGl
         ZlBsGHo2UDPuool2jqEANgB+px7YWM2XIv8PgVL/LUI1yJ125GE3NMlnKlpDbiUlluvH
         r1vurv2ZWVsCKVfkAJJSR7ka1s5/dAQDDAnAyDM0BEQI/HxjufrjnK4Hc7XtjXDcYOJK
         98s7pLV4e+QdnsP67qjZnBML+SNtdHdMhJFbO4+IzNCE/D7WGDGJ6b10IalNmIBUQaf9
         zh9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+P2AwgkA9zcHFFJ4vtZWoSAKb+bLbwPvpVBW3d49cGWjeqU3Ndi66XrzHjJ6ZTAvcl6Z/Fa7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhkrCcuJqNVGVCuGvRpA0CvbTnrqYnMGESQxhvaclIKCwzFjR
	Y6ZufV6ya82/Hor53qWKN6RbwWsMa7zhMIP9fTg4k4nASwH5r9dneMTJf1TmLnvbOaA49HWW5eG
	E19MWXw==
X-Received: from pgbq1.prod.google.com ([2002:a63:5c01:0:b0:c74:664d:4080])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0a:b0:39f:aa3:5e56
 with SMTP id adf61e73a8af0-3a3cf5e8cd2mr5001483637.14.1777574648207; Thu, 30
 Apr 2026 11:44:08 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:43:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430184405.1227386-1-kuniyu@google.com>
Subject: [PATCH v1 bpf 0/2] bpf: tcp: Fix type confusion in bpf_tcp_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F00384A7187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282974-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

bpf_tcp_sock() only check if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Patch 1 fixes it and Patch 2 adds a test.


Kuniyuki Iwashima (2):
  bpf: tcp: Fix type confusion in bpf_tcp_sock().
  selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.

 net/core/filter.c                               |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
 tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


