Return-Path: <netdev+bounces-88410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39298A7136
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113DB1C21EF3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B403131750;
	Tue, 16 Apr 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAfU6aWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069685644
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284429; cv=none; b=qnUD8/KA9x/KIHO9q/y2whKcDmPjogDGJtNWwVuuBAFfJ6TQsJcpSoD0zjZu7LFLgXHQAQqn/ywLvFLh+0CkSWzyadr13RWjpP8dTtFgYqtGAay72glG38XAvDnrtBdzYY1vubF3LgH71U6YwPgo4d7nxAIRH9wRiSZrJTXwqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284429; c=relaxed/simple;
	bh=U9I7MwRup10i6CGSw2yavcWZAxJ5SporaJsPqNwl+p4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=srw6JSEttMGOU1TLzIDjSQvDrxfmKiHdVVdSuKMgjAScv1pGZ+6RV2HTc45JL38PMpAq1OSzr6M/Ql9cdbFwsdSHLF44+xI51PhJm2mIE+xHGOp5BJwLMdRrqHF37ODIyRup1hsX6Lb3X+2BdPG3o13T/TwEVu+MrNYFvKHEVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAfU6aWp; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-69b81cb0865so22972366d6.2
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713284427; x=1713889227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2j1+4e1zwDvCqs4OGfseHDOM+IwC0cpeK8oQ65BCXfI=;
        b=lAfU6aWpe5zkRivBSgzToG3yLSf9Sol0k9um6ZZjAT9lQHLyCiZfCKOFZO7pVMUK22
         qfQnLNk7Fv/GdD2hPYbTkpPEKutW4rP1cxq+AoiCA1gAQ3qgT0iajOGwwWxL+VfCFhWH
         ECi+DAZ20CX6GnFHf6yVH7vUF6o2sAejkUSSZdhx7JEGuFraqTMYmFPcslvVqMLMVKcu
         AYIwlHtgu887IKCzdYwUUWdo6byFZ6CKUdSvhM+nBtkkhXI9lcSUi92UbX4PpTRXNU5k
         F4RfEDGNub8bkCdTkDkfeBzRwmkkNP2P4F1Dpp8zLieQjqWrkgtEOm+8MtH6aXFZYqf1
         hfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284427; x=1713889227;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2j1+4e1zwDvCqs4OGfseHDOM+IwC0cpeK8oQ65BCXfI=;
        b=H808l8iiqxOlBXfu2uFS23cNGvjj8I3DugqgMauRyrpQ7pj6TE8BVGaoai8d8t4aqO
         I2c+V0jiLjhAYpDXDkqgUgaSJRRQjV/iWJOaEK7M+kbPnTVWH+xiy81XLdnrwZeUwjTt
         ulIrSCp1/89/+FWjJ+Vn/QkUsC+KHvfMUuUbtqAqlecUNLAZzxmkATqMlSdEK6MlsI2w
         7Op5dQa7WWLogvwfFVsdJABeb6TC2VXAPiFXL3Kt9v4TqqVP6LBsX580jWRkN+I/K+08
         I3WeOzN6QRN9GQDPHXtad3yTKtfsJRXHSLIXYIwo8EaSmgYto0u1Vq8BXB/Rz5y2Ub8c
         /Y4A==
X-Gm-Message-State: AOJu0YzsDyec6aDHuqRAb0h2aarsySWBAZWdbYolkw6YLXvPX8cZQMOZ
	c7uQ6sV1AUm6uGEcs5sIM1ThZaOWGSLAgD28U0UXFivZi2HhTby+ca90E8/rI7UbIQKxf4dfY8k
	VIOmh6jLvuA==
X-Google-Smtp-Source: AGHT+IGoRWmRy6GkRBHKQKtnV+/xMcuswtVOwXTM4vYKHKTXFe0USYl53sg26ZhvLM5wlvNRMGKifqJZA/h7LQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:108e:b0:69b:5209:7526 with SMTP
 id o14-20020a056214108e00b0069b52097526mr109499qvr.9.1713284427049; Tue, 16
 Apr 2024 09:20:27 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:20:25 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416162025.1251547-1-edumazet@google.com>
Subject: [PATCH net-next] tcp_metrics: use parallel_ops for tcp_metrics_nl_family
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP_METRICS_CMD_GET and TCP_METRICS_CMD_DEL use their
own locking (tcp_metrics_lock and RCU),
they do not need genl_mutex protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 301881eb23f376339d59a62bebf150b4b1cae3fb..e93df98de3f454e9118116c3ca1b19b237ead04f 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -988,6 +988,7 @@ static struct genl_family tcp_metrics_nl_family __ro_after_init = {
 	.maxattr	= TCP_METRICS_ATTR_MAX,
 	.policy = tcp_metrics_nl_policy,
 	.netnsok	= true,
+	.parallel_ops	= true,
 	.module		= THIS_MODULE,
 	.small_ops	= tcp_metrics_nl_ops,
 	.n_small_ops	= ARRAY_SIZE(tcp_metrics_nl_ops),
-- 
2.44.0.683.g7961c838ac-goog


