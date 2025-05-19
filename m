Return-Path: <netdev+bounces-191370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E21ABB34A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9362A7A8B4F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955981EDA1A;
	Mon, 19 May 2025 02:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01LmC/qz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41E1E9B0D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622129; cv=none; b=DnSAjOkzPyItZIDWoRPpo5L8EDh3WV5CYj1mz2+79bZSWSC3jzqZKZ0bjqwA8SzuJzsZS1fxoFaxstrIR2Pvlj7wMDq7Wal/IklRKxsLMrq0ZU4S3g6glxt6Ru9ez4SlOd5uA59eKvYZRHkP8E09WzSO2gxScOYrMSCl/1CCyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622129; c=relaxed/simple;
	bh=mv1hnc/JYcrsYiWob27N35tjryacdBHMn0uTMgSU2F0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a0ie6U+wLUm+KTIXKiebZAcKV3jGIesXHOL7yyANsarnh/hts+EUc3bpl6VXcmAj/tbBJgvxGYeIdXhqgey/5QP7hUElvE3FpzUAwqCEi3vz2QPI0ZZ0Sy1SK2SvSSYQYIViLZZL15pFp9BlP5UQSnsRF1du5iJ96OJQD6MCKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01LmC/qz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742cf6f6a10so655491b3a.1
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622127; x=1748226927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgbVYH77FpbHQz0jo3ZInucxDqpVyDPyOGojAswcD18=;
        b=01LmC/qzQmgA0OPRbG75nu8kKZGDpPtmUhKpXWEFmgwKD3fXToyX2vAor/wc4pHEdz
         ux/u6NPwi4sXacRQL1a4Fc8Qxi9xMu4S1gcTBXvV60h4mo5BVpg1jchWNaByWaRo37OV
         6rdWwPKPdDp13xgYq7dOQrsc5sDizzNG1Uo7rEmVQwIIZQtufHwKaHFW8Gbs5KcYBSB1
         5695azyZoOfPl+qaensLQMqjm/gprTWik7XwQn89A6MSrQvUtgIDVAN25urC9qZ+h5z9
         jeNqCOxv6TgkGytsJi5SFuPSEQq4jKckAJA7IWDie8tH17EuCluG7Tk48Xfqk+m0ikGG
         //dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622127; x=1748226927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgbVYH77FpbHQz0jo3ZInucxDqpVyDPyOGojAswcD18=;
        b=oiMB/fEwd+fYO7kByofS58VBjenFiuzJKqgoUZz7N/oIuc/QB3B8QksYeEMmD+wIoA
         TjitLMTEDuo9zhgHopz5eRes1fXtGxm+2Tg2xKzpezCh8PXMQBj3cZiV3go6OtboetT0
         Or6s5+ubYbM1wAe5ZoEMwuQ+XLZpI4TkftUE1JD5Gn0T14Uc0tT3lsqDctOMu9z8AZyZ
         mwDpjmTmkK7bpJkOO1na4Hh6TzGZWPZ7l3cs1Twqrrg1XPMEfPrYin7cObCc3+ER+IBa
         4KR/rsg6D8YTql/+mbcaomIFQU+w4QMcg5vwRFeFrd8SKRl/2Z+bV1bNVud2RDP96KaS
         mJgg==
X-Gm-Message-State: AOJu0YyW2zPLUAOICXBcrd7esJzVT32qNW0TTyuyE8OwsHBluSIzgpGY
	+HfilMQL7eMzKbMpUmUWON/DBh4mSBJMFfurDLktjliumtoHzedidp9qw7v7TnrzVPc9dTQTw9r
	u9MWVhz9WZ5vyQn4cuQ/y6xVfP1k2pyvLanMHXw0DiG7H37C4u9NWZdGEvtleRH0ONPntWpeZQO
	T7blN+YzYwAUMSBz73HaXYE6kHN7Tue57PKXQO58//7w+zQZ1CMHjaLByNM3bCiKI=
X-Google-Smtp-Source: AGHT+IGYP7gHTQY4VrMBV4Jvp7SIjOwTc4ULH4X27OGkctqn0OJKaDn02AnHC71nkqQCZpE94dyzsqSq6kKMXBhrJg==
X-Received: from pfes20.prod.google.com ([2002:aa7:8d54:0:b0:742:a60b:3336])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:9ddd:0:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-742b3a6dbc0mr10282223b3a.20.1747622127291;
 Sun, 18 May 2025 19:35:27 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:12 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-5-almasrymina@google.com>
Subject: [PATCH net-next v1 4/9] net: devmem: ksft: remove ksft_disruptive
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

As far as I can tell the ksft_disruptive here is unnecessary. These
tests are largerly independent, and when one test fails, it's nice to
know the results from all the other test cases.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 7fc686cf47a2..f5d7809400ea 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -6,7 +6,6 @@ from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ksft_disruptive
 
 
 def require_devmem(cfg):
@@ -19,7 +18,6 @@ def require_devmem(cfg):
         raise KsftSkipEx("Test requires devmem support")
 
 
-@ksft_disruptive
 def check_rx(cfg) -> None:
     cfg.require_ipver("6")
     require_devmem(cfg)
@@ -34,7 +32,6 @@ def check_rx(cfg) -> None:
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
 
-@ksft_disruptive
 def check_tx(cfg) -> None:
     cfg.require_ipver("6")
     require_devmem(cfg)
-- 
2.49.0.1101.gccaa498523-goog


