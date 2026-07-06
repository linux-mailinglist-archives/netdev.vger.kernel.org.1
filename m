Return-Path: <netdev+bounces-304936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNxhC52CS2qMSgEAu9opvQ
	(envelope-from <netdev+bounces-304936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:25:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7870F1FD
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z7e4My/b";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304936-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304936-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F6A30E571B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846D43B6F8;
	Mon,  6 Jul 2026 09:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5343B6C9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:35:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330547; cv=none; b=J8NXVKWiZv9QTjRP+fvgJDGMOvC3WCW66rDqK+2HSTa63Ew0iTvocUlFqNmaPs3t8vIEH9YV7nGoHFXUkQ+CMGjGDblUlEn4nHID9Cy9YqwE8Sk4rOrQfbP8gP2RGnZ68OgyI5NkUvAKUUA0j0nqPkxHEmZ+K/kt9YythKrI80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330547; c=relaxed/simple;
	bh=5A1aBFaM2hbpyB0BRTQF0LrTf8c2s3q3kcvapCMe3Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjnYdm3RgCLXygY6hsS+MrjICuOZzWVWPXtgxLqvEnwSFBy5VJPlqETL2vLWeo0t2+ciHjs6I4bkRH4WnfqdKBSxF144scXmN3haoU8yGAmj6k8k++oKzFNZxDrbhiv4Xy+VEXwLG3kci1xrZ/QRACQ8kjdqlo0Ia734JRIWz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7e4My/b; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c55d5c7aso26857665e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330542; x=1783935342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVSBxfRrkS7bnz+659UBlFEvEo0XugvpTzUH02aOh1I=;
        b=Z7e4My/byo2Y6e06DgJaXqkb7RKERqA//nE3IqFNp3oy0PxHuL1Sr3/BPqLk11Akf7
         jW76BHRrzTzEwX63rLorpgfbbRsbhLrkTxvPK5hJFCoDrWklzmsMFFvFk/99LuqKZRFD
         eN9uqmIx4b2g/FHsEPqayiQEyL1Dga3WDwgTcyBcy4YBVr9QkNsareMlYTCYsLG5kPbv
         QjnqVXDPcufFY87T/ElorewEGz7fkE830RKVzAD2tB6nUb1uOyla+cDmd2Nw3NkdU0Rq
         tOOViRX/svG56kV7vyitwlEcXJZoPa6Rjij3/7kwdA87M9KPmqAqjJLDpGMSjSjgHKN1
         /gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330542; x=1783935342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVSBxfRrkS7bnz+659UBlFEvEo0XugvpTzUH02aOh1I=;
        b=WujdJgO6tBKtBcrbx00CDCU3z9oIVplTIMitraCS4JAKpqlpiKKiImL3+6mITnwoh9
         G0BfAl1JxSnqQ/RaZGkoxwRE7TxeeraDihtSnW49cigEBWrvSgcD5a3rrUiawB7H8z9Z
         IOda6RLQc4uSfEPqWIS1J+2FHcgegRA33+3x0hAFS3t6dy8VROfLhHpwr+g3cP0qIn0c
         9UiqorMQz1BR6Vo9jXO4TuD+1iBUiHxbFa5QJ85aWudSr8Jl8Nxd/K1NML3OsUDcdZv5
         gK9i79LTTrBw81VoC1+pvx4TsD/jUnBxPA8yDk2ntvWRdkKrMopN5z9VNcNaWzbIig2S
         c3iA==
X-Forwarded-Encrypted: i=1; AHgh+Ro96FmvXsnjELgxxpYgVuzeWpMmScwGamAwn9EFjIlcHPXb14fC61roL+UbQT1e48OQPPhOuJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywig0qFHHrAUsQtmHzUsYJ7qxhm8/VBX1w17AYr9W0Hv+5CKx7p
	ajfuErLKch0v6VzrLnwkoJTKM9vVqWCfb51pBIbxqpCgj4GQLsw25sNm
X-Gm-Gg: AfdE7cmGUpdmUDa4Nj36JpT+d1/jzAEWXLtbCClBVRNeJrI1FVOPKuudNgrIHnqUFH2
	Wngu5F+bIMgoON6IIz6443SIugTCJEYc9LFV9+i2P/a8cBVUTtnJwU30Uq9dlfz45jlFTsmwZ18
	A2Oy2ZTOQQ3EyhOGm/aMDWQw+WBkZ4gA9BE+QLOBFLF+LYzMi5ZGA0A47HDw6FqxVVb0pIaBSQl
	RH/U/S88GmNvBX7kyhTnBxDAsJJz86Aq6DqMwQnueKPcJv16NT9RGvrXBd0MsqBh5zhpDa+Dec8
	bbpVxzLaFjaH7OU64dGxPLei+yXpdOZ3xO4lrJ+bSQgRKGBNBHnunYr91rxgexM5n6xmLS+dmYm
	VYFDmN257/UontzZ3Uywb6wxnmnrYuZtDb2K6suK8NkfAQBEoG2hPPYSjoooGRj036BtXNnzwRU
	hIqff+XhdZZBatngsw
X-Received: by 2002:a05:600c:608f:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493d11d21b2mr109853165e9.2.1783330541907;
        Mon, 06 Jul 2026 02:35:41 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:41 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 0/6] Introduce bpf_ksock
