Return-Path: <netdev+bounces-181472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18652A851A5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD724A7350
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C135215162;
	Fri, 11 Apr 2025 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RCOz3Nec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED82AE72
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339039; cv=none; b=nPmPQtuPB7UMgLos9kfGZj8MJith9bCfn2NSdzDEravZVhsM//oQPUWJpBv7waPCl/0hfAvc/OVLTaRi+TXtREvTgNaSn4+0IfYcGwH55FE5JdnfYScqlVUCF4BIkhSCEss/n6/a9rfEO096RvFDVhfXihalcbipXPlP3NowBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339039; c=relaxed/simple;
	bh=FJzKu8/YigJflHw0QcYYvCNlG7fANjIZ3mvioJ4pUtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zpaj5VFRMdE5fNDQGzyofGZce3R/p1i93F/ST9fy2UOmiozI5v61gdRC+DDiFDmNqBxmFznX5ubVBLYSKnJkso3PNE/nxVOkPojDi79UtSuKYH54mV6HDzEfJc+4L8F1x6OdNJnXpEqCJwfwnaTpol8kuaRrUijjMNZNb9IID54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RCOz3Nec; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744339038; x=1775875038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/x5An8ry2W7DBgZtmC7lOtixm9XCb+ZIVvOE+zYZNuw=;
  b=RCOz3NecXImNVTLS90QVZiT1xqCMnour0hDyl7sPiTFHp4chAUHwHwOG
   emIQdaUTpjKwXef8Ovgvm2OFW6HHAhCNrZheKXetIjb3mJRuEjj4VXlSm
   FM3MU+0eW/L2Hh4iJ75N2RhCSe42z1eSQ5ptTHCk9HCJsjP55fF0/2ljV
   4=;
X-IronPort-AV: E=Sophos;i="6.15,203,1739836800"; 
   d="scan'208";a="39700528"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 02:37:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:35586]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 4a136905-1297-4e7a-88e2-f5e17b3ec3d7; Fri, 11 Apr 2025 02:37:15 +0000 (UTC)
X-Farcaster-Flow-ID: 4a136905-1297-4e7a-88e2-f5e17b3ec3d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 02:37:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 02:37:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <hramamurthy@google.com>, <jdamato@fastly.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp features
Date: Thu, 10 Apr 2025 19:36:51 -0700
Message-ID: <20250411023702.62614-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410191028.31a0eaf2@kernel.org>
References: <20250410191028.31a0eaf2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 10 Apr 2025 19:10:28 -0700
> On Thu, 10 Apr 2025 10:10:01 -0700 Kuniyuki Iwashima wrote:
> > syzkaller reported splats in register_netdevice() and
> > unregister_netdevice_many_notify().
> > 
> > In register_netdevice(), some devices cannot use
> > netdev_assert_locked().
> > 
> > In unregister_netdevice_many_notify(), maybe we need to
> > hold ops lock in UNREGISTER as you initially suggested.
> > Now do_setlink() deadlock does not happen.
> 
> Ah...  Thank you.
> 
> Do you have a reference to use as Reported-by, or its from a
> non-public instance ?

It's from private instance on my EC2, so

  Reported-by: syzkaller <syzkaller@googlegroups.com>

would be fine unless Eric can release a public report from syzbot
if exists.

