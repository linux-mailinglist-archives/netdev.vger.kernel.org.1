Return-Path: <netdev+bounces-267293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN+ZKeaIs2kTXwAAu9opvQ
	(envelope-from <netdev+bounces-267293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:47:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093E27D352
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5136430A8130
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4636495A;
	Fri, 13 Mar 2026 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIxO6L4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A311D90DD
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373663; cv=none; b=NNcH85rUzHxIjEKsSI/2zLDv51a2LP4B7KINr0h+2lcpAj7tZ4uNgmlodI4OUEqldq3ZycpeWl0FeEJ1gXgEQhcLpbfrsaTm0I5wOnORC5nTzrJnlVoShEY+hdaqnfoJ9oRO0PHFxiITQDC3SxyhpIS/IvsAfz+cA6Eg3NFrmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373663; c=relaxed/simple;
	bh=/4gcq8LShB8D0c5s2jFOvaAMKwtDoLawyFz3nOQjuLU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mLBrzJgyJOIq25KZ7hTNRusW5ssSyLK6CPaU3VoY6O9ThhvCYtrZlFqseAsLkTmLCRFt4Zw3NOsZegIW5+QjTMxR8VAM5TcIkg4rj0WNYk7jFOIvU5D23uwaTwmEqaVM3Nty1Qf5XlbsQNGgD30Au0+wCkgBw+Jr0kuzylQFsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIxO6L4v; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6638ce09a31so2176117a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773373660; x=1773978460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=INglkRyjzET0z5aJCRl/lBzILAwHGEvu+nMDhJsrwlg=;
        b=VIxO6L4vyy3roWMrX2etPjhzkvIe9/K98Yo3iA/gQSQwVzuoOA6JD+dOOVaViStjge
         kedSqrEK3qiY+blXlZHfzrapJZGoNvb/QCXeQ30fDXZYh0e66+mIBxMqKMwOuPemGK3W
         mWcsCEyIpauB+8GX+mCeiCfzOLy+6dsNWhTIuKBFEMDt9zFIGkJDSn2eHXNpd9fY3UXN
         clFMruJEsFSu1a0zMDqxSZ/bxKmrO3R/TmPYW7UBKTquuwzTegbuU7iXuixYGS3W/dxH
         xh6JiYQ2p2hul0CAyOJLlhYpXANYsxWO+MmF66Cip/PuXzLDrSHVEyUUl3yQjMAK29GG
         dDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773373660; x=1773978460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INglkRyjzET0z5aJCRl/lBzILAwHGEvu+nMDhJsrwlg=;
        b=IOcY2x48TfBhrvlmpuzkQPla30Qfx+rl5ZzwWtdSLdt3e+7aMx9SdRBbWYH+URyzpa
         PYnt8wVEyAVCCS9+DaLxuyD2DNg31O/rB/Mb/8N/9iMke9qMpeiGwwVnUbWzAoZe4IPT
         vo5xT1RGLV+Ly6azI2ePLQwONgFRnRrVnyHGKftAndWx0oT1QjOsK0AF6y5M5EVvShjN
         wu4Hq8ldGzodtr1c8t6xY5i5iHl0SmaFlmj5aO+9xsWhcgqPT5Lyvt2KMV0QA5SVRJwz
         hn7Ld+0iiymmcgGleTZ4lzPY0qgYVmdro9gav+3GbFHWXRFxC0KgADg1EmHwx7LecHpZ
         9nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX31PnLuf53grEeha3NpZWGv5bFyBERP+APEM6RH1v2pcY2WL5LDvLHjJDfoEONLF55OT3HbKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJembCzRiumgKFbOTngYnrWXcJZejUfASWdgvzt9HLypsZgiQ
	dhAmbut+aDg20o2xbf3qmzhq0v9ayCklzxkpGF4N6MDtT9lc78NuI7e+
X-Gm-Gg: ATEYQzw7f/Y6pJ2RXk6ExzsacyoN8Q/Um+dOTqmXDvzNVqDR0icbGStG1YEv2Wtj+Ja
	U9MXEQ9FsOHd4VTs3ErZ21V2PTSm45P4eobQijXc+5L/0A/+xVoWAPuw1ZFqzm3JnaU3TleINDa
	/zOR/KNxZg/tpdS0E1gRUqMdNEDjBKF+SaSWCnNTuNQsaaVMHe8+FT9UnUyLwJanTX4X3D8uq5y
	d5hLGJioVZi+2W8iVs/75wyBVK32lwYpnrdbTxf5V5pMSyAIay0UER1mVhF1jNz8bjBl8zs+uly
	6Uc37XTW1AMj+G8GgdBUEzLC0rVWe7Z6XNm6Z/h74DmaL7As48As2cb05YXkB6dSarTHv6L66Ui
	Qonq+WwvivwnIautvIuxMJfp9wI3VplNKh9d1EkvvOPsoVmoyrkvZ5i+WnkRFajl7j09lNyNM4e
	h4MW0=
X-Received: by 2002:a05:6402:1ec8:b0:660:eabc:9c70 with SMTP id 4fb4d7f45d1cf-663bac0452amr977150a12.29.1773373659478;
        Thu, 12 Mar 2026 20:47:39 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e25:2e3c::49b:47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6635088ffb8sm924271a12.22.2026.03.12.20.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:47:39 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: linux-ppp@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: ppp: use max L2TP header size for PPP channel hdrlen
Date: Fri, 13 Mar 2026 11:47:31 +0800
Message-ID: <20260313034732.209792-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267293-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5093E27D352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

chan.hdrlen is read once at channel registration by
ppp_register_net_channel(), and used to set the PPP net device's
hard_header_len. It was set to PPPOL2TP_L2TP_HDR_SIZE_NOSEQ (6), which
is 4 bytes too small if sequence numbers are later enabled via
setsockopt(PPPOL2TP_SO_SENDSEQ), causing unnecessary skb reallocations
on the TX path.

The setsockopt handler attempted to change netdev's hard_header_len by
updating chan.hdrlen, but the PPP layer never re-reads it after the
registration, so the update had no effect.

Set chan.hdrlen to PPPOL2TP_L2TP_HDR_SIZE_SEQ (10) unconditionally at
registration and remove the ineffective update in setsockopt.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 net/l2tp/l2tp_ppp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index ae4543d5597b..99d6582f41de 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -787,11 +787,12 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr_unsized *userva
 		goto out_no_ppp;
 	}
 
-	/* The only header we need to worry about is the L2TP
-	 * header. This size is different depending on whether
-	 * sequence numbers are enabled for the data channel.
+	/* Reserve enough headroom for the L2TP header with sequence numbers,
+	 * which is the largest possible. This is used by the PPP layer to set
+	 * the net device's hard_header_len at registration, which must be
+	 * sufficient regardless of whether sequence numbers are enabled later.
 	 */
-	po->chan.hdrlen = PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
+	po->chan.hdrlen = PPPOL2TP_L2TP_HDR_SIZE_SEQ;
 
 	po->chan.private = sk;
 	po->chan.ops	 = &pppol2tp_chan_ops;
@@ -1176,12 +1177,6 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
 			break;
 		}
 		session->send_seq = !!val;
-		{
-			struct pppox_sock *po = pppox_sk(sk);
-
-			po->chan.hdrlen = val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
-				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
-		}
 		l2tp_session_set_header_len(session, session->tunnel->version,
 					    session->tunnel->encap);
 		break;
-- 
2.43.0


