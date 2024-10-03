Return-Path: <netdev+bounces-131687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BCA98F42B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D511C20D2D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382B19F42F;
	Thu,  3 Oct 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYPeSZcL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6637433AD;
	Thu,  3 Oct 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972631; cv=none; b=nZSCc0rKL9ca7hLvJlYpm+TL/fjs4rGPYIw4o4l6N8SwYDJaM0tnfAY80s/350TWdpu9B1730ubSvAIdpsAQKaCabraRidny4a7YqVS4y7QA7LZ6rESnjt6frT4vSFzg+EYmEH9HE/X98CzJlgp1QQ9Ty16+u7yoLr6x3xpUZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972631; c=relaxed/simple;
	bh=O8Vmu7TFQB3fopW1DTEkKfVJeNrb3XgMb8cN6yFuONM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho3XxFDUD6/fqgd5Ft3dXhEXIMPqA5VhubxrTFf3kTHdM6cU60am3zq5IwSiWGaHccp+ysF67CcjmQS++4AoXcXyTB4Etl1Wb6DYyKG9TcWXv7TZtJFZUv8W2GbCEu2cXypXH1F3BB+bn9xTjK2ydvwhAmFs7sU1/F2XnIZitYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYPeSZcL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e262e36df27so1801108276.0;
        Thu, 03 Oct 2024 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727972629; x=1728577429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2A7HVbCYMRJB0wC6HN6kgIW4ax3rl9C50DMlGTp8TQw=;
        b=EYPeSZcLclU06uP1DsyS8j66o1XHoRrVTietpIhV7h021IQXxoLrK8U83dCX2ciaBs
         1aGk1TJ8jY1CBzB/Ek9vS2vUOp+ZqT8C0POAQwCClJr2PbNiCMwK6XeYOVpPMo95Vix6
         ssCTQPQoPMCTC35ObPh+1/nqbRnDvdP9wsaUv87RKjMDWh4fCk1iq+GueZGS4A6E8tuC
         gzyBdgpaTHhZLG8/XsrrP3lZAFv4TB6ihoSH9wUrbPuKLf7nouIPfCLH9lvd1oStmBN3
         gSCD2ZScPcox97jnbemHIobxYD6RbBxmnJA5yS6WYLnGhDdHbS4V8ndyzufv6KMVfX3f
         XdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972629; x=1728577429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2A7HVbCYMRJB0wC6HN6kgIW4ax3rl9C50DMlGTp8TQw=;
        b=u1NAmcbGckf1BlsRt78cy+r7fQeYYu+mvNQRwYtx7Z10ftrRDyc0Ai597yFMMDfuB4
         8Pxb5Y6MzMMc+ODqNIM+esQV03DGjKLPhr8juAjBXPj/ZCv4qekYKJb2+EEYYuzidAbB
         +n+aZgqsaIXmtePR+fPYn2Z+r57ukmx/cRBedY2y8CFL3Sumw2SKI6xrJoFB3iwsUg4u
         d9W9ysw8GnKTQX53OoKk+ebqd2uC+NvVhSpJQ/UygzzbCuzHWEvIR3kijC+7Zhq9Afdf
         UPEzrtMyo0aYH6j1kU3/RE311QKkwQa2IKUVLTlOShJCmQu0Tw6f2yDVjgjR/PJwQeus
         OUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXICWUAEqJXpYwAhlc5x2n8PkHvp4pcNEz4Kv09Nf3IpDti04e3P9mWGQdleJPwAC6NLYUbDyXkyo+ev7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37NF+GY8SlB/9hDUw2Lo4+3uj8XEqqLYgyetJqMC1mAgz32fr
	SGUSqwk4t+tJwTNuEjsl0TmrB8IFVrKBtbGJOc4WA0QrQzkmpq5k
X-Google-Smtp-Source: AGHT+IFoKPod/9H6XNAvjsfkxVWc/pBu30GvTKXrHnDKDWyOWAOLLIEQ/DOSeLpmtKWpOwNDXLNUVw==
X-Received: by 2002:a5b:891:0:b0:e24:9e26:133 with SMTP id 3f1490d57ef6-e286f81947emr3207971276.14.1727972628734;
        Thu, 03 Oct 2024 09:23:48 -0700 (PDT)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885d2ac2asm269232276.16.2024.10.03.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:23:48 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] ethtool: rss: fix rss key initialization warning
Date: Thu,  3 Oct 2024 09:23:10 -0700
Message-ID: <20241003162310.1310576-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This warning is emitted when a driver does not default populate an rss
key when one is not provided from userspace. Some devices do not
support individual rss keys per context. For these devices, it is ok
to leave the key zeroed out in ethtool_rxfh_context. Do not warn on
zeroed key when ethtool_ops.rxfh_per_ctx_key == 0.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/ethtool/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 65cfe76dafbe..04b34dc6b369 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1505,6 +1505,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 						       extack);
 			/* Make sure driver populates defaults */
 			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
+				     ops->rxfh_per_ctx_key &&
 				     !memchr_inv(ethtool_rxfh_context_key(ctx),
 						 0, ctx->key_size));
 		} else if (rxfh_dev.rss_delete) {
-- 
2.43.5


