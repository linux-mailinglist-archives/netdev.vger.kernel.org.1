Return-Path: <netdev+bounces-190245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B69AB5D3E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA2D4A1542
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1632C0864;
	Tue, 13 May 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaEnJm+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9282BFC8C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165176; cv=none; b=ooPHB9uxT6sBvF9FeRxo6fUgbZMpy607qg4ABDddrBGPOvgbMPfS10PWeDHravv9EBhL5AmDuAqixxeru2UYovXSODg3B1DsGmBccENxkZvyWuGdr/NySkjGgHBH0ilNuocFAZDlTZn7yCRcL0vL3V9vWAax1RKobCsZ/TOcGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165176; c=relaxed/simple;
	bh=P6plcoCn/f8hl158IHj6qAYQ0rT/BBePb0/+W7ms7VE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rd7UWIT5p8EzvFWx51RuMjdXh7Dxl7u6v/qc2wSXWhd0tG2jVpvdG3ogO9AWRBZ2CkswSBL8BHFd/3hm5IyVrVeICyn6TgIFuJdSo+Msa7SrJ6ZTDiaEi8tyBQcu1P2j47Il07bdIUCe6K8bifIt8Sa4CwucOUbRq6DW5Dz2/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaEnJm+g; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5bb68b386so1972724785a.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165174; x=1747769974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8Vi3EZ8QxN/ut2jg54Car+ZaB5jX8ZbkHwyaQiAZ4=;
        b=RaEnJm+ggLMXMt/kQjy6lgcisS/TaAvL+5dFZkWAPMrEdm67Slno9VBiRoRsWHGRuy
         4P06ULV9G7CNhJQ5/K03xSqwu1fVNnEutOO7r2mh0kLDWpV+rhxm9z0dUV+tHn0Y3GM2
         9APNUGPMDijacExM+tdyEyVkSMeZa0O9199gUk7JHIvlbUh8J9xerQligNq5rHXECNTm
         rSWtW7TYk8APckBPdDRrxnC3IjPh8UT77WEQyyO6I6ZtozCH039JckaWyJPuDvHHoeKb
         eo7vSdnJkawNFOsoZAPefFvgCebWYQJW7rbAWWocTehj/CR2Cgn+26aHNrzIXKG7CRBK
         pNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165174; x=1747769974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mA8Vi3EZ8QxN/ut2jg54Car+ZaB5jX8ZbkHwyaQiAZ4=;
        b=h0jPdpDTL0EtrDigxEluqZiBBU++ZsFX9jdSNJDSsiK4UqfLYTBexBT/yWPNfgzI5k
         dNEytpOpQvFWhjNovxqOlZLnSoHqG8tO0R2tvlj3G5SrBD7wyfR5mPx+gd6bQ/JbK+XK
         THt4NEKCMnI22LrELkfxgRwcrehM3t9VDVGjZ6UiOTRYSlsYugwnd811WxCwGHXjWfmP
         VpEm3qCqUcRQA5+NISgDpRPnmi4ITaovySSTVyBiuU/8h22to+tf6XIMLp7sijGTavJc
         wd3Jaw3wFaY3MR5O1aJ24X/OlsSYtUbx6cZFa4yWDWpVV2qbCuCTRQ5rVxxq5l86GmbD
         waZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSi3cthB01ddHgZEbzD4BDcT+WjVqYePIEPnCAj9ryJ0H1b8dRDD222lKt6ghA1fdZidcQZSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OSUMCCnvStTtSRgUP7FM5tpB7bz2c6EC0mPbfNMqZH5CPvGO
	04naMaPTpGL6mQ91dc8plktFm3q7NFNC3WzFxyP8PAuBwSaYJqdsHiDb44ipXqRpgsQSpEsX+OM
	w+coOVhmPVA==
X-Google-Smtp-Source: AGHT+IHa1EE2MebiY5s5cCu1GhYFv2I6aMXWrR4fqW1KxQZ+Cs2LzvDTz8Isf6Uzz26WU6h3kVwnJA1sdBiVBg==
X-Received: from qkbdv4.prod.google.com ([2002:a05:620a:1b84:b0:7c5:f932:ef2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46aa:b0:7cd:27f9:6ebc with SMTP id af79cd13be357-7cd287c4b63mr102262685a.9.1747165174456;
 Tue, 13 May 2025 12:39:34 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:16 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-9-edumazet@google.com>
Subject: [PATCH net-next 08/11] tcp: skip big rtt sample if receive queue is
 not empty
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_rcv_rtt_update() role is to keep an estimation
of RTT (tp->rcv_rtt_est.rtt_us) for receivers.

If an application is too slow to drain the TCP receive
queue, it is better to leave the RTT estimation small,
so that tcp_rcv_space_adjust() does not inflate
tp->rcvq_space.space and sk->sk_rcvbuf.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4723d696492517143a2f3c035bfda6b05198a824..8ec92dec321a909abe00203d0097c8bf4df1a240 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -682,6 +682,9 @@ static void tcp_rcv_rtt_update(struct tcp_sock *tp, u32 sample, int win_dep)
 		 */
 		if (win_dep)
 			return;
+		/* Do not use this sample if receive queue is not empty. */
+		if (tp->rcv_nxt != tp->copied_seq)
+			return;
 		new_sample = old_sample - (old_sample >> 3) + sample;
 	}
 
-- 
2.49.0.1045.g170613ef41-goog


