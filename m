Return-Path: <netdev+bounces-199723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC57AE191F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B9E3B03A0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC84260580;
	Fri, 20 Jun 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXN6OcwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51657254AE1;
	Fri, 20 Jun 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415826; cv=none; b=CccJNCeAgMf9VoyEzrH7YJIoqF38Z488pgSh4PwWt2cLS407/2Ulk8c+4Jodd/curJEhD5azOUHpRs0w6WTrGfd9Lbb4viOgyDCR8DDWb+RvxKz3QVPyz6CAo/WoYTZL3hTcERc+Tku1PAcDMp6RqtlnN+xqFlIFv8S6p1QsBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415826; c=relaxed/simple;
	bh=VS3JJVcLM8e+/C9GKlienZfWElI7EwidERPeL2fcH/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+D3lzI//c7CvXT4A0oluAfZfo4zRbQK+UhB134hPYBYMXfCwVPiO+KKXP7Y/e6Fz0UTvuo78t46WXE5BsewBvOjS3Ody3eGkZbt2e1Ys7jlzk4FqdWJRPvY4+IRIlVtY9qTCbFk+Nj4veZLGXySmc+iMVML+FvhzJE11C08Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXN6OcwT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d710d8so23628575ad.1;
        Fri, 20 Jun 2025 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750415824; x=1751020624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzFnKyjtp6zgHtcCmzpcFM78spPpMQ5at1Z7orqizdM=;
        b=OXN6OcwTovRi9s4+A62Cq3vV6GdoSV2fBLcZkEYSWrdMXkaCWtD+TQVSw9KuXS3DWR
         Zovip5qZk1gerIzKAtVp9K6Ycl52N+tgMOSTtsLwSIrgTD4d1yAoEKdjsgYFK4seN7vn
         r532JOhVo+lt3K2kgla892uxQ/wsE+dL/GjugvI4bG90XM+r1/dgaa1dFnHc6bKUvVx/
         ZpXJHjc/Y4xfLKfsowXicxbU6JY/SoV1c5qhc4OyTyxKLf/qi1bsHtdV3iPaYIJkTDDZ
         ge/oVZ5HLo3y7mCmFOQiXXI9CDkx4RdSiSWxrPXGHq4DQBmTQbHj6pQpzDmD30mQ/QCD
         CB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415824; x=1751020624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzFnKyjtp6zgHtcCmzpcFM78spPpMQ5at1Z7orqizdM=;
        b=tygzPlB1UKLrX4wUvHs2HwfnMVkP//ZMgdwWABZl1D9Ce//QZo7Xzk0Lqvr6HzkVso
         AH3S/kehCaYhGNFTgRjCBrr3JBzITx4WJ+sKulM1yq5nAxo7PfH3J7V8yHSDxXEal8kr
         jGZ5j7WBq15opAPtqJLTHt0bOCj4GLqQPcUx70Nm0aegVSZ4w6RQUDhLiJp3XnlX7zuF
         t5XWAIcxy612agt1qYVQrr1megQdlc+SaM+VyOgcB4qkMaKp/xilkhEi6kMUUd5rBQgM
         bP1rhTngCe6zIgccpUuOpAXTtQ782BJc1w3tk1b8lC/gawFvdpba6Sx1l2SjBY/1qDma
         scHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpTAAPOC2rPnu+Helxu1n5z3FuJRakEZTyixCr0meNjJSoaCxg0e31XnM04QPXw8mGZC1v/Dbf@vger.kernel.org, AJvYcCX01u1zXkgOvK0xUlaHcm7EFGOqcO8Wg7zkck3ED3BPrsExer+K66ZMJz1N+CVSfDVc3zLxLZzcQCYZOIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzH5FX3r1gqqNDyNBOsc5TeQzWUJIzWENx3EWACOnR6oNRt1AY
	2pmOJSSwY7bhHRChtXadc8zMybQzSKF61UDzOxaUhtXWe6cDWZaYtsNZ
X-Gm-Gg: ASbGnctHmm1UVNFFDq54nE46UM3PZBkgdzFAmRQ3mZ7HDrViaueKC2mD1yTnjHhEOa9
	LTr4ZchRW3toD6koG639pvn415hM4dlWFMiOrfBIGmbmCKrUeh0TxMbRzkwRODgpMvCCRip+E+3
	CVqAgxzZUZE2BApmOTAvJOcuNX1wOWFve4DbdVWC/8+w3QOLdVpsZEsXAmgIFV2qvD/AJRGx8qf
	j7u1Ja0R76uNgzuuG3lTnSBC5F0BLyy5rxZUik15ODBd5lRkncPhW+bn1W/xqODKMX6ISVBmbna
	CHAIIROktRjUnbGQnT9TyESRXbM/OEuIL21CWnPpQF8TU3G5jnGqyfz4fnyAdQIW0WrmSojKqXd
	S27DREw==
X-Google-Smtp-Source: AGHT+IFHciKNELGCLQrx8i2bmHdeHbV6hiXtNE+JqkjF7+uOfgOBIvu+M3yZCjLl65a5EWLbBvlH6g==
X-Received: by 2002:a17:903:2a8d:b0:234:986c:66d4 with SMTP id d9443c01a7336-237d9851e1dmr35751955ad.26.1750415824490;
        Fri, 20 Jun 2025 03:37:04 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:adfa:3ba4:a43a:db76:7cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83c0b61sm15249775ad.54.2025.06.20.03.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:37:04 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH v2 net-next] net/sched: replace strncpy with strscpy
Date: Fri, 20 Jun 2025 16:06:53 +0530
Message-ID: <20250620103653.6957-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with the two-argument version of
strscpy() as the destination is an array
and buffer should be NUL-terminated.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/sched/em_text.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 420c66203b17..6b3d0af72c39 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 	struct text_match *tm = EM_TEXT_PRIV(m);
 	struct tcf_em_text conf;
 
-	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
+	strscpy(conf.algo, tm->config->ops->name);
 	conf.from_offset = tm->from_offset;
 	conf.to_offset = tm->to_offset;
 	conf.from_layer = tm->from_layer;
-- 
2.49.0


