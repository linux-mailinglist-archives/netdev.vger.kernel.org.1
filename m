Return-Path: <netdev+bounces-298429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6jc7Ew5eK2qq8AMAu9opvQ
	(envelope-from <netdev+bounces-298429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DF8676148
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:17:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=K7aaXMAW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298429-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298429-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9FA831561A9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860A30566C;
	Fri, 12 Jun 2026 01:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C031ED7C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226927; cv=none; b=Ra+C1VcmHMpD/CMZQocyRR/rnU2vOHoBo+2KSaxbob/GtRBMJPcr6l0YegYVhGobiMn4aUy1qXMuImvSfalEPME6/D63HwZBs7h/DdTB8MCoZ9eRgxG+c7Y1v3Lxt9uhd0qbkcqPrdF3WDlHHA6lIT4D8ORlL87Oxrx7Db6qZ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226927; c=relaxed/simple;
	bh=F+0f6GjAi0Omfa+PHFBC0H5zSWE02Vdv2b6Qqh1qNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBPVFuV4m2xhKgMzd6ZeDf11KdDcaXZLa0Rk+NQ1K4Punc9kx3NqElKyVD9tP4COsZq5s30Va7d7Odz13AvHw0thK1zxf3MQ2BuLuS/cNtysCub89jsePxtuNDwGuN5WZh7IfPF+w3VYYYIKsEBDASziBBFKl9XgvcaDm/Hazic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7aaXMAW; arc=none smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13721dfd471so562717c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226925; x=1781831725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON+xkZIueelbq1KEBRaBWhyuYqrWXonUEPs0BXpVTfM=;
        b=K7aaXMAWT3Fe77QoHr1H9VmVSaAP6tWkuzAuLmOMKNJVIrKDyvoJ1DuqcQrby1hU/M
         r+1sx/dOZPXZdzaCIaIojFljypQ0pHLlZLQrhg5n8qBc8gXlBmVbKEAFZIcY56ZM3QQb
         kMFCsIGi/yqUSxu02YWW1gFLCRCrNXYxeVuJ/gLNiH0zL2Lj1SpzBld1xDYO861Kny+B
         YS0bOxD7fXVRoDl5tmZuwCvAO7usE55Qfu39jaYYteYSCT13+s27TNE4L9xqeLyRzFLr
         RYT1MUVfR/oEpyoeMVY+PYyj7PvHTBmUkXyslyPmLj9rqAacDyiak1x5ckAfgdRl+Kxg
         /T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226925; x=1781831725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ON+xkZIueelbq1KEBRaBWhyuYqrWXonUEPs0BXpVTfM=;
        b=pYOlC0H+VBMVfYpiNVHWtt2wgPdu9kGHmLF4YEDqAkVItBS43AxepcjgPUGTGDebRb
         Et09QCfZzQB6yRq2VhXewJoJXDZrAjrD1DA574iUn0jko0Blx5DUnCfUtu4t3JlT1HYL
         kfmNq62/N7VbSTyHJqYB1LyT4W5+R28aP4eSG0mIU1Y0DoRzldclZ//xPgJ4mqbh9poQ
         m9CAMNn4DyLw24QcerptaE+ojGFhhQy7cKub3YUtjMHwZlZk1WiwDq/fOHj3JJ5DzI61
         nORS/fIPepoh8gQDZV/JNlTDwvrifKKOlL6XMPFR8Iv1/8VFjO850u7bQAaheQh1OR5K
         boSw==
X-Gm-Message-State: AOJu0Yzxwju0uQJ1DbD+Dr+2GSi+4009r+jboOVpPnblFNQfdPir1Fyn
	GTmZ5zKK7rNT7KYwaJx5lvTcRWX73koUTiwGhDJgDSVGtdAb2kh6740LnFYTmg==
X-Gm-Gg: Acq92OEex2mnXxnvu3GOnLEfyfVI0zAzfhyGYE8SkyvqBLXgS21gTaW9G5c1OFtUAhA
	jCWN+atjCF0+mhCm9DbUZMg09uMnJPD4M/KYKak8xnnHOIgt/I/noT54XKEmWaCNfhvSrZotI+m
	ueIU4inBRAU6VdmH4EjsvTGvIXfRKDWDhDvssNWbtoXonDqTXZ10kq8txNwlFjEzyUFx+hAz8dj
	oSVOLnp631RmwY4o5x+dETktU6jP5hsxiUZsZoAC7l59fv6tu0PfU+1ezsC4M31/5WFePIHKAHC
	aiEv4ta8iABMwWSDte+drzzC4EHAIn1KpYisgyflAuWBL8GwvL4zCZFB91m68mmhoG9PIsR/7nw
	Vk4u+qrT6TNu6/jxYqB51V9Kw+WomnTPjZHKct7mlk5o3xINGY5qSorNQD76cuXm51M4Bglx75F
	wWmgToajukSz1ibyMUign7JQwhGLYzgJlU81gwJ+RXboyvQ/es4LvaO+3oXIJB0btGRw==
X-Received: by 2002:a05:7022:6baa:b0:137:fc94:9758 with SMTP id a92af1059eb24-1384cc8b831mr10992c88.19.1781226924868;
        Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog
Date: Thu, 11 Jun 2026 18:14:52 -0700
Message-ID: <20260612011452.134466-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com,multikernel.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298429-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyou.wangcong@gmail.com,m:cwang@multikernel.io,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[multikernel.io:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3DF8676148

Set SO_BUSY_POLL (busy_poll_us) on each paired socket via
bpf_setsockopt() so the splice receiver busy-polls the ring instead of
parking - without net.core.busy_read or an application setsockopt.

The sock_ops prog runs for both the active and passive established
callbacks, so each endpoint sets its own socket. This is done before the
peer-not-found early return: pairing is asymmetric (only the second side
to establish finds a peer and calls bpf_sock_splice_pair), so setting it
only on the pairing side would leave the other end without busy-poll.
bpf_setsockopt acts on skops->sk; the peer sets itself on its own
callback. Busy polling is a receive-path optimization
(splice_busy_loop() in tcp_bpf_splice_recvmsg()); TCP is full-duplex so
both ends are receivers and both need it, which the per-endpoint setting
provides.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 .../selftests/bpf/progs/test_tcp_splice.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_splice.c b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
index 09c7f0f9e311..da43f00046c0 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_splice.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
@@ -9,6 +9,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#ifndef SOL_SOCKET
+#define SOL_SOCKET 1
+#endif
+#ifndef SO_BUSY_POLL
+#define SO_BUSY_POLL 46
+#endif
+
 struct flow_key {
 	__u32	saddr;
 	__u32	daddr;
@@ -29,6 +36,8 @@ void *bpf_cast_to_kern_ctx(void *obj) __ksym;
 __u32 pair_ok;
 __u32 pair_other_err;
 
+__u32 busy_poll_us;
+
 /* IPv4 only: the verifier doesn't accept memcpy from sock_ops ctx
  * because it lowers to "ctx + reg" pointer arithmetic. IPv6 support
  * would need explicit field-by-field reads of local_ip6[i] /
@@ -71,6 +80,21 @@ int sockops_splice(struct bpf_sock_ops *skops)
 	if (skops->family != 2 /* AF_INET */)
 		return 0;
 
+	/* Enable busy-poll on this socket. Both endpoints run this callback,
+	 * so each sets its own socket; this must happen here, before the
+	 * peer-not-found early return below, because pairing is asymmetric -
+	 * only the second side to establish finds a peer and calls
+	 * bpf_sock_splice_pair. Setting it only on the pairing side would
+	 * leave the other side without busy-poll. bpf_setsockopt acts on
+	 * skops->sk only - there is no variant to set the peer - but the peer
+	 * sets itself when its own ESTABLISHED callback fires.
+	 */
+	if (busy_poll_us) {
+		int us = busy_poll_us;
+
+		bpf_setsockopt(skops, SOL_SOCKET, SO_BUSY_POLL, &us, sizeof(us));
+	}
+
 	mk_key(skops, &self_key, 0);
 	mk_key(skops, &peer_key, 1);
 
-- 
2.43.0


