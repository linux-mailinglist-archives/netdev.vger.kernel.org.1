Return-Path: <netdev+bounces-101542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDD8FF548
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EBE2818B3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE6F4D59B;
	Thu,  6 Jun 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFvrWBp6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771A446DB
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702150; cv=none; b=lhfHSb7Oi6kg79ko51ar8IHqjRb3u7DtmYQ/36f372w100p/Lu8F29X9/39UzIN2aGrHKQfCLMI43ijPs3u2/iflPw62GOFqZpsiC+VY3hcJgIBWip5qd7cDq6ZjccoxLUxg2ZdeiI+5DbEwVxXwLA5xWPx1UyL1BtYocJVxDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702150; c=relaxed/simple;
	bh=cUsavMKE4FAZF0vHNMsvPysJvxDmJX7tzBE5ctQrpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd952zRxnZuweoEKcOPyLLSaZ7psfkBmnQPD6AnsBj66snkMN9vQ7Rffc00uJV6Zej5OxhqS8p4qchyP12u1LsQstL2NSpSqFCkVnoBj1nfB8ldWar4HXGXzJk8xjsNG1TBWi0lsVet3DMhB5a2zKFUkbpgnO9y/Vns8YqlF+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFvrWBp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0183FC2BD10;
	Thu,  6 Jun 2024 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702150;
	bh=cUsavMKE4FAZF0vHNMsvPysJvxDmJX7tzBE5ctQrpY4=;
	h=From:To:Cc:Subject:Date:From;
	b=OFvrWBp6THnuYQy4bUIPvs0q95iI6yjeSuR7ZffP96KwWvglplBNlHhWasODoy6Nv
	 3j+Ex9MYEcCZdjF2fC/r7vOqOsbe73t+rV8nWz4EKamhQdnL7XQfHzb38M2tRBDMBG
	 umwcYo1l/sxgCcioq9C51/qEKAQDEkpMV94JqRW/tpaD+7JEVgWeLgx36kChG9mQi3
	 +n11YYTqM/zEzjOl74MRdiTF0tguwB01tSOZX9j0Xd/PE4ocduzxL3lmrIe0HxNtP4
	 Pa/Mgn03zs7hmOziP7uuWB1oraAFK0gtRMNbCf8+LZ9dFa0nCuf8vFHX1S8PJ71fTM
	 MP+4etUWEAEHA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@gmail.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] rtnetlink: move rtnl_lock handling out of af_netlink
Date: Thu,  6 Jun 2024 12:29:04 -0700
Message-ID: <20240606192906.1941189-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the changes done in commit 5b4b62a169e1 ("rtnetlink: make
the "split" NLM_DONE handling generic") we can also move the
rtnl locking out of af_netlink.

Jakub Kicinski (2):
  rtnetlink: move rtnl_lock handling out of af_netlink
  net: netlink: remove the cb_mutex "injection" from netlink core

 include/linux/netlink.h  |  1 -
 net/core/rtnetlink.c     |  9 +++++++--
 net/netlink/af_netlink.c | 20 +++-----------------
 3 files changed, 10 insertions(+), 20 deletions(-)

-- 
2.45.2


