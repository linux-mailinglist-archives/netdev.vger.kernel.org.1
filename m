Return-Path: <netdev+bounces-103255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACF9074D1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D16282E37
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56628145B0F;
	Thu, 13 Jun 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDeORXqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B247613D63D
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287967; cv=none; b=K7YEF3eTWKP106BftK3d+YgNK9DS67Dv3uibaekOzdk0pXPkhOk55L2k+vsCGtav55NUolfHEtelgOKcEkfZkK/83rfsASkQWHlDsHah5iB2VxFT3zWpT1HiGERa0CckuW1KALC5KJBKPyXlTpOo9KrjI9aAUnuWYANXfNd4Xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287967; c=relaxed/simple;
	bh=6T6lKFPe7/sI9JEcUTsxkCEW05GYtKDvK2CICycaEd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iu1v8UmOlgqhLPOQq6DXOfDLW7OkrF/wdA38dohoq1AxvV1lXYfh0CKl4wVzmOYjS4Ka/4x/ppqNXK47ZWHzkIVzD2GPjmSedvoi+zaUmU02/Ei67xnw1u2cBiTQYR/sn5rVnn/778Q92f36pcHmmPGpcwjVmXA7qXnJn3c4TzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDeORXqS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6302067d548so19676787b3.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718287964; x=1718892764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+c85gVjYqcsvNJhPW6cD+lrlo7sHtAPWN2WNkaB9hI=;
        b=mDeORXqSTlemEHbLC7BED2Cmwx36N0QxZjA8Iieu0Fnn12wdh0AQbSV3TKjb1Fi2Xm
         Dzwzb+wdTBnPtpqcrVU0+/jGjrmMXKrHr+yx7l67bYejI3o453Rjur304NPi/sTMTz6X
         8zlXNjAXOnW8GQr49WtozNJWPDCzSRfvvnMlXzUR/pMsnleJm0jOGzyaJnILil6DL0NW
         z4RNES/1gRFcLlm0mfbIY3QOj//DZrw7HrMxk3HFmD3LusobMxzWB7n1v95Vp4uR/TtG
         ksGR49zfRrpL8glMsyn1PwwM8P2TdVWLMpuVG8r/smt78cj7UYwqVsIfr2RblCjF9kzH
         yaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287964; x=1718892764;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+c85gVjYqcsvNJhPW6cD+lrlo7sHtAPWN2WNkaB9hI=;
        b=Mqyz2TnOGC2p+MfSQ/sHEq0QoyDZyFuyd/6biThkCHI3kcpMuEzEvq/eYMyO2YdH72
         +g9XpjXzAYDOBBTtFON6GFNGfS38Vq3ISahSHcihA6N+Jys6h8uVumGmYomXS6tOfGaq
         Z7jtHZilOKttzycrTsYFYlTD3/ti6TO9YzdK5Pmjvp0VNVA7OwFcqzQcPzm4dLw3GSRj
         qllicdubRAHASgsIO0CYqraY2Ujix/V4eA38kk0teBUvQSUBg6kPOviVfElcTJvk4MZf
         kfgM+WHrZ36uUbDK2EinU9CKXEFRjoAGBmNafRD9blTrcbQrSY5Q4G4NthJrr2NKccW8
         PKFQ==
X-Gm-Message-State: AOJu0Yy8xzVgF4U03tT/nsRHm81OzWaWn52pWhV+nprGQHG/CxmIUZkJ
	50fCY+kfI7nmAY53i2SR4jODPpPRnzS/Tnqqms1xYT4zxeKfuOAVxgHL8PNwwyU0uBiCLQ==
X-Google-Smtp-Source: AGHT+IHc6XdUiJashgkfrFpeukxl2Xey/sE7QJy2a+awAsq+QKx8p0xrsKF+nNQoDrnAM/oNX9OiNqRn
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:39d0:ab84:9864:b0c6])
 (user=maze job=sendgmr) by 2002:a05:690c:296:b0:61a:bfc8:64ce with SMTP id
 00721157ae682-62fbbbec0a4mr10530217b3.8.1718287964577; Thu, 13 Jun 2024
 07:12:44 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:12:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613141240.2122771-1-maze@google.com>
Subject: [PATCH net] net: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GET(RULE|ROUTE)
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

without this Android's net test, available at:
  https://cs.android.com/android/platform/superproject/main/+/main:kernel/t=
ests/net/test/
run via:
  /...aosp-tests.../net/test/run_net_test.sh --builder multinetwork_test.py
fails with:
  TypeError: NLMsgHdr requires a bytes object of length 16, got 4

Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_dump=
_ifinfo()")
Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_if=
addr()")
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 net/core/fib_rules.c | 2 +-
 net/ipv6/route.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 6ebffbc63236..6229a8947889 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1294,7 +1294,7 @@ static int __init fib_rules_init(void)
 	rtnl_register(PF_UNSPEC, RTM_NEWRULE, fib_nl_newrule, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELRULE, fib_nl_delrule, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_GETRULE, NULL, fib_nl_dumprule,
-		      RTNL_FLAG_DUMP_UNLOCKED);
+		      RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
=20
 	err =3D register_pernet_subsys(&fib_rules_net_ops);
 	if (err < 0)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f083d9faba6b..1558687c2894 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6736,7 +6736,7 @@ int __init ip6_route_init(void)
=20
 	ret =3D rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE,
 				   inet6_rtm_getroute, NULL,
-				   RTNL_FLAG_DOIT_UNLOCKED);
+				   RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
 	if (ret < 0)
 		goto out_register_late_subsys;
=20
--=20
2.45.2.505.gda0bf45e8d-goog


