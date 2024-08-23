Return-Path: <netdev+bounces-121503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11A95D7B5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA11B230BA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB91946A0;
	Fri, 23 Aug 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HJwuBMol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8771558B7
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444169; cv=none; b=Hpt9aXnNkwLNSnE6ozklirAQ61wimEF9rgx4brz/czW9ImwKFg1L+nWaYlepMWT1Q0UfYJl8KZtPCUEVQ4wy1RNC0ETeSPe3/aVjpaEyBIuQuR7t7SJa5uNTknM+/Ulq4V2lZVJOQWwrAdSXRfWKGMy8G3x1LuQw6EHainGWbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444169; c=relaxed/simple;
	bh=Ns0KOeHMODzgyYb2Slk0P01dK/NEXX/alEQCVREHKo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jH0PCgRvdA1WlgdcXWar0WJxXBFog1dvLBQjG2b4SnY6zAbXXTrweYtMjc7ees3s0fo7BN3BC/HJfrndMPHGVHEOzFzt1WJB5JDgi6v1zDD/4eAx0ulLn4TwQsDBj0ZEY4IXvICC2bDeQnSC1YOLoDGPRDZv8fWV3zuigfPOvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HJwuBMol; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7141feed424so2182877b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444166; x=1725048966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lS2UcxYbYtjp0gLaf1bV9orlpRzhszA5KISnZ+C/4po=;
        b=HJwuBMollne+Q5WG66YXmgiWuGd1LoJOh3+6vsVGu+XMkgH+JXrCmrhOjv7OckGLjX
         BdQ3dvHB+AvKLuYtg3cmDgcfglBPPladxagrAEV3jfd9zcrvSP9xy2OTyjm0nQkC2ZaQ
         MSOknS0R9FPZPSJ6wPx0/lZ5s22mdm+qmUs/5/Jrjf993n7GGZA9uq77vZUgbyYp/Z/F
         X0HZHhfl+D1tlFX7/QWHSv38SV5cjWD1mquqgm4hiI0CaTPY/veiEcfNw2oiRsao0BjZ
         1HdNFOSMYuG3Yuot5Uaab5kmfwuduwoan3SkiGfW8Xs43obEg4TbJoDmGGtuB6B1+dRa
         Jx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444166; x=1725048966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS2UcxYbYtjp0gLaf1bV9orlpRzhszA5KISnZ+C/4po=;
        b=EuUodrHQB5U8dXfqJ4JWyn//isFwcrx9Sermk9wX9JBwf5ECDD36Zf6q6qP2ptuxBx
         8/tomFO/LZs09dnL3yop1nHXPYYgKKQdFtjfemlnnMP8ZkBvqUhPQqkIY+6DBFcWQnbR
         rhhXbfZSvTzuiyCKQaGQgrsAbU2vijP0Xoxynt9BjUQvU4YDkjBQn5vNLPplnWXBWeYV
         RUr6agTv3arbTLh/nkLx3rPawaJ3pHHZYay83H4oBgHqY/HtgfdqqCythbEFOkSbmY8O
         P/jRccoeuz0h/jDQp0CuskPjf/5Mfu9YQpF3inCUKKmH9IjQm6aJ2afQpJEFX1Fy+y6t
         dlnw==
X-Forwarded-Encrypted: i=1; AJvYcCWirfvUiOBx7ZQBQyk7pnh6AYwwNxECo6Xy61+WfADB7p0c3TCyq9rZkDTdQ31/VmAq1mQZNlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76c9TPcXFdqxMZjaaCA5mbxR7E4Yk/47KpdFZuuhfBRI5r92b
	AyCJ4sScct4c3TAe3GETAJ41vI284k2/z7QhsoEjVp75AbdeoJxp6DvzQ69Qiw==
X-Google-Smtp-Source: AGHT+IE8ExtDOXqsVniG/un7I/QmzMWoMBQ0zaSixRlXGr/hr53WjTl08TpNP6eCpX98/ytNxszg3A==
X-Received: by 2002:a05:6a00:2342:b0:706:726b:ae60 with SMTP id d2e1a72fcca58-71445d6c8aamr4540100b3a.17.1724444165841;
        Fri, 23 Aug 2024 13:16:05 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:05 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 00/13] flow_dissector: Dissect UDP encapsulation protocols
Date: Fri, 23 Aug 2024 13:15:44 -0700
Message-Id: <20240823201557.1794985-1-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in flow_dissector for dissecting into UDP
encapsulations like VXLAN. __skb_flow_dissect_udp is called for
IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
of UDP encapsulations. If the flag is set when parsing a UDP packet then
a socket lookup is performed. The offset of the base network header,
either an IPv4 or IPv6 header, is tracked and passed to
__skb_flow_dissect_udp so that it can perform the socket lookup.
If a socket is found and it's for a UDP encapsulation (encap_type is
set in the UDP socket) then a switch is performed on the encap_type
value (cases are UDP_ENCAP_* values)

Changes in the patch set:

- Unconstantify struct net argument in flowdis functions so we can call
  UDP socket lookup functions
- Dissect ETH_P_TEB in main flow dissector loop, move ETH_P_TEB check
  out of __skb_flow_dissect_gre and process it in main loop
- Add UDP_ENCAP constants for tipc, fou, gue, sctp, rxe, pfcp,
  wireguard, bareudp, vxlan, vxlan_gpe, geneve, and amt
- For the various UDP encapsulation protocols, Instead of just setting
  UDP tunnel encap type to 1, set it to the corresponding UDP_ENCAP
  constant. This allows identify the encapsulation protocol for a
  UDP socket by the encap_type
