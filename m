Return-Path: <netdev+bounces-165273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A305FA315EC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED9E3A91A9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D742638A3;
	Tue, 11 Feb 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1V5wWrO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC414263884
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303263; cv=none; b=q7pBmaku21DQfElfPJWr3yoSobtqJk+cPKbKGPTgWNiv3CrN+t09vo7LZeDqzZTnRJt6rValt0Yw86To9HK0WnD/tCtnexCQMty8LjAOklbuv6+xMsTzqlbM6Zpr5u+SkvRoQFfL4KV90C1e0APmP0xMvduvEamt3u5HsSWdqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303263; c=relaxed/simple;
	bh=pJv71v/cri0TPX1o0+CLzhGyaVlgIxqgIFLIPmHfKVg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gT0ytTOi0aoR53iPUyWyObhAyGKFPLVVoXv5VcxX4XSSj/oX2JVzwva6Eq50nZHg0lDnquuG0dTFSsStfpVpJ8M8Csx7LFDNYXdKQtrZhJK2YkEDGZgyfctCyYaYoMk8aeP6qimJt4nHkWfdaBYcrMXrxe7j77tU8sgxDsZV3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1V5wWrO9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa166cf656so11158151a91.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739303261; x=1739908061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dHh4Wwsziy+3nuZCP27QtsSzjh5eaqEICsFmTBKoA8k=;
        b=1V5wWrO9Zo8so1CNWkgLFqm0DUdqe/ok7yz9plhDdObXhyB+pQS3CkElc8LB1YgOfO
         +U5Zh4qJjEFIYUzJ79uWbBFrWQqaHc2lvDVCdbn39G/w3Qlqyel4gmGIRCoJ+NgshRYW
         qIreBxJMXtRric9LYVn01GL5AMOp9TwwnMsJU+pymEc9f7xGd01TWKbl+ACuuYh7GPvI
         Eb02U/QO/Q7IUBey/eDfpSAxeI9QSyPXVWRV3GE2uHK14WkJLrNErPQ4Ti0uDXlMvTq0
         21PAVbORCz01Oz1qm0kgAjm3ripMA/a/EUfX5JDKH2uHzLnaX4nfjO5VtP4cozlfb8bB
         synw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303261; x=1739908061;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHh4Wwsziy+3nuZCP27QtsSzjh5eaqEICsFmTBKoA8k=;
        b=sDlqfidrsg2aty/B3ariczlSfo6ISb8wEjH1tEZbuSXx0///V1jO8DEfckqqtBmii5
         uWSiSbsPQCbi9UNVfhhUQ/QlXCD9V+eMWy7XqHmJQfX4qoMbyWJgDjG0sNNpATIRb4PM
         kc/t8b6cxnBt3yIkRydc8qHkxgqYGJ8Z5UwxUKz1QPYiVS4AmQtn2LO3CtPy4jAxrXdI
         hwe0iMYF0vXgsuBoGUhKhf1HKOaOzexRM8kd3TkNVD2QoCLvCc8yimr0wNqlAcKXr5Jn
         wM3U1pjVhFz5mCqkegTXZELFjG+ZfyddbpX+wztM2a94tPG+fQdHhRscvQePFgEEdmCv
         p16A==
X-Gm-Message-State: AOJu0YyIItpmrxzxpCbarT2GzRLdYdD2vDt2J+v9RZT94SLzonSbOmP5
	x54yic1Bc9/XozboKAbStdQ2KYmaCrEYhjQQ7LAFm88zXHtkaN08XFt1oNlx+CK++RG+Ppbafjd
	0O9lgv1FkfXvPrsaq32KoCayRd401VdQLsEBjGCADAn/of91pn2KE1DC9ivHXKDsZJyviyYQ4ML
	mk9wt3yeO0WdGQ3Jj42cBydq14DAAEqeBSiM/c92HH0jw=
X-Google-Smtp-Source: AGHT+IEU3hX9hycREpNQY0Z67pvynsSq9jxI1tO/uK5JEcjk9RVvajVETUlyD2AoizOa0zkv2TYNTqvTt/zONA==
X-Received: from pjbpv5.prod.google.com ([2002:a17:90b:3c85:b0:2f2:e5c9:de99])
 (user=jeroendb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c88e:b0:2fa:1f1b:3db2 with SMTP id 98e67ed59e1d1-2fbf5c58cf7mr529268a91.25.1739303261059;
 Tue, 11 Feb 2025 11:47:41 -0800 (PST)
Date: Tue, 11 Feb 2025 11:47:26 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250211194726.1593170-1-jeroendb@google.com>
Subject: [PATCH NET] gve: Update MAINTAINERS
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	willemb@google.com, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Updating MAINTAINERS to include active contributers.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1bc31a6624b..a0e92051ac60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8711,8 +8711,8 @@ F:	drivers/input/touchscreen/goodix*
 
 GOOGLE ETHERNET DRIVERS
 M:	Jeroen de Borst <jeroendb@google.com>
-M:	Catherine Sullivan <csully@google.com>
-R:	Shailend Chand <shailend@google.com>
+M:	Joshua Washington <joshwash@google.com>
+M:	Harshitha Ramamurthy <hramamurthy@google.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
-- 
2.48.1.502.g6dc24dfdaf-goog


