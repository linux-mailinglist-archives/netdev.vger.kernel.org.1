Return-Path: <netdev+bounces-249721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A3D1CA10
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40BC8301055C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CE36BCE1;
	Wed, 14 Jan 2026 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deZaObU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9636BCF8
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370704; cv=none; b=Pjt1QHGTUNJN8KINMNUR43EbCucqCTNIP6pq+0wrLFlAwXVZtl1NsrStdr1OWxOS/Dv4Zj1YBakzaueODBl1MPPjgMY2bNoIzQsuYFtXQk33a8ZpctUXUWoOk2lg0PkR4NcNLSULuIEyEpq1PUytismAp7KBKBurX77MoCMsBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370704; c=relaxed/simple;
	bh=DAsOq5M0Coab+rmoiISyOt1M2w/X9h0gZzQq1KG9UQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOrbb4G3ZVIJE512gXfXoEx94foDS1ZDP93rFhE3QkGHsqo2YJcXp3I8GxQhPwXC+y0y+mlN+2f1IPPjUC6+CeqvoLnRnqVG159Cd0kuneCvKV4XtGgiwFQEZ+vgX73m0kpE9lLtmhUl7Wgs9ORagTpRqyxuQIZnMF9YcuNABJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deZaObU0; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29efd139227so57121925ad.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768370694; x=1768975494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDgcpoXWlHrnVNaTs+8RAQZSv14M5S+NeQHQRuPlaX0=;
        b=deZaObU0L0SI3lPtu97om6fD4PorkPk/XE3iCacf0qo5O1mRqx+0okJss+TzICRqd8
         tIle9O7m2onvHW1wxoQtp5vMHFIQ0jJDS9juTt4fVfTmbiKDQTXP/Ecf/e574aIZERyp
         6Y/0cMzcHFJSSVbzGd0m1KTfzQy3YG6KFlvD7emdumb/2OYeF2dYCITOx+kbUyCdHGMe
         hu8mnBZ0dx28DHP3KgiJP3jxh+KqTmaGBCeQCJLHVrNVhhK76X7m0HxNE+g79zVk0G7u
         6eu8sxtEFxSLI0BNaH7iD20Q+Sna8MdbIbE8iRVormdWQCJWQUWqqTKGoEnBx6qsbes2
         IC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768370694; x=1768975494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDgcpoXWlHrnVNaTs+8RAQZSv14M5S+NeQHQRuPlaX0=;
        b=IOv+aYVg9MiOo/+lUmITh1xLI3zRxGrW4WBo5+5BkZoX8UILBykUma/e1NVfeOmSSw
         maTbPIYnoXdF5fnR9IMI5Jc26sqWBrykI+JblVUKwsWtP26anJw+R3vmmLX/0e+pSBGr
         gks3LNxFoj5mDsBlpVWEDZPwl+XMfFBV4XT0SVZhqE8juRNag4/0uaDbEVOMS6QtmbPK
         0lgWQ7pbRPF1+vmjbdibEY8FqWwe6Lg44qDmCI7H9ZitOlb2fKuoZqjHG2dPM5WJkQac
         JJOzZ4EDfLn+6bDxGgO9tifrUXshsBFkJFPIgvRAaONLuJUZ5LRCQS+KbuqKeHzffX6z
         cr4A==
X-Forwarded-Encrypted: i=1; AJvYcCXswlHIWcbIauoad4xnlwySyTCkSiYaM9I+/SRgME3dZV26JRBa79QBlL5a/8vaVQJWIrfCCS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6nXXSpHZQoStNHVVYOUtymvVXAOA3Fkjk/9+gjeB1erKdp3+
	mlQ5thG1lw9qBHRIi34y5HeCaFDZfz4L2zVxlswzco+D6ZUJ0rXcyBDg
X-Gm-Gg: AY/fxX7/FTjhiyIKNJTC5w2djCPgAMRwC4ayYR+f/2+MBo0uDfnZuPAYp1fpLP0vq44
	rIq58fM6lO5RQmN4XlPvKJorRsC8UsjZrCRF3FDlEemmlj31LMCQKH5UHJ+NaQkNkA993mHePNT
	ea9CxoN+RBgIHCnp9S/TI/4OAF/5TGmoeJhD2/UyYBUm6tyYRlvtFEEkDHRPZivk1gIJZRewMEl
	w/EZLnqb+iEcuhtFCIz/Yz6r3BXKqcrSX4H06MRKMgmm91EWXXEtemje0RrxObqATMjiqLYc1/8
	YYDXVFET+/et/rOqPQJY+YIWvM/vyF55t2uyTkid3rjgc84BmwKEqD8eNeuP9oYYe+MPYu67kp6
	yRTKBuX+BCjg+xBC0dwdBYKz8KXCqkWOC59eolo7TOmx3IkwSIHxJJlqcZvignicY9czsWgOjSZ
	dEwX3Q5d7kaqzbzVRsBclMphRf3zbog89BQtsFpywV0THoc+dlZys=
X-Received: by 2002:a17:902:d501:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2a599e2416fmr15597135ad.38.1768370694311;
        Tue, 13 Jan 2026 22:04:54 -0800 (PST)
Received: from fedora (softbank036243121217.bbtec.net. [36.243.121.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4893dsm214955615ad.28.2026.01.13.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:04:53 -0800 (PST)
From: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
Subject: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
Date: Wed, 14 Jan 2026 15:04:30 +0900
Message-ID: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When packets are redirected via cpumap, the original queue_index
information from xdp_rxq_info was lost. This is because the
xdp_frame structure did not include a queue_index field.

This patch adds a queue_index field to struct xdp_frame and ensures
it is properly preserved during the xdp_buff to xdp_frame conversion.
Now the queue_index is reported to the xdp_rxq_info.

Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().

Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
---
 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 net/core/xdp.c      | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..feafeed327a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -303,6 +303,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	u32 queue_index;
 };
 
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
@@ -421,6 +422,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
+	xdp_frame->queue_index = xdp->rxq->queue_index;
 
 	return 0;
 }
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..7e8bfac4ca05 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -348,6 +348,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
+		rxq.queue_index = xdpf->queue_index;
 		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..29f0b5ddb39e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
 	xdpf->mem_type = MEM_TYPE_PAGE_ORDER0;
+	xdpf->queue_index = xdp->rxq->queue_index;
 
 	xsk_buff_free(xdp);
 	return xdpf;
-- 
2.52.0


