Return-Path: <netdev+bounces-305482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LKMbOzwITWp/twEAu9opvQ
	(envelope-from <netdev+bounces-305482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796371C553
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:07:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XzF99Pqn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305482-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305482-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80673199FFE
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428B4229C8;
	Tue,  7 Jul 2026 13:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C2412282
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432783; cv=none; b=c1UBwZSRH0fMF+Pa3i6USegI/1LPm67TcqbidsuLgvaiKmlEGFy8e4x8nL/g3xYCdZwfDbY4V97abPq5H4vZ9MYCz+awxLJ2byQVckOvJ+ZebsbibYkvf0qFIDKW77RQHGTjCSbebNSv6dEcyLDIxSnbrYw6iZkHbPeO2npi8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432783; c=relaxed/simple;
	bh=Rl43uplBn455YhFwjo/vcc9PHxz7zLwspe271+LXUrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8i60r2qBfS6ydbE7BpQybMEEuJe7x49oi2o+O8296qtj2qo2ba5E9r7zZT19P2ClIvA7AL2Rj0mmuhQQegi+fFAEpQxlCybqZkBJjh+BF8Zofh0CEuAZOru3HZdG7EP/+QTddJikImIzd1Djb6YLSlp3fm/+6Q6lhGRJY5Vrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzF99Pqn; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c30f5347so4389425e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432780; x=1784037580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vstUOUhJFF2dnlTmkQFQ2pW4YjUnMuVRw9ylmAWYSnU=;
        b=XzF99PqnB39O4ARUaL5bXUJJzPSE86UgCTfKi2TIX44budyaKd/+xCI643Qe4wE4/8
         shrnoG7TyFQEgXPGL3jyTARjkshjMTIFEQ1L8p9NskFRbiOBNxcZhzukvbd7JQudKOUO
         bBCkF8GaYysb/TlWnaGsc0BgocG45jH580krARzHoLesnP37Ji4S1MMtcN9DIps1MGIi
         kETMAyAcxPxWYQwcO/xFpCupyR9/Fuuz6qKzCmAbZS7IlbVPIYOU5aE/UWP0EZy9oZWb
         2PxdHJU2pvj/Ee1SRcc2yVqgGDQTyyEtv85WquUU78SsavhZ1TMmn30/z/dNN1uG/DAT
         591Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432780; x=1784037580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vstUOUhJFF2dnlTmkQFQ2pW4YjUnMuVRw9ylmAWYSnU=;
        b=KOS7USQdR7KTRWX4Pd13bdOg/Nnemxx0gm8JDvfftjvtKbClVZDQTPO8+BEt9HVLgz
         KHFhlnwoyLMCImdrHL77VxMEMH0P4MxGobxCRiorH4N365ItxI1jVOlSXn2Em0Fh5Pjm
         OtyANHnr09PZXtGpZOpuOYnhphbwHaXh+k5jirhBt3QpIzWstrpm/y8wGZ0HcnGnS0Q7
         Nwhe2sd1RtYCl5NyBZITcNI462jTdKY3EmWCJU73KWW5nuWVe66TWJIpjdpvDeCSc1tJ
         WH3xUdHZ0YupgQl6ODdgHD5q+qf8ldwoiHp8FuaoPry6FKCv7mMgyhg78+1jy8c/AOgi
         Lr/w==
X-Gm-Message-State: AOJu0YyjsE307lN8jbW5xI3+7OvWcTST0Xph6ymH9d7AcZiUAeiosaeo
	c/pS7SvU8kUZx5IjAEJ0QduILvrpoNRv/YF5CGdC3VS0/BNUQ5Hikb94FE04ujdW
X-Gm-Gg: AfdE7cnIspXN4T002Qbo2JFfXJM6yLYyG5syVHhi6TuLr1GiYuECsX2YkDro985hKxS
	IOSEGP3KRuAM1cvZ7tSptY14zTMOhO9kk4tAxn9pB42rt1l7vLk+xw/Ai6gce60Jbg9iMxxME2r
	/UfU+AM2fKIfcuUgYFMZK1nK0eiJgQCRxxG2orkgND4Aipm3LPLUOJ6dB2wFWvbpb66+E14lDA5
	C9HINlFQHz96lCo9tq+35MWKuQD3ZJly/Pi0gqpKs/T1t8byxgufZA5BjJji2wceY42VwZzd8wJ
	T3cHzg/5+9tHoqGUjbCVxUJSqiAwHoGv1BNz6Wdo/+doTt2dZGUQCVf4SUEjBZ8STVuHjrIpY9E
	Rqxi/aELTMwRod1g8DE3Y6gcy+1HqzP0B7rDovtYaL8ddTwr30RNfzsy29AmzS3iAafIzjHMZfm
	hHNCa67A3dj4eIpeuy4inZ3qwaD4S9pisPjk27NxAaRQsQwM+pUTIWm1xlAWwpXSGHfEW6IUpXM
	glwKyFhbe8WYDj8To0MLG6+GjNKTddgMFTTwovU8dXODwNTJME=
X-Received: by 2002:a05:600c:c0cb:b0:490:b227:da9b with SMTP id 5b1f17b1804b1-493e0b9071emr12356505e9.1.1783432780094;
        Tue, 07 Jul 2026 06:59:40 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-189-165-250.77.189.pool.telefonica.de. [77.189.165.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40d50sm67409615e9.5.2026.07.07.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:59:39 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v3 0/4] net: hsr: PRP RedBox (PRP-SAN) support
Date: Tue,  7 Jul 2026 15:59:33 +0200
Message-ID: <20260707135937.18-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305482-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3796371C553

This series adds PRP RedBox support to the hsr driver: a PRP node that
proxies one or more SANs sitting behind an interlink port (IEC 62439-3,
PRP-SAN). HSR-SAN has been supported since commit 5055cccfc2d1 ("net: hsr:
Provide RedBox support (HSR-SAN)"); this extends the equivalent capability
to PRP, reusing the existing protocol-neutral proxy machinery
(proxy_node_db, hsr_proxy_announce(), hsr_prune_proxy_nodes()).

A SAN behind the interlink does bidirectional unicast with peers on the PRP
network, its source MAC is preserved on the wire, the PRP RCT is correct,
and the RedBox announces each proxied SAN with the RedBox-MAC TLV (Type 30)
in its supervision frames.

The series is bisect-safe: the datapath, duplicate discard and supervision
support are added first; the rtnetlink rejection of "type hsr ... interlink
<dev> proto 1" is removed only in patch 3, once the feature is complete.

Design notes:

 - prp_drop_frame() does not walk the node tables. The destination
   classification (PRP-network node vs proxied SAN) is resolved once per
   frame in fill_frame_info() and cached in struct hsr_frame_info, so the
   per egress-port drop decision is O(1) in the softIRQ path. The
   classification is gated on PRP RedBox devices (prot_version == PRP_V1 &&
   hsr->redbox), so HSR RedBox traffic is not affected.

 - The LAN A/B duplicate test is factored into prp_is_lan_dup() so the new
   PRP interlink rules in prp_drop_frame() do not change hsr_drop_frame()
   behaviour, including the NETIF_F_HW_HSR_FWD path. This is software PRP
   RedBox only; it adds no new hardware-offload contract.

 - The supervision emitter uses pre-reserved tailroom (hsr_init_skb() +
   skb_put()) on the existing GFP_ATOMIC path; no skb_linearize() or
   pskb_expand_head(). The RedBox-MAC TLV is followed by an explicit EOT
   (Type 0, Length 0); padding via skb_put_padto(ETH_ZLEN) and the 6-byte
   PRP RCT remain at the absolute tail of the egress frame.

 - The hsr_get_node() hsr_ethhdr length guard is relaxed only for PRP
   supervision frames (prot_version == PRP_V1 && ETH_P_PRP && is_sup), which
   are untagged with mac_len == ETH_HLEN. HSR (ETH_P_HSR) supervision is
   front-tagged and keeps the original length requirement, so HSR
   malformed-frame filtering is unchanged.

Testing (on a net-next v7.2-rc1 kernel built from this base, x86-64):
 - checkpatch.pl --strict: patches 1-3 clean; patch 4 reports only the
   expected "added file(s), does MAINTAINERS need updating?" note, which is
   ignorable here -- MAINTAINERS already lists
   tools/testing/selftests/net/hsr/ under HSR NETWORK PROTOCOL.
 - git diff --check clean; the series git-am's onto the base commit.
 - tools/testing/selftests/net/hsr/hsr_prp_redbox.sh: PASS on the patched
   kernel (bidirectional unicast, SAN MAC preservation, RedBox-MAC TLV +
   EOT in the proxy-announce).
 - HSR regression on the same kernel: hsr_redbox.sh (HSR-SAN/RedBox),
   hsr_ping.sh and prp_ping.sh all PASS, confirming the PRP changes do not
   regress the existing HSR/PRP paths.
 - netns checks: peer<->SAN 0% loss with no duplicates and a valid PRP RCT
   on the wire; a silent SAN is pruned from the announce; zero driver
   WARN/BUG/Oops/RCU-stall during the run.

Beyond the in-tree selftest, this exact series (applied to this base and
running as the net-next kernel on x86-64 hardware) was also validated with an
out-of-tree IEC 62439-3 conformance harness (supervision TLV chain, duplicate
discard, cross-LAN rejection, seqnr rollover, VLAN/multicast/GOOSE frame types
with the RCT verified at the absolute frame tail), and interoperability-tested
against a commercial PRP RedBox (Siemens SCALANCE X204RNA) over 100 Mbit/s
Fast Ethernet with NIC hardware (PTP) timestamping: a mid-stream single-LAN
outage of ~2 s at 10 kpps was bridged with zero lost and zero duplicate frames
(seamless PRP failover), and the duplicate-discard window held zero lost /
zero duplicates under netem asymmetric delay up to 100 ms (~1000 sequence
numbers in flight), 25% reorder, and 5% single-LAN loss. The failover and
impairment matrix was additionally repeated on a KASAN + lockdep + kmemleak
instrumented build of this kernel, including a 72-carrier-event link
flap-storm with deliberate double-LAN cuts: zero KASAN, lockdep, or kmemleak
findings. This out-of-tree testing is supplementary and not required to
evaluate the series.

v3:
 - no code changes; repost as a new thread (v2 was incorrectly posted
   in reply to v1)
v2: https://lore.kernel.org/netdev/20260706134131.61659-1-xiexinet@gmail.com/
 - publish the RedBox state before lower RX handlers can learn nodes:
   fixes an initialization-ordering race where a node learned during
   device setup got a single-port sequence block, breaking interlink
   duplicate discard and letting the supervision merge read beyond the
   source node's allocated sequence bitmap (reported by the NIPA Sashiko
   review)
 - harden the supervision sequence-block merge against mismatched
   seq_port_cnt
 - align macaddress_redbox for ether_addr_copy() on strict-alignment
   architectures
 - selftest: kill the background ping by exact PID and wrap an overlong
   line
v1: https://lore.kernel.org/netdev/20260704234704.4297-1-xiexinet@gmail.com/

Xin Xie (4):
  net: hsr: add PRP interlink (RedBox) datapath and duplicate discard
  net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
  net: hsr: allow PRP RedBox (interlink) creation
  selftests: net: hsr: add PRP RedBox test

 net/hsr/hsr_device.c                          | 44 ++++++++-
 net/hsr/hsr_forward.c                         | 49 +++++++--
 net/hsr/hsr_framereg.c                        | 27 +++--
 net/hsr/hsr_framereg.h                        |  2 +
 net/hsr/hsr_main.h                            |  2 +-
 net/hsr/hsr_netlink.c                         |  8 +-
 tools/testing/selftests/net/hsr/Makefile      |  1 +
 .../selftests/net/hsr/hsr_prp_redbox.sh       | 99 +++++++++++++++++++
 8 files changed, 207 insertions(+), 25 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_prp_redbox.sh


base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
-- 
2.53.0


