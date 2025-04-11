Return-Path: <netdev+bounces-181812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F144A86836
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE1A9C36BD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87F298CB7;
	Fri, 11 Apr 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y0dnvnEg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32E28137D;
	Fri, 11 Apr 2025 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406739; cv=none; b=Fg97uainxVq3CP45Xljv315PGkQjGIQF/m1PN3AKcNqWBtMOC9yN5S0N8Zci2jxyKoJEtCJy2/JMmZ48xMQ1IlpjqSZX7Lsfqx7kFEJYjIN0nfYaVelkWCvKrWzzKfIt7qPcPz2XFY0VHpwPknZNojhH6mS4ascAXTtYgCYoyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406739; c=relaxed/simple;
	bh=jWM/lW8xq6iammxuBXFg2vacnKdTzL0REbb3rjSjPNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXnReMv39RsUMhaOdnDFjZhvxnLywUXjcO4VAI2T9IrIyT5F1Xnp5SiE7S6VrN7s4BYF3gYojvzH4PLnQHcJjEid0PbnclzGfIK/t49beVMgV1Krr0QkMd4mvnsbJtsO8HrXDlWU0UxC8ceDVfNw1ruYuQnfxscmQDpCRj3NHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y0dnvnEg; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744406739; x=1775942739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/EsWgiikBtQJ5CQbxPlHtDvXhYOrLcHzgcGnXgknNU=;
  b=Y0dnvnEgWT54g+sCXSwuvC6l/5wY8vqwn8yZ3MFZXNIN7/TlftHBJ1y4
   J9xTuJOmKuowhm4FpCbLHjx81TeLSNlNswS3l0yMxNAaE4Wg3EG8bmJfz
   O7dkzS4sV55aJLUovNkq4n0J66c9KqvkBPUZz1euJJgRuaJ6Itwy6YJR5
   E=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="488753187"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:25:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:37379]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 4a852ad4-708d-4d66-a446-123564edb03d; Fri, 11 Apr 2025 21:25:34 +0000 (UTC)
X-Farcaster-Flow-ID: 4a852ad4-708d-4d66-a446-123564edb03d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:25:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:25:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 4/9] rtnetlink: Use nlmsg_payload in valid_fdb_dump_strict
Date: Fri, 11 Apr 2025 14:25:21 -0700
Message-ID: <20250411212521.68007-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-4-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-4-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:51 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

