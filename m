Return-Path: <netdev+bounces-98691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 284CB8D2183
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74902856E1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0CF172799;
	Tue, 28 May 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="qxvlQ3tK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp80.ord1d.emailsrvr.com (smtp80.ord1d.emailsrvr.com [184.106.54.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF540172786
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913308; cv=none; b=STsFO3NYAJN64KjhZ4NAz/47f3zBxtxf/OsaqftL8OyuODAku+4+1UTiBhTzLZmGtxnflZHRFaEzLvspd4lLcrnj5xG+llPjg9JKS9R+Q4nVHixndjAhsZxUxPL5T2oboXIiET+qMdRhSAjRTjPEwTj1SM7nc5YFIfQvTQ8WEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913308; c=relaxed/simple;
	bh=uPcX4z4vChSnnecLJ7DKxLv5M3scjruejYkgwMUr6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ6xDd+afRqYIikxtO3t/rLaw2JsoPC2fWVr3cp9Dx5eGMfkIRZ2lZow9UZuB4vc/qGVuoK21okICf3np6R3Gcii4drhMssOMi+2+lDFCTopaEqSdTYfnB+DjwT7jusYG1sI+yJNL0dqSKvkDX+XbIRJ0msX5YoJ6ePLJ+KeucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=qxvlQ3tK; arc=none smtp.client-ip=184.106.54.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716912400;
	bh=uPcX4z4vChSnnecLJ7DKxLv5M3scjruejYkgwMUr6UE=;
	h=Date:From:To:Subject:From;
	b=qxvlQ3tKidDcQIKmp5DQK4xdiztJqbK8c4i+bEuRtwo5500UqQ76dg20jNonwTQJa
	 rAtn6avLXBo3l0ZTMox01/oyrkMauukrmw8L+MMR9X8EroTPFHuFhC03YjUIaO1J7L
	 DS1EgFsHwMvHdRFTREqX/6PNEr8TEWTQsvVYL10A=
X-Auth-ID: lars@oddbit.com
Received: by smtp19.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id CC40060217;
	Tue, 28 May 2024 12:06:39 -0400 (EDT)
Date: Tue, 28 May 2024 12:06:39 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] ax25: Fix refcount imbalance on inbound connections
Message-ID: <rkln7v7e5qfcdee6rgoobrz7yzuv7yelzzo7omgsmnprtsplr5@q25qrue4op7e>
References: <20240522183133.729159-2-lars@oddbit.com>
 <8e9a1c59f78a7774268bb6defed46df6f3771cbc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e9a1c59f78a7774268bb6defed46df6f3771cbc.camel@redhat.com>
X-Classification-ID: c34efdfc-07aa-4a67-a808-046896bc1b32-1-1

On Tue, May 28, 2024 at 11:40:38AM GMT, Paolo Abeni wrote:
> Note that the fixes tag above is still wrong - the hash must be 12
> chars long, see:

I had spotted that, thanks. Just waiting to see if there are any real
change requests before re-submitting.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

