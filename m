Return-Path: <netdev+bounces-225422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4ABB93962
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2E619C1345
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D132E7F39;
	Mon, 22 Sep 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXgi0XcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C815A86D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584040; cv=none; b=sfnbLkmdVnT9BJaqm4rpPJAJAqqQDaJ/jkjSaZr93RKf1aNLBNKqRwsFs//LWZXDobxdskNjgNn9Ivg8EZ8eLlCNtIHXsvNqAU3NdHW+GAuTDHoWI+hnfrBo1sDubLTxDubKfY/hkpiYTeoUDefEmyo89kvs/gMuOJjWiCsO9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584040; c=relaxed/simple;
	bh=RY4vyhTW2f0bqZ50MhY7X3Zavq16OFmxObJLoF6ooLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAzUOrCWTlxBQmqMzB1uGbWGD+2nUtLPZlzk3XDxFqaVnRUGdPHQwOuoZMAlfzf8e7qQaZ1AXf/eJATu10hAG6HZyt2iVdzKn40Nm+pI9780X4mBr3C/x0/LrECez7jTTlFZPTsyP7mRPJJ2kXPIttAvlYja3dvlc45BKI5amK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXgi0XcV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d3540a43fso36805ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584038; x=1759188838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEMsRO7TZHSh+9hG3bYkPqo/ea+Q2binhPvJcPdGhgo=;
        b=QXgi0XcV6rqviHfOFkU1957qzzRXNORsZ7di65X23b1UXr9orL/uinsYe1k+N3UV2D
         QntNy9fH7JH80ogv9CtnIBodvKMJn5HzsNhYiHzb32F904GpJ1wOMltMZ2zPEtAxFhY8
         noFSttmhMgBtwgWkcZLY7zbMF6wK2typ2TW8fLrJb9Dixj6+OkMOixm68JrG0JPgmPvT
         K0Mmb4P3vTy0c+yliwiGFsPPJp0pFmuM3SSC10dgJSzoCWDLjw0Nrg5HMCdJqpcZ3JR4
         oNKf7OHH0367hMvWuU0QQa8y1fpkpoVSB+O+aJWh/MJeFa0iKiwJFBS9AmM2o2mU+nRU
         9pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584038; x=1759188838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEMsRO7TZHSh+9hG3bYkPqo/ea+Q2binhPvJcPdGhgo=;
        b=sPvPhjyqIlA1Z3tj3opcdMBGRdF7sRtMlmCFB2J1L3/t6WQyj0VT/Ho92lUtf8/iGj
         CdQGLlFXfreIeYTGwAAmLrgOMnqyHFQ5SUReTdMbd1pTtM0xKGmmxle46RKRyD4FciAI
         bCBaCdsIEa5O/5w61XUSVQNJXrkFxjyPT8DmZL5UgB1YmhZTaO+g3LpL5+15jWN/cV20
         8KOPu7nTX0Aqwtzs+mqR3DlIbzUFGK+vsm2at3Crr0z1QbfAAz2KTqNyLK7+uX8fIwq5
         6oL/+CvHngFeMC7q/LOBnqEKfulbvoTZWO+drZRNNMiZhZ2fn1GCexulwqWePiYoisGK
         wDPA==
X-Gm-Message-State: AOJu0YxH8sCcMVcrPSbUdSj5rNl+N2Fo6/bWX5bpPUqSQ0ZbIEMQwA6C
	aQHUZluashEslQXS53CGUDTaQMJP8I5/Q9rkQtNHURObArLLqpHJhuoK
X-Gm-Gg: ASbGnctK7PysN9C4ca088DIHGwglhWyMwoGC1c5xgGDpH4PgVxxbQaHyCv+WB34DwSI
	N499mc3uCt0A4h+wvLAvmwdKZT8L1hyeD+SKRBIWT3Tyi0H7xbeN03zqe189PHQvNfGxVuSX6l0
	Uy4L0tJ7Ej8ffiOpemnRNbP2QeITq2Qk8qjumBwGzGcGH6YYV9sDFLspo97Zyv4j8sgX5KFLCyf
	U98Mycvlodj/CzSfeRQ6BdKoe2JkvPhgfIA3rl2AgQbzKuJPsU+qGDpwIZ3jwfuPYLV42eRdKQq
	VI3W4jOROCx3+9dJtCif2dgd05qGqwSg1fJR+6Acw7JahK9KrWXsvV6o7g9iOgkVUNHI4lXTC7F
	+y2q/QbqkkeOLhg==
X-Google-Smtp-Source: AGHT+IFli+7qKpqXBAL0FjmI7t/09HNmmxUPAxbWmuChBYdr7dn3srih2OOB3NQrLfPplajYGStBEw==
X-Received: by 2002:a17:903:2f85:b0:266:f01a:98d5 with SMTP id d9443c01a7336-27cc79c350amr7785845ad.57.1758584038604;
        Mon, 22 Sep 2025 16:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c081sm145042545ad.41.2025.09.22.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:33:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 1/8] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Mon, 22 Sep 2025 16:33:49 -0700
Message-ID: <20250922233356.3356453-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for bpf_xdp_adjust_tail() to free all fragments. The
kfunc currently clears the XDP_FLAGS_HAS_FRAGS bit, but not
XDP_FLAGS_FRAGS_PF_MEMALLOC. So far, this has not caused a issue when
building sk_buff from xdp_buff since all readers of xdp_buff->flags
use the flag only when there are fragments. Clear the
XDP_FLAGS_FRAGS_PF_MEMALLOC bit as well to make the flags correct.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp.h | 5 +++++
 net/core/filter.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..f288c348a6c1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -115,6 +115,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..5837534f4352 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4210,6 +4210,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 	if (unlikely(!sinfo->nr_frags)) {
 		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
 		xdp->data_end -= offset;
 	}
 
-- 
2.47.3


