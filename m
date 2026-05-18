Return-Path: <netdev+bounces-288928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOFSOW/OCmq18QQAu9opvQ
	(envelope-from <netdev+bounces-288928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:31:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE502568D38
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ADC2307A869
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C43E8343;
	Mon, 18 May 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa36u6rh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E853E51ED
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092661; cv=none; b=evVu0JY/XOdsJ3kDNXPBmczgMoiQTchg9wyHaCcquMu8YTQbMNoiSPrtGD9LrsfLR5Wqun/iDgvE4KzE+lQHueOMecbpk7BCBZYEvaN/YSAqp7bMJgQ9CpZmgCn0Dc9e2Ei0asz5Jaf8WT+VsRd46Zbvd9+JdbGytRxCPsmMUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092661; c=relaxed/simple;
	bh=7dRN2lVYiQcHQj85FKXslQHT95uAqRClKyLM9OSsglg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7DWxhwr51+R02Pw5zryF+Q+bBPpe0GGzkaa/aZBO4GBk59ckoTF3zqdRNGU7IzFRLlLA8mLbCwN4iS8wBTqK1XC2ixStpDX161+RXgvDgxzbGiqDvTH9piyKTCUtkqbDA6iVveJPZXugXFNjyPFeJbRaytP8CBdGUhKkyOdR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa36u6rh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so831211a91.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092660; x=1779697460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=sa36u6rhPN/NAPkvLYNOj7hx3EAS4l3JTyY8cno2f+DOPH0PLarZ6CM6GHhZhGeaF1
         jyh0+XObc9j2ZrAemDLwvL8lcKk6AoCt3O+zUWhEqEA64prowqi4DBeNVP5Tg1rffatd
         vampPiUJUuxbvdFdx8V0giq93OYgtPHP6zhhIPRbn6EOqhG0PNf4MvHfWbIiOkJO/z47
         qvQOyOTCxeybMOj1w5wlRxcTeBg19GVweqHU+jezcFFfTTTzmwiQOJLLqhjE4oU81p1b
         I08NvBkzQ7tkoB6w7geD4bGpD2HBRH1sWHa1aLQQ6VrfsUVObiD/QAqJj1cHewIt6pmi
         uNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092660; x=1779697460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=mpc3QXuFZ5nn/bLLQ00VNajbp2TbNHIUi3M81ivhjX2XlHEWCLA12J8HoVtkomAP0Y
         Oqm2QV3c7+kOR+Uz9ar9qkYt8qFgA8DU0IxSJYiHS6QlxyorCpNFiBRw96kjTzCAn4pi
         0N3zljMgDqd7nT8jmfHOFjorhXrJ8ZB2EAp7WqIA3JzhFVf1NxvVqpPXY2QdsHa3spZ3
         cPJ2Zf5fv+EF/pkl8fNLb2PuAT2Qqp8bQxe955Sxn7sJ8DpRRdr8bS39SjXsz0aUKE4j
         ncbCe0UDJshwejQtacH4vlM/TqilZjLajctgQULz/SZAxq5W6+8B05Mk07DjnBCbzHES
         VWYQ==
X-Gm-Message-State: AOJu0YxyBKCNJoq99KsTGTPFYCYvMWiLnLj+uQfnsgEPWUcx1cBmL99z
	gzJeiAYNdbgYM8QOXdzLMoIyQZdO3tHR6GqQ6wOCmcP3YifcBGR5dlKS
X-Gm-Gg: Acq92OH+DIojsTAM5sQi3LS2CzE7CWqZlbYXmjTdH1GT9Udj/Xwd9pqMK9neQmQCO57
	HMWE9RTvCnH+L2XEqyhMcs/5duTM29trRW5dh4EykX4O64K2CDvtfk/hfhZXjJ8A/rRAdGBHTIq
	F5jX3MRuFD8WzGOeshB29a5vytotOeHp94pX/tq12IhMVmtEei8qfDkREFNGfqsrytJkxzXQQ7s
	SLZuMTK9udBXyhkvErbdnRe1E+0WBFTnrIyJJE+4cLq1Itmf00+9B1jaDiJIys0Ow3I8wvnBJqz
	ERB8+kfnBLwE/taZQ1pWqdYfKPGqHYRBjbQ2pBUvUyNHDhud+EA3VjgukR93Fs1ROPWJ0Vr4YnH
	mN7AFeuotplJI+kC33ST/RBs2E8aqIkp+0fgsUJQ1Ixv8+Suu5Qtse6++KP5WPxqoA2ub6ra5+p
	Zy/4CfPku+b14NG9QNJVMpZ3BP5i95K59WbbrwCWI4HXCwUOtNshCnnkC5c472lDrP1z4IybZ9w
	222ColU+FDUlP9D/qSrBKWOsKDrOQ==
X-Received: by 2002:a17:90b:3c10:b0:369:a359:b189 with SMTP id 98e67ed59e1d1-369a35a15a7mr5394598a91.19.1779092659728;
        Mon, 18 May 2026 01:24:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/6] net: export sock_disable_timestamp() declaration
Date: Mon, 18 May 2026 16:23:40 +0800
Message-Id: <20260518082344.96647-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE502568D38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

In the series, sock_disable_timestamp() will be shortly used by bpf
timestamping rx feature to dynamically turn off the global time record
function. So remove the static label.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e0263bae8da9..a579d5b09207 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3047,6 +3047,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
 }
 
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
+void sock_disable_timestamp(struct sock *sk, unsigned long flags);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..f3d78da3aeba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
 	}
 }
 
-static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
+void sock_disable_timestamp(struct sock *sk, unsigned long flags)
 {
 	if (sk->sk_flags & flags) {
 		sk->sk_flags &= ~flags;
-- 
2.43.7


