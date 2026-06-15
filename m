Return-Path: <netdev+bounces-299313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eeHvHgx+L2rQBQUAu9opvQ
	(envelope-from <netdev+bounces-299313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:22:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD36833DF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=dw8rN6Ny;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299313-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299313-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E27300F51C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 04:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAD2FFF99;
	Mon, 15 Jun 2026 04:22:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC33002DD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 04:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497329; cv=none; b=OcAxMCmay5ug086ELKGxqCTlZkgk/StP02owQ8ZsVd1SODEqXPG95v428Ffb11PhL8BA9hE+BEv0hfKlUvkYzZBkgxVJ8nDdYSYtgKnDpRhoYcAFFxbloQza8nkyngPuZ8bRCpOvm9wUgkPJFS8kkb7KlOSQLsuyKd6S7tKVfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497329; c=relaxed/simple;
	bh=FYcrnorg30zPKoBTt70D88QoCtynE4hGYHDb0vZ+Pkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/m7yJnRQPyza2e2XQmrezqt2C1t0ollFwewhg4d8Np1L8+hVhFXMWS9lB6ldmhIVoDmW9pv7LeqomlqpJxHfqV/rcJ3ZtC5U/Y+zoAmDL3WDJMcEha/3qc3yYSmyue3aiaffFdKZeXvdhtb1ePv82V4FX5L1mnEv9edadjqV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dw8rN6Ny; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F38jpx854034
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=WWf8yRi
	fFio8H9z8PEGx3DSkcRIHGFbUBa9Kp4onCjM=; b=dw8rN6Nyw+CCZVL0kflx3Sf
	iPVY/Wb8cIZAOYkURxKAzQlu6DC88CoBV4kBYn8QzM9h4EEbatbjLn1pxd68Ju7Z
	DephTMrk07EDyo8rIzdkbl86mwRBSbfFvb+tooRHarAKRp1bWypgs9osc5DWcQFZ
	ntYQomMKyGmongqzS/TxpktnP+IlB7I0oFVeu2OOPjswYnwv5e3scZiVgO6pwMoE
	f22PZ8WeoF8eDBzf4FowNQPhHVMRIdoSGhcsTlo7q3SwADU8dcOs11j00CkSjjI2
	g+DcOELpcjcXm1Gxz+dIOnGyTjXaWB+/G7Jd4ZkYz57RELeynHNebFK66F126bg=
	=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2h0q6ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:05 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6cea6ada5so6460790a34.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781497325; x=1782102125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWf8yRifFio8H9z8PEGx3DSkcRIHGFbUBa9Kp4onCjM=;
        b=NZSb6Xb94T8FMcEubWLpTuub100cO5fWgLh8Rph545STTSnFSwWFm/EbTP3NDTwwN2
         ROE7tBCzdveNIha/wFuvSHljLqL6M+c6Oh+3bjLJI2KXOVLEaf55ozBdOo9QzPYfMkAE
         J5z1sgfS74I0B7bEIHkAWZNjlCzUmHlAJmSBnw1F3Y14jS0zyonCGj3CJwruGijB11Ig
         zi1zQPs8X+hh55Ho3X7+VFSzTOhDoDKmWMK/WrIDt40emKqeTOKeqDVOUHkmF1krWmGU
         ot68B8tapNvwzLM4Y/UBzHydD73LKY4anANQOX0apA8JAtz1iYQUtSnRqda1/GWLhJoe
         WWQA==
X-Gm-Message-State: AOJu0YwABlQOIY9CRtyinw8ses4PUPRXpHwTgx5DNPk0HuPj46pjGGIl
	njsU2cSafnJ6B2QWkcsr7ZLtHeyQ87nfjZfKSd+CKndxySfn53612aXX62BanUzk/Cq5HD2UTn0
	ZXJ+Lxn8AS8uCBLE3chtt8ZNCyNLl1l64l2Yjte1RYAkPkC/opOe8QYcPU3hZFfbox/7/Hd9Lhr
	UsbrY8j4sPryy+vRx/9qsjCogJEI17pE9t8S/0
X-Gm-Gg: Acq92OGzcZSjtrqNd2u+cgcJQcIAFFr/Hj+0OffD14MWIwUp56VvwKllat6vRsnWbmc
	hHsBO6ns8GzLsz1uxGZLXOI7w/NEqz5Qk96n8zE9vfeuvFD6bQGbKsgDZjqsb62M3lFIFhEdhPO
	wWuCZMVa8ycGCqln9kzjqTg+Pxzo7e5p0NpaQH2mBkjoIw9EIl0GlCibsj7YbniYbD2aK8Si65W
	Dmg2m6JIkuZLbaKdrpYu0ybRMR2N/c2bizz//81Ut5JAvOWfKuDVM6FdJx8pgcvT4UnY+u4inei
	FkLq5iVD0BDnnjUCwaRshDenLJZfba8yEpFErWX3YXoJl0nclZdIGXJNE99j+Fh7fdcY36xChmn
	3u4aDGnseUQ==
X-Received: by 2002:a05:6830:2693:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e7846eea5bmr9893479a34.1.1781497324542;
        Sun, 14 Jun 2026 21:22:04 -0700 (PDT)
X-Received: by 2002:a05:6830:2693:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e7846eea5bmr9893438a34.1.1781497323895;
        Sun, 14 Jun 2026 21:22:03 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5bb5fcsm3314516a34.9.2026.06.14.21.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:22:02 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH v14 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Sun, 14 Jun 2026 21:21:57 -0700
Message-ID: <20260615042158.1600746-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260615042158.1600746-1-ntspring@meta.com>
References: <20260615042158.1600746-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a2f7ded cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=lg01szkEsf34iIS5_2gA:9
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0MiBTYWx0ZWRfX2lPkqcKTqXJH
 UaHt0iKnTMyQUvUZema/pD43FM+GwAe4aKqX/u3CiBT8T8A3rX578QZNDvXruh6ijt9Byf+duOZ
 x5ae9upWgdVRQ8VqE5jD6Bdyzpdrj/o=
X-Proofpoint-GUID: 5Ft5fUBCV3JS_MnH0qYiHU2RHowMUoB7
X-Proofpoint-ORIG-GUID: 5Ft5fUBCV3JS_MnH0qYiHU2RHowMUoB7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0MiBTYWx0ZWRfXz5Zpqj4YJJ4E
 90mpZMBqEnQZhN2YrHhuCeyODNV3O+LLNy/Oji3MyuS8ALJxELOARHjjcJoWahnxIyR0iH00lQc
 0izaJecoHleXwh5UhkKeenoK4XLJnMKwOI8Ts63PDTLNUy/Ol4tUGR7qeuOTmCFZevGBUxS1OIv
 D9sCWjquFLO3R6p3P7TFqtSU7vw2HUHkQmo98hPycTC8+dxLyi32KcT0AjZEJ3SkO6ECqFyFqwN
 OO3S80+a1ByUjry3twP3LLepZOBhBB19QUYW56JyRe/Nv3UDigPFL6XP5fiWSTrbFyEGHCFiGq4
 /xYPU+6Cscq5v6AtjMIC6VrGsbn3EtbuWUhpztvj5iM2G/y2eAMj3GI5Jtl5XZvHTTva0D8KsTy
 42o55jdYNg+q3t+RcIcGM3Fgo6yY0FMNmzBlSuCqvDIbpDQFzeOrJnARB8DLfesnT9gpPczktrk
 tphFZUxCYwKY9wMa/eg==
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
	TAGGED_FROM(0.00)[bounces-299313-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFCD36833DF

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
and spurious-retransmission events, but the cached route is reused and
the new hash is not propagated into the ECMP path selection logic.  Two
changes are needed to make rehash select a different local ECMP path:

1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
   tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
   tcp_plb_check_rehash() so the cached dst is invalidated and the
   next transmit triggers a fresh route lookup.

2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
   SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
   inet6_sk_rebuild_header(), inet6_csk_route_req(),
   inet6_csk_route_socket(), tcp_v6_send_response(), and
   cookie_v6_check() so fib6_select_path() picks a path based on the
   new hash.

The mp_hash override only applies to fib_multipath_hash_policy 0 (the
default L3 policy).  Its hash includes the flow label, but that is 0 by
default -- np->flow_label is unset, and auto_flowlabels only computes
the on-wire label later, per packet -- so flows to the same peer share
one local path.  Keying the hash on sk_txhash makes the local path
per-connection and lets a rehash re-select it.  Policies 1-3 are left
unchanged.

The mp_hash assignment is factored into a small helper,
ip6_ecmp_set_mp_hash(), shared by inet6_csk_route_req(),
inet6_csk_route_socket(), tcp_v6_connect(), inet6_sk_rebuild_header(),
tcp_v6_send_response(), and cookie_v6_check().  It applies
(txhash >> 1) ?: 1 for policy 0 (the >> 1 keeps mp_hash in the 31-bit
range; ?: 1 keeps it non-zero, since 0 would fall back to
rt6_multipath_hash()).  inet6_csk_route_socket() calls it only for
sk_protocol == IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
inet6_csk_xmit) fall through to rt6_multipath_hash() and retain their
existing flow-key-based ECMP behavior.

tcp_v6_send_response() also sets mp_hash from the response txhash so
that a control packet (a RST from the full socket, or an ACK from a
time-wait socket) selects the same local ECMP nexthop as the
connection's txhash rather than falling back to the flow hash.  The
time-wait socket's tw_txhash is copied from sk_txhash when the
connection enters TIME_WAIT, so it reflects any rehash that occurred.

Setting mp_hash explicitly is necessary because the default ECMP hash
derives from fl6->flowlabel via np->flow_label, which is not updated
from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
cannot help either, as it runs after the route lookup.

As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
label.  This is intentional: only local path selection changes, so
rehash can recover from a failed path; the on-wire flow label is
unchanged.

sk_set_txhash() is moved before ip6_dst_lookup_flow() in
tcp_v6_connect() so the initial ECMP path is selected by the same
txhash that subsequent route rebuilds will use.  This avoids
unintended path changes when the cached dst is naturally invalidated
(e.g., by PMTU discovery or route changes).

The rehash sites (tcp_write_timeout(), tcp_plb_check_rehash(), and
tcp_rcv_spurious_retrans()) call __sk_rethink_txhash_reset_dst(),
which re-rolls the txhash and, when it changed, drops the cached dst
so the next transmit re-runs route selection.  The dst reset is
guarded by sk->sk_family == AF_INET6 since IPv4 ECMP does not
currently use sk_txhash for path selection.  For IPv4-mapped IPv6
sockets this produces a redundant dst reset on a cold path
(RTO/PLB); the subsequent IPv4 route lookup returns the same result.
The helper is deliberately separate from sk_rethink_txhash() itself:
dst_negative_advice() calls sk_rethink_txhash() before its own dst op,
so resetting the dst inside sk_rethink_txhash() would skip that op
(e.g. rt6_remove_exception_rt()).

For syncookies, cookie_init_sequence() computes the cookie value
before route_req() and sets txhash so the SYN-ACK selects the same
ECMP path that cookie_v6_check() will use when the full socket is
created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
assignment in tcp_conn_request() and the full-socket assignment in
cookie_tcp_reqsk_init() set txhash from the cookie for IPv4 and IPv6
alike.  On IPv6 this drives ECMP path selection; on IPv4, which does
not use sk_txhash for ECMP, it only affects TX-queue selection.  That
selection scales the hash by its high bits (reciprocal_scale()), which
are uniform in the keyed secure_tcp_syn_cookie() output -- the MSS index
only perturbs the low bits -- so the queue distribution matches
net_tx_rndhash().

cookie_init_sequence() is split from the former version that also
called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
side effects are now in cookie_record_sent(), called after
route_req() succeeds so they are not bumped when route_req() fails.
cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
match the guard on tcp_synq_overflow().  route_req() receives 0 as
tw_isn for the syncookie path so that tcp_v6_init_req() still saves
ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
options.  The ecn_ok clear for syncookies without timestamps stays
after tcp_ecn_create_request() so it takes precedence.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 Documentation/networking/ip-sysctl.rst |  6 +++++-
 include/net/ipv6.h                     | 12 ++++++++++++
 include/net/sock.h                     | 14 ++++++++++++++
 include/net/tcp.h                      | 20 ++++++++++++++------
 net/ipv4/syncookies.c                  |  6 +++++-
 net/ipv4/tcp_input.c                   | 17 +++++++++++++----
 net/ipv4/tcp_plb.c                     |  2 +-
 net/ipv4/tcp_timer.c                   |  2 +-
 net/ipv6/af_inet6.c                    |  2 ++
 net/ipv6/inet6_connection_sock.c       |  5 +++++
 net/ipv6/syncookies.c                  |  2 ++
 net/ipv6/tcp_ipv6.c                    | 19 +++++++++++++++++--
 12 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..9905f5aa2427 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2444,7 +2444,11 @@ fib_multipath_hash_policy - INTEGER
 
 	Possible values:
 
-	- 0 - Layer 3 (source and destination addresses plus flow label)
+	- 0 - Layer 3 (source and destination addresses plus flow label).
+	  For IPv6 TCP, the local ECMP path is selected from the socket
+	  txhash rather than the flow label, and may change after a TCP
+	  rehash event (such as a retransmission timeout) to recover from
+	  path failure.  The on-wire flow label is unaffected.
 	- 1 - Layer 4 (standard 5-tuple)
 	- 2 - Layer 3 or inner Layer 3 if present
 	- 3 - Custom multipath hash. Fields used for multipath hash calculation
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d042afe7a245..8a8eb30e2980 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -952,6 +952,18 @@ static inline u32 ip6_multipath_hash_fields(const struct net *net)
 }
 #endif
 
