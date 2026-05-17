Return-Path: <netdev+bounces-288685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3MBDlhCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DE55F82F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72A6130054E9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618922D3A69;
	Sun, 17 May 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPygyvdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C92D8771
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999606; cv=none; b=YIwtoSPkw7krEQJA7hOATkx9JZKt+6TSZfchbB5vthNQ5fIVi546ZPMeWcmoX+6wBpXx0T3/8kcp1LzVOB0e+PIFV+LFDsHUsnTpHNFKn/0YuB05LdMrw2k3Vw9KCkRNvIs6bo6ie03jWR9ie6hdIDjKKhurwYOoIZcDlrwHaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999606; c=relaxed/simple;
	bh=Iembz5WZriJohL290gtclVjvHwhKD+3xwyU6eomHFpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7Y34cpqKFeqz0p/ustmTbn1c4oqSTPQeBJfbcsPS9MbljpyQDgjw2Y8T5v5wufPlBp0o8ioWM7zUY4+0NRpishVwbtsA+zi0i0J3CalXLJUjJ0QRpuBUkfP4lLtgZj8z9bBycOaPTy4JJ/6XbZL6DtBLTEorzng0hrWmxKCRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPygyvdB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bd266f6fc0so5651025ad.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999604; x=1779604404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfn1wnsws3qKZ05OCo0NYpyEDF6wFwNBCzjnVjoFnoc=;
        b=jPygyvdB9RhtK8NFZ60B83kyCs0F1KmQ1VsPwROEQlVOfPO7zkzOjEcP4o9Hj+geU/
         ft7WSdmcPqqjcR96JgnVT3qUB3mnRAjNXP53ScG4DtsC8f5ptXXT2Un2VHAjcityO4e1
         FGFvSF7Gr43BXKnsH6Rv4oge8JXajq7RB3JFH2BrW7tRAgb5dZ6XjwKBM7pscLOhWDus
         UNnHdnsIn4j6JX0T6eDEMn8uR6Vf4cP8rr8Wj3CrIGBhytSK0MrPysQ7PvWmehS680uJ
         3TcYDpwaZHKGF4ZkJkKVQK4lk8QfTEmOegZQpdYBVjR0ZwBZiPwkZu7m/M6pFKYoTPsN
         uz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999604; x=1779604404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfn1wnsws3qKZ05OCo0NYpyEDF6wFwNBCzjnVjoFnoc=;
        b=AAWOJJMdTUKjqSoi80Kwx0YLECtAb76YPqnji1K/NwKYGjhR38M//dEP3UPqZeNiIn
         9DT/6JzXKsshGHUYlcrHipCzdA6agfbxbkSYoi+ySTFA00l8NVFLRJIS9TbGpdSC58hY
         ye1nPAO7ymZR9+5NvQoM5XXZek1gpiKd3JaC14ng/dOghuTzy4B6gCTRuLWf7hgGg7Me
         TzzK2xNzXk1emuSQBHrI9tjwVb4lUuyHAx1KbXs/DnhIxJK6gu/v80JXzg468vD7PM0g
         WZ/4IOJ4JHXHtctyKit4nInKHN4zBFxrWoQjaaUsALz1PSPktf5f2NZun2ljMxU9Uxl3
         UdJg==
X-Forwarded-Encrypted: i=1; AFNElJ9o2dGFuJqqKFBTMNQ2qqqzDv+iPphhc7Ln4IYvRrrSVYLOOAvMYLeCPa25yq84R5fYTZPzLhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZYBfFR3j2E8JDo6llmPY2AmtvVL+baYne9yD0OZCsFnLMNtK
	H2mZrStraRctTJPJSkN2NqYCHX0CE2wNZvTY3rn0jcKJDncE4rgkWzzM
X-Gm-Gg: Acq92OHBgUaPlzwRvn1KEUfBsz0uL5q+Or1jPmJNRq6hz3xOHqQkh6wvx2OakfGTLXf
	lIkqV54OdmSrurp5yf0zXu8zJ/S5Y1egfVYwnd09koO6R8zg2csEzmb1egLCuocNLu7v2K56Gs0
	n1YBc2cZ5lo1pgx1GFIMOMa5G2RxbHajXo6Snc+rgzqyUtDN/I/2L/EtfKuA4zHMnwtnADhG0iw
	F1Y6ibbrTsdM0A3nYfn4jMuZ+tTgS4b0lkP64Po8JgVcJiYZBw7387XAUyxjeQk5FqtXe+ZEZDg
	Eo8v3aGk7gnPonrLxD+CDji+jzI9ZFuREYndx7InfqGf0IL4haElJcE7xPQucZii01smIj2M2fN
	DT3F+Ll6rJjuj9su6nIA5zKf3ijlq00uM53e7UDj6QZThqDAenH8ePyIUJxkuQ9Omz3Cds1KsoB
	l/BFPBu87vOGLfPEmyPd4rDTmGsG1Ba4EoMcJLmYKe1u6KLX5sEvDZAwKaiC25VyjdoBbry5BUj
	AJcjMxq3tG6QWvcexBQJp7hotg+5Hc=
X-Received: by 2002:a17:903:24d:b0:2bd:9803:9308 with SMTP id d9443c01a7336-2bd98039479mr77245475ad.36.1778999604411;
        Sat, 16 May 2026 23:33:24 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 0/5] xsk: fix meta and publish of cq issues
Date: Sun, 17 May 2026 14:33:06 +0800
Message-Id: <20260517063311.28921-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A86DE55F82F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

---
V3
Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxing@gmail.com/
1. avoid breaking previous usage of sendto, and siliently handle
overflow case (Stan, sashiko)
2. add one particular exception process in patch 4 (sashiko)
3. adjust the selftest to make sure it passes in either virutal or
physical machines, which includes add usleep to support physical machine.

V2
Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxing@gmail.com/
1. adjust selftests (Jakub)
2. add READ_ONCE in patch 1 (Stan)

Jason Xing (5):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()
  selftests/xsk: drain CQ to wait for TX completion

 include/net/xdp_sock.h                        |  1 +
 net/xdp/xsk.c                                 | 44 +++++++++++++----
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 3 files changed, 63 insertions(+), 30 deletions(-)

-- 
2.43.7


