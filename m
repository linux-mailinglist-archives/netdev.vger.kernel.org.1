Return-Path: <netdev+bounces-155942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31958A04640
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B37166CF6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72F1F6686;
	Tue,  7 Jan 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA6IVByO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA81F709C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267284; cv=none; b=eq7QJzSrpTUBvYDP1qHhiXxwWWG2YW7NpvdVXqw8zs5+ayuv2bCTqhyD2rbtDBvxpHoBbS/4yAx3S7ZJI8d24ACd8otpOfUaHzYhVQKAeqPE/H9fuiThWdgGgdwvXyksBXqEMjxKS85TVzsHZDhSRFCPi6Ix6yoJQikJcSQfNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267284; c=relaxed/simple;
	bh=ro5SOHPGE494O8O02u5koqsBJ1Cw4yZfst2ne6UUoFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PWv+WuJczFpUzAZKJer0qB1JpzmviaYd/EmhKwP6eyeSqbNe4QTMBp90Mu2eckQNIWofLTG+DoIvOh/yNVYT53jgMWGozk5A6tyL+mIVZ3iSi8E2M+KFc7WldiA1tJ0kx7VgwCUkQeoO6shn2H2dwYjm04oKdlsWWle95wB/XX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TA6IVByO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736267281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=HDclS/DES8DLCo0SqLfzizwQKhbxuQktc23NSw3frko=;
	b=TA6IVByO+NfMJQ6d9tGJgG0i9QtCQBaKfndTZFpwjLD7MeY10MHVUftz8axQmxb36BNE3I
	63SkZKcEKTJFpERdQjfeBLeUchSlviXVo4sanmif+TgqLjpGzlYDoHVXAtgNpMTk1oL3Ks
	UF9znpQWjHZTTxgStlGZvHlPN5jdGd8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-q_1yp0tVNjyYqvWtWX8FjQ-1; Tue,
 07 Jan 2025 11:27:55 -0500
X-MC-Unique: q_1yp0tVNjyYqvWtWX8FjQ-1
X-Mimecast-MFC-AGG-ID: q_1yp0tVNjyYqvWtWX8FjQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1449119560BD;
	Tue,  7 Jan 2025 16:27:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EC1FF195395A;
	Tue,  7 Jan 2025 16:27:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Jan 2025 17:27:29 +0100 (CET)
Date: Tue, 7 Jan 2025 17:27:24 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	WangYuli <wangyuli@uniontech.com>, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/5] poll_wait: kill the obsolete wait_address check
Message-ID: <20250107162724.GA18926@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This check is historical and no longer needed, wait_address is never NULL.
These days we rely on the poll_table->_qproc check. NULL if select/poll
is not going to sleep, or it already has a data to report, or all waiters
have already been registered after the 1st iteration.

However, poll_table *p can be NULL, see p9_fd_poll() for example, so we
can't remove the "p != NULL" check.

Link: https://lore.kernel.org/all/20250106180325.GF7233@redhat.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/poll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/poll.h b/include/linux/poll.h
index fc641b50f129..57b6d1ccd8bf 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -41,7 +41,7 @@ typedef struct poll_table_struct {
 
 static inline void poll_wait(struct file * filp, wait_queue_head_t * wait_address, poll_table *p)
 {
-	if (p && p->_qproc && wait_address) {
+	if (p && p->_qproc) {
 		p->_qproc(filp, wait_address, p);
 		/*
 		 * This memory barrier is paired in the wq_has_sleeper().
-- 
2.25.1.362.g51ebf55


