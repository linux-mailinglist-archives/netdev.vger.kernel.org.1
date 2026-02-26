Return-Path: <netdev+bounces-261592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJLOOHO3oGnClwQAu9opvQ
	(envelope-from <netdev+bounces-261592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:13:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C411AF873
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF9B130074F0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68D46AF0B;
	Thu, 26 Feb 2026 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dhJ386y5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D544CAD0
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140389; cv=none; b=VbRCpSX7LoTOk0AlZgNKCyAOsVJnuKLpxjZ8C+bdW9PEYg9OfYtFwCiRiJgpNmN9UXhNW/6OEsRBFembK5VV/K3/As1VjHzdQr1IIHILQqSsi2cYd769NFhdSJpf0PzBFjjZg1toUnXvTqAtyFlYZ7NZqTxAHK4mLGPzmJlStKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140389; c=relaxed/simple;
	bh=Z7IEfLEm2NSKQ/Hm6w2MDipmn27AkA+2R/Dtftjgb/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fvv3eYxb5MQLguZQM7yy5o8uCKKPdeL0pEu2Y2bly2JSXzWCW0nR0hXCVJ0odCMj0xVN0zu/HR0qicWfmkLZkiMq8kROBzIep2lz3T4iEasouqV/Y/bdGmvn+CSn5+NLZGfa2HaKLrkG3O5v2l9b6IGvLrS2MZh2H3O/twPBloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dhJ386y5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389fb626b67so8069861fa.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140384; x=1772745184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V56aujRPERyoCLJD1JZX+RLV6JuIYVjtI+SIgQdcX4s=;
        b=dhJ386y5JwUgbX3pj6qc7nCFh6Asb+nqK6FV5icBYmilQmghPVTskhk1XgotIsvfkI
         jjEjWssIhwQXjtcS13TwFe2ix65OU8PZoZAk8/04Kzqjsryo2xMeieZhzlwN2ivqtf+B
         hs6caTR22ldSt0NPg598MSKUXFQnXqmIowFtN4Wl7jVRaxcXe3FjnIU3WpmMWiBTI6O8
         b6N1voEkqqgRfCDiiwZ6Zn09MEsem8OU/2eAoUxi1XnN8MGycQG0JHfGiSvcrvqyhNRb
         Yum4cB9kykNsy4e/QppvgDmnkLnTa965CwbqlncB4zceWU3Fcqsm1IzEfRmxVI+7h7gR
         eNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140384; x=1772745184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V56aujRPERyoCLJD1JZX+RLV6JuIYVjtI+SIgQdcX4s=;
        b=qlLp3V2EfIj05eaS3WdEvdmGHNqy59GpPUhcxA13DtkXxiX64TvIYwH1eduW3mY3qw
         k0OyOGT1DfXH+wh6GfsE+1yiUSJFdu+1eH+RCklhaTZlGRU9+IuWZ66RFOL4iwYtCLYD
         5RrDl8bFVBXx8wfTk6vgAR//PB3xSKSOFp0FM8lr6nyHZLd0d9oNcwOB7niGl3oUYOeO
         YUGk0jevHaUJxI3FOYDlLXeFelG319eHLQAKfMhfGFQDU5wONcbLRa9oCF48se1vIIbB
         z2QCC+TY1EZ7vRtQUlbijpjVir6oUeIxyRjQWkpi8BCBZxf5io6O1Lsy9w6oScJduD3j
         fKrg==
X-Forwarded-Encrypted: i=1; AJvYcCXhGAJEY0CgQdMKWYLqP3IemSsT3U0NHYcWtO4CylFpcut78QvaQ9ZvYnfZ/IEmb/ZL6SlSPjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBTjoL87YsOjr4ZVGTgbQVK5Mpooy8+WKxflX9jrkdh/UL/eS
	BUPvUXhAgIjRdNMiniinwkrysuYVcyM2RfFKw8TqSBrQHSdNxJO6UDNqudozgt+nv/YZ2fOc0UO
	xRSdO
X-Gm-Gg: ATEYQzwuRq/ckHPCugT4JOqAzKSRBEN+61CEDV70otawO8cPkLdYYEDQL2XrCd+jAms
	K96Dv4futjlR9MMHEd4V8k4ZzXJqLFd/zdHmcqZkL2AUuDHAgS6ueQ4ujkZinQVRk7uGzHb/8Fg
	uaSuYMcT5jAEv6EZrMNiyLSfMkr4mSruf6JUJKoHbt1RI75E4t1ctkhuLIF6jLXg510vZrEUpIn
	4vP6WzktoMqx5h78YJaQbom9v1nhnfmVEYZ1wbkUXCyE4wnSJ4ASVd9lmZwW/k5hNDFMRk8HKxo
	bXvUFh4GV2rFjMfKA+fKcUFcFqqe3vwgUkX45u++xL7tgHZ3hXE6eQG3NrYNkS9WOkNxza+ZfpY
	O+Ydh83p9kawBwewWxDmnf1Nbb3BqAVpAVEH48XFYH8dyegW5MMVpQe/bqiarIV9DW7eZPtstQh
	FJc94d3yuF7fkHCbOmu3hV/zqxO+ILOxrE5QGe8TJaqK5RdqzyqwzmSImKye7UJyUyWvxd
X-Received: by 2002:a2e:990d:0:b0:385:c314:2ebc with SMTP id 38308e7fff4ca-389ff137201mr1288151fa.11.1772140384035;
        Thu, 26 Feb 2026 13:13:04 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f62d25sm10158451fa.17.2026.02.26.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
Date: Thu, 26 Feb 2026 22:12:51 +0100
Message-Id: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFO3oGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3eLsJN2c/OTEHN3ikvyiRKCCpBQLIxNjU7NUk7RUJaC+gqLUtMw
 KsJnRSkFuzgpJBWm6eakVJUqxtbUAgFA3MnEAAAA=
X-Change-ID: 20260119-skb-local-storage-bd824356e4fe
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261592-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email]
X-Rspamd-Queue-Id: 10C411AF873
X-Rspamd-Action: no action

