Return-Path: <netdev+bounces-290561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDv1I7BKD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA05AADBB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9593C326A916
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9537C90A;
	Thu, 21 May 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcW034gf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9ED377034
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381211; cv=none; b=ELE55lNfeu1ojQnMPgOF8WMqjzzWOiybkZ0NvcVhRay8TlncwnKppKSKA6cfP5WgvMUA1dlxZOQw115AsvbxxH0Zwana7PSkomyQ3kAqQK0HHuS5GwnBmsbCFmcrHlAeJ42aqZY+1WE+7IfOuTmNuruC3LKLeo4O9qUjM+6fTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381211; c=relaxed/simple;
	bh=9M3xO3sTTq8LHfcKIc5hA0ERvkIIJW2Gka+8g8Vit+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sj26LfwgFmhIr+ssHtjb1E+Ubn/hlgesP9lsfX7cyknFddxLyLFlwcnbSOA/qn4NjLdQFttO5aOy/8Kx4tZL+0hu663i+ZPgK5sTkuQOwv8Qaa6ou0FYa1medkPGV6ea/sAFvdFFtCZ4Y7zOfAZRQ/PJg0WoouTIDgayFhvg//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcW034gf; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1334825de43so5780856c88.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381209; x=1779986009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z53ipK5w5yDvUUyH2xnve7gzJfjRxn1dpppTCEhJQdQ=;
        b=QcW034gfAMhINbdpmO1xvKKNvuRNrouot4zd8bvVxs/ZxjorM49m/UkXfNp0lvEapK
         5PkXPwcrQwwHW/sNLF7XCTkOTC95jUZClmcbz4Xwi4LPVaF7h4OhIk1NCHcsP1cL0mYV
         ypgf+juni8u50XorI7TGKzIshQo7ZJD7xQ7o/eh0D/lPcZw7ZjD2ey55m8UAV65VgBpH
         6JZgiyFpEE2s1VQxhgio7q5tl4VCyM1aTnK19DPykgmhiUZpyy94VYtoCKWrgOWoyDUp
         k0jr3f4fGcpgX9XAERz0fk3G9KZXA9Q7mHmlPoBsk8Gp/dp6PljfI8ZlmktCCxtsR1bD
         IXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381209; x=1779986009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z53ipK5w5yDvUUyH2xnve7gzJfjRxn1dpppTCEhJQdQ=;
        b=CpGv4xW4RLpFaVaew2DZdyReKDMiiulgpCsUeHxBbXPgt16h6yrNLZNbEsBa7YnrgM
         oAcGMe4eKoGXv1s7hKUOx9bTe06+s3nx9X7urQRUbw5qSR6ZxqZwV7Q4M3hm6koJe4ow
         1qJQWcTHMW3km3idDGHVWKW5WzTX3UdQzY2i8Fv17yTshfsBnPYba3a5XOnYtDij6Gej
         D9u+EPSY4HjPyJacjM6kO/GDQF5fblNbU6XOX27KdsZiNYTvPLoBv6ngodX2Z6Xncv0t
         nlkFRnYRxK6A3DmYfwzDNGNsQVk+0vlg5ylTsohm0MOIjm1dDZd94y7DhkUqavpc/7Ai
         zTfQ==
X-Gm-Message-State: AOJu0Yxl43NwGSA6ViqIFvtOn9f8NoJYNW0Z0xjcmCp/GtKp4hpK+wmq
	Kn44KxfyVw+TOMfRjshIZ49YgXHfN30wmJB9vuPlI+jv9763WX2WWEnerOSvUqR8avw=
X-Gm-Gg: Acq92OHIeefN4k3q8hzE1PV+y9Prjm6dFDPDtIR20DRHRcnsC7jlGErrRqNR3SDu5sy
	Z7FQV7HWPtHgwf53i3Yg1VgiATNhwmYq5Vq8M3G8W71SOohphrfLXwO50tLrOX3v9ySUo3FGTvR
	jrNe4ruM3f0tjsqYcZTSs2D36iZKGL48EXol3KDtt5MepBbmB/H0Lq2SYUBuyDRPWhc6PW1xIFL
	AYPQgJjGvB8CauyTdmF0dI7QYDoxgANgnmZYD2ceNeOolSoKJmtzNcb1cgD3XK1B2SYHtZGoUQm
	4gIipkDWS7Z/3IXxa0p3rWW0UvukBpSFVjFnYHgE88wG9494eJAR+PHFdk2znEwfU+919JOejXG
	V4O0FVH+4FUA1ZrqGw3iRt3e1oZFElE6+Pi7/17IoeoV18dRzNjeyM7C2M5K3RAG6HyqqSt23vp
	FZgaRCAh7EQlneCK30COQx8R4wTLCyW3f/DbCERrMFLxGi4bXGQBuhQ9MhajY32b/NDBSS
X-Received: by 2002:a05:7022:1282:b0:136:4514:d913 with SMTP id a92af1059eb24-1364514d988mr1044457c88.26.1779381208956;
        Thu, 21 May 2026 09:33:28 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13652ac2f39sm502917c88.15.2026.05.21.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:33:28 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dongli.zhang@oracle.com,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tun: free page on build_skb failure in tun_xdp_one()
Date: Thu, 21 May 2026 09:33:13 -0700
Message-ID: <20260521163312.1479805-2-bestswngs@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290561-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72FA05AADBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When build_skb() fails in tun_xdp_one(), the function sets ret to
-ENOMEM and jumps to the out label, which returns without freeing the
page that vhost_net_build_xdp() allocated for the frame. As with the
short-frame rejection path, tun_sendmsg() discards the per-buffer error
and still returns total_len, so vhost_tx_batch() takes the success path
and never frees the page. Each build_skb() failure in a batch leaks one
page-frag chunk.

Free the page before taking the error path, matching the put_page() the
other error exits of tun_xdp_one() already perform.

Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..39e9f3390c91 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2437,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.43.0


