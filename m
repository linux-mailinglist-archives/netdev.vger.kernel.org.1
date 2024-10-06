Return-Path: <netdev+bounces-132545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85199212D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EA21F21714
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8118BB9A;
	Sun,  6 Oct 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZUXsusz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB018BB83
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246756; cv=none; b=mZEQazNCoeOAyBL1SKzA5kPEYYT2U34z6Xsqy2lOM7DrTh99ZJe3raF2UVDzwj10Nt/6eDHAdzUOv8i4wR1fSiiK2V6dU0c7NTnwkScJMathKVwg1837y27j6GQNOyMWZ0+n+q9fB/UUwQndaYII5ydDilLlOLLyWp6+M4ZDXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246756; c=relaxed/simple;
	bh=5CD2vHD4iDomFD+zRyMXHslj/7EkOIstZWGcRfg/YVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEygihtaz+QZD3iiFbipuBb3CC/nbo9EUrA+wmwsUkOAWDriN11RovdlSJC2FDzVZBudZ0TgGjYr4u/2ILdM1QN6ScCgcyx77eOLvZhqMh4CKcZ8fvG0weNRTR6N2AFJC7TJVaMXUctH6qcVw0B1Yb+TbfD0+X9C/sKFYc7urYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZUXsusz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso5555450276.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246754; x=1728851554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqdflWDTEWZXIQHuvOe+TKvfOK+KjwD2ecbuIHYqymE=;
        b=dZUXsuszgQ4GgZpY/+5el/ASjtPRdYGkylX3RQzWXLkltiXS3uznMRLxCUKIY2D6p9
         p78Oc/PyhYFXVcnqTnVWC0zgP770iIDBWnrz+82GnWDP0lvKfPborIRvUCeBvBVwTgQv
         w8mNBqIiysi3my1B9P2i9YZLIaFeIZ5thbEGDFBoVBvdS0d6yCynnDN6nf/tOjTvID0Z
         Q78fwMBPwbyGvtSe547ub3z968ON6o3ib/GfxseeJC6gcRM1VxetRuKB6v+hYVhV0YFu
         aKn1rF6Zu9YBqfC31FkggmBJjXHY+aCyNZBwnQSW1wgDOx4U3fh4qTbUuSKPllt46g/X
         vFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246754; x=1728851554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqdflWDTEWZXIQHuvOe+TKvfOK+KjwD2ecbuIHYqymE=;
        b=uo0e9WEC7x4rgmkbqQtFqmq1h6u4PrU1Ua1xBuZvyqN3gl5mwQaGDcifn8g93Bk2BU
         fdcZjHFz0BrvKR27dTFe8fEQnVWZKwZeEosGgQkUWkCMuk9eAePPvlxJQkLSqDqN0utv
         ojSC/Env9dxuhtMPr/nwd6K4M3lr1qMuz9K62whjF0In8VLNKJoeTnj4cZxNbi+RE5Gr
         9SPCDucki7my39qGbU3UPjp2lnF8Vkpl1NCD71frNrbITGnZxCzV4CRIaFnGFMTJdY2H
         3/Q1xhLPRUiVRfcLOm0FBjnD0aDPwbGqhW8sl2qhlwj9Z/pPvy6gefCrT1BfmQmCxhU3
         kg6w==
X-Gm-Message-State: AOJu0YxpGSVHu/P5S6QqAgInc41lI5ti7rLFPiyUECgTCFEauG6/34Le
	s/iefVGa+JXDIolM0F/qEKhZ7YNaUrl4QgvMHfLbNLPMr6aHyKHnJ4jDpnLVGqB95fAOOIbZO1s
	rWXI8Wz5+lw==
X-Google-Smtp-Source: AGHT+IE2dhJauz50GUa4VOaoSWyhGjoYs5dr/ymimpTCgYApfat/GtdBCWrPNJM+v3mm9mqBHuM0LnI+oz8hhA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:84c4:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e28939399d5mr29734276.9.1728246753851; Sun, 06 Oct 2024 13:32:33
 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:23 +0000
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241006203224.1404384-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_v6_send_response() send orphaned 'control packets'.

These are RST packets and also ACK packets sent from TIME_WAIT.

Some eBPF programs would prefer to have a meaningful skb->sk
pointer as much as possible.

This means that TCP can now attach TIME_WAIT sockets to outgoing
skbs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/tcp_ipv6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7634c0be6acbdb67bb378cc81bdbf184552d2afc..597920061a3a061a878bf0f7a1b03ac4898918a9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -967,6 +967,9 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	}
 
 	if (sk) {
+		/* unconstify the socket only to attach it to buff with care. */
+		skb_set_owner_edemux(buff, (struct sock *)sk);
+
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
 		else
-- 
2.47.0.rc0.187.ge670bccf7e-goog


