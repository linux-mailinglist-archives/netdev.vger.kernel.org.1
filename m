Return-Path: <netdev+bounces-99934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1F8D7206
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9131C20B08
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1751DDD1;
	Sat,  1 Jun 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVsqsPz4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8914A82;
	Sat,  1 Jun 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717278982; cv=none; b=iGfM2oAX0SpT9dwuwWC5EFBw16ZaaB+ztlNy9ctoaYaTQ7PiIjubZDhu7kcIWzihfWNfL57eVOBEBRFa+ysyYgrXVZLnmz1w2DOT7+8MmMaiVL8HYFk9XZoP0cavUfSGdS9Fpdm9204jsi/m5FnUiNY+9kai1TVpBUZQpbfo3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717278982; c=relaxed/simple;
	bh=lgVp7NvXT5vDd7Lb0r3V1J4x6OKqwMTUUWGjTwCgjBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWY+JXzSr93c5MgAVqm5u928FkfxDakK+qhH53mGrZL87B36Uqq/V2FJHibqKl9Qo/Bl3suiJvYwhM13aJ9UMcNXutU5Gs/yNWy3QUHv33qA12qrzCs6BfJf2DuBR1CcRypi1AkOsUn0Z3iqKHaOTm12jsWA7YHjJb10mPvJTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVsqsPz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A71CC116B1;
	Sat,  1 Jun 2024 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717278982;
	bh=lgVp7NvXT5vDd7Lb0r3V1J4x6OKqwMTUUWGjTwCgjBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kVsqsPz4WgZK6OBVrPBDlwNOAG92Wl0TSezYlhvL7aOnsU4D7RJdAUyaEht6WS1qY
	 fGZOBANlrI0h6Z3dfSIGil8eA4Ag/Cmv0flMoBZOWcC8k7zpvdbHekB12ZCaXr3eLK
	 mpMiEmP+JVIl2V/iuS8mW0ohV3FwRLL9xdv39HGME3/v5Y2lFgpGDYJj7J2ED9JqNr
	 4W78LHVYKqMP3UFY9k72IkeXxxIqZ20OM2bcZtnnM6sUiEjXLdmpLzbdFs1oLA/Eq3
	 waTPIUXZWj33PIyyuSKKC0q4i/htJr5sPruBl17+XFjY8zgY23/3zB+gl3u0A5/aB6
	 XCRCXvW+3FLuA==
Date: Sat, 1 Jun 2024 14:56:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, borisp@nvidia.com
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail
 skb
Message-ID: <20240601145620.065e6a5d@kernel.org>
In-Reply-To: <6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
References: <20240530233616.85897-1-kuba@kernel.org>
	<20240530233616.85897-3-kuba@kernel.org>
	<6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 09:41:30 -0400 Willem de Bruijn wrote:
> > +static inline void tcp_write_collapse_fence(struct sock *sk)
> > +{  
> 
> const struct ptr?

Maybe just me, but feels kinda weird for the sole input to be const
if the function does modify the object it operates on.

