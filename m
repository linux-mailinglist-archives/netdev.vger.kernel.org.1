Return-Path: <netdev+bounces-198202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF5ADB928
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE67F17402F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240D28A1DB;
	Mon, 16 Jun 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xnfXcxrh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213F204C1A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100104; cv=none; b=VaoE8fcSZJKVx5kz6V4Z+LlFIyW/4S9/xqqaMbk0ZHrJTPf3ZNGytKSonIi7321J6q7r1tpXOJ3UPNKwjKabxr1qd7tgx+ILxxTI2fc9Z9lLUs86qiiSeQaXvCXFc16zTR09KNzJYPkdFFiCx0H12TyBXap6Iu3Fmk/x7SZlxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100104; c=relaxed/simple;
	bh=Rn/7wRmGcAxzDqeisQ+LfcxOtH7Pz0HzM0OYTlth4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LglrQsEJ35y208MUAufHRiY46bGN4I1Z9BpBnZcaMV+HG+ppk7fDHp04hzEwSkVu7JhzhQD0Jn2vLd+FvOEoM3+DMVJWPXmwYv7ltfl7jV5iJQXddf7CXf0n9GdtXtC5I64czWm6FV9n4ex2FK0+gyjC1JKnYQLYxqIbrV6KN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xnfXcxrh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748a42f718aso1717469b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750100102; x=1750704902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx81n7Pha/SR/jETIz5Pw/KIFtPSohKv2m9Lgpv8CxU=;
        b=xnfXcxrh8jhPcE7C3QNByJVALfdP/HuTPVkK7u0aefN4fRFpDof2uyJRGq7ehyJ12D
         /RZAcHEiZdhRX3dnFNqQJ9J0IMiawIuIBw/bTlEEtFLqy4exSsm+syH1ZMZg31/WTC9I
         lgEosNVPeoE7hjgRxj+HBthGM/1LtK6RSr6Ue7H1oBFyyMGc3HYKyVfjlWfzyn8iweb0
         DlRbODcxBmpr6FlBMXIa6k+hPFlPJjpFZ9KKQ9DbQPvtZ8sJ8J8FQEtishGk7u2xTxCa
         1k9aKF9HpTeAKNiLk1xeSlLXWuMXBkHKDoQFsLLvFVbFZIuttEB2yK/6YYgigCWMfwTE
         pZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100102; x=1750704902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx81n7Pha/SR/jETIz5Pw/KIFtPSohKv2m9Lgpv8CxU=;
        b=JAyb67o11AW+Hw7NuWYNqjomZgiVXDbVoOJpGTyG/qK2XKGvIafIXDnwus+Q11jlo6
         R/3VzLJ9XqfL7lD4w3GYRnJ31d9aCc/jGPhuf/4Y5SELcx//gRadvqBwd+S9qOL/bMjp
         zf8zzyRAEEPuxMAJ8Ss4lHox8q72XuAeo4vRc5QeFdYfZ2gAoTvKN3OYj0lPrSpD+ps/
         zCX1F+uFIg2Uc+vnJIBWfnnhlNgm6tZMgvUfmv7wlhRXb513KGM6sPNJuRsg4E8ldycw
         lSdcHgDO258EnBU0jrUfTzab7Pzd/I+oqy6VdDb6COuXb1jz6P5tVb4x5OCnYQWpdRMH
         RlFg==
X-Gm-Message-State: AOJu0YyTNtvU5DYgdCEsQpZghjKu0dIpk11PEpvkefISuAxDXlXF8zgG
	f0Ln7P8TnAKLJkBOnqY92XgIb3wFpK94rNOD8rRbMgDexGigc6rV3l42IkoO+g1QiAkVh5hASy8
	6w9sM
X-Gm-Gg: ASbGnctApvrxI+cQI+44pV1IQI9oEFSx4xDDtLQhAtxDelZYMyXJ8jLuqC+mjfzC+Vg
	5dOmZ3qmcbJkvU1MId9nWvYnQP3FkA8OGAhfZq7N2Iy074pEsVNgwkrXie78UetAlY0OROScbhF
	yqw7spKRpiZFrKIcxzGbn8Cddp2WkRe/k3msEjOpXvpnGhEktwcviPVCF+cDkhrxew2JCUkh8Ci
	6kucdWxZm3FxbzwXMZ3bmNrTkFl4kOSnRwGYfJyvnN8FzPaidq23DeIABCNZ1A5sjDzMXCq7kQX
	e75u1BLhP5saDkvZ3En5Z+YEXyCCIpvBREJW3bnwGOhaer0=
X-Google-Smtp-Source: AGHT+IHRlsZnkjevup/hk1ceHV2FZkLVUYgnTw6UkBHNGi16boeOmFKJEEW9x1UzQqLP1jhWVHjmMg==
X-Received: by 2002:a05:6a00:3990:b0:746:26fe:8cdf with SMTP id d2e1a72fcca58-7489cf72666mr14856387b3a.7.1750100102438;
        Mon, 16 Jun 2025 11:55:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ad24csm7451015b3a.109.2025.06.16.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:55:02 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid NAPI ID
Date: Mon, 16 Jun 2025 11:54:56 -0700
Message-ID: <20250616185456.2644238-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616185456.2644238-1-dw@davidwei.uk>
References: <20250616185456.2644238-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug with passive TFO sockets returning an invalid NAPI ID 0
from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
receive relies on a correct NAPI ID to process sockets on the right
queue.

Fix by adding a skb_mark_napi_id().

Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/ipv4/tcp_fastopen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 9b83d639b5ac..d0ed1779861b 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -3,6 +3,7 @@
 #include <linux/tcp.h>
 #include <linux/rcupdate.h>
 #include <net/tcp.h>
+#include <net/busy_poll.h>
 
 void tcp_fastopen_init_key_once(struct net *net)
 {
@@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	refcount_set(&req->rsk_refcnt, 2);
 
+	sk_mark_napi_id(child, skb);
+
 	/* Now finish processing the fastopen child socket. */
 	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
 
-- 
2.47.1


