Return-Path: <netdev+bounces-130622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC698AED9
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC51C2272B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937B1A2570;
	Mon, 30 Sep 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F2a90XNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939B1A2550
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730469; cv=none; b=oXLItiA1vCIUBqFrgCsfzZFrC6yhTeknN/71R8tRxpEX141clDblTpqHOnQBTQUJNPqY9PaTuYQbVqNtPmQBZPiNEl5JrpJ9wVMtzpT1ljrZBPl4N54chODf89PQSFrlDi8VOIRIGjFTqxxhwwCgvaSX/J6dTdCq0kmVTpGtvnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730469; c=relaxed/simple;
	bh=wrH3ejNJ740G76Ulnf0Pc2dPkl8LUwTvYP/7w/p8f98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FndnEFkOZ40X2rX3wN8uSHYsWKmidAFSogv8ruoq3KKKp14WaywoKJPIVQQJ0d6H9ZnQ1cRnMGLh+Y07DkzefRYStaKPnVAIaYasYeVgDujXRxVXj99G8+z7FGtUNMmd6ZT9aIwaW9luLBJ9SInnI9qIaHP9oM+0oC9lAtyfKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F2a90XNZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so3829558a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730467; x=1728335267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8aiIusvfCJ8Y/Mbuyg89MbzSUpUMVKwRqs8fSlQSzo=;
        b=F2a90XNZD0+D3T2VfHB35jUY5kpABh12qREPxPp+82duEBP1t/rcr6g+dSgtVNQzSJ
         I3EO/cyUyEJJPkSqXVbxyhj5HAgZCwomv9c37ScID7w+Vy5gJaZS06lyoU0cFXrO99tv
         tIapdzviu5ecR2P2CHGqZROc8UPbBY2ENpO0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730467; x=1728335267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8aiIusvfCJ8Y/Mbuyg89MbzSUpUMVKwRqs8fSlQSzo=;
        b=UCX5Hk/aR8p1fXMyjhX7yizxfGospytXv2wDqmRTIpTS4vR1ec/SNgC4q0n+iSk+Hl
         3G544sZ5FMDJ3fcdtIszHUbeXaNVyrWSgBYGnQ2XDguWEHZUSUYCqXtCDK/UHIre+WpT
         TZzg6ZKQRC1vK4Arvbk3kpRbKo3V+d0ibBS4Scwok5GMbx3yK7RYKBUJ4mN3lIqSSewD
         19+RB2zgMXk4RVTtBlwnL8X/mEEgnnmRL9c4fR/2hxjyV0osT0qnm+FiipOqari44Qwy
         aOIaDkSzlSVq5Pxnq1y+uBltTZYO9bmNQcHiwh6If1cB6jIltO/TalFPqiCvB3i520iA
         cNHg==
X-Gm-Message-State: AOJu0YwJZMm24w+mZ+g1kY0WgoIkjfH8220IE9rbkyehaLLMGTK4llrb
	j0pAr6w6HAchKKIXjsBYB1RL9qqXOq0C2qt27nFDyRnMm2hur/FLDPkXNMq375Q9lljHeU4PlYu
	tg+4fywtYt1pq47Gc+HZ2bR0UuuMUh37QSN1nAmmQ03JwE82KRua2/bRunaTZnte5GDxMV0jERl
	76oaUs6FfUHPlw7Hq9DoYdwE/SOcf0iF1VVjw=
X-Google-Smtp-Source: AGHT+IFJATfp6tM4lpzO4EBUwrl7NJ7Unq0DqBkTMLiaXx3ye4SDY9+pujgIFWcxlIILHR0RgqlAMg==
X-Received: by 2002:a17:90b:4005:b0:2d8:baf1:e319 with SMTP id 98e67ed59e1d1-2e0b8ebf632mr15837481a91.25.1727730466928;
        Mon, 30 Sep 2024 14:07:46 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shailend Chand <shailend@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 0/2] gve: Link IRQs, queues, and NAPI instances
Date: Mon, 30 Sep 2024 21:07:06 +0000
Message-ID: <20240930210731.1629-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. The previous revision was an RFC [1].

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on a GCP instance with a GVE NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240926030025.226221-1-jdamato@fastly.com/

v2:
  - Fixed spelling error in commit message of patch 1 suggested by Simon
    Horman
  - Fixed patch 2 to skip XDP TX queues, as suggested by Praveen
    Kaligineedi

Joe Damato (2):
  gve: Map IRQs to NAPI instances
  gve: Map NAPI instances to queues

 drivers/net/ethernet/google/gve/gve_main.c  | 17 +++++++++++++++++
 drivers/net/ethernet/google/gve/gve_utils.c |  1 +
 2 files changed, 18 insertions(+)

-- 
2.43.0


