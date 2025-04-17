Return-Path: <netdev+bounces-183911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A431A92C94
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DC84A3E4A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BA2046B8;
	Thu, 17 Apr 2025 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nW1e/yvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2331D07BA;
	Thu, 17 Apr 2025 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924756; cv=none; b=uRHMU/z6R+m0M5ATKssJfkJptxJ87rpUky/AfbBE0pPcEPLo8DkVLFwfyZk2b2yFH7t+9XZZawyFalr1CiFg+5RRfibw7MLvYGaxMrVjdjLs9QodRrIuPDo+y5S/xcqB/QvsXKOy+2fu6NhGgoHGvRA7BAogXQhoIa5UPRM72GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924756; c=relaxed/simple;
	bh=nC8UzQqBU++CeIHZRw6fD+TYAx/1VnKSjr8xWFnChxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7wpQ34Rd3FLyrQGB2gVHv+P/r0iIO7zca3mIOv0eeVbM3ETl3HwY/Mskn/YIlLRzmy9sFDSze/JpD6EWAa3m1pVqOUFxxyOGCGiyB+USJEN2QiQOKwHcXhcz2zYvJZOsryEp4k1jG6n45D5BOq39TwWRPfdsVzm59QVosjb0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nW1e/yvl; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744924755; x=1776460755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEpcLojT1ePaRIDUjzvduBn77a/qfXTeM2H6Ak+/xZM=;
  b=nW1e/yvll34Jj6WQ+Z/BFCa733dB/B7u6TyjM83bze2hZDPtKeDZR4Xi
   3sWYCteR7qatY6u5+S63mnSgHFJ+3lX/A+Kjkil+V7LmXecL3rliPZImR
   WtUehAYPcHP3NHM2ZUypAy2wSmmRLgXBVOfGfF6C/cQgMmosP2lJIi+Q7
   w=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="490377752"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 21:18:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:39572]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id b9b8547f-3313-4caa-9a82-5c24831f1157; Thu, 17 Apr 2025 21:17:58 +0000 (UTC)
X-Farcaster-Flow-ID: b9b8547f-3313-4caa-9a82-5c24831f1157
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:17:58 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:17:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qasdev00@gmail.com>
Subject: Re: [PATCH v3 8/8] net: register debugfs file for net_device refcnt tracker
Date: Thu, 17 Apr 2025 14:17:44 -0700
Message-ID: <20250417211746.16680-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417-reftrack-dbgfs-v3-8-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-8-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:11 -0400
> As a nearly-final step in register_netdevice(), finalize the name in the
> refcount tracker, and register a debugfs file for it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

