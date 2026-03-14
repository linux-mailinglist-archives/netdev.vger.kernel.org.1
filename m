Return-Path: <netdev+bounces-267785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMCFFVyetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:43:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77B28E2B8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8335300C017
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23354211A05;
	Sat, 14 Mar 2026 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ByootprF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCA1B4223
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510232; cv=none; b=t40raNzMM+2CDnm9PhHZFbUPK0hrTGSdIe2cakY9Z9pGezmHp+xDaqWHuc+EIM129T1B37VBTF9Ch2p4Qr5j4QVwRxKi+PUmcoT7fqEpqJjLxmfo8j096jhh0W/zrDzZXPDQRL6JdodqNnCTGnq7fvG2rlDUJaIbKHuWfmxamVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510232; c=relaxed/simple;
	bh=Wcy6ze1HGPsfKhByVxPy+eLc3X0DUfSW/DkOqPoIU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rce99rmArzPVGPClX6L3Vd9GfePMFqFkB6VOcg87pljBA4bVLi+4uqlped6H/Pc5RReN5nmw60El4HLeiy4y/ZRUQanMQXNQOy6C4J8sJ4zZgt6pfXOXtNqHRdaN+gpFt5KHVz+U7R22hXZ4Ro6RAMGc/sUILfr7jXzY3x8tRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ByootprF; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12732e6a123so1777311c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510230; x=1774115030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kDQKCL09AdCuTW+404nqjdhz5IvcXKxBUkw8texaA4=;
        b=ByootprFmUpJjTgbbWI4Yu/lFqj9mfxGKLKe4rz2O7CSn1eX4wYMwSZixI3RMo0jYO
         jriIKaY3bj5xwa+vSgG8GHiGpLNTkOWFaFleMQWuZv2VmP2Rwt8al2Pkw4Dj6T6B6Hat
         BSnc3pvEzrvRCrKTNxuOyg2o1Z6YX5R0FjTkGPfQ8L5zOktG3lzcBjI4TKlLbr66gQqP
         y6fsKWqpl/ywU7GCeZLhU91ZZMHauD9hLE3FCPTKkLNGWNynHdqfxgkmdo1YS/b3ZKIr
         pjXo6jdzaA83gL3CD8evpF+eEVa3+4RYBUPBbvAmQSh0tes7vo0LjJWZZC6U2IuHtP7B
         2Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510230; x=1774115030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kDQKCL09AdCuTW+404nqjdhz5IvcXKxBUkw8texaA4=;
        b=S2InDzejrkYYCn7uvKa7axAeXlxTifGwUukMGmPcfePtqzP7i7kqBVcq8qXIpnsitW
         8YP1XGOHYiMOaINkZH6poPMjTb6x9LNgZTeEbUT7q8LHtRbuHDv4GisAzzkHJEmb4ZoN
         DhuzuGu1pXFkqPKOlxEhzwOX/EzG+MGpCbBGMICcDri7yYMKxGE62Kk/U5AS9eaJBA3u
         KcavinuhIKK8MyIVJm/3GHFaYt6Fq2eceeWM3tqWOZik1m6xziliXU/nZ8sskqIMGJZM
         fmQxKtaqaPwnNs7eXVFRFGsJD/QDdQfOpZiqGxiVuRAf7Lq8H9gN4QyEkCev5oPVJln1
         IRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJ08XsK9ShZch29RtunWbcdoIfy/Mqi+B518dNyEG9MSkXK2keIlueos0sqrT3c5uM2gqcqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeEC+07epp7ii3zhABlRRSBQBQPIB+SvNQQeGqfMj+gA9iwRg
	2jGvTUhlffKHkLokh7Q26TNyfW88iy1vt9roG+suo/FN7tazkSYxMglU4KqNSaG/Aw==
X-Gm-Gg: ATEYQzy7NoLzDronOTUlocSxlL2Ixy3apAMwnYJebVuSosVwBd2Rca8KehXM8E1Y8/8
	XTob5Uc/V+A+a+w0XPiT8f7CwFJyJ1h/jaHKHs3R32vC5dQZPkKJ0cgDoDTMyXPtOsd98nDpX0g
	Q0b0k/JNC9IRu0GTZyeCIfLT5VZXAVoSBP2mRB1Yaeymft72WJT99FHrMNyXrXordjKOQSR6h19
	FnLpnh1aobAIJkzBzqJQMaC51md3cPBOtgnjUudFgmkBjDhto+glekVJrQ0gllXSa85ir2h04Ei
	QmrBfnXt8xHvRoKxcOk0F3m5IHg4lMPV/1DxNPW55A380OVynbbE9zmUz8nhGojlOX7eCMuGuLk
	XRxN39IwI3l9UFnu39jr1oXXtGK42ygPQab4S2tN/90KhgDOsfOZfUmyRhZ5Y58Bx+YLJ1mBJEz
	K4S9LLinjxfHaOAmp+lC0x0KUimbEB3BrHID3fHxQA9JRI31OEcObNY1YA3e0FCKvcyQ3PdA==
X-Received: by 2002:a05:7022:23a9:b0:128:d24a:a5c1 with SMTP id a92af1059eb24-128f3dc5262mr3486576c88.28.1773510229518;
        Sat, 14 Mar 2026 10:43:49 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:43:48 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v8 00/10] ipv6: Address ext hdr DoS vulnerabilities
Date: Sat, 14 Mar 2026 10:43:23 -0700
Message-ID: <20260314174333.46406-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eh_limits.sh:url,ietf.org:url]
X-Rspamd-Queue-Id: CF77B28E2B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

An update to RFC8200 is being proposed in IETF to allow enforcement of
extension header ordering and number of occurrences. An I-D is in
https://www.ietf.org/archive/id/draft-iurman-6man-eh-occurrences-00.txt

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
v6: Fix a bug and create a test for extension header limits
v7: Run pylint on new Python file, run shellcheck on new bash file,
    Make fixes as needed
v8: Repost

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
  test: Add networking selftest for eh limits

 Documentation/networking/ip-sysctl.rst    |  52 ++-
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
 tools/testing/selftests/net/eh_limits.py  | 349 ++++++++++++++++++++
 tools/testing/selftests/net/eh_limits.sh  | 205 ++++++++++++
 tools/testing/selftests/net/ext_hdr.py    | 385 ++++++++++++++++++++++
 tools/testing/selftests/net/proto_nums.py | 231 +++++++++++++
 17 files changed, 1326 insertions(+), 28 deletions(-)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh
 create mode 100755 tools/testing/selftests/net/ext_hdr.py
 create mode 100644 tools/testing/selftests/net/proto_nums.py

-- 
2.43.0


