Return-Path: <netdev+bounces-291547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJaNG+83FWoDTwcAu9opvQ
	(envelope-from <netdev+bounces-291547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:04:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC225D10D2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9F63006390
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BAB3BFE44;
	Tue, 26 May 2026 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6IuZOdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E463559C9
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775326; cv=none; b=Mj5IifaWwgUuo2vpLFLqIxzfDYbvWlk+39T2cppqt3Nxomv+yJfbIxOENih3ZBOt7ycWjIjxMrVSsiKk460CcKSTTVVcpoHTqRANhd4ipW+b0xYTHq1PlbW+2wgh9cwlvBH62pCoARf5w1rcUTG6lE/XBY31MLfWsqiKiSbh7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775326; c=relaxed/simple;
	bh=ChxFUaH9zjpYx8BRjD9dZ1vHU8YYLfBsQ0g0/WFsa04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aB7qmzRQAFMmnbczk017o9bJ4qVfdbSlpzspEwF20/olXvvKScO11/TPfT17htAZCW9rX9giaF9ut4k+gBiKsmPBgauNYjmXT1fPtOI8pB/lNzMAdzA+RERnFUnEvO6RfQT/7Sp+5neM5dM76FWpXi56EU/M0uhqd+NxMJUxLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6IuZOdC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so63743525e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779775323; x=1780380123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I15Qye72rXnWF52br0qRQsOfcY4+owD8kwcdhmYsCXA=;
        b=Q6IuZOdCTtzoZaDj/nzDRpZatytcBKlnePx4JQLKE82LcAmYjUMNJYGJYxw3RmWQkz
         /awJktpuJ+ZhScg8WdbZ981evwEsmTR3oQTzg4E9yjjou6iAt7thD1u1Alh5mxDlKUQH
         BwwSMFXDDHpYkTVf+iNe+y/WM1C1V6pweNWYzDf+Ix3fE+IA8SQ8WHkRPNCAwwQGrZVi
         8fpKs8xI5GoGrgGMBk1A5u89cbK95zR7XykcT0qJbTFHAUPXkexux6zAlyvGZuLMBiDk
         ySln2gzsFWHdIBDUXFfBRcy3ocBQaQSyoHdIDjzt3PDcPnuibYX2ebWvNPGJzSYWYkNh
         z9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779775323; x=1780380123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I15Qye72rXnWF52br0qRQsOfcY4+owD8kwcdhmYsCXA=;
        b=CWKkze8yKtvUK1oe6dpwwDBgvuy0K5Hd0/RTZIx6X/Gt2p1vkYpymt4eS3MFjMeeNP
         KJMD3kW+R3rjM3DQlfr8mH9QsINnL71xRrCTRcDcSQQ4rMWrEzkSB2CkGGi2iR/IZd4L
         dHWZHhQxsslKUd7KZNbT4LvWYtkL5irEgwa0yk134O5vQKPp/SjZFoO2oesFj7neppQL
         DCuqzP6S7blW7RYgEPohdLu7Y2s1bRMAZBe7A+Lv78jIouHgzGs0jx/yVzYc/NnarhcQ
         CrH5QSw0DlXPKwq+E617qBXkKZhluS/gaOCsIuhXhD3kBQZRQPJBweoKXM5MYT3L5VUv
         xQ5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Yicw9Up708GSyUgtZs4uSW22//8u9bFnjwJ02kGqSeZF2MKQsTDIq4TGmqyJIvB0qHVgmojE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cDqUngeTFB7C+mMZVTpPV94lAEnk+m+T2KU6KlD/QirnI5Ug
	cyIThOTAkNwQZbxWyrO9tTXqSFVIKisjBzdJtqtn0w9wrRSs21DMGBwc
X-Gm-Gg: Acq92OEtyZ3xRqaZPwA4Zhk9qezzNW+xBhFpWuKvTuQ2JerSGHNPoVItFibAtNBDLrI
	zaN9BlFZbWPUfKOiu+UKeHMNF91lZ/69ChssvP5nHYH62MRyQ2cJ2vJATGgEVL6wvISOr5FcBps
	S7YT8kWGNPbM8WPNlUnPq9cZXNdJJP76/WMFaJOWLXctigvc1woO4kitp5FkQhrSyZiyJ1nQfqy
	HDUUvM6np9wRWONAwGjif8+Ljz8A5fBvz3TYrZ3TCH6iT9+bu1r/zfSRifGE2gGWf5ISU9R7xoq
	CfAbvl/PoppUBOkm9v+LwvKe+Fk9glEzyl0D2N7CI18ezvffm8ciQjsBKwN08W4SzprvdUwqPYk
	zYB9mW+ZZBl6zxiY+Yk6C+Li1R5HAoYFKDC1ID6tnH4ZYDO7bvNSlvwMVVNnhJPSkGH7hBcKtej
	2/5r/SZbPafK3LQC28iNqtvlILpMzO1L7yc/NFVtP39gZRRtLw8uM/Fju8aXCZTXqvSfbCVlm2k
	+EEZKQ=
X-Received: by 2002:a05:600d:6447:10b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-490426c5b1emr200251675e9.20.1779775322583;
        Mon, 25 May 2026 23:02:02 -0700 (PDT)
Received: from localhost.localdomain ([188.27.64.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b7d57sm295929035e9.15.2026.05.25.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 23:02:01 -0700 (PDT)
From: Adrian Bente <adibente@gmail.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Adrian Bente <adibente@gmail.com>
Subject: [RFC PATCH net] netfilter: flowtable: fix offloaded ct timeout never being extended
Date: Tue, 26 May 2026 09:01:38 +0300
Message-ID: <20260526060138.3924-1-adibente@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,mediatek.com,lunn.ch,gmail.com,collabora.com,makrotopia.org,netfilter.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-291547-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adibente@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCC225D10D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OpenWrt has recently migrated many platforms to kernel 6.18. On the
MediaTek platform, which supports hardware network offloading, WiFi
connections accelerated via the WED path were observed to drop after
roughly 300 seconds.

After several debugging sessions, assisted by the Claude LLM, the
problem was narrowed down as follows:

nf_flow_table_extend_ct_timeout() extends ct->timeout for offloaded
flows using:

	cmpxchg(&ct->timeout, expires, new_timeout);

'expires' comes from nf_ct_expires(ct) and is a relative value, while
ct->timeout holds an absolute timestamp. The two are never equal, so
the cmpxchg always fails and the timeout is never extended.

This goes unnoticed for most flows, but a long-lived hardware (WED)
offloaded flow on MediaTek MT7986 eventually has ct->timeout decay to
zero, the conntrack entry is reaped and the connection breaks.

Compare against the current ct->timeout value instead.

This patch is sent as RFC: the diagnosis is verified on hardware and
the fix resolves the drop, but review of the chosen approach is
welcome.

Fixes: 03428ca5cee9 ("netfilter: conntrack: rework offload nf_conn timeout extension logic")
Signed-off-by: Adrian Bente <adibente@gmail.com>
---
 net/netfilter/nf_flow_table_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -541,8 +541,10 @@
 		 * after this -- is fine, datapath is authoritative.
 		 */
 		if (new_timeout) {
+			u32 old = READ_ONCE(ct->timeout);
+
 			new_timeout += nfct_time_stamp;
-			cmpxchg(&ct->timeout, expires, new_timeout);
+			cmpxchg(&ct->timeout, old, new_timeout);
 		}
 	}
 

-- 
2.46.0

