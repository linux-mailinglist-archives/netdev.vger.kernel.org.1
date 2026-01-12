Return-Path: <netdev+bounces-248874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08412D106BF
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B41D3027CFC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE86307481;
	Mon, 12 Jan 2026 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DAclZ753"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E9306D36
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768187468; cv=none; b=MzywhTnvP72a71UNp5FwrLaLihJvmuq3/FLAN/+KQYi97o+4uoAQuThVSChoesGcO6e7+zubzVT7IBW3jNIKfDl42+rQgvFR/kqDjCgEfthsBtnXHSuGU3NDSO33NRCfrT/7bwv1cF7pC1taOOEQPb2Kun97Wb+N+fW0drd9oXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768187468; c=relaxed/simple;
	bh=PjQXTurCqg8eMA0SqlreYKSa2/BSBZlUecjE8/D6eRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6Mdhmhxj06QitxOgvXrfXtl6JP7YDAhwxG9FKzPxUY+wm9swxGBnvAEJr7u8A+Nac0R/oHXZ1dOEINQIUocVlDmd6bw/y1MQhR6r4tHppiXteI0/ElbC+Dsgd+OtyXlLVHfSlYStLrrK8oBr6NvXQjBqUTePf2rmTO3NqpIDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DAclZ753; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768187454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjQXTurCqg8eMA0SqlreYKSa2/BSBZlUecjE8/D6eRo=;
	b=DAclZ753FhN3IYgOkQEkzVjY6K8HvdSb2MxLMLN3vTfM2F5NP/hmMufoEXAXiTyj6EKM5c
	f1lURNRKOGE8rrgnxOPOQrAsbAA+GWDi//y1l0m0A5UQz/bG0+KM1axiVdXoDMLcxAzV3N
	LeZudy70yGi8cKU1d9EnzXYJTbPcNlU=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: wangfushuai@baidu.com
Cc: Jason@zx2c4.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com
Subject: Re: [PATCH v2] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
Date: Mon, 12 Jan 2026 11:10:21 +0800
Message-Id: <20260112031021.81853-1-fushuai.wang@linux.dev>
In-Reply-To: <20251005133936.32667-1-wangfushuai@baidu.com>
References: <20251005133936.32667-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
> the code and reduce function size.

Gentle ping.

---
Regards,
WANG

