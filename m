Return-Path: <netdev+bounces-166181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F2A34DE9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F56188CAF1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8D2063E2;
	Thu, 13 Feb 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECY5yPCS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA91E8854
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472332; cv=none; b=OmeIpJ2Nfl5YX4h+urDlKKjgh1ICT+wE3xZ1qfpUsfEhPWp75N0MM2WKuzdPWE1WtkgZKTd7lVEaWNbL5hkPgUjX4X2HBS7t4CtEEaSZPPueJdj0XL/rV7CNUGCsCs8NN+j9+wpDldIatyPkWFmB2PsyR9Yj9+F697AMS8cMO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472332; c=relaxed/simple;
	bh=DoPDgpVI2nTdJI4tytg/0fM8KDT3x8hz6VgZooNMVjw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KYqgK9murwbP9NkFfINvE74xFXzOzV/UCndOjpNn4QQUdR/E4Byc4J62/W/sBBqFliv3xqJP4ikjv/VHrBu5wvn0Jbwj4VFGC4rDRmUaldav4/ccAZ1Cg7V3/OMT4u7mXPw2UD1oy7DDTTtqyQc/m6gDlfSKLAaMv0cYP18XaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECY5yPCS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa6793e8b8so3017930a91.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739472330; x=1740077130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Du3A5K57RxjPwG7x2oH3uLI4BLE7+mYFN2POoX74f4=;
        b=ECY5yPCSWkvhMx9gql8TSju9bf742iwV9CsJ5uMGoQH+9hQ+NmjtzdAMSpU94wsraZ
         MzzlazdDN0gjk7zv7Mrsz8s/3rlA/jHxajwxd5hQkOlf6GCBKUlLAeLgxY8VKxqCEn7I
         c10qSzLMDkxx+qAVanvjDZ5hw+fJ9LX8ZtJT4lnuIiPGBFRb4Ulox5StCn/9rq39Je5f
         dCRxdZuzEjUW4bLU+XM9Xa3opoKTLXL4JyLTiI80ADKKj54G+ZgM1IYlv+8+SxlALIhy
         lc6iydsg7S+U4DwEnnLRTm1onBByKJyOHnl1/prKuA24ruFKnlS8Pya1ZLrGikFZqbcF
         loZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739472330; x=1740077130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Du3A5K57RxjPwG7x2oH3uLI4BLE7+mYFN2POoX74f4=;
        b=OtK5UWag2amNAnVeoQ/x9/iz1+7q9VyceDij5LlcGePNtjq0wHPcKjUrcXIXT7N31x
         26uP+SJqL05nP0aDGlWNU8xy7k+iXH6gYgy3Thm+Tr1KoyDqVGI9uax6+D0UBqS+BPuu
         OP/AuaEloW/PiOgfC7o1UuUCo0rtifM8ososvBlj37H8GRzL+LcCOPXjz7qOrROGeNbg
         3stAdxxO+TyC8mLq/b+hgCuKtNQ4TlKh+ZxqPG8Ff4O8qcprW1xhN8PqE3FJUv94n2T0
         Q55as2PErOWKi94jin195AfPC2vscG8dnTVdiaYP4akwQTqURRKjmFIfVOoNn5IiVYHt
         LEuQ==
X-Gm-Message-State: AOJu0Yz7+3Wm5qJgyyg1ptymvX9eFjm/ecWFiMQyRHAev4kNYu2cMGSs
	Xfzhp9IqcWJctHWJFNGrBX0625d1BaEVo9JkJwfRfsufASuLImV6NOJrnCjO/O3Hx+1rpvjiZiB
	jprfBYgXkmhrUK/7rMjufDIieMniw9OOhif5VwcklIou2KO0ucex1blytR+IDUx1yNyjWeD298m
	aXZ65y1Ul71jaBmUF8Nl1r29siKwfrpyhbNxxL7Wv1vcc=
X-Google-Smtp-Source: AGHT+IFd3vJJQ1gGAzK/LWTCZtaWucHh33vfoMNNRsKJOkSS+WW37LrgOUbC/5QGcfelTqOMAYSC0imLFGAP2g==
X-Received: from pjyf5.prod.google.com ([2002:a17:90a:ec85:b0:2fa:1481:81f5])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:364f:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fbf8957ef8mr10643752a91.5.1739472329890;
 Thu, 13 Feb 2025 10:45:29 -0800 (PST)
Date: Thu, 13 Feb 2025 10:45:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213184523.2002582-1-jeroendb@google.com>
Subject: [PATCH NET v2] gve: Update MAINTAINERS
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	willemb@google.com, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Updating MAINTAINERS to include active contributers.

v2: Rebased.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b182021f4906..2325bd337477 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9834,8 +9834,8 @@ F:	drivers/input/touchscreen/goodix*
 
 GOOGLE ETHERNET DRIVERS
 M:	Jeroen de Borst <jeroendb@google.com>
-M:	Praveen Kaligineedi <pkaligineedi@google.com>
-R:	Shailend Chand <shailend@google.com>
+M:	Joshua Washington <joshwash@google.com>
+M:	Harshitha Ramamurthy <hramamurthy@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
-- 
2.48.1.601.g30ceb7b040-goog


