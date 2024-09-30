Return-Path: <netdev+bounces-130464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8998A9B2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8925B25F0C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD07193426;
	Mon, 30 Sep 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KFVM2JBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7427192D84
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713475; cv=none; b=ln8WAljhxwZYvJ9FB+P8ROPtPT8KH7N3f1i84fxJh/59mvDD+2Ymyq+6KtFvV6dFwjN/FKPQXKN25nRHj1INN4qSEFpmySkvEU6Cv68PGEpbdvERpoObQnsku8J+j5DR+wyNe3hVhJPYF/hzYNiAMW24IIS11KkXrlCXCiddMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713475; c=relaxed/simple;
	bh=skuyjD1ajuiD/T7n5bmsansD48TDspNnbpW87vZl5kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVeJsD1c4C38f+oH/GQz9rgNQ5rh3R/m9YTMTzAkONtPrPV2HO6xOlpiQXvGhl3NU/F0MbRzY1VKhMpSwGzDmcxJM58GAccCoQWGHsm4D1YAuUtdUawFzX5J6lVDBqsPL3sLxmg5Pw4By48+A1Pvd0LdI41Z/D/NDeEbZ24Xhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KFVM2JBJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2007664a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727713473; x=1728318273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp8feoqdAky18wo/b0zvz2eHXjnj8M+1w7vQomtljxY=;
        b=KFVM2JBJhrWbrjC/iwkB2QXCv4s+Dh41cNRvTBrxIy0s/HNI9m02NutE5B9n9yjJco
         4bWXt8ebwr5TAsYwT2T9kGsdqSz7LQR+ZFUCpiAasynijYqntyTFjbmikPFX1PyeVPDN
         2UyqANxzrPDSxNvnS2WfT9s8W5/7U6OJOSzao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713473; x=1728318273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vp8feoqdAky18wo/b0zvz2eHXjnj8M+1w7vQomtljxY=;
        b=KxkLvyM+6pOz1CFnGWxluFqrU9CJd456dR632Oyq/sMf3Da8nQbys9bEu7hqpZ/Y45
         nfrtEzAVIr1P1ZKUT5uy7R8z5R+hEhkseiroJFiZ9EETPyux5VQ2XDPuQEdknPmYJggm
         LxTDJfD/sYLGk6c5WigYvK2rTs3F1z/0x0YS8XjKPLpDACUJtBQp1ft2VZkMB7YyQ92R
         6KQH6fNONB3fGa2Vcq9xuON/69eqdM6MDP1I2z840jqq+KEs1RMBL64xbaOzq5P1fDgd
         lVcIvmR0SZmiEx+00Vt0WC+sBmUTkRkpnp7ZB4SXOlperaLstI2tUmVIP7VQVn84nuS1
         qCBg==
X-Gm-Message-State: AOJu0YwtIUCUDuERBhkunrm9H9VQylMVyjl0QQjmpCuY0ke68qlt2dUT
	gzVgZ7I2W4J2X36L1yHwANLy5PITGCYQVd85pTbMwf0M3AcH3imipmRJs6oiPg80nkK3NeXfxbI
	btwCyYdYNLJUsQs8LnJyG+NdvWokCDrPVEcJxgVebR+8QeBftQJcVVk/nLlwtGxZpoBgeRCOYQk
	WZnfCyXtUfKaFNL95YMba4jtcELUJSz4f6F0o=
X-Google-Smtp-Source: AGHT+IFjpq6oB/rF3b4HdxDd9AuevTEwTzCo5XR0fDrLWvCVK+j+fq4uhFs+PIXISYEYpZkvXoIz4g==
X-Received: by 2002:a05:6a21:139b:b0:1cf:47b3:cbbe with SMTP id adf61e73a8af0-1d4fa7ae130mr16805435637.45.1727713472592;
        Mon, 30 Sep 2024 09:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649f879sm6411451b3a.22.2024.09.30.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:24:32 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 1/1] idpf: Don't hard code napi_struct size
Date: Mon, 30 Sep 2024 16:24:22 +0000
Message-Id: <20240930162422.288995-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930162422.288995-1-jdamato@fastly.com>
References: <20240930162422.288995-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sizeof(struct napi_struct) can change. Don't hardcode the size to
400 bytes and instead use "sizeof(struct napi_struct)".

While fixing this, also move other calculations into compile time
defines.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 v2:
   - Added Simon Horman's Reviewed-by tag

 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f0537826f840..d5e904ddcb6e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -437,9 +437,13 @@ struct idpf_q_vector {
 	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 112,
-			    424 + 2 * sizeof(struct dim),
-			    8 + sizeof(cpumask_var_t));
+
+#define IDPF_Q_VECTOR_RO_SZ (112)
+#define IDPF_Q_VECTOR_RW_SZ (sizeof(struct napi_struct) + 24 + \
+			     2 * sizeof(struct dim))
+#define IDPF_Q_VECTOR_COLD_SZ (8 + sizeof(cpumask_var_t))
+libeth_cacheline_set_assert(struct idpf_q_vector, IDPF_Q_VECTOR_RO_SZ,
+			    IDPF_Q_VECTOR_RW_SZ, IDPF_Q_VECTOR_COLD_SZ);
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
-- 
2.25.1


