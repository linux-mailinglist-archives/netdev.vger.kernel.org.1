Return-Path: <netdev+bounces-77179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05788706DE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648A81F21776
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D2482C9;
	Mon,  4 Mar 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZcbND2E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5346BA0
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569203; cv=none; b=dZJmrFY3ESzbBcgBQpwjtHEPbh3dyqGh6MxEcIlL2hFE/AAjjRSmcgcyW6dHGz5STZBuiVl+DkHGvDMOmGMemwm7y1/oE9naEIGM6VwuRc1w9ikSpb1j0rNuR9jnK4SGoaGrrqX7BU5+1iXMLw87my0+EAmQpezuENuv6cSTdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569203; c=relaxed/simple;
	bh=I758tjVlpgSflX7zDEXIKlU/dlj6cXvkjbHNBihfeHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUeG562F+qaG+iuycPZBJb3d1AnJDnBK6CULLQkW0cUY5eyJWgmgLL/qUIWRCpLyv8+tBGijD0ZoRH7O5TsVowbqHv97fHqJVF4ucfawuG/TpKDeCmXX77tbIs089KeCHJ5+Y3LsNSNnUZ/7gUprQKB6g9/umXSLk/YQueY8eqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZcbND2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5F4C433C7;
	Mon,  4 Mar 2024 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569203;
	bh=I758tjVlpgSflX7zDEXIKlU/dlj6cXvkjbHNBihfeHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZcbND2EL5ZcHYQdVkyiPTjilcVezxXvbbhdlFtNjvmjh4wS7fdTdaLMN7hfL48qy
	 O6F1aoicrTFF3J1gEpwzqBS5nnCC1ZOAybl/lqCQNME6CssUi836/41asSIPMXU+V7
	 gnWJk8GOI06+QFtILWawk9NcSlP9i1bkPCQhxy1Vp87/6fVWsrUqINGWq2Gw8hTPVs
	 h44vFpUNZj0aBroB6aTFWhwBDzmKngzqkjuczhbGafxQUySxUQCBIgPpsYbdrsKHlp
	 gXINLk3N/pVPEla7uEniMCRTcHwuDiQoeNQvpkdJ40f2rssRthAMO9KPeQsAJU+4X7
	 I81KdhSp3yo3g==
Date: Mon, 4 Mar 2024 08:20:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us
Subject: Re: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
Message-ID: <20240304082002.14b3a081@kernel.org>
In-Reply-To: <CAD4GDZzZrJATP9qTe235RYytfAEm+ByeucR11g+ixWMXvGnVQQ@mail.gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-3-kuba@kernel.org>
	<CAD4GDZzkVJackAf2yhG1E5vypd2J=n23HD5Huu356JK1F1oLKA@mail.gmail.com>
	<20240304065823.258dfabf@kernel.org>
	<CAD4GDZzZrJATP9qTe235RYytfAEm+ByeucR11g+ixWMXvGnVQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 15:57:57 +0000 Donald Hunter wrote:
> > Attributes, not messages, right? But large messages are relatively
> > rare, this is to make dump use fewer syscalls. Dump can give us multiple
> > message on each recv().  
> 
> I did mean messages:

That's kernel capping the allocations to 32kB, using larger allocations
is "costly" / likely to fail on production systems. Technically the
family can overrule that setting, and my recollection was that 128k or
64k was what iproute2 uses.. I could be wrong.

