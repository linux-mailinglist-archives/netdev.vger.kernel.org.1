Return-Path: <netdev+bounces-305063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DfrKAKSzS2ocYwEAu9opvQ
	(envelope-from <netdev+bounces-305063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:54:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F57118B3
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:54:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=osOKbdFt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305063-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305063-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6B33139834
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDC3749F5;
	Mon,  6 Jul 2026 13:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E6372664
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:41:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345296; cv=none; b=C75HIyl1HYarRDobiUriSoFiSgqe+6/qZZKGOKF8bQI2Ehz+rv+u0jjzMLwOjEoYNiU9w7WOnMItBY7aCXAvN2nfaz+assCexen8ixK+xjvme0ns47QZLRVIE+/rCi5qdGdM0GY+c3uPqOa+tujy6vu/2j3Y03xGBI6ncBG1a2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345296; c=relaxed/simple;
	bh=DcinLXJkZhEimlfXPZqljt/KeF0J4CwScC9uvOz+V3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d53g0uSDyQF2fiCIuCFU1qDthxtkzZuOwn1BKa3lqTsktf8zFkL75+bo9DGb/ALWgVYMqsEliROXO1GwE4mAx0HR5H+JOfLDUpBLao78no+UE8VKBibemwNmjTunJdBPwaozEhBZbqjf7Uzz+U7HWxSpr+Eaus5xXA6ZsxvY10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osOKbdFt; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490d6730461so2864195e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345293; x=1783950093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRId4DvGOQ2rNFx3qYCNQcXGs6GHkZEpPtpwnp5Y1wM=;
        b=osOKbdFtTia/FPkcMnltfT5HRL21Uj/OG9kVfBZ3s8IpAwQg+RUDmdfVoMvbApDFLI
         hg6EL6Ua3hg0h9jxvYlvgeHIBIfN35uQTgHuCbBX0L0djQ+/ETv0FTDLCbZDlw0AEjHH
         LUijdLBLQHGSReC85SORlpe+Sk2FZTSQ93reG4jd/i8uWzLe7zfKhicGIHhtJ+RMkwvA
         bFnkbYE651igYDylnaJFxIlwvjWuiMclZC6nH8j9vfGs8GFkb3zzS8z16Q9d3FEy0Adp
         vFOyPNkIWvrLtTSBWgZDLAxorlv5L0zmMCNaW1S962KGyvmhgexgEbuRD4IuCMcoUcvB
         lxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345293; x=1783950093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRId4DvGOQ2rNFx3qYCNQcXGs6GHkZEpPtpwnp5Y1wM=;
        b=PTIPp9H4bNJqEIadZlTql9wj9mIv5qr5CkC+KYuTVe/tQGSMFftVx8ptIfMDaVvWcs
         ocl55gfqCskzmDhKhQUvbKE3KFU3aVzHwZSt6XSIQMWybJRmmboG+kq4zJqMYzq6iseR
         2Jgta+cpLifVpGlCPTzdlxvHHlvsnRsu3EENPchnr8ZnSrzRodHyCTO3Tmu9ozu+32SI
         bQHHnjOndEG7o52wTjBMVMiDE67KQACP/i/A5aD92FLaPuWptTAKFcQD0Ix8FT8Zu2o+
         WtUG7d0G7ZuROHpBBenZHCiJM/Vdod7NaBiiEZqceIEKcMEj5F2GBlyKrQcNc0tsN8jV
         nwDA==
X-Gm-Message-State: AOJu0YxXdzfYz5GmgPqKbMxUDhsJ+IZCQ2ypE/xC5Ih89e8+qObUhdlh
	wG21HRS7sFGR2Dhm4GIauHc4g4MDSs4GYwEqJhkIiErIZOVIIzZCdwVCLcnlPyhxDJw=
X-Gm-Gg: AfdE7cmdhgMvmGIqDkxXcGHKJugOfl9MZHWuAiNGuAXrSscefV8K22u0oreWL5C1SMZ
	wCu4n1dAHxTDQaKB4AdjlTo54odWR1qi54lH1nYAwagnNNkUJux5UMCsJPL140pQFO9Jh7CiKCB
	kVXfV9S03ftitUhgsvte3gHp73sAb9iSVb6Wqxlyk5tISi12hJsRQbJOsrpTc9EBLvhnw8e/j9B
	KdOXyQppqK18TkgMw4SV4ddkuwrp+lFIbBNLTi/7eor9M25jKbRMJFEeeXE6rZNS7iwBPETraih
	6d7+Aw4u22vdxoXUF4xmc6hjWGcDaxRv1/IHavk4zlT8jIYxFxhA5ZgwSQ/vpTIA7SA0epvocv1
	X/aE8hmv2zxH0Z/qvLSIXYeXpaCYqXBb1E/YT5XKFxIucIiQbUFHv75ULmW3cRm/YOnbay8rCnw
	CzhnGwYR6Lfzm350eORhiVNblb0Fzss8TsYNMmkoiGdqWLNPD7iBUv/VFdgeaOkszNIT3kxU7nB
	RAiEprKdzBgArgwcCOdEDyfHcPrwbsaxBPVnT2yiM9zDXA81wg=
X-Received: by 2002:a05:600c:4691:b0:492:6e72:eee with SMTP id 5b1f17b1804b1-493d0f361c6mr70762245e9.3.1783345292673;
        Mon, 06 Jul 2026 06:41:32 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5b6d-48fc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5b6d:48fc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm23960881f8f.23.2026.07.06.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:41:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/4] net: hsr: PRP RedBox (PRP-SAN) support
Date: Mon,  6 Jul 2026 13:41:27 +0000
Message-ID: <20260706134131.61659-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704234704.4297-1-xiexinet@gmail.com>
References: <20260704234704.4297-1-xiexinet@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305063-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url,vger.kernel.org:from_smtp,prp_ping.sh:url,hsr_redbox.sh:url,hsr_ping.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E1F57118B3

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

v1 -> v2:
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


