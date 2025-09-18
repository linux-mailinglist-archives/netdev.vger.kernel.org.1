Return-Path: <netdev+bounces-224594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA061B869DB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9421B25B21
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6432A23C4E0;
	Thu, 18 Sep 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+ibkjzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D94A2D;
	Thu, 18 Sep 2025 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222371; cv=none; b=WCrPhKQj+wnpYEzUWeTYa0LZBPKvm6/lS0HqcPk80GZNkfg6SoQp7ObAULqLq9SpoHIKVErq5/xTRkRd+6B8HcmDu5RQGsAhDrHtmA7YLlVIqm+F+47b2CrxsUMGML8EY/kR/ZZayhtfFxtalK6SZtyexfGMKQj7cIyoCD3PC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222371; c=relaxed/simple;
	bh=mcMpLeS3K+Px3yW5q4lpYSSclMu5cVJ/n7WoXdEJH64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+Nz/Tp7Yp1DdoWBD9OoqTtKyPjulYvCW/km2PPOFkQq0rmwt5zVZk2HGO75kjGDJghZfjNaXw+6Qks4AZba/b/W0t8YZaKEMZcKd9gx5tf/YjxNyzr15SaJAm1Ewz9WF+GvXudUrhm7DYu9QB7FH5WI/jJj624HPkTYCisFwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+ibkjzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515EFC4CEE7;
	Thu, 18 Sep 2025 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222370;
	bh=mcMpLeS3K+Px3yW5q4lpYSSclMu5cVJ/n7WoXdEJH64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+ibkjzIVF+1FhJ1udqpCLC/XMdR4bBb8R+C/Uv+cKKXdHxGQnS/DkaERxSQIhcoL
	 HqeiwvLfXjZkzUbF2zIfKi1twDmn8QfZGS7XU+kRGFDdCIH6dSguUjvUegR4OMREgO
	 QKDMwnWXkXAwkxEdPJSGB2vc5JyhZrOyI66Sg1o/riAj47ZxATmiDMp+wCiPgDv3VA
	 NvikKHTHRlAfhRw8nFz9KHNsm1ZxGUoIK5g41CeA3yek6y7XjwUrWFcHqbvPLrL/y4
	 s7/I7FCUacl9uV8KcSyHDBz9w8po0I7WKErvI8aRfNXnLNHFyMU3QZ1JDLQ/uy/5rT
	 Qcf91iG7jXEiQ==
Date: Thu, 18 Sep 2025 20:06:06 +0100
From: Simon Horman <horms@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind
 on failure
Message-ID: <20250918190606.GA589538@horms.kernel.org>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-2-bhargava.marreddy@broadcom.com>
 <20250916151257.GI224143@horms.kernel.org>
 <CANXQDtbXG2XjBa2ja1LY7gdALg-PnEyvQBWPAiXQqD0hvtwp=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXQDtbXG2XjBa2ja1LY7gdALg-PnEyvQBWPAiXQqD0hvtwp=g@mail.gmail.com>

On Thu, Sep 18, 2025 at 03:20:09PM +0530, Bhargava Chenna Marreddy wrote:
> On Tue, Sep 16, 2025 at 8:43 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Sep 12, 2025 at 01:04:56AM +0530, Bhargava Marreddy wrote:
> > > Ensure bnge_alloc_ring() frees any intermediate allocations
> > > when it fails. This enables later patches to rely on this
> > > self-unwinding behavior.
> > >
> > > Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> > > Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> > > Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> >
> > Without this patch(set), does the code correctly release resources on error?
> >
> > If not, I think this should be considered a fix for net with appropriate
> > Fixes tag(s).
> 
> Thanks for your feedback, Simon. This patch doesn't introduce a fix;
> the code already frees resources correctly.
> Instead, it modifies error handling by changing from caller-unwind to
> self-unwind within this function

Thanks for the clarification.
In that case, this looks good to me.

