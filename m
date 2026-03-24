Return-Path: <netdev+bounces-270880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I0wLv4qwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:11:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1E302A05
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBBC31027B8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3CA3B19D2;
	Tue, 24 Mar 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmL3Jayq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C6D3AE70E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332272; cv=none; b=WvTY+L+v1FJflxnTbRwLNKWVrt5wuHVwQOc8xW5ZR9c6vDLZw4EUizBNCipZNvrUbPvrE+Sf2kiEiOG1Uinl6YU9p3WjRpyUVyZcl27J/iJmcMDkE1NppSIHn+vG1Mn8DzfSNnZwZTKlllHuxcCSVxQSm4bYIFLJLZPhQ+xZkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332272; c=relaxed/simple;
	bh=eYCwzFxY2qGj3pCgqVAMjLFFIbI4v5MvL64DV7JicQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC/DT1h78/EZG/jyzace3tgOrKLDlAi4aFYHX+egtm0cJpCtzUzL72dfw81nKyLaTAEkoA662AzuUJY1w2CnRU49Lk2QlS2OlmkgPxbkZzuBnD/OXm8WGWDZ4PJvpyZFA6xflcWcEz02LG52h/ii718eSZv51FHdZ6ADMWEMZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmL3Jayq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d7f92bde91so1939036a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332268; x=1774937068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2bTKYrz6TONuhlNDgy7SEn2xSoQ5Qqb0S20rvcw5Ho=;
        b=cmL3JayqeggRQV89G8Km3o8QnjpYMytrPcff4Jxqdar2vr0hzREkEgAqy1RlfqsB3y
         uzagKgFCZspeHJIJfO9xSTkvTxy67i+VvP60inqbFm35IimacAs1nEf7SHhpapWDq6EV
         pdlWswsgojz22h0PWPxGjVr8aiJENMmvpLab7I1LxcZXi9/iCKmYGBvxHO6bT5mfOzJV
         8bKLJJ/LWXKxK+yGSy5arTCHYZtlBFsUQOhJdwtHTV+Ssm1g4eS74bzHvKjzQrrXFMg3
         4uRdCOG8AiDhTyAq8/T7igSEO8TUnLwp9hh+iD1GGRKjs8tdmElkxSdV01iEFfyjVXcS
         zfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332268; x=1774937068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2bTKYrz6TONuhlNDgy7SEn2xSoQ5Qqb0S20rvcw5Ho=;
        b=NtOCJLoOdd1hEVOrFdgLnXGTV4R6wk0qIodZRuuVosolvn3v8zsS5v6nBShb43eRkH
         4Nzu3/Z/AiY+jw4/ZYh3jnaP+04BGmxMPitbMuZKyrxo5J+E9/8VXwTYjBlRMvcIfQqI
         bn5uJ9ULuU3Ilo2fGWWFwhYvKxSmpwVJ5HdyguwuiRJy6IIzAOnGP3M8WypVstKdH9Ga
         QVecrO0qhR6lVVfVDlO1B23DsLmYQUHssVGZZhAMl58Kp2J61iGOMTRKIizU+aandok3
         8cgV7snyTYEeQtdie9Esct2ussd4Th9rKAh5na8cAbE7vhW9TgC4u8WzwYoRH6Qo6E5B
         xLFg==
X-Gm-Message-State: AOJu0YwwIuTCJC0QnPhIkox/7hok8juy5m7NKXu0nfvqP6oJJELB6kaY
	9AEE31FXulRB6b+uil2W9q52mQHgOza08zZO6a/xGaUmYOdKeJMl5fmDZi6ukSdR