+/* Derive the IPv6 ECMP hash from txhash so a rehash may pick a different path;
+ * policy 0 only, and only when txhash is set.  >> 1 clears the top bit
+ * (fib6_select_path() uses mp_hash as a signed 31-bit value); ?: 1 keeps the
+ * result non-zero, since mp_hash 0 falls back to rt6_multipath_hash().
+ */
+static inline void ip6_ecmp_set_mp_hash(const struct net *net,
+					struct flowi6 *fl6, u32 txhash)
+{
+	if (ip6_multipath_hash_policy(net) == 0 && txhash)
+		fl6->mp_hash = (txhash >> 1) ?: 1;
+}
+
 /*
  *	Header manipulation
  */
diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c368..6ea7daab7660 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2252,6 +2252,20 @@ sk_dst_reset(struct sock *sk)
 	sk_dst_set(sk, NULL);
 }
 
+/* Re-roll the socket txhash.  On a rehash, IPv6 also drops the cached route
+ * so the next transmit re-selects an ECMP path; IPv4 keeps its route, since
+ * IPv4 ECMP path selection does not use sk_txhash.
+ */
+static inline bool __sk_rethink_txhash_reset_dst(struct sock *sk)
+{
+	if (sk_rethink_txhash(sk)) {
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+		return true;
+	}
+	return false;
+}
+
 struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie);
 
 struct dst_entry *sk_dst_check(struct sock *sk, u32 cookie);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c4e6adb0dbd..75d265d19bce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2540,22 +2540,30 @@ extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
 
 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
