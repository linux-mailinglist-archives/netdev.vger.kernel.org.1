Return-Path: <netdev+bounces-251308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A2D3B924
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48513023576
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E442F7475;
	Mon, 19 Jan 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="MjYqBpbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385E2EA47C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857152; cv=none; b=oDl/2ATvvDGd/6jxTIZ2g7d+92ZSE+nyrG3ZUX0jIXwaPOh2wh71Gd5ipwsfUXtpFoDCuGVuAIMzUBig1GDBYbC1GbkgDKUFrvHXpK533u0UADGFkCIdSYQCzeO2feJMkWIWN1wg4lHD43ioG2ND+eSD3+Nyud/BnQqXgV9YXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857152; c=relaxed/simple;
	bh=71UBcSWMWYnzWPSNMpKL0Rr0HVVU3U235AiteP7hZeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bypz+scIrQvaqIB4svLrqVIG7odJCFGzAi8prd+Fv7cLJUP2oKGRgjacN5HZjJEvVlDXHiMLZpSZgoeEZwgbEd7MX7liSwBOgAA2xEtSNX898glOR2XNR9RFOnwooVjnCDJQHlFPNhXwtRPewLnAmMh6GK+MODELn1sTBKaUecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=MjYqBpbh; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6313882eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857149; x=1769461949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EytL0NISE8MCpejRnXHppKBI5LcWsB6Mz72GQnH/Ko8=;
        b=MjYqBpbhiTMr4NyR7wGSIrD+jtv0Ncoj0af7fFcca4fzdxAqWGpUHVaqR2AyG7Hxlr
         IlwYarGNWHqvJHKoW3dVQpRxQzxUFpT6gSc3Ms5nGMD2CKXATGG5T4t/7Fes4Vt0qGNK
         CSclgeJhsWVqeVlNOECg3520O0ggMlOaDwO0SxsBU5Shl6Zc7KB6hc7MGVXOwJ+uVYIs
         Nrh9D5RUlmD8CDJ5w3zElZKv9xoYzHjBqtlP+P/t28Ndyc8PffGL9t9aT90yF3/LmLen
         w6SExdcJmdw3KiJkBcoVW8UQkFKRURshua4Hlrh8qlhK0rXg7tw0f6oQKl42Guvck3WL
         0J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857149; x=1769461949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EytL0NISE8MCpejRnXHppKBI5LcWsB6Mz72GQnH/Ko8=;
        b=UblD6HF8XV3+aBkvHMK3XwiP23V2hFG4sHFzrZKjDFRUfPagyldSYqG60Kv0pB82Y+
         KMH4t0zLYOuyHluXNZLVi6BofP+7dp5ivgb/Dwn2QWoSziD5gzyOAGVCXGrtRZUzQ8Nl
         xfVffa/AWIongNjvUF7Q+q6dGUZUghUOdlU3neZRmIAMu+ffxjK16MD1vRo7v17PF2dD
         UMlHW8mbrYr2TEO4BSYOkS/nPq3bguNsFhYoCsp17H/KIIHJpLXpRExlT5UXE/WRRKi8
         i6Zh4WXQLly1XoM9EZZexHn1C4Q3vpHKEhVFZsrbjHaAW2Y5nn75kt71YtyCEbGQqUKV
         DyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytaBbIfL+iCBuWRbJRWpVwD1TkkKxbtwHofMkH0WU3cjYvrI/0gq7QC+ZIgXBu7SYL93yIkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+rXPRb317qVDCGDWNZ1+6EkxYr7SNNKEywTk7jSHl1SWnUkP
	1g8HKohblF8JJ4FB3xIj5fdQ9OaZkpjTzVUh49Ih43RXIgkVz2M/LCnOZWEcWlfiYA==
X-Gm-Gg: AZuq6aKEyjJ/MtPzNiNuzPvLMYVJn2AyP+uLczhXCm9fK0dCJyGrBq69x3LvkCuKN8C
	zMNXfXe/sXn+kwOdqjqnIS9WjOK9TWG+eP+z5YZjbZwUMBLDdUkSBnJfy/iLt76vABjhNjvfdGf
	ipyUYuWjjjdER/jNLrO5OTxGGMW5wbqdB+eSX0heYxw0y+IHkzMM64rplE7Vr7kNrqoqOIhEBe0
	dOCkYMisFWdva55VeE8lZhTih+DlvPw6ZuE54t3V6W1v5ezjFtpx4DAiLT+a5XWzzh9nbtZ994Z
	XbKADaoA7BRBhf4XtZeBeEa2jSjitIuLKVeLRJpdqsJKcmRhOj3Arx3WE3CcSDFq+MfJwDrJXKP
	YNfzKFkrQtSpJU6diUa/qdyjCmOIa/KStttT/u2yzcAKVuHPDAhgDLxrj67nWOI8vG7Yhfx6bSj
	mRp9ojDn1s1pLqv5NxObfyFzhaKsVdeDboyd0jLYZbE4HXpyDwPNDjvQea
