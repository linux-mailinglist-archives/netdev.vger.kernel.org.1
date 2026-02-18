Return-Path: <netdev+bounces-259336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG5ZE8b4lWlMXgIAu9opvQ
	(envelope-from <netdev+bounces-259336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB051585B5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF60630013BF
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABEF334370;
	Wed, 18 Feb 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPfvwdiW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012B533EB07
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436207; cv=none; b=boHcqzpPTi2WosuM3WK9aww2E+TIlg/SjaJM0HGTzL+4CeS0J4XgiBRwUEYjwEecTgP79NwbC3LGJvDjw+d4MYmiJUT1escFRM7IYOxKU/0XvszODG3AIrtPSDD8zIVeW1G/m+dS/jWlCsnpieIG9xx0wrrY5PmZ2ZzZq9hFJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436207; c=relaxed/simple;
	bh=ryk1XlFpYkbWCCRIEYCdmMdH4Bm5ivPc/TwrajVtluw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpMHBveTOY/K0iaW5HUb9u8rqTcxg9mcu6LVkiok4tarrTfP7J7Qgf41dW9M7NoYtgUGMSuTvJQ2njVnTmOMnCyVqgTqyVE1iWrBl4dy+dCqiwwLKq5fETpvRITzQTxXkcNVe/+LK04Q1F0zm41exqrd89nJvYHQbWZ8hfBP3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPfvwdiW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso948615e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771436204; x=1772041004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opGeJXdqBNHSNGuTpufEOdqG+49HpE5DgTtWk7Ja0tg=;
        b=fPfvwdiWDb4Z/WTrRpEyjGKWx0uF+c3WWRdZpfUgGpmGf/wkqSJQDTsZfLyUtPb8bR
         3j/uHqLognwuuARMvQKskx8S54cNDCrd9ueIKDN9vt8wb9SZdGdXR7oSoAbxaLMTjn8M
         wyTG6ibzHAQZNvaMN9zgUG1+h0oLkSFuF13NONi6yvCohPCC1NUIsTIDL6dpklApzzxh
         99gjgu2i88SLjrIjNZCndX4iVqVBUcR8kMfPRBjin5emSni5dfRSi8JaVBvepj+BeksG
         +Yb0AUnaTtWu4svK6bkYXSMZER1LQU1gy5XI2j01f2/eP09DSQo9/YJ0g0kRstVAw0m4
         XGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771436204; x=1772041004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opGeJXdqBNHSNGuTpufEOdqG+49HpE5DgTtWk7Ja0tg=;
        b=pGQxVhUkPftJszsz8kQTFPsEKPOuB9rKvbj3oCuxSOo6xX7hfb5aPArUYUpjtbgcYY
         hCxGtotcnC34UJ+V/IVNg44xIneEJQDxYyHKwRv8IZbIV+699uJhjuXRJ2fd0eYDoitq
         NvLk/10blUQIwdku901zSLL8+fw3Vgvncn6K3cOzPL/T6BMKLtM5ryMv74vY0VSF5yV2
         ++1csO+DPzCwDoN5Aj0nzsgrvs3NH7n0WjAMlCjSXbP85ug3Bbcy23elcDIpradn01zq
         ph+rrxjkir6GEV+4Lx6Z6RoZy/3epw/jKeVjXRgnqXGBpaRABSKF1YjW25ydUq92kQ33
         Kgig==
X-Forwarded-Encrypted: i=1; AJvYcCXlE6lfkmkq0D8BCLtZ6npGoF+XY1vd2YPkAFJ6B9Coj1Y91NcSqvYhcy/DYQCvkRLqU5N/BUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiRIdrzyIF76V4LwqaGC7KKfNiVG5dIYLXZWIvQq1Rc0uhcj3
	hobdvdxAnfhpNPIoumFNzGPD/vHrxjgvr9ZEvU+crLiv4pJpnu6Lqnd0
X-Gm-Gg: AZuq6aL9K3xN+vq376vetbcitgHuKA25KmYyyLqLUPkEzNiV3+95sAb1a1fZOH9ZDV8
	RXTiMwq8tsHA13KUZ0aqUxA5Aw0bJ9DhdWVu5kVij/G56Cz+iT0UW5mdbtd1pRY3BJMeK2nUkOU
	KdILaye0rWN6YF+viNuvFe9dyx+NQ6JVGEkRDajOScS9+f/8sqIqUxyKX5ZKbva2dUEUrYDtHwa
	sYy9GB2SSL5yyeqp0vMLe+CM2J5F2SB6u6mTS/DavZ0ypnrlAcfb4LyS4Mqu5nQ8OjCBoEP9Pp+
	1+C1tJQpvJUFTbAKS3GEpI36e8PZTICoVEKClqNOhJQBizEDy3s12DJo4Do+9YqklZ/11rayfT4
	O8/Sw9JVLo5Y+7qjkaKBX02YRamw0c4asyxUU1nuOqpWVh8Qzoqt2X8dl4rY2XKfoKfe93H2atk
	S8kwZ6o7IX2eIweVPHlFHb4un+l1SPhREkOXU+/EeGvSfMy1ymLWfL2JXgn+zHmR6qU081Mru5p
	xaHy08BonfONC3h+qnCjI2hKmNxOFFHk44D2Ja8
X-Received: by 2002:a05:600c:5308:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-48379bf78f1mr246397705e9.27.1771436204063;
        Wed, 18 Feb 2026 09:36:44 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d99e194sm464119405e9.8.2026.02.18.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:36:43 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	Kai Aizen <kai@snailsploit.com>
Subject: [PATCH 1/1] io_uring/zcrx: fix user_ref race between scrub and refill paths
Date: Wed, 18 Feb 2026 17:36:41 +0000
Message-ID: <364c2e7d4f53b26bb3133cfc4271183fcd450be2.1771435883.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org,snailsploit.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259336-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AB051585B5
X-Rspamd-Action: no action

From: Kai Aizen <kai@snailsploit.com>

The io_zcrx_put_niov_uref() function uses a non-atomic
check-then-decrement pattern (atomic_read followed by separate
atomic_dec) to manipulate user_refs. This is serialized against other
callers by rq_lock, but io_zcrx_scrub() modifies the same counter with
atomic_xchg() WITHOUT holding rq_lock.

On SMP systems, the following race exists:

  CPU0 (refill, holds rq_lock)          CPU1 (scrub, no rq_lock)
  put_niov_uref:
    atomic_read(uref) - 1
    // window opens
                                        atomic_xchg(uref, 0) - 1
                                        return_niov_freelist(niov) [PUSH #1]
    // window closes
    atomic_dec(uref) - wraps to -1
    returns true
    return_niov(niov)
    return_niov_freelist(niov)           [PUSH #2: DOUBLE-FREE]

The same niov is pushed to the freelist twice, causing free_count to
exceed nr_iovs. Subsequent freelist pushes then perform an out-of-bounds
write (a u32 value) past the kvmalloc'd freelist array into the adjacent
slab object.

Fix this by replacing the non-atomic read-then-dec in
io_zcrx_put_niov_uref() with an atomic_try_cmpxchg loop that atomically
tests and decrements user_refs. This makes the operation safe against
concurrent atomic_xchg from scrub without requiring scrub to acquire
rq_lock.

Fixes: 34a3e60821ab ("io_uring/zcrx: implement zerocopy receive pp memory provider")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai@snailsploit.com>
[pavel: removed a warning and a comment]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3d377523ff7e..0c9bf540b12b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -341,10 +341,14 @@ static inline atomic_t *io_get_user_counter(struct net_iov *niov)
 static bool io_zcrx_put_niov_uref(struct net_iov *niov)
 {
 	atomic_t *uref = io_get_user_counter(niov);
+	int old;
+
+	old = atomic_read(uref);
+	do {
+		if (unlikely(old == 0))
+			return false;
+	} while (!atomic_try_cmpxchg(uref, &old, old - 1));
 
-	if (unlikely(!atomic_read(uref)))
-		return false;
-	atomic_dec(uref);
 	return true;
 }
 
-- 
2.52.0


