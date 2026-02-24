Return-Path: <netdev+bounces-260353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHPFMklLnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:55:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FC18295C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB50530ACBF5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6583093BC;
	Tue, 24 Feb 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA66euve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856A3081DF
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915995; cv=none; b=sRkLfhuc6/U4p5TMwiMgod/qAm0pFj4NR1+w1jK9BmgEaYzTuQdIq9ERjU14uRWbLhfUe5ltPHVzJlp8wMxuW5XifrKHKAAuJgk0RN3fHgNLS5Kn5u04z1cy9Zf9KgLB478zmKhw5f6YmsF/aVIH+72sHwK+0t6X6VN1wO2rEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915995; c=relaxed/simple;
	bh=lP3kra2h8AICEkoINsLGhXhIuRHfsSfxRft5F4Y06uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1rHh92SXepSrt6jsibcWV7YNXl/+GaIGDgHx27dR1Kqvml694v/vHYiUG9sPgxPOYrJrMvqVbRRfTNs/mARTuxz2i9KNva5wvEw2M9A3wnr9w7Y4DTI1M3evgEdw0DYP72R3Un0Y8c60XoHiRlHJc+1Oc86dYecUNBaM687Kpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA66euve; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65b94e0a875so7361717a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915992; x=1772520792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv3dlNi6mMAZcD4s6zkCWcTjX0AEel78U/A2n3eqi1w=;
        b=EA66euvee/okA1s/FCGDdkiZjtNziaI0tN7oh4S1XrTBRvIPLqkQxfzq7ve1+HDvis
         VYr11HYk32T2ps+XOTAMiJZx3Ir7Wt+7h3C1EHFOkQEGWBUAPKn2gR1gqscslcroLqsG
         UaJPwL5wH8gokO96M9OjATXqqAa3fJbw+DWgP/q6Y3WpNnqAdL4ZuQiJvNrRPxyu2eQh
         DkhsQk94rI60UarLTOP+JwoVGwcvF3UcGlFWsiuSXAizv2lMfQe/9r08bXlX17+ibP1Z
         tU55XKkIfZF5ApmAs1yJY3k5xlQ3OySBqe6ECRfoEbSpifhFPyLRyaYm+wo1dDENHkzX
         qKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915992; x=1772520792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv3dlNi6mMAZcD4s6zkCWcTjX0AEel78U/A2n3eqi1w=;
        b=awkWi68TLT8um8u7lF60chRfio1wNnsA5fpLJEatvUNnDoQKFMzxJxLxLqFcPhUElj
         UafSzMQENVebJJ5QIrtec1Jkr439s5NALyo7aTMrEpVOk35nLydhyAQGrB1AqeZDqKwz
         ZWxDMFdNzHzwPmYbdwd9v0S370uKpUOj23iap1UFoDU7JyGisWBrudkz+Td2qWl3sPjv
         pbz41tvCOARZUgE/XATyLRzYloqhOdlOvgio6UF88toB6vOmb6eN+WlQ1Ig6qfTWeyOz
         NA9NV7UfhWBX6CXbApCAqNYc+7Q46dSHbae2Gi/gbXogIc1Khy3aGFNl2iwEoJQSgm99
         wdwQ==
X-Gm-Message-State: AOJu0YxPp0mapev0b56eZqkW+dPcLHz3sJbHLDXpcZ/FczJHOQxMmRGX
	QBvCkx85nwFmJvCegdXlWrwBayn/qyF9968t6OA1wSkc5HlH7JRvncKV
X-Gm-Gg: ATEYQzyTaIwrYJIPyxk/Tqn2d/VjbOr293Gr3Bmk/kgqawT1LtCKil413e3b1vCcCA7
	mruiqY6VextQ3rUGthtAhnL9GrcNDjtyEliZHbT14NxJw1HS/cjbCs2juSWqaH9q9leNspOu+pN
	lI3Xnlc1C3Rb+054k9UZUedd5PtTjojJADeritriRAPgHXaCDXHGhpscJb37doAmhRvx4027+HS
	D8w8qqJwVD4PKEr3p1Gh9Gs9KlEX1GIMjXaS89+kCD4FTcvhepNywQqXGyK+ruCIvMNp2D+Vm7g
	KnfZytviZhD+6FkSjB6ub3oMIKc48E6qMcvnLtZxwETE9i7z/X3aMUGpGvOHwp7tl9aKfJFOgYw
	ijnerBtrrYM3GGPO1u+PIqrUsSNCQCyGTU3I24QSbLaimwfq7iZyjC6l16S5lm7oAbmylHXnqPX
	XuU/LHjtyZCMGtrVQhM2KuuBrbNiSRLusuBCW/MXEbJ+cEZQznd5YGZZQvPjd4JeRw9SnVvKYkj
	dMrXH9PPBl6RrzYw3MASbksoUPHu/MnfI0akSUAhbLWjfMLdQFhZOM=
X-Received: by 2002:a05:6402:2346:b0:659:4b76:74f5 with SMTP id 4fb4d7f45d1cf-65ea4f06505mr7015657a12.27.1771915992251;
        Mon, 23 Feb 2026 22:53:12 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13866sm3096698a12.18.2026.02.23.22.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:11 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v19 nf-next 0/5] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue, 24 Feb 2026 07:53:01 +0100
Message-ID: <20260224065307.120768-1-ericwouds@gmail.com>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 491FC18295C
X-Rspamd-Action: no action

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack and to
bridge filter chain.

Changes in v19:

- Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr.
   (It was part of other patch-set of mine, moved to this patch-set)

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

Eric Woudstra (5):
  net: pppoe: avoid zero-length arrays in struct pppoe_hdr
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 drivers/net/ppp/pppoe.c                    |  2 +-
 include/net/netfilter/nf_tables_ipv4.h     | 21 +++--
 include/net/netfilter/nf_tables_ipv6.h     | 21 +++--
 include/uapi/linux/if_pppox.h              |  4 +
 net/bridge/netfilter/nf_conntrack_bridge.c | 93 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 7 files changed, 182 insertions(+), 46 deletions(-)

-- 
2.53.0


