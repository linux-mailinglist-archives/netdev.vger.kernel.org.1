Return-Path: <netdev+bounces-69264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86284A8BD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117C329B5FD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091559B6D;
	Mon,  5 Feb 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c52AJGM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63359B57
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169244; cv=none; b=a/SQN1s7j7DzG50NKMTJ179AKryTv7s6a+c2owtEmK35IjM5iprricfIomJacZunxWKWJsGKgn5092QAJhkuP2qsVQb3GtjVKUaSa3uYqQCicvq233AME7ugQDl8NDgUZuIn/3LljE0+rbPQ+C4ySEszNdyBNnc/6Gh40ub60OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169244; c=relaxed/simple;
	bh=Zb0KvqSVUFD6trhqRy7c97PHe4hgPnMtl+lYemNh+DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOjUpHt8hgNEDC5DNoH7Oq9tGIXzWDgq0TjVajqg6zGU5wsUmV/5WtS4JjPwiZ2uDyMyQRuQ+Cor9N35TG/2ZBBCFMAGM+JDfDbF7w8PDJUeKmJwHYQ3OItyUFpWy4eHOGg+Ps9P1+KLZn3HmpXlp903V3+zKGvBZmcWvauIU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c52AJGM3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so4466838276.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707169241; x=1707774041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=c52AJGM3xT9bBnM04a76VKdbbuNjntGt2+YNTbGEaUsBtGmNqIrQVVfY8GsMc2jFY9
         4afR/Pg4ih7VTzyGMVuhOQ2XM0JkUOGYfq/8xzKSRaWnxgwaRLDdFQCdbGvqNxmpKR28
         DefV3vwgbDgmEYfvtY1/mHMmAPyAUZpFHRVQH17gcGBWw3Vs5RrV9jlZ03rTCSDsQIB9
         6bmrBP3fxZtmOBfg3ICSD3km/bCzH95vDvUHbSq1Sr77ZJS4DvJBbDxSv2zQYEdCDAfH
         srfkYj3v4Jjj60cpfoi7Nm8VvfSzDSCmaDB6f4XziIujLfy7SOOQNNs5m+TWji715Bwk
         csCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169241; x=1707774041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAhvacwnXC+gT2jQb1I4E2pL8pNEiK+4PVEePz3ZhJ8=;
        b=O2VlnGNWHMOXzHypWpNSTQvEzNo1IHISMwXJ3H5kVb1eaImbqPJfyDKxOlmvTfCfdy
         kFX1kieXZOHiFcR1p2B0NdhtHWtaIreWR3MUM1JhkmVIKF3ItuqERem8ufxP4p+NcTSs
         7VoAY0HIYLbHon0aJcE8MB9A26IVcElxTOTOFve77uhRFWaLd+Ny6V/xf1RPiB86Ea+F
         juGtl2UQ8MRtafeJo/06NlkI5i/GvgstbX/EG693LjXJ74pUl4HYTzL9vAO75VtY6xbB
         1aO9xwSoAXqNdbe20gvWZEvr2L1ie/omxMVG+JlhuMpAWZ9ZlmgzsR7jy9ds5N/Bga5v
         PbEw==
X-Gm-Message-State: AOJu0YxdlrHjRoYGhK07NYZOnaakx8ZnqbnzApNzBeMZ0QDPs3ISRHre
	O4V22WWcjFm7vRhJWwuFERxtbEhEyscx3PRjVivgq3qFmeAUfXZVfnO7/zi/AlY=
X-Google-Smtp-Source: AGHT+IF3irtsu6Fg1CNjoiiaFDe770VgOe1/qohyW+kEa3ONasNcuitFRt7qhti41+gO5u6pErQtvw==
X-Received: by 2002:a05:6902:e0b:b0:dc6:4ad3:1671 with SMTP id df11-20020a0569020e0b00b00dc64ad31671mr270683ybb.15.1707169241672;
        Mon, 05 Feb 2024 13:40:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXj6b9xpMhBKljK7ycQknlK8SInG4wBKOwue9kOlAdnpvyW/jwk4Hz+QBvoVxT04BE+Rkyrtxx+S3G36tGu5l8blIFtKhPExDsrxDo367AgCBKdZdACwZqc9aSyzMC8mcwtnNKTb3iaEzrmqPw1VGkJiZTikIhgpyQUoCrk8LXUxGxcGI5MHnllfDcowsmNkWB1Tylo3GyvkxQ6K0x/nyukyaRKb11KQpkM9gppVoAllXC9BTNkAd2V4vOlAnDwRMvEnQZjITADxVC387OAml3S08HGpHmQGg15P11/LlgrEE+jn+V20ngeEAUtyJ77m1r0YqqQn5QeyZ83xNwTRAJ5DerlAuJdDSiOiQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id d7-20020a258247000000b00dbf23ca7d82sm160936ybn.63.2024.02.05.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:40:41 -0800 (PST)
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
Subject: [PATCH net-next v4 2/5] net/ipv6: Remove unnecessary clean.
Date: Mon,  5 Feb 2024 13:40:30 -0800
Message-Id: <20240205214033.937814-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205214033.937814-1-thinker.li@gmail.com>
References: <20240205214033.937814-1-thinker.li@gmail.com>
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