Previously we have attempted to allow BPF users to attach tens of bytes of
arbitrary data to packets by making XDP/skb metadata area persist across
netstack layers [1].

This approach turned out to be unsuccessful. It would require us to
restrict the layout of skb headroom and patch call sites which modify the
headroom by pushing/pulling the skb->data.

As per Jakub's feedback [2] we're turning our attention to skb extensions
as the new vehicle for passing BPF metadata. skb extensions avoid these
problems by being a separate, opt-in side allocation that doesn't interfere
with skb headroom layout.

With the switch to skb extensions, we are no longer restricted by the
features of XDP metadata, and hence we propose to extend the concept of BPF
local storage to socket buffers - skb local storage.

BPF local storage is an established pattern of attaching arbitrary data
from BPF context to various common kernel entities (sk, task, cgroup,
inode). It avoids some of the limitations of XDP metadata, namely:

1. Multiple users can allocate space for their data without the need to
coordinate. BPF local storage solves this by allocating space for each
user's BPF map and its elements separately. This matters when independent
BPF programs owned by different parties (e.g. a traffic policy and an
observability tooling) both need to annotate the same packets.

2. Lifetime of metadata is well-defined and can be precisely scoped. By
default, skb local storage is scrubbed on clone, tunnel encap/decap, and
netns crossing - matching the skb extension defaults. In later iterations
we plan to let users relax these defaults through BPF map flags for packet
tracking use cases (see Future Work below).

However, with flexibility also come downsides:

BPF local storage is not allocation-free like skb->data_meta area. Creating
the storage imposes additional overhead, which translates to skb processing
latency. This is especially painful considering the relatively short
lifetime of sk_buff objects compared to other entities like socks.

The overhead tolerance for this naive skb local storage implementation
depends on the pps rate and whether skb local storage gets created for
every packet or just some of them, for example, when sampling or tagging
first packet in an L4 connection.

Our initial rough benchmarks on a VM with kernel.bpf_stats_enabled=1 [3]
show that running a tc/ingress prog that creates skb local storage and
writes to it amounts to ~330 nsec of per-packet overhead.  Retrieving skb
local storage and reading from it in a cgroup_skb/ingress hook contributes
an additional ~115 nsec.

Rounding up to ~500 nsec per packet:
- at 100k pps, that's 5% of the 10 usec per-packet budget, but
- at 1 Mpps, that's already 50% of the budget, which is not acceptable.

While definitely not suitable for high-pps flows, the naive skb local
storage implementation is arguably acceptable at low rates, for example
when you need to attach metadata only to the first packet of a TCP/QUIC
connection or sample packets at very low rates for tracing.

From this initial implementation, fit for the low-pps use cases, we would
like to work towards lowering the overhead to enable use at higher packet
rates as proposed in the LSF/MM/BPF topic [4].

Future work - in the next iterations on the RFC I'm planning to address:

1. skb local storage copying/uncloning when user opts in with BPF_F_CLONE,
2. opt out from scrubbing BPF local storage on tunnel decap/encap,
3. opt out from scrubbing BPF local storage on crossing netns boundary.

The (2) and (3) as needed to support packet tracking use cases.

With this early posting I'm looking for feedback - is this going in the
direction that aligns with the maintainers' and reviewers' expectations for
the intended use of skb extensions and BPF local storage?

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com/
[2] https://lore.kernel.org/all/20260108174903.59323f72@kernel.org/
[3] https://github.com/jsitnicki/skb-metadata-tests/tree/main/skb-storage-bench
[4] https://msgid.link/87ecmffopy.fsf@cloudflare.com

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (5):
      bpf: Introduce local storage for sk_buff
      bpf: Allow passing kernel context pointer to kfuncs
      bpf: Allow access to bpf_sock_ops_kern->skb
      selftests/bpf: Add verifier tests for skb local storage
      selftests/bpf: Add functional tests for skb local storage

 include/linux/bpf_types.h                          |   3 +
 include/linux/skbuff.h                             |   3 +
 include/net/bpf_skb_storage.h                      |  21 ++
 include/uapi/linux/bpf.h                           |   1 +
 kernel/bpf/syscall.c                               |   1 +
 kernel/bpf/verifier.c                              |  67 +++-
 net/Kconfig                                        |  10 +
 net/core/Makefile                                  |   1 +
 net/core/bpf_skb_storage.c                         | 264 ++++++++++++++
 net/core/skbuff.c                                  |  15 +
 .../testing/selftests/bpf/prog_tests/skb_storage.c | 405 +++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/skb_storage.c    | 312 ++++++++++++++++
 .../selftests/bpf/progs/verifier_skb_storage.c     | 209 +++++++++++
 14 files changed, 1313 insertions(+), 1 deletion(-)


