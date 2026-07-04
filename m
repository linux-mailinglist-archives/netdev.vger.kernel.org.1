Return-Path: <netdev+bounces-304733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ohZ2JIGbSWpU4QAAu9opvQ
	(envelope-from <netdev+bounces-304733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B9F708A45
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 01:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ez/HwjQa";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304733-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304733-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D5D300F9CD
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C739AD49;
	Sat,  4 Jul 2026 23:47:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61F2BD02
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 23:47:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208829; cv=none; b=Du1m37KQH8U9l/al7O+rTKDmb6BKstz6J2HaT6tdI+NiQ7FDf0eQ88CMwtkxviphkRT9P0HUTWTP2Mr5ubTxcQfcCasGNEKrj4NuErOb/JCoxj8UHWmssfzhO+uqn9cHPHdDaDXamLtf/9YwwGDFtmpGu49fDPHApNWQ+7hk8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208829; c=relaxed/simple;
	bh=hG23Q4y5aBcg3cuKpH3vsyLBWDktEghaMP46k932PwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJWo+Hb+6+/KnW/ymXdPxOzPMp0Wj/yot1fs5p1sgvAPBqf/B5kG0Yo7dzuqYycmyUlM5Ixb9FEAt26JPKpdsdFG5JxuD/+zQ16L7tEqckPwwnmQFRmVCL67CZO/IqclBq0gvde894vw3fu7Dkxuec/CD9+JyFsNcJw84PSzLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez/HwjQa; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4706f016316so200531f8f.3
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208826; x=1783813626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VP4mk76KIzqP5E59dkvynV+Ki6J6pthrQtt+0HdWFW0=;
        b=ez/HwjQahvWEFOi7JXEfrb2nnK79Ajct+Ipp8HSWwUd6sm/lCF67RTkx7CuU4dhiuR
         VJsDPnYET/Ch8brTLmyAgmn3aklYYxaZciJdp0CchbUgTZRXaZg8LmzBJZ+DBVsa7yJD
         TCCyhbr048jqR6H4jKwSJYIeNx+lzqh9XaooUWwoajnnSgvQo+33Me0sq7+uydUNznIK
         ZnrbZ3qLPCacINrCrdbPZt4oh8/ywZ81X7L/etMCtoo3ShXxF3gnh6h87qytESWRvbqd
         RXCJsH0SLQ2YowPih8Guo5uTHtZD3Txo9TKHn4twkO4OfEtIy2iVsh6ZAzhAbu5LkxVv
         0lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208826; x=1783813626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VP4mk76KIzqP5E59dkvynV+Ki6J6pthrQtt+0HdWFW0=;
        b=Fd91ni5/se2Y45uzpYOSgeXUdfIgtuyG7z6gf3EYl9nEXg7KM8yrzlSJ2iccgakK8R
         ytoaNhwWQPpMydG5upNDtv4BSPSVioaJ0Faub7Ic33j0DWHzXKSGfnxNBYFd7RudCzIW
         vOvjYgtfDnIJuYim1zoUjnl+Nv0fR2IGQs2TMzlZwiACExGqwl0dowPZOLvwdfhFgqce
         iw52vqgZ+xxd9J45CzJVcgFHel6t5YuOBrZiNlDQln2rTTTCu0lo7uKdWF3Je5kLxFBO
         MjiRUUeOXOoiGS0bgIabTilNoCeADk9KIJN+dk1igyamdOJobtrbxZdwbkl6nf8nkpvH
         WlrA==
X-Gm-Message-State: AOJu0YwZk5U1l2zDquCB/ma7caMMhvZ74JIbbggYALYFCAESfnoLH+Ml
	FnkreOWc0WWWgUPb5L5QfXcDF7RGF+HfT5OkDddQgxRB6Q62Je60pDob6FrWFHmN6vM=
X-Gm-Gg: AfdE7cnye2jYHOPZKLzwfRIPkQr9Albxx9GiEeqmvqQXE9GoxfD4o5Y5s0qtPNiwLop
	oqOw50GZU6f7BiNM7t5c9aayUgyy8Hh6IqfSwvr7UlmsSFRUOzjY9Oujt6aapNXnci6uKg2xXKO
	7nmMJhboLbepW2lkbfAuyezyvw1+fa1L8CoJ8s9HrilF5RthOCuGoUp9SFaJOKfwp2uDLKexu61
	u5hsLFHecwH97lonZ26TIX9Q6ktHAQQJ0D4TBrW/ECTR9nvNYMc0TTB2/zZ7niFHdltZejiV3nI
	DM18k1vIftycrDHLpWwATtkelpXdMQGhorw4U5JOdewtMEl0QhDdpVQJ5z+Md91I9op17zLqm2Q
	q1Ea1aGW0gZei9+EQgp4W7vm5FVel1rjbV/+CoBjhniXQ0GRkUP9GuDEa519lcfDVelDaQLuzq/
	5q6fC+/fvk7YhapW0srt/VRtKW2fZ6zwEpVexl2BU9NhB1NtiAVcsZ9s3QBBpR7i/pm3koOvUvI
	u1O2JIMCxbZGXa7FSHN2wrJFPUlppq6Idvi6w7WKDudFPu5e+g=
X-Received: by 2002:a05:600c:8217:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-493d0f35d08mr31512525e9.3.1783208825954;
        Sat, 04 Jul 2026 16:47:05 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5cf8-ddfc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5cf8:ddfc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce040b4sm216014125e9.10.2026.07.04.16.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:47:05 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next 0/4] net: hsr: PRP RedBox (PRP-SAN) support
Date: Sat,  4 Jul 2026 23:47:00 +0000
Message-ID: <20260704234704.4297-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304733-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9B9F708A45

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

Xin Xie (4):
  net: hsr: add PRP interlink (RedBox) datapath and duplicate discard
  net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
  net: hsr: allow PRP RedBox (interlink) creation
  selftests: net: hsr: add PRP RedBox test

 net/hsr/hsr_device.c                          | 33 ++++++-
 net/hsr/hsr_forward.c                         | 49 ++++++++--
 net/hsr/hsr_framereg.c                        | 23 ++++-
 net/hsr/hsr_framereg.h                        |  2 +
 net/hsr/hsr_netlink.c                         |  8 +-
 tools/testing/selftests/net/hsr/Makefile      |  1 +
 .../selftests/net/hsr/hsr_prp_redbox.sh       | 96 +++++++++++++++++++
 7 files changed, 191 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_prp_redbox.sh


base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
--
2.53.0

