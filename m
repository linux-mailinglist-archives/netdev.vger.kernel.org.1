Return-Path: <netdev+bounces-256042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PbSAQxGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C669D322D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C59300A3A8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3261F4174;
	Tue,  3 Feb 2026 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="c4wKr++/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8A4C81
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079753; cv=none; b=pYSGER3jLTWStV10Sca6VT9gXRxVBP2CS2W5An0WweqmN9t+JPsfnuMe69sNsBpqQ77DhOiEizE2UwLY2Bjeq+RzDqV9cCKk4ZBej95s7kddtiGz2hpJtL+lhAZShn8brHex37S890wIHx1rFNZhtl3cOVVYjWJQurhAr7Jmn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079753; c=relaxed/simple;
	bh=wz2LMxNE8BLKyCchWzzZVYpvxEb42Or5W8gAwZT7mLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WyNGdQZD0/W0M9QDAQbzh0qnxCobXrxcWvsTbKJxElYMYeNxLaA2f0wi5Zm0X5JWYKU6PYiHgS8CTRqXI2Kd5qnnZAOESzGwESt3f0ubpkSeXoF5gMh3tRvKDJkqxExKev7HJ0k1DRSQykDooZNzCtKyFrUCZcKHKXWd1dSgv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=c4wKr++/; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b74f839bdfso219062eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079750; x=1770684550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mz/ius4W/iN71stEhjUQMRkAW3vUJU20yNS6mSnuRI0=;
        b=c4wKr++/65yHpDOKL4vNxr0J82BeJegoWOqecXazC0y4OiqKbHzNwn+sjwxhHRf7eD
         g5p5iNWrIzYGsjFJByWTfwIL+thKu9MxYckCWCnI8/at1lZvXvb+74fc5+x2JLPkwu0j
         LDcBPCMM2Rzw9+GH1UUD5JJFvVAoSEIfhq6mJrmlEGDoykpVWV8m4/8m2LiUzF1/6kAy
         w8oLa79JBP2RK2tO6/MFHz/sbfmynfJrJx87+2oKaYlyEnkNGTQO27oEdBeZzDh9NZ4T
         bipia8s4nMqJXygZQTwTV5cMcefq4bLqqQ7OwLTeGhzbIQU5PO+6LX58181ihlBKProQ
         J+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079750; x=1770684550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz/ius4W/iN71stEhjUQMRkAW3vUJU20yNS6mSnuRI0=;
        b=ih/GyXlbIdPbhPLkpbfE36Jj3HGpclbYghyxB4GC8a3oE3Os0G4YCQFAyyWoBaJymg
         ZBX8mEZkL4G9RpT08dUsARx/ptxoTTj6cmfgDplqY/wnJWIqvVeoNweHm4vskWajYj7C
         zDaoMiEz7sp20mmy9v4pOY+W7yXKTODpdIZvD4Naz4aTwFZtqv0DIKSsxRtRbni25s1W
         k4s3fX0xW5XMJyL04SxdZhuLx9IJg7TiGExCCZv0HRPfbeqiw9olC7WhhA2g8JVIhhze
         Y0MgzaVqD+wWSyc2+tLUDw59GtfVt80VHiqwROzMAiaT3swmauabSFlj1WEnGX0yyd4O
         Le2A==
X-Forwarded-Encrypted: i=1; AJvYcCXEQ17Wi+RqVWkJB4soZLVgEfw20gtQu4zPkL46xVn9VDRZw+P1SXOm8LFFQdjgreurD8Zx5eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXZT12krwKsx1YxgJ1IqN7ZZyKQhHt5AX49USbiJ3YFBhgI9a
	vz9ec6dHSixaTYERjneHZdRjtEdoXyG3kF5WFuM2lMdsjK77aDPKMCkB/BKCz1hBVg==
