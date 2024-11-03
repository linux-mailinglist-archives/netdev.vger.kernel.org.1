Return-Path: <netdev+bounces-141319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB29BA782
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A821F1C20B76
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D92142659;
	Sun,  3 Nov 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoqUeNl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF176036
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660057; cv=none; b=BUzelwGJVJpbgaKeI7N839WOjYoXj6r3KOuwFOZ3SkItidSIvvOAhkUr2zCYWlmmHeFIy5u8kT0fQ93vO+Cssx2+DaYPxc1kQv1xVbUjSE5luMebwiNXQvvJqQguRhNIFD8golHO5O9FqWDxfkQFi6F53gRLRKliIs7kC28Sc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660057; c=relaxed/simple;
	bh=15ZgfVjGlGM0IqU/XG3XUSAtLn1cz0T5PjimnkX6Oi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CumE1DaWYSTOtjYeuMTxQuEql7LCZcZhm6p7qFAjmwE98LhWpW+LsK4EMLXCtfyE6mjGvKRueWFTupwlBxt3NvtwK0k9mgIceIzsWxMzrjxmpYC1x2G/98tw7TnXOPZRcw9iyAfXLhYJjHxdH5D885jG8BLq92D9t9ZNsszHrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoqUeNl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA95C4CECD;
	Sun,  3 Nov 2024 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730660056;
	bh=15ZgfVjGlGM0IqU/XG3XUSAtLn1cz0T5PjimnkX6Oi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RoqUeNl0uwBM39S8EcaCLmP3NhU+4k+K4YaOltlDg4b/BQvxZq5aYyDvFtIZlcEHJ
	 TyWPYem95+e+mFZjeQVGFCTr43thV9D9OneQkXFz2yr1AbhYwig/KKRr5RL0E1ufLZ
	 9oGbZvi7yJJIDMxR6w1NRa5nz/RuZuguG4DuB6vA7b0NVhtaRl6iTwPReoJmQ/9PB/
	 RH4Q6RbTcg5kQmgfhDHo0yeSfG646pG753HfscLPISjNPPf4KQZeqQSRrJi4NdlLFH
	 JC/4X1+RRVxYgqkrpP8ZQidOuR/QoWMlIeYDcz5CDHMJM7OgtdDIhOizmqos81Fzjs
	 6SQdY7mnf67/A==
Date: Sun, 3 Nov 2024 10:54:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ncsi: check for netlink-driven responses
 before requiring a handler
Message-ID: <20241103105414.75ddd6bd@kernel.org>
In-Reply-To: <20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>
References: <20241028-ncsi-arb-opcode-v1-1-9d65080908b9@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 15:08:34 +0800 Jeremy Kerr wrote:
> Subject: [PATCH net-next] net: ncsi: check for netlink-driven responses before requiring a handler

> Currently, the NCSI response path will look up an opcode-specific
> handler for all incoming response messages. However, we may be receiving
> a response from a netlink-generated request, which may not have a
> corresponding in-kernel handler for that request opcode. In that case,
> we'll drop the response because we didn't find a opcode-specific
> handler.

This makes it sound like the code is written this way unintentionally,
which I doubt. A better description of the patch would be "allow
userspace to issue commands unknown to the kernel". And then it'd be
great to get some examples of commands you'd like to issue..

> Perform the lookup for the pending request (and hence for
> NETLINK_DRIVEN) before requiring an in-kernel handler, and defer the
> requirement for a corresponding kernel request until we know it's a
> kernel-driven command.

As for the code - delaying handling ret != 0 makes me worried that
someone will insert code in between and clobber it. Can you split
the handling so that all the ret != 0 (or EPERM for netlink)
are still handled in the if (ret) {} ?
-- 
pw-bot: cr

