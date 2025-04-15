Return-Path: <netdev+bounces-183011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A657DA8AADB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195BD16489A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E25274649;
	Tue, 15 Apr 2025 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MVXKp1PJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0927464C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754924; cv=none; b=CXiw9/6yFN/KXBEbUWRM73Zk7h9qYSqrokqtVLLhXCdF9rTTca4VNve8pS1rsMpUQAaMRjhFeZ64ahy3xxhoOStf465mXLGnc3g37LDWyTHMUgD8svb9P4aGihaSMg3vf/h+Iv/gDOwyc2EIvAspBSKP6pomQPXuWkMFo9Cl3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754924; c=relaxed/simple;
	bh=8BVEqAQhLWsGSC2+4k0QBWcPmgefEkt7JdGCFNvwZnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDWPAFnzqsrhYvOpnNlXdltij0jzsebL07IXvhEeXK32Ao7RZIMhO/1CGBUpL4TKROcDPbdJ0swQ9cCAi4FWYjlZVUo4k4nnh80NJBBm4wiBDCEfFkinBv5udVGyUgHCtMI6Zj+3S0c9ZQGF15nBszdNjkQN1KJdBqksE2bv/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MVXKp1PJ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744754921; x=1776290921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrcDqxvm3I1kCilMEY3fstLqOX4V2pw6DvmDAslyDho=;
  b=MVXKp1PJKKptW01HWMejmdyQ8/Mb80AS+F3Aeo2A0zLn88rhk07ediqM
   mFBXFrQz6XYHkQETPPxwKnrHfzojB5b/8F/8Kp4dECUM/XLMvnYxZMgfO
   c3Hpo+F4W+S32rm5KqjRSICOoa7tGLYmxE7KHJv5vdlIv4oH1V5bILvPR
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="714113192"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 22:08:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:61519]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id c02780b3-bb80-4dad-8ce7-4a997c4c60db; Tue, 15 Apr 2025 22:08:36 +0000 (UTC)
X-Farcaster-Flow-ID: c02780b3-bb80-4dad-8ce7-4a997c4c60db
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 22:08:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 22:08:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>,
	<syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: don't try to ops lock uninitialized devs
Date: Tue, 15 Apr 2025 15:08:17 -0700
Message-ID: <20250415220824.94215-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415151552.768373-1-kuba@kernel.org>
References: <20250415151552.768373-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 15 Apr 2025 08:15:52 -0700
> We need to be careful when operating on dev while in rtnl_create_link().
> Some devices (vxlan) initialize netdev_ops in ->newlink, so later on.
> Avoid using netdev_lock_ops(), the device isn't registered so we
> cannot legally call its ops or generate any notifications for it.
> 
> netdev_ops_assert_locked_or_invisible() is safe to use, it checks
> registration status first.
> 
> Reported-by: syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: sdf@fomichev.me
> CC: kuniyu@amazon.com
> 
> I wasn't sure whether Kuniyuki is going to send this or he's waiting
> for me to send.. so let me send and get this off my tracking list :)

wondering the same, thanks!

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

