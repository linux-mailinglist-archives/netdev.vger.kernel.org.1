Return-Path: <netdev+bounces-70716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9D850177
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8504728A057
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265B5234;
	Sat, 10 Feb 2024 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8NdWIPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69F1FD7
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527809; cv=none; b=X6AfW39XM8a7Wek1fnJI8qYkQ9z9kEOoW5ah7V3k6itW2kRqp6AmQJdTIzpF6eB8jh/XRpghh8DaJoO+U7TZ8uPg6ELq4f+lv4dlD9diYxx55I58IJXXI4RcNM0W/qtNkQMf9v0du3WtjjkQrV6UljHxMbjE5dCW8WOiHPaSBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527809; c=relaxed/simple;
	bh=7XJjEgvqeEf1C270MBQlNS8089wSLDXw7au4fhViZ9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQzBpd0rf806oLfiWqW6Nl16VI33BFSOk0db2xNtcw9MXkAHGm7HNgQNUR0JoWEGQGSCsM7St3+y1UCmon7v8K4RnUw7alqGKt7PNnGxxfZ9qXubkBtDvPmunXf7mb1yIK0HFKKnezGOCfuHymOfcISHqBWgJPKhg/mo+3i+KKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M8NdWIPI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296d24631c0so1081832a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 17:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707527805; x=1708132605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mUvX1itSorxxJJ/u/VSZ6UrN6IODCy16GtowaQvelM=;
        b=M8NdWIPIRQmuR3ktJOzF8F+v8uc3dQaviwFg6/UH28ysFphpayPZH7Rd+fJ2jKaJCB
         nfaLk3KB6ceySGXz0NCZ5HWs5lm9bJTWLcT2t7rfR+Spk4tFhBFrD6CQ4dodX6IpXW2q
         miSULLf/BitwVsQsc0sWGHsnkix/fDPsdCdbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527805; x=1708132605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mUvX1itSorxxJJ/u/VSZ6UrN6IODCy16GtowaQvelM=;
        b=PCzT0+c2hrEejwlzt/4shpbW/YlIDZGZXweolOAkdXnwIr83ewU9pYuSSLHsOMdb0w
         GKdMdh4WevKm4gs7ZEhc/iX+5VWxFm7Y2ziE/g0Ff1IkJXPCIeP+rY2RkgNfZw8Xom8k
         iGvGliV2PlH0gFsxp1JEaXRcQZwzd818pPEVkmxPjEjAlQGcxILQ+HrNQzvRDEd0f6Cx
         3V7Qr7v6eq0ex9eQUyNhZRiPxAnsfUi4iywtzR4D13Lxq3dlaKyTLiXx6xtnl1OtkaKY
         YneNiadm/lxCdX1mMQM2U55kyn/JlCNhixpp4qU0j4/ZGwA4w/4YmUaLtVZceZ3KmRBs
         ZzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtru6jragJqhd6ZCsgKs5b2wgY+u3Mrxh3TDgd8eQj6CGgT/A3paJNe4bUSNbjXUL06dszehOoleNLQfu4j3ieRtpU0waU
X-Gm-Message-State: AOJu0YxKZYuMK/8iDIAK4NMblbMzM/7cQC/uxLGFt180nAxk8rvTW+dW
	UyBCNNcH8lZrk/GhtSm6QximaS8WcWjX6bDbiYPZOhyAtte1FIXeoTcnohTRlg==
