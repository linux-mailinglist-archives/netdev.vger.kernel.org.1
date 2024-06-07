Return-Path: <netdev+bounces-101670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4F8FFC90
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDD288743
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F3153593;
	Fri,  7 Jun 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YTPZwTQF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qD3siSs"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800014F9CE;
	Fri,  7 Jun 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743875; cv=none; b=pn4k26HR8BFujtZKkTPul+U8NleyqnceoSma9gXHrD4ommjqo7KFpDj05ynojw0F8bw4V7L8hNwbzTQzmH6sfwdsuZtpoZsnLRViNUNMscEH4lLZMyjmPbHe25C+UtMweBhpenc9X46pzdA5vLyJQzZOW3o7YnqtO/9FWgIPuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743875; c=relaxed/simple;
	bh=rL+z32yJ/DnaCZexB8chXUJAXOMyL2Zx2vFkJ71eg5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa/F53+yCQvW2dALz/3zWMtKfG/+B3vit9FaVMQHqTvmIIM9ncrBUdsHNhPOeJ3hLvoZsesineIBTr+xeE5KFhw9WuruQjtPWpD1/RM5I6a37eEme0LrG5YGREoQhaFQndXIsnWMZsuHjoJ5jRDyhk383GOP8wiq0+nommuwmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YTPZwTQF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qD3siSs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717743871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trq0tZG6+CjtFvIqf2pIYKAyc6gpPZC0W8KSFjMqnz8=;
	b=YTPZwTQFykR5A9FhnzcQsYnRLdc8/+51Ccb3trweEkjJ/FTHH6f+LqFjWj4umBSqLYphOe
	5pLdsU0pyc9X63HB0VvOJeF2PYIOR5528u2yEOga+XC8M2BRq17Z0lUAbNfbr9J6/TZ8PX
	WRAfVYlN3PUX0F20zQKH6tDiz/7HJ+8YnJb5TwJxuKGkaYilI2ObzRSI5SNmH/IBxciPCW
	ZzwfVAjp7ysDbx05r5BtrMMYwuJNKK0fL5ZE7NH0lkcHG0OUR5G3pA1pIlzHiyAa0UwX5h
	gQwVpR2MWjhOuRH1PgZU0GkVcZFe0kVlUxM6exJYJS88J4mitacYLszsLU8LZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717743871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trq0tZG6+CjtFvIqf2pIYKAyc6gpPZC0W8KSFjMqnz8=;
	b=0qD3siSshqfwzGJ0p0Muvbs+WmBjmK+4IheA1flXnQSPqLEZrodW7OM8aQ354GhUgx0shS
	Uystby352+dAdeAQ==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 net-next 01/15] locking/local_lock: Introduce guard definition for local_lock.
Date: Fri,  7 Jun 2024 08:53:04 +0200
Message-ID: <20240607070427.1379327-2-bigeasy@linutronix.de>
In-Reply-To: <20240607070427.1379327-1-bigeasy@linutronix.de>
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce lock guard definition for local_lock_t. There are no users
yet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index e55010fa73296..82366a37f4474 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,15 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
=20
+DEFINE_GUARD(local_lock, local_lock_t __percpu*,
+	     local_lock(_T),
+	     local_unlock(_T))
+DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
+	     local_lock_irq(_T),
+	     local_unlock_irq(_T))
+DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
+		    local_lock_irqsave(_T->lock, _T->flags),
+		    local_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif
--=20
2.45.1


