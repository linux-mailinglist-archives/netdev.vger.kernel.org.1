Return-Path: <netdev+bounces-65205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017ED8399FF
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0D61F23B66
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3082D92;
	Tue, 23 Jan 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="AstVvhcn"
X-Original-To: netdev@vger.kernel.org
Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAD81207;
	Tue, 23 Jan 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040565; cv=none; b=LeMlgKQEt9X0CtE+IPLixO6u2nXQpFg0q59hmThzrpAQEN/Z6HopDgkK5hKvsgcw2UdYzZyerYHIjhmsidz3S2uUDQx94pX+VD9P6ZbG4yhwds4SsvKXFnCJpLPgfkjedtCAv1vGfNeOkCzXnumbTn52/Z04+A9IRKlvi+wBF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040565; c=relaxed/simple;
	bh=OBTBIc8SOtlMyu6YMQOyN2VDAczt5GnHSpWK0XQjdaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A83BLXkxD1swZ7BnVlQDGUGMNLFDpvArLw+euKeS3n0jZbpcwAeJohnwgGoOtRBIYHldHyQBmEtjQRCcVq5tNg+qsG5va+P0QwQIzD0PJZ+VW/VqP7RqmrcKCCFHhPoqBLfoLfe8HAn7raE4NpbKGL3t3/+Vxgz2zmxH+fmIFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=AstVvhcn; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LBYELuQUyHOVBta/GS+BfP4GbFgIi2DJ6R3x+RlNpuE=; b=AstVvhcnOjl80I9/lkwJcKJDZl
	gxI8fc3xMsu+EcrF2FhqVSMDJquJuAfe3cEWa6P2fXs/Wxock1nsMxDULNwaRzsqE3N1/YIXQJI4U
	spV3UoLxOzDH+H/6zaP68gq0sCbxmUq3zobyuNdY8AZ6TYQ9ycmPloJIrPAT1n0kCLDQ=;
Received: from [88.117.59.234] (helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rSN5F-0006xu-2S;
	Tue, 23 Jan 2024 21:09:21 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net 0/2] tsnep: XDP fixes
Date: Tue, 23 Jan 2024 21:09:16 +0100
Message-Id: <20240123200918.61219-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Found two driver specific problems during XDP and XSK testing.

Gerhard Engleder (2):
  tsnep: Remove FCS for XDP data path
  tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring

 drivers/net/ethernet/engleder/tsnep_main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.39.2


