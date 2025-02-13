Return-Path: <netdev+bounces-165780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F92A335A3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359941885BE5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4AD23BE;
	Thu, 13 Feb 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZBtV1fPg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC24A08
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415280; cv=none; b=c/wDeidQiPfNu/yF4zXXpcxrf9wM073hq/wkkIuFa1uaMzMXewNB3j/oDMQ5nuM8whCr9bSB4AXZjDEN3hllKa8JH+zmbBh+877ysmoacfidwHvs6B4BH8wfXGHN6bfgKUTmkxpRKwaOKyFDmzhyzXZEcvWiUd8Le5pC8Q5r9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415280; c=relaxed/simple;
	bh=Hf/FMNufM41LZeDnoGOihk0rPQv/vTKheTEoMAwEyY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ochJrHcnZJzOraBWOItJUg5tsQrmDzCI9jQQPixKQHF9+ySzQMI7x3Ih4sQp16QZ2Hbn5BYWZwU726jHpfEyFnhZYW0u3gXmBA3T52NydeqO5PQuEPzTMdV9lZjv7KI6fDkje+lzuRZ9pfoi/gJOEhMc61xyLpcMqLDdgkAlxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZBtV1fPg; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739415279; x=1770951279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+dxJWAK/681LMRxs+Xejf1qOwislJbjd7lOfRUmPtk4=;
  b=ZBtV1fPgCjCVrVE3leecnxpxlPhTOC5J9NvpF1cJQKVAzImWdyMUXifG
   ykaSo2vM29C2oE4k9dDTUsMS2lEBLdgCKwyjLe6pRrGCHX/oypIKkcgYh
   3Qgvl+I0TiGo+4VLMcxXnNYKZitVKCBB8M8aewueojJjHL2tS4D/KCUbb
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="798376592"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:54:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:26108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.65:2525] with esmtp (Farcaster)
 id 10b9cb3a-1f47-460a-92b3-e105ed6dee76; Thu, 13 Feb 2025 02:54:33 +0000 (UTC)
X-Farcaster-Flow-ID: 10b9cb3a-1f47-460a-92b3-e105ed6dee76
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 02:54:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 02:54:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] inet: reduce inet_csk_clone_lock() indent level
Date: Thu, 13 Feb 2025 11:54:19 +0900
Message-ID: <20250213025419.80533-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212131328.1514243-2-edumazet@google.com>
References: <20250212131328.1514243-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 13:13:27 +0000
> Return early from inet_csk_clone_lock() if the socket
> allocation failed, to reduce the indentation level.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

