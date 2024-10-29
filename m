Return-Path: <netdev+bounces-140122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE449B5486
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82047283737
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A2209F26;
	Tue, 29 Oct 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1efnV4Z2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EB209665
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235334; cv=none; b=J1kFO23vSrbsUVyvq4IaoZBU/qsW0usYzSusdxr5YK33hHAHPThaJfC8209zQoGGfvrxVWnhq9COA1yDpgTNziL0hd9nzCHJaV3jnhvnp6tITBE5/FH3N3UFbgscoVBXpuuNWXygI8ohyuBKCg8plDTgPjflkHUjhaGaMptnl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235334; c=relaxed/simple;
	bh=NpiPjVlAleIs97JWrTTn4QJPsC0BpJIKw9WCJk+Z79w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qDD+eVer122x9bJeKBq9fcy802hGH3LmLiuHBqkpxVKEMMtkeD3GDrufaTEy0uFwblczH4QVWhxtTSJ/gtCoffJxhjGi1eB9DG/fGaAbF8I/1iMVg2nWdPfLHsXhuoBYYuLmCwUlSIecpR/72+t/MjLsLkEOU53HL4+ayLpDyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1efnV4Z2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so9612583276.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730235332; x=1730840132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtLM3BZMi5MIdFZN9lcNyhV6lseOB34DRhYH9xsg+Ww=;
        b=1efnV4Z23wiBfCN5m7n8pF769vD7wIqHlZCh19BgA/DR7sqc1h/hi7n/Sqh9fJkBJh
         y6zDEXLc3QJ4MOg7+ck8XZmKYgiY7RJpK2chuW0J7anjwSxuVr6IRlqPRzqxgPnPgNrI
         8fCn8sry25ZGSJyHt6qGD8YCNbLKAOzKA4g2+sTY8fwoWIZvBIcY2yCd4497hxB7euNh
         Pay388eOvsnxK+qMcR+aA2vfMKTt73ee5x/dUdTw7xI+R5RQ9OggHJ2vOdOMeJY1/sHA
         ixOOrP/j4IrgKwaEP4cHwwWsTd1JntvThxZ8QLPR02RO+bC0avrVPE5/fmjmpeX9jKkb
         sMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730235332; x=1730840132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtLM3BZMi5MIdFZN9lcNyhV6lseOB34DRhYH9xsg+Ww=;
        b=Ve8/YgJSATVDbc6x0kxKnNhOnsP6mJF8PMx0YyQYyYNXOQ1M1vGtqjk2mt0YtLHtTo
         +Yc5qU06TpdtmtTp3BxS5bnfb1AA+1+/b3uBINMHZQpGPIt5MzEDnPEI2564mnct4rul
         9HkE1eJm7CJVJ26Qjx6TaH6ytlbFz3/O46ddnsa3xAlxDyvgqEPAOn4enlFpe4X+521t
         Qw9W9rbu4InWuAfu+EVPrmiLRzk+PQC7jMzozPNy9TfVyZZNfVbTB3HA3CPrxFPJVcCu
         s8463RCwYrsx1JUNy6170nTY7FJ/q5yYpI8CMns+MhS08qhq4fZb2xrI8e85zc5gM2kQ
         4DfA==
X-Gm-Message-State: AOJu0YwX8wWKIaAfSzsLMbU7TKK5JVuzd17VGcxn8ZLJHa0dG4TUviPM
	wTTiUIoHFQxLpJP+rS6aXx2XCtC+bmjBdrWzq4Fpv20N4uSbGyVtFxuG9cbXOwgJgdMl4GwIgm/
	hkplXcukDhs7M7sgyy4JFAjTh17Mx0mC1+QvB+EdqhS5SJhSEVjo7FmX0vT0eeik0Stje37Wgqe
	Ff/OmsImERQlVV34TY4+zzhyxk5RXwMmYtdsxyxh+we7ijIWHkUmtKk17UHXo=
X-Google-Smtp-Source: AGHT+IFn71lHuPHiTD9RgndIXcKae2ZOCG2qnAN6B+/dPZ7/I2Uz1eJaAxX4qOtQrBvdw/LPXzQJ1QqhI/OPErXQEQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:c78a:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e3087c2d8b1mr69575276.11.1730235331689; Tue, 29 Oct 2024
 13:55:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:55:22 +0000
In-Reply-To: <20241029205524.1306364-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029205524.1306364-3-almasrymina@google.com>
Subject: [PATCH net-next v1 7/7] ncdevmem: add test for too many token_count
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add test for fixed issue: user passing a token with a very large
token_count. Expect an error in this case.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/net/ncdevmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 64d6805381c5..3fd2aee461f3 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -391,6 +391,17 @@ int do_server(void)
 				continue;
 			}
 
+			token.token_start = dmabuf_cmsg->frag_token;
+			token.token_count = 8192;
+
+			ret = setsockopt(client_fd, SOL_SOCKET,
+					 SO_DEVMEM_DONTNEED, &token,
+					 sizeof(token));
+			if (ret >= 0)
+				error(1, 0,
+				      "DONTNEED of too many frags should have failed. ret=%ld\n",
+				      ret);
+
 			token.token_start = dmabuf_cmsg->frag_token;
 			token.token_count = 1;
 
-- 
2.47.0.163.g1226f6d8fa-goog


