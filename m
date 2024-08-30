Return-Path: <netdev+bounces-123912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D242C966CF8
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 01:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110D61C2169B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C9190073;
	Fri, 30 Aug 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzJxGk5E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76D190056
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061368; cv=none; b=KjdlBidLBXFYhgRfkTXodn1bFscfGQmuhOLGuBo27boNPI4QLz9Xoo5Z+oIISLNocyTSL5qlu9v7q4VigzM5VIlhjVDi+iyltTFkT+WzKLpHVicWuBlDZDFEzm28524MnSfH2hwXIzaZUEOVwuygKJPbD6H0W1mGu4FEC0Ac6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061368; c=relaxed/simple;
	bh=gdoQctlXEsRYR0UYWAtrxA9rkf2AKKcV7usYOpNoZW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to2EknEhTBcqGFraUVKvVTWCgIu3zF/m3oagUwALWOXmvDjq6g6CuT6egZ1gQRnPsf46dAnaK0XelkDbR6fp/K817f7KAU3usZUinKoH/+F+tAC6/Fu46nEWRjQWTbx7q2OUYhqyfH+fnw5E7C6f3bvP6wNyKAsCug7AxOuBMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzJxGk5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E9C4CEC7;
	Fri, 30 Aug 2024 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725061367;
	bh=gdoQctlXEsRYR0UYWAtrxA9rkf2AKKcV7usYOpNoZW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzJxGk5EgXVF/4YzZAbWkp4cI8uutZDyvdWX3VinL6NCtYZII/+/tmshm+Mp4Ns4w
	 Y2TYqer6ie2duPaH+IINwnFKXqjB6AYa+areqb4Y3QnNvO1NC5kyYX0xcmi/+J3XMj
	 LG87KQW33qnBCaU3ewnxPuEQtCkUR9nJmzOas/9KFj3O9m8PKgLNmAtPxXMWCSsa5W
	 c/LBl/4XTjkXmJ73ub6WA2B7qvf5747M55Bsqwt0fiEyr+ouEjA7WalkBcub4gZogf
	 ifmmm3UYfNL/ABuzFs2XImOMSY3G+I/exPDUthmBzlNl1OH8GYJLdLaBaecnjSiKuj
	 A4G9DhHuyf79Q==
Date: Fri, 30 Aug 2024 16:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240830164246.73649979@kernel.org>
In-Reply-To: <20240830113900.4c5c9b2a@kernel.org>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
	<20240829182019.105962f6@kernel.org>
	<57ef8eb8-9534-4061-ba6c-4dadaf790c45@redhat.com>
	<20240830113900.4c5c9b2a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 11:39:00 -0700 Jakub Kicinski wrote:
> > There is a misunderstanding. This helper will be used in a following 
> > patch (7/12) with a different 'type' argument: 
> > NET_SHAPER_A_BINDING_IFINDEX. I've put a note in the commit message, but 
> > was unintentionally dropped in one of the recent refactors. I'll add 
> > that note back.  
> 
> What I'm saying is that if you want to prep the ground for more
> "binding" types you should also add:
> 
> 	if (type != ...IFINDEX) {
> 		/* other binding types are TBD */
> 		return -EINVAL;
> 	}

Ah, the part I missed is that there are two different types for ifindex:

NET_SHAPER_A_IFINDEX
NET_SHAPER_A_CAPABILITIES_IFINDEX

Got it now.

