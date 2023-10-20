Return-Path: <netdev+bounces-42840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3787D0611
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1348B282330
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 01:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D438B;
	Fri, 20 Oct 2023 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxFd5UOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB2377
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A5C433C8;
	Fri, 20 Oct 2023 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697764738;
	bh=SGuM9/qPcTd1VDtpMA93SNJkVGI4h5IGiJtZMXvYw+M=;
	h=From:To:Cc:Subject:Date:From;
	b=GxFd5UOb2ocQd5F2NjJ+/Aef9A4B5fisReAEmYqhszh6jGHVLj4teP4j2KRMkWJBo
	 zmrPzNoyZ2GpO+ePh60V6PMqMzWKAztDaTz77lZ7QxKqT1fKgFsK5YwY7rzOdEYa1A
	 mHPJbKVLPSbYgPoZWeK2dVWedY2s/SAuN689P/Q6Q1TN/lEdp8kvOc/rTpsoVF9IAK
	 qedfjUA0zRcDMG1UQgxsFKSRXbJ1de2edrphGihDWJp8hQsdJiUECHqahmjJ6Q6gVj
	 p19bUfFWK6tVIJzB1sAUc3f+zN9RA/MJe+0e8B041/5+7NI4uNRDZ4x29TH2zG8NdF
	 zYA91/KWZzu+g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next 0/6] net: deduplicate netdev name allocation
Date: Thu, 19 Oct 2023 18:18:50 -0700
Message-ID: <20231020011856.3244410-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After recent fixes we have even more duplicated code in netdev name
allocation helpers. There are two complications in this code.
First, __dev_alloc_name() clobbers its output arg even if allocation
fails, forcing callers to do extra copies. Second as our experience in
commit 55a5ec9b7710 ("Revert "net: core: dev_get_valid_name is now the same as dev_alloc_name_ns"") and
commit 029b6d140550 ("Revert "net: core: maybe return -EEXIST in __dev_alloc_name"")
taught us, user space is very sensitive to the exact error codes.

Align the callers of __dev_alloc_name(), and remove some of its
complexity.

Jakub Kicinski (6):
  net: don't use input buffer of __dev_alloc_name() as a scratch space
  net: make dev_alloc_name() call dev_prep_valid_name()
  net: reduce indentation of __dev_alloc_name()
  net: trust the bitmap in __dev_alloc_name()
  net: remove dev_valid_name() check from __dev_alloc_name()
  net: remove else after return in dev_prep_valid_name()

 net/core/dev.c | 120 +++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 75 deletions(-)

-- 
2.41.0


