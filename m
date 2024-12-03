Return-Path: <netdev+bounces-148480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C29E1CE5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A027D2822C7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4E1EE008;
	Tue,  3 Dec 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="jSOeyWJ4"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716A16BE17;
	Tue,  3 Dec 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230794; cv=none; b=BT/lF7HZCk+r6n/fC3dpQFYx5kseQvxdOhbHbQOlEaPdxMfKJgN/HFXs0jOb93uP0ik63uLs/UxNMbe75n3I2czmTVDxukaveX/TiCYUrIgGakIYru9TbRNZfL6wGQNfROPGYbBb1V1LHX59Mgq34lrpQpQewy9WKOTe/g1NxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230794; c=relaxed/simple;
	bh=i+diJin/f6M+owInzpyMhzzCOqFN5N9bv5THE6/VmwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxO/hY5oVkd4fa/Y7E95/gcTCSMwVrt0kahuzh0LyD4R78d5S5ofp7E0PFz1VZawjsZvz5I4zcln7qT+8GnZQ7+IoBXBi2pDBy++85+I7JB9tVQPk5HRu9XmBBXzCj/jmh1qdKrhyq0MlRTWn9xjOczQpbTXh3JEIzYV9sgfuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=jSOeyWJ4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C11B9200DFB8;
	Tue,  3 Dec 2024 13:49:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C11B9200DFB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1733230194;
	bh=m6S30J8S1J9kzN+p+8RyUdx8tHnIv1+plLh+2cuChWk=;
	h=From:To:Cc:Subject:Date:From;
	b=jSOeyWJ4XoT8CdsZavA2lIhHmnzkVXEEN0APy5hWcXYXbmcMr0yNCgeEPhA+O8t52
	 TW/ThoAE5XjQNt5AJ/p+ORDTqP/0w19qhWiohEQvzkfUER2pwUAU+JebG6XQ2o1oi6
	 JJtAzXLXY9EbPpXxczwapzzf8biVeTV5HF2JWuhSqBjP3Urftfm5mtkyDTRhKN2ZVR
	 Lb1fNlMlYB1XnSJsVOYNIyyd1Q2GkYsHOgG51jgc8ksotkP5oXzUKPZ5eVAEqBrKyD
	 fj8AGbCVJoplqYSec6tpYob88bZFpfd8OSENRW7QVi2QbEZApRP0omM4k1hHvKsJj9
	 slB7aZUNRse+g==
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
Subject: [RESEND PATCH net-next v5 0/4] Mitigate the two-reallocations issue for iptunnels
Date: Tue,  3 Dec 2024 13:49:41 +0100
Message-Id: <20241203124945.22508-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RESEND v5:
- v5 was sent just when net-next closed
v5:
- address Paolo's comments
- s/int dst_dev_overhead()/unsigned int dst_dev_overhead()/
v4:
- move static inline function to include/net/dst.h
v3:
- fix compilation error in seg6_iptunnel
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

Justin Iurman (4):
  include: net: add static inline dst_dev_overhead() to dst.h
  net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue
  net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
  net: ipv6: rpl_iptunnel: mitigate 2-realloc issue

 include/net/dst.h         |  9 +++++
 net/ipv6/ioam6_iptunnel.c | 73 ++++++++++++++++-----------------
 net/ipv6/rpl_iptunnel.c   | 46 +++++++++++----------
 net/ipv6/seg6_iptunnel.c  | 85 ++++++++++++++++++++++++---------------
 4 files changed, 123 insertions(+), 90 deletions(-)

-- 
2.34.1


