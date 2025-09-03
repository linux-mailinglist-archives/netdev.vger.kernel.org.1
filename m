Return-Path: <netdev+bounces-219656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A9B42866
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E42004E52C5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9160350D73;
	Wed,  3 Sep 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBvdRfup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35135085D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922218; cv=none; b=mXpUrWLEC8BcUc0cBzViEQROM3PGvNZQCmysPAQiJWBt8N+SlXFLrn8JVF8c37tYImX/cKSRHencSui6Egdgt9AIis+bFMh7cuH3/e/H9REhOWodZ0/Se4YGdzusxXJPT8BNJeHDJMb60a/ZIjYNzGSvXm5x4RGXEnYCfZapIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922218; c=relaxed/simple;
	bh=F6bNep8D109sbyXZNHXJabnlojF0qG38hM9vy4g/PeQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WkolNhWIkY2P5QuT3/R2CTVzWlzrgq7ibCSLXsoKhMpTH1mAeARFtT4FByIrruUoUs0WdegZFEVBFpcylgwRGhnzxoWCw0t2jYJGwUPg/X7vD4s6eIwtZAiqKur6VZOx16BRmMSnUEkMbV7A8VmTXWPFHyeMKiS3Y89dGJod8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBvdRfup; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so1833235ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756922216; x=1757527016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3ojQkminMxLTqsNJsCs0CXcsRfJBTxhwZ1SYZQ52IQ=;
        b=KBvdRfup5cCKmz76t2kEKIEQa6oqjrwpBvQNEpBO2CTU4l5NLi3jSc20SplXu8E7TW
         mkzrg27z8OHAq36YhdT/R/Y4Ur62RuCMcZSxwWPOceyjpGm8AQRhAC1ccGiGdC/ZfQru
         Lvm0qJ34TEjvOjL0iqTdmA8Monvu6pYwZqwY44vWOMpsyFU7qH161dMsQpcuMppcfdGX
         x97w066cH/UotYrje9cXFXrJ2ALlgpD1KtNilK64OS36n4j9RG2YLQmm9C/HVARRX+ms
         3E/9XtHKoAAmtQO3iQGo+B2OolJZM1WJhOdd2KJMDQBwy6Q+qPW/HQJkG9pSt8OKTe1I
         q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922216; x=1757527016;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3ojQkminMxLTqsNJsCs0CXcsRfJBTxhwZ1SYZQ52IQ=;
        b=uZEuky1bDtlp0vitMGgEtGNzjpqK62YaPUg7hUelw7/gKGGNqH1nO0tHfYgIl1Te6X
         0j9pIsq9TwMuNP3yaqsAiaSZXWbPf1aHHIS2lM+hPkNB1eWpYhcArk8XkVzgwljhPZi0
         DmqzdFfhqjfqlnqdYNlRUissmhtmlSNOwNAq4AEbY9PHQE8Lh78eAfrHmxVEjTcHIQYL
         IGhC87AE7IRkvVTi/z3Uq0cd53JqgVjMgJzCIx7X6WMi27pSyYgOuV8P9k9DjXrfYD9K
         K5g1qk22wTLNyWoO/GHIdPlWGVWXsnB4Wf9fT32HsklXfpvwJn4SrWgJiOV8ekJIjHmn
         mXIw==
X-Gm-Message-State: AOJu0YwK8C+uarqIW6p15ulvyIeOL6/B1s3eUBn/EDIpcAIj1whfqThM
	dFkKuQLk0Jy0q5Jd3zjWpl1wUsW4QO63uq6YNDThCJQwGUNAW3NpGoAbhJl2foHk+Z1OSZzgUms
	gBQzuPgkq5L8KkcZ8GzsrgHU+DCREqroBr0yzbtUgdQSOvm9fSw2fToPhPBJtPVtyds4fimdaXa
	nvD1i2mc7dHNvnfWLMLqjk5K+4wGjiRF4WFGbgE7NyWl1fj1c=
X-Google-Smtp-Source: AGHT+IHKU8Lr3G8r8m3yqV9vYnXIOx6YdOAJ970dcfiLKzKX+vMwFQ+J0DzQAEW8/HMDNGBNSswpLru05iy/ng==
X-Received: from plck21.prod.google.com ([2002:a17:902:f295:b0:244:6aa2:d387])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5c5:b0:24c:1a84:f73e with SMTP id d9443c01a7336-24c1a84f94cmr62207225ad.60.1756922216373;
 Wed, 03 Sep 2025 10:56:56 -0700 (PDT)
Date: Wed,  3 Sep 2025 10:56:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250903175649.23246-1-jeroendb@google.com>
Subject: [PATCH net] gve: update MAINTAINERS
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: hramamurthy@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, willemb@google.com, pabeni@redhat.com, 
	Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Jeroen is leaving Google and Josh is taking his place as a maintainer.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1819c477eee3..c6f470250f6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10388,7 +10388,7 @@ S:	Maintained
 F:	drivers/input/touchscreen/goodix*
 
 GOOGLE ETHERNET DRIVERS
-M:	Jeroen de Borst <jeroendb@google.com>
+M:	Joshua Washington <joshwash@google.com>
 M:	Harshitha Ramamurthy <hramamurthy@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.51.0.355.g5224444f11-goog


