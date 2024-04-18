Return-Path: <netdev+bounces-89032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 411488A9427
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F29B2141A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F326AF0;
	Thu, 18 Apr 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd3VFQl1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32954BED
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425772; cv=none; b=t2eWWlNnuQLsTvP+y07kLLD4mk4HzL5mCHSFlKuHlUgz6+GGW5YFqKUerZ4v1DqQ8mjqqFCJrCfFPde+d/uIszUeP04sEbFWi3c7uhAJDZCY0C1dGqsQ+ouw3VR+BHePZVkDR6iqZc0dCN7VewU6h7qAtGMj6wXc8xkZYWiJkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425772; c=relaxed/simple;
	bh=lZ+R6N67ARQFzq++3LFlB+Z9QWdHpDR9Skv4qPESf40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQRCpsmTxp3qrivKUmAZoGBeUuTOx+wYHj5tu36obzlB8Ei8QTruiaOtW5p5ehDbo8IlaLUqxiu1F4p++iyUeMvDULFpCv+vO1h6Vkyk9kvoWVRm2jkgI6gkDupvWDIIKAd+5f+UgBXPxsmkoLFYhN86wpx6Jkq+sTirRHuJzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd3VFQl1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e51398cc4eso5179235ad.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713425769; x=1714030569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpy2rEg9ZNWJ5JbT06/E9/NLB753gLdsnym9tdupR90=;
        b=Hd3VFQl1XKsfGXtVDWjXVIFadNiU/YQlopSkDpjOh2zvdYp55pe0NrOVKr6B7edOu5
         l4FziKvWiaxZ9I/own5KMqVnKGT5YpPqrxHm9O3p3PKaOBGa+hCUqM2NLIeAeNSczd66
         gL7F5FaJa688R1FPfypJhNMpf+QPpXpmZeNamrATXHB3LXwxZad05313nZsH2ntuGbT/
         LHtND+ZGwy/W3Qavc+wLAfQ70dm6nQp/EJ9+/XtpIGMSyv4b+bVyQlqibv9+yRAwUYeV
         v5Rk80Pq0Q+ysVMEo7EkDiaUYB4JvLb9Ih719eWznWbG1tEHsvJNv/yjtCddJUB5qSOy
         0PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425769; x=1714030569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dpy2rEg9ZNWJ5JbT06/E9/NLB753gLdsnym9tdupR90=;
        b=L1yy5RYz82jyo+Dq0wUsZZil7GjzsztnIhmKu+7FKBI3A+4Zf1a8t4AmDEX6JN3hn8
         A96+ghyPVL1hGSi22+XTtTtzQ1NRI5gtg+4+a5AcjYMjD3/EcfllGcC7X+c3pTTa7Vc9
         CFT817kARVrY6fT8q8WL2oaaelbDxyH8nPLL9foWMFVFIfHXUy6UO+Sti8MnJPHqh3/z
         t97Y9HjnX/ImruXHEXpD/Etf2th182t+gmuM9aCVCumD7hjtNRmxy+9+9NQWR8l5vV/5
         IdtF8anP/GzVRIq/LoBSiSNAJ4t/RrfpYVS+BhtmT2Zs+L5cYMLtfTe8Dpi+5YU3kWGS
         uucg==
X-Gm-Message-State: AOJu0YyWYMEm6QVwYhvz43sj/4aKFSoeq8HdyAs1EqvpfBah5dCcGe4X
	hvhu8wYDVgrarHL6zjhUPH4lpIS0wTPBeWYUkkcFNiEyXNa1GiIs
X-Google-Smtp-Source: AGHT+IFIAl2PHYE50esvr6yTvMmoj1qbC8mM4VW2rS2LO++l5Uw8MEmvSH5xiVcWlFIrowOJ0z2Fng==
X-Received: by 2002:a17:902:c106:b0:1e2:90c6:839a with SMTP id 6-20020a170902c10600b001e290c6839amr2095277pli.31.1713425768962;
        Thu, 18 Apr 2024 00:36:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm841756plt.287.2024.04.18.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:36:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/3] locklessly protect left members in struct rps_dev_flow
Date: Thu, 18 Apr 2024 15:36:00 +0800
Message-Id: <20240418073603.99336-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric did a more complicated locklessly change to last_qtail
member[1] in struct rps_dev_flow, the left members are easier to change
as the same.

One thing important I would like to share by qooting Eric:
"rflow is located in rxqueue->rps_flow_table, it is thus private to current
thread. Only one cpu can service an RX queue at a time."
So we only pay attention to the reader in the rps_may_expire_flow() and
writer in the set_rps_cpu(). They are in the two different contexts.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=3b4cf29bdab

v3
Link: https://lore.kernel.org/all/20240417062721.45652-1-kerneljasonxing@gmail.com/
1. adjust the protection in a right way (Eric)

v2
1. fix passing wrong type qtail.

Jason Xing (3):
  net: rps: protect last_qtail with rps_input_queue_tail_save() helper
  net: rps: protect filter locklessly
  net: rps: locklessly access rflow->cpu

 net/core/dev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.37.3


