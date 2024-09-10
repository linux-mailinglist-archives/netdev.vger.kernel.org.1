Return-Path: <netdev+bounces-127023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F8F973AB3
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B38F1F26010
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21819992A;
	Tue, 10 Sep 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afRV7+ld"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D600189903;
	Tue, 10 Sep 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980168; cv=none; b=oqz+IKNOxF6zvkyRIwOOD8VRTl+dK6ejqbEfd336gNn1ii/iXhaQ6iimWLeFQKDCvLBswDcVwf29DagObjXPvRh+3O962jEl679uxEnatqyTc+uTvSuu5btwWe7V+5oo00Rpd34hKL9vnoswu62Fk6a/EbS1gHymIgHoMzX8RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980168; c=relaxed/simple;
	bh=Knj+/+ZTNcHkhCPeQwfM9SbZokQitCPm0oFSvWrF6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRi0F96sCfVqNCztdW6wmYwep++PU6njF6UYh5IyleYJeO2HwBLUmOLC85s6veVUTBWTmDz54KyPJPDY/a8RMQT2ZJITbKfUDoK36fgXNTImqRCq7dnk/l/UiwvEh1aJHs8y+AYQWkEBowwU4TWRkET5tHqIMVGtBed/W//tvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afRV7+ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCA8C4CEC3;
	Tue, 10 Sep 2024 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725980168;
	bh=Knj+/+ZTNcHkhCPeQwfM9SbZokQitCPm0oFSvWrF6/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=afRV7+ldQirMVUJ6HP3r0uJ8N3BOfaLJwphabsueb3xu4Zos3wRJuDGtROtF97qjc
	 tnV9d0OQ1LO0tQkv9ojMVVjxvw4i/rId4St/zv8PjCvfNhzoHu8Q5uDMh/bsUQh6J4
	 Q5HlB2NIYWBsYE/vUM3U8cn5DrXCTd6K/z14JYfdyX3j2Gk9iJkOvfjzhPE37J6gLA
	 Fkfrk9xpKuIhpkNWDhjeKSM/Hr0YVnB9KO3xQMPB6PMivf0+yjicIcjO4rAplitnF7
	 0J4vtTC447mEs7PV2IiSbtiACMdsPZEkRW9LkQJh7oFucbWtR6Y5yEhkUIYEw4GySz
	 eGN37L0Qtp0NA==
Date: Tue, 10 Sep 2024 07:56:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 1/9] net: napi: Add napi_storage
Message-ID: <20240910075606.565fae97@kernel.org>
In-Reply-To: <Zt_kJT9jCy1rLLCr@LQ3V64L9R2.homenet.telecomitalia.it>
References: <20240908160702.56618-1-jdamato@fastly.com>
	<20240908160702.56618-2-jdamato@fastly.com>
	<Zt4N1RoplScF2Dbw@LQ3V64L9R2.homenet.telecomitalia.it>
	<Zt94tXG_lzGLWo1w@mini-arch>
	<Zt_kJT9jCy1rLLCr@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 08:16:05 +0200 Joe Damato wrote:
> > >   2. The two step "takeover" which seemed to imply that we might
> > >      pull napi_id into napi_storage? Or maybe I just read that part
> > >      wrong?  
> > 
> > Yes, the suggestion here is to drop patch #2 from your series and
> > keep napi_id as a user facing 'id' for the persistent storage. But,
> > obviously, this requires persistent napi_id(s) that survive device
> > resets.
> > 
> > The function that allocates new napi_id is napi_hash_add
> > from netif_napi_add_weight. So we can do either of the following:
> > 1. Keep everything as is, but add the napi_rehash somewhere
> >    around napi_enable to 'takeover' previously allocated napi_id.
> > 2. (preferred) Separate napi_hash_add out of netif_napi_add_weight.
> >    And have some new napi_hash_with_id(previous_napi_id) to expose it to the
> >    userspace. Then convert mlx5 to this new interface.  
> 
> Jakub is this what you were thinking too?
> 
> If this is the case, then the netlink code needs to be tweaked to
> operate on NAPI IDs again (since they are persistent) instead of
> ifindex + napi_storage index?

No strong preference on the driver facing API, TBH, your
netif_napi_add_storage() with some additional 'ifs' in the existing
functions should work.

Also no strong preference on the uAPI, avoiding adding new fields is
a little bit tempting. But if you think NAPI ID won't work or is less
clean - we can stick the index in.

