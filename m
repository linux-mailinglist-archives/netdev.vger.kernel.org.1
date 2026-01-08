Return-Path: <netdev+bounces-248198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E0D04F21
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E320304E41E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D252EACF9;
	Thu,  8 Jan 2026 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="JzzqysXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C52DB7BC
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892550; cv=none; b=n7d1vD+iU7ImGOscxe/UgZQDAkMBXPY8Qg6p+TCHtq+2CMEAhV+Rvu+pw5hmjlfZwjqgo1ju4sIrW0zUd/em8BYxGxToImmgHNp+ivlFwLHutXnlTIj7YffZ2BsdYKfVo+jDjKOGDk2RjBXwNu/ZZ8TTdtGdwId6pvT1s4Tqk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892550; c=relaxed/simple;
	bh=u9qkjFAKzX4vFrOHoN9SaRn2aKrw4+8mVLrJIcJmo4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVTZDcs7BJeQMBNaU1o6rKfD9xsh1K5LOkaaUwRIdej/rL/TFHRZWJoM0mzE0tETKbnO3MrM2fVgF5LEeqUmhRAnJJcO1ALe7MTxr46F+dYjYtg9K6T7u7sR39LLkU7um5nTukt+ywfF8DJMBooK9U81QLAuFDaQLpCZlwcyhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=JzzqysXG; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ad70765db9so4570127eec.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1767892548; x=1768497348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJDSI8myAj1omz3dpvsK2HoWtvG3zrEE8T6ptMgBz+c=;
        b=JzzqysXGJIvRMfWM6m5UmEjvqdPMLpyRvnAs0M+ilMcxQ0RT3XAZGdS1QW4x4OZVx0
         cfOJDukSdIilxBm/HyiSfmNIH7eqBpsJr6w8P6Jg15wUfOH3aaTbo3K0JyN5R5M5RygH
         997s/B8aMrccZA3CttWLKuwYj8Ri7M7DtLJKiXbTQ/4Rm0lWxtZeCBRHviUWIUwdZol0
         Rd8Ds6M8p9MzqXXsoPZIBs6Lh1bML0Wpl9lf3vu8plKU3+IrEVzkqt+XCtr0pn2SFgqV
         p9sFblgMP3v0spbZrAeQU6ils8L0qeVuEvWmQ2lCAY5NdaaQlhqo1EzBeXm+6RdLTUGG
         w2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892548; x=1768497348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJDSI8myAj1omz3dpvsK2HoWtvG3zrEE8T6ptMgBz+c=;
        b=kIyY1A9hg7QI683uMg5CSH3Nq4MpGuWRHFUuexkBDxupWMXzqThPUau4TXQcCk6qnl
         f8ss9pyRWISbT4PwxH3deomKCok0ClWskbCdtPl0TTohI79vQXZpC5z/i8mYj2wuBJKL
         n3xHE8QjADKiR9KmQT5rWjMFvUJw5Gw74vk0caiBRC7/cghz7hs8RxRpy4suy+qKPKiD
         A0kTUPeQGUT646rPKMmCz1cjOyKTcQbCO44PNxBm7X913YH8w2gmM+BzfYktHSI0JjQo
         f2mHXRwpAiTcEqZ2EMNwZabvUVBuQO/IOavmSLHp8t767rhIb2hotR3ejWLiI6+kFgvu
         MEVw==
X-Forwarded-Encrypted: i=1; AJvYcCVEVxk0xUe+zU2+uML4larkGn6EeqfmcoO4cU938/nAEaRlM9CSTZBFTm/2uIT1YCrhMNLHYr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxQnIr5Uc9huWGNBd6x5oRn13awB5hg6yYSB/I9Idwx9kpUaM
	VDOjQmOCYlTBJWMQReJQD6R4Y9GUBu05k6yy1qfYH3S8vKfbpyEh+I0LkjTBe8gIDw==
