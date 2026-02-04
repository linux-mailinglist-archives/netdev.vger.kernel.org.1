Return-Path: <netdev+bounces-256858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLpVFtLNg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:53:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F47ED19A
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 862E130055F3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83F396D01;
	Wed,  4 Feb 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="J9EV2hon"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CF396B8B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245578; cv=none; b=WX7ljUTrh/6alqAJ7poGt9VS0K6zuQoKx6MKCmN7pA7D2QfHbwjvMHzwbUo3PvppU3SCXh6uo5JzL2h+oh5wC/al32uY0HzzDAfbaimpkfUg3DuZuzJJanD+8IFau298gB5J2XqHm4tGedmj5RuXSMMVbhiF6WUDflHmDf/QyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245578; c=relaxed/simple;
	bh=VcEVP0Z15oLHeas+38i3h1wgFPft9AISvm377H5heNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVIV5rGGnoaAgkt5i42FbFwPBeQ/C9aTrkA04GmQQQqXeVvtKl1/dX+TQl697AM+WSQThGCoXo+ufV0CBdSImUv6BuOhAXajeHvyXq2a4a+Ekjx4bgvKu8d+DL/rSAsu7oueGHIu9oVVcDVFpXQ+5d4uQ8cxjSzBi5mrYmYjsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=J9EV2hon; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b71515d8adso241406eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245577; x=1770850377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzJggY7ZR3NwUmE45jAPIaDifWFOcud1MkmizXMwXpU=;
        b=J9EV2honPd7zB4MpZA1T8uJcQExWlCWS4LfZC01v685gY+QBJh9kPmecVzv8AI+p4f
         q89+lq3fC4xOAQek35zwlHF4niFmzN8cOfk8mfaInsow2ocgtZrt0fYjt8dxqE9mqehg
         QjDqtybax9wbaIaFiqtVBZjOczOusi7tgczVs8Ck2VAULDMfAgZyQPqpQPqp9kZUpI22
         TtVXPZIrbu15Frjpzoe0PIw0eyGHzKGLUB5cFJsZ6jc8iqCRZg5HIVSY1oGvxt1I0k4/
         58w7YnmksFAKJ7/qaW07zdt8ACvtAGHo9F0zYSidmdPg11agSPN8sDyhoYsKV3WA4g0a
         PkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245577; x=1770850377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzJggY7ZR3NwUmE45jAPIaDifWFOcud1MkmizXMwXpU=;
        b=U1ea10RPfHRTJWF0IN+BEV7dYXHXroY8wIQFSrnwKPz1LGZYKTQobXx987N1ECVgPo
         SD4foFiVeBUkQ5KI2C7FFZiAiIzbrByUco7NGFFAwtfL9LmzPmKAJXnz7v/26FfqCIZm
         C4lVARznfDInYgkMr8KYy628ezUB2VBIICRsY7yr3Y2dQD2Q4WlEiN6teXn+4/49Me4p
         Z4jH1b0bJhyV7+WUTWdkViwFglot56J1ueI11FvREq59mvanBpxK2FzyRFmntgZS4ySv
         2cojnpyskXNH2CI14j2nTP/tGTxMJ9m76WcTejaSqiOg3Qtqj4+ruU4X7KSezmGGG8fu
         UxSg==
X-Forwarded-Encrypted: i=1; AJvYcCUMNNKG/ekDJFhYCaZoaNdOdRWHiF28KIkJvnFmayMAryCBULOtXBmu8FUGu/Ke/ZethNI6SbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+vOINZ9dNRgukzo+FMquC9+U7PJzRtItg4TAx0pGI08KMWqs
	lReqsGACpGsAoetFl67Cl+Mp2o2yfZM9a4tb/vr86MsMMk3oKn+RyP/T6/sHGJSefA==
X-Gm-Gg: AZuq6aLabKUILNqRZre/kQmixoRrpN3i5zEoK+zKygcPrVpvuzl61m8rKpl0gtZmms+
	jsnkihx2Jzx90Zs1cV/gLXRuYbpeEx1gTj9N+KcEVgrHyTYH4HGqw8P7L58UcT5ipp0sSn0o1Yo
	1E0dKcuPIdd6ARPpuHBgzTM4wUJFc6WXzmH5D4/NHBGFtsE9UE1akvz+XtZ7S+3Ppja0l9PGRoe
	Gxhh/+GWZ7NQjh5mq7WhYafgVEQZXBH+/dvyxHjO6cDTAW2tvwxGKYbOjeaScdZBnVZjlSsFCCe
	EUAcYrIMp+xYaCQbTMz4fNEiSZNVqcRvnJgB9Vsmgij+gLkNwEVcHcexBjvs6LdRwhux554lczc
	sBdj2AsJYYRJrlQliEzOdLHY/bF8bJTLw62px2GMdN3ZIfiUCAXJVymM2W5Gu0yTcOre0w357+i
	svlq2ahyc6lZekgWIrDhuOxcfFBJ5TEbq3F8Ute46AMx6BMjgwhxmJtSOXwYKBZvfkXHs=
X-Received: by 2002:a05:7300:d704:b0:2b0:52cc:fe69 with SMTP id 5a478bee46e88-2b8328fa9d5mr1665879eec.5.1770245577223;
        Wed, 04 Feb 2026 14:52:57 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:52:56 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v7 00/10] ipv6: Address ext hdr DoS vulnerabilities
Date: Wed,  4 Feb 2026 14:51:44 -0800
Message-ID: <20260204225154.58245-1-tom@herbertland.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256858-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,proto_nums.py:url]
X-Rspamd-Queue-Id: 49F47ED19A
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
v6: Fix a bug and create a test for extension header limits
v7: Run pylint on new Python file, run shellcheck on new bash file,
    Make fixes as needed

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

 Documentation/networking/ip-sysctl.rst    |  56 +++-
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
 17 files changed, 1328 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh
 create mode 100755 tools/testing/selftests/net/ext_hdr.py
 create mode 100644 tools/testing/selftests/net/proto_nums.py

-- 
2.43.0


