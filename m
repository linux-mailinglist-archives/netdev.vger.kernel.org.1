Return-Path: <netdev+bounces-244893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A977CC1027
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3677A3011026
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A1334C19;
	Tue, 16 Dec 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9IwvEGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09B4313522
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862801; cv=none; b=dIxs9a5bnYorBc/iCqsgx4RWxSwo8mgOlqE+y/AsIYXduqMSKfpwi5Llhf5VDAPWE4VijsYNRnT+EYqMRtfuDJVT8qgPBrb+HJKWjEx0i0PkMowlRSJb47uPypLrWQi4apOthYZo4I9S4yljPMhAV9SGdIRMQPDeSAAqtpqSW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862801; c=relaxed/simple;
	bh=+Tmn6vSyTwnDcEGq+qnplLYYi6HzmJ7AkF17KLDtBOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NySH1B6kOWSSknRKsvvIFU67z81Xw5+VVb5z8z3+vOBJ5z5EMEOqJqTc8P7o1PDPl/GUiiNcCSznaWEqA21zBpvii6OzjB9uh/hzw5bguDaiTfRQySOOlDz6NBjlUuKyVctIIHn2Cle8bjCqSv9Tt1ofJqY43o9v8rWWU0kQcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9IwvEGY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a07fac8aa1so30714385ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 21:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765862791; x=1766467591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lcsxypbcAxCRkYeAeqApz/iS3sxlqqcxNrXs4xuNiPQ=;
        b=k9IwvEGYxE2JXa2V8VjGNdisSDFP9HIuja406bGvMJPfvy31YEcWAgpZhBfDw2jWL5
         Tp1xgK+dUjORFtRStu/mIAp6yc1Pg/tP9B0PwGYON0QLAxbvPkwCSMWSZ9fA7x5Czmtu
         N/Dxz2P9FhMjKKyXVipXwfOzdgahdGhTtwsGKdS2cqSF25Mz0odvzlUtEsuBYyBVNAM+
         HFJ4UTDy2nnvpEZ6HtVhGY4AQ+NaJKTiArNj62/FGZddEWRu7D/hqVIzBr3WtR0+XS5b
         DASjcTf/FAQrU0zCGRckt2eUGnhbkzyVdCy6srwKeZs4M7NlnfD3BiCHfNsLwLiVf7gy
         TbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765862791; x=1766467591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcsxypbcAxCRkYeAeqApz/iS3sxlqqcxNrXs4xuNiPQ=;
        b=Q9LWlAsuSQAUvq0lIW2yVgF2Y5RV8fkK5PEiTtTYPR+BTfpLAXysT5pndXE6Ce9rcI
         OTIAkkYBmLb9Qh0qzp35nIgV61gsaxRtdBlSjoA4rLmW+5/aJAvwZVyvAEsh+V4NbmJN
         uxEVxqECR3J3e6M5FXyFIc14rP9dw5Ci5/43VhA4yC9aiq+ngRna2VqpvH+FfcLC+nmN
         lR/ZxGxzgVtcwG8E3xBjJlFAKvvtSpZvZv5JiJhSs9TZHoDnDRf4Lkmg3PDH9ahkOap5
         PSTfA+Lc6QiUbdJFiO6z4SXaKJ9Y5ZQo1hLM/V8lfpCWR6TQFIMWn7twSrsclbHE3pr/
         UZYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqnmSkZm/bLSiShg9NPk83fysnmLm+y6O72wryqymo0hSA/ZbiM3j7KODD42Qukjr7f0s2C0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAGzKTUmFUA92DsHe1nTutuVzli77ZkegG+clEo30h5sRoUrkj
	AyXfzcX3yKzeCMCoeJOIYCv8okUUmhLexxWz2m0drxq8mxJWfV/5ZuKZ
X-Gm-Gg: AY/fxX5SebT1bmqsSOx2yS319GqafoadPl1FMrt5Sua72Hw7i1lPMrIrZvSnBePaDWn
	Zp3y6zBfnq3yh3zpU5zUFAG6AO+tXbr9sVgprB/+qDGa6ZYgQFV+qwZXYe5IkipFOoiTx2XyWRO
	v+B2fLK90Ud7UgOxYangrMw+hdgiMIrAd0g2j8mwk8MGqatrvzYAqKPbPuJZj0KRPEQh0kdteN0
	9v9DKuPe5DlbuKXLODoROCws84Ivg+du/f0yHdfvnD7MR1T+I3JM2Tvu9VYCABJq2IBxfpJM73X
	SPZiOcU0P56jXHjqxqDuzaBlfOlOfKPPFL4rQvBGKzEU06+RErLMzZ9VxuXQAPYlQ2u3mQozvwL
	kyH++aTI7U/1ulmRGETFaVgQGKMurSx01YJbKUeSely60kQZbPiYyaVp6sD5pe8WpF5i4eq9/rk
	qMslifw9KRJp5gn5A6iBYgEJsl+3QKfhYUDE7O8ahWXiw+Hw98Wnhw1uRZUA==
X-Google-Smtp-Source: AGHT+IH+UuREE2L2oI/f9++eF8O+lPF6GeYoWcFzwmygF3v+yf9Ylf2Yd9qrXd7u9dYHn/0w+8W93g==
X-Received: by 2002:a17:902:c402:b0:295:c2e7:7199 with SMTP id d9443c01a7336-29f23c7b8b9mr145172235ad.29.1765862790651;
        Mon, 15 Dec 2025 21:26:30 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ced60ff4sm61302145ad.76.2025.12.15.21.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:26:30 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v2 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Tue, 16 Dec 2025 13:26:21 +0800
Message-Id: <20251216052623.2697-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact through adding a
pre-allocated memory for each xsk.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")

---
v2
link: https://lore.kernel.org/all/20251209085950.96231-1-kerneljasonxing@gmail.com/
1. add if condition to test if cq is NULL
2. initialize the prod of local_cq

Jason Xing (2):
  xsk: introduce local_cq for each af_xdp socket
  xsk: introduce a dedicated local completion queue for each xsk

 include/net/xdp_sock.h |   8 ++
 net/xdp/xsk.c          | 208 ++++++++++++++++++++---------------------
 2 files changed, 111 insertions(+), 105 deletions(-)

-- 
2.41.3


