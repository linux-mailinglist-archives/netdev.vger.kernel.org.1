Return-Path: <netdev+bounces-299017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zsE4Mb6iLWpWiAQAu9opvQ
	(envelope-from <netdev+bounces-299017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 107C667F50A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:34:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=DiILeJaK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299017-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299017-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01023018AF6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E32EEE78;
	Sat, 13 Jun 2026 18:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B327F4F5
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 18:34:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375675; cv=none; b=teZgvEoxzvpfOe8cGL1op5EJryQ/jcx+RCN8cwL4dGEUua7sOqLGY3aD7x1DO5AwcBeaGY3VvQ1YOpbRVI8m+vpvtHbLKYZHD04K9LL8iSxaeaOWllnR8/tN/LjrgLO7KVfwkeMzc4jYrUb9qFFTcqKHum/oM0RX5u53DVN9ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375675; c=relaxed/simple;
	bh=SXQSUZ0U/F4r/AXAi7Qh+DoP0lk/Q8qajpC4LoTLTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0dFFk5CqvOBDW6qIMGM556a6uQ4XvoUaYm62WsrH6KUjJWcvIJezDS1cFkfONQRKA0KOBZuj7amS+4fGtz9LT+05cz1t01akzpS/4xdi/ThkEZcNAMJ8b0QBMl4w9reCi2GhOf+O4NismWYiHE1hPqo/zPRk8iCqNr2YTex41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=DiILeJaK; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3042a99f0ceso275347eec.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375673; x=1781980473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVOTG9mqzAl5iIZdVjvL/CvNIxqnVecyzPnuB1AZvck=;
        b=DiILeJaKog1eHgI5lgJER4Yd5pRFJkcrd34HpiVtOK/88vmDdM3eHFgN6KcmDMPwzM
         0ZdYrOgbx5bJ8QAV8bSnx3eWX9qhYaJwjLW2aL0un/qaWtqaRaxzA80R/pQiI9id1sGC
         JcHi3a++NDtvILwcKrGvidDHATDV2bam9aQSoaoeAWW6JqG7oZse4QxTg1QuHeL1koq4
         fkx1DUmy2/fmF5aVES7sqvIUMJFA79Opn9RFVmcJlfLVmbpG5PO0CABNEdNpVOq03cr+
         XJuRtVL2bYoxulANHzrmDJhYd5ZFE6K/5zQ4XxzITqVXZas+izPjTV9j4tHLl6yHef5X
         SDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375673; x=1781980473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVOTG9mqzAl5iIZdVjvL/CvNIxqnVecyzPnuB1AZvck=;
        b=LJHgxg81pOhObDDWqWgjM8Sxlvc8TvVPY5GyiJfl3GZ0ABSPZt3pIOvTGXcR+bu5OP
         H1xHoXfO1YXBnfFI3UIjwEPYlV+zuGdDkw2TUeOIS2emp9B36cQegWtiU5DMQ+SKHYEU
         LIhAOEOEwAyZ96I+wd8jBjKqLQRvDpqoqXFPLtkm2vT/xPnY42YYmvSkvhlhjX8sKw2R
         Bu0603+hZI439fMh3VTqjEuTQu/SnSIMoizXZOnW/FVZP7zCnIq4kuWGZ1iQdN2OSRRk
         /6qrBTIQ7bIq4BGW8ylBWwmBZICT8TI8UkZ+JnpPQDbGFp+8KmgTk9zZ62Rofr56qeXg
         JGOA==
X-Forwarded-Encrypted: i=1; AFNElJ/tP/UC7IDhLnrboCfi4Vk+5nQ99b4Oho6/K1VVCzMD2klHTkkYoBKkBUrrzK4hNog9RNuKgT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDMTOxRKz2qNUrn3nV28TpelyGG6Q+qS/F4u9uzRhm7pBowFD
	PuYD3X4ewitRbAxyQSkyCLVgdfgqiYNwjLyA95ApA38qMeO9WCGazvrP6RLVAZRPDbQ=
X-Gm-Gg: Acq92OEqAy/DAnvJhafosj9MCx655PSZSu/DPF6dodfNDYwwyzq0B+vxjJY9TKyYpDo
	644Dnz5tI47QNu5MwAZLeEifzhMkWImKfqgWfYKZfWlaN7L3oMl7RYpRxc1ni+sKF/5+SyxZrrP
	gVWCwPUr4LIc2XQfrnYWtqMkcPi6tKU9tZezJn/xBG2Eq+fBHaSvJzgV0/MD+E+LUBFHVwK1Tte
	xiNXF02e0QCkYnH1o0le2KFDuDuXZjgO44RWyZx6iYU67Ehf4uuwBUlumPhxy+KowXC+6uhFtII
	HP/lmzcgVcEXwkvvOf1ah+UbiN3+hSzyiviNcygICsPUGHCXxyTKG1bmls69327XLPc5P0E38DK
	viJEW1uiaScb0YqNk5SdTILG1di2rvbD4p1qGt8AQ/U03BPx3FoGOVor2ByvGT5TQKTB58rsAZn
	R2uanZt6KzJKkY5q29NICInQ==
X-Received: by 2002:a05:693c:3742:b0:2da:a813:a629 with SMTP id 5a478bee46e88-3081ff4badamr2104625eec.2.1781375673225;
        Sat, 13 Jun 2026 11:34:33 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:32 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Date: Sat, 13 Jun 2026 11:34:04 -0700
Message-ID: <20260613183424.1198073-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-299017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[jrife.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,jrife-io.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 107C667F50A

We have several use cases where a pod injects traffic into the datapath
of another so that the traffic appears to have originated from that
pod. One such use case is a synthetic flow generator which injects
synthetic traffic into a pod's datapath to enable dynamic probing and
debugging. Another is a transparent proxy where connections originating
from one pod are redirected towards another which proxies that
connection. The new connection is bound to the IP of the original pod
using IP_TRANSPARENT and its traffic is injected into that pod's
datapath and handled as if it had originated there. This can be used for
mTLS, etc.

We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
flow generator, etc. towards the target pod, ensuring that eBPF programs
that are meant to intercept traffic leaving that pod are executed.
However, this doesn't work with netkit.

With netkit, an ingress redirection from proxy to workload skips eBPF
programs that are meant to intercept traffic leaving the pod, since they
reside on the netkit peer device. One workaround is to attach the
same program to both the netkit peer device and the TCX ingress hook for
the netkit pair's primary interface, but

a) This seems hacky and we need to be careful not to run the same
   program twice for the same skb in cases where we want to pass that
   traffic to the host stack.
b) We're trying to keep the proxy redirection / traffic injection
   systems as modular and separated from Cilium as possible, the system
   that manages netkit setup and core eBPF programming.

