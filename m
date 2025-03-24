Return-Path: <netdev+bounces-177037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61791A6D765
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990BB3B37D2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961D25DB0B;
	Mon, 24 Mar 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYyDFxs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7025DB07;
	Mon, 24 Mar 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808600; cv=none; b=uWdOxEILWacnFnzjH9XEt2jcx8AiiqlmBfkSUsE0Hs+ShG7Qujg3SRlG3y9Y6z19d/cEvOGF9usOSINo5HyfrGJQ/7u60nU5iDSzsY3A3RrsQaee0i9GdSQUkGXu1RHyjxV+NGZ2eXU4Pkpsf2lEln3z7cFOT+H7X7zPfNkgtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808600; c=relaxed/simple;
	bh=kHfo3Vih2l9KqIfcBsMDzy1nd79VOQV4cHZiOu5Oohs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvvEtKxsmavc/wAPbk8eDbjaMSJDuobN4ZisHI/QngZX3HbYn1tcQZMLpfe53SQdqiGE7XHJk49OPZY/RIQw3t42ukvX0gr7Mv8Z8ZO2IFETrS1tXu0tz8RqBwP0MnIa3ts+dWVWS6c7Q1pAkJPtQ7DIp4mQL0jeRf4K/fth33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYyDFxs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D84C4CEDD;
	Mon, 24 Mar 2025 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808600;
	bh=kHfo3Vih2l9KqIfcBsMDzy1nd79VOQV4cHZiOu5Oohs=;
	h=From:To:Cc:Subject:Date:From;
	b=jYyDFxs+4KJxugNp064ddqYYC75ZQBsQjnzXTd6fFhpbmsiao6QTJHteOJm1Gc0in
	 GT9cQIQ2RnmCZEdXRJfGLzGH0HqdZ2LKe3l3sYWkTxIUsZaTdQkAJto7Qffz2R6UN1
	 nMzf2t2kHwdZOLYN7XW76bLqPImdlsYYeYqtPdHI3yeK6Aw3GSxGJVPYWIrRszmQxm
	 8vKxtdqdyQDZsShTNob3cMX6ORR7N2gFIuL0Hsg30dXjav9g2t2pZ2q2hhcM31/eAB
	 PNaHGFH6iHK1hSUOlJCHy12nuR5Gg5nV9cQJ4GjbwA9fPw8Cc3ox0Mg7lDsb6yObsA
	 /5WxCIMxtLuZQ==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yinggang Gu <guyinggang@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next v4 0/3] stmmac: Several PCI-related improvements
Date: Mon, 24 Mar 2025 10:29:26 +0100
Message-ID: <20250324092928.9482-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend of v4, rebased onto net-next due to a merge conflict.

Changes in v4:
  - Add missing full stop. (Yanteng)
  - Move forgotten unused-variable-removes to the appropriate places.
  - Add applicable RB / TB tags

Changes in v3:
  - Several formatting nits (Paolo)
  - Split up patch into a patch series (Yanteng)

Philipp Stanner (3):
  stmmac: loongson: Remove surplus loop
  stmmac: Remove pcim_* functions for driver detach
  stmmac: Replace deprecated PCI functions

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 27 +++++--------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 24 +++++------------
 2 files changed, 12 insertions(+), 39 deletions(-)

-- 
2.48.1


