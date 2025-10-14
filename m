Return-Path: <netdev+bounces-229335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8457FBDAC0A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA41E403215
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A1302156;
	Tue, 14 Oct 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3R28665"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E818C03F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462353; cv=none; b=oqhB86XMfrVwOyG3LIhrCudi/JSBl3sJJgcdWLiKl6ltY1jldgnZAN8kndfa5JbT2+xVemEXbTWByCVPBZmluHApVLv/cO2c6uF2oscdxUswU3pM0QoTym0EXSjAxc189L5TRFmD8mHBsQ6o+ywTQRPmlifhBjP6Sgv37Upi0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462353; c=relaxed/simple;
	bh=ZIXd6oVr1B8awakvZCqRo9PRNUzEdEVvjUh8upQ2Fz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DJzJ7qyHLZNXwSYhaznTOf5/b/BXVW/QPNWJaw4Rkk4dYCQiL3Qu5s2trn3UBo77ddKOCFlDZ6Zb5ZBFvlXyOt2zqobI2lvcKbZ3kCBLvQe+JB6YTWq/xIQM6+lidUp0QHul3Zq09AnM8dZDacpfObbnyo6nFOZEM/1rAVpMc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V3R28665; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-87a0e9be970so350485636d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462351; x=1761067151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OR4scqi0YzRO67X0wTkH7zsJNHHDlLwUhwwEJsp7nOk=;
        b=V3R28665GhzyYa/nz3qP0UXdPlA3ewCCTUDFEwqCvngFykCtXQi3MUJaBJjLKrgqfz
         MdPTp4Oow56Z8n5ddW6cr2fl62mqQ/hjIBJd7cfjZHRYMab1V16Ke0u/1HZ4bD7zDWgw
         A7dTK370jRMNzG/VN0RDQKxRPObiDhaOTubgoX7Sb1QSOD8zz6+O1KDldGpCx/Ph2WVn
         MIKXT8O9j1c+f8XbG/kiVSItoSC3ncbvTPV7rUreROLuJJWvPdt/b8NyQJBJO7c9QTM2
         B60h958PXaxbEAJXwAKVt9+oaEf1I7dHObZg/EQxzTxgD4iMVUbmGSWs2Hdqu5BIMgkt
         ZZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462351; x=1761067151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OR4scqi0YzRO67X0wTkH7zsJNHHDlLwUhwwEJsp7nOk=;
        b=YuO9ypRURm8mGiinIoPxNP8ogYtZzLCODm9KQ1C8WHVft6F8oWOBhUpEr/QXexi111
         cL0UqaQ9UTrqcKIcnn5YbgGx159ijUGEe+26SWK1cKHORi3lds/b53dIdxpF3qYMUET5
         bcFj+MTfHaciRi6+2fP7vONsE3i7S6YKH5o6HvpKtCo9COe/9AUuMkYjrurkL9Toqir6
         99Zd17ZDNELZv1TI/5NtDoWVc3vStoEwjMPILR6mxDZdWZU3Q1hjqOiwqYbK+4opNs0E
         vz7/U1HuFk6OjtIQqV8gkhkXEqb9KdCcnUI2EzuuxLuWUKCwMzBBG9alwytqn3geQBxC
         rLEw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnhC8uOfKI60MtFXvBaK9Qi23B+C7vrUVTii5goJ0P6s3sCxeYDx22daf5ofFy9SdogY29xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+22zA+e3dZTNh9eXJQ3LQnFhDgEPdbQLk3WZx4TKrKDD7FiAd
	bb/011Xuv8D8FegE1cOYHpXPqlAZeFwpmPjw6End0vXcU+sWigku7LNsSnDnYa1cf0PvjUtG8bu
	xha1+Fha7brek0A==
X-Google-Smtp-Source: AGHT+IHKbS0CQZ8uIgPjIv4QHyQ7gjFEFWRc4htbPS4bMt1m4vsPK4ysi+TWi0X/P39OKyyscTj0XAfAWqX3Og==
X-Received: from qvbrb4.prod.google.com ([2002:a05:6214:4e04:b0:786:c15:f4c7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c45:0:b0:7ff:7b64:840c with SMTP id 6a1803df08f44-87b2ef1d9a5mr312056316d6.41.1760462351016;
 Tue, 14 Oct 2025 10:19:11 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:02 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/6] selftests/net: packetdrill: unflake tcp_user_timeout_user-timeout-probe.pkt
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Soham Chakradeo <sohamch@google.com>
Content-Type: text/plain; charset="UTF-8"

This test fails the first time I am running it after a fresh virtme-ng boot.

tcp_user_timeout_user-timeout-probe.pkt:33: runtime error in write call: Expected result -1 but got 24 with errno 2 (No such file or directory)

Tweaks the timings a bit, to reduce flakiness.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Soham Chakradeo <sohamch@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 .../net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
index 183051ba0cae..6882b8240a8a 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_user_timeout_user-timeout-probe.pkt
@@ -23,14 +23,16 @@
 
 // install a qdisc dropping all packets
    +0 `tc qdisc delete dev tun0 root 2>/dev/null ; tc qdisc add dev tun0 root pfifo limit 0`
+
    +0 write(4, ..., 24) = 24
    // When qdisc is congested we retry every 500ms
    // (TCP_RESOURCE_PROBE_INTERVAL) and therefore
    // we retry 6 times before hitting 3s timeout.
    // First verify that the connection is alive:
-+3.250 write(4, ..., 24) = 24
++3 write(4, ..., 24) = 24
+
    // Now verify that shortly after that the socket is dead:
- +.100 write(4, ..., 24) = -1 ETIMEDOUT (Connection timed out)
++1 write(4, ..., 24) = -1 ETIMEDOUT (Connection timed out)
 
    +0 %{ assert tcpi_probes == 6, tcpi_probes; \
          assert tcpi_backoff == 0, tcpi_backoff }%
-- 
2.51.0.788.g6d19910ace-goog


