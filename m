Return-Path: <netdev+bounces-287722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEwXAfvhBGrPQAIAu9opvQ
	(envelope-from <netdev+bounces-287722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516253A981
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E27F3300E629
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFC3793D2;
	Wed, 13 May 2026 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VDjKqASz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C6375AB5
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704854; cv=none; b=G3lvOMkDhaWvEJAVdHz7qKNB3prOnr0W8Rmoy9xFTjee2DgKGvKHPSndsRmIGq86DhBnHTh+j8lrs3lXuN2NqEzJdBVpIQJbq9BrNdevchIC9CfbFpv0RdoYBVqVw3rGHTt8nlMB5a1u/SZt2fr2fGli0uxuc86kRw148VVAn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704854; c=relaxed/simple;
	bh=tnp9sWlRUCD7WPXqp62wSewrhltYpOGKUpZ0LbPcvec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUFYH59v+hKE1SqaCIoUSIpduiFVccYoZdQs3+4kWtxGfIqZMbDA4Yhgi4kZK/tp+DUMtr12pbRuHZD9B9T1Mp6dNZ4SYF2tL9KQQDOenxfNMh27VWTEbL1/7ZHwS3AQqTjOKLIdbEAvyZz63K669gCBAGKFGi7GJ7MczSzI+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VDjKqASz; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DKJCJC3541032
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=s2048-2025-q2; bh=0I9+jRdqhykl9YTULLQIHWGbqIub1No
	RYPqyBx+S3g0=; b=VDjKqASzNwIl9e6I0MlNv7DNI4GyCDcMzMCl4dTQ1a/pP8j
	T8O8IEN8dzrsr0it5eAJ09p1sPhEB4a2ozhAB4tOFUASluSL+fHhDtenEHJkPYi3
	1z3NC2y7/KvTxzB8IWcvDz4V4JNBx5fh65UnNstAX2ZSVaTDs0+W9mdOXZ28jAWl
	tPRkAGfEvwy2XEU0aIyinpGD44K9WPr7jTkNODjnGDf+guhp42gqMH0BrQQ87cTq
	xnBE/LoOB/NNlYxYLvp/U+4D3WZBS/aHukNY9cNTWOVTL9PzcrFnANaScq3mhe/D
	y73rS4qfoOPGXKl1jZgj7iZjsx4GR3i8BsRsGbQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvqk4w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:52 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-439e3568bf0so1234210fac.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704851; x=1779309651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I9+jRdqhykl9YTULLQIHWGbqIub1NoRYPqyBx+S3g0=;
        b=OaJElpytN4PAXb7JGRWp8QpFmrtjTWBnvzJ4FOH7X4ycnYOyZfWX+aTdeIZJfL6ZwH
         vXpfnrp0l//Dr4cY23LbLuvbKwphDskWvo3NypCFx4EOVRNWUM/lrWZEDLmBSKc0jRZD
         aNoIqlpQ2j0nhtBkMZZHV8DnZqmQJSyL/H0blB/2lV1r5kMmuyr+Js/6NaIXpehb5fKi
         0Qa1/idd4tEhgls4uBKoLuRTasWu7+kvqv4p3938gzcS2kks+nE3fFL35/I7VFFNYshh
         ZGrOfhmcHfDwfW2ZglKKB+agugStSkO50yYuK/jprSWANiVifu9WKkJ3YXRsI/4g0I+0
         kWaQ==
X-Gm-Message-State: AOJu0YwPC7kHV8gDWYeBPUlHYsBjc+WZK9ZHMdD2eH2E/QLRvQqOi9+M
	9MZy9BoV3/nBehUG03ciRP69z2QrLPibCYTn1norsh7EekhiVtiJ/dzRyaBpjDJ1GDA+aNc0BH1
	23c/IY//4HfFjSxJUUXW5nL+NL/9SltOL6ntHMXja5zt/SeOEkIFzNNg2o6NhdjaWRllPW3Vsb/
	I/+xmyML4T/3T0ZAT1VN5yiEFmcLvoT40uD0p2
X-Gm-Gg: Acq92OFDUr1aLSwC68GsrZRpgXdHmegWu5zBmQibh4PHYBoFIZptp4gcHX5glrAEsB3
	uBIvXLGQt2uZJFQCJ9FyAoklT3oqGBu/eZVc2Tpzza2RbqfA8KyZaF3yuLwMUqqs0M+WRhRPer6
	3Suy5BIGH0/3CtYs1rhJDgZDqyay9AGGI8AwTfMkCQczD26jni1QkoAFi6hUS4fZm60KJ8bc7Pi
	lemy0uVl4hwxUAtfDbIuBrvClKrr7Y9Urth8MekABTLWqgUGFyqS1gtqWXD54E2Ot9p1NUcrz/U
	SCoVdHOjWr62dbUS5Acn7/WYIja4JZsIAPba+lhBIB1LMANwr1AnK7iHu7PzIx3QRe5cQksueF6
	CcNbyLbbr0Z9YvrbgqxdmkQ==
X-Received: by 2002:a05:6820:4c86:b0:696:1262:2ac5 with SMTP id 006d021491bc7-69b78d325ccmr2861592eaf.2.1778704851365;
        Wed, 13 May 2026 13:40:51 -0700 (PDT)
X-Received: by 2002:a05:6820:4c86:b0:696:1262:2ac5 with SMTP id 006d021491bc7-69b78d325ccmr2861565eaf.2.1778704850754;
        Wed, 13 May 2026 13:40:50 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c76cc4sm10310127eaf.6.2026.05.13.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:40:50 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v5 0/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Wed, 13 May 2026 13:40:46 -0700
Message-ID: <20260513204048.2721843-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwMyBTYWx0ZWRfX1KGdQ1brv1Nw
 GQmt5Nix4cj7Ky5GTtoOPvk70vRTAS3VBtNrez5pQH9MViL/+PMgKLdb48iHYiKW8zhYlnuMv6q
 utJUSn2ZOZzAxq/3mtKaS80upIbwHISvr0rwY97cZXBx0+9mG91LowtBIlPbYoswi+SI1pwgX4V
 Fdx9eyVyh8IO+1oPOeM/E5EkYKRqaK7ZNrJ32J/nX+KWZCXlzgTXGSWhwOrt5bGtNjWOIchn0ma
 EkFxbfR8emWMk2vZ75893k1OayrVVvua4JTOc+KE+qcFNt7S2w7IeSZ1NvR6HGsPbOBWjDvr08W
 UNizZ7kb+5reO/DrUx5OiOmz59OmeQxWwRXDw8EudtwtI6Nit53KY+BdSsopEuQ0eL7pdBqLkQU
 HeIlYNijfGMWhsz5SMdsxfTFuCQsLnFATQCG9vGadZNtRK2W2haswodgTwlFFCnEMPqRz5YKv3Q
 BiHHdKOSLJbcLFSKcwQ==
X-Proofpoint-GUID: RWnbBHJVTzqMmh3UB1chqMSFaNOxlaFW
X-Proofpoint-ORIG-GUID: RWnbBHJVTzqMmh3UB1chqMSFaNOxlaFW
X-Authority-Analysis: v=2.4 cv=TfKmcxQh c=1 sm=1 tr=0 ts=6a04e1d4 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=SPPuj66wRu0voghISDgA:9 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 7516253A981
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
PLB, and spurious-retransmission events, but the new hash is not
propagated into the IPv6 ECMP path selection logic.  The cached
route is reused and fib6_select_path() is never re-invoked, so
the connection stays on the same ECMP path.

This series adds the two missing pieces:

1. __sk_dst_reset() alongside sk_rethink_txhash() so the cached dst
   is invalidated and the next transmit triggers a fresh route lookup.

2. fl6->mp_hash set from sk_txhash before each route lookup so
   fib6_select_path() picks a path based on the (potentially re-rolled)
   hash.  This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the flow
   keys which must not be overridden.

Patch 1 is the kernel change; patch 2 adds selftests covering SYN
rehash, SYN/ACK rehash, midstream RTO rehash, midstream ACK rehash
(spurious retransmission), PLB rehash, a policy 1 negative test,
a flowlabel leak regression test, and two dst rebuild consistency
tests (normal and syncookie) verifying that natural route
invalidation does not cause unintended path changes.

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

 net/ipv4/tcp_input.c                       |   6 +-
 net/ipv4/tcp_plb.c                         |   7 +-
 net/ipv4/tcp_timer.c                       |   4 +
 net/ipv6/af_inet6.c                        |   3 +
 net/ipv6/inet6_connection_sock.c           |   6 +
 net/ipv6/syncookies.c                      |   3 +
 net/ipv6/tcp_ipv6.c                        |  13 +-
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 861 +++++++++++++++++++++
 10 files changed, 900 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

--
2.53.0-Meta


