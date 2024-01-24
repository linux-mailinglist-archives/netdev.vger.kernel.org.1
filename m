Return-Path: <netdev+bounces-65651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36A83B429
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B41C234D5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F941350FB;
	Wed, 24 Jan 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwatT+oF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18C131E26
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132486; cv=none; b=jw9lIA8HXgOMq7D8fKgM77O4g2hI5y+GSjnkWy4st5a0Il1jG3NCEtzWcWjTJ7YpAAhX//h9OuITJb121TZGMaoHxVpGbUdARB1SA50z+ru1S69P9n+SkJ8ccWJ4q9/IAmXWvoWKDeHqnPTEbp7KoiGyRexDnSdGHJnRW8msBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132486; c=relaxed/simple;
	bh=igORXiULDvqkDmSN5lSdQw4DNjYBf/fr/uppQofETRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HlTaxDmFXpGyQ31c6geH2l5oNKg7t78WTOMNZkxfR17eUDpZrYYO2LnKr70oV/sSbUWxkTXrVqfvR2yMgHPLXt06DwZ8f+zA5MpapXBoZeJ9Heu03AG/wCBDTf6BGCIBLFSBQW04CC1aFP375jYd+6UBcqPg+vCasYptBYsQr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwatT+oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6820C433F1;
	Wed, 24 Jan 2024 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132486;
	bh=igORXiULDvqkDmSN5lSdQw4DNjYBf/fr/uppQofETRo=;
	h=From:To:Cc:Subject:Date:From;
	b=HwatT+oFTMTYqF2qCjDmD+O9wMCNb4mUXkkdQDWthQ6kbnuvtwEnCyUoCEhYU9Dz5
	 La8aOBvZm+59WhDD38DKXyrXr7P0IbkaMDCIpbd/zadCqUNZgAryGOWRnDCdaV2r7m
	 3rV8Z6QlT7HJBMEEBdwK2UvK+QjFPsMsG8TBKuLb1Wx4dGd8OVkr2I3t7PT3V+qv0N
	 HDF0ACktCA64VT3eMaAIZslsanwRhBZnY7ghhFL6yPghlFWGmmzCPdILAxsIr7p3/H
	 ZwdUAiRuq5enqqSCkkEB9ZY5AYUVu9fpxS1bDE6wrhHVqm+EV02E0nl5n+VNC4piUI
	 ZiPJuUPqrpiug==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 0/3] selftests: Updates to fcnal-test for autoamted environment
Date: Wed, 24 Jan 2024 14:41:14 -0700
Message-Id: <20240124214117.24687-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch updates the PATH for fcnal-test.sh to find the nettest
binary when invoked at the top-level directory via 
   make -C tools/testing/selftests TARGETS=net run_tests

Second patch fixes a bug setting the ping_group; it has a compound value
and that value is not traversing the various helper functions in tact.
Fix by creating a helper specific to setting it.

Third patch adds more output when a test fails - e.g., to catch a change
in the return code of some test.

With these 3 patches, the entire suite completes successfully when
run on Ubuntu 23.10 with 6.5 kernel - 914 tests pass, 0 fail.
 
David Ahern (3):
  selftest: Update PATH for nettest in fcnal-test
  selftest: Fix set of ping_group_range in fcnal-test
  selftest: Show expected and actual return codes for test failures in
    fcnal-test

 tools/testing/selftests/net/fcnal-test.sh | 25 +++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

-- 
2.39.3 (Apple Git-145)


