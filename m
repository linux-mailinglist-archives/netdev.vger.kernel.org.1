Return-Path: <netdev+bounces-116069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6D948F0B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7E1F21414
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC01C461F;
	Tue,  6 Aug 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h/57+CeY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2991DDF5
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947590; cv=none; b=laKSOoH0Vw9JAm/NpSIeFsRE2RtfHJCqhuXaeCaGphJZjgm91559s8xJ/OaD+zvQ0S0ZCiUCW58zq6JX1F5rY4hMPtvQjGlnNoRB872a0h+BO2GrDEHs9vib9QgfllzbkppiFXGHb3x4VmDZ19Fe4Dy5X3FSRZ/tT+psoPdWD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947590; c=relaxed/simple;
	bh=hLDHnjRdPnpaeg167MxCyofiZQOaLsJlLf+Rmw4qk3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uGmCPJGSn4aXf2SHN8xUBAnGynkpe6Jq41RsNwm+EnoZsjJM8Ci2lBe5UyYhaSaVWuGZ3H6xEbqEvoFW5HVUfT+BVqFyhnRjMbamw2yGJf6UdVCiGUywi+GHWgiOzPg8iX0MPpxg9fh+3CQjBeH5wcnkPML/tn8NObjHGSK8Pdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h/57+CeY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710afd56c99so354829b3a.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722947587; x=1723552387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AT7QwYWK8WZyIEtyo3//GG8heHvMwjuLkdYziSoLjUo=;
        b=h/57+CeYAWdfu365BOQ6Xxc2IhfE3gf2v9om5XyaVH+zMxhTZyrfVAd63mbXzj4qEf
         Q95+ZeSAqx59QW0Z8pO54tBttZJREbOEuPG0t+qG1wyFGjzdL0h6txUi5Bd+UUL4Bt7d
         anUs70yV/hEzj9WKZsl3csdVs7eL7xvQz7FKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947587; x=1723552387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT7QwYWK8WZyIEtyo3//GG8heHvMwjuLkdYziSoLjUo=;
        b=knEJj4irrmUW/wlSKnSlxJiX/DPjHr6wrJpnYWngtcwfskffwxlM0kytM5z9sd0hb8
         UjAnsq9F18lIwES267pRuis8DrXCwGW6w6mya4uQAW9xqQYDtITH5yweuFuy03U2MjQc
         aE5zFq5j8Nw29cjIJxMM8FYOI8dPOFDGxVZDtkIT8JrSiaio/zE16vAA+c+vjypMdtaf
         dioI67xxmKVadpL2L3nMGd5zHOvfB8D7WUpbsLiTYBzpM0SVTdaD/zOVnE2/3cEgaH0K
         ltA4kfVQPcbNt+EzWqx+T8wUzwIdCCLbIbv/r8FgnokAX+cCsXiQm3CfLftMFYcL1KTS
         W6qA==
X-Gm-Message-State: AOJu0YxlNqaz0MymA0KC2Umj866kgBR4li2+z4IFsDO/CjC6bksrdxrM
	1fQ0psT3HViWHM0ZAauvxYOASKu6F8RHskjAUP2U/rOg4ySVSZ6WD11IE2CAAl4=
X-Google-Smtp-Source: AGHT+IHrUqiuFtCV3WrfhBJ4arzdppGltRltfSkrJGcbzB3/8Mb8Oiy5ACComQJXPWx7LLJfKZ66aQ==
X-Received: by 2002:a05:6a21:788a:b0:1c4:d14f:248f with SMTP id adf61e73a8af0-1c69a5f0268mr22605294637.13.1722947586715;
        Tue, 06 Aug 2024 05:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed16cb3sm7141271b3a.179.2024.08.06.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:33:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	stable@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] eventpoll: Annotate data-race of busy_poll_usecs
Date: Tue,  6 Aug 2024 12:33:01 +0000
Message-Id: <20240806123301.167557-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

A struct eventpoll's busy_poll_usecs field can be modified via a user
ioctl at any time. All reads of this field should be annotated with
READ_ONCE.

Fixes: 85455c795c07 ("eventpoll: support busy poll per epoll instance")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..6d0e2f547ae7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,7 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!ep->busy_poll_usecs || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


