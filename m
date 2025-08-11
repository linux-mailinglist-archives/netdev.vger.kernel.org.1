Return-Path: <netdev+bounces-212532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D85B2120B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D8F3A33CF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F77311C23;
	Mon, 11 Aug 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKGvp9NK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176C311C02
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929710; cv=none; b=NCOLpTkgyCr8QWtTnRUIfNnuTqy2a5MEY8zU2JAHH95Re/zZJmK3kiNaT40Ypz3V0ZyurcREsYM7JmmoFZ3xE391j4GUiO/+LlfsP1YY3v9bDQChCtWkjV9NuTHKaVLcZwJmMy1zBUheyCXWnAlmsk31Va8n2k37KSmAwYnx7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929710; c=relaxed/simple;
	bh=YVbZYEKJitQTSeRIRZBEmXhgEgn20LxM//uJhpi477k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfnQaLyMpYNEWhgKHCC/nWvs3d8QCIDDZnWDW/tNTQdxdKIQg/hg5PsJkZI7P3O+IoLPR5YD9nuzsL5gqVHKmJdpFcts03rV9tky8Jj+SmKM3jz6frxY09l2AClpE/uWfRkJ1Hi9AvdgmOYAQxvqzkB02wwYuApkrsnCiKY22Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKGvp9NK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e72abdd2so26948325e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929707; x=1755534507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QYO33vtyNX6lrHTI/yuoeKF7fWSxGUk/Rv1icvg4M4=;
        b=bKGvp9NKuU63KaVy8PJiw7ysF70f/5ipN7IohNll0mFrfxPSiA/xIpfSmoj+1utAXO
         7Ry1p+FzB1XZq0+V5GTXU7PqAnGKiMwog3v/D4Ap3UpYrgOe6lfm7Lb5esjvzea8C7f+
         pysawfxK0sqnEtcecoa3CzNr2abVPf9EifG1iQ5vU9U/zB3jb9pBOb7Snnu11H/oPfOA
         8r74JqTj5VhSuH/afN4DUt/GJwz5Qkzb/dv0OOYYlNSCI/MQn9+bzWAM4FVcoaKqqz3F
         14jHMcqF65Mgrk5DrCpcn+Ykaghc42unYqGAk4/fbbf+NagWL/BI8bs5IbFMRcjDNL4O
         i85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929707; x=1755534507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QYO33vtyNX6lrHTI/yuoeKF7fWSxGUk/Rv1icvg4M4=;
        b=i1DIadNkJGBICrDcf44D+yPRIP3FTx04Y7Rww9YFz3mwTiGyEh+nEcqMJXwwLk6DkO
         0BTyHN4xYkPyrZ+q9CjrNBpAsfZ6/3pBgQ7Uf9OdGed1qD7ihiJldpCDVraWiu5WPWs6
         0jNMsjDJ05Ngqu1tskPiBaxI89gRVVfgGrvCQbwPryxsqGBKYiIV3aoU3RdWytWIVkUO
         EdQ3tHiv69JF7y37ecqPiI2t1jz1v6mKpzpfw4tzvfaOyG80xD7YwxOGSiO+bPf3Q0ie
         Fr3OsrlJSwPzmA43V/KP7d/xdlitP+oLbqE6Npbq4wmftZDo9crlOtWLPBfEz6XoIm05
         7v0Q==
X-Gm-Message-State: AOJu0YyVdRO241nh2QII+t9Pjmz/gVqKBDMd+oUDZ5BjZNDag+BLkEqZ
	jp7iDBJ9g+KJ4s5ILZZhFSRJT2pO2FOXMVf38GNY2h2dEZ+SoLU22yiVtgFx7A==
X-Gm-Gg: ASbGncvAHIm5HnGifque4NhGdOt+UZvUBYUB5RurX4O8JQB9KZ3bN0gPLYeCSICFP8Y
	//o0Wob42G5QE8xSCiobhGuLny1ffGibm8kynbHxDb6WPx/4V229p6SylBhEarJaZkWXGdpkrEe
	RIo/eBrSXHBRW0PQZiu1/5OJoFPi0VsHkUIb5k7NSv9xy6I+v1oUMu7TK2gyDZONcG91oZFJ69z
	J0EO/gV2uh0qOzw89KlTnFTSnR/dqEKOU6t2li1R05ka0O/ZOsanZiF64JTNSouXVedMMR0Z+10
	6WBomkWZMlySPUj/rmA+/R+knPaqNK3KKP7MFA0kzUJ65qSvDd4jw7g3+IxZpnwNVKKy5rfITjq
	wavclCQ==
X-Google-Smtp-Source: AGHT+IFha+q4uQmjExR0o8zEW12E6c3kYVn26D4UWc1nRd5p1ftZy2ByyeO5Ju1+Cz3yjZPbcjcJWQ==
X-Received: by 2002:a05:600c:45cc:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45a10b9bec7mr3167595e9.1.1754929707021;
        Mon, 11 Aug 2025 09:28:27 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:26 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 0/6] nmdesc cleanups and optimisations
Date: Mon, 11 Aug 2025 17:29:37 +0100
Message-ID: <cover.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series uses newly introduced struct netmem_desc, which represents
common fields b/w netmem types, for optimisations and to start
addressing some of the netmem technical debt.

First, replace __netmem_clear_lsb with netmem_to_nmdesc(). The helper
optimises pp fields accesses, but now we can do the same but cleaner.

The second problem is abundance of places where the user has struct
page / net_iov but still needs to cast it to netmem back and forth
just to be able to use generic helpers. It's not the prettiest
pattern and often can't be optimised. Start introducing netmem_desc
based helpers and using them instead.

There is more work we can do, but these are the patches I want to
pull into zcrx. It's an RFC for now, I'll send it as a pull request
without zcrx bits.

Byungchul Park (1):
  net: replace __netmem_clear_lsb() with netmem_to_nmdesc()

Pavel Begunkov (5):
  net: move pp_page_to_nmdesc()
  net: page_pool: remove page_pool_set_dma_addr()
  net: convert page pool dma helpers to netmem_desc
  net: page_pool: convert refcounting helpers to nmdesc
  io_uring/zcrx: avoid netmem casts with nmdesc

 include/net/netmem.h            | 75 +++++++++++++++------------------
 include/net/page_pool/helpers.h | 41 ++++++++++++++----
 io_uring/zcrx.c                 | 12 +++---
 net/core/devmem.c               |  5 ---
 net/core/netmem_priv.h          | 20 +++------
 net/core/page_pool_priv.h       | 14 +++---
 6 files changed, 82 insertions(+), 85 deletions(-)

-- 
2.49.0


