Return-Path: <netdev+bounces-140852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC49B87DC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EFD282649
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21585628;
	Fri,  1 Nov 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EOl9dT7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C73EA98
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422166; cv=none; b=NvpYImideWymWrS6ZI9P8wehkSrKsZ0eSTyBe7ShsOTv3PBfx7jNfjGDX3Z183yy1e35DfckqJE8ngIizplQYhq9u/8U+HdARZID23xtuhsT9RT0u/USwLnkSVSgSD3AirdBnPCYHiUvIQTXA0CXim3DiLbNVDgmg29gPSJf3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422166; c=relaxed/simple;
	bh=aGe3m9f05dLxeBPRr1eRz+KFLkuOg8ceUeij3ovk3Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnUdzKdWzAzv74/uO/SXMwhe86TkWMp3uUqcSW6gAk1RqoVEtgWn91Yw65aM8VWRjNh6xnvc2CY9CCARF6QHqtHQFFhDsg6RNfWWhxjrwZdrwUpUSSwqZxUtNvb7h+X8lacigYLjBWbsQZokpNlBL/RHia7VP9Lbi5n2u7yFcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EOl9dT7r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1281473b3a.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422160; x=1731026960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=EOl9dT7rqZ/XjE/Es3RJSORRnQSOmGvYBzkLqlURXuMRCAha7Loeei7+POyhP8uY9C
         4YQIvmTbQZPtVgIuUPSM+X9Twy+T8eKSO5/FKJjqIa9ua3K9IpiiN+fwcogFG46qCYki
         dB5tO5+fOGPLW97Ia9OplWjtER+O/Pjaps/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422160; x=1731026960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNzsrSrDdKCfiGrjyj6BVJ0PxYUn3ubPvyVnHqdF5ew=;
        b=Josnjxzz2uk4VVdTgFc0ijLGnxKJhCxLhubS8tWDO3D1XG9rBy19J0l8lJ3+aBBs4I
         ODl0ehJBFf3SrEn6qPZGiUJYAWkk5hPvnkZw1l8/S+kOtAiAkik3kYCaB3juMqizAz48
         uD0k7ZcHumeUPAM55DecCth4BW7W18GgBqP3tdpE98JtPHsJCvXy9WN6WOCTlCj+7w0c
         t+/EEkSJfPg5FUp8wTJ5j1wm/ZAqYAKKfWOtvhw+LZRhEBBrf5mPCtapZSBSbpBAiVKo
         zWwjHCZQzMt8boRqVx7050UNfjkE0cWbfnZnUnzGEeisaChTAa0kwACFtT3u3tVaubdO
         bbFw==
X-Gm-Message-State: AOJu0YxnAwx2jEMR9GuaSNt/IjPDyMU99sJHkCxgabrUtZb1S2ctHj9D
	oNBFLFRxL/4MLE3OF6rtkhP8v8Ywvl8I/09dkwM3g73WbaqZbh/88dypG+otXC5WyDIY45w5r4g
	WriwF7CYb2NwBeSVV6D4o97p9vMpV4FyqcIJSL4I3GLamPyGcxjSzEGR9uUnocILAIJphz4ZsAc
	h+E1LsIDvErIQum2ARfH7bQauJs5yTqX/2xD0=
X-Google-Smtp-Source: AGHT+IGknkQOlPQzMWzF3Nd5ddeqEP5+C9cHjsG5MuxNVuNJP+70dz/NU6AVLw9eSZ98XT55SfIr/w==
X-Received: by 2002:a05:6a20:c998:b0:1d9:1c20:4092 with SMTP id adf61e73a8af0-1db91d892d8mr5691359637.16.1730422159752;
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:19 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
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
Subject: [PATCH net-next v3 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  1 Nov 2024 00:48:31 +0000
Message-Id: <20241101004846.32532-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


