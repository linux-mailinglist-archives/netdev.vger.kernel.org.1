Return-Path: <netdev+bounces-191974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F4ABE128
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FC161BCE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667382620E5;
	Tue, 20 May 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvfcxgyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADE79CF
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759945; cv=none; b=kS+tSgHBhpofXosjsy+0xJXQdrKmhDi+pk0tAdKsw3ASRD4DDFNmYYZukFrMFO3gf+hkll9HUeR8+yoGNlB+KK432gSaZO7Nxxoh/vLkjk+XibRCGxCcHmJDpoGJLPKjfU2Hiz4LB4grrEI5/qqNtbdLEGE1FtR63mSoJ4ctb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759945; c=relaxed/simple;
	bh=ShlZzqbhoQvvleISg5FkFTCMcGbXMsdcSxpZUSf2JXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chXI/DFPyjgaSOnHZ4LzZEGYsHAJC37GuqOrOBV0Ce35PZnVCdtA0GmyGQlCxaj7cWDkAySLp2nBGle+Y/j7qxjIsymN/9gtLp18gHej5zt02sU9J8tPz3EYKXxUZjWANDhiz6mEF7eW4MTVLHFnBeNo3MOm2H5kEu07I34TXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvfcxgyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B96C4CEE9;
	Tue, 20 May 2025 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747759944;
	bh=ShlZzqbhoQvvleISg5FkFTCMcGbXMsdcSxpZUSf2JXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvfcxgyduibYGps5VypZUAcKAy+LfF3eyaIDWANKKaO12Keg6dTVkS6S6bfVfOTWO
	 uUzBHhEt631O85DgOs/UxWuyOyIAVcQ4i5Sv8Nx2V/NIpHW1aUSYu/o4FY2KtyAlOy
	 mhJXbLzG0BFdLwRBIqiPuvCil4BSViJs54KBEgRZfhWzZjdTeDpPp3T/vo1A/iAf15
	 M+re/28WC2gsOTzz9hWwZ0/vSX1yLffwgapXHhPqaQlCOOyFhqMdNUgAsI5fueOvv5
	 7o/Emt4nOJXrejzJwEvuDbXBGpXMLphzKmByiMSHLo531WzgXMosrMEOO5TcgC2ApU
	 vBHhO48DlMCpA==
Date: Tue, 20 May 2025 17:52:21 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/2] net: libwx: Fix statistics of multicast
 packets
Message-ID: <20250520165221.GE365796@horms.kernel.org>
References: <0250972BC2F238FA+20250520063900.37370-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0250972BC2F238FA+20250520063900.37370-1-jiawenwu@trustnetic.com>

On Tue, May 20, 2025 at 02:38:59PM +0800, Jiawen Wu wrote:
> When SR-IOV is enabled, the number of multicast packets is mistakenly
> counted starting from queue 0. It would be a wrong count that includes
> the packets received on VF. Fix it to count from the correct offset.
> 
> Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

I note that this is a fix for a commit present in net-next
but not net. So the net-next target + Fixes tag looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

