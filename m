Return-Path: <netdev+bounces-209043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59685B0E18D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24477AC29D6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864C27934A;
	Tue, 22 Jul 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqHp3wir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DE278161
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201182; cv=none; b=bbJXzvOmU2mgpn7nnmFm8CPtTOy8Zf2MhssI8rdxvYuH6T78W8v7xYectlfjQtd/v/NiRGue30BI9ZlCxnHWMEuELSss9riTkxKIYdjLiFW3qqqUCf52BNOK8M1aCO0gHPDzu7FGdZ63dPQhllQwvuTSVl02Z7hm5elqraZ+dHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201182; c=relaxed/simple;
	bh=guT9nYZqOUkjcIPrLcphPFlsHIcYFOxQ9db/JRWGPcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyOZqvJjZiTW18NvGhA5qm3S3QF7SfYpD2bTtdVvdZWCi/LX9gPs2URFMVRc1pZNe8w2+Y3ZgZ29oKHMqwW7LcNroQ8fRGqXvvOr7OP3mYAamb4uf9mwdj/nvI3uF00j1RO9uI5D/pEpY/pwj9jufYRcEAq2nnCiHrs480VzCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqHp3wir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE99DC4CEEB;
	Tue, 22 Jul 2025 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201182;
	bh=guT9nYZqOUkjcIPrLcphPFlsHIcYFOxQ9db/JRWGPcU=;
	h=From:To:Cc:Subject:Date:From;
	b=tqHp3wirkNf2mMaYFQ5uTN+RKdDDWeonW0BF2snXzWFRSBRqroNd2uS7zRbLg+MVv
	 FkpWsHACQ8vgOF/tCvcAYcYIuLgz29QRHyXFVl3wgZPFRlaQpKIfBtDImTfGPLAaIr
	 r8CaMUgLiN5laIphZqJN8ve7mfF/Q4Qe/4+UanEXpw3eKPG/WYtEqv+O8y0Z6W7qsS
	 B6ene4JntMbdRnlJQizBG2Wi8Kv43RIcSpP7f2LAZO98Zh8e9LtR3id9St3cgV4/l6
	 FHKMAXjmP2n/mS74G8a92FiJ1Oegv/DZvqitOfxobgoXjmAPoucqtAxKtJXvaRdYhR
	 iup+N8795HI+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tools: ynl-gen: print setters for multi-val attrs
Date: Tue, 22 Jul 2025 09:19:22 -0700
Message-ID: <20250722161927.3489203-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncdevmem seems to manually prepare the queue attributes. This is not
ideal, YNL should be providing helpers for this. Make YNL output
allocation and setter helpers for multi-val attrs.

Jakub Kicinski (5):
  tools: ynl-gen: don't add suffix for pure types
  tools: ynl-gen: move free printing to the print_type_full() helper
  tools: ynl-gen: print alloc helper for multi-val attrs
  tools: ynl-gen: print setters for multi-val attrs
  selftests: drv-net: devmem: use new mattr ynl helpers

 .../selftests/drivers/net/hw/ncdevmem.c       |  8 ++-
 tools/net/ynl/pyynl/ynl_gen_c.py              | 49 ++++++++++++++-----
 2 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.50.1


