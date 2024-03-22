Return-Path: <netdev+bounces-81317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8F8872A0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40187287877
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEE626AB;
	Fri, 22 Mar 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W7AtngQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A65FBB0;
	Fri, 22 Mar 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130943; cv=none; b=lYyJ9E8ggin3tkDwt6yJg5kfRDfxa14mt/LmZmguCxOFAn8stWEhbLt7ts3QIrAoiVPoK7kIBmwgh9wy/Sij+HW/WeiHwoo0KOVkvuLTN86yCa/WHjBWzGudb4U4udVpv77nykyG4YcM2BKPOT17ZPt/a0FozwrmmEcKEUqev6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130943; c=relaxed/simple;
	bh=g6oLuA619jzBBWFMWetl5CCBwUbcZU/i+Z5gARF8938=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBediznQqtr7/qcgle1yUGeRpDWmxmat1oAs5WRWbSfkYMuoeK/yZRjw0YduD/aZ2CSMidXeR6GwHh5uaax6m0R3MhK49LW2DxCg79UL2KJTrdh0jLDMNlXGonuKDSwioxlUEv1gvtLYPiQ3I77202KXTOKFfslDsPP4DiYNt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=W7AtngQY; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711130943; x=1742666943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+ptxNawZAJ42+073zLqw3Fvrnf3JM8XIOukEzY52mc=;
  b=W7AtngQYDq/2JvasrEXgx7t0wg2ntk9levrc7p/MFpaqReyhA4Hr/ymM
   hk/MGKseyC3oyICzoXsijI2hcPRH5fxb2MH3reXrh9i1zOUgWYNk8ZBLi
   DqbteAdJF/julr2LzZBpxhd4esX073YutJ35ofSMomP2JFgEDDHSPGLme
   M=;
X-IronPort-AV: E=Sophos;i="6.07,146,1708387200"; 
   d="scan'208";a="713703306"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 18:08:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:28676]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.70:2525] with esmtp (Farcaster)
 id c1f4331b-f630-4ea3-80a5-3f5cc567d229; Fri, 22 Mar 2024 18:08:53 +0000 (UTC)
X-Farcaster-Flow-ID: c1f4331b-f630-4ea3-80a5-3f5cc567d229
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 18:08:52 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 22 Mar 2024 18:08:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: BUG? flaky "migrate_reuseport/IPv4 TCP_NEW_SYN_RECV reqsk_timer_handler" test
Date: Fri, 22 Mar 2024 11:08:41 -0700
Message-ID: <20240322180841.54368-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0edaead1-b20b-4222-9ed5-4347efcebbc2@linux.dev>
References: <0edaead1-b20b-4222-9ed5-4347efcebbc2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Hi Martin,

Thanks for the report.

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 21 Mar 2024 18:39:53 -0700
> Hi Kuniyuki,
> 
> The bpf CI has recently hit failure in the "migrate_reuseport/IPv4 
> TCP_NEW_SYN_RECV" test. It does not always fail but becomes more flaky recently:
> https://github.com/kernel-patches/bpf/actions/runs/8354884067/job/22869153115
> 
> It could be due to some slowness in the bpf CI environment but failing because 
> of environment slowness is still not expected.
> 
> I took a very quick look. It seems like the test depends on the firing of the 
> timer's handler "reqsk_timer_handler()", so there is a sleep(1) in the test.

Yes, it depends on the timing of the reqsk tiemr.


> May be the timer fired slower and the test failed? If that is the case, it may 
> help to directly trace the reqsk_timer_handler() and wait for enough time to 
> ensure it is called.

Sounds good.  I'll give it a try.

Thanks!

> 
> This test has been temporarily disabled for now 
> (https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENYLIST). 
> Once you have a fix, we can re-enable it again to ensure this migrate feature 
> will not regress.
> 
> Thanks,
> Martin

