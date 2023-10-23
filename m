Return-Path: <netdev+bounces-43497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A027D3A9A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF273B20C68
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662671BDD7;
	Mon, 23 Oct 2023 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI4J94no"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB414F67
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 15:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692FCC433C8;
	Mon, 23 Oct 2023 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074627;
	bh=iOxWNBgcDlCnQ94OJSssMGSHTliZNlJJRj9XqeuwTDM=;
	h=From:To:Cc:Subject:Date:From;
	b=jI4J94noqlcCg8tfCSm4qfUHRbHmnGyGY4M53yh1MkFgbRbwe+03fGMk15eBwFzuV
	 LeQNn9eboxPH48TjUk7p3FHWcQdkKctwmmVLzCD6tUz0vNxKjFodXqVpGB4GpOdeNV
	 ugO4mCie6vI6Vem4hdda62IcyzmPW5IbYOlX6PnehrJKRtRPpTh0TzDFG3bY7J30lZ
	 GUm1oDn+PpgC97nOwchMkqCrIo8eN5g+J8ZDrSJmErlhGb6h2h0Fxg0wLL6sHmimIO
	 GGp7orezonYaWJUcFKvtz+o/yHfRX4iRruJgaUBLNQ3VbPjw9afC+LuJvB9837KE61
	 Chf/gw4NTaSQg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes.berg@intel.com,
	mpe@ellerman.id.au,
	j@w1.fi,
	jiri@resnulli.us
Subject: [PATCH net-next v2 0/6] net: deduplicate netdev name allocation
Date: Mon, 23 Oct 2023 08:23:40 -0700
Message-ID: <20231023152346.3639749-1-kuba@kernel.org>
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

v2: extend commit message on patch 4
v1: https://lore.kernel.org/all/20231020011856.3244410-1-kuba@kernel.org/

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


