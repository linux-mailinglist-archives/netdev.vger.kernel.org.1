Return-Path: <netdev+bounces-180048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B21A7F473
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC683B3C39
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0898253F22;
	Tue,  8 Apr 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cnPX/4y/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC4213E67;
	Tue,  8 Apr 2025 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744091765; cv=none; b=fIkHNSmfCUkLUg55gCH0NcKK8rWLAVkmLlE6JvoKdIY1se+fctl/JyOTKAq/TMBM01frWBWFmrNyss8RiDpH7KmkY/8ZUSbwCRbv5IRCA6KugKppyPfMJdg9L1pnsO1vWQWGNNnrFirxZD2wLJdLkoVkgFecR14I2+/cDQqC12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744091765; c=relaxed/simple;
	bh=VnD0HM6fbgKQ0RitnLeCiVhZjJO7XP7pXNQ/lN4Ckdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIRutGwMvNv6zTQMp5lLfImD9V3EA59ykeXUvYb0M1A4cWB+wGbHsS112hQ7ehR2zNCyKhIDkxBYdUMtToVqRCXkpCEHUlFuUfkSvITMyTO2QKLRwugu0gYbNfmVYVcIuZWtz4MadA02qT9w/QOzSia/7DMxIaVHKG31btFCFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cnPX/4y/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744091764; x=1775627764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnlKcunjrO5Vrzf8adu6sG/IV+JTDrSeQCmltXqSrKo=;
  b=cnPX/4y/d4cnJFtlLL4fp4j6AR7IUlK+e9e4PMgt6I9fGoDnC5r3EQN+
   jnL9fHuFFfWgRJ2FKPw1kB6F2IdUxxdZpji3lPwYi725e1BeRmUHSZUhb
   nj/DH6yMHy7pMbMq+htQ7Q6EK+lOEfGVbTOzalxNgnvhGR2rFS9FlcXvr
   4=;
X-IronPort-AV: E=Sophos;i="6.15,197,1739836800"; 
   d="scan'208";a="185441349"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:56:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id b3b618e6-478e-41e4-b234-2896bb1f70bd; Tue, 8 Apr 2025 05:56:01 +0000 (UTC)
X-Farcaster-Flow-ID: b3b618e6-478e-41e4-b234-2896bb1f70bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 05:56:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 05:55:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>,
	<sagi@grimberg.me>, <shaopeijie@cestc.cn>, <zhang.guanghui@cestc.cn>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 22:55:27 -0700
Message-ID: <20250408055549.16568-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408050408.GA32223@lst.de>
References: <20250408050408.GA32223@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 Apr 2025 07:04:08 +0200
> On Mon, Apr 07, 2025 at 10:18:18AM -0700, Kuniyuki Iwashima wrote:
> > The followup patch is wrong, and the correct fix is to take a reference
> > to the netns by sk_net_refcnt_upgrade().
> 
> Can you send a formal patch for this?

For sure.

Which branch/tag should be based on, for-next or nvme-6.15 ?
http://git.infradead.org/nvme.git

