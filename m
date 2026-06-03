Return-Path: <netdev+bounces-294875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id efSzHmluIGpr3QAAu9opvQ
	(envelope-from <netdev+bounces-294875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:11:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35A63A6CA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:11:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yoq+uvUH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294875-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294875-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89AE3004C23
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D48384CD6;
	Wed,  3 Jun 2026 18:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F903AC0FA
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510309; cv=none; b=rj9a5oS2ITKgOfQ6fYZIy9ky7LhcOS/MCkMEblRuqLvm/Qe3ljFn6bn3hWxG6gb6rJnqHbbxSN0a8AQ2K2KfTzt7AEIC3Np7WPsgKd/PFkY1mO/9corOeDQoQFCbfaoJFaaeYfuRLl/T3t1ewXJp/xPMZn2xLhsjdqH1vSVj8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510309; c=relaxed/simple;
	bh=vBuq5RH5ejw3/tAcr3Nrfx9Wu35JeiLcr7k1mySn2OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeNS3RK0hwK2fZnFbPP43bWtj5sobvLAKYd+kqeBeqRJu8+swjwgVJhkoj2xVcVCVRKWhBfFDbxVUTBgBWcK67gBXtBOJDf8d58436FVKuhX5FKA+x6MFW3sJla420df+iqdm+hsUKnLeRIWRN1NHHEj9tuqq1W2e4v18lAxTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yoq+uvUH; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91588056619so120331685a.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510306; x=1781115106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaZwF8ov1p7ahT/5/Q/DFOl65g+3shlkuIdix4Mu7Lc=;
        b=Yoq+uvUHIOQldUMwOINb4unrJIN7Q/oukVsB05x75uL37ADMpMGrBcVhA8mt9W3+45
         JABrDIM4v4BCYDxgyPOT0mYl1Jw4N97Jyh/B3P/sr2fu8QyN7QsaczNtHTEbQHfR+rgg
         uQo9Da+7bZEf1cjtP7i4bWOY9iecfNE/EGsfixP7Zwlx5Sc0Dp5WwvdiHoK98VysTAka
         0Jv736HqOFYdIn5Cm+tjMjEZOlndx7N180UUNbGCKeP20xQtLUE5AFH8BaVxvimNS+iI
         y6jUGu5jrnA98m0qSZgiVJR8mTvCpedPMSSV0vkSA4Xeao6KrE7qZkWfJ9Ix6QxlgAci
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510306; x=1781115106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaZwF8ov1p7ahT/5/Q/DFOl65g+3shlkuIdix4Mu7Lc=;
        b=MwMBWxe3E1g8LDGkB8yeGobc3VwNkm/N+ML1JEda6zDV0g2xOGFwIdJN0N5Pqi8BPy
         sys023FflpEej3LYhXydCbwXn8/5lpwKO/xsS0u54V45njx3Yzevd1O6ZFOabQ0I+aVp
         d5SC6GuPfmuQk1pkzVAT/6jKlIWbmLnRX2z8M93XxZDMclQA15WYfj+0MbpBSzFyJEw0
         Wqtz08AuaAJuxmCKKfUuhJ0Q2hbdF/0F1TCfWTq7OHwY7L/XmekZkHBJlZXoUWoHvrxg
         dzM/Mc7JCmeNc+dcpmIooZLXdk0kEN5rvwywxaM7iV8WNTWed1hhPDBAQSAA7YGjL6pP
         z2zQ==
X-Gm-Message-State: AOJu0YxEmiubJWSnKXHYkRBUXUhXKIwKEbo38KanMnhmjWhRfg97/8BC
	R5PfCtX7kWpkucZLHH/fyc/mkWYkFRN7HnH8mUFHiV7MDXoxvRsCzqO6ENP79Q==
X-Gm-Gg: Acq92OFud7DPo0GxY0fV5LnJwJQwIW7OZNFpGvzl5ACETtvfeOr8qpJXzb6mOlRcvCg
	hG3Xq8s2WBfyvuOukDw9UzX0kl4KW5iMy4VRrkuskA3dS5acryxj0qOelflbtLxJQAlYNf/NrsW
	DJ6DXLhE6JML7Y/1t3GEzdtXJNCylPndMIHPV3XFhWx0vBuFtsk6oNzR/d/uyd7FLcwE7UkfQ7u
	fvLFC1wqFR/1gLB3FSirXZ+kIxS3q669xlQJV7KkslytI55bRgQ92gfoBKNzNv3KUv9ICgtQk5s
	Usu/u4+ARKwhY49pFuyQvA/BWbU/vZsHQXqCIVWP6ePPxbwk4aPxLhUiCt7JL3t8oGfYrRGUE2V
	lOLd9Lkh4ZhiEbTZDKz1Ivx6f9gQlpwjo2cLjfwr4Fh8SXHiRnEhOSN6PF3BhbkYDsyfb89LNNP
	LSpvNlEqG/15fNNaIWZon9RP0WX6Hf/PMn3XevjhU4NLH9mccrfMZnMnpQpRDSf9OPG26yrUG1R
	7fDkdW/adKYLQC5hKQnXWnzTsF5zBACF+TRBJiLkJtQ+DD4pQ+QQnvTYFuBbtEuyORUSqFLkXeY
X-Received: by 2002:a05:620a:2412:20b0:915:8f08:5f9f with SMTP id af79cd13be357-9158f08645amr440199785a.48.1780510305897;
        Wed, 03 Jun 2026 11:11:45 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afbcsm319202285a.9.2026.06.03.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:11:45 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyq21@lenovo.com>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH net] sctp: purge outqueue on stale COOKIE-ECHO handling