Date: Mon,  6 Jul 2026 09:35:19 +0000
Message-Id: <20260706093525.13030-1-mahe.tardy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-304936-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahe.tardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com,vger.kernel.org];
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
X-Rspamd-Queue-Id: 91D7870F1FD

This patch series introduces bpf_ksock, a set of BPF kfuncs to allow BPF
programs to create UDP sockets and send data. This provides a mechanism
for BPF LSM progs to emit telemetry over UDP independently of userspace.

The main use case is to be able to completely dispense with
agents/daemons for BPF programs after startup. In the case of
Isovalent's Tetragon, the idea would be to be able to emit security
alerts or export data from BPF even when the agent is down. For meta,
according to Liam presentation[^2], this could replace logging via
ringbuffers which created cross-binary versioning issues.

The implementation follows the established kfunc lifecycle pattern
(create/acquire/release with refcounting, kptr map storage, dtor
registration), for example used by the network bpf_crypto kfuncs.

For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
during his presentation of BpfJailer[^2]. Then it was also discussed
during LSF/MM/BPF 2026 in Zagreb.

A first version of it, called bpf_netpoll was submitted to the mailing
list but eventually NACKED by Jakub Kicinski[^3]. The discussion
eventually reached an agreement that we should use regular kernel
sockets if we want to do network from BPF programs[^4]. This was
fundamentally more complex to implement but here is a first proposition
of how it could look like after several automated reviews using sashiko.

For more details, here are some of the main adjustements I had to make
during the preparation of these patches:

Initially, the goal was to register the ksock_kfunc_set with
BPF_PROG_TYPE_UNSPEC to allow send to be called from any programs. This
introduces significant challenges (but might be doable). The limitation
is still that the programs should be able to sleep but combining this
with bpf workqueue allows to send from virtually anywhere. However, not
by-passing LSM socket hooks make it impossible to be called from the
workqueue context as the credential of the initial caller would not be
preserved. Also, it would be easy for users to shoot themselves in the
foot and attach a program that sends asynchronously over the network on
a network hook. So the idea for now is to restrict the ksock_kfunc_set
(which is acquire, release and send) to SYSCALL and LSM to make it
simpler. Also to make the patch set easier to start with, the sockets
are restricted to UDP.

v0 updates (from local sashiko iterations):
- do not bypass the LSM and thus add send re-enter protection;
- limit the number of socket creation through the kfunc per ns;
- copy the arg values to avoid TOCTOU race since kfunc can sleep;
- prevent calling bpf_ksock_create from workqueue with improper creds.

[^1]: https://lwn.net/Articles/1022034/
[^2]: https://lpc.events/event/19/contributions/2159/
[^3]: https://lore.kernel.org/bpf/20260511182019.69ebc7c6@kernel.org/
[^4]: https://lore.kernel.org/bpf/CAPhsuW71P58XqsXrLbqsShgnozg66TA=T_c=fYrqSSzvL1tTWA@mail.gmail.com/

Mahe Tardy (6):
  net: Add __sys_connect_socket() helper
  bpf: Add ksock kfuncs
  selftests/bpf: Add ksock kfunc test
  selftests/bpf: Add ksock LSM recursion test
  selftests/bpf: Add ksock net ns quota tests
  selftests/bpf: Add ksock test for async callback guard

 Documentation/admin-guide/sysctl/net.rst      |  12 +
 include/linux/bpf_ksock.h                     |  50 ++
 include/linux/socket.h                        |   2 +
 kernel/bpf/verifier.c                         |   3 +
 net/core/Makefile                             |   3 +
 net/core/bpf_ksock.c                          | 516 ++++++++++++++++++
 net/core/sysctl_net_core.c                    |  11 +
 net/socket.c                                  |  32 +-
 .../testing/selftests/bpf/prog_tests/ksock.c  | 239 ++++++++
 .../selftests/bpf/prog_tests/ksock_quota.c    | 139 +++++
 .../selftests/bpf/prog_tests/ksock_wq.c       |  34 ++
 .../testing/selftests/bpf/progs/ksock_basic.c |  37 ++
 .../selftests/bpf/progs/ksock_common.h        | 110 ++++
 .../testing/selftests/bpf/progs/ksock_quota.c | 167 ++++++
 .../selftests/bpf/progs/ksock_recursion.c     |  69 +++
 tools/testing/selftests/bpf/progs/ksock_wq.c  |  62 +++
 16 files changed, 1472 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/bpf_ksock.h
 create mode 100644 net/core/bpf_ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_quota.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_wq.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_quota.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_wq.c

--
2.34.1


