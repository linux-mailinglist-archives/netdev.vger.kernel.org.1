Return-Path: <netdev+bounces-209410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42893B0F8AC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BB41792C2
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F83202C5D;
	Wed, 23 Jul 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah0n6GxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC017C91
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290660; cv=none; b=lx6pXF/ZpKGW07MH04swNYXBi8m+mIlA3q8eRZOMC9zHMWGRXyMkDpHFw/0OMpMxrmJWgOWsOrrc24lot/BXfHWE++TUqokv0JLD205JRd9qEm/qExsXohuIGFiqP6PvxmBaJz02zGREWLDJw1ellr0saT6dVCxn8Z4tEbThfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290660; c=relaxed/simple;
	bh=THXgwxDWVFzkgaiTOINNwvFzom9zp0v2nbXtIXCkGfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIiVQs4vNQ90ky3JJT7p6OYtKQPAQ0Ff9IsociAKOloi86iPkaAtG5G5fCP0A9awMdrT8c4rOz//sr49bLXM2iPDloty33CZA12CobbL0spo2K5n3GLYJcdUTsX3oLPcovy5AOiE0aegHAc8gazMw8X7Z+mBJ/vwMujufBD94JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah0n6GxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA84C4CEE7;
	Wed, 23 Jul 2025 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290660;
	bh=THXgwxDWVFzkgaiTOINNwvFzom9zp0v2nbXtIXCkGfk=;
	h=From:To:Cc:Subject:Date:From;
	b=ah0n6GxU0IwZKCwN1aHhtmzcUTPLGhJWSkVi/ug9CHEovG7Lbp8MMudV7Sj/BMEJ2
	 zK8Uibmn9hKce28yK3VVnWKdG+3y4Yvox6ub14NN6fRPyEqqwYA5CGxPTOO2ZhfcaN
	 xCALi0+vYEpGp93Be5yxQJ+9HREipD5PE/3+0uRi9yCbU5DWcS4VkDViGLntsPG7N7
	 gtPLaHaIg/IVfdNreSi2cdXoTJ1FZ4nw6+zMyoc2AyjPJ/MaLZQDsV9YWSCs7nHDDZ
	 y41WMAjiQ5qO9N7bliR3raNXFyqnXP5iEvDwAW1A7FwnrpuPbHnQZ/FbX9XSe8QGNa
	 9GvxgHvN19piA==
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
Subject: [PATCH net-next v2 0/5] tools: ynl-gen: print setters for multi-val attrs
Date: Wed, 23 Jul 2025 10:10:41 -0700
Message-ID: <20250723171046.4027470-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncdevmem seems to manually prepare the queue attributes.
This is not ideal, YNL should be providing helpers for this.
Make YNL output allocation and setter helpers for multi-val attrs.

v2:
 - rename a variable to args 
v1: https://lore.kernel.org/20250722161927.3489203-1-kuba@kernel.org

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


