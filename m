Return-Path: <netdev+bounces-143147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DA9C1436
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EE6282B14
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA520192599;
	Fri,  8 Nov 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OOida9Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6D188733
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033582; cv=none; b=oAIZOTuHSWpwXmtypR8rI5ruZ0eB2fUpAjllHZ+OonmivDYtKXzE35IJiUkMokOlCbNa4SIfZLM7qLwjkhC4ct0gFGqiwNIyib/birWiqoXZDKxPhUOyS/Q8S7zYNBK1HB0UkSElCvPB6hYs6ZSXZd5b7oL3bv7/b47SILcQG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033582; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5baq56hvWaoA4MfoJtgKl9aGVfUoc7BA7bwQ6N2gCaThyso1mdYUusm3xRGGh87NAytrMKx2/teqstMDX70s23HxBYqQCpn++Nuoe894ehmZKtn8phXe1ScMh77WU6YC6Htk5LGRBWJEsObuqgGtK0ZzKU/Q6VZLpiPTPZRQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OOida9Vn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1265423b3a.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731033580; x=1731638380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=OOida9VnztwHPkKj8/SaJe5KkFDqgOkWpIWLsWmKa+vKaLQkLTacCqWLeEbUM/doxa
         XXko/Kj9etoerBzHDEZK24GkDTaOh0RFkkij+359kwNjJBMSY3mRkTl9yhRe8R6+MHLf
         NBGbWyYnhiJJGEvDMTMGWw0o0WpCDg8Zp13vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033580; x=1731638380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=FABYxoTZ3kqk/kVyNHoeR4IzNZ1DKQy/CBIuMzzAElJDrvPtbNkUloo0VvdZHXPzg0
         PJoVt5XjXAeSgMeNqlpK/T0PR6RcruSdZe9tYN+AlEjYDx2lA5v/gzkrk3sepVX99zgL
         n6o4Nni3ubN1sYbXqnc6Ck1fg2XCNbemXTDYHLI28c2+pUeOsiatxIoq1LEO95UkCrjJ
         R1jEZSWlyL2E8uENuztOdipdhw9TluYLCG6GeslkNjkIcahDv4iZRLadso0WFFWt/6Yk
         eLfTb8ecrzNyJ3vgaaDkGhjGQhZELlmO6EpSTDinU3aQ3n1zweKcvDni8s847F7FJI+o
         CLYQ==
X-Gm-Message-State: AOJu0Yx7tqFRGO04Jidjqk/JmB7cwNV0JBP4vHXu4X8UxM7xvWdlIbrK
	BdEwKLAzEkpJA5HF9+hHtAdvRzOIPWOpyJj6qZfXgFnIoAIcI2MhTLvvf6Kg1MH783/A5LNHzFI
	0xWYWGU7wfkmWcioTRRb0owBxP/JMjdQcbJ2P+QGSrD1yiOgKUPL1pMtykwRE6EIGehJBgkq24/
	V1BLIXtTOScQ13ZLU24gNBozj5XLPDqXzLeWI=
X-Google-Smtp-Source: AGHT+IEMedPf8Gd4cnsji0k8y5FqSjEthT/NDHaffj0vgohWQEnnWYSflFAy7c/ZagbJxzaXfOP9PQ==
X-Received: by 2002:a05:6a00:2ea4:b0:71e:5950:97d2 with SMTP id d2e1a72fcca58-72413348feamr1807866b3a.17.1731033579715;
        Thu, 07 Nov 2024 18:39:39 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a403fsm2561208b3a.105.2024.11.07.18.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:39:39 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
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
Subject: [PATCH net-next v7 3/6] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Fri,  8 Nov 2024 02:38:59 +0000
Message-Id: <20241108023912.98416-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108023912.98416-1-jdamato@fastly.com>
References: <20241108023912.98416-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
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


