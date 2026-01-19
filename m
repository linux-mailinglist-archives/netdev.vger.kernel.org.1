Return-Path: <netdev+bounces-251312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921F6D3B92A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 894E1306EADA
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354E2FB08C;
	Mon, 19 Jan 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="GxSUuOcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D9296BBF
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857182; cv=none; b=h/Zyq9/gBYRzmMvchC0DqCRwzQsIUYiBNd6VMzzmjpUatzLqYDNacMwbYCGrAiVPahg2AUG7/46vUFYlq5mxY8JvUOMsBe4Jtgm+vF80Jkq959NxckYfcz6UBXdswqHNUT627wWbXeWlqs58SmyOYO+W4Yk3jPFjTxab4SrV+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857182; c=relaxed/simple;
	bh=C8OZ95/WAU5Mgc4JqBFq9iwhhE8rNCstGFD15StYgfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLlw8h5FvLsEWi8sGmgeGwn4Q8qT7mlKOHF40cwXtBnuwknyi1i8lyBpIhmyBJt5VWvKjZUBSgc35IQpmLipNP9lAJ6L122oT+iuaxRg0XpkcF1gHMvgYv3K0pyjFp5DGVoq4369oXWOBassxdIvtGX0QGs5jeikgpyfZ5RLWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=GxSUuOcK; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4805666eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857180; x=1769461980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=GxSUuOcKXIyIeYak41VZA/3Tysxjh+i4V0jJq+wCr9EBbGiAM/P850lB7ftYn0+RKR
         +jKnbOVuGkftd+wspTivAwhc2iE+dEWRdQifaO7mcaPR2pyTP8yqGDIiA/Ygn1otneB8
         5xiCOIWR/5MqpkkzN/QdO/h+UxQ+n7YYN9CfmzBsLsmkytCUluf58dUQahBvXyjNuS7k
         kPzsPxDLg+w1g/vW2VeP9lSqjhNFyoqA1kAGldciVYTlqXSX3oa/j2lxSutRv3gTmdMH
         WNzbIgN8gR9cKdVRsSIrEqk5wwO5865NG6nFxYbjLLBjdOKGDmLXXH2Z1CC2Uh29EHRA
         /m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857180; x=1769461980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZO6+38dWH2OotCsTPz22/g1kneoq3nExDC81to23zRA=;
        b=bKQWs+pgxQKPhDUn67OQ5B4uFnha9HB2AsueKaSa1DGVaUuaM+nsStu6nkDzDZag1Z
         9qhG+B6GURAV6bGI/E6Kr7ymXxTVFSs2HagcLmANUm0fep5EKN+F/6Dra+qwX0/kfwUz
         /W2xSAktwvSoSEhBp9g2ZaBZS9EipFZRvYXW8tZ2B1t9RwVGkP3179Cl0KNd06AOv5V9
         OrdzKnvdMoz+aVF6vWKaYR8RXy4TrIi7nv9mTySdq2I76EjI5JrdJV0MBxkM6tDJLlTz
         aSCqokIs0PbLnodSC2L76rdQl/coVpc44mWuuA75v0iKqEXaaSDM8IRfAEUIwRTlW4wY
         qL2w==
X-Forwarded-Encrypted: i=1; AJvYcCVXoZ93mM72dNT2XTTZazzECLp7N+EQ6GqgFgy4Lto7dxLf/099vpdH673rOmT+m5ZE4sc9Jbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgPkQIxWd4ylCVhLdvOLY664O0IN5KySVFZmhgNmAK46FZgXE
	ZJFIIh+TWCvTj7+BTL2/wTbE17ljdDMSFy+Q/ups776uSnjM5DlqM9AZDxDW7lJGeg==
X-Gm-Gg: AZuq6aJlHm81Ax33z2II+j9v1Q1llq4r0yYDUuOcMrubf5Lxga/6O2F58ijhaCEi6zP
	hn9GCmdN4GMo5D9/eWtmgKuzCRugm5JEags6YwJ0GiztW6pkdEwxw+H5v4EsqBsCOw9/LOWUdwF
	JhMDrfKtIws0HkIPMsf4lnuCa8I/v88yEyNiFOaZJ2TzsZoW76pOvNxPs/QWDXXZOyOAv3HFZYC
	yFUA353SFEGfpweIf1ol8WJGrkz96KI3ya+TJnMnWGWITmQTogU9HeVOCivsYRyp8nkOrfJ7TuA
	3Pl+rTV/ZrpYZm7b2QkLJs2j6hC8O0ySFiUCNbQRyqd6/aE3C7IfWk4UgfQ4wg6MRwPOk15+Xjg
	D9LrnXzWmmo5x3EYky+XOPcuUeoocsS2t8SOgDtHPlmZ8334R5p8pLPDwmpYksmuDuAqcCYuI6R
	ZIQZKHqPsNq3VUK73KjFNUgfWaTI9VBVWtzYiJtD4hdPoOSFbC8yq/TX84
X-Received: by 2002:a05:7300:7494:b0:2a4:3594:72e3 with SMTP id 5a478bee46e88-2b6b3f2a8d7mr9597829eec.18.1768857179999;
        Mon, 19 Jan 2026 13:12:59 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:12:59 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 4/7] ipv6: Set HBH and DestOpt limits to 2
Date: Mon, 19 Jan 2026 13:12:09 -0800
Message-ID: <20260119211212.55026-5-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the default limits of non-padding Hop-by-Hop and Destination
options to 2. This means that if a packet contains more then two
non-padding options then it will be dropped. The previous limit
was 8, but that was too liberal considering that the stack only
support two Destination Options and the most Hop-by-Hop options
likely to ever be in the same packet are IOAM and JUMBO. The limit
can be increased via sysctl for private use and experimenation.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c7f597da01cd..31d270c8c2e4 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -86,9 +86,12 @@ struct ip_tunnel_info;
  * silently discarded.
  */
 
-/* Default limits for Hop-by-Hop and Destination options */
-#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 8
-#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 8
+/* Default limits for Hop-by-Hop and Destination non-padding options. The
+ * default value for both is 2. This sets a limit at two non-padding options
+ * (see sysctl documention)
+ */
+#define IP6_DEFAULT_MAX_DST_OPTS_CNT	 2
+#define IP6_DEFAULT_MAX_HBH_OPTS_CNT	 2
 #define IP6_DEFAULT_MAX_DST_OPTS_LEN	 INT_MAX /* No limit */
 #define IP6_DEFAULT_MAX_HBH_OPTS_LEN	 INT_MAX /* No limit */
 
-- 
2.43.0


