Return-Path: <netdev+bounces-259903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC7qLQxgm2kmywMAu9opvQ
	(envelope-from <netdev+bounces-259903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:59:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB971703E2
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C56773009380
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441135C185;
	Sun, 22 Feb 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHwWiTl2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250C35BDB8
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790344; cv=none; b=BIo62VVl8piSWMhYA0NS9f/JWkXRCWA0Or20J+zoI1dM4fnyrqcfMPWt440ugSOkZb9OWH1uDRB0hp8jdNjIoeVsFX2A42Uk0xZA94s5AmGZKYkICyBHNgabyixzWibbI3LzvNBIMOKZp6Vd5nfbXEpMR6sZ+8ajVGYG9R76978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790344; c=relaxed/simple;
	bh=2r0CUzvJW0jUKiBlQ8CAUks8FkA5M+bm5AgY23WtjyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZE/gNs56MKct0RSDDAVRD6mEg+2gLkCZii5qNKk+m790UHECgEGuPVBhEirVGcqFLzGGj3tPz9G6y5TPujv0mRzzcR8vXMLZ1E5ykaeIqsa6vS/1GSt31KuQDtPoUmhcYmeo0A6ItCZnFNWWI7olFnVHGWP2swd1LNAH+tREVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHwWiTl2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b885e8c6727so655486266b.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790341; x=1772395141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QUz8L/CWko35QAQoLR3+2iYYOTyA5StSVzZHwFaV9s=;
        b=mHwWiTl2s8gycdG3ji++VEgMcnuFx8cQddjV6Q5mELECSxfwdY0h6SBftlcGXNlCto
         YKQEwA7dgNqar50inT9NyQtFZGtHEmUWTan1LExLfMY9LAJG84ldXONnEoeSEXVRL9ce
         n+LfyXtW5J/AEJOU6fYd5cu1UNDHdeAFc6QCRnT4ypeld8sRBxSVxuZdJWvCL/mso3Ml
         4Gr82oW7Qv6q2EPCUEXPaBGXqjI2kLDEuJmdlIfk1kdXId++UmRfjHB7GNvjVjErROia
         j8q8NNDC46EEkXEirTEBV4lVSQkoiOZCnvke/NS54Tqvr6d5OGtAHMnU+CX0Ix40Zvnv
         EMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790341; x=1772395141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QUz8L/CWko35QAQoLR3+2iYYOTyA5StSVzZHwFaV9s=;
        b=LS5xTy8hAuZd8sHaJ0Vrzspewfco03pmWJ+rNMjAjtUQO4y62Vzm1+ttZ1pEGuLkzm
         xVqlIgMNuvkw8TN49H/D1t7yuVQxweaJ9xj9tKLpHZQZBhKWXBUZdtLSG/N2lmv6yywD
         ItU+ztMBv+bgzwyPHXfj19F6sYFztxiYFkmZ/92lD6Enb9uCgxzTIPFkb2BrkFswWMOT
         BoT/TWucr07oaX58IHJbd5IDXC/Nn53Fe6MK6hPqElR6mtF5bI796JrfbLftloTw0sAb
         4MwR4JVw8ueVSYqxA270zVLO1Hw1wy0nBcRkAt060pWmpDBm23qXd5hQpuU7iTJFR/Wk
         SeZw==
X-Forwarded-Encrypted: i=1; AJvYcCXhyt/nsULPtTHlf9WS7ViesLK+JtQd3ZRWuB+/Z8VdzfZGVz0qpXmrdead8sX9WziEELHyK5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4+NjLl5WIVQGiVmEPLpCvYPSsY+9+3U4rs9dsFx8TCSZ5NnQ
	4sSeSFy7FSNETDa/Roq9Lle9KOPXmrrTjfS+QyoR0afUVioCwDGLmqK4
X-Gm-Gg: AZuq6aKrLkNvJUy5+AMdle1tBHM+dqqmCN95lI76misnNRG9wPKrab4l9jvOwNSfUj1
	i0sDSnaWDRYxPG8Y6jjxFS1eRq90ltngqbQAqbQ3bq/luT7bjUb0blYrelMmlgSg0ruaoDOVG+O
	AMXMkFTEBiXAarrp6GOZYp3Klleu8r1FdEWMKwJuCxNWUyqU8cURUW6Ur2N8cG6gRJ7f66FdzBM
	J6/nn1TQ18avhaU1+TsED83EYn92W4ceFj1zGpEfCAtDRnVnojVm0UxLTvrNQXA+LdI3TjlObDn
	3x2BYGms3Osqp+0XSVrsQneJJJ8DZ0tG5yQf1ZBg/yvbC0EhYEXX2hmrMl1jhJvjcLhiN1SUP7C
	DhpiFP90DQiy3FHhfBZMyGjnjYPdMmPwc+DUN3gya+iJRbhcyFiRjjeV8qyyEsvztviOHnTjD+l
	pRDu5XYJmkKPwmaPBEUHjrH2gyL6IckuMb768V7VERpFJ19gBjdYB1cVO7ZvvyasmYVJsSwi8iU
	0Kjr9wJ+qD7NtpduKhQI4BeK5NmyUjSgNMjbjAvJatfPwhX3KEtlCeBBjPMWoEo8w==
X-Received: by 2002:a17:907:ea8:b0:b88:3877:d922 with SMTP id a640c23a62f3a-b9080f34a6bmr415866766b.10.1771790341184;
        Sun, 22 Feb 2026 11:59:01 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 0/4] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sun, 22 Feb 2026 20:58:39 +0100
