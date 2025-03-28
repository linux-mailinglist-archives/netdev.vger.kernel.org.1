Return-Path: <netdev+bounces-178131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27799A74D93
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3C716D1A1
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDC1DA4E;
	Fri, 28 Mar 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gws2QELH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E431A0BF1
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175004; cv=none; b=Krh8cLXX8VYxB13QbnJX5XsbHUwq8kEMvYSg/C8EtwHV3TAYTBrpzPOxqWoDBGkr/gX13DCaQ1jihq1Ho70DJoa0sH3OwbHqBL5A29G95eiAFEUXZ2vTsbXfDfutoZtGzRNL8/oERtcFaipSnvLOKpK+db8ZLcZprhGnNpXY1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175004; c=relaxed/simple;
	bh=XLp8cXfLtQjmmFxadSFM7J6GZ1WQ3+/4K1FyXs8yhh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0u/qiRiE4ylXoBYJAJK3y8wuxgS4xuZnUkCtZa3AQQAbZmN6ryYoYTKhjcu1jwXUIqaPMQ5rVV7HRUfWOw71LD0szJYTMuKFCnbKheLXMq2zqEh8LUMIX4LECdlMMtmOsnoPfyku2LDh7g284Ha7pgCfZ/E4s2GwRsGvkwT5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gws2QELH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b650504fso50770135ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743175001; x=1743779801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KL46pdl62bzBaMquvC4YS0feFcpNYZxNvZS6lT2zC3Y=;
        b=Gws2QELHAf1ZuWHECX4JCKwRRSotDWpQcIRClY8ZK7OEFwegzBTqXfrl275p0VFGCd
         P8pHpB82GizYTNV2S/Hn13j3fVc08v7OmZA1THX3hd7WKeDRy1XDk34J2o90L0+lKMGu
         X98h9jLRpzcReIKxt7YtsMxYmvTBGlNJgJQFE1BSzN588oGPzZ5Igq2aOESzJqCAOHir
         H6DN9VC5jnk25NIxUFahlGhvjHrUpiEVs6x8X0xtGcaGD2h3NeNXusLfwZ77QwxG1q8x
         Vvi5QzQVkWmCXDCP1UGHYIXkLTXkvd4XN5O2Y60B6YcYhdt83RdzeT1ZHShWpxDUsXPH
         stVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175001; x=1743779801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KL46pdl62bzBaMquvC4YS0feFcpNYZxNvZS6lT2zC3Y=;
        b=QQG3I3MQe9EdRcg1yu4v9uqJLg8UPqlxOD0ZHj43OVlGfHbMGhkEYwjzMu/cf2xUey
         mf/ad0VwAycDSFAUSSqhfiF+3oPIed7LAoyRH0y3q7VVmWnuesOGCFSkxl3onZAJpyyo
         YWfVNJFmHXnxHHgvJuv3cI3IIZFWTN3b2c2H2A1IKmIB3hXZEW0QnoT1khVBA8lz9dww
         wAOh66aTHyd4usxji+SiwGS4drmTHaI2VNRwWRj5CaEsUm4XhxO90/g8fSgNb4DmPDlo
         /cVXGHnq+N+dFvxpnVrFxbFZ7lT/wtte2OrBZTApix9cPypWXsWyJAYwKy8oGfaX8u0e
         v2Tg==
X-Gm-Message-State: AOJu0Yy/YNBMl9Fp2ObD54fAn7vUsPa49Bzc3NpuMjgmKMGMkWqDVjxC
	AatrVCX7QyMJYxh3ZWFpvLusP/pOvBwV1Q4muO+c2mQmIgYk5UBO
X-Gm-Gg: ASbGncsEimH4SWak+m2WX9vHZNO6Wvu0JI0FlosCOYDpzHAj6wT+t1W1TZ/twaqSo0v
	T9Cl2ePPtgbrKutG3jp4RVjfyCjrddZyGTYaRxILZUAqLD5UkiZKWCTSz8aTn224wOzsw1nIZsx
	2LFROXmPEixXXDGC6UK5lRXz+fRuxk1YumkI3HpP9VLXH6i+eQG89jWqO+wt5sZ6xDTru24QaUv
	exgsquKlwmUAVyGelmFHSyMzOc93oWYAZaA4Wk+Vs5cK1HVXMr2e4WOC4p53NJrXpItmEY8Mi7K
	BJy0uVz1q71RDUkMoy4ltnblgkcYp3JYs4qSIyOnJRIdoc6eyfWk/kJu8XIGjhu//IN2Sh+YQn3
	ge7pJJMI=
X-Google-Smtp-Source: AGHT+IFmzAoRIlReGWxk+s49vyfMIGo6+EbUii8sLk1/q4QvAo43enMe9oOfmgQMLXYOA6gppDa3Fg==
X-Received: by 2002:a05:6a00:3a0e:b0:736:491b:536d with SMTP id d2e1a72fcca58-739610ca56dmr13756274b3a.20.1743175001262;
        Fri, 28 Mar 2025 08:16:41 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109200csm1853985b3a.128.2025.03.28.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:16:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next 0/2] tcp: support initcwnd adjustment
Date: Fri, 28 Mar 2025 23:16:31 +0800
Message-Id: <20250328151633.30007-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Patch 1 introduces a normal set/getsockopt for initcwnd.

Patch 2 introduces a dynamic adjustment for initcwnd to contribute to
small data transfer in data center.

Jason Xing (2):
  tcp: add TCP_IW for socksetopt
  tcp: introduce dynamic initcwnd adjustment

 include/linux/tcp.h      |  4 +++-
 include/uapi/linux/tcp.h |  2 ++
 net/ipv4/tcp.c           | 16 ++++++++++++++++
 net/ipv4/tcp_input.c     | 13 ++++++++++---
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.43.5


