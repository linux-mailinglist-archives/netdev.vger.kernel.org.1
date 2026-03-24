Return-Path: <netdev+bounces-270878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNv3NaEqwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:09:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE643029E1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2741930E2674
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70153AEF24;
	Tue, 24 Mar 2026 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ka94dG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFF3AB28F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332269; cv=none; b=bSEUastx2/lmY9eV2u2qmRHGuXBfqvQdgEmXG4BfjDNUO68M1gsoUvpE+A30IjOmoYHrgJC8LaM334+sM0EnjLQTdS/RTxCR1noKcBgr9BdVnza4mERcFm1D26pWm+aFDhYrCmFC1VLeK58pTMzUvNhZlSeB0byBnWVwNIQGp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332269; c=relaxed/simple;
	bh=2LpObmm0KAIiKn6ecbNp9DXCoG8E4+h39lkWKLmCI2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xsll5PRQY5Cxw7gIYK//WMDLr77Qm4pxN1anLpbF+HCNc//40/A4Q9pQVOj7DzncyA8FU7YYVgB1MPdRauUkDYs2N6A5JVVHKcKjoql/K3wm/efgDmwqgrL6PygM2i7D3J9RhtSZPZrcDs+fzbUGPdSqyBddUhzDr2a4y/jF9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ka94dG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d8b2703f37so791149a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332264; x=1774937064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/zbf91aM6LypdywPhicgkAJndZ/EFSfnS9FO2u56Vg=;
        b=T5ka94dGtnA4sHjcmIg2RoVWZniyqrGQE/AcDSKyAUwHdMapHi0QAhEPRkEawqCE58
         zGzHJcxah8raueTT28DsWPKT/Y0f9UnjQmsowXx/FnrteSjlGKAWiGDbgUlJJuzUdy5A
         BUQlNbPSMK76wHhR+QaK/7Z/TCnyAj4bK5pXruSPiJW8nVVOAU/gc9Ksg6qUIJLgoBdz
         U8+Y5tX8Pau6LQyafT0fMiLll4Fs8R/hIhePNdlvaXHnqmNv0Lqg+n6jMUsQrlLpFJy9
         1jc239h9jAnTikeEKUfXHsOWQaibOQciBCrhHAwVhvu+7uFcj4Q/arZnvV6gIAFzoqHS
         W9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332264; x=1774937064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/zbf91aM6LypdywPhicgkAJndZ/EFSfnS9FO2u56Vg=;
        b=pIx+kryH3eU8tMDL7iaX7hMHqX6bIgeu09YgyJooLUyj5qN/FMRLrHPgQnG3YqBeVP
         Qe8CcPQ+8dTHPDC9M+BrV3FbvREhTjZsYatLlaybndotOPD+tdRZ3Jh6xyV4fHoRGf1k
         BeeOPYQxhBmh8gJPirgzA7luBcAywGHm11qU+CfOO1UrjZMVXXw8lciNY5Q8fhxj2pKz
         ZnviWFGyjPBJXWUGHzU6jiMQrfmUNVZck7C5SHsgsp/2t8HasmezY7q8W505jBLcQMdK
         +4/AjNA92UtP+7x7zG45GihddzK0LuiUS4XfoG89xiLGRJIN1ULpAhsuq6wG3+NED4f0
         9UkA==
X-Gm-Message-State: AOJu0YzSAswzN6WBDcLVG2EVOoD2P/BHpNuMiTT6C2bYppQDQOWSQ29s
	52JwGWcw/Bqsb67sYh4JnhQVfVYTA7OuZckxWrC9NQFL2K9MwqMZu37q7gJf/+0l
X-Gm-Gg: ATEYQzycn6JKyLU7U545XiOL9sw+yrD3BGJvHYTCwp0VahEq4dSMcOV4Di1K9eZAbzJ
	IdmSXEBj94Ba9wVgi8T7vwSCYSrQuNqmEWTtY/jhX71mZe131WObe/tOmwFDkmewvHCY6lvcjF8
	FQZSwqVw4t5hW8sbaUrRHhSIVyxa1g096w5G7VR8cgIehlqvgEboCg6VzZoPI2UeAVYt+IzqrX6
	d3wneugpq0Oyx3UVDx7O1IaCxCjGzi8lOMx96m02ppdANHG0ZeXx33st7ssoez1kWXh72TGY8rM
	/bMSflGNXf7Dt+R28q2lFaVGoYKpjt67lUWZ+tfCrHGrCPTw8LSb/5h+o/Vucmjl0Tvy+22/UZi
	rfy+6fabrvqZ7+1Yiy/cZ4UtW6YgqyHwrhdv5HEb9esSyiI3qeVd4q2GliBW8y3P1B3maa8zJVH
	sqmdMDlmKf2pZ5XZYAqrrykGG/SZBDY7cXRd6fyvE0SGvZSqazvWKl/qJ8+wwzWDuPmplV6BG6O
	r8Xvj2zHLI+Ma7sjvGwxfbrfcdvZ6nSj/aFSrOhjQ==
X-Received: by 2002:a05:6830:81cd:b0:7d7:f15b:e399 with SMTP id 46e09a7af769-7d7f15be572mr9244399a34.16.1774332264220;
        Mon, 23 Mar 2026 23:04:24 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm11429957a34.15.2026.03.23.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:04:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/3] selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
Date: Tue, 24 Mar 2026 00:04:08 -0600
Message-ID: <20260324060410.1137199-2-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-270878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 7AE643029E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_ooo_rcv_mss.pkt cares about the OOO SACK state and the resulting
tcpi_rcv_mss update.

Its exact advertised receive-window value is incidental to that test and
can legitimately move when unrelated rwnd accounting changes adjust the
ACK window.

Drop the hard-coded win 81 checks and keep only the ACK/SACK shape and
the tcpi_rcv_mss assertion.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
index 7e6bc5fb0c8d..0b19de9f9307 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
@@ -17,11 +17,13 @@ sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
    +0 accept(3, ..., ...) = 4
 
    +0 < . 2001:11001(9000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:11001>
+// This test cares about the OOO SACK state and the resulting tcpi_rcv_mss.
+// Keep the ACK/SACK shape exact, but do not pin the precise advertised
+// receive window here because unrelated rwnd accounting changes can adjust it.
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:11001>
 
 // check that ooo packet properly updates tcpi_rcv_mss
    +0 %{ assert tcpi_rcv_mss == 1000, tcpi_rcv_mss }%
 
    +0 < . 11001:21001(10000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:21001>
-
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:21001>
-- 
2.43.0

