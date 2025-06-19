Return-Path: <netdev+bounces-199310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7616EADFC44
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93033A6892
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC023D2B0;
	Thu, 19 Jun 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+YIvyFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430D8633F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306505; cv=none; b=rExH5OqJYDPv3N3xkD5xV++TOrb7sYf6NhwC6e2jhypgEARPIIpSut4OQ2nMllradzucq2mWM1FALctchI5IEh0UJ/d7B5RT54q0G6PzXmqvhnOjRvQvOwl1De8XTLVclkhe4tz3s6lASO+qQfIr4Gvx2P5ir6JlJ4KG0nEkCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306505; c=relaxed/simple;
	bh=26/+w7DR5bLuEZ/6KopQYzCi3dGAjrhv2bNSuNw+zq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7fbgna6jBP+ZY8LWqx5vTosRiTBrxE8i67/frQuTF87G8YhlfIUKAEFaA3iz5re7MiLezSUeWGfAYVs7shR5dfcHS6Y9fCmVqh9uMzndWKZgxZ40YAe90CUK5xfmSV7okp2YcNCsz9H4P9PDBKz8Yns1IzhTiYMr3DZpmMJeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+YIvyFe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2349f096605so5991475ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750306503; x=1750911303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RtCMHn3OaTn93tWTmxxpAvxTcKLuMOyCWOMkbaVhJ0=;
        b=M+YIvyFeQPn9vfWLtgWslV4MKNl+N+Ttt7U90jXwwOtNq2/5OTTl/nhYo8ztefUGJM
         ELPHqBd+dwysqekWSie8lNjfT4RLv0+B0NikWc1BUyiD7m97U10mXZ8JyBxc8S2i/MQG
         UoCekNO3UTimxrtph0fZS4camxkunF2AzXpMQO+IMmfoYDtLe6EO6oWwBrYC2VGQbQzH
         RzEt0NeLs033swrs83Q2WcwowgaynbfZt6Pv6Gm3X6FIQNn3mJ9grWgytgSHh+ySwHqZ
         KEdkixxQ2Ty6HXa4a0p73EU2MNo4vUjE1dQT8mMsrJYrFrEvMtct/wS1G2/HNsE1WsCO
         UQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750306503; x=1750911303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RtCMHn3OaTn93tWTmxxpAvxTcKLuMOyCWOMkbaVhJ0=;
        b=QM8yDoko26oeexih8mnnqcfBeCCwx6TTMmjSFUgvYW/1ds/OcacEflhpVGq2nZUO3Y
         M5SfHypid9ZIzoolKuK3Dfo/b3R0TjLT0RBANHLCr82DIDdwWCHXaMxX3OortWjzdmA7
         BqfooAzDY3YYPpITKp86zGXnUVvLSOw3pdC5gue4CCtKvatDCvYtsSd30JHDtWSECalZ
         FOTk5MoXiRo5NopeMFpUHhfvGxDGSOJcq3JQuBszCK2iJfXcAP6XAy0wVl7dsM8gocch
         ODE9GRnHS1Mwi5PzpC+fjLWUehyeohvI99AbDMCddOPPClQf3CAb9EVMBIOpkzdnlG5e
         TE2w==
X-Forwarded-Encrypted: i=1; AJvYcCWUo25Y8IlXLh35LeCi8Pl/q+TwXOEV7L1kHWX/FdmYRD0FjdZjGP7C7/xRjTtDe1L4LNS1gRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZN6vH+Z/pcrvnkPfi3fwdnJHYaMabTxhl88GBWrf/ci4jqox
	54d7XCkeiSCFg7NgguVhdbdmf86j0JxtMOMlUcLgv3yLT+pQAzQclbQ=
X-Gm-Gg: ASbGncviQHQkwaXPedpx5FBlSql+vj+dFy4J32cUQxBTOXYgMxefRas5I88lamDQ/x8
	TCsnIP0upn6atmUnqNN8wAN/b10bTtd5RkW/7M91EotHG8G9CpYrNgqQrWqlnquR92v/sduCvf7
	zBi6dX+RUgzAaRKD9NFmP4EJ4nEjv+g4JO8yOCrP0YdzoamoFMCvZdJgi+5vNUbTsFSRQg56fLQ
	SztRRsOrLO3c+UqFOzuHDiui/I1va8qwqEPI5TvY3XrTiIjcVOYYJUI3jVq+fdWjDOwfq+8/VEZ
	vF+LZW6vywQmAFVb6JYaYAB+iBzYTR4+JGtMVcs=
X-Google-Smtp-Source: AGHT+IHlS0JxKmZMwgi5OY/9CR07Dka+VHjPSvDys769Xyo0/bTNqv++W0pyIcOtSGuB7FloXCPmnw==
X-Received: by 2002:a17:902:fc44:b0:234:e655:a632 with SMTP id d9443c01a7336-2366b3e02demr290775055ad.51.1750306503493;
        Wed, 18 Jun 2025 21:15:03 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781b1sm109928585ad.89.2025.06.18.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:15:03 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 net 2/4] af_unix: Add test for consecutive consumed OOB.
Date: Wed, 18 Jun 2025 21:13:56 -0700
Message-ID: <20250619041457.1132791-3-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619041457.1132791-1-kuni1840@gmail.com>
References: <20250619041457.1132791-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Let's add a test case where consecutive concumed OOB skbs stay
at the head of the queue.

Without the previous patch, ioctl(SIOCATMARK) assertion fails.

Before:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob_oob ...
  # msg_oob.c:305:ex_oob_ex_oob_oob:Expected answ[0] (0) == oob_head (1)
  # ex_oob_ex_oob_oob: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.ex_oob_ex_oob_oob
  not ok 12 msg_oob.no_peek.ex_oob_ex_oob_oob

After:

  #  RUN           msg_oob.no_peek.ex_oob_ex_oob_oob ...
  #            OK  msg_oob.no_peek.ex_oob_ex_oob_oob
  ok 12 msg_oob.no_peek.ex_oob_ex_oob_oob

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 3ed3882a93b8..918509a3f040 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -548,6 +548,29 @@ TEST_F(msg_oob, ex_oob_oob)
 	siocatmarkpair(false);
 }
 
+TEST_F(msg_oob, ex_oob_ex_oob_oob)
+{
+	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("x", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("y", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+
+	recvpair("y", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
+
+	sendpair("z", 1, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(true);
+}
+
 TEST_F(msg_oob, ex_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
-- 
2.49.0


