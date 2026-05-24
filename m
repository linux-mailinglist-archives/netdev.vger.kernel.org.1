Return-Path: <netdev+bounces-291141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEnhA0F7Emom0AYAu9opvQ
	(envelope-from <netdev+bounces-291141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:14:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC95C159D
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 678C9300FB78
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2819D2EAB82;
	Sun, 24 May 2026 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVBn0iqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663D2E2DF2
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596092; cv=none; b=MVaLRDQIGxYShBG9UwbYVCtwnpqKdHRjrwx/R25UwP7ZPtZTXpXDoebzDN45W9cfoTfNPtPg90CO4+4I6sgsqVRBgsOpvoVnRgvoMmItDAKoguMYBjbBPOY8TJlssgEtp6ME1vml1WKzTrdGerVAWkk2CYoGrZQq3mz7RbGlXDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596092; c=relaxed/simple;
	bh=TEOa/Iseq3bNDqxAi8ANzlQGhBUm4ry837taToh+6gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvwdXq9kGLBArPQguT2FZYqMCWbynSsVo7IxjFgKvSMF4GMUNun74BH7Kw1fvL07vVU+/Isn3Ca6mKHW+sZNSm+nEb8D3mRLT3EjNvyUzTIbLuKOFOrFqW744J8YHqNmrUjtSJZW27bdbesSOWDXOnNJGIX+bueWYkwYyTVmXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVBn0iqo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3042dffd80bso5047349eec.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596090; x=1780200890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qALrKcl/VHbNho7HBnjpVTkFJAqEJcLvpErXnBAKDNc=;
        b=YVBn0iqoVc4vHGoOW9n1LpeZtHcJ+8qKCEFpr2NfKUkjQ4ViScNXQDDSA0/MVXvh7M
         Huxj6GjwNUKM7xhfnVsoXg7ssxPYp1E7tJb7C0sjp42CSaInBTwPLLkRANkJJuR7PqdG
         DVKJIsfilgrcDAmH/C3MipN4yYdcraHcsX4C23fdFRS5QbEKin0MBmBRymFYYGsFfE1+
         F75BHQurnIuwDtuf0QaLxpGoIpag8+QoWX+yux8BMVN0ltsplzaVfNcfOn1IAhrPm8l5
         vZWMIzfbifejm+ea1SXaVSqH7XvhbzOG/PW6ynws4LFhYvkpqQCFqwhzwrwuvt8/U7u5
         bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596090; x=1780200890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qALrKcl/VHbNho7HBnjpVTkFJAqEJcLvpErXnBAKDNc=;
        b=m0QChMHxr8aDnA8jNzAItUQRC8KYx/7PzQMOe3pj2Q4bfcN6CbVFTMVb8Vmt8Xu6xC
         c/y7WSMxycBOY5tXSDZVj167OxIBywSkYtNkmUds/FOW8pVzPiERvC12HeoG4B7G+b5d
         1dgP7eo+xt7vo8P96YQTf7PBKxFUULsnQ+4csbha/xYIzFkgCxfuW5FI5rw9X1IVTLQ/
         cwyVXlwWKVWbvv0Re4/yxEkkSYet7coGZR7IyEO30ObaeNtJZTWxRDqBlyKr0vGI0pw1
         /yVwL56pULXPpltkmcYfcVMWUtKAQbajoe7LFvC3tX+BuTZu0jhh1NHHQpW0H2Vu8Gxm
         De/A==
X-Gm-Message-State: AOJu0Yxofxsj7sAmyTdsQ07IUIgpUjTBS6JUymtspFB2M/0sOWUyreTk
	lmJceQufNJytpMHYAS+H9H76Ow9o0LtwJoP82dHNDUWJuquzneTzgH7H
X-Gm-Gg: Acq92OH5UAANVaTZL2mvTc0YXFL7cGs7a+7ZaBUjMF5JnlHfgnTR4DVp51x4xTLnW1D
	jWPHvi3AUHzIDmGNmBM8wboPX++f7ENdHBTbb+kVK/UOJqEdUZ15KRcs2VaZSojF6Pk7ahG7eti
	1lkDX10+VeIuzmXjKvQupuHxAsl+f0xuTe0hYvqbmM4/dKalF/CLrIcpy78iWnqCZvHQq9A2Ry3
	BKnebWjfRatS2pCXrYMKXupwkSVKPhxT9HNdSS3sd8F8cTXOG9VKzfqthyalaWmMCFqmMd8tHYn
	MkfIcH7cGWHpUmRXy96XGM9KKwqvzRuo3ytjR27zMsbLGJZzAWHKjpQM+sx8ia33FJZldOq9TOG
	rv/NrZU7Je3R7oJzqoMDyzF/6bfKQTAYT5vWFMc+P3NZeEpI0LfnHKjCuiDc1LqNQxkLFlmH7bU
	dzJMQP4fIJdwo0Ks5ZkEPBFg+N89uv+uVPvFcqI1uq4tei
X-Received: by 2002:a05:7300:6da7:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-30448d6218amr4757606eec.0.1779596089593;
        Sat, 23 May 2026 21:14:49 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:14:49 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net v2 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Sun, 24 May 2026 12:14:34 +0800
Message-ID: <20260524041442.2432071-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,kernel.org,nvidia.com,paul-moore.com,schaufler-ca.com,codeweavers.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-291141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 70EC95C159D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Four small bounds-check fixes for a recurring pattern in IPv4 options
and CIPSO/CALIPSO consumers.  The parse-time validator stores only
the option offset into IPCB / skb metadata.  Later consumers (cmsg
echo, mrouted report, netlabel getattr) re-read the length /
pointer / cat_len bytes from the skb body and use them for indexed
memcpy or bitmap walk.  An nftables payload mutation reachable from
an unprivileged user namespace (CAP_NET_ADMIN inside the namespace)
rewrites those bytes between parse and consume.

  1/4 __ip_options_echo()                40-byte stack OOB write
                                         (KASAN: stack-out-of-bounds,
                                         Write of size 255).
  2/4 ipmr_cache_report()                Up to 40-byte OOB read of
                                         skb head leaked into the
                                         IGMPMSG cmsg delivered to
                                         mrouted.
  3/4 netlbl_skbuff_getattr() / CALIPSO  ~232-byte slab OOB read
                                         driving SELinux MLS
                                         category bitmap.
  4/4 netlbl_skbuff_getattr() / CIPSO    Sibling of 3/4 on the
                                         AF_INET (CIPSO IPv4) path.

Florian Westphal's [PATCH net 05/10] netfilter: disable payload
mangling in userns blocks the unprivileged-userns side of nft
payload-set at the source:
  https://lore.kernel.org/netdev/20260522104257.2008-6-fw@strlen.de/
These four consumer-side bounds checks land in the same direction
as defense in depth, also covering root / CAP_NET_ADMIN nft
FORWARD payload mangling in the init userns and any non-nft
mutation path.

Changes v1 -> v2:
  - 3/4 + 4/4 return -EINVAL on bounds-check failure instead of
    falling through to netlbl_unlabel_getattr() (Paul Moore).
  - 3/4 commit message drops the "Smack" mention from the CALIPSO
    consume path; Smack does not currently consume CALIPSO (Casey
    Schaufler).
  - 4/4 inline comment explains the literal 8: CIPSO option header
    (type+len+DOI = 6) plus first tag header (type+len = 2) (Paul
    Moore).
  - All four pick up Cc: stable@vger.kernel.org.

v1: https://lore.kernel.org/netdev/20260514165139.436961-1-tpluszz77@gmail.com/

Qi Tang (4):
  ipv4: validate ip_options length in __ip_options_echo() against skb
    tail
  ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
  netlabel: validate CALIPSO option against skb tail in
    netlbl_skbuff_getattr
  netlabel: validate CIPSO option against skb tail in
    netlbl_skbuff_getattr

 net/ipv4/ip_options.c        |  8 ++++++++
 net/ipv4/ipmr.c              |  2 +-
 net/netlabel/netlabel_kapi.c | 32 ++++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

--
2.47.3