-					 const struct sock *sk, struct sk_buff *skb,
-					 __u16 *mss)
+					 struct sk_buff *skb, __u16 *mss)
 {
-	tcp_synq_overflow(sk);
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
 	return ops->cookie_init_seq(skb, mss);
 }
 #else
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
-					 const struct sock *sk, struct sk_buff *skb,
-					 __u16 *mss)
+					 struct sk_buff *skb, __u16 *mss)
 {
 	return 0;
 }
 #endif
 
+#ifdef CONFIG_SYN_COOKIES
+static inline void cookie_record_sent(const struct sock *sk)
+{
+	tcp_synq_overflow(sk);
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
+}
+#else
+static inline void cookie_record_sent(const struct sock *sk)
+{
+}
+#endif
+
 struct tcp_key {
 	union {
 		struct {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index df479277fb80..73e129768184 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,9 +280,13 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
-	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	/* The request socket was freed after the SYN-ACK; use the cookie
+	 * (snt_isn) as txhash so the full socket and the SYN-ACK make the
+	 * same egress choice (IPv6 ECMP path; IPv4 TX queue).
+	 */
+	treq->txhash = treq->snt_isn;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 
 #if IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..928a065a242b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5020,8 +5020,9 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
 	    skb->protocol == htons(ETH_P_IPV6) &&
 	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
 	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
-	    sk_rethink_txhash(sk))
+	    __sk_rethink_txhash_reset_dst(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+	}
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
@@ -7636,6 +7637,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
 	tcp_rsk(req)->req_usec_ts = false;
+	tcp_rsk(req)->txhash = net_tx_rndhash();
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
@@ -7659,7 +7661,15 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	dst = af_ops->route_req(sk, skb, &fl, req, isn);
+	if (want_cookie) {
+		isn = cookie_init_sequence(af_ops, skb, &req->mss);
+		/* Use the cookie as txhash so the SYN-ACK and the later full
+		 * socket make the same egress choice (IPv6 ECMP path; IPv4 TX queue).
+		 */
+		tcp_rsk(req)->txhash = isn;
+	}
+
+	dst = af_ops->route_req(sk, skb, &fl, req, want_cookie ? 0 : isn);
 	if (!dst)
 		goto drop_and_free;
 
@@ -7699,7 +7709,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_ecn_create_request(req, skb, sk, dst);
 
 	if (want_cookie) {
-		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		cookie_record_sent(sk);
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok = 0;
 	}
@@ -7717,7 +7727,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..bcc2f0add6af 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,7 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	__sk_rethink_txhash_reset_dst(sk);
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..bf171b5e1eb3 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -297,7 +297,7 @@ static int tcp_write_timeout(struct sock *sk)
 		return 1;
 	}
 
-	if (sk_rethink_txhash(sk)) {
+	if (__sk_rethink_txhash_reset_dst(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
 	}
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..a5f3327d9f7d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,8 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	ip6_ecmp_set_mp_hash(sock_net(sk), fl6, sk->sk_txhash);
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..fbdb8c8b9ba1 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,8 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	ip6_ecmp_set_mp_hash(sock_net(sk), fl6, tcp_rsk(req)->txhash);
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +72,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (sk->sk_protocol == IPPROTO_TCP)
+		ip6_ecmp_set_mp_hash(sock_net(sk), fl6, sk->sk_txhash);
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..b581cb1ee2e8 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		ip6_ecmp_set_mp_hash(net, &fl6, tcp_rsk(req)->txhash);
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..e3a99f88cb6c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -258,6 +258,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		saddr = &sk->sk_v6_rcv_saddr;
 
+	sk_set_txhash(sk);
+
 	fl6->flowi6_proto = IPPROTO_TCP;
 	fl6->daddr = sk->sk_v6_daddr;
 	fl6->saddr = saddr ? *saddr : np->saddr;
@@ -275,6 +277,14 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	/* Non-zero mp_hash bypasses rt6_multipath_hash() in
+	 * fib6_select_path(), letting txhash control ECMP path
+	 * selection so that sk_rethink_txhash() rehashes onto a
+	 * different path.  Policies 1-3 derive a deterministic
+	 * hash from the flow keys and must not be overridden.
+	 */
+	ip6_ecmp_set_mp_hash(net, fl6, sk->sk_txhash);
+
 	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
@@ -313,8 +323,6 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err)
 		goto late_failure;
 
-	sk_set_txhash(sk);
-
 	if (likely(!tp->repair)) {
 		union tcp_seq_and_ts_off st;
 
@@ -955,6 +963,13 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (txhash) {
 		/* autoflowlabel/skb_get_hash_flowi6 rely on buff->hash */
 		skb_set_hash(buff, txhash, PKT_HASH_TYPE_L4);
+
+		/* Select the local ECMP path from the connection's txhash,
+		 * so a control packet (RST, or ACK from a time-wait socket)
+		 * uses the same nexthop as the data.  Only policy 0 uses
+		 * mp_hash; policies 1-3 derive a deterministic hash.
+		 */
+		ip6_ecmp_set_mp_hash(net, &fl6, txhash);
 	}
 	fl6.flowi6_mark = IP6_REPLY_MARK(net, skb->mark) ?: mark;
 	fl6.fl6_dport = t1->dest;
-- 
2.53.0-Meta


