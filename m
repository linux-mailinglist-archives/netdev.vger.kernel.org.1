Return-Path: <netdev+bounces-136615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894309A2531
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1FA1C2288F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AF1D47AC;
	Thu, 17 Oct 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pnx9i1yI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104510F2
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175790; cv=none; b=uk6K7NTNTuj243lIFZUFvmDLGNVUebhy6PpfQh6HL0BQajF+KUnktYLELuhGH8aX/Ma365d+9RRdibWBYsQgKrezl5oihMb3BbHueJzvCyIZryKUNyNtmfdxVPBKmhGxrtesyvJT5PPhKrnAzdJmVVquL2v6mvMO6Zhqi1v1n20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175790; c=relaxed/simple;
	bh=xsnoAs5t2EzyeZjdv9iWK4k4tnP36vpJBxRe47BN498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZT5ALl6J+U0KyrYLj4c8LfePl0utFRVctE1RnLbUODeToY0raJ6wGAjbuaLOQnNR+VQgIrmW3IrmWwWnsXdDLCERQaaPmu/OKijBkZmbTNrwZ5R6mL1LC3v5Ht5libUQYNq1Poe1vcoOXApgCMq60KPrbgj9RLpEbzq75F6QtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pnx9i1yI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF3C4CEC3;
	Thu, 17 Oct 2024 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175790;
	bh=xsnoAs5t2EzyeZjdv9iWK4k4tnP36vpJBxRe47BN498=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pnx9i1yIMY1S+ItuKqnS3P1BpeoOMra9oVQGvoPhLVy/14+7Q/MzNgr+py2PSumJe
	 e/VPmi410tpYdoAbFsBMSSbffBhwRImV6q5gG/DypHf6qhpkASn0F33m5kpgrOUxZG
	 lQ6M3lbEzCnyKI/n8t12rqR5nPHHVyZjIoTUS8IrzSTwlREjZ9Ikq+8gFDWYmlZk+q
	 K/AfU07KxYAMW3icRh7FQlAgRxO0h4xVlB0lu3kF+kvjMQKQ5c2sUh71YBSNw+oyCJ
	 8H7ZQCjirObTDe6rpWASWXMx68B60HKxOylGMKKC9Jlll5IVdimEdzfQkTfOTCsU6U
	 /b5digM6EgX4A==
Date: Thu, 17 Oct 2024 15:36:27 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH RESEND net] net: dsa: mv88e6xxx: Fix error when setting
 port policy on mv88e6393x
Message-ID: <20241017143627.GT1697@kernel.org>
References: <20241016040822.3917-1-peter@rashleigh.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016040822.3917-1-peter@rashleigh.ca>

On Tue, Oct 15, 2024 at 09:08:22PM -0700, Peter Rashleigh wrote:
> mv88e6393x_port_set_policy doesn't correctly shift the ptr value when
> converting the policy format between the old and new styles, so the 
> target register ends up with the ptr being written over the data bits.
> 
> Shift the pointer to align with the format expected by 
> mv88e6393x_port_policy_write().
> 
> Fixes: 6584b26020fc ("net: dsa: mv88e6xxx: implement .port_set_policy for Amethyst")
> Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>

Thanks, I agree with your analysis.
And that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

...

