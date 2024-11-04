Return-Path: <netdev+bounces-141685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2479BC075
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B4D282C99
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91F1FEFA3;
	Mon,  4 Nov 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HcWflled"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10521FDFB8
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757418; cv=none; b=GJ9V+57h4DGJWe3IWRUqi1UMgGYjAJrhF8PgxNXXIui0UVgJSSpWbYwiDH442jtHOu1BCxJBvt5CTSs3YGTgVdD524G5/PbKvteIDFpJTM5hwLAECT+5MWykUWONOld+gzjUEPQ3k/Df/XdP9CqfjJk9LuYcwGcZ7e1ZLnzsxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757418; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OI2O6DwnrEmbwLMHQcxHpculqLk3597OJUa1sH3AbfVgMpidX+L7qZOMQSzXeweMiYDwNJVBm1alkHxfQo0Y2LFZsGJlaCncplD1XVfUakqAXoo83LYr/pJsbc/CJuo5aXrYw7CWZnM35fM6r4c3cyyntQJ7ua+Eipvpo2K7qO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HcWflled; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cf3e36a76so50005055ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757416; x=1731362216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=HcWflledvMEqPwlR3SjnmZ45nEkgQT6ZfY2EecfnNkh/ahcWDnQ5KOr1vyOazU60CS
         p3d0KBVmelQJ47nvoOkSn5buV2nc5dt5rhnEpC2lrOdp1FxksVQ0wFlPFLt2odYudtdn
         wsyntg2GLcOTU1CPKWr4C7TSWnPUAfaiCN5uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757416; x=1731362216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=vsi2LifXRwhhsr8MfQJzPr04P3zHLys2GBRy2JxCSPd7eZLrIhPVQJNWwrl4agpmcX
         HoHRH1FzKWDr+GRPMz/EhwzlNcfPaVW6w527QMHegAYNY8xvun1ESC3tdqYlyEcugAa4
         M1F2KSBnAVWewlSPvlK1OCrTyjo36lmWLwsVFGelzVSQE0IKcULT6bp4L7Wm2M2NvUZ9
         K6BktMSDO5BVc2qGS8i/tqWYJSUFIiar4QnBm9Z7urc4L6dHv73RXaldNN5KqFLhurae
         Ua+t9XsifqPt1jA+muiQEQvnIVdgjXqB0bZt9sWCflwcLyU9Rz47ppI0FbYwwMoA2A1G
         S8UA==
X-Gm-Message-State: AOJu0YzBTZT8CZdFAs6XEMqhvYjWSZ0qCYX3/KnCz/bWDb8kP/GQ7A5p
	q6rWTwLflODI4nm59dLfdshgby6cTK2v9wz/BauY0bW4VMzzyXV/SMRsRfp+wXGGRfp/9GrGZUo
	5M0dRpOZhXNey8auiNvJdxtex6BvhjXmpny3brvObI2L41HtXmPFWJY2HZIFfK6xMSf2aUtylqh
	wwMy36mrj13vgyGSTTX/finAOSfu3HiiheZCg=
X-Google-Smtp-Source: AGHT+IHWXLfYRnyjLLBm8m8/vH3IV4zCHF4QIeTTrl45VzFqWP55kOn1ZRaQZ6RVPpoxAWT4AQ1w/w==
X-Received: by 2002:a17:902:cec9:b0:20c:872f:6963 with SMTP id d9443c01a7336-21103b1ce5amr244888585ad.33.1730757415610;
        Mon, 04 Nov 2024 13:56:55 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:55 -0800 (PST)
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
Subject: [PATCH net-next v6 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Mon,  4 Nov 2024 21:55:28 +0000
Message-Id: <20241104215542.215919-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
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


