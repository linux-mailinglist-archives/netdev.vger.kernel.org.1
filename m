Return-Path: <netdev+bounces-250932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93BD39B89
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A57330081B3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E253C8CE;
	Mon, 19 Jan 2026 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kylcQvMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAFBA21;
	Mon, 19 Jan 2026 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768780887; cv=none; b=L2VpBeTDRWfW9WmqZncNlaAmy7NeaBaUmMpEdYDqDWtZhdByOdSbW2H1VhWd4zPb76jwdVkAk1S+dfUxGXJVPojo6wOWdBwkAgcXDZStIOSgFUBoLtXvICOs/Qqp3HCfTHEXWyWDm7QpyKFCeItLFl0uZys6u0f917wb1W8XKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768780887; c=relaxed/simple;
	bh=tKZalNLzkywqrvTme+dc7390S/LaheF5UiLsTmtxgTc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XfcIR1TyVxPIux71K3FpG7bQxfRL93PcwmG1Z2Fd5tt0B3V/LTxUyJ5ULpxkuF+5sty+TpFNPCH+GIIWlxg5gLTtgzmL8l8GXuzqr4RY9smJ07DX/ggCiQIAEvVTL+sIdsEl5+q/sghPOorTga4h3zyalfBaY61xDCZ1zdlE5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kylcQvMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E46FC116D0;
	Mon, 19 Jan 2026 00:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768780886;
	bh=tKZalNLzkywqrvTme+dc7390S/LaheF5UiLsTmtxgTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kylcQvMwliwEHL7SHwduLt86YpL0BF1c7A5VsRdVG3kmowNAKoBHjmhyXCNWymxJ/
	 YPHOE2lDr2jExwCu6JXs4Ob8n4ePa9ZUhqzBIK2RclxkRk0qBFILlKMk6HakiqExLv
	 JZBDbQkuY5M3gqhhkJ4q3u0LhrKZHUdZsz3MbSv8=
Date: Sun, 18 Jan 2026 16:01:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-Id: <20260118160125.82f645575f8327651be95070@linux-foundation.org>
In-Reply-To: <20260118225802.5e658c2a@pumpkin>
References: <20260118152448.2560414-1-edumazet@google.com>
	<20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
	<20260118225802.5e658c2a@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 22:58:02 +0000 David Laight <david.laight.linux@gmail.com> wrote:

> > mm/ alone has 74 __always_inlines, none are documented, I don't know
> > why they're present, many are probably wrong.
> > 
> > Shit, uninlining only __get_user_pages_locked does this:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> >  115703	  14018	     64	 129785	  1faf9	mm/gup.o
> >  103866	  13058	     64	 116988	  1c8fc	mm/gup.o-after
> 
> The next questions are does anything actually run faster (either way),
> and should anything at all be marked 'inline' rather than 'always_inline'.
> 
> After all, if you call a function twice (not in a loop) you may
> want a real function in order to avoid I-cache misses.

yup

> But I'm sure there is a lot of code that is 'inline_for_bloat' :-)

ooh, can we please have that?


I do think that every always_inline should be justified and commented,
but I haven't been energetic about asking for that.

A fun little project would be go through each one, figure out whether
were good reasons and if not, just remove them and see if anyone
explains why that was incorrect.


