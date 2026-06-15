Return-Path: <netdev+bounces-299312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwfTDvZ9L2rMBQUAu9opvQ
	(envelope-from <netdev+bounces-299312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C799D6833D0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=bAh7S7s4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7E03009B25
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665172FFF99;
	Mon, 15 Jun 2026 04:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D62FD675
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 04:22:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497326; cv=none; b=Jl4agnshvIkVsxspIGswnrzPbNPjhblzZX2UXPpJPR7NurKfG74mSM3Ukpz/iVJQ15yFTZzRTaI71xi4iT2L+V7PdPRwET8Zub80wiDYn52iBJ2rNauz6m0ysfCtfws8nXP/mGWSTyJ7r41iJiD5qOQOcG0PvzIlDufdpWS1OBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497326; c=relaxed/simple;
	bh=WWjEImPO6w8kw99Ym0d8cFIZiVWfhBO22tFBwKFbnCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN/BcJoJYyqG/g3OgdN+/Ui66uShOBIJzcfFuC1j889HGolovSmwFNh8szNPb7BgiuK7QuvgkMU9fk0Y39HerX2IfSGHmVN0T4W75FQUL0OSXGofHqKrSL3olnhEAvYQtAgWOr8vZ2WNq8gVIqmfMG+gjCxjc7Jq6rFuITftF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bAh7S7s4; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F391Qn901200
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=3SqO/a1c9N5apayhr3tujxjqIGdo+3i
	5tpHfqmnRi9I=; b=bAh7S7s4FBjzuBqLp+qYfbhvlKofGMmFp3/teA8wqfl+GnV
	pxuvoGcArPLeLdLT7m9K8X+J0fFAvMB+csOaJU7VXR/JrHFBdlinCmkuC22O3wv+
	6zs49BG5WZQqF+R00Oy1WhFqE+5jETb5OHRnYVLCdDbGVuwFVHv0JldR/qOQc3Qk
	D0o6C0ApolkBA0uG/9qJ9a4fVq2KEmxOKUu9DGHFgj3hBbk/1OyedNeqWALsGVxa
	lFSmB/UkSQZ8kZogERIt86wHEPkNF7MmAbA2XIIn1QOLxETRFYgzgq0DETz8RD5I
	n7m0ixZEQ5fsgun5nMu23AhgC0mxFvhcTSwLTCg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4esry5b48g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:02 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e60737a964so6248491a34.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781497322; x=1782102122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SqO/a1c9N5apayhr3tujxjqIGdo+3i5tpHfqmnRi9I=;
        b=nUSEKhfdK/xpQamCopCvz3oXcurFiiE5D66sXb6i5tVRnfVgBblS0o/sQUFj2O3C1y
         rWAYfqjIBqSyrzv6WOlrEopYqm3OSkL3XUREb2udAxW/RTNU4bxUXPfL714pfL03Eu0c
         WYqLSe3qB3PfE5bz6EVeUj2MpyWY1Xpo/2JdSenqEvgAKT0rf6f7jl9DjMBQYt4Gn2A/
         +Qnq/BqfITBcpEaG2d2mVPuePFnTvXF1X+GZlmwepK2/hpuFNS27/XbqQf74+VL3tB9l
         Oz42TX3dDRs2gmIIqw6LOq8oXOmmq9SDXfDAWpLvONAubqT2y06bouR65+/ziNrcP/BQ
         7uqQ==
X-Gm-Message-State: AOJu0YyHgp57dpx+9cb/3O08Knbe8AE4LTkyMfFDCriI/iSdRDrI50Nh
	xHAdH+jhr9c6OpjW8VeYrhcyZPtV57vylUfJjQ/0OApvEzuGjaDEPfHLdBS1sAjIhNNP7ottSv/
	Y67F6gddxHYQ9iU/EUCD0+NIgFl5pcQb6xk172qfdVLFCtj/4LaQAzIj3MAihUZf/Ai2BSNWFhd
	iydRqGjNQh5WvjGNNKdbkD2EApyjfSHZWwMToJ
X-Gm-Gg: Acq92OEE+EAY/TsQa8fG55AfM9Dsg4dPgevvdTGeumhXl0Dxx6CTwPWF5lLUSRXY04x
	5ztV1/YKm5+5owfQshrb7zx7A6fY0G2MlXn5ZFTUVm+A0MvMGdI+dhX7nKDAESGbCVQOxSYBCSS
	eVyVRwpKFddeDNw+v8AxQNPNPO815j03cmHzr26rSYFcyIQvL+Cp7vETKiT1s6nKOiNf3FPmY8q
	TFn9Z2fBVbYh5tHYegpbl+ko+iGJHckbyCT3th1PN1QfOVyXTVd0JY6FlSLUy2nEaJ8bQMQLboH
	MSv/IAAFwEGdGgku8wcxFo5x1ELJq65WL/g+HR9uJdGEA8lD85Mj6IiTB3VbBBA0eUWZELEgmOC
	o5srh5xc2wQ==
X-Received: by 2002:a05:6820:2089:b0:696:8e8b:2097 with SMTP id 006d021491bc7-69edc639ccdmr7601395eaf.21.1781497321632;
        Sun, 14 Jun 2026 21:22:01 -0700 (PDT)
X-Received: by 2002:a05:6820:2089:b0:696:8e8b:2097 with SMTP id 006d021491bc7-69edc639ccdmr7601364eaf.21.1781497320980;
        Sun, 14 Jun 2026 21:22:00 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00ed708esm2365315eaf.9.2026.06.14.21.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:22:00 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v14 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Sun, 14 Jun 2026 21:21:56 -0700
Message-ID: <20260615042158.1600746-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0MiBTYWx0ZWRfX1JQxAV26wFmO
 nmqVNdhm0pQF2yM7MLpUVWXt4xJTnqkey5uAePycT11iAy8NDwEuPk+nsyq/BV5RhYtFSjufHx5
 MU6Q3sDRRaeU9Tyy+z6oL+2qwA5DpV4=
X-Authority-Analysis: v=2.4 cv=ZP/nX37b c=1 sm=1 tr=0 ts=6a2f7dea cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=iT-lFH1iRYiL1B3W7SgA:9 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0MiBTYWx0ZWRfX4OClrNGhubuy
 gWrek/SYD+Z4Jehs0xV53CJZKog2JT+2cDSsoQ7DqW6471KSAUTaX3hBVTCOIj3HlFXXnlJmKyV
 G+2OuxxSEHKP5RjFeEV2jk6R4GabvFjRwIGtstqANsbejvVO8tg4AwGDkX5sNRpr5hi/pxLRYUV
 hH5m38Mp961rOjroL2qt6oeqIKcIFdaxt42jzsI1F4ZzfKaouN/LRRXHQZBrfQbUNrl/awW3mnW
 1hZpjixOQjNZhrpTAXd9FWeJJnZZfum3fFzxYWjJFPMUzhWROcEVyZHErFxEJDC8l2ePkOiOp7O
 ABmpRikX8Z7CBK2F386FJif2F3irYnRRHBJmzNDHa68lDzFfSy6ObBDAb0wu4QGQ2kDZe8KZkdy
 6DfZULUwziBDg/TjF3xIsY1WsEY4AUdf2QrFysYZAJmB9iWkxTF9ewcr23NyrtoMP1UfQwqfsX1
 eVgEQ56gPxbMu8m4zSQ==
X-Proofpoint-ORIG-GUID: sT8kXYLaiA6a4Q2sSkViw8W0ULzajst3
X-Proofpoint-GUID: sT8kXYLaiA6a4Q2sSkViw8W0ULzajst3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299312-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:ntspring@meta.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:mid,meta.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C799D6833D0

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection uses the same local ECMP decision.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path from the (potentially re-rolled) hash.

The override applies only to fib_multipath_hash_policy 0 (the default L3
policy).  Its hash includes the flow label, but that is 0 by default
(np->flow_label is unset; auto_flowlabels computes the on-wire label
later, per packet), so flows to the same peer share one local path.
Keying it on sk_txhash makes that local path per-connection and lets a
rehash re-select it; even when a flow label is present (reflected REPFLOW
or explicitly set) only local path selection changes -- the on-wire flow
label is unaffected.  Policies 1-3 are left unchanged.

Patch 1 is the kernel change; patch 2 adds selftests covering rehash on
SYN, SYN/ACK, midstream RTO, midstream spurious-retransmission, and PLB
events, plus a policy 1 negative test, a flowlabel-leak regression test,
a dst-rebuild consistency test, and a syncookie path-consistency test.

Changes since v13: https://lore.kernel.org/netdev/20260612010047.1377331-1-ntspring@meta.com/
Patch 1:
- Set the syncookie txhash from the cookie unconditionally, dropping the
  v11 IPv6-only guard; on IPv4 it only feeds TX-queue selection (Paolo Abeni)
Patch 2:
- Pin DCTCP for the PLB test with a route congctl attribute instead of
  the host-global tcp_allowed_congestion_control (Sashiko AI review)
- Drop the redundant syncookie dst-rebuild test, already covered by the
  dst rebuild and syncookie path consistency tests (Sashiko AI review)
- Give each test (and retry) its own port via an alloc_ports helper to
  avoid overlap (Sashiko AI review)

Changes since v12: https://lore.kernel.org/netdev/20260604212246.265079-1-ntspring@meta.com/
Patch 1:
- Factor the repeated policy-0 IPv6 mp_hash assignment into a shared
  ip6_ecmp_set_mp_hash() helper (Paolo Abeni)
- Replace the open-coded txhash reroll + dst reset at the three rehash
  sites with a __sk_rethink_txhash_reset_dst() helper, kept separate
  from sk_rethink_txhash() so dst_negative_advice()'s dst op still runs
  (Paolo Abeni)
Patch 2:
- Check the first rehash attempt's exit status directly instead of via
  $? (shellcheck SC2181), and drop the redundant fail_reason capture on
  the tolerated first attempt (Paolo Abeni)
- Redirect the remaining slowwait stdout to /dev/null so loopy_wait's
  counter output cannot leak into the captured failure message
  (Sashiko AI review)

Changes since v11: https://lore.kernel.org/netdev/20260602181428.2318919-1-ntspring@meta.com/
Patch 1:
- Fix the IPv6-only rule to exclude IPv4-mapped connections: key the
  cookie txhash on skb->protocol, not sk->sk_family (Sashiko AI review)
- Set fl6->mp_hash in tcp_v6_send_response() so RSTs and time-wait
  ACKs use the connection's ECMP path (Sashiko AI review)
- Remove the bpf_sk_assign_tcp_reqsk() txhash init added in v7; it is
  redundant, as cookie_tcp_reqsk_init() always sets txhash before the
  request socket is routed (verified by poisoning txhash and running
  the tcp_custom_syncookie BPF selftest: the route lookup never saw
  the poison)
- Document that policy 0 IPv6 TCP ECMP selection follows txhash over a
  reflected/explicit flow label (on-wire flow label unchanged)
Patch 2:
- Drain TCP teardown between rounds so late FIN/RST packets do not
  pollute the next round's tc filter counters (bot+bpf-ci)
- Skip the syncookie tests when CONFIG_SYN_COOKIES is unavailable;
  select it in selftests/net/config

Changes since v10: https://lore.kernel.org/netdev/20260529160136.1010064-1-ntspring@meta.com/
Patch 1:
- Fix build without CONFIG_SYN_COOKIES
- Leave IPv4 syncookie txhash unmodified (`net_tx_rndhash()`)
- Document the IPv6 TCP policy 0 behavior change in ip-sysctl.rst
Patch 2:
- Correct runtime estimate from ~15s to ~60s
- Build DCTCP as `=y` instead of `=m` to avoid module load races
- Fix false failure of the midstream ACK test by limiting the send
  buffer to avoid a closed receive window; window probes do not
  cause rehash

Changes since v9: https://lore.kernel.org/netdev/20260526203403.3517607-1-ntspring@meta.com/
Patch 1:
- Split cookie_init_sequence() into pure computation and a new
  cookie_record_sent() helper for the side effects; call
  cookie_record_sent() after route_req() succeeds so the overflow
  timestamp and SYNCOOKIESSENT counter are not bumped when no
  SYN-ACK is sent
Patch 2:
- Make midstream ACK rehash test more reliable by blocking the unused
  path first
- Fix port overlap when ECMP_REBUILD_ROUNDS exceeds the default

Changes since v8: https://lore.kernel.org/netdev/20260522215733.929238-1-ntspring@meta.com/
Patch 1:
- Fix REPFLOW flowlabel reflection for syncookie SYN-ACKs: pass 0 as
  tw_isn to route_req() so tcp_v6_init_req() saves ireq->pktopts
Patch 2:
- Give midstream and ACK rehash attempt helpers distinct failure
  messages (no TX activity vs no data on alternate path vs counter
  not incrementing) instead of a single generic error
- Drop unused ns_server parameter from ecmp_dst_rebuild_check()
- Clean up server socat before break on setup failure in the dst
  rebuild loop

Changes since v7: https://lore.kernel.org/netdev/20260520064310.4154268-1-ntspring@meta.com/
Patch 1:
- Remove #if IS_ENABLED(CONFIG_IPV6) guards around __sk_dst_reset()
  in tcp_plb.c and tcp_timer.c (Eric Dumazet)
- Guard mp_hash in inet6_csk_route_socket() on sk_protocol == IPPROTO_TCP
  instead of txhash != 0, since non-TCP callers like L2TP set sk_txhash
  in __ip6_datagram_connect() and should retain flow-key-based ECMP
- Use the syncookie (ISN) as txhash for both the SYN-ACK route lookup
  and cookie_v6_check() socket creation, so the server's ECMP selection is
  consistent across the stateless SYN-ACK and the subsequent full socket.
  Move cookie_init_sequence() before route_req() in tcp_conn_request()
  so the SYN-ACK dst is computed with the cookie-derived txhash; derive
  txhash from snt_isn in cookie_tcp_reqsk_init() to match
Patch 2:
- Invalidate dst via dummy route add/del instead of route replace to
  avoid a transient single-nexthop state during multipath replacement
- Add syncookie server path consistency test verifying the SYN-ACK and
  post-cookie ACKs use the same ECMP path
- Strengthen policy 1 negative test to wait for multiple rehash attempts
  and verify SYNs landed on exactly one interface

Changes since v6: https://lore.kernel.org/netdev/20260517174522.2232057-1-ntspring@meta.com/
- Guard mp_hash assignment so that non-TCP callers of
  inet6_csk_route_socket() fall through to rt6_multipath_hash()
  (superseded in v8 by sk_protocol == IPPROTO_TCP guard)
- Initialize txhash in bpf_sk_assign_tcp_reqsk() to avoid reading
  uninitialized slab memory in inet6_csk_route_req() (reverted in v12
  as redundant)
- Check post-rebuild busywait return status to avoid silent false pass

Changes since v5: https://lore.kernel.org/netdev/20260513204048.2721843-1-ntspring@meta.com/
- Improve selftest reliability: suppress __dst_negative_advice() via
  tcp_retries1=255 in dst rebuild tests so a real RTO cannot trigger
  an unintended rehash; add internal retry to midstream and ACK
  rehash tests to tolerate probabilistic ECMP path selection; fix
  midstream baseline capture to account for packets that bypass tc
  filters during the prio qdisc's TCQ_F_CAN_BYPASS window
- Increase ECMP_REBUILD_ROUNDS default to 10 for reliable regression
  detection with 2-way ECMP; replace sleep with busywait
- Use tcp_allowed_congestion_control instead of changing the host's
  default congestion control for PLB test (superseded in v14 by route
  congctl)
- Use (txhash >> 1) ?: 1 to guarantee non-zero mp_hash, since zero
  falls back to rt6_multipath_hash()

Changes since v4: https://lore.kernel.org/netdev/20260507171319.1259115-1-ntspring@meta.com/
- Condition fl6->mp_hash on fib_multipath_hash_policy == 0 to preserve
  deterministic hash policies 1-3 (e.g., symmetric 5-tuple for policy 1)
- Set fl6->mp_hash in tcp_v6_connect() and cookie_v6_check() for
  initial route lookup consistency; move sk_set_txhash() earlier
  (Jakub Kicinski)
- Add policy 1 negative test; improve sysctl save/restore
- Add flowlabel leak test confirming mp_hash does not alter the
  on-wire IPv6 flow label
- Add dst rebuild consistency tests (normal and syncookie) verifying
  that route table changes do not cause unintended ECMP path changes

Changes since v3: https://lore.kernel.org/netdev/20260505193824.2791642-1-ntspring@meta.com/
- Use __sk_dst_reset() instead of sk_dst_reset() since the socket lock
  is held in all three call sites (Eric Dumazet)
- Guard __sk_dst_reset() with sk->sk_family == AF_INET6 since IPv4 ECMP
  does not use sk_txhash for path selection
- Guard __sk_dst_reset() in tcp_plb_check_rehash() with the return value
  of sk_rethink_txhash()
- Move tcp_rsk(req)->txhash initialization before route_req() in
  tcp_conn_request() to avoid reading uninitialized memory
- Add CONFIG_TCP_CONG_DCTCP=m to selftests/net/config for PLB test
- Skip PLB test gracefully if DCTCP is not available
- Save and restore original congestion control algorithm in PLB test
- Default get_netstat_counter() to 0 when counter is not found
- Skip all tests if tcp_syn_linear_timeouts is not available
- Replace bash/pipe data sources with socat OPEN:/dev/zero for
  cleaner process cleanup
- Fix shellcheck warnings

Changes since v2: https://lore.kernel.org/netdev/20260408070514.1840227-1-ntspring@meta.com/
- Retitle "ECMP" to "local ECMP" to distinguish from remote ECMP
  (Neal Cardwell)
- Add fl6->mp_hash propagation in inet6_sk_rebuild_header() (af_inet6.c),
  covering the dst rebuild path used on established sockets
- Remove incorrect ir_iif update from tcp_check_req() in tcp_minisocks.c;
  the SYN/ACK rehash is already handled by tcp_rtx_synack() re-rolling
  txhash which feeds into inet6_csk_route_req()'s mp_hash
  (Eric Dumazet)
- Add ACK rehash and PLB rehash selftests
- Improve selftest reliability

Changes since v1: https://lore.kernel.org/netdev/20260408002802.2448424-1-ntspring@meta.com/
- Use tcp_rsk(req)->txhash instead of jhash_1word(req->num_retrans, ...)
  for ECMP path selection in inet6_csk_route_req(), making the request
  socket path consistent with the established socket path (Eric Dumazet)
- Add comments explaining the >> 1 shift for 31-bit mp_hash range
- Use socat -u (unidirectional) in selftest to avoid SIGPIPE race
- Increase tcp_syn_retries and tcp_syn_linear_timeouts to 25 for
  better rehash coverage

Neil Spring (2):
  tcp: rehash onto different local ECMP path on retransmit timeout
  selftests: net: add local ECMP rehash test

 Documentation/networking/ip-sysctl.rst     |    6 +-
 include/net/ipv6.h                         |   12 +
 include/net/sock.h                         |   14 +
 include/net/tcp.h                          |   20 +-
 net/ipv4/syncookies.c                      |    6 +-
 net/ipv4/tcp_input.c                       |   17 +-
 net/ipv4/tcp_plb.c                         |    2 +-
 net/ipv4/tcp_timer.c                       |    2 +-
 net/ipv6/af_inet6.c                        |    2 +
 net/ipv6/inet6_connection_sock.c           |    5 +
 net/ipv6/syncookies.c                      |    2 +
 net/ipv6/tcp_ipv6.c                        |   19 +-
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/config         |    2 +
 tools/testing/selftests/net/ecmp_rehash.sh | 1109 ++++++++++++++++++++
 15 files changed, 1203 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.53.0-Meta