X-Gm-Gg: AZuq6aJ+5WIZYlu2yqf/x/DSwIIOPH0VbpbCWIFkBKNJFtcV9pdFxxp1wNKLVCBb/7I
	UWs8ieL17Qv3acNCXOONMdhIBjuCrHVCu86/1WCMRBJCYyV434b1xtjWh+D199q0O4Fx8hOwjQY
	WKtq9jlS1cPBR6MudyQ+5HYd5bcObcVx5mt1b8p3oF52bu9mZNfqy3io/54aEVmh3AEEM/my776
	G5OROP8p1Jf4G3CkCqFLDbS+AnJp4yKdiqcNLLdx0waF9craXoqRy30aGsattfViv6qN08fM/v3
	ltNspLRk9ERV6J7mdSsvcJRfNrI7RFbMkwwsl1opmkA1iabGLIBikOFAfHDfIGrA7kilE3hyLiU
	3gLCKlK+DwvvmzWVrr79grFDhLTNR8Vc+BoOu6inQu5L9Bq5Q9p8s0cE/5xA71Bf4apNv2rOPG8
	odUjoeM8+B81pOsE63pgEifq4zCu5OpdKai5Yjx4UMO9EQ3McyC4p0xNZu
X-Received: by 2002:a05:7300:5725:b0:2b7:b4f7:27de with SMTP id 5a478bee46e88-2b820e6d052mr591722eec.6.1770079750330;
        Mon, 02 Feb 2026 16:49:10 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:09 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 00/10] ipv6: Address ext hdr DoS vulnerabilities
Date: Mon,  2 Feb 2026 16:48:43 -0800
Message-ID: <20260203004853.94438-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256042-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C669D322D
X-Rspamd-Action: no action

IPv6 extension headers are defined to be quite open ended with few
limits. For instance, RFC8200 requires a receiver to process any
number of extension headers in a packet in any order. This flexibility
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
  in a packet except for Destination Options that may appear
  twice. The enforce_ext_hdr_order sysctl controls enforcement. If
  it's set to true then order is enforced, if it's set to false then
  neither order nor number of occurrences are enforced.

  The enforced ordering is:

    IPv6 header
    Hop-by-Hop Options header
    Destination Options before the Routing header
    Routing header
    Fragment header
    Authentication header
    Encapsulating Security Payload header
    Destination Options header
    Upper-Layer header

--- Background

We selected the default value of eight in RFC8504 based on an
expectation that there might be new options defined and that the
Internet would be fixed to reliably support extension headers
including those with options. I do not believe either of those are
going to happen.

