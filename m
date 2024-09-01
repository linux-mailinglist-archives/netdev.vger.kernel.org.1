Return-Path: <netdev+bounces-124063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C4967CD7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 01:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C041C20ACC
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 23:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EBB13AD05;
	Sun,  1 Sep 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV+gsTmP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835741C36
	for <netdev@vger.kernel.org>; Sun,  1 Sep 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725235089; cv=none; b=IKvGus3wIqItVtA9NOvx7/j1wN6eb7INC3Lz9CevORt24l0Jj3xiAGogqN1U5u6gCGTNDqPT0vQMNkhtWApYnLtZH5+291v80VKEaAQjxGc+UGUlu7VNw4ZK8vLOlC+mo5BdE2XozOguIgn9xcgh1ZNHR/ZGqTMAiDL605KhD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725235089; c=relaxed/simple;
	bh=iW3JRfWcb5BV3cF0sufQHjsQ6qchdQXlqpU8ph8/J/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAfJBKudV4pHDCasp/MDWhK7w0aGW6O6f4a8QelsCh8GCKlAOsdbpNllpDmzDBZgyFoRNK7oShavX3hzo/J6WfD+sP6n/RT/nE/XOCFUpeWqL+fELETE+nOoIi2hh1j7CoLPfY8AcfLbeFPkedkWDB+DBY4SzG6wr2fDbo3sIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV+gsTmP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2054feabfc3so7200095ad.1
        for <netdev@vger.kernel.org>; Sun, 01 Sep 2024 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725235088; x=1725839888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BX8aTtq62tbG6x6tKl+m15boVIotQo1+EqYnAjlD8c4=;
        b=KV+gsTmP9jXOaIjGZxCJE2Kj449P/UX8bHOl4dwhTcxPH83u9fro04tvG0WrOtdsXp
         VzI/dUlQKMhq8oEwn79pL3E1TlswNBBIbEhkI2dz4tNeFCErAj5QSjWU17Q1bjixqaSD
         hN60Txlvy+EWUBrlnd8zpqyErr7Elk1zJ8nxQRIo9KOZVHQQ/mvA7ZxDrhSwLiYJXbyb
         ygr13dSi8JLaflOdxCmYEhsCzs2OnMXO/byN35NYS5G3Mvlu53cMXM+2g7cBP122H8f7
         8dk4+Rdc1lKbTh+ResvFw0Yiwicjo6GabnRzWw5U3kBisEYWIHATjxMnxlF2O9mFDZl4
         tVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725235088; x=1725839888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX8aTtq62tbG6x6tKl+m15boVIotQo1+EqYnAjlD8c4=;
        b=AkrEPjXWTDuzLzhMpS8HuXSCkWk/PEk/Jb3PadhYALxOa+hSbS6ztO1NdcdDsN5apR
         ZyGKFsSBpfBd2jsIp+xOtDz2nfT9bS3HqiAexqIlCXrjmJPCifp/np4dGv/JSVauuD6v
         jPS0YHCXI0riyo0oszwoj5atVorHUfUCKCfBglcEWDE6DaWxSqMHWha73Au1M6+0ToVN
         Gsg/Jw8RtpO6xWfQn7s7g8FJNgSfCXVbHq1mGYeYFS468krI2uKIpTClkydpmonRydTf
         1Z1eCIHfzof7aoEgjnMj7fNFMTeNYLHmEqVI8Lc5Ej7ei00RhthHlOEuPrbKOyUryJxU
         ZVdA==
X-Gm-Message-State: AOJu0YyfFmGfQuSkYeeddOZRea9sA1i+xUAXwWR7aXRzSf9kTKUIXIh/
	TVos20rEH1ZETLK6dqNfOUkjS4FktpYVKCyFKirJYLk8YWEN7zbW
X-Google-Smtp-Source: AGHT+IFt+/pcgKozR79qHZLeXgIq0bHsd3NPaKy+OGzEfbLulQYbM3VOvUx3eyRXtltIFPH8QhxzAg==
X-Received: by 2002:a17:903:18b:b0:205:8121:e995 with SMTP id d9443c01a7336-2058121eddbmr4170865ad.50.1725235087725;
        Sun, 01 Sep 2024 16:58:07 -0700 (PDT)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2055012bbc1sm23848805ad.144.2024.09.01.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 16:58:07 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devel@linux-ipsec.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec 0/2] xfrm: respect ip proto rules criteria in xfrm dst lookups
Date: Sun,  1 Sep 2024 16:57:35 -0700
Message-Id: <20240901235737.2757335-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the route lookup when done for xfrm to regard
L4 criteria specified in ip rules.

The first patch is a minor refactor to allow passing more parameters
to dst lookup functions.
The second patch actually passes L4 information to these lookup functions.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Eyal Birger (2):
  xfrm: extract dst lookup parameters into a struct
  xfrm: respect ip protocols rules criteria when performing dst lookups

 include/net/xfrm.h      | 28 ++++++++++++-----------
 net/ipv4/xfrm4_policy.c | 40 +++++++++++++++------------------
 net/ipv6/xfrm6_policy.c | 31 +++++++++++++-------------
 net/xfrm/xfrm_device.c  | 11 ++++++---
 net/xfrm/xfrm_policy.c  | 49 +++++++++++++++++++++++++++++++----------
 5 files changed, 94 insertions(+), 65 deletions(-)

-- 
2.34.1


