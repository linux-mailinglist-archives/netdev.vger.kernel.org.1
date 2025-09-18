Return-Path: <netdev+bounces-224518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CABB85D2F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A77C47D5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3773314D13;
	Thu, 18 Sep 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6yOTz+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C4314B65
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210732; cv=none; b=kNtjnbeZMXPY9BUPprO4rrYJ6xU6Bm1sDW6Vl8h6ISDZczjcYQooCgTk8kVOISo+YMIFLKI8hv3KuPAIuSLw3piibiRqonZZ8YDdujbWv24Br2QLDejjwvM9U2Bod34CZ+R72mLZhxe9KdgmGBjzzXhXKRtz9syOsUiODBiFoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210732; c=relaxed/simple;
	bh=a/vBsqZLt+ZHusWU89f6Obs/nNwsU9VusiS0xPR+usA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtmxIFWQQIXDw9pXqz6CuEFlWIK3wDt7bBLNy/fLQq2igYdB+3wKyYnYDPnQoYBzeB9mUQqWGK5GQqlVJRVMGn2DT3Mf69p7SZkgoqIhv/S056JuqAzyidWe3zVeNil7tum+Wxc8LN4hoe5343TLzA/sTeeFE3PdUUNDqPAlLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6yOTz+p; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-723ad237d1eso11287737b3.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210730; x=1758815530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZotaRmQ0zKU33/Ymopl3kyUns7cg+jMfoZ0yYXnZiK0=;
        b=d6yOTz+pzJQIM1AAAZ/vtGdsMTF63KBvRqga9ibmEDe1gqt8d/GL1ADmJiiSoQvz5B
         F0rQQR5r89q7fwlDPqrdOHaoVOhrUrOgcIDVaql+MH02BzhuJDv6zS+IC1XkvMK5Ze4L
         0qSEP25OQoangYTVTiH+qlCFJ5XU1CQ6dOT4Z7AUMIMeQdgJRXCoBe/BsxwpY6rGpCNJ
         0FTcx5uT07asBjsc6E0af0PaMk3thBjDx1pq6cJJ9g9zjsqpYNKlDxt7E1z1yKmW/4Nt
         D/VsNvTX9vzxy+YFGl5f8NU/R0vyR9vJI4HuhW9A1f+djuzGcIII3jMjQ/ot3eM2KIW/
         Pb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210730; x=1758815530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZotaRmQ0zKU33/Ymopl3kyUns7cg+jMfoZ0yYXnZiK0=;
        b=YI2NxvbL2QhNHL+I0Adm5+015cRZu5IqPtaqm06cxY+N3G8kaHIAU96Isqlpwfy4eD
         gKySh9s556pUbXzOm6fCMdc9wjOwRfpsLXN01y3gkpfWRZrc3cFtljVG7K7Mm/gh8Gxa
         uIEKF+h4jmwsWOoodb8Jr31djwWCS6n668ironvpdEDDXKX1qsR3e7r2jCFv/UddQosk
         z6idqjU/zSltocP756tlchs1gemBp28eVDTI3lolkBFxZ8xt/H2o+mYy8y6Scr49LV8B
         hQ6tiC1KB2D2/V5Ncli9g2xgQOrsDcdy8PtHpVXpLpLG+PUKt7TifZ50Rdhx/1xGM0PR
         Ftrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7KaTEHhOmFZDVfh0TsEcZ3Dwbun3F7uRPt6mTNbdsYN0SZq4oVMBSvinizcabVmHMsr07cUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqwlahBXqloOTrvCmK4mdSeYTy1mHe2honhEQ2brH2o2PTnCe
	FdZxrJtTKknZLdvOPAgxS8GIE58xFIO4L+jVYCRtn7kBP311pVKchaWX
X-Gm-Gg: ASbGncvhKsCnbX3wHfmu+yhK+c8Hw0sUL2B9cT4ooWXSqkhj+xkdeEnOkYxksHez6yZ
	F0+fKNwCYC9xe2M5H90AN07/y9Op08yaIF/gtue35xKm+wXZQkeDoZ3OQY9ktc4bubTcI+P99Bp
	ZU1KPUAOOouzhL7C992iiK1BWX8tP04u1xHNx69eT7ImS49suLtq+Gq0Ac3rS+wT80gFYJ7/UG2
	/Oraq5nPZV5xF5Ms7O7adpLKRTdZEd8di0eLyxsdgOFF82kCWaSBp6aL5vWeFnpZsRBcRSCRG9p
	XiTrEB3fe9+qk/1kbo+dhNE6SFpbv7MwXdTmjCvQenJYje/7he+sD4xWWsazu7Z6Ud3bFOe94I2
	iF9/6FrdHUOh5nuwrq8fqBR/AJt8lLdXyPYOTjcRg4gglmUV7rw==
X-Google-Smtp-Source: AGHT+IEJBLMHxSKIsg0k3VjYho0dDab3dfFPfl2pW82sYt/MWYbRn+8u4SfwmPxZIWMaIJsbimp0uA==
X-Received: by 2002:a05:690c:b97:b0:731:4497:f372 with SMTP id 00721157ae682-738909bc71dmr59661677b3.24.1758210729926;
        Thu, 18 Sep 2025 08:52:09 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcce7089sm910395d50.5.2025.09.18.08.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:09 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] psp: don't use flags for checking sk_state
Date: Thu, 18 Sep 2025 08:52:04 -0700
Message-ID: <20250918155205.2197603-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918155205.2197603-1-daniel.zahka@gmail.com>
References: <20250918155205.2197603-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using flags to check sk_state only makes sense to check for a subset
of states in parallel e.g. sk_fullsock(). We are not doing that
here. Compare for individual states directly.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/psp/functions.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 980de7e58f8a..ef7743664da3 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -129,11 +129,11 @@ static inline struct psp_assoc *psp_sk_get_assoc_rcu(const struct sock *sk)
 	struct psp_assoc *pas;
 	int state;
 
-	state = 1 << READ_ONCE(sk->sk_state);
-	if (!sk_is_inet(sk) || state & TCPF_NEW_SYN_RECV)
+	state = READ_ONCE(sk->sk_state);
+	if (!sk_is_inet(sk) || state == TCP_NEW_SYN_RECV)
 		return NULL;
 
-	pas = state & TCPF_TIME_WAIT ?
+	pas = state == TCP_TIME_WAIT ?
 		      rcu_dereference(inet_twsk(sk)->psp_assoc) :
 		      rcu_dereference(sk->psp_assoc);
 	return pas;
-- 
2.47.3


