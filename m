Return-Path: <netdev+bounces-284005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLh9JOLq+Gmr3AIAu9opvQ
	(envelope-from <netdev+bounces-284005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE04C2C39
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352563017C2B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0F3E5EC1;
	Mon,  4 May 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="B3fKVbxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50C3E123A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920735; cv=none; b=fOTYZKVGPI45sFBwLPAjLFYhLeXEeCy1amQidshrYfRVbz+7etXjLvnTOKpj1TUEJdgUEpJQm11tmLYSjh8tqbxAEKdQ/XDfOAXv7tqVjRwjlirYNnT/WqfpkPsfsxeSZiCasf809B+9drsMkphFBdy7Jcjez1QYSguPwioYWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920735; c=relaxed/simple;
	bh=+xr0hkCglDAi5/1ZMaiWX3mPQThWpE4+/Fs8/vb4DjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVxPY9xKXP6FvV9GAFM0FHx7QThuQNx7eQKIw+0lE1Vni+oPSAaSPBY0GZlqTWfvUBz4bSHjioPdT/l6WB7Fs3KWzmzZvrnIHv23NPUzLkeEtLjpM11ombRrmoLGah/Uq4YhV73SPyMV2yVSEvpLGDnKa5nxnv4Uc1oVT6mIle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=B3fKVbxI; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7706832eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920733; x=1778525533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCML6SZ1a5u13rJhUm2xKc47KVpM+M3d5dcjm7BBH9w=;
        b=B3fKVbxIrJi0K0ldtWvgQz6zk8aeJUFMxsROV/gRVx4SlUgMQzGuvHD3q40l9VQsfA
         aCQuphGfs8bBFl9vIMGaTkcxS00uAzETWmqOvYvSnouxl6Nhxkym0Yh8mq4B+JQr49EB
         Q5G9DuKI+lOBkLj+3+reQz46eftbX6w82tjKRSDoZ/Hz4idq+2MC0WpeTPZMtNfgxhY7
         DPX6lEIBMfpwMK1F7JVQZGVaEAnHgJLYkVwFmzuP63YjTrpF8q5jhdQVIEqTRMUeVozS
         vJUlqqvduyMLmod4o1enFE7FZdFpkCr+AIa+gUscWMON/vJ0u7PjegkK5VqpKW+lJBLt
         A2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920733; x=1778525533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCML6SZ1a5u13rJhUm2xKc47KVpM+M3d5dcjm7BBH9w=;
        b=ds+2MsYkwasL5GIiUxpiQw1Ow9P6HJgsMVq4lxKHC65MUpuNkkQlSYvH4FW4t7OvDS
         83QXN2OYHwiSiKivMGMbXHBE00awVwrELM3haMmc/p/hfDoiUrSh9eRXHqvLo1vPdINN
         ATW+rgTvLIEAp5+RFUnB36TPVu0VsP0VjAza4EsHSWDFGCyTw/9QB3kWXGkzhO2ZJZ8+
         oOzvkKU2n+Efd1vKSrE11Su3AteDAm0iPOlnI+07jJDk9VykyvgGVFdk59iw8TTt93QC
         /5DW15KqC1ZjdzWTu42R6QqlN045rHwm7/lED26vrlDQFKrLkgkzL2TWt2hsHIIWJLxc
         bfVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YHHkce/4HwxbKV2yuK4xA3VZk7FOHOP/hw2i86qjLiqyyUyy4KujzX3pGImvdTFHN61VPBUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iNNruKLY0JJwSFW/IBwZk7YFsSMr3nRfPaC5slnd8bbZ0l8N
	C1beZ2J4+NIEI/pTX6By5AmZGPr6ynGDqB4gVWO6dMYI5ByIGh45FBY+yXxDj8iEsw==
X-Gm-Gg: AeBDieseCIi1C9YZHtkG7l8Z2jmUVpTr6BzZ7WSAOODfrAtcIdEsaMu4b86GtJyz/5k
	W7hhFacSkRa5oINciveDDpUnnviUWttg+7ssghFx9iDbRSl7X7taPpHxTn25/TfKY/4AK1+Jh3D
	ioyAkvq2w7wSuChGRgvZtcpG71TggbWn3/JE7kb68NnhGy7gI3mLzq3neTW47L4+73uRyKu77ZK
	gqYZ4Ix49vlS2xnZFJiNhQasN9y532oyoRr/acAJ7Xh1cADT2bzXL9rs508aGwp4Zbl0DbiJnQp
	BRiMthyL9ue+syErr7Ny51LvPg5mTxPwJuwsakV3rmLV1rlcmJr7b6l4XjCjM4paBgkK9nNyZUK
	PtKL2YUC5Xj3NDbOV6a/VHXM6ZSDyZeH2rDjGfrA2Ey8jdBnXbOX4ywK8sDtzPFHq0As0I6DqIV
	5CSCf00Qfqg3pP9UiN5HFYpImuLKSPB7KT1sdQ/VW9KKKsm7SsdDv9IBu35CtpwudGRDabMnme1
	5o4qWZV9DM=
X-Received: by 2002:a05:7300:478e:b0:2be:7885:31df with SMTP id 5a478bee46e88-2efb9d80a30mr4541706eec.17.1777920732795;
        Mon, 04 May 2026 11:52:12 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:12 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@xdpnet.ai>
Subject: [PATCH net-next v10 00/10] ipv6: Address ext hdr DoS vulnerabilities
Date: Mon,  4 May 2026 11:51:12 -0700
Message-ID: <20260504185122.50642-1-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5FE04C2C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284005-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,eh_limits.sh:url,xdpnet.ai:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
extension header ordering and number of occurences. An I-D is in
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
v9: Fix subject prefix
v10: Lint fixes in selftest scripts suggested by Simon Horman

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
 tools/testing/selftests/net/Makefile      |   4 +
 tools/testing/selftests/net/eh_limits.py  | 349 ++++++++++++++++++++
 tools/testing/selftests/net/eh_limits.sh  | 210 ++++++++++++
 tools/testing/selftests/net/ext_hdr.py    | 385 ++++++++++++++++++++++
 tools/testing/selftests/net/proto_nums.py | 231 +++++++++++++
 17 files changed, 1334 insertions(+), 28 deletions(-)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh
 create mode 100755 tools/testing/selftests/net/ext_hdr.py
 create mode 100644 tools/testing/selftests/net/proto_nums.py

-- 
2.43.0


