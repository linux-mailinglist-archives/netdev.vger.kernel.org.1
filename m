Return-Path: <netdev+bounces-240755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350DC79107
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8034EC4BD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2283246FD;
	Fri, 21 Nov 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuSyy081"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93A2F5A13
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729363; cv=none; b=aIpbHy/AcanBo40lj9N0zdCMwpXkW8RkoIz9rd+U89+t0F8VufohI9z/WeVxyBUpjXMHxN3DBixQszmbOyx8zKlDaBTiun4yyP8qxqDFEIrtkMGlbS4Fe8CwJCSg9To1bQCDRvxo/fi/h1FNUBwt7gFz5ohcMa/NsT3tnJ/nbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729363; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+jZG+EoLBZ+HfjbMGdA9rj9nfM4oUeB5iepw0vbVk4iL0jW0ZWoGSnKrvvXTVSc5nTipzoIFNz+XhrkRwtrhzNjWQLgAPCssTm+O/gxqXa8Zuf1Hsuks9StnHANhkgJdD5YTh9OOARQwoifebre8gqtERjM8SI0niWoFkyClD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuSyy081; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2984dfae0acso30745215ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729361; x=1764334161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=SuSyy081RDHOKYo9u3icd9+cCB4iEvbdDcMvZGeOEWRBNJ0FL/GOaViCx4/AJOQrzX
         VQvcdps3MO7lw53crA0CudtCHlZ1f8r0CrVc4IGKfmwsmooZJzZ7PYSPF8ErlvRTR5rC
         xN6DEO2mC9DIod9kN9zpI+HJQbCQbQ/RqWdMbRwjXimF7a9scy4pvu/zTesFhlOMHYNq
         zilws2IYLnlBnA7A3KjO9vGciegwen1mYv9Q0wBnuuMQGAGpIi1w8U3orHrJEqJabUF7
         GNC3t3exv9EtL1WaiLp698RTCYIZIjIMPJDr0M1ta9HfKi+SbEzPzcBzmM/ctSXJpYOC
         p6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729361; x=1764334161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=mxPJ/3vxAn4kUAJaQDLVKtQrZ00SYSn7MxgBK2w9oCi646KN9SJB9OoleJw2XZfKrX
         Z5aZLFy75EkzAc66aEnoLLEDKlQHXEu3kEkZcjVyKu+oMxcK5elg4bD7LkBtu+F1FBLh
         o+iKzANFunwrZ4CvNZ87tbJi4wumts6pXOo/fGNTO1vkMe2GlfCBBBBamlVDc76DwRMP
         uQ7IrV3Y5t45mL+nTht7FCezMwC27KfxHUkVjH19lEGk7CtSQb+DqVsi+HA5ctU87y5n
         8H9SlXakXSXb3Oqu7ZwBqk5MQlP1tEsrECEBQ71go0i+XVhrDJ9NCT4mWX7DSCMStZZE
         ysBg==
X-Gm-Message-State: AOJu0YwwSUTCODVYtKbQMZBeH5Kr4rjaROgAl3t7rNDEJJwCoppEOyeV
	5epfWkLYyGpWPE3PX/rwL3vGAX7+tq3pnj3LGJcg3UrVvsBpKC7Vg9t0qC33u9Y2dAvbC7FF
X-Gm-Gg: ASbGncu01sgsl1S7Q6tk+8Yx7R/qiZEPShXzkT9Et6ZcLUdXv+YXGl8jOSQ4LsBOAes
	tUURGt0aDy/bj1cAwrHcwofdvmnPKrtDcAj1fAphkG1K804KovuNKJ+qDSv2t1iZf3VIXsdrT9a
	jHr1KTl41sFLYLkKJ19LyleWctckDiEV+5Wt6cJjrAfc7E9KLWktC1F2AUK4wqPXbi43kaEgiCd
	46qyDFLjVNTDQwsipiVAGE9nh9Eec/JBQyunQQZtdxYaBRPY7pxFw9YnSZX4CUJruJqjo2Mjxks
	sNXdvObKlGcVa9NsWsSwrBZyFWGmoSHOxqLiNlO0QQuDPhFDsjEVqHVO3vtttx2B7vbZYOIUcRB
	cS6TmM5m1w+JAa1/5PxEz2b+Ngu+V30/g9I/vjxxUFr4wd86NPhnqIrxSJlBhTMBqxlS+D44n31
	PCLa/vQnJQxFSeIz+M
X-Google-Smtp-Source: AGHT+IGADjPBSv6dneXmHvy/d7ImNW4K6lxe2fy+G/Ozmk9OtVRsRVjcF0a8edFY+XOXLca6s+ACgQ==
X-Received: by 2002:a17:903:2c06:b0:297:fc22:3a9f with SMTP id d9443c01a7336-29b6bf19f1dmr29423045ad.38.1763729360830;
        Fri, 21 Nov 2025 04:49:20 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:20 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:00 +0000
Subject: [PATCH net-next v6 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-1-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=i5LMsfARwRqneqwPou9ysaSmPXgBprcP+Cdxs4zWJpbgkFhrfOS1RNzxP4zJ9iujoEomejMWo
 TKx/4fNVTYbDBn+xFqIHIFbB4/zBHsT8jC7e3G5y4sHcD3GQNroRnUP
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..e2ec09f238a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -119,6 +119,11 @@ enum sysdata_feature {
 	MAX_SYSDATA_ITEMS = 4,
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


