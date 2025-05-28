Return-Path: <netdev+bounces-194059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF2AC7297
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEAD5005BC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3A21883E;
	Wed, 28 May 2025 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkTJ9t0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4A6AD3
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466671; cv=none; b=q70blI+FSAX1wUKaqitkH+vHHpLjQYlGVdZ/Cz5DnlcVrrA4ciPOkvrTyC8eTFW65KgLRhZ2qPmkhqpKy+G1L+bHxsPdFuTOoAS6YxUKySETmY0WeN5fqTYn9q82zlK1sCjoNjka/dvYU4XSWc2JgBZeSBbSAxzYOKRug/G3+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466671; c=relaxed/simple;
	bh=4UXOM7OLzoW6ma+HUIJhbZGZce7+I4r8DZkICS/IKcQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eGk+yry0fDLslyoNYUbS7CmR8jePjPoV3MYDhLgGrxmmq073HUloTCKjqMJNJWUbv+zQ40czqxeJpsPrXg6wAmjsCYOP5wdHzmLzJLbeHm5HEBYqVK+13G7ap9isaajV8EgZzwGz8cmi78v8b0dtyLP/wAiCHyQhSbYv24B0mHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkTJ9t0d; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so188714a12.2
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748466668; x=1749071468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yqsw7cd17a5odblCnv8alvtCary2sTe+0twfnyapUMs=;
        b=jkTJ9t0dATLhhD5Xq+bdqx4sOJnibzCVAtakpQQwFZu6HkgxsOMMU1Y3V26EijDFPq
         R7hX8Zv2zssaQebgcEw3NKJqQcv+eUMextr2V2Mkb+1hAwlyIhTh8L1be98y4P0JirF6
         C3vAewG4b1cv2ffPEPsyLcO04jprxiR+zO903ANGzKcI828nECG0WDidZDifKCqkdrQ6
         rBHjd2QQHZUjCc65G8Ju1JHSFxtnY7DacQ3pQB5DbCqIZiNEDqMc+cSfY22ySp5TK49E
         LCgf9H0AnZbJP6Z6ohyZ5r9apUnPnEzat0RYC5mfrtf0tZO1lQ5qOelZr+8Hzx0CYjyI
         u4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748466668; x=1749071468;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yqsw7cd17a5odblCnv8alvtCary2sTe+0twfnyapUMs=;
        b=CRW4nU3mejR9MJ4YeVdTa7szd52Fd9SvRNEsINEbPh4UfkfOxJ/46YXbHvF0jVW3Wk
         Bb5fJ9RewsaL8HPQ3i26W8O2ngbsInicU5zMDthz11cPBYUcTxtFEmyUjuTXdoyfpJnU
         kPwC2YfZvuZWEvV06Llx6FzVr31+UMaH8RzmJvqF0+zi0Dhdk0GDHni0OHGnFd8zrBbl
         qlRr7bwzfkDCT8RYgJDW+v6f+G28vF3QZAcPj/iYd7mV2DewrRT7NoKpX2NwJ1uQRreK
         CkgIiiSbrHtyAO4oDxt5BAGKTVkKCRURdBv0L4pIjposEFMCXU3sQsjvjR/bvOD6pOma
         4HQg==
X-Gm-Message-State: AOJu0Yxl3kyy+Y81bcpOBctiSWCFrIQAk/W4RgBGAw1B0bQ+GWPnx8Pk
	3F4QQfEiFx0PL5i8Zf3Mwx4vJMmHUYqkCjjSB91BSawTE1mA132l2u4wfcD7aChD51k8e96O931
	lPx6mCHfpPRb1GH42e9nq4S02OAejlhydkAGLfv6l2HKX2w53yesP688EHvM0E9jvgSFHRVDY2F
	a6ogRwGOslmjgTz79dCeHp+WWzN9jefW4=
X-Google-Smtp-Source: AGHT+IEwzjNY2lmEL4t0vY22HgdKxrR7XoWmlRKrwK6gvj/A8k5t2OBXFvK7fgLsjcY+o6FMSU9l8LhDfw==
X-Received: from pgbdl13.prod.google.com ([2002:a05:6a02:d0d:b0:b2c:45e5:996d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c892:b0:215:df3d:d56
 with SMTP id adf61e73a8af0-2188c239840mr28986971637.21.1748466668465; Wed, 28
 May 2025 14:11:08 -0700 (PDT)
Date: Wed, 28 May 2025 21:10:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528211058.1826608-1-praan@google.com>
Subject: [PATCH net-next] net: Fix net_devmem_bind_dmabuf for non-devmem configs
From: Pranjal Shrivastava <praan@google.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix the signature of the net_devmem_bind_dmabuf API for
CONFIG_NET_DEVMEM=n.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 net/core/devmem.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.h b/net/core/devmem.h
index e7ba77050b8f..0a3b28ba5c13 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -170,8 +170,9 @@ static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
+		       unsigned int dmabuf_fd,
 		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
-- 
2.49.0.1238.gf8c92423fb-goog


