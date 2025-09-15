Return-Path: <netdev+bounces-222980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C2B576B3
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44F11A23055
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1482FCC1B;
	Mon, 15 Sep 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0kRvbRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BFC2FD1D0
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932749; cv=none; b=cCoIcnjykzh6fQ7tteqcJGH6zZcVnqTtInwCBlsPkivsnmTc8kvxlhvTx0+yW35ihbmsvo5cvXRM3CLZYlJKg535RJjVLUKrZKesaWm+U0LUSF0oP7h6wBqiDyYhyAh83cfy8YrqMmDOaRQ8G/SI6Y/hXNrblQ61VPX97kvCz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932749; c=relaxed/simple;
	bh=Ah9SUnFFUGDtrtZY6tlGLbggWcwF5sKBov3cvuNP86o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3GwyWp50GSnB1ETNV/PUUwt26rHYt3fbLdfxXk3zDfHE+ZXqU2G4f4/vGMqo6hAaV5EDy5xerL5Aq9XSrWfJ37ZVM3OPrkKoHQe2xzmPnqPMguUX8ycxLliPInW1g9O94mpmzIWyHZrut7JS5l7euX8Qsy+aoG17gh4X85M56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0kRvbRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9594EC4CEF1;
	Mon, 15 Sep 2025 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757932748;
	bh=Ah9SUnFFUGDtrtZY6tlGLbggWcwF5sKBov3cvuNP86o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0kRvbRhK8BuBDhwOJ1GypZxYMoYrP/FqFK/KrlQqMMbJEBdwSRopO3qZduEL1IiH
	 GvdRKEnuEV1BusvjBDVCCciMOveWVbsDvfym/IbKm1ZVePzGBDx/mH/0GHdhiEdVD/
	 aTsefAVhQqtn4UPslkZeS6zqkur0A7oXbQ0wvkkiDIsnK6hzgSddRGXsEZSwkiQNwl
	 ikXBP0k//GVQyNJEYApvgMR3zET0oyS3e7pQ1QQSAQnnHJJDR3W8S0YoLnRg9RX9t+
	 hptR6nQPwkRVjkdDsKX+Y/hMAfNBL1/mXxJlzZTkhieWw9gy/8yW146VIoH7mdTvyo
	 zBG7d30TuTUHg==
Date: Mon, 15 Sep 2025 11:39:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v3 1/2] tcp: Update bind bucket state on port
 release
Message-ID: <20250915103904.GQ224143@horms.kernel.org>
References: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
 <20250910-update-bind-bucket-state-on-unhash-v3-1-023caaf4ae3c@cloudflare.com>
 <20250911180628.3500bf0c@kernel.org>
 <87a52y67we.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a52y67we.fsf@cloudflare.com>

On Sat, Sep 13, 2025 at 11:04:01AM +0200, Jakub Sitnicki wrote:
> On Thu, Sep 11, 2025 at 06:06 PM -07, Jakub Kicinski wrote:
> > On Wed, 10 Sep 2025 15:08:31 +0200 Jakub Sitnicki wrote:
> >> +/**
> >> + * sk_is_connect_bind - Check if socket was auto-bound at connect() time.
> >> + * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
> >> + */
> >
> > You need to document Return: value in the kdoc, annoyingly.
> > Unfortunately kdoc warnings gate running CI in netdev 'cause they
> > sometimes result in a lot of htmldocs noise :\
> 
> Ah, thanks for the hint. 'scripts/kernel-doc -v -none' didn't complain
> about it.

FWIIW, I think -Wall would cause kernel-doc to complain about this.

> 
> I think I will drop the doc comment altogether since it's just a private
> helper now and the flag it checks is properly documented.
> 

