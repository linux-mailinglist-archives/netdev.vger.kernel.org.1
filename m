Return-Path: <netdev+bounces-182537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594BA89059
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57561897D71
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191694C83;
	Tue, 15 Apr 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7qPXpz1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCE23CB
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675927; cv=none; b=YTg59WVqS1MHAO/L7OovBnvR48TPLrsB1VzyEZOkKp3V4ZdylZj1rc6sqKITj+LTgiFOB68p5N4XbuGB3vb26b97XPg93C4c01nsrVf0XfMGdUdn4QWPRVYYqzDprAbn/rb5d4BfwAhyNCtcTbn3x1jbVSnZZuLKzpGs/AjjiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675927; c=relaxed/simple;
	bh=giycmozXgNDpEAV1C8OmZoh987wIfVY/hOxlhi3olSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETZezHGzNQ/Cy5e4ttZHHj0WwjFvG0CaIjJ6qDeSM5X9taHXqJD34A9A1yB00OGfV2eURKtIswQNIk3I5Qzd2ByRDp+8KpDHIEY1F5ZlN9l4blxMA9Rmxwz/EoIGvKKlqLkJDaxDNr3K809wG3Y6eTcqh9OZPTZsc4j0f5kVU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7qPXpz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140CDC4CEE2;
	Tue, 15 Apr 2025 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744675926;
	bh=giycmozXgNDpEAV1C8OmZoh987wIfVY/hOxlhi3olSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7qPXpz1pzieBPC+crPPDIFmzn/SEpgEfr7mdc5T3aiulirpEO8ysc9fp7pUpOtV9
	 G0jUfQrIJEt9gPKToFvaEc2IHqxa0/GKKhvQL3q808zMVY5WoQp8JyGkl9OoPjPjZa
	 u05TljsEuT5H1h6yq8+DkfZBg1yVM4KiWEI7TF4XycFgAid3VOIGYQXQDc58c9p1Or
	 6N933v+KK+F+7Gj4CW/0vKBJjdVpvSLDO2aSo2o6Az1TNX+yafrrA9V8X2MC7DELtA
	 0+15dvVQTtEDD0pgZwx7TI6tLgkzRDWtuxWswo1+fdWAzg4sHYVy04LY2+k1BndO/C
	 QzpNmyaYH+fuA==
Date: Mon, 14 Apr 2025 17:12:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 02/14] net: Add ops_undo_single for module
 load/unload.
Message-ID: <20250414171205.703b743b@kernel.org>
In-Reply-To: <20250414170148.21f3523c@kernel.org>
References: <20250411205258.63164-1-kuniyu@amazon.com>
	<20250411205258.63164-3-kuniyu@amazon.com>
	<20250414170148.21f3523c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 17:01:48 -0700 Jakub Kicinski wrote:
> On Fri, 11 Apr 2025 13:52:31 -0700 Kuniyuki Iwashima wrote:
> > +	bool hold_rtnl = !!ops->exit_batch_rtnl;
> > +
> > +	list_add(&ops->list, &ops_list);
> > +	ops_undo_list(&ops_list, NULL, net_exit_list, false, hold_rtnl);  
> 
> Is this the only reason for the hold_rtnl argument to ops_undo_list() ?
> We walk the ops once for pre-exit, before calling rtnl batch.
> As we walk them we can |= their exit_batch_rtnl pointers, so
> ops_undo_list() can figure out whether its worth taking rtnl all by itself ?

Either way -- this would fit quite nicely as its own patch so please
follow up if you agree. I'll apply the series as is.

