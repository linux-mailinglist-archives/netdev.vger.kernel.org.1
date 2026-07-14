Return-Path: <netdev+bounces-307545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cgYMAIt2Vmqf6AAAu9opvQ
	(envelope-from <netdev+bounces-307545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:48:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BC7579B7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=gJXXZw9J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307545-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307545-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BB743010DE8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CA32AAAB;
	Tue, 14 Jul 2026 17:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F11361DB8
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051322; cv=none; b=UO46uJAH4JAs+3iEti2AheTo+VOG7OZG579OPHqyV3PKPhmDC2OR1zmPYG0cyJVnvjyz7PQ3beXDu6q+tzBJ8/YLeBnOhFFOltVrcoYK2cM07Y71lHNixKhKSWpL6KSk3z9qPFs8slR0Ivo9XMxh+XEZou8mL0nQQv25lZt+Jjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051322; c=relaxed/simple;
	bh=EieddV3CunyOQvlNz5OXYGeoAo3XqAWY40+VPURDOds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YMf7WBJeFWAl+KmELIbZmItHvhBh9v9y4U6UKj046HoclIE4nArY5SjVWI54eR9O3Mro3UEGAGoPNC9y72Xw+GgM5tMNmztQPmitV9zYcb7wvfriz4nCYTkY1YAgIrTYHY7iVbInVINlrz4zgHm1W4dpc3KnZNvoAeLpJaK4LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gJXXZw9J; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1182540f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784051307; x=1784656107; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=INgFyAIVRVhEQv6f28do5NJNurJGs9np0h5kWK/uQJw=;
        b=gJXXZw9JLIYUzvAHmZZBlB3S4Ci+L7b1d4ceOwUHCave+v5l5631FPjLltmj2KmNrM
         5Xp4AM5p2EHGu9QyPjLPI+HMTgPkg5cojOKPv5Wi/uIL+o8UvEz72Yo4zb5EggGjzwPg
         tZKItL3cdsjK46i9TCgvNwLVVv3qDXhdqacJ+kCABaNNG8gSrqKfFlwoWcHWO9K9+a4x
         T3EDQBLZ3W9YGtE0WFg1LhecqT8+PZJh0CSuXvkfeYEKe6eUiHr28CzuwtkJCQujVE13
         3C7YKTc7HOIeF/A4iukNDplB93blglRc5P2GIxu1tBP/SRoCkfG8A/JHvOWUaA95QEFG
         UJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051307; x=1784656107;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INgFyAIVRVhEQv6f28do5NJNurJGs9np0h5kWK/uQJw=;
        b=YSSo1QfwDzwYwIebJo9ArIoOUFiBuzU+hDT5j2pXTeiQ/ORgmY28LvMOLLf6DSPmOc
         VRjUJDR0Pu4ZnQsCJnEBPfGpGKVk2+UzkXEoSYru6koS3IFfyGt+WytJuOm/m99MR4Qc
         RARInqxQMUhEX/Ar2rdF79eaC1YpY7VAufZn4jphzRpHb+oSBwB3f4WNb7ywQfYuZjWu
         cBL7FLUDmdum+5MKlpyeDPyBTWneCAG21LD1EeqTjAsu48EdZ8ZvytEi0bZFuCTwPZ8G
         49ofAZ6862+3bOrahcaaJ23wdTfPDtDK/o3DJviL8yvBGxZ0AfoCJQT4szgteSlY22Rs
         3mdA==
X-Gm-Message-State: AOJu0Yxkm0syVY2jcXdQLH0s0UgIX3BByrsKkJgfPDsX4NpERBHrHobf
	uSh90qlKfPSwW8Am68ay8MRU/0oC5bI1vA/FRxLSQYTLpUYx9LSUJK6m6S+74q7Q18Q=
X-Gm-Gg: AfdE7cl+7yIlQwylLpEeMtUIAeD8MVk1JYAD7RKvhP7aLVyZo0DSchmDP48Ebxv5lHi
	Zi3vOYxmNCT3J0neBGdahjF5m5lyAmTmedtlmWOCOqqxmz4vhKkxZ0ePluSrvTckAh0Ry5tPwEk
	+9kLVRFWbqtxAI+LmKHe/3tdEHTSkAWaOi/3gZt+qvy/juAnLmJ3SqwhAeVJg92bboAWUWtvEAu
	Irz7CRETncP/CjOLXH5nKnbux0i8hAhyR35Wbh0RkoPG/Hyz5qRI7vlpFSna9jwxMb1bH0ItFHN
	yovnJT1FbuUMP8dMdb1rHB24K7VZYuiC7a8HJmcnuRk4lO0BSp+OCAcBtHW8JiMDDLhOxKv2TwY
	EYMn7kJwUJYrgQ72auRtSWrHzZm8SBxxvA1SnDyyAFAZiX0CQYkjvF9lE0EMEKzBwk9mDp4RM5p
	JogCDpbFUFrRkol1vvs1JcJ4cmSbn/aDfCUWLkkmzL9wiLtpA=
X-Received: by 2002:a05:6000:612:b0:475:613c:c9f2 with SMTP id ffacd0b85a97d-47f2dcd1b38mr17227670f8f.5.1784051306731;
        Tue, 14 Jul 2026 10:48:26 -0700 (PDT)
Received: from cloudflare.com (93-57-92-86.ip163.fastwebnet.it. [93.57.92.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a940sm9457448f8f.12.2026.07.14.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:48:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC net-next 0/6] skb extension for BPF metadata
Date: Tue, 14 Jul 2026 19:48:19 +0200
Message-Id: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGN2VmoC/yWMQQrCMBBFr1Jm7UAToVS3ggdwKy6a9EdHMZZML
 IXSuzfV5fu8/2ZSJIHSsZopYRSVTyxgdhX5RxfvYOkLk61tUzd2z24I/EbuWKJKD9aXY0yZQ7D
 GH0yL1gcq7yEhyPQrX+lyPm1bROZYZLr9Bf26J3ze+rQsK0FiIniMAAAA
X-Change-ID: 20260623-bpf-meta-inside-skb-ext-ff21c918e8cf
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307545-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:from_mime,cloudflare.com:mid,cloudflare.com:email,cloudflare.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD8BC7579B7

BPF programs attached at different points in the network stack have no way
to pass data between each other on a per-packet basis. xdp/skb->data_meta
covers the XDP-to-TC handoff, but is not available to programs at later
hooks like cgroup/skb, sock_ops, socket filters, tracing, or LSM.

This series adds a per-packet metadata byte buffer for BPF, carried inline
in a new skb extension (struct bpf_skb_ext). Programs access it through a
bpf_dynptr returned by the bpf_dynptr_from_skb_ext() kfunc.

Pass BPF_SKB_EXT_F_CREATE to allocate (or COW) the extension and get a
read-write dynptr; omit the flag to get a read-only view of existing
metadata, or -ENOENT if none has been attached. The inline buffer is up to
256 bytes, sized at build time via CONFIG_BPF_SKB_EXT_SIZE (default 64).

Metadata survives across hooks (TC -> socket filter) and, when opted in
with BPF_SKB_EXT_F_NO_SCRUB, across tunnel encap/decap and cross-netns
forwarding. Without the flag the extension is scrubbed at the usual
points (skb_scrub_packet).

This is our third attempt at the problem. We first tried to make XDP/skb
metadata persist across network layers and expose it as a dynptr [1], then
turned to BPF local storage for skb's [2]. Based on the feedback from both,
we converged on the simpler skb extension + dynptr approach.

We are posting this RFC to accompany a Netdev talk on the topic [3]. We are
currently running an experiment in a production environment to evaluate the
performance of this approach and will follow up with results and a
comparison to alternatives.

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com/
[2] https://lore.kernel.org/all/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com/
[3] https://www.netdevconf.info/0x1A/sessions/talk/thrice-the-charm-an-skb-extension-for-bpf-metadata.html

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (6):
      bpf: Introduce per-packet metadata storage for BPF programs
      bpf: Allow access to bpf_sock_ops_kern->skb
      bpf: Allow skb extensions to survive packet scrubbing
      selftests/bpf: Add tests for bpf_dynptr_from_skb_ext
      selftests/bpf: Test skb_ext scrubbing across tunnels and veths
      selftests/bpf: Use non-trivial test payload in xdp_context tests

 include/linux/bpf.h                                |  11 +
 include/linux/filter.h                             |  26 +
 include/linux/skbuff.h                             |   5 +
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/helpers.c                               |   7 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  15 +-
 net/Kconfig                                        |  20 +
 net/core/filter.c                                  | 134 +++++
 net/core/skbuff.c                                  |  85 ++-
 net/ipv4/udp.c                                     |   2 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 592 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 418 ++++++++++++++-
 13 files changed, 1303 insertions(+), 20 deletions(-)


