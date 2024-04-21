Return-Path: <netdev+bounces-89871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F408ABFB3
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F7B1F214FC
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794618EB8;
	Sun, 21 Apr 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6+XdSN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA612B77
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713712659; cv=none; b=oHU5E0O/OcqjorVAjJFwKc9uUH1DVwfn+ASykh4/7AkGH7yJSe6fi1ijtuHvutZqkuN/qZGmFOmlLJP39KzqIMpyEXObS880yzI5PswPt6E+vJjYKpDl/bHxb+AnEcrdMjFSLXiDw1erC52dUZq4da4+fr8hE3mar7MCyi4EUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713712659; c=relaxed/simple;
	bh=q1hyGuqrtoU7mR36qdqK7lNmY/vN03a50XuwjHuqeso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzPHnwN6CXjU1iydZp8y/fjuWzc5TGE/4QzYpMnoUYUCsnCG2SGJ5HMAoJs4JElTnF2TgNb1QMbJa94K9gKOFVikiL/d7TTuIaqmCF5nezuL3TC9ycdXrljGPC7YjKM5DjzDUEJWHCBqfz0Gb93bcIyxP4tFwfGr46K9XzBi4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E6+XdSN9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d86adab5a7so171069639f.3
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713712656; x=1714317456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xfn7JCqs4DJP8L1doG9UlSi+qLTT0gfyOPjnyjB13U=;
        b=E6+XdSN9KO1B+84IzTLcuNHKBWo3tEu7G69RW0XPZIdkqwh0xGXvnWTLQEiCNUREy4
         pfNsK5NXEhCYO/KN0+JTMc75ELOvAkzebqvZw9RD2C4tmktlU6Tw78llQeGRzgeuhoL5
         LwqsSavJuH7kMQRPSlCJKg24Z0yE3v97iOyXXcmF1eavn/32RmgAxnvzi16hU6NNpMZK
         dhNsnLrISYEFq3WcN8mKdy72pwHWJWJzx9VpJCbjSQDNqk+fJxfaxrg6jxpJUzeG4uvx
         nOYz1o5OCIl4AUSgrGydn99WXqNya5MI4PIUZiSnkIxZzAv2ot8oYw8j8D5Ij+uo8vwD
         hbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713712656; x=1714317456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xfn7JCqs4DJP8L1doG9UlSi+qLTT0gfyOPjnyjB13U=;
        b=rT7x+KvB1fQwO05YB3sSqrhsN2xx8ZgQPwxUBeekQ2sxIvRpqW0CuCFN+BBBOToxhg
         WnI/dLxDWbm2oKzDnoSUjuyrzy8QbzLEQZyFLCDjUHTklfFjNKVEzksuBMfC7TQjmBZI
         4ZZhcjSmExAZsOOFR3QRGxsZFwpzzZw4x+Hu52YaZeo9KNJ/vZ8CMW0jDBzaQeLm5FKZ
         nXyFG2RXtVbZgBexEwUMyJvhCoj3E46kj6OTjhZIizy764on43Pgg2SFH5L3bwsJtMvP
         h6wg5kZ0rsuhnKMMLweol1ZWXRUnE19VsIGiBm667tVqkjznx9bCBL0UT9vxslNhiME7
         DxSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQVA2fhbhv6Qf2thwGA7vswgvmkrwCx/Cq5ZXOPe7s7TAUJCbk/5guoRyq5e5xAztTv8me2pdrnY307Lq/p30qd8vwgy3M
X-Gm-Message-State: AOJu0YwRV3ZND6Dk1d0O7ljEXao87bN9D25GBQULxKp8qwSFcEwq2YUd
	52Eu/9omVKxzcWHiu7AGpfDy44xHnxgqeq+986E0daiqU7RvdKSV8BOBzIWQMGo=
X-Google-Smtp-Source: AGHT+IEe7Kimv8GgDCtMG2dmDPa6n+g+6anbsvUuvqQyRVjthTFfY/QgqiMrnX55lF7LMO2kJDpSHw==
X-Received: by 2002:a05:6602:1b92:b0:7cb:ffe6:b320 with SMTP id dq18-20020a0566021b9200b007cbffe6b320mr8433088iob.5.1713712655703;
        Sun, 21 Apr 2024 08:17:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b007da1efc9b3asm2044016iow.43.2024.04.21.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 08:17:35 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mailmap: add entries for Alex Elder
Date: Sun, 21 Apr 2024 10:17:32 -0500
Message-Id: <20240421151732.2203345-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define my kernel.org address to be the canonical one, and add mailmap
entries for the various addresses (including typos) that have been
used over the years.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .mailmap | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8284692f96107..a78cd3d300eb1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,6 +38,18 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
 Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
+Alex Elder <elder@kernel.org>
+Alex Elder <elder@kernel.org> <aelder@sgi.com>
+Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
+Alex Elder <elder@kernel.org> <alex.elder@linary.org>
+Alex Elder <elder@kernel.org> <elder@dreamhost.com>
+Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
+Alex Elder <elder@kernel.org> <elder@ieee.org>
+Alex Elder <elder@kernel.org> <elder@inktank.com>
+Alex Elder <elder@kernel.org> <elder@kernel.org>
+Alex Elder <elder@kernel.org> <elder@linaro.org>
+Alex Elder <elder@kernel.org> <elder@newdream.net>
+Alex Elder <elder@kernel.org> Alex Elder (Linaro) <elder@linaro.org>
 Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
-- 
2.40.1


