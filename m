Return-Path: <netdev+bounces-116960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826794C35F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A961F22828
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA619066F;
	Thu,  8 Aug 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxtmYhGy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FA190668
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136973; cv=none; b=eB7FDWGB1zRNLG/qcafm8jd2UqjyWnKoScJJDsFTDZS0vzPTBDYnvE/xNMQksQRrD7XCtDwzyR5vwBz89qL/fodepfGbeCyLSJiBxVrYS1BjxNxxfl38RDXrq6VbQzYiHHCGe6deISdU/o/pDhIvYLsOjxR9oFOwBaFZegatZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136973; c=relaxed/simple;
	bh=5/GJFwZPamNEqsQ4SMC4FlG4ATU9o174iMBRyrcBIW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s08nps+ccV9n1frFDCx6aCArJ3E1lW6IXOK7pl0xd6Lwpt63hLzmxcmWBZw/HzzZZM2rkpkOMWfFUTksfZfnED80kXEiECw+Nf9wnjOptY9sTeA2Z9vDhg14aNe9DirlvSFiTHOwMVPoQ3ibiAueEW7zzDCcfubdZOGkHZpvmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxtmYhGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C6C32782;
	Thu,  8 Aug 2024 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723136972;
	bh=5/GJFwZPamNEqsQ4SMC4FlG4ATU9o174iMBRyrcBIW0=;
	h=From:To:Cc:Subject:Date:From;
	b=YxtmYhGyiRXpbtuI6Im/MsG2QNV5BOP7jljZH3kQ4HyM+6wCzNco/DMwijiBjAoKF
	 xdx7QNgzcdoOAJvheArPzDpQmhJrG+FQBHmnBTaPCblgtcnScJpEd70Hwus7NRSwl/
	 84MRP1eCLoVT7h/HDuf3gOQXkPPkr3KR4yn3eHhwoKshHVG0C87bsd4JZ3hi+uTd7c
	 UU8SfNnn6m3ZWFtynZE2J/Jq6n6L6g3pBSi0THgN3VkXjKfvZQ/DHCFUzXB9IPFy/L
	 ncDHcYf63k6VBCt5CPqaOvsBS6Ln6/WxhGRhmRmMoGEAulYXNjm3brONeq6cUq+tRf
	 Wy3is4mJTkl/A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] eth: fbnic: add basic stats
Date: Thu,  8 Aug 2024 10:09:13 -0700
Message-ID: <20240808170915.2114410-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic interface stats to fbnic.

v2:
 - drop duplicate check
v1: https://lore.kernel.org/20240807022631.1664327-1-kuba@kernel.org

Jakub Kicinski (1):
  eth: fbnic: add basic rtnl stats

Stanislav Fomichev (1):
  eth: fbnic: add support for basic qstats

 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 136 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  50 ++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  10 ++
 4 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.46.0


