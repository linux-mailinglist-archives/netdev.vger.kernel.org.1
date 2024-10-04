Return-Path: <netdev+bounces-132097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7799062A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35988B2227B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF62178EE;
	Fri,  4 Oct 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZJ7lTf1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF0216A06;
	Fri,  4 Oct 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052392; cv=none; b=cZEzj051QoYTVq7tpE2fz+vrXWbyIgj/R+EfYMyW543MVwbpe9+GtmJx/jWyXBb3sxOLOJZ3LvGKsBT5JNnZxkuXhb44qesSv5c6BPS5SRy4B3eptyZaET/GzksO1H3UgjPXGC17fx51LJ4jVXr6klLcjE5m7WHx1ZsoiQkRtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052392; c=relaxed/simple;
	bh=BNq+2BVbN1l33gixxoqIfhl6WtmK4yi8jzOPhLnc1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntc8CR6QlGwfm8CWoZNZWgndNqgzxouv57cUfS0/1R2lRQ3Sd8lBE0nqhDShdYrAufhBXajlb1TT+nAH/r30B0RAfOI2BqO4m+YRuEu3InI4UhCLQZVRceieTJT6gN6+05z3em3pTOJqzXCQlCccG/ingcZvKHVrkdRcQLOCgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZJ7lTf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BBCC4CEC6;
	Fri,  4 Oct 2024 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052392;
	bh=BNq+2BVbN1l33gixxoqIfhl6WtmK4yi8jzOPhLnc1Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZJ7lTf18AOZGhmxz5nWFA351JyvnAsEWL8pjGClUYq9A2gdKSndmv2bOuKfm9HAA
	 FC51D7tj61c3iQjGzaki9cPiOcaCABHhV2JfS3dEmhA9yEJzE02hfp9Xew4BJ7LGJ0
	 Djg1AAGvOaCLl1zwarBK/9i6v32EwxVYTmMiKDAmI8y0apUskhweQsL13PdgZ0HYFa
	 cYJ3uRJYCmk6pKbhrd1GPZNpgR4VWfo8Y2P+LYbon7tpSSsTO7FadIeR1ZkQZXL3nI
	 Db624rDGiul6LrEG2E6b+11zE0U884e5KWCToAH/IZxCqjp0dRkmxJLlBibGkQfD+e
	 ru7eJTa90Ko9A==
Date: Fri, 4 Oct 2024 07:33:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Abhijit Ayarekar
 <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] octeon_ep: Add SKB allocation failures handling
 in __octep_oq_process_rx()
Message-ID: <20241004073311.223efca4@kernel.org>
In-Reply-To: <20240930053328.9618-1-amishin@t-argos.ru>
References: <20240930053328.9618-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 08:33:28 +0300 Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.

You're doing multiple things here, please split this patch up.
-- 
pw-bot: cr

