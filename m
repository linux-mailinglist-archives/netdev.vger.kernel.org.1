Return-Path: <netdev+bounces-126581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A365D971E91
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B08284BA4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123DD7CF16;
	Mon,  9 Sep 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjA3HRpc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5B1BC49;
	Mon,  9 Sep 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897534; cv=none; b=cY9xrXVBi0lwKGAe7ZhbTCAT72mpfMHrLTvN+NDMwT120tjK7FQF2Gp1pY+sjySy/zc06/5jNNR2lF5JvubR2DrpnxJPsBKzNGflGd4avCUrXQEZwgD0XwadLckg/0x0jAf39WSWpKoRMxVZo8pwjvSFeT+1G69VfJUO9g7I1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897534; c=relaxed/simple;
	bh=oyW3IcH0Q70gkJiTRSuXEIiMgreHI1AcqFywZedJgog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7WLFlv3F/Bp4Cy9CjwBRNu2b4Uz4R1JArH6/fLLXHtDDbcMT/N7J9/8d6bC3vFITf0KrYzIdXWKuvYeyCqG9euGHiDoRiWycH0bIaUtUlyd+rtEfduj1D/sDSl3L8BRjt3fYdsUfJkEo1rs8NDTmtN6eEOjBLAMbK+LZqIFevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjA3HRpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351D7C4CEC5;
	Mon,  9 Sep 2024 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897533;
	bh=oyW3IcH0Q70gkJiTRSuXEIiMgreHI1AcqFywZedJgog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjA3HRpcVTW8JzmURsekASMfahSvX6HxiNmW6Q3c9UaIsscVL5gXjqqkMC9qjzgB7
	 Men3o4mdmn9kEMQThEQu+ylraG5svSrDwEFJDtjNhVvgX+wvL70ji3hYjKLN3tXIxI
	 xLTVVj/vRTWaXWIMJe9uhgAgXnabtQD6rPuMCfzjVeXdnyfBw2AZIgqQL2X9XPNbC2
	 kBSt8VUkNJrgvFmKwa9H5xYVByWBV+MKi9QVXlPrrmEED2f/NuyPUc0mr4uSPDrG2a
	 t8rNoTGZdZcJyHumfCMoDYGRJINzRHBmc+BxPq9DQ5WNJaaz1ZVO62/caS5oIoVE7A
	 3Q3ZcxWPM55pQ==
Date: Mon, 9 Sep 2024 16:58:48 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v2 02/10] net: netconsole: split
 send_ext_msg_udp() function
Message-ID: <20240909155848.GB2097826@kernel.org>
References: <20240909130756.2722126-1-leitao@debian.org>
 <20240909130756.2722126-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909130756.2722126-3-leitao@debian.org>

On Mon, Sep 09, 2024 at 06:07:43AM -0700, Breno Leitao wrote:
> The send_ext_msg_udp() function has become quite large, currently
> spanning 102 lines. Its complexity, along with extensive pointer and
> offset manipulation, makes it difficult to read and error-prone.
> 
> The function has evolved over time, and it’s now due for a refactor.
> 
> To improve readability and maintainability, isolate the case where no
> message fragmentation occurs into a separate function, into a new
> send_msg_no_fragmentation() function. This scenario covers about 95% of
> the messages.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


