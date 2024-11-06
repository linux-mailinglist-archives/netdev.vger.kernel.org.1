Return-Path: <netdev+bounces-142527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CF9BF80E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90322838F9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F020C33D;
	Wed,  6 Nov 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZzocqR3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC020C322
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925304; cv=none; b=D+5OfM9EBapzNwO/oX6Y35Zq6uy/T+QsDzZ+h2qcZ2V8Of3Ox1rhF/eNEfxOBFUly/v5DRCib0ig3iSOmLcnt/SBp5O4Sva6khGRuzyuD+mdl9UkkgaQTPJRtnvjXmaun1V9b4erWG84HqCdVhTWsAcDJ5zNslrxBfkgSFm9ApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925304; c=relaxed/simple;
	bh=1RJYIgf+wTVB1oDvY/MdNC1fwfyrT0AIVo6XVyFcdy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4qHFJGZmScT/2GzqCo5gmjAkEDl91GwVfZDzQp1Z67O0q7OlDYjP0BAbu1NpPnNehbjbiOXCcK5q3BxFK7jrpfB5Tu8DPXsMk5FnUXxMWt25dKl3SOHlW1JC1ntYczhPKrwIKE6++LqPoc2ZJIOwUg5gYOAFOTqDbAKa4IiaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZzocqR3c; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730925303; x=1762461303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HtJpybIrCQ+lX2bWaLVh/xqlm4ntF5fB5SWDnTG02M=;
  b=ZzocqR3cCu6Rki0SFgozSs+4n6U8ewCd4aUiHrTmNbtrDMBXOVU7peMn
   r404sfGpuMdZD0xzrZOPmA/Yrw5sHt+NTWs2fYX8VWjE9MVA66Cozvvfg
   e/TUZLmISC5Zwf6wBK1kn7VUZL8aFOp04G0rPHm71OgzgFDOm36Pls7wl
   8=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="773344962"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 20:34:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:16401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id 02189523-70fa-4baa-86f7-449225909df2; Wed, 6 Nov 2024 20:34:55 +0000 (UTC)
X-Farcaster-Flow-ID: 02189523-70fa-4baa-86f7-449225909df2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 20:34:54 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 20:34:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 3/6] neighbour: Convert seq_file functions to use hlist
Date: Wed, 6 Nov 2024 12:34:48 -0800
Message-ID: <20241106203448.33378-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-4-gnaaman@drivenets.com>
References: <20241104080437.103-4-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:31 +0000
> Convert seq_file-related neighbour functionality to use neighbour::hash
> and the related for_each macro.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

