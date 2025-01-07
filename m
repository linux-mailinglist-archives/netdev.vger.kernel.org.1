Return-Path: <netdev+bounces-155943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4969A04651
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EACF3A5CA7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658D1F4707;
	Tue,  7 Jan 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yol7MWqi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8F1F428A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267288; cv=none; b=sXMEbdnp3SiXY7jEF0c0/tMhHNucHLq9ZvuDXcURGXdSVWgahU+CSlEdzjsBujQWY2f2uWU4oyfzbwzbYZfb/wtBtvGoklvyB4dVBsax3WypziqlSq9t9TGbuG/FK8/+/DxDUCfyU261BkM98p97A+eyiKa0SqrAeWONPZRmjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267288; c=relaxed/simple;
	bh=8KUvX1mipGlvZnr3pyDyRpQyKInPgruNqY+hjvSMHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uQ13QchXZT7qP2U4mTeSNkdw7WlVxT5ELY6uB0KUa0nkw9YxDn0xWD62H5RuUgeBq4CHfBzK8nSAkA4kfdGGv1GP3MOOJl0/7FZ0OPUtVXB5lq2JU3nLRFk2DC2esDdOh9S5AENR6QvV18e1UCiuDgHMUOpkE6zAzb2l0BLzi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yol7MWqi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736267285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=0Hkc/r/J05Eu+h5oxPQEivv9ALULDWls00aLQM9qKG8=;
	b=Yol7MWqi6WkQ748ypyam++R+ovdcCt0BKtgQSQ1ifYScusYQ3nOrrTpIM8nEp/37VqmhJu
	O1rrzCuq9MPa2Xjf58Ig4p+yZfPOjg6cA3nQ5yuaTak63xTmMnPOKPtPupsqWAEdQSaDcx
	rAY5DSC/uBuIT0bcMYYQyJF0uVPWogo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-PDawU3_sPHyeaIXWivLkAg-1; Tue,
 07 Jan 2025 11:28:02 -0500
X-MC-Unique: PDawU3_sPHyeaIXWivLkAg-1
X-Mimecast-MFC-AGG-ID: PDawU3_sPHyeaIXWivLkAg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 367B219560B9;
	Tue,  7 Jan 2025 16:28:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 197E01956088;
	Tue,  7 Jan 2025 16:27:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Jan 2025 17:27:35 +0100 (CET)
Date: Tue, 7 Jan 2025 17:27:30 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	WangYuli <wangyuli@uniontech.com>, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 3/5] io_uring_poll: kill the no longer necessary barrier
 after poll_wait()
Message-ID: <20250107162730.GA18940@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107162649.GA18886@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now that poll_wait() provides a full barrier we can remove smp_rmb() from
io_uring_poll().

In fact I don't think smp_rmb() was correct, it can't serialize LOADs and
STOREs.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 io_uring/io_uring.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 06ff41484e29..a64a82b93b86 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2809,13 +2809,12 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 
 	if (unlikely(!ctx->poll_activated))
 		io_activate_pollwq(ctx);
-
-	poll_wait(file, &ctx->poll_wq, wait);
 	/*
-	 * synchronizes with barrier from wq_has_sleeper call in
-	 * io_commit_cqring
+	 * provides mb() which pairs with barrier from wq_has_sleeper
+	 * call in io_commit_cqring
 	 */
-	smp_rmb();
+	poll_wait(file, &ctx->poll_wq, wait);
+
 	if (!io_sqring_full(ctx))
 		mask |= EPOLLOUT | EPOLLWRNORM;
 
-- 
2.25.1.362.g51ebf55


