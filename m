Return-Path: <netdev+bounces-208603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F293EB0C4AF
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2CD1AA4C5D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A972D8DDF;
	Mon, 21 Jul 2025 13:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF92D780A;
	Mon, 21 Jul 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102934; cv=none; b=Wz0ASdAGz4a53Uyld6d6ll8nL2TwEtIx9BWcxkV84K5fDoRFeJANeSbjCbWoccJIlmH56XwU65AXtmx7nobcG1pTZqqdqeKzaXUjOwwbUkSnfb/XZx1ojTaIo9b9mzASPwQolh9WL9JAEQIQdKmO8zmaBymXPaEpqXMMyqNHsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102934; c=relaxed/simple;
	bh=oagYvLPRp2ebesljFuBIVfa937xZLmXWPbPvbJX8Vb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx2tQJjGB7pU/1Q0X0KCbGdbi4odsoJ/cBJNgNNL9XwYdxwM9PRzkVXF1b7aq7+9ziiyySW47QBWks1eYQnFQoHuXBiXwfdQLOxD7FcBVD7YXxN/XA85EoK8vD4yM6EqwZxjGq/N1Rfv6TWmAW9MWrj71vEZozs+OJdABfO6mEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0c4945c76so577383966b.3;
        Mon, 21 Jul 2025 06:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102931; x=1753707731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsLTxz4UURCNf6IGkttLdx17vKela2kG3TZHARmy8BA=;
        b=jka0m/b8zqXGHzbaf0s2reem5D2lo5hly4ZoesW1ruXIkT13iyKE8JmStOg+YDPuqK
         YV5XcuyDYelOW26BIsOk3xBE9OYXPIJlhbheUW822IP0Tvvo8cWuZQ5jBIc8TDu9EHzf
         Kh0FlvbxaFpbRDOU8NlkLKvwVViyVvJSLkGpYjAXg+ARcsavio0fe2BNocw26l0WXCvW
         tc0Jogir2Ts0qGQ30BiTv4cNd0M5RCCvPlLbJJvJK5R2PmO4pYWdquVsMnOUCr4uxrIW
         xZn/dd8+PgfVt3/Xyu4uOlqX/kGfjTpyFd7oPAaotTKyEcsOU1Gy08rf0xHwy6RT9aaC
         VoKg==
X-Forwarded-Encrypted: i=1; AJvYcCXUmOcUYKNvZzR9I2yyswBPZHvLjJfRmKye5joP6Oc45H0BvO18e4Cc2sKfYpqTNNn3NtsMoI/hZxrR2pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46Z6OBfHQfrwms9mPvCEzfolgcn6kovAc4LsTUobsEwPrjId0
	hBUGSgXYEQ0W2xHF0rxt97nD+TLcjh3NpCxvi781pHqquTBkhOz1TuZcUWhzWQ==
X-Gm-Gg: ASbGncuPsONk4peTgTz5Y7pX9FZlpaviQpwm3N1yMZtI4JNqfvY1qutct94c1tZqMAf
	nPpCUg3uwpQCKx57pfmmOO6ZGpnEIEOqFUykJgFL5IjsDNmnEHg8fdKXvL44JCOx1H7SYG4fS62
	MNxZECjHggSvVDSbo5ik8GxKtdqs+iHCUtTQvAcvnn3xjPZnMg7SrHI5jPitAl8KrBKwgfxaOn8
	Wxwux0INs5eQK6IQ/NkT+/J0e7NZk0zDpvPowsGVFUOS3klzqZHU55Aqk6vDYkNRQusiXOd/ity
	aQxo0eyz/H2PM/cd15RBLAUj0G4yYJ+klr9CF0GnoR57+zlNkFclGPqtN7Yjs83o0ow0IAqVCq1
	227XJ1mAwQV7F
X-Google-Smtp-Source: AGHT+IHRZVLcxa3SeMX6xPW1KQHsxQWWjiWfUsPZq8WyrGXDn9EV3khlqnaV7H3n9rQ0IkTAdRchtw==
X-Received: by 2002:a17:906:6a25:b0:ae6:b006:1be with SMTP id a640c23a62f3a-ae9cdda3d41mr1993116466b.5.1753102930486;
        Mon, 21 Jul 2025 06:02:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ae11sm677073066b.108.2025.07.21.06.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 06:02:01 -0700
Subject: [PATCH net-next v2 1/5] netpoll: Remove unused fields from
 inet_addr union
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-netconsole_ref-v2-1-b42f1833565a@debian.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
In-Reply-To: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; i=leitao@debian.org;
 h=from:subject:message-id; bh=oagYvLPRp2ebesljFuBIVfa937xZLmXWPbPvbJX8Vb4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOWKitypCa5Jn+jdxZ9bJxqnYDHoXwR9jfJ
 SjGCeEQyUSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 bepkEACZIExgS+ni+R+3NYK4IS0M/JhkTrDZwhU2V90JAjjkX54m8tBi/YY0T/VdiXech3YDJ0r
 S2KXRR4QFkGU+A5Q4D83gE5xfNPeQ6bKNxOHszGRzRDLktt/MCClxGdmqpMajjRDbCaanHAmhpb
 Obgxz4nhn7gAmjdz6oHV8XSa9CDc1kxxQZ4pyZby+dJfstNHhJAZK5ADOZ6z0MyPDe3JHL5n3Jz
 BBihgvdviu8aGcVDSoOg09zscZG+byo3vBhYFdFBLJm+NIiGj3Ls6bT5BIESI5ylCSmf4gQBR48
 DTL2kIk961RYQfnm541FfJAheYPCfizFAauO8yoFqw0j5/DU0qHVDKUyLgNO6P79pNFibKs/8l6
 yNBsKmepoAyhRZ1T9tUFyT58k8RF2mdkPGWcyhcsnWnAKtf9eAFPj6XAFqAxSK5yE+STF9OpFp9
 zNrG2y/gkjBzp8BSs6f8KN97cm+HUqEt/czjQsAxYQiaAkmX30pOJaMKO76L9xcbRi7RAcx9uH2
 QHvMSgV1WCqaQA0xIIVYwpawi2B62RtjqXNLocBP6/oPPh7JASjqURnVkfrcg76KIqi2WLZiuPP
 ZxIQ8d6nlOcNE/OJb7fPoG1uSPlHalD+oe69G/Y1H1jD2jnP+dEDu09qU5MJL8jitsXTUzXWElF
 BEHVL2XtpqnytlQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Clean up the inet_addr union by removing unused fields that are
redundant with existing members:

This simplifies the union structure while maintaining all necessary
functionality for both IPv4 and IPv6 address handling.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 735e65c3cc114..b5ea9882eda8b 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -15,10 +15,7 @@
 #include <linux/refcount.h>
 
 union inet_addr {
-	__u32		all[4];
 	__be32		ip;
-	__be32		ip6[4];
-	struct in_addr	in;
 	struct in6_addr	in6;
 };
 

-- 
2.47.1


