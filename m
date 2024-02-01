Return-Path: <netdev+bounces-68038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43502845AFB
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849CAB2239B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D65F49B;
	Thu,  1 Feb 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIcpI3Fy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906645F495
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800346; cv=none; b=EQCEpLf7Qab3jKAOjbuYM97r+j9FjnpB9cwMvqg+Z46jJnk3sdkzdqjZQFYBhwFEtLx5D4yQUherSSzclEpbidXi/kAil7XRRWBI+8fTLfD4nl+6bj3cIq/01LBLWwyYP8edP0315kMSMCI07oYw7PTcyMns1n1u2faFvY3MhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800346; c=relaxed/simple;
	bh=LM3CEG5hgn9LD8wvz/ZcIdWsEQpPVEJ6wSPXwvusJgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T24hdHWlq67XtebsWScnHa+pkmmUYnKrA3sI0GgylBZhvvBpk8K5yi8ryMiS1qpTz3ujq+fxR3miefCtBQnLggKGf1vM3/Q2YUWsPP1yHjQzZnqCSVhsMRPKvAUvQn8Jlmi25DxoQ7y02YTJ6JXe6DqtQaQyYuPd8UJT2hEoKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIcpI3Fy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51114557c77so1140383e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800342; x=1707405142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st2mHMLbxqifRmbCf6Q4OTXPD4LiFkmBTNf3YRFLiMU=;
        b=fIcpI3FyhNC9HQ05BGlE2dk5RRoK/ichxxZq4/JXYtRfW78KZSXOmMqANr6clYwl+f
         VJYb7hnrb7vZkOdIVrjzxuX7vpCnmSdCLUBRkGNZO7cFMG3aRn5hRS7p0B/nf6bp0otA
         XqtkkgZ+hxNs+DG6ADmT4v6J2cj5f8vQ6LSVkNI6O4z0YzlsMUq4wiJijP8NQVLa8ojP
         DeCJd9Cp88p1YgsJul9HtGOsrecxP83U3k21V0T5Od5t5XBDU4FLcNAJIq4t2TtOY1dk
         N6zBsSgIDDwzPBcknyOBkm1lk46ELv04c+rDOnSoGU5VtTYIHvgNh1+0Oo2ukkN9+RA1
         Zghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800342; x=1707405142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st2mHMLbxqifRmbCf6Q4OTXPD4LiFkmBTNf3YRFLiMU=;
        b=L+kD/tja0TymUy5dPr8ubsET7dDzvL/7tQCjjVqD8EfibKArJGAxz8FgDxnQXQ8sTj
         p8c687lQBpsqXf+S0EsOwwGMZffu3dW67L8vK7wCfytRZCCD7J287D3ScyJxYK+jTlm2
         1PaDMwzxV+Oih4RjAG9oETY+bYggrkpZJ1dKYMRklu8Ml8DcDkjMHCNpXFhD5wBlmRhD
         /BLmTtMDcCiT7cgz8warxtdR/vJz3GjC59EmiCH29YM8qHvKfJSp7GrLJ0nvY3V3QvYP
         uh0HIwY2DQriVc88fTwWuaKAb0SUrbmSEZInuAAwhne1qe/6QJAFR9y3eWmr+CJc5ts7
         uzSQ==
X-Gm-Message-State: AOJu0YzWeCB1+ypATZtL+CAJmynbv4N5GXG8NXs32Y5G8QYmESxg7cAl
	+EmLn60ydeoSuhUXilKDRHkJo+kjgOr2Yk2ovDY7bbu4dCX+iiY8
X-Google-Smtp-Source: AGHT+IEGu9VzKDWniiUCQCoj1zNIza0oRZUcPSsR4nrzRKURPV6h3n2N1JAXpMyB2eG1QOb/UTxcng==
X-Received: by 2002:a05:6512:b9a:b0:511:2ca7:acd3 with SMTP id b26-20020a0565120b9a00b005112ca7acd3mr2413780lfv.3.1706800341650;
        Thu, 01 Feb 2024 07:12:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWeh79IoDv2CcBzxmj60VjkSdOyedBbfqjh19G0VaxAGJ2eQyyZBOYB5UrNWr6sGHXPId1nnBFnk2xYzRiY4ETVzvGSZ9bvZ9hCI/lt+cpXu4rHXjMWt6ohoDKuKaSBoFIqv6boSjlODIq1vhTyiXCcs39BhtJ8EwErQMO24tIU8UjHwy47sY3TiBA3cu0YolhjFG3XIRhLx3HbkSSX0r7dcYqi8VG+7y9XTtRd5ISB8BZCBRqd2TkhsiOo/F+2z//7Yecd/B9SZ+Ox6lVleBmrV+JkrKb6Ywjda7XShJ/IVHfrdB0hqeArldUYnQuikbaS3iplmqQJ8WH9a2VuUFHlgGD90bEOfl0E
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040fb44a9288sm4753672wmq.48.2024.02.01.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:12:21 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v2 net-next 2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
Date: Thu,  1 Feb 2024 16:12:50 +0100
Message-ID: <e14fc185dff74792aec4323249137a2d397d2ecc.1706800192.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706800192.git.alessandromarcolini99@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
entries.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4b21b00dbebe..324fa182cd14 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3376,6 +3376,7 @@ attribute-sets:
         name: entry
         type: nest
         nested-attributes: tc-taprio-sched-entry
+        multi-attr: true
   -
     name: tc-taprio-sched-entry
     attributes:
-- 
2.43.0


