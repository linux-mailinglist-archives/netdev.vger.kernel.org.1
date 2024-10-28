Return-Path: <netdev+bounces-139691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429819B3D6D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81AEB21124
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781D1EE026;
	Mon, 28 Oct 2024 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="2tkZUdAg"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC81EF0AC;
	Mon, 28 Oct 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152965; cv=none; b=G+6fjRuElQS56eUKHnmbw02/Kq75jkRH3D1/qCUuxvj+g6IPp9/VG36D4+b2NDRzSZSX+x8oPQqwybe65ndfl0yQWkMIRHzm1py2ik8dbQV8kAwT8OVC8oyx8OcoYCFMVB89CtyhM/tN7FoBVFAxtjRuVVUm4Vi5AExcbuoGkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152965; c=relaxed/simple;
	bh=ujp1/jKeDc5NDfVkWom7tc8Ol4j64Ig2kDBcViWgXNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwo8qsIUQAF1VDhZHBK89XvG5DJLQOAFiSHeOEafsSIbnY5IeWpL1fNuGhbnkh6xbhjjJeTUqhT1+VzmnxPUo743wIeDklMVdESVzWG8Kq4QYN5Kq3A+ZZCniiu59XfpkOs6NpOp2oYLDFUhuZ8Mfe+rExsY+hQvyCCzwzRKyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=2tkZUdAg; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (modemcable174.147-130-66.mc.videotron.ca [66.130.147.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 7250420167D1;
	Mon, 28 Oct 2024 23:02:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 7250420167D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1730152954;
	bh=xhgerrHTTO59y44c3Jm6bkvSuMQT6i0Ogkew4CBYgPY=;
	h=From:To:Cc:Subject:Date:From;
	b=2tkZUdAgWnqA2nOi0QIrOp4trdaaEWkL77Wdwch3Do+9HAh8hM3Pagi06gXSQDdw8
	 3BmZcf/bp8cqLR3yHbEAILnGiwswomzEGwPW8/AHvD4B9Sbk26voAgdVNR1sBTSkJW
	 nPBl8O2BOdVUNl6xI7GyTilKXejQBycGNZBy9o6vYwIUpvOWeIcZikFxVgQzY2uTtv
	 jwrCXvVVPaAOf4ppLjOylbiZ6yBHeexaYHPM0Mcoa9B36FWvm4RA98+DU8WhrqGx9Q
	 ScDCfdJPPZVhOEq+HM31DG818Dz2mDIptEUXYfgf/rcnPReQkIhGx+n03NR+DUPBc9
	 hFbQrYY1RzX4A==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 0/3] Mitigate the two-reallocations issue for iptunnels
Date: Mon, 28 Oct 2024 23:02:09 +0100
Message-Id: <20241028220212.24132-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- add missing "static" keywords in seg6_iptunnel
- use a static-inline function to return the dev overhead (as suggested
  by Olek, thanks)

The same pattern is found in ioam6, rpl6, and seg6. Basically, it first
makes sure there is enough room for inserting a new header:

(1) err = skb_cow_head(skb, len + skb->mac_len);

Then, when the insertion (encap or inline) is performed, the input and
output handlers respectively make sure there is enough room for layer 2:

(2) err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));

skb_cow_head() does nothing when there is enough room. Otherwise, it
reallocates more room, which depends on the architecture. Briefly,
skb_cow_head() calls __skb_cow() which then calls pskb_expand_head() as
follows:

pskb_expand_head(skb, ALIGN(delta, NET_SKB_PAD), 0, GFP_ATOMIC);

"delta" represents the number of bytes to be added. This value is
aligned with NET_SKB_PAD, which is defined as follows:

NET_SKB_PAD = max(32, L1_CACHE_BYTES)

... where L1_CACHE_BYTES also depends on the architecture. In our case
(x86), it is defined as follows:

L1_CACHE_BYTES = (1 << CONFIG_X86_L1_CACHE_SHIFT)

... where (again, in our case) CONFIG_X86_L1_CACHE_SHIFT equals 6
(=X86_GENERIC).

All this to say, skb_cow_head() would reallocate to the next multiple of
NET_SKB_PAD (in our case a 64-byte multiple) when there is not enough
room.

Back to the main issue with the pattern: in some cases, two
reallocations are triggered, resulting in a performance drop (i.e.,
lines (1) and (2) would both trigger an implicit reallocation). How's
that possible? Well, this is kind of bad luck as we hit an exact
NET_SKB_PAD boundary and when skb->mac_len (=14) is smaller than
LL_RESERVED_SPACE(dst->dev) (=16 in our case). For an x86 arch, it
happens in the following cases (with the default needed_headroom):

- ioam6:
 - (inline mode) pre-allocated data trace of 236 or 240 bytes
 - (encap mode) pre-allocated data trace of 196 or 200 bytes
- seg6:
 - (encap mode) for 13, 17, 21, 25, 29, 33, ...(+4)... prefixes

Let's illustrate the problem, i.e., when we fall on the exact
NET_SKB_PAD boundary. In the case of ioam6, for the above problematic
values, the total overhead is 256 bytes for both modes. Based on line
(1), skb->mac_len (=14) is added, therefore passing 270 bytes to
skb_cow_head(). At that moment, the headroom has 206 bytes available (in
our case). Since 270 > 206, skb_cow_head() performs a reallocation and
the new headroom is now 206 + 64 (NET_SKB_PAD) = 270. Which is exactly
the room we needed. After the insertion, the headroom has 0 byte
available. But, there's line (2) where 16 bytes are still needed. Which,
again, triggers another reallocation.

The same logic is applied to seg6 (although it does not happen with the
inline mode, i.e., -40 bytes). It happens with other L1 cache shifts too
(the larger the cache shift, the less often it happens). For example,
with a +32 cache shift (instead of +64), the following number of
segments would trigger two reallocations: 11, 15, 19, ... With a +128
cache shift, the following number of segments would trigger two
reallocations: 17, 25, 33, ... And so on and so forth. Note that it is
the same for both the "encap" and "l2encap" modes. For the "encap.red"
and "l2encap.red" modes, it is the same logic but with "segs+1" (e.g.,
14, 18, 22, 26, etc for a +64 cache shift). Note also that it may happen
with rpl6 (based on some calculations), although it did not in our case.

This series provides a solution to mitigate the aforementioned issue for
ioam6, seg6, and rpl6. It provides the dst_entry (in the cache) to
skb_cow_head() **before** the insertion (line (1)). As a result, the
very first iteration would still trigger two reallocations (i.e., empty
cache), while next iterations would only trigger a single reallocation.

Justin Iurman (3):
  net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
  net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
  net: ipv6: rpl_iptunnel: mitigate 2-realloc issue

 net/ipv6/ioam6_iptunnel.c |  90 ++++++++++++++++---------------
 net/ipv6/rpl_iptunnel.c   |  67 +++++++++++++----------
 net/ipv6/seg6_iptunnel.c  | 108 ++++++++++++++++++++++----------------
 3 files changed, 150 insertions(+), 115 deletions(-)

-- 
2.34.1


