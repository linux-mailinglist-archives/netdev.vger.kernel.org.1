Return-Path: <netdev+bounces-122109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96895FEE8
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F001F226B7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C98DDAB;
	Tue, 27 Aug 2024 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FQJZdwzf"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A6D268
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724975; cv=none; b=DTs1P7vbDXF1H81gbJE5qnItYPZTuj3RFXONqlYxRkGzpmH4bScZlniQBZQFmiWW/bwaVdrzfKu7wlG2u2/qk2QHUh2P85Flj1ZVeWUOmjnZ/VwzF1+pZbh8oAc+/0+s78na1Es5Qr2BJHWuAONfS/V9AOnAD79D99u2lkdsDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724975; c=relaxed/simple;
	bh=gYxiPy6F41VAop4YJfculBMWWwkcBqpuG8DC0/ZcqDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kH7BXl0pMrAmRUu4JZyQUgG+S2BSOdixHjRsvJosm2gvQu1dKKycycaY7/H9ifzTewsK0cst2JgM9pAClMI0wLVFpliDySffVjKAcSHY35mNLtby1WhDBlrPf3USE0RsI7WNOVQhO1lv7k4ny+ggf96X4kmPdlNN/AcBB/Zi4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FQJZdwzf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724724488;
	bh=e/Uc0Oq3+vPGjFbt0hgCJkx4UqmKqwmhU8VozyRahRA=;
	h=From:To:Cc:Subject:Date;
	b=FQJZdwzfaUEBia0oAGj6ch466yBl34ANrGnVgaJ/4ia2EFQeUxysx4NPT6a0QSE1e
	 XKm9TysK14NDxJcAreq6zcLHDLhCXJBmiN0b8IT7BwSHIj+1kZzB/Fu0T/TReSkJwy
	 pW1M+wj5uznHEE4cVpP5ifABxRYT6EOblzXj1QQs5LyrdSwsdXj7E4J6mTpgGtaDD0
	 s93g0FNq1x+1+FYmOqrkpRQ77Mgyor0TN3lBiUI+Os58Am9b6KFba6JDFaSzEAjY1g
	 DOsx/zf7CCy0TtIVUT2gShNfnHwe4HM54krCSBkFmKnpocWXv5jllEYtp/2S/j2+Ax
	 jXfWcOlGKc2dQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id A1613650CC; Tue, 27 Aug 2024 10:08:08 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
To: jk@codeconstruct.com.au
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net 0/2] net: mctp-serial: Fix for missing tx escapes
Date: Tue, 27 Aug 2024 10:07:57 +0800
Message-ID: <20240827020803.957250-1-matt@codeconstruct.com.au>
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

Matt Johnston (2):
  net: mctp-serial: Add kunit test for next_chunk_len()
  net: mctp-serial: Fix missing escapes on transmit

 drivers/net/mctp/Kconfig       |   5 ++
 drivers/net/mctp/mctp-serial.c | 113 ++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)


