Return-Path: <netdev+bounces-160092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD819A18195
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A2616BAB1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F51F3FFD;
	Tue, 21 Jan 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NDBH42QX"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F11F2C57
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475200; cv=none; b=flW7xTZAEgRU1ci17UymVOqbB+JwbbMYCK/kIxiXZKEqfN3AluQeIim+Ca1bKf0NuTYdwW1JySIjCpIYRjL1yH9vK7AbXK3zNmLlL3XI1vC38fAylqUsc7vsQYJokMxC/hLVSadx/tCvNpzx6As06yQVAdrYMPb5zipcDvaAFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475200; c=relaxed/simple;
	bh=YAm25l/AE+PiifN1koxmjCwQWHoEL3uUg3ynG7JJTQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZL72TNzBmNgAGvl1h3Ds+3vxofV7AR1FViVjLmvQPPTuE0BHWrRqv3Sa6YhA/d2rrDWgV7XhfneGoza8ZZwyOyGLgDtggfBk0jTbIMoPPz/AFInn/+iYLWXIC716GwA4xjzMdQw1Zne2aozFDrwTRKMvRvhtnNhJB1gMJfDeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NDBH42QX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38892dea-f850-47d8-81df-ae8efd535272@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737475182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbTK+rVKLBnsmGuJaURQlyb5gRmUsxHhi46+45ugDMA=;
	b=NDBH42QXWTr2fIIUP1hriAEj/wyiiihuoSRQwSkjBkv7fbmOLY/gVFuOXuM6HroK6Jx1j9
	NqzYwmuIvQgI5Xm1UGvAoG/JcR/w7un5ig5b5NKJX6LNrRxkTchZHHeILl7ZOMJEf2dg5M
	VsK5ESvGooxYfyKuEZ/UjBAgqFKNEO0=
Date: Tue, 21 Jan 2025 10:59:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 0/6] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Shannon Nelson <shannon.nelson@amd.com>,
 linux-arm-kernel@lists.infradead.org, Heng Qi <hengqi@linux.alibaba.com>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
 <20250118171936.703c0a27@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250118171936.703c0a27@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/18/25 20:19, Jakub Kicinski wrote:
> On Thu, 16 Jan 2025 18:29:48 -0500 Sean Anderson wrote:
>> - Fix incorrect function name in doc comment for axienet_coalesce_params
> 
> Huh, I wonder if you sent the wrong version..

I think I applied the hunk to the wrong patch.

--Sean

