Return-Path: <netdev+bounces-257169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FxtDXyehGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C7F3750
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4D230523E7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DF22A4D6;
	Thu,  5 Feb 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="qHAutUmG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ou1nfzER"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F31FE44A
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298780; cv=none; b=bgTER8ruSTjUJF0ubxdDPahlB8xSjgLJ8+hFyl2EIkI/hdDM9A01vNlyohfTy2PpaIsBgrkp2pYXNDgkjEcPYu7rs2os9VDhpVNFlNXF9wXny5wOTchyeA1NG0o12pXIkMpPzsdnv0vI/nWqtkThlN7n5qRJXKpgvpi5e/Cs4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298780; c=relaxed/simple;
	bh=lkCxBl3M6NUt1fSvyWm8Frnzn5OVaKvU3BJBvhtKzVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9yznq/8Rt2WP0fh8XctnzfgN15/pNob/AdVcgC42//Klt3j9WNaTs/pyp0ppxJouaf9L4TMdk1SXTK7NgWJnnd3NIeyj6ZxCv3MmgXW0PxC8+Q5wiojYpCh2z9/dfaKQsEdBrDFtKaB9+e/SlRQOSrquGi4vKG6ZDjSzTaW82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=qHAutUmG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ou1nfzER; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D8FD7A00D4;
	Thu,  5 Feb 2026 08:39:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 08:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1770298777; x=1770385177; bh=iIjgWXki2cLYVJdnUnIcQ
	29iqEfAL//ZgeX1spEdvKA=; b=qHAutUmGtoBaJFmWn+ssDvUGzgVcjQT2xWf2v
	ZL1Hkh4cTMxGeE291s6wH7anzUCJJpyVMlW9SiFcvxBFi1FT73w6zTbg9L8IhFYz
	+4xW1Y4UPGz0hds5DgyjjraR0ZLJwphglNEDguiqUbFb7bbiI+To9/ElVxEHwIcF
	auxU5IBeS+A5tGIViCztNuiJ5ziAVNTzHLoCjBrC1bekfkJHCb5mdEMsDGiGhGh2
	FLWjsudbghpHnLIuWMlFLNeeBQEUgSA/WPEwMYLByrN+wFKbd3zvePQpBts9tqSI
	KS4ffAQ+jOBz82NYVJ3vPBF/BYuDJYIyfKTd1SNpdYNQez5SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770298777; x=1770385177; bh=iIjgWXki2cLYVJdnUnIcQ29iqEfAL//ZgeX
	1spEdvKA=; b=ou1nfzERgXJRZCmcIE4E4bSU0NgIf6mXhPx6mocsSewn2w96IAV
	CCjKOST/2adeBYiBpiR2bAlSilh9VvGlJF5V0bEyZgXgMvtwEmHRCwYhMRKD+4Tu
	n0+Hs5elnoElFwVuLvv6TX7azHTWT4yV2CaBG29/Cc9V4pgwaHohM0WlRrUXgf7z
	N74dFCOyzYoijR+uPiHIzxGIimd10YfAYPAc7fKVeo5qmRbLMwJW9OZTW2iYzGL5
	Q98Z5yQtkrJSEWaQa7qVrKaVQ1tiJp1yYjHeWjEMbLbIcRoNeuPikCp7mswVSpfN
	JuIBH7RU4CglwKUz6w8wojCrOiOF4R9yYbg==
X-ME-Sender: <xms:mJ2EaRfoP-JvMkjHw9xSkuIP5hY_-KmayMpcz6cklZZOfh-rlPkbZA>
    <xme:mJ2EaVn6WPnGu-1NBGUmuoDMnmn3XBLkU_PPOhYKGFqHeRbdQRdT5y-RBDYQynoYF
    aSXvYjrnJAj1h9RPXAzY_sgrs7R6CspvEJgZOexxfQXW2j5YIikmRA>
X-ME-Received: <xmr:mJ2EaWyvypDJbPOKmJRcaoW3U6VJZpYGCXZuUhIO7-IukzDVuWZIWpasJp8rFFWdMIDFmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlihgtvgcuofhi
    khhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhimh
    eqnecuggftrfgrthhtvghrnhepieeluefhleekiedvueeftedvheefvedujeelgffftdef
    veeijefhhfetleelkefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtth
    hopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlsehiohhg
    vggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilh
    drtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:mJ2EaYxY5YQb1IZaxe_3JskZAJGtekZi_QhZW09e0BFH6VJq0QljNQ>
    <xmx:mJ2EaWWGLkXop9pQZf30PmjihxZteHZdb8gYU7n8juUce5-TzxUQOQ>
    <xmx:mJ2EafRCVMoKdklUx_DDg1wq7ZmY2eZEj1VpAdqmT23KFkdbpB8Jbg>
    <xmx:mJ2EaeSc5aToJYSXjwPV_za-4NxLUcd7fJSAZuuH93zsR4Etnm0MxQ>
    <xmx:mZ2EaQrRYyHb1EWj1-fCa2KRLgzpDEt8GsIwHX_0sminjphOu2L9Gn1v>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 08:39:36 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 00/12] BIG TCP without HBH in IPv6
