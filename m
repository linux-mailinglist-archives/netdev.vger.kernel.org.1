Return-Path: <netdev+bounces-39393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89B7BEFC2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524841C20A17
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AA194;
	Tue, 10 Oct 2023 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDk7R9rZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3ED17E;
	Tue, 10 Oct 2023 00:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0DCC433C7;
	Tue, 10 Oct 2023 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696897730;
	bh=eRmX6kso32jvy3zEFP8jrkHMLQo6o5H2lpKN6P5u3sM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDk7R9rZX6qj/cx2pIdfGqKzdIYUaI3tMNVOdYnr7FwDq/xxkF7sxgztf2utinOOS
	 hr/ERR1n+dR3rHJVSjS602y1ybbZd+SnmSFYCFiCkRD5rQJm6eRLflxOGrYHS6PQPI
	 6tW1yd5YdSHBCTUsjHQJXFsWSMj3+9YEcfHTIAVMf0iMqOEAqV5x5HdpAq/ViaZFkH
	 enYsow3rTv6iaioJ8Ak3N2y1QCyvThaKvccC8CEOjf/p4B2q+dci5Fycrg37CgLktw
	 5rVAHetTPJKb28jsRX+kqAx4ngYHYRDx02a09HKzNXPrRRkLtKGj0tcyrbQ8QZpg73
	 UF0r9XVGRpXUA==
Date: Mon, 9 Oct 2023 17:28:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: markovicbudimir@gmail.com, Christian Theune <ct@flyingcircus.io>,
 stable@vger.kernel.org, netdev@vger.kernel.org, Linux regressions mailing
 list <regressions@lists.linux.dev>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231009172849.00f4a6c5@kernel.org>
In-Reply-To: <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
	<065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
	<0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
	<20231009080646.60ce9920@kernel.org>
	<da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 12:31:57 -0300 Pedro Tammela wrote:
> > Herm, how did we get this far without CCing the author of the patch.
> > Adding Budimir.
> > 
> > Pedro, Budimir, any idea what the original bug was? There isn't much
> > info in the commit message.  
> 
> We had a UAF with a very straight forward way to trigger it.

Any details?

> Setting 'rt' as a parent is incorrect and the man page is explicit about 
> it as it doesn't make sense 'qdisc wise'. Being able to set it has 
> always been wrong unfortunately...

Sure but unfortunately "we don't break backward compat" means
we can't really argue. It will take us more time to debate this
than to fix it (assuming we understand the initial problem).

Frankly one can even argue whether "exploitable by root / userns"
is more important than single user's init scripts breaking.
The "security" issues for root are dime a dozen.

