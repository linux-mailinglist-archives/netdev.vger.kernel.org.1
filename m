Return-Path: <netdev+bounces-287074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPc+AkoCA2pczgEAu9opvQ
	(envelope-from <netdev+bounces-287074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD851EABB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CAB83041BBA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC038398A;
	Tue, 12 May 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnGWrN1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8D383985
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582055; cv=none; b=CwipXNGl1PCVa8MudZMYvt6QE9yKCPdajA+AkBI8WrwJb9s1S6axH+2e+xHbu9Nzd+oNfCNrRaFEf0oPyqycBUb0F9a9Pga2EXglrz5287ghObfM21ZFkdBH5JSHZwmVGRndtSC2i/OCjB+OzXjbfIak+DzcxJNeHy0K2w7kR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582055; c=relaxed/simple;
	bh=i9Asqei4efexr6K9Dxu3hIacS9ENwy3ZmHOz6cviPfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOk7zesIfsL5Wg2KxiQvdnwL/liC7xYvlf/jCCIzRKBvEiLpm9Z4t9NsUHc1oi6iSt3Dxj/uHf2hWadc8AZoxnEznWgrHTafwdMYV2HM4Zs6ULyJlCEKR6kgb1XiXwzMcMwMHwXpKIYGGlDxaWI13oFy7OTGGBY3LLZNTBuD8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnGWrN1j; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so9039179a12.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778582050; x=1779186850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6uyOtwIR++/MDHnkbSW1HQI60jV8V86JJaTfeYsrdo=;
        b=AnGWrN1jXZg0UEySfShr8HemUBgV3rp/MdYlxkj6aEJ5qycfDWIx2nFUgFp88klBOk
         sJ9IZf55BU2W7q7eH7VqgX8caPSlzBGGZiZ+QTI9GWnbjR5adMY/SF0nJPrRdNihq8bZ
         KuYbwLc5MWno3nHXZWRgo4Wq9BMmtUsdR6B89bBrZX+usqAmIm9We+8bbzjEq6YO9avC
         gR05deYxQCoXrvctx9AK19PCTBpmVBmNRm+dQaRIkxPwmIDOeP5G5PUqH0cG/aGGn4xX
         TJT/KcrrpBUXecP8wgz3MbaQfpOANao70movkvj6CUSUmcGhW2li0QY3IVoMgFZM9i3I
         PI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778582050; x=1779186850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6uyOtwIR++/MDHnkbSW1HQI60jV8V86JJaTfeYsrdo=;
        b=PTk7w8LfV3idDuDshlieXGrk7ITO9PdTqIkeredSJ9IHBIRpb09WsDgseGCRe+m5Xb
         Ks6sqj5gQazoGsTxXQJ8C129XAPRx/10SGENX4JGI6ROEod7fiQ/Oxfz/5ne0xqjwDaq
         K2lvMnTGl46oHE7qWBGQKCQ/wV8fC8gEw7jLIW/rblGo86KMAuUc/4vScpWiema0iqv7
         sHrcO7vjqS4u7rNrMoJB50gaoTxZFwjsf1Y5NNXWTWT6FJPT45teLy5TjdofIZw5zf8Q
         D/pt6jJYDSB93X0pbXx/0DG44UG9D9MMCjoPLTBUh1xVTZ/en884RriR7CTOHI7F8ZOV
         ZIHg==
X-Forwarded-Encrypted: i=1; AFNElJ/Pu8qgCmaqddfDEw/UGgdMJwVRi9mpNg/xMynUzfVPy9LRMbXgEAAOy9toEQqpXzfBAUl2r0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNn9bAdHEPIJvWCERgI28Y/ModiCUgxNfFeYoQKZEK5FlT6Zi1
	8TL+BVAruBXfGNuE4kZvjt5VNtElFNwKcXN3I9PRVWciWx+EBybPT1KQ
X-Gm-Gg: Acq92OETb0AK+gEBpIOFVx13SiCzetQTsdL4/WBJ0RLLobWrCjXq2zo4fdF89mFhiI1
	BsnaCz2JGvAUuXgXGuHMvVUtVHFsKwCr/JzxAOpYc0zz2uhgYuSUJL0uuHmnh+us7uKv5XXkC5v
	qE4FoU+dX8rSYG7ZfmLYqYBMQ8CGHsuuAY8/cI566aTogVtR6dc0Tf3fy78tYxKhXiDP+m45DUH
	qGIW2bCqa0qQbYllbBTSI1YcEf3M5Y79u+/tgPN4K04vLOB8jI6E/PG3j4DCVhEfpqH6dE/UErm
	Wn00ogpN/qph/+MxSUXk6r0/MrFElBAD5J0hbHfkcJv8ttHTmCghK/WCWkaOe23W+5L6fVbWtv4
	Mnbg0GcayYY1BbV9ZD/sJAl7/Wkw6ORojHJd4C9uEleMz0wEENzcHakpzgD6S90K+GGbqINqlp/
	g7JO5GosGSUvIt3FgKHvvWOXSu/TmPWNG2Wopp5pwyI8RqTpeQ5kStWHJK60cDP1hqigyh4oJ+H
	x3cIDYXgXnmyhaZr1i4fDWi5iVdNUxvY43tD6YJfP8U+yipdQbrSN4=
X-Received: by 2002:a05:6402:4315:b0:66e:8ca6:e79f with SMTP id 4fb4d7f45d1cf-680cf3642bbmr1368517a12.13.1778582050230;
        Tue, 12 May 2026 03:34:10 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c044sm4629218a12.27.2026.05.12.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:34:09 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v20 nf-next 0/2] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Tue, 12 May 2026 12:33:45 +0200
Message-ID: <20260512103347.102746-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4DD851EABB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-287074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack.

Changes in v20:

- Moved skb_pull/push for icmpv4/6 checksum calculation correction to
   underlying functions, as these underlying functions are also called
   directly. Adjusted commit title and message accordingly.
- Altered nf_ct_bridge_pre_inner() so it can also be used when doing
   re-fragmentation.
- Added ip-fragmented packet handling for double vlan, pppoe and
   pppoe-in-q.
- Renamed nf_ct_bridge_pre_inner() to nf_ct_bridge_inner(), as it is also
   used in nf_ct_bridge_post().
- Dropped "netfilter: nft_chain_filter: Add bridge double vlan and pppoe".
- Dropped "netfilter: nft_set_pktinfo_ipv4/6_validate".
  (They are replaced by other patches using meta).
- Dropped "Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr"
  (It is applied separately)

Changes in v19:

- Add net: pppoe: avoid zero-length arrays in struct pppoe_hdr.
   (It was part of other patch-set of mine, moved to this patch-set)

Changes in v18:

- Rebased
- nf_conntrack_bridge: added #include <linux/ppp_defs.h>
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

Eric Woudstra (2):
  netfilter: utils: nf_ip(6)_checksum(_partial) correct
    data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe

 include/linux/netfilter_bridge.h           |   6 +
 net/bridge/netfilter/nf_conntrack_bridge.c | 203 ++++++++++++++++++---
 net/netfilter/utils.c                      |  52 +++++-
 3 files changed, 228 insertions(+), 33 deletions(-)

-- 
2.53.0