It would be handy if instead we could redirect traffic directly from
one netkit peer device to another. This patch proposes an extension
to bpf_redirect_peer to allow us to do just that.

With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
the skb in the egress direction of the target interface's peer device
While the main use case is netkit, I suppose you could also use this
mode with veth as well if, e.g., there were some eBPF programs attached
to that side of the veth pair that needed to intercept traffic.

 +---------------------------------------------------------------------+
 | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
 | | pod (10.244.0.10)       |           ------------------------      |
 | |                         |          |                        |     |
 | |              +--------+ |          |      +---------+       |     |
 | | 1. packet -->|        | |          |      |         |       |     |
 | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
 | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
 | |           |  |        | |          |      |         |       |     |
 | |           |  +--------+ |          |      +---------+       |     |
 | |           |             |          | 2. bpf_redirect        v     |
 | +-----------|-------------+          |___________________   +-------|
 |             |                                            |  | eth0  |
 |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
 |             |________________________                    |          |
 | +-------------------------+          |                   |          |
 | | proxy (10.244.0.11)     |          |                   |          |
 | | IP_TRANSPARENT          |          |                   |          |
 | |              +--------+ |          |      +---------+  |          |
 | | 3. packet <--|        | |          |      |         |<--          |
 | |    enters    | netkit |<===========|======| netkit  |             |
 | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
 | | 4. packet -->|        | |                 |         |             |
 | |    leaves    +--------+ |                 +---------+             |
 | |    sip=10.244.0.10      |                                         |
 | +-------------------------+                                         |
 +---------------------------------------------------------------------+

Using the proxy use case as an example, in step 5 we would redirect
traffic leaving the proxy towards the pod's peer device using
bpf_redirect_peer(BPF_F_INGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
which skips the host stack and uses BPF redirect helpers to do all the
routing.

  (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
   eBPF host routing mode)

BASELINE [bpf_redirect(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
  3. eth0        ==over network==>                         [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
  [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver

TEST [bpf_redirect_peer(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
  3. eth0        ==over network==>                              [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
      might be confusing, since technically it's an egress redirection
      from the perspective of the peer device's namespace. But, I didn't
      want to add a BPF_F_EGRESS flag just for this and convinced myself
      it makes sense, because from the perspective of the caller the skb
      will be flowing towards the current namespace.

Jordan Rife (2):
  bpf: Support BPF_F_INGRESS with bpf_redirect_peer
  selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS

 include/uapi/linux/bpf.h                      | 16 +++--
 net/core/filter.c                             | 14 ++--
 tools/include/uapi/linux/bpf.h                | 16 +++--
 .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
 5 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.43.0


