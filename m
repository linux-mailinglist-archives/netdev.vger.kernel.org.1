Return-Path: <netdev+bounces-298855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sR4BYGsLGq2VAQAu9opvQ
	(envelope-from <netdev+bounces-298855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6867D633
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IjSeLpfY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298855-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298855-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2289348645C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BC25A321;
	Sat, 13 Jun 2026 01:00:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859120ADF8
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312445; cv=none; b=shUuieuIA0ueNv8YNQ7p+EXD72tjvJL+GFP/K/yz5g69CN3O/vU7bsEbcuJc3M1crA92gETHIpgKFUSxwQhHfUdNNNBRoCqTSKuPzidGAeyBOcrzlnIdh6tgFPgIz+ioHTmghjpi+3c10D/9zt2GjapvakvjwKYRQkfczMzayRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312445; c=relaxed/simple;
	bh=JcOgNfYX5Fr+NIiNpGfDBLZGynCBhQ9Kevw5R9SUXOI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=id9Zi/VVinmPWkjZ3pIQK1BPpZSFTSylFQRdLTc/d/4ZQ33M+y+gY9LkgLLkZnrmvFRq01LKR5N+844+Z8dFhPQSrPrPv071kRs6Nbnu8Zz0IIAIlQJIuxJoecSui/HdrDWOZZunbKfaHWXzcWyqJBUfY6QQ2qHqFJGvTN0sFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjSeLpfY; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so25472245ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781312442; x=1781917242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfnHQTzprvfZIViqMRRKupB/GjOqKriHJyW+HN00hFg=;
        b=IjSeLpfY32buFZ58u0xA9jovQllopEI9dytbx8tDtAb7LkX1ajd48WvT/P8U2MxclI
         /80n/PLTcfrPa7ZEa9X32Rc3BxJp5V+e4pqQ+fzcKOBZeLZBxtwatYnWjqDz1NW8pX9k
         qjarmiykamtTTxLBjPsOUHRnaoQB1ptD8MHz8I+0MkRWwTWHFwrMqKAVpXbh1HMFEX8K
         x00WiBpPJ1TA1JhQAJ9vYU3GeRNkUHpIndD8oYMKvFkGu01YHBzhxXDvPcGCGc021uQK
         UYf6agJLkz2SEVoOX9kex2WjNRSMzLOIOgg6u4zyVgvnAnGI1HL5wFfH92Nyx74v3q4k
         F3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312442; x=1781917242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfnHQTzprvfZIViqMRRKupB/GjOqKriHJyW+HN00hFg=;
        b=jBXXU5yH5CbmmNVdBRuffQoUQyugWuFjMacgZ4wzdXfdMb0WYUpYmdHlkcsrYaEX9t
         Urx+m9WsR12zsUz9gVL01k379cuNKQdj69DYK4hX3ttjEzU2TIFLgWevmW4EMAZFDZu6
         pw2/3/h/PLpdkAIEzdp75b8cSXzCRaFmDIfSf8e+HWEPyg5wbf4qdrLmTHWwmrTZfsRv
         6AQ/Ww6nUjbkf31iRazeba8+T64z5b5D6pNjG/FhEn5La45OUg1+Px0K1x/zCutj+Ao/
         C0mzHjRGW4O/9oeHtvIKZPien88vcWeWMmwV7o2GEPUlAXLCp0dbSf9LxO35dgjDpVYj
         jgSw==
X-Forwarded-Encrypted: i=1; AFNElJ+1KDmuTcpwRh9m5YfYpEdQJV5g617P44Fi0UWp0cAkx+6iruyofFIfToQxy1HdOjgGZytgi1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlqr+BLRndhTnUKykYKe712XREr8BGet1AHk5iF+cWn/P6/Vp
	Fzl+GgtA0/B86Aaup3E5CGFT6m4hmyozVxEKjYLst/ChhWk9dBFfdNs02KpsiVDoY4ww391V57U
	N1CvwLQ==
X-Received: from plbjx8.prod.google.com ([2002:a17:903:1388:b0:2bc:c1af:322f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b47:b0:2c1:98b7:ecf3
 with SMTP id d9443c01a7336-2c41235e35cmr60019365ad.23.1781312441612; Fri, 12
 Jun 2026 18:00:41 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:59:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613010039.1362312-1-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuniyu@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298855-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACE6867D633

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

This series extends ethtool and adds BPF kfuncs to transparently
support HW timestamp on such a setup.

Patch 1 is pure net-next patch to advertise fake timestamping
capability on virtual interfaces (e.g. ipvlan, geneve, etc).

Patch 2 is misc cleanup.

Patch 3 & 4 add kfunc to proxy RX/TX hwtstamp.

Patch 5 is selftest to demonstrate how it works.

Note the test requires this iproute2 commit:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c9a9f12aa619288fd3d4e16bc4b3c73b655a4efe


Changes:
  v2:
    * Patch 3:
      * Remove __packed and use unnamed bit-field in struct bpf_hwtstamp (Alexei Starovoitov)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 4
      * Remove __packed and use unnamed bit-field in struct bpf_tx_tstamp_cmpl (Alexei Starovoitov)
      * Check !skb_at_tc_ingress() in bpf_skb_complete_tx_tstamp() (Sashiko)
      * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)

    * Patch 5
      * Use scm_timestamping64 (Sashiko)
      * Correct saw_tskey check (Sashiko)
      * Fix retval check for bpf_skb_get_tunnel_opt() with (int) cast (Sashiko)
      * bpf-style comment

  v1: https://lore.kernel.org/bpf/20260612001803.23341-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  ethtool: Introduce ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
  bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
  bpf: Add bpf_skb_set_hwtstamp().
  bpf: Add kfunc to proxy TX HW Timestamp.
  selftest: bpf: Add test for hwtstamp proxy.

 Documentation/netlink/specs/ethtool.yaml      |  13 +
 include/linux/filter.h                        |   2 +
 include/linux/netdevice.h                     |  11 +
 include/linux/skbuff.h                        |  13 +
 include/net/tcx.h                             |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/pkt_cls.h                  |   3 +-
 kernel/bpf/verifier.c                         |  13 +-
 net/core/dev.c                                |  39 ++
 net/core/dev_ioctl.c                          |  31 +-
 net/core/filter.c                             |  98 ++-
 net/ethtool/common.c                          |   4 +
 net/ethtool/netlink.c                         |   8 +
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/tsconfig.c                        |   7 +-
 net/ethtool/tsinfo.c                          | 123 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/proxy_hwtstamp.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/proxy_hwtstamp.c      | 236 +++++++
 21 files changed, 1186 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
 create mode 100644 tools/testing/selftests/bpf/progs/proxy_hwtstamp.c

-- 
2.54.0.1136.gdb2ca164c4-goog