Hop-by-Hop Options are ostensibly the right way to do network to host
and host to network signaling.The only HBH options that might get any
substantial deployment are Router Alert option and IOAM. The Router
Alert option is being deprecated and IOAM is at best a "nice to
have". The best use case of Hop-by-Hop options is congestion
signaling, unfortunately the die was cast when CSIG authors decided to
place the information in VLANs at L2 and cajole the information to be
routable through a switch. IMO, the miss on CSIG pretty much is the
nail in the coffin for Hop-by-Hop options to ever be widely deployed
(https://www.ietf.org/archive/id/draft-ravi-ippm-csig-01.txt).

Destination Options have proven even less useful than Hop-by-Hop
Options. The only Destination Options supported by the stack is the
Tunnel Encap Limit option and Home Address Options. The Tunnel Encap
Option was buried in the v6 tunnel code which is why it wasn't obvious
it was supported in the first version of the patch set.  I'll assume
that might be useful, so this patch set cleans up the code for it. I
don't believe there's any use of Home Address Option.

A major problem with DestOpts, HBH, Routing Header, and Fragment
header is that they have no inherent security. Their use presents a
security risk especially when sent over untrusted networks including
the Internet. Given that and that the high drop rates of extension
headers on the Internet, I am proposing that Extension header except
for ESP being deprecated on the Internet
(https://www.ietf.org/archive/id/draft-herbert-deprecate-eh-01.txt).

--- Testing

Add selftest eh_limits.sh. Tested by running:

$ sudo ./eh_limits.sh
    TEST: EH-limits - default sysctls                            [ OK ]
    TEST: EH-limits - modified sysctls                           [ OK ]

Tests passed:   2
Tests failed:   0

$ sudo ./eh_limits.sh -v
>>>>> Default
TEST: Two non-padding options in HBH and DestOpts: Received as expected
TEST: Big destination option: Received as expected
TEST: Almost Big HBH option: Received as expected
TEST: Big HBH option: Received as expected
TEST: Too much HBH padding: Didn't receive as expected
TEST: Too much DestOpt padding: Didn't receive as expected
TEST: Too much DestOpt padding #2: Didn't receive as expected
TEST: Too much DestOpt padding #3: Didn't receive as expected
TEST: Almost too much DestOpt padding #2: Received as expected
TEST: Two Dest Ops: Didn't receive as expected
TEST: OOO Routing header: Didn't receive as expected
TEST: Two Routing headers: Didn't receive as expected
TEST: Two Destination options okay: Received as expected
TEST: Two Destination options: Didn't receive as expected
TEST: Two Destination options after RH: Didn't receive as expected
TEST: Many EH OOO: Didn't receive as expected
TEST: Two fragment Headers: Didn't receive as expected

    TEST: EH-limits - default sysctls                            [ OK ]
>>>>> No order enforce, 8 options, 66 length limit
TEST: Two non-padding options in HBH and DestOpts: Received as expected
TEST: Big destination option: Didn't receive as expected
TEST: Almost Big HBH option: Received as expected
TEST: Big HBH option: Didn't receive as expected
TEST: Too much HBH padding: Didn't receive as expected
TEST: Too much DestOpt padding: Didn't receive as expected
TEST: Too much DestOpt padding #2: Didn't receive as expected
TEST: Too much DestOpt padding #3: Didn't receive as expected
TEST: Almost too much DestOpt padding #2: Received as expected
TEST: Two Dest Ops: Received as expected
TEST: OOO Routing header: Received as expected
TEST: Two Routing headers: Received as expected
TEST: Two Destination options okay: Received as expected
TEST: Two Destination options: Received as expected
TEST: Two Destination options after RH: Received as expected
TEST: Many EH OOO: Received as expected
TEST: Two fragment Headers: Didn't receive as expected

    TEST: EH-limits - modified sysctls                           [ OK ]

Tests passed:   2
Tests failed:   0

V4: Switch order of patches to avoid transient build failure
V5: Allow Destination Options before the Routing header, fixes
    suggested by Justin Iurman
v6: Fix a nug and create a test for extension header limits

Tom Herbert (10):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Cleanup IPv6 TLV definitions
  ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
  ipv6: Set HBH and DestOpt limits to 2
  ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
  ipv6: Enforce Extension Header ordering
  ipv6: Document enforce_ext_hdr_order sysctl
  test: Add proto_nums.py in networking selftests
  test: Add ext_hdr.py in networking selftests
  test: Add networking sefltest for eh limits

 Documentation/networking/ip-sysctl.rst    |  56 ++-
 include/net/ipv6.h                        |   9 +-
 include/net/netns/ipv6.h                  |   1 +
 include/net/protocol.h                    |  14 +
 include/uapi/linux/in6.h                  |  21 +-
 include/uapi/linux/ip6_tunnel.h           |   1 -
 net/ipv6/af_inet6.c                       |   1 +
 net/ipv6/exthdrs.c                        |  32 +-
 net/ipv6/ip6_input.c                      |  42 +++
 net/ipv6/reassembly.c                     |   1 +
 net/ipv6/sysctl_net_ipv6.c                |   7 +
 net/ipv6/xfrm6_protocol.c                 |   2 +
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/eh_limits.py  | 352 +++++++++++++++++++
 tools/testing/selftests/net/eh_limits.sh  | 205 +++++++++++
 tools/testing/selftests/net/ext_hdr.py    | 400 ++++++++++++++++++++++
 tools/testing/selftests/net/proto_nums.py | 231 +++++++++++++
 17 files changed, 1346 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh
 create mode 100755 tools/testing/selftests/net/ext_hdr.py
 create mode 100644 tools/testing/selftests/net/proto_nums.py

-- 
2.43.0