- Add function __skb_flow_dissect_udp in flow_dissector and call it for
  UDP packets. If a UDP encapsulation is present then the function
  returns either FLOW_DISSECT_RET_PROTO_AGAIN or
  FLOW_DISSECT_RET_IPPROTO_AGAIN
- Add flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS that indicates UDP
  encapsulations should be dissected
- Add __skb_flow_dissect_vxlan which is called when encap_type is
  UDP_ENCAP_VXLAN or UDP_ENCAP_VXLAN_GPE. Dissect VXLAN and return
  a next protocol and offset
- Add __skb_flow_dissect_fou which is called when encap_type is
  UDP_ENCAP_FOU. Dissect FOU and return a next protocol and offset
- Add support for ESP, L2TP, and SCTP in UDP in __skb_flow_dissect_udp.
  All we need to do is return FLOW_DISSECT_RET_IPPROTO_AGAIN and the
  corresponding IP protocol number
- Add __skb_flow_dissect_geneve which is called when encap_type is
  UDP_ENCAP_GENEVE. Dissect geneve and return a next protocol and offset
- Add __skb_flow_dissect_gue which is called when encap_type is
  UDP_ENCAP_GUE. Dissect gue and return a next protocol and offset
- Add __skb_flow_dissect_gtp which is called when encap_type is
  UDP_ENCAP_GTP. Dissect gtp and return a next protocol and offset

Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
IPv4 and IPv6 cases. This includes testing ETH_P_TEB case

v2:
- Add #if IS_ENABLED(CONFIG_IPV6) around IPv6 cases when dissecting UDP.
  Also, c all ipv6_bpf_stub->udp6_lib_lookup instead of udp6_lib_lookup
  directly since udp6_lib_lookup in the IPv6 module
- Drop patch to unconstantify struct net argument in flowdis functions,
  edumazet added const to ne argument in UDP socket lookup functions
- As support in flowdis ipproto switch for no-next-hdr. Just exit
  flowdis on good result when this is seen
- Merge patches that move TEB processing out of GRE and moved into
  main protocol switch
- Rename bpoff in UDP flow dissector functions to be base_nhoff for
  clarity
- Parse GTPv1 extension headers (part of this is moving
  gtp_parse_exthdrs to a header file
- Exit flowdis on good result if NPDU or SEQ GTPv1 flags are set

v3:
- Add udp6_lib_lookup to ipv6_stubs
- Call ipv6_stubs->udp6_lib_lookup instead of ipv6_bpf_stubs variant
- Use _HF_ variants of VLXAN flags (those in nbo)
- Use encap type from socket to determine if a packet is VXLAN-GPE instead
  of getting this from flags
- Protect both IPv4 and IPv6 cases with #ifdef CONFIG_INET
- Added a comment why UDP_ENCAP constants are in uapi
- Added a comment in ETH_P_TEB case why NET_IP_ALIGN is needed
- Add a check in __skb_flow_dissect_udp that the netns for the
  skb device is the same as the caller's netns, and also only
  dissect UDP is we haven't yet encountered any encapsulation.
  The goal is to ensure that the socket lookup is being done in the
  right netns. Encapsulations may push packets into different name
  spaces, so this scheme is restricting UDP dieesction to cases where
  there are not name spaces or at least the original name space.
  This should capture the majority of use cases for UDP encaps,
  if we do encounter a UDP encapsulation within a different namespace
  then the only effect is we don't attempt UDP dissection

v4:
- Fix undefined variables when CONFIG_INET is no set

Tom Herbert (13):
  ipv6: Add udp6_lib_lookup to IPv6 stubs
  flow_dissector: Parse ETH_P_TEB and move out of GRE
  udp_encaps: Add new UDP_ENCAP constants
  udp_encaps: Set proper UDP_ENCAP types in tunnel setup
  flow_dissector: UDP encap infrastructure
  flow_dissector: Parse vxlan in UDP
  flow_dissector: Parse foo-over-udp (FOU)
  flow_dissector: Parse ESP, L2TP, and SCTP in UDP
  flow_dissector: Parse Geneve in UDP
  flow_dissector: Parse GUE in UDP
  gtp: Move gtp_parse_exthdrs into net/gtp.h
  flow_dissector: Parse gtp in UDP
  flow_dissector: Add case in ipproto switch for NEXTHDR_NONE

 drivers/infiniband/sw/rxe/rxe_net.c |   2 +-
 drivers/net/amt.c                   |   2 +-
 drivers/net/bareudp.c               |   2 +-
 drivers/net/geneve.c                |   2 +-
 drivers/net/gtp.c                   |  37 ---
 drivers/net/pfcp.c                  |   2 +-
 drivers/net/vxlan/vxlan_core.c      |   3 +-
 drivers/net/wireguard/socket.c      |   2 +-
 include/net/flow_dissector.h        |   1 +
 include/net/fou.h                   |  16 +
 include/net/gtp.h                   |  38 +++
 include/net/ipv6_stubs.h            |   5 +
 include/uapi/linux/udp.h            |  19 +-
 net/core/flow_dissector.c           | 470 ++++++++++++++++++++++++++--
 net/ipv4/fou_core.c                 |  19 +-
 net/ipv6/af_inet6.c                 |   1 +
 net/sctp/protocol.c                 |   2 +-
 net/tipc/udp_media.c                |   2 +-
 18 files changed, 535 insertions(+), 90 deletions(-)

-- 
2.34.1


