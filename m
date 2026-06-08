Return-Path: <netdev+bounces-296661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pv9VKVv/JmqcpQIAu9opvQ
	(envelope-from <netdev+bounces-296661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0F16595B3
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:43:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xy9b5SKC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296661-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296661-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A023062F68
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C63BFE34;
	Mon,  8 Jun 2026 16:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14913C76BB
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936508; cv=none; b=TK1z6Py8vFOCTu9rO/bRfshvQ84FIsYDq+3jBC4JZxyRpHsvCH3TzZziE2EfINpfVariGTe9gySMIRWKztDomTq2HXIn0kMgxv13mRkHQWnbGeWP2N3kJu6PCeqTGrbM9CpJiiF0iWLRJ7FKcdZ0+cyfPCEjgY4/k37Cm30YwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936508; c=relaxed/simple;
	bh=jN1np271Ao4AkRlwEErMav6w1EbKzf6/LLnCRZAAMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6wYXKhNN/3EPOakJT/2o9haujmRUuTOcMICfM1g1R7UDi1H4G3f6zeFvfo7cKm4kWRNPXIQQigdX9/H90Z83hggMeYF12ezx4SM8dFa3pmQeXU8DQ4EpGl15lpRC8VIdjeu3k5jdhqjx1q5mITtaMYaByOfiwWMgtMvcs64GfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy9b5SKC; arc=none smtp.client-ip=209.85.128.65
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b8adf813so4693485e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780936505; x=1781541305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXDjqEbwtW2BwTfqI4ufJTWFGFA7tEvSW3qEJJY8Oek=;
        b=Xy9b5SKCrJ1RzoOg5+5k2K/P6GFRrF3BJkDxaSS00Igq9pNaMIqBH7tPU2EgEjiydN
         NOwGvLdTEOqhxgo+ebfakcD4DoHVBX78rnUxa4qaSWKcea39j52CUENYcmk/j7bwmgO0
         Mt/TiWzbkpn2eunFVXr4AEyXt9jL9OTsDH20nOMQZ42ySlsGZnbCHrffmWG3dtMHx1Uv
         UBGv1/SHFCaVq/flXnXpJ8ndkV0za+T9FOU7c6h+dd2dc/d5omwOTJvWBWFJwTg3u+Pu
         QBj90fVr4IDkFRiqW2k5PTkkoYS1iXgBQkAzIrqBHfzHV0NtL/8OP0ObANUAOUvXi+/E
         1UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780936505; x=1781541305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXDjqEbwtW2BwTfqI4ufJTWFGFA7tEvSW3qEJJY8Oek=;
        b=ZCk3kLeGY64RwZ8WmpJN9T+HsnhAJuRkIHO3/MuqvU4O1otz4ttERBH7xpp0tahilE
         lov2epbrJDMnbX3w3nf517NKrUcsJagmxdNH52OPB7XfhOvQEV+2JcPQR102ZkCEJ0MP
         eMwO439vfUKWRKD55RmPNw24xAxVluEx7jJFKjhk0puz7AvBmdsV57XF70mCtorLo6UL
         z1BN+GNL69sJZ9wZX6h27dEC7JAIg8HTJL+uocMKYmWSiBzsud/CB23bfiFyIFq2Za4q
         WLVRd+ulxy3iu6X+HGDLipNQ38A0ulLZEfureMpUhL1Ss5Kc8+MowXenPS3QrlMvj2BT
         hdGA==
X-Gm-Message-State: AOJu0YwC9/xSkmo/HtRDbtbvd2tAK6xT+/M2JUOdtjfa+ofZT1YU6U73
	q1DNScjduE0MjTjtXbP7zOUXvYl9B3IJ9eQCLMFKos3G8PRhs8mfNL0e8gvflZZ6G1c=
X-Gm-Gg: Acq92OEuCo99Lt/H+fR/rzrSa2yv/jZzlMcLR8yBCPdklrDdGCjUbAwhA5b/vUTzYBt
	dXE1rPtNp8BkVz+ri+CUIjg6UxftACL1mhS+8iOXZhtG16EXrPn6ikKpt0JevDPs/NvLrIz7Pn/
	7cnwunyTTZZFjXdahy1GMxNgxNNSSXftlzW5xKBFwdnDO5WuRolmJx9Mh9Mk7TtjlFnWiDsEtgA
	TrB8J2zATmiMqmQ5XNZL4ki+w/K86O2xaHaNQlLYWV1TWtETqKX0CxxeywWfbm90d1poG27Q+Pc
	ONgqyNy8DzlHWl7G6Xa8NkNGxHkgKxNrcoHmjX8qbpXyFH4dr1IueTuHgiVrX9D2VMteC+tKN6/
	IGOzRwVEA6tGfsIQaPhIGF7L4Iv/Rdogw/xROv4fXM6J+aM8xG11/Pv3HqBp3GIpnLcGqgM3Y4L
	d/D7ppcMshSJT8qlfdNaXLi/C0vmfssuF18fNhrQBR5Q==
X-Received: by 2002:a05:600c:8b0c:b0:490:6e0f:29f4 with SMTP id 5b1f17b1804b1-490c260d263mr108067065e9.3.1780936505011;
        Mon, 08 Jun 2026 09:35:05 -0700 (PDT)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm404805355e9.0.2026.06.08.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:35:04 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
Date: Mon,  8 Jun 2026 18:33:17 +0200
Message-ID: <20260608130755.5626-1-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296661-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[big_tcp.sh:url,vger.kernel.org:from_smtp,msg_zerocopy.sh:url,fastmail.im:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D0F16595B3

This series adds support for sending TCP jumbograms over MTUs above 65535,
and adds support for setting such MTUs on veth devices.

The TCP stack is already capable of receiving jumbograms and (up until
recently) sending GSO-jumbograms that get segmented before exiting the
host. However, the TCP stack doesn't support sending regular jumbograms
over high MTUs as described in RFC2675. Specifically, the TCP stack doesn't
support an MSS greater than 65535.

No device currently supports setting an MTU greater than 65535 but there
are some devices that could benefit from higher MTUs and that can
theoretically support it. For example, IPoIB in connected-mode can support
MTUs up to 2^31. Virtual devices such as veth have no physical limitations
and therefore could also support such MTUs.

This series only adds support for setting high MTUs on veth devices, with
support for other devices being delegated to future patch series. Allowing
jumbograms to pass through veth devices is useful for testing jumbogram
functionality, and also increases throughput when compared to BIG TCP (see
the benchmark numbers below).

In addition to removing the upper limit on veth MTUs, This series adds the
missing pieces that allow the TCP stack to send TCP jumbograms. This
includes a bit of code removed recently by Alice's patch series [1]. Most
of the patches in this series are rather trivial. The main problem
addressed by this series is that the TCP stack conflates the TSO segment
length with the MSS, but the TSO segment length is a 16-bit integer, which
doesn't allow for MSS > 65535. This series decouples them.

Running iperf over veth on an Intel Core i9-12900K CPU shows a 5%
improvement in throughput.

Commands:
iperf3 -s
iperf3 -c -l 500KiB ${SERVER_IP}%veth0

MTU=524280, gso disabled:
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  24.8 GBytes   213 Gbits/sec
[  5]   1.00-2.00   sec  25.5 GBytes   219 Gbits/sec
[  5]   2.00-3.00   sec  26.0 GBytes   223 Gbits/sec
[  5]   3.00-4.00   sec  25.8 GBytes   222 Gbits/sec
[  5]   4.00-5.00   sec  25.8 GBytes   221 Gbits/sec
[  5]   5.00-6.00   sec  25.4 GBytes   218 Gbits/sec
[  5]   6.00-7.00   sec  25.3 GBytes   217 Gbits/sec
[  5]   7.00-8.00   sec  26.1 GBytes   224 Gbits/sec
[  5]   8.00-9.00   sec  25.9 GBytes   223 Gbits/sec
[  5]   9.00-10.00  sec  25.6 GBytes   220 Gbits/sec
[  5]  10.00-10.00  sec  28.3 MBytes   154 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec   256 GBytes   220 Gbits/sec

MTU=1500, gso_max_size=524280:
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  24.1 GBytes   207 Gbits/sec
[  5]   1.00-2.00   sec  24.1 GBytes   207 Gbits/sec
[  5]   2.00-3.00   sec  24.6 GBytes   211 Gbits/sec
[  5]   3.00-4.00   sec  24.4 GBytes   209 Gbits/sec
[  5]   4.00-5.00   sec  24.5 GBytes   210 Gbits/sec
[  5]   5.00-6.00   sec  24.3 GBytes   209 Gbits/sec
[  5]   6.00-7.00   sec  24.6 GBytes   211 Gbits/sec
[  5]   7.00-8.00   sec  24.0 GBytes   206 Gbits/sec
[  5]   8.00-9.00   sec  23.9 GBytes   205 Gbits/sec
[  5]   9.00-10.00  sec  24.1 GBytes   207 Gbits/sec
[  5]  10.00-10.00  sec  7.81 MBytes   120 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec   243 GBytes   208 Gbits/sec

[1] 20260205133925.526371-1-alice.kernel@fastmail.im (full link was blocked by gmail)

Mariusz Klimek (10):
  ipv6: do not fragment packets into jumbograms
  ipv6: allow route exceptions with MTUs above 65535
  ipv6: add jumbo payload option to non-gso jumbograms
  tcp: decouple TSO segment length from MSS
  tcp: split jumbograms with urgent pointer correctly
  tcp: set MSS correctly for PMTU above 65535
  veth: raise the max MTU above 65535
  selftests/net: test sending TCP jumbograms over veth
  selftests/net: add test cases with MTU above 65535 to big_tcp.sh
  selftests/net: add jumbogram test case to msg_zerocopy.sh

 drivers/net/veth.c                          |   8 +-
 include/linux/ipv6.h                        |   6 +
 include/net/ip6_route.h                     |   5 +-
 include/net/ipv6.h                          |  11 +
 include/net/tcp.h                           |  12 +-
 net/ipv4/tcp.c                              |  12 +-
 net/ipv4/tcp_output.c                       |  84 +++--
 net/ipv4/tcp_timer.c                        |   4 +-
 net/ipv6/ip6_output.c                       |  24 +-
 net/ipv6/route.c                            |   2 +-
 tools/testing/selftests/net/Makefile        |   3 +
 tools/testing/selftests/net/big_tcp.sh      |  24 +-
 tools/testing/selftests/net/jumbogram.bpf.c |  36 ++
 tools/testing/selftests/net/jumbogram.sh    | 380 ++++++++++++++++++++
 tools/testing/selftests/net/jumbogram_rx.c  | 199 ++++++++++
 tools/testing/selftests/net/jumbogram_tx.c  | 139 +++++++
 tools/testing/selftests/net/msg_zerocopy.c  |   3 +-
 tools/testing/selftests/net/msg_zerocopy.sh |   3 +-
 18 files changed, 897 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/net/jumbogram.bpf.c
 create mode 100755 tools/testing/selftests/net/jumbogram.sh
 create mode 100644 tools/testing/selftests/net/jumbogram_rx.c
 create mode 100644 tools/testing/selftests/net/jumbogram_tx.c

-- 
2.47.3


