Return-Path: <netdev+bounces-94297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39F8BF0B0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7281F214E1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648E136667;
	Tue,  7 May 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOmSgRzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5D13664B
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122815; cv=none; b=YkM61FzFVYI5n4pq1VMdGAFPGFfeR8qQKIiwhkjn9sHOeN1oDC2o2AdYC2KkWEpHd2k1ClGUBZFajup+Y/n33r3gd8QP6FdcYwvppj+dNMrQz+WG2T+fsxygB6vnI9ECx/i50v7uDhprV/l9+rv1ORhdk9oZ02XTbYtfHlnQE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122815; c=relaxed/simple;
	bh=/GU79Kgff0skDDvMaY4WHPvnPx8SIQ17Sgl7wKmolF0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G6qoJxkHbqQFsjtMApSIS8fsr/sim4SqddEbivjTvPZN2y7xEQbkVVmCsaIK6JuPa5CCDazdz9+w+xYQbs2Omcwz04zMqXLzkW20Y0czy9/DNnBsml1GOKXJyGuneI+gMaz6iD7jWLHAXCVAiCWG45DQeMfSHrTPcYhTyp7inXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOmSgRzX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be3f082b0so64401657b3.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715122813; x=1715727613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sf3hv/X+FVx/KMJP0srRJep+yhny1t3ptyDpy1jPj74=;
        b=AOmSgRzXXwfLLqiNCZkJp6O0EUuuF0oKiRgNjk0Ewotd46jSpvc7izMXfu9/hBBU0N
         QWeCLgXqG80yikXuSRSfruaHy+59IgezRqhpoiVN8NzosIWPhQ2+DY9/wCaVjNM+ygoc
         Nqd+gCtV5mfRrKzHh/blHRFQdmXMexlBmUfVZfjU2hpQIP22wFxdm2Xq/eT/KIxxyQVC
         kbfhmVTYzeBCEqqLNZf/dck/hXE60ps0YY2n2cNTDxuc5nKAnk0jYEpMc3j6dy4AkTJ3
         ZgbAWovBCdGOsL/AoVDn4wdmXplE4uRP9EvgS1gdMnqIIxo7mp0eL9dTe/v9S7qtbiQi
         moqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715122813; x=1715727613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf3hv/X+FVx/KMJP0srRJep+yhny1t3ptyDpy1jPj74=;
        b=Pv0HLUwWYbFLcnGuP0pe5+wd6GFhWOqQvFPyuFUPzL+qLU7Oi52/XVhVgA93pheh8K
         0pDJbWQRyR4qD85v1f5Xx1hLg1182JMBaCwWQJmTXlTPQoKgAEB7GxSnFEUEe8jSVVYG
         bHABATSGkiazdfZghiJL8/YAKf4aMtaT5LrFEwYtZrwYuBlP+RpWYqt6TU6RVRkqzQm/
         pEjsj6h6ZzAlgI+oZDVUAvPVq3GPtb2KnpUdjiawxMZVYpAVxbWn0bAFlpDAObRegeR7
         L/2Xx/CIuHLGGlhrbXtiR2a2Ws/mzYilCDvNUjrShLeX/Id+vGjTELrnO1I43FxD/8oP
         GCOw==
X-Gm-Message-State: AOJu0YwQZITY+2GLTs5j7yRTGUBThW9V1e2/IKmZxhlvYlouk3o/EjjQ
	dVwaQkAZJ2am+wSMwZzEi+5REcUqnvvHB0tTCF0hcq+Tz/MN+Jm3VaHeE/djTvpQXA0SBUTA9J9
	6QsbTIIIcDEDfAQRzgXj1ETVBOpsXpKhIWIXx1EZzjqNzInf6cghpTvc6vVxJJLXH4PXupLJYUf
	ITY5aky+F3+1AOIV3MDFAz+46OhOkCQQIOXZq4zAyLy47h/hT6
X-Google-Smtp-Source: AGHT+IE9hOPN2lt7RSFJKIcZOyuNLU/r5OYWzliZ9pt3xeeJDz4hCT8iZ4E+txRGrb5DPst/gTSHqMgp3YtnFDE=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:8d03:0:b0:de1:d49:7ff6 with SMTP id
 3f1490d57ef6-debb9d3003cmr123671276.7.1715122812981; Tue, 07 May 2024
 16:00:12 -0700 (PDT)
Date: Tue,  7 May 2024 22:59:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507225945.1408516-1-ziweixiao@google.com>
Subject: [PATCH net-next 0/5] gve: Add flow steering support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, rushilg@google.com, 
	ziweixiao@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To support flow steering in GVE driver, there are two adminq changes
need to be made in advance. The first one is adding adminq mutex lock,
which is to allow the incoming flow steering operations to be able to
temporarily drop the rtnl_lock to reduce the latency for registering
flow rules among several NICs at the same time. The second one is to
add the extended adminq command so that we can support larger adminq
command such as configure_flow_rule command. The other three patches
are needed for the actual flow steering feature support.

Jeroen de Borst (4):
  gve: Add adminq extended command
  gve: Add flow steering device option
  gve: Add flow steering adminq commands
  gve: Add flow steering ethtool support

Ziwei Xiao (1):
  gve: Add adminq mutex lock

 drivers/net/ethernet/google/gve/Makefile      |   2 +-
 drivers/net/ethernet/google/gve/gve.h         |  53 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 228 +++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  98 ++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  91 +++++-
 .../net/ethernet/google/gve/gve_flow_rule.c   | 296 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  86 ++++-
 7 files changed, 829 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_flow_rule.c

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


