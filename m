Return-Path: <netdev+bounces-192496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B811AC00A8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEC81BC66BC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF722B8A4;
	Wed, 21 May 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qhImsyoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE121D3C7;
	Wed, 21 May 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747869642; cv=none; b=LYdduBtEiXUrbCmwgw5xBic0jNItu29caZPQT6Dsdrr/eNldSDMuZGCbi6uHebeGlWB4HyaxSeSAjVvcsaWhsx/G2XCTTQZCjnKXFCd7nilo4xYw68LZ+wDn5kap8aE+S1nXY9zqU/8pmzPKEm381MkCB9IvugCyI/1sWx27KCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747869642; c=relaxed/simple;
	bh=CBO5bSjK0stsEuvSrLFecuRqTIT6JhNGNaszCB83c7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccZyIOeMm9s/ea/KidIfapyvU6Cqx01bIcBmG1eFkRf7MDk0P6Ynpyn9jWBg22aN9kyQuEODROCGP2SMWoH+2G9nQCzFtEwQ7dGPP7h/5lA+9xOz0kGlVexujFkbNtp63V/tXiGd9pyQDPUAyCXGQdFZyMbEyJ+HfpxPCakR8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qhImsyoW; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747869636; x=1779405636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXuJz2ArVBVRGn/T+wPi9D2VYsVT/YdvKkpsGgUQxzQ=;
  b=qhImsyoWLaS3rgp9kKEnI/QAFBeh4PC/SQzXmJtZx6gOkHMuemHmVpfd
   favCZk9MvZuXnLKDl/EmQjfTDEqscXVtqPa3suWeB5+Q5/PyDYKxuKD1m
   BBqe1l+V1KIzXKmNsR/l7pV+uR2Gl84G8kKIARco+Tx3LGQRhCfMP5QJo
   a67d0W/JzGbA3GyMLBMRKKiUIZkl8XeM/HSpvwTECq2wO/XKf+BntZno2
   M8ZvNROKq9nKuDEV52hk6EHFZx+4jTsiE30l4b6ttkr/l9nQzJbc3Cuxg
   3c7bSCnW8+xdHmkLgO+5QmTNrsLBDFfotPyMqFkhnbHlHSwqHdPz5mPoX
   A==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="52605345"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 23:20:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:64887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.176:2525] with esmtp (Farcaster)
 id 2024a941-f13d-4ded-9d38-e62a87a669ca; Wed, 21 May 2025 23:20:34 +0000 (UTC)
X-Farcaster-Flow-ID: 2024a941-f13d-4ded-9d38-e62a87a669ca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 23:20:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 23:20:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jiang.kun2@zte.com.cn>
CC: <davem@davemloft.net>, <edumazet@google.com>, <fan.yu9@zte.com.cn>,
	<gnaaman@drivenets.com>, <he.peilin@zte.com.cn>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <leitao@debian.org>,
	<linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <qiu.yutan@zte.com.cn>,
	<tu.qiang35@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
	<yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH linux next v2] net: neigh: use kfree_skb_reason() in neigh_resolve_output() and neigh_connected_output()
Date: Wed, 21 May 2025 16:20:18 -0700
Message-ID: <20250521232021.92209-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
References: <20250521101408902uq7XQTEF6fr3v5HKWT2GO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: <jiang.kun2@zte.com.cn>
Date: Wed, 21 May 2025 10:14:08 +0800 (CST)
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() used in neigh_resolve_output() and
> neigh_connected_output() with kfree_skb_reason().
> 
> Following new skb drop reason is added:
> /* failed to fill the device hard header */
> SKB_DROP_REASON_NEIGH_HH_FILLFAIL
> 
> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

