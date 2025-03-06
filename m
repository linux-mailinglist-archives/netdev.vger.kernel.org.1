Return-Path: <netdev+bounces-172276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E298EA5409B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4456D3ADB93
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6D190051;
	Thu,  6 Mar 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va/OOF/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837018FDAA;
	Thu,  6 Mar 2025 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227680; cv=none; b=Gm6B23Os6EiJupLJhk7MgpltDWTtA5G3z6/65v7t41MAi7ZNClEhpo1FEi74Hf2DgLOp3FYjmgb4/6ZdMw7NmpdtrDsPHqi+8E22b0nNFQnjgzrr8RYMJaj9BjnGvG5bBaZNA0eF1sLiWbgvH5ErmSyLlEQFqtzN2I8mnbw03z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227680; c=relaxed/simple;
	bh=PgAbraQZXPJUTM0sapawAo5nQCEsVdzy9GJWZx0L0YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpengWj5yMgH8BeXoEuVs9Pw+lvlKUhjl5aOhmaYczvoU5oWma6V8VR3UTeCilH5l3O/dobhT4uzVgvJrX3IAQXHDwYqtCaLLqy82EJNdbtTBVrm7EJSxPtwU6q5sGv3sIjhJ6hOorAfl4kM102JT1D7juPXsguZ4os0IBoNoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va/OOF/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F78C4CEE7;
	Thu,  6 Mar 2025 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227680;
	bh=PgAbraQZXPJUTM0sapawAo5nQCEsVdzy9GJWZx0L0YI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Va/OOF/yWwSnj/6i/OuBNmFDuMfFhheOe52bkZGv5i/EZsptALR26VDmvYqzK+AAJ
	 zKQ0kqQjIzlDXabXJY/4TTYF4VX75ZPPqM9CyUltcSTxqCzLRzBP+2jcgtKOcGG5H/
	 tuUJR/CyuEyeHg8ldFReETTf0y008U3GmjCrdi0FaPe98UC0f6VQUa88y5jJAiH06L
	 YwdBsnwKR0nDY44w9s647hggpUdGOBHNN3rIKopwyj9aPvhB6f3SIu9pTZPMlr+6yr
	 riuZC9D3cHWWiVPoYOMU7yNGt5nGWNkq16c1jEQYLbzzMpYmVNUBPLi3nAKvR5lDAM
	 zWYFsgLqLqLNw==
Date: Wed, 5 Mar 2025 18:21:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
 gerhard@engleder-embedded.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open
 list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250305182118.3d885f0d@kernel.org>
In-Reply-To: <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
References: <20250227185017.206785-1-jdamato@fastly.com>
	<20250227185017.206785-4-jdamato@fastly.com>
	<20250228182759.74de5bec@kernel.org>
	<Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
	<Z8XgGrToAD7Bak-I@LQ3V64L9R2>
	<Z8X15hxz8t-vXpPU@LQ3V64L9R2>
	<20250303160355.5f8d82d8@kernel.org>
	<Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 17:42:35 -0800 Joe Damato wrote:
> Two spots that come to mind are:
>  - in virtnet_probe where all the other netdev ops are plumbed
>    through, or
>  - above virtnet_disable_queue_pair which I assume a future queue
>    API implementor would need to call for ndo_queue_stop

I'd put it next to some call which will have to be inspected.
Normally we change napi_disable() to napi_disable_locked()
for drivers using the instance lock, so maybe on the napi_disable()
line in the refill? 

