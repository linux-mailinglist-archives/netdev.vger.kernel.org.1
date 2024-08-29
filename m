Return-Path: <netdev+bounces-123146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7B963D65
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436A51C20FB4
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6321891AC;
	Thu, 29 Aug 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OD8LrsS8"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E291487D1
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917455; cv=none; b=dAF2uDqmmdYf4FC6o67FftDE0GmjUqiilk+Ys5a/3BEWWK/RafbPaT3NbHquHIe9auNHxatgQHtGGKD11cswguimQVvVJfWOOKHFKDZTLPkSrQ6+73EuVUaf8bNd50wfHfFKwRz6zT66Lkip7uQV2VAhxol0m/wklgJLiGVdZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917455; c=relaxed/simple;
	bh=7uPmpdl4nkxJxr6vbu9DfzSXWiYsCoYE8yTNrcXHFNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCo9y4q4aqJin27PAzi+HbJwq17ykgYWxKrvonoGUxLKwUBVjweptBctUrsE1imfIyUtHCSaa4Sk2Z6Wy11My4jvwzPDAfL2/wRFI8JQbdmlTH8vHQLSvY85GO/nNeAfvmaBgj3ZrfP7qFSgx316Gd7AT7drrQ069Ca8OWnKHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OD8LrsS8; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724917444;
	bh=+aWL5cZMu7VJGwZeMsJBvtZtznkNvawVqjMxM423Jzg=;
	h=From:To:Cc:Subject:Date;
	b=OD8LrsS8oobrd26Qjr+fP6pvzsoCNutd+CxL1CEiPWkX/yhBTQoPMp+r92grH2Xoi
	 b5B7M+rJ8CIwHFp/tTeZrUdt/hfKLr53gu+jRp2CwChGqIYMPXCNAnSMEU8MqHSr1M
	 k6LRo5Wv+wEvKeR6dh4vhgozTEopk/WRQeW4WoAMvDNfam6f4M2BiqwD4FTcdvETje
	 bihqxTNU8OniR4ELqw6rgTXvWvLkYBPhWNFsCd/ojqhyPaAJG2gN8DMHUsUaGTsonC
	 NYCbY8g02E3OU79stK9BX7BlVZXGI8/+E6SeBIwxFiV53v8c5ef/05F+Tth06tLIEW
	 g7KGkIH6klElQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id E6DA967504; Thu, 29 Aug 2024 15:44:04 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/2] net: mctp-serial: Fix for missing tx escapes
Date: Thu, 29 Aug 2024 15:43:44 +0800
Message-ID: <20240829074355.1327255-1-matt@codeconstruct.com.au>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mctp-serial code to add escape characters was incorrect due to an
off-by-one error. This series adds a test for the chunking which splits
by escape characters, and fixes the bug.

v2: Fix kunit param const pointer

Matt Johnston (2):
  net: mctp-serial: Add kunit test for next_chunk_len()
  net: mctp-serial: Fix missing escapes on transmit

 drivers/net/mctp/Kconfig       |   5 ++
 drivers/net/mctp/mctp-serial.c | 113 ++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)


