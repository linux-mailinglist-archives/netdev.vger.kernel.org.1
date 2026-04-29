Return-Path: <netdev+bounces-282318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPogJOPN8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C1491CE6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF57A30AFCAB
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B003BED24;
	Wed, 29 Apr 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="A3elTUNt"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23E3BE162
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454205; cv=none; b=KddnaLwHPyEpBnDPnJfrS4secH/vmBlWyeqxVtMur+rjn/1wBc1qgFGMgoDdS5wetaMwB7Qt8DKcZKpUqbuN1Z5J+hgp7Zhmh1fRg6CayZ4VgiHvlZ3dqeTt1pvpBbdG3DP9gwy83fHMXkmkYCy9Lq4Uq0d7FoXFGjZe3CNUByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454205; c=relaxed/simple;
	bh=zg/Pz/BFqrf72DZoag/0MP2PduVAz8/HE3aKT5CpnvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA9z/jyCoxSNNv2COvwrg2mFmdVKMpQAt+zrNx60Zp6k9p+olYSgBRC4DJjPGrSxGfXehlEmflacvttj7n5yDdiTJUn1SBvgS2z1Qnrr9JBFeotANBOJXDzPtqipBk9BrCMjqS4sl2SD++nn9W2LEF4RNUsYxf1ZTJIT8mm/fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=A3elTUNt; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63T9GYcI043681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Apr 2026 18:16:34 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=4BTnd8GaWFqwK6bklZlSRXajgKdYiTs6LR3SRu4Lx3k=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777454195; v=1;
        b=A3elTUNtVD7FP++cQeuEuPv9KFt2PyeIIKrYzZ3C0coqe2wEDJfM0fXyWXH8eqtP
         0GGlEnFAfnw64bFgwrmsYlTuqM0o2Rg6Gdu673g4s5tJezNt3KLA5wg0ahkeFlDJ
         lcGNP65/SrCRfy6oZIt0H4QPoAm2TcsHSyMhineVZ0TDHMy751daAQ480clutTPJ
         3aNLqMqVqwkZwPSFjI+xiaTGVNTg59dE5/ihoEEMMI6XPcb5UdVRqh+YUGyvPKjg
         eect2DPyvBntv6ji0toYIkeBjIUaZ60rtYEav/Fi13OcAQk4VKLXJdvHi1L6CsVe
         E+C4meT68Rru1flOa1iTPw==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1 0/3] af_packet/tcp: fix late hardware timestamp handling
Date: Wed, 29 Apr 2026 09:16:16 +0000
Message-ID: <20260429091632.26509-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 065C1491CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282318-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:mid]

Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
skb_shared_hwtstamps may carry netdev_data instead of a resolved
hwtstamp. AF_PACKET and TCP could still read that storage as a ktime_t
and report bogus hardware timestamps to userspace.

This series factors the late timestamp resolution logic into a common
helper, then switches AF_PACKET and TCP to use it.

Notes on SOF_TIMESTAMPING_BIND_PHC:
The generic socket receive timestamping path honors it, but the
AF_PACKET and TCP receive paths touched here haven't implemented that
behavior.
This series doesn't change that; those paths always resolve timestamps
with cycles == false and preserve their timestamp-domain semantics.

Kohei Enju (3):
  net: introduce helper to resolve hardware timestamps from skb
  af_packet: use skb_get_hwtstamp() for hardware timestamps
  tcp: use skb_get_hwtstamp() for hardware timestamps

 include/linux/skbuff.h | 11 +++++++++++
 include/net/tcp.h      |  2 +-
 net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_ipv4.c    |  6 ++++--
 net/ipv6/tcp_ipv6.c    |  3 ++-
 net/packet/af_packet.c |  2 +-
 net/socket.c           | 27 +++------------------------
 8 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.53.0


