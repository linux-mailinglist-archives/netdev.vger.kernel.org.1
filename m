Return-Path: <netdev+bounces-142528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39759BF81D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EDE1C22B2A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166A20C312;
	Wed,  6 Nov 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VSyFWZPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41B20C47D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925653; cv=none; b=ClLhkYM3+cFWTD9y7fuMxfAJHYuvc2Ru1JKCkp2XYXftLvurTh8Do7hWXr3jg/jPAovekgxyq+98ZxCOWnYPQsPfdRd6++/+9eV5oDh2mAbSTGrfSQLxuGYhbM+cB7f4adxfWqGeuqUv0zPK1QqKR2gDzVz3EYxphrl4cImana4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925653; c=relaxed/simple;
	bh=8JZzZ1Vljk3V5b8MEKyWmHjMVluG1RC4XzMVhKy6OSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx/VFjyCbBMXCJapRlphRPCTTTr8GbkvrrwitOyFUBLYzVxz4RUhLK4BtM03VnZgbZQGqjDvJa2ptfjXsUf3PqwLplqja+ngWkaGT4HluQF59zQ2F5aWcGPMFs1bzg1SLUblfUUz/aim57VMT3vSPEv6pWbPLpqwEr1cBXuZJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VSyFWZPH; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730925652; x=1762461652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pa500yMYbUchg0A3qrAZ0JKDJbBsNc3jVZbU37/QRhQ=;
  b=VSyFWZPHkJu2J4WV2sq/e5UGVGNpDHUknZGa+jOAamMooT0cs/kDM2EC
   ZeFlEFgQ5Z2igLPPYujUZLusR6T3ZtOTFgW/c5WcfpopKfPBSIZOLR/HV
   SOyN6PZet49o6KTyFrYPnDxPkEooHxFdeFHwt4b25t3NB5xqS9z1iihC8
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="467729930"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 20:40:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:44486]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.15:2525] with esmtp (Farcaster)
 id a93e3971-6e74-4ec3-8e6e-82934de3e4dc; Wed, 6 Nov 2024 20:40:46 +0000 (UTC)
X-Farcaster-Flow-ID: a93e3971-6e74-4ec3-8e6e-82934de3e4dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 20:40:44 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 20:40:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 4/6] neighbour: Convert iteration to use hlist+macro
Date: Wed, 6 Nov 2024 12:40:38 -0800
Message-ID: <20241106204038.33808-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-5-gnaaman@drivenets.com>
References: <20241104080437.103-5-gnaaman@drivenets.com>
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

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:32 +0000
> Remove all usage of the bare neighbour::next pointer,
> replacing them with neighbour::hash and its for_each macro.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

