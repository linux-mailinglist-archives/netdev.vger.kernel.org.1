Return-Path: <netdev+bounces-132767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0549993122
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F651F23687
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691A1D95BA;
	Mon,  7 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVXdtMTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43F1D8E08;
	Mon,  7 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314933; cv=none; b=DSXwhEIOEF9ZL8Cn2boYlWOCMGtVGxoZANMz8Ioc6AJzxbJTh0d8oCytk2ukBoozZEpuLDnD86Nmj5U9B62LA7DFvBVUrow6JBmvO7Aoaa/nHxBL0kMpUSfUaBFlOTagPpxQSJZRQpwRLGYAM5nEaLIZIc29ifjhXf1gWyB85Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314933; c=relaxed/simple;
	bh=Y0dsgOPCRxpo5JPknAJ6peCR29pneX/jCh4JsOnA2EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI+ETD6PhzIApVKdINNZnrOeBOAD9fU0fdQQNPYPCN7xn48ongV2ABBW9Yq4bLR64JHWwqrwBEwaMOzTG7AUvdXVePcPg2od48O4yNqFirAl2YCT+MvQiiJ5by+xoiaYujy8CS8DiB3YG0RkO6E+LjKLFN9dhZq6iuw1i5R/kF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVXdtMTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A57FC4CECC;
	Mon,  7 Oct 2024 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314933;
	bh=Y0dsgOPCRxpo5JPknAJ6peCR29pneX/jCh4JsOnA2EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVXdtMTHGt9Qzfnlybyp/wChlAwXzwvpIaBwAqTYay8UAJgC3EL16XnxX0YrCIt/r
	 4jYlojS3ZtHZT8BqlUb8RHKlKIVteYNPQs9lRmMN4hvxLhQ1iPs9030GPuobUqEJMi
	 lmIqdBfaxJ2PEVcD5j08gjFqb527GFe+/12HC0TsFQFTweowlijoiWN/DQnVSsdgz/
	 b+UFYylXTcNhUcjRvKa/c9rUlmN+Y4dVruBrxcmXAOGBFZ5PF0MFOQF9PiHR/HhOJI
	 FLK7KYRx5x786Hv3M8o2pQYWRYL6//hbtcFpHtdVuFrer2UHntBY2gI6467kzt5yiO
	 XLncprUZFZAAw==
Date: Mon, 7 Oct 2024 08:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 17/17] net: ibm: emac: mal: move dcr map
 down
Message-ID: <20241007082851.0de5e329@kernel.org>
In-Reply-To: <20241007070514.4439425d@kernel.org>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-18-rosenp@gmail.com>
	<20241004163613.553b8abe@kernel.org>
	<CAKxU2N-F+Gcv_LVvH5uB+x5gGABwzFsvxZOg+ApQ-DAHaFz3iw@mail.gmail.com>
	<20241007070514.4439425d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 07:05:14 -0700 Jakub Kicinski wrote:
> > > Not a fix?    
> > It's a fix for a prior commit, yes. 6d3ba097ee81d if I'm using git
> > blame correctly.  
> 
> Hm, I don't have this hash in my local tree.
> What I'm getting at is that if it's a fix for a patch already in
> networking trees the patch needs to have a Fixes tag. And if the 
> bug is present in net - the patch needs to go to net rather than
> net-next.

Looking closer I think this got added in:
commit 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")
please post the first to net. Then once net gets merged to net-next
(which happens every Thu), you can proceed with the net-next
conversions.

