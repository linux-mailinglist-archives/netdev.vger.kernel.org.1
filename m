Return-Path: <netdev+bounces-131689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52898F442
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F871F21EC1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC119309D;
	Thu,  3 Oct 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3uxGBst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2159F2E419
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973065; cv=none; b=iPxHz6AX2GjhmrgULrqAYqT9V1hVOMexC07Ysh4bgtlkRiMVF6iIHKzp9MCZ4wZDFs5VAW5nKYc7vCHGV+Gx6/SiDSJmoZVt1+x7s/LEJW72wspVtpsjmTADuSWdlR91FGO1pzNJ5QwhOQ5G3iW3g2RlZdvoNRq4lqsndA1Ma5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973065; c=relaxed/simple;
	bh=/TwQ/V3yyFLTTnM7FxAZz/EkTcwHrEU6SUmegANcUw8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oxfQrJysHxTZXVIbH/NpHObZZPOvsjk8/3z/QrMwBbrxst4YOVeZEDlXxx7HmRp+mU/yYDmpoZV3sgNI+18EpbHtQpTTEjuqkDR5H9dA5WFP6tlWT7SR2hHipkXvrIy8+ADj7e0eWoSxWKAw1TeDaIOYMOGsnqYMR9iY7H7/Or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3uxGBst; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e251ba2243so14675607b3.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727973063; x=1728577863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qoP858fuLnDt0mal6NkZJwbkYaOn7QjLgibHOH8liII=;
        b=P3uxGBstMbcS60s+O9WRT4NBwM0QNTzbABeVjY4ELsi4xV8AQhjRhtqF4bcqsH1Kb0
         3mHI2AqiXB7EROhNWOvSKqWcrjgT7avvmOToLStA7e64VAvD/ZXGU7OClY1xZHUf6D6l
         WVJ9OIPFHDeuWr3dkagId33i/MixISfILzeHd898wEh2O/FYY7QiJDIF+N8Kt88w4zXi
         MrpBAOAElzOjLYuQnUcccI6c1EUIz2BnMqSjiWq9TQ83rS/O6JYCThS/AJgQZCRzrlF1
         qCmmZS6GqbXcZ8UTrVZ5K/aJrC7Jguo7MEEOhsjj8x6pvD4J7dEc+F5igofOGwbJ3qQg
         gKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973063; x=1728577863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoP858fuLnDt0mal6NkZJwbkYaOn7QjLgibHOH8liII=;
        b=HOIhQKlSlMASHlYnoDjzMvk7c+/hdF2X7KsPJbVmdC0P9+uovcUCodwho3/uf82Fm5
         iedlw+riBKWrwZ8sWXq9cVKFKN0Sm68A6GDYE6Iho7XH5eXUaotIK1e5DfBop91xXNLC
         xJrLLQUA1G/QsXGuY1dYnhRxeI17viWYoXwcpP+FZxmLq02QrY1r0hJaG4qZ9lKwIZln
         dYsFAyS6hAr7jsVuTnWQmdzHOIQyTwy3bQrXZPdf8eX7CAJHP91pdZ1B/bgWBP8EhGdg
         Kon68mjmrSQyTe3I2wLQZzwmTzlOrjhFAaAzt0aWLox4cNcqCTkVJSh0YbRaKFL4Tu+d
         yAzw==
X-Gm-Message-State: AOJu0YyxpiGGmfFCCyCTZLGBD15T55ffzj3Vsf+osh6RrdvCosmsiab6
	tuKohVsyW7H8ddzE2HyADiGWGir7tOuy7BwLm4JFDtyld8ENFLl1nj9GW3+eoXHIn2VVZ4zVol/
	B+lcsBppot7oOIjDn0bgB7G/FaRNThZ+5U1hcAgMwpPQHFmnM01ZlqOPFdpVcnhLQi198aW6RC7
	js6SdlCpkDmY+Ipy9pa4dD7PhwKkmafA2C3+uVFNtaVbtsa9y8UDThhu2SL3VnsWLB
X-Google-Smtp-Source: AGHT+IF2IfXxd9TuNyUU/lzxP4QkxdpHfvF+85pWc66zKQM8To05O7OG/xOx4CDseeOqDQOoqZsqevAQEVL3WqgIsPU=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:db19:ea7:7d31:e0ea])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:257:b0:6da:3596:21b8 with
 SMTP id 00721157ae682-6e2b53e500cmr691567b3.4.1727973062807; Thu, 03 Oct 2024
 09:31:02 -0700 (PDT)
Date: Thu,  3 Oct 2024 09:30:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241003163042.194168-1-pkaligineedi@google.com>
Subject: [PATCH net-next v2 0/2] gve: adopt page pool
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

This patchset implements page pool support for gve.
The first patch deals with movement of code to make
page pool adoption easier in the next patch. The
second patch adopts the page pool API.

Changes in v2:
-Set allow_direct parameter to true in napi context and false
in others (Shannon Nelson)
-Set the napi pointer in page pool params (Jakub Kicinski)
-Track page pool alloc failures per ring (Jakub Kicinski)
-Don't exceed 80 char limit (Jakub Kicinski)

Harshitha Ramamurthy (2):
  gve: move DQO rx buffer management related code to a new file
  gve: adopt page pool for DQ RDA mode

 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/Makefile      |   3 +-
 drivers/net/ethernet/google/gve/gve.h         |  37 ++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 316 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_ethtool.c |  14 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 314 +++--------------
 6 files changed, 410 insertions(+), 275 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c

-- 
2.46.1.824.gd892dcdcdd-goog


