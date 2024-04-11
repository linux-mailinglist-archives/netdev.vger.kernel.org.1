Return-Path: <netdev+bounces-86993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFB8A13B4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFA928832B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B924149DF3;
	Thu, 11 Apr 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCElHXFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EAC1442FF
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836614; cv=none; b=O4Hfau6juuEnS0oYWdYlo82ZoTUM1PQFw5wlGL+xI09Nl9BFdX0Hq13w17OYCTZFZGQfl215s8tSX7MlS0+6LduaIWf4XuoyjE7Qd9Qpv07YlXN9Olm+9pNP8V9OQSkJs3zpc5rARwrdBjUPdLMulExjF4yxrjEii6Sj2LHgOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836614; c=relaxed/simple;
	bh=9mRq1p0pLgTGNhGIfitgSlfJ4UQXvmP0XrYiJcBiVkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdifbBmM2UMILB3+oycuSVgSyTh2KSZtMZKspmgGAuYVBefvENDl7rCRLDZTVgZWZyxRqIm32TQzEWJ9pIiLw+NB0W/fbzgasXFVV7/QPsQkRj0aMEokd5Xp2CPA0fUHIKLPvqmfQ4Z59w8LI4RY3TwuiwDvs0UuTkSx4kucLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCElHXFQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2b1cd446fso57185475ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836612; x=1713441412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1QVAQ8Ec97dFYaKzfWqsOpGEEdRtavRl4tq3a62nwo=;
        b=VCElHXFQ/lRWdj5Z42IlpCgUoedI3BNDO6WFGTzSLkxgR+pCacbifNBGZxiVoljd42
         hlK2Sys/u+WmjlClQbX439+qbCaytYHZpRpmq0kaJ8XIxSdn7n05am+Os4X9YEkuzJVB
         Up8kyvWJ671Y89P+VWhvaOHPg0ZStkMcdiyjbn2wO1M2xyU/aIkwSdQ20APTZlWOA9wa
         3EirOYtUSi9uopzwTWwW8mOhwiupDdIB0wxC4BKfqf4Nh+Pvh3mWRO2mSAvAT1eI3G2h
         q4Licv8RuTX3o3rZqbA1t8f61QgtZJFMAIQJqt6ESQyAlrxWS6zkG+yw2cftVEXUYNLM
         RCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836612; x=1713441412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1QVAQ8Ec97dFYaKzfWqsOpGEEdRtavRl4tq3a62nwo=;
        b=t/Nw2LCLNz4imySnN3KTawbrtoDU0ZVE6rGuOJad8mlZKQ+RmdAgSBIXxIPoGj1yYP
         VRS7oEAnE8imTyysmsQEkGBdo0oxcCwztKd8ZRc9/7QjDfTpVkSqXFQ82BYYxujKIjUL
         fyRTUpndBcEvM7MmX4YeMtvMBd36X6NgJx4rHM844xk6mDirLmsW3buRRqd2oxvX2RF2
         Z55oF7K09u+bmf+UGX9eRMdxkIRlNnX7QiLZrKx5BBGAgSlX9ndRi9VkCDTe/uOUjqim
         yHSYoZVK/4nojBJ93w7UoiGX3Ipf9C23ltKt9a+KzVqP45GaMJogi150+U+8LeA+fFam
         JSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvpIDQZWuFyF2ENDiY3Y9kmFguCP7BuLNoadQAInfpj4dfByUf7WusjsH8srPpKog2a4qk/YAJqWd1OqVst3r88wUYddXY
X-Gm-Message-State: AOJu0YwF84FhelsYKMg4bXiC/9UojzqDKPReBB7JXvcEnVHvWI9L283W
	e3EQW86tz7DTNQUyJO39gWL360pw+HHp5WHpKF5GrQTKumCwibor
X-Google-Smtp-Source: AGHT+IH7EHxErU1/GAHQNHNYxxKUfqFIAATsiMAKO+hD+43q0YrVlOqg3mBc9euZ1O6+qvJ7p3u3vQ==
X-Received: by 2002:a17:902:e884:b0:1e5:10e5:b66e with SMTP id w4-20020a170902e88400b001e510e5b66emr4219563plg.27.1712836612326;
        Thu, 11 Apr 2024 04:56:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:56:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/6] Implement reset reason mechanism to detect
Date: Thu, 11 Apr 2024 19:56:24 +0800
Message-Id: <20240411115630.38420-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree


Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  4 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  3 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  5 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 27 ++++++++---
 15 files changed, 207 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


