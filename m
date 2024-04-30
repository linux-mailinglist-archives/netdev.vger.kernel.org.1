Return-Path: <netdev+bounces-92495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EB8B78DB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934AA28199E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FC770F9;
	Tue, 30 Apr 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM1NVsQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE4770EC
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485824; cv=none; b=FBMCZi4A2M/aysGXPMKRQd5/hk2DzfF//Hy25gA/dfBOAQPVbepRBdqfTDxN3PysyUj/fAGARv9kwaFHpFHZADJTLpR27UhNZ5bA0lRD7gaS+80NiYRlwgcm2VvTU7KW0yaG3Hy7Nv+lWEolVhm8AdKlM1xGqhyUtWYzQISyY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485824; c=relaxed/simple;
	bh=kxJTJY3TvoePLj5HIQPj/ZpDqODTjzfP0WcduR1XKLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhmxYC1tBwu8nlUZGCfhXoF+PZCFa3UO5zDUj/VddlBJNVO0zifAKp5TsbRo1BnVcQFWaWPiTWWBbdl7PsGYbQ46eiKrrgEzAcFd4ffvWJcCerC28F6jsv/5fzPQgOAVtE/utwn14yZJz8MltI5/cOHOr8hZmFjt0XRj+rtmvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM1NVsQj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f04924a96so471760885a.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714485820; x=1715090620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJnYUGWwY/oqAOMwIFkx0qsRQso5ETFxAxoqD0BCIVA=;
        b=gM1NVsQj3UfzpLuP+8O0+3yFS1LVOCQS4xiWw0uDcBemerqpC2IuhKu+Ee7M2o5sie
         1I35XrseygeflucqdeuvMzuEaOB3DzM2pz9VigvnOc95Raswqik2pHbG9YG3A41jAEGQ
         oV/fYvUbrvrehrB3aldqn9emfHUAhkC1He87XC+W7n79llLQ2yf9bcMjDb6KspDZU/LM
         5fPuxguUm+pHoKdPTyPYh8SvHOnAOsk0nCZ7xpboSqdWdZu7ww7pj/4goOqoP+7xfaME
         TDLkz9SsIhnzunRN8pPz40zLDG1uMuscRUqVTU130/ygyxgRDdfdU2SWuRimhCzja2bj
         P2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714485820; x=1715090620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJnYUGWwY/oqAOMwIFkx0qsRQso5ETFxAxoqD0BCIVA=;
        b=EF1Qz7mb9x+LyjWeTyrJMk+iiCvGk2fxk2afE8ecD23CKmzzqOz+sYfw7ou/i/Q4+U
         nyQDJ+ijjPDYUzNfb+2Lks+SaWXB3Gwe8+tMnNM5JYFuX3fO3mNTD0HJmcMklPJpxgqO
         qdXka38oMcFG9v+tF5gGBiiBKLegF33W9ZIE7pNaZ6wsdF+Rqfhm1WH6NFxRNrVa1lJm
         MC16e4at1FJ4sSgBwAHn0iK7W6+ELJs8R2IbhC6hR3nzFqw8CTXt/fk9WezHfHwYDYy+
         YoNqYJJlwUFQbs0IB7rK07idXS/91qZRgdb4oEipPTN7wySbqRQ9arBTdyYeAJf4H3zp
         B6gA==
X-Gm-Message-State: AOJu0Ywy0872FiUcPRouYDjJhjfyPPjMTkuTD7AECBAoPV25Kc1pkkUw
	QQQvDftqH5c64vJJYDLMY3PmWhKzoMy2bkkT4GhDrqLnG83IXUNfqGmZCA==
X-Google-Smtp-Source: AGHT+IGMwTZBAt46LWw96I8o5TFU1PZR61lxjz2FkRE5rHPSJxdGcmX1PxGSs8uMCxNnJYtZAC8EOQ==
X-Received: by 2002:ad4:5be2:0:b0:6a0:6668:f3f6 with SMTP id k2-20020ad45be2000000b006a06668f3f6mr16722073qvc.21.1714485820015;
        Tue, 30 Apr 2024 07:03:40 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id qb6-20020ad44706000000b006994062299dsm4512692qvb.33.2024.04.30.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:03:38 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	tipc-discussion@lists.sourceforge.net
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>
Subject: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
Date: Tue, 30 Apr 2024 10:03:38 -0400
Message-ID: <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__skb_linearize() doesn't free the skb when it fails, so move
'*buf = NULL' after __skb_linearize(), so that the skb can be
freed on the err path.

Fixes: b7df21cf1b79 ("tipc: skb_linearize the head skb when reassembling msgs")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/tipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 5c9fd4791c4b..c52ab423082c 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -142,9 +142,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 	if (fragid == FIRST_FRAGMENT) {
 		if (unlikely(head))
 			goto err;
-		*buf = NULL;
 		if (skb_has_frag_list(frag) && __skb_linearize(frag))
 			goto err;
+		*buf = NULL;
 		frag = skb_unshare(frag, GFP_ATOMIC);
 		if (unlikely(!frag))
 			goto err;
-- 
2.43.0


