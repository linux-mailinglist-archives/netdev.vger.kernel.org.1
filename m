Return-Path: <netdev+bounces-72591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9A858BC8
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F202E1C22E08
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9C3D68;
	Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Z95VV+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49F1DFD0
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129069; cv=none; b=gze/E5tPgKz9/wCMk7Che+rQc2D7gWTByRvd6P8AzDXFNBmZWTfOmR73twTzLcXeka01DNOvt9Z8LbWd0sGixnGat9SUiCo4lrByCyIxUsWIUv3T+mauAfNGAliNu6pLh7L04HEC30tgwm9R6SjIlKW8uUZ1DoTs3dwxJLG864M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129069; c=relaxed/simple;
	bh=0qgH3e2s5Biuc83VUf4CHQtcBpyy/DvDMYCawAXMfBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rt2Hlh2MnaoprwOpQY6vX/xXXRzv7K7xmLTQYNJ9P4e34xGnYGKKlrb+vtpNyFlS7vnhznKNBqiPhS0F8qbA78POW3+9MNiGxZYl/AEHpCdT9QQSDs2sHyUsFhfijbFIuz2OysnKrAOw4Wqd+Zz6P6sMFC9L4d3ArD31UQffTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5Z95VV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED6AC433F1;
	Sat, 17 Feb 2024 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129068;
	bh=0qgH3e2s5Biuc83VUf4CHQtcBpyy/DvDMYCawAXMfBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=b5Z95VV+9QL7QZfuxM69sdGzVhQDj5hJjlVvL2ZV2meU7pe8rVMMDyV2Mm9yOEiH6
	 btQWOkAmMBCBhrpNjkatWSQeCrn/eDVFqLfHPzmtsLpMj+ScyD/l3W27TlTz0ps/Nr
	 OYSaIeF8Ky5djnK9jBFJSkMq0fOzAhb2xS+yk4koHdNNF4tQyJBwdjlncwGt3xbbZ9
	 6X/WYpROHqzIh/hzCOmuOESLnzT7EMMzxcv/dmDjA/E4TWcpQU940C7zurzR2yTQVj
	 j3AcOt8/Krv4WA3XvQqtgp3NQmRFet6lJAfO4C9r3JuUpwpDxsklK+mlU0iEWcoDnu
	 tluMGXRyvsucg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	nicolas.dichtel@6wind.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/3] tools: ynl: fix header guards and impossible errors
Date: Fri, 16 Feb 2024 16:17:39 -0800
Message-ID: <20240217001742.2466993-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix header guards for new families. I must have installed the latest
headers on my system when I was developing. Now it seems system update
overwrote them back to something slightly older, revealing the guards
I put in are wrong.

Also fix bugs discovered while I was hacking in low level stuff in YNL
and kept breaking the socket, really exercising the "impossible" paths.

Jakub Kicinski (3):
  tools: ynl: fix header guards
  tools: ynl: make sure we always pass yarg to mnl_cb_run
  tools: ynl: don't leak mcast_groups on init error

 tools/net/ynl/Makefile.deps |  4 ++--
 tools/net/ynl/lib/ynl.c     | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.43.0


