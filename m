Return-Path: <netdev+bounces-70990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C618517B3
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB241F2146D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F693BB5E;
	Mon, 12 Feb 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMTUa2QC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BA3BB47
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750739; cv=none; b=r72gVDbyLzv9/+1v/UweqpTMrPBMm1DhLf4nZ9GZiP+RKTH7DVsy7pp8OZ+0O0WsW6SLls902DhkT3O4ADQ5K71uVGHW6r8MZk2qZtFb0bbWLjIjyel54jBBXhLqI3JB4Qk91oC9WyMeyy7E8tIsIjmP0sLuvV6mBY06Be/QBu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750739; c=relaxed/simple;
	bh=kkseZIm6ZlPIBsB/X53FwjKVu7CXE4Epox0B+g9MJeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDhc/UFfDaFFKHW4agPVmMMUDOYk9PXqgAjw/JqSfuDAoRSbbAMKZKO+am7dJMC7CTdo/+rNnUMnIeuhqsC9IKTMW+5V34yftQvQveFSs1lQFGu++eyR2Rhk8w6keb59iujF6i78zp9/4udYfUsFO15xsHsqqFin2H1NRPW29GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMTUa2QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ABDC433C7;
	Mon, 12 Feb 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707750738;
	bh=kkseZIm6ZlPIBsB/X53FwjKVu7CXE4Epox0B+g9MJeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bMTUa2QCLsbGNLWbUPbgaTt9otlhqe1tgjkWfCtjSgAvdn2wJNCrGyQsd5n9scCLw
	 5Fz4N5jfe4zD520UhntjBsU5glOd4SG0eAnR77tgdKNaVuJiXXSc5daTKQV+qcXaS6
	 iqKts6KvMuZhqG/VhNKOCdce5rZFzBq7j98L43f8TMfWKL5/C8Kom+3SJtj4RjqL4F
	 78/+KFJg3kVxwdnAdlf/+FSYuI2vJYCvjGPwXUJZ6OmzNMdYxDIvwULQ2y+kdIKLH3
	 f2q7MBT+mgjqnOh+uNFkUv+1nLo94sacS9jB4ynSJ6+s6M022SNsm0hn9tZsGMRBO9
	 sJaq3VRN93+Yw==
Date: Mon, 12 Feb 2024 07:12:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Yannick Vignon
 <yannick.vignon@nxp.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
Message-ID: <20240212071216.21e36c5c@kernel.org>
In-Reply-To: <87il2t98ri.fsf@kurt.kurt.home>
References: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
	<87il2t98ri.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:17:37 +0100 Kurt Kanzenbach wrote:
> On Thu Feb 08 2024, Kurt Kanzenbach wrote:
> > Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
> > interrupts") disabled the RX FIFO overflow interrupts. However, it left the
> > status variable around, but never checks it.
> >
> > As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
> > simplified.
> >
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>  
> 
> why did this got marked as Changes Requested. What changes have to be
> made?

Sorry, restored!