X-Received: by 2002:a05:7300:230d:b0:2b0:5929:4d1f with SMTP id 5a478bee46e88-2b6b40f057bmr8431221eec.33.1768857149388;
        Mon, 19 Jan 2026 13:12:29 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:12:28 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 0/7] ipv6: Address ext hdr DoS vulnerabilities
Date: Mon, 19 Jan 2026 13:12:05 -0800
Message-ID: <20260119211212.55026-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 extension headers are defined to be quite open ended with few
limits. For instance, RFC8200 requires a receiver to process any
number of extension headers in a packet in any order. This flexiblity
comes at the cost of a potential Denial of Service attack. The only
thing that might mitigate the DoS attacks is the fact that packets
with extension headers experience high drop rates on the Internet so
that a DoS attack based on extension wouldn't be very effective at
Internet scale.

This patch set addresses some of the more egregious vulnerabilities
of extension headers to DoS attack. 

- If sysctl.max_dst_opts_cnt or hbh_opts_cnt are set to 0 then that
  disallows packets with Destination Options or Hop-by-Hop Options even
  if the packet contain zero non-padding options

- Add a case for IPV6_TLV_TNL_ENCAP_LIMIT in the switch on TLV type
  in ip6_parse_tlv function. This TLV is handled in tunnel processing,
  however it needs to be detected in ip6_parse_tlv to properly account
  for it as recognized non-padding option

- Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h so that all the
  TLV definitions are in one place

- Set the default limits of non-padding Hop-by-Hop and Destination
  options to 2. This means that if a packet contains more then two
  non-padding options then it will be dropped. The previous limit
  was 8, but that was too liberal considering that the stack only
  support two Destination Options and the most Hop-by-Hop options
  likely to ever be in the same packet are IOAM and JUMBO. The limit
  can be increased via sysctl for private use and experimentation

- Enforce RFC8200 recommended ordering of Extension Headers. This
  also enforces that any Extension Header occurs at most once
  in a packet (Destination Options before the Routing Header is
  considered deprecated, so Destination Options may only appear once).
  The enforce_ext_hdr_order sysctl controls enforcement. If it's set
  to true then order is enforced, if it's set to false then neither
  order nor number of occurrences are enforced.

  The enforced ordering is:

    IPv6 header
    Hop-by-Hop Options header
    Routing header
    Fragment header
    Authentication header
    Encapsulating Security Payload header
    Destination Options header
    Upper-Layer header

Tom Herbert (7):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
  ipv6: Cleanup IPv6 TLV definitions
  ipv6: Set HBH and DestOpt limits to 2
  ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
  ipv6: Enforce Extension Header ordering
  ipv6: Document enforce_ext_hdr_order sysctl

Tom Herbert (7):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
  ipv6: Cleanup IPv6 TLV definitions
  ipv6: Set HBH and DestOpt limits to 2
  ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
  ipv6: Enforce Extension Header ordering
  ipv6: Document enforce_ext_hdr_order sysctl

 Documentation/networking/ip-sysctl.rst | 53 +++++++++++++++++++++-----
 include/net/ipv6.h                     |  9 +++--
 include/net/netns/ipv6.h               |  1 +
 include/net/protocol.h                 | 16 ++++++++
 include/uapi/linux/in6.h               | 21 ++++++----
 include/uapi/linux/ip6_tunnel.h        |  1 -
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/exthdrs.c                     | 20 ++++++++--
 net/ipv6/ip6_input.c                   | 14 +++++++
 net/ipv6/reassembly.c                  |  1 +
 net/ipv6/sysctl_net_ipv6.c             |  7 ++++
 net/ipv6/xfrm6_protocol.c              |  2 +
 12 files changed, 123 insertions(+), 23 deletions(-)

-- 
2.43.0


