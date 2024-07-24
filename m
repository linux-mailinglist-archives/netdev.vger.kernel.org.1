Return-Path: <netdev+bounces-112798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E993B47B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A681F23039
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0115B97D;
	Wed, 24 Jul 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6briLkj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6D15B12F
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837221; cv=none; b=SMz1zYnm5rucnUyH4f6Op87u6fExcrd5hk6SS2F6zlYE+FqST42KOFeHlZYYNwdrdeCx0nnT9PijqXNZkdT6810YvWf/g/MXj40heocH8Sr96fXKyRHrHLEJw1NWCt72WykIDslWliM4xx3G6SscJ9RP7vEy6OuOi1sYdyY/CNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837221; c=relaxed/simple;
	bh=CqGehawQopzO0+MqKtuM0KuKVC/NihG+re/9nwFvxcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MgHJIrJaBnxe+x69gfnlxGZ30JqaOuhxPg5U6RgvSIJbim4XH4ilbISDCO6NmYWuB51+5MXdxR9gA+6xrI8+lMKP6QxoNMlIs5/L0WmfKlFcdHvZcKChuQf03R7Lm4LvGhUgN4Yp7891aM9bNkWzIYadOqnoOWn09CWdhPREi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6briLkj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703d5b29e06so3043999a34.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837219; x=1722442019; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WL00ffx6FZOS+gjuVcqsGTl485DZxHlIKJfADzNE310=;
        b=F6briLkj4+xU0WPPF0eVPTrUO1hW2W78TDAEOH0MYXBXg4ZvKWE/J8jWaC9JzTQnQj
         1ffiUCbwm4ABKHe3CY1+pJxzfoKvPJrEy+9oM7dsnoFWm/LIlyVfidtpHRu9BoOliUj7
         MkzNClEzM6kIDMsExSY9zZbPOMriYZNEH5cThK/Z1mhDPDH98Mqr0RJS+RQbhnfwCzm7
         klxBJc7ye5C5Z22qqyRQxBTwwqPvx7u9/VtR+UBbFTcYVieLSWvdJTvDOWFNY0BhgTrk
         op4sphGUENu6UGKpG02NXsOt15hHlv5YRU6rHcHl6Xqy1G8ATqscb1GhCZXAbec/V448
         DdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837219; x=1722442019;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL00ffx6FZOS+gjuVcqsGTl485DZxHlIKJfADzNE310=;
        b=RIO8awTrtqei210oZo+BlnTJcxQINg8U5vQ5r0OZNepPf3LfFxPr19OtmwQqrfp8LX
         x/hPdH1UYhqZZat+DN1Xo6q+vXDXZ6fnTNdZ4CQrKga4u5Pjnff8B+bXqiEPAuGLc0QI
         FvB5bY54D6UxofN3EDM5vLTWS/QfeXzdu6IpkLqG4XGuc5JBwa4PhuvqFFbZUQRK+ZpF
         c9Pb4eXAeu3add5FgtaZiSVB7208ufv0jCnLS+u+PP/qeVQ6cax/FaQ+i1VsOgOT/s56
         OqgjZzegcYq32KUV3lVa0w84EJgAszFX9mxurthJEdjes0kZGIvijWsuV1gUpG/WPhL/
         M62g==
X-Forwarded-Encrypted: i=1; AJvYcCVkiiOhUKi2mXFbRRQvXt2zAx35L4gqSYrNF0uJ9f+zJUq2YDlqwUDW9862u3ntdhN2WP1UY8rbfUnhiHWnOLPnQJbUXYWL
X-Gm-Message-State: AOJu0YylRi8hRH5/goo10va2G06W/iMUkfamwea7jW+2uV2iwQprj2MM
	b57Izd6HYTmf9lFeGK1zpvVFToWwaH/lK/fnIlnPCzFiUeYW4YkuTz+ol7/NbB4=
X-Google-Smtp-Source: AGHT+IFHDoY0NxaVxYd0I7yvfDpL/US8mbo5c+Ln+MlZ4tHFOz+j/ptFK+39Sj3ax64JA9QORrKb+w==
X-Received: by 2002:a05:6830:2782:b0:703:6341:5171 with SMTP id 46e09a7af769-7092e6f0700mr245391a34.15.1721837219146;
        Wed, 24 Jul 2024 09:06:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:23ae:46cb:84b6:1002])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d59ee0f336sm369821eaf.9.2024.07.24.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:06:58 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:06:56 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Chulski <stefanc@marvell.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: mvpp2: Don't re-use loop iterator
Message-ID: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function has a nested loop.  The problem is that both the inside
and outside loop use the same variable as an iterator.  I found this
via static analysis so I'm not sure the impact.  It could be that it
loops forever or, more likely, the loop exits early.

Fixes: 3a616b92a9d1 ("net: mvpp2: Add TX flow control support for jumbo frames")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 8c45ad983abc..0d62a33afa80 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -953,13 +953,13 @@ static void mvpp2_bm_pool_update_fc(struct mvpp2_port *port,
 static void mvpp2_bm_pool_update_priv_fc(struct mvpp2 *priv, bool en)
 {
 	struct mvpp2_port *port;
-	int i;
+	int i, j;
 
 	for (i = 0; i < priv->port_count; i++) {
 		port = priv->port_list[i];
 		if (port->priv->percpu_pools) {
-			for (i = 0; i < port->nrxqs; i++)
-				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[i],
+			for (j = 0; j < port->nrxqs; j++)
+				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[j],
 							port->tx_fc & en);
 		} else {
 			mvpp2_bm_pool_update_fc(port, port->pool_long, port->tx_fc & en);
-- 
2.43.0


