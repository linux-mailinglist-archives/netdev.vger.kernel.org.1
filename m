Return-Path: <netdev+bounces-190248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C06AB5D41
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D808319E6611
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC572BFC63;
	Tue, 13 May 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06axBYdV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D972C0306
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165181; cv=none; b=nNauJCApO4LrIcKkzWZzVKivZm8lULhWO1KVmU4uN8v9ktp6giH4sc5bW9X7bUzbx5h8StbuDgt7yp7UK5CAu0w8XHK0aZ0zGFKv1yU4Xree9SvOBTWSPNtE8gH3BCcH8b3NhaiIae9R6DBBrl5HyXEBAZqLws3LzdBubTMC21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165181; c=relaxed/simple;
	bh=33hF+R4+3bkuq/JtvFKKLWLyc+uvw5LaQ+TcIAJb+OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MInovKWcRB9djUDiJQrXPSHw8M2d6bbJBc0gNQcbuG9TxSGNcJAm5RCGyYIMTN7trj4JLaLm8ZX4EJ3cpQBzdyW93lYMt+b+r4d9M0DubbgzTzb0g7YpJmJrYpOmepoMoinx7GGl9bFQAnq7/3UJP2bfm66gZBckpyaeqNPqhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06axBYdV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c5750ca8b2so858719985a.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165179; x=1747769979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/b5gd8AcBJOX2dLOtydVCeH7TNv7LdYmWiC5fZgD44=;
        b=06axBYdVItx8sjnvyLcJYKjk4RVm4Xo0iYNbu8NusxqyrIsdKEV/X1MKdmoHupsxdt
         uhBk0ZAGupnCRLBSp7fmoL1S3qrMDRFd+VfpLK5qSJ9YWW8g8To9sYGMUe3aeNcJUGWH
         Nh8C2/qQHn5jV7OHarpHpCGoL775nTcQ1uGWzFIYGUfqyjD2FtZStxpSZTc4sUG1KcfB
         7dIHszGmLhCBzBt3+H9fhL4uFAi/Wrqppq/BnE08WZaSQzkmWFRM8zXqwLBuD//gU3xF
         KzGqGsVG0xuTrIKYJUSfqujB9imvhrZhICbCBpk0bo4zedZr6frKiIQihpXUQIwWlkvH
         vYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165179; x=1747769979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/b5gd8AcBJOX2dLOtydVCeH7TNv7LdYmWiC5fZgD44=;
        b=ZDi6Uc2iFwgW8MZNBjOraZv7t3kiR53+aMxaWdME5SZUA/C6B766G6liq0jrwvT1ed
         ffhxtxmVOO0agBLYKfL3L/RcOjOu2DxXcD06e/zNPejZ9tam4tm57tjaTHTsEpsaDmwB
         /hlNglencSSjbdb9g+PZthuk+1OkRI/ftvdlWJtFBnRR3LQZYSxONGMhMT4eHWTWQ8jy
         0h0SOtS5sYk8q1ikse0CYaq60ODGJ5FGE72u5Y6x3kC0+2rQ2XgkEOc4MpYvEpUmxOGG
         gS8EXRYDQbYPoiQNUnvTE3oKCmOw5T7jpGmUxWjDFoZ/2kyOfbYg6UbB6QXTu/2qsQM1
         qpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdOV2bsSu+VIDgKnm2f70b4GlFQh3U57qH6UP4hc16N6ClsgSaXl1jFG24ZYm0qRR7qJ+mC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+rfreb6DZfJqDCl9xBMDv59+CKdQTNJZWI64SNmM3R5Q+JPe
	yKqq7pWrigpV/37lvjr+rvC9GMI0DZ23j6b17XwjI3NjgCu3X6J/uu62ghhpaxc49aHDn7xdi58
	+IWcStNg5gA==
X-Google-Smtp-Source: AGHT+IEYh0qFloNH3Sayqtlr2ZjMJIthL4fEfUPw1nzpyGRF4AI5C835fny4OfGCootP3TQKRiHM7F3kBpm+Cw==
X-Received: from qtbgd5.prod.google.com ([2002:a05:622a:5c05:b0:494:771a:c76f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a21:b0:7ca:f34f:dfee with SMTP id af79cd13be357-7cd28812d1dmr98592185a.34.1747165179011;
 Tue, 13 May 2025 12:39:39 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:19 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-12-edumazet@google.com>
Subject: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Last change to tcp_rmem[2] happened in 2012, in commit b49960a05e32
("tcp: change tcp_adv_win_scale and tcp_rmem[2]")

TCP performance on WAN is mostly limited by tcp_rmem[2] for receivers.

After this series improvements, it is time to increase the default.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 net/ipv4/tcp.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 91b7d0a1c7fd884ee964d5be0d4dbd10ce040f76..0f1251cce31491930c3e446ae746e538d22fc5c7 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -735,7 +735,7 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 	net.core.rmem_max.  Calling setsockopt() with SO_RCVBUF disables
 	automatic tuning of that socket's receive buffer size, in which
 	case this value is ignored.
-	Default: between 131072 and 6MB, depending on RAM size.
+	Default: between 131072 and 32MB, depending on RAM size.
 
 tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0ae265d39184ed1a40a724a1ad6bb8f2f22d4fff..b7b6ab41b496f98bf82e099fab1da454dce1fe67 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5231,7 +5231,7 @@ void __init tcp_init(void)
 	/* Set per-socket limits to no more than 1/128 the pressure threshold */
 	limit = nr_free_buffer_pages() << (PAGE_SHIFT - 7);
 	max_wshare = min(4UL*1024*1024, limit);
-	max_rshare = min(6UL*1024*1024, limit);
+	max_rshare = min(32UL*1024*1024, limit);
 
 	init_net.ipv4.sysctl_tcp_wmem[0] = PAGE_SIZE;
 	init_net.ipv4.sysctl_tcp_wmem[1] = 16*1024;
-- 
2.49.0.1045.g170613ef41-goog


