Return-Path: <netdev+bounces-128004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05C977759
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768611F25478
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715E1779A5;
	Fri, 13 Sep 2024 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdVhp7j9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434591459F7
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198118; cv=none; b=GRMRjNajUyU2M+VgM1/f2nEZHERiPXGZObBueGEpltkoCnZgp3BJyBtdslR4OoOZBMr+P6RP6B+/01Zjz5KQEinDGyw7GZuOYqgMqToyXAbbz/JbFTsUhK0vD/Ckj07tc2J9it1Zjo7NaR9wFh6Pc1enAjql+J2q+cEYqS2LRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198118; c=relaxed/simple;
	bh=tXIZGGwOAe5zgTwiSn9fDaGoaLFWMTwvFPcHOj5kL3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlsrCGuohqNic24nCanQiQYDZmx6zvfPjYfZLfHoACf7G3U+2qEc+H3IuN3UivDKMZTfMYPeBKmR071uNV/xw249wXfIz/JYkHudqunJ8HN2dtNsHdEPe+WMYBQ0fQmJCieI/Jcu8rHPVsUtp/cSPCQKAZwDidIurqrN/o8XsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdVhp7j9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso2950428276.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726198116; x=1726802916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3YOB4wcPo05ff7ziEmXI37nLmZ1RxeYVhodrn8b1/4=;
        b=JdVhp7j9IErM2XyTk5NIBXzgrDyXvoge+D0FUXedaqjfOHlmLl/GhcL9ry45wR8Q3i
         UcpAcT/DIdoWvOlnBfViQ4ptlfDtY5NKWl6m60p79aykcPAOyvD3uNCxFV2pcRubqoxu
         7dE1FCcNFnEhWqOGbQA977s94ieBQ9OxJhrPXYRaSBokbiK6aZtc6WWD0czwi+SbCBkt
         gUyk4ibjXSX3RPwmPg5m0gVgF/emSzC4CL29KuuSUfeX4+mHLOXQU5j8C0BndFOameBz
         qzs0olT1Z5kzXxBQJ68OWDSVEal8Xfn6TLrvHE8quJ0foAmj3lk0Qun/ZKIfH8zUHw0e
         fRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198116; x=1726802916;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3YOB4wcPo05ff7ziEmXI37nLmZ1RxeYVhodrn8b1/4=;
        b=obZHjKeX7B07VA3pjObRxWu6UJrD7ZDLkreC/V/gEg4zOyPyZdM8SHta+6/lyCzxec
         CrOEasTu8f+uNFfBVcwjT49/iP6meDNZ4/1i8J3NyhFwH7WmNtD0DXXZAxb95uaSoDET
         Wf7eNMBfSymUKG7m+YMJvdqKcP/ougdWnej3RC9P6pGTBCJmJJmk4F5J2WQbPjfkLTpY
         PCZKc1QKVQ+D+slsEphi7yQUgCVeE9L1rqjT364m1h86rgvP0exn57VCjsFLVa2q/Pth
         EskksJrEzuyS2lhLXT6ezQl+3VE+ISI11R3o/0TjBtDZYQ0f4lbSAjdiJf4jHEVKCTiL
         dHAg==
X-Gm-Message-State: AOJu0YybaqjkDGrfA/S0fWSRgzZmUgqQqv2K/eZ1RpSlfx6nuyteIVSY
	qWblgNScMa6jfmbseMZn3n91f2So5FYqJFnuOMqqZizC5vxoSikrCS4c17jQjoehwhwCHqZEupI
	2NTJQMQamTpBIq9J2qhQ1suRacd2wUg3+OZdT/kqCTG5Tl0/PECShOpJNbriCA2RVD6bzLOYjTF
	LAX3F57A/LIPQwvCC2IS61Fvzo1QabSXCE8UMc42FHfD5yIFBOGwoVlw30btU=
X-Google-Smtp-Source: AGHT+IGv+5TvG476u+LirlfcJi6YSkhfRkMcokm6Ese/NoGd2WPBzbHbdaBVEcQNv5+2fD/ru+B02CLKZxwhvkLkCA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:8747:0:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-e1d9db8d00cmr14365276.1.1726198115993; Thu, 12 Sep 2024
 20:28:35 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:28:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913032824.2117095-1-almasrymina@google.com>
Subject: [PATCH net-next v2] memory-provider: fix compilation issue without SYSFS
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_SYSFS is not set, the kernel fails to compile:

     net/core/page_pool_user.c:368:45: error: implicit declaration of function 'get_netdev_rx_queue_index' [-Werror=implicit-function-declaration]
      368 |                 if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~

When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
as well.

Fix by removing the ifdef around get_netdev_rx_queue_index(). It is not
needed anymore after commit e817f85652c1 ("xdp: generic XDP handling of
xdp_rxq_info") removed most of the CONFIG_SYSFS ifdefs.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:

- I (mina) sent v2 of Matthieu's fix.
- Remove the ifdef around the function definition. It's not needed
  anymore (Jakub)
---
 include/net/netdev_rx_queue.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index ac34f5fb4f71..596836abf7bf 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -45,7 +45,6 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
 	return dev->_rx + rxq;
 }
 
-#ifdef CONFIG_SYSFS
 static inline unsigned int
 get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 {
@@ -55,7 +54,6 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	BUG_ON(index >= dev->num_rx_queues);
 	return index;
 }
-#endif
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 
-- 
2.46.0.662.g92d0881bb0-goog


