Return-Path: <netdev+bounces-140117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6579B5467
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2090284A94
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA420A5D1;
	Tue, 29 Oct 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pd8bUOpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A51209F3C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234756; cv=none; b=AVC1gbZ3TLmM/Tp/8PK/jHystVV35pICSFl77c5MFGcoTrDcTbiqL7YC4lh13BdLxEJNJqWXyLw58Mi6rel2MOZ/FUVhECzDrSAldbcGz6najTRBn1p+fGax75zDDcHo4CnsdMxFxUoCIY8BhC6tpdQJchS4MoPMrmsyXofVr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234756; c=relaxed/simple;
	bh=oxvcO/ZaB/lL61u8pEJ51NobI8qaVVYlrPTrDOUpHPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MfMU0EMrNDM2N9oHcSEU+S1AWMFeCle1pNy/pYh0ATeYSWFh1HXQS0DAyQYA1ooVoXD7PTKb/P5t3ByOhDVS0nKxuhix4I6u8u1+5Hbv4Ar+GfGJDnvyzZIsStWfIEz0LvsxadSApoKRv0c4aUYVS96TXX6qOQCycYN/NHLuqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pd8bUOpU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea258fe4b6so31709117b3.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234753; x=1730839553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKjGAeVoY4GHFtcwq5banhGcJjKwOgTAegNaQaox++w=;
        b=pd8bUOpUpARD3tcU0bwU12p3PxGCDqoDAszXIIqwYhYs7Bqc7QY1iLPZUnZw2yGNyo
         liUPo980BUweJNRqeACnmtcMMkhI6WvV9VP+qzzEKJt/gfBBmJ9AaXnXowunn2QLiyXO
         /d5HBm+pX0YsX7sobJsvzOB8/fl1NsB3RUMeBol5EpE8V+EGt1GhvZors7y/0L2qSAje
         T3XGtUKjuUwqN2rucag9C0dQDTqWV5tvLCQH8Qu3mrnLUjylW3xO/GWqT1WNtZU9dCQC
         czSVTbLpIVvC7GOlMHnTgn/y2AXD6Hj1CABV3sjpA/6dnJoa1R9aq+fUSZnR0DAiAEPW
         EwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234753; x=1730839553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKjGAeVoY4GHFtcwq5banhGcJjKwOgTAegNaQaox++w=;
        b=JiSdI9dA9KRNBfG2SSwWq+3kTF3Eot2wIE0BhRkYxqPtvHpMFHcXJ8cd3Ned8v1E9B
         LMULMUlMFn8G1prNeeA4mnTTZJGP8Wf5y/9yRrA5iqjRFRcthe7JOdJfxnjo+vQx46UL
         v2rG99fKazAays4Auo8M2p5frwSYmeoeBhMn0Ji667jrjuGbUdu5a2dnjJZTTFqBajsv
         bybBASyz1wEb4T+WRxzrSPU25PphmzVL2glWZuLs7FATVF2+dgZVlmEyZSOuJ2sXniiG
         EulfyUV6z/ERi+0ZY0SNJDQocwi2T2fEpeHo/IN4uXQrJkfI+WYYJjge6zab5FpgKIzk
         ERKw==
X-Gm-Message-State: AOJu0YyrMARm930com+W8WXcGA6xyNvZM+LvRz5aMKlP92HnMae+OKck
	Ajb81g455gMb5hxAUXekb99rS6/ryVtFBmQw33Uy0ZGZ4gPRVbov/UqcLZJILnxP0+0unLhAR4r
	bov1qBvzpz5wH45N987sOYSYsbQnukuT5TjEWAG3h/e522b1JvJQ6RaB9zlBsmKd/pGZX9HPgoM
	VsMgu7LSgW7nu2tgP9ynTVPJKH6iLUtvHyEBaQ6qR7YJmVH4piRZLoI93bgN4=
X-Google-Smtp-Source: AGHT+IFriD3g24XyT1jM0DrGKfcuWZDYLvFnWpLS3cNOCFhL6xGL+ZOplvsxqtm8XLZC9n/DUx7QNPgLv1gz7vx1pw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:2c85:b0:6e3:14c3:379a with
 SMTP id 00721157ae682-6e9d87a71camr2100287b3.0.1730234753049; Tue, 29 Oct
 2024 13:45:53 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:39 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-6-almasrymina@google.com>
Subject: [PATCH net-next v1 5/7] netmem: add netmem_prefetch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

prefect(page) is a common thing to be called from drivers. Add
netmem_prefetch that can be called on generic netmem. Skips the prefetch
for net_iovs.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..923c47147aa8 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -171,4 +171,11 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+static inline void netmem_prefetch(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return;
+
+	prefetch(netmem_to_page(netmem));
+}
 #endif /* _NET_NETMEM_H */
-- 
2.47.0.163.g1226f6d8fa-goog


