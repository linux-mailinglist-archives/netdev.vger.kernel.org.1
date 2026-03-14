Return-Path: <netdev+bounces-267801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJW/GS6gtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1A728E363
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E134300CA3B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BED2EC0A7;
	Sat, 14 Mar 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="agbRoAS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11E12D1F1
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510695; cv=none; b=d0gFzJDjY8piGJjJAgChUw5O5ivt62nqWsM4IUADyIy/Hbn0+b3/HC+xPQzao34rOu+/rGseXWsecYJwTU8wa73hAR8XcsX/bo3SdWOsCQhbpzNfjJC8oTWkTei2yGPGpnUdaRt++mxYZapt8Opa/qzKKBD162dmm6d0Qkzy22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510695; c=relaxed/simple;
	bh=h+k3gSlK3QIwufVp7J5MZXEYjxf8AFUljSDR9EzJu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi0g5CPRqdk0AI+sRSvxfZngEv7c+R+enZjdWqwKu88YTJvubVpu3tWjgY87ZNNydn67a+WJeSSeeOR6e9V8KzSAH97Y0VevctNcaj472wPNdBt8RUwQyTCYGVG6qt3dnzfVVJh6snBbAhsx6qRBxcz+EBazseW/KA2VzBSokGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=agbRoAS3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12732165d1eso4222356c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510693; x=1774115493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOY8W4NU42YGMZZ3hgYiSoDx6SVCv6AisEFzcoMnwFE=;
        b=agbRoAS3aoWMI5GrpsDi3NXXxiIBVU31S4/mZZfDcXiM3gW16IXBrM9T5YmEDG5i+W
         cq+QApNWr56ICMO49CQi2RJyd+HeLBuFys7Ndam6d3HAiD7uwBLFb9Y2YA45XFadOA3U
         cBQYOXUMLMgSolP6E6fLedQmjIJsI2CyyCEvuv3ti+TJShHL/yNV/M5pMq2PuHuFSh3/
         gQk+nUabWJaBLcUdE3m2oTyS0aN7mY41B8+GqTeZIPp8V9MheVhxy2WQVkgyhuo7oae4
         2S51zLY/IPi7RNB4jaFoWlerDJOQsV53sqRxthNK+7b77sbGVYo+RB14zw1X6VqL6Lpx
         YFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510693; x=1774115493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOY8W4NU42YGMZZ3hgYiSoDx6SVCv6AisEFzcoMnwFE=;
        b=CeSGJTuhTEStxpMBeXXUBbIdDyYqwoceRFZ68TgrjRXiSYtaxaukoxq1MOakToTurD
         w+Ptng9nzzrvy3IlK/LtxIBMT/fCl6aMEoa8gNHlj7CeMvpLZllq4tJi++rkRT7BpvC+
         A8GsIgILf71w1TwNpGweLTxN6AiRl0LLt70e31V2nhGY+LzKBFchVXuI4UT5u76C3ji8
         Va+13gubtXORwY4fVEuNqcVAOV5SLhnCOt9hLlXc7nP9ynSiUZDAYSTC8bUddjRS+P3u
         4wMf+pye7jl/6Lw8sTgL0LqYG6mMG4Ht3JbNmFTMV/NXvpc/OFZNHmEhBnR9OoWza2Ei
         LJrA==
X-Forwarded-Encrypted: i=1; AJvYcCWdqSTkl42Jmf/AeK6pyXROi1PxJffibHNIjJp27ek2SGI+egOlZoaEs1os3VIbrWeudxcURUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+wJu7P1EiYMmsjX2YWVVligfsQXVQwky/7pJnMk3Se9hlMU6
	pyCAEp9KsphtqlPD6JvcABEAvlnTVKJW6fZhNSRMLbOOvmlYBjeY+SrU2bjtxdoOBw==
X-Gm-Gg: ATEYQzywCHO8zB6f3VnGqsTcPxLctXOdAjYWwE1W0/KiCRAsSVw2ugex2QYMOrNxjV4
	ewroAtyNTp9qEgJQTazMoGBojzXk4ZDj4EXEcZoBdNjvsY6sU6jZxvoHh1HQZld4CuYMrhSuAWs
	PACW55lTIlWSFi8cxhAx3D2vPfexiBQ3T+Ew9njQVusX2FbAtl4oagd34W/YUIGzJK/9UDTDriu
	jmc7Kpg9DWx3ne0dP9DJBED+yp7bH+vS1VRaH0NeG3KTw1ihFhogpPxvek2IsfMGfTKOcEpqSb2
	JklimlEPYBl5VdwhRO/F3FiubMgfVxg+/r3z0/Oa4HUch3Ze9M2TdCWnJ+A0+LuLZmMZZb3ikYA
	pp3dM23RB1txgc0h/olo+pDUbKuZGKF11yOfG6Dn7MYGG0GJEUdtDgn59osjFUPLLelVpCjSns4
	Nz2/hVgASJtQ+EtsuIxDGU8IItiazH4KZtnSx6rHZp8SjoYtsj5TtNC6eu1oTOfZTwKIHXhw==
X-Received: by 2002:a05:7022:486:b0:119:e56b:98be with SMTP id a92af1059eb24-128f3df7531mr3412739c88.37.1773510693244;
        Sat, 14 Mar 2026 10:51:33 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:32 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v9 00/10] ipv6: Address ext hdr DoS vulnerabilities
Date: Sat, 14 Mar 2026 10:51:14 -0700
Message-ID: <20260314175124.47010-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267801-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[eh_limits.sh:url,ietf.org:url,herbertland.com:dkim,herbertland.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ext_hdr.py:url,proto_nums.py:url]
X-Rspamd-Queue-Id: BD1A728E363
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
v9: Fix subject prefix

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


