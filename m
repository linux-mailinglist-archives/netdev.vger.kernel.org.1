Return-Path: <netdev+bounces-107461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AE91B195
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28743283D30
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45203137923;
	Thu, 27 Jun 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGM5mN5l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F85249F9
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524155; cv=none; b=O9inhdBiOSEmIhsU8colhsv7R5C18O5hbgHSexLhItQ1g9mJB157szsmloewyg+ev/Gbnxw22SU0B4pgd9DKBG3alX46t58FwwTiUs2GGHsF630/46EXXWGxtUjMCXnMNpmvA2ZR5OiVwT3Q+tgzvQWuQInqegjgoJ6N3iULZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524155; c=relaxed/simple;
	bh=w651+bH74F4xq2ITaLMns5CL2ZeVy7tuG92jgeftqzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8C/XMoASGmuP6rb+g/DktJZKLs4HWiuVWRsNheQlBpA+c7IOoeIO7zw52s4Q3lFuxaceS+n7oBHLQhVhJIekNvOMohJVMNVJF15gkuC0kMT12aJZIokYZtGCmGQ263GkNDGLbjRmhIAxQZze52krE+PSjYr3arT81tpxbtB2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGM5mN5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C5C2BBFC;
	Thu, 27 Jun 2024 21:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524154;
	bh=w651+bH74F4xq2ITaLMns5CL2ZeVy7tuG92jgeftqzc=;
	h=From:To:Cc:Subject:Date:From;
	b=OGM5mN5ljYf34iBQCv/KO2z2jbajlU0aGlbE7l032v/4g/hZbAGU+C5aUzrcbL86o
	 0nTkeSTIBXleWuKHhFCyt8K3Sh6x7WJ/7HdzrW4YeBVnW5a2vYLkk2DK41zo/9B0EG
	 d/oSqo4YcrF+q/ayQC4xQJPkXZLulPk2OJWDPTLIMbJWKGj7tBRs2xd5uNT5NK0uLA
	 J0KwWoH4b2lc3Up2SlvwpD28rk5K+J+Y7xPNEhNyFqXzPfnKYup/d8Cdh67u0Mtd8w
	 4jJ7qtxXomPlRBDB98LMo417qofx8L6yQ5k4Uz4Wee6jlJ2czfZ6/oqc5hE0rzIOsi
	 qTWLceJDeOiZg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] tcp_metrics: add netlink protocol spec in YAML
Date: Thu, 27 Jun 2024 14:35:49 -0700
Message-ID: <20240627213551.3147327-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a netlink protocol spec for the tcp_metrics generic netlink family.
First patch adjusts the uAPI header guards to make it easier to build
tools/ with non-system headers.

v1: https://lore.kernel.org/all/20240626201133.2572487-1-kuba@kernel.org

Jakub Kicinski (2):
  tcp_metrics: add UAPI to the header guard
  tcp_metrics: add netlink protocol spec in YAML

 Documentation/netlink/specs/tcp_metrics.yaml | 169 +++++++++++++++++++
 include/uapi/linux/tcp_metrics.h             |  22 ++-
 tools/net/ynl/Makefile.deps                  |   1 +
 3 files changed, 189 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/netlink/specs/tcp_metrics.yaml

-- 
2.45.2


