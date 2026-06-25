Return-Path: <netdev+bounces-301938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lh3vFQkLPWpCwQgAu9opvQ
	(envelope-from <netdev+bounces-301938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D86C4F19
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s41UH2vV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301938-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301938-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550F0302494D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4E3AF67C;
	Thu, 25 Jun 2026 11:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D13AC0C1
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:03:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385413; cv=none; b=npF1P+k5luC1DEQVkG8UArE2xJiO27awTu6IjT2Nu1XdT9qiZPFgpxSzYGD60Pih0KmR25TF1eEf1z/HI0DwN3MwWQ3iYM7UJUqscS6HLtPG6HucofX1k57U7IZm6A9V7sfaoM4kfonujZvge7c24m2vdW3NaWHavPw5/sr5Hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385413; c=relaxed/simple;
	bh=M6XVmr9mr5hJbI6edN8tmTU2+YZgewGU2AkbPE+1Wxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jP+PL/fFKzox073haKMkOBLDT1yu7WGBH9lsvug06eQqo8tLbLKu10p0/HkLEx+GYnIPyRD/wic/X7vo4QAtZixAXUG089WJMowvEd0gA8/UTPkhSk5fcyCbFwwLRuR+0v6MScPR4ee6JGiO0PJUwAhbTOwRUFjOrLbxgKTsEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s41UH2vV; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49222b6e871so13368985e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385409; x=1782990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6M3A8+RJOXUSQAAq5YZ2iZRz2yh0XwXW9SyNNKOE0I=;
        b=s41UH2vVMAz8aB5JuhtVv5YMRJ602VGXErVNc2xxx/Kahu14vt7FiTGXmC8ps3/nWM
         4rqC6VT2KZcQtvsgee3u8+sQvsO+aYKI81O9wS4HogGcQUvZDyVXz76wf0+5gxb9Bi5k
         YU/avjOBAtNW/NI6Kc2Zo2W+SM0jS6e9v3fHd6gE+P9czlIZQe7Hm/KGAiz1D3IGYTsG
         wFNNnOIi7kFz91rx14Xky/ADiVTW+mS4XC6mPB2Ux9QnPksYZEPfZ6VhaCtw/BnrG74r
         Yx+tYfzzyMssRlTjFeog/zy6RssyqKvRSqNRietdWK6JGCnJPOgrE2Za+k4VIsLvFzlg
         BnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385409; x=1782990209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6M3A8+RJOXUSQAAq5YZ2iZRz2yh0XwXW9SyNNKOE0I=;
        b=oiASiu6oKjnwR2YWaXiEd4JBU9XnquvfUh/leJI4PAa/RCR25b2+A3TmabIkLpjpQj
         9Uv4ImOwRI6oOzqNs/kpvRhSEg+gp3fTgioEeBEIYg9jJtcVjT1U1+e6zLsWHP0PjCjI
         MZP+pPpMXU7bwiHL4aGjifRcDTHDhuWkd6gnWyn6uY/TtXRInxnD78Ww7FSlsrvCdJzM
         HMxmen89fDOpT5+KGoNFm0JMxp8dQWlyBXZ97VXUA7QwDUpZ/zOAoe4X41uO4UTqF/AI
         j/YMiuirfs2jy1XIHZa/c15d7cJ96nZlA5mb6QYE90jmJtNNR+vS/QLQ0CwbqJonwmoH
         otaA==
X-Forwarded-Encrypted: i=1; AFNElJ8Ejt7xSTuoHyZZXvANTGgkXHiTisxNxFxUXmeRBwLmhWu2xCyAm8PnZDA3XxZKIMdD/Qbs/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtpprKdeujHNith4ffpFWxMzh1ydwfhrp0++YkCNRxGY2xXP9
	AQT0yi4gLmEnwNOGvC1ptCOPzNEkofhSnj0OvZQDJ0o+DmFrAHgY6dHK
X-Gm-Gg: AfdE7cnHCQnlJDAfgJtd32+CWBkzi5If8Wg0gD6zH1kRMfcA2wYXoQnwLTvoFZdkoje
	KUo3hina0/XSVzzDGBcO/fzxk5+D0xQLybP7udJyoMf8jHJcu9Ltd/Z4c6gaaLYyOAW3TiulJki
	XQqHMfrfCrqYS566kAljZJ+VJzLmGs9FhndHz0IDwrF9d3v1RQbFsYckZxlaimoTPgYEvaXRmRb
	OY6wz0eRgnUvzCayZKjIzy1QU1LwQYgtGAwKr1WIPVm/U5VUyUkqHme6x7qlw9i7sc4wMc2WYUD
	0X+c4CQmD7eJw3Qq8ona+mmXzXXU+8fyMNUXjeKuBQeYERFk5VZ/mIQVgbHHueq8BGIwu35jBrg
	nwIa5phiHIahTxCra7e9m9URKN59YGCrphM3OLnd71TE+wDWlPC6LkIFuxHIRFi7goD105yEuP6
	9/wEUSDWu9gGkRzbqB
X-Received: by 2002:a05:600c:1c05:b0:490:ea8a:32da with SMTP id 5b1f17b1804b1-4926689ee78mr24829615e9.26.1782385408276;
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:27 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 0/5] bpf: add icmp_send kfunc
Date: Thu, 25 Jun 2026 11:03:16 +0000
Message-Id: <20260625110321.28236-1-mahe.tardy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301938-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahe.tardy@gmail.com,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,vger.kernel.org,google.com,redhat.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lwn.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A39D86C4F19

Hello,

This is v10 of adding the icmp_send kfunc, as suggested during
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

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lore.kernel.org/bpf/ajvDRCw8cPqXAqQq@gmail.com/

Link to v9: https://lore.kernel.org/bpf/20260624185554.362555-1-mahe.tardy@gmail.com/

Mahe Tardy (5):
  bpf: add bpf_icmp_send kfunc
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
  selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests
  selftests/bpf: add bpf_icmp_send recursion test
  selftests/bpf: add bpf_icmp_send no route test

 net/core/filter.c                             |  95 +++++++
 .../bpf/prog_tests/icmp_send_kfunc.c          | 269 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 123 ++++++++
 3 files changed, 487 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send.c

--
2.34.1


