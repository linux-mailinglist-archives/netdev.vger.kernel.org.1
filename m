Return-Path: <netdev+bounces-94922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804638C103C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AE71F237AE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5741527B7;
	Thu,  9 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6RjWWR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1F15279E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260713; cv=none; b=f7hH5CXxYqQXKPOybHBv/8eW+TCm3MMXL0gAr9uNEfEkKjmFDnjVKwS7F56OCaULMC6fikEpu6laNe5GoInWWoSrK7sLom72umUO3fwvxjbAnueq/Rbns/o7gED9Oic9PwnmZvNdKGJksp7baHU/xd9m2aDa7mji2OPrcZfIjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260713; c=relaxed/simple;
	bh=1+6mC037sTQMaHOmD6AvHXeYqpcyuwPhZf3IcwPUzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbKfcEuYaN57cfqAWEdQw1Z3NI52KBvzdyVCeUOz53QZwXZOeqkLAzozMz68Xkh1i0ipdIm0hm649OdOaHF32QblPxQbUoMrRU6HviJFkFzBXDEbSC8kfvBAbCWreyZN3s9YP8sq3f4FKzyd7hzNazezyyeA5nD00+ZIYI1qgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6RjWWR9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec4b2400b6so7444365ad.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260711; x=1715865511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NRBmMY/wP8DhSujWqhfOXdNOKQv2uovZrjoqS7hZgY=;
        b=f6RjWWR9tE/+Bw/3++tG15DAMVnxQIvn06Z+CPIsxrGtEp+puXRVZelSU8jMre79+s
         hjAgkTS2LMzLxWqE3DdIOEzNsC/7KMzlaz8A0k3h+JnhbYJn3kzRPF9ZJSWpAxwz7/Wi
         a8iC7wjcnsKk8Em/TYdGtxsLFEMe0y7UI8uvGmhM9q4EqVXltI12XuymiZ3zbz5OMvBa
         NRu2C0dhyTmiJT/QYsJ1N0sXZvrE87mLjw+6siA+G/1mfWHSmUUQwDrOB9qBaZ6jgmKU
         k+0n9i/APcZuJj6LGjaqboMJcBbH7D1g9fKCjEyNCZLljFBP91tF0djTnbUwqEz8891W
         rmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260711; x=1715865511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NRBmMY/wP8DhSujWqhfOXdNOKQv2uovZrjoqS7hZgY=;
        b=Twsa7I5VeR6Av2ocsDqH5N91cwQJgqDfa3NJST44qlNcs81OeoWG+uItC7QiVIw/Ak
         kGuBZZb2Q7zbXKmgqR7O09oBcCmbn203x6Fx2Effax+m48GJLrnKxjcgVesdz1Re9zoZ
         cXd6RDCcaYM2DluNVOoBfR6hK2Qm+ssGYe1lN1GMnpOcqaG/9yQwXAccn7NWytk3je/2
         wC09aTGc0+IoFuuN2EydclRVGUc/9S60I9jmibdlKH3v/2uqeUVAzzsgumq8kXoqC4DK
         feIjVbgLoMYRjBatpl3dcg45U2Ho5qBqRgk4WaeMTETji9Kx0v/KCp41AbBElnWFHYaq
         tuwA==
X-Gm-Message-State: AOJu0Yyu0PZA145XreGzFIBrYe3seTVZVmXQr3LuNhQ9f38pPAyhA34E
	BJgBNf4oWhHgZw/fVkWARBLqYXWc3HqxWzA/I5S4dl3xGGWVtCd70SujModp3y4=
X-Google-Smtp-Source: AGHT+IHqRkWoqjzZFMwn+KWU8gAHB55TkADezEigzFPeOFdOI6eRxmrXF8P+e0inah0CYL5PEYJ8Kg==
X-Received: by 2002:a17:902:db04:b0:1ee:b0db:e74a with SMTP id d9443c01a7336-1eeb0dbe84cmr66574445ad.40.1715260711108;
        Thu, 09 May 2024 06:18:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3d8sm13989055ad.99.2024.05.09.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:18:30 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/3] ipv6: sr: add missing seg6_local_exit
Date: Thu,  9 May 2024 21:18:10 +0800
Message-ID: <20240509131812.1662197-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509131812.1662197-1-liuhangbin@gmail.com>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only call seg6_local_exit() in seg6_init() if
seg6_local_init() failed. But forgot to call it in seg6_exit().

Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local lightweight tunnel")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/seg6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 35508abd76f4..5423f1f2aa62 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -564,6 +564,7 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
 	unregister_pernet_subsys(&ip6_segments_ops);
-- 
2.43.0


