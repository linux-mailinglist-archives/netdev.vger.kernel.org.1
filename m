Return-Path: <netdev+bounces-173827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD9A5BE34
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E30163D5B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF572500CD;
	Tue, 11 Mar 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzXO8gJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B324F5A8
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690120; cv=none; b=kPZN5ej9V1Os4/iyAka39cugs1U3IjepIKeTdZL5eLwHY/lCNKGk+ScnGvyU/Z5KNcJMYNfwJ07rU6J6jNo3ubgspMO6or1SzGWD/4Wfvm4l3RztTsXnUe+A1vgwRMPw9tJPqHgk45KJSqP6/sOm3fa2BWWQMtUnODoOp1ljk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690120; c=relaxed/simple;
	bh=vuIP2BxMldHeDrLEfAfJTipnUP74tlV3FUYVhzpsg1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icV1kmckn+rOP7iSJ85O2+2P8kkiG4c4s5XzI2thgBF0pFUp5iffGf80aU4jnmwZPliOb9taJn3EjAHzE+t2ke/WMP3Ow35Z7AAGQYcFTak+2i5j1sWH2VNH2mKHlD2BZ0d1nn+4Da1gqj3c8Jik7SPy+JmzRZNYFdTk2e02t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzXO8gJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20593C4CEE9;
	Tue, 11 Mar 2025 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741690119;
	bh=vuIP2BxMldHeDrLEfAfJTipnUP74tlV3FUYVhzpsg1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzXO8gJbD2ruOk+ivFMX/w3isZgkSau2SzXpgB3QDz046f3y3TO8WdAIwjX7QnoBP
	 GCbvRFVXPL2+DHPsY/QCUoavv9+t89JQg0OijMbySshTotIw8j+OfOKv5WGXCyRuNU
	 bkFA6e95rW/dMSqvYiHrJ0nWG1RCim+0fopfEaewCN8zuz/QuKsavKPdEsJKWdYEDh
	 txa6K5FYpdC0Dy0Xvu1YdjU0SGvqYtbb/JRZNhDBKaK9l4TrXcVbRXu0mZlHQGkCUw
	 +6jTWZ7lwxSt0EV6qNzbVTxUubTBEMkWX8jv6jF1KBmZfRP7M13q5gtrAkMYOR2c7p
	 coTA28N8mMQ9g==
Date: Tue, 11 Mar 2025 11:48:35 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	mincho@theori.io
Subject: Re: [Patch net 1/2] net_sched: Prevent creation of classes with
 TC_H_ROOT
Message-ID: <20250311104835.GJ4159220@kernel.org>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
 <20250306232355.93864-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306232355.93864-2-xiyou.wangcong@gmail.com>

On Thu, Mar 06, 2025 at 03:23:54PM -0800, Cong Wang wrote:
> The function qdisc_tree_reduce_backlog() uses TC_H_ROOT as a termination
> condition when traversing up the qdisc tree to update parent backlog
> counters. However, if a class is created with classid TC_H_ROOT, the
> traversal terminates prematurely at this class instead of reaching the
> actual root qdisc, causing parent statistics to be incorrectly maintained.
> In case of DRR, this could lead to a crash as reported by Mingi Cho.
> 
> Prevent the creation of any Qdisc class with classid TC_H_ROOT
> (0xFFFFFFFF) across all qdisc types, as suggested by Jamal.
> 
> Reported-by: Mingi Cho <mincho@theori.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Hi Cong,

This change looks good to me.
But could we get a fixes tag?`

...