X-Google-Smtp-Source: AGHT+IH6tbwWdPxhsZFHudRBZ6pJTFjSN4L0eEKXiYI/GL4yI3y+V2ANH7bQZbSma+RQT7XTv+6W6w==
X-Received: by 2002:a17:90a:eac9:b0:296:e219:eb1c with SMTP id ev9-20020a17090aeac900b00296e219eb1cmr535338pjb.37.1707527805350;
        Fri, 09 Feb 2024 17:16:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbfrX/vQ+BW17JmTFpCKFM+Wjbut2AMZLVfF/TwhbELBU+Y7ookg2n0ywiZ29PwM0IcVNXt5PB4F0bfr8zLEcJTjtnSFUS0AWU6ANuo9Z5Wtt+FRFxLvHxwXdQIJwAaZjRvDk9Z+RNAy2aAJ3KFhdGgakfHK0VWvSW9g7wnfMWyycqMqHESNUsVPZf/ANwPkZ0sqWJQHb7WW6JN/VfOv0ZpeLyHy8t3oKOxl+42jjjxJStyxbiKkiQMpgtLIWfZ7/ugiTTqCqoVYxSWgWMW4/Kth1JgAl2lnKtkPchsmtuMYwzrnD0l3XLLbRCdeWmkq6FYpuAZ08zEkR3AaHGaQkS7P1qzql60GE2Ul/rpAFOqc0PKfN/i8zg3kOGu9Y0PoUMwHBkEjqhJRPyorJAgsYM2ndATvIa1EOCCf7yQvrxj8HjOG75LEGkh6D2fa5I1F+SfVAYOa8hiHk6cL2LgQQgv9Qc1FwinCp2Z/23025UV911sRN8m9GwqsSY6H0K
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s21-20020a656915000000b005c662e103a1sm2171623pgq.41.2024.02.09.17.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:16:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net/ipv4: Annotate imsf_slist_flex with __counted_by(imsf_numsrc)
Date: Fri,  9 Feb 2024 17:16:42 -0800
Message-Id: <20240210011643.1706285-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210011452.work.985-kees@kernel.org>
References: <20240210011452.work.985-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=keescook@chromium.org; h=from:subject; bh=7XJjEgvqeEf1C270MBQlNS8089wSLDXw7au4fhViZ9k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxs56b/YU9uCWyX1kD51B/7AJ32jX6Ko3rsWCD ItxtYxKnueJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcbOegAKCRCJcvTf3G3A Jri6EACJUceo9gf6zPJCVHzFHPzJ+cKBEOecAQBjsrUQfNTiy7VZT2/P2C19Wsf3zLYOvxTr22Q mIGdvbjFOPTiZ/J4cH1+l2q7zO5PR/zS/5955PGAaCdIzmp5Z2mero036OEvuYfcfiDT+HHmROK J8RgVZDHh405kaxnoIn/Qe5YdrC+0YmuXd/8fj49EHa2fQSvk/ro5hYF+k+kjYsJLNVic9ssfFc X7ch/slGcLT5b3FIBJD+C1BGZQGppSy+Wv4ySmQKtfvuHqLGKvY/sKsUPthayKuilUe3X/SdXSD PPY0X/CHnKa9btW6GjQPWb7Oa3AwSxJnZQZBaMbTZk96bDwPVFar1ztYAFVaYkZpjSWNk6WDJ75 GH9YiiSZQHY8xV14ykgbRnxyZQULRYTdzUXwuEG8ifkLYkzJCW3TmN4kUEuNzL+kiclRLw1zQqL QMOS4yGsVBOu5cK/LGbDWhFbmxBvmNcw7K35YvzL22UXMNQ9tkpMU3gxRpnqbDl9nUhKmSD8LVZ WcSZuv2omy0/5G2EWB8XBrgtdYivyhS4mjqYoBp1edS83dJrRT/78mvm56jlS/t8Twk63QIsCMk 8TFHRHIo+jlikkTi2+AwcWkbzcqCGvARwro7mke7EUP7UAN0FufGN8XIRMC+ehaX2WZ2BNwnYZp CRIiDME9BkAFXig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The size of the imsf_slist_flex member is determined by imsf_numsrc, so
annotate it as such.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/in.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab628dfa..445f6ae76f1e 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -199,7 +199,8 @@ struct ip_msfilter {
 	__u32		imsf_numsrc;
 	union {
 		__be32		imsf_slist[1];
-		__DECLARE_FLEX_ARRAY(__be32, imsf_slist_flex);
+		__DECLARE_FLEX_ARRAY_ATTR(__be32, imsf_slist_flex,
+					  __counted_by(imsf_numsrc));
 	};
 };
 
-- 
2.34.1


