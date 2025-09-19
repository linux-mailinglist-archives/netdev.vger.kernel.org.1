Return-Path: <netdev+bounces-224843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA6B8AE47
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EA05A2E67
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F8269CE5;
	Fri, 19 Sep 2025 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoThJH8J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293925DAFF
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306064; cv=none; b=pS1y4OWAexEb/uVTu7DewrSN/Q0TVZ4wEeXiFcDDjqo9BqDFm59ao5cZsR+OvVB3GoEqdS/p2Etwue8dXSSrxpoWL+6k9OQmdqVpl//LAv62gOjGLx7lTqP8o77pawl6BECOiwOthXh306aSUBZycLJthG3tJdOvpkw77yOOUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306064; c=relaxed/simple;
	bh=5Wh1I62F1f9o/ydZ0qw8dXoBNDdZQT9dEqo+DcjIuWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0BOyUxEXB2Uwmit0UYnMOwodHHfpSNx1mPq5lXf9UwNJrkQCIw7fu/FHrLaGInpLbKPUl6m7CCOLX7J9mH1Jg/n3OcSAbD+XrKG2lZLOCArqC4BWfaiofyJZOUoXs/4ZTFc+mzLfkaWNW1M8vZ+ixICGEMhl6+Hxcoy2+N2BdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoThJH8J; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-268107d8662so22919005ad.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306062; x=1758910862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=MoThJH8J2zLhx9k5WtjWMRpHxFKB7wdV1TTJAlAlrVKRLz070Z0iz2VniS1Oen2EGs
         rtWEhpAqyHH+Va9WCj34nEryXU6YAWbxT+z7T6KXS/veSLAHTsQgPKO1N7cQlvalE01l
         mpqA9xfOU45Yn31q03uQkpoAldvnyoCxMGBxNJPTB2feflC0CsW9qP1sxOjKNdGwlHBO
         DDGS/s2Uq3VwuVhmSA78Sp1NS9G372y5UwM4ePbe/Yz0rhzJWFatmJGN6yCtOAZD+TgJ
         98Vh4suYHPFvJsFUDUgrt9VqGCnRqjqPtFSrl7bJmJJfV0+QGl5GJ9DWOMDIRIWrZpvi
         0qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306062; x=1758910862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bfJUnC1N1J8Qx74Y/0YQX4REZwiozdtUFZdSXz1p/o=;
        b=cBAi1JWjNNMC8PSnlm+HZaG+OOU24sTOjtZ5KwRD4ADsCz8tJ7jfCSV9yQVTgl9pbn
         6fA0T8jgwumpwOllXPPqOYRtR0RnZWnWCkh0iyvscSFPsAnbTgvXL4OGmQqRJA1qrtBU
         tHcTi8gsYA9THJJceiymrE1VMQgX6am7u6RpLD7gKfIsJWl9ysYVwnV2aOY4raG55JX9
         RLHRk75qliB170s2wMSnR9a0pwaSWztI2pKYRgbLh3ob5jxCMiEhwxUAZ0pXRpIpJLR4
         qlXlGDzUqlN78F0awQk7rJ+0zCLtwId2GiRM/Y4kpdXGPXRJOL1ZPJtpuRbEDlZ3eK5w
         DUUA==
X-Gm-Message-State: AOJu0YyKfgYgroBkC0Vg1rqw78gsCCp6ESoiS/b4jW5Uf/JjicyRhZAa
	5PuvWKUsHxe1HcCsJTdf4agsCcc08rKV2/K0APoF3J6755rKiVfxXjSI
X-Gm-Gg: ASbGncu/X7/TVuFrbtlkX+Dyul883TnedxkTfbxsM2WD3AU4mfp3+r2URcIo+cS0zX8
	XyLJkKvCE5boLUEKtQMHRnt9FLtGgYIuhBr1qR6fT9kParTWqVz6UVJJQtpWAbBK2Oxz/Xk42YC
	1Y58kr6xsxJRwwrOogDul6b6k56FE+PeZ/EAuC8Yx5iJJbhZYdTDt38s/SWuXD5kQNlTzG8s80J
	j7G31JpdHNl1HC76L5PRd4vLs9aDJbHIw8IiHEJLDwG/uOSAjhddoNnD57CFCEnj6PfwNgYK44c
	Vkd19ZndUN0T8ghEz+HB2klS4W9t7FR31crOiLrHe4a+T/yKGh976v4HmHOn3plQqDvXolmHjNl
	cVkEA8q7+wPfxsk25vgPIbUbX
X-Google-Smtp-Source: AGHT+IGOb0rV9m+TXnivyiMYU0jEF5nN5BKGJOkG3zrfm7v+1/+1D3Y5WpQnhi1t/HCfbb7yUb1ApA==
X-Received: by 2002:a17:903:244c:b0:264:416:8cad with SMTP id d9443c01a7336-269ba517175mr68364255ad.38.1758306062275;
        Fri, 19 Sep 2025 11:21:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803587absm59858265ad.137.2025.09.19.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/7] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Fri, 19 Sep 2025 11:20:54 -0700
Message-ID: <20250919182100.1925352-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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


