Return-Path: <netdev+bounces-233354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5CC127A4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DA15E3241
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014520297E;
	Tue, 28 Oct 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSY1oKSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF540855;
	Tue, 28 Oct 2025 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612894; cv=none; b=fP7Cdl91fFmkDHKF3qRRWzSHfZyYsiuxLowSC2gyl/GY+dzPw53iRaD4YZ2nsWmn8oBCmfJjh7KtGh7xeax71MvcIYFxeeBotUg1o84PZ1jEAyCFCNcW3ql8ugQjXi1ee4tluF8sgaPqQTpOU0OqpEK25LrIvbtBmkMKlufcFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612894; c=relaxed/simple;
	bh=Nd0pxAqWQXz/a5u/pQujHHDbZKq+u6+RfQU31uBaXWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0QIo6pFJkrBiCJ5vBQxX2CG2oeWhYIaPs0kcPlVHLkoT0r9EAj+4sjKicvgnveW7BovTMmQE5OJvGHVXoZmHSGXhONez7HTCBqDu4Dj/nHdFf/KjG6dTfWQuMXUslmYne8Z8zlrpbl/67f38HEgrzYz2lRoDajSR/y1q0T1HvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSY1oKSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A40C4CEF1;
	Tue, 28 Oct 2025 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761612893;
	bh=Nd0pxAqWQXz/a5u/pQujHHDbZKq+u6+RfQU31uBaXWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MSY1oKSPBgT+9kDn3D92h1zmAwFYZKJTB7GxHxRy3/8ucc+FSrEDx6EchgHjMuXCs
	 rM4Tt6UiBpUAngGmQUwsdC+fKG+Z5c5kSyuUbJ5yoVNk3MO/Xaf5ySJLr+iFOzWWR8
	 SwIXOUpzlS5VmPwyvf01Ee4DwcDknyIHD75K6sDqMFHW1ZjFJgs2kEyIzfqPjuvYMi
	 3N3/sZ4z9iPWLm8Hv0r0aTM4aqzdzqQT2WNoFs2rb/1EC9H2DAXEDV58moUvmBFtyb
	 VgOY/SxveJZUsgTaYKqD9p4hT13bcfC5iWhie5I8shqUL6lk7PhaUWKMnYdrfGPLm1
	 QppjKEWbsCFtA==
Date: Mon, 27 Oct 2025 17:54:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>, <lantao5@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hns3: fix null pointer in debugfs issue
Message-ID: <20251027175451.21b7bfe4@kernel.org>
In-Reply-To: <20251023131338.2642520-3-shaojijie@huawei.com>
References: <20251023131338.2642520-1-shaojijie@huawei.com>
	<20251023131338.2642520-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 21:13:38 +0800 Jijie Shao wrote:
> Currently, when debugfs and reset are executed concurrently,
> some resources are released during the reset process,
> which may cause debugfs to read null pointers or other anomalies.
> 
> Therefore, in this patch, interception protection has been added
> to debugfs operations that are sensitive to reset.

You need to explain what prevents the state from changing immediately
after you did the bit check. With no obvious locking in place I don't
see how this reliably fixes the issue.

