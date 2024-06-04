Return-Path: <netdev+bounces-100429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6488FA936
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73001F214A6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997A1386B9;
	Tue,  4 Jun 2024 04:30:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55E8F77;
	Tue,  4 Jun 2024 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475448; cv=none; b=uHlqlaLWOsKb0H9+nW2aP2YrnVJJa4p/DOCakttUBzBb74oVxUDAkw5S8Lwy6jk8/SFEjbLABXPwTMhUgUi9MSZL65wozRuufVi9LAbsibu7m/WlKMi6q0kO82aiZFr4gz9t0rUC+gyn0cvGHTeSdi9dsajmxzfDdIwEl44WjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475448; c=relaxed/simple;
	bh=FrRpTyIC0TSN7vgeKaP9koVH9eDEgABWGhVAwupcyZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI1vq7Y1el0blYK7ZynkUCDqE7w4ZshYHEFqsF3yCvTe1ypvaoTC11YPLeXmf6nD2X0sQghRroAAmDOWhmLjetJAlKpvcJy+GLFpdhyRgjKNaeyj7YyuTmf85dUhtW9D9fA897QroxXNNXB25bepbRjbZYxP/JZ7Ay5niYk1+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71B6A68D15; Tue,  4 Jun 2024 06:30:41 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:30:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ofir Gal <ofir.gal@volumez.com>,
	davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240604043041.GA28886@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240531073214.GA19108@lst.de> <20240601153610.30a92740@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601153610.30a92740@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 01, 2024 at 03:36:10PM -0700, Jakub Kicinski wrote:
> On Fri, 31 May 2024 09:32:14 +0200 Christoph Hellwig wrote:
> > I still find it hightly annoying that we can't have a helper that
> > simply does the right thing for callers, but I guess this is the
> > best thing we can get without a change of mind from the networking
> > maintainers..
> 
> Change mind about what? Did I miss a discussion?

Having a net helper to just send some memory in the most efficient
way and leave it up to the networking code to decide if it wants
to use sendpage or sendmsg internally as needed instead of burdening
the caller.

This happened before sendpage_ok was added, so probably in 2020
and most involved Dave and not you.

