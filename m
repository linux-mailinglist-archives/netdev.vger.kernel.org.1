Return-Path: <netdev+bounces-205861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC187B007D7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F3C3B55C4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BE278741;
	Thu, 10 Jul 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qz21eRi8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F82798FF
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163005; cv=none; b=VUyN8VJNmZqf8vRKdh/XZ/0aG86N//KRTUcAueORUwJee91hQia4XLtvAfcLHDcfXt71bKdBlAlnFJrENFQw+i3q4KFKKX2IPe9g1vp6UZl+aFZW650i98Osfh/muDrk99oa8kJR7hU2rmOXKLoUomBwsDvnJ0lJcU4WWXO5O4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163005; c=relaxed/simple;
	bh=/cJq9KxvDP6A6XR240CsJYr9GJdHVkdxiK5Yep+6gEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DeO7BRpk5+tXblHtaZ1sCVGXBJ/zqAEddHjz+xbpgnpLdfq6TX96GwaveKPOJS1Ypll/cf6drFJ8+6gP4jRIg/Rw/Yhw0C0tO8bs2O1Iv4wYVq2sbCFPZ3lo66axUk+Ys5e2sOmIMa3/FpJCd81tt7S7/FCN2ejZY42nb5WAHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qz21eRi8; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a762876813so18130381cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752163002; x=1752767802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnKwmo1m6hLF5udTnifDik+BWf8EHwhcINoxCW5NYug=;
        b=Qz21eRi88yNf86IGcpIEcbkJffzHTwicURmfCqki2Ev0yv0h4lfAmVY0zAhOKPekPD
         CJFYmmbXxpKf2VkXgqUDPfJoyu3qfKzvD4C9NGapsCMullFBA1Mrs7lQH4KKXwFetXGK
         yonADtrtnvGLn5i+ALlZ9fDRkYNViwRgcQjgt4fGI2DwUPnr5z82How33e2wtBlS2bmh
         NkIbofp51P/NQwChAOaH0tECjHE7xxtgHRinnjo4AdjfAYUQUT7ECjzXmXEZvopr8KYp
         uewGai9Sm8eMesM5/so0TvtJhirlkp5wDbbodduwTSDUn85ld5ThOHf/H5oyV5NpepGP
         k/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163002; x=1752767802;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnKwmo1m6hLF5udTnifDik+BWf8EHwhcINoxCW5NYug=;
        b=XQo7Yvb08N0zs0AdIehTbbyqbOClUwZuw8QCNtftlpUkNjA5o+/uU3tA0TJnI+kMyv
         AT9NKDGve1N2rAQr5TN+kLKfBiqRth2ckuyACSE0VhbbLr/dg5dXpvCdepE3a57ZT4q+
         1pQlWPj+55mLCPz+dji3ysZPLzSJ+MZg3KGYqTwecIVxbL1h0P9HaqxgRroZKdjcak0b
         f3ANIRtAgXu3sFqzd6fC48eO88Uk23SqF8lhD9SzJhP5MZre4rOBSAz98YvweeHY1lM0
         fAzM740ZMVq5GJ9s8s3EZQ22TVdwsISAca1D7PAaaiuML2WjrBOOEJHDS+iefywogxza
         3RKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ras01Qt8gxH0sCAGbAJilgeZJJJIqfApN7b1yRzmtD6fsTnB1mRybJy2I7sk267FjWfnS50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWG1xXW82DXo/4KAFabaTbD4dq4R5QQ2n43+cwIcfT4dTrPcW0
	7+3qdeVO1gFBaT0rc17+Z3w9HTOdjl7AY0f5ibWG4vw5x33IpHZAyliIE0DX5RixgSw3sPFrNAR
	BlVZg49x74wzQLA==
X-Google-Smtp-Source: AGHT+IEdWtY83QZnIyvWQZo2KsUUfLJ3rQSPGe3zKRVXB19x3084wZd8FiHiJkQe0y4NyYuXVKr6yTvjn8XEig==
X-Received: from qtbjb5.prod.google.com ([2002:a05:622a:7105:b0:4a9:85c8:9b0c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f53:0:b0:494:acf1:bd0f with SMTP id d75a77b69052e-4a9ded10757mr103732781cf.42.1752163002630;
 Thu, 10 Jul 2025 08:56:42 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:56:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710155641.3028726-1-edumazet@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: add --mss option to
 three tests
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Three tests are cooking GSO packets but do not provide
gso_size information to the kernel, triggering this message:

TCP: tun0: Driver has suspect GRO implementation, TCP performance may be compromised.

Add --mss option to avoid this warning.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../selftests/net/packetdrill/tcp_blocking_blocking-read.pkt   | 2 ++
 tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt     | 3 +++
 tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt     | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
index 914eabab367aeb765a85e311513c3ca35ec27946..657e42ca65b5d4280875af49ba8775688172799d 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_blocking_blocking-read.pkt
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Test for blocking read.
+
 --tolerance_usecs=10000
+--mss=1000
 
 `./defaults.sh`
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
index df49c67645ac8f8bdef485f03af6e84d2b883ae9..e13f0eee97952a39a3b67cf276d01d0b9eee16cb 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Test TCP_INQ and TCP_CM_INQ on the client side.
+
+--mss=1000
+
 `./defaults.sh
 `
 
diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
index 04a5e2590c62cf725e92f137470b0bcae309eaba..14dd5f813d50eb6425bb58a72e63d47433a29cb4 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_inq_server.pkt
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Test TCP_INQ and TCP_CM_INQ on the server side.
+
+--mss=1000
+
 `./defaults.sh
 `
 
-- 
2.50.0.727.gbf7dc18ff4-goog


