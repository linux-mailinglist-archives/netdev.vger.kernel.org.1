Return-Path: <netdev+bounces-223592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC3B59A4C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D952421A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5781834AAE5;
	Tue, 16 Sep 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG6dJTe+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966823A564
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032837; cv=none; b=QLKh1asu+RbDQMPPFluJAi74sOCJ97GwqxMXCEIdgHRtF7NrDgIhlqhEashkJ3wbL1Qkwx8n8nhX1LUPbFAQpJSQ9RAl67TUB/spQ212vxgEXNFEmo4WXaesaphofdMdwR/pgoVyI+kAhS+emLusfvKQzkj9VUote7dIZ9QLFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032837; c=relaxed/simple;
	bh=MJcEIUnPs9ak4+d5IkHtv3yqfevdFjfAWkSWHoi/y5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPAE8xpb8NolCeAJWdUwovGJySv2QoEJ4y0UZMy+Tyv8BWB30YzjAidc1gEpH40IMsU8tcnJePS4nJyqAayD6rc0brc8ubayYgFfxin0lZZ/fB60yhnNGfRsgcdyxn6VF88ycnz0LDc/kurhWQC+IKizuFfoLjw5w/Z7ukUUb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG6dJTe+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso40727265e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032834; x=1758637634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZnPDU01+keBE0tfX+r4Yhal5q4qGyGJ9h5yCH/G+vk=;
        b=mG6dJTe+byK55gIrX96quXZvu5pmuaFpo44VwWWjDU+E88XGvJgadpoA0RcyvNkNUY
         XVrk4PKuF5H17i7kDGWIHFy7/0I2cM2e4rL9a9odimBCgWOXavW5xArsMU/sHx4q0sjU
         zI3/xWCVJZmJn+W1ZhszdLL+/J9fsdGzjf4QtwUfx4ZstRL09rCqyvTN4P8AiSBrVKjC
         WLAp7d0vPe3L5t9WgChAMEUb1lYw9RZq/KOTt66145YMWW6nIt2a6BnmnQtqTAykF7A3
         3lKQnWBDCG+YIp3OIxeaYXvuWbKmFAPwPvqaknOT52g6ThQCW1WYnye5fgjgrSt66DLl
         5SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032834; x=1758637634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZnPDU01+keBE0tfX+r4Yhal5q4qGyGJ9h5yCH/G+vk=;
        b=wFfu0b94b416SzK2oNGx7h1hresJNBtqtPE72zVf0DWhRXNrlxCQlqPyL+T87ViMOx
         HYZAKk07vlhSQOizBIzWKQv1ArOFyMyckJPKcdKs+P+5nuDRY15W+5qsEGDMqfQJukZX
         T2sI9rZ51ocZzfDoNB3RPuGid4mJfnLEvoEol0mTCGV/LzrXz1nk5c99rpzaMNo39vfe
         SIliZDTQ76FZ3dANj9FYPHO1BJDG4kjzyN2LjJd6L3SbVY1FO0XCiTF6PGhbfzgWtk/N
         ob60dGY+6nZ5AuyaFhfvTvB96mSazPb+CNse3QFB9/xmcfFeBYnji7hQOy/hbIAfPswm
         641A==
X-Forwarded-Encrypted: i=1; AJvYcCVsFtCJJrSqMsclq+EM220KIfFGFwjZGYEWH08BQkaOss11YLEZPKxKrGSt/FnZisWCsvJY1Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGmUcl7mfQjgC4btqSUnta4rrp0rBV3VO5ruGAAH5cQL+l1tm
	zmU24k6XxKsLeFuXSTcpvZc1Yu1MkgFnHQml/I1BUb+8TY92KeefIuoj
X-Gm-Gg: ASbGncsuM4Um5aogrnR9HAkzaZ8aGEOrwpVBwKY41IIaEX0AuCgr1/FkcEO19ZjEci/
	x5PQ3YR3t9Qyi90MTgxBHj6GMoI4Mg2c5ImaLVNc1j9VZDVTiGqYhllhkPRK4mu4nfkpKa7rwb+
	ib0emfTw7ezp2pvf6Q8mp0C6NtYORKaEVaL6SvjFk1tHnKuoow+fxeDt6n1/nQbWCR7HYdioXj+
	H6wpMSM3+kohJkbk5MNBILlsSd/VBHb898b3XmtE+1yoQpQ3J/hxuBQRhiZU/CT6b6EPSBruhao
	awGe++5/f0XP85AKp+LlLnw8478VlcHODj8Cc/l/5qVLzRJw14KnKMwPK7cP4NXXw1ZKpfAkOSs
	rMCN6MA==
X-Google-Smtp-Source: AGHT+IEdVetd6MgumZM83BkZoyY9AAXzGENXYZmE4O7L+kfZRJgRnRIuft8ymbTIHuCrd8GAxIA6cA==
X-Received: by 2002:a05:600c:3b08:b0:45f:2c39:51af with SMTP id 5b1f17b1804b1-45f2c395323mr88594515e9.0.1758032833713;
        Tue, 16 Sep 2025 07:27:13 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:27:12 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 20/20] io_uring/zcrx: account niov arrays to cgroup
Date: Tue, 16 Sep 2025 15:28:03 +0100
Message-ID: <fbe8e974f87e182ae751e04ee9c83b658b8b3058.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net_iov / freelist / etc. arrays can be quite long, make sure they're
accounted.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 07a114f9a542..6799b5f33c96 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -428,17 +428,17 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 
 	ret = -ENOMEM;
 	area->nia.niovs = kvmalloc_array(nr_iovs, sizeof(area->nia.niovs[0]),
-					 GFP_KERNEL | __GFP_ZERO);
+					 GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!area->nia.niovs)
 		goto err;
 
 	area->freelist = kvmalloc_array(nr_iovs, sizeof(area->freelist[0]),
-					GFP_KERNEL | __GFP_ZERO);
+					GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!area->freelist)
 		goto err;
 
 	area->user_refs = kvmalloc_array(nr_iovs, sizeof(area->user_refs[0]),
-					GFP_KERNEL | __GFP_ZERO);
+					GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!area->user_refs)
 		goto err;
 
-- 
2.49.0


