Return-Path: <netdev+bounces-93142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9618BA47E
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0867B23CB5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 00:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E3368;
	Fri,  3 May 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfXy89FR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A02360
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695763; cv=none; b=dp5W5npEAOMasAbEC4nBparFVWk5nRdkUQ6nAZTZw1qEzVCSBFxE8Fo9eJCpiXHqC1n8VxRKweZEtKfYmBbcJO9KN/eP2eClTT8n5/lfJ7iPzXvp6GNOV7vTO5Djv5IKQ5lcIE0WfxO9eprt2xyA/BSRVK57eQ2V7tpukoKV2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695763; c=relaxed/simple;
	bh=8q9HvUtKUiQyMn3xs3ba1qE8fJsyY84+ny8joN9BcWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbKvweVWgYOrCn+UuBdXFDjPO8oOSOhikqmbvXVBOAhzM7dvddB1meCZAbFi/OpskeLvsyaa8zd34p9LU/5GruGMMDWg8R7mTgYmMg1x0KwA0ZVlehrkHOAcWcU+a+d0SKqI2JduRN4+jgOl1KNLb8hB74Fzj4AFRPI+Wji80/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfXy89FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B178CC113CC;
	Fri,  3 May 2024 00:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714695763;
	bh=8q9HvUtKUiQyMn3xs3ba1qE8fJsyY84+ny8joN9BcWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfXy89FRtI5aw38Edc3oY7Te054W7zbDdVTmNHCecNdPoXVTYbgHr9iQWMh3/j6rJ
	 YEkpu3rGaSXR2IdEmXcHVNil1fkGQZZO1uCArVXl4y3BtG4F0HSw1KdYU6aZ1FvOQ0
	 Bt6fLJQg9S26jWhCINrWIca4bnLZ0reRBifq3qoS54K4hMMF5L6ie4LEmTHLwxlLwx
	 8ss6a+ahxXrdLdguxRSJCgybBp82knqJPfmkBaEDEystPLpUnKYc6y/Ygsy5rYH+8X
	 a93ihwYJZnEhrCuUW82/mRd4dcsFMG5XqDxgviDsfzhXqWe5QFvk0gYcDDt3Nxzztu
	 Mlz7FvxSNlikg==
Date: Thu, 2 May 2024 17:22:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andy
 Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand
 <shailend@google.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add
 netdev_rx_queue_restart()
Message-ID: <20240502172241.363ba5a0@kernel.org>
In-Reply-To: <CAHS8izMzakPfORQ9FX8nh0u0V7awtjUufswCc0Gf3fxxXWX0WA@mail.gmail.com>
References: <20240430010732.666512-1-dw@davidwei.uk>
	<20240430010732.666512-4-dw@davidwei.uk>
	<CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
	<5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
	<CAHS8izMzakPfORQ9FX8nh0u0V7awtjUufswCc0Gf3fxxXWX0WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 09:46:46 -0700 Mina Almasry wrote:
> Sorry, I think if we don't need the EXPORT, then I think don't export
> in the first place. Removing an EXPORT is, AFAIU, tricky. Because if
> something is exported and then you unexport it could break an out of
> tree module/driver that developed a dependency on it. Not sure how
> much of a concern it really is.

FWIW don't worry about out of tree code, it's not a concern.

