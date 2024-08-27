Return-Path: <netdev+bounces-122374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99130960DC4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EE7284BF2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FB1C4EE8;
	Tue, 27 Aug 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5s3te5X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A41494AC
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769677; cv=none; b=ZbxBXgfvhc+QaUrqD5ScUGY3Xu/xCE+pAIFM0cj10foeGkmTPSzGRZnjYFglWB7Oa5j4Gfdgu1ZFd2VLqYX3ZVHLIsMiSe2pqc7JeqdEI7vo0s7wwi5O8p+9YJfB/8473EahD80DLwtpwsqeiFlHd9+67UnoM2nc51BG30rNI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769677; c=relaxed/simple;
	bh=1o3T2WJll+93Xjgt3B+0jROatBtYxIBfo2PFyhuq+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GduNWxjPiiUGXpTDx8kOy5XoIFf5Nee/5UKqDn6RkB5MpaCZqThhbj/Buqto36ISXK9Tp/cVCds1M7EoCoOZZa1zUmQfe5addV8/JLA5pP8YH8TjNlnpnOlyXz6cunLxG2kI2mTgUzmtX8ruygjM5bNeFsvUkHsOPXVKE8+pXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5s3te5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415EBC4AF15;
	Tue, 27 Aug 2024 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724769676;
	bh=1o3T2WJll+93Xjgt3B+0jROatBtYxIBfo2PFyhuq+eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5s3te5XqcQhUlqksT1Nab1G1EeGdEd1+WkOuzqjUnfppNC7DXlk6HdOjE2wKq75T
	 3ODKT6erH7HHwiUjR26tKjPg+xbv8VkOSuMe6devBquseqz6tzROeGk4pF9JpfOCvF
	 GEfgei/s5V+g4MyFpNPZkSxAtckdWHbljaBxrGna9+XSXqooQabDvVpFie9g3D+ANz
	 mU3lSXS/bOaPkOM8cpmqPwdVeo7hsNxkze8qGpzI8PWkck1W4G/fdlj2IQjLp6di4F
	 QScQj8KJPdKySexmyaIzqxApRwVV9UQhQ3DE3et78BFNPhNBDyXlGMXpAsKpSzGuVb
	 TJEpDOVqyxdDg==
Date: Tue, 27 Aug 2024 15:41:13 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	Andreas Schultz <aschultz@tpip.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Subject: Re: [Patch net] gtp: fix a potential NULL pointer dereference
Message-ID: <20240827144113.GE1368797@kernel.org>
References: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825191638.146748-1-xiyou.wangcong@gmail.com>

On Sun, Aug 25, 2024 at 12:16:38PM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> When sockfd_lookup() fails, gtp_encap_enable_socket() returns a
> NULL pointer, but its callers only check for error pointers thus miss
> the NULL pointer case.
> 
> Fix it by returning an error pointer with the error code carried from
> sockfd_lookup().
> 
> (I found this bug during code inspection.)
> 
> Fixes: 1e3a3abd8b28 ("gtp: make GTP sockets in gtp_newlink optional")
> Cc: Andreas Schultz <aschultz@tpip.net>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Harald Welte <laforge@gnumonks.org>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Thanks Cong,

I agree with your analysis.

Reviewed-by: Simon Horman <horms@kernel.org>

