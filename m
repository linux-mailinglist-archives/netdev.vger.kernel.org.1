Return-Path: <netdev+bounces-151943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DB9F1C24
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 03:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA1188C5C5
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3F11712;
	Sat, 14 Dec 2024 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6nassFL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1810A1E;
	Sat, 14 Dec 2024 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144175; cv=none; b=nQUryuGr0OYKvGRufWLIjUWg+jHEZ0W0M7ulvNbkgPLY/sfcQldkJYNgWaoMIu81K3CTaOzKkolI2I/2h3TWE/T5hNzB2sPrgSXeY/59jBK6RPeu88E0Tj+fVBDhw45oxxjoNx8KmfdjOQYEI+Lcp7Tf8xMbbQw9L2va9dYy6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144175; c=relaxed/simple;
	bh=ztEhXcSAyyqNq3L4FS9I/YkZ86zRTO0AYWpbeD09Kgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpVbC116n7LR9+63nc7XFi80HVE3DrCJvFLMeZFCNbL/DVCiyQ+LVD+8/Ir/4bokMswhjlU/3i8OD3V5uKcccZEsKncceTuxN9treR2BCwvSVwVsdhmaQUf0ou5qUrB16rGunYy+nFgmzYJxgz1K7imJSkvaEtqz7/+ia3yqUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6nassFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5037DC4CED0;
	Sat, 14 Dec 2024 02:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734144174;
	bh=ztEhXcSAyyqNq3L4FS9I/YkZ86zRTO0AYWpbeD09Kgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V6nassFLbvy+EOuEChJi9YzsJTKmj4kDtoSvCSpUwwx1pedXE/Th+VCvPHlO4r6TJ
	 b7Dp7bU24wP+5BfBvIAiYVXuiovwRDNAj0xVf6Qpvanj7amEWoBOt+vXusapd+i50L
	 RgsslmqoLeR/ZXIcNyiyWmW+4UJFuUIb5/S1EepctlExLFh9wVp2yhB1kql1S3x0BS
	 1jcTaikDNAtKn6aJJPd9tYrmA/h0MVHYQRDkPuZ7jUuzTzG89BfoVxDfcW1nxU3Xpi
	 fWZBwHq/+8lsv0MAzmWvQKNCwvPTYqx8c9ID4zITZJGGxbiqqGBocMmRRuU9o/Zene
	 1NXGCSJkLNIEA==
Date: Fri, 13 Dec 2024 18:42:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Message-ID: <20241213184253.7c8203ce@kernel.org>
In-Reply-To: <b7a48bbf-d783-4636-8f75-35c9904ffe05@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
	<20241204133518.581207-3-parthiban.veerasooran@microchip.com>
	<20241209161140.3b8b5c7b@kernel.org>
	<5670b4c0-9345-4b11-be7d-1c6426d8db86@microchip.com>
	<b7a48bbf-d783-4636-8f75-35c9904ffe05@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 10:35:03 +0000 Parthiban.Veerasooran@microchip.com
wrote:
> >> start_xmit runs in BH / softirq context. You can't take sleeping locks.
> >> The lock has to be a spin lock. You could possibly try to use the
> >> existing spin lock of the tx queue (__netif_tx_lock()) but that may be
> >> more challenging to do cleanly from within a library..  
> > Thanks for the input. Yes, it looks like implementing a spin lock would
> > be a right choice. I will implement it and do the testing as you
> > suggested below and share the feedback.  
> I tried using spin_lock_bh() variants (as the softirq involved) on both 
> start_xmit() and spi_thread() where the critical regions need to be 
> protected and tested by enabling the Kconfigs in the 
> kernel/configs/debug.config. Didn't notice any warnings in the dmesg log.
> 
> Note: Prior to the above test, purposefully I tried with spin_lock() 
> variants on both the sides to check/simulate for the warnings using 
> Kconfigs kernel/configs/debug.config. Got some warnings in the dmesg 
> regarding deadlock which clarified the expected behavior. And then I 
> proceeded with the above fix and it worked as expected.
> 
> If you agree, I will prepare the next version with this fix and post.

Go ahead.

