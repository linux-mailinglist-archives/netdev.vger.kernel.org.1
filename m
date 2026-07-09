Return-Path: <netdev+bounces-306285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fbFdGIq2T2qhnAIAu9opvQ
	(envelope-from <netdev+bounces-306285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB8732869
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:56:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fDEjpC7t;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306285-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 636F630B6110
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2F9387363;
	Thu,  9 Jul 2026 14:49:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB53469E0
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:49:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608556; cv=none; b=mtJjEQZlxI3VU0lVxc3dYiNilfKDcjvpnX1Txy9i2vnIPZYtRzQ5I04vy/Hb7CNgc5HCSZLwD+fknNHfn+HPkk119esqEWoSRg3omorGEYX4Qa86OTj/aSLE6htAvibbnmDO23i7I/QWYvJKsbomaIcqiMOZ4Sn+DiYomjaLQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608556; c=relaxed/simple;
	bh=XTfXLtRELTOMtjURz4kpMJiy23PUAH9vPIKBBJZfsVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnTuCH+XIRG8fKOOikn6xd8isfgg9UY5ntikJJ63fVaB+EicUF+J7XHmA0L0DiaWq5/YuSwboIm3n8/xThXFgPcEe1xOve3dpwPaTS4+WOpl3aSy7EtDZ4lX6fMrvbP/r4gaStqwMXiNU4m4RA8McnbffJYjshr/zvdxZ7LGNg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDEjpC7t; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so11828645e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608553; x=1784213353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkvKBoxtJ+UbxgZKdRff8ZWtf2aZi2+TWq6ySEYlnTY=;
        b=fDEjpC7tsS1Sf/iBfp2HLozxsFOMOFuf3VGJgYL27izmQFQEYInj8Td6guRQpg80o/
         8WcbWphlWcfxrUaIhax9dAHoaxlaOlqBqyYXPrhjCpOj7c9a2Ltjs5D9dNIclkycI9Od
         FdHPqivd1udLDuStts8wGIfJYf9MxE+JtGlK77zCrjS850q4koo2bYgB7UQ3N59fxtr/
         odbQP/5juisot/NzfMnHcjeNfFN4vkoPsh59oqYKdIlERCKw9dHmtYApJq+29asH55nE
         UuMjhjDmP9WcYhH8w5T7ONuJIBAmjobx17xXy0VP/vkLeUOL1lDrlx2wnICbngPMqt4S
         rSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608553; x=1784213353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkvKBoxtJ+UbxgZKdRff8ZWtf2aZi2+TWq6ySEYlnTY=;
        b=Z79GHhW/4Rhft95yH8Zhlyw7o0VCihKCrEDACbkbOI4fIKdiTcbWUQbbL4iPdPM1jn
         LaHMOI4jj1NQnfafM/L35/n7gbXnczgFF7sHf42iSDkVlVSXliLG94Ns+17DcPC1vPTG
         Y2NseAzo38w0R18Q0mk9JHgx1gyoNWJjI5Xu4yD8djOxliMsGcrVnYVl9jq90LYDrwIg
         om8CMkrVx5OFdRQnkHCKvEwTtpJL6H7UcTyJbgOyXwCJGVSUcPJBQG3Lvr2qr+33Jzzq
         +MfcIIq4nwKshKHO8za/pgBofQSTk0eE/xe593cPgC/XY8bNky2+OS4/3Pr5AJW8nrXV
         KGNA==
X-Forwarded-Encrypted: i=1; AHgh+RqzpRvf6R3a4kPnaO99kSp+l+MSrqPY9e6IQ6ykpoZMkiGAFKtQfHffFognirz6v15idySDT5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbV4qjOCl7IOM0i0GHjanEywD998LqkK/rzS16RZ1Nxw0UgTZs
	Eg1boiMaPTU3mYizJrSdw8d+7oxOB+B/wgbmFeGOc1wUrFttBCn9C7U5
X-Gm-Gg: AfdE7ckaVuykCAA1vTxuRQrLX8P6WJ7DReX1NRpT7VIWz/AapDLOi0Hg88guCsVeYFC
	bKcTHuVqXd9bDUMJT/hGZjv/u9YUHQLT6mWmA0Y2kynteHpE+qxzz+1Et9HM5q/4Sc3jYAKVCot
	Gg1Onf1oWcKq2chUNUKHPixOC16vGPFb00nGapzObaLMR99P0+d48oc93f4qiYTyYfYB5TZJsGX
	s1LMwtviu6ooEeCf8V1zC9bYXvoJWKCfq42e+vf8W3cnlTXiXqbrm2sf2uDwvtQwWcWv4Fyj2he
	uoi+rSogolG3scohFQQb3sTRqntdcz5aRRf4u3SH47LxAM1doRJ5hoinjfOkprB1n57WTBh6Zz/
	ogFftX+0Cn+jmtW7LlyLJ+PvMcnbytyLcgK58UH52rcfKEouwDooxXGVgtRTsZJHONGRwbRQeIa
	HQkntoYTb6ChXp8IBJemaMDO47t54iAvEfgsjEOhSQw1K3tUvX6M6f1UqKiHK++oJ7fANe
X-Received: by 2002:a05:600c:c1c8:10b0:493:c310:4106 with SMTP id 5b1f17b1804b1-493e68a1a8amr58115315e9.35.1783608552637;
        Thu, 09 Jul 2026 07:49:12 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:12 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 0/5] bpf: add icmp_send kfunc