Date: Thu,  5 Feb 2026 15:39:13 +0200
Message-ID: <20260205133925.526371-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-257169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:mid,fastmail.im:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,isovalent.com:email]
X-Rspamd-Queue-Id: 894C7F3750
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

Resubmitting after the grace period.

This series is part 1 of "BIG TCP for UDP tunnels". Due to the number of
patches, I'm splitting it into two logical parts:

* Remove hop-by-hop header for BIG TCP IPv6 to align with BIG TCP IPv4.
* Fix up things that prevent BIG TCP from working with UDP tunnels.

The current BIG TCP IPv6 code inserts a hop-by-hop extension header with
32-bit length of the packet. When the packet is encapsulated, and either
the outer or the inner protocol is IPv6, or both are IPv6, there will be
1 or 2 HBH headers that need to be dealt with. The issues that arise:

1. The drivers don't strip it, and they'd all need to know the structure
of each tunnel protocol in order to strip it correctly, also taking into
account all combinations of IPv4/IPv6 inner/outer protocols.

2. Even if (1) is implemented, it would be an additional performance
penalty per aggregated packet.

3. The skb_gso_validate_network_len check is skipped in
ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
would make sense to do the actual validation, just taking into account
the length of the HBH header. When the support for tunnels is added, it
becomes trickier, because there may be one or two HBH headers, depending
on whether it's IPv6 in IPv6 or not.

At the same time, having an HBH header to store the 32-bit length is not
strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
just restores the length from skb->len. The same thing can be done for
BIG TCP IPv6. Removing HBH from BIG TCP would allow to simplify the
implementation significantly, and align it with BIG TCP IPv4, which has
been a long-standing goal.

v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/

v2: https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/

v2 changes:

Split the series into two parts. Address the review comments in part 2
(details follow with part 2).

v3: https://lore.kernel.org/netdev/20260202192338.2373930-1-alice.projects@fastmail.im/

v3 changes:

No code changes. Added Paolo's ACK. Tcpdump patches have been merged and
unblocked the series:

https://github.com/the-tcpdump-group/tcpdump/pull/1329

v4 changes:

Added one more patch for bng_en, because it started using
ipv6_hopopt_jumbo_remove in the meanwhile. Added Eric's Reviewed-by.

v4: https://lore.kernel.org/netdev/20260203085942.2477583-1-alice.projects@fastmail.im/

v5 changes:

Rebased to solve minor conflicts.

Alice Mikityanska (12):
  net/ipv6: Introduce payload_len helpers
  net/ipv6: Drop HBH for BIG TCP on TX side
  net/ipv6: Drop HBH for BIG TCP on RX side
  net/ipv6: Remove jumbo_remove step from TX path
  net/mlx5e: Remove jumbo_remove step from TX path
  net/mlx4: Remove jumbo_remove step from TX path
  ice: Remove jumbo_remove step from TX path
  bnxt_en: Remove jumbo_remove step from TX path
  gve: Remove jumbo_remove step from TX path
  net: mana: Remove jumbo_remove step from TX path
  bng_en: Remove jumbo_remove step from TX path
  net/ipv6: Remove HBH helpers

 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  3 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 -----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  3 -
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    | 42 ++--------
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++---------------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  3 -
 include/linux/ipv6.h                          | 21 ++++-
 include/net/ipv6.h                            | 79 -------------------
 include/net/netfilter/nf_tables_ipv6.h        |  4 +-
 net/bridge/br_netfilter_ipv6.c                |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c    |  4 +-
 net/core/dev.c                                |  6 +-
 net/core/gro.c                                |  2 -
 net/ipv6/ip6_input.c                          |  2 +-
 net/ipv6/ip6_offload.c                        | 36 +--------
 net/ipv6/ip6_output.c                         | 20 +----
 net/ipv6/output_core.c                        |  7 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  2 +-
 net/netfilter/nf_conntrack_ovs.c              |  2 +-
 net/netfilter/nf_log_syslog.c                 |  2 +-
 net/sched/sch_cake.c                          |  2 +-
 22 files changed, 59 insertions(+), 282 deletions(-)

-- 
2.52.0


