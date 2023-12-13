Return-Path: <netdev+bounces-57110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BB8122AE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98FE2817F4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F79683AF0;
	Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YArnPRUZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647958183A
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84966C433C7;
	Wed, 13 Dec 2023 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509284;
	bh=rY0wvuO984KctszIw6tesCXoa8ZAhzCRJCRlYdj1CR0=;
	h=From:To:Cc:Subject:Date:From;
	b=YArnPRUZgrx1JiSjo20RrhJidMcuA6RhtctkofxAO1ITbv6ezPm6uTF/BPhm7FujK
	 WBhu/Ibbld5lydBcf33hj59V/SkP5mgjisKzAObfwaRlKJN9d04ZS776gYOxdkih7G
	 ZeaNDHeUZodeDBaxW/HTj0P+/pEhQQuispcnIbCYX5Yah/+5HwYzS+X/D4oNnaQdFe
	 5WD8h87m959mWVm29q8PkMZ1CwOOS76Ez3C29g9oqt2oXJ2qu6Gz4NJv6JrsFcoYq+
	 tVQ/BrWeZxkOKtUDhpeyoR9KypJtO0ybpBp2S141IVIQJNaDTlvkS3LA+Q+PKVyL9v
	 5fd8hD1/YmogQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/8] tools: ynl-gen: fill in the gaps in support of legacy families
Date: Wed, 13 Dec 2023 15:14:24 -0800
Message-ID: <20231213231432.2944749-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in the gaps in YNL C code gen so that we can generate user
space code for all genetlink families for which we have specs.

The two major changes we need are support for fixed headers and
support for recursive nests.

For fixed header support - place the struct for the fixed header
directly in the request struct (and don't bother generating access
helpers). The member of a fixed header can't be too complex, and
also are by definition not optional so the user has to fill them in.
The YNL core needs a bit of a tweak to understand that the attrs
may now start at a fixed offset, which is not necessarily equal
to sizeof(struct genlmsghdr).

Dealing with nested sets is much harder. Previously we'd gen
the nested structs as:

 struct outer {
   struct inner inner;
 };

If structs are recursive (e.g. inner contains outer again)
we must break this chain and allocate one of the structs
dynamically (store a pointer rather than full struct).

Jakub Kicinski (8):
  tools: ynl-gen: add missing request free helpers for dumps
  tools: ynl-gen: use enum user type for members and args
  tools: ynl-gen: support fixed headers in genetlink
  tools: ynl-gen: fill in implementations for TypeUnused
  tools: ynl-gen: record information about recursive nests
  tools: ynl-gen: re-sort ignoring recursive nests
  tools: ynl-gen: store recursive nests by a pointer
  tools: ynl-gen: print prototypes for recursive stuff

 tools/net/ynl/lib/ynl.c    |   8 +-
 tools/net/ynl/lib/ynl.h    |   1 +
 tools/net/ynl/ynl-gen-c.py | 190 +++++++++++++++++++++++++++++--------
 3 files changed, 158 insertions(+), 41 deletions(-)

-- 
2.43.0


