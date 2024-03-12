Return-Path: <netdev+bounces-79573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BF879E9A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E393B22485
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D911448C1;
	Tue, 12 Mar 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avrBSBw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE3146E94
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282268; cv=none; b=ImNWR6hpYw7yp39vKmMGwYmzejhS2zUoXkgQ4+WD/dx4liy6edRtn9VE8wQaSGZ+/eTV3ZJdrl+2ugw7Js0AyE2SDhVUbe93Cr9Pbfzn/5m5LfPfKhNyu/KnVfz7pukMGyvopHERn4drnjayxE2BJamyqx/m12T8OS75cHzC2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282268; c=relaxed/simple;
	bh=EPpzSOSTp8R7ep0Nt9Uw3VDr/tZaEmVmhtrw7JWBXx0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=V36uYovVRXzHwu7FjaeLvrNXpMOxpBT6MRLXGatJ5vfz8KtPjgxYxgljdsKsT3PdV5e1fSQhIJIm2K9udHlfZY4214YGI/L/ZdEVJioNDLchsya72dpMLft3VZxxyUGy1HZma9IMX8WIRuwMqc+bYsSstVBzWVi5HgJkvxxCsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avrBSBw+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132f780ee2so1923965e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710282265; x=1710887065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMsa5OzvjkOZTDF7h+UW1ijj+nK1L0JIj98BA2zFNWc=;
        b=avrBSBw+JB85dcz4FYXag+v1ytqsbDv6cyYh+QqSHJL3QcrjD/gI0JxYnmQ4l4x9JP
         RXb9hIchqY9RMKt3likhLAnkxaVSwXPaMO52bhfiMIg4dTuiU5q5XSxJPYjUOn+tnJrv
         vMJRKthl8QhOLG5Ec3LAaCbBK4Cq6dScN5zvoVaLC8CCfBBpdHsgWxOhN5v5qPMBcsTV
         gtBEvJBwHhHf2Ebp35qjWkciCMCufXIFn2OPbK03Yi1l1qUYekjLHhdAXEpEDvMG+Bvv
         znvIuEkB6AzmisOx+ISnwbFP9yxp0JeC773YJPn4IluGAQn67FWnfAEAdk7lMovxllT2
         A9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282265; x=1710887065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMsa5OzvjkOZTDF7h+UW1ijj+nK1L0JIj98BA2zFNWc=;
        b=qK+vQRfdbbnTyj8g6+meRLy7QXDeXB3X/1y0Gy+BjkJBjbvzUWoyuZV0ebuplsEUFg
         VJ0AQifmvfzH7yae8eItv9yZhalsgVj36UkIDMIMvby9OjTLWEllpMOPxAqSelsyLsXu
         VO9ygLw6TpjB6Md5uWZlaNcYcuY4Dub+TDynXlathYNS1UPSQW9AMCtzNOn70oyMPSv6
         3+AxoO5Vqy10iFtYUBvjSoHUlpcT836MDP8rhUHRAZ1YmwPQvNIIxikg3EXME537mVbE
         +jc/y5IwTaGXXGK8VNgWINFnA7rt/mMBbq2tRfgUUOlXZ0KXboE8MXMYCEhBw75kRFbv
         RS4g==
X-Gm-Message-State: AOJu0Yw+ntUU1kseGzz7yAV8PbwE6wrUvs/SHiPFw6NC/EP1Kcqtl97L
	ztgYcd34smgvoevabLlrGOaCmWpd9y8vpOqbqxKwButdTAf1fqkY+3+enUpvfWA=
X-Google-Smtp-Source: AGHT+IEQab6Iltp6MrOqk5juLXhrw1VKrc729cTGYubL7DMMxZy/eXcpnf6HldI1u03GaVkA+knAXQ==
X-Received: by 2002:a05:600c:5407:b0:413:e93b:cdf with SMTP id he7-20020a05600c540700b00413e93b0cdfmr140444wmb.13.1710282264822;
        Tue, 12 Mar 2024 15:24:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:7aef:1aaa:3dff:d546])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b004126afe04f6sm246924wmq.32.2024.03.12.15.24.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:24:24 -0700 (PDT)
From: luca.boccassi@gmail.com
To: netdev@vger.kernel.org
Subject: [PATCH iproute2] man: fix typo found by Lintian
Date: Tue, 12 Mar 2024 22:24:22 +0000
Message-Id: <20240312222422.2494767-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 man/man8/tc-mirred.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
index ea408467..cf199bd7 100644
--- a/man/man8/tc-mirred.8
+++ b/man/man8/tc-mirred.8
@@ -114,7 +114,7 @@ interface, it is possible to send ingress traffic through an instance of
 .EE
 .RE
 
-.SH LIMITIATIONS
+.SH LIMITATIONS
 The kernel restricts nesting to four levels to avoid the chance
 of nesting loops.
 .PP
-- 
2.39.2