Date: Thu,  9 Jul 2026 14:48:55 +0000
Message-Id: <20260709144900.245904-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306285-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BDB8732869

Hello,

This is v11 of adding the icmp_send kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target. Applications can receive early feedback
that something went wrong during the TCP handshake.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a program can call this function N
times, thus send N ICMP unreach control messages and that the program
can return from the BPF filter with pass leading to a potential
confusing situation where the TCP connection was established while the
client received ICMP_DEST_UNREACH messages.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

v4 updates:
- prevent the kfunc to be called recursively and add a test (thanks to
  Martin).
- do not fetch dst route when unnecessary (thanks to Martin).
- extend the test for IPv6 (thanks to Martin).
- use SK_DROP in examples and use non blocking sockets for testing
  (thanks to Martin).
- test when the kfunc returns -EINVAL (thanks to Jordan).
- add the kfunc to bpf_kfunc_set_skb as suggested by Alexei.
- guard the IPv4 parts with IS_ENABLED(CONFIG_INET).
- fix a wrong initial value for client_fd (thanks to Yonghong).
- add documentation to the kfunc.
- to Jordan: I couldn't include <linux/icmp.h> because of redefines from
  <network_helpers.h>.

v5 updates:
- kfunc name is now icmp_send and takes the control message type as
  parameter for future potential extension (daniel)
- drop the net patches to route packet since now the kfunc is limited to
  cgroup_skb and tc progs (daniel & martin)
- linearize skb headers (sashiko)
- zero SKB control block (sashiko)
- bind to port 0 instead of fixed port (sashiko)
- poll to wait for POLLERR event (sashiko)
- do not use ASSERT_EQ in CMSG_NXTHDR loop (sashiko)
- fix comment about byte order (sashiko)
- fix endianness IP address issue (sashiko)
- add forgotten cleanup_cgroup_environment (sashiko)
- let packets pass in recursion test (sashiko)
- clarify evaluation order for recursion test (sashiko)

v6 updates (all from sashiko):
- bring back the net patches to route packet since tc ingress needs it.
- rename the ip_route_reply helpers from fetch to fill.
- call pskb_network_may_pull on the cloned pkt.
- check explicitly that we received one and only one ICMP err ctrl msg.

v7 updates:
- use consume_skb on success path (stanislav)
- replace recursion protection with CPU_ARRAY by checking the nature of
  the sk (daniel, offline)
- use reverse xmas tree in read_icmp_errqueue (jordan)
- use ASSERT_OK_FD instead of ASSERT_GE whenever possible (jordan)
- add a test for tc (jordan)
- better filtering from host cgroup test progs (sashiko)

v8 updates:
- mostly a resend as it's been sitting as "New" in the queue for almost
  one month, fixed a few nits.
- on new bpf_icmp_send kfunc cgroup_skb test (patch 4/7):
  - guard a close fd with fd >= 0 (jordan)
  - use ASSERT_OK_FD instead of ASSERT_GE (jordan)
  - fixed comment style (sashiko)
- on recursion test (patch 7/7):
  - guard a close fd with fd >= 0 (jordan)
  - fixed comments style (sashiko)
  - filter bpf prog on pid and ICMP message types (sashiko)

v9 updates:
- first, there was a v8.5 that I discussed here[^2] with Emil
  Tsalapatis. I tried once again to make tc work but the ai review found
  something fundamentally wrong. This version removes the tc support for
  now and focuses on cgroup_skb.
- use helper get_socket_local_port instead of getsockname (sashiko)
- use if_nametoindex("lo") instead of value 1 (bpf-ci)
- fix IPV6_RECVERR appearance before IPv6 patch (bpf-ci)
- precise that 0 on success mean icmp_send was called but it was just an
  attempt since this function does not return anything (sashiko)
- explicitly consider ICMP_FRAG_NEEDED as invalid in bpf_icmp_send as
  it would miss the next-hop MTU info. Also test it. (sashiko)
- test for max_code + 1 for invalid (sashiko)
- add review-by tags from Jordan and Emil but remove it on the main
  patch as I have significantly changed it.
- check for rec_count in recursion test (sashiko)
- re-order setup_cgroup_environmment in test (sashiko)
- reset kfunc_ret on every test run (sashiko)
- check for skb route for icmp_send as the function would quietly fail
  and add a test (sashiko)

v10 updates:
- guard against skbs with metadata_dst before calling icmpv6_send
  (sashiko)
- add more review-by tags from Emil and Jordan.

v11 updates:
- move !skb_valid_dst(skb) check to both ipv4 and ipv6 (daniel)

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lore.kernel.org/bpf/ajvDRCw8cPqXAqQq@gmail.com/

Link to v10: https://lore.kernel.org/bpf/20260625110321.28236-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test
  selftests/bpf: add bpf_icmp_send no route test

 net/core/filter.c                             |  90 ++++++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 292 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 123 ++++++++
 3 files changed, 505 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1


