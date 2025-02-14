Return-Path: <netdev+bounces-166436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B9A35FEB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1417F3A5B2E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F5264FB9;
	Fri, 14 Feb 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hTLSSzS6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DD25A35E
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542463; cv=none; b=Ilo8c/oLbzR7i4qCsIxgas5k+jOwZqgIe4UcA4TUelRCdpvDbmWbrzTftAI26Ka3r7KbREWg5l/6MRXyxKczQVjY8vh4uD2/IY75dna2Vf4MCefNjxpu9POQYzXhwFi7xf3TVWT3m/POqbpoCe5JzFgIrmOROZMITqBBIBGpqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542463; c=relaxed/simple;
	bh=XoOP2Rl4B9P2ec3pKEVrjBv0YWzev9pY5vEbs+9JzSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV3KEmnxkjgcLqJsZFDMvs8UexrfFrYzEKFI6L+53ARNnC3UalUjvlDQkrCljbYoNpm3E34gIfEeyZl9w6kIF8WBIN1jE0qc6sa7LSUbVv3aqArJQYDbNVzTwl0DuVpoaGjokUGnVA2tgb6SEs1LT6zYSNtQA+9V9+VY26JbCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hTLSSzS6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwTNYMSB6L78IK+gymK2J/YOKlkj4xNihqKiXhxKYjM=; b=hTLSSzS61rz4N/pRvrURgPeRdf
	ffYS3YHCRZQzdbpzaCLp1TKxCih4kQO55h4zDL059ojKY9ySI+Z3kCcsSVuBoE9toAyax9yBBCgUU
	6oQ2r7e/Y2mundk0LnjdiqiMtysROLNPqMgVDtIFFjc8eUqlOT3Y/Yberb/atLadFEs4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiwSP-00E5Wo-AA; Fri, 14 Feb 2025 15:14:17 +0100
Date: Fri, 14 Feb 2025 15:14:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <10e27c4b-84d8-4c63-9aea-d6d6197510d9@lunn.ch>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
 <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
 <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69MESaQ4cUvIy4z@mev-dev.igk.intel.com>

On Fri, Feb 14, 2025 at 02:58:41PM +0100, Michal Swiatkowski wrote:
> On Fri, Feb 14, 2025 at 02:44:49PM +0100, Andrew Lunn wrote:
> > On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> > > Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> > > from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> > > devlink_rel_alloc().
> > 
> > If the same bug exists twice it might exist more times. Did you find
> > this instance by searching the whole tree? Or just networking?
> > 
> > This is also something which would be good to have the static
> > analysers check for. I wounder if smatch can check this?
> > 
> > 	Andrew
> > 
> 
> You are right, I checked only net folder and there are two usage like
> that in drivers. I will send v2 with wider fixing, thanks.
> 
> It can be not so easy to check. What if someone want to treat wrapping
> as an error (don't know if it is valid)? If one of the caller is
> checking err < 0 it will be fine.

I put Dan in Cc:, lets see what he thinks.

There is at least one other functions i can think of which has similar
behaviour, < 0 on error, 0 or 1 are both different sorts of
success. If there are two, there are probably more. Having tooling to
find this sort of problem would be nice, even if it has a high false
positive rate and needs combining with manual inspection.

	Andrew

