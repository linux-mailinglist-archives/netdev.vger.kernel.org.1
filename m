Return-Path: <netdev+bounces-249064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF1D1352D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9513002150
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3422C1586;
	Mon, 12 Jan 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYSKjae3"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964152BEFFB;
	Mon, 12 Jan 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229636; cv=none; b=QjG7I4l6fuiTqpPKL15uEryTyA4R6Yre/Bqhvl5J3Cur49sABREo5wMmI+Vt/7ymNvNRGMhjOJ6WBOdHhF8oP6YsNoi54WoMVC/bjuPTIQze5OdVOYQeUClystl5H3jpKjsYSQmksAWyvbzg0T5Goy9g9SEEdEu1OZ8ZxYo05hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229636; c=relaxed/simple;
	bh=vMdMbkaj9FIBvbrqlM+Ht0cnW5A4bq8nE13c3jx00b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4PIUSsQz2PH8NG0p1p04Bbf2guBZ+o6Er/bbEUEOww6/7kyD9Gj5kNhLXfuViRrYQN7EqJxt9RPdLKLw+IKG3Y34ETWVeuzKRkUWbNCL19+ixvz3lSnfI/dlExjQcYMyVKTXzNLP8HhdEBnUGwrvBFhB1JUh/aymv2f/6zWVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYSKjae3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6499ec9-92d3-4a63-8172-3c09a8b64066@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768229632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJRXUcKkDog21NY9arGh1QRo0yXqzWSWI32WfNW/NXU=;
	b=CYSKjae3S5FACFkMnLMzwVE2kPTt9AMRFN7mSAGW7ME7h8gCmWVnkY/8iXTwGDn78taKG+
	dlMM0E4bxhFjRCNUCQ0EdYqXcA3SfGlSkxhCK1yFDn7rUu5Sk2zK83MCOlOKqDNNxxeFqM
	XELoFN5cAGbovb03AKSOu9bx+yyVOnI=
Date: Mon, 12 Jan 2026 09:53:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] net: axienet: Fix resource release ordering
To: Jakub Kicinski <kuba@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, radhey.shyam.pandey@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, michal.simek@amd.com, linux@armlinux.org.uk,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bmasney@redhat.com
References: <20260109071051.4101460-1-suraj.gupta2@amd.com>
 <20260109071051.4101460-3-suraj.gupta2@amd.com>
 <20260110115306.4049b2cb@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260110115306.4049b2cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/26 14:53, Jakub Kicinski wrote:
> On Fri, 9 Jan 2026 12:40:51 +0530 Suraj Gupta wrote:
>> Device-managed resources are released after manually-managed resources.
>> Therefore, once any manually-managed resource is acquired, all further
>> resources must be manually-managed too.
> 
> only for resources which have dependencies. Please include in the commit
> message what exactly is going wrong in this driver. The commit under
> Fixes seems to be running ioremap, I don't see how that matters vs
> netdev allocation for example..

In the series I originally submitted this in, I wanted to add a devm
resources (mdio bus etc.) at the end of probe that required the clocks
to be running. But as a standalone patch this is more of a cleanup.

>> Convert all resources before the MDIO bus is created into device-managed
>> resources. In all cases but one there are already devm variants available.

