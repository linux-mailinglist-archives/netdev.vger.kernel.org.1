Return-Path: <netdev+bounces-143085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491D9C118B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890E9284A99
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10D2185A8;
	Thu,  7 Nov 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BvhpptEs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A5215C6D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017648; cv=none; b=OF7WyTZd9Z3wGTZ+vuzUMEQmaFIwoo0XhGcr7E1rAFB/OfUSBRH2/SMl13SwA3LLwHUjka5MZUoK0otJOlTaWEPOA3esjXeZDB3H0buxUlMBOhe4y8viCxBBuPalwbg8Xza9fgf97lhMhc0UD4401I/ZKZDfx1lbI3LwidtZwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017648; c=relaxed/simple;
	bh=lI4nSw1WpRUQbfCz5qVHVOOn8plSSm7oWVPEj5mq1TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWjDh/ziKIEDsbFdiUSPxyNFVYts3u8AmgG0J8hzf0jv9zNIeclGAvsygfAZxh9IMkuMsMRZEuHSDMvIzB/j3V+jpcmv/xIKQZ6VK+30F2FPuN4hEDXrOG3FgzpEVnESu8Vogkfr4vzFIJp/XZs2+80A92Kx4TdhjxtH99Ej4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BvhpptEs; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731017646; x=1762553646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSZUk3kWjRm3VmUBepPQ+Po3zM0MFnxGP/VxyYoPUrc=;
  b=BvhpptEsLkvyJJKOn0MoxKZrASIltrb262YUmocbW1HKYhV8VwyrFYkU
   VAjTcKLWC1GKQRYIDJ00Ma5glRl0Di+NVJE7VCGJy330cc/pAN3rBBPFp
   0ee18A5YvbhaCVOAu/Iu/brOcaSlPqZNOy07DJoVMo17yoALBV0WPjDCc
   g=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="447238541"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 22:14:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:48850]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.15:2525] with esmtp (Farcaster)
 id 3c0f78b8-48da-4439-9c89-6740d97705e6; Thu, 7 Nov 2024 22:14:02 +0000 (UTC)
X-Farcaster-Flow-ID: 3c0f78b8-48da-4439-9c89-6740d97705e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 22:14:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 22:13:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 6/6] neighbour: Create netdev->neighbour association
Date: Thu, 7 Nov 2024 14:13:54 -0800
Message-ID: <20241107221354.14483-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107160444.2913124-7-gnaaman@drivenets.com>
References: <20241107160444.2913124-7-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Thu,  7 Nov 2024 16:04:43 +0000
> Create a mapping between a netdev and its neighoburs,
> allowing for much cheaper flushes.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

