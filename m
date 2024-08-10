Return-Path: <netdev+bounces-117381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736BA94DAFA
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC081F21ADC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CD43ACB;
	Sat, 10 Aug 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9ZbYES9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE33CF73
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268606; cv=none; b=alNtW2wKT5ROk22RoFk8KPfWT/OGSRnodELjU872egQaGd3nIsgVM0zGfE7VwR7yI+uG9QpuRnd7pNhCEUOlar7Vco/EbcDYSe+JLxYSpqmva1RpWJLVdmdF3c3W9hhEWutrpmNzXdwyh7FL7YIgB0HPuFKaPmvcPZ/nn+7CoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268606; c=relaxed/simple;
	bh=W+qbRRWdQ4J5AokOQzZeQizuOUpLQhFuk0wxXU8JjFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ief+OWJuXASWHppdziUO/ScCX6Kq6Y7+kKHPd0jz5fNwZ3vM7hi5ATdEtVZCShfv1UsX+PTjzyH94F4KmBIgn+T30yrCEKjZPb1pxL2IX2s4+syksmPXbk1YopdFwdlY+fqqBxlXnu3SwcE0zWa1F33+DCvlijOkWrMhRHWQAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9ZbYES9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA29C32781;
	Sat, 10 Aug 2024 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268605;
	bh=W+qbRRWdQ4J5AokOQzZeQizuOUpLQhFuk0wxXU8JjFM=;
	h=From:To:Cc:Subject:Date:From;
	b=p9ZbYES9nQCrlleWvZ6ITVdibCD86M9On5Dx8JP1wnLCNsVvNSt5zIAp1hnsZUHlq
	 hRQLbGtUSnWJT7hXsKMIaP/d+KTyysUdBPMW57XMuulfMeTX5GZbt0aq2uGATwpSJj
	 4YxVAVihLefY1RVPlELdu1eQwAbOFuWciDEP7pqXgYkUrV2hKQzFNf2GDh3MdAmclH
	 sRePzBMUsIZTu0vkye2y8kE2fMXrWL0gc2vkeK9GbIk+m0FG302/d5NFKmuLj4QdMs
	 GnqZ4wA9I2UqoiDlQ6IeRhtfvLH2gzW05J/KfElsPHPzf2rzTT7/76+34TKyfbbJJc
	 hWeWsV55TV7Fw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexanderduyck@fb.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/2] eth: fbnic: add basic stats
Date: Fri,  9 Aug 2024 22:43:20 -0700
Message-ID: <20240810054322.2766421-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic interface stats to fbnic.

v3:
 - add missing sync init
v2:
 - drop duplicate check
v1: https://lore.kernel.org/20240807022631.1664327-1-kuba@kernel.org

Jakub Kicinski (1):
  eth: fbnic: add basic rtnl stats

Stanislav Fomichev (1):
  eth: fbnic: add support for basic qstats

 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 136 ++++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  51 ++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  10 ++
 4 files changed, 199 insertions(+), 1 deletion(-)

-- 
2.46.0


