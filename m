Return-Path: <netdev+bounces-116504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB794A96A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D8282E8F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19700282FB;
	Wed,  7 Aug 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyR451Ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE52209B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039680; cv=none; b=E2AVo5kG3Sq9RutSlekWKaiNKuMCfSCWSwEFuiNrA+Lc8uv66jqMKNxvw9zDOpJGX0lyBetuDbeZysuel/QtiiuhHe51fI7MuyDFqkIRqZib4QTfaqiAyCxkJNR+WAGrDaQMxgJ1q9tCZEssypeNzRfQt+uJC3yFOyEmu5DqyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039680; c=relaxed/simple;
	bh=pb5CyPfopDyXjOhxLmxypLq7aX+p18zmvyDDaT6hr3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLaRBze+JJwo9TiOpyhkZo+rb0W/whVwfYZe9StlDVdTgTweKn5b0qgBgNMzHnfSnG2WapanyY2HlITfgnNk0F8Od2iL8KdXpEw0lFV+BqBirrGs+LSWCE9jJYFl4n7QOcULlC+JSWcrLHCpsRUw3wCq0HzELviA4QQz75vaB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyR451Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D82EC32781;
	Wed,  7 Aug 2024 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723039679;
	bh=pb5CyPfopDyXjOhxLmxypLq7aX+p18zmvyDDaT6hr3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jyR451Ep5P2IlIMTp2LHtXFl7kuQqX0r7DbGSAjAQcgGJUQgpXyxN0RiyQZmHx1/o
	 k4JPUvEuWYy92+AojmgAe+cat/Fu2BJJGRDkfvJSq2Pm0Q+yh5MJdc6DzZtKvnWI+s
	 TPxqxSk8lXZnFOJXdvixnJoKJYdia6PO+SnRww5TSF1c1XQmbC8i6bCfZGz0UbU2Tx
	 GEPoeTwt4sxwYH7podA8PbhJ0A5pCMEYTWwBML8J2JZIIhEDU8iMJQ0kjda+As61vg
	 9Y8dPNdzs/KvBVAEW4ND6XdLLLaHEepeFPDAmD9y7nLRfLvvazFHJ4NQwxsaAzpJKE
	 3sVSd3i5mmH8w==
Date: Wed, 7 Aug 2024 07:07:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree@amd.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, Edward Cree
 <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: fix off-by-one error in max RSS
 context IDs
Message-ID: <20240807070758.07752f14@kernel.org>
In-Reply-To: <e6cebcb7-a3e0-076f-e099-420a143cbaaf@amd.com>
References: <20240806160126.551306-1-edward.cree@amd.com>
	<20240806095426.6c4bcd2a@kernel.org>
	<e6cebcb7-a3e0-076f-e099-420a143cbaaf@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 11:30:54 +0100 Edward Cree wrote:
> > also1 if we want to switch to exclusive I maintain we should rename the
> > field  
> 
> Okay, will do.  I misunderstood your "if we change the definition
>  of the field" remark, because in my head I'm not changing the
>  definition ;)
> How about rxfh_max_num_contexts?

As good as anything I can come up with :)
It's hard to name it as "this is just for width of the contexts"
without implying that it's inclusive :S
I was thinking about hinting at this being the limit fed into XArray,
but Xarray's limit is inclusive.
Another thought I had was FIELD_MAX(), again, inclusive :D

Maybe we can forgo the max as it could imply max value, and insert id
instead because we're talking about ids not contexts?

rxfh_context_id_cnt ? Or give up and rxfh_field1_read_the_doc ;)

> > also2 check that it's not 1 during registration, that'd be nonsense  
> 
> Fair enough.
> 
> > also3 you're breaking bnxt, it _wants_ 32 to be a valid ID, with max 32  
> 
> Fwiw the limit in bnxt existed purely for the sake of the bitmap[1]
>  which you removed when you converted it to the new API.
> My reading of the bnxt code is that context allocation happens via
>  a firmware RPC.  Pavan, if the firmware can be trusted to reject
>  this RPC when it has no contexts left to give, then you shouldn't
>  need an rxfh_max_context_id in the driver at all and you can
>  remove it from ethtool_ops for net-next.
> To avoid a regression in net I'll change it to 33 in my patch.
> 
> (Typically rxfh_max_context_id is only needed if either driver or
>  firmware is using the context ID as an index into a fixed-size
>  array.  This is why I consider an exclusive limit -- which would
>  be set to an ARRAY_SIZE() -- more appropriate.)

Got it. I had the vague plan of piggy backing on this to express
the order of magnitude of how many contexts are supported, but FWIW
I no longer think it's a good fit, anyway.

