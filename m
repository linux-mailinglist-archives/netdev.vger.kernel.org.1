Return-Path: <netdev+bounces-107262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EA591A74C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829F31F21456
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939918733B;
	Thu, 27 Jun 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LyE3Zm6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84713F00A
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493671; cv=none; b=E8OG+CZ7XZToBsOvQrMP1oo8ghu6KuTFyQKqnrNKiQ8Yi8mzhfmQZa0wtsGE8o5m+KRoPaT4Pzed71Yx9G5LQYBfzuUzkFetx5la/GPKkGBYOle5JWEwQ8qTNXqCzWFYHTxk0VH+rf6TmGHJvtJTtLu1L/+n/90nJYj1Aex0plw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493671; c=relaxed/simple;
	bh=XXwpUhM31bW2Piiqd+8cOJ6+ulZZMITgIuIybhrzrB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByCTs/q+E1HFQX6oXOrM2OLZ2xqpkj6M50E75uG5EDQ01DaDQGIAOXOPKPZjMKw98nw6OQLUclxRclo+XI+dGsCUvCTp6CmSBa4spY0Il+tS5P18cYAzz9taBwp/C8WXjvCIpLoOkoqjkaZVVBiIPiVzACoCZoa5oKabtvX+Z3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LyE3Zm6G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad289912so15632245e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493667; x=1720098467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woK5EokpP7Oj+IDQQmUPUDM5W2CzY1qhohWhjnlCr0s=;
        b=LyE3Zm6Gp/lgx6owJVRxqBHpSLJlP6A4oy1PhxCq1+x+EvhohSPawy3yi7zFKZQQx/
         ZxBLC7RzyI4CEwf9c1gsGBx4Juk0g8txoECvcSyxbGsi4WvLr0x/CcLXiYBNYSdVKfBq
         dbqbKab3mep5wxGzNwGkVXML0VhVDot7vwJGg+cg9tT2/22Xkqbh8F7MJ+sdsKuAoCo3
         /gj1j7oDk63EYfuIagsXSMfo9K9bjHSQQxhaKgz3qX+ZVJjzjsubx+VmmU8Fz1Y1Zo6D
         UwlPlhL9bENtuj8EDzoFXFwifja4VxDEXNrzTAUhbYptsp4OmduUR1QF/KcNT2xQKZBO
         4Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493667; x=1720098467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woK5EokpP7Oj+IDQQmUPUDM5W2CzY1qhohWhjnlCr0s=;
        b=rpvoQIMzkftVX1impGqUx8KjT1rpmjvSrn8kt7V+aN4koWFW0v5Xw6RvBMKpA93Wy/
         T6l90Oa5dy0CMkbjR2gk7T8sjAFR/NCc0HxBtunr62S+u7BIqYLWI1BqmIgyI/RzgmID
         4BzG2xAGjqq+k7WUZIxJ8Fxtb0GXLDstOnlV41ij4MhGUwgRFov3uMlcLVMFQ6nZtuDZ
         47rLvUQ+LjF1oNqAZzdRvW02p9DVZ1c23z+Bcx7h1gWlhvOTam1JTH97EifETTrz7X4r
         2GN2dQ++NNyuOik7CV1MG2ZjN9T4pO1TRKKmr7ITT/UxR6cvTBnGbjjX7AkcdnYa4r5N
         Qi6Q==
X-Gm-Message-State: AOJu0YxIbmnfr4f4k27oaOS3xYAq+SMkrIgraE3/3RDPRXZFHQpbJKml
	xnWf0meIZD1h5ZZZ3yG/dlamAGQmF6j0J0PHAH3LHBx7acMo568fmhABXf4HSuZNG1KGqrvLxYn
	Q
X-Google-Smtp-Source: AGHT+IFwtxubXIWKVPGjVpiy0Yu+FFB92Pavhl0Vymb61pFWEDST2Q5w5BL1cV3jNezFuenVQglq0Q==
X-Received: by 2002:a05:600c:6c97:b0:424:a822:7845 with SMTP id 5b1f17b1804b1-424a8227914mr42008935e9.10.1719493667309;
        Thu, 27 Jun 2024 06:07:47 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:07:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 02/25] rtnetlink: don't crash on unregister if no dellink exists
Date: Thu, 27 Jun 2024 15:08:20 +0200
Message-ID: <20240627130843.21042-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_unregister_ops calls __rtnl_links_kill which calls
unconditionally ops->dellink on any related interface.

However, if a module hasn't implemented dellink, this
invocation will crash.

Add a check to avoid calling dellink when NULL and rather
invoke netdevice_unregister_queue to schedule unregistering
the device as usual.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index eabfc8290f5e..be79c2a051b2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -453,8 +453,12 @@ static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
-		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+		if (dev->rtnl_link_ops == ops) {
+			if (ops->dellink)
+				ops->dellink(dev, &list_kill);
+			else
+				unregister_netdevice_queue(dev, &list_kill);
+		}
 	}
 	unregister_netdevice_many(&list_kill);
 }
-- 
2.44.2


