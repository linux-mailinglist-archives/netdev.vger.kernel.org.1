Return-Path: <netdev+bounces-253844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLuMHOaxeGkksQEAu9opvQ
	(envelope-from <netdev+bounces-253844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:39:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3C94652
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A819302296E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7998354AF7;
	Tue, 27 Jan 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2765yq8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62400355026
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517516; cv=none; b=kiSsZvBBZEYkGklEwbc7I6t6ps4xMriWlHk2cyPb2DAHB53szNBAg+Of1UKKwR+AwRU08hrfBQAwQIWju5oKqhzX97/+kgJ/fNBS+dOlhKUci4g7tmmGa1vOAn03w23D72djIb2IM7YprVT6TAGO618XqwMjr+/VU6mmaptW4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517516; c=relaxed/simple;
	bh=UwQfXjVA6/aNekkAEMxH3Vphc7MEP1+13GONKU5WWQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hl2NgkM6q+8jDsYUq+UO6JSo2HQ4ICkG7IKG5cQWS7WmvpHeFDcAs8PqUWSYsYkOZFEdUqCtEniAQmBborb6PejJlI2S7YXCJ/zB6g7CCzFU30gZajZCiiwVs5WYrzRq2kkeyRPITU6+XffxqkZhYs6dtGaJ72spk2zhcEXzWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2765yq8D; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6b4058909so1309054585a.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769517514; x=1770122314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBZ5tJuuo1kDhPksgjemdrHPtXRVqLMT/4EEaJ3bmrw=;
        b=2765yq8DFloJia4SO+qEUux5h0dxKjDcT2KW7vqu778N0ugRkxNmPow4B2oo5WI5As
         WUOdkBLRY28y+Cs9B1Mvbn4wtvhNdcTMZk0DBaN45ObOEFLjBvCGhlGH4z/NtAytXAo+
         IaIJclX4yzNvgeI+wTLDHFB5Kx+CjFlrgmJg9RpUbo4b+LvATEpiebsvyhKH7FqghABo
         sQwNokxr1+4lmLJMIqMpBIW/ayCx2rskNkHhhhTx8/lueoZQrfySji0TX6IfwuNizy6J
         T4QJF3w0u/c/s5zNn9LTb6st/bJKqZ34Ma7xNasC19KeM1N5kcJ5t9YF0PsjRgXJhOt7
         ymSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517514; x=1770122314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBZ5tJuuo1kDhPksgjemdrHPtXRVqLMT/4EEaJ3bmrw=;
        b=J1EtmA6mKrTv8zLmZIEdo8Hq7qnnX0P4JFf/bXtcTzlbpfmd0zVNUgBEsCGe+bqp20
         RaWAJgjvthMLtCNduidN36oeX0Jpwcs7jJ3KHbSVowDyulgmJmACocK4ghc/kmZ2S8s/
         QxuQd9cVLaVZyg6TAv0kkibSsLhDv2NftRBlfV0tlo9jSpa/t9OwH2ynZg0OxdqjQJMp
         jfnW5iRGuc238Ksm36IRp3m+ZTH0fzlJgrGWJdi5WVePdDKWStGb9VHzFEjMGK59Cail
         T7QU8f5QIRzhDqwxgA4/DOAnzYMT1ClyJJ8UxEl/6jxEk/OUWUbalhndz5vH6azfpijq
         5TYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrYEp/vQhG3O4ge7H2XakThOsXBfN7bV0BrJIUiAnzX+oH0+yfXtuuF2VqyQFzD3fBmXz0IpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/8Dzw9/VOES2yga6CDb8ATh9vQGVdf0EchtvyE36Kcib5Fsj
	ox09l7Yn2ShbbXFgZxKzkT6L1uRLeAeBN7aOsBWV+sZsXyjpX4mb0zPdjS2+X4KvpkOdo0Gi/vR
	2g9mXEv8fXjFfqg==
X-Received: from qkvv16.prod.google.com ([2002:a05:620a:910:b0:8c7:f48:b8f1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4891:b0:8bb:a346:8c84 with SMTP id af79cd13be357-8c70b86ee1emr157304985a.30.1769517514371;
 Tue, 27 Jan 2026 04:38:34 -0800 (PST)
Date: Tue, 27 Jan 2026 12:38:28 +0000
In-Reply-To: <20260127123828.4098577-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127123828.4098577-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127123828.4098577-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5F3C94652
X-Rspamd-Action: no action

Test tcp_tx_timestamp() behavior after ("tcp: tcp_tx_timestamp()
must look at the rtx queue").

Without the fix, this new test fails like this:

tcp_timestamping_tcp_tx_timestamp_bug.pkt:55: runtime error in recvmsg call: Expected result 0 but got -1 with errno 11 (Resource temporarily unavailable)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../tcp_timestamping_tcp_tx_timestamp_bug.pkt | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt b/tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..95a1957a2cf9c8d52946174c01241b1a911e4e02
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test after "tcp: tcp_tx_timestamp() must look at the rtx queue"
+
+// This test is about receiving the SCM_TSTAMP_ACK,
+// we do not care about its SCM_TIMESTAMPING precision.
+--tolerance_usecs=1000000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_min_tso_segs=70
+`
+
+// Create a socket and set it to non-blocking.
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0	fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+// Establish connection and verify that there was no error.
+   +0	connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0	> S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.010	< S. 0:0(0) ack 1 win 65535 <mss 1000,sackOK,TS val 700 ecr 100,nop,wscale 7>
+   +0	> . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
+   +0	getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
+   +0	setsockopt(3, SOL_SOCKET, SO_SNDBUF, [30000], 4) = 0
+
+   +0   write(3, ..., 9880) = 9880
+   +0   > P. 1:9881(9880) ack 1 <nop,nop,TS val 200 ecr 700>
++.010   < . 1:1(0) ack 9881 win 10000 <nop,nop,TS val 701 ecr 200>
+
+   +0   write(3, ..., 19760) = 19760
+   +0   > P. 9881:29641(19760) ack 1 <nop,nop,TS val 201 ecr 701>
++.010   < . 1:1(0) ack 29641 win 10000 <nop,nop,TS val 702 ecr 201>
+
+   +0   write(3, ..., 39520) = 39520
+   +0   > P. 29641:69161(39520) ack 1 <nop,nop,TS val 202 ecr 702>
++.010   < . 1:1(0) ack 69161 win 10000 <nop,nop,TS val 703 ecr 202>
+
+// One more write to increase cwnd
+   +0	write(3, ..., 79040) = 79040
+   +0	> P. 69161:108681(39520) ack 1 <nop,nop,TS val 203 ecr 703>
+   +0	> P. 108681:148201(39520) ack 1 <nop,nop,TS val 203 ecr 703>
++.010	< . 1:1(0) ack 148201 win 1000 <nop,nop,TS val 704 ecr 203>
+
+   +0	setsockopt(3, SOL_SOCKET, SO_TIMESTAMPING,
+		   [SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_SOFTWARE |
+		    SOF_TIMESTAMPING_OPT_ID], 4) = 0
+
+// We have one write filling one skb
+// last byte can not be stored because of our small SO_SNDBUF
+   +0	write(3, ..., 65209) = 65208
+   +0	> P. 148201:213409(65208) ack 1 <nop,nop,TS val 204 ecr 704>
++.010	< . 1:1(0) ack 213409 win 1000 <nop,nop,TS val 705 ecr 204>
+
+// SCM_TSTAMP_ACK should be received after the last ack at
+// t=60ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=60000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_ACK,
+				    ee_data=65207}}
+		    ]}, MSG_ERRQUEUE) = 0
-- 
2.53.0.rc1.217.geba53bf80e-goog


