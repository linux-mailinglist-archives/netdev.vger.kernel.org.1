Return-Path: <netdev+bounces-217432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC097B38A5B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BC61716F0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6A2F2902;
	Wed, 27 Aug 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY4w8gJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E202F0C5F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323679; cv=none; b=UXd0Y2mnJZj/oNqPAXY6mKCvpX1z8sslc5cjO8CLVjE2gXVhDaHV4aOKIxDhB/usdDZh9qKXJ8BcgJy09JlZjHX4wfLbGHlfk2tvPE3HLR/wPO2YYWv1jpUKn1qLrdbiY1xEysbDwgBVG3ALq7EkZv/WUWjxjgiVHR3RVjaNBJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323679; c=relaxed/simple;
	bh=lOFYn5tzMu+BIyj/3iv2zb29eZrNyF3mgyqQKezrkec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hkKmWeFaR8xHWBGdxwWVGjfdP0WborWF9KV1OhuP+KJXmaPRo5Umj/bcXRGs+kE4YT8MbJLpvLdnCmOjTTis1n9bv6NXPil1mZCDFZK6HEF3fXn+coTPzEkGzfOhcnSKNGwVqq09kYYKhQsvOm3zxwkM/gK2x5RE7oHXNK9H+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY4w8gJu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327594fd627so185242a91.3
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756323677; x=1756928477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=sY4w8gJuo5Y59YmV/4QW4Ysfi/2U5cRw/Tp47qbJ363iDCQL+0V9+M0nQ8bsoFFUs3
         iV/ZZDLPT+gh1gwQ2aX2WG2J+Fij2Wc92+fBNfjRlc9KiwEM5RiZLk1YKXfmyE26hAHs
         3hGACwOWDPuUqX2VlNsVorZkl2xEd4sFKDd0H8mSdeLWBdj/E00IrpjKnWorxdHAXlUZ
         +oarvHpOTBwrL9iqg+AiHwNyvXBM8L/tPyFJbJvnxzpUZU+6HoTW4z9wIUBX873TrejZ
         1A1yceiJtm3SY7pfM8caoX2FxEn86WjHGnOwsYOAO590cQuDqXWLarDH0x0+jHiiGTmk
         l+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323677; x=1756928477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKdkhp8v27Li0GOsmRqKq40Y7Pxs7HR00OYnU2c0jjU=;
        b=I/VVlf6PStNEy6t7uM2EWc4RpWzFUIeG/lsqOQaOHoOMB0IOL0L2LjMm3BCiyKVebr
         bFdXoDme1b9+7oJy58wmCOUFrNLTili/GI3x5M8dDzJcGvzYJVYs0pGpD16BRRISaZ0W
         2OWffmfVePl3s+i8idtgE8Cy3iaviwstFEcr+54XiL3bfw+cdbFTy0cqYDfef/iHKu+O
         fxg/nQE2a1CmPmOyo555BglEPdpGgYCYNnBRRERuRlx1TumxhLoRUS7Sipxpkvf8mo94
         w2aFyEg/3ToN2gXGKqD4Wu+9K9oWJR/T1hCPlRycAPo1+MzZGhT7h5/VLztM9WHbrDs+
         MHRw==
X-Forwarded-Encrypted: i=1; AJvYcCVsTHTVLGcv4SFTpfhb98ZOn8lKehv+82IYyC2auuT6YP2dldQkfuBqPFTOHmjs3zOg0L5eJNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcj9uleBsMxpfDXwJ3sObe+QwfhBxBHMFB8yMEt5ppPgnRO3x
	62qXsNN6JySu/d7DFWMcB/K31mCCssgTkdkhcQWFSRYL6lFAC7iuk+M195ypdWXssjvjKoZdnOt
	aexpJ8Q==
X-Google-Smtp-Source: AGHT+IFkp3cSkHK/LCzu7rsgKn502PeqGnc81s3u1mjxkvPKl0aSkQfYxtfmuXztKttrbNAZ69OCb7JCKaU=
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4f:b0:324:eb2d:7537
 with SMTP id 98e67ed59e1d1-32515ea1b2dmr27081009a91.20.1756323677599; Wed, 27
 Aug 2025 12:41:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 12:41:06 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827194107.4142164-3-seanjc@google.com>
Subject: [PATCH v2 2/3] vhost_task: Allow caller to omit handle_sigkill() callback
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that vhost_task provides an API to safely wake a task without relying
on the caller to react to signals, make handle_sigkill() optional and
WARN if the "unsafe" __vhost_task_wake() is used without hooking sigkill.
Requiring the user to react to sigkill adds no meaningful value, e.g. it
didn't help KVM do the right thing with respect to signals, and adding a
sanity check in __vhost_task_wake() gives developers a hint as to what
needs to be done in response to sigkill.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/vhost_task.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index bd213d0b6da3..01bf7b0e2c5b 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -59,7 +59,8 @@ static int vhost_task_fn(void *data)
 	 */
 	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
 		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
-		vtsk->handle_sigkill(vtsk->data);
+		if (vtsk->handle_sigkill)
+			vtsk->handle_sigkill(vtsk->data);
 	}
 	mutex_unlock(&vtsk->exit_mutex);
 	complete(&vtsk->exited);
@@ -81,6 +82,13 @@ static void vhost_task_wake_up_process(struct vhost_task *vtsk)
  */
 void __vhost_task_wake(struct vhost_task *vtsk)
 {
+	/*
+	 * Waking the task without taking exit_mutex is safe if and only if the
+	 * implementation hooks sigkill, as that's the only way the caller can
+	 * know if the task has exited prematurely due to a signal.
+	 */
+	WARN_ON_ONCE(!vtsk->handle_sigkill);
+
 	/*
 	 * Checking VHOST_TASK_FLAGS_KILLED can race with signal delivery, but
 	 * a race can only result in false negatives and this is just a sanity
-- 
2.51.0.268.g9569e192d0-goog


