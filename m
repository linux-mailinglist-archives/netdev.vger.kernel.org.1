Return-Path: <netdev+bounces-132226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9B991058
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CE7281E37
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D21AE009;
	Fri,  4 Oct 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DShWE5rf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F71339B1;
	Fri,  4 Oct 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072477; cv=none; b=AzVH8SxFiMQ7to1BC3ngLcV47mHXk7BLbFiVq5H3mEJqMvOTndAfAveVXHJL59Fld6bN4yX71gf5zf7QjmSBDZgNt9eVl6ydQepdf7+QQMtlkUbIzlhWWVUuH66ZCEqKlEbDXK2Oj/Z2EvLorwd/7h9cHVi1obpNdqrzI4FE5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072477; c=relaxed/simple;
	bh=K/PdPwbJ/UqEBqxwToXx1HRmNsPfXx/ybKWz8tMXoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fj6q3mA+SpzPwCJZBc3OKJEqKzAjmJsrZW4Agssbcqp1c7SfR+VSAaOkF17UFIepA8lXgcxbajebLoGysbHM4In6Bj2oB7uSAo9zw3CSF0jc5jaFbU9bFV3uFvsM8ciDPDZeX7q+liO6IW1Vzjw8E+PO5zKekklr3NX4q72s2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DShWE5rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA11C4CECD;
	Fri,  4 Oct 2024 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072476;
	bh=K/PdPwbJ/UqEBqxwToXx1HRmNsPfXx/ybKWz8tMXoJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DShWE5rfzAd+IofYT4/GcnALtx/f+2bMMXi8y7oUL3wLbLJEU1nZJk/HihEjLYOsF
	 skqQTKle3IQWn8MGVo+BqvkebDgK0K2C8+UuNpbZRAyx+v6mT9NQ1YWc/Nh/b4QzgS
	 ED+gKweq+/fnOWoKfMgPi9sGfBE1585w6Jp1SBoW5y6Z4qdToNjVFbwE8yBbw7MHOu
	 U5pUrcw/paFp+FDSHYRN500HgvU+ptAfVR1KdErkkFqJ4gw07sgd9AawZEqa4OrN9l
	 ONSzesogzUkuQTvioIJ+jx057qw8IyT2VGegfBShSZ6duGeXNoHhOY5Q8sIh/KvBeo
	 oLZ3j+/0AuGiQ==
Date: Fri, 4 Oct 2024 13:07:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>, robh@kernel.org,
 jan.kiszka@siemens.com, dan.carpenter@linaro.org, diogo.ivo@siemens.com,
 andrew@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
Message-ID: <20241004130755.3ec07538@kernel.org>
In-Reply-To: <20241004104610.GD1310185@kernel.org>
References: <20241003105940.533921-1-danishanwar@ti.com>
	<20241003174142.384e51ad@kernel.org>
	<4f1f0d20-6411-49c8-9891-f7843a504e9c@ti.com>
	<20241004104610.GD1310185@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 11:46:10 +0100 Simon Horman wrote:
> > 1. Move the documentation to kdoc - This is will result in checkpatch
> > 2. Keep the documentation in kdoc as well as inline - This will result
> > in no warnings but duplicate documentation which I don't think is good.
> > 
> > I was not sure which one takes more precedence check patch or kdoc, thus
> > put it inline thinking fixing checkpatch might have more weightage.
> > 
> > Let me know what should be done here.  
> 
> FWIIW, my preference would be for option 2.

Of the two options I'd pick 1, perhaps due to my deeply seated
"disappointment" in the quality of checkpatch warnings :)
Complaining about missing comment when there's a kdoc is a false
positive in my book. But option 2 works, too.

I haven't tested it but there's also the option 3 - providing 
the kdoc inline, something like:

+	/** @vtbl_lock: Lock for vtbl in shared memory */
+	spinlock_t vtbl_lock;

Again, no strong preference on which option you choose.
kdoc warnings may get emitted during builds so we should avoid them.