X-Gm-Gg: ATEYQzy4bnjEDDHmw/GlYWI02c40MRTI1SvbTwH1HUhuDuVaFtLn7if9ahii02oBB59
	1w4Vv5uRrX2BgW9ZartJC0cb3PTz02EpWbcxndByNyL55sVw/fNc8+2BiCBEQhb13Wv+P1rqad9
	GHYNRInZU3ZTl6dSvSSzGzvVdzscIl4x1oYEPrp/RWAGziPeXniTUUNwGI1Uo1Qco4/v5XZzo4x
	qKy+pX5BT2/9hjoKHttln3Y0P7X2GnoVCmoN15rgRkUZV/WDCPmOht6gs7bZpqXTLCcHDnlKFvN
	U2a9Tf7bO/Y7pXX8ko4qZyV1BM8lBHlS+WS4fefbFDran/Z0YmSWno/ESlcfAb1bb42RiHScjrs
	fJlFa6V82kw0chFHea3VwKFg/rjKV1yR8cIM7HbCZtxzm0ZxbTHxD1G05fsB3W1TM9Kw6ymJD9b
	11ZfFf+HTo1hB24HHLRJRofslKsedTwPzPcMKvf8F3D80YWemCPWM38ktQBaWHLvK5DLKWVu8JQ
	96r6RUZkeWdJl4OFFzG1zGI8WQj2eaJM01cNGaDNQ==
X-Received: by 2002:a05:6830:6f88:b0:7d7:45eb:4e22 with SMTP id 46e09a7af769-7d7eaffb87cmr9661028a34.26.1774332267560;
        Mon, 23 Mar 2026 23:04:27 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm11429957a34.15.2026.03.23.23.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:04:27 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	gmbnomis@gmail.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v2 3/3] selftests: packetdrill: cover scaled rwnd quantization slack
Date: Tue, 24 Mar 2026 00:04:10 -0600
Message-ID: <20260324060410.1137199-4-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324060410.1137199-1-atwellwea@gmail.com>
References: <20260324060410.1137199-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-270880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17D1E302A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a packetdrill reproducer for the free_space-limited scaled
no-shrink quantization case.

Grow rcv_ssthresh with in-order data, then queue tiny OOO skbs so
receive memory drives raw free_space just below rcv_ssthresh without
advancing rcv_nxt. The final ACK reaches the case where raw free_space
sits just above 84 scaled units while rcv_ssthresh stays slightly
larger.

Old code rounds that final free_space value up and advertises 85. With
the fix, the ACK stays at 84.

This gives fail-before/pass-after coverage for the actual raw
free_space bug rather than the separate rcv_ssthresh-limited ALIGN-up
behavior.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
v2:
- replace the old rcv_ssthresh-limited sequence with an OOO-memory
  reproducer for the raw free_space case
- drop the follow-on ACK transition and keep the final free_space
  failure case that proves the bug
- drop the IPv4-only restriction after verifying the test passes for
  ipv4, ipv6, and ipv4-mapped-ipv6
- reword the in-file comments to describe the observed behavior without
  referring to a removed path as "buggy"

 .../packetdrill/tcp_rcv_quantization_credit.pkt    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt
new file mode 100644
index 000000000000..bb4f63772326
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_moderate_rcvbuf=0
+sysctl -q net.ipv4.tcp_shrink_window=0
+sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
+
+// Exercise the scaled no-shrink path when raw backed free_space, not
+// rcv_ssthresh, limits the post-ACK window in __tcp_select_window().
+//
+// Grow rcv_ssthresh with in-order data, then queue tiny OOO skbs so receive
+// memory drops raw free_space to just over 84 scaled units while the current
+// rcv_ssthresh stays slightly larger. The final OOO ACK should keep the
+// sender-visible window at 84 rather than reopening it to 85.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 10>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:10001(10000) ack 1 win 257
+   * > .  1:1(0) ack 10001
+
+   +0 < P. 10001:11024(1023) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 12024:12025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 13024:13025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 14024:14025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 15024:15025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 16024:16025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 17024:17025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 18024:18025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+   +0 < P. 19024:19025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024
+
+// The last tiny OOO skb pushes raw free_space just below rcv_ssthresh
+// without crossing the next lower scaled unit.
+   +0 < P. 20024:20025(1) ack 1 win 257
+   * > .  1:1(0) ack 11024 win 84
+   +0 %{ assert (tcpi_rcv_wnd >> 10) == 84, tcpi_rcv_wnd }%
-- 
2.43.0

