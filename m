Return-Path: <netdev+bounces-179690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC856A7E294
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E73B1643
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897DD1F461C;
	Mon,  7 Apr 2025 14:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A61F4CAD;
	Mon,  7 Apr 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036289; cv=none; b=hTp9rqzd0EHadFDiMWRJP0E4JC1HA9y07Plo4TyDUaUJ+95YsDOP4yxOrpfsCcjp8cN5+yZTude2iaSQQ1pLyTRy9ixbqYdu7GeE2eJy7FLLGD909QDoX6JoK5faEmce6PlFj6Oz+EsTTZfsKUXmkFvDvY4F5aqfL4A224pGoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036289; c=relaxed/simple;
	bh=TI2+s/JnZ8DjT+9G+x/pMG8Q9zFhE72iryPhllYsy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5ML70Aoi1C8qpObjdJRl+VP6ezY7dAPDCCkAqzVOq6vRuKGtZbyxNFtmLMtJUp+yCfKuhmO2yvogwwYleYbnP20PtBMotGJBtgzOZ8br/JPU2dS0DvBdkyXX2K1o2uJNPtX8e4Es2vE9ViPH7pAgC+6UAIJNJSe2st3lYdbuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E68A867373; Mon,  7 Apr 2025 16:31:21 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn, zhang.guanghui@cestc.cn,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250407143121.GA11876@lst.de>
References: <bd5f2f8a-94f0-43b0-af02-565422d12032@cestc.cn> <20250403144748.3399661-1-shaopeijie@cestc.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144748.3399661-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

I had another look at this patch, and it feels wrong to me.  I don't
think we are supposed to create sockets triggered by activity in
a network namespace in the global namespace even if they are indirectly
created through the nvme interface.  But maybe I'm misunderstanding
how network namespaces work, which is entirely possible.

So to avoid the failure I'd be tempted to instead revert commit
1be52169c348 until the problem is fully sorted out.