Message-ID: <20260222195845.77880-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259903-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CB971703E2
X-Rspamd-Action: no action

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack and to
bridge filter chain.

Changes in v18:

- Rebased
- ‎nf_conntrack_bridge: added #include <linux/ppp_defs.h>
- nf_checksum(_partial)(): changed WARN_ON to WARN_ON_ONCE.
- nft_set_bridge_pktinfo(): changed call to pskb_may_pull() to
   skb_header_pointer().

Changes in v17:

- Add patch for nft_set_pktinfo_ipv4/6_validate() adding nhoff argument.
- Stopped using skb_set_network_header() in nft_set_bridge_pktinfo,
   using the new offset for nft_set_pktinfo_ipv4/6_validate instead.
- When pskb_may_pull() fails in nft_set_bridge_pktinfo() set proto to 0,
   resulting in pktinfo unspecified.

Changes in v16:

- Changed nft_chain_filter patch: Only help populating pktinfo offsets,
   call nft_do_chain() with original network_offset.
- Changed commit messages.
- Removed kernel-doc comments.

Changes in v15:

- Do not munge skb->protocol.
- Introduce nft_set_bridge_pktinfo() helper.
- Introduce nf_ct_bridge_pre_inner() helper.
- nf_ct_bridge_pre(): Don't trim on ph->hdr.length, only compare to what
   ip header claims and return NF_ACCEPT if it does not match.
- nf_ct_bridge_pre(): Renamed u32 data_len to pppoe_len.
- nf_ct_bridge_pre(): Reset network_header only when ret == NF_ACCEPT.
- nf_checksum(_partial)(): Use of skb_network_offset().
- nf_checksum(_partial)(): Use 'if (WARN_ON()) return 0' instead.
- nf_checksum(_partial)(): Added comments

Changes in v14:

- nf_checksum(_patial): Use DEBUG_NET_WARN_ON_ONCE(
   !skb_pointer_if_linear()) instead of pskb_may_pull().
- nft_do_chain_bridge: Added default case ph->proto is neither
   ipv4 nor ipv6.
- nft_do_chain_bridge: only reset network header when ret == NF_ACCEPT.

Changes in v13:

- Do not use pull/push before/after calling nf_conntrack_in() or
   nft_do_chain().
- Add patch to correct calculating checksum when skb->data !=
   skb_network_header(skb).

Changes in v12:

- Only allow tracking this traffic when a conntrack zone is set.
- nf_ct_bridge_pre(): skb pull/push without touching the checksum,
   because the pull is always restored with push.
- nft_do_chain_bridge(): handle the extra header similar to
   nf_ct_bridge_pre(), using pull/push.

Changes in v11:

- nft_do_chain_bridge(): Proper readout of encapsulated proto.
- nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
- removed test script, it is now in separate patch.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (4):
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
 include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 5 files changed, 177 insertions(+), 45 deletions(-)

-- 
2.53.0


