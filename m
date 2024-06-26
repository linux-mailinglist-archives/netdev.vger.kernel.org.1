Return-Path: <netdev+bounces-106731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A89D9175AE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AE91F21FF7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0351F4FB;
	Wed, 26 Jun 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAiJkJsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90D1755A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365779; cv=none; b=tGpLeboMHNY6pIAO68qegfT2fZ2lTtQGjIxFYTTAKVXdXSaJdGN3eGrT+mideX/XrP/bRyjA5lrIxkf+59uO4uGoai+DjRc0oFp9Z63GVgv3vowouO1QJOXatmDv+SE2zHEPN2sqs19tQr41o4AiW1nLlpt7YVnp7HhbvkD+R4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365779; c=relaxed/simple;
	bh=8ip5z7kOI+dlaq8i6LjHx3Ct6SgS2W7H7meKjmI2te8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2Con+Oy1jTPy5RqgULKdGd43Lm2kOPvkt3+oQHKen75UbVwueNNXuoDyMT351idRdhdJQeaJq0pmULoKqbgXURuIa54FfNnOZxi5LuwF9DbRvgk31ZhQYQl69vdYdqZi4hKbkbvAYkhd25UnWsNBCiMyyPE/BYg+Hi8xwGdJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAiJkJsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A15C32781;
	Wed, 26 Jun 2024 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365779;
	bh=8ip5z7kOI+dlaq8i6LjHx3Ct6SgS2W7H7meKjmI2te8=;
	h=From:To:Cc:Subject:Date:From;
	b=hAiJkJsiFkF16+F85hmd/5j/l+wrHUoj+S5KqV9STj4YU1WMbkzOO0UwiokcwPqY2
	 f0Pqk4u3CG+bc0DcZovvFblwsCTXrGj6/hLAd/9IWRC6aituqpSTyhD/vBOXcRUuEf
	 7PbzUNUR82l7U8jrIUtUbUCzDZavRwgRsbXk5kgrtqQc5L15DdnZn4nRiUbMLRrNx+
	 YAiaEg3FOu1P0riAbTXL1icSFHIGVtrjVP5ne2hDjUvLfbY66Ngw0tWN+GKgnsXqDS
	 snaVVNBjSUTRXiCmQ2syoEzf2V0er1oz5iziX7yXqivgM50++dSW78lgAoVPBSLKTs
	 9tcJTgXxbzA7w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	przemyslaw.kitszel@intel.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 0/2] selftests: drv-net: add ability to schedule cleanup with defer()
Date: Tue, 25 Jun 2024 18:36:09 -0700
Message-ID: <20240626013611.2330979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is on top of the rss_ctx patches.

I don't want to delay those from getting merged, and this may be a longer
discussion...

Jakub Kicinski (2):
  selftests: drv-net: add ability to schedule cleanup with defer()
  selftests: drv-net: rss_ctx: convert to defer()

 .../selftests/drivers/net/hw/rss_ctx.py       | 225 ++++++++----------
 tools/testing/selftests/net/lib/py/ksft.py    |  49 ++--
 tools/testing/selftests/net/lib/py/utils.py   |  41 ++++
 3 files changed, 173 insertions(+), 142 deletions(-)

-- 
2.45.2


