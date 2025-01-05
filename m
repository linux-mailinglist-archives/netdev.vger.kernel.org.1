Return-Path: <netdev+bounces-155232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6DA017BD
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18155162025
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85535947;
	Sun,  5 Jan 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpUKrEzC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1E1EB2E
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040329; cv=none; b=gtlcUMFykTu/JLvrQ+daPnqZNeBJGp+uC2ZmQGrmDQGslslzXcq/3vmHEmt0F3NDzNjUGShAcZeyYiz79+Ox9PWxC8/c4Clgi63gyNe7FGI04SpvZOjwpKU6cEgXoyBxTvhPkTq7OfhB/8zN2cTy2vPOAOIn4AjJrAuRZjbdL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040329; c=relaxed/simple;
	bh=MogOMziLmdew/KAjXObd6PWk1sSGmYytNF34KHm93B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxgaW8crWQgr6DKg/4DXjalcUwa+2tOwFUlwMhv/Cl25myJ1cnwJAx0+ZWc7gkDcug+TIsQjlMqk8/GC0RF6c7aUg6bkrbI/fey6q53Y7B0aWRO+7QlbUi2ISn5394+XzaHqsQMwc7+qxkJp53z8FW6yZD9kcosxtSCA31sQsCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpUKrEzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9778DC4CED1;
	Sun,  5 Jan 2025 01:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736040329;
	bh=MogOMziLmdew/KAjXObd6PWk1sSGmYytNF34KHm93B0=;
	h=From:To:Cc:Subject:Date:From;
	b=NpUKrEzC4BV5KMmdHITw7AgVstU0F6yYaoaG3PgEj1HypjPSRwKoYa8yGwfbgbUIo
	 RJTcWuNY6KcjQPc//d1iBOY6jJp+WkbAIMfzpj8INXO/JWCbGrWqpy66z5lZFrwWQk
	 3Y94Jffl9oI2r8qW123YZfDqJd8TQb6uBGWhBoSw0UX3kjbqAdxix6CnP6Lp4Dcg6P
	 tbweYqqpPfvKCtGpBlww4T0hLwcd4ilkf5sRIsH//uN6lDT1QzLwz0IlRJKNGmSj+N
	 mkQ7L+T5gJUfT2OesATrbVAsnMAepe0MRDiseXaTeqGjPWnSne99R6ggHFjiA8kSYw
	 1FbnwRhvYtseA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] tools: ynl: decode link types present in tests
Date: Sat,  4 Jan 2025 17:25:20 -0800
Message-ID: <20250105012523.1722231-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a kernel built for the net selftest target to run drivers/net
tests currently fails, because the net kernel automatically spawns
a handful of tunnel devices which YNL can't decode.

Fill in those missing link types in rt_link. We need to extend subset
support a bit for it to work.

Jakub Kicinski (3):
  tools: ynl: correctly handle overrides of fields in subset
  tools: ynl: print some information about attribute we can't parse
  netlink: specs: rt_link: decode ip6tnl, vti and vti6 link attrs

 Documentation/netlink/specs/rt_link.yaml | 87 ++++++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py              |  5 +-
 tools/net/ynl/lib/ynl.py                 | 72 +++++++++++---------
 3 files changed, 129 insertions(+), 35 deletions(-)

-- 
2.47.1


