Return-Path: <netdev+bounces-196394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCB9AD471D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46857A84C4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64C26E718;
	Tue, 10 Jun 2025 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoJiKfV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DD17E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599865; cv=none; b=VCoxnwMsGRXBqJugANzWobvaPdPFDm2OFn2Mk9Z+E1UTGCA1kgpcCiIwANzAWrot8LsPN40+ACxlDgfo9TPIrRznfYHnWfOETd8HUiS25AME3ErG7cV6BnXVcK3mOA/Gm4vq1rSsFRjohxB8DhZIWJg84ZfpxAD7VttiYRabr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599865; c=relaxed/simple;
	bh=ge1chh9BdzD8GY+DHa85CwLZmd8FOwaUB5HwqRVd7AM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=amJG+zLVQ5eWPy7M7xrd3CDKaqt6aKbwxFTOEiRd0eaZS5iKL5Qyj+SAUePw643Ku0K51h82rjLDAa5s4qbSEJec536ltVsCCrK44qGCWkvLfBJwZxsLWewVKAV6HzdJ+AnI9xOPCDMi+KRhXuOq0grImxS0Lj7XConwzMgmdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoJiKfV1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso5261727a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749599863; x=1750204663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwUFkMYiuBZ4MufFwXA3va+N5hQMy0EEDIkOppiCzg=;
        b=xoJiKfV1a3+FrYppP7snDqnaW1Lb5AI/RvmIXySDZZVp2KjVeKs+FR8aa3rpFSdcZU
         NlvxnK5CV7vYdoGwlg56ybEpRWzO7FPypfD/k433Gik3UwEQxqh5gecTuxD65GKYq78p
         m0xmvKqBcSQtnejn+uvYFYs8rNMVx31QR6Jntz9G88NXWB4hhKKv+FunDaugfAJBuoOS
         LcXiO2/z8e9rWm3Pb91zBXJHhA+UwG16gO9VsVTRJNBguqMznPFXUniG5X8CDZhG92Nt
         pA+U7GUZo5OmeRr6weTzx+3esqZ7h5XOzDdROF35lBUjV21ojIhQMLBkRB+/mzFAnmdc
         Q34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599863; x=1750204663;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUwUFkMYiuBZ4MufFwXA3va+N5hQMy0EEDIkOppiCzg=;
        b=XRYqLBkVuLopUqnpW5F42jEpWZaNLQh8DVWTItfGgKYDKgwg8GBHmyDZKT7u3Go4KK
         w0j6b/oxTXrD6xwf/9BWg4HBC8hUC2Xr6sZHP8UWHuc7COeoXwdIAoAJ4rEPLgZXtEMN
         I/suuSX+rzIEjj8P8Uo59jzos/IsCLSw3c0S21tuYL1BK8SEk2oD43qeUj0wQajf3NI5
         FZLFlY9hLvxHYYakceXRQeVRWpUeVOIpjHVggKBH2a7aA/LxQ7QykvA44Jln6NNXM9EY
         QWRbL/EsxZNy3fy18aiqWJWda4WYUuiVnYhL3+s6bAVcEZfcv18/0IuSSBnJcJoLKuc0
         O+WA==
X-Forwarded-Encrypted: i=1; AJvYcCWMzwI+x1Z9x9TaqL3J41DZMU0TnEj3Rb6Xcn/bxjuGb4zR6bvgIjV6ESjkkcxjaVS44ZHGL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3/jc7Pg21ssnWki5wa2LY80gSG2jRVCFq+uqWJxGUnhz7dzO
	sb5og9PA0/+kwOqq2iZx67zv6R3pdgBa0SiKpf3WRy8ikYzn7ABYJWvWJ/xpBm9/6FfgocfJdIY
	a/o9Euw==
X-Google-Smtp-Source: AGHT+IFGvG+U6u/PV1oZyp/1XABzNmJE/TDQdMkHA9/rlxwOmQ0UoAfgqiRTB39OpadNfFEX+VJ6yKPuE2g=
X-Received: from pjj7.prod.google.com ([2002:a17:90b:5547:b0:309:f831:28e0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e42:b0:311:e8cc:424e
 with SMTP id 98e67ed59e1d1-313af2402d6mr1908155a91.24.1749599862997; Tue, 10
 Jun 2025 16:57:42 -0700 (PDT)
Date: Tue, 10 Jun 2025 23:56:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250610235734.88540-1-kuniyu@google.com>
Subject: [PATCH v1 net] MAINTAINERS: Update Kuniyuki Iwashima's email address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I left Amazon and joined Google, so let's map the email
addresses accordingly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .mailmap    | 3 +++
 MAINTAINERS | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 074082ce9299..7890b69a9b6e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -424,6 +424,9 @@ Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org> <krz=
ysztof.wilczynski@linux.com>
 Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org> <kw@linux.com>
 Kshitiz Godara <quic_kgodara@quicinc.com> <kgodara@codeaurora.org>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+Kuniyuki Iwashima <kuniyu@google.com> <kuniyu@amazon.com>
+Kuniyuki Iwashima <kuniyu@google.com> <kuniyu@amazon.co.jp>
+Kuniyuki Iwashima <kuniyu@google.com> <kuni1840@gmail.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
 Lee Jones <lee@kernel.org> <joneslee@google.com>
 Lee Jones <lee@kernel.org> <lee.jones@canonical.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index f2668b81115c..bd09337f178d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17420,7 +17420,7 @@ F:	tools/testing/selftests/net/srv6*
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
 M:	Neal Cardwell <ncardwell@google.com>
-R:	Kuniyuki Iwashima <kuniyu@amazon.com>
+R:	Kuniyuki Iwashima <kuniyu@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/net_cachelines/tcp_sock.rst
@@ -17450,7 +17450,7 @@ F:	net/tls/*
=20
 NETWORKING [SOCKETS]
 M:	Eric Dumazet <edumazet@google.com>
-M:	Kuniyuki Iwashima <kuniyu@amazon.com>
+M:	Kuniyuki Iwashima <kuniyu@google.com>
 M:	Paolo Abeni <pabeni@redhat.com>
 M:	Willem de Bruijn <willemb@google.com>
 S:	Maintained
@@ -17465,7 +17465,7 @@ F:	net/core/scm.c
 F:	net/socket.c
=20
 NETWORKING [UNIX SOCKETS]
-M:	Kuniyuki Iwashima <kuniyu@amazon.com>
+M:	Kuniyuki Iwashima <kuniyu@google.com>
 S:	Maintained
 F:	include/net/af_unix.h
 F:	include/net/netns/unix.h
--=20
2.50.0.rc0.642.g800a2b2222-goog


