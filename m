Return-Path: <netdev+bounces-249102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC806D14160
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F5B3016926
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC4365A1E;
	Mon, 12 Jan 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hErqo7P3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF33659FA
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235644; cv=none; b=BxgV958ZjAFqHMTfLNg/isve3lvJ13rgXmkid8aNrvtBt9fcG2TR8oHCNZOXOMvWOuvhJtjzC33Q5JXFNNg1EDSjnVKoq4Z20pQckFkivDwbgVmfHGVQmoZ4+3RfQs6P1ALpYPCt+Cb+5Q6XJJ5A9AhbtL8lZ0jqH/6AK2TOFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235644; c=relaxed/simple;
	bh=qObXrZZY/g3E4GCjc0G54e2FFMUVE8T5kZfQcSCoJ94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2bRafi8raq2PSGnMga+ddsIU7iL7aH9hsV/uJfU9Nqis3Z5gAmKn7iEWMhor30WxN+t9MMfncrs1Kb3gLM8P8fUep89Q28gpMGBLLBqZPsDox/A5/N4yAVM0cATQIH/p7UXcbfCi61uhOjxPKDBJp9IbJy+Rjtq6rjM6tYtIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hErqo7P3; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64476c85854so6388408d50.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235641; x=1768840441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuJVkRWTkGkTXSTXinl6EKTHqtS+lO+xdjv/rVIuI/Q=;
        b=hErqo7P3fCkDNmuylITsU/vVdNRLaAw0BLTnaYW52RjBR5pbIMB84h1300SGNc/aon
         KPV7avpEz51Dbz1Ho/B0BlSoCoV5bc1WfYJv/+GgsakmX3Ai6k1eZqfEks1a7wMZYiN+
         IjCZaDtREfjr3QDjVptX3xGKN/hmesn57kXZD1uFCCZH+134iwO2Of7WW4KikXD9u7u6
         Pi0wzxMdauqlgmCtS8/PBlpSRYQ0MdDFhDzE0hGgTGahhUu4sNyk7efxSAk1Ml0lA4wB
         +sQdOTnf9//oWm1tlQ3Qqm85zJRSHE0PTVCpQzAkeyYiZqlfw0fAACaMDMwTFl1QxBoV
         PtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235641; x=1768840441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuJVkRWTkGkTXSTXinl6EKTHqtS+lO+xdjv/rVIuI/Q=;
        b=W8ZB/eNkYaXnR1wj9CLGjcIjb9q1gFMEKg4t69YXA3qE5WkpM1loB2zIwcSf6oPqda
         PCg3Q5YTPU2oHM8LZs1EN0Q2NtdzKs765POmW+7XVIcLv4+DMI5GXeAkseMuMIpXbHHD
         oS+xD/oLUumySU9ezuttU2sztvkj2DxGbtlQAB8XD9hMHwcfJnE9iLZ0zWRKl/Kobl88
         usAxOw+ZDNSaQmFFttJF4ysNk0S/PCQedkNs304JVG/7xI68q069ClfWmnaowN+Hppr4
         O2C8N7ALFl0oJYGGX/NM9iRg4AUBrZXw+0qvdI58i9Dgo7A8lFYOcCzphxdhFOWM4FG3
         eRYQ==
X-Gm-Message-State: AOJu0Yy4TPx+WCbaTVhp9qMOtOMEYF4RhKxQw93RchKYxv6A2r0J2e03
	RzPJLMlsCFNjtEgMOxZlkfprGYziYVp7t0RxeuZojuBqEXjSBHekAAjZexFRFQ==
X-Gm-Gg: AY/fxX7gBNiTCjWsZOtu5+3zqVZ1MpgSRx7KU1m16pD7Efg5yI7ctUVnL0BV7ABX3Gf
	NkBXGzfRHoQwXNee+2/l9yp4zmiqp2DM8W0boTv8EOVmZviSc8WRKi0cIk5uIG0lMBFiddapqUy
	wON9JmCbSkgXQ7uVM/YEfyggeJ6i3n3OVJNTPEI7iol+vTSCT4pUimvcfHrP4I0guSeg8vSGTxh
	+2bj6KrY85zAcqs9MIijoMWTYwtYXihkrf34NwVrajJ0SmREP/eIm3OkTkSuNpBi6vcuEe2L0H+
	oBl52B6QGWsL1sG0Z/GJlV7WnOGBsXS+IkHkVToPyWhpN5p0hI76+7ONBBBso0a2yXOAByV3orx
	qdpQJ/21mh+reS6ACS4vyk8A/gABRwh3cZsM17auOyAnnghCdqLXIh1mSdc9ypygxqf6ry5pPl+
	wyx8dnp/4WR2UI4MXRVg0F/TWhhZn8ZoQsL93ApIKP2AtguYRkrKkk7FYpk51Eh01AeXfFDNV6f
	DOydiJbHg==
