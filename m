Return-Path: <netdev+bounces-253579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAgzNTDFd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AAB8CC15
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66114302E7BE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96728853E;
	Mon, 26 Jan 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="gNnl3JbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164A287518
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456916; cv=none; b=G7JOnlRjuHTcBotLAxEayUMF2AIJXv588or2+BvlnKDo4/j0n0MWoUKbaU891PrGYRO2Pbw/VkkSLbd00t/RNLQJAIH0xGUt+u2+JrHmk2MkiTFiTjwkti/04G56IKzctmgCIPMTUBEtdMWPg2FXz66Zlf+r36nNf2FUos+66jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456916; c=relaxed/simple;
	bh=XrFrXjeR3dmf8lKjMmr112+8n0WR/cVWmRq36XSKpEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VulKb/KuWL5BrLVJlQ089rfsVSZSkzxM25j7L+Cj2Np4r9RfGy0obBi1fdA4S1vFTgXgRmh3y9OJe/tNbdPohJdtsqWyVjJlTCRY58/N0A4/lEQBFu6JQlfH2Bhcqn9umc4osu9ZuhX6EV9UOHlzB8YJd8tlOLC/bxZxVilSWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=gNnl3JbT; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12331482b8fso1365176c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456914; x=1770061714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ODlDLQtdtzEEsYeCoyewhRo5Fmv3vyOv9mA9o1HdCg=;
        b=gNnl3JbTHi9r5uBttBcWxvjmAbsAsch7M6Jo3ulztL8UD61PVy3pPFAkCQw4e+DJLD
         YoYsLI5kB/jgtrRgXXDzxex6AZCR2xd8QiAtcm2MeG/4fHJDTg/GtMy187wtqQpIS2lL
         ywD08mfyVeiX/J2kGyN04c34wKIM65QoAbTWBZ493LZYDJ1Ek3qgX57yz+7M/BSEDpKr
         aHH+g1aWFMY4wqEFaInYsaCCUk1vGO6tjOWFu5AoaR4gNokDBWNYTxlOSk+U1MUYGtFB
         c9KXSBiuCACWkTgUrz3cJzhmVMJHmrlqzj80FzCrqxqCJ9tgrFH2mHnMjOjSfx4RFX/H
         0n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456914; x=1770061714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ODlDLQtdtzEEsYeCoyewhRo5Fmv3vyOv9mA9o1HdCg=;
        b=WLzdsahlxYyo//Ao9wEADj6r1vZ1JLcpq6njBemZ/BJqE282oXZlCJbBKrP12BCWaZ
         zEBgRn4gsSZ1/YnW5gRCHRfNpjaIBDmNYY/gPp0MN5L0anqDQllTvWOkPlzyZ7Jw5TDO
         80x1OLumZUHECPGLxfanMnlsYL3aY7Bz9HqiwTKLetCMLJauDb9BJjMtus27S5YLma49
         pHfHCUn0bVOYB+Q3Cuevo4lkSw7h0L2fTss/3mWjy9/xctHJQUuPferX5O+aWArltHL6
         kEawGYZE/tDlKzg72/+rTVpkvWETynnsV+9ZprxuUxDH7pXqwY5GouVdQxu7wm/tCjs2
         BySA==
X-Forwarded-Encrypted: i=1; AJvYcCXqrosjNAFnFptOp9rYkVl59PLVhmUZ6c6hY0ORZlSKkFTSi451PCOVEcCdQSFV46XO8Guz018=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWL6su9LNHFoRbeLrzsIFbX6/agX4btK90AYKSzVFleo+/XfFq
	M8gQcmdfa6JWOPeJ/SA0i38N3kPesdbonK5raqgeBAvlFMA61gB6g0SvV0iR6gIGKqMYHA/gV/p
	G9aDK5Q==
X-Gm-Gg: AZuq6aINtZUik+L9md1ju+kylJG394kSrwXo6aeShz9KiAc6aL1uYAVW4XlBuSMRs37
	824ragXMAUGrLX+5T5oPeG9Deo0Ktn8rW/erS3G3/wIfDHrNuCycrxeShOqbDE0M9pSNnmVDDBx
	Z9/KvUjyjgm0JKe1PQXgk3RjJtD0pcbwpnPaQANrrlzTtlDAkyQXgdTLZo5f7O+DZtBc4xne2uD
	8vHoieWvn9kRWYn11u0R6noZMBr1UBeUKXRqnbgNPWnYxQEQ4i6/kmkTCvpUIHygzAFrxNfGmA5
	DpUKBWh78lhW809du3PjhJDLTMHRpNq1CPlU1NSJhc2q5A3XCH5W87MXeO/50dRACBCY+3EZRcR
	WArg66niBpZIohC/XA2MeZT9BxIwRBLUTdF4e7po5+PIDgk6ge+KXrK14vpzx+JR+J/tM5VODTs
	6e80GKKRmcL0wdkWKY4TlCBK5Fz0W2con+zNdOd5+QtC4qX1ks2RIvNhnbkYRJSecp6w==
X-Received: by 2002:a05:7022:128f:b0:123:3407:1066 with SMTP id a92af1059eb24-1248ec85aa2mr2704101c88.43.1769456913995;
        Mon, 26 Jan 2026 11:48:33 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:33 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 0/7] ipv6: Address ext hdr DoS vulnerabilities
Date: Mon, 26 Jan 2026 11:48:19 -0800
Message-ID: <20260126194826.236075-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253579-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:mid,herbertland.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54AAB8CC15
X-Rspamd-Action: no action

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

V4: Switch order of patches to avoid transient build failure
V5: Allow Desination Options before the Routing header, fixes
    suggested by Justin Iurman

Tom Herbert (7):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Cleanup IPv6 TLV definitions
  ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
  ipv6: Set HBH and DestOpt limits to 2
  ipv6: Document defaults for max_{dst|hbh}_opts_number sysctls
  ipv6: Enforce Extension Header ordering
  ipv6: Document enforce_ext_hdr_order sysctl

 Documentation/networking/ip-sysctl.rst | 50 +++++++++++++++++++++-----
 include/net/ipv6.h                     |  9 +++--
 include/net/netns/ipv6.h               |  1 +
 include/net/protocol.h                 | 14 ++++++++
 include/uapi/linux/in6.h               | 21 +++++++----
 include/uapi/linux/ip6_tunnel.h        |  1 -
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/exthdrs.c                     | 32 ++++++++++++-----
 net/ipv6/ip6_input.c                   | 42 ++++++++++++++++++++++
 net/ipv6/reassembly.c                  |  1 +
 net/ipv6/sysctl_net_ipv6.c             |  7 ++++
 net/ipv6/xfrm6_protocol.c              |  2 ++
 12 files changed, 153 insertions(+), 28 deletions(-)

-- 
2.43.0


