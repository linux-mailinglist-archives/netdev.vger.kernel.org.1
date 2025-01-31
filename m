Return-Path: <netdev+bounces-161715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C542A238A3
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183371889A98
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 01:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60822CCC0;
	Fri, 31 Jan 2025 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgbcJkPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BD23A9;
	Fri, 31 Jan 2025 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738287518; cv=none; b=GzRKNWEnKvRintS7TSKxutJOMBdwbMN23Vq6IryAooZ8rDmfJb8covMkWOENZLIbrasu2t/bsDTZImCNp87USN1R4HOfi5m0UoC0OCxI2mqaOLLT1c8n3zUN7Lw/iW9zTeSSY8/a7M2Hm0K3OoBEhYrAwceNTKXeV/5miiUM4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738287518; c=relaxed/simple;
	bh=8T1brB6w6nSJSTLTaIr/V6qDnzmA1rzqOhE85sB/WkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cGQBZDcepxj8MrTcyDLC3+1gDBhF4d2lu1lMQSqUsQELrXa5iF/mc4eTPBzydytMczogxii7jms5+0qsqBVzDv6HQqpMcAFU2nG69VTfVedJhHywKcGKzJI/FYoHNd/dLOCMie90inVGJ9hAkKOXGPwuQDvnZ2m04nr4OnBfCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgbcJkPE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6ef047e9bso128739685a.1;
        Thu, 30 Jan 2025 17:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738287516; x=1738892316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfEBD8O4S41CSk8Ejf3kHFNH8o56a8/NnzuZ2Wxb/e4=;
        b=RgbcJkPEPdpmqAOyja2WDhTO20rZ94yKlrbYMyZYM04u8Z1Tf51j9TWmxWFTlhjYWj
         aa7sBehRY/VbKOCLVbcoMWOJU+NT05TpFWXGp8O//YtNHV/9nhPe69nDI0pLZ9VCsbE5
         cVwJ0OpiDHk5vNUy/SfuZa9DN3IxuQXFUQ+cXcIu3+7EU9sOsrtvwEB4Nw+wNJQil0lH
         qz5nykhIzNpG8r2RJ3eL/dSchWmu3gtfrx0Qvuol8Wx40RP/9m1cq04K6GxkEfBYkvOW
         iEiASZ0zgPxcKLNghTeyFlR+DLCH6ZJz8nEWOfdo249gqNyVKfuOA5CduiWBwjMzEzyp
         xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738287516; x=1738892316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfEBD8O4S41CSk8Ejf3kHFNH8o56a8/NnzuZ2Wxb/e4=;
        b=m1I1mtEGbeWzo9Ww/+QjbfNsGhB93DUKzoMjoeBEiC1bYafP0/w3069cRbaDbE75xJ
         6aWT547WiYlj+6mujL32sZkzxpulLxG+nIGo9Q2+1SqZmAMRn9YzEkGnOGhAA7UlSpMT
         NTqb32vPxOoHzc8hByvZaRpf+MPZXu0Biiq5MHPWqUc40kGUCcirCHnr9uUkMZ2Ih+SY
         /1QbLjy6iIegnA1pqnZlrl2GaAxoERap9MCuMdh715dh0G3d0f+olpfdqV7X9mN8ml2p
         jTe5Gska0JCsDD6gY6ldaUe4Nxl6mErNG4tqUUvl0b/Cy3OWfh60m090GUfHtPl91p/F
         AmEw==
X-Forwarded-Encrypted: i=1; AJvYcCUplOCRVzx3Ox4l9fVcd1seVJUf+3hai8I4/j1nUjD84SyaEDowWx3YzSLwCA7bJokeTirmV9pQ@vger.kernel.org, AJvYcCXJ/BRQRW1TGDXl1XA7ExeO56ZIwnLv8ceR25pxUmjwUKPP+tQIuGnleGMOIB1zHl+yMYljeetQtRYcPHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKR1MNbAvlD+54x/8ymoeef/FgALKylLpXyG1WOxk+LkQyVeA
	jXnaFcZeACAPUKs4ysZ64klE3HuMbuBLg42VUjTuREuFtHZsrRrU8HescA==
X-Gm-Gg: ASbGncv+S1Aq4YC2dzbmTyPDaUcVGLdQXJMAa6ldxeG0neRYYiscSZ9qhnbiqcX70U2
	xswze4J3gDju15INhe/W8yjznoS7z6TmcWKj5DYBjEQQBNsdDWoQylz3x84HhJnTJ/SFn/yzxnF
	a5I5owx1SX3WKmpWP5KR74YNfmui+mh8s1Ph48VXBEQ7kMeYEHJu4n+nAIrY796ccjAVshtxw+l
	Lh2blXf5x3xroTdmkkH/R5CjjnXKan/SEKTXNX1tuKTJSRtUAfNKRuXkVIQ20Lho6vZxEU0W/yN
	g0OU1hiVUdhoNG0S5R3/00+otIuG/lQAtth2bw==
X-Google-Smtp-Source: AGHT+IHF03Z1w5BISujPuhazjh6mZg2XUPcFhMysp+KcXv0RlqAPgtsxXI68XwaULsfJq1lzsS5vUg==
X-Received: by 2002:a05:620a:2728:b0:7b6:d5b2:e58 with SMTP id af79cd13be357-7c0097ae5ccmr974617985a.18.1738287515767;
        Thu, 30 Jan 2025 17:38:35 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90ef7esm135314485a.110.2025.01.30.17.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 17:38:35 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com,
	horms@kernel.org,
	wojciech.drewek@intel.com,
	piotr.raczynski@intel.com,
	mateusz.polchlopek@intel.com,
	pawel.kaminski@intel.com,
	michal.wilczynski@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] ice: Add check for devm_kzalloc()
Date: Fri, 31 Jan 2025 01:38:32 +0000
Message-Id: <20250131013832.24805-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of devm_kzalloc() to guarantee the success
of allocation.

Fixes: 42c2eb6b1f43 ("ice: Implement devlink-rate API")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d116e2b10bce..dbdb83567364 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -981,6 +981,9 @@ static int ice_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv
 
 	/* preallocate memory for ice_sched_node */
 	node = devm_kzalloc(ice_hw_to_dev(pi->hw), sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
 	*priv = node;
 
 	return 0;
-- 
2.25.1


