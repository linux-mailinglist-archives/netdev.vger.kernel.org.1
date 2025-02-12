Return-Path: <netdev+bounces-165356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5496BA31BBE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BA91889896
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78F19D087;
	Wed, 12 Feb 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDDd3Y64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A775155C96
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326311; cv=none; b=jWFnOs5YoVAT1D3QGi5ESrK3kkAOoWAIffKCDem17VmmzvAYwjBZWD4FqlijffTTSolSFsRjdS+KuXrJKLHom6fXC8mTQe2KxYwdBCm+VnblzXH5fAB2yKM6G+CBbd4TFsIVzCfX8hJdjsKtqUFqHloIjkSqa98m+fubaGwDPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326311; c=relaxed/simple;
	bh=lGZWu3jPg52+pH/sJcRfMQ2FRfaimKSO6mvYUMpmPS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9tbe3WLvbcNFk+/VFQfJpXMKkVDHeBDhSRumomR3SbHMaLhiePwaI4igkPZ440P5qVZHjJlhonF+zRAbP8RX/tioWVRdK6EqFcxcEYc9TrrvKbN96Gu31Vx9j0XXSCsrxwFUmEjBm9mnXaHqWoeeM80Z//TBue+p7KQhWm9fMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDDd3Y64; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e46349b7daso30708236d6.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326308; x=1739931108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esbRzenWeGW8N6g0TO6k08/dN2AilbZBXiBhfK+nIOM=;
        b=VDDd3Y641nxUU6xjj+XOtz1faYrgtqqGIkzpQrqRJMxvTkBLjFI06/uoFbY1zC6QuP
         M+Fsblo/gXLPEtm+AGt5bWbrcOUpenIZmZG/WFEv8jNOOyyNWY2no0F16nDmInwpU6bu
         knDX9BVbw0ZBx2ta1eqfHbbTASjXK3P/hE6dkTrSMJ3fmTzYeBKgO0aUbl1jCJnOBOoV
         AnN3JPD6D7b8ovLbJDOdJXa3W+89+/pV6Wu97NVn86yRvz/rlZuqs3zA+7VlWYBws/4b
         1iPBwHwbWNSmz32vIaZAWQ8XiSQ//DnbbDrSnltsBjUOmH0DnuYt8G0tspEdoraj1eCW
         CXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326308; x=1739931108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esbRzenWeGW8N6g0TO6k08/dN2AilbZBXiBhfK+nIOM=;
        b=DqQQxq/BYI7k1DO6gKBtWzk81OoI7TFG+F6OByF1b99QtgiLOfTIounIwXHOVlKcIT
         IGGZDi0z66rn8doV2ejTh4fBOjflJVFRxAuUFaWeBu3Z75jdQq4bLhL3N1hCw7aZaBSV
         djEMs/cSUblzv/dCd1EsMP607+J+zvEFLkiAvGfuwuiIP4l4z44v2T03fz6b/Ox0zZLx
         gYVnub+P2gNldNxYS54tPR0/KmQgLw+iwfIqNvLvxP/cVhtwTL+W8dvZ2bDGIkF6Azkp
         65iPM0kDdEIUpf10Llmi3wUE+VdhRZiuVA+/NM11+AVBJP0QWATLdBHuPLMzDhfZG6Li
         NPgQ==
X-Gm-Message-State: AOJu0YyQCYLtS4ZirosAakPrlpvWolaR1EhjxJQx8BBzWeUUqgdcHLCB
	KPFqeZMMN88hHDyRY82L7DlWSVbMjgDbnmGUIcdZManO37LUKw84VV0fbg==
X-Gm-Gg: ASbGncufGsPyueMZYyW00VWmQrTfwj9601ZSqg5uxXNjNEnwOeIyjyXq3TdWHzOArI9
	V2t5UN0CWrsVCc6Uynkr9PrYpb61PuKO7x3YWjLVZWlsTmDhQkZioLp35kB6Yn7utZ4/ZHLGbne
	MESCLn8UfnxJ4mmAAe0Q0EEOrJdLZ8uAQ7qj+wkNK250eaMKbpzCHQFwKSU2eh31eh2E0HCm5E0
	knuN+59brkRXebGIkiUU55bIguHwy+nUbAFL7eI6kgw5odiAONRK/22ifocpb11F/aAkhnzt68j
	xJwMQam8YI8Nm95kTdeeCTD3FbUR5LmY/DUvEH0B6taMUHlnF4xvaRP+peSKfeDvha5SzJF5++I
	8XaIGC1G13Q==
X-Google-Smtp-Source: AGHT+IHxU1ot93AxPIs6drzNiaufV8N2qBgz4l8EfuPJdb+NzOIzjnTh8dcymldvF+fDFscvfHRk5Q==
X-Received: by 2002:a05:6214:e85:b0:6d8:7ed4:336c with SMTP id 6a1803df08f44-6e46ed77270mr28191786d6.9.1739326308282;
        Tue, 11 Feb 2025 18:11:48 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:47 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 3/7] ipv4: initialize inet socket cookies with sockcm_init
Date: Tue, 11 Feb 2025 21:09:49 -0500
Message-ID: <20250212021142.1497449-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Avoid open coding the same logic.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 9f5e33e371fc..6af16545b3e3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -94,9 +94,8 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 {
 	ipcm_init(ipcm);
 
-	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.priority = READ_ONCE(inet->sk.sk_priority);
-	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
+	sockcm_init(&ipcm->sockc, &inet->sk);
+
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
-- 
2.48.1.502.g6dc24dfdaf-goog


