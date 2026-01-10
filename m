Return-Path: <netdev+bounces-248764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A7D0DF2E
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 318EA30028A5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D93A23ED5B;
	Sat, 10 Jan 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1BrfOH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B31EB1AA
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768087911; cv=none; b=e9rlqFdPKb63Mg+0rpDhdLeC5NgDJUnKCDwVLAzanUI68kxu0UcU1W22PQ/ywEUjPY7wF05iG/F+mrMA3ui7N3y5CnQN7wjKwlYjTlz6r/vn3gff4YSMMP4VorMzGa/5dc9XECd9QkiFFQPN1G6nP8/YkNB/MQjUYWlRFgyXNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768087911; c=relaxed/simple;
	bh=e4nrL/o77Jh2lfebc/JqTD54LoppUAHXSRVg8p9qI58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUhg2xcv5UvtDRrhMxbJIC6bOuG+DZkap2GPkOBMOdzJWJlyRMNYsPsCQngSw5xzMW/9AFOCjQUdU0ComtSbZDxE8CkMDU0hWF818HW/IyDZMeip/BrXLNq4ai8WzCqv2vCdFANmuy0ZW9GxRorpYMJIq/xaiDsOcKOtUH/G9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1BrfOH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414B5C4CEF1;
	Sat, 10 Jan 2026 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768087910;
	bh=e4nrL/o77Jh2lfebc/JqTD54LoppUAHXSRVg8p9qI58=;
	h=From:To:Cc:Subject:Date:From;
	b=U1BrfOH58KyUSocIJ/CFgfUMFnx9W1Ij8tiqA8KBBewYOYvw/CT5BxvpkX1ge9/7X
	 /RsI87ZC5tgkoBfm/tLcrGg8lh/lKalWDWsIMIwFssWPkqc3eyL+9BH2FMT/qPXU/X
	 HVJLZrhuvpSbhSzK93/2u1kGJl1xJvQTei0uwFOJBzErZC3uq/i+gSqZgUvrNCZkbS
	 cNUlVvzIYy2FbjoZ4v52cKUgrlj+xYvUAAEqeXCFn6g5qysab98AU1aex5lWm95Lrt
	 8BhRLs3421Dp/tYxUwx1GvfkGQNkVjQxTNIWscxss+SzI1n/FEMaqm0YdAR9TOEC7a
	 3UEjbMbPab6BA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	donald.hunter@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/7] tools: ynl: cli: improve the help and doc
Date: Sat, 10 Jan 2026 15:31:35 -0800
Message-ID: <20260110233142.3921386-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had some time on the plane to LPC, so here are improvements
to the --help and --list-attrs handling of YNL CLI which seem
in order given growing use of YNL as a real CLI tool.

v2:
 - patch 2: remove unnecessary isatty() check
v1: https://lore.kernel.org/20260109211756.3342477-1-kuba@kernel.org

Jakub Kicinski (7):
  tools: ynl: cli: introduce formatting for attr names in --list-attrs
  tools: ynl: cli: wrap the doc text if it's long
  tools: ynl: cli: improve --help
  tools: ynl: cli: add --doc as alias to --list-attrs
  tools: ynl: cli: factor out --list-attrs / --doc handling
  tools: ynl: cli: extract the event/notify handling in --list-attrs
  tools: ynl: cli: print reply in combined format if possible

 tools/net/ynl/pyynl/cli.py | 207 ++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 63 deletions(-)

-- 
2.52.0


