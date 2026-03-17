Return-Path: <netdev+bounces-268457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLZDFNn6uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:55:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4B2A482D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00A630791EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE9366541;
	Tue, 17 Mar 2026 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDk4M7Iv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCB347FC8
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730314; cv=none; b=adR9E2JUbvO6LlPAB23qxhBLScPzJzjj30Rvl8P0MtgJPpOvptalueoofDtk8p71gC0Z7t9iMtUrhqjsrzgMG2Zm0fDcPqoIDXMjbN5TBqoGv08iOExvoDrOe5+den9uZDDCjCEKs3M15aahfAtbCljKfwEJ2Ybu0m2Us+tdx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730314; c=relaxed/simple;
	bh=r4HeCz/IRpYcOhG+YpKz/qws21aUNL7YkGF4PVZ+KWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSSMjLrByHe0yhXKNZ/WtB0G+9lYhUP44DWB68Q9WqBvzxqB7Ol80pk3+9ZgEtcGz8kfvK3MV15QSVTcPBE+YasAgDjv11mWh1Czh2Jf3yWkay6bbCtiXIRQNDifez8KxZvSUKtDxwWEN1XXZ6BuOnHi2mIqCoXEjNTBKhtRgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDk4M7Iv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d75d698ee6so2999862a34.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730312; x=1774335112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyJZWPy0C8gtfPznUNGUjC3oIzSMZL+cyuAhRIUmyqg=;
        b=FDk4M7IvGbZ1eMBOfUi2JkSo/tHUAPn3aufZgz33Kvau7n1EoHmeK1mpHVazOmZERW
         LeoA9oY3CpQAovTZNpmdzct0hWKsBVbYHs9EBJ7K8sSJVn8ttOu1lTGevSUXKj+VQID7
         VDqMo8iVoMKdMU/CBcjf+8TX6ceS+hBCNhE2jxXj9zbgm9sS/d03sR1Jy+stbI3YUBhI
         v1tf98JP2QMw/YCjqxJvVj+8kPL0lJTen7MgyRSxUhqE9ui63KQcMkRnctmGMd5ZrFiM
         +Wz/M6CX1BTKOwEp2CFlSBgbKcxcZgCP4VQWydRbAh4Qn9JoyG9SKEiCtwTbcK/Cn16l
         GEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730312; x=1774335112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iyJZWPy0C8gtfPznUNGUjC3oIzSMZL+cyuAhRIUmyqg=;
        b=JCLO+Ki5FmzUVZUsWMspaxjRnLp9ok9IAJJD1hNUg5jWnd2IPnHnOLhFJR7SvX6jM2
         c6pFu1SHMtq6WmZLFJtGeEYxeQ1NZRna6zgOkWCXfL3cdyecAdCHfaAmT48JnKfIRxtF
         /ut9xlAEOCHneAUnjUFlehq52qVkX+L1XyFvQbcISC46/6BFLCapZnTzoqrTdpSxSNsk
         UGfsFBUoBaR9GjDIWFqDowb+FJsbs6p5iY/kcaz25QqobmNUD0DcFvhCxDJZFYWeuX+G
         L78hzMcJVjMa+gWPH7zxYXfsgBxtjFQryED95cU3Iiohs8tBBa0/PA8ZOeDIhgd45iA9
         Gpig==
X-Gm-Message-State: AOJu0YyEItOhonQNatfK6AfVud0RLZdmwlG/EfpHUY6WpfnPiWhO2UUY
	nzUiYUo0lIPKzljKz/y8V9qOCEX/IL2NGtBBkOdcLV5doHpzGatst4FsfKMj+zegmFQ=