Date: Wed,  3 Jun 2026 14:11:44 -0400
Message-ID: <94318159b9052907a6cbb7256aee8b5f8dfbfccb.1780510304.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-294875-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyq21@lenovo.com,m:n05ec@lzu.edu.cn,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,lzu.edu.cn,lenovo.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC35A63A6CA

sctp_stream_update() is only invoked when the association is moved into
COOKIE_WAIT during association setup/reconfiguration. In this path, the
outbound stream scheduler state (stream->out_curr) is expected to be
clean, since no user data should have been transmitted yet unless the
state machine has already partially progressed.

However, a corner case exists in sctp_sf_do_5_2_6_stale(): when a
Stale Cookie ERROR is received, the association is rolled back from
COOKIE_ECHOED to COOKIE_WAIT. In this scenario, user data may already
have been queued and even bundled with the COOKIE-ECHO chunk.

During the rollback, sctp_stream_update() frees the old stream table
and installs a new one, but it does not invalidate stream->out_curr.
As a result, out_curr may still point to a freed sctp_stream_out
entry from the previous stream state.

Later, SCTP scheduler dequeue paths (FCFS, RR, PRIO, etc.) rely on
stream->out_curr->ext, which can lead to use-after-free once the old
stream state has been released via sctp_stream_free().

This results in crashes such as (reported by Yuqi):

  BUG: KASAN: slab-use-after-free in sctp_sched_fcfs_dequeue+0x13a/0x140
  Read of size 8 at addr ff1100004d4d3208 by task mini_poc/9312
  CPU: 1 UID: 1001 PID: 9312 Comm: mini_poc Not tainted
     7.1.0-rc1-00305-gbd3a4795d574 #5 PREEMPT(full)
   sctp_sched_fcfs_dequeue+0x13a/0x140
   sctp_outq_flush+0x1603/0x33e0
   sctp_do_sm+0x31c9/0x5d30
   sctp_assoc_bh_rcv+0x392/0x6f0
   sctp_inq_push+0x1db/0x270
   sctp_rcv+0x138d/0x3c10

Fix this by fully purging the association outqueue when handling the
Stale Cookie case. This ensures all pending transmit and retransmit
state is dropped, and any scheduler cached pointers are invalidated,
making it safe to rebuild stream state during COOKIE_WAIT restart.

Updating only stream->out_curr would be insufficient, since queued
and retransmittable data would still reference the old stream state and
trigger later use-after-free in dequeue paths.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Yuqi Xu <xuyq21@lenovo.com>
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8e89a870780c..9b23c11cbb9e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2598,11 +2598,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 	 */
 	sctp_add_cmd_sf(commands, SCTP_CMD_DEL_NON_PRIMARY, SCTP_NULL());
 
-	/* If we've sent any data bundled with COOKIE-ECHO we will need to
-	 * resend
-	 */
-	sctp_add_cmd_sf(commands, SCTP_CMD_T1_RETRAN,
-			SCTP_TRANSPORT(asoc->peer.primary_path));
+	sctp_add_cmd_sf(commands, SCTP_CMD_PURGE_OUTQUEUE, SCTP_NULL());
 
 	/* Cast away the const modifier, as we want to just
 	 * rerun it through as a sideffect.
-- 
2.47.1


