Return-Path: <netdev+bounces-124816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CA96B0CB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC71C242AC
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8013B5B4;
	Wed,  4 Sep 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="WnHkfufs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E55F4EE
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429423; cv=none; b=dZpjGgdC+E2HAtn8+vlHeyUn3yQoDejBzfipdReR/mQOD2almzv5pWkx3YYyGle/0FtXzrjqlgvvVWgpnQ0cOjK7fvaFA8oNm+TLPVZ9w1ukf/ITP/UWIQS9/pv48FTbhfUX8KW0TZgiAWk7Q/xBHHgrdnBCplHsX4SYY7DdYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429423; c=relaxed/simple;
	bh=G+G9s1luBmtPzU90PxHILb9gEYRiStFk5g6Op94i83Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANhEyRu7jfJS2mXDB6HQCa/DCO0OCQNp3AD0tb+KVA2f0rkyPzjKMRKwnU/+MQWhzMIv0/VIDBYPPbH7dRANKt1WBs4f4LrlaEhkl+pWPKT0NDqwnaL7sChJ8c71OB+FbodxA9J+bmFKi87r6MmrA0L6XH6jyLCG6taDXcK0a70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=WnHkfufs; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1725429422; x=1756965422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+G9s1luBmtPzU90PxHILb9gEYRiStFk5g6Op94i83Q=;
  b=WnHkfufstzXiHb12HNJINkd540Ip48SL/W0+rZR1AH7YIqTdk5bbx0IE
   lFVB0GEP3UcQUW8sEJ2TDwQNcRuq8fYgoBDwfMlxy91uletXtAUKQj8Wi
   Bn1DGSgbaIHPTZheZLpuPxJHnXyBrgFGTfR0P55arHn/V9n236XLe9wv/
   I=;
X-IronPort-AV: E=Sophos;i="6.10,201,1719878400"; 
   d="scan'208";a="23206570"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:57:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:40999]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.247:2525] with esmtp (Farcaster)
 id cacf0781-44cc-4b50-9e67-0cc85c46de4c; Wed, 4 Sep 2024 05:56:59 +0000 (UTC)
X-Farcaster-Flow-ID: cacf0781-44cc-4b50-9e67-0cc85c46de4c
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Sep 2024 05:56:59 +0000
Received: from 682f678c4465.ant.amazon.com (10.143.69.10) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Sep 2024 05:56:55 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: <andrew@lunn.ch>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <takamitz@amazon.co.jp>
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Wed, 4 Sep 2024 14:56:46 +0900
Message-ID: <20240904055646.58588-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
References: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

> So you have confirmed with the datsheet that the write is not needed?
>
> As i said, this is a hardware register, not memory. Writes are not
> always idempotent. It might be necessary to write it twice.

I have checked following datasheets and I can not find that we need to write
RDH, RDT, TDH, TDT registers twice at initialization.

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82577-gbe-phy-datasheet.pdf
https://www.intel.com/content/www/us/en/content-details/613460/intel-82583v-gbe-controller-datasheet.html

Write happened once before commit 0845d45e900c, so just out of curiosity,
have you seen such a device?

My colleague, Kohei, tested the patch with a real hardware and will provide his
Tested-by shortly.

