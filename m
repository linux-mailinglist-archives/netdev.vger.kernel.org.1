Return-Path: <netdev+bounces-288185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMo/J3epBmq8mAIAu9opvQ
	(envelope-from <netdev+bounces-288185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:04:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F454962D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F6FF302CBD0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 05:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DD3DEAC9;
	Fri, 15 May 2026 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4QTrN7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830133DDDB8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821493; cv=none; b=UlrY3BH+Yyd97O6KmnJggmO1VAgy8XotNJjMwsQgKqw55jzy869E2jrgrBarZYFG+o/SBfgx8SJfMKbmXUnfql0facxNUYbSUVEy8tYAafyV0yOZ5IZaST/u+6Q3t8t4G9CXhumg3cfUU8UhtY70jGDPScovXfZNSQAtd6vR9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821493; c=relaxed/simple;
	bh=LE8jfo45c+SRwiSVqT2/Y0314N5ZIYQwpVi4AglxEfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GUEej3vYsyN51c38wRoEcCEDxdbjEmz0aTlXyUKvPk19ap0pdtGs9FVE0zxoq/yF9rIv2iTzIx+oJ43XX4M1ePqjewh8KwMVe2jqmfxc6ZydWANh27huWeXqMza5uDL4jHZbSrmsisYxVMEOKII72ttxV96aJG/Atg533OJIfaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4QTrN7P; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so3891088a12.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821492; x=1779426292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDkpadn+ZjaKcKAsJOyp81emebQ7DUn9DAmh7WWqOus=;
        b=D4QTrN7PD1+oEKiUNYqxgR6J366MMhDtyJ+JYW0kcNKsWypaLjkETtulk2EdPwf3W9
         Q2F2+ijWPXcekrxR31bqYEK4pshu8dL1Ut093yyD0G1+kCbAoF/2DtmgL62gdXGftvO/
         8j/ZFG7RYgTsEKysbLS2v1z359E4rL9GIrIltW8+QIItRK6rEUKSK8CH6Wzj13Q3dQOf
         M4BhtUd2KBqCfpecKwfCUxkIQo1cUit6aW1sh+ZZuQZ4dj1g6MkzdcSEc7PuiYU22G+d
         ErVJeNNXdDznoojXLA9fasljsaXnuMUzfFXcVuHanUrOnEtnTuqK5fTO7PQ+iYp3ZcBC
         Ukuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821492; x=1779426292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDkpadn+ZjaKcKAsJOyp81emebQ7DUn9DAmh7WWqOus=;
        b=RIzHGfvMM58JV+MInt79DCsJtPbqkrsRGJcJ1LscbmIjhIVBkusxX7j1sxv1F/mPxN
         0LRA4yZTDGrpo4Xs1hgpP7sVbpQt58WfJ3onefNJ4w/F7DXMfLyztWyJwGB1T47Jq8SS
         Kq0H+R+2el4jzlqwv4zxRwukxsZ9pJKA4Ag1eCSDBmGnaAhy20LtCyOFF07tq/u96fVI
         TgQ+w2vzF6eMaX/iZzQs41AaUSU75McogEgs9qyl2HQrV/AY6KLbAT0P6WSYmZaWTuKn
         Q6HWHw13OgagbkD7Fo5OGbyEcU0jStJgdgW1HAOiV7P1TBqHthax9a71SgMVu1zla2Ca
         ZKXg==
X-Gm-Message-State: AOJu0YwNJ+6geYjezUx9EAZ1GfvzkdrpgBcO8iA9jVrHJtJ7ym0LGDo0
	M0y3cBiAcXAvaDdFdxtBB4g+oXj949XG5ytGJYUrQmbRax3zUDv8lDjU
X-Gm-Gg: Acq92OGzYSHKHui+gJ3GyZ6IYuFP2rrYXUYb+zDgpCnCxi0pmoDq+ixSliODDF+TnPG
	WI0Aun4C3xzhjeJ00ec/RmCJlx70hqcbt11Ope9PPyw2c4PLjBRU/JfwBP+4Hp+kLzjrniWcepq
	RkeJX+tHvq6lUn3rdgCEbxKPJiJuVUGvQEvnmbEgz9DcoZPbcLFPH7Q/DzQHYly63fq4fSevSAF
	d9qH1ePAJfBzhboGa7drG2tdZsKNGM6H/fSuFpdrsBvFeFenZSgEX23KYMbUjMa1Q3dEYRUusCm
	Nfq9pkA3n8qZ1WvYUIcTRVPnvQiVzG9Rq5+M/pWLvy4nr0cj5m31pmcufG4jICsIEvG9TvC2IYH
	DXhTpS69UQIb5nf2SUDbBPNhmk7+kbkZF/n7BJTx7Lz1+GrkesWRX5inPs94sRKgNyYKGTslKPi
	OmxY8BDNaQt80ClAAbYDtVZkcq4fcmlqM=
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id d9443c01a7336-2bd7e85fce5mr27404215ad.6.1778821491625;
        Thu, 14 May 2026 22:04:51 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm44205615ad.79.2026.05.14.22.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:04:51 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>
Subject: [PATCH] net: skmsg: pin the delayed-work psock in sk_psock_backlog
Date: Fri, 15 May 2026 13:04:37 +0800
Message-Id: <20260515050437.104716-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F5F454962D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288185-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

sk_psock_backlog() recovers the psock it operates on from the delayed
work item, but it takes its lifetime reference with
sk_psock_get(psock->sk).
That reloads sk->sk_user_data and can therefore return a replacement
psock after the old psock was detached and a new one was attached to
the same socket.

In that case the worker locks and drains the old psock, but the
reference it acquired belongs to the replacement psock. The exit path
then puts the detached old psock, which can underflow its refcount
after the last unlink while the replacement psock keeps the leaked
reference.

Take the reference on the delayed-work psock directly with
refcount_inc_not_zero(). If that fails, the old psock is already being
dropped, so skip the detached backlog instead of processing or putting
it. This keeps the worker's get/put pair on the same psock whose
work_state, ingress queue and state bits it manipulates.

The buggy scenario involves two paths, with each column showing the
order within that path:

path A label: detach and reattach path   path B label: old backlog worker
1. The last unlink drops the old         1. Delayed work resumes from the
   psock into sk_psock_drop().              old psock embedded in work.
2. sk_psock_drop() clears               2. The worker still sees
   sk->sk_user_data before the old         SK_PSOCK_TX_ENABLED on that
   TX state is cleared.                    old psock.
3. A new attach publishes a             3. sk_psock_get(psock->sk)
   replacement psock on the same           reloads sk->sk_user_data and
   socket.                                 refs the replacement psock.
4. The old psock is still queued for    4. The worker locks, drains and
   delayed backlog work.                   finally puts the detached old
                                           psock.

Sanitizer validation reported:
Non-fatal target warning: refcount_t underflow/use-after-free warning from refcount_warn_saturate triggered by sk_psock_backlog putting the detached old psock after last_old_ref_before_put reached 0.
use-after-free

Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

---
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -684,12 +684,12 @@ static void sk_psock_backlog(struct work_struct *work)
 	if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
 		return;
 
-	/* Increment the psock refcnt to synchronize with close(fd) path in
-	 * sock_map_close(), ensuring we wait for backlog thread completion
-	 * before sk_socket freed. If refcnt increment fails, it indicates
-	 * sock_map_close() completed with sk_socket potentially already freed.
+	/* Hold the delayed-work psock itself so teardown synchronizes with
+	 * the same object whose work_state, queues and state bits we touch.
+	 * If the refcnt is already zero, this psock is being dropped and its
+	 * detached backlog must no longer run.
 	 */
-	if (!sk_psock_get(psock->sk))
+	if (!refcount_inc_not_zero(&psock->refcnt))
 		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {

