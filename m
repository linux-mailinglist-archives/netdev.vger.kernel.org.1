Return-Path: <netdev+bounces-240212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19DC7186E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 059944E2DF6
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2E1D8E10;
	Thu, 20 Nov 2025 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDyG4RTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB181B4138
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597736; cv=none; b=iyazQ21IQd+eQCQNGiEy13BiI/atKZCeVp73IpmlBLafnxEExD6b0MhaJCYB9X1SZsIHLOV5jrNLNiUsXxbJbtlwptlYEr7WV91Vk5+7C3ublG4XMI6au7W52Y4AMiUCp35oglmhkNviELw7hL4MIy/5upCzaBiD2bjaMYdpbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597736; c=relaxed/simple;
	bh=OJ5QWhtiskGythM7vc6Jd6M853ak+vqQdxx02P1aSSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zt/R8ziZRKx0sGQrDxGZxjnyM9l9SMR/0smW7LT6i59oeCvzeJVQ8VXrWZUUopMfOQsWw0mk55GOtOVPuCqPiuGAkkL/BMMHNcczRAvHi6dQI9jwWhJVtj+V6BE83wv5ydMhk+mo5zMhH27ub6iX8ADEkSYpBt05oD4ra59Bdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDyG4RTk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso331255e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597732; x=1764202532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SayxfPvE/g0bojag9Jh1IjbEk4cTOITTJ9rniJCmzdw=;
        b=MDyG4RTkla1NVM2/ZkWxecCIwg68QHNaq5SRT2t3FXNxMMC92WvTSSGn1hgcz68pCl
         7q1tmID5BPsVDC8Dy6yG9tdClOV+c6LjwNAr4DkSyCr1arey10jrRVcASfJAMNh3YLed
         VwWFVph2PH6I7BWQZDmQhWYT9/vWS3kBE0q5c/sagrGv+WJc5h98bW7MlYBmN9PDAR+C
         /2NkFmgdlIKPfLv7HgZqaYjMK4FcpB7kKC9JEfzx5WaXRLhhnCIE9H+rZwlM90LceYvh
         42aCqzSrAwxG30cp1dzNFiHlJpgHtbMcHGSmyVVGdj5HAJlwFsug/ZE1CoAL88FEFEIJ
         Kfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597732; x=1764202532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SayxfPvE/g0bojag9Jh1IjbEk4cTOITTJ9rniJCmzdw=;
        b=ElLi+5QKtVhsfadWgpZqecXVRiC+33ZhFgdX+3nXdNSRlpirdFxuIha8SCF4FEvp6h
         GfCM18MPkiyeGbxoEWHOez+xTHO8Z1tCutxBTjSmq4muTExppUui5rThdriVs9isysWa
         fxE2ZSrGlXl+JXeYebH6kBwCeBpc6O22wMgxr+mj6V3XYomB0rQ2vx7K3eETaWQgpq7/
         cLeuctZWt4InCzsJnI+0tX3478rdFVs5Wg2rzAn5DPvOKLEcqnUH7aBKzpqazPrOgdsL
         8zC8isQXwu47FPsSxPnBozJwHdR9t530gcd0aAHMofBF6r/2oWUCJBUyMJSrj9zJ8PMR
         DrpA==
X-Gm-Message-State: AOJu0YyTTETwCajjA5SzqConBq8aw+NAvDbOxr4n0Ti6pBWQxZ+KfgZL
	YWcm/M7S3h7lv4Vdhqe+tPiSUR3QaOhPZceKbkLpXSvYXGMBxGlovPB2
X-Gm-Gg: ASbGncv3zpJZ4kkH8kaLeHT7p5AW04shvweMYlHAouzvjtAx2u1Vgc6c+sFOKH9Z4Py
	Q22frpJymM/KQSWphbg8MdMcj6q/AIeexBthsHfFSkfViqxWiRMIzmhZ5hENfXTaa2RRq8qalKi
	/6p4SNiBNE4yZJbCSng/xjcdPe9tKS4MBnDYto3AaWm7KVT29rBM+hAxL2gzWg3jaLiUMUbqwbD
	mZmnMoGPS7m8GC/43G3GTaYyLgZKjnCgI1kCDmZG5St4ZCLHKcGvI2aHi1TrGhuFgMQmBOmo4yq
	6dNQJ5QQwyfbmA5LXeUgo/SIbDOqahJvgC2Q5apa1DDxFwIr1ZV8Y+yMIpOW59FLs+gEhrpsjAH
	JlC5uFWUSxgWOzqEQb5+FTJ8bWGGWskDK9ApespJINJN+1hvA060Cjx2frup2emq8jwOA1VxvLU
	WCttJ84POrIqF+nn1GKaTCHn56ZLbgwhMIHqhd9w==
X-Google-Smtp-Source: AGHT+IEzBZnPtD+MWg+C98wu/ohpL3j6Un+ABjFCUid0HHBT6AkRjqh+tjh65yJWqV45+5XdzYdJ2Q==
X-Received: by 2002:a5d:584f:0:b0:429:bc3b:499d with SMTP id ffacd0b85a97d-42cb9a6a91emr262740f8f.6.1763597732189;
        Wed, 19 Nov 2025 16:15:32 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e574sm1897907f8f.3.2025.11.19.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:31 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 16:14:52 -0800
Subject: [PATCH net-next v3 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netconsole_dynamic_extradata-v3-4-497ac3191707@meta.com>
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
In-Reply-To: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
buffer is allocated dynamically.

The previous limit of 16 was necessary because the buffer was statically
allocated for all targets. With dynamic allocation, we can support more
entries without wasting memory on targets that don't use userdata.

This allows users to attach more metadata to their netconsole messages,
which is useful for complex debugging and logging scenarios.

Also update the testcase accordingly.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c                                | 2 +-
 tools/testing/selftests/drivers/net/netcons_overflow.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0b350f82d9156..9cb4dfc242f5f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a24..06089643b7716 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -15,7 +15,7 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
-MAX_USERDATA_ITEMS=16
+MAX_USERDATA_ITEMS=256
 
 # Function to create userdata entries
 function create_userdata_max_entries() {

-- 
2.47.3


