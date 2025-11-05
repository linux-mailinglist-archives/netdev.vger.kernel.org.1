Return-Path: <netdev+bounces-235774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E83C3552D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFE718C6B29
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6630F80D;
	Wed,  5 Nov 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MW1Tm3Yd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795243081D5
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341613; cv=none; b=RnJAZZYuh5L6FRGdLHocU5z7yHzXhjO/V4IyaNklwks7RygmGeF1tmtevp7zmrL9pBj9p2Em6pFThs7+wOuplCup/hcPFoAR9ElSaLVTkhJw31a43ybpHY82k256tJmyAjuzPe0jbpPRz8Zv644NXWuYKb843KbzyMBdxhewDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341613; c=relaxed/simple;
	bh=jg9JQhH4jC+1PYtjc2yGbQiHAhtmYm3wKu/Ci02YltM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtiuOdO+DsZ4cfMYItWCYocZk2Qm1RqYwiGnxv+yAFO6TGEswXITtctYFyKAQghU6nJgXMnCSaTTRVAs0EW/GPFmPxHP5SjFhPh98GrKGgKyWd4rtwFNprZp8kQ2QjtdqbAAcL75SDRNjciMxTkMCQ63d0P1mH8jh3/Z2xBzOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MW1Tm3Yd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so11435802a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341609; x=1762946409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPx7TEpg2PCWQMCzIdCwjLuxukIo7EnolPdS5y3Rh20=;
        b=MW1Tm3YdfiYNcZBZIFg43dhf1NNTNIjPZk+yroArYzCA14RtO0T//cFkYh82Uhav4Q
         TkCyUMphjIpkoIqb30dCMJoH60TLYCuhizbScbI4rAbT0uYfLRIFttWv+vA8vcfmPove
         k85VkLTjZ5JOxhaWQWnvrMFF6PmeWWMK19b2AWJapVX6l5vq2Yh0iR/c+nNfKI0EyYzC
         guY+OoZfHb363eSdC47/9yyxmZFtIOJJgH43ppQ5gYi1iHHK51jfX/GPdLX4DAv8K+4s
         Pf6hGzz6IcJ3yak5WdupZXEYFa+PobpQVk0KnLjEZhXo8nGyrF/2RDjs7/tmOTRWq6hO
         QwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341609; x=1762946409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPx7TEpg2PCWQMCzIdCwjLuxukIo7EnolPdS5y3Rh20=;
        b=ZIUu8TTLjgme/kCcmkgjswOqAFcreclucXk7HbYtbRArcBaRwSmkAFwWwFIJvMiP54
         G2361fV7wKoe1hWZtznljps0IHc396pYvUZbDdODG4XXu07kSL3M2wsVrk+2cUGCQUZ3
         wY+mQ+b+vZT6MaDuE44SSGpIMQdq89XMi7kEyOtuYLReVnv3oNpfhJ3WV5KVf+jSqIjo
         /dTOqnS0ktuABvGuccKAycWpgojBMwk5NfjIc9ITVGulV2s997MGzjsohZRFL2AM1fZV
         DyQ6jnTheMWQzQaxupXkAWeaIWcYa2o5K67pncld+s3q3d7+Gk0TLek1W71MqWCw8NEr
         TF3g==
X-Gm-Message-State: AOJu0YzqXaCEsOdam13B5mjAnYK36NKO721tbJ7KNJ+qFfkkwAGveUSs
	xjJgMbD6lCRjdPLC+XIbaojjri7waeao5VWS77lT1kBWHaHq9Vk/kU/An/cTShji8YMOZGw5/UH
	YwSmDL+Y=
X-Gm-Gg: ASbGnctWq1aaMWaEPf1S9gIYmqW7x9e77aH3AGeKRq0BZfCWsw7wwwJVEKNSLelCz2A
	QxF4+Xkh7JsdZS9xv/OU3/pJ5TkK+XcezI+L/EtiUrbvy5apD/VJO9m7YGFWyDiUowWdXkGkXkV
	zTQJLzcJ4w2dVjPeisVLEyEBV4uyXVRJKGSOwVi2z+OgZ50M8zf16fdAdDz2eX0J5c7fcLHC8rz
	/oRx+NjJMG98Phfc2OBOdHAAwSo/n6kxN12GvcVIn0Sb4q+Vlah9kxEeIXlBn0v8yvF++dc27Rj
	eHZYgbFXhDNtuaVz0+QHuInhtpZWoFJHRnry8yVFdGx9pPQ1Ml+IqMbdS6pdn5k5GeswH4aI6w0
	EKSQCKwMr5F1SyMyPbqYIYNcZXJ3jIaG1ec/LMHpqx0rJmhKTezwwKOarp9gj7jFEGAy08F0GOl
	q6CHDuirheG3LmU2f+g1+cfVtPj4WWxcCLXQ==
X-Google-Smtp-Source: AGHT+IGRLAPN+U8MsOi98eMXNR9poCLGHE6zHV2WLUCBS2zrBTES/2GZ6P1qjmj02rFfUreHnCGQAQ==
X-Received: by 2002:a17:907:3f22:b0:b6d:2773:3dcb with SMTP id a640c23a62f3a-b7265296c93mr276688266b.14.1762341609321;
        Wed, 05 Nov 2025 03:20:09 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:08 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 0/2] net: bridge: fix two MST bugs
Date: Wed,  5 Nov 2025 13:19:17 +0200
Message-ID: <20251105111919.1499702-1-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Patch 01 fixes a race condition that exists between expired fdb deletion
and port deletion when MST is enabled. Learning can happen after the
port's state has been changed to disabled which could lead to that
port's memory being used after it's been freed. The issue was reported
by syzbot, more information in patch 01. Patch 02 fixes an issue with
MST's static key which Ido spotted, we can have multiple bridges with MST
and a single bridge can erroneously disable it for all.

v2: dropped the selftest as it is useless with the new fix
    patch 01 - new fix approach relying on port's vlan group
    patch 02 - new patch fixing an issue with MST's static key

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: fix use-after-free due to MST port state bypass
  net: bridge: fix MST static key usage

 net/bridge/br_forward.c |  2 +-
 net/bridge/br_if.c      |  1 +
 net/bridge/br_input.c   |  4 ++--
 net/bridge/br_mst.c     | 10 ++++++++--
 net/bridge/br_private.h | 13 ++++++++++---
 5 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.51.0


