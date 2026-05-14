Return-Path: <netdev+bounces-288044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLh4J8v9BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:52:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB28544F24
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A537930342A4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216933A9F8;
	Thu, 14 May 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3/xM5B6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF631ED7C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777509; cv=none; b=tHqHg+UpH0zO9/bWe+4/pyi7kNZcnNGLM0kutEMjG/79ahCsSoVPe+t/3g2DXQFNcsM98KZiInN7pQ4frw7Smh8uC3Y35LJQnP5ZF3Z421pxp6Pd06P/ctnDV0E1WseOT/jmyvIMswF04WX9r5+Vl3mfWFRiIaAmdXEMndz/bnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777509; c=relaxed/simple;
	bh=hYXAA7aXalALRkWgfGuP0w+RQxSmZCydDdMOcZxX1/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BopHU7mjIKEM8ZIDTvNESayKoAOc+pJRO5Q6XWozLOg6AfpkpMC8EKFRcZ5fcH/flnvC/jiyHa9Iht9C4sMEafoayq4K+AShqcvmSOOcvlh/YD8mGrgVXL8lZJEL5OxvDbHp43urx7s44aQjvSKViV3FuN6To3i1n2qJ9NcQj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3/xM5B6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b45cb89f7eso52729505ad.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777507; x=1779382307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=m3/xM5B6pG2NR5nomGt3ZmTwYSS3wPcf0QyCE0vtPz9LK/9lv/CztxkWi9paUxO8FK
         eCyeJ8/pNI2q2SVBED/isBR8aOb8V3dG8/6JFJLzdngLizZnpjIi+ZOAf1YKiFnCm+PN
         LL/WeeY6kTdkBtwHwqcW491WeHdbnwkYDJ8JE/Zqf5UX4/6vCGjkqAJZ2xp8usoRUYiC
         jOiREK4U6MBShmtgHym0WSnAqk+XINlKuSyIcJK5jTtMwKk2EzOmvd626nb4cSyTSKuX
         bVAXGGQBoTglP+Q1Xc9os4xh5pc9bJ5BvwqcoRsj6IQhNY4zXH61/9xVGu7ZhIy2zROT
         GAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777507; x=1779382307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=i8Fu1Z9rhf3A9OGT93bzb4D1d9ALNpmnjt/nfX4SWWtQzQrAnld/oMfFWY2VYZ7GLn
         h8kXT1EShOMXIf6kulide2gvViufdicAjVzoW0MsBhF2+/R5tlX+GZufzcYTh0Ew5zdM
         LQfPjEoFZX2ZWq8dhCf68ahKSegM/xtT6+p0Fvn9KPhOpF9I95BOyLKaZ4+hexViz/wf
         c6L86tl6aB4TgRp9wGVdZurLHGUSW2zmH4MVhqmIIirxaiusHiAFMooeNbBvPM8Nmozl
         0BZYwMtqRUT7iLf7lNigu+y8GrVegq7pUMZa4BRxQMqe91TRRRKU2wnnq6c6kvpwKxPT
         88VQ==
X-Gm-Message-State: AOJu0YwppgW+0EPoFzHfwQP4m+bhCtuvG5qSIEHzMgwB726JFuvZ7gPp
	CG4/fRUkA08wxqrXlhKSbLCUqLMIFHvZ9yH/wdSkloUjbTDM84lhpFq/
X-Gm-Gg: Acq92OFWQKtGXbOb6HyzAh8J0YDJ2hnhSaeBgQZsQKW1z8GV+S+ox8yEq8XLNem0U4a
	3Kw3/pa3FnasW9Jz12FDlS0Nsi59TLQva0YZ63xfKzZ3dfWNJ2rm07L/eGkRciewzPxklw6KvJ3
	uiBhp1PewI/q/UdfX6m/hau3nBRIbDcOXoer7oJdNzTfdWpBwB6nJ2vjbnCXLeapj6ycFX2Pqlv
	RT0PqUVFOO0Uuvh0dcaZfhnxid3jn+zF+6Eu7wQptBa3Kmbphk7K90Wzls4uoiFbXN9Ec4bGBzE
	lZFBVSKa+vGcJzlvyMB21C69Ddwf86Hv5f3Lcm/9phFgUkdRw0dy89bHIb4sx/dW6oXBhKARHA2
	Srf+42aaE6eDEZaS+X38/VwCydTLVR6k4njhGJWymxtNgtoldfLDxExW04/Pd7hKGZseeJegFq2
	8WgY4WIrCPaAfhHrMt178Youpi/nt0azpq4Djy+Q9J
X-Received: by 2002:a17:902:c94c:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2bd7e7c7ad0mr4187315ad.9.1778777507059;
        Thu, 14 May 2026 09:51:47 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:46 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Fri, 15 May 2026 00:51:30 +0800
Message-ID: <20260514165139.436961-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECB28544F24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com,paul-moore.com,codeweavers.com];
	TAGGED_FROM(0.00)[bounces-288044-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
                                         driving SELinux/Smack MLS
                                         category bitmap.
  4/4 netlbl_skbuff_getattr() / CIPSO    Sibling of 3/4 on the
                                         AF_INET (CIPSO IPv4) path.

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
 net/netlabel/netlabel_kapi.c | 27 +++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.47.3


