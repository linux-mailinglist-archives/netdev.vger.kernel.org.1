Return-Path: <netdev+bounces-70388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F1184EB34
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0D01F22FB2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8324F602;
	Thu,  8 Feb 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6m6tNLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315484F21E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430044; cv=none; b=GFQ+J5c0zD+KO4dwpTL2RSaHpu20Q22AnepsyocSKGicE9jf18xVP8Uq1WTsaf7Nr2gLq8RzExj8HT38nhgM4Q5x+4lhnJ5KL0Nuh6QoWT1mK4/JT4UPhcPXpItlyeHRFBxgHxsXXdQ+9qI9OV3z1q2myskytGDlVU/VyGAKUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430044; c=relaxed/simple;
	bh=Zb0KvqSVUFD6trhqRy7c97PHe4hgPnMtl+lYemNh+DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOsDfDKZKJm8laPWAYX2oDB3rC5mwOiPrlEyJjBxYgpSmnOWFsfUIEdcXK/rbAjZDSG2eSC9ILO4IzolPeHXD+uPSHRSxN8dkmlhRq9N/c1GZaKpIi1iG+U7ieBLCyC7+1KYcePl6/PUNB71ipXmm3r3SlhSmOAcVW+LCmInUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6m6tNLa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6047a616bfeso3764477b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430041; x=1708034841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=B6m6tNLadn/gOivfV/JBYpEeZr7wMdcS1KQqY+Rt24LMKCNFLX1ca1kuHlTryyZZIi
         8pH78igj7z1yftQ2Ofv6U3tlr0FEWhAxQYJ0BSYzkBB5QqQLI2NY+woWtTEFn0ZfAg4V
         v+0clDlrgQo0kWzUUBU7BzyErPOE+QSPoaRnKCNW1dQMqskHDBNpHyxq9ZkFfLhrT8SR
         ewahJqp+TtKkRmjmUEAXzNJISTeqEx7UGaWMlFiYHHzDzifNbY1qcuaoZPDVwQyySGRQ
         7XZqw4kcRrZzDoMHaPNncmx6FbGndxk/kmCpl4ol1xIlAXF7wwykzMXft7HANAoR9dt1
         AwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430041; x=1708034841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=UQ+WLP7BIJIKn3ZqX9Wqajsm3eHp4Rxl8nUcMISgX+QRNcXB/An2nCo6zKje17rFJT
         uMmjIlmnXB0AaUUPTQ109KcbJwEeCFg8PC9PEvY0Kf6/bhqXWQM9etEkFCmQpzprwwYL
         i54ed8325wXL6AZyiSixjqPilXj2HyG+X6tVI+s3GWF13zcGjVrl97m4ieF4xI07CcX6
         A1QfbliuoPYCnJxo33hPTdiQzyusPz/0zAKkhoqxw+mYC0hAB6fRzdnFGp2UQ5HYrYXO
         0pcbBPkHR6xgFzUtF/W6tzJwDzA92UhlKty83TeAkjy74aYYhLihK5XCeZOPqiuWtIp5
         aD5A==
X-Gm-Message-State: AOJu0YwcF7kM8xY6klguoSb5GVj7vmSRDAaWmtciM0DmJXnePVhE/SoM
	UJbN6Ic3VUBB79/4PVfZoRgdih/4LmVoE8Gj5KDLzYBt42E8GyelhouYI9DznJo=
X-Google-Smtp-Source: AGHT+IE4CHizE6bl/TPYpnwhMCbexjw/nj2L8uKN0qMkFlg2m8xFJUOyvS48AB7l+HkHluMWND1XhQ==
X-Received: by 2002:a81:6ec6:0:b0:604:5be:7163 with SMTP id j189-20020a816ec6000000b0060405be7163mr686639ywc.41.1707430041528;
        Thu, 08 Feb 2024 14:07:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3KT94QkrJkZouOoc6aZBi0QWKni6NOQApIHs41mMgwMs2w/WRV///rq+kT70aD1J7Ktfz8cqgRuclhh1nlqiRTRdg1zdcsTuw6GQOb/tsSd0LfpBXBbXERaU2qDMnnxNc4ZTvOtv7G3EiNthXx67c6OojuFAq6iV0Z0xWcgcmC32jheh031wYKPVH9MPCCT0zRZsM41iiILiYgkK5MXLMXNGh4tCey3YTnMaJQKSzh19srGCAGqt6PmPDP8dwrkeFW5v1ldePkVrlrqnv5ZaSV6nH3KqKMKvmBIJutw3n7+4eisA1lW24LfUs+AU2VfcQuxX0+ZFS9tDnLEoZANvsbOV1Vkq0eBcYsQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:21 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v6 2/5] net/ipv6: Remove unnecessary clean.
Date: Thu,  8 Feb 2024 14:06:50 -0800
Message-Id: <20240208220653.374773-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The route here is newly created. It is unnecessary to call
fib6_clean_expires() on it.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/route.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 98abba8f15cd..dd6ff5b20918 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3765,8 +3765,6 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_EXPIRES)
 		fib6_set_expires(rt, jiffies +
 				clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


