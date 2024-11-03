Return-Path: <netdev+bounces-141267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A149BA422
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 06:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D7FB21B34
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56416849F;
	Sun,  3 Nov 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KYvVsQVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B11632F7
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611501; cv=none; b=bOzPzqPDVwqA0+q8mwpntcqXv3IRrzUksNwBPgDfm10LdrdTWE6oAw9wk+TuKktZ99mRbfMQTtvqBbzw6pWNClEs8Mk3VDHs+SGE+JEGi5ax0yjqQrt6vgI2X7bWPmYalepDYpMgqg5+/XVxii7eIjg/B+/wn+rQ4YAZGROgYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611501; c=relaxed/simple;
	bh=ZvawQy978AWawDyo2L5Npe51s7GUMbBNxiumv6HwfAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7J7dKuy0Ex/wrb/rpLU9MKRzl36nN8+pbBWiCuoZz96Jwa8uq+6a/rmyOmJQJ3f0C5tVasSaVeXg2OEtJI7eN6K6/uMpN6HnAQoMUBPMZQi91Avu7RT6bYDNNhn+0sw73NTWVGRANFobzwwZRMz+ugA8SBPeISsxB3jmbf4FPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KYvVsQVK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so2410691a12.1
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 22:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730611499; x=1731216299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=KYvVsQVKvp/bHpyN2IpV9POnVcijs8LdNoMPC5HR6asXRPEMejniHKJX2S3+XvZ8iq
         HZjcBchvjy4e03fywIyeLiWYsJI7EFOYKP1wQ57oW4Asj376oLxOhC2zLFTb/Z5QilgG
         Pn2zy+RRfzdBx6j/zswV7GY1uDO/yx2L2Xbrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730611499; x=1731216299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=oTuPSo4K0oCmYAuaA9sIsHtKRYBj/dYkRUE2wiGFG3fjhuCdSStaJbh6y4AuvUDfmL
         lXo1Fd+a7rQcTgkyf3AS8mezK+fGVjaVr5Vs+hMXT2i7qISG/AyATIO6rBMzPrCeHkQE
         wZFQV/g1oy5z+CrgIWFv0PBggX9UZkDZ4fxg2ft8RRx1sbrPDRH6i+Yx1v+6BhJf3/H8
         h0kLGhtLQq5rv1jKA7CWLRr0ML4VubAgTidHkiqp0eMLDZhZywLDU4YkYBL08dJE+wEn
         aOkfqRBwC3mlFsTUxf/G467Z4jP3LkulnM4YGIy+zSBhKLZZtwwaT4t5WCDYRC+0WCzD
         3BIA==
X-Gm-Message-State: AOJu0YzvW30BLBvzzLwfWproCXdi8hwZZwr/NMrsgJxo684ZxL1aC3n3
	HADWDEsC6dwUn7335IitTMs7H4uWHdK8JQ/1wKKUrTbY2PrIT9mLBCJKi7G9oso3dfcBVGik18G
	eLNraQyFO1NYif6eTtqwZjzrYz3B1Ys52xztLf6+7ZHENMyMJDH5+JjGOmA81SBG078wy05v2ff
	giImSBW8Jgd1YnFCZCbtq9SEDNKW7C9y5ypDI=
X-Google-Smtp-Source: AGHT+IGIYltp82PEjPx2cFpKwx1ZvWECv/q2F7DRSSnHSlDpMIPGRQwlEee6s7qmdPap+mee8hEJXg==
X-Received: by 2002:a17:90b:54c5:b0:2da:7536:2b8c with SMTP id 98e67ed59e1d1-2e93c1f3c53mr16432709a91.36.1730611499100;
        Sat, 02 Nov 2024 22:24:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac02acsm5896036a91.27.2024.11.02.22.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 22:24:58 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 5/7] eventpoll: Control irq suspension for prefer_busy_poll
Date: Sun,  3 Nov 2024 05:24:07 +0000
Message-Id: <20241103052421.518856-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241103052421.518856-1-jdamato@fastly.com>
References: <20241103052421.518856-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When events are reported to userland and prefer_busy_poll is set, irqs
are temporarily suspended using napi_suspend_irqs.

If no events are found and ep_poll would go to sleep, irq suspension is
cancelled using napi_resume_irqs.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v5:
   - Only call ep_suspend_napi_irqs when ep_send_events returns a
     positive value. IRQs are not suspended in error (e.g. EINTR)
     cases. This issue was pointed out by Hillf Danton.

 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..83bcb559b89f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -457,6 +457,8 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 		 * it back in when we have moved a socket with a valid NAPI
 		 * ID onto the ready list.
 		 */
+		if (prefer_busy_poll)
+			napi_resume_irqs(napi_id);
 		ep->napi_id = 0;
 		return false;
 	}
@@ -540,6 +542,22 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_suspend_irqs(napi_id);
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_resume_irqs(napi_id);
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -557,6 +575,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +814,7 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	ep_resume_napi_irqs(ep);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2032,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				if (res > 0)
+					ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


