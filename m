Return-Path: <netdev+bounces-68853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447548488A4
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0928285695
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057A5D46B;
	Sat,  3 Feb 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoVQJ02/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDD5FDBC
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990605; cv=none; b=riflbZpik6E9in1AQn1yzjZ6Cvq86e2Ua86Wecu+3171/cwboDR/x/PJBTlYDkuXHRfnuP2Et+1qfBpkTolwVNl/KC7cJ0Rz7m7H1SNtzrCPSrMvLZtwS6wnkdVw3hJ/Lgxt5LJZ338tkKyze8f6/guREYKmrgvf6lzRfZrdjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990605; c=relaxed/simple;
	bh=IFAJJp/U2qj1Ev3mP9hqjqlp0exsVspYUPzSe7wv9To=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoiCvs5CB9gnRFTElD6YCb1QXOl7rEfw7/4bGPOTqR9Qv618wrE+miEp3+/N3pEuIKrHOyrjy58/b/aCPwcU2peQxWuR3IsAs+0hMpnBuI6tWD6SMY9MkooSFlgQv+VF7EAo0CwMq7QXPMheJji2OziqguRtShoEPw4X0B7wy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoVQJ02/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so2400546f8f.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706990602; x=1707595402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWKSdqZXEg458XYloVfdLWl1eCWooBzklK2j68WLOA4=;
        b=YoVQJ02/Bx113izcK55GFymlAfcMNG6pgyEw01+yX2v/ftkuJlOyjc4FYBN5ahaYHb
         jNa0U3xJvcaGVRxo6KdhTsy7egQ6pNau+UdKq2FQIEhI9kHZN1F4y9AQlBOxz4VXT11n
         dDuQZOTVlMbdpEOlYHomeXd2agQS59UpUZTtYEM9vou5MFn/MRsoKD/TMnjGAPph6WI/
         ROggJxBg6evg9U+KUzHsZkdz+AjlDz5aaUVnLsZFbCKZi8HXCHHhtgEnAwrblBMp3Y7a
         cg+dCUDoZ3eLRQ4RsuHLFJWojjqrB+tG3WEY1KNCv9j5VrCE8OjuBs7/iaJDCeDQnEv2
         HaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706990602; x=1707595402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWKSdqZXEg458XYloVfdLWl1eCWooBzklK2j68WLOA4=;
        b=AUTuo90BdVvs5Mb4nDcE3MgwRR2L+6+jZbQ5NXxMgoawMpdz30IUFdyDsjK98NtEUf
         ZDOM9xxsiLzZonMcnvhMkYghv3tFhc/TRfnGx2OpQwgg+Z7D+s/m1UBZ3X5GB+q75cXM
         XpYIpXK4AF86OpYQMOKFiuXbjmLCJyGsH0Y+Mua9vCHuHoR5Uh+OAtng9hRiFZz/m9H1
         SJqPo0xSMA3QCs5PTUBxWoge/DIoSAIpTQG3HWsoictKDB/5tlHFa/PVpSycgwfxO8W1
         Zg2p7/k+LAo7Qm5UT9t+Hx2qc6xlx/9Bxah62Dw4z84xiLM5iaKB2WASbbBhOzLHX7/A
         ayRQ==
X-Gm-Message-State: AOJu0YwAQeztXy+m4X7yYJK525j0QMPhEUT8mrJHnY3XNtYT5bO9co+0
	+g6S5CeTvUtE+EBL06+Fv/o4MQBaUWaHF/6mD896YO5gfTxpmVshQGfPXiRvfoc=
X-Google-Smtp-Source: AGHT+IFHycM5dJsAIPvbKF0fAMzGTfe0wSbrHncjaDVOn5lwhsIrv+iMagrXfZg4Ral6eCXFeWuqrA==
X-Received: by 2002:adf:a45d:0:b0:33a:e6f0:ee05 with SMTP id e29-20020adfa45d000000b0033ae6f0ee05mr5675881wra.45.1706990601792;
        Sat, 03 Feb 2024 12:03:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZZBd5+VF/PqVfPKLzik7JNCdZVkJuHOhRrUU223LHBicZd5crTgO7wFbs5x6NzXfKWPtD3AGV71sw5kXlce6pV0tJsG1/V3Ar/y1NKtIQcAeje67WeSKnt6Pg83K2ag==
Received: from lenovo-lap.localdomain (109-186-141-116.bb.netvision.net.il. [109.186.141.116])
        by smtp.googlemail.com with ESMTPSA id x9-20020adff649000000b0033947d7651asm4651124wrp.5.2024.02.03.12.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 12:03:21 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add missing stats command to usage
Date: Sat,  3 Feb 2024 22:03:05 +0200
Message-Id: <20240203200305.697-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stats command was added in 54d82b0699a0 ("ip: Add a new family of
commands, "stats""), but wasn't included in the subcommand list in the
help usage.
Add it in the right position alphabetically.

Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ip.c b/ip/ip.c
index 39bea69b7137..9e81248ff7f0 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -64,7 +64,7 @@ static void usage(void)
 		"where  OBJECT := { address | addrlabel | fou | help | ila | ioam | l2tp | link |\n"
 		"                   macsec | maddress | monitor | mptcp | mroute | mrule |\n"
 		"                   neighbor | neighbour | netconf | netns | nexthop | ntable |\n"
-		"                   ntbl | route | rule | sr | tap | tcpmetrics |\n"
+		"                   ntbl | route | rule | sr | stats | tap | tcpmetrics |\n"
 		"                   token | tunnel | tuntap | vrf | xfrm }\n"
 		"       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |\n"
 		"                    -h[uman-readable] | -iec | -j[son] | -p[retty] |\n"
-- 
2.34.1


