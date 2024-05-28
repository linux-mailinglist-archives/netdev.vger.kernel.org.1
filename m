Return-Path: <netdev+bounces-98707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0848D2234
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF531C214B9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1A173338;
	Tue, 28 May 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z7sZPATP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FED17167F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916439; cv=none; b=hYA/65CHPGZDV419eovYD/ckx6rE2GtqdN5XDLa/WqXlKdHB4irtdfntih/U+QBun2ly+MXqYNTKSau4nVJMxbUqpGFWyu+sDqD2rEvBj4wf8S0+YC+NHvs/gPp+fgRVxjL6i4VEErAGx78Eo2A2i03MzLf/37hrosM+bJiTjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916439; c=relaxed/simple;
	bh=iG9BOJcSxl8YXz51Un16GiWG5FA8K5O8l12pkiV8qqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JYd20tv+fhI5z/l1kjSAhdogWUYUYEJDzeaDPBE/TrfpBRr7laU+XmI7Koy/A14YNzT5M2jzjdyK9yY7GOVniepnheBKQSKwlfJjer0tjsxgJOMIeNLmARfdzzB5wW/qaj85pEFKPMyghgivvOtWBYFDVIfQMZuM9qxQOMaTHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z7sZPATP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7719a8e7dso1770192276.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716916437; x=1717521237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Of+ZQHLEtghH1ZmmisJuUEAJKFNFpZXzue2dQ3pMulY=;
        b=z7sZPATPAVchS1+ciIPDJ4hHhpbQb9Tqmn+x1DIb/eFGVcXo/uQ0muFFn1OrfrkVtV
         +4tiCHbq+pbgBQNtt8QXP5HcWU5akBQJQWYYBVedFFqRw8v9qMWRjRliVlDgdX9zazh3
         KJIj8BGXKga+8mBNPIfZktSgCpXOtW6JRpwZJwEOjhY9peXX12bw/f+O+yBIy3IGD+LC
         cTGBLVpVqE52TDy4mJBNsC/a/hGYlB6mwpme+KISInYcIu00daeuvMrHCWjpgGz1MWdA
         Hy3D+aiDlwgdZnb1S/SH60Sa1gzMeoKQBb3jLb4s2y+3a5sezVZ4c/i4rtOkXY/QtzEX
         8OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916437; x=1717521237;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Of+ZQHLEtghH1ZmmisJuUEAJKFNFpZXzue2dQ3pMulY=;
        b=uZHWvVKmDhBZ4J/xngVDdssPxSQK44cIPkMU4jNpUPjfpTZrk0lMYKeX2wu/yg6L5I
         97p3aiy6DM3LCv73SBssax92Xm7j/3UhKxK1nPgd5o6C4dAXE8UDRnKqmaZymdP9/cq8
         e+7C7TsCpnJJ0HeMViFR1Lkc2GPkvudJbZ3iz1THYjLiW1YpG03EhjXrwX6JWbCuWeot
         Cq/HWHrUjxpoTgeZlIqLibm1WOJBkIB0NoSRzWlYYth4CQ2MS1uclu/6N6lnkhrIeeUi
         qulch44uu4GgNj673J4EagZ3QYaRdtv/32ow6EiW4T/iXyNLI1NkYivYsDG2uoSgLPeT
         4Hlw==
X-Gm-Message-State: AOJu0YwV5w8vJ9/+V3jdSx01L2DVCofYOCmQkDQ5teAwH8mGSQARNeG8
	NTqKJYvsZACK179w11O6Hj0WZRzvcRipNk5m4RHJTItS7cq3zeNHro2+BHD0jzUWcQ==
X-Google-Smtp-Source: AGHT+IHcLSD5IV2FEchwCgL4F+hztDhQuAxuw7fBukwYoveMcJ0N+azhRIP/bSRIeVdrxJnkYayt9ok=
X-Received: from yyd.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:13c9])
 (user=yyd job=sendgmr) by 2002:a05:6902:2b04:b0:dda:c57c:b69b with SMTP id
 3f1490d57ef6-df772051c89mr3893857276.0.1716916437091; Tue, 28 May 2024
 10:13:57 -0700 (PDT)
Date: Tue, 28 May 2024 17:13:19 +0000
In-Reply-To: <20240528171320.1332292-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240528171320.1332292-2-yyd@google.com>
Subject: [PATCH net-next 1/2] tcp: derive delack_max with tcp_rto_min helper
From: Kevin Yang <yyd@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Kevin Yang <yyd@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rto_min now has multiple souces, ordered by preprecedence high to
low: ip route option rto_min, icsk->icsk_rto_min.

When derive delack_max from rto_min, we should not only use ip
route option, but should use tcp_rto_min helper to get the correct
rto_min.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 95caf8aaa8be..c90362c1f724 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4163,16 +4163,9 @@ EXPORT_SYMBOL(tcp_connect);
 
 u32 tcp_delack_max(const struct sock *sk)
 {
-	const struct dst_entry *dst = __sk_dst_get(sk);
-	u32 delack_max = inet_csk(sk)->icsk_delack_max;
-
-	if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
-		u32 rto_min = dst_metric_rtt(dst, RTAX_RTO_MIN);
-		u32 delack_from_rto_min = max_t(int, 1, rto_min - 1);
+	u32 delack_from_rto_min = max_t(int, 1, tcp_rto_min(sk) - 1);
 
-		delack_max = min_t(u32, delack_max, delack_from_rto_min);
-	}
-	return delack_max;
+	return min_t(u32, inet_csk(sk)->icsk_delack_max, delack_from_rto_min);
 }
 
 /* Send out a delayed ack, the caller does the policy checking
-- 
2.45.1.288.g0e0cd299f1-goog


