Return-Path: <netdev+bounces-237071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B942C445FC
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69CE53462C8
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8940238C36;
	Sun,  9 Nov 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6dTkOa9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51A21D5AA
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716284; cv=none; b=sk4kmhvTItIifquSpESKMRwBysZ2Gh286HOMm/GuFL3v5t/HjA21D3dUY5yZJXRCwIAJiyFr7uxSrYZpt18JGpNDyTL+ZVjDk6ZYwGg587tO9GH/jfdvpiybBgJLaqi+a21HVdh+unwdKeIF8eOAwoeuL0Knfi2tFK6rNssqGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716284; c=relaxed/simple;
	bh=/E2065CYZGXfqGZTKvMv4TkgohZjDxfQeXejzHAHj4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyugGoIaLEniaOuD9GgyJYioHurpoogn0oBuSc44gu9dUe8wedF9uVzQ+7kUo5trODF8Xfahlyj3199wVMNRyL08n9+uuqcLLxT1YBvEaYyDJ0wrw/EHybUTfKLMSwmpC5Ya/u50NN4vSMmGzoPE4Nikhy9SS+2K8vLyK5u7YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6dTkOa9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso348611266b.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716281; x=1763321081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIKKGAUxLaG+QVE3XjDCtS0yAOmsRVmTQnPpcMwaNFo=;
        b=i6dTkOa9gYlF3U9nMkC004x/rZ30yV9M3mv+6qYKUkatMfq9cbfHAXeuQFC3pJbnDq
         I2c64cZ+Nwwrm8sJv1RG6LGlPclmLc0iB0WmpwlXkSzbtS9P18+4oNJS7UVUOSaE3QGv
         Aik+ogNOsGEUq2CIbKHfaORZJYsBnThQwKid/zQdqtlxWapQfBeOAmyfS+F4uMxj1ew/
         o9OqtZ3X773yNKUonCgN+1vmBICzW0aqgkZ9Z2SwWCZQMbwBgABdkHrAVOMKk9nqaUGW
         63QLG14msXymsSCEE/gboDSEgcxomPVyKTPKdnj+0A/VS/B0p6bqrmunddtqrQQC0O3k
         miIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716281; x=1763321081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIKKGAUxLaG+QVE3XjDCtS0yAOmsRVmTQnPpcMwaNFo=;
        b=ejWlMQn1MYqgDX3oYBCZQbeBjvYmSarvZUXsBU6wYL5/RRMfWr+lcBUodVGeAIj7jQ
         Jx19kSFHjPxU7k+JUwRoJ6C37X57by0P8jt7DOG2HBEb6sqSg40rDV1uNqgdVMDUvVwp
         gtpW7LKYBDuuX0VafoyllwxlQi1wyn2ItPLa0zahAPEDRA33UAz2xZlQLvqCvV0oZ1RE
         jREr51+hvUp8/5rzHnW2ShLOlQu1pc9HwIqx1YCecJZN/QYsOVJz2mX3jFwSXS9f7fOj
         fbT6D2jfdX9K5uO7dDWZ71Ohy7KuS/ftCB5vzAlGuTDUycCnAyRiNml0YZcVPbc+a47N
         FBDw==
X-Forwarded-Encrypted: i=1; AJvYcCXh8vPmNFMlHFeLZEKpBGqBGtOdKsbAbhfuYtJwSy4PprrFKxr4W+gTdkSs8BRIq5piUKhcewI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDbcrCH/ELz2x3V6hgUfWct/IP1EmGbIwHi5+mo2WomiZhEW0
	m+A+zfJZ97oAya2ENQKZH7Qba+E3YS9wEWjfZ2zN/CYVsjCMxhCfy8bI
X-Gm-Gg: ASbGncvBbWtjG4JCndwWsNICgqR/jWxnZJrjJbweCnyLz+ogietSmJguj7BNRLXhMyd
	R04ndHZw17szBhv+ErOI/5BgOCcpnqp5gm2Hz+E7a9bZoEO6gZRokk20uRL0NLkcXGjGWQIu11I
	V771fLylT/NdI/mgOs2UdQoIP+xwe57O2BGqca2tCwEYUBQ7so+OQ3ptXbeeZeRwNe2+EIIhFAl
	FQIqYu45zqejy1wmSM1Sa7bGWdUFob1HCauFhEgyR5qjc38ijPOutzej3pYfxqIOryXXywOWJj5
	QCeEf7O9/jFHW0H7YlkIXe0DaYopqj9qi9/fCrc0VnDm62w54TBFaIwAsXGcenXH4uNUXV8jN70
	Z5MH8yOR94ZUIaIQMtLNoWNGzJ23e54sO/JADbCEixN4nKgqd9mWRJgsJEXtnOI+9QMRGQ9brmS
	7mGgmle2VsR18A3QAcjhDgwE+saLm063JIWIULfyJpUvGBCLOLIYYXqXZSlL7vnH/A/CoZZME=
X-Google-Smtp-Source: AGHT+IHcavlGRtCMXIYLReGyT/wu2uhwzR3CuuOMBLjG6pTiN0jeib0DEyX5FIv4+8BofcYcOeVwtg==
X-Received: by 2002:a17:906:d554:b0:b72:d001:7653 with SMTP id a640c23a62f3a-b72e02d62cemr545418666b.19.1762716281018;
        Sun, 09 Nov 2025 11:24:41 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:40 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
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
Subject: [PATCH v17 nf-next 0/4] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Sun,  9 Nov 2025 20:24:23 +0100
Message-ID: <20251109192427.617142-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, introduce patches for double vlan,
pppoe and pppoe-in-q tagged packets to bridge conntrack and to
bridge filter chain.

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
 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 59 ++++++++++++--
 net/netfilter/utils.c                      | 28 +++++--
 5 files changed, 176 insertions(+), 45 deletions(-)

-- 
2.50.0


