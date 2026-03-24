Return-Path: <netdev+bounces-271298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA08NUP6wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:55:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848031C932
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEC2630F6286
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A235AC3A;
	Tue, 24 Mar 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeVZW3Pm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC0359A99
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385592; cv=none; b=hfMWyeHpsqiOnVzPLtIKa/OpYE5MEuWdJDT5kAIT28aiYHRn1/qfz4X3+m+pX+oxDBb+V0tbrhs1rH01vCUHlSGfJwjSchiKLu+V2rgBSzRtF4p3uWbcOTkW+cWAWrdc3g0symAJ3PHcHQ9GhPLtlRVCnV6m4sRbCvZEL8zBxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385592; c=relaxed/simple;
	bh=MecEpZvlRBPcpBi8sq+iqUvHanol5HuJ9vfTFHwBoEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn/Kj41qsornRoo5knQTo7gydjXI6lYdW3mhcT4l/ePDcifYvGkdrRS5nyx+rFSa0rX+7jyv5tHgrw3SxiAR3rVXROPN4U0HVQDAGM0R/6RmDYeh3UgoK84v2ewdkj8P9QgBD216eT5Dlrgu5+YjevB2BHszcYimk7jzUfa6rhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeVZW3Pm; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-415e568a7ecso1453645fac.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774385590; x=1774990390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqQ3x3m7rF+rvEu9cT7z+2urBJztBsKv9f9L3zEtIa4=;
        b=MeVZW3Pm1xg27UmJWLQUrUnnHTY280fP2MZ6ucy6WffGaQsdsuUKBjIHsMWdvW8Egd
         ocJGMgPNvbkBAg3/OMnIkQlw0u5uu35My8NmJpo9r+N0Uvnat/tq0eVUbnZ1P4s8zidy
         05ufdadx5Z++tn4EolJW6JgD/gWOIDbbWsGgPsy1V3lYgl7E3P0FoWhQQm8BKN9s468Q
         yAYPSTm6S20hFefnbbI/1R6WJV9USGU9O/1Zgj25KATffuHputrdn148gYWoI7HzgcYn
         upEGNX6xaXYzvTHQfvRUjrrjXrHYZkZepHfUzxW+btOlwuhz5FRBbugqDO1sredMRgtZ
         AWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385590; x=1774990390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WqQ3x3m7rF+rvEu9cT7z+2urBJztBsKv9f9L3zEtIa4=;
        b=EQVXGYasX0iM8FVFPQ2SvNVg8E1aY6TSap5cZ44qe+HOygbwlfSCq4RtV6ym9nmPRa
         x8cJywcgjsQgSt4e4bpdhH7jUSSd+m3hOOA8DH9zSqiPtS2w2WMXONqjwhQdbEfFlMMk
         4odu1dYIfbXtl17jQ5+OLhRwwXA8/0GRW8VJwlHvJkoUJhjcvfjJAisuynyxViFODBVK
         IqXKpc5GTFClvBJZRYJ1MDlSilX7GaliRMANL+lWr1eN+rTtugw4TaceAaicsswsANvz
         9zKRsMVNcDIGGDLetqrDPaqRUpxkHwnPa6ps1m1CT9sz99TOkjPIWMwNcUR8CRNQhOvt
         aYfQ==
X-Gm-Message-State: AOJu0Yyocnr6HQ4YcZ51YGMNYZ7X6lzp+et1qehlBHiQh2xVDWVV+pU2
	jDzWyITAsZRhtcA+0ELPZC+UHrT1UHvTJLvMJbEqY3B+tNdWFeYxkqZu3I9h2+3J
X-Gm-Gg: ATEYQzz4vWC9rfhnFCBzV25iljcxpbUdE/enQn2kyIG+3CVRi/X/E4sq41K+Y+h0lLd
	cDakqIiYQP9oWS18L9KXREYcMRzTecgj99nPNp24lNUFSHMT4EZ1uosKllovaV3VZWAMGglzD36
	uqsLCODf5XKi1RrLbpxao3921w6bwoYgCIT4r0MAxlT5bbLuABZ1L5bqyQSUssSozPmMLjhrInq
	Y+EEwb5TFW2h7fI4eN/te3U54nc++JIDKaKfWAiZgriR9PaDomO5bmrB/ObLC4cbq+0gmIkmFHO
	54YxRN6caZXV4roJ4EfAa8xDpuhMKY83s9ZVLIGt4LpaXv8HWCE1UmVFCb+n/J3j/h4Kd543o+T
	MxSyHMKxnacFWpWZ1M5EtqkWCoz5I5BkhAHx7OBAdxuF945uwO0Q1RAX/3Em/oEcDMEc8d+pNgY
	HL1D5C67EfcueQVVAOI03SgNXn5GP/FQ/hpV7PYxhqKeFmD43nCtCKIH9iiA10k3Sx16C4eK6wX
	srPSeDiypRCuDMfhb98nQjeQAmrHdpd3Bct1mGEaA==
X-Received: by 2002:a4a:ec4c:0:b0:67c:27a7:8c4d with SMTP id 006d021491bc7-67dff55c413mr774454eaf.48.1774385590432;
        Tue, 24 Mar 2026 13:53:10 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252c91d0sm9125161eaf.5.2026.03.24.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:53:10 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Simon Baatz <gmbnomis@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v3 1/3] selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
Date: Tue, 24 Mar 2026 14:52:59 -0600
Message-ID: <20260324205301.1361608-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324205301.1361608-1-atwellwea@gmail.com>
References: <20260324205301.1361608-1-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-271298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7848031C932
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
v3:
- drop the explanatory packetdrill comment per review

 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
index 7e6bc5fb0c8d78f36dc3d18842ff11d938c4e41b..0116abd86093e1920f14d027d34ff5ad30ccaeef 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
@@ -17,11 +17,10 @@ sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
    +0 accept(3, ..., ...) = 4
 
    +0 < . 2001:11001(9000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:11001>
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:11001>
 
 // check that ooo packet properly updates tcpi_rcv_mss
    +0 %{ assert tcpi_rcv_mss == 1000, tcpi_rcv_mss }%
 
    +0 < . 11001:21001(10000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:21001>
-
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:21001>
-- 
2.43.0