X-Gm-Gg: ATEYQzzyWNjBvY1TwNKU8HND3w5/xUViNQoHY2YRMvHECs0Iv9ZOfY1RF4LzBMNFsRg
	epDTPRfWrDSshlQwL5g1pg9ojpvXynOfMKtAeCKpy00i4g9jPHWIF9b4SBSpTLDtONf8/5ft+Cv
	3yQHkMRXa2+fBN5LvEyygs5tbi5x+8LwZZsMG0igcqiyWwsI2LB8TB2fNoBRYI2g8NsSaxhrVhS
	1/kb+DKH200+ZjUSUEYbsaZIfw2LwqyeazeuOQtjKn2HEeYkEeM28a1AqbGNqNSOABm1YaxfVnB
	5J4OyFu2JuVDnLbuT4+deKeXxmz4ZeWqg39XZIoL7AjZ1VEaeGMsjpey5NHxDZBOb5AGVbCoMfL
	8I+0Z4A6nHckqKnthFf/5begrEgceI0EW/xZ1+xpIrR9yKfs7vTv5hNVd4HkNdTvN0Zby1Z3irm
	NKkqDIiO2neP6CMIfa4w66SbLWh1teG5LWJS+ZTKO/v8bv4Pr0rZP/pP1vgblBeQf1Z9TaHhyQO
	v72T9aZg6fNx2kWydsQEDlvA3IhQMte1kzJ+80RIw==
X-Received: by 2002:a05:6830:700c:b0:7d7:5405:193d with SMTP id 46e09a7af769-7d7825696d4mr10566630a34.24.1773730311701;
        Mon, 16 Mar 2026 23:51:51 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae68a4bsm14058432a34.19.2026.03.16.23.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:51:51 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next 3/3] selftests: packetdrill: cover scaled rwnd quantization slack
Date: Tue, 17 Mar 2026 00:51:37 -0600
Message-ID: <20260317065137.1533226-4-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317065137.1533226-1-atwellwea@gmail.com>
References: <20260317065137.1533226-1-atwellwea@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-268457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: E6A4B2A482D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a packetdrill reproducer for the scaled no-shrink quantization case.

The sequence leaves slightly more than 84 scaled units of backed credit
after one skb is drained. The buggy ALIGN() path rounds that up and
exposes a fresh extra unit, so the wire-visible window becomes 85.

Then queue a tiny OOO skb so the next ACK re-runs the no-shrink path
after a small receive-memory change without advancing rcv_nxt. With the
fix in place, both ACKs keep the sender-visible window at 84.

This provides fail-before/pass-after coverage for both the immediate
quantization bug and the follow-on ACK transition that reuses the stored
window state.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 .../packetdrill/tcp_rcv_quantization_credit.pkt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..8ea96281b601f2d161cfd84967cad91cedb03151
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_quantization_credit.pkt
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--ip_version=ipv4
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_moderate_rcvbuf=0
+sysctl -q net.ipv4.tcp_shrink_window=0
+sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
+
+// Exercise the scaled no-shrink path in __tcp_select_window().
+// The sequence below leaves slightly more than 84 scaled units of backed
+// credit after one skb is drained. The buggy ALIGN() path rounds that up and
+// exposes a fresh extra unit; the fixed path keeps the sender-visible window
+// at 84. Then queue a tiny OOO skb so the next ACK re-runs the no-shrink
+// path after a small receive-memory change without advancing rcv_nxt.
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
+// Free one skb, then force an outbound packet so the current advertised
+// window is observable both on the wire and via TCP_INFO.
+   +0 read(4, ..., 10000) = 10000
+   +0 write(4, ..., 1) = 1
+   * > P. 1:2(1) ack 11024 win 84
+   +0 %{ assert (tcpi_rcv_wnd >> 10) == 84, tcpi_rcv_wnd }%
+
+// Queue a tiny OOO skb. This should not create fresh sender-visible credit
+// on the next ACK after the first post-drain window update.
+   +0 < P. 12024:12025(1) ack 2 win 257
+   * > .  2:2(0) ack 11024 win 84
+   +0 %{ assert (tcpi_rcv_wnd >> 10) == 84, tcpi_rcv_wnd }%
-- 
2.43.0