X-Gm-Gg: AY/fxX4vzx0w3A4ebh7Be4YnREqA4R3ElOtgHgnOnqsUUhQ7+0A3ew9zsIE0Pb6vgft
	N2FkSXq3dnaaWdfriJkfs7X93xx0CVXpwMJ3+V0OVsByRZRbHdHgNwPRWZCeRNZ1Co3BIll5tAc
	f8h7IG+pjb74LhkcxYTmm9VP8SZ3cQUY7rpI+jdJeR0G+g0/iQgx7d92NGuQ8jLgpPFtJ1G1rZp
	7KdkDwaH4dqCmJbDfl21FcSMH9wKuPTSvrkjBsPLC2J+bhzN4kgvg7jrMqOzxW6weklQ7EH1WEy
	2XhuVy4R9aF1MLGGl8XaoXW9cGX0mz37/Bq1Bqgzyl38U07O5YZkuOohDXEf7nDJWNY644JLu5V
	3hftgHiEXUoRYWYcNrVxxV0XWSW6sl5QQ8Xfl0f4xpEZI1f3kqs9oAnE9ZaBDMuTdqTW03rbwBM
	QWCFddlMz9T4Y39XrA+RyEJGLW0Tz4zpJdGT2tIMBnzRCIuMReMPaZy/1C
X-Google-Smtp-Source: AGHT+IHiNkU/QxusSbnN6m/8YDFWrMn9FthORMWs+VMsOcK5wIjVTmBpDAm+4N82ijCUMjLjG034fw==
X-Received: by 2002:a05:7022:41a5:b0:119:e569:f27a with SMTP id a92af1059eb24-121f8b5fe14mr5921942c88.35.1767892548000;
        Thu, 08 Jan 2026 09:15:48 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:812d:d4cb:feac:3d09])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm14029259c88.12.2026.01.08.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:15:47 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 2/4] ipv6: Disable IPv6 Destination Options RX processing by default
Date: Thu,  8 Jan 2026 09:14:54 -0800
Message-ID: <20260108171456.47519-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108171456.47519-1-tom@herbertland.com>
References: <20260108171456.47519-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set IP6_DEFAULT_MAX_DST_OPTS_CNT to zero. This disables
processing of Destinations Options extension headers by default.
Processing can be enabled by setting the net.ipv6.max_dst_opts_number
to a non-zero value.

The rationale for this is that Destination Options pose a serious risk
of Denial off Service attack. The problem is that even if the
default limit is set to a small number (previously it was eight) there
is still the possibility of a DoS attack. All an attacker needs to do
is create and MTU size packet filled  with 8 bytes Destination Options
Extension Headers. Each Destination EH simply contains a single
padding option with six bytes of zeroes.

In a 1500 byte MTU size packet, 182 of these dummy Destination
Options headers can be placed in a packet. Per RFC8200, a host must
accept and process a packet with any number of Destination Options
extension headers. So when the stack processes such a packet it is
a lot of work and CPU cycles that provide zero benefit. The packet
can be designed such that every byte after the IP header requires
a conditional check and branch prediction can be rendered useless
for that. This also may mean over twenty cache misses per packet.
In other words, these packets filled with dummy Destination Options
extension headers are the basis for what would be an effective DoS
attack.

Disabling Destination Options is not a major issue for the following
reasons:

* Linux kernel only supports one Destination Option (Home Address
  Option). There is no evidence this has seen any real world use
* On the Internet packets with Destination Options are dropped with
  a high enough rate such that use of Destination Options is not
  feasible
* It is unknown however quite possible that no one anywhere is using
  Destination Options for anything but experiments, class projects,
  or DoS. If someone is using them in their private network then
  it's easy enough to configure a non-zero limit for their use case

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065..723a254c0b90 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,8 +86,11 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination options. By default
+ * packets received with Destination Options headers are dropped to thwart
+ * Denial of Service attacks (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 0
 #define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
-- 
2.43.0


