Return-Path: <netdev+bounces-195718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53458AD2125
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F313A8956
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC625A351;
	Mon,  9 Jun 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulbqLbF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28B13CF9C
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479978; cv=none; b=o4+YBs1s0tcAILX8nTFqQ0IuGs5JM0VBy9nPdhT/ZhXw7Xoku9VNeRAgjmLGIkuV1/dOZuR43qkupfVLvNs6E9slfTyNOLACmlDxfaZAeaVDj9lpAv0JD1d+w1ESN+gzT0ayj1XlUEY7nUtuu3IX/ef/6+WUszN39Sk5NMS9ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479978; c=relaxed/simple;
	bh=ru0flEcIK1WnpJ3XoPHdjbvxOY1flbUEK3H4pdNsPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XbSLk/u16ggBl3HeCUyCA+H3KTWRK30/JAcd8iP1LkS2UASMBiFgvHeKlDZK+YRnt+EZDsT8SN7O7gdjPNr2d2zcQj9ovnUX5kLw7T4ck/RQbTb3DSDt6AQvkjI1gqLUAPmp9XI60D/jMw7ur4yKbtIgpmEd1kvKmUklB2JmGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulbqLbF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144FCC4CEEB;
	Mon,  9 Jun 2025 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749479978;
	bh=ru0flEcIK1WnpJ3XoPHdjbvxOY1flbUEK3H4pdNsPpw=;
	h=From:To:Cc:Subject:Date:From;
	b=ulbqLbF44BTbQ7GIfbrhXSG/MXqORvNqBKkSNZ7imW/68NCRRksJTSxP1wVye6MdF
	 Ilwvx8BmnRpZ1qEhgEWYLZpjeRF45x9/Q02AAzIWubOAnSgZRO5Q7BO/gND270RsA8
	 V0+D1G0UmPbpA/YnGnLAq8btLohq2cl2CGEpE/hVJ1BosncrVBau1NBnbfTnz5bCwq
	 xBFjt35NR9xqKoc08aRxXY8NJ9xaVRzqjGwdCSgT8pTr7yPu1hoH2XXZUENjUe7ecp
	 rmrGmfAdfyY+rbojez8X5csqnwA/luu0+DGEWPdUykewiK88kPBz62Etr617jh6IIn
	 p/qeuhdNqAB7w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	stephen@networkplumber.org,
	hannes@stressinduktion.org,
	willemb@google.com
Subject: [PATCH net-next] uapi: in6: restore visibility of most IPv6 socket options
Date: Mon,  9 Jun 2025 07:39:33 -0700
Message-ID: <20250609143933.1654417-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A decade ago commit 6d08acd2d32e ("in6: fix conflict with glibc")
hid the definitions of IPV6 options, because GCC was complaining
about duplicates. The commit did not list the warnings seen, but
trying to recreate them now I think they are (building iproute2):

In file included from ./include/uapi/rdma/rdma_user_cm.h:39,
                 from rdma.h:16,
                 from res.h:9,
                 from res-ctx.c:7:
../include/uapi/linux/in6.h:171:9: warning: ‘IPV6_ADD_MEMBERSHIP’ redefined
  171 | #define IPV6_ADD_MEMBERSHIP     20
      |         ^~~~~~~~~~~~~~~~~~~
In file included from /usr/include/netinet/in.h:37,
                 from rdma.h:13:
/usr/include/bits/in.h:233:10: note: this is the location of the previous definition
  233 | # define IPV6_ADD_MEMBERSHIP    IPV6_JOIN_GROUP
      |          ^~~~~~~~~~~~~~~~~~~
../include/uapi/linux/in6.h:172:9: warning: ‘IPV6_DROP_MEMBERSHIP’ redefined
  172 | #define IPV6_DROP_MEMBERSHIP    21
      |         ^~~~~~~~~~~~~~~~~~~~
/usr/include/bits/in.h:234:10: note: this is the location of the previous definition
  234 | # define IPV6_DROP_MEMBERSHIP   IPV6_LEAVE_GROUP
      |          ^~~~~~~~~~~~~~~~~~~~

Compilers don't complain about redefinition if the defines
are identical, but here we have the kernel using the literal
value, and glibc using an indirection (defining to a name
of another define, with the same numerical value).

Problem is, the commit in question hid all the IPV6 socket
options, and glibc has a pretty sparse list. For instance
it lacks Flow Label related options. Willem called this out
in commit 3fb321fde22d ("selftests/net: ipv6 flowlabel"):

  /* uapi/glibc weirdness may leave this undefined */
  #ifndef IPV6_FLOWINFO
  #define IPV6_FLOWINFO 11
  #endif

More interestingly some applications (socat) use
a #ifdef IPV6_FLOWINFO to gate compilation of thier
rudimentary flow label support. (For added confusion
socat misspells it as IPV4_FLOWINFO in some places.)

Hide only the two defines we know glibc has a problem
with. If we discover more warnings we can hide more
but we should avoid covering the entire block of
defines for "IPV6 socket options".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: stephen@networkplumber.org
CC: hannes@stressinduktion.org
CC: willemb@google.com
---
 include/uapi/linux/in6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index ff8d21f9e95b..5a47339ef7d7 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -152,7 +152,6 @@ struct in6_flowlabel_req {
 /*
  *	IPV6 socket options
  */
-#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADDRFORM		1
 #define IPV6_2292PKTINFO	2
 #define IPV6_2292HOPOPTS	3
@@ -169,8 +168,10 @@ struct in6_flowlabel_req {
 #define IPV6_MULTICAST_IF	17
 #define IPV6_MULTICAST_HOPS	18
 #define IPV6_MULTICAST_LOOP	19
+#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADD_MEMBERSHIP	20
 #define IPV6_DROP_MEMBERSHIP	21
+#endif
 #define IPV6_ROUTER_ALERT	22
 #define IPV6_MTU_DISCOVER	23
 #define IPV6_MTU		24
@@ -203,7 +204,6 @@ struct in6_flowlabel_req {
 #define IPV6_IPSEC_POLICY	34
 #define IPV6_XFRM_POLICY	35
 #define IPV6_HDRINCL		36
-#endif
 
 /*
  * Multicast:
-- 
2.49.0


