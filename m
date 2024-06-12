Return-Path: <netdev+bounces-102942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E390596E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D95282B9C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159491822F9;
	Wed, 12 Jun 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaJ75bH+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTBFBk2z"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D0250EC;
	Wed, 12 Jun 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211804; cv=none; b=lOy563Ww6fa7rxBL8WLJXJPTpF7tTv24y4QryweJjQ2w0k2UbRRvpahaZt2VayALfgwQZG7zE3M9EfWC5TPaB6LTCJjePL58OyN/yBkzXViJiwWMEP42YMKO7XAdjkPb3LDeJJCbVbfgv0IGIGgKT3/CdUZT+37FiasK/9jHy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211804; c=relaxed/simple;
	bh=g9DAnp4ACdmRClsuM2C1EE+m73Pze6Bb8H+1qFd5Hz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbRfXhla88SUHtNVcHXfIvYJmXWLcDJtcVWIDnsR7b6hS7RG5oYYE46Bux/IPOdVOQFlh3EnYWBoDmCr4hz03/WysvMgIuDg3ffs15L4mINTXmEyL2tmOtlEoOK3bRoAevuLgd7MDPw1zARe4WfSgO95E+ZDJwb2Nr92wSMfamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaJ75bH+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTBFBk2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfcLU4Oh9EtlRdw/XpgHY5VtGHocSkPfsZwBs/Vxtx4=;
	b=IaJ75bH+NsKUwzE/hAavXNfobVQXH/VoiQEPj3lDAbdUJFwYctb076fm/YlOHZJZK+DokE
	byGLOxYXBU103kajUampMHGfNerVjMX5lCi4CMuwQUIncb5g8yhXCRoYx+iTOsUBN+o/7p
	fFVaiiDs4qjCc9rYhxUYcFBPOZ6F3rgk1BkFmGhBKvrLuvJrdvXeZ+ywCKbX31RAkkpybL
	PFnPGx/HxEX3g20ol3uzyOj4WaRPCfdyDNFMdTjyFQqnhSyy73msUdAyfim6iydmbdm76L
	1kGprlQNo/CwwnL3V9JMefeVT0bLSpp+VVf1FKhpGTpRkVSqMnmbACRlbhXsjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfcLU4Oh9EtlRdw/XpgHY5VtGHocSkPfsZwBs/Vxtx4=;
	b=fTBFBk2zj9xfr2fZHLjozEnrqcKH6MuWn6vcNyD50CvIqFlQNKPHeDI9uFIyuBly2RNKvr
	rqnk9lyIyfv8CSCg==
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
Subject: [PATCH v6 net-next 01/15] locking/local_lock: Introduce guard definition for local_lock.
Date: Wed, 12 Jun 2024 18:44:27 +0200
Message-ID: <20240612170303.3896084-2-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce lock guard definition for local_lock_t. There are no users
yet.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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


