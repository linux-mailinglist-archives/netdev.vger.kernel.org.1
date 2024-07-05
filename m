Return-Path: <netdev+bounces-109329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A61927FF1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287C8287849
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A37E9;
	Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osk/RGbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C48634
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144651; cv=none; b=XhBPQteHsDr1EZS8GsBNcqRAG8uorIC884Vo57IRBAoLcHjfMZSQ70+NXTcFFoDWNBX+SuzHL6HLnarOCfKDFPCspLD/jdp0JaoLOW2emAyxuBLuA/iIkHVWRYO1Ib9+3asT+dxaC9I9evyuJ1KdPu+Eshh6aBBFZrn/5e0Ipr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144651; c=relaxed/simple;
	bh=piHuhkCiPg1WnNAuB02eglZ07Uz4GyO+RIAbnkhoEsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQ3n5GS1fAb7zzc0/eAbqNYEw4eUHYtaPIzukn1bjrlSxnf4ylZfnjnMx6zdUQiKOX4ujSfUlZLfArPOpomnHfKlfG+WJYW8qtocNHfHtdR/+WodbkNe4HaxqkSd8leTURBScZPXM15ulvTtVvSRb88NzLgj0HVmc412jtSzFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osk/RGbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F247EC3277B;
	Fri,  5 Jul 2024 01:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144651;
	bh=piHuhkCiPg1WnNAuB02eglZ07Uz4GyO+RIAbnkhoEsk=;
	h=From:To:Cc:Subject:Date:From;
	b=Osk/RGbp1K7ntsde23p+L6ZPY25xXpfzFtCrjhQq7BI1mP7EKYRXMpy3JX8/+lhNr
	 YQPg/7+o9FF3InDrBvSfaZQ1UCBEif7qiztQwX1rPLWaJV2tN1zNxlvGxBhI8NKCUp
	 Po/3mATlyDakA+n9IPbOaHZ/6yKxUtSOOohFM2FiSoTf8xN8UAm7hcIMpYlhxRoO4u
	 cZ3NrsiOSYIRym3BqpYpjmjaHWMD+lfWU3rLto/1zfCgqA+ArZKdvkBk9iU6PuetI4
	 AG0IEAOavNRQQ0olzz4+XNKb/Rd+zERD/M8pJHq+KF1tqJjFETWdsTJG4wBGMSI3dz
	 N3YoHOPj/MWPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] selftests: drv-net: rss_ctx: more tests
Date: Thu,  4 Jul 2024 18:57:20 -0700
Message-ID: <20240705015725.680275-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few more tests. I think they work. Commit 5d350dc3429b ("bnxt_en:
Fix the resource check condition for RSS contexts") does not appear
to have fixed bnxt for me :(

Jakub Kicinski (5):
  selftests: drv-net: rss_ctx: fix cleanup in the basic test
  selftests: drv-net: rss_ctx: factor out send traffic and check
  selftests: drv-net: rss_ctx: test queue changes vs user RSS config
  selftests: drv-net: rss_ctx: check behavior of indirection table
    resizing
  selftests: drv-net: rss_ctx: test flow rehashing without impacting
    traffic

 .../selftests/drivers/net/hw/rss_ctx.py       | 206 +++++++++++++++---
 1 file changed, 181 insertions(+), 25 deletions(-)

-- 
2.45.2


