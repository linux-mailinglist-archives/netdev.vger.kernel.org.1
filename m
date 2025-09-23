Return-Path: <netdev+bounces-225455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD813B93C26
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF36481160
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10E1A23A9;
	Tue, 23 Sep 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PctZEMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E12BAF7
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588886; cv=none; b=ltwExGc37Rn1h3XbEd+oKZYFPhicj+2ChQxIUDx2zBUEIYDLvAXQ/Ts+PRFd1FpP5om/+RNPdmvoI5oHuo2oopSfy7rQX9FTMlokwBiev46TMko/vFATEaAha3rn8zqGmsh/wuc1wwTGNaY/htQJo7UBhjRd4f/MSwYO5i9SlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588886; c=relaxed/simple;
	bh=klENf0wzMty5iQv/3JYwYFw5T7Z5pKzGnQIwGjZancI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lIsmAdliDbHo6w0m02MZrAMzTZ3oYkWLNyRFvyLOc2M0EJTxRyF+KqbLLhboVI3on/VwJtXWA+KFN5P4MOg6dZjuHBpiM6Gdk0ZlhQm8+Ghi+sfzxB+ZGMBXBn6MlxvWZsAuaPjnMv45gcSAL3Z3U1u/7CtXEpBmZ+68VBwYGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PctZEMZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5533921eb2so1874955a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758588885; x=1759193685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CoVoArecKfYDk+5oCQTM74H/Mow91nnMdkU2wKUzm38=;
        b=2PctZEMZigXKPG4MEeUrSp9WB77hasILNmJCqj8xHrY96cWtZCwrNY2KTjXlYkY8vq
         gmcLRvdmpUoBkXMKCSikvzh4x5OkEhf2Bw7iORgAI5j3ieh6phxiz78+T9EKN1UBjnPM
         xVCvq2pFGcYCB9z4/kfxcwY5Z5bmhyL4+BPaqcdg0PkBhip0dG3kAJoB+aQ0h9Kls/Tz
         3AdiOobH5ouDfAQb+uQcVIKaeDSVGQXnHWBd0WUn8TW8uLBP4Zf+j80knJJ+DgxXHDT5
         H59BqZ6bMJOf2+9zfczYRt3LPpVXnjGZClXKNRu21ivkm3fZM8H9yakVYgXCb9xOV1xs
         uZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588885; x=1759193685;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CoVoArecKfYDk+5oCQTM74H/Mow91nnMdkU2wKUzm38=;
        b=Xpw8JWq4H0IZ15+rkfJknHYbVOQ7bAVhnID229zhbk+OaZga3aSRvOpAxOhB2X5WLr
         n4NRs+WiEFo9iMrKbgB3KCLkB0QrYYTUre85UZGxA5gMbvUvbHOevH8CICkKXLUMbcuU
         +cglRRePyRp6znQSxmGrgSQ9Zgq8YqxeAWS8+IogCCPh31CxbJ5QUldU4lULDwff1PTc
         TtBSfymfSIzTfXAyKZJ+qflkNEGGJ3m7r/WmMpFgFg8/zcnzFDVdqOdu/jw/+JNHHTDN
         05vhgp/kqV7gFkwivBE8EdpOAQxCPa8kSz7F+xf8d7Q3dJ61O/kk2IC4RKZm0oWymy1+
         B7DA==
X-Forwarded-Encrypted: i=1; AJvYcCVy4AMziuler3+Ibjan3g4nCMv+ygvSkCEMXHy+vCAAvsZwIUfKkU/6ocBuS97tl/0GX7cmZ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuMKAgkYzdcIXvTN8YlQmo77D68M9y3TX0NljQSRYi3e+rf0W
	qXj1Igd/DRZspswL0XnO7kPeiHG8zD8A6AI7fGF155ECWwpTHtxemg1AFijIbddg7OtQARQrBV8
	zcMjs1Q==
X-Google-Smtp-Source: AGHT+IEP1jRGh1tIoYGJNDs1rFaGRSenygyFIi1ySAfun1mEZ4lgvCKMueDrR+ga8OAqzR4OJklNqqJHm0E=
X-Received: from pfbc15.prod.google.com ([2002:a05:6a00:ad0f:b0:76e:7024:76])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9994:b0:250:9175:96d4
 with SMTP id adf61e73a8af0-2cfffa79ee2mr1129568637.56.1758588884604; Mon, 22
 Sep 2025 17:54:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 00:54:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923005441.4131554-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tcp: Remove stale locking comment for TFO.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The listener -> child locking no longer exists in the fast path
since commit e994b2f0fb92 ("tcp: do not lock listener to process
SYN packets").

Let's remove the stale comment for reqsk_fastopen_remove().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/request_sock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 63de5c635842..897a8f01a67b 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -77,9 +77,7 @@ void reqsk_queue_alloc(struct request_sock_queue *queue)
  * a simple spin lock - one must consider sock_owned_by_user() and arrange
  * to use sk_add_backlog() stuff. But what really makes it infeasible is the
  * locking hierarchy violation. E.g., inet_csk_listen_stop() may try to
- * acquire a child's lock while holding listener's socket lock. A corner
- * case might also exist in tcp_v4_hnd_req() that will trigger this locking
- * order.
+ * acquire a child's lock while holding listener's socket lock.
  *
  * This function also sets "treq->tfo_listener" to false.
  * treq->tfo_listener is used by the listener so it is protected by the
-- 
2.51.0.534.gc79095c0ca-goog


