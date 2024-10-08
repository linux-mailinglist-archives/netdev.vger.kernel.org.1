Return-Path: <netdev+bounces-133014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD03994473
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349952855AA
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2B183CB8;
	Tue,  8 Oct 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Per/RU4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DE42A9F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380331; cv=none; b=lkz7I2k5cmngTE7cNvQWMwZdW5UZ/efl+MFDQJlM3gm5Zq3dfYJywejyvsKwiDyz05opIWro9whXkuZtfwOGNApL0rCvXvzMC/38FTrvh0Tkfhx3nzpNQwbkCxv1XXcrbT7pDvcB5hTE2iYF19vV1cenx/f9LWFPmzTqZcDMS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380331; c=relaxed/simple;
	bh=iAI1FMy90yn4FDqkQ4IB7+Xy1a3gHK7rx+/OPT5a1iA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o0WMWYRgkGTzj2Vx9oZXvFXH6fK6detrqlXICfoYXedWTXzPAWWPsvIQTGu8jgojwkxxATQRF09jcOziYW2m5Oc71/EbKvWDe5op+w/VeSsIiIamkya0krfveRnoRZpidSzkbkzY8RVFxbVcSFLj/8aozcWDWwnS8k/Vas1pnD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Per/RU4V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624bfcso75952107b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728380329; x=1728985129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsYxGWbI8yd4jNED/VtYXpXPSxZrsstyrlUIU7d7J7w=;
        b=Per/RU4VN3zkg6/dBbtFBqX/a6QCsDKYZKKbeYgpfoh3jIvpLBIY9F2pIQtd4Hn1AQ
         t67LbM9ovt5O8UMF1YWECrgFjQoQp77h2HbxvNOsnNZRRdbF8fHB/aFgpZde65QmYesy
         6G3Fe5kwTjiMvi6y8OQ/TQ/5IYfjwIiDR9mX2ujoHTtf5MSaWsYnSKFeSOuMkpsI6Yg0
         KL+yzhME9Zlr7WQBkTYNlMsRd3JgrU6znle8474N3rUXno/gXCzX+LsN7xE/OOun6tBq
         ++WsZvDFUwbW4HpG034zjfYQWa939BITaI8DHanjb1peYb0U5KkoivWTA6D6SRS2307s
         Cpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380329; x=1728985129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsYxGWbI8yd4jNED/VtYXpXPSxZrsstyrlUIU7d7J7w=;
        b=nQWd94PytQiD90GwV84C87XBGRDciKs92maBToeTEMF0mwSX927xs5vT7YKEDlgl+h
         v3Is11SzREPEqgNkQJ7Px6mpnhf4ZyP5nT36EC3rTYWn2xwGW9w3PovFu6SeoWnzKWHY
         YOiTKFp1svidDRmXSj+hQUzHjiyt+1wh36HbTXfy9jDwXyZxucVMP/dk5jT3tfMqxNw5
         FIZWCZO8Fp+cJ5AFklckBmaik831ToSszobBYak7MMR/NrUT0XiphsH+LJtMl0YwRW+A
         JHlk2Cbh7z5/LesJQlIrfObN47Z2fwjncVALq4AoalBtj/0zmgckZ3umT2ZJO08esyG5
         MHbw==
X-Gm-Message-State: AOJu0Ywvx2vOXy2yOSGZfxvqMsAo19hbjI5xzB+CaGNQc+L9hTly8AwW
	x2oI1o/ThVzEJPQzKfoZv7bIR9RyBVQHTh8dr4zFE58h5uHwY0zAPnQtf/EAYKFY95s2rsjwYAa
	1Gi38tSDlQw==
X-Google-Smtp-Source: AGHT+IF366KMtjKxii+DBjTgCNw2GKxCHhX9AbuY3ulo63rwldoPeCtTh0mEXPKUqVl+EfCYO9HX5JBrxH2wFA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:700c:b0:6e2:371f:4af9 with SMTP
 id 00721157ae682-6e2c727c4c7mr2970237b3.3.1728380329281; Tue, 08 Oct 2024
 02:38:49 -0700 (PDT)
Date: Tue,  8 Oct 2024 09:38:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008093848.355522-1-edumazet@google.com>
Subject: [PATCH net-next] net: add kdoc for dev->fib_nh_head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Simon reported that fib_nh_head kdoc was missing.

Fixes: a3f5f4c2f9b6 ("ipv4: remove fib_info_devhash[]")
Closes: https://lore.kernel.org/netdev/20241007140850.GC32733@kernel.org/raw
Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3baf8e539b6f33caaf83961c4cf619b799e5e41d..b5a5a2b555cda76ce2c0b3b3b2124b34409d1d69 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1842,6 +1842,7 @@ enum netdev_reg_state {
  *	@tipc_ptr:	TIPC specific data
  *	@atalk_ptr:	AppleTalk link
  *	@ip_ptr:	IPv4 specific data
+ *	@fib_nh_head:	list of fib_nh attached to this device
  *	@ip6_ptr:	IPv6 specific data
  *	@ax25_ptr:	AX.25 specific data
  *	@ieee80211_ptr:	IEEE 802.11 specific data, assign before registering
-- 
2.47.0.rc0.187.ge670bccf7e-goog


