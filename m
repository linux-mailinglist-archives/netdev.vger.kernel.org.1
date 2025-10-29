Return-Path: <netdev+bounces-234198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2EC1DAC5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9411889789
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939530C378;
	Wed, 29 Oct 2025 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DTX/eMQE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDA2FBE02
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779821; cv=none; b=c/sgkDUwQvYZMNm+iPltiH+m/TWRGSTDQcpSDvmWrugZgpNmqzpWi4wH6V+8v8SGYxQ1nIf42mo075LP53nwABOQy3x4AkjCArhMerTFROPALN989z8dogvWYqJvWcJqUkplvVV0vLBMwuzhFv+Ss83d1zqFcmIk841y9biuEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779821; c=relaxed/simple;
	bh=Y0bV3uOqQa0TmJ2BTXmCRJtuU5Q6CRukeoWm1kvXiU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX/40TLSuRqeP8fZFF6rzWhvhsMiMI9/eTWrDzf7mWz2+FZDd+2bD3IdGJn0CtcwvYEDejX67O87BKpBoGsepnLCLiI4zP75/pESQW517oLxcxRjmQ43G709TYON8I52hc34QcDRDRnE2DT2bep4+eQJ2XHijEZdENsgbwSEdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DTX/eMQE; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3c73e93eadfso182064fac.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761779817; x=1762384617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzjBeoCQ8MaxzzsfgtZXJfGuzfexJFlkMup0/3yKERI=;
        b=DTX/eMQEjhoa3/3V3N+hIDmGsb1PWCjVqYdDCFgauDbaSp2ZDLHw1CxAKmhszs8yko
         x1b0p8W8HPLTUIuwfC3TzJvD7jZ3JI1jnOs3ZLVBEBB6Kb4lGjduF7fy6HAV22utcXph
         373rgBiBmzjlGSDT0p1RVBajC3jpOFpNdp8ymojadE33H2eijcyFCvwTMkUFlIYCTqnt
         HS6tMMdrdcZul0oYiB7N3XgoBL1W8CLgo1N/WkieSpzU+qN4M+japZ5OPJmFRPYavKvm
         byd6k/u8PrI9T2xFqYuyEjQ+wcFa38/uoLhN1F/bofD4Zw+ZVPwSlADgKq1XD9nveTkp
         xQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761779817; x=1762384617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzjBeoCQ8MaxzzsfgtZXJfGuzfexJFlkMup0/3yKERI=;
        b=OjMRAu6+IWoD8/jHP57Z7gZrES1t2sKItUk/5k3hw4drNPRDg8QvCVnOJ/UfWQtJ2b
         IO49O8HF569QJ7PzTpl6kbK74dOtq2jmG5EHWYej8UpZFjIPBDDqwMRIojEtK6kWbM2/
         wSGFmIyhAirngLMcQVaNyHS/U3ToXtyIEIqgaCLsjR/RDYN7oTlDWkzrIPLZOL5aEsj8
         /UqAJtdKzfsFoZTZ8trwQXAZfv2YvWCm8htQ9QGxOZJS9sIUFoIJvii+sxMxDn3aIdYJ
         7D//Wt6L4TL7zkg/U1bLKD87vRqdJUiB8gyoWlXHeEF/WXhf0CqVnhefxeSlWBs2xVj7
         V8tA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOsQG0QkAeBt6z3dXWoxhfZ7kvuJlf/unrPvCtXBVQYs2IEFTjdl2cBDDU4whOQOrX1KT6SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5vlctVgOy9laP8joBqwnzJJSRq3B5qPN7/V8OwxwYBKeq/4P
	DzlcfHJf6AmadJ5FcuGOlBlNLCnZTu0dfbEmJ4Ef8hui2A1ydCYL5er2872Q9LXEs0c=
X-Gm-Gg: ASbGncuHVYGkVWmY4jdeB741f2b4KZmKuMlOzrOlKH6SmSFBiaSOTpQS8xPVKAoOdej
	8hi/NUoblBQYPxS7mt0AxTQjuK89PfnmVpPHnUzk4mHN8KiklTVUyDZGk9YWM/u4jW9pp9yFelc
	rkhNvUURMbbQiBqst2vnDN/xI5APd/6hVmvlRXC7lFjl4Qwx8tmSY1lxIuiNEF0vSEH+X8kxGj9
	EvcoKqwkH7xmedSy6uz8i5l/5vk8/XC18T7pOrYaziKys5UFrt2nhVxImBCCm/vXzdPY7SwooTc
	g5ZRDzn1EzTfZOLZNjOZqfEESDcMlDBWuE95FwIA8IUw7eDNaG69wTFZyn5GnQlGjTSajaaj339
	pJgk0cDf32H9eJUu59z2uGNB/qaGwBOaEAkkKsWT+7XrIxYKkbjYrVkxFrwvo2xR4h1TnGyr89K
	wXLRi5y5uiqks+ZKRad1I=
X-Google-Smtp-Source: AGHT+IEbT+2c9fUYGpfZP0URl7Gt/aBbWW1x3GT8+zF4zksuc2BgrtHFAIMB1hd1CMW/+ncpXmbzQA==
X-Received: by 2002:a05:6870:1490:b0:3d3:10a4:c6e4 with SMTP id 586e51a60fabf-3d7481a610bmr2512441fac.51.1761779817372;
        Wed, 29 Oct 2025 16:16:57 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e3a62f09sm5209364fac.24.2025.10.29.16.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:16:57 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 1/2] net: export netdev_get_by_index_lock()
Date: Wed, 29 Oct 2025 16:16:53 -0700
Message-ID: <20251029231654.1156874-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029231654.1156874-1-dw@davidwei.uk>
References: <20251029231654.1156874-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need to call netdev_get_by_index_lock() from io_uring/zcrx.c, but it is
currently private to net. Export the function in linux/netdevice.h.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 1 +
 net/core/dev.h            | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..77c46a2823ec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3401,6 +3401,7 @@ struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 				       netdevice_tracker *tracker, gfp_t gfp);
+struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
diff --git a/net/core/dev.c b/net/core/dev.c
index 2acfa44927da..7e4ef9a915f9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1089,6 +1089,7 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 
 	return __netdev_put_lock(dev, net);
 }
+EXPORT_SYMBOL(netdev_get_by_index_lock);
 
 struct net_device *
 netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
diff --git a/net/core/dev.h b/net/core/dev.h
index 900880e8b5b4..df8a90fe89f8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -29,7 +29,6 @@ struct napi_struct *
 netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
-struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex);
 struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
-- 
2.47.3


