Return-Path: <netdev+bounces-142525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD69BF7FA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716881F2255C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3920C039;
	Wed,  6 Nov 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dPPAuBAn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2C1DAC88
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924784; cv=none; b=JeS4viS1rc1XwhMtygSeBXAlHv0x9cCE7hffuSTzx+fhc1Bmyr2uc2A/4tkXg4Xwgd3IgMEmmV/WUc6ZLqdIjFVhBzxIkVDWUQQjf0IYVa3z4Ii7MXbi6MrLIwgcFDUWhPgZ4VuhHDF288BMHCsDNkphpUN+f0mrlGjrhpt5cXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924784; c=relaxed/simple;
	bh=dq4T6DDVby43a81FHhZNd4AQehoM9GI28l9/MpOmHCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0SMfH2TXRRbcr1PSOSs80IbPeK8pLh50urPnxW0OLhZtdeobgpv40kw2QHnhoJqPp8TJXT04UPUCvTGeqre6rjHUWjcA9tP2D2KGMJwhWZ/tXral23VGOmmi70fOc+yOvg8NB+88BE14XODVBiteizSZAofnsxOMo9bAZYo2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dPPAuBAn; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730924782; x=1762460782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d52lqdmdiQ6Pi4n+9nENh96+SpX0Y4voSesLcWRCw+c=;
  b=dPPAuBAnN3T5v+gy6HjEdYfjKyZccTMeGTaF9I6q+2eCwvnU6XDmxxoN
   J5GGxXvmCEX7OcCVOHOJ1WC30P1LLDdBfrIaN4SIEi23I+UJQCw/sBZK1
   bSkMGeljFhrVIWiYakvfFCxZ+K9xkEWxtC5X4YRM7QQMtRivVitskhVDb
   A=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="349962065"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 20:26:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:39085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.15:2525] with esmtp (Farcaster)
 id 6dff6e60-af96-44b2-8a27-bd203325642c; Wed, 6 Nov 2024 20:26:20 +0000 (UTC)
X-Farcaster-Flow-ID: 6dff6e60-af96-44b2-8a27-bd203325642c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 20:26:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 20:26:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 1/6] neighbour: Add hlist_node to struct neighbour
Date: Wed, 6 Nov 2024 12:26:14 -0800
Message-ID: <20241106202614.32517-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-2-gnaaman@drivenets.com>
References: <20241104080437.103-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:29 +0000
> Add a doubly-linked node to neighbours, so that they
> can be deleted without iterating the entire bucket they're in.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

