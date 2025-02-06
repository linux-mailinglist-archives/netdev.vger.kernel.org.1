Return-Path: <netdev+bounces-163647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C129EA2B25A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1CF7A186A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD31A8F95;
	Thu,  6 Feb 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpZCoSLS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF941A265E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870530; cv=none; b=CHFEonGtiBoZiXRgrWP73MH6DTS5PqurLxEkjCgoaQfjTjM8UqmkGBB8j7g7adFT0vnFDr9mvgX/79+vkCpCnKL93pV+ANF/WzQA7TkIP07kEiQQRE584mDOYuQD4sHxDrmdB7NhFvhcuGC0D/OvO5t+5jDkDfx5+5sYd7X3A/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870530; c=relaxed/simple;
	bh=QygX04I51BXpRg/71AhnNhGV0vVoH7LJVYhFcnQkF8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZIkmZii4B7YxB7C+a6rLo8U7p2DzAyRL0cU2/6qmOzvTOLsNL6+OqloQfQADPb7IUPStEMx2SdV0AfbV2YhyPgLOUwlak2tTo0lVk/Y0i0rvOfa1ZiwNPXnk2whZkg9VbEWQzpHC+44PG5wpTiOq3cdSJCE3ItwgyIY66vZj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpZCoSLS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c7855df10so22013891cf.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870527; x=1739475327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Kfk8tx7yFTz1fGWHvM+mv1grSUJUUWgJMZFXYog8RY=;
        b=UpZCoSLS9vimGMegKw64xqpNqxjqNpzUmcrMwg4yqC3JdqIcQ2Sa0bqU2b+jkZK0ZF
         GGqmB4FZTdQx1AnGX1hsANuvjqggWLwgOMaOuGwfU8YKxEbz/VEAWUECRev/KRUS7VPb
         tPhBbbZEzCrpxDfGiIM+43/3SvS6jC7jn0a6XGbDiCkYe1UMGIjyhu2anemqm1tU9qno
         E+Qy5544BWkfhRq5Qii9gOwO+Gu5PUQ7eKsHRwBtPCfAOczX+Fb1t3ajIEfeX/KhTHxV
         PpPHSxl3kwQBGQcnZPclTv43eQriwQH2eURa8WLIkkAvjDrSSWLQtqqIOS/mrqKHtYK4
         Lz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870527; x=1739475327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Kfk8tx7yFTz1fGWHvM+mv1grSUJUUWgJMZFXYog8RY=;
        b=SduH9vsQsgtIXppY8O1CNy6nPrnuOedE4qzL7BOjXCf6qGsa9RsYirNMtOCOW+j5FC
         st8ScXgc3aLVbTFNNsRpM1OKxuNKVNjj1bpECqSBGcPnTgrlD5v2UEFPYsoHH3yffCBM
         TgaC3fuA8h7zLXa8jKuPzdeEmTt0TPNCAbRytYUPIZUlJnL2YTjcWbUTx4tkdSFaD08g
         HkZtanIv4aEIrgL6PAvkNu7gPc9ufB51cKlN6xZQ7QrDGhFfEZqSvHIBzG0AuG5c843+
         yNVUrNPlLlbvcC7bBMPmHjmhfx0T88kOvntINSlI7tsuW9hFPQMqrRAGSI+u2nnh0P6P
         SBzQ==
X-Gm-Message-State: AOJu0YzYlGmOpGoRKN07L0q5PueiMn9irD0CVkmTWl4ueCAujMXv7sDO
	nlgQfmsmxDmaV95AK5Ub7E+fl7+AujOBjZp+3OLnKwbQX3lUkNJ1bdeaaw==
X-Gm-Gg: ASbGncs0uQz1L2YSO2gbkpR+NDIOyALVyoQrWtUk66Khft9Wev9OJ5Vvv4mejMtwC5E
	b/WRJsSHtKdBMmFLGYCMUMHylv418qEUsftRs8co3WQZ187Ihxqxah4tjfZUXP7uW0oKHU6LQBM
	CDp2Nu7I+rJzFD2rLjzXszYrwfOmI69OgpjwPQvRr8t5tqcPxK4EENhVC3WsfdnaZkZiLevRI3U
	ls68T1nUvUHh+IceO/uhReg9v1Tpkg+c+ThKbTHB9RAQajEN9MOi1k3m/pgMXlK8I96NQYStRhp
	XbOqu+s+QRNun0VkzevSGZldQBQwAnjkAMb3GO92tR3IWHVNxFa65Q4OYvYpcAJ45zwQ/c4yif8
	CPqzseI9N1Q==
X-Google-Smtp-Source: AGHT+IFW54NHdl066U3/GA/AUZmhKu5oNo0MKA3zymDwlTC2nFCgwnn617WUR8o6eDRaazqI5Xfe5A==
X-Received: by 2002:a05:622a:12:b0:467:956a:6a5d with SMTP id d75a77b69052e-47167a38e64mr9216811cf.27.1738870527636;
        Thu, 06 Feb 2025 11:35:27 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:27 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/7] tcp: only initialize sockcm tsflags field
Date: Thu,  6 Feb 2025 14:34:48 -0500
Message-ID: <20250206193521.2285488-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

TCP only reads the tsflags field. Don't bother initializing others.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Another option is to entirely avoid sockcm_cookie in the tcp hot path.
Limit its use to the sock_cmsg_send branch:

	@@ -1123,13 +1123,17 @@ int tcp_sendmsg_locked(struct sock *sk, struct
	msghdr *msg, size_t size)
			/* 'common' sending to sendq */
		}

	-       sockcm_init(&sockc, sk);
	+       tsflags = READ_ONCE(sk->sk_tsflags);
		if (msg->msg_controllen) {
	+               struct sockcm_cookie sockc = { .tsflags = tsflags };
	+
			err = sock_cmsg_send(sk, msg, &sockc);
			if (unlikely(err)) {
				err = -EINVAL;
				goto out_err;
			}
	+
	+               tsflags = sockc.tsflags;

This involves a bit more rework, to have sock_tx_timestamp take a u32
tsflags directly.
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..1f94b4e6c7ec 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1123,7 +1123,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	sockcm_init(&sockc, sk);
+	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
 	if (msg->msg_controllen) {
 		err = sock_cmsg_send(sk, msg, &sockc);
 		if (unlikely(err)) {
-- 
2.48.1.502.g6dc24dfdaf-goog


