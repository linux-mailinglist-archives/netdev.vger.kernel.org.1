Return-Path: <netdev+bounces-252059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFaPKx5KcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF95E491
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5A4F7EF0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC40339526A;
	Wed, 21 Jan 2026 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IsgTdvmP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA3337B87
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032186; cv=none; b=sdqINM8Agf3tWCJvMiPCbF2wVh6CU5LFXFB4vaLNIif8PGidtUM3k9ckfpFvA1T33XjMLQVOuV5Jp0GL4OtusU6sB8OXlbnbZl//YHAD/Yr+16lIMiY/GnJGvjg3R0U11wcAmFIYhTZNEHUqBTD6PBxnWq4KnvYdqua26cFs+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032186; c=relaxed/simple;
	bh=wD7+pzdZml8DztnMkmZ4SF64xdgAiFBWrz9uctvMyUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPr6Vs/oJt962C4La8GRkTqrswPTh2y8ZaSwZAREqjsedxhPinThxwR1ZbpN7rrtz93o5pjVXTqSTiDNpU95AC5xtktjpLRkODmfgEFPjxS7uO4XKNWrkboII+/gBNZK8nUyTnM4yW5YPUtEaOisu/xlmzozUIIOeBMnOkFygRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IsgTdvmP; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ae61424095so357132eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032184; x=1769636984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ4kIqgDfPhK8EpVGp9kzVMOY2aHc7K1oLvrxLHq/6Y=;
        b=IsgTdvmP8MZeM2oAbx785lV/W1HTxYJWspBhqKv/OmkHqwNIFo884ToojqSrM3w/cI
         NOxkRHlqvu4rXL+lQOHA8F8QpsIV8hi4J5kHwUudFqH2aRJFJOjuYwOutdPbUonKSL3r
         +8JuTOG5quEdETpnsCNnnL2HAB6sD/gFAejXCuHpiP8kPlyt/9oeQ0yrNkvW7ZdaMLLm
         PJ58+fTyWIQYMttAd/SU0WmPB02zNxOYGJD1qQOeI7ARYLUSjCWk1uDb4p/NOA0diFbX
         IwMu0XoegDmQaj5UkY0aGskzABz4h0tq7hMWSU3frlhkcaYp/Ut9wWPgCDKLZhMx9Yvw
         rvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032184; x=1769636984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ4kIqgDfPhK8EpVGp9kzVMOY2aHc7K1oLvrxLHq/6Y=;
        b=hNaDFc14cokU7lq02a4QHE5r6plM8Zu0gJIPmqm5lIqD54IsJRNvWkmu4RTPQN26Fd
         5gRGIuw2R7LVxaV/PFTC9APkLDqfPE3YE4CgvyuRx6iXBaksG1LD1XTB46dGT5mFBYPK
         9ohfSXVhPYQIFfWDPpudhzl+ZxtSqICVUNOZZCWyRlVYyuWEilbmLRFIuO3iCufiaCA0
         q5V0xpIZfsk82dhFc/ERphZE9LXNFFWuc3wX8DmHnR1j29YV2HbE35hpFBl8urID6x9Q
         7K0WL2MRd7in5vC6oy1BgmzcPNu1edzMZDJd0udVaTjxebfEKUJazDHAyJGrpMXDtSqL
         vBrg==
X-Forwarded-Encrypted: i=1; AJvYcCVNku5oEr4/hI3snLWBbwTQnOfEFYTWkrkGrD6Wgu6QnJHEztOOobdxD765XD1+1cKGmRWh1ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6gacWm0l0JjSN+smOku5jEg/KgrjnrRcdeGK5N/q9EwX6nCK
	sAuCtKoynKGmNBspr+1fFlM+SbB+hZAtZnC1EjVJtQPD3sD6Ae6MP0WqnJKxOlxkPpD7cQGZzL+
	E7/oFmw==
X-Gm-Gg: AZuq6aLaiTj1k5p4adehwsY+QUwDnsNyAyvs+pqU62OTRER1lCcQEU1LH88uVyj6vc6
	o3SgBOPk1gIFv9q2L7GUnLTyEPdCV8M2QG3V1WryBEQD7ZKzyJgfBZ+FbRJD8S7kp6xINNU7RIH
	Z+Y+C/J+bADya4hWJ2TQPOU11lLEO3pzVYr8ACinKYTlmyIcq+559iDGi1hKAXHWwzLan61hxzy
	kQ5vrLPXTwfokgvGNBGpe3Z4mHP/2W1H76PZUUj7aQNMHx6Pl74ZFHkZQiGkmHvM7Xp37dWlLAt
	VmFuowbn5nVzW/0Kw/vI4G7rcLpjwNFhBdonVqAjTx3kBWEk6Nz02g04dz/CuFTSurTsfsvVOBw
	RcsJx5Z75tHVA6AeRb8dP59ryeiX4uDJuxaoQDYPFIso8czLpY7azKncps6UtSqQtpSk1eebriE
	VV4y5VG1Z7n9UbmiIYa6w53/eP4t+NVapCll/1CS1E1sZowFCnFfsqoR3S
X-Received: by 2002:a05:693c:2c17:b0:2b7:1e8f:c83a with SMTP id 5a478bee46e88-2b71e8fcdc4mr1154597eec.32.1769032183457;
        Wed, 21 Jan 2026 13:49:43 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:49:42 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 0/7] ipv6: Address ext hdr DoS vulnerabilities
Date: Wed, 21 Jan 2026 13:49:18 -0800
Message-ID: <20260121214925.112604-1-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[herbertland.com,reject];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252059-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1DFF95E491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

V4: Switch order of patches to avoid transient build failure

Tom Herbert (7):
  ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
  ipv6: Cleanup IPv6 TLV definitions
  ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
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


