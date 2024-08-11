Return-Path: <netdev+bounces-117483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B494E187
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C951C1C20D14
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A166149C4F;
	Sun, 11 Aug 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAZima4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DF149C47;
	Sun, 11 Aug 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384721; cv=none; b=UduH8DbFXQk46Vzr+MBPE0qYqGFyk4/tvBiBfKMLx4c2nAapCXKsodH17npJJ5InTCNFbWRdsBuAJUon+b20L85XliUnSQJss5x0EP285F/E+itENuCRmhHa6irCGQOkLeOvQCT0jFNDC9PVzTVv1Xb8/XXRQIpD6FzYU+fSjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384721; c=relaxed/simple;
	bh=o5a8FFs85PMoZBta1eolepimcLRI3x86gA34btyJ5+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gByqaS5lKpPloJv/bCFC1Ct/ho6mGb9bR5MtYNFb5zJCiyYxTC7YCsRJvE77OPXQjLzi3QKJsFLHVzgr5s5YX/f/gqNud5Kkx1Ff8n60CLolUyksgKRDqiKQO70w5sVQGvc0YY36RRTVnJjwMiJdMTZn2gly0hFoYRkUZtETGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAZima4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0863FC32786;
	Sun, 11 Aug 2024 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723384720;
	bh=o5a8FFs85PMoZBta1eolepimcLRI3x86gA34btyJ5+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAZima4/ezuDOUmGiSNxtA0OD5o18jUVBBv806mywLMQfYPUZw8h5ofNFXSttpFtG
	 g6xEKBw1joDQb2ArR12K9RQQG3bsWdsKflavw4mk5XhCP/gcMvhoxgMrvz4CxzvceG
	 8He+f1AW9/CmNKLg8FvubxzqNjzMxh+NxGbYJrEPECgM43p3eAV4d2hKYk0oTp3cra
	 IGtJlHcF7Pyyp3SMmKoQofITL3H6ZK2/f758q0Qihqmzrx4D20tnXFG0NOhu5dVwuO
	 5qz6Vs51YYS0zGV+Hi+kIjw369bRHjs/3W3E+5qbTHKulIWFPPBHIT2vgoDQBqeuQq
	 bheN+JOPcv9Dg==
Date: Sun, 11 Aug 2024 14:58:35 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, idosch@nvidia.com, amcohen@nvidia.com,
	gnault@redhat.com, dongml2@chinatelecom.cn, b.galvani@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vxlan: remove duplicated initialization in
 vxlan_xmit
Message-ID: <20240811135835.GK1951@kernel.org>
References: <20240810020632.367019-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810020632.367019-1-dongml2@chinatelecom.cn>

On Sat, Aug 10, 2024 at 10:06:32AM +0800, Menglong Dong wrote:
> The variable "did_rsc" is initialized twice, which is unnecessary. Just
> remove one of them.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Thanks, I have verified that did_rsc is initialised to false,
else where in this function, before it is otherwise used.

And, as the function may return before then, it does seem
reasonable to defer initialisation until then.

Reviewed-by: Simon Horman <horms@kernel.org>

