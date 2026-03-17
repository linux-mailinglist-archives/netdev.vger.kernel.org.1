Return-Path: <netdev+bounces-268456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IocELX6uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D54972A4817
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43FFD3018742
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2FA348445;
	Tue, 17 Mar 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edP9a+/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A49349B03
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730313; cv=none; b=flmanqIwFthpfwE0fU3ZL15h8hFi67aem06sd6dMZGi3QghQiKFiXOfkofl+c75zVCL7BLOQdUwRKlb6BUdrjg518jWejc3yteAcpnddl3QFWw4YyJKQPz39p4YDWj2Nmal4c92OL9+lgN+TWozBPQaBCvU97hBTEvzOPXk/gHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730313; c=relaxed/simple;
	bh=evB/X8tNk78bHrQ/MFYt8wsGBWuU1gJMZqIau8s3uvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUU/+OTlEtMjeqA0+xujPcF6gZmrPo53w5+RSDhm3Wb9X9TvyCAY4rz9SkqH/ZTdSFC2tsK3hE6of0jJ2jV0JUyopU5Mh721I2sMlvLWdOEf5Kqp6d0b1E1ap8tz9qXqj0j9bOHFBLEdHnu69/FJTslXn5+vBK47dnChD1P3HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edP9a+/P; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d556c1a79eso5940815a34.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730311; x=1774335111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nu5fdG7ljOunxtDElL00N3RnG2qS7orERGCqEegHO8=;
        b=edP9a+/PyTUTASdPoNDae9hEmSrVrYiE3pYK+ouU7XZYN1Uoz8hmzs3m8hFmfksg9L
         PsMf8Zr8y8zP50ENDvqudplXcgjFFma/vRm0koa/UVv2O19db83cOReSAukJi1QLKsqr
         I4bnkrCHkMc/uVs9YI2Y4PCXYlgqJTIQN2w2zoxVYI6Bp7eW/cuT45+/HG55DRviOqVH
         6vvpjRye3yvNvgOTWlAcwRXIFDcyqWKHgTPyoH8Xu26VNXH8LiY61QysGfmk6YSAnyu2
         JPRsAM6pPyd/qpgxf7OtYuQ56lN7gtJnFZ+1NImZMeFckZNFTxYKNADZJslJ+aWlHYE1
         jbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730311; x=1774335111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Nu5fdG7ljOunxtDElL00N3RnG2qS7orERGCqEegHO8=;
        b=CJW1ziYL3StRhpbDXh1Ifz4ALtpen7yiC8PdD4Cjr/7Y+MWzXHbzwm+FrVSHxbYARM
         m9/k2JZBgmNs5N+rHTq7ulXtpOr7ep6XSMAB7rWHxPfSzGCyUzsaCIwbqfHUaPqBeqGJ
         MfkG5vXPGA6FXDVnd1krJmpSqoQg0y6/R6IvrKfINlbtMrOXESg7WU5B6kvJBOm+3yrf
         RoLXg20nUNzX4mWmA9hjaytD77m+RXczBDhCk5i1+2TdY+sJKphIZq/31LyBOA2ZDjUT
         GJGt6qqrjoLfQbtJOIUrFEre7+Rtd3yL5AQZQd3JB+tqiPi3U5ZaeL8k6dc5BX2iJuTY
         9odQ==
X-Gm-Message-State: AOJu0YywcvjglgkIEsADv112L3cDwfBZleSR+JdDi3rlz0QmhGeVKFXl
	oYdOiAHAw5ZmwzyqJ9p3YBrZ0pDNFX+OoAlbGNy766YZGwyLgkqhf8fTik6yXoVGEp0=
X-Gm-Gg: ATEYQzzy+VlIy3BudP5IPBrXwXOijI51jPO2SSL2aBRwRGfj8I54XuJkhz8/gudV4HC
	z9/yBy/+C3de1fBIFXiRnTOvY1XuQN+q+17osXQgE4I8RKqP95znOBkvQiE9DHK2tbn85eDn410
	RD9vE+3wt0VpEHO3Xfr/cqG4IQvjX5FaHv2YSeAel05II5Sqjc8mQZO5nBglF82z6XKVrhU2xCr
	konRhwJ31FfkTpsz3pRCkZFYR8j5cXKGHGSdfr0ETzpdI1cuehcf/pordJACzXecsVsdFSgXnGV
	RISCO1Pp4tCsxZ30VLQOco9D//XdiMXF1E3NewIvMM+V/KMp05bxPglxgrHrAyzFFeO9e4UpLRs
	a0jvtaeAzquSoBxsWrZydqMlWDnoI/Um7O9VARYtOl8wLrSpqFwyr0HvdMa+MqfzA2OgafhLDaA
	N3OyKJFEHBeWQuhMSxI0Wb7HLey3BTNSVLStzZ4rVO+QJdnJccoIMMGc7QCX8ldmSBJn+bj/7Vo
	LOn0L8MGOptraYmc+Ua976gtrLx/6wGq9MKgzU0Ig==
X-Received: by 2002:a05:6830:6619:b0:7d7:466f:b2fd with SMTP id 46e09a7af769-7d78246af9bmr10197156a34.2.1773730310733;
        Mon, 16 Mar 2026 23:51:50 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae68a4bsm14058432a34.19.2026.03.16.23.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:51:50 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] tcp: keep scaled no-shrink window representable
Date: Tue, 17 Mar 2026 00:51:36 -0600
Message-ID: <20260317065137.1533226-3-atwellwea@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-268456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: D54972A4817
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the scaled no-shrink path, __tcp_select_window() currently rounds the
raw free-space value up to the receive-window scale quantum.

That can expose fresh sender-visible credit beyond the currently backed
free space.

Fix this without changing the meaning of the stored receive-window
state. Keep tp->rcv_wnd representable in scaled units by rounding larger
windows down to the scale quantum and preserving only the small
non-zero case that would otherwise scale away to zero.

tcp_select_window() already preserves the no-shrink guarantee from the
currently offered window, so later no-shrink decisions continue to
reason from a right edge the peer actually saw on the wire.

This removes the larger-window quantization slack from rounding
free_space up, while preserving the small non-zero case needed to avoid
scaling away to zero.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_output.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 35c3b0ab5a0cb714155d5720fe56888f71aecced..bd3a43148a87e891bc632a47ffb5b82c475e8f6f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3375,13 +3375,19 @@ u32 __tcp_select_window(struct sock *sk)
 	 * scaled window will not line up with the MSS boundary anyway.
 	 */
 	if (tp->rx_opt.rcv_wscale) {
-		window = free_space;
+		u32 gran = 1U << tp->rx_opt.rcv_wscale;
 
-		/* Advertise enough space so that it won't get scaled away.
-		 * Import case: prevent zero window announcement if
-		 * 1<<rcv_wscale > mss.
+		/* Keep tp->rcv_wnd representable in scaled units so later
+		 * no-shrink decisions reason about the same right edge we
+		 * can advertise on the wire. Preserve only a small non-zero
+		 * offer that would otherwise get scaled away to zero.
 		 */
-		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
+		if (free_space >= gran)
+			window = round_down(free_space, gran);
+		else if (free_space > 0)
+			window = gran;
+		else
+			window = 0;
 	} else {
 		window = tp->rcv_wnd;
 		/* Get the largest window that is a nice multiple of mss.
-- 
2.43.0

