Return-Path: <netdev+bounces-152751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9359B9F5BAA
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF890161A2B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8C4503C;
	Wed, 18 Dec 2024 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wi9teH3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AF39ACC
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482167; cv=none; b=fFZh4NPYFi4KzP0NTnVe/1pjVTvjeLueMWth09Lgk4Pz3z6h72sc3gGbbujiQI3i9Tr4qEsZeV7X9khLUiC6fYoJ5porCp16sto2+RTpBgGu32QQh9OcP02AKuH7JcasUXmSWjQie8UeRynb+WnCqGTEDz7mvJCOeNc0bkeQUx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482167; c=relaxed/simple;
	bh=135g8sWdi14q9q8Itt2VZQPm7R0gFcz1ULHZpEn4dmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ+vTUTTbMgl+Pm2oI3AAjcoGOEH4MREqR3+dhXhPuxkDn9DXZt460olTHhiI4rDYMEkMzM+MMATZFO3PwNH1fCzAJNJyYgRWj0CZOnlkEHYESuk1Y+nWaCeFTSEKVJ1x+tntpHhBGVTflCBeXU/GJsYfSOc5jJvcAbaXOZw+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wi9teH3Z; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso4086344a91.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482165; x=1735086965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ73wFKVt12qccWHG7cPPzOfiVyAwI1MB/XTBNYCLeg=;
        b=wi9teH3Zjc4zmlVYJ+wxsCtSP4yXDkKkfv/oKxU54LFiymJrRurciP7UeTPHMXFwGj
         PSLC+7BLrwPwELcavZsc12jOGytCAnqwwq2pTKgeo/CNbKAE5YP5J7Pxt9pPzTEPQlsk
         n4EK5bUwW39A+WNQVMcpXIwON/vVxamvgGEM0OwmGL4BcrVfcIWlhxyediwaqZMVEXmr
         TzGUbMVbFUubiGxTas2A4ELA0LVPOcK+HBvV+JLy41ygDhjv54vNDg2tzA427i+284Rg
         q787crFEfEn09hSdpEYp4uRLjcg8ay4Nf+98GPtIExIzkSY402W1TtkfkeZuI1j8FTI+
         JqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482165; x=1735086965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ73wFKVt12qccWHG7cPPzOfiVyAwI1MB/XTBNYCLeg=;
        b=PU95aIwk2KoDiodY1qfV1/onpootsBONHwxGsDxiJ64Mwoxk0QmVXipw3rJ5Wo5Trn
         BRxlo/4aBUx3K+FX8L43uS9CB8+VQa4I1tkt/oT8pTbeZlxQXQAwsCbaK/k/WVNSffpZ
         lEOchNjG2il8nxuj3dGnbeQMWBaGmStdrXPYGFkAsHxAKKH8ZzxnxRjmzXanWkj/Lif3
         MQOK9FdTPDqogNAx2W3RDbld4EFPUMEH51/3gSNy9HpNwxzVblj5Xu2OIWoemIGiim1M
         t9khl5PF3heHMiICVsiyuuEfwhAdma/QB4HGDUYupkA/Pf4BK5PBnAT3vhpdEpJFWUH+
         /OsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPuMPhUD6odS8iejR0VUmYHTgE89p8zaBd/8CcYggde+XoHq1ZvtzwiURspVft+bG/8WGbk0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGqw/UztJqUdkmWNSUeYS7Uah5d8Nv6+YysQb6gKy7diZp0CX
	6fej6tLqle8COqargMubp+yG5f3FiUMWKWH3u4jcfYaJ1/4B59Z9YSAz1AIfSUY=
X-Gm-Gg: ASbGnctDx+Fpu6j6avIG56rfIsXVo1CX0BYarm3RL93kQ8Y6AdP4uvJavBamRLPR/vC
	S/EBSdzJwROEoloLzIMb2b0oEnJIl4mATNv5Vid+cHK7sTWq+/UTRAi841P31AkboMtStjAKYla
	7lcgjGvdqPJ+XJwQByHjFW1c+FonkMJtwns+IhH1KX8YglIdHuyoNJGkCpqHp5vZu8mPCHDBr51
	vwdSoPtYk5/zN8tpIJSQ95jA0XfBFtkMGkSvBNBng==
X-Google-Smtp-Source: AGHT+IEEmLhfsg3d8KRh7lYkeLWJXR5yLAID5ZTIPn5Yij4dunrusE+MZoJ2ZrylKcRPNbr7UU+E7g==
X-Received: by 2002:a17:90b:4c0e:b0:2ee:49c4:4a7c with SMTP id 98e67ed59e1d1-2f2e91feea3mr1318385a91.18.1734482164829;
        Tue, 17 Dec 2024 16:36:04 -0800 (PST)
Received: from localhost ([2a03:2880:ff:20::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62b2afsm109623a91.12.2024.12.17.16.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:36:04 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [--bla-- 05/20] net: page_pool: add mp op for netlink reporting
Date: Tue, 17 Dec 2024 16:35:33 -0800
Message-ID: <20241218003549.786301-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003549.786301-1-dw@davidwei.uk>
References: <20241218003549.786301-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add a mandatory memory provider callback that prints information about
the provider.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/page_pool/types.h | 1 +
 net/core/devmem.c             | 9 +++++++++
 net/core/page_pool_user.c     | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index d6241e8a5106..a473ea0c48c4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -157,6 +157,7 @@ struct memory_provider_ops {
 	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
 	int (*init)(struct page_pool *pool);
 	void (*destroy)(struct page_pool *pool);
+	int (*nl_report)(const struct page_pool *pool, struct sk_buff *rsp);
 };
 
 struct pp_memory_provider_params {
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 48903b7ab215..df51a6c312db 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -394,9 +394,18 @@ bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
+static int mp_dmabuf_devmem_nl_report(const struct page_pool *pool,
+				      struct sk_buff *rsp)
+{
+	const struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	return nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id);
+}
+
 static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.init			= mp_dmabuf_devmem_init,
 	.destroy		= mp_dmabuf_devmem_destroy,
 	.alloc_netmems		= mp_dmabuf_devmem_alloc_netmems,
 	.release_netmem		= mp_dmabuf_devmem_release_page,
+	.nl_report		= mp_dmabuf_devmem_nl_report,
 };
diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 8d31c71bea1a..61212f388bc8 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -214,7 +214,6 @@ static int
 page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 		  const struct genl_info *info)
 {
-	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
 	size_t inflight, refsz;
 	void *hdr;
 
@@ -244,7 +243,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
 			 pool->user.detach_time))
 		goto err_cancel;
 
-	if (binding && nla_put_u32(rsp, NETDEV_A_PAGE_POOL_DMABUF, binding->id))
+	if (pool->mp_ops && pool->mp_ops->nl_report(pool, rsp))
 		goto err_cancel;
 
 	genlmsg_end(rsp, hdr);
-- 
2.43.5


