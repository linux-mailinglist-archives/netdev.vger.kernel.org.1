Return-Path: <netdev+bounces-300397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aWIMCRjIM2rYGAYAu9opvQ
	(envelope-from <netdev+bounces-300397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:27:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D499769F4E3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vxod0Tmg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300397-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A5663006449
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32693C3458;
	Thu, 18 Jun 2026 10:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835953CA4B8
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:27:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778452; cv=none; b=Rf23b6SFCfhH/d9dli9ttYZnCNkJB1P4UsrmsSIzYj1/nvtHB2xzom9rKXhHJlW2NwEdB7AxTukYH0YeM6Z4XMY+m1W3aXgWsFz5HxWuuuUBnlfSh6NZtL8DiA46c6PgM091K9YyUZMw6JviVY0mvyHdGt0V7xKqXWSSKOj/3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778452; c=relaxed/simple;
	bh=ie+WeF9YvCciqNwiy2FTqjhEPlH33sG92o0tD3DNuUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MReY6RDahD5u7/XMtUMCPGdCLrxLrQGg+eAy6/2ZE9rgxOs0Mmo62WQMxsgZVJOJBYia0IGIwDJssu5XQ7LIMrFdhimCpHL+tiY/E+1xyxk6YXFGbHNZ9bqQdMmAME1Qj/ZJWZy7pyDRQj8gwN1q+51MMxV4ZXlS1zCFA2J9vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxod0Tmg; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cb36ca63bso388869a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778450; x=1782383250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+g3ajtkFOOFkEfqzNyMI8IOO/HHBfQmbFF+r03Fz6Q=;
        b=Vxod0TmgOV9GfPZJ29LcTX7XF3tczpqFvgyuvAMMZADv5UyG0PoyHU9iE391pFRwyY
         TaPBVHFHPd1pOTfvqyReAD5AP2THdJSjkqiBSFwC9T6UAS7Ey//vAB3BBf5VMZJHqpc/
         IPKBVnp02TjQII0ZuBBvbD1KEJwaobEPGE8PtpqfIfp5y5WkPuDQCWIFYDZb1noYscoJ
         Ra+bWxhLib7lX8Hpl0qyAf2N4YKpdX62YDks/C9/nHVLwGM5cnPMxXOqL9+epcdD5kW9
         7KW0u+VEmDtIUYLdsJX3IbE6GnvaRhqhO5iXFgieXrxwaHWt954vUn+LjqnrkmwaAN7m
         Dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778450; x=1782383250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+g3ajtkFOOFkEfqzNyMI8IOO/HHBfQmbFF+r03Fz6Q=;
        b=V8tdhtGfRfKifM8hywchLHG+JVKAyyvVFN1zJrCvt347KDH3MtZ6BR/6repA4Gpmcs
         l/t19X8JaZosXXAY7gZstF1C3aRv1vd9FKyrpomGcC2CvsJ+N3Vsqns/AimGcotuJB/1
         sxKzevQFwGrJByhNAgzX34k6j+miFVqvcn/6xH5FK5gsrAiqWtZOyrlL/5J0LQPEdnf6
         S6RDFHzGqbge32zzykWuUtRm9PmPWrloD3RJNMZi1MdhlSXn9fzICfuSjSJvBdGGdkrI
         A0OVeAq52r7B25VQrjEnIjNJwPizklX4/fKflNJsi8yIB1MtdprdofODzZWEYbhdTg+K
         wPvA==
X-Forwarded-Encrypted: i=1; AFNElJ9hA6GuMpiFU/uHpwmckVV7Y4CjOVe9Ze4Lvnx8VaXwAYV0ch7Cj2BBjOEdNO7UgIJLg5Hafdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzgJ35gQIZJh8w6yXEQ0pQ/35QzIWvqbNSSSJKG3ulOJOt3Cy
	QM2RYA/sA8dWe6e08ekRycFBybz4Xl+4jtm2ZjfS2RGWzCZV6/bKTLt/
X-Gm-Gg: AfdE7cmwY2YhPhzowX4VHAw/PV5I+BgfMoY89k6xR7quROmScNmQnnOIBpWzpdCTgcr
	rK76T9b8NSGRo6dl0k4ly4IxWmbHOAR6HgKZga7O7n9jsgp4ifuHGmrnl8BDQotHQ/IB9+hgkFu
	R687V9684mUw4G7hyJ9gcTt7jr3NjhGRD8l/bGsY0uK1PVEFukLgS7oB4TtUSaLxGo6xSCOgvjC
	JggJUoiTmgA3uDa/uNVRrllVSJJil0qadXoMgGkMnlu9tHMQaGesMM9LPFa420kC1othmnPHcvW
	/npuQ9I+lWJfWn5Pb7Gt0YJ6viYTOFYK3BPq8MSReNeyOkFP1GQQJlP+X0ZdfKui16L+3TlKmUK
	uEyBqbquPm/uEME1A6NcOzg+bqF7CXpe4Gd77U/NhBQBWHaFSw7vmsbPWkOAUpDbDVe0bh+LUUM
	KgNRKDdTYJQ/+AhQxBIZLrjEU5aQOVburgRPIBzbDNPqB5x7OIAgU=
X-Received: by 2002:a17:90b:3c12:b0:36d:8f51:fe29 with SMTP id 98e67ed59e1d1-37ce488901dmr3403296a91.17.1781778449635;
        Thu, 18 Jun 2026 03:27:29 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:28 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Thu, 18 Jun 2026 10:27:06 +0000
Message-ID: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300397-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D499769F4E3

A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
which can chain skbs through frag_list. A parser that resizes the skb
frees the frag_list segments that strparser still tracks through
skb_nextp, leading to a use-after-free.

A stream parser is only meant to measure the next message, not to modify
the packet, so reject a packet-modifying parser at attach time rather
than working around the resize at runtime.

v3:
 - reject the parser at attach time instead of cloning the skb at
   runtime (Kuniyuki Iwashima, Jiayuan Chen)
 - add a selftest (Bobby Eshleman)

v2:
 - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: fix use-after-free when the stream parser resizes the
    skb
  selftests/bpf: test rejection of a packet-modifying SK_SKB stream
    parser

 net/core/sock_map.c                           | 20 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 3 files changed, 58 insertions(+)

-- 
2.43.0


