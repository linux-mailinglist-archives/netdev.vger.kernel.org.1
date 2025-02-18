Return-Path: <netdev+bounces-167493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CEA3A7FF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD3C3A62BD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371F91E833C;
	Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAqPZIwK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BE1E8332
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908251; cv=none; b=paPea3/KEkbMQG4gI23cQDq+HTqFG0PpQaBmnX0zSCi71TKlthUnCoNzG8wK1UEasdo7OQbnLgg3w+vx//GonUtbdA3wnONg7KsqSwvZYpQaMZUOhIoUuMm6ZnJ7TxocJC1QRnV/XNteSPuZEBx6bYic5T3/6aJinMTE4mGzKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908251; c=relaxed/simple;
	bh=+QVZ2b3j2vGG0rAR+pFlZvRLmKdon7U3eD4hbt8j28Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYnSynRye17WKcP54DiuIVBZBX0xEk3o5N/1RRh8v2HRbs8aF7A4kM5Ms38sbQGHhBzligjwalOM3W6veqeY1vX/328iP/dDmbWFSGl4kzSELytQ0SGb6JrGkwF/xCQuqwB9zQfs9YFHpGmhtBHJjoPT0Gi4PSbEZBr97c2mgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAqPZIwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20172C4CEE2;
	Tue, 18 Feb 2025 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908250;
	bh=+QVZ2b3j2vGG0rAR+pFlZvRLmKdon7U3eD4hbt8j28Y=;
	h=From:To:Cc:Subject:Date:From;
	b=pAqPZIwKxSKdFdO4Z/myCeKBRf6EiydAwC6wczNijsZeuOilDVd6X9LMP5gL3g7PW
	 dZcsB0U7enqBiC+oY9ShbPfP8NG1Foyea8hs+nBCa9PCeMphKtTd8khmGjt9AlV/qG
	 ZmFYRNbL1xZ/Eq0v5KXkJhIPmfTXSLcrXo55T7oWb7seNNwmvnH82ndhZIaaR5iHg/
	 Ajmd3rtCO9COEdSsAz+8ydK+EVHMhi0cshyHMnp0qWgv1SAUCmN+LcDlr07ViwZOCP
	 c6zwzvVFSov5LYIZsGi/+a+uZM36fUzC09nWl3XpdYznI6RoAI4lgIfFrQ4bjsqqqE
	 bUsQX4zratecg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	jdamato@fastly.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: drv-net: improve the queue test for XSK
Date: Tue, 18 Feb 2025 11:50:44 -0800
Message-ID: <20250218195048.74692-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We see some flakes in the the XSK test:

   Exception| Traceback (most recent call last):
   Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
   Exception|     case(*args)
   Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
   Exception|     ksft_eq(q['xsk'], {})
   Exception| KeyError: 'xsk'

I think it's because the method or running the helper in the background
is racy. Add more solid infra for waiting for a background helper to be
initialized.

Jakub Kicinski (4):
  selftests: drv-net: use cfg.rpath() in netlink xsk attr test
  selftests: drv-net: add a way to wait for a local process
  selftests: drv-net: improve the use of ksft helpers in XSK queue test
  selftests: drv-net: rename queues check_xdp to check_xsk

 .../selftests/drivers/net/xdp_helper.c        | 22 ++++++-
 tools/testing/selftests/drivers/net/queues.py | 55 ++++++++----------
 tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
 tools/testing/selftests/net/lib/py/utils.py   | 58 +++++++++++++++++--
 4 files changed, 103 insertions(+), 37 deletions(-)

-- 
2.48.1