X-Google-Smtp-Source: AGHT+IHwCAsygqtGFPRDkA2lpMh2n1Jks08uLWVmcs8Ruowj98Oq2HZmppb7RJ2spxJlhQnmaa8tKw==
X-Received: by 2002:a05:690c:6605:b0:786:7a54:4624 with SMTP id 00721157ae682-790b57238dfmr346819387b3.7.1768235641256;
        Mon, 12 Jan 2026 08:34:01 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa58f9f5sm69610607b3.24.2026.01.12.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:34:00 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: net: reduce txtimestamp deschedule flakes
Date: Mon, 12 Jan 2026 11:33:39 -0500
Message-ID: <20260112163355.3510150-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This test occasionally fails due to exceeding timing bounds, as
run in continuous testing on netdev.bots:

  https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh

A common pattern is a single elevated delay between USR and SND.

    # 8.36 [+0.00] test SND
    # 8.36 [+0.00]     USR: 1767864384 s 240994 us (seq=0, len=0)
    # 8.44 [+0.08] ERROR: 18461 us expected between 10000 and 18000
    # 8.44 [+0.00]     SND: 1767864384 s 259455 us (seq=42, len=10)  (USR +18460 us)
    # 8.52 [+0.07]     SND: 1767864384 s 339523 us (seq=42, len=10)  (USR +10005 us)
    # 8.52 [+0.00]     USR: 1767864384 s 409580 us (seq=0, len=0)
    # 8.60 [+0.08]     SND: 1767864384 s 419586 us (seq=42, len=10)  (USR +10005 us)
    # 8.60 [+0.00]     USR: 1767864384 s 489645 us (seq=0, len=0)
    # 8.68 [+0.08]     SND: 1767864384 s 499651 us (seq=42, len=10)  (USR +10005 us)
    # 8.68 [+0.00]     USR-SND: count=4, avg=12119 us, min=10005 us, max=18460 us

(Note that other delays are nowhere near the large 8ms tolerance.)

One hypothesis is that the task is descheduled between taking the USR
timestamp and sending the packet. Possibly in printing.

Delay taking the timestamp closer to sendmsg, and delay printing until
after sendmsg.

With this change, failure rate is significantly lower in current runs.

Link: https://lore.kernel.org/netdev/20260107110521.1aab55e9@kernel.org/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/txtimestamp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index bcc14688661d..170be192f5c7 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -206,12 +206,10 @@ static void __print_timestamp(const char *name, struct timespec *cur,
 	fprintf(stderr, "\n");
 }
 
-static void print_timestamp_usr(void)
+static void record_timestamp_usr(void)
 {
 	if (clock_gettime(CLOCK_REALTIME, &ts_usr))
 		error(1, errno, "clock_gettime");
-
-	__print_timestamp("  USR", &ts_usr, 0, 0);
 }
 
 static void print_timestamp(struct scm_timestamping *tss, int tstype,
@@ -599,8 +597,6 @@ static void do_test(int family, unsigned int report_opt)
 			fill_header_udp(buf + off, family == PF_INET);
 		}
 
-		print_timestamp_usr();
-
 		iov.iov_base = buf;
 		iov.iov_len = total_len;
 
@@ -655,10 +651,14 @@ static void do_test(int family, unsigned int report_opt)
 
 		}
 
+		record_timestamp_usr();
+
 		val = sendmsg(fd, &msg, 0);
 		if (val != total_len)
 			error(1, errno, "send");
 
+		__print_timestamp("  USR", &ts_usr, 0, 0);
+
 		/* wait for all errors to be queued, else ACKs arrive OOO */
 		if (cfg_sleep_usec)
 			usleep(cfg_sleep_usec);
-- 
2.52.0.457.g6b5491de43-goog


