Return-Path: <netdev+bounces-109068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B188926C3C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 01:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BD4B2192F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369D1946AD;
	Wed,  3 Jul 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="foN6g2Aw"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35C4964E;
	Wed,  3 Jul 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047870; cv=none; b=hX9UZIsGafgUqX2cWM6DhAp2BGYIY01eMBSc7MOB7aEbCRLN59T86fDxUmrrat8Ta3J8vTAlx8A8xEIn1om5tOkZd6sbe1YWSEtZunXiw4XweLJfKh+Bz10yFDLWW/U6w5UTLp1VL9cQ90VdTiY0bt5Bm+BA7yMn2dH2pXuCFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047870; c=relaxed/simple;
	bh=sjUlk2dyanMoOOvqU/NU0Qw0qLzZxQECvFTWbr3HFx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKXsP4fWYkH08g9DBDWpZo7IPn97T8Ssf6ClQQG4RHi/1aCwA2/qLoEQhsZ9BuaA+gWxDYBvqlmV51+dBuvp6QAC9dQ54u9W6qokIxnAeNX+HW8U8bxtCeBCJ2qOOfMbUcITksxeBY04PvXszawaTKm654MkubFVGKA5Qw3hgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=foN6g2Aw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 491D74189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720047868; bh=YTLOx/1o2O6vgLftzil18tbHX7AAy8OKyo+xBns4TL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=foN6g2Awy5eiKZju1LPimmtXOR26SvHVLj3GQfBqu75Gzkyb2rCX4/C9CLU0E9Scn
	 25gOIiHYzDk+1wKQFy24VU/7F1d0eBMctpd+BfpUBJ9X5Uk4xIH87HaczPT4wLhjDE
	 2kA2efk/k+pm4mvDW2bffK229qejCmKvk3CseEWzwSg2V6BKe674vCJepuzP7OXUHB
	 ALwDATik/GzfLBsi1VIVIuNhfVBQqN2jrQerInqOxDPBJnNp0t/bVeUn80NIQsONG3
	 VSAiHzfOqEYvarluqY1xD6t5yh+JcBhpWnwt0sB3R9JSUkBctTWBx+huc1oueKTEFu
	 6FHk79eTvoCIg==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 491D74189E;
	Wed,  3 Jul 2024 23:04:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
 ksummit@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Documentation: update information for mailing lists
In-Reply-To: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
Date: Wed, 03 Jul 2024 17:04:27 -0600
Message-ID: <87y16irsas.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> There have been some important changes to the mailing lists hosted at
> kernel.org, most importantly that vger.kernel.org was migrated from
> majordomo+zmailer to mlmmj and is now being served from the unified
> mailing list platform called "subspace" [1].
>
> This series updates many links pointing at obsolete locations, but also
> makes the following changes:
>
> - drops the recommendation to use /r/ subpaths in lore.kernel.org links
> (it has been unnecessary for a number of years)
> - adds some detail on how to reference specific Link trailers from
> inside the commit message
>
> Some of these changes are the result of discussions on the ksummit
> mailing list [2].
>
> Link: https://subspace.kernel.org # [1]
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat/ # [2]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Changes in v2:
> - Minor wording changes to text and commit messages based on feedback.
> - Link to v1: https://lore.kernel.org/r/20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org
>
So I have gone ahead and applied this.  There are some important changes
here that shouldn't miss the merge window, and we can argue about the #
marking with it in-tree.

I am rather amused, though, that b4 added a few extra tag lines:

> Link: https://example.com/somewhere.html  optional-other-stuff
> Signed-off-by: Random Developer <rdevelop@company.com>
>      [ Fixed formatting ]
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I do believe I'll amend the changelog before pushing this one :)

Thanks,

jon

