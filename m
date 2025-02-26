Return-Path: <netdev+bounces-169975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B5A46B01
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5583B0C26
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF39239565;
	Wed, 26 Feb 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzm/OXZ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D2239588
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598109; cv=none; b=HMnLSXHOKA8uVI6THBuL1ulZ+1IrNOVLipAX1QAjHG+pKAjQO/5IC8X/zqzicMq07fl8UaX4avTxFu2HeSHrNnM0lC5/J3nHlhnTjHPRxwHZrvd1HlP2G/tkoVRp+2+4Q/5xABbIhBMw7K1fyXegN/JXJdE6m1lITpM1uD0jhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598109; c=relaxed/simple;
	bh=tmN5JwTaZ421JUVQTXr4tJNOy/0VgsWNPYovSN2FDSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDqDtdyic7ZSYdo6ijO+6+pSaGy/oZDz1la5WQ4d7go4vkg8JrUhlhKJdZ68+IEMKR62Lx24dbYPzAixOYML56CS1WfcS9smSs3Jp0/1u99mYfkUkc93Eclmy/7uNft/pnHCF4xemXeLKPvNLP7l2r1vZW3YYuAFXEbUMY/O7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzm/OXZ+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--krakauer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so373970a91.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740598106; x=1741202906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=Pzm/OXZ+TgUygYunrr38Ff4cgRZlJiJiNBJm79oEzx/i9MN5qv0SyOepDmYspAIIWV
         DFkLy2p9aKgT2LaFlnVpwOaUCbLWO5BpwFQj0mnHjQmalnKuk0+ECQiHFx6jlSV0nEvK
         0WlOxUAKfJQFoYxY3KYtTreUK0Nb+D+xqO4HvAjPCrhq/nUMziPUUn1gks6AwU3d2RGY
         eIFtLF/GXT/yYeGzTTwjXnoLcoP+0hpYlJMPcaEjAz/DDTJYA0RVRVDHbk1tnDOTiDcg
         AT7o1vx1+0V35NKKGp4RQR7jyLF8+NBuz4e1bu0yor8wHTUuqxHHdJcbvb0P/68hDArA
         WEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740598106; x=1741202906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfKyFrAiD8h/LnMC+tGogS6xsvZrTTIIDx60NZVpyZE=;
        b=nWVD5ViFUzMf6vvclZyyaqgN0PomtxbI1KlcXIWNxhWIH7jzCbXQWYcLrlwp7UU/gn
         AGutyKiwV4FhkiEVF5Lb68lFBMFNxmBU7by4hsd/53Y/OR1iqrEgxNPYtYfcdKHmUX5R
         bN8NUsht2j13ZvZqYdHT063qNtpUOGOAlm6seT6YicZZXIfsMPfNXyEm692d5TQzJZwh
         dfyb1Vh0Fi0hs9DOGnuK+Rl4PAcDJMakaHot4K3MS3RVKFBQloIZZ6oJ3BrG7sG+audt
         IT+C2rW+BvzWAODLwDdg8Fr8ALOt9frcvHXtB1mFoyX55BV/RWClRxptM2P2/dAg1TnY
         SoIg==
X-Gm-Message-State: AOJu0Yw45NWzgnGIaOPIuzsF9OX8mSecfwRzITvc3fV95whaaPyNU7PJ
	rsLEo0Awp2EZuTVWWNV+9V6mrrRpTs/iGTTl4lSjWF0BDjGBo2/e7suT+f8kkJywfa7pcZJA+Z3
	zVCb4jk5873bIn5pqbKe5v8bhdVevklRhuRm3MQSz0XLp5psIq46DgJhY1465PDlNWW4YLJlRae
	Picd80/ovhHK/Eb3J2kqw5Q9fUKPF8G8PyvIwb903Mlw==
X-Google-Smtp-Source: AGHT+IH6eAP4Cyst+V85LJmLhx2Rg1bDfnJ+WmNbTdbRluW4pkEzVr68R+e3txlLoA5Mp3lBArRubTvC02kHFg==
X-Received: from pjbtc16.prod.google.com ([2002:a17:90b:5410:b0:2f7:d453:e587])
 (user=krakauer job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5243:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2fe68ada3e8mr15762000a91.12.1740598106543;
 Wed, 26 Feb 2025 11:28:26 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:23 -0800
In-Reply-To: <20250226192725.621969-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226192725.621969-1-krakauer@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226192725.621969-2-krakauer@google.com>
Subject: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct exit code
From: Kevin Krakauer <krakauer@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Kevin Krakauer <krakauer@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 02c21ff4ca81..aabd6e5480b8 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.48.1.658.g4767266eb4-goog


