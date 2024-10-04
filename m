Return-Path: <netdev+bounces-132175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D658F990AC0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897EE1F24031
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4941DACA2;
	Fri,  4 Oct 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeoiiwRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB11DAC90;
	Fri,  4 Oct 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065394; cv=none; b=GNUPcTZb76QZtsos5narYk+1JHX5pzGuNNPucGSXOy7pQo6s4Rr2rHZlFr6wjmQfwvw4z50ysKrqwyx/gl3CmklPqf7J6fvwfS5T/nqQBzBjLbXmw2ClrjazXDV3oujqaRoEDQ66QJZcG2KXoP/LQDbQM6yF9y/YqyXxih5KE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065394; c=relaxed/simple;
	bh=1b0KlwUhNqg/XeSKf7cJicZ9rbENT+XgkJYsWOJSG7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MryF+5jDLprmcr06lm5JNinyOVrYXfgHO6RipiWq7c7NJL+2XUNbfXrBSeKysL4SVNMJeWz/M+ANyPTeLcmLXg/CaCzPHJwikKMfyBeJnGMsiGhq39+C3Ue1WbpL/u1dycudHUqDTSHV7ST29xJskDcD5TYan4qxVjv5sJTmAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeoiiwRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC0C4CEC6;
	Fri,  4 Oct 2024 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065393;
	bh=1b0KlwUhNqg/XeSKf7cJicZ9rbENT+XgkJYsWOJSG7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XeoiiwRPmH/niGgmgL0yPM+f4Uf2XyXzizbl1q7/ZJmWAgjiVW/zlUy8ZD4OxGB0V
	 OC2NT+9MTICDI1L2ma9kuNa+/PySSeo2N2ssNTtbln2u7N6J2o9D8d+YD8eLBDnS82
	 1Xf+h2pteCwHasokG1UB9aTdxGuEiG49IGsVeiQ/+7WC0aF453JfuJGQYWtFMysbIL
	 KKNDYpv5N3+ca7YNY/yoY3zMh+w5MV2qbL3R51qxm/MRbrWnxuP6vpSr7csOLVrAYY
	 aA/POpohPDOvF71jHy0dXnk42B8roxOqGWxS7bJ998DFBV3hdkU3rlXTNmpvS9TtJP
	 Sl4NN7D6rLZCg==
Date: Fri, 4 Oct 2024 11:09:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Lennart Franzen <lennart@lfdomain.com>, Alexandru
 Tachici <alexandru.tachici@analog.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error
 handling path in adin1110_read_fifo()
Message-ID: <20241004110952.545402d0@kernel.org>
In-Reply-To: <63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
	<63dbd539-2f94-4b68-ab4e-c49e7b9d2ddd@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 14:47:22 +0300 Dan Carpenter wrote:
> It's a pity that deliberately doing a "return ret;" when ret is zero is so
> common.  Someone explained to me that it was "done deliberately to express that
> we were propagating the success from frob_whatever()".  No no no!

FWIW I pitched to Linus that we should have a err_t of some sort for
int variables which must never be returned with value of 0.
He wasn't impressed, but I still think it would be useful :)

