Return-Path: <netdev+bounces-136619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89C9A2678
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA471F233A3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5C1DE3DA;
	Thu, 17 Oct 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrVmaocJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714C111AD
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178666; cv=none; b=R84QbNwh8SPIXeXdcaO8cKQ+owD/LCKrikqz/DMrhe2OeNhRFK7uoH71e0YxEK9hYOVrTDAxq0M17YMww0JYPnbg94jv/29/4uYifLXr92OO5XiX6YqAO2PlLoulV/Ktxh5aZwopBEH9Y5wijb+OH+a+c/eyFTH3bpyYg64iAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178666; c=relaxed/simple;
	bh=ekFKhbbow6YsoEQi2mt9jGptC/XVzOO0TQI1cLyom0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/H2u4ZibqQb+eGb66vmJA25i5q7+VdwdH4tB70u2twGhLtufJik/TKrik65xZ6M2SwUsijqSr69mDPS+gRADZN+YjP3lCcVK/NOrf3t6Jrz8o/IPBHbPWmGiSel91YU66Vb+3QXHakoeZWFRLprZbCTAColPTz1GNES/EmwUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrVmaocJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CF6C4CEC7;
	Thu, 17 Oct 2024 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729178665;
	bh=ekFKhbbow6YsoEQi2mt9jGptC/XVzOO0TQI1cLyom0E=;
	h=From:To:Cc:Subject:Date:From;
	b=XrVmaocJbIDmnKy6XkUEaKdX44mdfS+XQI1fBE4CC3SRPsxHZyZi/y2M3+E0CcEX6
	 ykdZaKgjiZW/pSb4gm+oRjwFGD45jU/4Li0W3T5qusEYA5HiqJqIdI1y5z/Mt1QkZs
	 yvzNABG4v5CfjpQiZnMHSNW3Z5Ovstptnzbg3/SFQBcc/2hjS8SWLVhWhsfo3muM5o
	 4WOVYb5US/nmtfZ+LiZGv/WcsMm0Xct/Iqr0RH98a8WXgsHoYCB6fBMjtAw/DbuOO0
	 rOVNuOafqKZls5r4lQBMSUlNlmdXpdtGLxYTcCLapqvqHdqAfomTyixd8JDm866UMa
	 eMr5/pSOccbLw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: sysctl: allow dump_cpumask to handle higher numbers of CPUs
Date: Thu, 17 Oct 2024 17:24:16 +0200
Message-ID: <20241017152422.487406-1-atenart@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The main goal of this series is to allow dump_cpumask to handle higher
numbers of CPUs (patch 3). While doing so I had the opportunity to make
the function a bit simpler, which is done in patches 1-2.

None of those is net material IMO.

Thanks,
Antoine

Antoine Tenart (3):
  net: sysctl: remove always-true condition
  net: sysctl: do not reserve an extra char in dump_cpumask temporary
    buffer
  net: sysctl: allow dump_cpumask to handle higher numbers of CPUs

 net/core/sysctl_net_core.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
2.47.0


