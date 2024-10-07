Return-Path: <netdev+bounces-132653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58270992A9D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EA1F236DF
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960CD1B4F2F;
	Mon,  7 Oct 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gENxy5AY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D218A6AD;
	Mon,  7 Oct 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301703; cv=none; b=nB5d5BXJD9FpwhFwogWQeO8LoLqujnWqkWKa+qVQoMZj+WINMsZU0oJ8BJe7cClaVjB8TWwAE5q/7g+c+h/MJJkGBhzCoqcOTT47e/DkGiw4gvs2imhMKHu9OvvrE0hxkKMmQLewFoShhkx1WWDCok6wWDEjSrDx6J53l4zkgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301703; c=relaxed/simple;
	bh=385W9W9QYNTyfuD6FUYa8ebktE7Q2QSi8i4s3DwWVPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMUFXX6xsFBMJEVZDRcNvRsJhAulv75rRiDfaiaplyQtEmldMYaczTCBf3R3mSwDb5sZ7z17030RTO6LxgKiqwbJGAHklLWWg1v+Nsghjl7dijHjTEnkJggYdLj/ixK+Am+AsAZHLgxKRKeJzV4l4MERVeM+kd6zhE7zgCX/dfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gENxy5AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B4C4CEC6;
	Mon,  7 Oct 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301703;
	bh=385W9W9QYNTyfuD6FUYa8ebktE7Q2QSi8i4s3DwWVPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gENxy5AYP9qM7KkOxjjoibALNHn9iljkoW+UY7NPcxKhMyAvZ/dIecYLxCT/PojIu
	 04r+asy/SeC7JVqw16e/6zMXN3C+nGRCcVhbCCMsMwdiwWfnH+idjPd4wZ21UHcZpc
	 znfz9qXfLQbTat27nyPawY2Nf/WeGH3WIRYNhT2pclC+/QyLBYOfImUVv8yB3uO7dI
	 xlLK8E3FU4mUJnTnhQs9+it9uKwVzBFE2De1Ich4q/kmHGBOBSrdKiUjwibHOhhUAN
	 V+fbPRjJEIIu/4MKGFb82TdWCPmRDiC7YmhCS5WViu/NRbUwtth8+HIiuqHofdZmBR
	 PbYdJNO527yfA==
Message-ID: <dc17ed49-aed6-4c44-97e9-d6b21e5966dd@kernel.org>
Date: Mon, 7 Oct 2024 14:48:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
To: MD Danish Anwar <danishanwar@ti.com>, robh@kernel.org,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, andrew@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20241007054124.832792-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241007054124.832792-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/10/2024 08:41, MD Danish Anwar wrote:
> The VLAN table is a shared memory between the two ports/slices
> in a ICSSG cluster and this may lead to race condition when the
> common code paths for both ports are executed in different CPUs.
> 
> Fix the race condition access by locking the shared memory access
> 
> Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

