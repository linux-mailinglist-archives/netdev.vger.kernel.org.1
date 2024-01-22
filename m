Return-Path: <netdev+bounces-64636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012D8361E0
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E5B1F27393
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698873EA68;
	Mon, 22 Jan 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLku0fN/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6853E47C
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922769; cv=none; b=EdvA7OXfqh/kxL0DRCJuDDQGN6RTed/WTEKypHTTni9tnUwodAdSDba/6HSOlz5Il0fI1O+AFDgrFXDOKFr3ozfYLm4LPKD6L7Efg2grGasfHNe6zNZPViJp3ZrjFR6BFrLEvsbkSayt8FQ+6VR7ngZO5TD3GSlU9yP/C1he1Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922769; c=relaxed/simple;
	bh=ISin7FPZX3o4tj1SBD9foukf78JmZPWFenhPU1ecoFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NnjsM3AdIqUP8LrmzbtsVhBTGY4GVk0PMNk+J0LC80eZtLHb9kklr1dlMDY6S/WgSdKVcVhD/MpbZDY6qF8X3yBlvkR8LvRucIKHaHN0bbfBGZbT/kvhnIfrKGajLgkZBaxJ3dD86mJXPUkzSdZ37/WyyDe8rxD4UHAg/x+S19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLku0fN/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so3379849276.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922767; x=1706527567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+18H0mLnHJDJExXbYmTsTpIx4h4sUECXl7UH0A0t00=;
        b=jLku0fN/lec1vvOaFBGSlk+toccpQbSoGZIFuI9fGhhqgXDy/+yOIpiJkruX5AG58r
         85M95IyIwRnsK8pjLdckhKV4gSYcCTpIgMXYSf6unaONknRbuzYY6iuOzuLlbJT1mbAN
         IdtDtWWFiWbdlW98esC/BWQcpaiCsJ5fRIgADCq3SCCrnL7l5DiVqPzCvLAzjebRdlRN
         9sME1mYQfb4Z8OInJ5NMhGUI1CRJTT8W0rihhXH89tQGdtDRrc3v6gDMeFT6sE31YgQw
         NdyVNaQXHjBQhxpvU1yX68ehYRqeBrkUY6+sbXirR10oL9B1z+cIvzZdifk22/PbTZLb
         z1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922767; x=1706527567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+18H0mLnHJDJExXbYmTsTpIx4h4sUECXl7UH0A0t00=;
        b=b7WEQpW/0s4iewkptUSlTPl6pJG1+6F21SWfWWS7jzPCDLKxVDGNMkBdZW2CQW4lSP
         kEcUYYZ/ilZaSIBXPCwMSkdrBbosuWZEsP82ql4lxT/HPibUmDpIkKgsok3KNi/aXn/z
         urk+D/nPvMFO754pIOvYu4M9jrEgOI+qZ7UzfWvhle9d3Zn9CDQ9v8rcOXrt3umPEDD4
         /vYS0Vt/0fM8QAj84J3VcPvh8JQGWSIt0eyCwsUTu2n6+QAjl/98s1fVk2UATs40/cha
         waw6Ejamb2oqM3uo67qaFtQ3rriHbiuWGb/0udDloTWLrhlJFL3hX/JjSHwCg0Ps3kDW
         Xymg==
X-Gm-Message-State: AOJu0YxCODkLNZawXAeUrNkw7gLI+Vr98YYejxAPXy7m3o7fbdtlYjrI
	iS0GrLJybRKpCSURDIgtv9RkbLODxP45nlmi0upxWKl0Oy+sZOfWPROe4Gjq8PPJHZXZ/WNuq5q
	lkDNIMQAD8g==
X-Google-Smtp-Source: AGHT+IFyfiRIQWAwVuEBOoDbYFqe1x5y1aKtMLLbVK0IxXRtcqERVNVcy4XVsSzAlGwmjpVEDsPXLAdSGeCY5w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ce11:0:b0:dbd:b909:f090 with SMTP id
 x17-20020a25ce11000000b00dbdb909f090mr239344ybe.11.1705922766864; Mon, 22 Jan
 2024 03:26:06 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:55 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-2-edumazet@google.com>
Subject: [PATCH net-next 1/9] sock_diag: annotate data-races around sock_diag_handlers[family]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__sock_diag_cmd() and sock_diag_bind() read sock_diag_handlers[family]
without a lock held.

Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.

Fixes: 8ef874bfc729 ("sock_diag: Move the sock_ code to net/core/")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock_diag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index b1e29e18d1d60cb5c87c884652f547c083ba81cd..c53b731f2d6728d113b90732f4df5b011a438038 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -193,7 +193,7 @@ int sock_diag_register(const struct sock_diag_handler *hndl)
 	if (sock_diag_handlers[hndl->family])
 		err = -EBUSY;
 	else
-		sock_diag_handlers[hndl->family] = hndl;
+		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
 	mutex_unlock(&sock_diag_table_mutex);
 
 	return err;
@@ -209,7 +209,7 @@ void sock_diag_unregister(const struct sock_diag_handler *hnld)
 
 	mutex_lock(&sock_diag_table_mutex);
 	BUG_ON(sock_diag_handlers[family] != hnld);
-	sock_diag_handlers[family] = NULL;
+	WRITE_ONCE(sock_diag_handlers[family], NULL);
 	mutex_unlock(&sock_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
@@ -227,7 +227,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (sock_diag_handlers[req->sdiag_family] == NULL)
+	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
 
 	mutex_lock(&sock_diag_table_mutex);
@@ -286,12 +286,12 @@ static int sock_diag_bind(struct net *net, int group)
 	switch (group) {
 	case SKNLGRP_INET_TCP_DESTROY:
 	case SKNLGRP_INET_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET]))
 			sock_load_diag_module(AF_INET, 0);
 		break;
 	case SKNLGRP_INET6_TCP_DESTROY:
 	case SKNLGRP_INET6_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET6])
+		if (!READ_ONCE(sock_diag_handlers[AF_INET6]))
 			sock_load_diag_module(AF_INET6, 0);
 		break;
 	}
-- 
2.43.0.429.g432eaa2c6b-goog


