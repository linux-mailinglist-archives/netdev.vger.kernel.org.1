Return-Path: <netdev+bounces-181061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D917A837D5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A76B18956CC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B08C1F0E56;
	Thu, 10 Apr 2025 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KIbN5dG4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3E1F0E20;
	Thu, 10 Apr 2025 04:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744259269; cv=none; b=OndSQ6slcrcMy+JrG5cirFPwvqQaV7NJrlI72LQmOzbpgR0mveexl+qgMt++5//oIrb3UHYgfflylMg9bfAMipZI+4iAPi3A9QxhIBiUchNldF29XII8zRC6rN2VC1cUT0QI0mpJsgUE0VBnbrauj/NVZAT+2ylbWVtPftswSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744259269; c=relaxed/simple;
	bh=vfyyGp+v8jqucGJEOF0XejoiO01V1dhCfxvuBODWvpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB7B2S2G0/HgG7tJgbSh4HbM/ZQPZALnituB3ZEOWusz/XqqACGuNFBTSWEn/UqzsooIUuQqAUJqxNideXRaYDgC93qWpqpVy4KP0/e7vMmNtGr2T+tgpPCVJ/4IO7Slk59tAPBHO72cDvP9Hz6pv0wKFw6stOld2m0yeYpFoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KIbN5dG4; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744259268; x=1775795268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=51j84NperLAndL5LBmwVhbZdXFBL3eij9J5uxzWxhH8=;
  b=KIbN5dG4v7Lb1Fqet2upJ2JH/l5uP9K7wjaUlShjr8VRipRu8qJnXwON
   t3BaPRGEn8oCIgVCVb0V0c1Iv4ORm4dpSw+rUY1X6/TICEFkPrwrjEqaa
   82LlieURCgZB3cqS6/6j48r7DF2TajVtuiyjzGQ1uI1zgSeUsxOQkeNrm
   U=;
X-IronPort-AV: E=Sophos;i="6.15,202,1739836800"; 
   d="scan'208";a="9142601"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 04:27:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:35423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 8594f17e-c979-4a89-84f0-810e3544dc3f; Thu, 10 Apr 2025 04:27:41 +0000 (UTC)
X-Farcaster-Flow-ID: 8594f17e-c979-4a89-84f0-810e3544dc3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 04:27:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 04:27:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v2 1/2] ref_tracker: add a top level debugfs directory for ref_tracker
Date: Wed, 9 Apr 2025 21:27:27 -0700
Message-ID: <20250410042729.28604-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408-netns-debugfs-v2-1-ca267f51461e@kernel.org>
References: <20250408-netns-debugfs-v2-1-ca267f51461e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Apr 2025 09:36:37 -0400
> Add a new "ref_tracker" directory in debugfs. Each individual refcount
> tracker can add a directory or files under there to display info about
> currently-held references.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


