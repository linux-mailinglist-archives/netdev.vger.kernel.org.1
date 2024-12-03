Return-Path: <netdev+bounces-148326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B433D9E11FD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FB92828E0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302916BE17;
	Tue,  3 Dec 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdGxMH8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A421304BA;
	Tue,  3 Dec 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197472; cv=none; b=Vu/hZu2os8G6Z2UVdJEGr9jNqpMz+engkNx/2DnpfMReiF991vfT2ifNI4xh9GAGv7ISqehVTWWzgI1vHYPkAuvwCHLdDr5V8tijSW3yxHsersDHjBSVb1KWzKmI93aqLZR/RvaFE2n3FLgSmDfiY+5rKyDaR3Y943lWKjcCDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197472; c=relaxed/simple;
	bh=Kf9YiXZrjswwCIUkQVwB8maazm8DaPi7VK/f7wvzAww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvZRca6MB2B1iOcaHS1n67+z31/xoTpYEwrWmTQ5vbaXbWRSsWMJruMhrwpUqgOI8aqQ9TdwCQ0Fa2z1GUl8+of16vWjlMM+/gWQhmfYVmwzkk0qDpeOoSGIVgABOdRVCF9iqh7esGi3d6NPcod0GrCXxuhqE2k2RCjFVHAg+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdGxMH8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC38C4CED8;
	Tue,  3 Dec 2024 03:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733197471;
	bh=Kf9YiXZrjswwCIUkQVwB8maazm8DaPi7VK/f7wvzAww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdGxMH8THHQTY7MATjtS+qPlRZjbQwDLNfffrqNIE4fa5n2FRXhd8k/Mc/sU06aUp
	 8stkGE3N1HO9VQxjre15CoGKG0AP6TNEhHUlgKROAsxaNobJpNzwe28Dl0XaBv8rSF
	 pFcwGovvKjqkqEzhPjJotJQu8mV3HZTIcXdeaLUmkVEJbJjkvhyKaqQGPrMhgA8nRr
	 ESknBxxDgyIJ5/RvWMqyAs68UHZ3qhUUF+gfpmfg/l/swo9i+i6mpeBrkqJ9XlLg1j
	 l+9uXd/xAAcEHVVOD9MQxodYlIDtQ2exq80e/uDn+pcxEQSeFaLphjyhxWcMEeXsMV
	 BikVO8CIpIR0A==
Date: Mon, 2 Dec 2024 19:44:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 16/37] rxrpc: Implement progressive
 transmission queue struct
Message-ID: <20241202194429.0cec6f2e@kernel.org>
In-Reply-To: <20241202143057.378147-17-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
	<20241202143057.378147-17-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 14:30:34 +0000 David Howells wrote:
> We need to scan the buffers in the transmission queue occasionally when
> processing ACKs, but the transmission queue is currently a linked list of
> transmission buffers which, when we eventually expand the Tx window to 8192
> packets will be very slow to walk.
> 
> Instead, pull the fields we need to examine a lot (last sent time,
> retransmitted flag) into a new struct rxrpc_txqueue and make each one hold
> an array of 32 or 64 packets.
> 
> The transmission queue is then a list of these structs, each pointing to a
> contiguous set of packets.  Scanning is then a lot faster as the flags and
> timestamps are concentrated in the CPU dcache.
> 
> The transmission timestamps are stored as a number of microseconds from a
> base ktime to reduce memory requirements.  This should be fine provided we
> manage to transmit an entire buffer within an hour.
> 
> This will make implementing RACK-TLP [RFC8985] easier as it will be less
> costly to scan the transmission buffers.

also possibly transient but clang says:

net/rxrpc/output.c:815:20: warning: unused function 'rxrpc_instant_resend' [-Wunused-function]
  815 | static inline void rxrpc_instant_resend(struct rxrpc_call *call)
      |                    ^~~~~~~~~~~~~~~~~~~~

