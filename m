Return-Path: <netdev+bounces-99125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B18D3C6E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AD81C213DC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9D18411A;
	Wed, 29 May 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F46TjbSi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSP2sZgF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBD184114;
	Wed, 29 May 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000176; cv=none; b=JL0Lwv4ay6ga98EF/4k4QBXwlJs92JBSa0c0RMKSMRokNGGN8o8sDgtEqOL1SWPZYbA8XqjrflVaHUSci7JKqBe5gnwflxigi0CFB+SjDFbMU1YNb06Ps9ejuG372uYr7DCQ+nisdZA1IGombMbtVhsp9haCMhNq6so20HOwWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000176; c=relaxed/simple;
	bh=rL+z32yJ/DnaCZexB8chXUJAXOMyL2Zx2vFkJ71eg5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzFGSJTjW0PN6lhy5RHrlSbvnDPuNwOanBFKBWcj5SVwwXgGZF9KbNNamh5qW8muhuQ/D4nkYg9pROsKsQRZl4xTRdhzrR9GqaIqaCs3qsQQauduPANo+SrsT/BNdDlrzIJUqO88MKstnfLjCW6JLPYihmmVVRPH9Z1GJZP0KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F46TjbSi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSP2sZgF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trq0tZG6+CjtFvIqf2pIYKAyc6gpPZC0W8KSFjMqnz8=;
	b=F46TjbSiydq7v27gjH8lDaxgMBDdInroZVg8P8gEOFiKZOGlsKjj60gl04WVfmKClb8Pzm
	EqqQPjYTAAhjqGHT8RrFN0cY1BcQk66Z1IyA8AFjyUxA48iiXpeRGKoyIoK3oy5rfZi2ER
	jPCK55xlHpAekZjeMFS914Ti7p0Emmy5+feWd6vPeiphteR8xIge5LzuWqXobWmSuwdv8g
	oh/+cLQ2qmuGV0J/dDHkaw95p3puWXTAy4r1bemv18mSCotu/KdJM4MM8QdtltTQHmTwuB
	djaCktk4GmUgyYyBcFAb3GVi/CGx+ljnTSTABJmJVwg2vGQNxNGb2HgfWhvMOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Trq0tZG6+CjtFvIqf2pIYKAyc6gpPZC0W8KSFjMqnz8=;
	b=xSP2sZgFJ/5/9QZscb9SvZI4aSEhFfPBnd6a6z99iqoaxlWFN22bY3jRKO/OfbxorUEPDK
	HpmEduc1zmuUsxAA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v3 net-next 01/15] locking/local_lock: Introduce guard definition for local_lock.
Date: Wed, 29 May 2024 18:02:24 +0200
Message-ID: <20240529162927.403425-2-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
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


